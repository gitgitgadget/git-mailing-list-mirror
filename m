Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2B8C3B186
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 22:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6741C2072C
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 22:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lguG9CxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgBJWG2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:06:28 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:35532 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbgBJWGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 17:06:25 -0500
Received: by mail-wm1-f49.google.com with SMTP id b17so1069809wmb.0
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 14:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wbzRpmSO8WD1vUTJEu5oNDVRZOAMUvxUxnlkeLWKGkI=;
        b=lguG9CxIHO9qjRDFju4JJUBRiyJYAlkPcMm2R2FOmXY+akzyLxElqIBQUiqFolj6W4
         JKDbvqOesi6B3+N8qqrGSCqTH+ckhkEfY/hHzgyhCj44vHDOhBpLtzyNnSLzRWsPTrC4
         jj1qVGUUApxftU0M5bGWhTu332KbiumZMK+E9ffos/I4A5KXCqzviZ6cvn49ikH41E4w
         UNR37vrGijlhtSq0OJHxiQDA4XyGn4AbsP7sEpr3hVaBgbZf3ZW3CfRXbDlPsP3HDQxm
         5fj4KZ5lRfCbgrzwIF2Rq21HaeJ82GoJOEIoX0h0Fc9pJYpMWpTPxDmKeCcPX2xdag3b
         rdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wbzRpmSO8WD1vUTJEu5oNDVRZOAMUvxUxnlkeLWKGkI=;
        b=ZXg+px/mT53VxY22lo2dL6y0BP9CDxKl8Ic0ZVn566/eHzYbXFYQf0xGI+nmhRm+xd
         6uhqxwsvbo547VnVu38L91ldl5ZV9oF+S8CgtBXX+SJ2FFTNMnwYX0PgBFE69uEQJ8jV
         AfuctmOQSxa9XPSqv0nR2Bz6EtqMH50WGFclQavy9Fs9U+UL+fDbtjxj0IGEXPCgGKUG
         xB2JSB57qB0CmhMiXZ+T9q9cLG9WrRhCe7Xhp3Lg3W/vTzfw5m6pPEqr1ijpTeIOM/Pn
         gIIiPcIoWLMHu9gBZfGqVpJ9cLNoD0YEn1R7w2V9tza2D3iM+9ebtoK2R5Het6TptK1o
         buRw==
X-Gm-Message-State: APjAAAVCZ3df/VN6sLSdEDOxjWEo2lY03qxn7DngYHHsg9+6dpExv48w
        TXwROqnoscNEXiJlZ8MB4c5wIfVg
X-Google-Smtp-Source: APXvYqyPILDCxTW6a7Y+IVJwMO8L19s9SwsXkVbNSk5OdXJqpBYwRKMcf0hdVWFSXo4DZmDe4SDPUw==
X-Received: by 2002:a1c:6755:: with SMTP id b82mr1162545wmc.126.1581372382530;
        Mon, 10 Feb 2020 14:06:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v8sm2554239wrw.2.2020.02.10.14.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 14:06:22 -0800 (PST)
Message-Id: <ceb2b0aff65bad9ca5a7aed29be20b3a51b2cf54.1581372376.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.698.v4.git.git.1581372376.gitgitgadget@gmail.com>
References: <pull.698.v3.git.git.1581002149.gitgitgadget@gmail.com>
        <pull.698.v4.git.git.1581372376.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 22:06:15 +0000
Subject: [PATCH v4 5/6] git-p4: add p4 submit hooks
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
index 0224f2e032..4b77879679 100755
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

