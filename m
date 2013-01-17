From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 8/8] git-remote-testpy: call print as a function
Date: Thu, 17 Jan 2013 18:54:01 +0000
Message-ID: <88502ee7b090454352b46d496741029817b27482.1358448207.git.john@keeping.me.uk>
References: <cover.1358448207.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Pete Wyckoff <pw@padd.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 19:57:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tvueo-0006PD-TW
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 19:57:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755645Ab3AQS50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 13:57:26 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:56837 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776Ab3AQS50 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 13:57:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 4259FCDA59C;
	Thu, 17 Jan 2013 18:57:25 +0000 (GMT)
X-Quarantine-ID: <LwTBXAaXAkFG>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LwTBXAaXAkFG; Thu, 17 Jan 2013 18:57:19 +0000 (GMT)
Received: from aardwolf.aluminati.org (aardwolf.aluminati.org [10.0.7.189])
	by jackal.aluminati.org (Postfix) with ESMTP id 10C28CDA5E6;
	Thu, 17 Jan 2013 18:57:19 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by aardwolf.aluminati.org (Postfix) with ESMTP id D8C9C276DFE;
	Thu, 17 Jan 2013 18:57:18 +0000 (GMT)
X-Quarantine-ID: <OUArC7GaKGdx>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from aardwolf.aluminati.org ([127.0.0.1])
	by localhost (aardwolf.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OUArC7GaKGdx; Thu, 17 Jan 2013 18:57:18 +0000 (GMT)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by aardwolf.aluminati.org (Postfix) with ESMTPSA id 5D6A2276DFB;
	Thu, 17 Jan 2013 18:56:54 +0000 (GMT)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <cover.1358448207.git.john@keeping.me.uk>
In-Reply-To: <cover.1358448207.git.john@keeping.me.uk>
References: <cover.1358018078.git.john@keeping.me.uk> <cover.1358448207.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213870>

This is harmless in Python 2, which sees the parentheses as redundant
grouping, but is required for Python 3.  Since this is the only change
required to make this script just run under Python 3 without needing
2to3 it seems worthwhile.

The case of an empty print must be handled specially because in that
case Python 2 will interpret '()' as an empty tuple and print it as
'()'; inserting an empty string fixes this.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-remote-testpy.py | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/git-remote-testpy.py b/git-remote-testpy.py
index bc5e3cf..ccdb2dc 100644
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
1.8.1.1.260.g99b33f4.dirty
