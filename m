Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC37C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 01:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352300AbiCaBOZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352254AbiCaBOD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 21:14:03 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005B36623D
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:15 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r7so13310367wmq.2
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jLdYEl8vjkJnCXLyA0+xnaKukqreTwNy3fRcp8Jycjw=;
        b=CFI8YT3WjKihpTdKxKUmiZNGabSYRzhG6rU+QMLxIFsI3IToZSnS6YtgEZZtG+abzd
         re5KfA+DYWVocNGb5fwjRdZU68ftq23oNV0md7aL2BWDw2x+qZ6uK54twfdO0A5zBBPY
         5C0TqyOYRL+1wJZrGFX3VCzqOtERnzCsoznRm9X5jr/4501TCpQoT+11Bnymnqj7SP34
         Ex06CtWungJgv+UfgOQmD7jUR/febRqIuns1dsuMK7mmU68F5Kx0rpWel0TFC2UBVVLo
         U4LINZNw4ZinyQPASHlIJhb0g7FU7mTJ3YxS3dtUXfJtMTuJa7ExkgqC/JjWmYr/8EU+
         ofvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jLdYEl8vjkJnCXLyA0+xnaKukqreTwNy3fRcp8Jycjw=;
        b=EZdl+FJpHv4ZBgk7FX3z8NcsfHK7hywwMNFbJomYZKN1ituRLWK2dmdR1fIVZphfmE
         xSp3RtzLIVOecNkO58mn9W6R4w20ogIDKZf8yj9C0qJ7D2UEJnMmr6fO0uEU1HefZUy1
         klFLl0po4hI7iEpQL85KbgL/2uU7GwNb/qi68m9h9NJ5x5be4/D3xzJg763yzcxww8MK
         kOREVCtDSJlKXtLu4Ow+Z27pr560VdTiz+2w3UocoynFnG42vl+T7fIixW33IZIWbil1
         p7ca9Aq7XcMJLQYnfd338tAeB4bj4Fyc6Vc2/WVpI4kyDAkVXw5ZEOMnikrby+4AnDe4
         lWZQ==
X-Gm-Message-State: AOAM532ACTs/fxr4c2+1CZJECYs5L28aX0SAourLldyR54Obp8ADMeKg
        uaYKS+a9iJjArO8R7XveDEEntoOOL/MyRQ==
X-Google-Smtp-Source: ABdhPJwgqAM7M9Kpn98QmBGO3//BPXSZCOf/HDl6XKT9MEbFWaRXkm4iWzyignIfYtC8M7eVz+DM9g==
X-Received: by 2002:a05:600c:364f:b0:38c:c9f9:f867 with SMTP id y15-20020a05600c364f00b0038cc9f9f867mr2388474wmq.155.1648689134167;
        Wed, 30 Mar 2022 18:12:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c26cb00b0037ff53511f2sm5789218wmv.31.2022.03.30.18.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:12:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 10/27] stash: always have the owner of "stash_info" free it
Date:   Thu, 31 Mar 2022 03:11:15 +0200
Message-Id: <patch-v4-10.27-145a0f74b6a-20220331T005325Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1557.g4e3e9cdb5e0
In-Reply-To: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com> <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the initialization of the "revision" member of "struct
stash_info" to be initialized vi a macro, and more importantly that
that initializing function be tasked to free it, usually via a "goto
cleanup" pattern.

Despite the "revision" name (and the topic of the series containing
this commit) the "stash info" has nothing to do with the "struct
rev_info". I'm making this change because in the subsequent commit
when we do want to free the "struct rev_info" via a "goto cleanup"
pattern we'd otherwise free() uninitialized memory in some cases, as
we only strbuf_init() the string in get_stash_info().

So while it's the smallest possible change, let's convert all users of
this pattern in the file while we're at it.

A good follow-up to this change would be to change all the "ret = -1;
goto done;" in this file to instead use a "goto cleanup", and
initialize "int ret = -1" at the start of the relevant functions. That
would allow us to drop a lot of needless brace verbosity on two-line
"if" statements, but let's leave that alone for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/stash.c | 70 ++++++++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 33 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index ad74624c2f7..891572d807c 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -116,6 +116,10 @@ struct stash_info {
 	int has_u;
 };
 
