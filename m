Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 110A51F406
	for <e@80x24.org>; Thu, 21 Dec 2017 11:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbdLULLz (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 06:11:55 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45285 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751702AbdLULLx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 06:11:53 -0500
Received: by mail-pf0-f194.google.com with SMTP id u19so13806452pfa.12
        for <git@vger.kernel.org>; Thu, 21 Dec 2017 03:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pbaag6zIhh/HuI3sTiskOJ9y1Qak78mXMx7JpVJ8m6w=;
        b=Y7advSYc2DmxObOzajgTR7T2g3Tf7T0b5+WxMkuz6dJn/OMj+vkvEVZSLYhEEnGvwr
         u6GZ3z8WiF36tCw9FHInphuzIPWOxg7V4o4VGk4YiuOBWGXtr4QY4+fGfxABYscoHldx
         oAm9XmgNbtYRTOIQX7mR5scOV5Ss1ZhEJfJRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pbaag6zIhh/HuI3sTiskOJ9y1Qak78mXMx7JpVJ8m6w=;
        b=aDpJXB62rdtdlD3fH9JY++Q6lwPWYWXfPuK4dohE8+uD03+ok81Cwn1HyxU6XYKEe1
         yiMYsVh21wByZIiqeiM8Bt/36h1Jg3kAtM+IpDkMYRYGCaUUU4vJuBozjz62A6v3iKEU
         0LApspjMBlwaIoxvHPZBbHZHp8gTMci2l9LujFAE11xlIuFRwud7ZqetJq1CSihOMFJ0
         ig7qfncKdIgPv/KgqUguAlpgEho893RFcbcSQm8QTUVRR1zAL/UK9eict8FU+bQeNGhG
         TPPNRSbLr5qzRMJsCUhiwkRPsSNq6GSjqUy3xm6OPeuX02P7yNb7YjPdDMwBao99goKO
         NGPw==
X-Gm-Message-State: AKGB3mLNBnX5g8/1kkLNWUTwlf0eeKt+5dvdBsxCksd0Vi3IMTg8wVco
        apSawdRz4yyvXuryyrwS1juzyse1
X-Google-Smtp-Source: ACJfBouScq13F5AwsFkLI+mz8jVvwIGfAf5Z4UHApTwIcXXKtkyYJUoWphIaSnuFggUf73nnF9U4bQ==
X-Received: by 10.99.67.195 with SMTP id q186mr9304140pga.163.1513854712053;
        Thu, 21 Dec 2017 03:11:52 -0800 (PST)
Received: from ldiamand-t3610.corp.roku ([81.145.207.254])
        by smtp.gmail.com with ESMTPSA id n3sm33705912pgq.30.2017.12.21.03.11.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 21 Dec 2017 03:11:51 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     viniciusalexandre@gmail.com, miguel.torroja@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>,
        gvanburgh@bloomberg.net, Luke Diamand <luke@diamand.org>
Subject: [PATCH 1/1] git-p4: update multiple shelved change lists
Date:   Thu, 21 Dec 2017 11:06:14 +0000
Message-Id: <20171221110614.29300-2-luke@diamand.org>
X-Mailer: git-send-email 2.15.0.276.g89ea799.dirty
In-Reply-To: <20171221110614.29300-1-luke@diamand.org>
References: <20171221110614.29300-1-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--update-shelve can now be specified multiple times on the
command-line, to update multiple shelved changelists in a single
submit.

This then means that a git patch series can be mirrored to a
sequence of shelved changelists, and (relatively easily) kept in
sync as changes are made in git.

Note that Perforce does not really support overlapping shelved
changelists where one change touches the files modified by
another. Trying to do this will result in merge conflicts.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 Documentation/git-p4.txt |  8 +++++++-
 git-p4.py                | 41 ++++++++++++++++++++++++++---------------
 t/t9807-git-p4-submit.sh | 24 ++++++++++++++----------
 3 files changed, 47 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 7436c64a9..d8c8f11c9 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -157,6 +157,12 @@ The p4 changes will be created as the user invoking 'git p4 submit'. The
 according to the author of the Git commit.  This option requires admin
 privileges in p4, which can be granted using 'p4 protect'.
 
+To shelve changes instead of submitting, use `--shelve` and `--update-shelve`:
+
+----
+$ git p4 submit --shelve
+$ git p4 submit --update-shelve 1234 --update-shelve 2345
+----
 
 OPTIONS
 -------
@@ -310,7 +316,7 @@ These options can be used to modify 'git p4 submit' behavior.
 
 --update-shelve CHANGELIST::
 	Update an existing shelved changelist with this commit. Implies
-	--shelve.
+	--shelve. Repeat for multiple shelved changelists.
 
 --conflict=(ask|skip|quit)::
 	Conflicts can occur when applying a commit to p4.  When this
diff --git a/git-p4.py b/git-p4.py
index 76859b453..7bb9cadc6 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1178,6 +1178,12 @@ class Command:
         self.needsGit = True
         self.verbose = False
 
+    # This is required for the "append" cloneExclude action
+    def ensure_value(self, attr, value):
+        if not hasattr(self, attr) or getattr(self, attr) is None:
+            setattr(self, attr, value)
+        return getattr(self, attr)
+
 class P4UserMap:
     def __init__(self):
         self.userMapFromPerforceServer = False
@@ -1343,9 +1349,10 @@ class P4Submit(Command, P4UserMap):
                 optparse.make_option("--shelve", dest="shelve", action="store_true",
                                      help="Shelve instead of submit. Shelved files are reverted, "
                                      "restoring the workspace to the state before the shelve"),
-                optparse.make_option("--update-shelve", dest="update_shelve", action="store", type="int",
+                optparse.make_option("--update-shelve", dest="update_shelve", action="append", type="int",
                                      metavar="CHANGELIST",
-                                     help="update an existing shelved changelist, implies --shelve")
+                                     help="update an existing shelved changelist, implies --shelve, "
+                                           "repeat in-order for multiple shelved changelists")
         ]
         self.description = "Submit changes from git to the perforce depot."
         self.usage += " [name of git branch to submit into perforce depot]"
