Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F43BC432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 06:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED0C260FD8
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 06:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244124AbhH0GCU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 02:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhH0GCT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 02:02:19 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09209C061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 23:01:31 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u16so8635494wrn.5
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 23:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8WW8hYtYUVA8iKnvz/iKM31nEmMr4hxuKiswvHyo8V0=;
        b=A3c+H9VhuDW+KP2W6re1CdoojQ34Wok4iLKdUStTlvMXu/3QEARwuoyZlAa9wJHdnU
         4NC4o1wUbkFGVh0rMzs+4QdUj6RNGiwZber2jln0dJfO7vKLi0TKydDCY7sCI4OyVVQS
         2nwzD6h5wXSPWiWaMadtoRZDrYHNWHQ9FDj7Dhpi7HtfCIP2T+JO8t8wDqRwULw8oXB9
         Wizd5Rskb93YlgzqVWcn+DHtrLra+mVpoMYYFIx+VNP012rpHNn4jwzRAjNMpbfVf4Iz
         Ebc7ndVb9P1IQLDxkakgKlSG89oqlPE54IHzFo0H0hqBWbiU3RH1TDLjjQQQ+e7UZoAX
         pmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8WW8hYtYUVA8iKnvz/iKM31nEmMr4hxuKiswvHyo8V0=;
        b=a678vdI12C7AuhScrsRO6/RSYgrImyVHWTae5nQoYc300vmNcdzr8+fuLP6X56cBbf
         7dJEmdZaeOP5HrDdJLz2Fchp9MqKCNR8e/HCXxLYyB7ihEohzsAbqVo90zf+Mr4CF8jQ
         bnJzLsyFGZarPx6xOPzmVqG6RxoHS5DZH+5DGR5IS2YsyCRSoh95NTHxexFY0jU5V78l
         Gnch8XCopXbeVDvAUwH0jLNc99uJ9V05l2dixRYwyD9iYhnMB6mU5+mzD2hJu+ZNjjj1
         OhqGSkAhZWOMewWg1tWfYxOPfHVgns73TqRyy5lvB4w7WbXAIvtHuSUs3pj1ezagutSQ
         uP4w==
X-Gm-Message-State: AOAM5324ykMDy9zp04y4iQN22roMAzdCzDUGnJJehDqUtL3M2wEj86yi
        qLKPQh+31zQeiUUO/qz9B1gesywvH4HzbQ==
X-Google-Smtp-Source: ABdhPJxfS0bZZyJ9vyzTxHNbwy3MEFmcpWth5mAPfv//uSrYdT0cHdtK+4uX1nhS6C0bbOWS+um2XA==
X-Received: by 2002:adf:9151:: with SMTP id j75mr8243311wrj.68.1630044089073;
        Thu, 26 Aug 2021 23:01:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y15sm11909520wmi.18.2021.08.26.23.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 23:01:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH] reftable: fixup for broken __FUNCTION__ use
Date:   Fri, 27 Aug 2021 08:01:21 +0200
Message-Id: <patch-1.1-f7d9c8af0c-20210827T055608Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.736.g68690aaec9a
In-Reply-To: <xmqqwno7bgeo.fsf@gitster.g>
References: <xmqqwno7bgeo.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The use of the __FUNCTION__ macro is non-standard, in this case all
we're doing with it is generating a prettier unique filename based on
the name of the function that makes it, presumably to make ad-hoc
debugging easier.

For mkdtemp() and mkstemp() we don't need to pass anything like this
in, since the "XXXXXX" part of the template will ensure that we get a
unique filename, but to make finding what function created what
tempfile easy let's just use __LINE__ here, it's not *as easy*, but at
least this one uses standard behavior.

This can be tested under DEVOPTS=pedantic, i.e. before this change
we'd emit errors like:

    reftable/stack_test.c: In function ‘test_read_file’:
    reftable/stack_test.c:67:30: error: ISO C does not support ‘__FUNCTION__’ predefined identifier [-Werror=pedantic]
      char *fn = get_tmp_template(__FUNCTION__);

