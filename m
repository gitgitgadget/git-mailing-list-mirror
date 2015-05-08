From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t0005-signals.sh fails with ksh
Date: Fri, 08 May 2015 14:16:19 -0700
Message-ID: <xmqqwq0iixcs.fsf@gitster.dls.corp.google.com>
References: <31108626.20150508231514@gmail.com>
	<xmqq1tiqkdue.fsf@gitster.dls.corp.google.com>
	<20150508205548.GB13457@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: evgeny <illumsoft.org@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 08 23:16:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqpdE-0003lG-1T
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 23:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812AbbEHVQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 17:16:23 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60555 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752717AbbEHVQW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 17:16:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5040341FB2;
	Fri,  8 May 2015 17:16:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DUNF8hU0f9XirdQ+FQlBcip3fxA=; b=na4DfK
	onkgLccjRWydfTvFnTT12qzqAQ8d2TjodIgQVV/zKM50flwOBY2fv6jM98L3OtyL
	QQ4rBdkTHoPlb+Cd/hguh5VHWxyjBHwDUzRbxJkviH0mLY7D7HK8mc3a68l7hjn4
	Hk7t8VxnLU1ItN1o+s7iOgIhlyf0vK8Xwr6RQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WT2pQli2jPiHFH4dguDYff03LCAwHN3S
	p2F4H/Tn8rpfYK2kyUZxK1Yor5uiZsFFYQhC/LuoGEgP63x/I0VCrKTikdCY9cEI
	My4tlntHzJt91fjdxgsBUW3mlaW+HS8983DySaCuCnBFCQ2BvR0oSzSdDZ9EBxXE
	7JiIsLd8MNk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 49B3D41FB1;
	Fri,  8 May 2015 17:16:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BB20741FB0;
	Fri,  8 May 2015 17:16:20 -0400 (EDT)
In-Reply-To: <20150508205548.GB13457@peff.net> (Jeff King's message of "Fri, 8
	May 2015 16:55:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7925FE78-F5C7-11E4-835A-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268670>

Jeff King <peff@peff.net> writes:

> On Fri, May 08, 2015 at 01:34:49PM -0700, Junio C Hamano wrote:
>
>> evgeny <illumsoft.org@gmail.com> writes:
>> 
>> > expecting success: 
>> >         OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
>> >         test "$OUT" -eq 141
>> >
>> > t0005-signals.sh[499]: eval: syntax error at line 4: `(' unmatched
>> > Memory fault
>> 
>> Does this work if you did
>> 
>> 	OUT=$( ( (large_git ; echo $? 1>&3) | : ) 3>&2 ) &&
>> 
>> instead?
>
> It does for me. I've tested our suite with mksh before, and it passed
> (that's why the earlier check already covers ksh). But using the ksh I
> get from "apt-get install ksh" on Debian (ksh93, it looks like?) fails
> as described. 
> ...

Yuck.

> I'm on the fence, though, on declaring ksh93 to be unsupported. I don't
> know how many other instances of this are in our test suite, and it's
> one more maintenance headache to deal with. Are there really platforms
> with no actual POSIX shell (on Solaris, for example, the xpg6 shell is a
> much better choice)?

Yeah, ksh has gone too far and now is on the other side, I would
have to say.  Introducing new keywords and semantics to let its
users use new features (e.g. "let") is one thing, but breaking a
valid POSIX shell construct and interpreting it in an incompatible
way is going just too far for it to be treated as a Bourne variant.

I wonder if zsh is in the same league.  Do we support people who do
SHELL_PATH=/bin/zsh and bend over backwards when it breaks?

I'm on the fence, too.
