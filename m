From: Zack Brown <zbrown@tumblerings.org>
Subject: README rewrite
Date: Sat, 14 May 2005 21:42:44 -0700
Message-ID: <20050515044244.GA7391@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 06:49:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXB3d-0002pg-US
	for gcvg-git@gmane.org; Sun, 15 May 2005 06:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVEOEss (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 00:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVEOEss
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 00:48:48 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:57237 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S261466AbVEOErp
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 00:47:45 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.50)
	id 1DXAxg-0002jo-W1; Sat, 14 May 2005 21:42:45 -0700
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Petr,

This patch is a complete rewrite of the Cogito section of the README file.
Commands are explained in detail, with a quickstart section at the top and a
full command reference below.

Signed-off-by: Zack Brown <zbrown@tumblerings.org>

README: needs update
Index: README
===================================================================
--- 4ef3de6ae44888d83e8c00326ddcc9f40cbd12e2/README  (mode:100644)
+++ uncommitted/README  (mode:100644)
@@ -1,164 +1,656 @@
-	GIT - the stupid content tracker
+                Cogito
 
-"git" can mean anything, depending on your mood.
+Cogito is a version control system layered on top of the git
+content-tracking filesystem. This document first describes some quick ways
+to get started using Cogito, then goes over each available command one by
+one.
 
- - random three-letter combination that is pronounceable, and not
-   actually used by any common UNIX command.  The fact that it is a
-   mispronunciation of "get" may or may not be relevant.
- - stupid. contemptible and despicable. simple. Take your pick from the
-   dictionary of slang.
- - "global information tracker": you're in a good mood, and it actually
-   works for you. Angels sing, and a light suddenly fills the room. 
- - "goddamn idiotic truckload of sh*t": when it breaks
+            Quickstart
 
