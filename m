From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/2] git-svn user documentation update.
Date: Mon, 22 Jun 2009 00:48:41 +0200
Message-ID: <1245624521-30769-3-git-send-email-ydirson@altern.org>
References: <1245624521-30769-1-git-send-email-ydirson@altern.org>
 <1245624521-30769-2-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 00:49:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIVqV-0005jy-Db
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 00:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754419AbZFUWsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 18:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754307AbZFUWsz
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 18:48:55 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:58812 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753920AbZFUWsv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 18:48:51 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 5682994005C;
	Mon, 22 Jun 2009 00:48:47 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g21.free.fr (Postfix) with ESMTP id E81A49400EB;
	Mon, 22 Jun 2009 00:48:44 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 2E4391F0CF; Mon, 22 Jun 2009 00:49:18 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <1245624521-30769-2-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121999>

- do not use dash-form for git commands
- review option documentation for init and fetch:
  - list undocumented options
  - move some options to the right command
  - move some options from the generic "options" section to where
    they belong
- document that all options are available through config file
- make formatting more consistent
- various phrasing improvements

Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 Documentation/git-svn.txt |  463 ++++++++++++++++++++++++---------------------
 1 files changed, 245 insertions(+), 218 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index ca3fc3d..652c007 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -11,11 +11,11 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-'git-svn' is a simple conduit for changesets between Subversion and git.
+'git svn' is a simple conduit for changesets between Subversion and git.
 It provides a bidirectional flow of changes between a Subversion and a git
 repository.
 
