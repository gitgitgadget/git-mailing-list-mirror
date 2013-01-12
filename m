From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 8/8] git-remote-testpy: call print as a function
Date: Sat, 12 Jan 2013 19:23:46 +0000
Message-ID: <96d803276c95af6bf909bc48e8e984cc7ba25ead.1358018078.git.john@keeping.me.uk>
References: <cover.1358018078.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 20:26:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tu6iq-0002K2-Su
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 20:26:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754258Ab3ALT0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 14:26:08 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:44334 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082Ab3ALT0H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 14:26:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 7B172606565;
	Sat, 12 Jan 2013 19:26:07 +0000 (GMT)
X-Quarantine-ID: <RZqkLQfBe1DQ>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RZqkLQfBe1DQ; Sat, 12 Jan 2013 19:26:07 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 2A25C606562;
	Sat, 12 Jan 2013 19:26:07 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 21F3F161E556;
	Sat, 12 Jan 2013 19:26:07 +0000 (GMT)
X-Quarantine-ID: <FxI14WjmhDjl>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FxI14WjmhDjl; Sat, 12 Jan 2013 19:26:07 +0000 (GMT)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id EAF9C161E1F3;
	Sat, 12 Jan 2013 19:25:57 +0000 (GMT)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <cover.1358018078.git.john@keeping.me.uk>
In-Reply-To: <cover.1358018078.git.john@keeping.me.uk>
References: <cover.1358018078.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213309>

This is harmless in Python 2, which sees the parentheses as redundant
grouping, but is required for Python 3.  Since this is the only change
required to make this script just run under Python 3 without needing
2to3 it seems worthwhile.

The case of an empty print must be handled specially because in that
case Python 2 will interpret '()' as an empty tuple and print it as
'()'; inserting an empty string fixes this.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-remote-testpy.py | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/git-remote-testpy.py b/git-remote-testpy.py
index 815222f..8ba5d28 100644
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
@@ -167,7 +167,7 @@ def do_import(repo, args):
     repo = update_local_repo(repo)
     repo.exporter.export_repo(repo.gitdir, refs)
 
-    print "done"
+    print("done")
 
 
 def do_export(repo, args):
@@ -184,8 +184,8 @@ def do_export(repo, args):
         repo.non_local.push(repo.gitdir)
 
     for ref in changed:
-        print "ok %s" % ref
-    print
+        print("ok %s" % ref)
+    print('')
 
 
 COMMANDS = {
-- 
1.8.1