-The GIT itself is merely an extremely fast and flexible filesystem-based
-database designed to store directory trees with regard to their history.
-The top layer is a SCM-like tool Cogito which enables human beings to work
-with the database in a manner to a degree similar to other SCM tools (like
-CVS, BitKeeper or Monotone).
+        Downloading Cogito From Scratch
+
+Cogito can be obtained as a tarball from
+
+http://www.kernel.org/pub/software/scm/cogito/
+
+Download and unpack the latest version, build with make, put the executables
+somewhere in your $PATH (or add your Cogito directory itself to your $PATH),
+and you're ready to go!
+
+The following tools are required by Cogito:
+
+bash
+basic shell environment (sed, grep, textutils, ...)
+diff
+patch
+RCS (the merge program from this package)
+mktemp 1.5+ (Mandrake users beware!)
+libssl
+rsync
+libcurl
+
+        Starting A Fresh git Repository
+
+If you want to start your own project using Cogito, there are two basic ways
+to do this. You may start a fresh repository with no files in it, or you may
+take an existing directory tree and turn it into a git repository.
+
+    Starting An Empty Repository
+
+To create a new repository with no files in it, cd into an empty directory,
+and give the following command:
+
+$ cg-init
+
+Your editor will start up, and you will be asked to type in an initial
+commit description. Type something cute, and exit your editor.
+
+That's it! You're now in your own git repository. Notice there is now a git
+.directory. Go into it and look around, but don't change anything in
+there. That's what Cogito commands are for.
+
+    Turning An Existing Directory Into A Repository
+
+If you have a directory full of files, you can easily turn this into a
+git repository. In fact, it is virtually the same as starting an empty
+repository. Just cd into the directory you want converted into a git
+repository, and give the following command:
+
+$ cg-init
+
+Your editor starts up, you type in an initial commit message, exit your
+editor, and you're good to go. All of the files and directories within that
+directory are now part of a git archive.
+
+        Accessing Someone Else's git Repository
+
+    Creating The Repository
+
+If you want to get started tracking an outside git repository, you first
+must have Cogito's executables on your $PATH. Next, you need the URL (or
+local directory path) of the repository you want to track. You can't just
+use the URL of a tarball, like the one given above for the Cogito source.
+The URL must point specifically to a .git directory somewhere. For instance,
+the URL for Cogito's self-hosting repository is
+
+rsync://rsync.kernel.org/pub/scm/cogito/cogito.git
+
+Notice that the final filename, 'cogito.git', is not called '.git'. That is
+fine. It's still a .git directory.
+
+To clone the repository to your local filesystem, use the cg-clone command.
+cg-clone can be told to create a new directory for your repository, or to
+drop the repository into the current directory.
+
+To have a new directory created, just include the directory in the command,
+as follows:
+
+$ cg-clone rsync://rsync.kernel.org/pub/scm/cogito/cogito.git cogitodir
+
+You will see a whole bunch of output, and when it is over, there will be a
+new directory called 'cogitodir' (or whatever name you chose) in the current
+directory. cd into it. Because we used the Cogito URL, you will see the
+Cogito source tree, with its own .git directory keeping track of everything.
+
+If, instead, you want to clone the repository to the current directory,
+first make sure you are in an empty directory. Then give the following
+command:
+
+$ cg-clone -s rsync://rsync.kernel.org/pub/scm/cogito/cogito.git cogitodir
+
+When you get your prompt back, do an ls to see the source tree and .git
+directory.
+
+    Tracking The Repository
+
+Of course, once you have cloned a repository, you don't just want to leave
+it at that. The upstream sources are constantly being updated, and you want
+to follow these updates. To do this, cd into the repository directory (not
+the .git directory, but the directory that contains the .git directory), and
+give the following command:
+
+$ cg-update
+
+You don't use a URL anymore. Cogito knows which tree you're tracking,
+because this information is stored in the .git directory. The above command
+will track the 'origin' branch, which is the primary branch of development.
+But cg-update can also be used to track specific branches. See below for
+more discussion of branches, and how to track them.
+
+When you give the above cg-update command, this performed two actions.
+First, it pulled all new changes from the upstream repository into your
+local repository. At that point, the changes exist in your local repository
+as part of the project's history. The changes themselves are not actually
+visible in the files you see, but reside in the .git directory's awareness.
+The second thing cg-update does is to merge these changes into the files you
+see and work with. The end result is that, when the cg-update has finished,
+you will see all the upstream changes reflected in your local files, and the
+.git directory will be aware of the history of those changes as well.
+
+It may be that you want to be aware of the history of the upstream work, but
+you don't yet want those changes merged with your own local files. To do
+this, give the following command:
+
+$ cg-pull
+
+This does the first part of cg-update's behavior, but skips the second part.
+Now your local files have not been changed, but your .git directory has been
+updated with the history of all the changes that have occurred in the
+upstream sources.
+
+Using cg-pull is useful for a variety of purposes, for instance if you want
+to construct a diff against the latest version of the upstream sources, but
+don't want those changes to disturb your ongoing work. cg-pull will update
+your .git directory with the history you need to construct your diff,
+without merging that history into your tree, potentially breaking your
+changes.
+
+Typically, if you are not making changes to a repository yourself, but just
+want the latest version of a given project for your own use, you would use
+cg-update. cg-pull is strictly for development work.
+
+Once you've done a cg-pull, you may decide you want to merge after all. In
+this case a cg-update command will do the trick, however you will also
+update your local files with any further upstream changes that have occurred
+since your cg-pull.
+
+        Getting Help
+
+Cogito commands come with their own helpful documentation. To get help on
+cg-update, for example, give this command:
+
+$ cg-pull --help
+
+or, for the same information, try this:
+
+$ cg-help cg-pull
+
+            Command Reference
+
+        Caveats
+
+    What are those cg-Xes?
+
+There are three executables, cg-Xdiffdo, cg-Xlib, and cg-Xmergefile, that
+are not meant to be used from the command line. They provide a library of
+generic functions used by many of the real cg-* commands. You can safely
+ignore them, unless you want to contribute to Cogito development.
+
+    What about file renames?
+
+File renaming (and tracking the history of a file from name to name) is
+being worked on. git provides a wonderful, elegant way to track content as
+it moves from file to file, and renames should be a special case of this.
+
+    Can I give Cogito commands from a subdirectory?
+
+Cogito currently requires that commands be given from the base directory,
+the one containing the .git directory. Patches have been submitted to
+implement the ability to give Cogito commands from subdirectories within the
+repository, but Linus prefers the current bahavior.
+
+        cg-add
+
+This command is used to add files to the git repository. It takes a list of
+files on the command line, and schedules them for addition. To actually add
+them, however, you must subsequently give a cg-commit command.
+
+$ cg-add file1 file2 dir1/file3 dir1/file4 dir2/dir3/file5
+
+The above command schedules file1, file2, file3, file4, and file5 to be
+added to the repository at the next cg-commit.
+
+Notice that you never need to add directories to a repository, in fact
+Cogito won't let you. Directories are added automatically when you add the
+files that are inside them. So you can do something like this:
+
+$ mkdir testdir
+$ echo "testtext" > testdir/testfile
+$ cg-add testdir/testfile
+$ cg-commit
+
+and the testdir directory and testfile file will both be added to the
+repository. If you then do a cg-seek to look at an earlier version of the
+respository, both the file and the directory will be gone.
+
+        cg-admin-lsobj
+
+STUB
+
+        cg-admin-uncommit
+
+STUB
+
+        cg-branch-add
+
+STUB
+
+        cg-branch-ls
+
+STUB
+
+        cg-cancel
+
+This undoes all the changes you have made but not committed to your
+repository. Changes you have already committed are kept. All others are
+reverted to their previous form.
+
+If you have given any cg-add commands, these are also undone in the sense
+that the files and directories will no longer be added on a cg-commit. The
+files and directories themselves are not deleted by a cg-cancel.
+
+        cg-clone
+
+This checks out a remote repository into a local filesystem. It is only used
+for the initial creation of the local repository. Subsequent updates to
+track the upstream sources are done with cg-update or cg-pull.
+
+In its simplest form, cg-clone takes a URL or directory path to a remote
+repository:
+
+$ cg-clone rsync://rsync.kernel.org/pub/scm/cogito/cogito.git
 
