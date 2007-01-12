From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] use 'init' instead of 'init-db' for shipped docs and tools
Date: Fri, 12 Jan 2007 16:01:46 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701121554490.2577@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 22:02:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5TXM-00064J-ID
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 22:02:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160998AbXALVBv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 16:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161004AbXALVBv
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 16:01:51 -0500
Received: from relais.videotron.ca ([24.201.245.36]:53874 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1160998AbXALVBt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 16:01:49 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JBR00DFEX2Y2E10@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 12 Jan 2007 16:01:48 -0500 (EST)
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36709>

While 'init-db' still is and probably will always remain a valid git 
command for obvious backward compatibility reasons, it would be a good 
idea to move shipped tools and docs to using 'init' instead.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
diff --git a/Documentation/config.txt b/Documentation/config.txt
index b4aae0d..f7dba89 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -100,7 +100,7 @@ core.sharedRepository::
 	group-writable). When 'all' (or 'world' or 'everybody'), the
 	repository will be readable by all users, additionally to being
 	group-shareable. When 'umask' (or 'false'), git will use permissions
-	reported by umask(2). See gitlink:git-init-db[1]. False by default.
+	reported by umask(2). See gitlink:git-init[1]. False by default.
 
 core.warnAmbiguousRefs::
 	If true, git will warn you if the ref name you passed it is ambiguous
diff --git a/Documentation/core-tutorial.txt b/Documentation/core-tutorial.txt
index 5ea6117..0cd33fb 100644
--- a/Documentation/core-tutorial.txt
+++ b/Documentation/core-tutorial.txt
@@ -46,12 +46,12 @@ to import into git.
 For our first example, we're going to start a totally new repository from
 scratch, with no pre-existing files, and we'll call it `git-tutorial`.
 To start up, create a subdirectory for it, change into that
-subdirectory, and initialize the git infrastructure with `git-init-db`:
+subdirectory, and initialize the git infrastructure with `git-init`:
 
 ------------------------------------------------
 $ mkdir git-tutorial
 $ cd git-tutorial
-$ git-init-db
+$ git-init
 ------------------------------------------------
 
 to which git will reply
@@ -1371,11 +1371,11 @@ $ mkdir my-git.git
 ------------
 
 Then, make that directory into a git repository by running
-`git init-db`, but this time, since its name is not the usual
+`git init`, but this time, since its name is not the usual
 `.git`, we do things slightly differently:
 
 ------------
-$ GIT_DIR=my-git.git git-init-db
+$ GIT_DIR=my-git.git git-init
 ------------
 
 Make sure this directory is available for others you want your
@@ -1511,7 +1511,7 @@ A recommended workflow for a "project lead" goes like this:
 +
 If other people are pulling from your repository over dumb
 transport protocols (HTTP), you need to keep this repository
-'dumb transport friendly'.  After `git init-db`,
+'dumb transport friendly'.  After `git init`,
 `$GIT_DIR/hooks/post-update` copied from the standard templates
 would contain a call to `git-update-server-info` but the
 `post-update` hook itself is disabled by default -- enable it
diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
index 8e09bea..775bf42 100644
--- a/Documentation/cvs-migration.txt
+++ b/Documentation/cvs-migration.txt
@@ -80,7 +80,7 @@ it:
 ------------------------------------------------
 $ mkdir /pub/my-repo.git
 $ cd /pub/my-repo.git
-$ git --bare init-db --shared
+$ git --bare init --shared
 $ git --bare fetch /home/alice/myproject master:master
 ------------------------------------------------
 
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index e1fd688..596b567 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -79,9 +79,7 @@ was primarily meant to initialize the object database, but over
 time it has become responsible for setting up the other aspects
 of the repository, such as installing the default hooks and
 setting the configuration variables.  The old name is retained
-because people are so used to it and many existing documents
-refer to it that way, and this will not change for some time to
-come.
+for backward compatibility reasons.
 
 
 EXAMPLES
diff --git a/Documentation/git-p4import.txt b/Documentation/git-p4import.txt
index ee9e8fa..6edb9f1 100644
--- a/Documentation/git-p4import.txt
+++ b/Documentation/git-p4import.txt
@@ -93,7 +93,7 @@ perforce branch into a branch named "jammy", like so:
 ------------
 $ mkdir -p /home/sean/import/jam
 $ cd /home/sean/import/jam
-$ git init-db
+$ git init
 $ git p4import //public/jam jammy
 ------------
 
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 1b01313..9ed7211 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -171,7 +171,7 @@ OPTIONS
 --shared::
 --template=<template_directory>::
 	Only used with the 'init' command.
