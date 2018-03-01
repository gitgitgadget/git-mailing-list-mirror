Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A430D1F576
	for <e@80x24.org>; Thu,  1 Mar 2018 10:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967609AbeCAKvw (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 05:51:52 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:32655 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967579AbeCAKvY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 05:51:24 -0500
Received: from lindisfarne.localdomain ([92.22.16.137])
        by smtp.talktalk.net with SMTP
        id rLnoeYfgY59cnrLnwexaFu; Thu, 01 Mar 2018 10:51:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519901477;
        bh=9wAHtahnsOH2w01XKwYm7IlTk4+dwWlZDg33ZH5Qmk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=Brd9MW5JET74+RUF5hzW11fAzDGwRd6u9FX7EyLyvqeXShi1xQRILgqG/+3AzClBG
         WjGNJcuT+iRUDlK0MNvpZUHn6rV1L1DVU5slM8gllPB3RmlaD+SYnt0Pi6+uid+gBH
         zSL9mDwyeDIktOOhlQIeKq5t20eMcsRc0JnEA6Mo=
X-Originating-IP: [92.22.16.137]
X-Spam: 0
X-OAuthority: v=2.3 cv=Yr8hubQX c=1 sm=1 tr=0 a=nWy375ASyxHoIYnPohIYMA==:117
 a=nWy375ASyxHoIYnPohIYMA==:17 a=evINK-nbAAAA:8 a=ybZZDoGAAAAA:8
 a=TQO8FCMgGYcQxHoYvoMA:9 a=GvWkX6MdpQk4SUrl:21 a=Z-JS3JWn8hL6a7Zp:21
 a=RfR_gqz1fSpA9VikTjo0:22 a=0RhZnL1DYvcuLYC8JZ5M:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 4/9] t3701: don't hard code sha1 hash values
Date:   Thu,  1 Mar 2018 10:50:58 +0000
Message-Id: <20180301105103.24268-5-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180301105103.24268-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180301105103.24268-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfGBkoTsGcgFjx0FvrAMkMajVRFyEVexd8ddU+A2DFRvBpJNJok7ee53VHSak87LhfqT2k5f3lVPd6hBLfc2ZiW4Ul/qOkGKFOS9PU2z7dhZVc0+gLYjL
 +8SzHpGzISsfbX9D9q5s4woEn8mLCMfwhUw+vbV0gQP/EUwpyzRn2pSh7Hh2thBUD37svb6orzBpiGtAmQe9haSIhjEut5LN+43Yne4qwfjqdQVCtjcpf8We
 Ob5AW667mKFSu99J7T/ITfbxVUIEc4shBIlXsCbOQZzjOddr4q6gXiydcCHsFULEeI6pRh9Nqs0tVwOOA0zTnacPhpK4tqnLGK5fsqCzApk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Use a filter when comparing diffs to fix the value of non-zero hashes
in diff index lines so we're not hard coding sha1 hash values in the
expected output. This makes it easier to change the expected output if
a test is edited as we don't need to worry about the exact hash value
and means the tests will work when the hash algorithm is transitioned
away from sha1.

Thanks-to: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    changes since v3:
     - fix zero hash values to seven digits
    changes since v2:
     - fix hash values in index lines rather than removing the line
     - reworded commit message

 t/t3701-add-interactive.sh | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 836ce346ed..f95714230b 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -10,6 +10,19 @@ then
 	test_done
 fi
 
+diff_cmp () {
+	for x
+	do
+		sed  -e '/^index/s/[0-9a-f]*[1-9a-f][0-9a-f]*\.\./1234567../' \
+		     -e '/^index/s/\.\.[0-9a-f]*[1-9a-f][0-9a-f]*/..9abcdef/' \
+		     -e '/^index/s/ 00*\.\./ 0000000../' \
+		     -e '/^index/s/\.\.00*$/..0000000/' \
+		     -e '/^index/s/\.\.00* /..0000000 /' \
+		     "$x" >"$x.filtered"
+	done
+	test_cmp "$1.filtered" "$2.filtered"
+}
+
 test_expect_success 'setup (initial)' '
 	echo content >file &&
 	git add file &&
@@ -35,7 +48,7 @@ test_expect_success 'setup expected' '
 test_expect_success 'diff works (initial)' '
 	(echo d; echo 1) | git add -i >output &&
 	sed -ne "/new file/,/content/p" <output >diff &&
-	test_cmp expected diff
+	diff_cmp expected diff
 '
 test_expect_success 'revert works (initial)' '
 	git add file &&
@@ -72,7 +85,7 @@ test_expect_success 'setup expected' '
 test_expect_success 'diff works (commit)' '
 	(echo d; echo 1) | git add -i >output &&
 	sed -ne "/^index/,/content/p" <output >diff &&
-	test_cmp expected diff
+	diff_cmp expected diff
 '
 test_expect_success 'revert works (commit)' '
 	git add file &&
@@ -91,7 +104,7 @@ test_expect_success 'dummy edit works' '
 	test_set_editor : &&
 	(echo e; echo a) | git add -p &&
 	git diff > diff &&
-	test_cmp expected diff
+	diff_cmp expected diff
 '
 
 test_expect_success 'setup patch' '
@@ -159,7 +172,7 @@ test_expect_success 'setup expected' '
 test_expect_success 'real edit works' '
 	(echo e; echo n; echo d) | git add -p &&
 	git diff >output &&
-	test_cmp expected output
+	diff_cmp expected output
 '
 
 test_expect_success 'skip files similarly as commit -a' '
@@ -171,7 +184,7 @@ test_expect_success 'skip files similarly as commit -a' '
 	git reset &&
 	git commit -am commit &&
 	git diff >expected &&
-	test_cmp expected output &&
+	diff_cmp expected output &&
 	git reset --hard HEAD^
 '
 rm -f .gitignore
@@ -248,7 +261,7 @@ test_expect_success 'add first line works' '
 	git apply patch &&
 	(echo s; echo y; echo y) | git add -p file &&
 	git diff --cached > diff &&
-	test_cmp expected diff
+	diff_cmp expected diff
 '
 
 test_expect_success 'setup expected' '
@@ -271,7 +284,7 @@ test_expect_success 'deleting a non-empty file' '
 	rm non-empty &&
 	echo y | git add -p non-empty &&
 	git diff --cached >diff &&
-	test_cmp expected diff
+	diff_cmp expected diff
 '
 
 test_expect_success 'setup expected' '
@@ -290,7 +303,7 @@ test_expect_success 'deleting an empty file' '
 	rm empty &&
 	echo y | git add -p empty &&
 	git diff --cached >diff &&
-	test_cmp expected diff
+	diff_cmp expected diff
 '
 
 test_expect_success 'split hunk setup' '
@@ -355,7 +368,7 @@ test_expect_success 'patch mode ignores unmerged entries' '
 	+changed
 	EOF
 	git diff --cached >diff &&
-	test_cmp expected diff
+	diff_cmp expected diff
 '
 
 test_expect_success TTY 'diffs can be colorized' '
@@ -384,7 +397,7 @@ test_expect_success 'patch-mode via -i prompts for files' '
 
 	echo test >expect &&
 	git diff --cached --name-only >actual &&
-	test_cmp expect actual
+	diff_cmp expect actual
 '
 
 test_expect_success 'add -p handles globs' '
-- 
2.16.1