+The above command interprets the URL and takes the base directory (in this
+case 'cogito') as the target for the new repository. If the directory
+already exists within the current directory, cg-clone exits with an error
+message. Otherwise this directory is created within the current directory.
+cg-clone then clones the upstream repository into that directory.
 
+It's also possible to specify the target directory by hand on the command
+line, as follows:
 
-	Cogito
-	~~~~~~
+$ cg-clone rsync://rsync.kernel.org/pub/scm/cogito/cogito.git targetdir
 
-This currently simply describes what should you do when you get a tarball
-of Cogito and start to use it and hack upon it. It can give you some guide,
-but the documentation should be certainly consolidated and rewritten.
+If targetdir already exists, cg-clone will exit again with an error message.
+Otherwise, targetdir is created, and the upstream repository is cloned into
+it.
 
-Build it by make, make sure the scripts are in $PATH.
+If you want to clone the upstream sources into the current directory, use
+the -s option:
 
-If, after unpacking the tarball, you do not have the .git subdirectory in the
-tarball root, you
+$ cg-clone -s rsync://rsync.kernel.org/pub/scm/cogito/cogito.git
 
-	cg-clone -s rsync://rsync.kernel.org/pub/scm/cogito/cogito.git
+This will not create a new directory anywhere, but will just create the
+repository directly into the current directory. Any files or directories
+already in the current directory will not be overwritten, and files of the
+same name will retain their old contents. Typically, you never want to use
+the -s option in a directory with existing files or subdirectories.
 
-in that directory, and
+        cg-commit
 
-	cg-branch-add pasky rsync://rsync.kernel.org/pub/scm/cogito/cogito.git
+This command is used after you have edited files in a repository, and now
+want to include your changes in the project history. After a cg-commit, your
+changes will have a changelog entry, including your identity, the date of
+the change, and other information.
 
-(there is already the same branch called "origin" created by cg-clone, however
-we expect the branch name to be "pasky" for the result of the tutorial;
-alternatively, just use "origin" everywhere instead of "pasky").
+Typically you do not need to give any command line options to cg-commit, but
+just use it in its simplest form:
 
