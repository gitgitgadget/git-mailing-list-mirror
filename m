Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B2EC2BA83
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 22:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBAFE20838
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 22:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAQdgPHz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgBIWBI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 17:01:08 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:39079 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbgBIWBI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 17:01:08 -0500
Received: by mail-wm1-f45.google.com with SMTP id c84so8376576wme.4
        for <git@vger.kernel.org>; Sun, 09 Feb 2020 14:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=f1/bDq/Ct4wz1zs+jHVFj4257+OIb6V4gSmm69hWsOA=;
        b=LAQdgPHz954IPjLMIWgGPyspDXdNtjPUsf6w8v1/CHh/B5N4f3+p207sUxxXiaDv1A
         HYCZHHp14yKPuz+xX4mN2ujkBTcchOdWH13XTbZs5gkakP4NNN/C3OY/ory2XvRXWDDW
         3uKWG35Aj9IEE3uLQPHX0o73zfrMxFL0O1YoZFjVDNlyeNuufudMmNkpZ0ifBjstX9y5
         3EhAyZgwq4Ub/FTYhOhmJSsK6JKT2jmaNoJyMep4Z6iU1Ia6IqsYGMVehfdWdDFZ719e
         Rvivh4Y3QgtB8Y06Lro3Iyii5/NtYMoLrPZmkSaY7OebPpTLwUuYY8X4VIGVJ2A3NbDr
         H9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=f1/bDq/Ct4wz1zs+jHVFj4257+OIb6V4gSmm69hWsOA=;
        b=ZFJDMVGfK3ZMlQBXoiZGlVzimvZ0xciFZ92izRzfBH9HU6HCEbCqXgaH2BAhEQAQBk
         /Bxbm/B1ZEcvlnKmdfA4n04N4YEJB35qxXj7Z2/QcJ2mMtRnY2AfoaiYkOgIlRBX6jPN
         ddB6+gCWrpGEOUq1r4TUt7Ld9qW1OEDUj4uI8DdehADjj+JCr/txz0F8b1SaFQWuVf2E
         IkOTYeUwrDyAiX//MITavB8asLgzBPm1cWlnT7uNyMzGDUpBG39WG6dsDPXsb7j9rBUE
         C8DnEpjb93ffpa/oeuQxMjl0nTbuz8XP/BoljWnm3Z2zcdn7ARkg1RJOtt3X44QXRI2V
         Zx9A==
X-Gm-Message-State: APjAAAUIj8rEKpJVjf+4nzrKNtOPzgHc+Ssg9IpqoRnGc6EOT1wjI3s2
        OdZyylQGPviRiYHqVYS8ty+OKc2b
X-Google-Smtp-Source: APXvYqwI0Us/fXxCU7tj9YVEXiyxdRMVoMq1FLfxWGaBikdHn/mDFq4nTHl3tMnJ5an4RgN2KYbTNw==
X-Received: by 2002:a05:600c:217:: with SMTP id 23mr11074458wmi.124.1581285662408;
        Sun, 09 Feb 2020 14:01:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h10sm12373860wml.18.2020.02.09.14.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 14:01:02 -0800 (PST)
Message-Id: <721bbc1cc83b380557d7e92e428b68e395bb845d.1581285658.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.525.v2.git.1581285658.gitgitgadget@gmail.com>
References: <pull.525.git.1579905218.gitgitgadget@gmail.com>
        <pull.525.v2.git.1581285658.gitgitgadget@gmail.com>
From:   "Christian Stimming via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 09 Feb 2020 22:00:57 +0000
Subject: [PATCH v2 2/3] git-gui: extend translation glossary template with
 more terms
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Stimming <christian@cstimming.de>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Christian Stimming <christian@cstimming.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Stimming <christian@cstimming.de>

The English glossary template was missing some terms, some of them
not only for git-gui, but also gitk and/or git core. Many such terms
have been added.

Also, the list has been sorted alphabetically so that comparison to
other glossary lists are easier.

