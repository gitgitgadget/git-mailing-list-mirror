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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579AFC35242
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 18:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A72A2168B
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 18:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6e09j4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbgBKS6O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 13:58:14 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53953 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730807AbgBKS6M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 13:58:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id s10so5021763wmh.3
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 10:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wwhNZbumD67NNG9L80tgBsexUQGiFgu2wBg2CR09VDg=;
        b=d6e09j4u016gHQnRg4Y4sGDzwaKeH83RXXJjjwPbRoIwuaL7XytFbfgu070JFp6Tan
         7IwP1kN+/Bu36vZswzDBlIR3ZGDt6mSKqQCW80gLlIp+NJ12ZbtHCkC6MZyzsda7pFms
         dgzlu2bKr7tO9CgYogdjb8NEM+821xYUrfTysrZFLG2LpB2ViTgxPJgwBOPhc0wUAA56
         8HUVuCe9j+fe3TSq/GyqsG4y5Tk3MkTVgJg0AqPGs4/zk3G7uKo7OiwxNbzM/grFveMY
         SGMvVfT55TlVx0WVeXCX/GQkk2K3mC0uwROenSaI9qozrGxgk6AGp0fwlLnqacMNmhBn
         8oUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wwhNZbumD67NNG9L80tgBsexUQGiFgu2wBg2CR09VDg=;
        b=shDrRCzIXKYpriWle4Ahn6Nzl87cxI2Q7mFjNPwXn7+thjfjyXzH/N7IFAY0dZCyvW
         pNZOxhSO48wjMzJe3rn10Pb3K2PAVpH79L6DXOQ2ZQLajL9LKz9gkrEEAVyN46sOz7DD
         g/erBU3i+5YoxjI2tnFSP4XFPoldyEsJEiSiWq/bp+y7RZ8YDHdA8jXC/VDvGXqCiSXb
         N2InZ535GOdcoc02YTI47gJ0Y/q05ASia1/2Pjm83v8hUO9t2tHirHaqifx9vvnolZXK
         iDpQ4igbC2Q7rapbCXDMwdLTLb9Ri6aESW2s+eR8PkTEmm/Xyr0jFuqJXrYeffqIAhuX
         V3Xw==
X-Gm-Message-State: APjAAAULLzRLDXj4TK9yCh+uFlLfgad6yB8lVRlF1boIFWrtTe+yvXsB
        xI4EY/0EoC3IkW25bTMFZrA09ZkE
X-Google-Smtp-Source: APXvYqzwsaP8REgFxSp/uFmXvaAYVhqXlUc+MhXkwhOLdwoHIaquQ4RvxVFlwMK5eSfNqGIoFWZWxg==
X-Received: by 2002:a05:600c:224a:: with SMTP id a10mr7204678wmm.143.1581447490109;
        Tue, 11 Feb 2020 10:58:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm6425398wrn.3.2020.02.11.10.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 10:58:09 -0800 (PST)
Message-Id: <5299f61e4e17938654d7013295e4f545b86e033a.1581447485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.698.v5.git.git.1581447484.gitgitgadget@gmail.com>
References: <pull.698.v4.git.git.1581372376.gitgitgadget@gmail.com>
        <pull.698.v5.git.git.1581447484.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Feb 2020 18:58:02 +0000
Subject: [PATCH v5 5/7] git-p4: restructure code in submit
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

In preparation for adding new hooks to the submit method of git-p4,
restructure the applyCommit function in the P4Submit class.  Make the
following changes:

* Move all the code after the definition of submitted = False into the
  Try-Finally block. This ensures that any error that occurs will
  properly recover.  This is not necessary with the current code because
  none of it should throw an exception, however the next set of changes
  will introduce exceptional code.

  Existing flow control can remain as defined - the if-block for
  prepare-p4-only sets the local variable "submitted" to True and exits
  the function. New early exits, leave submitted set to False so the
  Finally block will undo changes to the P4 workspace.

* Make the small usability change of adding an empty string to the
  print statements displayed to the user when the prepare-p4-only option
  is selected.  On Windows, the command print() may display a set of
  parentheses "()" to the user when the print() function is called with
  no parameters. By supplying an empty string, the intended blank line
  will print as expected.

* Fix a small bug when the submittedTemplate is edited by the user
  and all content in the file is removed. The existing code will throw
  an exception if the separateLine is not found in the file. Change this
  code to test for the separator line using a find() test first and only
  split on the separator if it is found.