-If you already have the .git subdirectory, update it to the latest version by
+$ cg-commit
 
-	cg-update pasky
+This will fire up your editor and ask for a changelog entry. If you leave
+this text blank, a changelog entry will still be created, but with no
+explanatory text. When you exit your editor, your changed files and
+changelog entry are included in the history of the repository, and are
+subject to full version control.
 
-(and repeat that after some time to get the future updates - but see below).
-Then build it again, doing
+There are several ways to avoid dealing with an editor at commit time.
+cg-commit accepts changelog entries from standard input:
 
-	make
+$ echo "my first changelog entry" | cg-commit
 
-and...  well, that's it. Play around with it a bit. ;-)
+You can also specify your changelog entry with the -m option to cg-commit:
 
-You can get my latest changes by doing:
+$ cg-commit -m"my first changelog entry"
 
-	cg-update pasky
+If a changelog entry is sent via standard input, and another one is included
+in a -m option, the entry from standard input is appended with no blank line
+after the entry from the -m option.
 
-If you did some local commits in the meantime, Cogito will attempt to merge
-them with the pasky branch. You then need to check that the merging went
-correctly and without conflicts, possibly do merge-related fixes, and then
-record the merge with cg-commit (if the merge was clean, Cogito will commit
-automatically).
+Multiple -m options can also be given, and they will each be appended, with
+a blank line between, after the one before in the changelog entry.
 
-Sometimes, you will just want to bring the latest stuff from my branch, but not
-merge it (e.g. you might want only to diff against it). Do that by
+A -e option also exists, to force an editor to come up for a commit message,
+even if -m options are present, or if there is data coming from standard
+input. In this case, all input from standard input or -m options is appended
+with a blank line after the text typed into the editor.
 
-	cg-pull pasky
+A -E option also exists and behaves identically to -e, except it will force
+the commit even if the default commit message is not changed.
 
-If there are any changes, two IDs will be printed (I mean the line saying
-"Tree change"). Pass those as parameters to cg-diff and you will get a diff
-describing changes from the last time you pulled. You can also
+A -C option also exists, but it is for internal purposes. You can safely
+ignore it.
 
-	cg-diff -r pasky:HEAD
+There are several environment variables you may use to control the
+authentication information included with the changelog entry. Typically,
+Cogito uses getpwuid(getuid()) to identify the user. This can be overridden
+with these variables:
 
-which will show changes between my and your branch.
+GIT_AUTHOR_NAME       Author's name
+GIT_AUTHOR_EMAIL      Author's e-mail address
+GIT_AUTHOR_DATE       Date, perhaps from a patch e-mail
+GIT_COMMITTER_NAME    Committer's name
+GIT_COMMITTER_EMAIL   Committer's e-mail address
 
-Note that you can also access the Linus' official branch, just by specifying
-'linus' instead of 'pasky'. You can of course add more branches by:
+In the above variables - and in the changelog entries - the author is the
+person who actually wrote a given patch, and the commiter is the person who
+actually gave the command to include this patch in the repository. If you
+are just working on your own repository, or if you commit your own patches,
+then the author and committer are both you.
 
-	cg-branch-add name rsyncurl
+        cg-diff
 
-(the rsyncurl can have a fragment part identifying a branch inside of the
-repository accessible over rsync).  When you do some local changes, you can do
+This compares two trees and outputs a diff, suitable for feeding into the
+patch program. If there is no difference between the trees, cg-diff just
+outputs "ok".
 
-	cg-diff
+With no arguments, it compares the state of your working tree, including all
+your uncommitted changes, with the state of the tree at the last commit. The
+result in this case is a diff showing only the changes you have not yet
+committed. To do this, give the following command:
 
-to display them. "ok" means it's identical, while hash printed means that there
-is some difference. This is a little troublesome so far, since it doesn't like
-even things like ctime or inode number (!) changed. Actual diff is printed out
-when you changed the file contents.
+$ cg-diff
 
-Of course you will want to commit. If you added any new files, do
+You can use the -r command to specify a single tree to compare against your
+current working directory:
 
