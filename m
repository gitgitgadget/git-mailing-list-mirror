From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 1/3] git-p4: move to toplevel
Date: Sun,  8 Apr 2012 20:18:00 -0400
Message-ID: <1333930682-31670-2-git-send-email-pw@padd.com>
References: <1333930682-31670-1-git-send-email-pw@padd.com>
Cc: Luke Diamand <luke@diamand.org>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 09 02:18:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SH2JT-0004d8-Ix
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 02:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753906Ab2DIAS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Apr 2012 20:18:26 -0400
Received: from honk.padd.com ([74.3.171.149]:45568 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752625Ab2DIASZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2012 20:18:25 -0400
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id A3FC02CBE;
	Sun,  8 Apr 2012 17:18:24 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 55821313D3; Sun,  8 Apr 2012 20:18:22 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.56.gfc226
In-Reply-To: <1333930682-31670-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195007>

Move git-p4 out of contrib/fast-import into the main code base,
aside other foreign SCM tools.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 .gitignore                              |    1 +
 Documentation/git-p4.txt                |   19 ++++++-------------
 INSTALL                                 |    3 +++
 Makefile                                |    1 +
 command-list.txt                        |    1 +
 contrib/fast-import/git-p4.README       |   13 +++++++++++++
 contrib/fast-import/git-p4.bat          |    1 -
 contrib/fast-import/git-p4 => git-p4.py |    0
 t/lib-git-p4.sh                         |    2 +-
 9 files changed, 26 insertions(+), 15 deletions(-)
 create mode 100644 contrib/fast-import/git-p4.README
 delete mode 100644 contrib/fast-import/git-p4.bat
 rename contrib/fast-import/git-p4 => git-p4.py (100%)

diff --git a/.gitignore b/.gitignore
index 87fcc5f..5a0782f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -92,6 +92,7 @@
 /git-name-rev
 /git-mv
 /git-notes
+/git-p4
 /git-pack-redundant
 /git-pack-objects
 /git-pack-refs
diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index b7c7929..3fac413 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -31,13 +31,6 @@ the updated p4 remote branch.
 
 EXAMPLE
 -------
-* Create an alias for 'git p4', using the full path to the 'git-p4'
-  script if needed:
-+
-------------
-$ git config --global alias.p4 '!git-p4'
-------------
-
 * Clone a repository:
 +
 ------------
@@ -311,19 +304,19 @@ configuration file.  This allows future 'git p4 submit' commands to
 work properly; the submit command looks only at the variable and does
 not have a command-line option.
 
-The full syntax for a p4 view is documented in 'p4 help views'.  Git-p4
+The full syntax for a p4 view is documented in 'p4 help views'.  'Git p4'
 knows only a subset of the view syntax.  It understands multi-line
 mappings, overlays with '+', exclusions with '-' and double-quotes
-around whitespace.  Of the possible wildcards, git-p4 only handles
-'...', and only when it is at the end of the path.  Git-p4 will complain
+around whitespace.  Of the possible wildcards, 'git p4' only handles
+'...', and only when it is at the end of the path.  'Git p4' will complain
 if it encounters an unhandled wildcard.
 
 Bugs in the implementation of overlap mappings exist.  If multiple depot
 paths map through overlays to the same location in the repository,
-git-p4 can choose the wrong one.  This is hard to solve without
-dedicating a client spec just for git-p4.
+'git p4' can choose the wrong one.  This is hard to solve without
+dedicating a client spec just for 'git p4'.
 
-The name of the client can be given to git-p4 in multiple ways.  The
+The name of the client can be given to 'git p4' in multiple ways.  The
 variable 'git-p4.client' takes precedence if it exists.  Otherwise,
 normal p4 mechanisms of determining the client are used:  environment
 variable P4CLIENT, a file referenced by P4CONFIG, or the local host name.
diff --git a/INSTALL b/INSTALL
index 58b2b86..87e03bb 100644
--- a/INSTALL
+++ b/INSTALL
@@ -131,6 +131,9 @@ Issues of note:
 	  use English. Under autoconf the configure script will do this
 	  automatically if it can't find libintl on the system.
 
+	- Python version 2.6 or later is needed to use the git-p4
+	  interface to Perforce.
+
  - Some platform specific issues are dealt with Makefile rules,
    but depending on your specific installation, you may not
    have all the libraries/tools needed, or you may have
diff --git a/Makefile b/Makefile
index be1957a..df86f2f 100644
--- a/Makefile
+++ b/Makefile
@@ -440,6 +440,7 @@ SCRIPT_PERL += git-send-email.perl
 SCRIPT_PERL += git-svn.perl
 
 SCRIPT_PYTHON += git-remote-testgit.py
+SCRIPT_PYTHON += git-p4.py
 
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
 	  $(patsubst %.perl,%,$(SCRIPT_PERL)) \
diff --git a/command-list.txt b/command-list.txt
index a36ee9b..38ec5f7 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -76,6 +76,7 @@ git-mktree                              plumbingmanipulators
 git-mv                                  mainporcelain common
 git-name-rev                            plumbinginterrogators
 git-notes                               mainporcelain
+git-p4                                  foreignscminterface
 git-pack-objects                        plumbingmanipulators
 git-pack-redundant                      plumbinginterrogators
 git-pack-refs                           ancillarymanipulators
diff --git a/contrib/fast-import/git-p4.README b/contrib/fast-import/git-p4.README
new file mode 100644
index 0000000..d9a7684
--- /dev/null
+++ b/contrib/fast-import/git-p4.README
@@ -0,0 +1,13 @@
+The git-p4 script moved to the top-level of the git source directory.
+
+Invoke it as any other git command, like "git p4 clone", for instance.
+
+Note that the top-level git-p4.py script is now the source.  It is
+built using make to git-p4, which will be installed.
+
+Windows users can copy the git-p4.py source script directly, possibly
+invoking it through a batch file called "git-p4.bat" in the same folder.
+It should contain just one line:
+
+    @python "%~d0%~p0git-p4.py" %*
+
diff --git a/contrib/fast-import/git-p4.bat b/contrib/fast-import/git-p4.bat
deleted file mode 100644
index 9f97e88..0000000
--- a/contrib/fast-import/git-p4.bat
+++ /dev/null
@@ -1 +0,0 @@
-@python "%~d0%~p0git-p4" %*
diff --git a/contrib/fast-import/git-p4 b/git-p4.py
similarity index 100%
rename from contrib/fast-import/git-p4
rename to git-p4.py
diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index a870f9a..49edaae 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -13,7 +13,7 @@ fi
 	test_done
 }
 
-GITP4="$GIT_BUILD_DIR/contrib/fast-import/git-p4"
+GITP4="$GIT_BUILD_DIR/git-p4"
 
 # Try to pick a unique port: guess a large number, then hope
 # no more than one of each test is running.
-- 
1.7.10.4.gb369
