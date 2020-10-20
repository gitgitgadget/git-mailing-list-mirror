Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1F8C433E7
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 11:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 562012224B
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 11:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIHn2+aa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393731AbgJTLoL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 07:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393645AbgJTLoL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 07:44:11 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A923EC061755
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 04:44:10 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id e15so1036619pfh.6
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 04:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xQDLRFW4FiYAUG6yGXSGbCtCgG6dpFRXFikvWvF4lr0=;
        b=XIHn2+aaISao+OcIkwJaurydAGLWW3KjCJnUjpvuRD9VHT0R2PX8OpZTm/B4+vKcTF
         so0L5g99lMJORUmspyaBLfHrEtnewG8zocM4O1Rj96HaY0alittVc/PQtW+/oMIP12TY
         fvxo23A8VcfttP1hkaD2ZlrFixwj/NQgYgAqMm6aAXB6NzQXH5U9ATeNMctnbfsLBxEN
         PnVwjH8cEjzwldpG3WTQqxX7PBfVRmHeVlXeK+w31CR3+bMF8+YulLHs9Ne0FVYmjrzQ
         9CODrUrjpLidhVHePA/1taY8T/tNs2L1TUCuc/FmNEwCjTUpLbjYhH+z5jpriH3iegJQ
         4Asg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xQDLRFW4FiYAUG6yGXSGbCtCgG6dpFRXFikvWvF4lr0=;
        b=ap3RkrY12WsADjovarTinbOSy/0cSh/AbjPmxjRe/OXqc8YL2lnYj0HhCP1eMt3yQ9
         Sd2lr9ZnlUZwfatLaEjFw92msVyR4vKsc0D52G87LxEGdh6kxGnuHVVp3Icrk6N3SV9c
         pscOCV0CBvVa9ZnrqZ69YLTIW7sqSTPqJyibJPp5TZBjCsNbSz7N3AiP8Lt4+dZoMFaw
         ukzRQJwZqf2/5jn1Uz6yjBm94qLRbVyjqaK8KIf7F7VKFu281slSrDidiHd1n1pOCJBG
         pQQ6pqHF0V/7N88KBNvZDBNYvVS+P0apO4h9ZcP4yHU0yv/+yhtf5iVu56I4KZRNTHk5
         JPdA==
X-Gm-Message-State: AOAM531WXsdQdygtkfli4Q5tElFqxkeGDyRVaJBBXKW5KdvFylW6QYse
        3XHxyAeN/AQ+V7cd+aM4bLy/Yh0X3cb0jenn
X-Google-Smtp-Source: ABdhPJzy428TqLTJygn4lVfs8h0k5EjkCOEehN/2TL0lPzZOQ51LjCdBKVCsMzJiD0tcaZliUmTaow==
X-Received: by 2002:a63:6701:: with SMTP id b1mr2339475pgc.59.1603194250036;
        Tue, 20 Oct 2020 04:44:10 -0700 (PDT)
Received: from localhost.localdomain ([106.215.55.55])
        by smtp.gmail.com with ESMTPSA id y22sm2204615pfr.62.2020.10.20.04.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 04:44:09 -0700 (PDT)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, congdanhqx@gmail.com, me@ttaylorr.com,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v3 3/5][Outreachy] t7102,t7201: remove whitespace after redirect operator
Date:   Tue, 20 Oct 2020 17:13:17 +0530
Message-Id: <20201020114319.18245-4-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20201020114319.18245-1-charvi077@gmail.com>
References: <20201017075455.9660-1-charvi077@gmail.com>
 <20201020114319.18245-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to Documentation/CodingGuidelines, redirect
operator is written with space before, but no space
after them.

