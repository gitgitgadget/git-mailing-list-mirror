From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 3/3] builtin/checkout: learn -B
Date: Thu, 24 Jun 2010 03:29:00 +0800
Message-ID: <1277321340-4000-4-git-send-email-rctay89@gmail.com>
References: <1277140782-4064-1-git-send-email-rctay89@gmail.com>
 <1277321340-4000-1-git-send-email-rctay89@gmail.com>
 <1277321340-4000-2-git-send-email-rctay89@gmail.com>
 <1277321340-4000-3-git-send-email-rctay89@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Clemens Buchacher <drizzd@aon.at>,
	Michel Lespinasse <walken@google.com>,
	Erick Mattos <erick.mattos@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 23 21:29:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORVdY-0001e5-LO
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 21:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533Ab0FWT3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 15:29:25 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:61250 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522Ab0FWT3X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 15:29:23 -0400
Received: by mail-px0-f174.google.com with SMTP id 7so408429pxi.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 12:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=P9dFysxCbAvmi0VAz8czI0+xdjci4mWwrLJirZi+6Y0=;
        b=OkV8Y5FrUO1J6kQplcSTfqKxdQX5nqq2/TsWPksz6ZrHGodfPQNd6VFEkEzW1wyXOd
         91sktDSi4+6zB1XRqxUD0548bCl1t8wLnYfUdUjDz3qWnA9cNaRZlRMUToFnVhzKBpRV
         3p5oOgLgp6J6U7Z3Lw6K4pgTKhSiWAi8Yefj0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JXFCbkbZpSoM7NZ3X8zi7fDUP61ZrIWmg6V3yFtlIz6Il5FKJ2D64ps+mo08jqc1U8
         VgN0j2AvWKZpI+jJX8PBZIi0m6cBFEWdHED42n1kZmjXULFggGc1DWWO+vm7q7pRo4eA
         yKcT39UympSxuhO6mW5iVRlkEp28TIY1zYKxM=
Received: by 10.143.27.12 with SMTP id e12mr7758214wfj.87.1277321363632;
        Wed, 23 Jun 2010 12:29:23 -0700 (PDT)
Received: from localhost.localdomain (cm156.zeta152.maxonline.com.sg [116.87.152.156])
        by mx.google.com with ESMTPS id p1sm570577rvq.0.2010.06.23.12.29.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jun 2010 12:29:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.513.g06a69
In-Reply-To: <1277321340-4000-3-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149536>

Internally, --track and --orphan still use the 'safe' -b, not -B.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Junio, I didn't wait for your reply to my suggestion about using
"git reset" instead, as I hope to put this out for review before I creep
to bed - I'll put it in the next iteration, if need be.

 Documentation/git-checkout.txt |   21 ++++++++++++++++-
 builtin/checkout.c             |   29 +++++++++++++++++++++----
 t/t2018-checkout-branch.sh     |   45 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 261dd90..97c5144 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git checkout' [-q] [-f] [-m] [<branch>]
-'git checkout' [-q] [-f] [-m] [[-b|--orphan] <new_branch>] [<start_point>]
+'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
 'git checkout' --patch [<tree-ish>] [--] [<paths>...]

@@ -21,7 +21,7 @@ also update `HEAD` to set the specified branch as the current
 branch.

 'git checkout' [<branch>]::
-'git checkout' -b <new branch> [<start point>]::
+'git checkout' -b|-B <new_branch> [<start point>]::

 	This form switches branches by updating the index, working
 	tree, and HEAD to reflect the specified branch.
@@ -31,6 +31,17 @@ were called and then checked out; in this case you can
 use the `--track` or `--no-track` options, which will be passed to
 'git branch'.  As a convenience, `--track` without `-b` implies branch
 creation; see the description of `--track` below.
++
+If `-B` is given, <new_branch> is created if it doesn't exist; otherwise, it
+is reset. This is the transactional equivalent of
++
+------------
+$ git branch -f <branch> [<start point>]
+$ git checkout <branch>
+------------
++
+that is to say, the branch is not reset/created unless "git checkout" is
+successful.

 'git checkout' [--patch] [<tree-ish>] [--] <pathspec>...::

@@ -75,6 +86,12 @@ entries; instead, unmerged entries are ignored.
 	Create a new branch named <new_branch> and start it at
 	<start_point>; see linkgit:git-branch[1] for details.

+-B::
+	Creates the branch <new_branch> and start it at <start_point>;
+	if it already exists, then reset it to <start_point>. This is
+	equivalent to running "git branch" with "-f"; see
+	linkgit:git-branch[1] for details.
+
 -t::
 --track::
 	When creating a new branch, set up "upstream" configuration. See
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3969683..ec2ecfa 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -32,7 +32,11 @@ struct checkout_opts {
 	int writeout_stage;
 	int writeout_error;

+	/* not set by parse_options */
+	int branch_exists;
+
 	const char *new_branch;
+	const char *new_branch_force;
 	const char *new_orphan_branch;
 	int new_branch_log;
 	enum branch_track track;
@@ -511,7 +515,8 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 			}
 		}
 		else
