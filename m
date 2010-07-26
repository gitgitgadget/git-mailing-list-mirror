From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 3-24/24] Documentation: include configuration options in manpages
Date: Mon, 26 Jul 2010 20:48:55 +0200
Message-ID: <a0be121e0b89f010273f3a3de9ad054bcec26d6c.1280169048.git.trast@student.ethz.ch>
References: <cover.1280169048.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 26 20:49:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdSji-0005Le-4o
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 20:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755041Ab0GZStG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 14:49:06 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:14250 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755026Ab0GZStE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 14:49:04 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 26 Jul
 2010 20:48:56 +0200
Received: from localhost.localdomain (84.74.100.241) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.0.702.0; Mon, 26 Jul
 2010 20:48:56 +0200
X-Mailer: git-send-email 1.7.2.349.gd5452
In-Reply-To: <cover.1280169048.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151880>

This is a squash of 22 commits.  You can find their originals at

  git://repo.or.cz/git/trast.git t/doc-config-extraction
---
 Documentation/config-vars.txt      |  107 +++++++++++++++++++++++++++++------
 Documentation/git-add.txt          |    6 +-
 Documentation/git-am.txt           |   18 ++++++
 Documentation/git-archive.txt      |    8 +--
 Documentation/git-branch.txt       |    8 +++
 Documentation/git-checkout.txt     |    8 +++
 Documentation/git-clean.txt        |    6 ++
 Documentation/git-commit.txt       |    7 ++
 Documentation/git-diff.txt         |   12 ++++
 Documentation/git-fetch.txt        |   12 ++++
 Documentation/git-format-patch.txt |   22 ++++++-
 Documentation/git-grep.txt         |    7 ++
 Documentation/git-gui.txt          |   16 +++++
 Documentation/git-log.txt          |   38 ++-----------
 Documentation/git-merge.txt        |   15 +++--
 Documentation/git-pull.txt         |   14 +++++
 Documentation/git-push.txt         |   19 ++++++
 Documentation/git-rebase.txt       |    5 +-
 Documentation/git-shortlog.txt     |    6 ++
 Documentation/git-status.txt       |   18 ++----
 Documentation/git-submodule.txt    |    8 +++
 Documentation/git-tag.txt          |   11 +---
 Documentation/gitk.txt             |    8 +++
 Documentation/merge-config.txt     |   49 ----------------
 24 files changed, 284 insertions(+), 144 deletions(-)
 delete mode 100644 Documentation/merge-config.txt

diff --git a/Documentation/config-vars.txt b/Documentation/config-vars.txt
index 3fcefe9..0ae80be 100644
--- a/Documentation/config-vars.txt
+++ b/Documentation/config-vars.txt
@@ -426,7 +426,9 @@ core.sparseCheckout::
 add.ignore-errors::
 	Tells 'git add' to continue adding files when some files cannot be
 	added due to indexing errors. Equivalent to the '--ignore-errors'
-	option of linkgit:git-add[1].
+	option
+ifdef::git-config[of linkgit:git-add[1].]
+ifndef::git-config[.]
 
 alias.*::
 	Command aliases for the linkgit:git[1] command wrapper - e.g.
@@ -1137,8 +1139,11 @@ i18n.commitEncoding::
 	porcelains). See e.g. linkgit:git-mailinfo[1]. Defaults to 'utf-8'.
 
 i18n.logOutputEncoding::
-	Character encoding the commit messages are converted to when
-	running 'git log' and friends.
+	Encoding to use when displaying logs.
+ifdef::git-log[(See "Discussion", above.)]
+ifndef::git-log[See "Discussion" in linkgit:git-log[1].]
+	Defaults to the value of `i18n.commitEncoding` if set, UTF-8
+	otherwise.
 
 imap::
 	The configuration variables in the 'imap' section are described
@@ -1175,10 +1180,11 @@ interactive.singlekey::
 	ignored if portable keystroke input is not available.
 
 log.date::
