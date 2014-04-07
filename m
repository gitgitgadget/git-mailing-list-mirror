From: Ronald Weiss <weiss.ronald@gmail.com>
Subject: [PATCH v3 2/2] commit: add --ignore-submodules[=<when>] parameter
Date: Tue, 08 Apr 2014 01:03:01 +0200
Message-ID: <53432EA5.5060102@gmail.com>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>	<5335A78C.60401@web.de>	<CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com>	<53374E49.9000702@gmail.com>	<533874F9.3090802@web.de>	<5338AC36.6000109@gmail.com>	<5338B1B0.3050703@gmail.com>	<5339BAE4.8020306@web.de> <CABxC_L8_tQrANXji_Z0LfigxsAuzSDj3K9ndTGOTHh2ctHvc6A@mail.gmail.com> <5339F122.60801@gmail.com> <5339FBB4.1010101@gmail.com> <533B2036.3050506@web.de> <533B36AA.3090600@gmail.com> <533C5CBD.4050601@web.de> <533C6B57.3080901@gmail.com> <534180BC.308@web.de> <53431CB8.2050600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 08 01:03:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXIZL-0006ZC-3r
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 01:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755051AbaDGXDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 19:03:05 -0400
Received: from mail-we0-f176.google.com ([74.125.82.176]:54680 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754637AbaDGXDD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 19:03:03 -0400
Received: by mail-we0-f176.google.com with SMTP id x48so124945wes.7
        for <git@vger.kernel.org>; Mon, 07 Apr 2014 16:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ppXkhVlsjQAjuZZ5JJohk6+pQsY8f7d1RQ0szWU64CE=;
        b=QWegT1uAMECXv0efD4EsVTCCc9Sar/EAm/6Zs+ad1J9RG1coo0LiPRLyBh1OWnanij
         26dloR+lB/HugG/Chxw/s//9VCcdUcqO3xanfKjIEdOyQEuNHAt5gFsyMmh6Q2hbNj0B
         pKzFptevpknfIMgizzKcXo1DjjreC3ACmzJEATU7i1jHM46Be3FB+jTpVmj9d6I2wIVX
         OYTMHTeVwe8A81Me7+QjGXbTLufz29s8DWfYCfZBwZFeu1+9hM1OJMM4GbSd/FWHoX7/
         ECfrJXXc2Z9+tP/m9HtR9WKx1lJZm4aHKh3H6+wxqKDm9IHpqxgXFYZrbsVqVWTuX1lQ
         BXIA==
X-Received: by 10.180.75.202 with SMTP id e10mr28441421wiw.50.1396911781978;
        Mon, 07 Apr 2014 16:03:01 -0700 (PDT)
Received: from [10.0.1.101] (chello089173067059.chello.sk. [89.173.67.59])
        by mx.google.com with ESMTPSA id m42sm444250eex.21.2014.04.07.16.03.00
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 07 Apr 2014 16:03:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <53431CB8.2050600@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245914>

Git commit honors the 'ignore' setting from .gitmodules or .git/config,
but didn't allow to override it from command line, like other commands do.

Useful <when> values for commit are 'all' (default) or 'none'. The others
('dirty' and 'untracked') have same effect as 'none', as commit is only
interested in whether the submodule's HEAD differs from what is commited
in the superproject.

This patch depends on Jens Lehmann's patch "commit -m: commit staged
submodules regardless of ignore config". Without it,
"commit -m --ignore-submodules" would not work and tests introduced
here would fail.

Signed-off-by: Ronald Weiss <weiss.ronald@gmail.com>
---
 Documentation/git-commit.txt        |  6 ++++++
 builtin/commit.c                    |  8 ++++++-
 t/t7513-commit-ignore-submodules.sh | 42 +++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 1 deletion(-)
 create mode 100644 t/t7513-commit-ignore-submodules.sh

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 1a7616c..8d3b2db 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
 	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
+	   [--ignore-submodules[=<when>]]
 	   [-i | -o] [-S[<keyid>]] [--] [<file>...]
 
 DESCRIPTION
@@ -271,6 +272,11 @@ The possible options are:
 The default can be changed using the status.showUntrackedFiles
 configuration variable documented in linkgit:git-config[1].
 
+--ignore-submodules[=<when>]::
+	Can be used to override any settings of the 'submodule.*.ignore'
+	option in linkgit:git-config[1] or linkgit:gitmodules[5].
+	<when> can be either "none" or "all", which is the default.
+
 -v::
 --verbose::
 	Show unified diff between the HEAD commit and what
diff --git a/builtin/commit.c b/builtin/commit.c
index 0db215b..121c185 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -360,7 +360,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 	 */
 	if (all || (also && pathspec.nr)) {
 		fd = hold_locked_index(&index_lock, 1);
-		add_files_to_cache(also ? prefix : NULL, &pathspec, 0, NULL);
+		add_files_to_cache(also ? prefix : NULL, &pathspec, 0, ignore_submodule_arg);
 		refresh_cache_or_die(refresh_flags);
 		update_main_cache_tree(WRITE_TREE_SILENT);
 		if (write_cache(fd, active_cache, active_nr) ||
@@ -1492,6 +1492,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "amend", &amend, N_("amend previous commit")),
 		OPT_BOOL(0, "no-post-rewrite", &no_post_rewrite, N_("bypass post-rewrite hook")),
 		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, N_("mode"), N_("show untracked files, optional modes: all, normal, no. (Default: all)"), PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
+		{ OPTION_STRING, 0, "ignore-submodules", &ignore_submodule_arg, N_("when"),
+		  N_("ignore changes to submodules, optional when: all, none. (Default: all)"),
+		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 		/* end commit contents options */
 
 		OPT_HIDDEN_BOOL(0, "allow-empty", &allow_empty,
@@ -1531,6 +1534,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
index 0000000..83ce04c
--- /dev/null
+++ b/t/t7513-commit-ignore-submodules.sh
@@ -0,0 +1,42 @@
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
+test_done
-- 
1.9.1.3.gef38fe4
 
