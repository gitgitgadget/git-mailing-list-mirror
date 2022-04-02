Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB33C433EF
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 10:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354509AbiDBKwC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 06:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354494AbiDBKvt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 06:51:49 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77CF1403EB
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 03:49:56 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id qh7so696428ejb.11
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 03:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ugr2ozj/FNQa9QaTDG4rCY1TyCG+8D0lbCbK4JjOw3U=;
        b=qtV9E5bldB9YGfoLN97adb+tiApFawgft7Vl/VECltNZ3TJ+9qQ2MKlIiB2w1TMke9
         7teODUPO4Y9frtxLEJewiqUENxlqAYHh2HnHF0b2sG5G9LxXslbPw2RNuffHw/C35YTt
         isnsBJPQKHeuZI+3dUO+UFcJSB1jqgZutokivg0Cq+04c1uD5VRvNsj5V2XhNvMfQhbg
         A0NW6EQWCtBKftxnPIqacg3aChBR0ZrpIHcd8ZAVYqkTYXQdN2XOvoe6JRxUjV9Ej0+Z
         uNsx2zzxk5IoQaPtyPQKhs1j88bGiLJ4/oogdb2TOcUsaMb5lG8mzqSg26txkPz9rJSo
         VGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ugr2ozj/FNQa9QaTDG4rCY1TyCG+8D0lbCbK4JjOw3U=;
        b=0rY9fqatoRocw36Sq7rWHrGUyGxn6A3Ja2cnwc41GgMM/KHlkfRegIfqEh2HWNIly2
         stSS2BnEKa3JNjMkZGzqBns5R+dEqAkhE1gf/lIykTxblILF/sXWBmARO4gMBiguPwPc
         h+Ay4ksFEzQePoMT2TEA0qanRARDGraHgJKhgd0dYYfrjzQ8lw1UEIBrhcKvZTxmr+9v
         pGZLo036U7p51h027hKn8FoSwYh9OGIqlUkE/Flj2k1kVRPxvRizjt3RktCIHAEvWCl7
         p9OxwJbk66FzXl0/fQ68wW8ArKtVNlZWErfusp7diCw1GL0tQ6d5w7A56PwYW39s8bvf
         zeWg==
X-Gm-Message-State: AOAM533SE5MCy0y6E3mRal6lgF57dNN6emkMsABzOn8M8fbWLCwp1kKH
        xf70x8O9slze/+h7YBjkyXHfyqpOhY8Pfg==
X-Google-Smtp-Source: ABdhPJy0vEsRZIxbMKV99KQPqP2wG4QcIFcezOxmQAJeaTj/E6t4RTvQ5y4962s2jE00/Nk8h0hl2A==
X-Received: by 2002:a17:907:9724:b0:6e0:f204:5c8c with SMTP id jg36-20020a170907972400b006e0f2045c8cmr3400708ejc.150.1648896594979;
        Sat, 02 Apr 2022 03:49:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r23-20020a056402235700b00419171bc571sm2366137eda.59.2022.04.02.03.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:49:54 -0700 (PDT)
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
Subject: [PATCH v5 10/27] stash: always have the owner of "stash_info" free it
Date:   Sat,  2 Apr 2022 12:49:24 +0200
Message-Id: <patch-v5-10.27-4c5404912e9-20220402T102002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1584.g2aeb20a6519
In-Reply-To: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com> <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
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
2.35.1.1585.gd85f8dcb745

