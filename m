From: Erick Mattos <erick.mattos@gmail.com>
Subject: [PATCH v4] git checkout -b: unparent the new branch with -o
Date: Wed, 17 Mar 2010 15:46:24 -0300
Message-ID: <1268851584-10988-1-git-send-email-erick.mattos@gmail.com>
Cc: git@vger.kernel.org, Erick Mattos <erick.mattos@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 19:47:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NryHR-00029P-Ej
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 19:47:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755504Ab0CQSrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 14:47:40 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:63262 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755496Ab0CQSri (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 14:47:38 -0400
Received: by qyk9 with SMTP id 9so644636qyk.1
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 11:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=oFtJl3wXJHgwx+3uCyJnmUJVd35hd1XK1HkyR37FNuQ=;
        b=cbKF8YDAeH+MPYpaZ28mYh/UIkp+XGgE8807Lfe/XMsC6zEiUF/lTVsPAN2VKFWcKQ
         TPtRCIJ6FM0hfIiE4oHT4IG/QFPdhi4YJlEfycbDyo0b1hR/Fa0YqroRuVxuHKhdWnMA
         Hh3IZUE0dNq6oeBAr0Xx1ZUpTN6bxx0PI39UM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=i6cmZxdaCbuAy1p2ZaR2eFzXLJ+woCtx6h8rGMtBh8oZB/cDKnNh3fS38HMdQVy4+B
         qzmABJQAUT4pDLvV4T1y2GX7J8dNCzUVmapdJ1+31Ilf3MP9iidvoSNWOks+hKV0r3HQ
         MYMcttGOeI2Zx16ytYo08JkNctY5ScbRSAoDc=
Received: by 10.229.131.39 with SMTP id v39mr1148002qcs.66.1268851657959;
        Wed, 17 Mar 2010 11:47:37 -0700 (PDT)
Received: from localhost.localdomain ([187.15.3.54])
        by mx.google.com with ESMTPS id 20sm4899250qyk.0.2010.03.17.11.47.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Mar 2010 11:47:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.2.277.gc3e85
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142427>

Sometimes it is interesting to start a new unparented branch in an
existing repository.

The new -o/--orphan is intended to solve this situation allowing the
creation of a new branch unparented to any other.

After the 'checkout -o -b' you are in an new unborn branch ready to be
committed which will start a new history without any ancestry.

By a 'git commit -a' the commit tree is going to resemble the one from
the previous branch.  This way you begin a "mostly common paths" work
flow.

In case you are doing this orphan branch intending to start a "no common
paths" work flow then with a 'git rm -rf .' you are ready to go.

Signed-off-by: Erick Mattos <erick.mattos@gmail.com>
---

Trying to be concise and more positive on this new option descriptions.  :-)

 Documentation/git-checkout.txt |   18 ++++++++++++++
 builtin/checkout.c             |   10 ++++++-
 t/t2017-checkout-orphan.sh     |   49 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 2 deletions(-)
 create mode 100755 t/t2017-checkout-orphan.sh

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 37c1810..35a6194 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git checkout' [-q] [-f] [-m] [<branch>]
+'git checkout' [-q] [-f] [-m] [-b <new_branch> [-o]]
 'git checkout' [-q] [-f] [-m] [-b <new_branch>] [<start_point>]
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
 'git checkout' --patch [<tree-ish>] [--] [<paths>...]
@@ -26,6 +27,18 @@ use the --track or --no-track options, which will be passed to `git
 branch`.  As a convenience, --track without `-b` implies branch
 creation; see the description of --track below.
 
+When using -b, it is possible to use the option -o to set the new branch
+as unparented thus unrelated to the previous branch.  After the command
+you are in an new unborn branch ready to be committed which will start a
+new history without any ancestry.
+
+By a 'git commit -a' the commit tree is going to resemble the one from
+the previous branch.  This way you begin a "mostly common paths" work
+flow.
+
+In case you are doing this orphan branch intending to start a "no common
+paths" work flow then with a 'git rm -rf .' you are ready to go.
+
 When <paths> or --patch are given, this command does *not* switch
 branches.  It updates the named paths in the working tree from
 the index file, or from a named <tree-ish> (most often a commit).  In
