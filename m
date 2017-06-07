Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 897F71FACB
	for <e@80x24.org>; Wed,  7 Jun 2017 18:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751833AbdFGSyB (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 14:54:01 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:35973 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751690AbdFGSx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 14:53:59 -0400
Received: by mail-pg0-f45.google.com with SMTP id a70so8129636pge.3
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 11:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=i7JLosqXxeCE1t5dFLH0bIroGe0kby5RKOA17+VW93U=;
        b=Y0IbKWN0OBFQmF0zycRWyag37BwDwYkoVg5IDAEH1hLzDsqKK/QtmRXCb9YU2PwcfX
         XfSnrghlGCYBvFWm2iUrWay6eKPtpXjUiGE6+lo/ffLFRZrDTJbRyr1CNgc6P4UzPx8W
         AOGPEy1nvl3I6es5znJKxbdgvrQtZFaSxkesq8v/W69Ka9YOqIZsxdFM9bf/wA3x432d
         Bmup8tF4u7X0UTwA1i2y6+pXqK8zVyOYtMY+Kwx9/XhrzkRgbMPf10vY9GA40myL9j/0
         w+zTMS4AHsEHAnAOiMHDt4unRG+tyH99Y7H0PCVkl3HNWRSIrad4WTyEfTJnV86vdXLo
         c8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i7JLosqXxeCE1t5dFLH0bIroGe0kby5RKOA17+VW93U=;
        b=bMYoSMe6dm4uHSC/oNQEBZwuDYZkzJ/QjC/nyKOzX+DgdHqJOspcCesuk+Pm3RXslt
         t+p4DVn6f504EQxJLfBufIv+peQv5sjz/KYND723gik588w57oKMcukPw0PGLeSjk1+a
         f2zazj98shNXes/li7krgbycvyfjsyi24w97v+9olPR70C4Z3TyzFPhEkLtAy6YW4H3g
         oJ/I3wWAIkT6cCVLxvWLx5C8io5Xzp7NQahifkg0goZEjiBreyolg/EvWh12RGpJyFi/
         QYU+OaYx2b9I2OD7y42JhRtHb6P4v0mdR3QI3a5Nthz0NNP4TDQSWTNGUycj/Lqu34Yq
         kJdw==
X-Gm-Message-State: AODbwcCCoPFtwCwiUU+kHVZrudz3IbqEvK2VijxQZjGCDlLKfTLSGQz6
        gzukbPjT++xRjh5X8nPrVg==
X-Received: by 10.84.218.133 with SMTP id r5mr30476893pli.190.1496861638684;
        Wed, 07 Jun 2017 11:53:58 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:31b5:6e3d:be03:a020])
        by smtp.gmail.com with ESMTPSA id f72sm5646851pff.78.2017.06.07.11.53.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Jun 2017 11:53:57 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH] submodules: overhaul documentation
Date:   Wed,  7 Jun 2017 11:53:54 -0700
Message-Id: <20170607185354.10050-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.17.gf3d7728391
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

The moved part of text has been slightly restructured:
* Rewrite first paragraph ("allows" is wrong. For example you can keep
  untracked repos as well, submodules enable tracking across versions)
  (Also remove short example as we have examples later)

* Remove "that is completely separate" from the second sentence as
  that was said in the first sentence.

* Introduce the gitmodules file in the third paragraph, mention name
  as the basic requirement. The URL is optional though strongly
  suggested. Leave it out as gitmodules(5) explains the url.

* The paragraphs about other mechanisms and implementation details
  are moved further down, as they are not as relevant to the concept of
  gitmodules.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

This is kind of a resend from [RFC-PATCHv2] submodules: add a background story
https://public-inbox.org/git/20170209020855.23486-1-sbeller@google.com/
but the new man page is completely reworked, so I'd expect it go over better
for the first half at least.

(In the "data model" section it begins to differ from reality,
as it mentions a new not-yet-implemented place where to put submodule
related config)

