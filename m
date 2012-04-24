From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv4 5/5] git p4: move verbose to base class
Date: Tue, 24 Apr 2012 09:33:23 +0100
Message-ID: <1335256403-22162-6-git-send-email-luke@diamand.org>
References: <1335256403-22162-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Junio C Hamano <gitster@pobox.com>,
	Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 10:33:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMbC0-00088z-VG
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 10:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756337Ab2DXIdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 04:33:45 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:53086 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756247Ab2DXIdg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 04:33:36 -0400
Received: by mail-we0-f174.google.com with SMTP id x9so243064wej.19
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 01:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=vqAgBqrsolbQr52lhyz2oja3krONGxyTtNCdULssyKU=;
        b=V0vnDR1XtREZSl+clAbzOUfgvDV5n7MYC9L8n0dNl2OwCtB9L+tIfFd5afBS5xSxZa
         zOQXeRjw162SgX1b4bFu9D7cojPnRqWAg+tw2Rs4b4tbfx+dA2ZYD5dl89CODfiaDckp
         vXZ7Muabgw8jjl4n0xPri+K+5aTm5YV/rzaMiA3TbMDuB2YuZWTqK9aeGx41OAQ9GSMS
         p2upQWvWOdrOGRQBpz9IXIPLYzluGgqwJKaozRcDcky/y9HUK82LD2xJBnk9d3BUpdY8
         kS0IWgA2FdmuPTxS+APdTi/vOlk9YfdkU1f2GaIxucH5XR04f+4+/Mz2zv0e6MJbbpBG
         n/SA==
Received: by 10.180.82.136 with SMTP id i8mr28828517wiy.19.1335256415599;
        Tue, 24 Apr 2012 01:33:35 -0700 (PDT)
