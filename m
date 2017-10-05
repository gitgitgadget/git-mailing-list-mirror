Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC06C1FA21
	for <e@80x24.org>; Thu,  5 Oct 2017 20:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752276AbdJEUzU (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 16:55:20 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36159 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752226AbdJEUzB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 16:55:01 -0400
Received: by mail-qk0-f193.google.com with SMTP id z14so10743417qkg.3
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 13:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZY+kENe+z+vfuDehfOwkh71Go9oJx1f8Xxpkd3lnpGw=;
        b=i/vWIjzLLUvKVGpGvrgvudrpaRl+nP7R/tVt95i102tcHxgthLPXTeI8iBKfgPJUcq
         mXhvf6PWADVX4ojiPbPJzT1VO4LDKe1pTX38PizqU+bd7YOcztxsQvqhKaRLl9sRz8Nv
         gT4xSlr0CLL8gkiOf0mvXQ7CK+LXj+N+dpZisZ3i+YjrlAsjHfrl6abf4zn7QdNExabV
         fJI0nvGOfZh97FJWtyZ++00gkObdmLINiaXb65T85/0m6ijXMIFJi65l1BxRJUuNt2A3
         cyfnN5B8u9P9gaR0W+ECznNIZNt/6j52usheSeO+WCsriJ+2i/Fyhq+yjlsvCPtL7xoj
         7aAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZY+kENe+z+vfuDehfOwkh71Go9oJx1f8Xxpkd3lnpGw=;
        b=Pq4osiYGFOuIgcc4r0IDt0y5/cV0+1DGQgzaUaqx6V0ik4HcIgjMf9vKDZNtb29jYZ
         55uSR9ZBBvawA8VvvfUl+vcAtEtukaiC98DCMHhiee+5SjLFAQVPcJNofOk87j7sqXEp
         OypgX6l7czuguH/7rV440hgqgQBCWlLepckw1IDeR5e1YDRFYRog6/M0TEDizQ3VCCjU
         VsmJly0G5Wf0Pk3ig9IOl2pXuq0B6jHYkykfjQDF+zjGICz3FTosVxukJbo5WIgobZVP
         UN4hZJMiHc1/Qxrvsi86hsZR+6vnIvOcDW1wInt0/Ee0yZbk6j2WUOCDT+xHt8Mipdye
         6rpg==
X-Gm-Message-State: AMCzsaUCw0DEQRl4i5iZ3eLZvKNsh2DoFgiwV8N5Rk7CiKTjIwPd4zyL
        gCg0LJMYHZYOe02Crtft+7PQXsHixi0=
X-Google-Smtp-Source: AOwi7QAvqqooOovyj6DQFmBUZmShuAwo3KU9LHbQkl2HAidVODYAcuOUye/ZitdEdQUDKpHrDOcEgg==
X-Received: by 10.55.27.136 with SMTP id m8mr7085115qkh.356.1507236900584;
        Thu, 05 Oct 2017 13:55:00 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2001:4898:8010::76e])
        by smtp.gmail.com with ESMTPSA id x127sm11871596qkd.3.2017.10.05.13.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Oct 2017 13:55:00 -0700 (PDT)
From:   jameson.miller81@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, bmwill@google.com,
        sbeller@google.com, Jameson Miller <jamill@microsoft.com>
Subject: [PATCH 1/6] Teach status options around showing ignored files
Date:   Thu,  5 Oct 2017 16:54:38 -0400
Message-Id: <20171005205443.206900-2-jameson.miller81@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171005205443.206900-1-jameson.miller81@gmail.com>
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jameson Miller <jamill@microsoft.com>

This change teaches the status command more options to control which
ignored files are reported independently of the which untracked files
are reported by allowing the `--ignored` option to take additional
arguments.  Currently, the shown ignored files are linked to how
untracked files are reported. Both ignored and untracked files are
controlled by arguments to `--untracked-files` option. This makes it
impossible to show all untracked files individually, but show ignored
"files and directories" (that is, ignored directories are shown as 1
entry, instead of having all contents shown).

Our application (Visual Studio) has a specific set of requirements
about how it wants untracked / ignored files reported by git status.
It requires all untracked files listed individually. It would like
ignored files and directories that explicity match an exclude pattern
listed. If an ignored directory matches an exclude pattern, then the
path of the directory should be returned. If a directory does not
match an exclude pattern, but all of its contents are ignored, then we
want the contained files reported instead of the directory.

