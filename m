Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98A6C433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 01:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C54961205
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 01:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhKJBqs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 20:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhKJBqp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 20:46:45 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7600BC061764
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 17:43:57 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z21so3970965edb.5
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 17:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m6vNSCYVowYau1Q2FwT6dMSni5gY/1BZW4/8FvrsVvI=;
        b=XZlc9y/CdyUcmQr+KRHQQx85zo9bVG2nX56iflP/U9olonlGTui1Mzfdb4tCKeDjN+
         AUBMKjWkJhDcpRQacosvXQibhMWUFc18RpmC/oXYfvAeck4hquIBb9oYuvWaPXhn33SU
         i98Q84LxyqgSFWXL2rn65L+SctjUyhxCHg2kGkBc07qab4YeQ1jdD+k6fa3zJSpct4uK
         LNTENP9v/jAvW9DCMuLxLC9/0/wHWlu6CzZ3KPuMn+5gnXmKos9oJtBR5RTiEbWR7Ov6
         0SJQkApUugv1ShTVeJtTtjlrhPBlqotJx6+9dsDyg0necdre6gBJ/v9wuysPDgMv3vIV
         Sj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m6vNSCYVowYau1Q2FwT6dMSni5gY/1BZW4/8FvrsVvI=;
        b=xo+ZFgUlN/PsiFGWT/D46fAvl9aLHPyRP2kLfp6sIHr3wA0bQyQvAWUzL3ib9c45uQ
         aN2Ov33qg2zaMrIuFOeiyNF8KzHW2HVY2lPl8meOFNIIfk468Xfn2iI+AXKaXVpQb/+A
         uADXQhewxc2ua6+rPXT80zYrwS//+h60mtuo0rJACD0+rzQxFN+SjpMwv+4ojN64uC78
         sXyj4ayOWCIqx+O97Pqf+sxBFQo72CgXY0bbmIMnL5GQxuM+P3uz/O1hoF0RvCp1oUdB
         U6YCmS15LQ3DRuusbW3ubEIHDQpAatcqh2xzRPRCE+8Q/uKrnvTEStSE78ItDH2pTIQw
         vMIw==
X-Gm-Message-State: AOAM532HVNXgUoCEsPogcY2kPFSmuUq688pVknavbl7RFUt11hBF15ZD
        SjXvzU2nO7ZaLhw3OfiHaOaWA7AartNtXg==
X-Google-Smtp-Source: ABdhPJxOgkS6t5bM8Q97XJN7IWYtI7cx9nmcCZyLfLL6vTTR2oPB/3Ff461f237pGYoiRNz0sv5lkg==
X-Received: by 2002:a50:d88a:: with SMTP id p10mr16890978edj.274.1636508635742;
        Tue, 09 Nov 2021 17:43:55 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id qf8sm9369252ejc.8.2021.11.09.17.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 17:43:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/8] built-ins: trust the "prefix" from run_builtin()
Date:   Wed, 10 Nov 2021 02:43:44 +0100
Message-Id: <patch-v2-2.8-63cf2fe266d-20211110T013632Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.791.gdbfcf909579
In-Reply-To: <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code in "builtin/grep.c" and "builtin/ls-tree.c" to trust the
"prefix" passed from "run_builtin()". The "prefix" we get from setup.c
is either going to be NULL or a string of length >0, never "".

So we can drop the "prefix && *prefix" checks added for
"builtin/grep.c" in 0d042fecf2f (git-grep: show pathnames relative to
the current directory, 2006-08-11), and for "builtin/ls-tree.c" in
a69dd585fca (ls-tree: chomp leading directories when run from a
subdirectory, 2005-12-23).

As seen in code in revision.c that was added in cd676a51367 (diff
--relative: output paths as relative to the current subdirectory,
2008-02-12) we already have existing code that does away with this
assertion.

This makes it easier to reason about a subsequent change to the
"prefix_length" code in grep.c in a subsequent commit, and since we're
going to the trouble of doing that let's leave behind an assert() to
promise this to any future callers.

For "builtin/grep.c" it would be painful to pass the "prefix" down the
callchain of:

    cmd_grep -> grep_tree -> grep_submodule -> grep_cache -> grep_oid ->
    grep_source_name

So for the code that needs it in grep_source_name() let's add a
"grep_prefix" variable similar to the existing "ls_tree_prefix".

While at it let's move the code in cmd_ls_tree() around so that we
assign to the "ls_tree_prefix" right after declaring the variables,
and stop assigning to "prefix". We only subsequently used that
variable later in the function after clobbering it. Let's just use our
own "grep_prefix" instead.

Let's also add an assert() in git.c, so that we'll make this promise
about the "prefix" to any current and future callers, as well as to
any readers of the code.

Code history:

 * The strlen() in "grep.c" hasn't been used since 493b7a08d80 (grep:
   accept relative paths outside current working directory, 2009-09-05).

   When that code was added in 0d042fecf2f (git-grep: show pathnames
   relative to the current directory, 2006-08-11) we used the length.

   But since 493b7a08d80 we haven't used it for anything except a
   boolean check that we could have done on the "prefix" member
   itself.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c    | 13 ++++++++-----
 builtin/ls-tree.c |  9 ++++-----
 git.c             |  4 ++--
 grep.c            |  4 +---
 grep.h            |  4 +---
 revision.c        |  2 +-
 6 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 9e34a820ad4..d85cbabea67 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -26,6 +26,8 @@
 #include "object-store.h"
 #include "packfile.h"
 
