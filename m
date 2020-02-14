Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B778EC3B19D
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 14:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853112187F
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 14:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1Ktnmz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387458AbgBNOo5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 09:44:57 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:33767 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387429AbgBNOo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 09:44:56 -0500
Received: by mail-wr1-f44.google.com with SMTP id u6so11234126wrt.0
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 06:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=81/AIgqyRuFiV3HO2Icul1sGV/JwegTwet9uDfguys4=;
        b=b1Ktnmz9Ec+Dtowa+A9lfFqHOnWPUKvO0gLpKwSdL9gLyWr5g7ztVL32ZA5XRlT4iB
         h+Ka37tiufW/lG9mDOzV7Vqw1w8kdnXCHEmssur6Zc7OaDvXHP54YENtQ622xcphbWVi
         iX4twi3JI/M8fTrBHTk4yDdWZ8MGNYwUVLAOXuFcdz3G+xMj83lqJnDuLBjUV3SyW4Ig
         c7Ufnu4SB8klIxNBRO9tOc+jO88LIuljWpvx59dAHxB0aImpVslKUL6kGmy9TTUd2ui7
         p83nMlD4Ho/DKPbqBTM9CUn9FjcBYGVNdJPmKvutKu6mjy8668giiT7mQC3mUzl0dwWb
         wYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=81/AIgqyRuFiV3HO2Icul1sGV/JwegTwet9uDfguys4=;
        b=svTJZqH/4vEA6TpSEV1SZCGV38/r1evS5ig1c2cfKsk7+m5vvOJOmY7KllXdstROZY
         5GSOuTm0mTnn+5h63i38svyfoQXP1gqk0YP3NlP8KU8RxRgl3Y+MjrnLiZStjXGLjiep
         dkdZLG8Om53Tu8t8kzO4eJLbKMpwA3f7sb8tWFG4S+YQbAE5L4i1QV9ob8llExLZjxTH
         kK3r1oEXA81LRm0O6cO9oDLBiyRF/0roo/7YLv0wu4F9pNLdMr40Wqso0zd86QU4Ijss
         DBvzN4S1eQTHfPNvmgc0YLaD1OOqe8Wz76VU0crKPXrwYDUhazwH4Y0fKFz/A1W9cqvB
         SjIQ==
X-Gm-Message-State: APjAAAUxRwvaq9dZHmt0qOEXDBKBk/jH2sHTxJd704sTJU6SXfTImmMU
        Sd3sKjgTL5ZlI04DQ0bqOBvZw9YB
X-Google-Smtp-Source: APXvYqxXLNwMm2Pc8QZesVPvvD4k14fmbIczj6eE3li/xrqja0FmdCJEBugJXiA/PecWVJLmVORAtg==
X-Received: by 2002:adf:ce0f:: with SMTP id p15mr4638343wrn.342.1581691493512;
        Fri, 14 Feb 2020 06:44:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm7853762wrn.3.2020.02.14.06.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 06:44:52 -0800 (PST)
Message-Id: <a240b292a17e393932031fb542d40ef8ebc90e96.1581691486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.698.v6.git.git.1581691486.gitgitgadget@gmail.com>
References: <pull.698.v5.git.git.1581447484.gitgitgadget@gmail.com>
        <pull.698.v6.git.git.1581691486.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Feb 2020 14:44:45 +0000
Subject: [PATCH v6 6/7] git-p4: add p4 submit hooks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>, Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

The git command "commit" supports a number of hooks that support
changing the behavior of the commit command.  The git-p4.py program only
has one existing hook, "p4-pre-submit".  This command occurs early in
the process.  There are no hooks in the process flow for modifying
the P4 changelist text programmatically.

Adds 3 new hooks to git-p4.py to the submit option.

The new hooks are:
* p4-prepare-changelist - Execute this hook after the changelist file
  has been created. The hook will be executed even if the
  --prepare-p4-only option is set.  This hook ignores the --no-verify
  option in keeping with the existing behavior of git commit.

* p4-changelist - Execute this hook after the user has edited the
  changelist. Do not execute this hook if the user has selected the
  --prepare-p4-only option. This hook will honor the --no-verify,
  following the conventions of git commit.

* p4-post-changelist - Execute this hook after the P4 submission process
  has completed successfully. This hook takes no parameters and is
  executed regardless of the --no-verify option.  It's return value will
  not be checked.

The calls to the new hooks: p4-prepare-changelist, p4-changelist,
and p4-post-changelist should all be called inside the try-finally
block.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 Documentation/git-p4.txt   | 35 +++++++++++++++++++++++++++++
 Documentation/githooks.txt | 46 ++++++++++++++++++++++++++++++++++++++
 git-p4.py                  | 35 ++++++++++++++++++++++++++++-
 3 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 362b50eb212..dab9609013f 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -387,6 +387,41 @@ It can be bypassed with the `--no-verify` command line option.
 
 One usage scenario is to run unit tests in the hook.
 