The reason for controlling these behaviors separately is that there
can be a significant performance impact to scanning the contents of
excluded directories. Additionally, knowing whether a directory
explicitly matches an exclude pattern can help the application make
decisions about how to handle the directory. If an ignored directory
itself matches an exclude pattern, then the application will know that
any files underneath the directory must be ignored as well.

As a more concrete example, on Windows, Visual Studio creates a bin/
and obj/ directory inside of the project where it writes all .obj and
binary build output files. Normal usage is to explicitly ignore these
2 directory names in the .gitignore file (rather than or in addition
to *.obj). We just want to see the "bin/" and "obj/" paths regardless
of which "--untracked-files" flag is passed in. Additionally, if we
know the bin/ and obj/ directories are ignored, then we can ignore any
files changes we notice underneath these paths, as we know they do not
affect the output of stats.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 builtin/commit.c | 27 +++++++++++++++++++++------
 dir.c            | 24 ++++++++++++++++++++++++
 dir.h            |  3 ++-
 wt-status.c      | 11 ++++++++---
 wt-status.h      |  8 +++++++-
 5 files changed, 62 insertions(+), 11 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d75b3805ea..34443b45d3 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -118,7 +118,7 @@ static int edit_flag = -1; /* unspecified */
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int config_commit_verbose = -1; /* unspecified */
 static int no_post_rewrite, allow_empty_message;
