Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 645591FC96
	for <e@80x24.org>; Mon, 28 Nov 2016 09:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932481AbcK1Jd6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 04:33:58 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38309 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932283AbcK1Jdz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 04:33:55 -0500
Received: by mail-wm0-f51.google.com with SMTP id f82so148641165wmf.1
        for <git@vger.kernel.org>; Mon, 28 Nov 2016 01:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eXWR/nq4OJWlt2Nl6w57iO9EgL7lsm8VM6U4Ux9fe1k=;
        b=RHCpACzljB/gDAgi+j+PCU+yschc7vcjPxTkD43FVst23/2EoGtv+iSzcT7Dpu37vW
         mEucrIi+pcnKj1pD7tBb8wK5BMYK4LzdCNZPbHH/j0gKFU04tnCRqdeqWFB7mFr/EDDx
         t/NZ7XE+OWDF3BZcFWi1kAZNQty/IZRSHkig8d/l6NYljLT5pVk2XhxKzcMzcrQ7Brz5
         hR1bmTKX5pXpRyLYQq1YNezYH9K4X/8N0d57GzQmDub3KW9hsRaAw5227T+1t9juQhEX
         M5+CVHDQZ49m5U6MBNZaQyzPs4WEYjwO6L8Y2Go+mmGGm8colnN+aKOxVu7S6tCexC/G
         cccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eXWR/nq4OJWlt2Nl6w57iO9EgL7lsm8VM6U4Ux9fe1k=;
        b=cLGvN77NwKdoVfMTTw6EN9+5WegxW4c0RhhNlUtJ9E88YI2Vj9Jd/LhM+AXciruz+P
         GXbPDymsT2eNmLypgaisi2o5yfBl6dd2b4lHDUTklG9KE9gviOzWpluqlLtXY4zx6q4c
         yZTGVqxIDmN3ig0xRET9D3Pk8tp71eNI1cc+jOrR9BS/me7YIS47py5u325Fk0dm7dFN
         7hl50XoZrL76ebbPpqYHphNR71P6+cNqlORITq0oL1H5Gl93sg3bIoK9uGeAIxY6p42r
         QLhJ0fTfqfZThT1ykk6Mx0tEeOaoJKVA8F0iD/XhlDxYHdK95UUiVR3LClkKmCfv+MYE
         3SFA==
X-Gm-Message-State: AKaTC03G/GRSXt9P8Njbjm9a5MsGrRn5AMJAxbwZ1jq+Jda4xAqne8nAO/20vn+sDkqQEg==
X-Received: by 10.28.49.3 with SMTP id x3mr18262582wmx.121.1480325634268;
        Mon, 28 Nov 2016 01:33:54 -0800 (PST)
Received: from kursancew-t5810.corp.roku ([81.145.207.254])
        by smtp.gmail.com with ESMTPSA id d64sm27875797wmh.3.2016.11.28.01.33.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2016 01:33:53 -0800 (PST)
From:   Vinicius Kursancew <viniciusalexandre@gmail.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Vinicius Kursancew <viniciusalexandre@gmail.com>
Subject: [PATCH] git-p4: allow submit to create shelved changelists.
Date:   Mon, 28 Nov 2016 09:33:18 +0000
Message-Id: <1480325598-12344-2-git-send-email-viniciusalexandre@gmail.com>
X-Mailer: git-send-email 2.6.0-rc1
In-Reply-To: <1480325598-12344-1-git-send-email-viniciusalexandre@gmail.com>
References: <1480325598-12344-1-git-send-email-viniciusalexandre@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a --shelve command line argument which invokes p4 shelve instead
of submitting changes. After shelving the changes are reverted from the
p4 workspace.

Signed-off-by: Vinicius Kursancew <viniciusalexandre@gmail.com>
---
 Documentation/git-p4.txt |  5 +++++
 git-p4.py                | 36 ++++++++++++++++++++++--------------
 t/t9807-git-p4-submit.sh | 31 +++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index c83aaf3..1bbf43d 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -303,6 +303,11 @@ These options can be used to modify 'git p4 submit' behavior.
 	submit manually or revert.  This option always stops after the
 	first (oldest) commit.  Git tags are not exported to p4.
 
+--shelve::
+	Instead of submitting create a series of shelved changelists.
+	After creating each shelve, the relevant files are reverted/deleted.
+	If you have multiple commits pending multiple shelves will be created.
+
 --conflict=(ask|skip|quit)::
 	Conflicts can occur when applying a commit to p4.  When this
 	happens, the default behavior ("ask") is to prompt whether to