Signed-off-by: Christian Stimming <christian@cstimming.de>
---
 po/glossary/git-gui-glossary.pot | 250 +++++++++++++++++++++++++++++--
 po/glossary/git-gui-glossary.txt | 101 ++++++++-----
 2 files changed, 305 insertions(+), 46 deletions(-)

diff --git a/po/glossary/git-gui-glossary.pot b/po/glossary/git-gui-glossary.pot
index 40eb3e9c07..4e66e0da3a 100644
--- a/po/glossary/git-gui-glossary.pot
+++ b/po/glossary/git-gui-glossary.pot
@@ -6,7 +6,7 @@
 msgid ""
 msgstr ""
 "Project-Id-Version: PACKAGE VERSION\n"
-"POT-Creation-Date: 2008-01-07 21:20+0100\n"
+"POT-Creation-Date: 2020-01-26 22:26+0100\n"
 "PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
 "Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
 "Language-Team: LANGUAGE <LL@li.org>\n"
@@ -18,14 +18,46 @@ msgstr ""
 msgid "English Term (Dear translator: This file will never be visible to the user!)"
 msgstr ""
 
+#. "prematurely stop and abandon an operation"
+msgid "abort"
+msgstr ""
+
 #. ""
 msgid "amend"
 msgstr ""
 
+#. "a commit that succeeds the current one in git's graph of commits (not necessarily directly)"
+msgid "ancestor"
+msgstr ""
+
 #. ""
 msgid "annotate"
 msgstr ""
 
+#. "The person who initially created (authored) a commit"
+msgid "author"
+msgstr ""
+
+#. "a repository with only .git directory, without working directory"
+msgid "bare repository"
+msgstr ""
+
+#. "a parent version of the current file"
+msgid "base"
+msgstr ""
+
+#. ""
+msgid "bisect"
+msgstr ""
+
+#. "get the authors responsible for each line in a file"
+msgid "blame"
+msgstr ""
+
+#.      ""
+msgid "blob"
+msgstr ""
+
 #. "A 'branch' is an active line of development."
 msgid "branch [noun]"
 msgstr ""
@@ -42,6 +74,18 @@ msgstr ""
 msgid "checkout [verb]"
 msgstr ""
 
+#. "to select and apply a single commit to the current HEAD without merging"
+msgid "cherry-pick"
+msgstr ""
+
+#. "a commit that directly succeeds the current one in git's graph of commits"
+msgid "child commit"
+msgstr ""
+
+#. "clean the state of the git repository, often after manually stopped operation"
+msgid "cleanup"
+msgstr ""
+
 #. ""
 msgid "clone [verb]"
 msgstr ""
@@ -54,6 +98,26 @@ msgstr ""
 msgid "commit [verb]"
 msgstr ""
 
+#. "a message that gets attached with any commit"
+msgid "commit message"
+msgstr ""
+
+#.   "The person who committed a commit (to the current branch), which might be different than the author."
+msgid "committer"
+msgstr ""
+
+#. "a commit that precedes the current one in git's graph of commits (not necessarily directly)"
+msgid "descendant"
+msgstr ""
+
+#.       "checkout of a revision rather than some head"
+msgid "detached HEAD"
+msgstr ""
+
+#. "checkout of a revision rather than some head"
+msgid "detached checkout"
+msgstr ""
+
 #. ""
 msgid "diff [noun]"
 msgstr ""
@@ -62,14 +126,34 @@ msgstr ""
 msgid "diff [verb]"
 msgstr ""
 
-#. "A fast-forward is a special type of merge where you have a revision and you are merging another branch's changes that happen to be a descendant of what you have."
-msgid "fast forward merge"
+#.   ""
+msgid "directory"
+msgstr ""
+
+#. "A fast-forward merge is a special type of merge where you have a revision and you are merging another branch's changes that happen to be a descendant of what you have."
+msgid "fast-forward"
 msgstr ""
 
 #. "Fetching a branch means to get the branch's head from a remote repository, to find out which objects are missing from the local object database, and to get them, too."
 msgid "fetch"
 msgstr ""
 