-static char *untracked_files_arg, *force_date, *ignore_submodule_arg;
+static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
 static char *sign_commit;
 
 /*
@@ -139,7 +139,7 @@ static const char *cleanup_arg;
 static enum commit_whence whence;
 static int sequencer_in_use;
 static int use_editor = 1, include_status = 1;
-static int show_ignored_in_status, have_option_m;
+static int have_option_m;
 static struct strbuf message = STRBUF_INIT;
 
 static enum wt_status_format status_format = STATUS_FORMAT_UNSPECIFIED;
@@ -1075,6 +1075,19 @@ static const char *find_author_by_nickname(const char *name)
 	die(_("--author '%s' is not 'Name <email>' and matches no existing author"), name);
 }
 
+static void handle_ignored_arg(struct wt_status *s)
+{
+	if (!ignored_arg)
+		; /* default already initialized */
+	else if (!strcmp(ignored_arg, "traditional"))
+		s->show_ignored_mode = SHOW_TRADITIONAL_IGNORED;
+	else if (!strcmp(ignored_arg, "no"))
+		s->show_ignored_mode = SHOW_NO_IGNORED;
+	else if (!strcmp(ignored_arg, "matching"))
+		s->show_ignored_mode = SHOW_MATCHING_IGNORED;
+	else
+		die(_("Invalid ignored mode '%s'"), ignored_arg);
+}
 
 static void handle_untracked_files_arg(struct wt_status *s)
 {
@@ -1363,8 +1376,10 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		  N_("mode"),
 		  N_("show untracked files, optional modes: all, normal, no. (Default: all)"),
 		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
-		OPT_BOOL(0, "ignored", &show_ignored_in_status,
-			 N_("show ignored files")),
+		{ OPTION_STRING, 0, "ignored", &ignored_arg,
+		  N_("mode"),
+		  N_("show ignored files, optional modes: traditional, matching, no. (Default: traditional)"),
+		  PARSE_OPT_OPTARG, NULL, (intptr_t)"traditional" },
 		{ OPTION_STRING, 0, "ignore-submodules", &ignore_submodule_arg, N_("when"),
 		  N_("ignore changes to submodules, optional when: all, dirty, untracked. (Default: all)"),
 		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
@@ -1383,8 +1398,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	finalize_deferred_config(&s);
 
 	handle_untracked_files_arg(&s);
-	if (show_ignored_in_status)
-		s.show_ignored_files = 1;
+	handle_ignored_arg(&s);
+
 	parse_pathspec(&s.pathspec, 0,
 		       PATHSPEC_PREFER_FULL,
 		       prefix, argv);
diff --git a/dir.c b/dir.c
index 1d17b800cf..b9af87eca9 100644
--- a/dir.c
+++ b/dir.c
@@ -1389,6 +1389,30 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	case index_nonexistent:
 		if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
 			break;
+		if (exclude &&
+			(dir->flags & DIR_SHOW_IGNORED_TOO) &&
+			(dir->flags & DIR_SHOW_IGNORED_TOO_MODE_MATCHING)) {
+
+			/*
+			 * This is an excluded directory and we are
+			 * showing ignored paths that match an exclude
+			 * pattern.  (e.g. show directory as ignored
+			 * only if it matches an exclude pattern).
+			 * This path will either be 'path_excluded`
+			 * (if we are showing empty directories or if
+			 * the directory is not empty), or will be
+			 * 'path_none' (empty directory, and we are
+			 * not showing empty directories).
+			 */
+			if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
+				return path_excluded;
+
+			if (read_directory_recursive(dir, istate, dirname, len,
+						     untracked, 1, 1, pathspec) == path_excluded)
+				return path_excluded;
+
+			return path_none;
+		}
 		if (!(dir->flags & DIR_NO_GITLINKS)) {
 			unsigned char sha1[20];
 			if (resolve_gitlink_ref(dirname, "HEAD", sha1) == 0)
diff --git a/dir.h b/dir.h
index e3717055d1..57b0943dae 100644
--- a/dir.h
+++ b/dir.h
@@ -152,7 +152,8 @@ struct dir_struct {
 		DIR_COLLECT_IGNORED = 1<<4,
 		DIR_SHOW_IGNORED_TOO = 1<<5,
 		DIR_COLLECT_KILLED_ONLY = 1<<6,
-		DIR_KEEP_UNTRACKED_CONTENTS = 1<<7
+		DIR_KEEP_UNTRACKED_CONTENTS = 1<<7,
+		DIR_SHOW_IGNORED_TOO_MODE_MATCHING = 1<<8
 	} flags;
 	struct dir_entry **entries;
 	struct dir_entry **ignored;
diff --git a/wt-status.c b/wt-status.c
index 6f730ee8f2..8301c84946 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -660,10 +660,15 @@ static void wt_status_collect_untracked(struct wt_status *s)
 	if (s->show_untracked_files != SHOW_ALL_UNTRACKED_FILES)
 		dir.flags |=
 			DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
-	if (s->show_ignored_files)
+	if (s->show_ignored_mode) {
 		dir.flags |= DIR_SHOW_IGNORED_TOO;
-	else
+
+		if (s->show_ignored_mode == SHOW_MATCHING_IGNORED)
+			dir.flags |= DIR_SHOW_IGNORED_TOO_MODE_MATCHING;
+	} else {
 		dir.untracked = the_index.untracked;
+	}
+
 	setup_standard_excludes(&dir);
 
 	fill_directory(&dir, &the_index, &s->pathspec);
@@ -1621,7 +1626,7 @@ static void wt_longstatus_print(struct wt_status *s)
 	}
 	if (s->show_untracked_files) {
 		wt_longstatus_print_other(s, &s->untracked, _("Untracked files"), "add");
-		if (s->show_ignored_files)
+		if (s->show_ignored_mode)
 			wt_longstatus_print_other(s, &s->ignored, _("Ignored files"), "add -f");
 		if (advice_status_u_option && 2000 < s->untracked_in_ms) {
 			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
diff --git a/wt-status.h b/wt-status.h
index 64f4d33ea1..fe27b465e2 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -27,6 +27,12 @@ enum untracked_status_type {
 	SHOW_ALL_UNTRACKED_FILES
 };
 
+enum show_ignored_type {
+	SHOW_NO_IGNORED,
+	SHOW_TRADITIONAL_IGNORED,
+	SHOW_MATCHING_IGNORED,
+};
+
 /* from where does this commit originate */
 enum commit_whence {
 	FROM_COMMIT,     /* normal */
@@ -70,7 +76,7 @@ struct wt_status {
 	int display_comment_prefix;
 	int relative_paths;
 	int submodule_summary;
-	int show_ignored_files;
+	enum show_ignored_type show_ignored_mode;
 	enum untracked_status_type show_untracked_files;
 	const char *ignore_submodule_arg;
 	char color_palette[WT_STATUS_MAXSLOT][COLOR_MAXLEN];
-- 
2.13.6