-	cg-add newfile1 newfile2 ...
+$ cg-diff -r 9e734775f7c22d2f89943ad6c745571f1930105f
 
-first. Then examine your changes by cg-diff or just show what files did you
-change by
+More generally, cg-diff can be used to produce a diff between any two SHA1
+IDs (or tags). The most common way is with a single -r command line
+argument, specifying two trees by hash IDs:
 
-	cg-status
+$ cg-diff -r 9e734775f7c22d2f89943ad6c745571f1930105f:0397236d43e48e821cce5bbe6a80a1a56bb7cc3a
 
-and feel free to commit by
+The same command using tags would be:
 
-	cg-commit
+$ cg-diff -r v2.6.12-rc2:v2.6.12-rc3
 
-which expects the commit message on stdin.
+Or you could use two -r commands to accomplish the same thing:
 
-It is nice to be able to examine the commit history. We have tool for that too.
+$ cg-diff -r v2.6.12-rc2 -r v2.6.12-rc3
 
-	cg-log -r pasky
+Using the colon-separated form, leaving one SHA1 ID or tag name out implies
+that cg-diff should compare the specified tree to the current HEAD:
 
-will get you the history of my branch. cg-log with no arguments will default
-to the history of the current branch.
+$ cg-diff -r v2.6.12-rc2:
 
-If you want to start out new project, do (IN NEW DIRECTORY)
+compares Linux kernel version 2.6.12-rc2 with HEAD, creating a patch to
+convert the 2.6.12-rc2 tree into HEAD. To do the reverse, you simply put the
+':' at the other end of the string:
 
-	cg-init
+$ cg-diff -r :v2.6.12-rc2
 
-which will also do the initial commit, importing the content of the current
-directory if there is anything in it yet.
+This command compares HEAD to Linux kernel version 2.6.12-rc2, creating a
+patch to convert HEAD into the 2.6.12-rc2 tree.
 
-If you want to get someone else's project, do
+The cg-diff command can also take a -p argument.
 
-	cg-clone URL
+STUB - get more info on the -p arg
 
-(the URL will be available as branch "origin" for updating, etc).  cg-clone
-will create new repository for its work - if you want it to work in the current
-directory (like cg-init), pass it the '-s' argument first (like in our first
-cg-clone in this tutorial).
+        cg-export
 
-Note that we missed out a lot of stuff here. There is already support
-for merging (cg-merge), moving your tree to an older commit (cg-seek), etc.
+This command extracts the actual project under version control and puts it
+somewhere for you. Not the revision control history but the project files
+themselves. So if you have the Linux kernel in a git repository and you give
+a cg-export command, only the kernel files themselves, not the git
+repository files, will be exported.
 
-For quick reference, please see
+You must specify a destination for the export on the command line. This may
+have several different interpretations:
 
-	cg-help
+$ cg-export dirname
 
+In the command above, dirname is a directory name. In this case, cg-export
+exports the current state of the project to that directory.
 
-And for reference, my branch URL is:
+$ cg-export filename.tar
 
-	rsync://rsync.kernel.org/pub/scm/cogito/cogito.git
+In the above, filename.tar has a '.tar' extension, and so cg-export produces
+a tarball of the current state of the project. Other recognized extensions
+are '.tar.gz', '.tgz', and '.tar.bz2'.
 
-Note that this all is highly experimental and is likely break frequently. You
-are advised to track LKML and/or the git mailing list.
+You may specify an additional command line argument that is an SHA1 hash ID
+(or tag), to indicate the particular version of the tree you wish to export:
 
+$ cg-export filename.tgz 0397236d43e48e821cce5bbe6a80a1a56bb7cc3a
 