+#. "any merge strategy that works on a file by file basis"
+msgid "file level merging"
+msgstr ""
+
+#.      ""
+msgid "file"
+msgstr ""
+
+#. "the last revision in a branch"
+msgid "head"
+msgstr ""
+
+#. "script that gets executed automatically on some event"
+msgid "hook"
+msgstr ""
+
 #. "One context of consecutive lines in a whole patch, which consists of many such hunks"
 msgid "hunk"
 msgstr ""
@@ -78,6 +162,26 @@ msgstr ""
 msgid "index (in git-gui: staging area)"
 msgstr ""
 
+#. "the first checkout during a clone operation"
+msgid "initial checkout"
+msgstr ""
+
+#. "The very first commit in a repository"
+msgid "initial commit"
+msgstr ""
+
+#. "a branch that resides in the local git repository"
+msgid "local branch"
+msgstr ""
+
+#. "a Git object that is not part of any pack"
+msgid "loose object"
+msgstr ""
+
+#. "a branch called by convention 'master' that exists in a newly created git repository"
+msgid "master branch"
+msgstr ""
+
 #. "A successful merge results in the creation of a new commit representing the result of the merge."
 msgid "merge [noun]"
 msgstr ""
@@ -90,7 +194,42 @@ msgstr ""
 msgid "message"
 msgstr ""
 
-#. "Deletes all stale tracking branches under <name>. These stale branches have already been removed from the remote repository referenced by <name>, but are still locally available in 'remotes/<name>'."
+#. "a remote called by convention 'origin' that the current git repository has been cloned from"
+msgid "origin"
+msgstr ""
+
+#.       ""
+msgid "orphan commit"
+msgstr ""
+
+#.  ""
+msgid "orphan reference"
+msgstr ""
+
+#. "a file containing many git objects packed together"
+msgid "pack [noun]"
+msgstr ""
+
+#.     "the process of creating a pack file"
+msgid "pack [verb]"
+msgstr ""
+
+#. "a Git object part of some pack"
+msgid "packed object"
+msgstr ""
+
+#. "a commit that directly precedes the current one in git's graph of commits"
+msgid "parent commit"
+msgstr ""
+
+msgid "patch" ""
+msgstr ""
+
+#. "The path to a file"
+msgid "path"
+msgstr ""
+
+#. "Delete all stale tracking branches under <name>. These stale branches have already been removed from the remote repository referenced by <name>, but are still locally available in 'remotes/<name>'."
 msgid "prune"
 msgstr ""
 
@@ -102,12 +241,43 @@ msgstr ""
 msgid "push"
 msgstr ""
 
+#. "The process of rebasing one set of commits on top of another branch's head"
+msgid "rebase [noun]"
+msgstr ""
+
+#. "Re-apply one set of commits on top of another branch's head. Contrary to merge."
+msgid "rebase [verb]"
+msgstr ""
+
 #. ""
 msgid "redo"
 msgstr ""
 
-#. "An other repository ('remote'). One might have a set of remotes whose branches one tracks."
-msgid "remote"
+#.   ""
+msgid "reference"
+msgstr ""
+
+#. "the log file containing all states of the HEAD reference (in other words past pristine states of the working copy)"
+msgid "reflog"
+msgstr ""
+
+msgid "refmap"       ""
+msgstr ""
+
+#. ""
+msgid "refspec"
+msgstr ""
+
+#. "The adjective for anything which is outside of the current (local) repository"
+msgid "remote [adj]"
+msgstr ""
+
+#.       "A branch in any other ('remote') repository"
+msgid "remote branch"
+msgstr ""
+
+#.   "An other repository ('remote'). One might have a set of remotes whose branches one tracks."
+msgid "remote repository"
 msgstr ""
 
 #. "A collection of refs (?) together with an object database containing all objects which are reachable from the refs... (oops, you've lost me here. Again, please an explanation for mere mortals?)"
