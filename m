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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F812C33CAC
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 15:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C74E20838
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 15:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tG8lbu4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgBFPP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:15:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51956 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbgBFPP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 10:15:56 -0500
Received: by mail-wm1-f67.google.com with SMTP id t23so400797wmi.1
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 07:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DbwiWqhX18A6vIt3g7hAwB5VHXIjGLnr3YXxuKapvzk=;
        b=tG8lbu4JhFPNYy5rq7XElfx+iIm4YXYBnOVsUxas8UDiripWzDqzhlYW1nJ1OTobra
         oK5Mcc1D8ICfaK/LUjJudHweTTDzLbVKiCt5qRfVLBZL93/qhmpGRgWXbhV/uRDdO8n7
         04KwzwuIlg0qmEod4B4xHYdAC/+R5V37hoS1//KBlT1GlXZbNLcJDU0UgO6Cv7PhbskB
         mfavgTMmyXRZAwg8pF7l8FsdRghje8xS0En8zWjFaLlQJdXDFvg5Ju77/1BE6HCX43ei
         FnZB5XWm3h4NioOIj1x/NuBqDLR8xrVE2+Fj1FU0ToGzQOh4/yIKYFNBULB8eGVq2BNa
         yTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DbwiWqhX18A6vIt3g7hAwB5VHXIjGLnr3YXxuKapvzk=;
        b=XWJ3NHgiMm10N7uDz//blTi4D8f23I35KfcstG6MZyOuJXY5cfrRWZbBH8q54aHmw/
         ynlgIDNiYpKRmLlY0EWojzS6db3VWFawYFIO/ohV5VYP5dpLyQ+IcNt3ukgPjJCH32wR
         0qWCPTG0Sm77FrhiRuUXS7bvRs3xgb8jdLYfb/4lvpCMO+AzEhkg8u5bP9tVqPbL/2md
         LGqZva+jyaHc+fq9AKj2t4queZnz4FaAYZXgdeUX5xqnNGZsXLRVsfDmUalpGqQfsSAC
         mVx4Z8ELDFinEkNq8UOhpGWr3h/fgA9adqBRmNfNXEId8y4cduUlwy5Dcs7K+eVxTBPN
         KgDA==
X-Gm-Message-State: APjAAAVgN5KmfuP2bObJlyjfjBhcLx/hTbm4pOQZWfpvyf038fuTpPs6
        dpAjowM0RgQJchH67UfKFBkGCvea
X-Google-Smtp-Source: APXvYqxqNJCMC7sA487dPjlmqVRMTz6N4agvG47MQEK8ghDCuICVi8EViePBvUmFk9ZF0UxJKwunvg==
X-Received: by 2002:a7b:cbcf:: with SMTP id n15mr5070527wmi.21.1581002153033;
        Thu, 06 Feb 2020 07:15:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f127sm4145141wma.4.2020.02.06.07.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 07:15:52 -0800 (PST)
Message-Id: <b538ad08b6f931cab27f084364669583743e4839.1581002149.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.698.v3.git.git.1581002149.gitgitgadget@gmail.com>
References: <pull.698.v2.git.git.1580507895.gitgitgadget@gmail.com>
        <pull.698.v3.git.git.1581002149.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Feb 2020 15:15:46 +0000
Subject: [PATCH v3 3/5] git-p4: add --no-verify option
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

Add new command line option --no-verify:

Add a new command line option "--no-verify" to the Submit command of
git-p4.py.  This option will function in the spirit of the existing
--no-verify command line option found in git commit. It will cause the
P4 Submit function to ignore the existing p4-pre-submit.

Change the execution of the existing trigger p4-pre-submit to honor the
--no-verify option. Before exiting on failure of this hook, display
text to the user explaining which hook has failed and the impact
of using the --no-verify option.

Change the call of the p4-pre-submit hook to use the new run_git_hook
function. This is in preparation of additional hooks to be added.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 Documentation/git-p4.txt   | 10 ++++++++--
 Documentation/githooks.txt |  5 ++++-
 git-p4.py                  | 30 +++++++++++++++++++-----------
 3 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 3494a1db3e..362b50eb21 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -374,14 +374,20 @@ These options can be used to modify 'git p4 submit' behavior.
     been submitted. Implies --disable-rebase. Can also be set with
     git-p4.disableP4Sync. Sync with origin/master still goes ahead if possible.
 