Thanks,
Stefan

 Documentation/Makefile          |   1 +
 Documentation/git-rm.txt        |   4 +-
 Documentation/git-submodule.txt |  44 ++-------
 Documentation/gitsubmodules.txt | 214 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 227 insertions(+), 36 deletions(-)
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
index 74bc6200d5..032590d828 100644
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
+For more information about submodules, see linkgit:gitsubmodules[5]
 
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
index 0000000000..2bf3149b68
--- /dev/null
+++ b/Documentation/gitsubmodules.txt
@@ -0,0 +1,214 @@
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
+A submodule is another Git repository tracked in a subdirectory of your
+repository. The tracked repository has its own history, which does not
+interfere with the history of the current repository.
+
+Submodules are composed from a so-called `gitlink` tree entry
+in the main repository that refers to a particular commit object
+within the inner repository.
+
+Additionally to the gitlink entry the `.gitmodules` file (see
+linkgit:gitmodules[5]) at the root of the source tree contains
+information needed for submodules. The only required information
+is the path setting, which estabishes a logical name for the submodule.
+
+The usual git configuration (see linkgit:git-config[1]) can be used to
+override settings given by the `.gitmodules` file.
+
+Submodules can be used for two different use cases:
+
+1. Using another project that stands on its own.
+  When you want to use a third party library, submodules allow you to
+  have a clean history for your own project as well as for the library.
+  This also allows for updating the third party library as needed.
+
+2. Artificially split a (logically single) project into multiple
+   repositories and tying them back together. This can be used to
+   overcome deficiences in the data model of Git, such as:
+
+* To have finer grained access control.
+  The design principles of Git do not allow for partial repositories to be
+  checked out or transferred. A repository is the smallest unit that a user
+  can be given access to. Submodules are separate repositories, such that
+  you can restrict access to parts of your project via the use of submodules.
+* In its current form Git scales up poorly for very large repositories that
+  change a lot, as the history grows very large. For that you may want to look
+  at shallow clone, sparse checkout, or git-LFS.
+  However you can also use submodules to e.g. hold large binary assets
+  and these repositories are then shallowly cloned such that you do not
+  have a large history locally.
+
+The data model
+--------------
+
+A submodule can be considered its own autonomous repository, that has a
+worktree and a git directory at a different place than the superproject.
+
+The superproject only records the commit object name in its tree, such that
+any other information, e.g. where to obtain a copy from, is not recorded
+in the core data structures of Git. The porcelain layer of Git however
+makes use of the `.gitmodules` file that gives hints where and how to
+obtain a copy of the submodule git repository from.
+
+Submodule operations can be configured using the following mechanisms
+(from highest to lowest precedence):
+
+ * the command line for those commands that support taking submodule specs.
+
+ * the configuration file `$GIT_DIR/config`.
+
+ * the configuration file `config` found in the `refs/submodule/config` branch.
+   This can be used to overwrite the upstream configuration in the `.gitmodules`
+   file without changing the history of the project.
+   Useful options here are overwriting the base, where relative URLs apply to,
+   when mirroring only parts of the larger collection of submodules.
+
+ * the `.gitmodules` file inside the repository. A project usually includes this
+   file to suggest defaults for the upstream collection of repositories.
+
+On the location of the git directory
+------------------------------------
+
+Since v1.7.7 of Git, the git directory of submodules is stored inside the
+superprojects git directory at $GIT_DIR/modules/<submodule-name>
+This location allows for the working tree to be non existent while keeping
+the history around. So we can use `git-rm` on a submodule without loosing
+information that may only be local; it is also possible to checkout the
+superproject before and after the deletion of the submodule without the
+need to reclone the submodule as it is kept locally.
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
+in the superproject history as others may have use for it.
+--
+  git submodule deinit <submodule path>
+--
+will remove the configuration entries
+as well as the work
+
+2) Remove it from history:
+--
+   git rm <submodule>
+--
+
+3) Remove the submodules git directory:
+
+When you also want to free up the disk space that the submodules git
+directory uses, you have to delete it manually. It is found in
+`$GIT_DIR/modules`.
+The steps 1 and 2 can be undone via `git submodule init` or
+`git revert`, respectively.  This step may incur data loss,
+and cannot be undone. That is why there is no builtin.
+
+Other mechanisms
+----------------
+
+Git repositories are allowed to be kept inside other repositories without
+the need to use submodules. This however does not enable cross-repository
+versioning as the inner repository is unaware of the outer repository,
+which in turn ignores the inner.
+
+Submodules are not to be confused with remotes, which are other
+repositories of the same project; submodules are meant for
+different projects you would like to make part of your source tree,
+while the history of the two projects still stays completely
+independent and you cannot modify the contents of the submodule
+from within the main project.
+If you want to merge the project histories and want to treat the
+aggregated whole as a single project from then on, you may want to
+add a remote for the other project and use the 'subtree' merge strategy,
+instead of treating the other project as a submodule. Directories
+that come from both projects can be cloned and checked out as a whole
+if you choose to go that route.
+
+Third party tools
+-----------------
+
+There are a variety of third party tools that manage multiple repositories
+and their relationships to each other, such as Androids repo tool or git-slave.
+Often these tools lack cross repository versioning.
+
+https://source.android.com/source/using-repo
+
+http://gitslave.sourceforge.net/
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
2.13.0.17.gf3d7728391