Received: from ethel.diamand (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id fz9sm28534467wib.3.2012.04.24.01.33.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Apr 2012 01:33:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.8.g12781
In-Reply-To: <1335256403-22162-1-git-send-email-luke@diamand.org>
X-Gm-Message-State: ALoCoQmPEnijbwMfzzdRLeEPHOODYgLSwDXexlacgm1BtUPKMd7EwWz2Dxb9vs3HfFXXRtMdRvQD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196212>

The verbose flag is common to all classes, or at least should be.
Make it a member of the base Command class, rather than
reimplementing for each class. Make option parsing mirror this.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 Documentation/git-p4.txt |   11 ++++-------
 git-p4.py                |   31 ++++++++++---------------------
 2 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 01cc97b..51955a5 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -158,11 +158,14 @@ OPTIONS
 
 General options
 ~~~~~~~~~~~~~~~
-All commands except clone accept this option.
+All commands except clone accept these options.
 
 --git-dir <dir>::
 	Set the 'GIT_DIR' environment variable.  See linkgit:git[1].
 
+--verbose::
+	Provide more progress information.
+
 Sync options
 ~~~~~~~~~~~~
 These options can be used in the initial 'clone' as well as in
@@ -193,9 +196,6 @@ git repository:
 --silent::
 	Do not print any progress information.
 
---verbose::
-	Provide more progress information.
-
 --detect-labels::
 	Query p4 for labels associated with the depot paths, and add
 	them as tags in git. Limited usefulness as only imports labels
@@ -249,9 +249,6 @@ Submit options
 ~~~~~~~~~~~~~~
 These options can be used to modify 'git p4 submit' behavior.
 
---verbose::
-	Provide more progress information.
-
 --origin <commit>::
 	Upstream location from which commits are identified to submit to
 	p4.  By default, this is the most recent p4 commit reachable
diff --git a/git-p4.py b/git-p4.py
index 6ce88ff..eab6959 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -662,6 +662,7 @@ class Command:
     def __init__(self):
         self.usage = "usage: %prog [options]"
         self.needsGit = True
+        self.verbose = False
 
 class P4UserMap:
     def __init__(self):
@@ -727,13 +728,9 @@ class P4UserMap:
 class P4Debug(Command):
     def __init__(self):
         Command.__init__(self)
-        self.options = [
-            optparse.make_option("--verbose", dest="verbose", action="store_true",
-                                 default=False),
-            ]
+        self.options = []
         self.description = "A tool to debug the output of p4 -G."
         self.needsGit = False
-        self.verbose = False
 
     def run(self, args):
         j = 0
@@ -747,11 +744,9 @@ class P4RollBack(Command):
     def __init__(self):
         Command.__init__(self)
         self.options = [
-            optparse.make_option("--verbose", dest="verbose", action="store_true"),
             optparse.make_option("--local", dest="rollbackLocalBranches", action="store_true")
         ]
         self.description = "A tool to debug the multi-branch import. Don't use :)"
-        self.verbose = False
         self.rollbackLocalBranches = False
 
     def run(self, args):
@@ -809,7 +804,6 @@ class P4Submit(Command, P4UserMap):
         Command.__init__(self)
         P4UserMap.__init__(self)
         self.options = [
-                optparse.make_option("--verbose", dest="verbose", action="store_true"),
                 optparse.make_option("--origin", dest="origin"),
                 optparse.make_option("-M", dest="detectRenames", action="store_true"),
                 # preserve the user, requires relevant p4 permissions
@@ -821,7 +815,6 @@ class P4Submit(Command, P4UserMap):
         self.interactive = True
         self.origin = ""
         self.detectRenames = False
-        self.verbose = False
         self.preserveUser = gitConfig("git-p4.preserveUser").lower() == "true"
         self.isWindows = (platform.system() == "Windows")
         self.exportLabels = False
@@ -1644,7 +1637,6 @@ class P4Sync(Command, P4UserMap):
                 optparse.make_option("--silent", dest="silent", action="store_true"),
                 optparse.make_option("--detect-labels", dest="detectLabels", action="store_true"),
                 optparse.make_option("--import-labels", dest="importLabels", action="store_true"),
-                optparse.make_option("--verbose", dest="verbose", action="store_true"),
                 optparse.make_option("--import-local", dest="importIntoRemotes", action="store_false",
                                      help="Import into refs/heads/ , not refs/remotes"),
                 optparse.make_option("--max-changes", dest="maxChanges"),
@@ -1671,7 +1663,6 @@ class P4Sync(Command, P4UserMap):
         self.importLabels = False
         self.changesFile = ""
         self.syncWithOrigin = True
-        self.verbose = False
         self.importIntoRemotes = True
         self.maxChanges = ""
         self.isWindows = (platform.system() == "Windows")
@@ -2712,9 +2703,7 @@ class P4Rebase(Command):
         Command.__init__(self)
         self.options = [
                 optparse.make_option("--import-labels", dest="importLabels", action="store_true"),
-                optparse.make_option("--verbose", dest="verbose", action="store_true"),
         ]
-        self.verbose = False
         self.importLabels = False
         self.description = ("Fetches the latest revision from perforce and "
                             + "rebases the current work (branch) against it")
@@ -2911,16 +2900,16 @@ def main():
 
     args = sys.argv[2:]
 
-    if len(options) > 0:
-        if cmd.needsGit:
-            options.append(optparse.make_option("--git-dir", dest="gitdir"))
+    options.append(optparse.make_option("--verbose", dest="verbose", action="store_true"))
+    if cmd.needsGit:
+        options.append(optparse.make_option("--git-dir", dest="gitdir"))
 
-        parser = optparse.OptionParser(cmd.usage.replace("%prog", "%prog " + cmdName),
-                                       options,
-                                       description = cmd.description,
-                                       formatter = HelpFormatter())
+    parser = optparse.OptionParser(cmd.usage.replace("%prog", "%prog " + cmdName),
+                                   options,
+                                   description = cmd.description,
+                                   formatter = HelpFormatter())
 
-        (cmd, args) = parser.parse_args(sys.argv[2:], cmd);
+    (cmd, args) = parser.parse_args(sys.argv[2:], cmd);
     global verbose
     verbose = cmd.verbose
     if cmd.needsGit:
-- 
1.7.10.8.g12781
