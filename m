From: Ronald Weiss <weiss.ronald@gmail.com>
Subject: [PATCH v3 1/2] add: add --ignore-submodules[=<when>] parameter
Date: Tue, 08 Apr 2014 01:01:12 +0200
Message-ID: <53432E38.4080403@gmail.com>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>	<5335A78C.60401@web.de>	<CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com>	<53374E49.9000702@gmail.com>	<533874F9.3090802@web.de>	<5338AC36.6000109@gmail.com>	<5338B1B0.3050703@gmail.com>	<5339BAE4.8020306@web.de> <CABxC_L8_tQrANXji_Z0LfigxsAuzSDj3K9ndTGOTHh2ctHvc6A@mail.gmail.com> <5339F122.60801@gmail.com> <5339FBB4.1010101@gmail.com> <533B2036.3050506@web.de> <533B36AA.3090600@gmail.com> <533C5CBD.4050601@web.de> <533C6B57.3080901@gmail.com> <534180BC.308@web.de> <53431CB8.2050600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 08 01:01:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXIXz-0005qx-QC
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 01:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309AbaDGXBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 19:01:15 -0400
Received: from mail-we0-f170.google.com ([74.125.82.170]:42534 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197AbaDGXBN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 19:01:13 -0400
Received: by mail-we0-f170.google.com with SMTP id w61so123932wes.29
        for <git@vger.kernel.org>; Mon, 07 Apr 2014 16:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=MVPE+xX9VTu4EuW3uRkllqjLjQllEgRCa5BVxNaZOMM=;
        b=B/+4NeU4paGLiaho6C+oIOHRBpYljFRKrgRgCctgB5Cnaf553jqU/uCCwu9Oh1+mH6
         VRIhK3baZzItyRK0uDHForO+KRaFSh3ve5E1Es26j+NB1hIY4WwlOB6NXRSOgWwxueWv
         qjAjmdjight1+kq0Q1jjP5jeqmkD6/tFxwNs58DDOEdJEfScA9mNrq4WWxQGm2qzc5kQ
         zE4n3xS5CdDuq3w4rhn/kVJGd9AYxlKGgyrxw+l7KM5yOciROoC4SqICL6Fnq6A+j2bc
         CLhYsFGzilIqnSdaQPZLSaoGdH2S2XRPvHYyXxF22KZP+8WFNPuJhiSyyFc3+sYabIb1
         +6SA==
X-Received: by 10.194.173.193 with SMTP id bm1mr155694wjc.55.1396911672745;
        Mon, 07 Apr 2014 16:01:12 -0700 (PDT)
Received: from [10.0.1.101] (chello089173067059.chello.sk. [89.173.67.59])
        by mx.google.com with ESMTPSA id 45sm453901eeh.9.2014.04.07.16.01.11
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 07 Apr 2014 16:01:11 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <53431CB8.2050600@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245913>

Allow overriding the ignore setting from config, using the command line
parameter like diff and status have. Git add currently doesn't honor
ignore from .gitmodules, but it does honor it from .git/config. And
support for .gitmodules will come in another patch.

Useful <when> values are 'none' and 'all' (the default), the other values
('dirty' and 'untracked') being equivalent to 'none' for add's purposes.

Also add ignore_submodules_arg parameter to function add_files_to_cache,
which will allow implementing --ignore-submodules also for other commands
using this function (for commit command, in particular, coming in
subsequent commit). This requires compilo fixes in checkout.c and commit.c

Signed-off-by: Ronald Weiss <weiss.ronald@gmail.com>
---
I have changed order of commits, from what Jens proposed, to avoid the patch
for commit (coming right after this one) having to mess too much with add's
source code.

If anyone disagrees, let me know, and I will redo it as needed.

I'll look in to the related "add [-f] vs .gitmodules:ignore=all" problem
soon.

 Documentation/git-add.txt        |  7 ++++++-
 builtin/add.c                    | 21 +++++++++++++++----
 builtin/checkout.c               |  2 +-
 builtin/commit.c                 |  2 +-
 cache.h                          |  2 +-
 t/t3704-add-ignore-submodules.sh | 45 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 71 insertions(+), 8 deletions(-)
 create mode 100644 t/t3704-add-ignore-submodules.sh

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 48754cb..be2e7b5 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git add' [-n] [-v] [--force | -f] [--interactive | -i] [--patch | -p]
 	  [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update | -u]]
 	  [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing]
-	  [--] [<pathspec>...]
+	  [--ignore-submodules[=<when>]] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -160,6 +160,11 @@ today's "git add <pathspec>...", ignoring removed files.
 	be ignored, no matter if they are already present in the work
 	tree or not.
 