Let's remove these whitespaces after redirect operators.

Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t7102-reset.sh | 30 +++++++++++++++---------------
 t/t7201-co.sh    | 10 +++++-----
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 2b4cfb2c83..a8c96bf162 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -70,15 +70,15 @@ check_changes () {
 
 test_expect_success 'reset --hard message' '
 	hex=$(git log -1 --format="%h") &&
-	git reset --hard > .actual &&
-	echo HEAD is now at $hex $(commit_msg) > .expected &&
+	git reset --hard >.actual &&
+	echo HEAD is now at $hex $(commit_msg) >.expected &&
 	test_i18ncmp .expected .actual
 '
 
 test_expect_success 'reset --hard message (ISO8859-1 logoutputencoding)' '
 	hex=$(git log -1 --format="%h") &&
-	git -c "i18n.logOutputEncoding=$test_encoding" reset --hard > .actual &&
-	echo HEAD is now at $hex $(commit_msg $test_encoding) > .expected &&
+	git -c "i18n.logOutputEncoding=$test_encoding" reset --hard >.actual &&
+	echo HEAD is now at $hex $(commit_msg $test_encoding) >.expected &&
 	test_i18ncmp .expected .actual
 '
 
@@ -387,25 +387,25 @@ test_expect_success '--hard reset to ORIG_HEAD should clear a fast-forward merge
 '
 
 test_expect_success 'test --mixed <paths>' '
-	echo 1 > file1 &&
-	echo 2 > file2 &&
+	echo 1 >file1 &&
+	echo 2 >file2 &&
 	git add file1 file2 &&
 	test_tick &&
 	git commit -m files &&
 	before1=$(git rev-parse --short HEAD:file1) &&
 	before2=$(git rev-parse --short HEAD:file2) &&
 	git rm file2 &&
-	echo 3 > file3 &&
-	echo 4 > file4 &&
-	echo 5 > file1 &&
+	echo 3 >file3 &&
+	echo 4 >file4 &&
+	echo 5 >file1 &&
 	after1=$(git rev-parse --short $(git hash-object file1)) &&
 	after4=$(git rev-parse --short $(git hash-object file4)) &&
 	git add file1 file3 file4 &&
 	git reset HEAD -- file1 file2 file3 &&
 	test_must_fail git diff --quiet &&
-	git diff > output &&
+	git diff >output &&
 
-	cat > expect <<-EOF &&
+	cat >expect <<-EOF &&
 	diff --git a/file1 b/file1
 	index $before1..$after1 100644
 	--- a/file1
@@ -423,9 +423,9 @@ test_expect_success 'test --mixed <paths>' '
 	EOF
 
 	test_cmp expect output &&
-	git diff --cached > output &&
+	git diff --cached >output &&
 
-	cat > cached_expect <<-EOF &&
+	cat >cached_expect <<-EOF &&
 	diff --git a/file4 b/file4
 	new file mode 100644
 	index 0000000..$after4
@@ -460,14 +460,14 @@ test_expect_success 'resetting an unmodified path is a no-op' '
 	git diff-index --cached --exit-code HEAD
 '
 
-cat > expect << EOF
+cat >expect << EOF
 Unstaged changes after reset:
 M	file2
 EOF
 
 test_expect_success '--mixed refreshes the index' '
 	echo 123 >> file2 &&
-	git reset --mixed HEAD > output &&
+	git reset --mixed HEAD >output &&
 	test_i18ncmp expect output
 '
 
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index b527f8009c..74553f991b 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -33,7 +33,7 @@ fill () {
 
 
 test_expect_success setup '
-	fill x y z > same &&
+	fill x y z >same &&
 	fill 1 2 3 4 5 6 7 8 >one &&
 	fill a b c d e >two &&
 	git add same one two &&
@@ -55,7 +55,7 @@ test_expect_success setup '
 
 	git checkout -b simple master &&
 	rm -f one &&
-	fill a c e > two &&
+	fill a c e >two &&
 	git commit -a -m "Simple D one, M two" &&
 
 	git checkout master
@@ -95,7 +95,7 @@ test_expect_success 'checkout -m with dirty tree' '
 	git clean -f &&
 
 	fill 0 1 2 3 4 5 6 7 8 >one &&
-	git checkout -m side > messages &&
+	git checkout -m side >messages &&
 
 	test "$(git symbolic-ref HEAD)" = "refs/heads/side" &&
 
@@ -159,7 +159,7 @@ test_expect_success 'checkout -m with merge conflict' '
 test_expect_success 'format of merge conflict from checkout -m' '
 	git checkout -f master && git clean -f &&
 
-	fill b d > two &&
+	fill b d >two &&
 	git checkout -m simple &&
 
 	git ls-files >current &&
@@ -182,7 +182,7 @@ test_expect_success 'format of merge conflict from checkout -m' '
 test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
 	git checkout -f master && git reset --hard && git clean -f &&
 
-	fill b d > two &&
+	fill b d >two &&
 	git checkout --merge --conflict=diff3 simple &&
 
 	cat <<-EOF >expect &&
-- 
2.29.0.rc1