@@ -118,10 +288,22 @@ msgstr ""
 msgid "reset"
 msgstr ""
 
+#. "decide which changes from alternative versions of a file should persist in Git"
+msgid "resolve (a conflict)"
+msgstr ""
+
+#. "abandon changes and go to pristine version"
+msgid "revert changes"
+msgstr ""
+
 #. ""
 msgid "revert"
 msgstr ""
 
+#. "expression that signifies a revision in git"
+msgid "revision expression"
+msgstr ""
+
 #. "A particular state of files and directories which was stored in the object database."
 msgid "revision"
 msgstr ""
@@ -130,39 +312,87 @@ msgstr ""
 msgid "sign off"
 msgstr ""
 
-#. ""
+#.     "see: staging area. In some areas of git this is called 'index'."
+msgid "stage [noun], index"
+msgstr ""
+
+#. "add some content of files and directories to the staging area in preparation for a commit"
+msgid "stage [verb]"
+msgstr ""
+
+#. "The place where changes from files are marked to be included for the next commit. In some areas of git this is called 'index'."
 msgid "staging area"
 msgstr ""
 
+#. "The place (stack) where changes can be temporarily saved without committing"
+msgid "stash [noun]"
+msgstr ""
+
+#. "temporarily save changes in a stack without committing"
+msgid "stash [verb]"
+msgstr ""
+
 #. ""
 msgid "status"
 msgstr ""
 
-#. "A ref pointing to a tag or commit object"
+#. ""
+msgid "submodule"
+msgstr ""
+
+#. "A ref pointing to some commit object. In other words: A label on a specific commit."
 msgid "tag [noun]"
 msgstr ""
 
-#. ""
+#. "The process of creating a tag at a specific commit object"
 msgid "tag [verb]"
 msgstr ""
 
+#. "The person who created a tag"
+msgid "tagger"
+msgstr ""
+
+#. "file whose content is tracked/not tracked by git"
+msgid "tracked/untracked"
+msgstr ""
+
 #. "A regular git branch that is used to follow changes from another repository."
 msgid "tracking branch"
 msgstr ""
 
+#. ""
+msgid "trailer"
+msgstr ""
+
+#. "1. tree object, 2. directory tree"
+msgid "tree"
+msgstr ""
+
 #. ""
 msgid "undo"
 msgstr ""
 
+#. "Remove content of files from the staging area again so that it will not be part of the next commit"
+msgid "unstage"
+msgstr ""
+
+#. "Retrieving the temporarily saved changes back again from the stash"
+msgid "unstash [verb]"
+msgstr ""
+
 #. ""
 msgid "update"
 msgstr ""
 
+#. ""
+msgid "upstream branch"
+msgstr ""
+
 #. ""
 msgid "verify"
 msgstr ""
 
 #. "The tree of actual checked out files."
-msgid "working copy, working tree"
+msgid "working directory, working copy, working tree"
 msgstr ""
 
diff --git a/po/glossary/git-gui-glossary.txt b/po/glossary/git-gui-glossary.txt
index 409304692d..48b9f10e57 100644
--- a/po/glossary/git-gui-glossary.txt
+++ b/po/glossary/git-gui-glossary.txt
@@ -1,67 +1,96 @@
 "English Term (Dear translator: This file will never be visible to the user!)"	"English Definition (Dear translator: This file will never be visible to the user! It should only serve as a tool for you, the translator. Nothing more.)"
+"abort"	"prematurely stop and abandon an operation"
 "amend"	""
+"ancestor"	"a commit that succeeds the current one in git's graph of commits (not necessarily directly)"
 "annotate"	""
+"author"	"The person who initially created (authored) a commit"
+"bare repository"	"a repository with only .git directory, without working directory"
+"base"	"a parent version of the current file"
+"bisect"	""
+"blame"	"get the authors responsible for each line in a file"
+"blob"	     ""
 "branch [noun]"	"A 'branch' is an active line of development."
 "branch [verb]"	""
 "checkout [noun]"	""
 "checkout [verb]"	"The action of updating the working tree to a revision which was stored in the object database."