-	Set default date-time mode for the log command. Setting log.date
-	value is similar to using 'git log'\'s --date option. The value is one of the
-	following alternatives: {relative,local,default,iso,rfc,short}.
-	See linkgit:git-log[1].
+	Default date-time mode for the log family. The value must be
+	one of {relative,local,default,iso,rfc,short}. Defaults to
+	"default".  See the `\--date` option
+ifdef::git-log[above.]
+ifndef::git-log[in linkgit:git-log[1].]
 
 log.decorate::
 	Print out the ref names of any commits that are shown by the log
@@ -1188,10 +1194,16 @@ log.decorate::
 	This is the same as the log commands '--decorate' option.
 
 log.showroot::
-	If true, the initial commit will be shown as a big creation event.
-	This is equivalent to a diff against an empty tree.
-	Tools like linkgit:git-log[1] or linkgit:git-whatchanged[1], which
-	normally hide the root commit will now show it. True by default.
+	If enabled, the initial commit will be shown as a big creation
+	event (equivalent to a diff against an empty tree).  Otherwise
+	it has an empty diff. Enabled by default.
+
+mailinfo.scissors::
+	When splitting the patch out of an email, remove everything in
+	body before a scissors line, if such a line is found.  A
+	scissors line is a line that mainly consists of scissors
+	(either ">8" or "8<") and perforation (dash "-") marks.
+	See the `\--scissors` option in linkgit:git-mailinfo.txt[].
 
 mailmap.file::
 	The location of an augmenting mailmap file. The default
@@ -1199,7 +1211,9 @@ mailmap.file::
 	first, then the mailmap file pointed to by this variable.
 	The location of the mailmap file may be in a repository
 	subdirectory, or somewhere outside of the repository itself.
+ifdef::git-config[]
 	See linkgit:git-shortlog[1] and linkgit:git-blame[1].
+endif::git-config[]
 
 man.viewer::
 	Specify the programs that may be used to display help in the
@@ -1214,7 +1228,55 @@ man.<tool>.path::
 	Override the path for the given tool that may be used to
 	display help in the 'man' format. See linkgit:git-help[1].
 
-include::merge-config.txt[]
+merge.conflictstyle::
+	Specify the style in which conflicted hunks are written out to
+	working tree files upon merge.  The default is "merge", which
+	shows a `<<<<<<<` conflict marker, changes made by one side,
+	a `=======` marker, changes made by the other side, and then
+	a `>>>>>>>` marker.  An alternate style, "diff3", adds a `|||||||`
+	marker and the original text before the `=======` marker.
+
+merge.log::
+	Whether to include summaries of merged commits in newly created
+	merge commit messages. False by default.
+
+merge.renameLimit::
+	The number of files to consider when performing rename detection
+	during a merge; if not specified, defaults to the value of
+	diff.renameLimit.
+
+merge.stat::
+	Whether to print the diffstat between ORIG_HEAD and the merge result
+	at the end of the merge.  True by default.
+
+merge.tool::
+	Controls which merge resolution program is used by
+	linkgit:git-mergetool[1].  Valid built-in values are: "kdiff3",
+	"tkdiff", "meld", "xxdiff", "emerge", "vimdiff", "gvimdiff",
+	"diffuse", "ecmerge", "tortoisemerge", "p4merge", "araxis" and
+	"opendiff".  Any other value is treated is custom merge tool
+	and there must be a corresponding mergetool.<tool>.cmd option.
+
+merge.verbosity::
+	Controls the amount of output shown by the recursive merge
+	strategy.  Level 0 outputs nothing except a final error
+	message if conflicts were detected. Level 1 outputs only
+	conflicts, 2 outputs conflicts and file changes.  Level 5 and
+	above outputs debugging information.  The default is level 2.
+	Can be overridden by the 'GIT_MERGE_VERBOSITY' environment variable.
+
+merge.<driver>.name::
+	Defines a human-readable name for a custom low-level
+	merge driver.  See linkgit:gitattributes[5] for details.
+
+merge.<driver>.driver::
+	Defines the command that implements a custom low-level
+	merge driver.  See linkgit:gitattributes[5] for details.
+
+merge.<driver>.recursive::
+	Names a low-level merge driver to be used when
+	performing an internal merge between common ancestors.
+	See linkgit:gitattributes[5] for details.
 
 mergetool.<tool>.path::
 	Override the path for the given tool.  This is useful in case