-Hook for submit
-~~~~~~~~~~~~~~~
+Hooks for submit
+----------------
+
+p4-pre-submit
+~~~~~~~~~~~~~
+
 The `p4-pre-submit` hook is executed if it exists and is executable.
 The hook takes no parameters and nothing from standard input. Exiting with
 non-zero status from this script prevents `git-p4 submit` from launching.
+It can be bypassed with the `--no-verify` command line option.
 
 One usage scenario is to run unit tests in the hook.
 
+
 Rebase options
 ~~~~~~~~~~~~~~
 These options can be used to modify 'git p4 rebase' behavior.
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 50365f2914..8cf6b08b55 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -520,7 +520,10 @@ p4-pre-submit
 
 This hook is invoked by `git-p4 submit`. It takes no parameters and nothing
 from standard input. Exiting with non-zero status from this script prevent
-`git-p4 submit` from launching. Run `git-p4 submit --help` for details.
+`git-p4 submit` from launching. It can be bypassed with the `--no-verify`
+command line option. Run `git-p4 submit --help` for details.
+
+
 
 post-index-change
 ~~~~~~~~~~~~~~~~~
diff --git a/git-p4.py b/git-p4.py
index d4c39f112b..b377484464 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1583,13 +1583,17 @@ def __init__(self):
                                      "work from a local git branch that is not master"),
                 optparse.make_option("--disable-p4sync", dest="disable_p4sync", action="store_true",
                                      help="Skip Perforce sync of p4/master after submit or shelve"),
+                optparse.make_option("--no-verify", dest="no_verify", action="store_true",
+                                     help="Bypass p4-pre-submit"),
         ]
         self.description = """Submit changes from git to the perforce depot.\n
-    The `p4-pre-submit` hook is executed if it exists and is executable.
-    The hook takes no parameters and nothing from standard input. Exiting with
-    non-zero status from this script prevents `git-p4 submit` from launching.
+    The `p4-pre-submit` hook is executed if it exists and is executable. It
+    can be bypassed with the `--no-verify` command line option. The hook takes
+    no parameters and nothing from standard input. Exiting with a non-zero status
+    from this script prevents `git-p4 submit` from launching.
 
-    One usage scenario is to run unit tests in the hook."""
+    One usage scenario is to run unit tests in the hook.
+    """
 
         self.usage += " [name of git branch to submit into perforce depot]"
         self.origin = ""
@@ -1607,6 +1611,7 @@ def __init__(self):
         self.exportLabels = False
         self.p4HasMoveCommand = p4_has_move_command()
         self.branch = None
+        self.no_verify = False
 
         if gitConfig('git-p4.largeFileSystem'):
             die("Large file system not supported for git-p4 submit command. Please remove it from config.")
@@ -1993,6 +1998,9 @@ def applyCommit(self, id):
         applyPatchCmd = patchcmd + "--check --apply -"
         patch_succeeded = True
 
+        if verbose:
+            print("TryPatch: %s" % tryPatchCmd)
+
         if os.system(tryPatchCmd) != 0:
             fixed_rcs_keywords = False
             patch_succeeded = False
@@ -2032,6 +2040,7 @@ def applyCommit(self, id):
                 print("Retrying the patch with RCS keywords cleaned up")
                 if os.system(tryPatchCmd) == 0:
                     patch_succeeded = True
+                    print("Patch succeesed this time")
 
         if not patch_succeeded:
             for f in editedFiles:
@@ -2400,13 +2409,12 @@ def run(self, args):
             sys.exit("number of commits (%d) must match number of shelved changelist (%d)" %
                      (len(commits), num_shelves))
 
-        hooks_path = gitConfig("core.hooksPath")
-        if len(hooks_path) <= 0:
-            hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
-
-        hook_file = os.path.join(hooks_path, "p4-pre-submit")
-        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file]) != 0:
-            sys.exit(1)
+        if not self.no_verify:
+            if not run_git_hook("p4-pre-submit"):
+                print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nYou can skip " \
+                    "this pre-submission check by adding\nthe command line option '--no-verify', " \
+                    "however,\nthis will also skip the p4-changelist hook as well.")
+                sys.exit(1)
 
         #
         # Apply the commits, one at a time.  On failure, ask if should
-- 
gitgitgadget