-	These are passed directly to gitlink:git-init-db[1].
+	These are passed directly to gitlink:git-init[1].
 
 -r <ARG>::
 --revision <ARG>::
@@ -367,7 +367,7 @@ Basic Examples
 Tracking and contributing to a the trunk of a Subversion-managed project:
 
 ------------------------------------------------------------------------
-# Initialize a repo (like git init-db):
+# Initialize a repo (like git init):
 	git-svn init http://svn.foo.org/project/trunk
 # Fetch remote revisions:
 	git-svn fetch
@@ -388,7 +388,7 @@ See also:
 '<<tracking-multiple-repos,Tracking Multiple Repositories or Branches>>'
 
 ------------------------------------------------------------------------
-# Initialize a repo (like git init-db):
+# Initialize a repo (like git init):
 	git-svn multi-init http://svn.foo.org/project \
 		-T trunk -b branches -t tags
 # Fetch remote revisions:
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 5662cdc..f89d745 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -354,8 +354,7 @@ gitlink:git-index-pack[1]::
 	Build pack idx file for an existing packed archive.
 
 gitlink:git-init[1]::
-gitlink:git-init-db[1]::
-	Creates an empty git object database, or reinitialize an
+	Creates an empty git repository, or reinitialize an
 	existing one.
 
 gitlink:git-merge-file[1]::
diff --git a/Documentation/hooks.txt b/Documentation/hooks.txt
index 161123f..e3b76f9 100644
--- a/Documentation/hooks.txt
+++ b/Documentation/hooks.txt
@@ -3,7 +3,7 @@ Hooks used by git
 
 Hooks are little scripts you can place in `$GIT_DIR/hooks`
 directory to trigger action at certain points.  When
-`git-init-db` is run, a handful example hooks are copied in the
+`git-init` is run, a handful example hooks are copied in the
 `hooks` directory of the new repository, but by default they are
 all disabled.  To enable a hook, make it executable with `chmod +x`.
 
diff --git a/Documentation/howto/setup-git-server-over-http.txt b/Documentation/howto/setup-git-server-over-http.txt
index ba19156..a202f3a 100644
--- a/Documentation/howto/setup-git-server-over-http.txt
+++ b/Documentation/howto/setup-git-server-over-http.txt
@@ -70,7 +70,7 @@ DocumentRoot /where/ever/httpd.conf" to find your root:
 Initialize a bare repository
 
     $ cd my-new-repo.git
-    $ git --bare init-db
+    $ git --bare init
 
 
 Change the ownership to your web-server's credentials. Use "grep ^User
diff --git a/Documentation/repository-layout.txt b/Documentation/repository-layout.txt
index e20fb7e..0fdd366 100644
--- a/Documentation/repository-layout.txt
+++ b/Documentation/repository-layout.txt
@@ -102,7 +102,7 @@ branches::
 hooks::
 	Hooks are customization scripts used by various git
 	commands.  A handful of sample hooks are installed when
-	`git init-db` is run, but all of them are disabled by
+	`git init` is run, but all of them are disabled by
 	default.  To enable, they need to be made executable.
 	Read link:hooks.html[hooks] for more details about
 	each hook.
diff --git a/INSTALL b/INSTALL
index e7aea60..361c65b 100644
--- a/INSTALL
+++ b/INSTALL
@@ -95,7 +95,7 @@ Issues of note:
    repository itself.  For example, you could:
 
 	$ mkdir manual && cd manual
