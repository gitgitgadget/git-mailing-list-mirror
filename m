Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBF2C433FE
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 20:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238586AbiDMUEt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238573AbiDMUEe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 16:04:34 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB017B55C
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:12 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t1so4174540wra.4
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VpbpPQKFIE0wFb0og0ybwM3qs+6CJgaQ9z76sf4JktY=;
        b=YxC+UC0dec0i8Z8Zfu9hm2q0vOPKOu1Mm4bPyXZxLQyFYoMyFWscHVbkKKdQrzjpZE
         fEjyL1eLVjbD/ZHxfaUK7lGlcRJFMUmdaA+9PaQ+gb1ZJTfK/wq/iPt4HP1uaWNOivCd
         aoRUvOIQgC1uYG0PEhdi93bSYKLhNGpwy17pJwmu4cyf4jnrA7yZwEC3a6lvJO/pntcV
         N0Gs4Tb7j5Ff8ChLPnOi4JJMt2WY0uaCDzjeMuPmZm6IuJw8hwuYryZyEpkPlnwKLxAc
         C/M0NnjM2ZdCczlSzr+lTF3WlE0ioDlGCwJGM9EpU2qMh2ekP514upNYD2pIh8kkUpoe
         HclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VpbpPQKFIE0wFb0og0ybwM3qs+6CJgaQ9z76sf4JktY=;
        b=2+0c1Du1ci0eKNizJOgUqHBPHg7QrHVs51/wospHJTHPOS0BO/Cui+pcs2ctEIHh55
         X4GB/+2TuBeliPIUmDf5jgNYNmZukAZm1ySBcLoOBY+Ugd7HKpbqzjbCWieULQsP2SB+
         CAet2VW2NvmfIW6552yQVQm2lbrnOTmeA4bvr9geO1IXySu7AeZELbTsazcOhhx0eqAb
         IeHxk18CL7SCbPCTc5m9MflZEDndNNVh2m1XThWw71/Vb1kezfMsjahlS/iaq6YfcBOe
         VxmM6BkNgNwF4zkGy12oC+5quJILSsQLGFIsejuaNRIfs8hyo5UfJh3/kOem5+DRJDOJ
         5cZQ==
X-Gm-Message-State: AOAM531ELnYFY2GKKDH4Tu1lMtc+aVt5EQ42zLJweGGHr97IT0aXhOqr
        ZeKFTdWx5jhizzmNO3NiEqDpVzaLcwqmUg==
X-Google-Smtp-Source: ABdhPJwRld55Sc1mLyzaVbfRffqrm6SSccf+yPvaKMeoGPX8LLZhDbF/nKMzzJAZDXuQNLGOkC5tzw==
X-Received: by 2002:adf:fb01:0:b0:205:c3e1:7980 with SMTP id c1-20020adffb01000000b00205c3e17980mr327496wrr.639.1649880130265;
        Wed, 13 Apr 2022 13:02:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d6484000000b002057ad822d4sm35220498wri.48.2022.04.13.13.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 13:02:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 10/27] stash: always have the owner of "stash_info" free it
Date:   Wed, 13 Apr 2022 22:01:39 +0200
Message-Id: <patch-v6-10.27-f0c3d274fb5-20220413T195935Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
References: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com> <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
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

So while it's not the smallest possible change, let's convert all
users of this pattern in the file while we're at it.

A good follow-up to this change would be to change all the "ret = -1;
goto done;" in this file to instead use a "goto cleanup", and
initialize "int ret = -1" at the start of the relevant functions. That
would allow us to drop a lot of needless brace verbosity on two-line
"if" statements, but let's leave that alone for now.

To ensure that there's a 1=1 mapping between owners of the "struct
stash_info" and free_stash_info() change the assert_stash_ref()
function to be a trivial get_stash_info_assert() wrapper. The caller
will call free_stash_info(), and by returning -1 we'll eventually (via
!!ret) exit with status 1 anyway.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/stash.c | 107 ++++++++++++++++++++++++++----------------------
 1 file changed, 59 insertions(+), 48 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 74fa810cf8c..ba030238939 100644
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
@@ -651,20 +651,25 @@ static int do_drop_stash(struct stash_info *info, int quiet)
 	return 0;
 }
 
-static void assert_stash_ref(struct stash_info *info)
+static int get_stash_info_assert(struct stash_info *info, int argc,
+				 const char **argv)
 {
-	if (!info->is_stash_ref) {
-		error(_("'%s' is not a stash reference"), info->revision.buf);
-		free_stash_info(info);
-		exit(1);
-	}
+	int ret = get_stash_info(info, argc, argv);
+
+	if (ret < 0)
+		return ret;
+
+	if (!info->is_stash_ref)
+		return error(_("'%s' is not a stash reference"), info->revision.buf);
+
+	return 0;
 }
 
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
@@ -673,22 +678,21 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options,
 			     git_stash_drop_usage, 0);
 
