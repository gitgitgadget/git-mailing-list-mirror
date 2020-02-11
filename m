Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5A6C3B187
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 18:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C062173E
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 18:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAxa6g/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbgBKS6O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 13:58:14 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:41997 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730831AbgBKS6M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 13:58:12 -0500
Received: by mail-wr1-f46.google.com with SMTP id k11so13776056wrd.9
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 10:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Zn8vN0yMoJ6nSN+rJsVUi7ptGiBWrWxgFvCn/ezqD+0=;
        b=kAxa6g/tcc+iA6U7y8utfHMOys9xw1/WtGB3UmfqmRLsqny+VfUa6l7JDmQJN1GSFd
         XhgGl6C6pJpgFdH5qsj065zCFuDmKoSUISso83UliikUwgL1zWGHboapOBuKIEEACzt6
         y2fA8dqyatRFIz/nJh1UiAckd2INk4bbPZb3gIU0rSHPqAn/ugtPxGiFcmxtuoPK5HG/
         h6UZ5HHg8XPGioJOAAL3ggoeJYAqVlvEg++VHALF9Cfay8F0q9h+qATA5nz6/UEpa8If
         1dz+zUs6TMiEnQGdlKm2kuUmwLwq6sPFp3D7BWr0QW8prZjthQcqldCUVMorm61r90iO
         s2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Zn8vN0yMoJ6nSN+rJsVUi7ptGiBWrWxgFvCn/ezqD+0=;
        b=Tn+tIAVwC3b4lW+xKSGhqwi2bI3qgK0FWr8LWdQYI+p7P687EQdJYnFOs4lxlvFRVd
         MLdWC/2VDgbCQxlJnxLn7/YVOjNFx6YzrX9hTT75VaE2rfCZJoQAgIDK4YyFkvX/UehF
         NxApR8yFzI6YK2/KY15R9vWKFoCD3yT2Y7iaEBI2M9uQBPX7ysoSKRta+c58XUjrXmLb
         xG4vOh3clemYhvVGkuUOSmh6nizD4qjWVbaYPAoMI+0GqbBsfTnAvOf0JftRW6ab8++P
         I5x1JxYe6nJc8yEa2++HGU7xJoBGfdUtHNXqyI0B4VNzbfWKM9AUEAoD+S6Cmu3A2WUR
         Oidg==
X-Gm-Message-State: APjAAAWtPWF5NGcXQnJJiAJLI2o51qnWxgTg741Ww/1k16cibAe5yHbt
        pafQyrgJWg2A+XdKRbrcf8n592BR
X-Google-Smtp-Source: APXvYqxZ5Jvu5596wORCc+NnpRi85PPlaOOAiAw7O+eX2ho/tGxtiFxuTSuAFDqypf5RLQwzG6Aalw==
X-Received: by 2002:adf:f886:: with SMTP id u6mr10074860wrp.409.1581447490916;
        Tue, 11 Feb 2020 10:58:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h18sm6578512wrv.78.2020.02.11.10.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 10:58:10 -0800 (PST)
Message-Id: <7a6d9fafceafae953d80513d62446b753de88768.1581447485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.698.v5.git.git.1581447484.gitgitgadget@gmail.com>
References: <pull.698.v4.git.git.1581372376.gitgitgadget@gmail.com>
        <pull.698.v5.git.git.1581447484.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Feb 2020 18:58:03 +0000
Subject: [PATCH v5 6/7] git-p4: add p4 submit hooks
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
index b6da7bcb02..f14c71c97d 100755
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

