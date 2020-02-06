Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BB9C2D0B1
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 15:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD7521741
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 15:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nf3Lu7lu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbgBFPP7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:15:59 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:36389 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbgBFPP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 10:15:57 -0500
Received: by mail-wm1-f51.google.com with SMTP id p17so431535wma.1
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 07:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bbODT8OalAQRq4WbFQV1GtaKv9y7L5lP5tpfDheyhOk=;
        b=Nf3Lu7luQCE4WeTx30f94v0LFmFhTTUB9A+8I4OXGW6fEO36iO+rGxLyWuR0zvfPce
         zBDeJFpkmE4M612Ik/UZTGZR7tiPsvMcGH9mmGOrlH0Xdk8nThn0DT0hC8mFKA3i+6g5
         o2C/f/iKhI6Y/1I1a6STsyvG8K6Aa35FHcYaf2T6I7dOQvvy473bP7N78+bqILBZevXV
         EGfZf0qyvzOVkK0Rp1vuqhIVjUyZABlkD2prerSuHC9rnA+uWqpAvZCF+GtEJmqvlgLa
         3UQgDmqmxsBFLUqI4Px/dflu8MFvwou5siFaNth4LVwoilgdCC6Mt0uLVH92g7QrR1oZ
         e2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bbODT8OalAQRq4WbFQV1GtaKv9y7L5lP5tpfDheyhOk=;
        b=ccEyWYiNqPlEyGDQ0/CqDiMKW9TiDfxPmBzeKyM4ddNlt/D/R2gVj1rEcrHuk4n9xB
         N2YKSEL44TYE1MKRJPNGT58PFFiqrIJrKoqol3Xsv12Q03C45HRhBrJKuA23XMzM7HEs
         /3Hfwf6ou4moanQEJep8SG+vFddgsvGQCHLKkFmAseyFLcEFeII72e+C/bznWrmWUvRa
         iL03GWfUBM+o9vuXLtafYGQnFYV3uK/eOhFiMYf0nHRJElkFLYeCuivtVDOqllzwDVWS
         V9iNMOrYQQgP3N1159qx0Ma8g1Mj8nuGWNknqjUE/jSW1XtDL54iG1/13O9zO1Bc7BmM
         s5zg==
X-Gm-Message-State: APjAAAWpvFZDhJ5FwDWQoZ3tDKJQlhj0ibvaFRQc03v/XOTZoYVXF07d
        pSu9ZcnlSe9LSGGHVG4Jsxb9eziz
X-Google-Smtp-Source: APXvYqx7m3hgMRQLCEUaHjrghdC7ksvlgMsNCEIDx75MK+i5NJmrI5aRmnC2V15bqd5Y3GApTBSksw==
X-Received: by 2002:a7b:ce8b:: with SMTP id q11mr5241467wmj.100.1581002154731;
        Thu, 06 Feb 2020 07:15:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 18sm3919350wmf.1.2020.02.06.07.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 07:15:54 -0800 (PST)
Message-Id: <e34c377066ecd4f0bad2fafde01701d3b2af48a7.1581002149.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.698.v3.git.git.1581002149.gitgitgadget@gmail.com>
References: <pull.698.v2.git.git.1580507895.gitgitgadget@gmail.com>
        <pull.698.v3.git.git.1581002149.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Feb 2020 15:15:48 +0000
Subject: [PATCH v3 5/5] git-p4: add p4 submit hooks
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
index 362b50eb21..dab9609013 100644
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
index 8cf6b08b55..8aa9c2176c 100644
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
index 1d15ea7464..c912576094 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1584,7 +1584,7 @@ def __init__(self):
                 optparse.make_option("--disable-p4sync", dest="disable_p4sync", action="store_true",
                                      help="Skip Perforce sync of p4/master after submit or shelve"),
                 optparse.make_option("--no-verify", dest="no_verify", action="store_true",
-                                     help="Bypass p4-pre-submit"),
+                                     help="Bypass p4-pre-submit and p4-changelist hooks"),
         ]
         self.description = """Submit changes from git to the perforce depot.\n
     The `p4-pre-submit` hook is executed if it exists and is executable. It
@@ -1593,6 +1593,28 @@ def __init__(self):
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
@@ -2104,6 +2126,10 @@ def applyCommit(self, id):
         submitted = False
 
         try:
+            # Allow the hook to edit the changelist text before presenting it
+            # to the user.
+            if not run_git_hook("p4-prepare-changelist", [fileName]):
+                return False
 
             if self.prepare_p4_only:
                 #
@@ -2143,6 +2169,12 @@ def applyCommit(self, id):
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
@@ -2180,6 +2212,7 @@ def applyCommit(self, id):
 
                 submitted = True
 
+                run_git_hook("p4-post-changelist")
         finally:
             # Revert changes if we skip this patch
             if not submitted or self.shelve:
-- 
gitgitgadget
