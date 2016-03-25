From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3/GSoC 2/5] path.c: implement xdg_runtime_dir()
Date: Fri, 25 Mar 2016 11:00:13 -0700
Message-ID: <xmqq4mbu4evm.fsf@gitster.mtv.corp.google.com>
References: <1458728005-22555-1-git-send-email-huiyiqun@gmail.com>
	<1458728005-22555-2-git-send-email-huiyiqun@gmail.com>
	<20160325095923.GB8880@sigill.intra.peff.net>
	<CAKqreux8FHdJoKDishjQkbi9g1oUc265EUK4nOJ_sgeFivGSNA@mail.gmail.com>
	<xmqqpoui4huo.fsf@gitster.mtv.corp.google.com>
	<20160325175510.GA10563@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>,
	Git List <git@vger.kernel.org>,
	Your friend <pickfire@riseup.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 25 19:00:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajW22-0001Dx-TQ
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 19:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039AbcCYSAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 14:00:17 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:50162 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753793AbcCYSAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 14:00:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1C8384F08E;
	Fri, 25 Mar 2016 14:00:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uCB9wKw7Ls9dIHqCLjWjJDxVSTQ=; b=F3JiTo
	fowsqWtSm/yXOj03h5+Dh5wglbEl2HKw0PiY5/tT6L4UNAW6vJObMn98U+iR8AG1
	h6qfERd5ht6ZO2tx9cbGMLIvQ4zHQyM68OIiqELnUA2K/c0JML68X4MkXM+URLQf
	UBLtY2f7OOCXy+hyesmLcsaEWh9vFb6NpOCOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lx95ltZc0ZANw3W5n3u0kIpf+4RFCtAM
	0rgtWOP+LyWxCCD8QUaszU7a9gykVNfV4LdjWkFgtSLmMBdoXDo8ei6MdAyKPcYV
	72CsO3MOUAQF+3kUakBM3ZablxAJwEHSQHk1pz86lMerI6Hil2fK5X6ccuLQzI3k
	h955c2DF7mM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 145F44F085;
	Fri, 25 Mar 2016 14:00:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 87B694F083;
	Fri, 25 Mar 2016 14:00:14 -0400 (EDT)
In-Reply-To: <20160325175510.GA10563@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 25 Mar 2016 13:55:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6CF4839C-F2B3-11E5-A51E-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289920>

Jeff King <peff@peff.net> writes:

>> > That's clearer, but if I were the caller, I would worry about the
>> > security of the path.
>> > How about adding:
>> >
>> > The security of the path is ensured by file permission.
>> 
>> Is "by file permission" descriptive enough?
>> 
>> To protect /a/b/c/socket, what filesystem entities have the right
>> permission bits set?  If the parent directory is writable by an
>> attacker, the permission bits on 'socket' itself may not matter as
>> the attacker can rename it away and create new one herself, for
>> example.
>
> I think that is discussed elsewhere, and referring to the xdg document
> is enough. My main point is that the docstring about a function should
> tell a potential caller what they need to know to use it, but if it gets
> overly long, that information is lost in the noise.

I agree with your main point, and I was wondering if "by file
permission" is merely adding yet another noise if there is
discussion elsewhere already, and/or if it does not refer to an
external document that has a fuller discussion, because it lacks any
useful information by itself.
