Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F5D11F576
	for <e@80x24.org>; Tue, 27 Feb 2018 11:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752791AbeB0LEb (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 06:04:31 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:38863 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752526AbeB0LE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 06:04:27 -0500
Received: from lindisfarne.localdomain ([89.242.176.20])
        by smtp.talktalk.net with SMTP
        id qd3QeQ4WdoNnDqd3ZeXd0l; Tue, 27 Feb 2018 11:04:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519729465;
        bh=4NjRfDTRKi1c+J54K5IIJ+OMchdjQCzZ/F1cy/PXAuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=bhb/tEt+ZKfN9cRU+iJJJdGEUxquWNzty2KPCExEHEznqg+iiqrSIsOTJw+N9JGDs
         +B26lVYcvjsnuNSv8QkxWF8ZGc32eLv++5wIY3sdO3jys8kS3Z8nazsG0EXp0P9QKR
         w7CaNpuuZ5jR5MS2XDF0AlWik/b25tDeywiQnULM=
X-Originating-IP: [89.242.176.20]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZZ9tDodA c=1 sm=1 tr=0 a=BZXIa/HMvEOrkAULb1ciZg==:117
 a=BZXIa/HMvEOrkAULb1ciZg==:17 a=evINK-nbAAAA:8 a=lSdJyWsktzXlDhlMj3UA:9
 a=XmVmglaO1cG27cQD:21 a=thlRE7dt-AYeVCSJ:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 4/9] t3701: don't hard code sha1 hash values
Date:   Tue, 27 Feb 2018 11:03:59 +0000
Message-Id: <20180227110404.16816-5-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180227110404.16816-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180227110404.16816-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfHceZpoVR87XFaQFJU1QPQeeOHFad2MgKYg0DofbkAaX9pTcc6eZTxsQn3kMpWN8R/5AwwLRc7IV43m8e0Mv7JtsACsutKLdeUkdu0Fl0jTa46OVpntO
 gfrPKZEb1IKOenFpoKqJBV/1gRwa6raWA2RCfCDlN6ygO2ZV8PpIV6ER98nemP1Yj417wXRYKYI80POOQRuL6DhYv6eoTlAgWyePv4HlvdCt0/cXjkadS13n
 NSHXbgXWLx26yUqCnLn15gsh3K0ViFZIjkhCuWoTeVeA6OHd0dIb0qopvzViGZERwi/hmIT/X/uA5PZYlzYOG+C9qYhMsoryQ97efmQj3i4=
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

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    changes since v2:
     - fix hash values in index lines rather than removing the line
     - reworded commit message

 t/t3701-add-interactive.sh | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index bdd1f292a9..46d655038f 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -10,6 +10,16 @@ then
 	test_done
 fi
 
+diff_cmp () {
+	for x
+	do
+		sed  -e '/^index/s/[0-9a-f]*[1-9a-f][0-9a-f]*\.\./1234567../' \
+		     -e '/^index/s/\.\.[0-9a-f]*[1-9a-f][0-9a-f]*/..9abcdef/' \
+		     "$x" >"$x.filtered"
+	done
+	test_cmp "$1.filtered" "$2.filtered"
+}
+
 test_expect_success 'setup (initial)' '
 	echo content >file &&
 	git add file &&
@@ -35,7 +45,7 @@ test_expect_success 'setup expected' '
 test_expect_success 'diff works (initial)' '
 	(echo d; echo 1) | git add -i >output &&
 	sed -ne "/new file/,/content/p" <output >diff &&
-	test_cmp expected diff
+	diff_cmp expected diff
 '
 test_expect_success 'revert works (initial)' '
 	git add file &&
@@ -72,7 +82,7 @@ test_expect_success 'setup expected' '
 test_expect_success 'diff works (commit)' '
 	(echo d; echo 1) | git add -i >output &&
 	sed -ne "/^index/,/content/p" <output >diff &&
-	test_cmp expected diff
+	diff_cmp expected diff
 '
 test_expect_success 'revert works (commit)' '
 	git add file &&
@@ -91,7 +101,7 @@ test_expect_success 'dummy edit works' '
 	test_set_editor : &&
 	(echo e; echo a) | git add -p &&
 	git diff > diff &&
-	test_cmp expected diff
+	diff_cmp expected diff
 '
 
 test_expect_success 'setup patch' '
@@ -159,7 +169,7 @@ test_expect_success 'setup expected' '
 test_expect_success 'real edit works' '
 	(echo e; echo n; echo d) | git add -p &&
 	git diff >output &&
-	test_cmp expected output
+	diff_cmp expected output
 '
 
 test_expect_success 'skip files similarly as commit -a' '
@@ -171,7 +181,7 @@ test_expect_success 'skip files similarly as commit -a' '
 	git reset &&
 	git commit -am commit &&
 	git diff >expected &&
-	test_cmp expected output &&
+	diff_cmp expected output &&
 	git reset --hard HEAD^
 '
 rm -f .gitignore
@@ -248,7 +258,7 @@ test_expect_success 'add first line works' '
 	git apply patch &&
 	(echo s; echo y; echo y) | git add -p file &&
 	git diff --cached > diff &&
-	test_cmp expected diff
+	diff_cmp expected diff
 '
 
 test_expect_success 'setup expected' '
@@ -271,7 +281,7 @@ test_expect_success 'deleting a non-empty file' '
 	rm non-empty &&
 	echo y | git add -p non-empty &&
 	git diff --cached >diff &&
-	test_cmp expected diff
+	diff_cmp expected diff
 '
 
 test_expect_success 'setup expected' '
@@ -290,7 +300,7 @@ test_expect_success 'deleting an empty file' '
 	rm empty &&
 	echo y | git add -p empty &&
 	git diff --cached >diff &&
-	test_cmp expected diff
+	diff_cmp expected diff
 '
 
 test_expect_success 'split hunk setup' '
@@ -355,7 +365,7 @@ test_expect_success 'patch mode ignores unmerged entries' '
 	+changed
 	EOF
 	git diff --cached >diff &&
-	test_cmp expected diff
+	diff_cmp expected diff
 '
 
 test_expect_success TTY 'diffs can be colorized' '
@@ -384,7 +394,7 @@ test_expect_success 'patch-mode via -i prompts for files' '
 
 	echo test >expect &&
 	git diff --cached --name-only >actual &&
-	test_cmp expect actual
+	diff_cmp expect actual
 '
 
 test_expect_success 'add -p handles globs' '
-- 
2.16.1

