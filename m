From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH (Eek!)] git diff does not honor --no-ext-diff
Date: Wed, 26 Nov 2008 08:59:13 +0100
Message-ID: <492D01D1.7020702@lsrfire.ath.cx>
References: <544dda350811252312u7ef5533bwb20b37640d861487@mail.gmail.com> <7vprkihqk6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nazri Ramliy <ayiehere@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 09:00:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5FK9-00021k-TP
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 09:00:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbYKZH7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 02:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbYKZH7V
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 02:59:21 -0500
Received: from india601.server4you.de ([85.25.151.105]:53901 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbYKZH7V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 02:59:21 -0500
Received: from [10.0.1.101] (p57B7E31A.dip.t-dialin.net [87.183.227.26])
	by india601.server4you.de (Postfix) with ESMTPSA id 8A5ED2F8051;
	Wed, 26 Nov 2008 08:59:18 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <7vprkihqk6.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101709>

Junio C Hamano schrieb:
> "Nazri Ramliy" <ayiehere@gmail.com> writes:
> 
>> git-diff does not honor the --no-ext-diff option in both cases when the external
>> diff program is set via diff.external and gitattributes.
>>
>> Is this intentional?
> 
> Judging from 72909be (Add diff-option --ext-diff, 2007-06-30), I think
> this was intended in the sense that --ext-diff and --no-ext-diff were
> meant to be no-op for "diff" itself when they were introduced.
> 
> Having said that, I do not know if I agree with the original intention.
> It looks more like an oversight that came from focusing only on what a new
> behaviour for the "log" family should be, than a logical design decision
> to exclude "diff" from this codepath.
> 
> Wouldn't this be a better patch?

Yes.  And feel free to squash in the following. :)

diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index dfe3fbc..ec787b4 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -43,6 +43,13 @@ test_expect_success 'GIT_EXTERNAL_DIFF environment should apply only to diff' '
 
 '
 
+test_expect_success 'GIT_EXTERNAL_DIFF environment and --no-ext-diff' '
+
+	GIT_EXTERNAL_DIFF=echo git diff --no-ext-diff |
+	grep "^diff --git a/file b/file"
+
+'
+
 test_expect_success 'diff attribute' '
 
 	git config diff.parrot.command echo &&
@@ -68,6 +75,13 @@ test_expect_success 'diff attribute should apply only to diff' '
 
 '
 
+test_expect_success 'diff attribute and --no-ext-diff' '
+
+	git diff --no-ext-diff |
+	grep "^diff --git a/file b/file"
+
+'
+
 test_expect_success 'diff attribute' '
 
 	git config --unset diff.parrot.command &&
@@ -94,6 +108,13 @@ test_expect_success 'diff attribute should apply only to diff' '
 
 '
 
+test_expect_success 'diff attribute and --no-ext-diff' '
+
+	git diff --no-ext-diff |
+	grep "^diff --git a/file b/file"
+
+'
+
 test_expect_success 'no diff with -diff' '
 	echo >.gitattributes "file -diff" &&
 	git diff | grep Binary