+"cherry-pick"	"to select and apply a single commit to the current HEAD without merging"
+"child commit"	"a commit that directly succeeds the current one in git's graph of commits"
+"cleanup"	"clean the state of the git repository, often after manually stopped operation"
 "clone [verb]"	""
 "commit [noun]"	"A single point in the git history."
 "commit [verb]"	"The action of storing a new snapshot of the project's state in the git history."
+"commit message"	"a message that gets attached with any commit"
+"committer"	  "The person who committed a commit (to the current branch), which might be different than the author."
+"descendant"	"a commit that precedes the current one in git's graph of commits (not necessarily directly)"
+"detached HEAD"	      "checkout of a revision rather than some head"
+"detached checkout"	"checkout of a revision rather than some head"
 "diff [noun]"	""
 "diff [verb]"	""
-"fast forward merge"	"A fast-forward is a special type of merge where you have a revision and you are merging another branch's changes that happen to be a descendant of what you have."
+"directory"	  ""
+"fast-forward"	"A fast-forward merge is a special type of merge where you have a revision and you are merging another branch's changes that happen to be a descendant of what you have."
 "fetch"	"Fetching a branch means to get the branch's head from a remote repository, to find out which objects are missing from the local object database, and to get them, too."
+"file level merging"	"any merge strategy that works on a file by file basis"
+"file"	     ""
+"head"	"the last revision in a branch"
+"hook"	"script that gets executed automatically on some event"
 "hunk"	"One context of consecutive lines in a whole patch, which consists of many such hunks"
 "index (in git-gui: staging area)"	"A collection of files. The index is a stored version of your working tree."
+"initial checkout"	"the first checkout during a clone operation"
+"initial commit"	"The very first commit in a repository"
+"local branch"	"a branch that resides in the local git repository"
+"loose object"	"a Git object that is not part of any pack"
+"master branch"	"a branch called by convention 'master' that exists in a newly created git repository"
 "merge [noun]"	"A successful merge results in the creation of a new commit representing the result of the merge."
 "merge [verb]"	"To bring the contents of another branch into the current branch."
 "message"	""
-"prune"	"Deletes all stale tracking branches under <name>. These stale branches have already been removed from the remote repository referenced by <name>, but are still locally available in 'remotes/<name>'."
+"origin"	"a remote called by convention 'origin' that the current git repository has been cloned from"
+"orphan commit"	      ""
+"orphan reference"	 ""
+"pack [noun]"	"a file containing many git objects packed together"
+"pack [verb]"	    "the process of creating a pack file"
+"packed object"	"a Git object part of some pack"
+"parent commit"	"a commit that directly precedes the current one in git's graph of commits"
+"patch" ""
+"path"	"The path to a file"
+"prune"	"Delete all stale tracking branches under <name>. These stale branches have already been removed from the remote repository referenced by <name>, but are still locally available in 'remotes/<name>'."
 "pull"	"Pulling a branch means to fetch it and merge it."
 "push"	"Pushing a branch means to get the branch's head ref from a remote repository, and ... (well, can someone please explain it for mere mortals?)"
+"rebase [noun]"	"The process of rebasing one set of commits on top of another branch's head"
+"rebase [verb]"	"Re-apply one set of commits on top of another branch's head. Contrary to merge."
 "redo"	""
-"remote"	"An other repository ('remote'). One might have a set of remotes whose branches one tracks."
+"reference"	  ""
+"reflog"	"the log file containing all states of the HEAD reference (in other words past pristine states of the working copy)"
+"refmap"       ""
+"refspec"	""
+"remote [adj]"	"The adjective for anything which is outside of the current (local) repository"
+"remote branch"	      "A branch in any other ('remote') repository"
+"remote repository"	  "An other repository ('remote'). One might have a set of remotes whose branches one tracks."
 "repository"	"A collection of refs (?) together with an object database containing all objects which are reachable from the refs... (oops, you've lost me here. Again, please an explanation for mere mortals?)"
 "reset"	""