-Software requirements:
+or equivalently:
+
+$ cg-export filename.tgz v2.6.12-rc3
+
+This ability makes cg-export quite powerful. It is not just a tool for
+packaging the current state of the tree, it can package any past state as
+well.
+
+        cg-help
+
+This command is used to get help about other Cogito commands. The form is
+very simple. For instance, to get help on cg-pull, give the following
+command:
+
+$ cg-help cg-pull
+
+This is identical to giving this command as well:
+
+$ cg-pull --help
+
+Help for all other commands use an identical form.
+
+        cg-init
+
+This is used to initialize a new git repository. There are two cases: either
+you want to start a repository in an empty directory; or you want to start a
+repository in a full directory, using the existing files in that directory
+to seed the repository. In both cases the procedure is the same. Change
+directories into the directory you want to turn into the repository. Do not
+create a .git directory or anything weird like that. Just go into your
+target directory and give this command:
+
+$ cg-init
+
+Your editor will start up and you will be asked to write your first commit
+message. Make it a good one. Exit the editor. Welcome to Cogito.
+
+        cg-log
+
+This command generates changelog entries. Unless output is explicitly
+redirected, cg-log pipes all of its output to less. If invoked with no
+arguments, it shows all available changelog entries:
+
+$ cg-log
+
+You may use the -r command line argument to specify an SHA1 hash ID (or tag
+name), or a pair of these. cg-log will generate all log entries starting
+after the first, up to and including the second:
+
+$ cg-log -r v2.6.12-rc2:v2.6.12-rc3
+
+The above command shows all the log entries starting after the actual
+2.6.12-rc2 release, up to and including the entry marking the release of
+2.6.12-rc3. In other words, it produces the full changelog for 2.6.12-rc3.
+
+You may also use the -u command line argument, to specify the name - or part
+of the name - of the person who authored or committed the patch.
+
+$ cg-log -uStroesser
+
+Notice that there is no space between the -u and the name. If there are
+spaces in the name, you must use quotes, like this:
+
+$ cg-log -u"Irwin Fletcher"
+
+Whatever other arguments you give, you may also append a list of files on
+the command line. In that case, cg-log will output only the log entries of
+patches that altered those files.
+
+$ cg-log README Documentation/git.txt
+
+or
+
+$ cg-log -r v2.6.12-rc2:v2.6.12-rc3 -uLinus Makefile
+
+There are two options that control how output is displayed in cg-log. The -f
+option can be given with no arguments, to tell cg-log to include a list of
+all affected files with each changelog entry.
+
+$ cg-log -f -r v2.6.12-rc2:v2.6.12-rc3
+
+The other option to control output is -c. It can be given with no arguments,
+to cause cg-log to display its output in color.
+
+$ cg-log -c -f -r v2.6.12-rc2:v2.6.12-rc3
+
+Currently, the following changelog elements map to the following colors:
+
+header     Green   
+author     Cyan
+committer  Magenta
+files      Blue
+signoff    Yellow
+
+        cg-ls
+
+This command lists all the files in the repository, along with their current
+SHA1 hash ID and the type of data they represent to git (blob, tree).
+
+With no arguments, cg-ls operates on the current state of the repository. If
+given a commit ID or tree ID as a command line argument, it will list the
+files current as of that commit, or to that tree.
+
+STUB (this section needs filling out)
+
+        cg-merge
+
+STUB
+
+        cg-mkpatch
+
+STUB
+
+        cg-patch
+
+STUB
+
+        cg-pull
+
+See the quickstart section above
+
+        cg-restore
+
+STUB
+
+        cg-rm
+
+This command schedules a group of files for removal from the git repository,
+and also removes them right away from your working set of files. Although
+gone from your working set of files, the repository still considers them
+part of the tree until you give a cg-commit command.
+
+        cg-seek
+
+STUB
+
+        cg-status
+
+This command takes no arguments, and returns a list of files you have
+changed in your local tree, but that you have not yet committed with
+cg-commit. File additions and removals with cg-add and cg-rm are not listed.
+A sample usage follows:
+
+$ cg-status
+M cache.h
+$
+
+        cg-tag
+
+This command gives a convenient name of your choosing to a particular state
+of the repository, associating that name with the otherwise cumbersome hash
+ID. You may tag the current state of a repository, or you may specify a
+particular hash ID to tag from any previous state. In software development,
+a developer might tag a particular release with a version number. When Linus
+releases a new kernel, he tags it 'v2.6.12-rc4' or something similar.
+
+To tag the current state of a repository, just specify the name of the tag,
+as follows:
+
+$ cg-tag v2.6.12-rc4
+
+To tag a specific state from some time in the past, you must specify the
+SHA1 hash ID, like this:
+
+$ cg-tag v2.6.12-rc4 ebb5573ea8beaf000d4833735f3e53acb9af844c
+
+You can select a particular hash ID by looking at the 'commit' of the
+changelog entry representing the repository state you wish to tag.
+
+Tags are interchangeable with hash IDs in Cogito commands. Typically, to do
+a diff between two states of a repository, you must give a command like
+this:
+
+$ cg-diff -r 0397236d43e48e821cce5bbe6a80a1a56bb7cc3a:ebb5573ea8beaf000d4833735f3e53acb9af844c
+
+With tags, the same command can be given much more intuitively, like this:
+
+$ cg-diff -r v2.6.12-rc3:v2.6.12-rc4
+
+Both of the above examples will show you the diff between Linux kernel
+version 2.6.12-rc3 and 2.6.12-rc4.
+
+        cg-tag-ls
+
+This command takes no arguments, and lists all tags in a given repository in
+alphabetical order, along with their corresponding SHA1 hash IDs. Doing this
+on the current Cogito repository, for instance, produces the following
+output:
+
+$ cg-tag-ls
+cogito-0.10     4ed293bc0a5ffca9683e139cad499b69a4c4d569
+cogito-0.8      f9f0459b5b39cf83143c91ae39b4eaf187cf678a
+cogito-0.9      cc5517b4ea4134c296d4ce2b1d82700c44200c1e
+git-pasky-0.1   463d05c7c4fe7f24da29749f4c7f25893fc20b8c
+git-pasky-0.2   2c70421be7d88fbee49986d7a5584d1f010a25de
+git-pasky-0.3   d14925c87cdb6ca6345bcb3c8e34a2d659c79451
+git-pasky-0.4   b0bb73f33fc06cc5ff6fca0d2dfce484c5f191b7
+git-pasky-0.5   0ec59a771ff9d618a1b86e0cc1b93e3d9dad17a9
+git-pasky-0.6   b498dafca4dcc136294853d1de09fb64b0b0deea
+git-pasky-0.6.1 1690697813ffcfc35075859534a627699d07c613
+git-pasky-0.6.2 b21cee2236b494787204754960d6a5d2916dfeb4
+git-pasky-0.6.3 acc71aab89b4ae8d5f4a03c758cc4c2bc04a3229
+git-pasky-0.7   bc61d9a04dc39598014f38b0ad7422f0ceaf2cc9
+pull_from_pasky 11ed64c1b141c9ba397a1ca76aef2cd250976007
+$
+
+        cg-update
+
+See the quickstart section above.
 