+#define STASH_INFO_INIT { \
+	.revision = STRBUF_INIT, \
+}
+
 static void free_stash_info(struct stash_info *info)
 {
 	strbuf_release(&info->revision);
@@ -157,10 +161,8 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
 	if (argc == 1)
 		commit = argv[0];
 
-	strbuf_init(&info->revision, 0);
 	if (!commit) {
 		if (!ref_exists(ref_stash)) {
-			free_stash_info(info);
 			fprintf_ln(stderr, _("No stash entries found."));
 			return -1;
 		}
@@ -174,11 +176,8 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
 
 	revision = info->revision.buf;
 
-	if (get_oid(revision, &info->w_commit)) {
-		error(_("%s is not a valid reference"), revision);
-		free_stash_info(info);
-		return -1;
-	}
+	if (get_oid(revision, &info->w_commit))
+		return error(_("%s is not a valid reference"), revision);
 
 	assert_stash_like(info, revision);
 
@@ -197,7 +196,7 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
 		info->is_stash_ref = !strcmp(expanded_ref, ref_stash);
 		break;
 	default: /* Invalid or ambiguous */
-		free_stash_info(info);
+		break;
 	}
 
 	free(expanded_ref);
@@ -598,10 +597,10 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 
 static int apply_stash(int argc, const char **argv, const char *prefix)
 {
-	int ret;
+	int ret = -1;
 	int quiet = 0;
 	int index = 0;
-	struct stash_info info;
+	struct stash_info info = STASH_INFO_INIT;
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
 		OPT_BOOL(0, "index", &index,
@@ -613,9 +612,10 @@ static int apply_stash(int argc, const char **argv, const char *prefix)
 			     git_stash_apply_usage, 0);
 
 	if (get_stash_info(&info, argc, argv))
-		return -1;
+		goto cleanup;
 
 	ret = do_apply_stash(prefix, &info, index, quiet);
+cleanup:
 	free_stash_info(&info);
 	return ret;
 }
@@ -662,9 +662,9 @@ static void assert_stash_ref(struct stash_info *info)
 
 static int drop_stash(int argc, const char **argv, const char *prefix)
 {
-	int ret;
+	int ret = -1;
 	int quiet = 0;
-	struct stash_info info;
+	struct stash_info info = STASH_INFO_INIT;
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
 		OPT_END()
@@ -674,21 +674,22 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
 			     git_stash_drop_usage, 0);
 
 	if (get_stash_info(&info, argc, argv))
-		return -1;
+		goto cleanup;
 
 	assert_stash_ref(&info);
 
 	ret = do_drop_stash(&info, quiet);
+cleanup:
 	free_stash_info(&info);
 	return ret;
 }
 
 static int pop_stash(int argc, const char **argv, const char *prefix)
 {
-	int ret;
+	int ret = -1;
 	int index = 0;
 	int quiet = 0;
-	struct stash_info info;
+	struct stash_info info = STASH_INFO_INIT;
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
 		OPT_BOOL(0, "index", &index,
@@ -700,7 +701,7 @@ static int pop_stash(int argc, const char **argv, const char *prefix)
 			     git_stash_pop_usage, 0);
 
 	if (get_stash_info(&info, argc, argv))
-		return -1;
+		goto cleanup;
 
 	assert_stash_ref(&info);
 	if ((ret = do_apply_stash(prefix, &info, index, quiet)))
@@ -709,15 +710,16 @@ static int pop_stash(int argc, const char **argv, const char *prefix)
 	else
 		ret = do_drop_stash(&info, quiet);
 
+cleanup:
 	free_stash_info(&info);
 	return ret;
 }
 
 static int branch_stash(int argc, const char **argv, const char *prefix)
 {
-	int ret;
+	int ret = -1;
 	const char *branch = NULL;
-	struct stash_info info;
+	struct stash_info info = STASH_INFO_INIT;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct option options[] = {
 		OPT_END()
@@ -734,7 +736,7 @@ static int branch_stash(int argc, const char **argv, const char *prefix)
 	branch = argv[0];
 
 	if (get_stash_info(&info, argc - 1, argv + 1))
-		return -1;
+		goto cleanup;
 
 	cp.git_cmd = 1;
 	strvec_pushl(&cp.args, "checkout", "-b", NULL);
@@ -746,8 +748,8 @@ static int branch_stash(int argc, const char **argv, const char *prefix)
 	if (!ret && info.is_stash_ref)
 		ret = do_drop_stash(&info, 0);
 
+cleanup:
 	free_stash_info(&info);
-
 	return ret;
 }
 
@@ -825,8 +827,8 @@ static void diff_include_untracked(const struct stash_info *info, struct diff_op
 static int show_stash(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	int ret = 0;
-	struct stash_info info;
+	int ret = -1;
+	struct stash_info info = STASH_INFO_INIT;
 	struct rev_info rev;
 	struct strvec stash_args = STRVEC_INIT;
 	struct strvec revision_args = STRVEC_INIT;
@@ -861,10 +863,8 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 			strvec_push(&revision_args, argv[i]);
 	}
 
-	ret = get_stash_info(&info, stash_args.nr, stash_args.v);
-	strvec_clear(&stash_args);
-	if (ret)
-		return -1;
+	if (get_stash_info(&info, stash_args.nr, stash_args.v))
+		goto cleanup;
 
 	/*
 	 * The config settings are applied only if there are not passed
@@ -878,8 +878,8 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 			rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
 
 		if (!show_stat && !show_patch) {
-			free_stash_info(&info);
-			return 0;
+			ret = 0;
+			goto cleanup;
 		}
 	}
 
@@ -912,8 +912,11 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 	}
 	log_tree_diff_flush(&rev);
 
+	ret = diff_result_code(&rev.diffopt, 0);;
+cleanup:
+	strvec_clear(&stash_args);
 	free_stash_info(&info);
-	return diff_result_code(&rev.diffopt, 0);
+	return ret;
 }
 
 static int do_store_stash(const struct object_id *w_commit, const char *stash_msg,
@@ -1409,9 +1412,9 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 
 static int create_stash(int argc, const char **argv, const char *prefix)
 {
-	int ret = 0;
+	int ret;
 	struct strbuf stash_msg_buf = STRBUF_INIT;
-	struct stash_info info;
+	struct stash_info info = STASH_INFO_INIT;
 	struct pathspec ps;
 
 	/* Starting with argv[1], since argv[0] is "create" */
@@ -1426,6 +1429,7 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 	if (!ret)
 		printf_ln("%s", oid_to_hex(&info.w_commit));
 
+	free_stash_info(&info);
 	strbuf_release(&stash_msg_buf);
 	return ret;
 }
@@ -1434,7 +1438,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 			 int keep_index, int patch_mode, int include_untracked, int only_staged)
 {
 	int ret = 0;
-	struct stash_info info;
+	struct stash_info info = STASH_INFO_INIT;
 	struct strbuf patch = STRBUF_INIT;
 	struct strbuf stash_msg_buf = STRBUF_INIT;
 	struct strbuf untracked_files = STRBUF_INIT;
-- 
2.35.1.1557.g4e3e9cdb5e0

