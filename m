From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 00/22] rid git-checkout of too-intimate knowledge of new worktree
Date: Fri, 17 Jul 2015 18:59:55 -0400
Message-ID: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 01:01:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGEd3-0002EW-78
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 01:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752794AbbGQXBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 19:01:12 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:32924 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965AbbGQXBL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 19:01:11 -0400
Received: by igbpg9 with SMTP id pg9so5819254igb.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 16:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=8DevLkkp92NeQI4WBQXEk5NcL1XGinFF7vZWZazRBYI=;
        b=jjrbK2urANqBp81ulstww55x4yQLM+hb0cQQs++aEfkRtpZ9VZ71A9Rz0AyYPCjoOb
         7+EQ2OaA9JB7iF3133Izs8qG4tYWtksP7MPl0hxOv2Fkb2i9fN4qZHmjUU/HLFUR4uwn
         IRwyu4mIz+sLbn8kJ5wwZBp6ELloFJ5PQo5DANr5PUwV3F9cl2ifcX5rjJD4I61H00T9
         in8kxfF4uCrPscrCFGwT9jev9SULtINIVEMiwG19CnlMXvMrmMkwRZLBfHD/O+0wACFV
         x0h0JyUkEqF3vYT7yiqdRs9yOOTFI2LDtk+fr7I9XeHzTynGjUfe6R6UE2bWXGe9AsAh
         Oycw==
X-Received: by 10.107.169.10 with SMTP id s10mr20837098ioe.138.1437174071158;
        Fri, 17 Jul 2015 16:01:11 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id 140sm8414824ion.16.2015.07.17.16.01.09
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jul 2015 16:01:10 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274129>

This is v3 of [1] which rids git-checkout of specialized knowledge that
it's operating in a newly created linked worktree. Thanks to Junio for
his review, and Duy and Michael J Gruber for additional observations.

A v2 to v3 interdiff is included below.

Changes since v2:

* patch 06/22: strip only trailing ".git" rather than "/.git" from
  "'branch' is already checked out at '/some/patch/.git'" message[2];
  also reword commit message slightly to better emphasize that the
  trailing ".git" is more than a mere cosmetic issue[2]

* patch 10/22 (new): change worktree setup message from "Enter
  <path>..." to "Preparing <path>..." to avoid possibly confusing the
  user into thinking that 'cd <path>' occurred[3]

* patch 13/22: add tests of -b/-B/--detach exclusivity

* patch 14/22 (new): suppress accidental triggering of branch
  auto-vivication with "git worktree add --detach <path>"; instead treat
  it as shorthand for "git worktree add --detach <path> HEAD"[3]

[1]: http://thread.gmane.org/gmane.comp.version-control.git/274024
[2]: http://article.gmane.org/gmane.comp.version-control.git/274035
[3]: http://article.gmane.org/gmane.comp.version-control.git/274083

Eric Sunshine (22):
  checkout: avoid resolving HEAD unnecessarily
  checkout: name check_linked_checkouts() more meaningfully
  checkout: improve die_if_checked_out() robustness
  checkout: die_if_checked_out: simplify strbuf management
  checkout: generalize die_if_checked_out() branch name argument
  checkout: check_linked_checkout: improve "already checked out"
    aesthetic
  checkout: check_linked_checkout: simplify symref parsing
  checkout: teach check_linked_checkout() about symbolic link HEAD
  branch: publish die_if_checked_out()
  worktree: improve worktree setup message
  worktree: simplify new branch (-b/-B) option checking
  worktree: introduce options container
  worktree: make --detach mutually exclusive with -b/-B
  worktree: add: suppress auto-vivication with --detach and no <branch>
  worktree: make branch creation distinct from worktree population
  worktree: elucidate environment variables intended for child processes
  worktree: add_worktree: construct worktree-population command locally
  worktree: detect branch-name/detached and error conditions locally
  worktree: make setup of new HEAD distinct from worktree population
  worktree: avoid resolving HEAD unnecessarily
  worktree: populate via "git reset --hard" rather than "git checkout"
  checkout: drop intimate knowledge of newly created worktree

 branch.c                |  67 ++++++++++++++++++++++++++
 branch.h                |   7 +++
 builtin/checkout.c      |  82 +++-----------------------------
 builtin/worktree.c      | 123 ++++++++++++++++++++++++++++++++----------------
 t/t2025-worktree-add.sh |  34 +++++++++++++
 5 files changed, 197 insertions(+), 116 deletions(-)

-- 
2.5.0.rc2.378.g0af52e8

---- 8< ----
diff --git a/branch.c b/branch.c
index dfd7698..af9480f 100644
--- a/branch.c
+++ b/branch.c
@@ -347,7 +347,7 @@ static void check_linked_checkout(const char *branch, const char *id)
 	} else
 		strbuf_addstr(&gitdir, get_git_common_dir());
 	skip_prefix(branch, "refs/heads/", &branch);
-	strbuf_strip_suffix(&gitdir, "/.git");
+	strbuf_strip_suffix(&gitdir, ".git");
 	die(_("'%s' is already checked out at '%s'"), branch, gitdir.buf);
 done:
 	strbuf_release(&path);
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 2873064..5d9371c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -264,7 +264,7 @@ static int add_worktree(const char *path, const char *refname,
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, 1, "../..\n");
 
-	fprintf_ln(stderr, _("Enter %s (identifier %s)"), path, name);
+	fprintf_ln(stderr, _("Preparing %s (identifier %s)"), path, name);
 
 	argv_array_pushf(&child_env, "%s=%s", GIT_DIR_ENVIRONMENT, sb_git.buf);
 	argv_array_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
@@ -335,7 +335,7 @@ static int add(int ac, const char **av, const char *prefix)
 	if (opts.force_new_branch)
 		opts.new_branch = new_branch_force;
 
-	if (ac < 2 && !opts.new_branch) {
+	if (ac < 2 && !opts.new_branch && !opts.detach) {
 		int n;
 		const char *s = worktree_basename(path, &n);
 		opts.new_branch = xstrndup(s, n);
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 9e30690..8267411 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -153,6 +153,14 @@ test_expect_success '"add -b" with <branch> omitted' '
 	test_cmp_rev HEAD burble
 '
 
+test_expect_success '"add --detach" with <branch> omitted' '
+	git worktree add --detach fishhook &&
+	git rev-parse HEAD >expected &&
+	git -C fishhook rev-parse HEAD >actual &&
+	test_cmp expected actual &&
+	test_must_fail git -C fishhook symbolic-ref HEAD
+'
+
 test_expect_success '"add" with <branch> omitted' '
 	git worktree add wiffle/bat &&
 	test_cmp_rev HEAD bat
@@ -167,4 +175,22 @@ test_expect_success '"add" auto-vivify does not clobber existing branch' '
 	test_path_is_missing precious
 '
 
+test_expect_success '"add" no auto-vivify with --detach and <branch> omitted' '
+	git worktree add --detach mish/mash &&
+	test_must_fail git rev-parse mash -- &&
+	test_must_fail git -C mish/mash symbolic-ref HEAD
+'
+
+test_expect_success '"add" -b/-B mutually exclusive' '
+	test_must_fail git worktree add -b poodle -B poodle bamboo master
+'
+
+test_expect_success '"add" -b/--detach mutually exclusive' '
+	test_must_fail git worktree add -b poodle --detach bamboo master
+'
+
+test_expect_success '"add" -B/--detach mutually exclusive' '
+	test_must_fail git worktree add -B poodle --detach bamboo master
+'
+
 test_done
---- 8< ----