The current tip of "seen" is broken as a result, see
https://github.com/git/git/runs/3439941236

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Thu, Aug 26 2021, Junio C Hamano wrote:

> This step does not compile under -pedantic because it assumes that
> __FUNCTION__ is available unconditionally (unlike trace.h where it
> allows __FUNCTION__ to be used iff compiler supports it).
>
> Here is a workaround that needs to be split and squashed into the
> steps that introduce these test source files.
>
> Subject: [PATCH] SQUASH???
>  https://github.com/git/git/runs/3439941236?check_suite_focus=true#step:5:700

First, thanks for the re-re-arrangement of the errno+reftable
topics. It looks like the "seen" integration is good, except for this
issue under -pedantic.

I can confirm your fix works, for what it's worth I came up with this
alternate approach that I was about to send before I saw your proposed
fixup.

It's smaller because it punts on the whole notion of adding the
function name to the filename, as argued above I think __LINE__ should
be sufficient here (and is probably already overkill). The only reason
to add __FUNCTION__ or __LINE__ to the filename is presumably for
one-off ad-hoc debugging.

I see you pushed out seen a few minutes ago as bce8679d69 with your
proposed squash. Let's leave that in and not have the churn of
re-replacing that fixup. I'm submitting this more for Han-Wen's
consideration at this point.

 reftable/stack_test.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 890a5c0199..f6b542b259 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -46,25 +46,26 @@ static int count_dir_entries(const char *dirname)
 	return len;
 }
 
-static char *get_tmp_template(const char *prefix)
+static char *get_tmp_template(const int line)
 {
 	const char *tmp = getenv("TMPDIR");
 	static char template[1024];
-	snprintf(template, sizeof(template) - 1, "%s/%s.XXXXXX",
-		 tmp ? tmp : "/tmp", prefix);
+	snprintf(template, sizeof(template) - 1, "%s/stack-test.c-%d.XXXXXX",
+		 tmp ? tmp : "/tmp", line);
+	fprintf(stderr, "have template %s\n", template);
 	return template;
 }
 
