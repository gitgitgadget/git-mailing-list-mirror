Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4AFC1F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 16:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731606AbeK1DwI (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 22:52:08 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34158 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731580AbeK1DwH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 22:52:07 -0500
Received: by mail-lj1-f195.google.com with SMTP id u6-v6so20693790ljd.1
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 08:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6brQhIwpV2Fs+CmMlcXl/1k5MLHmasxGxy0XJf2ZpGU=;
        b=jwisNU4Qcl+fQeXy7m6orkKWcDmEHjhap2MnThcHiX4pd/2q9VNiG0w5dPvAPxXR3p
         ndn7GE09fJoSOvLNOsDbdipA6nCtHmJs9Uz9Ks4gkIrOpMDtd76GdWvh7A19cb8YX5Ss
         n17hwFAfocVe3CSVvg4MYjrYXUfnYorVMqLMRqBV8AZGRNo2RIdMmLoywYRUsVDKy67k
         L0hzzyupsv9hHYvB+PNCDcCi6J5y9JXw9Z8RNmC2oCRjDyRQJBeTp7yytlL/pB9bw0fm
         L4aCmKavAQsIJdoeBxWPz4xU169xw2yEqmo/lBLeZ4kfVtM99jFEqREwDIRzpSYE0bWD
         U5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6brQhIwpV2Fs+CmMlcXl/1k5MLHmasxGxy0XJf2ZpGU=;
        b=VxPi1ZawnycNeaCXSIEcz952awXakpGxnstMJKVIv9ikn7gzMLXlMEZJwPLFippSo4
         m2zU4Ed9n14xGjWhXzQA4TFVRGjf69uRwsatynEKTtlK+mfVrQf9T6m44C6mDse9m4pj
         ozGtHTEhv38lxeHlVprZX8t+6+wEmoTzJpN+lHcw2gC4SqzrP9qmuZbuSCItdYkeXhv3
         LfW7TMzET+YZgNvvk85rPxBWXnWSqtY509z0Y17ISWEu1V8VF8c+FlXGHv3YuVPbLfuE
         3jFQcErOImVxAZS4hCLanMlOWbVA4Sxxbargz+J87+3ePHmW+QHUn/sWrgBaOEb2m5BT
         2B2A==
X-Gm-Message-State: AA+aEWYI0XzfWwB4w+Tm3vjuiImK8SK8HPQayloK7btfMmyBRBZuUuoc
        dZPD5gKRXAzdB+84EpasGAbqMKI0
X-Google-Smtp-Source: AJdET5fSAmID4Nbm2BQro6QlM4wCE0Pam7oDzIAZrNXoknQieTbrSoqntMwHMhYOUMrtvcWnvj/n/Q==
X-Received: by 2002:a2e:9107:: with SMTP id m7-v6mr20375435ljg.23.1543337614712;
        Tue, 27 Nov 2018 08:53:34 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g66sm694016lfe.42.2018.11.27.08.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 08:53:33 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>, t.gummerer@gmail.com
Subject: [PATCH v2 6/7] checkout: split into switch-branch and checkout-files
Date:   Tue, 27 Nov 2018 17:52:10 +0100
Message-Id: <20181127165211.24763-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1327.g328c130451.dirty
In-Reply-To: <20181127165211.24763-1-pclouds@gmail.com>
References: <20181120174554.GA29910@duynguyen.home>
 <20181127165211.24763-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git checkout" doing too many things is a source of confusion for many
users (and it even bites old timers sometimes). To rememdy that, the
command is now split in two: switch-branch and checkout-files.

The switch-branch command is all about switching branches, detaching,
DWIM-ing new branch... It does not accept pathspecs and it always
requires a ref (in contrast, "git checkout" without arguments works)

The checkout-files command on the other hand is all about resetting
certain files in worktree, either from the index or from a specific
tree. It could accept a tree-ish, but it will never touch HEAD or the
ref it points to.

The good old "git checkout" command is still here and will be until
all (or most of users) are sick of it.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin.h          |  2 +
 builtin/checkout.c | 91 +++++++++++++++++++++++++++++++++++++++-------
 git.c              |  2 +
 3 files changed, 82 insertions(+), 13 deletions(-)

diff --git a/builtin.h b/builtin.h
index 6538932e99..d4a66e5f79 100644
--- a/builtin.h
+++ b/builtin.h
@@ -138,6 +138,7 @@ extern int cmd_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_bundle(int argc, const char **argv, const char *prefix);
 extern int cmd_cat_file(int argc, const char **argv, const char *prefix);
 extern int cmd_checkout(int argc, const char **argv, const char *prefix);
+extern int cmd_checkout_files(int argc, const char **argv, const char *prefix);
 extern int cmd_checkout_index(int argc, const char **argv, const char *prefix);
 extern int cmd_check_attr(int argc, const char **argv, const char *prefix);
 extern int cmd_check_ignore(int argc, const char **argv, const char *prefix);
@@ -227,6 +228,7 @@ extern int cmd_show_index(int argc, const char **argv, const char *prefix);
 extern int cmd_status(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
 extern int cmd_submodule__helper(int argc, const char **argv, const char *prefix);
+extern int cmd_switch_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_tag(int argc, const char **argv, const char *prefix);
 extern int cmd_tar_tree(int argc, const char **argv, const char *prefix);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index d9dbd2d40d..c09d2da47a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -33,6 +33,16 @@ static const char * const checkout_usage[] = {
 	NULL,
 };
 
+static const char * const switch_branch_usage[] = {
+	N_("git switch-branch [<options>] <branch>"),
+	NULL,
+};
+
+static const char * const checkout_files_usage[] = {
+	N_("git checkout-files [<options>] [<branch>] -- <file>..."),
+	NULL,
+};
+
 struct checkout_opts {
 	int patch_mode;
 	int quiet;
@@ -45,6 +55,8 @@ struct checkout_opts {
 	int ignore_other_worktrees;
 	int show_progress;
 	int dwim_new_local_branch;
+	int accept_pathspec;
+	int empty_arg_ok;
 
 	/*
 	 * If new checkout options are added, skip_merge_working_tree
@@ -1056,7 +1068,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 	arg = argv[0];
 	dash_dash_pos = -1;
 	for (i = 0; i < argc; i++) {
-		if (!strcmp(argv[i], "--")) {
+		if (opts->accept_pathspec && !strcmp(argv[i], "--")) {
 			dash_dash_pos = i;
 			break;
 		}
@@ -1067,6 +1079,8 @@ static int parse_branchname_arg(int argc, const char **argv,
 		has_dash_dash = 1; /* case (3) or (1) */
 	else if (dash_dash_pos >= 2)
 		die(_("only one reference expected, %d given."), dash_dash_pos);
+	else if (!opts->accept_pathspec)
+		has_dash_dash = 1;
 
 	if (!strcmp(arg, "-"))
 		arg = "@{-1}";
@@ -1291,30 +1305,23 @@ static struct option *add_checkout_path_options(struct checkout_opts *opts,
 	return newopts;
 }
 
-int cmd_checkout(int argc, const char **argv, const char *prefix)
+static int checkout_main(int argc, const char **argv, const char *prefix,
+			 struct checkout_opts *opts, struct option *options,
+			 const char * const usagestr[])
 {
-	struct checkout_opts real_opts;
-	struct checkout_opts *opts = &real_opts;
 	struct branch_info new_branch_info;
 	int dwim_remotes_matched = 0;
-	struct option *options = NULL;
 
-	memset(opts, 0, sizeof(*opts));
 	memset(&new_branch_info, 0, sizeof(new_branch_info));
 	opts->overwrite_ignore = 1;
 	opts->prefix = prefix;
 	opts->show_progress = -1;
-	opts->dwim_new_local_branch = 1;
 
 	git_config(git_checkout_config, opts);
 
 	opts->track = BRANCH_TRACK_UNSPECIFIED;
 
-	options = add_common_options(opts, options);
-	options = add_switch_branch_options(opts, options);
-	options = add_checkout_path_options(opts, options);
-
-	argc = parse_options(argc, argv, prefix, options, checkout_usage,
+	argc = parse_options(argc, argv, prefix, options, usagestr,
 			     PARSE_OPT_KEEP_DASHDASH);
 
 	if (opts->show_progress < 0) {
@@ -1381,7 +1388,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 					     &dwim_remotes_matched);
 		argv += n;
 		argc -= n;
-	}
+	} else if (!opts->empty_arg_ok)
+		usage_with_options(usagestr, options);
 
 	if (argc) {
 		parse_pathspec(&opts->pathspec, 0,
@@ -1443,3 +1451,60 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		return checkout_branch(opts, &new_branch_info);
 	}
 }
+
+int cmd_checkout(int argc, const char **argv, const char *prefix)
+{
+	struct checkout_opts opts;
+	struct option *options = NULL;
+	int ret;
+
+	memset(&opts, 0, sizeof(opts));
+	opts.dwim_new_local_branch = 1;
+	opts.accept_pathspec = 1;
+	opts.empty_arg_ok = 1;
+
+	options = add_common_options(&opts, options);
+	options = add_switch_branch_options(&opts, options);
+	options = add_checkout_path_options(&opts, options);
+
+	ret = checkout_main(argc, argv, prefix, &opts,
+			    options, checkout_usage);
+	FREE_AND_NULL(options);
+	return ret;
+}
+
+int cmd_switch_branch(int argc, const char **argv, const char *prefix)
+{
+	struct checkout_opts opts;
+	struct option *options = NULL;
+	int ret;
+
+	memset(&opts, 0, sizeof(opts));
+	opts.dwim_new_local_branch = 1;
+
+	options = add_common_options(&opts, options);
+	options = add_switch_branch_options(&opts, options);
+
+	ret = checkout_main(argc, argv, prefix, &opts,
+			    options, switch_branch_usage);
+	FREE_AND_NULL(options);
+	return ret;
+}
+
+int cmd_checkout_files(int argc, const char **argv, const char *prefix)
+{
+	struct checkout_opts opts;
+	struct option *options = NULL;
+	int ret;
+
+	memset(&opts, 0, sizeof(opts));
+	opts.accept_pathspec = 1;
+
+	options = add_common_options(&opts, options);
+	options = add_checkout_path_options(&opts, options);
+
+	ret = checkout_main(argc, argv, prefix, &opts,
+			    options, checkout_files_usage);
+	FREE_AND_NULL(options);
+	return ret;
+}
diff --git a/git.c b/git.c
index 2f604a41ea..3b86ba765c 100644
--- a/git.c
+++ b/git.c
@@ -457,6 +457,7 @@ static struct cmd_struct commands[] = {
 	{ "check-mailmap", cmd_check_mailmap, RUN_SETUP },
 	{ "check-ref-format", cmd_check_ref_format, NO_PARSEOPT  },
 	{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
+	{ "checkout-files", cmd_checkout_files, RUN_SETUP | NEED_WORK_TREE },
 	{ "checkout-index", cmd_checkout_index,
 		RUN_SETUP | NEED_WORK_TREE},
 	{ "cherry", cmd_cherry, RUN_SETUP },
@@ -557,6 +558,7 @@ static struct cmd_struct commands[] = {
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
 	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX | NO_PARSEOPT },
+	{ "switch-branch", cmd_switch_branch, RUN_SETUP | NEED_WORK_TREE },
 	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 	{ "tag", cmd_tag, RUN_SETUP | DELAY_PAGER_CONFIG },
 	{ "unpack-file", cmd_unpack_file, RUN_SETUP | NO_PARSEOPT },
-- 
2.19.1.1327.g328c130451.dirty

