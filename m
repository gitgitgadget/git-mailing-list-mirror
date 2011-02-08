From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/3] checkout: introduce --detach synonym for "git checkout
 foo^{commit}"
Date: Tue, 8 Feb 2011 04:32:49 -0600
Message-ID: <20110208103249.GC29660@elie>
References: <alpine.DEB.1.10.1102062234010.3788@debian>
 <20110207205934.GD13461@sigill.intra.peff.net>
 <AANLkTinmqTi4cYbR6PtSxt6itCvFQDuT_sE1tjx45a3h@mail.gmail.com>
 <20110207220030.GA19357@elie>
 <7vaai7s9g4.fsf@alter.siamese.dyndns.org>
 <20110207234526.GA28336@sigill.intra.peff.net>
 <20110208005238.GB24340@elie>
 <20110208102605.GA29660@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 08 11:33:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmksW-00031q-NC
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 11:33:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220Ab1BHKc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 05:32:56 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48584 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151Ab1BHKcy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 05:32:54 -0500
Received: by gyb11 with SMTP id 11so2143010gyb.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 02:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=KXJKtI6QnWIWWwx7ICxV7Znoa3k4C9iejcubEb1VNlE=;
        b=sarVj1lhty7NOH/FbgO7OiXkx+iksyb7yHT1shMC66xfMe8CL8aDtzAZr8afYI/BLD
         Shff+CnpcwBI5pxLwUo1jV24ylJzy6mgMnkPkorZNqUYQA+7/mYGeIfrOgUPE0JTxWpX
         +claZn4jtP1tq6My3mC9kWst3IybD1R276i6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qMNGbXkGg6Sm/vD/SXaj3nY5GdS+oODawICCM2IJ5JfhkVPoRWa7xarNBU/AMkMGOK
         08EHAkTkNIoQke/yeix6qT+hadvIhHspHkqNYsjZ2lr+VpaSw9UlnuJtJgzDRvAks/Oi
         A360gX0ZYqXrM0vnN/OPiRkkmEaBo1ku69zo4=
Received: by 10.90.72.14 with SMTP id u14mr20448301aga.195.1297161173865;
        Tue, 08 Feb 2011 02:32:53 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id i10sm6926935anh.32.2011.02.08.02.32.51
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 08 Feb 2011 02:32:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110208102605.GA29660@elie>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166347>

From: Junio C Hamano <gitster@pobox.com>

For example, one might use this when making a temporary merge to
test that two topics work well together.

Patch by Junio, with tests from Jeff King.

[jn: with some extra checks for bogus commandline usage]

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-checkout.txt |   13 +++++-
 builtin/checkout.c             |   25 ++++++++--
 t/t2020-checkout-detach.sh     |   95 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 126 insertions(+), 7 deletions(-)
 create mode 100755 t/t2020-checkout-detach.sh

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 22d3611..d162117 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git checkout' [-q] [-f] [-m] [<branch>]
+'git checkout' [-q] [-f] [-m] [--detach] [<commit>]
 'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
 'git checkout' --patch [<tree-ish>] [--] [<paths>...]
@@ -22,9 +23,10 @@ branch.
 
 'git checkout' [<branch>]::
 'git checkout' -b|-B <new_branch> [<start point>]::
+'git checkout' [--detach] [<commit>]::
 
 	This form switches branches by updating the index, working
-	tree, and HEAD to reflect the specified branch.
+	tree, and HEAD to reflect the specified branch or commit.
 +
 If `-b` is given, a new branch is created as if linkgit:git-branch[1]
 were called and then checked out; in this case you can
@@ -115,6 +117,13 @@ explicitly give a name with '-b' in such a case.
 	Create the new branch's reflog; see linkgit:git-branch[1] for
 	details.
 
+--detach::
+	Rather than checking out a branch to work on it, check out a
+	commit for inspection and discardable experiments.
+	This is the default behavior of "git checkout <commit>" when
+	<commit> is not a branch name.  See the "DETACHED HEAD" section
+	below for details.
+
 --orphan::
 	Create a new 'orphan' branch, named <new_branch>, started from
 	<start_point> and switch to it.  The first commit made on this
@@ -204,7 +213,7 @@ leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
 
 
 
-Detached HEAD
+DETACHED HEAD
 -------------
 
 It is sometimes useful to be able to 'checkout' a commit that is
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0e7a6a3..51ec977 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -30,6 +30,7 @@ struct checkout_opts {
 	int quiet;
 	int merge;
 	int force;
+	int force_detach;
 	int writeout_stage;
 	int writeout_error;
 
@@ -563,7 +564,7 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 			if (!file_exists(ref_file) && file_exists(log_file))
 				remove_path(log_file);
 		}
-	} else if (strcmp(new->name, "HEAD")) {
+	} else if (opts->force_detach || strcmp(new->name, "HEAD")) {
 		update_ref(msg.buf, "HEAD", new->commit->object.sha1, NULL,
 			   REF_NODEREF, DIE_ON_ERR);
 		if (!opts->quiet) {
@@ -574,7 +575,8 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 	}
 	remove_branch_state();
 	strbuf_release(&msg);
-	if (!opts->quiet && (new->path || !strcmp(new->name, "HEAD")))
+	if (!opts->quiet &&
+	    (new->path || (!opts->force_detach && !strcmp(new->name, "HEAD"))))
 		report_tracking(new);
 }
 
