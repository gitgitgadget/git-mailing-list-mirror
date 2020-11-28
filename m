Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53343C63798
	for <git@archiver.kernel.org>; Sat, 28 Nov 2020 22:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17777221FD
	for <git@archiver.kernel.org>; Sat, 28 Nov 2020 22:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieskAgH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389053AbgK1Vtt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Nov 2020 16:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732770AbgK1TDG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Nov 2020 14:03:06 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A189AC09424C
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 22:44:46 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id f190so5277513wme.1
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 22:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b+pnXY7dabSgWLV5TuoCsS06Yfyzz5HKpiLYfb18E88=;
        b=ieskAgH1hiNS5uLmYb+hEyy2iFXLnSTM+a70hpfnlNO/r63uB+RiLVI/O3g17IMpCs
         vgZ8DN5TBp7YtkQ6bWlFzigRNclG8Xt7Kvtyfks9dBU8/Ml4eSV2zVUZ4R9Nn3JlmL+D
         gHIqWKfFcjhBssriMgBAz3euqYfxMhBXSOy2XJLnt6/9O9NwfoAX+nv4C51Bb3jQRPyI
         jEaK2P1W7WB+2Ae7lJSEqTi8Sn3EwJi/AFLMTHNzMeII0vcF1eWRfFGgn6KOrfonbln3
         7ot4lUuN8j+B8e/xbfYCH3qOW2Qy9lt/er4T8Tc9rvl3r3hfdIRvdT4NJ4goOcY4CxIK
         jc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=b+pnXY7dabSgWLV5TuoCsS06Yfyzz5HKpiLYfb18E88=;
        b=T9OdTH5RciKc6VgL7YRhVfPQ5ssX8LaN7Gs2pf8JksWSdfLycHR0vrlWRkl6aG9Dvr
         vbK5W/3Up4YlIxQeLBJ3djQRqkSkrS947JS7NoBBlk84zqNRSEu/R2JM6rfBKwlo6m7/
         yNMk9E+o3CG7dEdzZwzcM/cSoQLJAoCqvIX76xLr8n3Rj8NM976R+RX3Qi9Z6O8zLIfT
         bc31VQ7WIfC3KNG572vEuGkXZisdN5ATbJRC6nnYrD+70rmLGYCEQcZTDxZo8w5n9if2
         x8kijcW+EXrGrSknjm3FXjYz0joIVVig7Wv/KGI1xYFQAC569OQj/XnDyPa3pdxx9J/j
         zDmQ==
X-Gm-Message-State: AOAM530GGZksL/XZ7+LC6IqoRoGa61KG0hEWOf3FvKSB+cV6OJsBu2ha
        tGUVzgS3P8YTHWGQPL2v95tadLkHM9g=
X-Google-Smtp-Source: ABdhPJy22vhJPHQ8UWo561zZLLmby8Z9Rsnb5wj+aykVXrzzE+iqOF4NG9TKdE3oqxv/XKK7UqPI2g==
X-Received: by 2002:a1c:309:: with SMTP id 9mr12514306wmd.80.1606545885107;
        Fri, 27 Nov 2020 22:44:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d2sm18283197wrn.43.2020.11.27.22.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 22:44:44 -0800 (PST)
Message-Id: <ded8d502d97d3d48dc0e4397b6153f4b06fa319b.1606545878.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.801.git.1606545878.gitgitgadget@gmail.com>
References: <pull.801.git.1606545878.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 28 Nov 2020 06:44:38 +0000
Subject: [PATCH 6/6] fixup! reftable: rest of library
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The stack_test hard-codes `/tmp/`. That is a particular problem on
Windows where the temp directory is never at that location.

Let's not do that, but instead use `TMPDIR` as we do in similar
scenarios in the rest of Git's source code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 reftable/stack_test.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index cf2e32a25c..c9beaf4dbf 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -28,9 +28,19 @@ static void clear_dir(const char *dirname)
 	strbuf_release(&path);
 }
 