-static char *get_tmp_dir(const char *prefix)
+static char *get_tmp_dir(const int line)
 {
-	char *dir = get_tmp_template(prefix);
+	char *dir = get_tmp_template(line);
 	EXPECT(mkdtemp(dir));
 	return dir;
 }
 
 static void test_read_file(void)
 {
-	char *fn = get_tmp_template(__FUNCTION__);
+	char *fn = get_tmp_template(__LINE__);
 	int fd = mkstemp(fn);
 	char out[1024] = "line1\n\nline2\nline3";
 	int n, err;
@@ -133,7 +134,7 @@ static int write_test_log(struct reftable_writer *wr, void *arg)
 
 static void test_reftable_stack_add_one(void)
 {
-	char *dir = get_tmp_dir(__FUNCTION__);
+	char *dir = get_tmp_dir(__LINE__);
 
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st = NULL;
@@ -174,7 +175,7 @@ static void test_reftable_stack_uptodate(void)
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st1 = NULL;
 	struct reftable_stack *st2 = NULL;
-	char *dir = get_tmp_dir(__FUNCTION__);
+	char *dir = get_tmp_dir(__LINE__);
 
 	int err;
 	struct reftable_ref_record ref1 = {
@@ -218,7 +219,7 @@ static void test_reftable_stack_uptodate(void)
 
 static void test_reftable_stack_transaction_api(void)
 {
-	char *dir = get_tmp_dir(__FUNCTION__);
+	char *dir = get_tmp_dir(__LINE__);
 
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st = NULL;
@@ -265,7 +266,7 @@ static void test_reftable_stack_validate_refname(void)
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st = NULL;
 	int err;
-	char *dir = get_tmp_dir(__FUNCTION__);
+	char *dir = get_tmp_dir(__LINE__);
 
 	int i;
 	struct reftable_ref_record ref = {
@@ -305,7 +306,7 @@ static int write_error(struct reftable_writer *wr, void *arg)
 
 static void test_reftable_stack_update_index_check(void)
 {
-	char *dir = get_tmp_dir(__FUNCTION__);
+	char *dir = get_tmp_dir(__LINE__);
 
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st = NULL;
@@ -337,7 +338,7 @@ static void test_reftable_stack_update_index_check(void)
 
 static void test_reftable_stack_lock_failure(void)
 {
-	char *dir = get_tmp_dir(__FUNCTION__);
+	char *dir = get_tmp_dir(__LINE__);
 
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st = NULL;
@@ -362,7 +363,7 @@ static void test_reftable_stack_add(void)
 		.exact_log_message = 1,
 	};
 	struct reftable_stack *st = NULL;
-	char *dir = get_tmp_dir(__FUNCTION__);
+	char *dir = get_tmp_dir(__LINE__);
 
 	struct reftable_ref_record refs[2] = { { NULL } };
 	struct reftable_log_record logs[2] = { { NULL } };
@@ -443,7 +444,7 @@ static void test_reftable_stack_log_normalize(void)
 		0,
 	};
 	struct reftable_stack *st = NULL;
-	char *dir = get_tmp_dir(__FUNCTION__);
+	char *dir = get_tmp_dir(__LINE__);
 
 
 	uint8_t h1[GIT_SHA1_RAWSZ] = { 0x01 }, h2[GIT_SHA1_RAWSZ] = { 0x02 };
@@ -495,7 +496,7 @@ static void test_reftable_stack_log_normalize(void)
 static void test_reftable_stack_tombstone(void)
 {
 	int i = 0;
-	char *dir = get_tmp_dir(__FUNCTION__);
+	char *dir = get_tmp_dir(__LINE__);
 
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st = NULL;
@@ -577,7 +578,7 @@ static void test_reftable_stack_tombstone(void)
 
 static void test_reftable_stack_hash_id(void)
 {
-	char *dir = get_tmp_dir(__FUNCTION__);
+	char *dir = get_tmp_dir(__LINE__);
 
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st = NULL;
@@ -685,7 +686,7 @@ static void test_suggest_compaction_segment_nothing(void)
 
 static void test_reflog_expire(void)
 {
-	char *dir = get_tmp_dir(__FUNCTION__);
+	char *dir = get_tmp_dir(__LINE__);
 
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st = NULL;
@@ -766,7 +767,7 @@ static void test_empty_add(void)
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st = NULL;
 	int err;
-	char *dir = get_tmp_dir(__FUNCTION__);
+	char *dir = get_tmp_dir(__LINE__);
 
 	struct reftable_stack *st2 = NULL;
 
@@ -788,7 +789,7 @@ static void test_reftable_stack_auto_compaction(void)
 {
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st = NULL;
-	char *dir = get_tmp_dir(__FUNCTION__);
+	char *dir = get_tmp_dir(__LINE__);
 
 	int err, i;
 	int N = 100;
@@ -823,7 +824,7 @@ static void test_reftable_stack_compaction_concurrent(void)
 {
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st1 = NULL, *st2 = NULL;
-	char *dir = get_tmp_dir(__FUNCTION__);
+	char *dir = get_tmp_dir(__LINE__);
 
 	int err, i;
 	int N = 3;
@@ -873,7 +874,7 @@ static void test_reftable_stack_compaction_concurrent_clean(void)
 {
 	struct reftable_write_options cfg = { 0 };
 	struct reftable_stack *st1 = NULL, *st2 = NULL, *st3 = NULL;
-	char *dir = get_tmp_dir(__FUNCTION__);
+	char *dir = get_tmp_dir(__LINE__);
 
 	int err, i;
 	int N = 3;
-- 
2.33.0.736.g68690aaec9a

