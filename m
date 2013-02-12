From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] rebase -i: respect core.commentchar
Date: Tue, 12 Feb 2013 10:21:57 -0800
Message-ID: <7vip5xgzp6.fsf@alter.siamese.dyndns.org>
References: <aa1deab1de2e0f998b9ac0bc8c2d76557429a46b.1360610368.git.john@keeping.me.uk>
 <7vzjzali6a.fsf@alter.siamese.dyndns.org>
 <20130211213900.GE2270@serenity.lan>
 <7va9raldw8.fsf@alter.siamese.dyndns.org>
 <20130211230804.GF2270@serenity.lan>
 <7vehgmjsno.fsf@alter.siamese.dyndns.org>
 <20130212095340.GG2270@serenity.lan>
 <7v4nhhigp5.fsf@alter.siamese.dyndns.org>
 <20130212175322.GC13501@farnsworth.metanate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Feb 12 19:22:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5KUv-00032X-Ey
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 19:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933566Ab3BLSWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 13:22:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41290 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933476Ab3BLSV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 13:21:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AE4EB041;
	Tue, 12 Feb 2013 13:21:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QGOfjt0xWh0oCiuKbvwUx7kl8TY=; b=XylRJR
	31ZU236ZBaH2cBKRJuw1yGaAfs3rtB828+FsXLLuLQNlkGP/dwBBg+Swlo5IXoas
	H56ayr2m6WchQLGlsGfO5Le2r9ilID1PqS3ug2jFoo5S5AeGGdpaZzCbjc9YWXwu
	JhBOB4EKM9R7KZnp1jrzdjU3mHBRxEptNg1yw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PJfhKRbixcppR+ifc/ADIANTjz1knv3N
	iiHIVoljxXj7njDuUFqkNa2zuugkdw+TstwA4ew3++0ib9iexfpqH5wjCvbIvqYx
	XEiRrFGnHN9BYgUaAOSsKndLQM20T2lEzeus95856DzENRxh+ot1t1ZKapeoW/5H
	l6vwsc7FljQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AC73B03E;
	Tue, 12 Feb 2013 13:21:59 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C29A3B03A; Tue, 12 Feb 2013
 13:21:58 -0500 (EST)
In-Reply-To: <20130212175322.GC13501@farnsworth.metanate.com> (John Keeping's
 message of "Tue, 12 Feb 2013 17:53:22 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 16A9448E-7541-11E2-89BD-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216171>

John Keeping <john@keeping.me.uk> writes:

>> I am not sure if I understand what you meant by "literal backslash
>> blah blah", though.
>
> It turns out that having this in the script works (in bash and dash
> although I haven't checked what Posix has to say about it):
>
>     sed -e "2,$ s/^/\\\/"
>
> and is equivalent to:
>
>     sed -e '2,$ s/^/\\/'
>
> because backslashes that aren't recognised as part of an escape sequence
> are not treated specially.

That's POSIX.  Inside a dq pair:

        \
        The <backslash> shall retain its special meaning as an escape
        character (see Escape Character (Backslash)) only when followed by
        one of the following characters when considered special:
        $   `   "   \   <newline>

So in your example "\\\/", the first backslash escapes the second
backslash and together they produce a single backslash, the third
backslash is followed by a slash that is not special at all, so it
produces a second backslash, and the slash stands for itself,
resulting in "\\/".
