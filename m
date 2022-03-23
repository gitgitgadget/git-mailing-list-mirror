Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C187C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344747AbiCWUe2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344722AbiCWUeI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:34:08 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD078CCE7
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:36 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u16so3787840wru.4
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IInV0DCfR20V0uhj7jK4FrNGN0bgHw271izaXY3pb44=;
        b=gyU7VGLl6PmhOKnuYFILnqofRYP0oYQzoBZlwZl1Gdk9jdbeWM59sJUcfb5iISnFME
         vZOU4tZXQvTmrpqw+eH9VDTUEWTaitZkNt92O3eKqt8FoLhAmjwoSA/Zt7gS35UTU1f4
         lxQjUAfG3FP0qLlDIYDrYsw9L0LwXt3f/z93RAesoCW+pR3aP0HXyEkSusOlonZPPpbH
         PdHRx16a2V1AkHgqvVyz5panne2eYYBY/+JHIijRF6XQvKwiBjxdo2wD33QjrpLCSNeK
         8LzxqMjfJ4Gmj6LKh5UMthpTvdRADmxKRJ3O4Dy9BprVuV1mo/hjDjktfoh3X2gKDiD0
         e7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IInV0DCfR20V0uhj7jK4FrNGN0bgHw271izaXY3pb44=;
        b=yqEyrdhcZTGIzktLRYT8dNXffMs4I833tyCjkelNdAZ6lOIW4zXD3+j9+9Ni/tGQVT
         TryXDroYq4UybIuM0bWvOWgCrKf1LQdkH88Nw8AAT4qhXxllp7WpKAlzYtTGXjQOLJgy
         rif6nl4xQBevkwibRC1QSj2Dbnvgi/EHVCUbSv7ODcKVn3N+9um7ZN2bd1TU8S8ryzQg
         xzRchuJD+n4kS6GPePqEIdTYQXDbOFUqRUS1qkefDryomt8uYLCAUJHxAZmsXfhZZ/7i
         0ynqKLd0WRPUWHEd6kEkF6DcPjw58OeeFJRr6mNjOlj+3TS4Zcsn/nKQo29dEttMxb40
         Ccow==
X-Gm-Message-State: AOAM533ApT5PUHDuJgjk2Ewtagv++Oixg8yMpnVwr3CZKdMPHMTxztcL
        GTtRHEzXfX2bM+IJRuTU2CMnyp7CKNGL3w==
X-Google-Smtp-Source: ABdhPJyGAJR4fueT6Q2NtqFAJu1CGj76fq7qHiya4yJ0vxTt3oaro+OanOWd3mitpAj0CWRyxH2luw==
X-Received: by 2002:adf:e885:0:b0:203:f46f:e19f with SMTP id d5-20020adfe885000000b00203f46fe19fmr1550730wrm.449.1648067554691;
        Wed, 23 Mar 2022 13:32:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6dac000000b00204119d37d0sm849843wrs.26.2022.03.23.13.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:32:34 -0700 (PDT)
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
Subject: [PATCH v2 09/27] stash: always have the owner of "stash_info" free it
Date:   Wed, 23 Mar 2022 21:31:59 +0100
Message-Id: <patch-v2-09.27-88289157533-20220323T203149Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1452.ga7cfc89151f
In-Reply-To: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com> <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the initialization of the "revision" member of "struct
stash_info" to be initialized vi a macro, and more importantly that
that initializing function be tasked to free it, usually via "goto
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
index 8a8093c5eea..4c8c8af8a09 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -117,6 +117,10 @@ struct stash_info {
 	int has_u;
 };
 
