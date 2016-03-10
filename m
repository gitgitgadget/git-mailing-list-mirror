From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -p: avoid grep on potentailly non-ASCII data
Date: Thu, 10 Mar 2016 09:22:20 -0800
Message-ID: <xmqq1t7ifdtf.fsf@gitster.mtv.corp.google.com>
References: <alpine.DEB.2.10.1603080255030.2674@buzzword-bingo.mit.edu>
	<56DEC4B4.2000902@web.de> <56DED770.4050603@drmicha.warpmail.net>
	<20160308143556.GA10153@sigill.intra.peff.net>
	<xmqqio0wk151.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.10.1603082127230.2674@buzzword-bingo.mit.edu>
	<xmqqvb4vgzxs.fsf@gitster.mtv.corp.google.com>
	<56E1256B.9030308@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Anders Kaseorg <andersk@mit.edu>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Mar 10 18:22:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae4IA-0006I1-2f
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 18:22:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754303AbcCJRW0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Mar 2016 12:22:26 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52401 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753670AbcCJRWY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2016 12:22:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CE43B49373;
	Thu, 10 Mar 2016 12:22:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bvpo0bzKHM7r
	KMaxasELDVn8KGQ=; b=BYZNdkOEhAEwmZljRJtXb3anXncSftXAITJMrNLG3mZV
	DiNg33E6xsWUc4h/4Vik9utu9kh2CcXQehSv60EbvdLPmPPwIwO/fasMUBwzxMtN
	ub+ZJ6g21ExMMH0JQAh5dwP0zksl0tgg0Y+rV1/UqHYuoPAtqtQxo5C1yWy9RFs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nt2tPV
	xqv021YDCu1TLxS6zIFh4VvFzD8ib+0LKN47VITexql7Xl8FpaXRUIe24W6LtqCA
	ISm2GFRt1r5UTX5a+6UXUsgE9vj0uzALiHMJo+yLGb+SlviE0aUSm5wRZZefPAUx
	Bo243w3arY+e3lSm8eKoX4bpDGfKqJLHoT9Z0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C4FA749372;
	Thu, 10 Mar 2016 12:22:22 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 378E64936E;
	Thu, 10 Mar 2016 12:22:22 -0500 (EST)
In-Reply-To: <56E1256B.9030308@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Thu, 10 Mar 2016 08:42:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A658C47A-E6E4-11E5-B773-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288627>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 09.03.16 21:26, Junio C Hamano wrote:
>> Anders Kaseorg <andersk@mit.edu> writes:
> []
>>  sane_grep () {
>> -	GREP_OPTIONS=3D LC_ALL=3DC grep "$@"
>> +	GREP_OPTIONS=3D LC_ALL=3DC grep @@SANE_TEXT_GREP@@ "$@"
>>  }
>> =20
>>  sane_egrep () {
>> -	GREP_OPTIONS=3D LC_ALL=3DC egrep "$@"
>> +	GREP_OPTIONS=3D LC_ALL=3DC egrep @@SANE_TEXT_GREP@@ "$@"
>>  }
>>
>
> I always wondered why we do LC_ALL=3DC.

It is because, at least back when we started scripted Porcelains of
Git, that is the only thing we could count on available everywhere,
and more importantly, that is how you disable all the i18n gotchas
and ask tools to use the traditional "a file stores a stream of
bytes" semantics.

> Isn't that begging for trouble, when we feed UTF-8, ISO-8895-1
> or other stuff into a program and say LC_ALL=3DC at the same time ?

Yes and no.  It is true that in "C" ("POSIX"), behaviour on anything
outside the portable and control character sets is undefined, so in
theory, it is bad that we relied on that undefined behaviour to be
to treat the input as just a stream of bytes.  But at the same time,
it is no worse than letting the user's locale take effect or use
hardcoded en_US.UTF-8 and passing unknown end user data that could
be in latin1 and other stuff.  And sensible implementors of "C"
locale seemed to choose the "stream of bytes" back when fa9d3485
(git-am: force egrep to use correct characters set, 2009-09-25) was
written, which is where LC_ALL=3DC comes from.  I wasn't around when
that patch was accepted, so I cannot quite tell if it was done to
fix a reported bug (i.e. it would reintroduce the bug if we lost
LC_ALL=3DC) or it was done "just because".

Back when e1622bfc (Protect scripted Porcelains from GREP_OPTIONS
insanity, 2009-11-23) introduced sane_grep, the only caller of it
that wanted to use LC_ALL=3DC was this callsite in "git am", and we no
longer have that callsite since 783d7e86 (builtin-am: remove
redirection to git-am.sh, 2015-08-04), so I think whatever fa9d3485
wanted to do will not be broken if we removed LC_ALL=3DC from
sane_grep.  It however is possible that any callsites of sane_grep
added after e1622bfc implicitly depended on having LC_ALL=3DC in the
implementation.