-	if (get_stash_info(&info, argc, argv))
-		return -1;
-
-	assert_stash_ref(&info);
+	if (get_stash_info_assert(&info, argc, argv))
+		goto cleanup;
 
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
@@ -699,25 +703,25 @@ static int pop_stash(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options,
 			     git_stash_pop_usage, 0);
 
-	if (get_stash_info(&info, argc, argv))
-		return -1;
+	if (get_stash_info_assert(&info, argc, argv))
+		goto cleanup;
 
-	assert_stash_ref(&info);
 	if ((ret = do_apply_stash(prefix, &info, index, quiet)))
 		printf_ln(_("The stash entry is kept in case "
 			    "you need it again."));
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
@@ -734,7 +738,7 @@ static int branch_stash(int argc, const char **argv, const char *prefix)
 	branch = argv[0];
 
 	if (get_stash_info(&info, argc - 1, argv + 1))
-		return -1;
+		goto cleanup;
 
 	cp.git_cmd = 1;
 	strvec_pushl(&cp.args, "checkout", "-b", NULL);
@@ -746,8 +750,8 @@ static int branch_stash(int argc, const char **argv, const char *prefix)
 	if (!ret && info.is_stash_ref)
 		ret = do_drop_stash(&info, 0);
 
+cleanup:
 	free_stash_info(&info);
-
 	return ret;
 }
 
@@ -825,8 +829,8 @@ static void diff_include_untracked(const struct stash_info *info, struct diff_op
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
@@ -844,6 +848,7 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 			      UNTRACKED_ONLY, PARSE_OPT_NONEG),
 		OPT_END()
 	};
+	int do_usage = 0;
 
 	init_diff_ui_defaults();
 	git_config(git_diff_ui_config, NULL);
@@ -861,10 +866,8 @@ static int show_stash(int argc, const char **argv, const char *prefix)
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
@@ -878,16 +881,14 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 			rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
 
 		if (!show_stat && !show_patch) {
-			free_stash_info(&info);
-			return 0;
+			ret = 0;
+			goto cleanup;
 		}
 	}
 
 	argc = setup_revisions(revision_args.nr, revision_args.v, &rev, NULL);
-	if (argc > 1) {
-		free_stash_info(&info);
-		usage_with_options(git_stash_show_usage, options);
-	}
+	if (argc > 1)
+		goto usage;
 	if (!rev.diffopt.output_format) {
 		rev.diffopt.output_format = DIFF_FORMAT_PATCH;
 		diff_setup_done(&rev.diffopt);
@@ -912,8 +913,16 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 	}
 	log_tree_diff_flush(&rev);
 
+	ret = diff_result_code(&rev.diffopt, 0);
+cleanup:
+	strvec_clear(&stash_args);
 	free_stash_info(&info);
-	return diff_result_code(&rev.diffopt, 0);
+	if (do_usage)
+		usage_with_options(git_stash_show_usage, options);
+	return ret;
+usage:
+	do_usage = 1;
+	goto cleanup;
 }
 
 static int do_store_stash(const struct object_id *w_commit, const char *stash_msg,
@@ -1409,9 +1418,9 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 
 static int create_stash(int argc, const char **argv, const char *prefix)
 {
-	int ret = 0;
+	int ret;
 	struct strbuf stash_msg_buf = STRBUF_INIT;
-	struct stash_info info;
+	struct stash_info info = STASH_INFO_INIT;
 	struct pathspec ps;
 
 	/* Starting with argv[1], since argv[0] is "create" */
@@ -1426,6 +1435,7 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 	if (!ret)
 		printf_ln("%s", oid_to_hex(&info.w_commit));
 
+	free_stash_info(&info);
 	strbuf_release(&stash_msg_buf);
 	return ret;
 }
@@ -1434,7 +1444,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 			 int keep_index, int patch_mode, int include_untracked, int only_staged)
 {
 	int ret = 0;
-	struct stash_info info;
+	struct stash_info info = STASH_INFO_INIT;
 	struct strbuf patch = STRBUF_INIT;
 	struct strbuf stash_msg_buf = STRBUF_INIT;
 	struct strbuf untracked_files = STRBUF_INIT;
@@ -1633,6 +1643,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 	}
 
 done:
+	free_stash_info(&info);
 	strbuf_release(&stash_msg_buf);
 	return ret;
 }
-- 
2.36.0.rc2.843.g193535c2aa7

