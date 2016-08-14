Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F2101F859
	for <e@80x24.org>; Sun, 14 Aug 2016 08:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbcHNI4l (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 04:56:41 -0400
Received: from mout.gmx.net ([212.227.17.22]:50201 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932129AbcHNI4k (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 04:56:40 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Mdrph-1bphH52kZx-00Pgwm; Sun, 14 Aug 2016 10:56:26
 +0200
Date:	Sun, 14 Aug 2016 10:56:25 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH] squash! diff: add --diff-line-prefix option for passing in
 a prefix
Message-ID: <5ca415f99718b1792cd0a9c31606b45d27befc48.1471164824.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:aP93lh6xoXz2+SKBWBjfHGLkOGFNkfHIgqmLcpddZRhvAkP7UGC
 M+qpdIggWmT81XR9yoLc1RIGTssPNYC0mEl3ixmSXXvQFegFbChTcaLb9daBxMcqC2vKQen
 8F3rKMguktU3pm8JuYchiyFhmHluHu1PKfdmwEDwrKe8fs26Rcw5+broY7eCwHkMidPqV2a
 STZbFvgyF8ogUGLmaZGhQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:09/X0k9WaHw=:ayTZdbYe5gxmHQMI2IHhY/
 UGop95CpGqSLBAtzkZ3Xzy3zteRYnsqtDleUsT0nbKrLmt4Mp3loEK1edevdws+UXXphXwS47
 DP5MHVuOG1cHhDuR+fDzSyhqtWrmFQoUUL0/CVIEAKatBsG8TCF3voSaB97jTwaSv+/ix2Ovk
 DlySRmDZrkW9/cFyZF2NJbm2fL7ikqf1hE9jOQkYTDHs5TkH1RCKjEPy61ghjDAyfC40rzWjB
 3CvvyLcwEQO3XspIzpjIB5EpXxcSOegLaZHxRIICNxbG+MMkjlRUQaffImJ1k4BLgW06U+ZGR
 kXJbpvZI45/Ky+QTojLmgl+3T8Or0qlnTaY5cnQku1ObcMNSunUYQaijUxmpDA6E/bsOMNAMd
 zxa9yqIhdMaxel2ex+PbYtvMV/Mu43mpnC8mDavRNC7oKJ+oDHkOtF09crf1NQ79+Jy5/Z5cg
 /cP5dtt41YuuXttLw3iKtgOBMc3D/ongeQkhis5kqfDmYzRQbcWt8jFnrQvDGKAOW1upmhwUm
 pikUIycRiRYzJhhZhXcmGO2Zh/XvgkaUtuzNDWrArNs79FzKYJN7Sd6/9+FUJJYNTskoE8W3i
 d2CVLECddEg0E2rZnNomANsrhk63TL7+wYSWz9/4Tybl5ccGm1n0pQtNAm6bMc55ztLIPEShm
 xDXQDplB0BzUpHg/+NZxwWcqj8lFxcOGLWldRs3fe+1XXf1jXv8Iu6MfDDAn0Vmktzk0LyOI2
 hxuPxCnKKe4FtvjJohL9kJF/52G8zIi7BOslH3pGk2W57GMP88x+c1t3PQ3rsGWqHsoUmNwYk
 I18/3Un
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The '>' character is not a legal part of filenames on Windows. So let's
just not use it in Git's source code. This poses a challenge in the test
script t4013 which distills command-lines into file names (so that the
expected outcome can be stored in files with said names).

We have to take particular care not to confound the existing conversion
of unwanted characters to underscores with the new substitution of '>':
the existing conversion chose to collapse runs of multiple unwanted
characters into a single underscore. If we allowed '>' to be collapsed,
too, the file name generated from the command "diff [...]=-- [...]"
would be identical to the one generated from "diff [...]=--> [...]".

Please squash this patch into
3c90ffd2f01e2d0d080c8e42df2ee89709b324de

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/mingw-t4013-v1
Fetch-It-Via: git fetch https://github.com/dscho/git mingw-t4013-v1

	For the record: this prevented my beautiful CI jobs from even
	checking out the source code for `pu` in the last days.

	Junio, please let me know if you would prefer this as a separate
	patch.

 t/t4013-diff-various.sh                                                 | 2 +-
 ...aster^_side => diff.diff_--diff-line-prefix=--__master_master^_side} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename t/t4013/{diff.diff_--diff-line-prefix=-->_master_master^_side => diff.diff_--diff-line-prefix=--__master_master^_side} (100%)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 5204645..84e2ee0 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -115,7 +115,7 @@ do
 	case "$cmd" in
 	'' | '#'*) continue ;;
 	esac
-	test=$(echo "$cmd" | sed -e 's|[/ ][/ ]*|_|g')
+	test=$(echo "$cmd" | sed -e 's|[/ ][/ ]*|_|g' -e 'y/>/_/')
 	pfx=$(printf "%04d" $test_count)
 	expect="$TEST_DIRECTORY/t4013/diff.$test"
 	actual="$pfx-diff.$test"
diff --git a/t/t4013/diff.diff_--diff-line-prefix=-->_master_master^_side b/t/t4013/diff.diff_--diff-line-prefix=--__master_master^_side
similarity index 100%
rename from t/t4013/diff.diff_--diff-line-prefix=-->_master_master^_side
rename to t/t4013/diff.diff_--diff-line-prefix=--__master_master^_side
-- 
2.9.2.691.g78954f3

base-commit: 945e149951a152207b56d5e49ff5167d151a4c89
