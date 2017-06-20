Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CA9720282
	for <e@80x24.org>; Tue, 20 Jun 2017 22:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752356AbdFTW44 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 18:56:56 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34034 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbdFTW4z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 18:56:55 -0400
Received: by mail-pg0-f49.google.com with SMTP id e187so16526079pgc.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 15:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UOx2jL8G3DlABkeVplHuja3UZVWUrhbxymW+pGT5fjo=;
        b=ZEEgS+tnHk59Myn2/6Ljy/QgKpmQXOnFWK59nPeYTHbMhidRFKvMEDfARHqZ/9JVI1
         i6DBwyOV2fAzQfrvlQOKPrmcP50UhG6YuMgaEefRQj3jw2p/fRasIfdcyqUW8h+8K0yt
         /VJpJcMnXf4vQXaOwexZ7IfdLNegH7MyOwAPvxlKGcoiD/suVtab9vYrnlvYy8q90MJW
         OMRWtczDMdiSR+6S2l/k8Zi6VJjN1EAOvrMam+d7FEvBHyOO3yCzqQnoEALu5Wuoii8V
         +TM4o3QKGsbOGawGi6ySaSm6sgH9JYOVYtW/82qm6R+qI7+cj3MGy/uEc8ceHjYMdls2
         6O7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UOx2jL8G3DlABkeVplHuja3UZVWUrhbxymW+pGT5fjo=;
        b=epYD/mqiAkLOHaXTFFShR6m3gEb8c5s5VDCf2qqUPq6US99u3K8Fn3oOVnXaLj9dY0
         hukM+FnRKudr2pXVViA9vMDMPIhVf4dmYxHrZwYQ6JPXd9GaVfwJY8+ERzAPeZFjHSBC
         aYdyP0usQQTp/YzRpeoV0Nas80+/y746DATviit4ZmAYRwi7yuAVOYJaasfuwIRbpRUJ
         5PIuXqMt7T3CizqSeyCty96yvTo1sboUeRVsh/bWZTp+7HVIrxXldrqaq06LUfonXIT7
         N0pSsicBfxEhSts7BR/n9/Tjz1eEXIH4kByzhaEuz6xMw/L4TOaO8g5g4Kw51/4kFikY
         fnVQ==
X-Gm-Message-State: AKS2vOx7IP0IgvDDz9wK8l+Ul6zKy3/8TJ99tp2zzkeX/SZQUwPXqQUj
        XCX/0aF3SUS7F6Cp
X-Received: by 10.98.76.140 with SMTP id e12mr32642725pfj.78.1497999413954;
        Tue, 20 Jun 2017 15:56:53 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c80:865c:a15:8a68])
        by smtp.gmail.com with ESMTPSA id r63sm28892906pgr.65.2017.06.20.15.56.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 15:56:53 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: [PATCHv2] submodules: overhaul documentation
Date:   Tue, 20 Jun 2017 15:56:50 -0700
Message-Id: <20170620225650.7573-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170607185354.10050-1-sbeller@google.com>
References: <20170607185354.10050-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch aims to detangle (a) the usage of `git-submodule`
from (b) the concept of submodules and (c) how the actual
implementation looks like, such as where they are configured
and (d) what the best practices are.

To do so, move the conceptual parts of the 'git-submodule'
man page to a new man page gitsubmodules(7). This new page
is just like gitmodules(5), gitattributes(5), gitcredentials(7),
gitnamespaces(7), gittutorial(7), which introduce a concept
rather than explaining a specific command.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

I have considered most of the feedback, and stopped marking it RFC,
but I'd like to propose this as a serious patch.

Thanks,
Stefan

 Documentation/Makefile          |   1 +
 Documentation/git-rm.txt        |   4 +-
 Documentation/git-submodule.txt |  44 +++-------
 Documentation/gitsubmodules.txt | 189 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 202 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/gitsubmodules.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b5be2e2d3f..2415e0d657 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -31,6 +31,7 @@ MAN7_TXT += giteveryday.txt
 MAN7_TXT += gitglossary.txt
 MAN7_TXT += gitnamespaces.txt
 MAN7_TXT += gitrevisions.txt
+MAN7_TXT += gitsubmodules.txt
 MAN7_TXT += gittutorial-2.txt
 MAN7_TXT += gittutorial.txt
 MAN7_TXT += gitworkflows.txt
diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index f1efc116eb..db444693dd 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -152,8 +152,8 @@ Ignored files are deemed expendable and won't stop a submodule's work
 tree from being removed.
 
 If you only want to remove the local checkout of a submodule from your