@@ -1354,7 +1361,7 @@ class P4Submit(Command, P4UserMap):
         self.preserveUser = gitConfigBool("git-p4.preserveUser")
         self.dry_run = False
         self.shelve = False
-        self.update_shelve = None
+        self.update_shelve = list()
         self.prepare_p4_only = False
         self.conflict_behavior = None
         self.isWindows = (platform.system() == "Windows")
@@ -1809,9 +1816,10 @@ class P4Submit(Command, P4UserMap):
             mode = filesToChangeExecBit[f]
             setP4ExecBit(f, mode)
 
-        if self.update_shelve:
-            print("all_files = %s" % str(all_files))
-            p4_reopen_in_change(self.update_shelve, all_files)
+        update_shelve = 0
+        if len(self.update_shelve) > 0:
+            update_shelve = self.update_shelve.pop(0)
+            p4_reopen_in_change(update_shelve, all_files)
 
         #
         # Build p4 change description, starting with the contents
@@ -1821,7 +1829,7 @@ class P4Submit(Command, P4UserMap):
         logMessage = logMessage.strip()
         (logMessage, jobs) = self.separate_jobs_from_description(logMessage)
 
-        template = self.prepareSubmitTemplate(self.update_shelve)
+        template = self.prepareSubmitTemplate(update_shelve)
         submitTemplate = self.prepareLogMessage(template, logMessage, jobs)
 
         if self.preserveUser:
@@ -1894,7 +1902,7 @@ class P4Submit(Command, P4UserMap):
                     message = message.replace("\r\n", "\n")
                 submitTemplate = message[:message.index(separatorLine)]
 
-                if self.update_shelve:
+                if update_shelve:
                     p4_write_pipe(['shelve', '-r', '-i'], submitTemplate)
                 elif self.shelve:
                     p4_write_pipe(['shelve', '-i'], submitTemplate)
@@ -2012,6 +2020,10 @@ class P4Submit(Command, P4UserMap):
         else:
             return False
 
