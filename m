From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Do not output whitespace on blank lines
Date: Sun, 29 May 2016 17:30:59 -0700
Message-ID: <xmqqa8j8pet8.fsf@gitster.mtv.corp.google.com>
References: <01020154fd28aa12-f536bf3e-58df-4d1f-b903-929b429954d3-000000@eu-west-1.amazonses.com>
	<574B25F4.8090409@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dave Nicolson <david.nicolson@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon May 30 02:31:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7B6s-0005Ea-0z
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 02:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258AbcE3AbF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 May 2016 20:31:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57614 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753114AbcE3AbE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2016 20:31:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 736EB2053B;
	Sun, 29 May 2016 20:31:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=C8/t+wkSbAJl
	mjJrh45o6qtjZls=; b=d800jyAJGshPq+CtLroNfGAd4IMzCY4Dn5boWMpLnYSH
	l6xz56JxfBHe2JLKeFhbxayTshX9NEcAtCQILq84dUNpRzyAx7D3lp/wuQDDlYvx
	gYCSrsRqgOk1wUdzlYwUCAYZThKST4K1czG5Gfu65lyTdepVBtkjt5mgIYU+BEA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=oK7Feb
	RTp2ucbRVhLxzZOCcpDUtntk9Q6YyVJyb1OIYa8aIn9CDt8dqsq47rs6XIVjaXux
	dQab7cG/5p9qDXjxhVedQVRCEu6797tCwfWIwuHqgIb3h2tFQK021YLMABFFq2gu
	T7cVvRqaMxgxrruugR/DFYtfwvE9qsPBOKbds=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C6152053A;
	Sun, 29 May 2016 20:31:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CCD2120539;
	Sun, 29 May 2016 20:31:01 -0400 (EDT)
In-Reply-To: <574B25F4.8090409@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Sun, 29
	May 2016 19:25:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C979CAAA-25FD-11E6-B2EB-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295848>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 29.05.2016 um 17:36 schrieb Dave Nicolson:
>> ---
>
> git diff marks context lines (in unified diff format) with a precedin=
g
> space character.  Your intent is to remove that marker for empty
> context lines, right?  Why?  How much smaller do diffs get by that
> (assuming output size reduction is one of the reasons)?
>
> How compatible is it with patch, git apply and other programs that
> handle diffs?  Interestingly in that context, POSIX [*] allows it,
> saying: "It is implementation-defined whether an empty unaffected lin=
e
> is written as an empty line or a line containing a single <space>
> character."

Indeed POSIX allows it, and I am aware of a push to GNU diff some
time ago that making this possible (I do not offhand know if it was
a move to make it default, though), which is why "git apply" does
tolerate an empty line in the common context that is not a single SP
on a line since b507b465 (git-apply: prepare for upcoming GNU diff
-u format change., 2006-10-19).

But that does not mean we should flip the default without any
justification like this patch does.

=46WIW, GNU diffutils 3.3 seems _not_ to default to this behaviour,
and require you to say --suppress-blank-empty when asking for this
form of output.  The rationale for this option in their
documentation is:

    Some text editors and email agents routinely delete trailing
    blanks, so it can be a problem to deal with diff output files
    that contain them. You can avoid this problem with the
    --suppress-blank-empty option. It causes diff to omit trailing
    blanks at the end of output lines in normal, context, and
    unified format, unless the trailing blanks were already present
    in the input.

If you think about this, the above does not make _any_ sense as a
justification for that feature.  "Some editors tend to remove SPs
that you do want if they appear at the end of line, which is a
problem.  To _AVOID_ this problem, we give an option not to produce
the SP that may be eaten by such editors in the first place".

Seriously?  The reason why you do want them in the first place is
because eating them silently would cause trouble on the receiving
end, so it is very understandable to prepare the side that _uses_
diff output to accept such an output that is missing the SPs at the
end of the line.  That justification does not make sense for the
side that _generates_ output at all.

In any case, I am not strongly opposed to add --suppress-blank-empty
option to "git diff" family, even though I do not see much point in
it.  I'll not accept a change to make that the default, until "diff"
implementations everybody else uses uses such default and POSIX
starts saying "a single SP on a line to represent an empty shared
context is deprecated".
