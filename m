From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v3 8/8] git-remote-testpy: call print as a function
Date: Sun, 20 Jan 2013 13:15:38 +0000
Message-ID: <ef4637c02dcfb306a2f209c7387ecfb2f66d4e7a.1358686905.git.john@keeping.me.uk>
References: <cover.1358686905.git.john@keeping.me.uk>
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 14:17:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Twulz-0003ES-9I
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 14:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087Ab3ATNQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 08:16:58 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:51978 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab3ATNQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 08:16:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 976D460655D;
	Sun, 20 Jan 2013 13:16:57 +0000 (GMT)
X-Quarantine-ID: <gcK5XzvX9Or8>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gcK5XzvX9Or8; Sun, 20 Jan 2013 13:16:57 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 3F22F6064D3;
	Sun, 20 Jan 2013 13:16:56 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 388FE161E560;
	Sun, 20 Jan 2013 13:16:56 +0000 (GMT)
X-Quarantine-ID: <fRoZ+OMwCDBa>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fRoZ+OMwCDBa; Sun, 20 Jan 2013 13:16:56 +0000 (GMT)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 4304A161E557;
	Sun, 20 Jan 2013 13:16:49 +0000 (GMT)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <cover.1358686905.git.john@keeping.me.uk>
In-Reply-To: <cover.1358686905.git.john@keeping.me.uk>
References: <cover.1358686905.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214018>

This is harmless in Python 2, which sees the parentheses as redundant
grouping, but is required for Python 3.  Since this is the only change
required to make this script just run under Python 3 without needing
2to3 it seems worthwhile.

The case of an empty print must be handled specially because in that
case Python 2 will interpret '()' as an empty tuple and print it as
'()'; inserting an empty string fixes this.

Signed-off-by: John Keeping <john@keeping.me.uk>
Acked-by: Sverre Rabbelier <srabbelier@gmail.com>
---
 git-remote-testpy.py | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/git-remote-testpy.py b/git-remote-testpy.py
index 5dbf1cc..c7a04ec 100644
--- a/git-remote-testpy.py
+++ b/git-remote-testpy.py
@@ -87,9 +87,9 @@ def do_capabilities(repo, args):
     """Prints the supported capabilities.
     """
 
-    print "import"
-    print "export"
-    print "refspec refs/heads/*:%s*" % repo.prefix
+    print("import")
+    print("export")
+    print("refspec refs/heads/*:%s*" % repo.prefix)
 
     dirname = repo.get_base_path(repo.gitdir)
 
@@ -98,11 +98,11 @@ def do_capabilities(repo, args):
 
     path = os.path.join(dirname, 'git.marks')
 
-    print "*export-marks %s" % path
+    print("*export-marks %s" % path)
     if os.path.exists(path):
-        print "*import-marks %s" % path
+        print("*import-marks %s" % path)
 
-    print # end capabilities
+    print('') # end capabilities
 
 
 def do_list(repo, args):
@@ -115,16 +115,16 @@ def do_list(repo, args):
 
     for ref in repo.revs:
         debug("? refs/heads/%s", ref)
-        print "? refs/heads/%s" % ref
+        print("? refs/heads/%s" % ref)
 
     if repo.head:
         debug("@refs/heads/%s HEAD" % repo.head)
-        print "@refs/heads/%s HEAD" % repo.head
+        print("@refs/heads/%s HEAD" % repo.head)
     else:
         debug("@refs/heads/master HEAD")
-        print "@refs/heads/master HEAD"
+        print("@refs/heads/master HEAD")
 
-    print # end list
+    print('') # end list
 
 
 def update_local_repo(repo):
@@ -164,7 +164,7 @@ def do_import(repo, args):
         ref = line[7:].strip()
         refs.append(ref)
 
-    print "feature done"
+    print("feature done")
 
     if os.environ.get("GIT_REMOTE_TESTGIT_FAILURE"):
         die('Told to fail')
@@ -172,7 +172,7 @@ def do_import(repo, args):
     repo = update_local_repo(repo)
     repo.exporter.export_repo(repo.gitdir, refs)
 
-    print "done"
+    print("done")
 
 
 def do_export(repo, args):
@@ -192,8 +192,8 @@ def do_export(repo, args):
         repo.non_local.push(repo.gitdir)
 
     for ref in changed:
-        print "ok %s" % ref
-    print
+        print("ok %s" % ref)
+    print('')
 
 
 COMMANDS = {
-- 
1.8.1.353.gc992d5a.dirty
