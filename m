From: Ronald Weiss <weiss.ronald@gmail.com>
Subject: [PATCH v4 2/2] commit: add --ignore-submodules[=<when>] parameter
Date: Sun, 13 Apr 2014 00:49:56 +0200
Message-ID: <5349C314.50500@gmail.com>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>	<5335A78C.60401@web.de>	<CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com>	<53374E49.9000702@gmail.com>	<533874F9.3090802@web.de>	<5338AC36.6000109@gmail.com>	<5338B1B0.3050703@gmail.com>	<5339BAE4.8020306@web.de> <CABxC_L8_tQrANXji_Z0LfigxsAuzSDj3K9ndTGOTHh2ctHvc6A@mail.gmail.com> <5339F122.60801@gmail.com> <5339FBB4.1010101@gmail.com> <533B2036.3050506@web.de> <533B36AA.3090600@gmail.com> <533C5CBD.4050601@web.de> <533C6B57.3080901@gmail.com> <534180BC.308@web.de> <53431CB8.2050600@gmail.com> <53432EA5.5060102@gmail.com> <53444368.9050607@web.de> <5349BC2C.9030509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 13 00:50:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZ6kT-0004kV-9W
	for gcvg-git-2@plane.gmane.org; Sun, 13 Apr 2014 00:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756287AbaDLWuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 18:50:01 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:55870 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbaDLWuA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 18:50:00 -0400
Received: by mail-ee0-f46.google.com with SMTP id t10so5269143eei.33
        for <git@vger.kernel.org>; Sat, 12 Apr 2014 15:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=7NA1RqF9lf47PqtKyXnHIRpaHH840gzWLq38qpOtG64=;
        b=bTPEchg97mIRoigQYskMdFqWFOYTMG5T3syUq97CkUrwzGg+foPFjH07fW4p2lutZe
         SgUARaqhQYHBc2HN4dj2zT8OOb+jplsWJgtr5/EIgu8dZ/l6QosPQ89DNQjbVsua5WOo
         YVyaCetqjTpBBY8/n5l6XlzJ0xdq93WEu52RATm1u5rGVVW/jv/FsBsxOlS20rgKfQG9
         TR7j5xNOdLL14v6nSShMR00sjFotOA85kG25J6ueQotnxPBwchM/wpQa1fGrIoy4V0bR
         Fb5lxm0+vM3EHvhtmnZ2JY0QXetmCgz48w+ACHLNO3pXcf+IflIJnq6/OOiBNhO0JOqu
         +m+A==
X-Received: by 10.15.67.142 with SMTP id u14mr39674023eex.19.1397342998763;
        Sat, 12 Apr 2014 15:49:58 -0700 (PDT)
Received: from [10.0.1.226] (chello089173067059.chello.sk. [89.173.67.59])
        by mx.google.com with ESMTPSA id o7sm28553128eew.25.2014.04.12.15.49.57
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Apr 2014 15:49:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <5349BC2C.9030509@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246201>

Allow ignoring submodules (or not) by command line switch, like diff
and status do.

Git commit honors the 'ignore' setting from .gitmodules or .git/config,
but didn't allow to override it from command line.

This patch depends on Jens Lehmann's patch "commit -m: commit staged
submodules regardless of ignore config". Without it,
"commit -m --ignore-submodules" would not work and tests introduced
here would fail.

Signed-off-by: Ronald Weiss <weiss.ronald@gmail.com>
---
 Documentation/git-commit.txt        |  7 ++++
 builtin/commit.c                    |  8 +++-
 t/t7513-commit-ignore-submodules.sh | 78 +++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+), 1 deletion(-)
 create mode 100644 t/t7513-commit-ignore-submodules.sh

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 0bbc8f5..de0e8fe 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
 	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
+	   [--ignore-submodules[=<when>]]
 	   [-i | -o] [-S[<key-id>]] [--] [<file>...]
 
 DESCRIPTION
@@ -277,6 +278,12 @@ The possible options are:
 The default can be changed using the status.showUntrackedFiles
 configuration variable documented in linkgit:git-config[1].
 
+--ignore-submodules[=<when>]::
+	Can be used to override any settings of the 'submodule.*.ignore'
+	option in linkgit:git-config[1] or linkgit:gitmodules[5].
+	<when> can be either "none", "dirty, "untracked" or "all", which
+	is the default.
+
 -v::
 --verbose::
 	Show unified diff between the HEAD commit and what
