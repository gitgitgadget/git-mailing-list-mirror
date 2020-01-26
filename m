Return-Path: <SRS0=UUNX=3P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E486C2D0DB
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 20:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77082070A
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 20:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGgYTI2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgAZUXX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jan 2020 15:23:23 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41091 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgAZUXX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jan 2020 15:23:23 -0500
Received: by mail-qk1-f196.google.com with SMTP id s187so7687582qke.8
        for <git@vger.kernel.org>; Sun, 26 Jan 2020 12:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RG1c76iUqecI2nlPL2S9riRPhQwrEewVsdOnjqDTgeA=;
        b=rGgYTI2sfwNfRD47uIaavSBPj4ZG3FREPRaarfLKYKo0iGqO2HFDx7BjscB+qihmFA
         nhPA868s8WCNDGIuNOPdKxv0uxSgCDO4mpYwb73xIkQlZ9iGYsAtyBLum67atWsj5YGr
         H+YMk/T1J5iJdghhHA3wX9OFo1Ch/6F0JvY6mp8BViGUTUjQXiEOYcqLXd7PZ2Yp+RgF
         C3qWWiQM8lSfkW2uLwtfZY/mbFSM4RHZ8qysRNF4EJJPe2fu9CA5mxzkuKbxFyL3FPHU
         ARLkAU4f4j5gNG4S0ixiiFgNzMzdSMbWuby1IabHPxHyLI++1DBunZRhybRomyH6jthi
         jZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RG1c76iUqecI2nlPL2S9riRPhQwrEewVsdOnjqDTgeA=;
        b=WqHFwRcAyBCIUSq+opBtcGd0AqVUHX/c8afoH45NOPdarAz7A6ef8PjrwonfkHMTY3
         9yx6ed+5hKTdfYie9O9Hlatez3fWCjR8xZO15xdc+nXNzeyJeyrPvn1C/lWUGtfeUvof
         AQzkyUfoeV9UFoOrPPavFjbJ7JRCxV4kTCh2FJsQMbjNSNQ+yQzIR2KvX9kP+DivcR/q
         Kgp4ApdGsPgS6B2k/9oEuXyQRFEybRiR3Bx/bQ6sk/3nf6YBZQaHOpnz4ZeKLXVyNMwl
         kv4fkOlm6MzAWJmZrXgVHb1XL2i1dlyMwg+OTwxnVAdizHK2rhugCC9s6TLoK0CC7aOj
         9/SQ==
X-Gm-Message-State: APjAAAVenZk85K2jwO2IOHfINmh1xVUg2QsxvDgFdoPtuFaFLsk92LSv
        T52pJG9TxoC9yTJgQo96AwMiQFB3
X-Google-Smtp-Source: APXvYqyaalC58crKbknlMehmLcX+jaidObU+cAIWnqs6IGKdXTRH6i8wuG8a47cgCknr5b4neeMq/g==
X-Received: by 2002:a37:7881:: with SMTP id t123mr13567206qkc.155.1580070202412;
        Sun, 26 Jan 2020 12:23:22 -0800 (PST)
Received: from archbookpro.uwaterloo.ca ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id b30sm4500438qka.48.2020.01.26.12.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 12:23:21 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3] t2018: be more discerning when checking for expected exit codes
Date:   Sun, 26 Jan 2020 15:23:05 -0500
Message-Id: <4af0c20e2981ed7e361083a71cb25b9f4a55fa4f.1580069736.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.rc1.180.g49a268d3eb
In-Reply-To: <587e53053f02ad0867dc903688c8887602950bd3.1578372682.git.liu.denton@gmail.com>
References: <587e53053f02ad0867dc903688c8887602950bd3.1578372682.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Functions test_dirty_unmergeable() and test_dirty_mergeable()
expect git-diff to exit with the specific code 1. However, rather
than checking for that value explicitly, they instead negate the
exit code. Unfortunately, this negation makes it impossible to
distinguish the expected code from some other unexpected non-zero
code, for instance, from a segmentation fault. Therefore, be more
discerning by checking the exit code explicitly using
test_expect_code().

Furthermore, some callers of those functions want to negate the
result again, and do so with test_must_fail(). However,
test_must_fail() should only be used with git commands. Address
this by introducing a couple new tiny helper functions which test
the exact condition expected (without the unnecessarily confusing
double-negation).

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
This patch is a complete replacement for 4/16: "t2018: use
test_expect_code for failing git commands"[1] in
"dl/test-must-fail-fixes-2". It replaces the commit message with a
much-improved version from Eric. Other than that, no code changes are
made.

[1]: https://lore.kernel.org/git/587e53053f02ad0867dc903688c8887602950bd3.1578372682.git.liu.denton@gmail.com/

 t/t2018-checkout-branch.sh | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 61206a90fb..7ca55efc6b 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -34,7 +34,11 @@ do_checkout () {
 }
 
 test_dirty_unmergeable () {
-	! git diff --exit-code >/dev/null
+	test_expect_code 1 git diff --exit-code
+}
+
+test_dirty_unmergeable_discards_changes () {
+	git diff --exit-code
 }
 
 setup_dirty_unmergeable () {
@@ -42,7 +46,11 @@ setup_dirty_unmergeable () {
 }
 
 test_dirty_mergeable () {
-	! git diff --cached --exit-code >/dev/null
+	test_expect_code 1 git diff --cached --exit-code
+}
+
+test_dirty_mergeable_discards_changes () {
+	git diff --cached --exit-code
 }
 
 setup_dirty_mergeable () {
@@ -94,7 +102,7 @@ test_expect_success 'checkout -f -b to a new branch with unmergeable changes dis
 
 	# still dirty and on branch1
 	do_checkout branch2 $HEAD1 "-f -b" &&
-	test_must_fail test_dirty_unmergeable
+	test_dirty_unmergeable_discards_changes
 '
 
 test_expect_success 'checkout -b to a new branch preserves mergeable changes' '
@@ -112,7 +120,7 @@ test_expect_success 'checkout -f -b to a new branch with mergeable changes disca
 	test_when_finished git reset --hard HEAD &&
 	setup_dirty_mergeable &&
 	do_checkout branch2 $HEAD1 "-f -b" &&
-	test_must_fail test_dirty_mergeable
+	test_dirty_mergeable_discards_changes
 '
 
 test_expect_success 'checkout -b to an existing branch fails' '
@@ -163,7 +171,7 @@ test_expect_success 'checkout -B to an existing branch with unmergeable changes
 test_expect_success 'checkout -f -B to an existing branch with unmergeable changes discards changes' '
 	# still dirty and on branch1
 	do_checkout branch2 $HEAD1 "-f -B" &&
-	test_must_fail test_dirty_unmergeable
+	test_dirty_unmergeable_discards_changes
 '
 
 test_expect_success 'checkout -B to an existing branch preserves mergeable changes' '
@@ -180,7 +188,7 @@ test_expect_success 'checkout -f -B to an existing branch with mergeable changes
 
 	setup_dirty_mergeable &&
 	do_checkout branch2 $HEAD1 "-f -B" &&
-	test_must_fail test_dirty_mergeable
+	test_dirty_mergeable_discards_changes
 '
 
 test_expect_success 'checkout -b <describe>' '
-- 
2.25.0.rc1.180.g49a268d3eb