+        for i in self.update_shelve:
+            if i <= 0:
+                sys.exit("invalid changelist %d" % i)
+
         if self.master:
             allowSubmit = gitConfig("git-p4.allowSubmit")
             if len(allowSubmit) > 0 and not self.master in allowSubmit.split(","):
@@ -2022,7 +2034,7 @@ class P4Submit(Command, P4UserMap):
         if len(self.origin) == 0:
             self.origin = upstream
 
-        if self.update_shelve:
+        if len(self.update_shelve) > 0:
             self.shelve = True
 
         if self.preserveUser:
@@ -2134,6 +2146,11 @@ class P4Submit(Command, P4UserMap):
         if gitConfigBool("git-p4.detectCopiesHarder"):
             self.diffOpts += " --find-copies-harder"
 
+        num_shelves = len(self.update_shelve)
+        if num_shelves > 0 and num_shelves != len(commits):
+            sys.exit("number of commits (%d) must match number of shelved changelist (%d)" %
+                     (len(commits), num_shelves))
+
         #
         # Apply the commits, one at a time.  On failure, ask if should
         # continue to try the rest of the patches, or quit.
@@ -2404,12 +2421,6 @@ class P4Sync(Command, P4UserMap):
         if gitConfig("git-p4.syncFromOrigin") == "false":
             self.syncWithOrigin = False
 
-    # This is required for the "append" cloneExclude action
-    def ensure_value(self, attr, value):
-        if not hasattr(self, attr) or getattr(self, attr) is None:
-            setattr(self, attr, value)
-        return getattr(self, attr)
-
     # Force a checkpoint in fast-import and wait for it to finish
     def checkpoint(self):
         self.gitStream.write("checkpoint\n\n")
diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index 3457d5db6..71cae2874 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -460,7 +460,13 @@ test_expect_success 'submit --shelve' '
 	)
 '
 
-# Update an existing shelved changelist
+make_shelved_cl() {
+	test_commit "$1" >/dev/null &&
+	git p4 submit --origin HEAD^ --shelve >/dev/null &&
+	p4 -G changes -s shelved -m 1 | marshal_dump change
+}
+
+# Update existing shelved changelists
 
 test_expect_success 'submit --update-shelve' '
 	test_when_finished cleanup_git &&
@@ -470,21 +476,19 @@ test_expect_success 'submit --update-shelve' '
 		p4 revert ... &&
 		cd "$git" &&
 		git config git-p4.skipSubmitEdit true &&
-		test_commit "test-update-shelved-change" &&
-		git p4 submit --origin=HEAD^ --shelve &&
+		shelved_cl0=$(make_shelved_cl "shelved-change-0") &&
+		echo shelved_cl0=$shelved_cl0 &&
+		shelved_cl1=$(make_shelved_cl "shelved-change-1") &&
 
-		shelf_cl=$(p4 -G changes -s shelved -m 1 |\
-			marshal_dump change) &&
-		test -n $shelf_cl &&
-		echo "updating shelved change list $shelf_cl" &&
+		echo "updating shelved change lists $shelved_cl0 and $shelved_cl1" &&
 
 		echo "updated-line" >>shelf.t &&
 		echo added-file.t >added-file.t &&
 		git add shelf.t added-file.t &&
-		git rm -f test-update-shelved-change.t &&
+		git rm -f shelved-change-1.t &&
 		git commit --amend -C HEAD &&
 		git show --stat HEAD &&
-		git p4 submit -v --origin HEAD^ --update-shelve $shelf_cl &&
+		git p4 submit -v --origin HEAD~2 --update-shelve $shelved_cl0 --update-shelve $shelved_cl1 &&
 		echo "done git p4 submit"
 	) &&
 	(
@@ -494,7 +498,7 @@ test_expect_success 'submit --update-shelve' '
 		p4 unshelve -c $change -s $change &&
 		grep -q updated-line shelf.t &&
 		p4 describe -S $change | grep added-file.t &&
-		test_path_is_missing test-update-shelved-change.t
+		test_path_is_missing shelved-change-1.t
 	)
 '
 
-- 
2.15.0.276.g89ea799.dirty