+"resolve (a conflict)"	"decide which changes from alternative versions of a file should persist in Git"
+"revert changes"	"abandon changes and go to pristine version"
 "revert"	""
+"revision expression"	"expression that signifies a revision in git"
 "revision"	"A particular state of files and directories which was stored in the object database."
 "sign off"	""
-"staging area"	""
+"stage [noun], index"	    "see: staging area. In some areas of git this is called 'index'."
+"stage [verb]"	"add some content of files and directories to the staging area in preparation for a commit"
+"staging area"	"The place where changes from files are marked to be included for the next commit. In some areas of git this is called 'index'."
+"stash [noun]"	"The place (stack) where changes can be temporarily saved without committing"
+"stash [verb]"	"temporarily save changes in a stack without committing"
 "status"	""
-"tag [noun]"	"A ref pointing to a tag or commit object"
-"tag [verb]"	""
+"submodule"	""
+"tag [noun]"	"A ref pointing to some commit object. In other words: A label on a specific commit."
+"tag [verb]"	"The process of creating a tag at a specific commit object"
+"tagger"	"The person who created a tag"
+"tracked/untracked"	"file whose content is tracked/not tracked by git"
 "tracking branch"	"A regular git branch that is used to follow changes from another repository."
+"trailer"	""
+"tree"	"1. tree object, 2. directory tree"
 "undo"	""
+"unstage"	"Remove content of files from the staging area again so that it will not be part of the next commit"
+"unstash [verb]"	"Retrieving the temporarily saved changes back again from the stash"
 "update"	""
+"upstream branch"	""
 "verify"	""
-"working copy, working tree"	"The tree of actual checked out files."
-"ancestor"	"a commit that succeeds the current one in git's graph of commits (not necessarily directly)"
-"abort"	"prematurely stop and abandon an operation"
-"bare repository"	"a repository with only .git directory, without working directory"
-"base"	"a parent version of the current file"
-"blame"	"get the authors responsible for each line in a file"
-"cherry-pick"	"to select and apply a single commit without merging"
-"child"	"a commit that directly succeeds the current one in git's graph of commits"
-"cleanup"	"clean the state of the git repository, often after manually stopped operation"
-"commit message"	"a message that gets attached with any commit"
-"descendant"	"a commit that precedes the current one in git's graph of commits (not necessarily directly)"
-"detached checkout"	"checkout of a revision rather than a some head"
-"file level merging"	"any merge strategy that works on a file by file basis"
-"head"	"the last revision in a branch"
-"hook"	"script that gets executed automatically on some event"
-"initial checkout"	"the first checkout during a clone operation"
-"local branch"	"a branch that resides in the local git repository"
-"loose object"	"a Git object that is not part of any pack"
-"master branch"	"a branch called by convention 'master' that exists in a newly created git repository"
-"origin"	"a remote called by convention 'origin' that the current git repository has been cloned from"
-"pack [noun]"	"a file containing many git objects packed together"
-"packed object"	"a Git object part of some pack"
-"parent"	"a commit that directly precedes the current one in git's graph of commits"
-"reflog"	"the log file containing all states of the HEAD reference (in other words past pristine states of the working copy)"
-"resolve (a conflict)"	"decide which changes from alternative versions of a file should persist in Git"
-"revert changes"	"abandon changes and go to pristine version"
-"revision expression"	"expression that signifies a revision in git"
-"stage/unstage"	"add some content of files and directories to the staging area in preparation for a commit"
-"stash"	"temporarily save changes in a stack without committing"
-"tracked/untracked"	"file whose content is tracked/not tracked by git"
+"working directory, working copy, working tree"	"The tree of actual checked out files."
-- 
gitgitgadget

