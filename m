From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git p4 test: fix failure in 9814-git-p4-rename.sh Was: Re: Test failure in t9814-git-p4-rename.sh - my environment or bad test?
Date: Thu, 24 Jul 2014 15:05:54 -0700
Message-ID: <xmqq4my68la5.fsf@gitster.dls.corp.google.com>
References: <CABUJjW8TFCw2wwAO83vMBPc7vQc+rvuPOAca-CNECEduUn19Ew@mail.gmail.com>
	<53D1543F.50508@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christoph Bonitz <ml.christophbonitz@gmail.com>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jul 25 00:06:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAR9N-0003kx-JE
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 00:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbaGXWGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 18:06:04 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57734 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752268AbaGXWGD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 18:06:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2A7782AF56;
	Thu, 24 Jul 2014 18:06:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R3K2/hic+V0kExE1Zj5/iAMcPlk=; b=jkECJQ
	P9lev0u3pbdlCf7GoySInJTwYu0mJ+qetlR/uNheViWP0mxGlrJBFZGwPLjkK5ks
	COLXF02PTMWn2zGethtGJsfhcU9xgQR+WkYsAjCaQQcs4aOR2sd9Ot1t81E6lMfu
	AL4Ps1BdL9Yw0/F+N2hwDif+dFcpz81/3mDr0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eA82yHfLqtXSWAtmdvj9GSlzFuAd/EVM
	zImgfcfAv5NLg4U++i0k5lx9KVox9eTWPLkPf2GMUTuPOrnwbwE+PR58IfUocSnK
	xT/7rluN8Javkf2panXhZINNmIO/PZC22vqCIw+w6uGP7YuHDpfnvqH/hKtP6Vo/
	PJ2qz4ZNcv8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 06D812AF50;
	Thu, 24 Jul 2014 18:06:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BB1A82AF46;
	Thu, 24 Jul 2014 18:05:55 -0400 (EDT)
In-Reply-To: <53D1543F.50508@kdbg.org> (Johannes Sixt's message of "Thu, 24
	Jul 2014 20:45:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AF6B0E50-137E-11E4-BAE5-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254188>

Johannes Sixt <j6t@kdbg.org> writes:

>> @@ -177,7 +175,7 @@ test_expect_success 'detect copies' '
>>   level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
>>   test -n "$level" && test "$level" -gt 0 && test "$level" -lt 98 &&
>>   src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
>> - test "$src" = file10 || test "$src" = file11 &&
>> + test "$src" = file2 || test "$src" = file10 || test "$src" = file11 &&
>
> You can't test for alternatives in this way. It's already wrong in the
> original line, which is from 795fcb0e (avoid "test <cond> -a/-o <cond>"),
> and breaks the && chain. You need braces like this:
>
>   { test "$src" = file2 || test "$src" = file10 || test "$src" = file11; } &&
>
> or you wrap it up in a case statement.
> ...
>>   )
>>  '
>> 
>
> I see a few other no-nos in the context of the changes, in particular,
> pipelines where git is not the last command; these would not catch
> failures in the git commands. But a fix for that is certainly outside
> the scope of this patch.

Yuck.  Thanks for spotting.

Perhaps we should apply a preliminary clean-up before doing anything
else, perhaps?  The change in 9814 is a post 2.0 regression.



 t/t9814-git-p4-rename.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
index 1fc1f5f..95f4421 100755
--- a/t/t9814-git-p4-rename.sh
+++ b/t/t9814-git-p4-rename.sh
@@ -177,7 +177,10 @@ test_expect_success 'detect copies' '
 		level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
 		test -n "$level" && test "$level" -gt 0 && test "$level" -lt 98 &&
 		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
-		test "$src" = file10 || test "$src" = file11 &&
+		case "$src" in
+		file10 | file11) : ;; # happy
+		*) false ;; # not
+		&&
 		git config git-p4.detectCopies $(($level + 2)) &&
 		git p4 submit &&
 		p4 filelog //depot/file12 &&
@@ -191,7 +194,10 @@ test_expect_success 'detect copies' '
 		level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
 		test -n "$level" && test "$level" -gt 2 && test "$level" -lt 100 &&
 		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
-		test "$src" = file10 || test "$src" = file11 || test "$src" = file12 &&
+		case "$src" in
+		file10 | file11 | file12) : ;; # happy
+		*) false ;; # not
+		&&
 		git config git-p4.detectCopies $(($level - 2)) &&
 		git p4 submit &&
 		p4 filelog //depot/file13 &&