-	$ git init-db
+	$ git init
 	$ git fetch-pack git://git.kernel.org/pub/scm/git/git.git man html |
 	  while read a b
 	  do
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 22729f0..8e7540b 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -56,7 +56,7 @@ static void copy_templates_1(char *path, int baselen,
 
 	/* Note: if ".git/hooks" file exists in the repository being
 	 * re-initialized, /etc/core-git/templates/hooks/update would
-	 * cause git-init-db to fail here.  I think this is sane but
+	 * cause git-init to fail here.  I think this is sane but
 	 * it means that the set of templates we ship by default, along
 	 * with the way the namespace under .git/ is organized, should
 	 * be really carefully chosen.
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 1de14ea..975777f 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -22,7 +22,7 @@ commit
 diff
 fetch
 grep
-init-db
+init
 log
 merge
 mv
diff --git a/git-archimport.perl b/git-archimport.perl
index ada60ec..2e15781 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -226,7 +226,7 @@ my $import = 0;
 unless (-d $git_dir) { # initial import
     if ($psets[0]{type} eq 'i' || $psets[0]{type} eq 't') {
         print "Starting import from $psets[0]{id}\n";
-	`git-init-db`;
+	`git-init`;
 	die $! if $?;
 	$import = 1;
     } else {
diff --git a/git-clone.sh b/git-clone.sh
index cf761b2..0f7bbbf 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -214,7 +214,7 @@ yes)
 	GIT_DIR="$D" ;;
 *)
 	GIT_DIR="$D/.git" ;;
-esac && export GIT_DIR && git-init-db ${template+"$template"} || usage
+esac && export GIT_DIR && git-init ${template+"$template"} || usage
 
 if test -n "$reference"
 then
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 1018f4f..35ef0c0 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -520,7 +520,7 @@ $orig_git_index = $ENV{GIT_INDEX_FILE} if exists $ENV{GIT_INDEX_FILE};
 my %index; # holds filenames of one index per branch
 
 unless (-d $git_dir) {
-	system("git-init-db");
+	system("git-init");
 	die "Cannot init the GIT db at $git_tree: $?\n" if $?;
 	system("git-read-tree");
 	die "Cannot init an empty tree: $?\n" if $?;
@@ -660,7 +660,7 @@ $ignorebranch{'#CVSPS_NO_BRANCH'} = 1;
 sub commit {
 	if ($branch eq $opt_o && !$index{branch} && !get_headref($branch, $git_dir)) {
 	    # looks like an initial commit
-	    # use the index primed by git-init-db
+	    # use the index primed by git-init
 	    $ENV{GIT_INDEX_FILE} = '.git/index';
 	    $index{$branch} = '.git/index';
 	} else {
diff --git a/git-p4import.py b/git-p4import.py
index 908941d..5c56cac 100644
--- a/git-p4import.py
+++ b/git-p4import.py
@@ -163,7 +163,7 @@ class git_command:
             self.gitdir = self.get_single("rev-parse --git-dir")
             report(2, "gdir:", self.gitdir)
         except:
-            die("Not a git repository... did you forget to \"git init-db\" ?")
+            die("Not a git repository... did you forget to \"git init\" ?")
         try:
             self.cdup = self.get_single("rev-parse --show-cdup")
             if self.cdup != "":
diff --git a/git-svn.perl b/git-svn.perl
index 56f1700..9986a0c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -286,7 +286,7 @@ sub init {
 
 	$SVN_URL = $url;
 	unless (-d $GIT_DIR) {
-		my @init_db = ('init-db');
+		my @init_db = ('init');
 		push @init_db, "--template=$_template" if defined $_template;
 		push @init_db, "--shared" if defined $_shared;
 		command_noisy(@init_db);
diff --git a/git-svnimport.perl b/git-svnimport.perl
index f1f1a7d..3af8c7e 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -285,7 +285,7 @@ my $last_rev = "";
 my $last_branch;
 my $current_rev = $opt_s || 1;
 unless(-d $git_dir) {
-	system("git-init-db");
+	system("git-init");
 	die "Cannot init the GIT db at $git_tree: $?\n" if $?;
 	system("git-read-tree");
 	die "Cannot init an empty tree: $?\n" if $?;
diff --git a/perl/Git.pm b/perl/Git.pm
index 2b26b65..3474ad3 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -63,7 +63,7 @@ for doing easily operations which are not totally trivial to do over
 the generic command interface.
 
 While some commands can be executed outside of any context (e.g. 'version'
-or 'init-db'), most operations require a repository context, which in practice
+or 'init'), most operations require a repository context, which in practice
 means getting an instance of the Git object using the repository() constructor.
 (In the future, we will also get a new_repository() constructor.) All commands
 called as methods of the object are then executed in the context of the
diff --git a/t/README b/t/README
index 7abab1d..36f2517 100644
--- a/t/README
+++ b/t/README
@@ -18,7 +18,7 @@ The easiest way to run tests is to say "make".  This runs all
 the tests.
 
     *** t0000-basic.sh ***
-    *   ok 1: .git/objects should be empty after git-init-db in an empty repo.
+    *   ok 1: .git/objects should be empty after git-init in an empty repo.
     *   ok 2: .git/objects should have 256 subdirectories.
     *   ok 3: git-update-index without --add should fail adding.
     ...
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 0cd1c41..186de70 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -31,12 +31,12 @@ fi
 . ./test-lib.sh
 
 ################################################################
-# init-db has been done in an empty repository.
+# git-init has been done in an empty repository.
 # make sure it is empty.
 
 find .git/objects -type f -print >should-be-empty
 test_expect_success \
-    '.git/objects should be empty after git-init-db in an empty repo.' \
+    '.git/objects should be empty after git-init in an empty repo.' \
     'cmp -s /dev/null should-be-empty' 
 
 # also it should have 2 subdirectories; no fan-out anymore, pack, and info.
diff --git a/t/t4116-apply-reverse.sh b/t/t4116-apply-reverse.sh
index 74f5c2a..aa2c869 100755
--- a/t/t4116-apply-reverse.sh
+++ b/t/t4116-apply-reverse.sh
@@ -50,12 +50,12 @@ test_expect_success 'setup separate repository lacking postimage' '
 
 	git tar-tree initial initial | tar xf - &&
 	(
-		cd initial && git init-db && git add .
+		cd initial && git init && git add .
 	) &&
 
 	git tar-tree second second | tar xf - &&
 	(
-		cd second && git init-db && git add .
+		cd second && git init && git add .
 	)
 
 '
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index de45ac4..f511547 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -44,7 +44,7 @@ test_expect_success \
     'unpack without delta' \
     "GIT_OBJECT_DIRECTORY=.git2/objects &&
      export GIT_OBJECT_DIRECTORY &&
-     git-init-db &&
+     git-init &&
      git-unpack-objects -n <test-1-${packname_1}.pack &&
      git-unpack-objects <test-1-${packname_1}.pack"
 
@@ -75,7 +75,7 @@ test_expect_success \
     'unpack with delta' \
     'GIT_OBJECT_DIRECTORY=.git2/objects &&
      export GIT_OBJECT_DIRECTORY &&
-     git-init-db &&
+     git-init &&
      git-unpack-objects -n <test-2-${packname_2}.pack &&
      git-unpack-objects <test-2-${packname_2}.pack'
 
@@ -100,7 +100,7 @@ test_expect_success \
     'use packed objects' \
     'GIT_OBJECT_DIRECTORY=.git2/objects &&
      export GIT_OBJECT_DIRECTORY &&
-     git-init-db &&
+     git-init &&
      cp test-1-${packname_1}.pack test-1-${packname_1}.idx .git2/objects/pack && {
 	 git-diff-tree --root -p $commit &&
 	 while read object
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 77c3c57..ef78df6 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -97,7 +97,7 @@ pull_to_client () {
 (
 	mkdir client &&
 	cd client &&
-	git-init-db 2>> log2.txt
+	git-init 2>> log2.txt
 )
 
 add A1
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 90eeeba..3ce9446 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -73,7 +73,7 @@ test_expect_success 'fetch following tags' '
 
 	mkdir four &&
 	cd four &&
-	git init-db &&
+	git init &&
 
 	git fetch .. :track &&
 	git show-ref --verify refs/tags/anno &&
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index f841574..7eb3783 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -17,7 +17,7 @@ test_expect_success setup '
 test_expect_success 'pulling into void' '
 	mkdir cloned &&
 	cd cloned &&
-	git init-db &&
+	git init &&
 	git pull ..
 '
 
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 2f4ff82..3440332 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -88,7 +88,7 @@ test_expect_success \
 
 test_expect_success "Michael Cassar's test case" '
 	rm -fr .git papers partA &&
-	git init-db &&
+	git init &&
 	mkdir -p papers/unsorted papers/all-papers partA &&
 	echo a > papers/unsorted/Thesis.pdf &&
 	echo b > partA/outline.txt &&
@@ -109,7 +109,7 @@ rm -fr papers partA path?
 
 test_expect_success "Sergey Vlasov's test case" '
 	rm -fr .git &&
-	git init-db &&
+	git init &&
 	mkdir ab &&
 	date >ab.c &&
 	date >ab/d &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 72ea2b2..8e3ee6c 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -220,8 +220,8 @@ test_create_repo () {
 	repo="$1"
 	mkdir "$repo"
 	cd "$repo" || error "Cannot setup test environment"
-	"$GIT_EXEC_PATH/git" init-db --template=$GIT_EXEC_PATH/templates/blt/ >/dev/null 2>&1 ||
-	error "cannot run git init-db -- have you built things yet?"
+	"$GIT_EXEC_PATH/git" init --template=$GIT_EXEC_PATH/templates/blt/ >/dev/null 2>&1 ||
+	error "cannot run git init -- have you built things yet?"
 	mv .git/hooks .git/hooks-disabled
 	cd "$owd"
 }