diff --git a/builtin/commit.c b/builtin/commit.c
index a148e28..8c4d05e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -361,7 +361,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 	 */
 	if (all || (also && pathspec.nr)) {
 		fd = hold_locked_index(&index_lock, 1);
-		add_files_to_cache(also ? prefix : NULL, &pathspec, 0, NULL);
+		add_files_to_cache(also ? prefix : NULL, &pathspec, 0, ignore_submodule_arg);
 		refresh_cache_or_die(refresh_flags);
 		update_main_cache_tree(WRITE_TREE_SILENT);
 		if (write_cache(fd, active_cache, active_nr) ||
@@ -1526,6 +1526,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "amend", &amend, N_("amend previous commit")),
 		OPT_BOOL(0, "no-post-rewrite", &no_post_rewrite, N_("bypass post-rewrite hook")),
 		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, N_("mode"), N_("show untracked files, optional modes: all, normal, no. (Default: all)"), PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
+		{ OPTION_STRING, 0, "ignore-submodules", &ignore_submodule_arg, N_("when"),
+		  N_("ignore changes to submodules, optional when: all, none. (Default: all)"),
+		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 		/* end commit contents options */
 
 		OPT_HIDDEN_BOOL(0, "allow-empty", &allow_empty,
@@ -1564,6 +1567,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
 					  builtin_commit_usage,
 					  prefix, current_head, &s);
+
+	s.ignore_submodule_arg = ignore_submodule_arg;
+
 	if (dry_run)
 		return dry_run_commit(argc, argv, prefix, current_head, &s);
 	index_file = prepare_index(argc, argv, prefix, current_head, 0);
diff --git a/t/t7513-commit-ignore-submodules.sh b/t/t7513-commit-ignore-submodules.sh
new file mode 100644
index 0000000..52ab37d
--- /dev/null
+++ b/t/t7513-commit-ignore-submodules.sh
@@ -0,0 +1,78 @@
+#!/bin/sh
+#
+# Copyright (c) 2014 Ronald Weiss
+#
+
+test_description='Test of git commit --ignore-submodules'
+
+. ./test-lib.sh
+
+test_expect_success 'create submodule' '
+	test_create_repo sm && (
+		cd sm &&
+		>foo &&
+		git add foo &&
+		git commit -m "Add foo"
+	) &&
+	git submodule add ./sm &&
+	git commit -m "Add sm"
+'
+
+update_sm () {
+	(cd sm &&
+		echo bar >> foo &&
+		git add foo &&
+		git commit -m "Updated foo"
+	)
+}
+
+test_expect_success 'commit -a --ignore-submodules=all ignores dirty submodule' '
+	update_sm &&
+	test_must_fail git commit -a --ignore-submodules=all -m "Update sm"
+'
+
+test_expect_success 'commit -a --ignore-submodules=none overrides ignore=all setting' '
+	update_sm &&
+	git config submodule.sm.ignore all &&
+	git commit -a --ignore-submodules=none -m "Update sm" &&
+	git diff --exit-code --ignore-submodules=none &&
+	git diff --cached --exit-code --ignore-submodules=none
+'
+
+test_expect_success 'commit --ignore-submodules status of submodule with untracked content' '
+	GIT_EDITOR=cat &&
+	export GIT_EDITOR &&
+	echo untracked > sm/untracked &&
+
+	test_might_fail git commit --ignore-submodules=none > output &&
+	test_i18ngrep modified output &&
+
+	test_might_fail git commit --ignore-submodules=untracked > output &&
+	test_must_fail test_i18ngrep modified output &&
+
+	test_might_fail git commit --ignore-submodules=dirty > output &&
+	test_must_fail test_i18ngrep modified output &&
+
+	test_might_fail git commit --ignore-submodules=all > output &&
+	test_must_fail test_i18ngrep modified output
+'
+
+test_expect_success 'commit --ignore-submodules status of dirty submodule' '
+	GIT_EDITOR=cat &&
+	export GIT_EDITOR &&
+	echo dirty > sm/foo &&
+
+	test_might_fail git commit --ignore-submodules=none > output &&
+	test_i18ngrep modified output &&
+
+	test_might_fail git commit --ignore-submodules=untracked > output &&
+	test_i18ngrep modified output &&
+
+	test_might_fail git commit --ignore-submodules=dirty > output &&
+	test_must_fail test_i18ngrep modified output &&
+
+	test_might_fail git commit --ignore-submodules=all > output &&
+	test_must_fail test_i18ngrep modified output
+'
+
+test_done
-- 
1.9.1.3.g7790cde.dirty
 