+p4-prepare-changelist
+~~~~~~~~~~~~~~~~~~~~~
+
+The `p4-prepare-changelist` hook is executed right after preparing
+the default changelist message and before the editor is started.
+It takes one parameter, the name of the file that contains the
+changelist text. Exiting with a non-zero status from the script
+will abort the process.
+
+The purpose of the hook is to edit the message file in place,
+and it is not supressed by the `--no-verify` option. This hook
+is called even if `--prepare-p4-only` is set.
+
+p4-changelist
+~~~~~~~~~~~~~
+
+The `p4-changelist` hook is executed after the changelist
+message has been edited by the user. It can be bypassed with the
+`--no-verify` option. It takes a single parameter, the name
+of the file that holds the proposed changelist text. Exiting
+with a non-zero status causes the command to abort.
+
+The hook is allowed to edit the changelist file and can be used
+to normalize the text into some project standard format. It can
+also be used to refuse the Submit after inspect the message file.
+
+p4-post-changelist
+~~~~~~~~~~~~~~~~~~
+
+The `p4-post-changelist` hook is invoked after the submit has
+successfully occured in P4. It takes no parameters and is meant
+primarily for notification and cannot affect the outcome of the
+git p4 submit action.
+
+
 
 Rebase options
 ~~~~~~~~~~~~~~
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 8cf6b08b55b..8aa9c2176c6 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -515,6 +515,52 @@ The exit status determines whether git will use the data from the
 hook to limit its search.  On error, it will fall back to verifying
 all files and folders.
 
+p4-changelist
+~~~~~~~~~~~~~
+
+This hook is invoked by `git-p4 submit`.
+
+The `p4-changelist` hook is executed after the changelist
+message has been edited by the user. It can be bypassed with the
+`--no-verify` option. It takes a single parameter, the name
+of the file that holds the proposed changelist text. Exiting
+with a non-zero status causes the command to abort.
+
+The hook is allowed to edit the changelist file and can be used
+to normalize the text into some project standard format. It can
+also be used to refuse the Submit after inspect the message file.
+
+Run `git-p4 submit --help` for details.
+
+p4-prepare-changelist
+~~~~~~~~~~~~~~~~~~~~~
+
+This hook is invoked by `git-p4 submit`.
+
+The `p4-prepare-changelist` hook is executed right after preparing
+the default changelist message and before the editor is started.
+It takes one parameter, the name of the file that contains the
+changelist text. Exiting with a non-zero status from the script
+will abort the process.
+
+The purpose of the hook is to edit the message file in place,
+and it is not supressed by the `--no-verify` option. This hook
+is called even if `--prepare-p4-only` is set.
+
+Run `git-p4 submit --help` for details.
+
+p4-post-changelist
+~~~~~~~~~~~~~~~~~~
+
+This hook is invoked by `git-p4 submit`.
+
+The `p4-post-changelist` hook is invoked after the submit has
+successfully occured in P4. It takes no parameters and is meant
+primarily for notification and cannot affect the outcome of the
+git p4 submit action.
+
+Run `git-p4 submit --help` for details.
+
 p4-pre-submit
 ~~~~~~~~~~~~~
 
diff --git a/git-p4.py b/git-p4.py
index 4ae6aa30f06..8761c70e1c6 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1589,7 +1589,7 @@ def __init__(self):
                 optparse.make_option("--disable-p4sync", dest="disable_p4sync", action="store_true",
                                      help="Skip Perforce sync of p4/master after submit or shelve"),
                 optparse.make_option("--no-verify", dest="no_verify", action="store_true",
-                                     help="Bypass p4-pre-submit"),
+                                     help="Bypass p4-pre-submit and p4-changelist hooks"),
         ]
         self.description = """Submit changes from git to the perforce depot.\n
     The `p4-pre-submit` hook is executed if it exists and is executable. It
@@ -1598,6 +1598,28 @@ def __init__(self):
     from this script prevents `git-p4 submit` from launching.
 
     One usage scenario is to run unit tests in the hook.
+
+    The `p4-prepare-changelist` hook is executed right after preparing the default
+    changelist message and before the editor is started. It takes one parameter,
+    the name of the file that contains the changelist text. Exiting with a non-zero
+    status from the script will abort the process.
+
+    The purpose of the hook is to edit the message file in place, and it is not
+    supressed by the `--no-verify` option. This hook is called even if
+    `--prepare-p4-only` is set.
+
+    The `p4-changelist` hook is executed after the changelist message has been
+    edited by the user. It can be bypassed with the `--no-verify` option. It
+    takes a single parameter, the name of the file that holds the proposed
+    changelist text. Exiting with a non-zero status causes the command to abort.
+
+    The hook is allowed to edit the changelist file and can be used to normalize
+    the text into some project standard format. It can also be used to refuse the
+    Submit after inspect the message file.
+
+    The `p4-post-changelist` hook is invoked after the submit has successfully
+    occured in P4. It takes no parameters and is meant primarily for notification
+    and cannot affect the outcome of the git p4 submit action.
     """
 
         self.usage += " [name of git branch to submit into perforce depot]"
@@ -2105,6 +2127,10 @@ def applyCommit(self, id):
         submitted = False
 
         try:
+            # Allow the hook to edit the changelist text before presenting it
+            # to the user.
+            if not run_git_hook("p4-prepare-changelist", [fileName]):
+                return False
 
             if self.prepare_p4_only:
                 #
@@ -2144,6 +2170,12 @@ def applyCommit(self, id):
                 return True
 
             if self.edit_template(fileName):
+                if not self.no_verify:
+                    if not run_git_hook("p4-changelist", [fileName]):
+                        print("The p4-changelist hook failed.")
+                        sys.stdout.flush()
+                        return False
+
                 # read the edited message and submit
                 tmpFile = open(fileName, "rb")
                 message = tmpFile.read()
@@ -2181,6 +2213,7 @@ def applyCommit(self, id):
 
                 submitted = True
 
+                run_git_hook("p4-post-changelist")
         finally:
             # Revert changes if we skip this patch
             if not submitted or self.shelve:
-- 
gitgitgadget

