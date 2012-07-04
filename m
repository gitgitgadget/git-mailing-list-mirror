From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 1/3] git p4: remove unused P4Submit interactive setting
Date: Wed,  4 Jul 2012 09:34:18 -0400
Message-ID: <1341408860-26965-2-git-send-email-pw@padd.com>
References: <1341408860-26965-1-git-send-email-pw@padd.com>
Cc: Michael Horowitz <mike@horowitz.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 04 15:34:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmPjG-00046U-9k
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 15:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588Ab2GDNep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jul 2012 09:34:45 -0400
Received: from honk.padd.com ([74.3.171.149]:54380 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752140Ab2GDNep (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2012 09:34:45 -0400
Received: from arf.padd.com (unknown [50.55.159.91])
	by honk.padd.com (Postfix) with ESMTPSA id CDD631FED;
	Wed,  4 Jul 2012 06:34:43 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 58A6D5A90B; Wed,  4 Jul 2012 09:34:40 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.125.g4a65fea
In-Reply-To: <1341408860-26965-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201005>

The code is unused.  Delete.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 144 ++++++++++++++++++++++++++++----------------------------------
 1 file changed, 66 insertions(+), 78 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index f895a24..542c20a 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -844,7 +844,6 @@ class P4Submit(Command, P4UserMap):
         ]
         self.description = "Submit changes from git to the perforce depot."
         self.usage += " [name of git branch to submit into perforce depot]"
-        self.interactive = True
         self.origin = ""
         self.detectRenames = False
         self.preserveUser = gitConfig("git-p4.preserveUser").lower() == "true"
@@ -1209,86 +1208,77 @@ class P4Submit(Command, P4UserMap):
 
         template = self.prepareSubmitTemplate()
 
-        if self.interactive:
-            submitTemplate = self.prepareLogMessage(template, logMessage)
+        submitTemplate = self.prepareLogMessage(template, logMessage)
 
-            if self.preserveUser:
-               submitTemplate = submitTemplate + ("\n######## Actual user %s, modified after commit\n" % p4User)
-
-            if os.environ.has_key("P4DIFF"):
-                del(os.environ["P4DIFF"])
-            diff = ""
-            for editedFile in editedFiles:
-                diff += p4_read_pipe(['diff', '-du',
-                                      wildcard_encode(editedFile)])
-
-            newdiff = ""
-            for newFile in filesToAdd:
-                newdiff += "==== new file ====\n"
-                newdiff += "--- /dev/null\n"
-                newdiff += "+++ %s\n" % newFile
-                f = open(newFile, "r")
-                for line in f.readlines():
-                    newdiff += "+" + line
-                f.close()
-
-            if self.checkAuthorship and not self.p4UserIsMe(p4User):
-                submitTemplate += "######## git author %s does not match your p4 account.\n" % gitEmail
-                submitTemplate += "######## Use option --preserve-user to modify authorship.\n"
-                submitTemplate += "######## Variable git-p4.skipUserNameCheck hides this message.\n"
-
-            separatorLine = "######## everything below this line is just the diff #######\n"
-
-            (handle, fileName) = tempfile.mkstemp()
-            tmpFile = os.fdopen(handle, "w+")
-            if self.isWindows:
-                submitTemplate = submitTemplate.replace("\n", "\r\n")
-                separatorLine = separatorLine.replace("\n", "\r\n")
-                newdiff = newdiff.replace("\n", "\r\n")
-            tmpFile.write(submitTemplate + separatorLine + diff + newdiff)
+        if self.preserveUser:
+           submitTemplate = submitTemplate + ("\n######## Actual user %s, modified after commit\n" % p4User)
+
+        if os.environ.has_key("P4DIFF"):
+            del(os.environ["P4DIFF"])
+        diff = ""
+        for editedFile in editedFiles:
+            diff += p4_read_pipe(['diff', '-du',
+                                  wildcard_encode(editedFile)])
+
+        newdiff = ""
+        for newFile in filesToAdd:
+            newdiff += "==== new file ====\n"
+            newdiff += "--- /dev/null\n"
+            newdiff += "+++ %s\n" % newFile
+            f = open(newFile, "r")
+            for line in f.readlines():
+                newdiff += "+" + line
+            f.close()
+
+        if self.checkAuthorship and not self.p4UserIsMe(p4User):
+            submitTemplate += "######## git author %s does not match your p4 account.\n" % gitEmail
+            submitTemplate += "######## Use option --preserve-user to modify authorship.\n"
+            submitTemplate += "######## Variable git-p4.skipUserNameCheck hides this message.\n"
+
+        separatorLine = "######## everything below this line is just the diff #######\n"
+
+        (handle, fileName) = tempfile.mkstemp()
+        tmpFile = os.fdopen(handle, "w+")
+        if self.isWindows:
+            submitTemplate = submitTemplate.replace("\n", "\r\n")
+            separatorLine = separatorLine.replace("\n", "\r\n")
+            newdiff = newdiff.replace("\n", "\r\n")
+        tmpFile.write(submitTemplate + separatorLine + diff + newdiff)
+        tmpFile.close()
+
+        if self.edit_template(fileName):
+            # read the edited message and submit
+            tmpFile = open(fileName, "rb")
+            message = tmpFile.read()
             tmpFile.close()
+            submitTemplate = message[:message.index(separatorLine)]
+            if self.isWindows:
+                submitTemplate = submitTemplate.replace("\r\n", "\n")
+            p4_write_pipe(['submit', '-i'], submitTemplate)
 
-            if self.edit_template(fileName):
-                # read the edited message and submit
-                tmpFile = open(fileName, "rb")
-                message = tmpFile.read()
-                tmpFile.close()
-                submitTemplate = message[:message.index(separatorLine)]
-                if self.isWindows:
-                    submitTemplate = submitTemplate.replace("\r\n", "\n")
-                p4_write_pipe(['submit', '-i'], submitTemplate)
-
-                if self.preserveUser:
-                    if p4User:
-                        # Get last changelist number. Cannot easily get it from
-                        # the submit command output as the output is
-                        # unmarshalled.
-                        changelist = self.lastP4Changelist()
-                        self.modifyChangelistUser(changelist, p4User)
-
-                # The rename/copy happened by applying a patch that created a
-                # new file.  This leaves it writable, which confuses p4.
-                for f in pureRenameCopy:
-                    p4_sync(f, "-f")
-
-            else:
-                # skip this patch
-                print "Submission cancelled, undoing p4 changes."
-                for f in editedFiles:
-                    p4_revert(f)
-                for f in filesToAdd:
-                    p4_revert(f)
-                    os.remove(f)
+            if self.preserveUser:
+                if p4User:
+                    # Get last changelist number. Cannot easily get it from
+                    # the submit command output as the output is
+                    # unmarshalled.
+                    changelist = self.lastP4Changelist()
+                    self.modifyChangelistUser(changelist, p4User)
+
+            # The rename/copy happened by applying a patch that created a
+            # new file.  This leaves it writable, which confuses p4.
+            for f in pureRenameCopy:
+                p4_sync(f, "-f")
 
-            os.remove(fileName)
         else:
-            fileName = "submit.txt"
-            file = open(fileName, "w+")
-            file.write(self.prepareLogMessage(template, logMessage))
-            file.close()
-            print ("Perforce submit template written as %s. "
-                   + "Please review/edit and then use p4 submit -i < %s to submit directly!"
-                   % (fileName, fileName))
+            # skip this patch
+            print "Submission cancelled, undoing p4 changes."
+            for f in editedFiles:
+                p4_revert(f)
+            for f in filesToAdd:
+                p4_revert(f)
+                os.remove(f)
+
+        os.remove(fileName)
 
     # Export git tags as p4 labels. Create a p4 label and then tag
     # with that.
@@ -1437,8 +1427,6 @@ class P4Submit(Command, P4UserMap):
             commit = commits[0]
             commits = commits[1:]
             self.applyCommit(commit)
-            if not self.interactive:
-                break
 
         if len(commits) == 0:
             print "All changes applied!"
-- 
1.7.11.1.125.g4a65fea