-work tree without committing the removal,
-use linkgit:git-submodule[1] `deinit` instead.
+work tree without committing the removal, use linkgit:git-submodule[1] `deinit`
+instead. Also see linkgit:gitsubmodules[7] for details on submodule removal.
 
 EXAMPLES
 --------
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 74bc6200d5..9ffd129bbc 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -24,37 +24,7 @@ DESCRIPTION
 -----------
 Inspects, updates and manages submodules.
 
-A submodule allows you to keep another Git repository in a subdirectory
-of your repository. The other repository has its own history, which does not
-interfere with the history of the current repository. This can be used to
-have external dependencies such as third party libraries for example.
-
-When cloning or pulling a repository containing submodules however,
-these will not be checked out by default; the 'init' and 'update'
-subcommands will maintain submodules checked out and at
-appropriate revision in your working tree.
-
-Submodules are composed from a so-called `gitlink` tree entry
-in the main repository that refers to a particular commit object
-within the inner repository that is completely separate.
-A record in the `.gitmodules` (see linkgit:gitmodules[5]) file at the
-root of the source tree assigns a logical name to the submodule and
-describes the default URL the submodule shall be cloned from.
-The logical name can be used for overriding this URL within your
-local repository configuration (see 'submodule init').
-
-Submodules are not to be confused with remotes, which are other
-repositories of the same project; submodules are meant for
-different projects you would like to make part of your source tree,
-while the history of the two projects still stays completely
-independent and you cannot modify the contents of the submodule
-from within the main project.
-If you want to merge the project histories and want to treat the
-aggregated whole as a single project from then on, you may want to
-add a remote for the other project and use the 'subtree' merge strategy,
-instead of treating the other project as a submodule. Directories
-that come from both projects can be cloned and checked out as a whole
-if you choose to go that route.
+For more information about submodules, see linkgit:gitsubmodules[7].
 
 COMMANDS
 --------
@@ -149,15 +119,17 @@ deinit [-f|--force] (--all|[--] <path>...)::
 	tree. Further calls to `git submodule update`, `git submodule foreach`
 	and `git submodule sync` will skip any unregistered submodules until
 	they are initialized again, so use this command if you don't want to
-	have a local checkout of the submodule in your working tree anymore. If
-	you really want to remove a submodule from the repository and commit
-	that use linkgit:git-rm[1] instead.
+	have a local checkout of the submodule in your working tree anymore.
 +
 When the command is run without pathspec, it errors out,
 instead of deinit-ing everything, to prevent mistakes.
 +
 If `--force` is specified, the submodule's working tree will
 be removed even if it contains local modifications.
++
+If you really want to remove a submodule from the repository and commit
+that use linkgit:git-rm[1] instead. See linkgit:gitsubmodules[7] for removal
+options.
 
 update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--] [<path>...]::
 +
@@ -435,6 +407,10 @@ This file should be formatted in the same way as `$GIT_DIR/config`. The key
 to each submodule url is "submodule.$name.url".  See linkgit:gitmodules[5]
 for details.
 
