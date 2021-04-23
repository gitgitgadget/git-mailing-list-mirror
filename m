Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EE6C433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3958161075
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243952AbhDWTn6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 15:43:58 -0400
Received: from mav.lukeshu.com ([104.207.138.63]:35312 "EHLO mav.lukeshu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243951AbhDWTnl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 15:43:41 -0400
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 2E08380598;
        Fri, 23 Apr 2021 15:43:04 -0400 (EDT)
From:   Luke Shumaker <lukeshu@lukeshu.com>
To:     git@vger.kernel.org
Cc:     Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Luke Shumaker <lukeshu@datawire.io>
Subject: [PATCH 26/30] subtree: give the docs a once-over
Date:   Fri, 23 Apr 2021 13:42:26 -0600
Message-Id: <20210423194230.1388945-27-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210423194230.1388945-1-lukeshu@lukeshu.com>
References: <20210423194230.1388945-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

Just went through the docs looking for anything inaccurate or that can
be improved.

In the '-h' text, in the man page synopsis, and in the man page
description: Normalize the ordering of the list of sub-commands: 'add',
'merge', 'split', 'pull', 'push'.  This allows us to kinda separate the
lower-level add/merge/split from the higher-level pull/push.

'-h' text:
 - correction: Indicate that split's arg is optional.
 - clarity: Emphasize that 'pull' takes the 'add'/'merge' flags.

man page:

 - correction: State that all subcommands take options (it seemed to
   indicate that only 'split' takes any options other than '-P').
 - correction: 'split' only guarantees that the results are identical if
   the flags are identical.
 - completeness: Clarify that 'push' always operates on HEAD, and that
   'split' operates on HEAD if no local commit is given.
 - clarity: In the description, when listing commands, repeat what their
   arguments are.  This way the reader doesn't need to flip back and
   forth between the command description and the synopsis and the full
   description to understand what's being said.
 - clarity: In the <variables> used to give command arguments, give
   slightly longer, descriptive names.  Like <local-commit> instead of
   just <commit>.
 - clarity: Emphasize that 'pull' takes the 'add'/'merge' flags.
 - style: In the synopsis, list options before the subcommand.  This
   makes things line up and be much more readable when shown
   non-monospace (such as in `make html`), and also more closely matches
   other man pages (like `git-submodule.txt`).
 - style: Use the correct syntax for indicating the options ([<options>]
   instead of [OPTIONS]).
 - style: In the synopsis, separate 'pull' and 'push' from the other
   lower-level commands.  I think this helps readability.
 - style: Code-quote things in prose that seem like they should be
   code-quoted, like '.gitmodules', flags, or full commands.
 - style: Minor wording improvements, like more consistent mood (many
   of the command descriptions start in the imperative mood and switch
   to the indicative mode by the end).  That sort of thing.
 - style: Capitalize "ID".
 - style: Remove the "This option is only valid for XXX command" remarks
   from each option, and instead rely on the section headings.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
 contrib/subtree/git-subtree.sh  |   4 +-
 contrib/subtree/git-subtree.txt | 162 +++++++++++++++-----------------
 2 files changed, 80 insertions(+), 86 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 54e904516b..4d0be1ad5c 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -9,9 +9,9 @@ OPTS_SPEC="\
 git subtree add   --prefix=<prefix> <commit>
 git subtree add   --prefix=<prefix> <repository> <ref>
 git subtree merge --prefix=<prefix> <commit>
+git subtree split --prefix=<prefix> [<commit>]
 git subtree pull  --prefix=<prefix> <repository> <ref>
 git subtree push  --prefix=<prefix> <repository> <ref>
-git subtree split --prefix=<prefix> <commit>
 --
 h,help        show the help
 q             quiet
@@ -24,7 +24,7 @@ b,branch=     create a new branch from the split subtree
 ignore-joins  ignore prior --rejoin commits
 onto=         try connecting new tree to an existing one
 rejoin        merge the new branch back into HEAD
- options for 'add', 'merge', and 'pull'
+ options for 'add' and 'merge' (also: 'pull')
 squash        merge subtree changes as a single commit
 "
 
diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 0db02fe3c0..5728778bdf 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -9,13 +9,14 @@ git-subtree - Merge subtrees together and split repository into subtrees
 SYNOPSIS
 --------
 [verse]
-'git subtree' add   -P <prefix> <commit>
-'git subtree' add   -P <prefix> <repository> <ref>
-'git subtree' pull  -P <prefix> <repository> <ref>
-'git subtree' push  -P <prefix> <repository> <ref>
-'git subtree' merge -P <prefix> <commit>
-'git subtree' split -P <prefix> [OPTIONS] [<commit>]
+'git subtree' [<options>] -P <prefix> add <local-commit>
+'git subtree' [<options>] -P <prefix> add <repository> <remote-ref>
+'git subtree' [<options>] -P <prefix> merge <local-commit>
+'git subtree' [<options>] -P <prefix> split [<local-commit>]
 
+[verse]
+'git subtree' [<options>] -P <prefix> pull <repository> <remote-ref>
+'git subtree' [<options>] -P <prefix> push <repository> <remote-ref>
 
 DESCRIPTION
 -----------
@@ -28,7 +29,7 @@ as a subdirectory of your application.
 
 Subtrees are not to be confused with submodules, which are meant for
 the same task. Unlike submodules, subtrees do not need any special
-constructions (like .gitmodules files or gitlinks) be present in
+constructions (like '.gitmodules' files or gitlinks) be present in
 your repository, and do not force end-users of your
 repository to do anything special or to understand how subtrees
 work. A subtree is just a subdirectory that can be
@@ -59,27 +60,28 @@ project as much as possible.  That is, if you make a change that
 affects both the library and the main application, commit it in
 two pieces.  That way, when you split the library commits out
 later, their descriptions will still make sense.  But if this
-isn't important to you, it's not *necessary*.  git subtree will
+isn't important to you, it's not *necessary*.  'git subtree' will
 simply leave out the non-library-related parts of the commit
 when it splits it out into the subproject later.
 
 
 COMMANDS
 --------
-add::
+add <local-commit>::
+add <repository> <remote-ref>::
 	Create the <prefix> subtree by importing its contents
-	from the given <commit> or <repository> and remote <ref>.
+	from the given <local-commit> or <repository> and <remote-ref>.
 	A new commit is created	automatically, joining the imported
-	project's history with your own.  With '--squash', imports
+	project's history with your own.  With '--squash', import
 	only a single commit from the subproject, rather than its
 	entire history.
 
-merge::
-	Merge recent changes up to <commit> into the <prefix>
+merge <local-commit>::
+	Merge recent changes up to <local-commit> into the <prefix>
 	subtree.  As with normal 'git merge', this doesn't
 	remove your own local changes; it just merges those
-	changes into the latest <commit>.  With '--squash',
-	creates only one commit that contains all the changes,
+	changes into the latest <local-commit>.  With '--squash',
+	create only one commit that contains all the changes,
 	rather than merging in the entire history.
 +
 If you use '--squash', the merge direction doesn't always have to be
@@ -87,39 +89,40 @@ forward; you can use this command to go back in time from v2.5 to v2.4,
 for example.  If your merge introduces a conflict, you can resolve it in
 the usual ways.
 	
-pull::
-	Exactly like 'merge', but parallels 'git pull' in that
-	it fetches the given ref from the specified remote
-	repository.
-	
-push::
-	Does a 'split' (see below) using the <prefix> supplied
-	and then does a 'git push' to push the result to the 
-	repository and ref. This can be used to push your
-	subtree to different branches of the remote repository.
-
-split::
+split [<local-commit>]::
 	Extract a new, synthetic project history from the
-	history of the <prefix> subtree.  The new history
+	history of the <prefix> subtree of <local-commit>, or of
+	HEAD if no <local-commit> is given.  The new history
 	includes only the commits (including merges) that
 	affected <prefix>, and each of those commits now has the
 	contents of <prefix> at the root of the project instead
 	of in a subdirectory.  Thus, the newly created history
 	is suitable for export as a separate git repository.
 +
-After splitting successfully, a single commit id is printed to stdout.
+After splitting successfully, a single commit ID is printed to stdout.
 This corresponds to the HEAD of the newly created tree, which you can
 manipulate however you want.
 +
 Repeated splits of exactly the same history are guaranteed to be
-identical (i.e. to produce the same commit ids).  Because of this, if
-you add new commits and then re-split, the new commits will be attached
-as commits on top of the history you generated last time, so 'git merge'
-and friends will work as expected.
+identical (i.e. to produce the same commit IDs) as long as the
+settings passed to 'split' (such as '--annotate') are the same.
+Because of this, if you add new commits and then re-split, the new
+commits will be attached as commits on top of the history you
+generated last time, so 'git merge' and friends will work as expected.
 +
 Note that if you use '--squash' when you merge, you should usually not
 just '--rejoin' when you split.
 
+pull <repository> <remote-ref>::
+	Exactly like 'merge', but parallels 'git pull' in that
+	it fetches the given ref from the specified remote
+	repository.
+
+push <repository> <remote-ref>::
+	Does a 'split' using the <prefix> subtree of HEAD and then
+	does a 'git push' to push the result to the <repository> and
+	<remote-ref>.  This can be used to push your subtree to
+	different branches of the remote repository.
 
 OPTIONS
 -------
@@ -139,19 +142,18 @@ OPTIONS
 
 -m <message>::
 --message=<message>::
-	This option is only valid for add, merge, pull, and split --rejoin.
+	This option is only valid for 'add', 'merge', 'pull', and 'split --rejoin'.
 	Specify <message> as the commit message for the merge commit.
 
+OPTIONS FOR 'add' AND 'merge' (ALSO: 'pull')
+--------------------------------------------
+These options for 'add' and 'merge' may also be given to 'pull' (which
+wraps 'merge').
 
-OPTIONS FOR add, merge, and pull
---------------------------------
 --squash::
-	This option is only valid for add, merge, and pull
-	commands.
-+
-Instead of merging the entire history from the subtree project, produce
-only a single commit that contains all the differences you want to
-merge, and then merge that new commit into your project.
+	Instead of merging the entire history from the subtree project, produce
+	only a single commit that contains all the differences you want to
+	merge, and then merge that new commit into your project.
 +
 Using this option helps to reduce log clutter. People rarely want to see
 every change that happened between v1.0 and v1.1 of the library they're
@@ -175,56 +177,48 @@ remain intact and can be later split and send upstream to the
 subproject.
 
 
-OPTIONS FOR split
------------------
+OPTIONS FOR 'split'
+-------------------
+These options are only valid for 'split'.
+
 --annotate=<annotation>::
-	This option is only valid for the split command.
-+
-When generating synthetic history, add <annotation> as a prefix to each
-commit message.  Since we're creating new commits with the same commit
-message, but possibly different content, from the original commits, this
-can help to differentiate them and avoid confusion.
+	When generating synthetic history, add <annotation> as a prefix to each
+	commit message.  Since we're creating new commits with the same commit
+	message, but possibly different content, from the original commits, this
+	can help to differentiate them and avoid confusion.
 +
 Whenever you split, you need to use the same <annotation>, or else you
 don't have a guarantee that the new re-created history will be identical
 to the old one.  That will prevent merging from working correctly.  git
-subtree tries to make it work anyway, particularly if you use --rejoin,
+subtree tries to make it work anyway, particularly if you use '--rejoin',
 but it may not always be effective.
 
 -b <branch>::
 --branch=<branch>::
-	This option is only valid for the split command.
-+
-After generating the synthetic history, create a new branch called
-<branch> that contains the new history.  This is suitable for immediate
-pushing upstream.  <branch> must not already exist.
+	After generating the synthetic history, create a new branch called
+	<branch> that contains the new history.  This is suitable for immediate
+	pushing upstream.  <branch> must not already exist.
 
 --ignore-joins::
-	This option is only valid for the split command.
-+
-If you use '--rejoin', git subtree attempts to optimize its history
-reconstruction to generate only the new commits since the last
-'--rejoin'.  '--ignore-join' disables this behaviour, forcing it to
-regenerate the entire history.  In a large project, this can take a long
-time.
+	If you use '--rejoin', git subtree attempts to optimize its history
+	reconstruction to generate only the new commits since the last
+	'--rejoin'.  '--ignore-join' disables this behaviour, forcing it to
+	regenerate the entire history.  In a large project, this can take a long
+	time.
 
 --onto=<onto>::
-	This option is only valid for the split command.
-+
-If your subtree was originally imported using something other than git
-subtree, its history may not match what git subtree is expecting.  In
-that case, you can specify the commit id <onto> that corresponds to the
-first revision of the subproject's history that was imported into your
-project, and git subtree will attempt to build its history from there.
+	If your subtree was originally imported using something other than git
+	subtree, its history may not match what git subtree is expecting.  In
+	that case, you can specify the commit ID <onto> that corresponds to the
+	first revision of the subproject's history that was imported into your
+	project, and git subtree will attempt to build its history from there.
 +
 If you used 'git subtree add', you should never need this option.
 
 --rejoin::
-	This option is only valid for the split command.
-+
-After splitting, merge the newly created synthetic history back into
-your main project.  That way, future splits can search only the part of
-history that has been added since the most recent --rejoin.
+	After splitting, merge the newly created synthetic history back into
+	your main project.  That way, future splits can search only the part of
+	history that has been added since the most recent '--rejoin'.
 +
 If your split commits end up merged into the upstream subproject, and
 then you want to get the latest upstream version, this will allow git's
@@ -240,8 +234,8 @@ split, because you don't want the subproject's history to be part of
 your project anyway.
 
 
-EXAMPLE 1. Add command
-----------------------
+EXAMPLE 1. 'add' command
+------------------------
 Let's assume that you have a local repository that you would like
 to add an external vendor library to. In this case we will add the
 git-subtree repository as a subdirectory of your already existing
@@ -253,15 +247,15 @@ git-extensions repository in ~/git-extensions/:
 'master' needs to be a valid remote ref and can be a different branch
 name
 
-You can omit the --squash flag, but doing so will increase the number
+You can omit the '--squash' flag, but doing so will increase the number
 of commits that are included in your local repository.
 
 We now have a ~/git-extensions/git-subtree directory containing code
 from the master branch of git://github.com/apenwarr/git-subtree.git
 in our git-extensions repository.
 
-EXAMPLE 2. Extract a subtree using commit, merge and pull
----------------------------------------------------------
+EXAMPLE 2. Extract a subtree using 'commit', 'merge' and 'pull'
+---------------------------------------------------------------
 Let's use the repository for the git source code as an example.
 First, get your own copy of the git.git repository:
 
@@ -284,9 +278,9 @@ the upstream.  You could do this:
 0a8f4f0 to the current version, including 0a8f4f0 itself.")
 
 If gitweb had originally been merged using 'git subtree add' (or
-a previous split had already been done with --rejoin specified)
+a previous split had already been done with '--rejoin' specified)
 then you can do all your splits without having to remember any
-weird commit ids:
+weird commit IDs:
 
 	$ git subtree split --prefix=gitweb --annotate='(split) ' --rejoin \
 		--branch gitweb-latest2
@@ -321,8 +315,8 @@ the standard gitweb:
 
 	git log gitweb-latest..$(git subtree split --prefix=gitweb)
 
-EXAMPLE 3. Extract a subtree using branch
------------------------------------------
+EXAMPLE 3. Extract a subtree using a branch
+-------------------------------------------
 Suppose you have a source directory with many files and
 subdirectories, and you want to extract the lib directory to its own
 git project. Here's a short way to do it:
-- 
2.31.1