-'git-svn' can track a single Subversion branch simply by using a
+'git svn' can track a single Subversion branch simply by using a
 URL to the branch, follow branches laid out in the Subversion recommended
 method (trunk, branches, tags directories) with the --stdlayout option, or
 follow branches in any layout with the -T/-t/-b options (see options to
@@ -27,11 +27,10 @@ Subversion updated from git by the 'dcommit' command.
 
 COMMANDS
 --------
---
 
 'init'::
 	Initializes an empty git repository with additional
-	metadata directories for 'git-svn'.  The Subversion URL
+	metadata directories for 'git svn'.  The Subversion URL
 	may be specified as a command-line argument, or as full
 	URL arguments to -T/-t/-b.  Optionally, the target
 	directory to operate on can be specified as a second
@@ -54,28 +53,17 @@ COMMANDS
 	which is the Subversion default. If any of the other options are given
 	as well, they take precedence.
 --no-metadata;;
-	Set the 'noMetadata' option in the [svn-remote] config.
+	Set the 'noMetadata' option in the [svn-remote] config.  See
+	'CONFIG FILE OPTIONS' below.
 --use-svm-props;;
-	Set the 'useSvmProps' option in the [svn-remote] config.
+	Set the 'useSvmProps' option in the [svn-remote] config.  See
+	'CONFIG FILE OPTIONS' below.
 --use-svnsync-props;;
-	Set the 'useSvnsyncProps' option in the [svn-remote] config.
+	Set the 'useSvnsyncProps' option in the [svn-remote] config.  See
+	'CONFIG FILE OPTIONS' below.
 --rewrite-root=<URL>;;
-	Set the 'rewriteRoot' option in the [svn-remote] config.
---use-log-author;;
-	When retrieving svn commits into git (as part of fetch, rebase, or
-	dcommit operations), look for the first From: or Signed-off-by: line
-	in the log message and use that as the author string.
---add-author-from;;
-	When committing to svn from git (as part of commit or dcommit
-	operations), if the existing log message doesn't already have a
-	From: or Signed-off-by: line, append a From: line based on the
-	git commit's author string.  If you use this, then --use-log-author
-	will retrieve a valid author string for all commits.
---username=<USER>;;
-	For transports that SVN handles authentication for (http,
-	https, and plain svn), specify the username.  For other
-	transports (eg svn+ssh://), you must include the username in
-	the URL, eg svn+ssh://foo@svn.bar.com/project
+	Set the 'rewriteRoot' option in the [svn-remote] config.  See
+	'CONFIG FILE OPTIONS' below.
 --prefix=<prefix>;;
 	This allows one to specify a prefix which is prepended
 	to the names of remotes if trunk/branches/tags are
@@ -85,25 +73,83 @@ COMMANDS
 	specified, the prefix must include a trailing slash.
 	Setting a prefix is useful if you wish to track multiple
 	projects that share a common repository.
+--repack[=<n>];;
+--repack-flags=<flags>;;
+--repack-args=<flags>;;
+--repack-opts=<flags>;;
+	These should help keep disk usage sane for large fetches
+	with many revisions.
++
+'--repack' takes an optional argument for the number of revisions
+to fetch before repacking.  This defaults to repacking every
+1000 commits fetched if no argument is specified.
++
+'--repack-flags' are passed directly to 'git repack'.  '--repack-args'
+and '--repack-opts' are aliases for '--repack-flags'.
++
+[verse]
+config key: svn.repack
+config key: svn.repackflags
+
+--shared[={false|true|umask|group|all|world|everybody}];;
+--template=<template_directory>;;
+	These are passed directly to 'git init'.
+--minimize-url;;
+-m;;
+	FIXME: to be documented.
+
++
+The following options to 'init' are also available to the 'fetch'
+command:
++
+--
+--username=<USER>;;
+	For transports that SVN handles authentication for (http,
+	https, and plain svn), specify the username.  For other
+	transports (eg svn+ssh://), you must include the username in
+	the URL, eg svn+ssh://foo@svn.bar.com/project
 --ignore-paths=<regex>;;
 	When passed to 'init' or 'clone' this regular expression will
 	be preserved as a config key.  See 'fetch' for a description
 	of '--ignore-paths'.
+--no-auth-cache;;
+--config-dir=<path>;;
+	FIXME: to be documented.
+--
 
 'fetch'::
 	Fetch unfetched revisions from the Subversion remote we are
 	tracking.  The name of the [svn-remote "..."] section in the
 	.git/config file may be specified as an optional command-line
-	argument.
+	argument.  FIXME: not all configured branches are fetched
+	unless '--fetch-all' is specified ?
+
+-q::
+--quiet::
+	Make 'git svn' less verbose. Specify a second time to make it
+	even less verbose.
+
+--fetch-all;;
+--all;
+	FIXME: to be documented.
+
+-r <ARG>;;
+--revision <ARG>;;
+	   This allows revision ranges for partial/cauterized history
+	   to be supported.  $NUMBER, $NUMBER1:$NUMBER2 (numeric ranges),
+	   $NUMBER:HEAD, and BASE:$NUMBER are all supported.
++
+This can allow you to make partial mirrors; but is generally not
+recommended because history will be skipped and lost.
 
 --localtime;;
 	Store Git commit times in the local timezone instead of UTC.  This
-	makes 'git-log' (even without --date=local) show the same times
+	makes 'git log' (even without --date=local) show the same times
 	that `svn log` would in the local timezone.
 
 --parent;;
 	Fetch only from the SVN parent of the current HEAD.
-
++
 This doesn't interfere with interoperating with the Subversion
 repository you cloned from, but if you wish for your local Git
 repository to be able to interoperate with someone else's local Git
@@ -116,20 +162,78 @@ the same local timezone.
 	The '--ignore-paths' option should match for every 'fetch'
 	(including automatic fetches due to 'clone', 'dcommit',
 	'rebase', etc) on a given repository.
-
++
+[verse]
 config key: svn-remote.<name>.ignore-paths
++
+If the ignore-paths config key is set and the command
+line option is also given, both regular expressions
+will be used.
++
+Examples:
++
+	--ignore-paths="^doc" - skip "doc*" directory for every fetch.
+	--ignore-paths="^[^/]+/(?:branches|tags)" - skip "branches" and "tags"
+of first level directories.
 
-	If the ignore-paths config key is set and the command
-	line option is also given, both regular expressions
-	will be used.
+--no-checkout;;
+	Do not checkout the tree after fetching.  Note that this does
+	not make the converted repository a bare one.
 
-Examples:
+--use-log-author;;
+	When retrieving svn commits into git (as part of fetch, rebase, or
+	dcommit operations), look for the first From: or Signed-off-by: line
+	in the log message and use that as the author string.
 
-	--ignore-paths="^doc" - skip "doc*" directory for every
-	    fetch.
+--add-author-from;;
+	When committing to svn from git (as part of commit or dcommit
+	operations), if the existing log message doesn't already have a
+	From: or Signed-off-by: line, append a From: line based on the
+	git commit's author string.  If you use this, then --use-log-author
+	will retrieve a valid author string for all commits.
 
-	--ignore-paths="^[^/]+/(?:branches|tags)" - skip
-	    "branches" and "tags" of first level directories.
+-A<filename>;;
+--authors-file=<filename>;;
+	Syntax is compatible with the file used by 'git cvsimport':
++
+------------------------------------------------------------------------
+	loginname = Joe User <user@example.com>
+------------------------------------------------------------------------
++
+If this option is specified and 'git svn' encounters an SVN
+committer name that does not exist in the authors-file, 'git svn'
+will abort operation. The user will then have to add the
+appropriate entry.  Re-running the previous 'git svn' command
+after the authors-file is modified should continue operation.
++
+[verse]
+config key: svn.authorsfile
+
+--authors-prog=<filename>;;
+	If this option is specified, for each SVN committer name that
+	does not exist in the authors file, the given file is executed
+	with the committer name as the first argument.  The program is
+	expected to return a single line of the form "Name <email>",
+	which will be treated as if included in the authors file.
+
+--follow-parent;;
+	This is especially helpful when we're tracking a directory
+	that has been moved around within the repository, or if we
+	started tracking a branch and never tracked the trunk it was
+	descended from. This feature is enabled by default, use
+	--no-follow-parent to disable it.
++
+[verse]
+config key: svn.followparent
+
+--log-window-size=<size>;;
+	FIXME: to be documented.
+
+--username=<USER>;;
+--ignore-paths=<regex>;;
+--no-auth-cache;;
+--config-dir=<path>;;
+	See description above under 'init' command.
 
 'clone'::
 	Runs 'init' and 'fetch'.  It will automatically create a
@@ -137,29 +241,29 @@ Examples:
 	or if a second argument is passed; it will create a directory
 	and work within that.  It accepts all arguments that the
 	'init' and 'fetch' commands accept; with the exception of
-	'--fetch-all'.   After a repository is cloned, the 'fetch'
-	command will be able to update revisions without affecting
-	the working tree; and the 'rebase' command will be able
-	to update the working tree with the latest changes.
+	'--fetch-all' and '--parent'.   After a repository is cloned,
+	the 'fetch' command will be able to update revisions without
+	affecting the working tree; and the 'rebase' command will be
+	able to update the working tree with the latest changes.
 
 'rebase'::
 	This fetches revisions from the SVN parent of the current HEAD
 	and rebases the current (uncommitted to SVN) work against it.
-
-This works similarly to `svn update` or 'git-pull' except that
-it preserves linear history with 'git-rebase' instead of
-'git-merge' for ease of dcommitting with 'git-svn'.
-
-This accepts all options that 'git-svn fetch' and 'git-rebase'
++
+This works similarly to `svn update` or 'git pull' except that
+it preserves linear history with 'git rebase' instead of
+'git merge' for ease of dcommitting with 'git svn'.
++
+This accepts all options that 'git svn fetch' and 'git rebase'
 accept.  However, '--fetch-all' only fetches from the current
 [svn-remote], and not all [svn-remote] definitions.
-
-Like 'git-rebase'; this requires that the working tree be clean
++
+Like 'git rebase'; this requires that the working tree be clean
 and have no uncommitted changes.
 
 -l;;
 --local;;
-	Do not fetch remotely; only run 'git-rebase' against the
+	Do not fetch remotely; only run 'git rebase' against the
 	last fetched commit from the upstream SVN.
 
 'dcommit'::
@@ -167,7 +271,7 @@ and have no uncommitted changes.
 	repository, and then rebase or reset (depending on whether or
 	not there is a diff between SVN and head).  This will create
 	a revision in SVN for each commit in git.
-	It is recommended that you run 'git-svn' fetch and rebase (not
+	It is recommended that you run 'git svn' fetch and rebase (not
 	pull or merge) your commits against the latest changes in the
 	SVN repository.
 	An optional command-line argument may be specified as an
@@ -179,18 +283,17 @@ and have no uncommitted changes.
 	After committing, do not rebase or reset.
 --commit-url <URL>;;
 	Commit to this SVN URL (the full path).  This is intended to
-	allow existing git-svn repositories created with one transport
+	allow existing 'git svn' repositories created with one transport
 	method (e.g. `svn://` or `http://` for anonymous read) to be
 	reused if a user is later given access to an alternate transport
 	method (e.g. `svn+ssh://` or `https://`) for commit.
-
++
+[verse]
 config key: svn-remote.<name>.commiturl
-
 config key: svn.commiturl (overwrites all svn-remote.<name>.commiturl options)
-
-	Using this option for any other purpose (don't ask)
-	is very strongly discouraged.
---
++
+Using this option for any other purpose (don't ask)
+is very strongly discouraged.
 
 'branch'::
 	Create a branch in the SVN repository.
@@ -228,7 +331,7 @@ The following features from `svn log' are supported:
 	supported
 --
 +
-New features:
+Features not present in 'svn log':
 +
 --
 --show-commit;;
@@ -241,7 +344,7 @@ NOTE: SVN itself only stores times in UTC and nothing else. The regular svn
 client converts the UTC time to the local time (or based on the TZ=
 environment). This command has the same behaviour.
 +
-Any other arguments are passed directly to 'git-log'
+Any other arguments are passed directly to 'git log'
 
 'blame'::
        Show what revision and author last modified each line of a file. The
@@ -249,15 +352,14 @@ Any other arguments are passed directly to 'git-log'
        `svn blame' by default. Like the SVN blame command,
        local uncommitted changes in the working copy are ignored;
        the version of the file in the HEAD revision is annotated. Unknown
-       arguments are passed directly to 'git-blame'.
+       arguments are passed directly to 'git blame'.
 +
 --git-format;;
-	Produce output in the same format as 'git-blame', but with
+	Produce output in the same format as 'git blame', but with
 	SVN revision numbers instead of git commit hashes. In this mode,
 	changes that haven't been committed to SVN (including local
 	working-copy edits) are shown as revision 0.
 
---
 'find-rev'::
 	When given an SVN revision number of the form 'rN', returns the
 	corresponding git commit hash (this can optionally be followed by a
@@ -271,7 +373,13 @@ Any other arguments are passed directly to 'git-log'
 	absolutely no attempts to do patching when committing to SVN, it
 	simply overwrites files with those specified in the tree or
 	commit.  All merging is assumed to have taken place
-	independently of 'git-svn' functions.
+	independently of 'git svn' functions.
+
+-;;
+--stdin;;
+	Read a list of commits from stdin and commit them in reverse
+	order.  Only the leading sha1 is read from each line, so 'git
+	rev-list --pretty=oneline' output can be used.
 
 'create-ignore'::
 	Recursively finds the svn:ignore property on directories and
@@ -286,12 +394,12 @@ Any other arguments are passed directly to 'git-log'
 
 'commit-diff'::
 	Commits the diff of two tree-ish arguments from the
-	command-line.  This command does not rely on being inside an `git-svn
+	command-line.  This command does not rely on being inside an `git svn
 	init`-ed repository.  This command takes three arguments, (a) the
 	original tree to diff against, (b) the new tree result, (c) the
 	URL of the target Subversion repository.  The final argument
-	(URL) may be omitted if you are working from a 'git-svn'-aware
-	repository (that has been `init`-ed with 'git-svn').
+	(URL) may be omitted if you are working from a 'git svn'-aware
+	repository (that has been `init`-ed with 'git svn').
 	The -r<revision> option is required for this.
 
 'info'::
@@ -313,159 +421,78 @@ Any other arguments are passed directly to 'git-log'
 	Shows the Subversion externals.  Use -r/--revision to specify a
 	specific revision.
 
---
 
 OPTIONS
 -------
---
-
---shared[={false|true|umask|group|all|world|everybody}]::
---template=<template_directory>::
-	Only used with the 'init' command.
-	These are passed directly to 'git-init'.
-
--r <ARG>::
---revision <ARG>::
-
-Used with the 'fetch' command.
-
-This allows revision ranges for partial/cauterized history
-to be supported.  $NUMBER, $NUMBER1:$NUMBER2 (numeric ranges),
-$NUMBER:HEAD, and BASE:$NUMBER are all supported.
-
-This can allow you to make partial mirrors when running fetch;
-but is generally not recommended because history will be skipped
-and lost.
-
--::
---stdin::
-
-Only used with the 'set-tree' command.
-
-Read a list of commits from stdin and commit them in reverse
-order.  Only the leading sha1 is read from each line, so
-'git-rev-list --pretty=oneline' output can be used.
 
 --rmdir::
-
-Only used with the 'dcommit', 'set-tree' and 'commit-diff' commands.
-
+	Only used with the 'dcommit', 'set-tree' and 'commit-diff' commands.
++
 Remove directories from the SVN tree if there are no files left
 behind.  SVN can version empty directories, and they are not
 removed by default if there are no files left in them.  git
 cannot version empty directories.  Enabling this flag will make
 the commit to SVN act like git.
-
++
+[verse]
 config key: svn.rmdir
 
 -e::
 --edit::
-
-Only used with the 'dcommit', 'set-tree' and 'commit-diff' commands.
-
+	Only used with the 'dcommit', 'set-tree' and 'commit-diff' commands.
++
 Edit the commit message before committing to SVN.  This is off by
 default for objects that are commits, and forced on when committing
 tree objects.
-
++
+[verse]
 config key: svn.edit
 
 -l<num>::
 --find-copies-harder::
-
-Only used with the 'dcommit', 'set-tree' and 'commit-diff' commands.
-
-They are both passed directly to 'git-diff-tree'; see
+	Only used with the 'dcommit', 'set-tree' and 'commit-diff' commands.
++
+They are both passed directly to 'git diff-tree'; see
 linkgit:git-diff-tree[1] for more information.
-
++
 [verse]
 config key: svn.l
 config key: svn.findcopiesharder
 
--A<filename>::
---authors-file=<filename>::
-
-Syntax is compatible with the file used by 'git-cvsimport':
-
-------------------------------------------------------------------------
-	loginname = Joe User <user@example.com>
-------------------------------------------------------------------------
-
-If this option is specified and 'git-svn' encounters an SVN
-committer name that does not exist in the authors-file, 'git-svn'
-will abort operation. The user will then have to add the
-appropriate entry.  Re-running the previous 'git-svn' command
-after the authors-file is modified should continue operation.
-
-config key: svn.authorsfile
-
---authors-prog=<filename>::
-
-If this option is specified, for each SVN committer name that does not
-exist in the authors file, the given file is executed with the committer
-name as the first argument.  The program is expected to return a single
-line of the form "Name <email>", which will be treated as if included in
-the authors file.
-
--q::
---quiet::
-	Make 'git-svn' less verbose. Specify a second time to make it
-	even less verbose.
-
---repack[=<n>]::
---repack-flags=<flags>::
-
-These should help keep disk usage sane for large fetches
-with many revisions.
-
---repack takes an optional argument for the number of revisions
-to fetch before repacking.  This defaults to repacking every
-1000 commits fetched if no argument is specified.
-
---repack-flags are passed directly to 'git-repack'.
-
-[verse]
-config key: svn.repack
-config key: svn.repackflags
-
 -m::
 --merge::
 -s<strategy>::
 --strategy=<strategy>::
-
-These are only used with the 'dcommit' and 'rebase' commands.
-
-Passed directly to 'git-rebase' when using 'dcommit' if a
-'git-reset' cannot be used (see 'dcommit').
+	These are only used with the 'dcommit' and 'rebase' commands.
++
+Passed directly to 'git rebase' when using 'dcommit' if a
+'git reset' cannot be used (see 'dcommit').
 
 -n::
 --dry-run::
-
-This can be used with the 'dcommit', 'rebase', 'branch' and 'tag'
-commands.
-
+	This can be used with the 'dcommit', 'rebase', 'branch' and 'tag'
+	commands.
++
 For 'dcommit', print out the series of git arguments that would show
 which diffs would be committed to SVN.
-
++
 For 'rebase', display the local branch associated with the upstream svn
 repository associated with the current branch and the URL of svn
 repository that will be fetched from.
-
++
 For 'branch' and 'tag', display the urls that will be used for copying when
 creating the branch or tag.
 
---
 
 ADVANCED OPTIONS
 ----------------
---
 
 -i<GIT_SVN_ID>::
 --id <GIT_SVN_ID>::
-
-This sets GIT_SVN_ID (instead of using the environment).  This
-allows the user to override the default refname to fetch from
-when tracking a single URL.  The 'log' and 'dcommit' commands
-no longer require this switch as an argument.
+	This sets GIT_SVN_ID (instead of using the environment).  This
+	allows the user to override the default refname to fetch from
+	when tracking a single URL.  The 'log' and 'dcommit' commands
+	no longer require this switch as an argument.
 
 -R<remote name>::
 --svn-remote <remote name>::
@@ -473,39 +500,39 @@ no longer require this switch as an argument.
 	this allows SVN multiple repositories to be tracked.
 	Default: "svn"
 
---follow-parent::
-	This is especially helpful when we're tracking a directory
-	that has been moved around within the repository, or if we
-	started tracking a branch and never tracked the trunk it was
-	descended from. This feature is enabled by default, use
-	--no-follow-parent to disable it.
-
-config key: svn.followparent
 
---
 CONFIG FILE-ONLY OPTIONS
 ------------------------
---
 
-svn.noMetadata::
-svn-remote.<name>.noMetadata::
+All command-line options are also available as config-file items, with
+the same name prefixed by "svn." and with any dash in their names
+removed.  Be aware that for some options it is probably not a good
+idea to use them in the config file, and you should probably only use
+the config keys explicitely mentionned in this manual.  If you find
+one useful, but don't see it mentionned together with the
+corresponding option, please mention this on the git mailing list.
 
-This gets rid of the 'git-svn-id:' lines at the end of every commit.
+The extra options described below are not available directly from the
+command-line, although some of them can be set by specific flags at
+repository initialization.
 
-If you lose your .git/svn/git-svn/.rev_db file, 'git-svn' will not
+svn.noMetadata::
+svn-remote.<name>.noMetadata::
+	This gets rid of the 'git-svn-id:' lines at the end of every commit.
++
+If you lose your .git/svn/git-svn/.rev_db file, 'git svn' will not
 be able to rebuild it and you won't be able to fetch again,
 either.  This is fine for one-shot imports.
-
-The 'git-svn log' command will not work on repositories using
++
+The 'git svn log' command will not work on repositories using
 this, either.  Using this conflicts with the 'useSvmProps'
 option for (hopefully) obvious reasons.
 
 svn.useSvmProps::
 svn-remote.<name>.useSvmProps::
-
-This allows 'git-svn' to re-map repository URLs and UUIDs from
-mirrors created using SVN::Mirror (or svk) for metadata.
-
+	This allows 'git svn' to re-map repository URLs and UUIDs from
+	mirrors created using SVN::Mirror (or svk) for metadata.
++
 If an SVN revision has a property, "svm:headrev", it is likely
 that the revision was created by SVN::Mirror (also used by SVK).
 The property contains a repository UUID and a revision.  We want
@@ -522,23 +549,23 @@ svn-remote.<name>.useSvnsyncprops::
 
 svn-remote.<name>.rewriteRoot::
 	This allows users to create repositories from alternate
-	URLs.  For example, an administrator could run 'git-svn' on the
+	URLs.  For example, an administrator could run 'git svn' on the
 	server locally (accessing via file://) but wish to distribute
 	the repository with a public http:// or svn:// URL in the
 	metadata so users of it will see the public URL.
 
 svn.brokenSymlinkWorkaround::
-This disables potentially expensive checks to workaround broken symlinks
-checked into SVN by broken clients.  Set this option to "false" if you
-track a SVN repository with many empty blobs that are not symlinks.
-This option may be changed while "git-svn" is running and take effect on
-the next revision fetched.  If unset, git-svn assumes this option to be
-"true".
+	This disables potentially expensive checks to workaround
+	broken symlinks checked into SVN by broken clients.  Set this
+	option to "false" if you track a SVN repository with many
+	empty blobs that are not symlinks.  This option may be changed
+	while 'git svn' is running and take effect on the next
+	revision fetched.  If unset, 'git svn' assumes this option to be
+	"true".
 
---
 
 Since the noMetadata, rewriteRoot, useSvnsyncProps and useSvmProps
-options all affect the metadata generated and used by 'git-svn'; they
+options all affect the metadata generated and used by 'git svn'; they
 *must* be set in the configuration file before any history is imported
 and these settings should never be changed once they are set.
 
@@ -556,7 +583,7 @@ Tracking and contributing to the trunk of a Subversion-managed project:
 	git svn clone http://svn.example.com/project/trunk
 # Enter the newly cloned directory:
 	cd trunk
-# You should be on master branch, double-check with git-branch
+# You should be on master branch, double-check with 'git branch'
 	git branch
 # Do some work and commit locally to git:
 	git commit ...
@@ -587,12 +614,12 @@ Tracking and contributing to an entire Subversion-managed project
 # of dcommit/rebase/show-ignore should be the same as above.
 ------------------------------------------------------------------------
 
-The initial 'git-svn clone' can be quite time-consuming
+The initial 'git svn clone' can be quite time-consuming
 (especially for large Subversion repositories). If multiple
 people (or one person with multiple machines) want to use
-'git-svn' to interact with the same Subversion repository, you can
-do the initial 'git-svn clone' to a repository on a server and
-have each person clone that repository with 'git-clone':
+'git svn' to interact with the same Subversion repository, you can
+do the initial 'git svn clone' to a repository on a server and
+have each person clone that repository with 'git clone':
 
 ------------------------------------------------------------------------
 # Do the initial import on a server
@@ -606,7 +633,7 @@ have each person clone that repository with 'git-clone':
 	git fetch
 # Create a local branch from one of the branches just fetched
 	git checkout -b master FETCH_HEAD
-# Initialize git-svn locally (be sure to use the same URL and -T/-b/-t options as were used on server)
+# Initialize 'git svn' locally (be sure to use the same URL and -T/-b/-t options as were used on server)
 	git svn init http://svn.example.com/project
 # Pull the latest changes from Subversion
 	git svn rebase
@@ -615,7 +642,7 @@ have each person clone that repository with 'git-clone':
 REBASE VS. PULL/MERGE
 ---------------------
 
-Originally, 'git-svn' recommended that the 'remotes/git-svn' branch be
+Originally, 'git svn' recommended that the 'remotes/git-svn' branch be
 pulled or merged from.  This is because the author favored
 `git svn set-tree B` to commit a single head rather than the
 `git svn set-tree A..B` notation to commit multiple commits.
@@ -630,7 +657,7 @@ previous commits in SVN.
 DESIGN PHILOSOPHY
 -----------------
 Merge tracking in Subversion is lacking and doing branched development
-with Subversion can be cumbersome as a result.  While 'git-svn' can track
+with Subversion can be cumbersome as a result.  While 'git svn' can track
 copy history (including branches and tags) for repositories adopting a
 standard layout, it cannot yet represent merge history that happened
 inside git back upstream to SVN users.  Therefore it is advised that
@@ -641,25 +668,25 @@ CAVEATS
 -------
 
 For the sake of simplicity and interoperating with a less-capable system
-(SVN), it is recommended that all 'git-svn' users clone, fetch and dcommit
-directly from the SVN server, and avoid all 'git-clone'/'pull'/'merge'/'push'
+(SVN), it is recommended that all 'git svn' users clone, fetch and dcommit
+directly from the SVN server, and avoid all 'git clone'/'pull'/'merge'/'push'
 operations between git repositories and branches.  The recommended
 method of exchanging code between git branches and users is
-'git-format-patch' and 'git-am', or just 'dcommit'ing to the SVN repository.
+'git format-patch' and 'git am', or just 'dcommit'ing to the SVN repository.
 
-Running 'git-merge' or 'git-pull' is NOT recommended on a branch you
+Running 'git merge' or 'git pull' is NOT recommended on a branch you
 plan to 'dcommit' from.  Subversion does not represent merges in any
 reasonable or useful fashion; so users using Subversion cannot see any
 merges you've made.  Furthermore, if you merge or pull from a git branch
 that is a mirror of an SVN branch, 'dcommit' may commit to the wrong
 branch.
 
-'git-clone' does not clone branches under the refs/remotes/ hierarchy or
-any 'git-svn' metadata, or config.  So repositories created and managed with
-using 'git-svn' should use 'rsync' for cloning, if cloning is to be done
+'git clone' does not clone branches under the refs/remotes/ hierarchy or
+any 'git svn' metadata, or config.  So repositories created and managed with
+using 'git svn' should use 'rsync' for cloning, if cloning is to be done
 at all.
 
-Since 'dcommit' uses rebase internally, any git branches you 'git-push' to
+Since 'dcommit' uses rebase internally, any git branches you 'git push' to
 before 'dcommit' on will require forcing an overwrite of the existing ref
 on the remote repository.  This is generally considered bad practice,
 see the linkgit:git-push[1] documentation for details.
@@ -685,7 +712,7 @@ for git to detect them.
 CONFIGURATION
 -------------
 
-'git-svn' stores [svn-remote] configuration information in the
+'git svn' stores [svn-remote] configuration information in the
 repository .git/config file.  It is similar the core git
 [remote] sections except 'fetch' keys do not accept glob
 arguments; but they are instead handled by the 'branches'
@@ -706,7 +733,7 @@ Keep in mind that the '\*' (asterisk) wildcard of the local ref
 however the remote wildcard may be anywhere as long as it's an
 independent path component (surrounded by '/' or EOL).   This
 type of configuration is not automatically created by 'init' and
-should be manually entered with a text-editor or using 'git-config'.
+should be manually entered with a text-editor or using 'git config'.
 
 SEE ALSO
 --------
-- 
1.6.3.1
