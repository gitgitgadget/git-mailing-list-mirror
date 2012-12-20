From: esr@thyrsus.com (Eric S. Raymond)
Subject: [PATCH] Python scripts audited for minimum compatible version and
 checks added.
Date: Thu, 20 Dec 2012 09:13:37 -0500
Message-ID: <20121220141855.05DAA44105@snark.thyrsus.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 20 15:19:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlgyG-0002SB-2a
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 15:19:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168Ab2LTOTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 09:19:18 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:35449
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009Ab2LTOTR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 09:19:17 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 05DAA44105; Thu, 20 Dec 2012 09:18:54 -0500 (EST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211889>

Signed-off-by: Eric S. Raymond <esr@thyrsus.com>
---
 contrib/ciabot/ciabot.py           | 5 +++++
 contrib/fast-import/import-zips.py | 5 +++++
 contrib/hg-to-git/hg-to-git.py     | 5 +++++
 contrib/p4import/git-p4import.py   | 5 +++++
 contrib/svn-fe/svnrdump_sim.py     | 4 ++++
 git-p4.py                          | 5 +++++
 git-remote-testgit.py              | 5 +++++
 git_remote_helpers/git/__init__.py | 4 ++++
 8 files changed, 38 insertions(+)

diff --git a/contrib/ciabot/ciabot.py b/contrib/ciabot/ciabot.py
index bd24395..b55648f 100755
--- a/contrib/ciabot/ciabot.py
+++ b/contrib/ciabot/ciabot.py
@@ -50,6 +50,11 @@
 import os, sys, commands, socket, urllib
 from xml.sax.saxutils import escape
 
+if sys.hexversion < 0x02000000:
+	# The limiter is the xml.sax module
+        sys.stderr.write("import-zips.py: requires Python 2.0.0 or later.")
+        sys.exit(1)
+
 # Changeset URL prefix for your repo: when the commit ID is appended
 # to this, it should point at a CGI that will display the commit
 # through gitweb or something similar. The defaults will probably
diff --git a/contrib/fast-import/import-zips.py b/contrib/fast-import/import-zips.py
index 82f5ed3..d9ad71d 100755
--- a/contrib/fast-import/import-zips.py
+++ b/contrib/fast-import/import-zips.py
@@ -13,6 +13,11 @@ from sys import argv, exit
 from time import mktime
 from zipfile import ZipFile
 
+if sys.hexversion < 0x01060000:
+	# The limiter is the zipfile module
+        sys.stderr.write("import-zips.py: requires Python 1.6.0 or later.")
+        sys.exit(1)
+
 if len(argv) < 2:
 	print 'Usage:', argv[0], '<zipfile>...'
 	exit(1)
diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.py
index 046cb2b..9f39ce5 100755
--- a/contrib/hg-to-git/hg-to-git.py
+++ b/contrib/hg-to-git/hg-to-git.py
@@ -23,6 +23,11 @@ import os, os.path, sys
 import tempfile, pickle, getopt
 import re
 
+if sys.hexversion < 0x02030000:
+   # The behavior of the pickle module changed significantly in 2.3
+   sys.stderr.write("hg-to-git.py: requires Python 2.3 or later.")
+   sys.exit(1)
+
 # Maps hg version -> git version
 hgvers = {}
 # List of children for each hg revision
diff --git a/contrib/p4import/git-p4import.py b/contrib/p4import/git-p4import.py
index b6e534b..fb48e2a 100644
--- a/contrib/p4import/git-p4import.py
+++ b/contrib/p4import/git-p4import.py
@@ -14,6 +14,11 @@ import sys
 import time
 import getopt
 
+if sys.hexversion < 0x02020000:
+   # The behavior of the marshal module changed significantly in 2.2
+   sys.stderr.write("git-p4import.py: requires Python 2.2 or later.")
+   sys.exit(1)
+
 from signal import signal, \
    SIGPIPE, SIGINT, SIG_DFL, \
    default_int_handler
diff --git a/contrib/svn-fe/svnrdump_sim.py b/contrib/svn-fe/svnrdump_sim.py
index 1cfac4a..ed43dbb 100755
--- a/contrib/svn-fe/svnrdump_sim.py
+++ b/contrib/svn-fe/svnrdump_sim.py
@@ -7,6 +7,10 @@ to the highest revision that should be available.
 """
 import sys, os
 
+if sys.hexversion < 0x02040000:
+	# The limiter is the ValueError() calls. This may be too conservative
+        sys.stderr.write("svnrdump-sim.py: requires Python 2.4 or later.")
+        sys.exit(1)
 
 def getrevlimit():
         var = 'SVNRMAX'
diff --git a/git-p4.py b/git-p4.py
index 551aec9..ec060b4 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -12,6 +12,11 @@ import optparse, sys, os, marshal, subprocess, shelve
 import tempfile, getopt, os.path, time, platform
 import re, shutil
 
+if sys.hexversion < 0x02040000:
+    # The limiter is the subprocess module
+    sys.stderr.write("git-p4.py: requires Python 2.4 or later.")
+    sys.exit(1)
+
 verbose = False
 
 # Only labels/tags matching this will be imported/exported
diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index 5f3ebd2..22d2eb6 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -31,6 +31,11 @@ from git_remote_helpers.git.exporter import GitExporter
 from git_remote_helpers.git.importer import GitImporter
 from git_remote_helpers.git.non_local import NonLocalGit
 
+if sys.hexversion < 0x01050200:
+    # os.makedirs() is the limiter
+    sys.stderr.write("git-remote-testgit.py: requires Python 1.5.2 or later.")
+    sys.exit(1)
+
 def get_repo(alias, url):
     """Returns a git repository object initialized for usage.
     """
diff --git a/git_remote_helpers/git/__init__.py b/git_remote_helpers/git/__init__.py
index e69de29..776e891 100644
--- a/git_remote_helpers/git/__init__.py
+++ b/git_remote_helpers/git/__init__.py
@@ -0,0 +1,4 @@
+if sys.hexversion < 0x02040000:
+    # The limiter is the subprocess module
+    sys.stderr.write("git_remote_helpers: requires Python 2.4 or later.")
+    sys.exit(1)
-- 
1.8.1.rc2



-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

"The state calls its own violence `law', but that of the individual `crime'"
	-- Max Stirner