* Additionally, add the new behavior that if the changelist file has
  been completely emptied that the Submit action for this changelist
  will be aborted.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 92 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 51 insertions(+), 41 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index c969d9235b..b6da7bcb02 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2102,47 +2102,47 @@ def applyCommit(self, id):
         tmpFile.write(submitTemplate)
         tmpFile.close()
 
-        if self.prepare_p4_only:
-            #
-            # Leave the p4 tree prepared, and the submit template around
-            # and let the user decide what to do next
-            #
-            print()
-            print("P4 workspace prepared for submission.")
-            print("To submit or revert, go to client workspace")
-            print("  " + self.clientPath)
-            print()
-            print("To submit, use \"p4 submit\" to write a new description,")
-            print("or \"p4 submit -i <%s\" to use the one prepared by" \
-                  " \"git p4\"." % fileName)
-            print("You can delete the file \"%s\" when finished." % fileName)
-
-            if self.preserveUser and p4User and not self.p4UserIsMe(p4User):
-                print("To preserve change ownership by user %s, you must\n" \
-                      "do \"p4 change -f <change>\" after submitting and\n" \
-                      "edit the User field.")
-            if pureRenameCopy:
-                print("After submitting, renamed files must be re-synced.")
-                print("Invoke \"p4 sync -f\" on each of these files:")
-                for f in pureRenameCopy:
-                    print("  " + f)
-
-            print()
-            print("To revert the changes, use \"p4 revert ...\", and delete")
-            print("the submit template file \"%s\"" % fileName)
-            if filesToAdd:
-                print("Since the commit adds new files, they must be deleted:")
-                for f in filesToAdd:
-                    print("  " + f)
-            print()
-            return True
-
-        #
-        # Let the user edit the change description, then submit it.
-        #
         submitted = False
 
         try:
+
+            if self.prepare_p4_only:
+                #
+                # Leave the p4 tree prepared, and the submit template around
+                # and let the user decide what to do next
+                #
+                submitted = True
+                print("")
+                print("P4 workspace prepared for submission.")
+                print("To submit or revert, go to client workspace")
+                print("  " + self.clientPath)
+                print("")
+                print("To submit, use \"p4 submit\" to write a new description,")
+                print("or \"p4 submit -i <%s\" to use the one prepared by" \
+                      " \"git p4\"." % fileName)
+                print("You can delete the file \"%s\" when finished." % fileName)
+
+                if self.preserveUser and p4User and not self.p4UserIsMe(p4User):
+                    print("To preserve change ownership by user %s, you must\n" \
+                          "do \"p4 change -f <change>\" after submitting and\n" \
+                          "edit the User field.")
+                if pureRenameCopy:
+                    print("After submitting, renamed files must be re-synced.")
+                    print("Invoke \"p4 sync -f\" on each of these files:")
+                    for f in pureRenameCopy:
+                        print("  " + f)
+
+                print("")
+                print("To revert the changes, use \"p4 revert ...\", and delete")
+                print("the submit template file \"%s\"" % fileName)
+                if filesToAdd:
+                    print("Since the commit adds new files, they must be deleted:")
+                    for f in filesToAdd:
+                        print("  " + f)
+                print("")
+                sys.stdout.flush()
+                return True
+
             if self.edit_template(fileName):
                 # read the edited message and submit
                 tmpFile = open(fileName, "rb")
@@ -2150,7 +2150,15 @@ def applyCommit(self, id):
                 tmpFile.close()
                 if self.isWindows:
                     message = message.replace("\r\n", "\n")
-                submitTemplate = message[:message.index(separatorLine)]
+                if message.find(separatorLine) <> -1:
+                    submitTemplate = message[:message.index(separatorLine)]
+                else:
+                    submitTemplate = message
+
+                if len(submitTemplate.strip()) == 0:
+                    print("Changelist is empty, aborting this changelist.")
+                    sys.stdout.flush()
+                    return False
 
                 if update_shelve:
                     p4_write_pipe(['shelve', '-r', '-i'], submitTemplate)
@@ -2174,19 +2182,21 @@ def applyCommit(self, id):
                 submitted = True
 
         finally:
-            # skip this patch
+            # Revert changes if we skip this patch
             if not submitted or self.shelve:
                 if self.shelve:
                     print ("Reverting shelved files.")
                 else:
                     print ("Submission cancelled, undoing p4 changes.")
+                sys.stdout.flush()
                 for f in editedFiles | filesToDelete:
                     p4_revert(f)
                 for f in filesToAdd:
                     p4_revert(f)
                     os.remove(f)
 
-        os.remove(fileName)
+            if not self.prepare_p4_only:
+                os.remove(fileName)
         return submitted
 
     # Export git tags as p4 labels. Create a p4 label and then tag
-- 
gitgitgadget

