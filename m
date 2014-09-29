From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v3 3/3] Make 'git help everyday' work
Date: Mon, 29 Sep 2014 17:41:47 +0100
Message-ID: <1412008907-3988-4-git-send-email-philipoakley@iee.org>
References: <1412008907-3988-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 29 18:41:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYe11-00071J-LU
	for gcvg-git-2@plane.gmane.org; Mon, 29 Sep 2014 18:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754896AbaI2QlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2014 12:41:23 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:22700 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754879AbaI2QlV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Sep 2014 12:41:21 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AuoRAEOKKVROl3pTPGdsb2JhbAArMwITAQGCeSAzV4kvwEcZCodIBAICgREXAQEFAQEBATg5hAQBBRoBDC8jEAgxARc5CgMRBhMbiCcJvy8YjzwLBQIBTwcSAQqCGg9EgUEFhiiPd4QumiCBfDwvAYEGAQcXgSQBAQE
X-IPAS-Result: AuoRAEOKKVROl3pTPGdsb2JhbAArMwITAQGCeSAzV4kvwEcZCodIBAICgREXAQEFAQEBATg5hAQBBRoBDC8jEAgxARc5CgMRBhMbiCcJvy8YjzwLBQIBTwcSAQqCGg9EgUEFhiiPd4QumiCBfDwvAYEGAQcXgSQBAQE
X-IronPort-AV: E=Sophos;i="5.04,620,1406588400"; 
   d="scan'208";a="1313656"
Received: from host-78-151-122-83.as13285.net (HELO localhost) ([78.151.122.83])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 29 Sep 2014 17:41:15 +0100
X-Mailer: git-send-email 1.9.4.msysgit.0
In-Reply-To: <1412008907-3988-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257629>

The "Everyday GIT With 20 Commands Or So" is not accessible via the
Git help system.  Move everyday.txt to giteveryday.txt so that "git
help everyday" works, and create a new placeholder file everyday.html
to refer people who follow existing URLs to the updated location.

giteveryday.txt now formats well with AsciiDoc as a man page and
refreshed content to a more command modern style.

Add 'everyday' to the help --guides list and update git(1) and 5
other links to giteveryday.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/Makefile             |   3 +-
 Documentation/everyday.txt         | 447 -------------------------------------
 Documentation/everyday.txto        |   9 +
 Documentation/git-push.txt         |   2 +-
 Documentation/git.txt              |   4 +-
 Documentation/gitcore-tutorial.txt |   2 +-
 Documentation/gitcvs-migration.txt |   2 +-
 Documentation/giteveryday.txt      | 447 +++++++++++++++++++++++++++++++++++++
 Documentation/gitglossary.txt      |   2 +-
 Documentation/gittutorial-2.txt    |   4 +-
 Documentation/gittutorial.txt      |   4 +-
 README                             |   2 +-
 builtin/help.c                     |   1 +
 13 files changed, 470 insertions(+), 459 deletions(-)
 delete mode 100644 Documentation/everyday.txt
 create mode 100644 Documentation/everyday.txto
 create mode 100644 Documentation/giteveryday.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3b56714..8d0f709 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -27,6 +27,7 @@ MAN7_TXT += gitcore-tutorial.txt
 MAN7_TXT += gitcredentials.txt
 MAN7_TXT += gitcvs-migration.txt
 MAN7_TXT += gitdiffcore.txt
+MAN7_TXT += giteveryday.txt
 MAN7_TXT += gitglossary.txt
 MAN7_TXT += gitnamespaces.txt
 MAN7_TXT += gitrevisions.txt
@@ -38,11 +39,11 @@ MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
 MAN_XML = $(patsubst %.txt,%.xml,$(MAN_TXT))
 MAN_HTML = $(patsubst %.txt,%.html,$(MAN_TXT))
 
+OBSOLETE_HTML += everyday.html
 OBSOLETE_HTML += git-remote-helpers.html
 DOC_HTML = $(MAN_HTML) $(OBSOLETE_HTML)
 
 ARTICLES += howto-index
-ARTICLES += everyday
 ARTICLES += git-tools
 ARTICLES += git-bisect-lk2009
 # with their own formatting rules.
diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
deleted file mode 100644
index cd7f87c..0000000
--- a/Documentation/everyday.txt
+++ /dev/null
@@ -1,447 +0,0 @@
-giteveryday(7)
-===============
-
-NAME
-----
-giteveryday - A useful minimum set of commands for Everyday Git
-
-SYNOPSIS
---------
-
-Everyday Git With 20 Commands Or So
-
-DESCRIPTION
------------
-
-Git users can broadly be grouped into four categories for the purposes of
-describing here a small set of useful command for everyday Git.
-
-*	<<STANDALONE,Individual Developer (Standalone)>> commands are essential
-	for anybody who makes a commit, even for somebody who works alone.
-
-*	If you work with other people, you will need commands listed in
-	the <<PARTICIPANT,Individual Developer (Participant)>> section as well.
-
-*	People who play the <<INTEGRATOR,Integrator>> role need to learn some
-	more commands in addition to the above.
-
-*	<<ADMINISTRATION,Repository Administration>> commands are for system
-	administrators who are responsible for the care and feeding
-	of Git repositories.
-
-
-Individual Developer (Standalone)[[STANDALONE]]
------------------------------------------------
-
-A standalone individual developer does not exchange patches with
-other people, and works alone in a single repository, using the
-following commands.
-
-  * linkgit:git-init[1] to create a new repository.
-
-  * linkgit:git-log[1] to see what happened.
-
-  * linkgit:git-checkout[1] and linkgit:git-branch[1] to switch
-    branches.
-
-  * linkgit:git-add[1] to manage the index file.
-
-  * linkgit:git-diff[1] and linkgit:git-status[1] to see what
-    you are in the middle of doing.
-
-  * linkgit:git-commit[1] to advance the current branch.
-
-  * linkgit:git-reset[1] and linkgit:git-checkout[1] (with
-    pathname parameters) to undo changes.
-
-  * linkgit:git-merge[1] to merge between local branches.
-
-  * linkgit:git-rebase[1] to maintain topic branches.
-
-  * linkgit:git-tag[1] to mark a known point.
-
-Examples
-~~~~~~~~
-
-Use a tarball as a starting point for a new repository.::
-+
-------------
-$ tar zxf frotz.tar.gz
-$ cd frotz
-$ git init
-$ git add . <1>
-$ git commit -m "import of frotz source tree."
-$ git tag v2.43 <2>
-------------
-+
-<1> add everything under the current directory.
-<2> make a lightweight, unannotated tag.
-
-Create a topic branch and develop.::
-+
-------------
-$ git checkout -b alsa-audio <1>
-$ edit/compile/test
-$ git checkout -- curses/ux_audio_oss.c <2>
-$ git add curses/ux_audio_alsa.c <3>
-$ edit/compile/test
-$ git diff HEAD <4>
-$ git commit -a -s <5>
-$ edit/compile/test
-$ git diff HEAD^ <6>
-$ git commit -a --amend <7>
-$ git checkout master <8>
-$ git merge alsa-audio <9>
-$ git log --since='3 days ago' <10>
-$ git log v2.43.. curses/ <11>
-------------
-+
-<1> create a new topic branch.
-<2> revert your botched changes in `curses/ux_audio_oss.c`.
-<3> you need to tell Git if you added a new file; removal and
-modification will be caught if you do `git commit -a` later.
-<4> to see what changes you are committing.
-<5> commit everything, as you have tested, with your sign-off.
-<6> look at all your changes including the previous commit.
-<7> amend the previous commit, adding all your new changes,
-using your original message.
-<8> switch to the master branch.
-<9> merge a topic branch into your master branch.
-<10> review commit logs; other forms to limit output can be
-combined and include `--max-count=10` (show 10 commits),
-`--until=2005-12-10`, etc.
-<11> view only the changes that touch what's in `curses/`
-directory, since `v2.43` tag.
-
-
-Individual Developer (Participant)[[PARTICIPANT]]
--------------------------------------------------
-
-A developer working as a participant in a group project needs to
-learn how to communicate with others, and uses these commands in
-addition to the ones needed by a standalone developer.
-
-  * linkgit:git-clone[1] from the upstream to prime your local
-    repository.
-
-  * linkgit:git-pull[1] and linkgit:git-fetch[1] from "origin"
-    to keep up-to-date with the upstream.
-
-  * linkgit:git-push[1] to shared repository, if you adopt CVS
-    style shared repository workflow.
-
-  * linkgit:git-format-patch[1] to prepare e-mail submission, if
-    you adopt Linux kernel-style public forum workflow.
-
-  * linkgit:git-send-email[1] to send your e-mail submission without
-    corruption by your MUA.
-
-
-Examples
-~~~~~~~~
-
-Clone the upstream and work on it.  Feed changes to upstream.::
-+
-------------
-$ git clone git://git.kernel.org/pub/scm/.../torvalds/linux-2.6 my2.6
-$ cd my2.6
-$ git checkout -b mine master <1>
-$ edit/compile/test; git commit -a -s <2>
-$ git format-patch master <3>
-$ git send-email --to="person <email@example.com>" 00*.patch <4>
-$ git pull <5>
-$ git log -p ORIG_HEAD.. arch/i386 include/asm-i386 <6>
-$ git ls-remote --heads http://git.kernel.org/.../jgarzik/libata-dev.git <7>
-$ git pull git://git.kernel.org/pub/.../jgarzik/libata-dev.git ALL <8>
-$ git reset --hard ORIG_HEAD <9>
-$ git gc <10>
-$ git fetch --tags <11>
-------------
-+
-<1> checkout a new branch 'mine' from master.
-<2> repeat as needed.
-<3> extract patches from your branch, relative to master,
-<4> and email them.
-<5> `git pull` fetches from `origin` by default and merges into the
-current branch.
-<6> immediately after pulling, look at the changes done upstream
-since last time we checked, only in the
-area we are interested in.
-<7> check the branch names in an external repository (if not known).
-<8> fetch from a specific branch 'ALL' from a specific repository
-and merge it.
-<9> revert the pull.
-<10> garbage collect leftover objects from reverted pull.
-<11> from time to time, obtain official tags from the `origin`
-and store them under `.git/refs/tags/`.
-
-
-Push into another repository.::
-+
-------------
-satellite$ git clone mothership:frotz frotz <1>
-satellite$ cd frotz
-satellite$ git config --get-regexp '^(remote|branch)\.' <2>
-remote.origin.url mothership:frotz
-remote.origin.fetch refs/heads/*:refs/remotes/origin/*
-branch.master.remote origin
-branch.master.merge refs/heads/master
-satellite$ git config remote.origin.push \
-           +refs/heads/*:refs/remotes/satellite/* <3>
-satellite$ edit/compile/test/commit
-satellite$ git push origin <4>
-
-mothership$ cd frotz
-mothership$ git checkout master
-mothership$ git merge satellite/master <5>
-------------
-+
-<1> mothership machine has a frotz repository under your home
-directory; clone from it to start a repository on the satellite
-machine.
-<2> clone sets these configuration variables by default.
-It arranges `git pull` to fetch and store the branches of mothership
-machine to local `remotes/origin/*` remote-tracking branches.
-<3> arrange `git push` to push all local branches to
-their corresponding branch of the mothership machine.
-<4> push will stash all our work away on `remotes/satellite/*`
-remote-tracking branches on the mothership machine.  You could use this
-as a back-up method.
-<5> on mothership machine, merge the work done on the satellite
-machine into the master branch.
-
-Branch off of a specific tag.::
-+
-------------
-$ git checkout -b private2.6.14 v2.6.14 <1>
-$ edit/compile/test; git commit -a
-$ git checkout master
-$ git cherry-pick v2.6.14..private2.6.14 <2>
-------------
-+
-<1> create a private branch based on a well known (but somewhat behind)
-tag.
-<2> forward port all changes in `private2.6.14` branch to `master` branch
-without a formal "merging". Or longhand +
-`git format-patch -k -m --stdout v2.6.14..private2.6.14 |
-  git am -3 -k`
-
-
-Integrator[[INTEGRATOR]]
-------------------------
-
-A fairly central person acting as the integrator in a group
-project receives changes made by others, reviews and integrates
-them and publishes the result for others to use, using these
-commands in addition to the ones needed by participants.
-
-This section can also be applied to a git-request-pull workflow,
-or the GitHub (www.github.com) pull-request flow.
-
-  * linkgit:git-am[1] to apply patches e-mailed in from your
-    contributors.
-
-  * linkgit:git-pull[1] to merge from your trusted lieutenants.
-
-  * linkgit:git-format-patch[1] to prepare and send suggested
-    alternative to contributors.
-
-  * linkgit:git-revert[1] to undo botched commits.
-
-  * linkgit:git-push[1] to publish the bleeding edge.
-
-  * linkgit:git-request-pull[1] to create a summary of changes
-    for your upstream to pull.
-
-
-Examples
-~~~~~~~~
-
-A typical integrator's Git day.::
-+
-------------
-$ git status <1>
-$ git branch --no-merged master <2>
-$ mailx <3>
-& s 2 3 4 5 ./+to-apply
-& s 7 8 ./+hold-linus
-& q
-$ git checkout -b topic/one master
-$ git am -3 -i -s ./+to-apply <4>
-$ compile/test
-$ git checkout -b hold/linus && git am -3 -i -s ./+hold-linus <5>
-$ git checkout topic/one && git rebase master <6>
-$ git checkout pu && git reset --hard next <7>
-$ git merge topic/one topic/two && git merge hold/linus <8>
-$ git checkout maint
-$ git cherry-pick master~4 <9>
-$ compile/test
-$ git tag -s -m "GIT 0.99.9x" v0.99.9x <10>
-$ git fetch ko && for branch in master maint next pu <11>
-    do
-        git show-branch ko/$branch $branch <12>
-    done
-$ git push --follow-tags ko <13>
-------------
-+
-<1> see what you were in the middle of doing, if anything.
-<2> see which branches haven't been merged into 'master' yet.
-Likewise for any other integration branches e.g. 'maint', 'next'
-and 'pu' (potential updates).
-<3> read mails, save ones that are applicable, and save others
-that are not quite ready (other mail readers are available).
-<4> apply them, interactively, with your sign-offs.
-<5> create topic branch as needed and apply, again with sign-offs.
-<6> rebase internal topic branch that has not been merged to the
-master or exposed as a part of a stable branch.
-<7> restart `pu` every time from the next.
-<8> and bundle topic branches still cooking.
-<9> backport a critical fix.
-<10> create a signed tag.
-<11> make sure master was not accidentally rewound beyond that
-already pushed out.  `ko` shorthand points at the Git maintainer's
-repository at kernel.org, and looks like this:
-+
-------------
-(in .git/config)
-[remote "ko"]
-        url = kernel.org:/pub/scm/git/git.git
-        fetch = refs/heads/*:refs/remotes/ko/*
-        push = refs/heads/master
-        push = refs/heads/next
-        push = +refs/heads/pu
-        push = refs/heads/maint
-------------
-+
-<12> In the output from `git show-branch`, `master` should have
-everything `ko/master` has, and `next` should have
-everything `ko/next` has, etc.
-<13> push out the bleeding edge, together with new tags that point
-into the pushed history.
-
-
-Repository Administration[[ADMINISTRATION]]
--------------------------------------------
-
-A repository administrator uses the following tools to set up
-and maintain access to the repository by developers.
-
-  * linkgit:git-daemon[1] to allow anonymous download from
-    repository.
-
-  * linkgit:git-shell[1] can be used as a 'restricted login shell'
-    for shared central repository users.
-
-  * linkgit:git-http-backend[1] provides a server side implementation
-    of Git-over-HTTP ("Smart http") allowing both fetch and push services.
-
-  * linkgit:gitweb[1] provides a web front-end to Git repositories,
-    which can be set-up using the linkgit:git-instaweb[1] script.
-
-link:howto/update-hook-example.html[update hook howto] has a good
-example of managing a shared central repository.
-
-In addition there are a number of other widely deployed hosting, browsing
-and reviewing solutions such as:
-
-  * gitolite, gerrit code review, cgit and others.
-
-Examples
-~~~~~~~~
-We assume the following in /etc/services::
-+
-------------
-$ grep 9418 /etc/services
-git		9418/tcp		# Git Version Control System
-------------
-
-Run git-daemon to serve /pub/scm from inetd.::
-+
-------------
-$ grep git /etc/inetd.conf
-git	stream	tcp	nowait	nobody \
-  /usr/bin/git-daemon git-daemon --inetd --export-all /pub/scm
-------------
-+
-The actual configuration line should be on one line.
-
-Run git-daemon to serve /pub/scm from xinetd.::
-+
-------------
-$ cat /etc/xinetd.d/git-daemon
-# default: off
-# description: The Git server offers access to Git repositories
-service git
-{
-        disable = no
-        type            = UNLISTED
-        port            = 9418
-        socket_type     = stream
-        wait            = no
-        user            = nobody
-        server          = /usr/bin/git-daemon
-        server_args     = --inetd --export-all --base-path=/pub/scm
-        log_on_failure  += USERID
-}
-------------
-+
-Check your xinetd(8) documentation and setup, this is from a Fedora system.
-Others might be different.
-
-Give push/pull only access to developers using git-over-ssh.::
-
-e.g. those using:
-`$ git push/pull ssh://host.xz/pub/scm/project`
-+
-------------
-$ grep git /etc/passwd <1>
-alice:x:1000:1000::/home/alice:/usr/bin/git-shell
-bob:x:1001:1001::/home/bob:/usr/bin/git-shell
-cindy:x:1002:1002::/home/cindy:/usr/bin/git-shell
-david:x:1003:1003::/home/david:/usr/bin/git-shell
-$ grep git /etc/shells <2>
-/usr/bin/git-shell
-------------
-+
-<1> log-in shell is set to /usr/bin/git-shell, which does not
-allow anything but `git push` and `git pull`.  The users require
-ssh access to the machine.
-<2> in many distributions /etc/shells needs to list what is used
-as the login shell.
-
-CVS-style shared repository.::
-+
-------------
-$ grep git /etc/group <1>
-git:x:9418:alice,bob,cindy,david
-$ cd /home/devo.git
-$ ls -l <2>
-  lrwxrwxrwx   1 david git    17 Dec  4 22:40 HEAD -> refs/heads/master
-  drwxrwsr-x   2 david git  4096 Dec  4 22:40 branches
-  -rw-rw-r--   1 david git    84 Dec  4 22:40 config
-  -rw-rw-r--   1 david git    58 Dec  4 22:40 description
-  drwxrwsr-x   2 david git  4096 Dec  4 22:40 hooks
-  -rw-rw-r--   1 david git 37504 Dec  4 22:40 index
-  drwxrwsr-x   2 david git  4096 Dec  4 22:40 info
-  drwxrwsr-x   4 david git  4096 Dec  4 22:40 objects
-  drwxrwsr-x   4 david git  4096 Nov  7 14:58 refs
-  drwxrwsr-x   2 david git  4096 Dec  4 22:40 remotes
-$ ls -l hooks/update <3>
-  -r-xr-xr-x   1 david git  3536 Dec  4 22:40 update
-$ cat info/allowed-users <4>
-refs/heads/master	alice\|cindy
-refs/heads/doc-update	bob
-refs/tags/v[0-9]*	david
-------------
-+
-<1> place the developers into the same git group.
-<2> and make the shared repository writable by the group.
-<3> use update-hook example by Carl from Documentation/howto/
-for branch policy control.
-<4> alice and cindy can push into master, only bob can push into doc-update.
-david is the release manager and is the only person who can
-create and push version tags.
-
-GIT
----
-Part of the linkgit:git[1] suite
diff --git a/Documentation/everyday.txto b/Documentation/everyday.txto
new file mode 100644
index 0000000..c5047d8
--- /dev/null
+++ b/Documentation/everyday.txto
@@ -0,0 +1,9 @@
+Everyday Git With 20 Commands Or So
+===================================
+
+This document has been moved to linkgit:giteveryday[1].
+
+Please let the owners of the referring site know so that they can update the
+link you clicked to get here.
+
+Thanks.
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index b17283a..21b3f29 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -34,7 +34,7 @@ When the command line does not specify what to push with `<refspec>...`
 arguments or `--all`, `--mirror`, `--tags` options, the command finds
 the default `<refspec>` by consulting `remote.*.push` configuration,
 and if it is not found, honors `push.default` configuration to decide
-what to push (See linkgit:git-config[1] for the meaning of `push.default`).
+what to push (See gitlink:git-config[1] for the meaning of `push.default`).
 
 
 OPTIONS[[OPTIONS]]
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 8b2c542..6b69cad 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -22,7 +22,7 @@ unusually rich command set that provides both high-level operations
 and full access to internals.
 
 See linkgit:gittutorial[7] to get started, then see
-link:everyday.html[Everyday Git] for a useful minimum set of
+linkgit:giteveryday[7] for a useful minimum set of
 commands.  The link:user-manual.html[Git User's Manual] has a more
 in-depth introduction.
 
@@ -1097,7 +1097,7 @@ subscribed to the list to send a message there.
 SEE ALSO
 --------
 linkgit:gittutorial[7], linkgit:gittutorial-2[7],
-link:everyday.html[Everyday Git], linkgit:gitcvs-migration[7],
+linkgit:giteveryday[7], linkgit:gitcvs-migration[7],
 linkgit:gitglossary[7], linkgit:gitcore-tutorial[7],
 linkgit:gitcli[7], link:user-manual.html[The Git User's Manual],
 linkgit:gitworkflows[7]
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index d2d7c21..8475c07 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -1667,7 +1667,7 @@ linkgit:gittutorial[7],
 linkgit:gittutorial-2[7],
 linkgit:gitcvs-migration[7],
 linkgit:git-help[1],
-link:everyday.html[Everyday git],
+linkgit:giteveryday[7],
 link:user-manual.html[The Git User's Manual]
 
 GIT
diff --git a/Documentation/gitcvs-migration.txt b/Documentation/gitcvs-migration.txt
index 5f4e890..b06e852 100644
--- a/Documentation/gitcvs-migration.txt
+++ b/Documentation/gitcvs-migration.txt
@@ -194,7 +194,7 @@ linkgit:gittutorial[7],
 linkgit:gittutorial-2[7],
 linkgit:gitcore-tutorial[7],
 linkgit:gitglossary[7],
-link:everyday.html[Everyday Git],
+linkgit:giteveryday[7],
 link:user-manual.html[The Git User's Manual]
 
 GIT
diff --git a/Documentation/giteveryday.txt b/Documentation/giteveryday.txt
new file mode 100644
index 0000000..cd7f87c
--- /dev/null
+++ b/Documentation/giteveryday.txt
@@ -0,0 +1,447 @@
+giteveryday(7)
+===============
+
+NAME
+----
+giteveryday - A useful minimum set of commands for Everyday Git
+
+SYNOPSIS
+--------
+
+Everyday Git With 20 Commands Or So
+
+DESCRIPTION
+-----------
+
+Git users can broadly be grouped into four categories for the purposes of
+describing here a small set of useful command for everyday Git.
+
+*	<<STANDALONE,Individual Developer (Standalone)>> commands are essential
+	for anybody who makes a commit, even for somebody who works alone.
+
+*	If you work with other people, you will need commands listed in
+	the <<PARTICIPANT,Individual Developer (Participant)>> section as well.
+
+*	People who play the <<INTEGRATOR,Integrator>> role need to learn some
+	more commands in addition to the above.
+
+*	<<ADMINISTRATION,Repository Administration>> commands are for system
+	administrators who are responsible for the care and feeding
+	of Git repositories.
+
+
+Individual Developer (Standalone)[[STANDALONE]]
+-----------------------------------------------
+
+A standalone individual developer does not exchange patches with
+other people, and works alone in a single repository, using the
+following commands.
+
+  * linkgit:git-init[1] to create a new repository.
+
+  * linkgit:git-log[1] to see what happened.
+
+  * linkgit:git-checkout[1] and linkgit:git-branch[1] to switch
+    branches.
+
+  * linkgit:git-add[1] to manage the index file.
+
+  * linkgit:git-diff[1] and linkgit:git-status[1] to see what
+    you are in the middle of doing.
+
+  * linkgit:git-commit[1] to advance the current branch.
+
+  * linkgit:git-reset[1] and linkgit:git-checkout[1] (with
+    pathname parameters) to undo changes.
+
+  * linkgit:git-merge[1] to merge between local branches.
+
+  * linkgit:git-rebase[1] to maintain topic branches.
+
+  * linkgit:git-tag[1] to mark a known point.
+
+Examples
+~~~~~~~~
+
+Use a tarball as a starting point for a new repository.::
++
+------------
+$ tar zxf frotz.tar.gz
+$ cd frotz
+$ git init
+$ git add . <1>
+$ git commit -m "import of frotz source tree."
+$ git tag v2.43 <2>
+------------
++
+<1> add everything under the current directory.
+<2> make a lightweight, unannotated tag.
+
+Create a topic branch and develop.::
++
+------------
+$ git checkout -b alsa-audio <1>
+$ edit/compile/test
+$ git checkout -- curses/ux_audio_oss.c <2>
+$ git add curses/ux_audio_alsa.c <3>
+$ edit/compile/test
+$ git diff HEAD <4>
+$ git commit -a -s <5>
+$ edit/compile/test
+$ git diff HEAD^ <6>
+$ git commit -a --amend <7>
+$ git checkout master <8>
+$ git merge alsa-audio <9>
+$ git log --since='3 days ago' <10>
+$ git log v2.43.. curses/ <11>
+------------
++
+<1> create a new topic branch.
+<2> revert your botched changes in `curses/ux_audio_oss.c`.
+<3> you need to tell Git if you added a new file; removal and
+modification will be caught if you do `git commit -a` later.
+<4> to see what changes you are committing.
+<5> commit everything, as you have tested, with your sign-off.
+<6> look at all your changes including the previous commit.
+<7> amend the previous commit, adding all your new changes,
+using your original message.
+<8> switch to the master branch.
+<9> merge a topic branch into your master branch.
+<10> review commit logs; other forms to limit output can be
+combined and include `--max-count=10` (show 10 commits),
+`--until=2005-12-10`, etc.
+<11> view only the changes that touch what's in `curses/`
+directory, since `v2.43` tag.
+
+
+Individual Developer (Participant)[[PARTICIPANT]]
+-------------------------------------------------
+
+A developer working as a participant in a group project needs to
+learn how to communicate with others, and uses these commands in
+addition to the ones needed by a standalone developer.
+
+  * linkgit:git-clone[1] from the upstream to prime your local
+    repository.
+
+  * linkgit:git-pull[1] and linkgit:git-fetch[1] from "origin"
+    to keep up-to-date with the upstream.
+
+  * linkgit:git-push[1] to shared repository, if you adopt CVS
+    style shared repository workflow.
+
+  * linkgit:git-format-patch[1] to prepare e-mail submission, if
+    you adopt Linux kernel-style public forum workflow.
+
+  * linkgit:git-send-email[1] to send your e-mail submission without
+    corruption by your MUA.
+
+
+Examples
+~~~~~~~~
+
+Clone the upstream and work on it.  Feed changes to upstream.::
++
+------------
+$ git clone git://git.kernel.org/pub/scm/.../torvalds/linux-2.6 my2.6
+$ cd my2.6
+$ git checkout -b mine master <1>
+$ edit/compile/test; git commit -a -s <2>
+$ git format-patch master <3>
+$ git send-email --to="person <email@example.com>" 00*.patch <4>
+$ git pull <5>
+$ git log -p ORIG_HEAD.. arch/i386 include/asm-i386 <6>
+$ git ls-remote --heads http://git.kernel.org/.../jgarzik/libata-dev.git <7>
+$ git pull git://git.kernel.org/pub/.../jgarzik/libata-dev.git ALL <8>
+$ git reset --hard ORIG_HEAD <9>
+$ git gc <10>
+$ git fetch --tags <11>
+------------
++
+<1> checkout a new branch 'mine' from master.
+<2> repeat as needed.
+<3> extract patches from your branch, relative to master,
+<4> and email them.
+<5> `git pull` fetches from `origin` by default and merges into the
+current branch.
+<6> immediately after pulling, look at the changes done upstream
+since last time we checked, only in the
+area we are interested in.
+<7> check the branch names in an external repository (if not known).
+<8> fetch from a specific branch 'ALL' from a specific repository
+and merge it.
+<9> revert the pull.
+<10> garbage collect leftover objects from reverted pull.
+<11> from time to time, obtain official tags from the `origin`
+and store them under `.git/refs/tags/`.
+
+
+Push into another repository.::
++
+------------
+satellite$ git clone mothership:frotz frotz <1>
+satellite$ cd frotz
+satellite$ git config --get-regexp '^(remote|branch)\.' <2>
+remote.origin.url mothership:frotz
+remote.origin.fetch refs/heads/*:refs/remotes/origin/*
+branch.master.remote origin
+branch.master.merge refs/heads/master
+satellite$ git config remote.origin.push \
+           +refs/heads/*:refs/remotes/satellite/* <3>
+satellite$ edit/compile/test/commit
+satellite$ git push origin <4>
+
+mothership$ cd frotz
+mothership$ git checkout master
+mothership$ git merge satellite/master <5>
+------------
++
+<1> mothership machine has a frotz repository under your home
+directory; clone from it to start a repository on the satellite
+machine.
+<2> clone sets these configuration variables by default.
+It arranges `git pull` to fetch and store the branches of mothership
+machine to local `remotes/origin/*` remote-tracking branches.
+<3> arrange `git push` to push all local branches to
+their corresponding branch of the mothership machine.
+<4> push will stash all our work away on `remotes/satellite/*`
+remote-tracking branches on the mothership machine.  You could use this
+as a back-up method.
+<5> on mothership machine, merge the work done on the satellite
+machine into the master branch.
+
+Branch off of a specific tag.::
++
+------------
+$ git checkout -b private2.6.14 v2.6.14 <1>
+$ edit/compile/test; git commit -a
+$ git checkout master
+$ git cherry-pick v2.6.14..private2.6.14 <2>
+------------
++
+<1> create a private branch based on a well known (but somewhat behind)
+tag.
+<2> forward port all changes in `private2.6.14` branch to `master` branch
+without a formal "merging". Or longhand +
+`git format-patch -k -m --stdout v2.6.14..private2.6.14 |
+  git am -3 -k`
+
+
+Integrator[[INTEGRATOR]]
+------------------------
+
+A fairly central person acting as the integrator in a group
+project receives changes made by others, reviews and integrates
+them and publishes the result for others to use, using these
+commands in addition to the ones needed by participants.
+
+This section can also be applied to a git-request-pull workflow,
+or the GitHub (www.github.com) pull-request flow.
+
+  * linkgit:git-am[1] to apply patches e-mailed in from your
+    contributors.
+
+  * linkgit:git-pull[1] to merge from your trusted lieutenants.
+
+  * linkgit:git-format-patch[1] to prepare and send suggested
+    alternative to contributors.
+
+  * linkgit:git-revert[1] to undo botched commits.
+
+  * linkgit:git-push[1] to publish the bleeding edge.
+
+  * linkgit:git-request-pull[1] to create a summary of changes
+    for your upstream to pull.
+
+
+Examples
+~~~~~~~~
+
+A typical integrator's Git day.::
++
+------------
+$ git status <1>
+$ git branch --no-merged master <2>
+$ mailx <3>
+& s 2 3 4 5 ./+to-apply
+& s 7 8 ./+hold-linus
+& q
+$ git checkout -b topic/one master
+$ git am -3 -i -s ./+to-apply <4>
+$ compile/test
+$ git checkout -b hold/linus && git am -3 -i -s ./+hold-linus <5>
+$ git checkout topic/one && git rebase master <6>
+$ git checkout pu && git reset --hard next <7>
+$ git merge topic/one topic/two && git merge hold/linus <8>
+$ git checkout maint
+$ git cherry-pick master~4 <9>
+$ compile/test
+$ git tag -s -m "GIT 0.99.9x" v0.99.9x <10>
+$ git fetch ko && for branch in master maint next pu <11>
+    do
+        git show-branch ko/$branch $branch <12>
+    done
+$ git push --follow-tags ko <13>
+------------
++
+<1> see what you were in the middle of doing, if anything.
+<2> see which branches haven't been merged into 'master' yet.
+Likewise for any other integration branches e.g. 'maint', 'next'
+and 'pu' (potential updates).
+<3> read mails, save ones that are applicable, and save others
+that are not quite ready (other mail readers are available).
+<4> apply them, interactively, with your sign-offs.
+<5> create topic branch as needed and apply, again with sign-offs.
+<6> rebase internal topic branch that has not been merged to the
+master or exposed as a part of a stable branch.
+<7> restart `pu` every time from the next.
+<8> and bundle topic branches still cooking.
+<9> backport a critical fix.
+<10> create a signed tag.
+<11> make sure master was not accidentally rewound beyond that
+already pushed out.  `ko` shorthand points at the Git maintainer's
+repository at kernel.org, and looks like this:
++
+------------
+(in .git/config)
+[remote "ko"]
+        url = kernel.org:/pub/scm/git/git.git
+        fetch = refs/heads/*:refs/remotes/ko/*
+        push = refs/heads/master
+        push = refs/heads/next
+        push = +refs/heads/pu
+        push = refs/heads/maint
+------------
++
+<12> In the output from `git show-branch`, `master` should have
+everything `ko/master` has, and `next` should have
+everything `ko/next` has, etc.
+<13> push out the bleeding edge, together with new tags that point
+into the pushed history.
+
+
+Repository Administration[[ADMINISTRATION]]
+-------------------------------------------
+
+A repository administrator uses the following tools to set up
+and maintain access to the repository by developers.
+
+  * linkgit:git-daemon[1] to allow anonymous download from
+    repository.
+
+  * linkgit:git-shell[1] can be used as a 'restricted login shell'
+    for shared central repository users.
+
+  * linkgit:git-http-backend[1] provides a server side implementation
+    of Git-over-HTTP ("Smart http") allowing both fetch and push services.
+
+  * linkgit:gitweb[1] provides a web front-end to Git repositories,
+    which can be set-up using the linkgit:git-instaweb[1] script.
+
+link:howto/update-hook-example.html[update hook howto] has a good
+example of managing a shared central repository.
+
+In addition there are a number of other widely deployed hosting, browsing
+and reviewing solutions such as:
+
+  * gitolite, gerrit code review, cgit and others.
+
+Examples
+~~~~~~~~
+We assume the following in /etc/services::
++
+------------
+$ grep 9418 /etc/services
+git		9418/tcp		# Git Version Control System
+------------
+
+Run git-daemon to serve /pub/scm from inetd.::
++
+------------
+$ grep git /etc/inetd.conf
+git	stream	tcp	nowait	nobody \
+  /usr/bin/git-daemon git-daemon --inetd --export-all /pub/scm
+------------
++
+The actual configuration line should be on one line.
+
+Run git-daemon to serve /pub/scm from xinetd.::
++
+------------
+$ cat /etc/xinetd.d/git-daemon
+# default: off
+# description: The Git server offers access to Git repositories
+service git
+{
+        disable = no
+        type            = UNLISTED
+        port            = 9418
+        socket_type     = stream
+        wait            = no
+        user            = nobody
+        server          = /usr/bin/git-daemon
+        server_args     = --inetd --export-all --base-path=/pub/scm
+        log_on_failure  += USERID
+}
+------------
++
+Check your xinetd(8) documentation and setup, this is from a Fedora system.
+Others might be different.
+
+Give push/pull only access to developers using git-over-ssh.::
+
+e.g. those using:
+`$ git push/pull ssh://host.xz/pub/scm/project`
++
+------------
+$ grep git /etc/passwd <1>
+alice:x:1000:1000::/home/alice:/usr/bin/git-shell
+bob:x:1001:1001::/home/bob:/usr/bin/git-shell
+cindy:x:1002:1002::/home/cindy:/usr/bin/git-shell
+david:x:1003:1003::/home/david:/usr/bin/git-shell
+$ grep git /etc/shells <2>
+/usr/bin/git-shell
+------------
++
+<1> log-in shell is set to /usr/bin/git-shell, which does not
+allow anything but `git push` and `git pull`.  The users require
+ssh access to the machine.
+<2> in many distributions /etc/shells needs to list what is used
+as the login shell.
+
+CVS-style shared repository.::
++
+------------
+$ grep git /etc/group <1>
+git:x:9418:alice,bob,cindy,david
+$ cd /home/devo.git
+$ ls -l <2>
+  lrwxrwxrwx   1 david git    17 Dec  4 22:40 HEAD -> refs/heads/master
+  drwxrwsr-x   2 david git  4096 Dec  4 22:40 branches
+  -rw-rw-r--   1 david git    84 Dec  4 22:40 config
+  -rw-rw-r--   1 david git    58 Dec  4 22:40 description
+  drwxrwsr-x   2 david git  4096 Dec  4 22:40 hooks
+  -rw-rw-r--   1 david git 37504 Dec  4 22:40 index
+  drwxrwsr-x   2 david git  4096 Dec  4 22:40 info
+  drwxrwsr-x   4 david git  4096 Dec  4 22:40 objects
+  drwxrwsr-x   4 david git  4096 Nov  7 14:58 refs
+  drwxrwsr-x   2 david git  4096 Dec  4 22:40 remotes
+$ ls -l hooks/update <3>
+  -r-xr-xr-x   1 david git  3536 Dec  4 22:40 update
+$ cat info/allowed-users <4>
+refs/heads/master	alice\|cindy
+refs/heads/doc-update	bob
+refs/tags/v[0-9]*	david
+------------
++
+<1> place the developers into the same git group.
+<2> and make the shared repository writable by the group.
+<3> use update-hook example by Carl from Documentation/howto/
+for branch policy control.
+<4> alice and cindy can push into master, only bob can push into doc-update.
+david is the release manager and is the only person who can
+create and push version tags.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/gitglossary.txt b/Documentation/gitglossary.txt
index e52de7d..212e254 100644
--- a/Documentation/gitglossary.txt
+++ b/Documentation/gitglossary.txt
@@ -19,7 +19,7 @@ SEE ALSO
 linkgit:gittutorial[7],
 linkgit:gittutorial-2[7],
 linkgit:gitcvs-migration[7],
-link:everyday.html[Everyday Git],
+linkgit:giteveryday[7],
 link:user-manual.html[The Git User's Manual]
 
 GIT
diff --git a/Documentation/gittutorial-2.txt b/Documentation/gittutorial-2.txt
index 3109ea8..f6fbf81 100644
--- a/Documentation/gittutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -403,7 +403,7 @@ What next?
 
 At this point you should know everything necessary to read the man
 pages for any of the git commands; one good place to start would be
-with the commands mentioned in link:everyday.html[Everyday Git].  You
+with the commands mentioned in linkgit:giteveryday[7].  You
 should be able to find any unknown jargon in linkgit:gitglossary[7].
 
 The link:user-manual.html[Git User's Manual] provides a more
@@ -427,7 +427,7 @@ linkgit:gitcvs-migration[7],
 linkgit:gitcore-tutorial[7],
 linkgit:gitglossary[7],
 linkgit:git-help[1],
-link:everyday.html[Everyday Git],
+linkgit:giteveryday[7],
 link:user-manual.html[The Git User's Manual]
 
 GIT
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 8262196..af9f709 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -656,7 +656,7 @@ digressions that may be interesting at this point are:
   * linkgit:gitworkflows[7]: Gives an overview of recommended
     workflows.
 
-  * link:everyday.html[Everyday Git with 20 Commands Or So]
+  * linkgit:giteveryday[7]: Everyday Git with 20 Commands Or So.
 
   * linkgit:gitcvs-migration[7]: Git for CVS users.
 
@@ -668,7 +668,7 @@ linkgit:gitcore-tutorial[7],
 linkgit:gitglossary[7],
 linkgit:git-help[1],
 linkgit:gitworkflows[7],
-link:everyday.html[Everyday Git],
+linkgit:giteveryday[7],
 link:user-manual.html[The Git User's Manual]
 
 GIT
diff --git a/README b/README
index 15a8e23..1083735 100644
--- a/README
+++ b/README
@@ -27,7 +27,7 @@ Torvalds with help of a group of hackers around the net.
 Please read the file INSTALL for installation instructions.
 
 See Documentation/gittutorial.txt to get started, then see
-Documentation/everyday.txt for a useful minimum set of commands, and
+Documentation/giteveryday.txt for a useful minimum set of commands, and
 Documentation/git-commandname.txt for documentation of each command.
 If git has been correctly installed, then the tutorial can also be
 read with "man gittutorial" or "git help tutorial", and the
diff --git a/builtin/help.c b/builtin/help.c
index 8343b40..b3c818e 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -421,6 +421,7 @@ static struct {
 	const char *help;
 } common_guides[] = {
 	{ "attributes", N_("Defining attributes per path") },
+	{ "everyday", N_("Everyday Git With 20 Commands Or So") },
 	{ "glossary", N_("A Git glossary") },
 	{ "ignore", N_("Specifies intentionally untracked files to ignore") },
 	{ "modules", N_("Defining submodule properties") },
-- 
1.9.4.msysgit.0
