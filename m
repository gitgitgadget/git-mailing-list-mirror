From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/WIP] checkout: introduce --detach synonym for "git checkout
 foo^{commit}"
Date: Mon, 7 Feb 2011 18:52:53 -0600
Message-ID: <20110208005238.GB24340@elie>
References: <alpine.DEB.1.10.1102062234010.3788@debian>
 <20110207205934.GD13461@sigill.intra.peff.net>
 <AANLkTinmqTi4cYbR6PtSxt6itCvFQDuT_sE1tjx45a3h@mail.gmail.com>
 <20110207220030.GA19357@elie>
 <7vaai7s9g4.fsf@alter.siamese.dyndns.org>
 <20110207234526.GA28336@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 08 01:53:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmbpL-00080o-Ha
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 01:53:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038Ab1BHAxB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 19:53:01 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:52563 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836Ab1BHAxA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 19:53:00 -0500
Received: by qyk12 with SMTP id 12so4347318qyk.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 16:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=vdBl4PWz8O7h1I2grgpx0LtxyzrlUvcRQbc+lnZEvHY=;
        b=WNnaCLkS39UOWRF9PT8YpMhts5jzfvddo8Y8441lPD/njvYUuGTyX++oKwG07HuH3V
         IWuynrMcH8fFmk3C1E0PM47vXQSYqJ6hm6xxM9EeMs4+UwT/lE1p+Tl9l/8+MvLsTL5U
         S4RjlfE9rGKm51UD4bKK9UQBcDL+AaNTT7Pdw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=h/CzZ7w9BFSjQvB81/OpIhEhBfn3bb476UzzIlfBJKCFwfcy2y2alRDoV/vpdeLbNe
         tMbXTt4aPlbmgVvsjhKgOBYj1FOutYdofYMPz6pBKosRKISA5f2Gm7iQ3XVSDnEXQNmW
         v9vBfJoFYdJViXsLoIB9d/B0ja/tJxsom+Aao=
Received: by 10.229.110.8 with SMTP id l8mr11535783qcp.205.1297126378713;
        Mon, 07 Feb 2011 16:52:58 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id s10sm3189048qco.47.2011.02.07.16.52.56
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 07 Feb 2011 16:52:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110207234526.GA28336@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166318>

From: Junio C Hamano <gitster@pobox.com>

For example, one might use this when making a temporary merge to
test that two topics work well together.

Patch by Junio, tests from Jeff King.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jeff King wrote:

> Jonathan, do you want to roll all of these up into a single patch?

Okay, here it is.  Two of the new tests fail. :)

 Documentation/git-checkout.txt |   13 +++++-
 builtin/checkout.c             |    8 +++-
 t/t2020-checkout-detach.sh     |   89 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+), 3 deletions(-)
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
index 953abdd..526abb9 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -685,6 +685,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	char *conflict_style = NULL;
 	int patch_mode = 0;
 	int dwim_new_local_branch = 1;
+	int force_detach = 0;
 	struct option options[] = {
 		OPT__QUIET(&opts.quiet),
 		OPT_STRING('b', NULL, &opts.new_branch, "branch",
@@ -692,6 +693,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_STRING('B', NULL, &opts.new_branch_force, "branch",
 			   "create/reset and checkout a branch"),
 		OPT_BOOLEAN('l', NULL, &opts.new_branch_log, "create reflog for new branch"),
+		OPT_BOOLEAN(0, "detach", &force_detach, "detach the HEAD at named commit"),
 		OPT_SET_INT('t', "track",  &opts.track, "set upstream info for new branch",
 			BRANCH_TRACK_EXPLICIT),
 		OPT_STRING(0, "orphan", &opts.new_orphan_branch, "new branch", "new unparented branch"),
@@ -726,6 +728,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	if (opts.new_branch && opts.new_branch_force)
 		die("-B cannot be used with -b");
 
+	if ((opts.new_branch || opts.new_orphan_branch) && force_detach)
+		die("--detach cannot be used with -b/-B/--orphan");
+
 	/* copy -B over to -b, so that we can just check the latter */
 	if (opts.new_branch_force)
 		opts.new_branch = opts.new_branch_force;
@@ -834,7 +839,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		new.name = arg;
 		setup_branch_path(&new);
 
-		if (check_ref_format(new.path) == CHECK_REF_FORMAT_OK &&
+		if (!force_detach &&
+		    check_ref_format(new.path) == CHECK_REF_FORMAT_OK &&
 		    resolve_ref(new.path, branch_rev, 1, NULL))
 			hashcpy(rev, branch_rev);
 		else
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
new file mode 100755
index 0000000..e57f253
--- /dev/null
+++ b/t/t2020-checkout-detach.sh
@@ -0,0 +1,89 @@
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
+test_expect_failure 'checkout --detach without branch name' '
+	reset &&
+	git checkout --detach &&
+	check_detached
+'
+
+test_expect_failure 'checkout --detach errors out for extra argument' '
+	reset &&
+	git checkout master &&
+	test_expect_code 129 git checkout --detach tag nonsense &&
+	check_not_detached
+'
+
+test_expect_success 'checkout --detached and -b are incompatible' '
+	check_not_detached &&
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
