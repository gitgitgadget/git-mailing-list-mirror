From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3/GSoC 2/5] path.c: implement xdg_runtime_dir()
Date: Fri, 25 Mar 2016 09:55:59 -0700
Message-ID: <xmqqpoui4huo.fsf@gitster.mtv.corp.google.com>
References: <1458728005-22555-1-git-send-email-huiyiqun@gmail.com>
	<1458728005-22555-2-git-send-email-huiyiqun@gmail.com>
	<20160325095923.GB8880@sigill.intra.peff.net>
	<CAKqreux8FHdJoKDishjQkbi9g1oUc265EUK4nOJ_sgeFivGSNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Your friend <pickfire@riseup.net>
To: =?utf-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 17:56:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajV1t-0000bM-Ta
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 17:56:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887AbcCYQ4F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2016 12:56:05 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:56693 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753472AbcCYQ4D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Mar 2016 12:56:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8078B4DDAB;
	Fri, 25 Mar 2016 12:56:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hly531DAaTyn
	eOinO3oqJrL+z2U=; b=e9fyl5zuZNOPl5YjNzPHw2Qym0+buj/zX9OdRoXlfsni
	1JqfsNsll21931Vc+R1XWCseyJO+q6w5BxuycYWiu5gaeaSnC4zNvV9bCzFWIhyY
	y9EMqU2VbJ1XMmDyVGrLugaAsGMepTj0kxtn0JaKBeKRV3ebCZl3g8jwnc+vZk0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ww+cIy
	jGJ6bxTZvH1qrj1FyjHflSjEWFQAq5JVuJDmgEuFPRmjm5BUTX27yvd79rOp2HVQ
	bC0l88yis7WcHMZuYFQXxtZXeIag3tPQ2DZdI/G1iA5TG3pGG4kgvnc8uytAkn3F
	Nq61mnIAZKJLxFBrMCmG0hkyVuAwpPj7J+uYo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 668764DDA9;
	Fri, 25 Mar 2016 12:56:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8DDB44DDA1;
	Fri, 25 Mar 2016 12:56:00 -0400 (EDT)
In-Reply-To: <CAKqreux8FHdJoKDishjQkbi9g1oUc265EUK4nOJ_sgeFivGSNA@mail.gmail.com>
	(=?utf-8?B?IuaDoOi9tue+pCIncw==?= message of "Fri, 25 Mar 2016 22:21:48
 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 73CF3256-F2AA-11E5-8B08-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289906>

=E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqun@gmail.com> writes:

>> There's a lot of "what" here that the caller doesn't really care abo=
ut,
>> and which may go stale with respect to the implementation over time.=
 Can
>> we make something more succinct like:
>>
>>   /*
>>    * Return a path suitable for writing run-time files related to gi=
t,
>>    * or NULL if no such path can be established. The resulting strin=
g
>>    * should be freed by the caller.
>>    */
>>
>> ?
>
> That's clearer, but if I were the caller, I would worry about the
> security of the path.
> How about adding:
>
> The security of the path is ensured by file permission.

Is "by file permission" descriptive enough?

To protect /a/b/c/socket, what filesystem entities have the right
permission bits set?  If the parent directory is writable by an
attacker, the permission bits on 'socket' itself may not matter as
the attacker can rename it away and create new one herself, for
example.

> I will deal with it.
>
> I find there are some similar leakage in this file. I'll fix them in
> another patch.
>
> Do you think we need some additional comments for the release of strb=
uf?

As Documentation/technical/api-strbuf.txt has this, I think we are
already OK.

`strbuf_release`::

	Release a string buffer and the memory it used. You should not use the
	string buffer after using this function, unless you initialize it agai=
n.