+SEE ALSO
+--------
+linkgit:gitsubmodules[7], linkgit:gitmodules[5].
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
new file mode 100644
index 0000000000..80e71ff55c
--- /dev/null
+++ b/Documentation/gitsubmodules.txt
@@ -0,0 +1,189 @@
+gitsubmodules(7)
+================
+
+NAME
+----
+gitsubmodules - mounting one repository inside another
+
+SYNOPSIS
+--------
+.gitmodules, $GIT_DIR/config
+------------------
+git submodule
+git <command> --recurse-submodules
+------------------
+
+DESCRIPTION
+-----------
+
+A submodule is another Git repository tracked inside a repository.
+The tracked repository has its own history, which does not
+interfere with the history of the current repository.
+
+It consists of a tracking subdirectory in the working directory,
+a 'gitlink' in the working tree and an entry in the `.gitmodules`
+file (see linkgit:gitmodules[5]) at the root of the source tree.
+
+The tracking subdirectory appears in the main repositorys working
+tree at the point where the submodules gitlink is tracked in the
+tree.  It is empty when the submodule is not populated, otherwise
+it contains the content of the submodule repository.
+The main repository is often referred to as superproject.
+
+The gitlink contains the object name of a particular commit
+of the submodule.
+
+The `.gitmodules` file establishes a relationship between the
+path, which is where the gitlink is in the tree, and the logical
+name, which is used for the location of the submodules git
+directory. The `.gitmodules` file has the same syntax as the
+$Git_DIR/config file and the mapping of path to name
+is done via setting `submodule.<name value>.path = <path value>`.
+
+The submodules git directory is found in in the main repositories
+'$GIT_DIR/modules/<name>' or inside the tracking subdirectory.
+
+Submodules can be used for at least two different use cases:
+
+1. Using another project while maintaining independent history.
+  Submodules allow you to contain the working tree of another project
+  within your own working tree while keeping the history of both
+  projects separate. Also, since submodules are fixed to a an arbitrary
+  version, the other project can be independently developed without
+  affecting the superproject, allowing the superproject project to
+  fix itself to new versions only whenever desired.
+
+2. Splitting a (logically single) project into multiple
+   repositories and tying them back together. This can be used to
+   overcome current limitations of Gits implementation to have
+   finer grained access:
+
+* Size of the git repository
+  In its current form Git scales up poorly for very large repositories that
+  change a lot, as the history grows very large.
+  However you can also use submodules to e.g. hold large binary assets
+  and these repositories are then shallowly cloned such that you do not
+  have a large history locally.
+
+* Transfer size
+  In its current form Git requires the whole working tree present. It
+  does not allow partial trees to be transferred in fetch or clone.
+
+* Access control
+  By restricting user access to submodules, this can be used to implement
+  read/write policies for different users.
+
+The configuration of submodules
+-------------------------------
+
+Submodule operations can be configured using the following mechanisms
+(from highest to lowest precedence):
+
+ * the command line for those commands that support taking submodule specs.
+
+ * the configuration file `$GIT_DIR/config` in the superproject.
+
+ * the `.gitmodules` file inside the superproject. A project usually
+   includes this file to suggest defaults for the upstream collection
+   of repositories.
+
+On the location of the git directory
+------------------------------------
+
+Since v1.7.7 of Git, the git directory of submodules is either stored inside
+the superprojects git directory at $GIT_DIR/modules/<submodule-name> or
+in the submodule.
+The location inside the superproject allows for the working tree to be
+non existent while keeping the history around. So we can delete a submodule
+working tree without losing information that may only be local. It is also
+possible to checkout the superproject before and after the deletion of the
+submodule without the need to reclone the submodule as it is kept locally.
+
+Workflow for a third party library
+----------------------------------
+
+  # add the submodule
+  git submodule add <url> <path>
+
+  # occasionally update the submodule to a new version:
+  git -C <path> checkout <new version>
+  git add <path>
+  git commit -m "update submodule to new version"
+
+  # see the discussion below on deleting submodules
+
+
+Workflow for an artifically split repo
+--------------------------------------
+
+  # Enable recursion for relevant commands, such that
+  # regular commands recurse into submodules by default
+  git config --global submodule.recurse true
+
+  # Unlike the other commands below clone still needs
+  # its own recurse flag:
+  git clone --recurse <URL> <directory>
+  cd <directory>
+
+  # Get to know the code:
+  git grep foo
+  git ls-files
+
+  # Get new code
+  git fetch
+  git pull --rebase
+
+  # change worktree
+  git checkout
+  git reset
+
+Deleting a submodule
+--------------------
+
+Deleting a submodule can happen on different levels:
+
+1) Removing it from the local working tree without tampering with
+   the history of the superproject.
+
+You may no longer need the submodule, but still want to keep it recorded
+in the superproject history as others may have use for it. The command
+`git submodule deinit <submodule path>` will remove any configuration
+entries from the config file, such that the submodule becomes
+uninitialized. The tracking directory in the superprojects working
+tree that holds the submodules working directory is emptied.
+This step can be undone via `git submodule init`.
+
+2) Remove it from history:
+--
+   git rm <submodule path>
+   git commit
+--
+This removes the submodules gitlink from the superprojects tree, as well
+as removing the entries from the `.gitmodules` file, but keeps the
+local configuration for the submodule. This can be undone using `git revert`.
+
+
+3) Remove the submodules git directory:
+
+When you also want to free up the disk space that the submodules git
+directory uses, you have to delete it manually as this
+step cannot be undone using git tools. It is found in `$GIT_DIR/modules`.
+
+Implementation details
+----------------------
+
+When cloning or pulling a repository containing submodules the submodules
+will not be checked out by default; You can instruct 'clone' to recurse
+into submodules. The 'init' and 'update' subcommands of 'git submodule'
+will maintain submodules checked out and at an appropriate revision in
+your working tree. Alternatively you can set 'submodule.recurse' to have
+'checkout' recursing into submodules.
+
+
+SEE ALSO
+--------
+linkgit:git-submodule[1], linkgit:gitmodules[5].
+
+GIT
+---
+Part of the linkgit:git[1] suite
-- 
2.12.2.575.gb14f27f917