@@ -1271,6 +1333,11 @@ globs.
 The effective value of "core.notesRef" (possibly overridden by
 GIT_NOTES_REF) is also implicitly added to the list of refs to be
 displayed.
+ifdef::git-log[]
++
+This setting can be disabled by the `--no-standard-notes` option
+and supplemented by the `--show-notes` option.
+endif::git-log[]
 
 notes.rewrite.<command>::
 	When rewriting commits with <command> (currently `amend` or
@@ -1637,8 +1704,9 @@ tar.umask::
 	This variable can be used to restrict the permission bits of
 	tar archive entries.  The default is 0002, which turns off the
 	world write bit.  The special value "user" indicates that the
-	archiving user's umask will be used instead.  See umask(2) and
-	linkgit:git-archive[1].
+	archiving user's umask will be used instead.  See umask(2)
+ifdef::git-config[and linkgit:git-archive[1].]
+ifndef::git-config[for details.]
 
 transfer.unpackLimit::
 	When `fetch.unpackLimit` or `receive.unpackLimit` are
@@ -1680,11 +1748,12 @@ user.name::
 	environment variables.  See linkgit:git-commit-tree[1].
 
 user.signingkey::
-	If linkgit:git-tag[1] is not selecting the key you want it to
-	automatically when creating a signed tag, you can override the
-	default selection with this variable.  This option is passed
-	unchanged to gpg's --local-user parameter, so you may specify a key
-	using any method that gpg supports.
+	By default, 'git tag -s' (-s) will use your committer identity
+	(of the form "Your Name <your@email.address>") to find a key.
+	If you want to use a different default key, you can override
+	the selection with this variable.  The value is passed
+	unchanged to gpg's --local-user parameter, so you may specify
+	a key using any method that gpg supports.
 
 web.browser::
 	Specify a web browser that may be used by some commands.
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index e22a62f..da1ac09 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -148,10 +148,8 @@ subdirectories.
 Configuration
 -------------
 
-The optional configuration variable `core.excludesfile` indicates a path to a
-file containing patterns of file names to exclude from git-add, similar to
-$GIT_DIR/info/exclude.  Patterns in the exclude file are used in addition to
-those in info/exclude.  See linkgit:gitrepository-layout[5].
+@@CONFIG(add.ignore-errors)@@
+@@CONFIG(core.excludesfile)@@
 
 
 EXAMPLES
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 9e62f87..3db8e9d 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -185,6 +185,24 @@ commits that is more easily fixed by changing the mailbox (e.g.
 errors in the "From:" lines).
 
 
+CONFIGURATION
+-------------
+
+Variables that affect 'git am' itself:
+
+@@CONFIG(am.keepcr)@@
+@@CONFIG(i18n.commitEncoding)@@
+
+Variables that affect 'git apply', which is used to apply the patches:
+
+@@CONFIG(apply.ignorewhitespace)@@
+@@CONFIG(apply.whitespace)@@
+
+Variables that affect 'git mailinfo':
+
+@@CONFIG(mailinfo.scissors)@@
+
+
 SEE ALSO
 --------
 linkgit:git-apply[1].
diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 8d3e666..01a6bc5 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -93,12 +93,8 @@ zip
 CONFIGURATION
 -------------
 
-tar.umask::
-	This variable can be used to restrict the permission bits of
-	tar archive entries.  The default is 0002, which turns off the
-	world write bit.  The special value "user" indicates that the
-	archiving user's umask will be used instead.  See umask(2) for
-	details.
+@@CONFIG(tar.umask)@@
+
 
 ATTRIBUTES
 ----------
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 1940256..08ea917 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -222,6 +222,14 @@ but different purposes:
 - `--no-merged` is used to find branches which are candidates for merging
   into HEAD, since those branches are not fully contained by HEAD.
 
+
+CONFIGURATION
+-------------
+
+@@CONFIG(branch.autosetupmerge)@@
+@@CONFIG(branch.autosetuprebase)@@
+
+
 SEE ALSO
 --------
 linkgit:git-check-ref-format[1],
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 1bacd2e..c5d5c03 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -299,6 +299,14 @@ $ git add frotz
 ------------
 
 
+CONFIGURATION
+-------------
+
+@@CONFIG(branch.autosetupmerge)@@
+@@CONFIG(branch.autosetuprebase)@@
+@@CONFIG(merge.conflictstyle)@@
+
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index a81cb6c..eab8de5 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -56,6 +56,12 @@ OPTIONS
 	everything from scratch, but keep manually created files.
 
 
+CONFIGURATION
+-------------
+
+@@CONFIG(clean.requireForce)@@
+
+
 Author
 ------
 Written by Pavel Roskin <proski@gnu.org>
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index c28603e..49420cd 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -375,6 +375,13 @@ and `post-commit` hooks.  See linkgit:githooks[5] for more
 information.
 
 
+CONFIGURATION
+-------------
+
+@@CONFIG(commit.status)@@
+@@CONFIG(commit.template)@@
+
+
 SEE ALSO
 --------
 linkgit:git-add[1],
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 08fd409..b7dc1e6 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -157,6 +157,18 @@ $ git diff -R                          <2>
 rewrites (very expensive).
 <2> Output diff in reverse.
 
+CONFIGURATION
+-------------
+
+@@CONFIG(diff.autorefreshindex)@@
+@@CONFIG(diff.external)@@
+@@CONFIG(diff.mnemonicprefix)@@
+@@CONFIG(diff.noprefix)@@
+@@CONFIG(diff.renameLimit)@@
+@@CONFIG(diff.renames)@@
+@@CONFIG(diff.suppressBlankEmpty)@@
+@@CONFIG(diff.wordRegex)@@
+
 SEE ALSO
 --------
 linkgit:git-difftool[1]::
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 400fe7f..b0c2027 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -76,6 +76,18 @@ The `pu` branch will be updated even if it is does not fast-forward,
 because it is prefixed with a plus sign; `tmp` will not be.
 
 
+CONFIGURATION
+-------------
+
+@@CONFIG(fetch.unpackLimit)@@
+@@CONFIG(core.gitProxy)@@
+@@CONFIG(branch.<name>.remote)@@
+@@CONFIG(branch.<name>.merge)@@
+
+The `remote.<name>.*` configuration options also affect git-fetch as
+discussed above.
+
+
 SEE ALSO
 --------
 linkgit:git-pull[1]
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 4b3f5ba..def364f 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -211,10 +211,9 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
 
 CONFIGURATION
 -------------
-You can specify extra mail header lines to be added to each message,
-defaults for the subject prefix and file suffix, number patches when
-outputting more than one patch, add "To" or "Cc:" headers, configure
-attachments, and sign off patches with configuration variables.
+
+'git format-patch' has a lot of configuration variables.  A short
+example:
 
 ------------
 [format]
@@ -226,8 +225,23 @@ attachments, and sign off patches with configuration variables.
 	cc = <email>
 	attach [ = mime-boundary-string ]
 	signoff = true
+	signature = "Hello, world!\n"
+	thread = shallow
 ------------
 
+The individual variables are as follows:
+
+@@CONFIG(format.headers)@@
+@@CONFIG(format.subjectprefix)@@
+@@CONFIG(format.suffix)@@
+@@CONFIG(format.numbered)@@
+@@CONFIG(format.to)@@
+@@CONFIG(format.cc)@@
+@@CONFIG(format.attach)@@
+@@CONFIG(format.signoff)@@
+@@CONFIG(format.signature)@@
+@@CONFIG(format.thread)@@
+
 
 EXAMPLES
 --------
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 5474dd7..37af4e3 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -203,6 +203,13 @@ git grep --all-match -e NODE -e Unexpected::
 	Looks for a line that has `NODE` or `Unexpected` in
 	files that have lines that match both.
 
+
+Configuration
+-------------
+
+@@CONFIG(color.grep)@@
+@@CONFIG(color.grep.<slot>)@@
+
 Author
 ------
 Originally written by Linus Torvalds <torvalds@osdl.org>, later
diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
index 2563710..5c53b36 100644
--- a/Documentation/git-gui.txt
+++ b/Documentation/git-gui.txt
@@ -98,6 +98,22 @@ git gui browser maint::
 	selected in the browser can be viewed with the internal
 	blame viewer.
 
+CONFIGURATION
+-------------
+
+@@CONFIG(gui.commitmsgwidth)@@
+@@CONFIG(gui.diffcontext)@@
+@@CONFIG(gui.encoding)@@
+@@CONFIG(gui.matchtrackingbranch)@@
+@@CONFIG(gui.newbranchtemplate)@@
+@@CONFIG(gui.pruneduringfetch)@@
+@@CONFIG(gui.trustmtime)@@
+@@CONFIG(gui.spellingdictionary)@@
+@@CONFIG(gui.fastcopyblame)@@
+@@CONFIG(gui.copyblamethreshold)@@
+@@CONFIG(gui.blamehistoryctx)@@
+
+
 SEE ALSO
 --------
 linkgit:gitk[1]::
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index e970664..77987b3 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -145,38 +145,12 @@ format.pretty::
 	Default for the `--format` option.  (See "PRETTY FORMATS" above.)
 	Defaults to "medium".
 
-i18n.logOutputEncoding::
-	Encoding to use when displaying logs.  (See "Discussion", above.)
-	Defaults to the value of `i18n.commitEncoding` if set, UTF-8
-	otherwise.
-
-log.date::
-	Default format for human-readable dates.  (Compare the
-	`--date` option.)  Defaults to "default", which means to write
-	dates like `Sat May 8 19:35:34 2010 -0500`.
-
-log.showroot::
-	If `false`, 'git log' and related commands will not treat the
-	initial commit as a big creation event.  Any root commits in
-	`git log -p` output would be shown without a diff attached.
-	The default is `true`.
-
-mailmap.file::
-	See linkgit:git-shortlog[1].
-
-notes.displayRef::
-	Which refs, in addition to the default set by `core.notesRef`
-	or 'GIT_NOTES_REF', to read notes from when showing commit
-	messages with the 'log' family of commands.  See
-	linkgit:git-notes[1].
-+
-May be an unabbreviated ref name or a glob and may be specified
-multiple times.  A warning will be issued for refs that do not exist,
-but a glob that does not match any refs is silently ignored.
-+
-This setting can be disabled by the `--no-standard-notes` option,
-overridden by the 'GIT_NOTES_DISPLAY_REF' environment variable,
-and supplemented by the `--show-notes` option.
+@@CONFIG(i18n.logOutputEncoding)@@
+@@CONFIG(log.date)@@
+@@CONFIG(log.decorate)@@
+@@CONFIG(log.showroot)@@
+@@CONFIG(mailmap.file)@@
+@@CONFIG(notes.displayRef)@@
 
 Author
 ------
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 84043cc..41c7e44 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -275,12 +275,17 @@ include::merge-strategies.txt[]
 
 CONFIGURATION
 -------------
-include::merge-config.txt[]
 
-branch.<name>.mergeoptions::
-	Sets default options for merging into branch <name>. The syntax and
-	supported options are the same as those of 'git merge', but option
-	values containing whitespace characters are currently not supported.
+@@CONFIG(merge.conflictstyle)@@
+@@CONFIG(merge.log)@@
+@@CONFIG(merge.renameLimit)@@
+@@CONFIG(merge.stat)@@
+@@CONFIG(merge.tool)@@
+@@CONFIG(merge.verbosity)@@
+@@CONFIG(merge.<driver>.name)@@
+@@CONFIG(merge.<driver>.driver)@@
+@@CONFIG(merge.<driver>.recursive)@@
+@@CONFIG(branch.<name>.mergeoptions)@@
 
 SEE ALSO
 --------
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index ab4de10..b169964 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -165,6 +165,20 @@ If you tried a pull which resulted in a complex conflicts and
 would want to start over, you can recover with 'git reset'.
 
 
+CONFIGURATION
+-------------
+
+Options that affect 'git pull':
+
+@@CONFIG(branch.<name>.remote)@@
+@@CONFIG(branch.<name>.merge)@@
+@@CONFIG(branch.<name>.rebase)@@
+
+Options that affect the underlying 'git fetch' and 'git merge' are
+documented in linkgit:git-fetch[1] and linkgit:git-merge[1],
+respectively.
+
+
 SEE ALSO
 --------
 linkgit:git-fetch[1], linkgit:git-merge[1], linkgit:git-config[1]
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 658ff2f..6c76f74 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -406,6 +406,25 @@ Commits A and B would no longer belong to a branch with a symbolic name,
 and so would be unreachable.  As such, these commits would be removed by
 a `git gc` command on the origin repository.
 
+CONFIGURATION
+-------------
+
+Variables that affect the sending (local) side:
+
+@@CONFIG(push.default)@@
+@@CONFIG(branch.<name>.remote)@@
+@@CONFIG(branch.<name>.merge)@@
+
+Variables that affect the receiving (remote) side:
+
+@@CONFIG(receive.autogc)@@
+@@CONFIG(receive.fsckObjects)@@
+@@CONFIG(receive.unpackLimit)@@
+@@CONFIG(receive.denyDeletes)@@
+@@CONFIG(receive.denyDeleteCurrent)@@
+@@CONFIG(receive.denyCurrentBranch)@@
+@@CONFIG(receive.denyNonFastForwards)@@
+@@CONFIG(receive.updateserverinfo)@@
 
 Author
 ------
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index be23ad2..41e0604 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -195,9 +195,8 @@ Alternatively, you can undo the 'git rebase' with
 CONFIGURATION
 -------------
 
-rebase.stat::
-	Whether to show a diffstat of what changed upstream since the last
-	rebase. False by default.
+@@CONFIG(rebase.stat)@@
+
 
 OPTIONS
 -------
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index bc1ac77..21628fc 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -69,6 +69,12 @@ spelled differently.
 include::mailmap.txt[]
 
 
+CONFIGURATION
+-------------
+
+@@CONFIG(mailmap.file)@@
+
+
 Author
 ------
 Written by Jeff Garzik <jgarzik@pobox.com>
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 2fd054c..c001d56 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -152,19 +152,11 @@ backslash-escaping is performed. Fourth, there is no branch line.
 CONFIGURATION
 -------------
 
-The command honors `color.status` (or `status.color` -- they
-mean the same thing and the latter is kept for backward
-compatibility) and `color.status.<slot>` configuration variables
-to colorize its output.
-
-If the config variable `status.relativePaths` is set to false, then all
-paths shown are relative to the repository root, not to the current
-directory.
-
-If `status.submodulesummary` is set to a non zero number or true (identical
-to -1 or an unlimited number), the submodule summary will be enabled for
-the long format and a summary of commits for modified submodules will be
-shown (see --summary-limit option of linkgit:git-submodule[1]).
+@@CONFIG(color.status)@@
+@@CONFIG(color.status.<slot>)@@
+@@CONFIG(status.relativePaths)@@
+@@CONFIG(status.showUntrackedFiles)@@
+@@CONFIG(status.submodulesummary)@@
 
 SEE ALSO
 --------
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 1ed331c..40bb60f 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -258,6 +258,14 @@ to each submodule url is "submodule.$name.url".  See linkgit:gitmodules[5]
 for details.
 
 
+CONFIGURATION
+-------------
+
+@@CONFIG(submodule.<name>.path)@@
+@@CONFIG(submodule.<name>.url)@@
+@@CONFIG(submodule.<name>.update)@@
+
+
 AUTHOR
 ------
 Written by Lars Hjemli <hjemli@gmail.com>
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 31c78a8..8e264e7 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -95,15 +95,8 @@ OPTIONS
 
 CONFIGURATION
 -------------
-By default, 'git tag' in sign-with-default mode (-s) will use your
-committer identity (of the form "Your Name <your@email.address>") to
-find a key.  If you want to use a different default key, you can specify
-it in the repository configuration as follows:
-
--------------------------------------
-[user]
-    signingkey = <gpg-key-id>
--------------------------------------
+
+@@CONFIG(user.signingkey)@@
 
 
 DISCUSSION
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 05ac1c7..498a5f1 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -100,6 +100,14 @@ Files
 Gitk creates the .gitk file in your $HOME directory to store preferences
 such as display options, font, and colors.
 
+
+CONFIGURATION
+-------------
+
+@@CONFIG(gui.encoding)@@
+@@CONFIG(i18n.commitEncoding)@@
+
+
 SEE ALSO
 --------
 'qgit(1)'::
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
deleted file mode 100644
index a403155..0000000
--- a/Documentation/merge-config.txt
+++ /dev/null
@@ -1,49 +0,0 @@
-merge.conflictstyle::
-	Specify the style in which conflicted hunks are written out to
-	working tree files upon merge.  The default is "merge", which
-	shows a `<<<<<<<` conflict marker, changes made by one side,
-	a `=======` marker, changes made by the other side, and then
-	a `>>>>>>>` marker.  An alternate style, "diff3", adds a `|||||||`
-	marker and the original text before the `=======` marker.
-
-merge.log::
-	Whether to include summaries of merged commits in newly created
-	merge commit messages. False by default.
-
-merge.renameLimit::
-	The number of files to consider when performing rename detection
-	during a merge; if not specified, defaults to the value of
-	diff.renameLimit.
-
-merge.stat::
-	Whether to print the diffstat between ORIG_HEAD and the merge result
-	at the end of the merge.  True by default.
-
-merge.tool::
-	Controls which merge resolution program is used by
-	linkgit:git-mergetool[1].  Valid built-in values are: "kdiff3",
-	"tkdiff", "meld", "xxdiff", "emerge", "vimdiff", "gvimdiff",
-	"diffuse", "ecmerge", "tortoisemerge", "p4merge", "araxis" and
-	"opendiff".  Any other value is treated is custom merge tool
-	and there must be a corresponding mergetool.<tool>.cmd option.
-
-merge.verbosity::
-	Controls the amount of output shown by the recursive merge
-	strategy.  Level 0 outputs nothing except a final error
-	message if conflicts were detected. Level 1 outputs only
-	conflicts, 2 outputs conflicts and file changes.  Level 5 and
-	above outputs debugging information.  The default is level 2.
-	Can be overridden by the 'GIT_MERGE_VERBOSITY' environment variable.
-
-merge.<driver>.name::
-	Defines a human-readable name for a custom low-level
-	merge driver.  See linkgit:gitattributes[5] for details.
-
-merge.<driver>.driver::
-	Defines the command that implements a custom low-level
-	merge driver.  See linkgit:gitattributes[5] for details.
-
-merge.<driver>.recursive::
-	Names a low-level merge driver to be used when
-	performing an internal merge between common ancestors.
-	See linkgit:gitattributes[5] for details.
-- 
1.7.2.349.gd5452