+--ignore-submodules[=<when>]::
+	Can be used to override any settings of the 'submodule.*.ignore'
+	option in linkgit:git-config[1] or linkgit:gitmodules[5].
+	<when> can be either "none" or "all", which is the default.
+
 \--::
 	This option can be used to separate command-line options from
 	the list of files, (useful when filenames might be mistaken
diff --git a/builtin/add.c b/builtin/add.c
index 672adc0..72ef792 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -168,7 +168,8 @@ static void update_callback(struct diff_queue_struct *q,
 
 static void update_files_in_cache(const char *prefix,
 				  const struct pathspec *pathspec,
-				  struct update_callback_data *data)
+				  struct update_callback_data *data,
+				  const char *ignore_submodules_arg)
 {
 	struct rev_info rev;
 
@@ -180,17 +181,24 @@ static void update_files_in_cache(const char *prefix,
 	rev.diffopt.format_callback = update_callback;
 	rev.diffopt.format_callback_data = data;
 	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
+
+	if (ignore_submodules_arg) {
+		DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
+		handle_ignore_submodules_arg(&rev.diffopt, ignore_submodules_arg);
+	}
+
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
 }
 
 int add_files_to_cache(const char *prefix,
-		       const struct pathspec *pathspec, int flags)
+		       const struct pathspec *pathspec, int flags,
+		       const char *ignore_submodules_arg)
 {
 	struct update_callback_data data;
 
 	memset(&data, 0, sizeof(data));
 	data.flags = flags;
-	update_files_in_cache(prefix, pathspec, &data);
+	update_files_in_cache(prefix, pathspec, &data, ignore_submodules_arg);
 	return !!data.add_errors;
 }
 
@@ -342,6 +350,8 @@ static int ignore_add_errors, intent_to_add, ignore_missing;
 static int addremove = ADDREMOVE_DEFAULT;
 static int addremove_explicit = -1; /* unspecified */
 
+static char *ignore_submodule_arg;
+
 static int ignore_removal_cb(const struct option *opt, const char *arg, int unset)
 {
 	/* if we are told to ignore, we are not adding removals */
@@ -367,6 +377,9 @@ static struct option builtin_add_options[] = {
 	OPT_BOOL( 0 , "refresh", &refresh_only, N_("don't add, only refresh the index")),
 	OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
 	OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
+	{ OPTION_STRING, 0, "ignore-submodules", &ignore_submodule_arg, N_("when"),
+	  N_("ignore changes to submodules, optional when: all, none. (Default: all)"),
+	  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 	OPT_END(),
 };
 
@@ -576,7 +589,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		memset(&pathspec, 0, sizeof(pathspec));
 	}
 	update_data.flags = flags & ~ADD_CACHE_IMPLICIT_DOT;
-	update_files_in_cache(prefix, &pathspec, &update_data);
+	update_files_in_cache(prefix, &pathspec, &update_data, ignore_submodule_arg);
 
 	exit_status |= !!update_data.add_errors;
 	if (add_new_files)
diff --git a/builtin/checkout.c b/builtin/checkout.c
index ada51fa..22a4b48 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -525,7 +525,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			 * entries in the index.
 			 */
 
-			add_files_to_cache(NULL, NULL, 0);
+			add_files_to_cache(NULL, NULL, 0, NULL);
 			/*
 			 * NEEDSWORK: carrying over local changes
 			 * when branches have different end-of-line
diff --git a/builtin/commit.c b/builtin/commit.c
index 26b2986..0db215b 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -360,7 +360,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 	 */
 	if (all || (also && pathspec.nr)) {
 		fd = hold_locked_index(&index_lock, 1);
-		add_files_to_cache(also ? prefix : NULL, &pathspec, 0);
+		add_files_to_cache(also ? prefix : NULL, &pathspec, 0, NULL);
 		refresh_cache_or_die(refresh_flags);
 		update_main_cache_tree(WRITE_TREE_SILENT);
 		if (write_cache(fd, active_cache, active_nr) ||
diff --git a/cache.h b/cache.h
index ebe9a40..5ef8dd6 100644
--- a/cache.h
+++ b/cache.h
@@ -1282,7 +1282,7 @@ void packet_trace_identity(const char *prog);
  * return 0 if success, 1 - if addition of a file failed and
  * ADD_FILES_IGNORE_ERRORS was specified in flags
  */
-int add_files_to_cache(const char *prefix, const struct pathspec *pathspec, int flags);
+int add_files_to_cache(const char *prefix, const struct pathspec *pathspec, int flags, const char *ignore_submodules_arg);
 
 /* diff.c */
 extern int diff_auto_refresh_index;
diff --git a/t/t3704-add-ignore-submodules.sh b/t/t3704-add-ignore-submodules.sh
new file mode 100644
index 0000000..db58f0c
--- /dev/null
+++ b/t/t3704-add-ignore-submodules.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+#
+# Copyright (c) 2014 Ronald Weiss
+#
+
+test_description='Test of git add with ignoring submodules'
+
+. ./test-lib.sh
+
+test_expect_success 'create dirty submodule' '
+	test_create_repo sm && (
+		cd sm &&
+		>foo &&
+		git add foo &&
+		git commit -m "Add foo"
+	) &&
+	git submodule add ./sm &&
+	git commit -m "Add sm" && (
+		cd sm &&
+		echo bar >> foo &&
+		git add foo &&
+		git commit -m "Update foo"
+	)
+'
+
+test_expect_success 'add --ignore-submodules ignores submodule' '
+	git reset &&
+	git add -u --ignore-submodules &&
+	git diff --cached --exit-code --ignore-submodules=none
+'
+
+test_expect_success 'add --ignore-submodules=all ignores submodule' '
+	git reset &&
+	git add -u --ignore-submodules=all &&
+	git diff --cached --exit-code --ignore-submodules=none
+'
+
+test_expect_success 'add --ignore-submodules=none overrides ignore=all from config' '
+	git reset &&
+	git config submodule.sm.ignore all &&
+	git add -u --ignore-submodules=none &&
+	test_must_fail git diff --cached --exit-code --ignore-submodules=none
+'
+
+test_done
-- 
1.9.1.3.gef38fe4
 