+static const char *grep_prefix;
+
 static char const * const grep_usage[] = {
 	N_("git grep [<options>] [-e] <pattern> [<rev>...] [[--] <path>...]"),
 	NULL
@@ -315,11 +317,11 @@ static void grep_source_name(struct grep_opt *opt, const char *filename,
 	strbuf_reset(out);
 
 	if (opt->null_following_name) {
-		if (opt->relative && opt->prefix_length) {
+		if (opt->relative && grep_prefix) {
 			struct strbuf rel_buf = STRBUF_INIT;
 			const char *rel_name =
 				relative_path(filename + tree_name_len,
-					      opt->prefix, &rel_buf);
+					      grep_prefix, &rel_buf);
 
 			if (tree_name_len)
 				strbuf_add(out, filename, tree_name_len);
@@ -332,8 +334,8 @@ static void grep_source_name(struct grep_opt *opt, const char *filename,
 		return;
 	}
 
-	if (opt->relative && opt->prefix_length)
-		quote_path(filename + tree_name_len, opt->prefix, out, 0);
+	if (opt->relative && grep_prefix)
+		quote_path(filename + tree_name_len, grep_prefix, out, 0);
 	else
 		quote_c_style(filename + tree_name_len, out, NULL, 0);
 
@@ -962,9 +964,10 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_END()
 	};
+	grep_prefix = prefix;
 
 	git_config(grep_cmd_config, NULL);
-	grep_init(&opt, the_repository, prefix);
+	grep_init(&opt, the_repository);
 
 	/*
 	 * If there is no -- then the paths must exist in the working
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 3a442631c71..84bed6d5612 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -147,16 +147,15 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		OPT__ABBREV(&abbrev),
 		OPT_END()
 	};
-
-	git_config(git_default_config, NULL);
 	ls_tree_prefix = prefix;
-	if (prefix && *prefix)
+	if (prefix)
 		chomp_prefix = strlen(prefix);
 
+	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, ls_tree_options,
 			     ls_tree_usage, 0);
 	if (full_tree) {
-		ls_tree_prefix = prefix = NULL;
+		ls_tree_prefix = NULL;
 		chomp_prefix = 0;
 	}
 	/* -d -r should imply -t, but -d by itself should not have to. */
@@ -178,7 +177,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	parse_pathspec(&pathspec, PATHSPEC_ALL_MAGIC &
 				  ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
 		       PATHSPEC_PREFER_CWD,
-		       prefix, argv + 1);
+		       ls_tree_prefix, argv + 1);
 	for (i = 0; i < pathspec.nr; i++)
 		pathspec.items[i].nowildcard_len = pathspec.items[i].len;
 	pathspec.has_wildcard = 0;
diff --git a/git.c b/git.c
index 5ff21be21f3..611bf2f63eb 100644
--- a/git.c
+++ b/git.c
@@ -420,9 +420,8 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 {
 	int status, help;
 	struct stat st;
-	const char *prefix;
+	const char *prefix = NULL;
 
-	prefix = NULL;
 	help = argc == 2 && !strcmp(argv[1], "-h");
 	if (!help) {
 		if (p->option & RUN_SETUP)
@@ -431,6 +430,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 			int nongit_ok;
 			prefix = setup_git_directory_gently(&nongit_ok);
 		}
+		assert(!prefix || *prefix);
 		precompose_argv_prefix(argc, argv, NULL);
 		if (use_pager == -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY) &&
 		    !(p->option & DELAY_PAGER_CONFIG))
diff --git a/grep.c b/grep.c
index f6e113e9f0f..c9065254aeb 100644
--- a/grep.c
+++ b/grep.c
@@ -139,13 +139,11 @@ int grep_config(const char *var, const char *value, void *cb)
  * default values from the template we read the configuration
  * information in an earlier call to git_config(grep_config).
  */
-void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix)
+void grep_init(struct grep_opt *opt, struct repository *repo)
 {
 	*opt = grep_defaults;
 
 	opt->repo = repo;
-	opt->prefix = prefix;
-	opt->prefix_length = (prefix && *prefix) ? strlen(prefix) : 0;
 	opt->pattern_tail = &opt->pattern_list;
 	opt->header_tail = &opt->header_list;
 }
diff --git a/grep.h b/grep.h
index 95cccb670f9..62deadb885f 100644
--- a/grep.h
+++ b/grep.h
@@ -134,8 +134,6 @@ struct grep_opt {
 	 */
 	struct repository *repo;
 
-	const char *prefix;
-	int prefix_length;
 	int linenum;
 	int columnnum;
 	int invert;
@@ -180,7 +178,7 @@ struct grep_opt {
 };
 
 int grep_config(const char *var, const char *value, void *);
-void grep_init(struct grep_opt *, struct repository *repo, const char *prefix);
+void grep_init(struct grep_opt *, struct repository *repo);
 void grep_commit_pattern_type(enum grep_pattern_type, struct grep_opt *opt);
 
 void append_grep_pat(struct grep_opt *opt, const char *pat, size_t patlen, const char *origin, int no, enum grep_pat_token t);
diff --git a/revision.c b/revision.c
index ab7c1358042..9f9b0d2429e 100644
--- a/revision.c
+++ b/revision.c
@@ -1833,7 +1833,7 @@ void repo_init_revisions(struct repository *r,
 	revs->commit_format = CMIT_FMT_DEFAULT;
 	revs->expand_tabs_in_log_default = 8;
 
-	grep_init(&revs->grep_filter, revs->repo, prefix);
+	grep_init(&revs->grep_filter, revs->repo);
 	revs->grep_filter.status_only = 1;
 
 	repo_diff_setup(revs->repo, &revs->diffopt);
-- 
2.34.0.rc1.741.gab7bfd97031