-	bash, basic shell environment (sed, grep, textutils, ...)
-	diff, patch, RCS (the merge program from this package)
-	mktemp 1.5+ (Mandrake users beware!)
-	libssl
-	rsync
-	libcurl
 
 
 
 	The "core GIT"
 	~~~~~~~~~~~~~~
 
-This is a stupid (but extremely fast) directory content manager.  It
+	GIT - the stupid content tracker
+
+"git" can mean anything, depending on your mood.
+
+ - random three-letter combination that is pronounceable, and not
+   actually used by any common UNIX command.  The fact that it is a
+   mispronunciation of "get" may or may not be relevant.
+ - stupid. contemptible and despicable. simple. Take your pick from the
+   dictionary of slang.
+ - "global information tracker": you're in a good mood, and it actually
+   works for you. Angels sing, and a light suddenly fills the room. 
+ - "goddamn idiotic truckload of sh*t": when it breaks
+
+The GIT itself is merely an extremely fast and flexible filesystem-based
+database designed to store directory trees with regard to their history.
+The top layer is a SCM-like tool Cogito which enables human beings to work
+with the database in a manner to a degree similar to other SCM tools (like
+CVS, BitKeeper or Monotone).
+
+Git is a stupid (but extremely fast) directory content manager.  It
 doesn't do a whole lot, but what it _does_ do is track directory
 contents efficiently.
 


-- 
Zack Brown
