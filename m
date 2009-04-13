From: Jeff King <peff@peff.net>
Subject: [PATCH 3/5] doc/checkout: refer to git-branch(1) as appropriate
Date: Mon, 13 Apr 2009 07:18:52 -0400
Message-ID: <20090413111852.GC15982@coredump.intra.peff.net>
References: <20090413110947.GA15647@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 13:20:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtKDD-00017N-As
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 13:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753687AbZDMLSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 07:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753471AbZDMLSy
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 07:18:54 -0400
Received: from peff.net ([208.65.91.99]:50781 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752734AbZDMLSx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 07:18:53 -0400
Received: (qmail 31771 invoked by uid 107); 13 Apr 2009 11:18:56 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.0.130)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 13 Apr 2009 07:18:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Apr 2009 07:18:52 -0400
Content-Disposition: inline
In-Reply-To: <20090413110947.GA15647@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116429>

Most of description for the branch creation options is
simply cut and paste from git-branch. There are two reasons
to fix this:

  1. It can grow stale with respect to what's in "git
     branch" (which it is now is).

  2. It is not just an implementation detail, but rather the
     desired mental model for the command that we are using
     "git branch" here. Being explicit about that can help
     the user understand what is going on.

It also makes sense to strip the branch creation options
from the synopsis, as they are making it a long,
hard-to-read line. They are still easily discovered by
reading the options list, and --track is explicitly
referenced when branch creation is described.

Signed-off-by: Jeff King <peff@peff.net>
---
There are two things here that people might disagree with:

 1. Referring the user instead of using asciidoc magic to just include
    the repeated text. While it is nice to save the user the effort
    of referencing the other documentation, I think sometimes we go too
    far with this in git. Sometimes it is beneficial for the user not
    just to get the information, but to have it pointed out that the
    link exists. Then they can better understand exactly what it is git
    is doing (it is not "oh, this is a totally unrelated way to create
    branches" but "this is a convenience wrapper that calls git branch"
    -- I think the latter is the model we want to use).

 2. Shortening the synopsis field. The long lines look awful in the
    manpage on an 80-column terminal. I don't read git documentation
    very often, so I have not really noticed, but some of our synopses
    are quite complex and IMHO unreadable. We are much better off just
    saying "there are some options, then these 1 or 2 arguments" which
    give an overview of how you would invoke the command. You can look
    at the option list if you want to actually see the options.

    In this patch I just shortened the ones related to branch creation.
    But I was tempted to take this a step further and get rid of the
    "-f", "-q", and "-m" options in the synopsis, as well, which I think
    would look much better.

 Documentation/git-checkout.txt |   28 +++++++++-------------------
 1 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 16d3c87..22ad10d 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -8,7 +8,7 @@ git-checkout - Checkout a branch or paths to the working tree
 SYNOPSIS
 --------
 [verse]
-'git checkout' [-q] [-f] [-t | --track | --no-track] [-b <new_branch> [-l]] [-m] [<branch>]
+'git checkout' [-q] [-f] [-m] [-b <new_branch>] [<branch>]
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
 
 DESCRIPTION
@@ -18,8 +18,9 @@ When <paths> are not given, this command switches branches by
 updating the index and working tree to reflect the specified
 branch, <branch>, and updating HEAD to be <branch> or, if
 specified, <new_branch>.  Using -b will cause <new_branch> to
-be created; in this case you can use the --track or --no-track
-options, which will be passed to `git branch`.
+be created as if linkgit:git-branch[1] were called; in this case you can
+use the --track or --no-track options, which will be passed to `git
+branch`.
 
 As a convenience, --track will default to creating a branch whose
 name is constructed from the specified branch name by stripping
@@ -62,22 +63,12 @@ entries; instead, unmerged entries are ignored.
 
 -b::
 	Create a new branch named <new_branch> and start it at
-	<branch>.  The new branch name must pass all checks defined
-	by linkgit:git-check-ref-format[1].  Some of these checks
-	may restrict the characters allowed in a branch name.
+	<branch>; see linkgit:git-branch[1] for details.
 
 -t::
 --track::
-	When creating a new branch, set up configuration so that 'git-pull'
-	will automatically retrieve data from the start point, which must be
-	a branch. Use this if you always pull from the same upstream branch
-	into the new branch, and if you don't want to use "git pull
-	<repository> <refspec>" explicitly. This behavior is the default
-	when the start point is a remote branch. Set the
-	branch.autosetupmerge configuration variable to `false` if you want
-	'git checkout' and 'git branch' to always behave as if '--no-track' were
-	given. Set it to `always` if you want this behavior when the
-	start point is either a local or remote branch.
+	When creating a new branch, set up "upstream" configuration. See
+	"--track" in linkgit:git-branch[1] for details.
 +
 If no '-b' option is given, the name of the new branch will be
 derived from the remote branch.  If "remotes/" or "refs/remotes/"
@@ -94,9 +85,8 @@ explicitly give a name with '-b' in such a case.
 	branch.autosetupmerge configuration variable is true.
 
 -l::
-	Create the new branch's reflog.  This activates recording of
-	all changes made to the branch ref, enabling use of date
-	based sha1 expressions such as "<branchname>@\{yesterday}".
+	Create the new branch's reflog; see linkgit:git-branch[1] for
+	details.
 
 -m::
 --merge::
-- 
1.6.3.rc0.148.g141203.dirty
