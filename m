Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B6D92023D
	for <e@80x24.org>; Wed,  1 Mar 2017 18:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753179AbdCASka (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 13:40:30 -0500
Received: from mout.web.de ([217.72.192.78]:54720 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752462AbdCASkC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 13:40:02 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MUW7T-1crXbw2mVn-00RFEz; Wed, 01
 Mar 2017 18:04:47 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org, mac@mcrowe.com
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v1 1/1] git diff --quiet exits with 1 on clean tree with CRLF conversions
Date:   Wed,  1 Mar 2017 18:04:44 +0100
Message-Id: <20170301170444.14274-1-tboegi@web.de>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <xmqqshmyhtnu.fsf@gitster.mtv.corp.google.com>
References: <xmqqshmyhtnu.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Ji6lIRZkU6jgpqkOtX1fYSvuCIGNcHBtVA1B9wdRW71f4EIGBbX
 09b/e/iMEUDG0cWQQdzUhdEMCbchPAllu5xITNmN1tlqtlc+wJ1b+s5pi7knqPTObU4cOrF
 u6QAH8gjCv7hchiJ2I5Ld4qbvCuYRZTMgrZ1as3ucqs3L2gLJFWMP0+kqDtUrrYWaZC+kYG
 Bn7mtRBpVGMB/w/R0sphw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rA4gU6mU7mk=:GI7axU4gtrlJ3rEQEGef3B
 4h3oBLOuWi7kqrnJ2T7lCcl4kMVHTObG4v1wkPh3tdOz0TLWpXzzS0vWI9Z278zN+CwRSSJGC
 pVXievum3lowZJtHf0oDEYzvjQ9/MZnXkOPw3NdnHXpBlTFwV6cJ+u0DuYWhvqISKMtf4aCIL
 S1sJgYqAjeDW/wqWS9G244WKukxEg7nueulFMrlu975Gi8Aqr2SqCo9Dr2VNmtx+C1W1xZlDv
 jGcb2KaI/E6B8T2gaydEow2QqbNa+J9mLJOOfDZpgcqYVPk/vwxt4V+TFhC2aS2ttWTy4kn8M
 nnbgM4F9lO90RefdSN8lkmrqQ5r1pWcwZTPVWAQqh3v0kxcvIbzRoUesSgqQ2bQM+hdaynJ3r
 y4jPuncNqzLjUa2Pm49zlLshj99OUZLrvlrxfdDWAwDsCeqNdYoRvU0A9Acmsem0Ed/HMYnw+
 u6VRtk++50n/Ne5zYdk4A0tPzhKrMn3a5KSgVBFaTlt2VK8v2RKncadPj6TDtWG7lmB1IWD5V
 6ffCCWAN1ohf/En2p8D0iLjth2H7lgF4BW80YfFhHi2htVC3yCMIiIS2qd4Zdjf/Eaqn412Az
 JPh8DiMoNGfrhizWMzaaBZn7U3//p2JGEk24twCt5IR9XAszIip4DyltKichj6VncsGs+3+2e
 aUqqPady4YQ6HoqOHdhkH452yOAslKenEMKHOlEMoQWfCajSJrtkm1yh1iGzfGNkDf3R9QYOC
 7jSfeYaK/V7WCgyLBzuQmAzvVnyI5DJR/3B/eKhz25QYomipZ0FiIqr5Mp4iYGKsQWvJhWIW4
 3+KUou3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

git diff --quiet may take a short-cut to see if a file is changed
in the working tree:
Whenever the file size differs from what is recorded in the index,
the file is assumed to be changed and git diff --quiet returns
exit with code 1

This shortcut must be suppressed whenever the line endings are converted
or a filter is in use.
The attributes say "* text=auto" and a file has
"Hello\nWorld\n" in the index with a length of 12.
The file in the working tree has "Hello\r\nWorld\r\n" with a length of 14.
(Or even "Hello\r\nWorld\n").
In this case "git add" will not do any changes to the index, and
"git diff -quiet" should exit 0.

Add calls to would_convert_to_git() before blindly saying that a different
size means different content.

Reported-By: Mike Crowe <mac@mcrowe.com>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
This is what I can come up with, collecting all the loose ends.
I'm not sure if Mike wan't to have the Reported-By with a
Signed-off-by ?
The other question is, if the commit message summarizes the discussion
well enough ?

diff.c                    | 18 ++++++++++++++----
 t/t0028-diff-converted.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 4 deletions(-)
 create mode 100755 t/t0028-diff-converted.sh

diff --git a/diff.c b/diff.c
index 051761b..c264758 100644
--- a/diff.c
+++ b/diff.c
@@ -4921,9 +4921,10 @@ static int diff_filespec_check_stat_unmatch(struct diff_filepair *p)
 	 *    differences.
 	 *
 	 * 2. At this point, the file is known to be modified,
-	 *    with the same mode and size, and the object
-	 *    name of one side is unknown.  Need to inspect
-	 *    the identical contents.
+	 *    with the same mode and size, the object
+	 *    name of one side is unknown, or size comparison
+	 *    cannot be depended upon.  Need to inspect the
+	 *    contents.
 	 */
 	if (!DIFF_FILE_VALID(p->one) || /* (1) */
 	    !DIFF_FILE_VALID(p->two) ||
@@ -4931,7 +4932,16 @@ static int diff_filespec_check_stat_unmatch(struct diff_filepair *p)
 	    (p->one->mode != p->two->mode) ||
 	    diff_populate_filespec(p->one, CHECK_SIZE_ONLY) ||
 	    diff_populate_filespec(p->two, CHECK_SIZE_ONLY) ||
-	    (p->one->size != p->two->size) ||
+
+	    /*
+	     * only if eol and other conversions are not involved,
+	     * we can say that two contents of different sizes
+	     * cannot be the same without checking their contents.
+	     */
+	    (!would_convert_to_git(p->one->path) &&
+	     !would_convert_to_git(p->two->path) &&
+	     (p->one->size != p->two->size)) ||
+
 	    !diff_filespec_is_identical(p->one, p->two)) /* (2) */
 		p->skip_stat_unmatch_result = 1;
 	return p->skip_stat_unmatch_result;
diff --git a/t/t0028-diff-converted.sh b/t/t0028-diff-converted.sh
new file mode 100755
index 0000000..3d5ab95
--- /dev/null
+++ b/t/t0028-diff-converted.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+#
+# Copyright (c) 2017 Mike Crowe
+#
+# These tests ensure that files changing line endings in the presence
+# of .gitattributes to indicate that line endings should be ignored
+# don't cause 'git diff' or 'git diff --quiet' to think that they have
+# been changed.
+
+test_description='git diff with files that require CRLF conversion'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo "* text=auto" >.gitattributes &&
+	printf "Hello\r\nWorld\r\n" >crlf.txt &&
+	git add .gitattributes crlf.txt &&
+	git commit -m "initial"
+'
+
+test_expect_success 'quiet diff works on file with line-ending change that has no effect on repository' '
+	printf "Hello\r\nWorld\n" >crlf.txt &&
+	git status &&
+	git diff --quiet
+'
+
+test_done
-- 
2.10.0