+static char *get_tmp_template(const char *prefix)
+{
+	static struct strbuf path = STRBUF_INIT;
+	const char *tmp = getenv("TMPDIR");
+
+	strbuf_reset(&path);
+	strbuf_addf(&path, "%s/%s.XXXXXX", tmp ? tmp : "/tmp", prefix);
+	return path.buf;
+}
+
 static void test_read_file(void)
 {
-	char fn[256] = "/tmp/stack.test_read_file.XXXXXX";
+	char *fn = get_tmp_template("stack.test_read_file");
 	int fd = mkstemp(fn);
 	char out[1024] = "line1\n\nline2\nline3";
 	int n, err;
@@ -99,7 +109,7 @@ static int write_test_log(struct reftable_writer *wr, void *arg)
 
 static void test_reftable_stack_add_one(void)
 {
-	char dir[256] = "/tmp/stack_test.XXXXXX";
+	char *dir = get_tmp_template("stack_test");
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st = NULL;
 	int err;
@@ -132,7 +142,7 @@ static void test_reftable_stack_uptodate(void)
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st1 = NULL;
 	struct reftable_stack *st2 = NULL;
-	char dir[256] = "/tmp/stack_test.XXXXXX";
+	char *dir = get_tmp_template("stack_test");
 	int err;
 	struct reftable_ref_record ref1 = {
 		.refname = "HEAD",
@@ -171,7 +181,7 @@ static void test_reftable_stack_uptodate(void)
 
 static void test_reftable_stack_transaction_api(void)
 {
-	char dir[256] = "/tmp/stack_test.XXXXXX";
+	char *dir = get_tmp_template("stack_test");
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st = NULL;
 	int err;
@@ -216,7 +226,7 @@ static void test_reftable_stack_validate_refname(void)
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st = NULL;
 	int err;
-	char dir[256] = "/tmp/stack_test.XXXXXX";
+	char *dir = get_tmp_template("stack_test");
 	int i;
 	struct reftable_ref_record ref = {
 		.refname = "a/b",
@@ -254,7 +264,7 @@ static int write_error(struct reftable_writer *wr, void *arg)
 
 static void test_reftable_stack_update_index_check(void)
 {
-	char dir[256] = "/tmp/stack_test.XXXXXX";
+	char *dir = get_tmp_template("stack_test");
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st = NULL;
 	int err;
@@ -284,7 +294,7 @@ static void test_reftable_stack_update_index_check(void)
 
 static void test_reftable_stack_lock_failure(void)
 {
-	char dir[256] = "/tmp/stack_test.XXXXXX";
+	char *dir = get_tmp_template("stack_test");
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st = NULL;
 	int err, i;
@@ -309,7 +319,7 @@ static void test_reftable_stack_add(void)
 		.exact_log_message = 1,
 	};
 	struct reftable_stack *st = NULL;
-	char dir[256] = "/tmp/stack_test.XXXXXX";
+	char *dir = get_tmp_template("stack_test");
 	struct reftable_ref_record refs[2] = { { NULL } };
 	struct reftable_log_record logs[2] = { { NULL } };
 	int N = ARRAY_SIZE(refs);
@@ -385,7 +395,7 @@ static void test_reftable_stack_log_normalize(void)
 		0,
 	};
 	struct reftable_stack *st = NULL;
-	char dir[256] = "/tmp/stack_test.XXXXXX";
+	char *dir = get_tmp_template("stack_test");
 
 	uint8_t h1[SHA1_SIZE] = { 0x01 }, h2[SHA1_SIZE] = { 0x02 };
 
@@ -436,7 +446,7 @@ static void test_reftable_stack_log_normalize(void)
 static void test_reftable_stack_tombstone(void)
 {
 	int i = 0;
-	char dir[256] = "/tmp/stack_test.XXXXXX";
+	char *dir = get_tmp_template("stack_test");
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st = NULL;
 	int err;
@@ -511,7 +521,7 @@ static void test_reftable_stack_tombstone(void)
 
 static void test_reftable_stack_hash_id(void)
 {
-	char dir[256] = "/tmp/stack_test.XXXXXX";
+	char *dir = get_tmp_template("stack_test");
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st = NULL;
 	int err;
@@ -621,7 +631,7 @@ static void test_suggest_compaction_segment_nothing(void)
 
 static void test_reflog_expire(void)
 {
-	char dir[256] = "/tmp/stack.test_reflog_expire.XXXXXX";
+	char *dir = get_tmp_template("stack.test_reflog_expire");
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st = NULL;
 	struct reftable_log_record logs[20] = { { NULL } };
@@ -701,7 +711,7 @@ static void test_empty_add(void)
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st = NULL;
 	int err;
-	char dir[256] = "/tmp/stack_test.XXXXXX";
+	char *dir = get_tmp_template("stack_test");
 	struct reftable_stack *st2 = NULL;
 
 	EXPECT(mkdtemp(dir));
@@ -723,7 +733,7 @@ static void test_reftable_stack_auto_compaction(void)
 {
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st = NULL;
-	char dir[256] = "/tmp/stack_test.XXXXXX";
+	char *dir = get_tmp_template("stack_test");
 	int err, i;
 	int N = 100;
 	EXPECT(mkdtemp(dir));
-- 
gitgitgadget