-			create_branch(old->name, opts->new_branch, new->name, 0,
+			create_branch(old->name, opts->new_branch, new->name,
+				      opts->new_branch_force ? 1 : 0,
 				      opts->new_branch_log, opts->track);
 		new->name = opts->new_branch;
 		setup_branch_path(new);
@@ -531,7 +536,7 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 					new->name);
 			else
 				fprintf(stderr, "Switched to%s branch '%s'\n",
-					opts->new_branch ? " a new" : "",
+					opts->branch_exists ? " and reset" : " a new",
 					new->name);
 		}
 		if (old->path && old->name) {
@@ -659,6 +664,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT__QUIET(&opts.quiet),
 		OPT_STRING('b', NULL, &opts.new_branch, "branch",
 		           "create and checkout a new branch"),
+		OPT_STRING('B', NULL, &opts.new_branch_force, "branch",
+		           "create/reset and checkout a branch"),
 		OPT_BOOLEAN('l', NULL, &opts.new_branch_log, "log for new branch"),
 		OPT_SET_INT('t', "track",  &opts.track, "track",
 			BRANCH_TRACK_EXPLICIT),
@@ -689,6 +696,14 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);

+	/* we can assume from now on new_branch = !new_branch_force */
+	if (opts.new_branch && opts.new_branch_force)
+		die("-B cannot be used with -b");
+
+	/* copy -B over to -b, so that we can just check the latter */
+	if (opts.new_branch_force)
+		opts.new_branch = opts.new_branch_force;
+
 	if (patch_mode && (opts.track > 0 || opts.new_branch
 			   || opts.new_branch_log || opts.merge || opts.force))
 		die ("--patch is incompatible with all other options");
@@ -710,7 +725,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)

 	if (opts.new_orphan_branch) {
 		if (opts.new_branch)
-			die("--orphan and -b are mutually exclusive");
+			die("--orphan and -b|-B are mutually exclusive");
 		if (opts.track > 0)
 			die("--orphan cannot be used with -t");
 		opts.new_branch = opts.new_orphan_branch;
@@ -859,8 +874,12 @@ no_reference:
 		if (strbuf_check_branch_ref(&buf, opts.new_branch))
 			die("git checkout: we do not like '%s' as a branch name.",
 			    opts.new_branch);
-		if (!get_sha1(buf.buf, rev))
-			die("git checkout: branch %s already exists", opts.new_branch);
+		if (!get_sha1(buf.buf, rev)) {
+			opts.branch_exists = 1;
+			if (!opts.new_branch_force)
+				die("git checkout: branch %s already exists",
+				    opts.new_branch);
+		}
 		strbuf_release(&buf);
 	}

diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 3c13065..1caffea 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -118,4 +118,49 @@ test_expect_success 'checkout -b to an existing branch fails' '
 	test_must_fail do_checkout branch2 $HEAD2
 '

+test_expect_success 'checkout -B to an existing branch resets branch to HEAD' '
+	git checkout branch1 &&
+
+	do_checkout branch2 "" -B
+'
+
+test_expect_success 'checkout -B to an existing branch with an explicit ref resets branch to that ref' '
+	git checkout branch1 &&
+
+	do_checkout branch2 $HEAD1 -B
+'
+
+test_expect_success 'checkout -B to an existing branch with unmergeable changes fails' '
+	git checkout branch1 &&
+
+	setup_dirty_unmergeable &&
+	test_must_fail do_checkout branch2 $HEAD1 -B &&
+	test_dirty_unmergeable
+'
+
+test_expect_success 'checkout -f -B to an existing branch with unmergeable changes discards changes' '
+	# still dirty and on branch1
+	do_checkout branch2 $HEAD1 "-f -B" &&
+	test_must_fail test_dirty_unmergeable
+'
+
+test_expect_success 'checkout -B to an existing branch preserves mergeable changes' '
+	git checkout branch1 &&
+
+	setup_dirty_mergeable &&
+	do_checkout branch2 $HEAD1 -B &&
+	test_dirty_mergeable
+'
+
+test_expect_success 'checkout -f -B to an existing branch with mergeable changes discards changes' '
+	# clean up from previous test
+	git reset --hard &&
+
+	git checkout branch1 &&
+
+	setup_dirty_mergeable &&
+	do_checkout branch2 $HEAD1 "-f -B" &&
+	test_must_fail test_dirty_mergeable
+'
+
 test_done
--
1.7.1.513.g4f18
