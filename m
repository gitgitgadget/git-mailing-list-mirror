Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E75FA1F404
	for <e@80x24.org>; Thu, 12 Apr 2018 22:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752612AbeDLW5W (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 18:57:22 -0400
Received: from ao2.it ([92.243.12.208]:51123 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753202AbeDLW5U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 18:57:20 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1f6kZd-0008Ux-G3; Fri, 13 Apr 2018 00:20:09 +0200
Received: from ao2 by jcn with local (Exim 4.90_1)
        (envelope-from <ao2@ao2.it>)
        id 1f6kad-0001VG-Ef; Fri, 13 Apr 2018 00:21:11 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Richard Hartmann <richih.mailinglist@gmail.com>,
        Antonio Ospite <ao2@ao2.it>
Subject: [RFC 04/10] submodule: document 'core.submodulesFile' and fix references to '.gitmodules'
Date:   Fri, 13 Apr 2018 00:20:41 +0200
Message-Id: <20180412222047.5716-5-ao2@ao2.it>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180412222047.5716-1-ao2@ao2.it>
References: <20180412222047.5716-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The gitmodules file location can be overridden by setting the
'core.submodulesFile' config option.

Document this new option and reflect the new behavior in the
documentation by using the more generic formula "gitmodules file"
instead of the hardcoded '.gitmodules' file path.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 Documentation/config.txt                      | 18 +++++---
 Documentation/git-add.txt                     |  4 +-
 Documentation/git-submodule.txt               | 45 ++++++++++---------
 Documentation/gitmodules.txt                  | 15 ++++---
 Documentation/gitsubmodules.txt               | 18 ++++----
 .../technical/api-submodule-config.txt        |  6 +--
 contrib/subtree/git-subtree.txt               |  2 +-
 7 files changed, 59 insertions(+), 49 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2659153cb..647e33646 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -742,6 +742,12 @@ core.excludesFile::
 	If `$XDG_CONFIG_HOME` is either not set or empty, `$HOME/.config/git/ignore`
 	is used instead. See linkgit:gitignore[5].
 
+core.submodulesFile::
+	Specifies the pathname to the file that contains the submodules
+	configuration. The path must be relative to the repository work tree.
+	The specified path replaces the default per-repository '.gitmodules'
+	file. See linkgit:gitmodules[5].
+
 core.askPass::
 	Some commands (e.g. svn and http interfaces) that interactively
 	ask for a password can be told to use an external program given
@@ -3170,7 +3176,7 @@ stash.showStat::
 	See description of 'show' command in linkgit:git-stash[1].
 
 submodule.<name>.url::
-	The URL for a submodule. This variable is copied from the .gitmodules
+	The URL for a submodule. This variable is copied from the gitmodules
 	file to the git config via 'git submodule init'. The user can change
 	the configured URL before obtaining the submodule via 'git submodule
 	update'. If neither submodule.<name>.active or submodule.active are
@@ -3191,7 +3197,7 @@ submodule.<name>.update::
 submodule.<name>.branch::
 	The remote branch name for a submodule, used by `git submodule
 	update --remote`.  Set this option to override the value found in
-	the `.gitmodules` file.  See linkgit:git-submodule[1] and
+	the gitmodules file.  See linkgit:git-submodule[1] and
 	linkgit:gitmodules[5] for details.
 
 submodule.<name>.fetchRecurseSubmodules::
@@ -3212,10 +3218,10 @@ submodule.<name>.ignore::
 	let submodules with modified tracked files in their work tree show up.
 	Using "none" (the default when this option is not set) also shows
 	submodules that have untracked files in their work tree as changed.
-	This setting overrides any setting made in .gitmodules for this submodule,
-	both settings can be overridden on the command line by using the
-	"--ignore-submodules" option. The 'git submodule' commands are not
-	affected by this setting.
+	This setting overrides any setting made in the gitmodules file for
+	this submodule, both settings can be overridden on the command line by
+	using the "--ignore-submodules" option. The 'git submodule' commands
+	are not affected by this setting.
 
 submodule.<name>.active::
 	Boolean value indicating if the submodule is of interest to git
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index d50fa339d..8add7e7c0 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -171,8 +171,8 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
 --no-warn-embedded-repo::
 	By default, `git add` will warn when adding an embedded
 	repository to the index without using `git submodule add` to
-	create an entry in `.gitmodules`. This option will suppress the
-	warning (e.g., if you are manually performing operations on
+	create an entry in the gitmodules file. This option will suppress
+	the warning (e.g., if you are manually performing operations on
 	submodules).
 
 --renormalize::
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 71c5618e8..6bd8e3d44 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -58,13 +58,13 @@ for commit without cloning. The <path> is also used as the submodule's
 logical name in its configuration entries unless `--name` is used
 to specify a logical name.
 +
-The given URL is recorded into `.gitmodules` for use by subsequent users
-cloning the superproject. If the URL is given relative to the
+The given URL is recorded in the gitmodules file for use by subsequent
+users cloning the superproject. If the URL is given relative to the
 superproject's repository, the presumption is the superproject and
 submodule repositories will be kept together in the same relative
 location, and only the superproject's URL needs to be provided.
 git-submodule will correctly locate the submodule using the relative
-URL in `.gitmodules`.
+URL in the gitmodules file.
 
 status [--cached] [--recursive] [--] [<path>...]::
 	Show the status of the submodules. This will print the SHA-1 of the
@@ -86,8 +86,8 @@ too (and can also report changes to a submodule's work tree).
 init [--] [<path>...]::
 	Initialize the submodules recorded in the index (which were
 	added and committed elsewhere) by setting `submodule.$name.url`
-	in .git/config. It uses the same setting from `.gitmodules` as
-	a template. If the URL is relative, it will be resolved using
+	in .git/config. It uses the same setting from the gitmodules file
+	as a template. If the URL is relative, it will be resolved using
 	the default remote. If there is no default remote, the current
 	repository will be assumed to be upstream.
 +
@@ -162,8 +162,8 @@ The following 'update' procedures are only available via the
 	none;; the submodule is not updated.
 
 If the submodule is not yet initialized, and you just want to use the
-setting as stored in `.gitmodules`, you can automatically initialize the
-submodule with the `--init` option.
+setting as stored in the gitmodules file, you can automatically initialize
+the submodule with the `--init` option.
 
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.
@@ -185,8 +185,8 @@ foreach [--recursive] <command>::
 	Evaluates an arbitrary shell command in each checked out submodule.
 	The command has access to the variables $name, $path, $sha1 and
 	$toplevel:
-	$name is the name of the relevant submodule section in `.gitmodules`,
-	$path is the name of the submodule directory relative to the
+	$name is the name of the relevant submodule section in the gitmodules
+	file, $path is the name of the submodule directory relative to the
 	superproject, $sha1 is the commit as recorded in the superproject,
 	and $toplevel is the absolute path to the top-level of the superproject.
 	Any submodules defined in the superproject but not checked out are
@@ -207,11 +207,11 @@ git submodule foreach 'echo $path `git rev-parse HEAD`'
 
 sync [--recursive] [--] [<path>...]::
 	Synchronizes submodules' remote URL configuration setting
-	to the value specified in `.gitmodules`. It will only affect those
-	submodules which already have a URL entry in .git/config (that is the
-	case when they are initialized or freshly added). This is useful when
-	submodule URLs change upstream and you need to update your local
-	repositories accordingly.
+	to the value specified in the gitmodules file. It will only affect
+	those submodules which already have a URL entry in .git/config (that
+	is the case when they are initialized or freshly added). This is
+	useful when submodule URLs change upstream and you need to update your
+	local repositories accordingly.
 +
 "git submodule sync" synchronizes all submodules while
 "git submodule sync \-- A" synchronizes submodule "A" only.
@@ -247,9 +247,9 @@ OPTIONS
 --branch::
 	Branch of repository to add as submodule.
 	The name of the branch is recorded as `submodule.<name>.branch` in
-	`.gitmodules` for `update --remote`.  A special value of `.` is used to
-	indicate that the name of the branch in the submodule should be the
-	same name as the current branch in the current repository.
+	the gitmodules file for `update --remote`.  A special value of `.` is
+	used to indicate that the name of the branch in the submodule should
+	be the same name as the current branch in the current repository.
 
 -f::
 --force::
@@ -289,8 +289,8 @@ OPTIONS
 	is branch's remote (`branch.<name>.remote`), defaulting to `origin`.
 	The remote branch used defaults to `master`, but the branch name may
 	be overridden by setting the `submodule.<name>.branch` option in
-	either `.gitmodules` or `.git/config` (with `.git/config` taking
-	precedence).
+	either the gitmodules file or `.git/config` (with `.git/config`
+	taking precedence).
 +
 This works for any of the supported update procedures (`--checkout`,
 `--rebase`, etc.).  The only change is the source of the target SHA-1.
@@ -378,7 +378,7 @@ for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
 --[no-]recommend-shallow::
 	This option is only valid for the update command.
 	The initial clone of a submodule will use the recommended
-	`submodule.<name>.shallow` as provided by the `.gitmodules` file
+	`submodule.<name>.shallow` as provided by the gitmodules file
 	by default. To ignore the suggestions use `--no-recommend-shallow`.
 
 -j <n>::
@@ -394,8 +394,9 @@ for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
 
 FILES
 -----
-When initializing submodules, a `.gitmodules` file in the top-level directory
-of the containing repository is used to find the url of each submodule.
+When initializing submodules, a gitmodules file is used to find the url of
+each submodule. By default this file is named `.gitmodules` and is located in
+the top-level directory of the containing repository.
 This file should be formatted in the same way as `$GIT_DIR/config`. The key
 to each submodule url is "submodule.$name.url".  See linkgit:gitmodules[5]
 for details.
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index db5d47eb1..833c0a172 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -13,9 +13,12 @@ $GIT_WORK_DIR/.gitmodules
 DESCRIPTION
 -----------
 
-The `.gitmodules` file, located in the top-level directory of a Git
-working tree, is a text file with a syntax matching the requirements
-of linkgit:git-config[1].
+A gitmodules file is a text file with a syntax matching the requirements of
+linkgit:git-config[1].
+
+By default the file is named `.gitmodules` and is located in the top-level
+directory of a Git working tree, The location can be changed by setting the
+`core.submodulesFile` config option.
 
 The file contains one subsection per submodule, and the subsection value
 is the name of the submodule. The name is set to the path where the
@@ -27,7 +30,7 @@ submodule.<name>.path::
 	Defines the path, relative to the top-level directory of the Git
 	working tree, where the submodule is expected to be checked out.
 	The path name must not end with a `/`. All submodule paths must
-	be unique within the .gitmodules file.
+	be unique within the gitmodules file.
 
 submodule.<name>.url::
 	Defines a URL from which the submodule repository can be cloned.
@@ -60,7 +63,7 @@ submodule.<name>.fetchRecurseSubmodules::
 	This option can be used to control recursive fetching of this
 	submodule. If this option is also present in the submodules entry in
 	.git/config of the superproject, the setting there will override the
-	one found in .gitmodules.
+	one found in the gitmodules file.
 	Both settings can be overridden on the command line by using the
 	"--[no-]recurse-submodules" option to "git fetch" and "git pull".
 
@@ -86,7 +89,7 @@ submodule.<name>.ignore::
 
 	If this option is also present in the submodules entry in .git/config
 	of the superproject, the setting there will override the one found in
-	.gitmodules.
+	the gitmodules file.
 	Both settings can be overridden on the command line by using the
 	"--ignore-submodule" option. The 'git submodule' commands are not
 	affected by this setting.
diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
index 3b9faabdb..abfb70227 100644
--- a/Documentation/gitsubmodules.txt
+++ b/Documentation/gitsubmodules.txt
@@ -29,13 +29,13 @@ the submodule's working directory pointing to (i).
 Assuming the submodule has a Git directory at `$GIT_DIR/modules/foo/`
 and a working directory at `path/to/bar/`, the superproject tracks the
 submodule via a `gitlink` entry in the tree at `path/to/bar` and an entry
-in its `.gitmodules` file (see linkgit:gitmodules[5]) of the form
+in its gitmodules file (see linkgit:gitmodules[5]) of the form
 `submodule.foo.path = path/to/bar`.
 
 The `gitlink` entry contains the object name of the commit that the
 superproject expects the submodule's working directory to be at.
 
-The section `submodule.foo.*` in the `.gitmodules` file gives additional
+The section `submodule.foo.*` in the gitmodules file gives additional
 hints to Git's porcelain layer. For example, the `submodule.foo.url`
 setting specifies where to obtain the submodule.
 
@@ -108,7 +108,7 @@ If the submodule is not yet initialized, then the configuration
 inside the submodule does not exist yet, so where to
 obtain the submodule from is configured here for example.
 
- * The `.gitmodules` file inside the superproject. A project usually
+ * The gitmodules file inside the superproject. A project usually
    uses this file to suggest defaults for the upstream collection
    of repositories for the mapping that is required between a
    submodule's name and its path.
@@ -127,12 +127,12 @@ FORMS
 Submodules can take the following forms:
 
  * The basic form described in DESCRIPTION with a Git directory,
-a working directory, a `gitlink`, and a `.gitmodules` entry.
+a working directory, a `gitlink`, and a linkgit:gitmodules[5] entry.
 
  * "Old-form" submodule: A working directory with an embedded
-`.git` directory, and the tracking `gitlink` and `.gitmodules` entry in
-the superproject. This is typically found in repositories generated
-using older versions of Git.
+`.git` directory, and the tracking `gitlink` and linkgit:gitmodules[5] entry
+in the superproject. This is typically found in repositories generated using
+older versions of Git.
 +
 It is possible to construct these old form repositories manually.
 +
@@ -140,7 +140,7 @@ When deinitialized or deleted (see below), the submodule's Git
 directory is automatically moved to `$GIT_DIR/modules/<name>/`
 of the superproject.
 
- * Deinitialized submodule: A `gitlink`, and a `.gitmodules` entry,
+ * Deinitialized submodule: A `gitlink`, and a linkgit:gitmodules[5] entry,
 but no submodule working directory. The submodule's Git directory
 may be there as after deinitializing the Git directory is kept around.
 The directory which is supposed to be the working directory is empty instead.
@@ -155,7 +155,7 @@ is not affected. This can be undone using `git submodule init`.
 using `git revert`.
 +
 The deletion removes the superproject's tracking data, which are
-both the `gitlink` entry and the section in the `.gitmodules` file.
+both the `gitlink` entry and the section in the gitmodules file.
 The submodule's working directory is removed from the file
 system, but the Git directory is kept around as it to make it
 possible to checkout past commits without requiring fetching
diff --git a/Documentation/technical/api-submodule-config.txt b/Documentation/technical/api-submodule-config.txt
index ee907c4a8..1b9f86493 100644
--- a/Documentation/technical/api-submodule-config.txt
+++ b/Documentation/technical/api-submodule-config.txt
@@ -4,7 +4,7 @@ submodule config cache API
 The submodule config cache API allows to read submodule
 configurations/information from specified revisions. Internally
 information is lazily read into a cache that is used to avoid
-unnecessary parsing of the same .gitmodules files. Lookups can be done by
+unnecessary parsing of the same gitmodules files. Lookups can be done by
 submodule path or name.
 
 Usage
@@ -12,7 +12,7 @@ Usage
 
 To initialize the cache with configurations from the worktree the caller
 typically first calls `gitmodules_config()` to read values from the
-worktree .gitmodules and then to overlay the local git config values
+worktree gitmodules file and then to overlay the local git config values
 `parse_submodule_config_option()` from the config parsing
 infrastructure.
 
@@ -61,6 +61,6 @@ via e.g. `gitmodules_config()`, it will overwrite the null_sha1 entry.
 So in the normal case, when HEAD:.gitmodules is parsed first and then overlayed
 with the repository configuration, the null_sha1 entry contains the local
 configuration of a submodule (e.g. consolidated values from local git
-configuration and the .gitmodules file in the worktree).
+configuration and the gitmodules file).
 
 For an example usage see test-submodule-config.c.
diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 352deda69..a86f8b6f5 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -28,7 +28,7 @@ as a subdirectory of your application.
 
 Subtrees are not to be confused with submodules, which are meant for
 the same task. Unlike submodules, subtrees do not need any special
-constructions (like .gitmodules files or gitlinks) be present in
+constructions (like gitmodules files or gitlinks) be present in
 your repository, and do not force end-users of your
 repository to do anything special or to understand how subtrees
 work. A subtree is just a subdirectory that can be
-- 
2.17.0