diff --git a/git-p4.py b/git-p4.py
index fd5ca52..0c4f2af 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1289,6 +1289,9 @@ class P4Submit(Command, P4UserMap):
                 optparse.make_option("--conflict", dest="conflict_behavior",
                                      choices=self.conflict_behavior_choices),
                 optparse.make_option("--branch", dest="branch"),
+                optparse.make_option("--shelve", dest="shelve", action="store_true",
+                                     help="Shelve instead of submit. Shelved files are reverted, "
+                                     "restoring the workspace to the state before the shelve"),
         ]
         self.description = "Submit changes from git to the perforce depot."
         self.usage += " [name of git branch to submit into perforce depot]"
@@ -1296,6 +1299,7 @@ class P4Submit(Command, P4UserMap):
         self.detectRenames = False
         self.preserveUser = gitConfigBool("git-p4.preserveUser")
         self.dry_run = False
+        self.shelve = False
         self.prepare_p4_only = False
         self.conflict_behavior = None
         self.isWindows = (platform.system() == "Windows")
@@ -1785,7 +1789,14 @@ class P4Submit(Command, P4UserMap):
                 if self.isWindows:
                     message = message.replace("\r\n", "\n")
                 submitTemplate = message[:message.index(separatorLine)]
-                p4_write_pipe(['submit', '-i'], submitTemplate)
+                if self.shelve:
+                    p4_write_pipe(['shelve', '-i'], submitTemplate)
+                else:
+                    p4_write_pipe(['submit', '-i'], submitTemplate)
+                    # The rename/copy happened by applying a patch that created a
+                    # new file.  This leaves it writable, which confuses p4.
+                    for f in pureRenameCopy:
+                        p4_sync(f, "-f")
 
                 if self.preserveUser:
                     if p4User:
@@ -1795,23 +1806,20 @@ class P4Submit(Command, P4UserMap):
                         changelist = self.lastP4Changelist()
                         self.modifyChangelistUser(changelist, p4User)
 
-                # The rename/copy happened by applying a patch that created a
-                # new file.  This leaves it writable, which confuses p4.
-                for f in pureRenameCopy:
-                    p4_sync(f, "-f")
                 submitted = True
 
         finally:
             # skip this patch
-            if not submitted:
-                print "Submission cancelled, undoing p4 changes."
-                for f in editedFiles:
+            if not submitted or self.shelve:
+                if self.shelve:
+                    print ("Reverting shelved files.")
+                else:
+                    print ("Submission cancelled, undoing p4 changes.")
+                for f in editedFiles | filesToDelete:
                     p4_revert(f)
                 for f in filesToAdd:
                     p4_revert(f)
                     os.remove(f)
-                for f in filesToDelete:
-                    p4_revert(f)
 
         os.remove(fileName)
         return submitted
@@ -2067,13 +2075,13 @@ class P4Submit(Command, P4UserMap):
                         break
 
         chdir(self.oldWorkingDirectory)
-
+        shelved_applied = "shelved" if self.shelve else "applied"
         if self.dry_run:
             pass
         elif self.prepare_p4_only:
             pass
         elif len(commits) == len(applied):
-            print "All commits applied!"
+            print ("All commits {0}!".format(shelved_applied))
 
             sync = P4Sync()
             if self.branch:
@@ -2085,9 +2093,9 @@ class P4Submit(Command, P4UserMap):
 
         else:
             if len(applied) == 0:
-                print "No commits applied."
+                print ("No commits {0}.".format(shelved_applied))
             else:
-                print "Applied only the commits marked with '*':"
+                print ("{0} only the commits marked with '*':".format(shelved_applied.capitalize()))
                 for c in commits:
                     if c in applied:
                         star = "*"
diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index 5931528..42a5fad 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -413,6 +413,37 @@ test_expect_success 'submit --prepare-p4-only' '
 	)
 '
 
+test_expect_success 'submit --shelve' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$cli" &&
+		p4 revert ... &&
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		test_commit "shelveme1" &&
+		git p4 submit --origin=HEAD^ &&
+
+		echo 654321 >shelveme2.t &&
+		echo 123456 >>shelveme1.t &&
+		git add shelveme* &&
+		git commit -m"shelvetest" &&
+		git p4 submit --shelve --origin=HEAD^ &&
+
+		test_path_is_file shelveme1.t &&
+		test_path_is_file shelveme2.t
+	) &&
+	(
+		cd "$cli" &&
+		change=$(p4 -G changes -s shelved -m 1 //depot/... | \
+			 marshal_dump change) &&
+		p4 describe -S $change | grep shelveme2 &&
+		p4 describe -S $change | grep 123456 &&
+		test_path_is_file shelveme1.t &&
+		test_path_is_missing shelveme2.t
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
2.6.0-rc1