+#define STASH_INFO_INIT { \
+	.revision = STRBUF_INIT, \
+}
+
 static void free_stash_info(struct stash_info *info)
 {
 	strbuf_release(&info->revision);
@@ -158,10 +162,8 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
 	if (argc == 1)
 		commit = argv[0];
 
-	strbuf_init(&info->revision, 0);
 	if (!commit) {
 		if (!ref_exists(ref_stash)) {
-			free_stash_info(info);
 			fprintf_ln(stderr, _("No stash entries found."));
 			return -1;
 		}
@@ -175,11 +177,8 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
 
 	revision = info->revision.buf;
 
-	if (get_oid(revision, &info->w_commit)) {
-		error(_("%s is not a valid reference"), revision);
-		free_stash_info(info);
-		return -1;
-	}
+	if (get_oid(revision, &info->w_commit))
+		return error(_("%s is not a valid reference"), revision);
 
 	assert_stash_like(info, revision);
 
@@ -198,7 +197,7 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
 		info->is_stash_ref = !strcmp(expanded_ref, ref_stash);
 		break;
 	default: /* Invalid or ambiguous */
-		free_stash_info(info);
+		break;
 	}
 
 	free(expanded_ref);
@@ -599,10 +598,10 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 
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
@@ -614,9 +613,10 @@ static int apply_stash(int argc, const char **argv, const char *prefix)
 			     git_stash_apply_usage, 0);
 
 	if (get_stash_info(&info, argc, argv))
-		return -1;
+		goto cleanup;
 
 	ret = do_apply_stash(prefix, &info, index, quiet);
+cleanup:
 	free_stash_info(&info);
 	return ret;
 }
@@ -663,9 +663,9 @@ static void assert_stash_ref(struct stash_info *info)
 
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
@@ -675,21 +675,22 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
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
@@ -701,7 +702,7 @@ static int pop_stash(int argc, const char **argv, const char *prefix)
 			     git_stash_pop_usage, 0);
 
 	if (get_stash_info(&info, argc, argv))
-		return -1;
+		goto cleanup;
 
 	assert_stash_ref(&info);
 	if ((ret = do_apply_stash(prefix, &info, index, quiet)))
@@ -710,15 +711,16 @@ static int pop_stash(int argc, const char **argv, const char *prefix)
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
@@ -735,7 +737,7 @@ static int branch_stash(int argc, const char **argv, const char *prefix)
 	branch = argv[0];
 
 	if (get_stash_info(&info, argc - 1, argv + 1))
-		return -1;
+		goto cleanup;
 
 	cp.git_cmd = 1;
 	strvec_pushl(&cp.args, "checkout", "-b", NULL);
@@ -747,8 +749,8 @@ static int branch_stash(int argc, const char **argv, const char *prefix)
 	if (!ret && info.is_stash_ref)
 		ret = do_drop_stash(&info, 0);
 
+cleanup:
 	free_stash_info(&info);
-
 	return ret;
 }
 
@@ -826,8 +828,8 @@ static void diff_include_untracked(const struct stash_info *info, struct diff_op
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
@@ -862,10 +864,8 @@ static int show_stash(int argc, const char **argv, const char *prefix)
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
@@ -879,8 +879,8 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 			rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
 
 		if (!show_stat && !show_patch) {
-			free_stash_info(&info);
-			return 0;
+			ret = 0;
+			goto cleanup;
 		}
 	}
 
@@ -913,8 +913,11 @@ static int show_stash(int argc, const char **argv, const char *prefix)
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
@@ -1410,9 +1413,9 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 
 static int create_stash(int argc, const char **argv, const char *prefix)
 {
-	int ret = 0;
+	int ret;
 	struct strbuf stash_msg_buf = STRBUF_INIT;
-	struct stash_info info;
+	struct stash_info info = STASH_INFO_INIT;
 	struct pathspec ps;
 
 	/* Starting with argv[1], since argv[0] is "create" */
@@ -1427,6 +1430,7 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 	if (!ret)
 		printf_ln("%s", oid_to_hex(&info.w_commit));
 
+	free_stash_info(&info);
 	strbuf_release(&stash_msg_buf);
 	return ret;
 }
@@ -1435,7 +1439,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 			 int keep_index, int patch_mode, int include_untracked, int only_staged)
 {
 	int ret = 0;
-	struct stash_info info;
+	struct stash_info info = STASH_INFO_INIT;
 	struct strbuf patch = STRBUF_INIT;
 	struct strbuf stash_msg_buf = STRBUF_INIT;
 	struct strbuf untracked_files = STRBUF_INIT;
-- 
2.35.1.1452.ga7cfc89151f