@@ -677,6 +679,7 @@ static const char *unique_tracking_name(const char *name)
 
 static int parse_branchname_arg(int argc, const char **argv,
 				int dwim_new_local_branch_ok,
+				int force_detach,
 				struct branch_info *new,
 				struct tree **source_tree,
 				unsigned char rev[20],
@@ -753,7 +756,8 @@ static int parse_branchname_arg(int argc, const char **argv,
 	new->name = arg;
 	setup_branch_path(new);
 
-	if (check_ref_format(new->path) == CHECK_REF_FORMAT_OK &&
+	if (!force_detach &&
+	    check_ref_format(new->path) == CHECK_REF_FORMAT_OK &&
 	    resolve_ref(new->path, branch_rev, 1, NULL))
 		hashcpy(rev, branch_rev);
 	else
@@ -804,6 +808,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_STRING('B', NULL, &opts.new_branch_force, "branch",
 			   "create/reset and checkout a branch"),
 		OPT_BOOLEAN('l', NULL, &opts.new_branch_log, "create reflog for new branch"),
+		OPT_BOOLEAN(0, "detach", &opts.force_detach, "detach the HEAD at named commit"),
 		OPT_SET_INT('t', "track",  &opts.track, "set upstream info for new branch",
 			BRANCH_TRACK_EXPLICIT),
 		OPT_STRING(0, "orphan", &opts.new_orphan_branch, "new branch", "new unparented branch"),
@@ -842,9 +847,15 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		opts.new_branch = opts.new_branch_force;
 
 	if (patch_mode && (opts.track > 0 || opts.new_branch
-			   || opts.new_branch_log || opts.merge || opts.force))
+			   || opts.new_branch_log || opts.merge || opts.force
+			   || opts.force_detach))
 		die ("--patch is incompatible with all other options");
 
+	if (opts.force_detach && (opts.new_branch || opts.new_orphan_branch))
+		die("--detach cannot be used with -b/-B/--orphan");
+	if (opts.force_detach && 0 < opts.track)
+		die("--detach cannot be used with -t");
+
 	/* --track without -b should DWIM */
 	if (0 < opts.track && !opts.new_branch) {
 		const char *argv0 = argv[0];
@@ -895,7 +906,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			dwim_new_local_branch &&
 			opts.track == BRANCH_TRACK_UNSPECIFIED &&
 			!opts.new_branch;
-		int n = parse_branchname_arg(argc, argv, dwim_ok,
+		int n = parse_branchname_arg(argc, argv,
+				dwim_ok, opts.force_detach,
 				&new, &source_tree, rev, &opts.new_branch);
 		argv += n;
 		argc -= n;
@@ -922,6 +934,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			}
 		}
 
+		if (opts.force_detach)
+			die("git checkout: --detach does not take a path argument");
+
 		if (1 < !!opts.writeout_stage + !!opts.force + !!opts.merge)
 			die("git checkout: --ours/--theirs, --force and --merge are incompatible when\nchecking out of the index.");
 
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
new file mode 100755
index 0000000..0042145
--- /dev/null
+++ b/t/t2020-checkout-detach.sh
@@ -0,0 +1,95 @@
+#!/bin/sh
+
+test_description='checkout into detached HEAD state'
+. ./test-lib.sh
+
+check_detached () {
+	test_must_fail git symbolic-ref -q HEAD >/dev/null
+}
+
+check_not_detached () {
+	git symbolic-ref -q HEAD >/dev/null
+}
+
+reset () {
+	git checkout master &&
+	check_not_detached
+}
+
+test_expect_success 'setup' '
+	test_commit one &&
+	test_commit two &&
+	git branch branch &&
+	git tag tag
+'
+
+test_expect_success 'checkout branch does not detach' '
+	reset &&
+	git checkout branch &&
+	check_not_detached
+'
+
+test_expect_success 'checkout tag detaches' '
+	reset &&
+	git checkout tag &&
+	check_detached
+'
+
+test_expect_success 'checkout branch by full name detaches' '
+	reset &&
+	git checkout refs/heads/branch &&
+	check_detached
+'
+
+test_expect_success 'checkout non-ref detaches' '
+	reset &&
+	git checkout branch^ &&
+	check_detached
+'
+
+test_expect_success 'checkout ref^0 detaches' '
+	reset &&
+	git checkout branch^0 &&
+	check_detached
+'
+
+test_expect_success 'checkout --detach detaches' '
+	reset &&
+	git checkout --detach branch &&
+	check_detached
+'
+
+test_expect_success 'checkout --detach without branch name' '
+	reset &&
+	git checkout --detach &&
+	check_detached
+'
+
+test_expect_success 'checkout --detach errors out for non-commit' '
+	reset &&
+	test_must_fail git checkout --detach one^{tree} &&
+	check_not_detached
+'
+
+test_expect_success 'checkout --detach errors out for extra argument' '
+	reset &&
+	git checkout master &&
+	test_must_fail git checkout --detach tag one.t &&
+	check_not_detached
+'
+
+test_expect_success 'checkout --detached and -b are incompatible' '
+	reset &&
+	test_must_fail git checkout --detach -b newbranch tag &&
+	check_not_detached
+'
+
+test_expect_success 'checkout --detach moves HEAD' '
+	reset &&
+	git checkout one &&
+	git checkout --detach two &&
+	git diff --exit-code HEAD &&
+	git diff --exit-code two
+'
+
+test_done
-- 
1.7.4