@@ -86,6 +99,11 @@ explicitly give a name with '-b' in such a case.
 	Do not set up "upstream" configuration, even if the
 	branch.autosetupmerge configuration variable is true.
 
+-o::
+--orphan::
+	When creating a new branch, set it up as unparented thus
+	unrelated to the previous branch.
+
 -l::
 	Create the new branch's reflog; see linkgit:git-branch[1] for
 	details.
diff --git a/builtin/checkout.c b/builtin/checkout.c
index acefaaf..405de7e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -34,6 +34,7 @@ struct checkout_opts {
 
 	const char *new_branch;
 	int new_branch_log;
+	int new_branch_orphan;
 	enum branch_track track;
 };
 
@@ -491,8 +492,9 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 	struct strbuf msg = STRBUF_INIT;
 	const char *old_desc;
 	if (opts->new_branch) {
-		create_branch(old->name, opts->new_branch, new->name, 0,
-			      opts->new_branch_log, opts->track);
+		if (!opts->new_branch_orphan)
+			create_branch(old->name, opts->new_branch, new->name, 0,
+				      opts->new_branch_log, opts->track);
 		new->name = opts->new_branch;
 		setup_branch_path(new);
 	}
@@ -629,6 +631,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT__QUIET(&opts.quiet),
 		OPT_STRING('b', NULL, &opts.new_branch, "new branch", "branch"),
+		OPT_BOOLEAN('o', "orphan", &opts.new_branch_orphan, "make the new branch unparented"),
 		OPT_BOOLEAN('l', NULL, &opts.new_branch_log, "log for new branch"),
 		OPT_SET_INT('t', "track",  &opts.track, "track",
 			BRANCH_TRACK_EXPLICIT),
@@ -677,6 +680,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		opts.new_branch = argv0 + 1;
 	}
 
+	if (opts.new_branch_orphan && !opts.new_branch)
+		die("-o is used only with -b");
+
 	if (conflict_style) {
 		opts.merge = 1; /* implied */
 		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
new file mode 100755
index 0000000..c1b77ac
--- /dev/null
+++ b/t/t2017-checkout-orphan.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Erick Mattos
+#
+
+test_description='git checkout -b
+
+Tests for -o functionality.'
+
+. ./test-lib.sh
+
+TEST_FILE=foo
+
+test_expect_success 'Setup' '
+	echo "initial" >"$TEST_FILE" &&
+	git add "$TEST_FILE" &&
+	git commit -m "First Commit"
+'
+
+test_expect_success '-b without -o checkout into a new clone branch' '
+	test_tick &&
+	echo "Test 1" >>"$TEST_FILE" &&
+	git add "$TEST_FILE" &&
+	git commit -m "Second Commit" &&
+	git log --pretty=oneline >base &&
+	git checkout -b alpha &&
+	test "alpha" = "$(git symbolic-ref HEAD | sed "s,.*/,,")" &&
+	git log --pretty=oneline >actual &&
+	test_cmp base actual
+'
+
+test_expect_success '-b with -o checkout into an orphan branch' '
+	git checkout -ob beta &&
+	test_must_fail PAGER= git log >/dev/null 2>/dev/null &&
+	test "beta" = "$(git symbolic-ref HEAD | sed "s,.*/,,")" &&
+	test_tick &&
+	echo "Test 2" >>"$TEST_FILE" &&
+	git add "$TEST_FILE" &&
+	git commit -m "Third Commit" &&
+	git log --pretty=oneline >actual &&
+	test 1 -eq $(wc -l actual | sed "s/ .*//") &&
+	! test_cmp base actual
+'
+
+test_expect_success '-o must be rejected without -b' '
+	test_must_fail git checkout -o alpha
+'
+
+test_done
-- 
1.7.0.2.277.gc3e85
