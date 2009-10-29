From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 1/7] Refactor git_remote_cvs to a more generic git_remote_helpers
Date: Thu, 29 Oct 2009 08:47:21 -0700
Message-ID: <1256831241-3309-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Johan Herland <johan@herland.net>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 29 16:48:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3XEt-0003vT-3Y
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 16:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755441AbZJ2Ps0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 11:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755432AbZJ2Ps0
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 11:48:26 -0400
Received: from mail-pw0-f42.google.com ([209.85.160.42]:50542 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755381AbZJ2PsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 11:48:25 -0400
Received: by pwj9 with SMTP id 9so117180pwj.21
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 08:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=KbAj4lspXISHsYxLIsjpEx5ZaCT8cj4ruyvSMXNn1XY=;
        b=rxRxKfy7gTdQhFZ6WDzBlV9Ni0C4CScDhfrwcD0Px44DMqKsejxF/WoSyNik4DThgT
         OZ3y6FshracO7CfPYRhR2nqH0bBPkIUynFQzMU72wO4WLtz9VCQ9yTl+5GaCRPooWnvl
         fghr3oT30akMWo1pwE++wQ//pN/cUlPwom/Nw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=vtsM31OywF2I1y80phU07ZExtg/b7EJLcb/kalWLOiL0U7b3RV/xxd4K5hQ/tOQjJg
         hw9ZWppt5Gr5wO9xMG2GiAN+XnZ174XVJwx7Cd++5yyYmH2+WiCy0gW+G3h+hOjNgMnK
         bwPMCIPVUFNMIcXjYNi4rmMNbNNmMu/rTJpWg=
Received: by 10.115.27.14 with SMTP id e14mr149114waj.116.1256831309104;
        Thu, 29 Oct 2009 08:48:29 -0700 (PDT)
Received: from localhost.localdomain (ip67-152-86-163.z86-152-67.customer.algx.net [67.152.86.163])
        by mx.google.com with ESMTPS id 23sm1277225pxi.5.2009.10.29.08.48.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 08:48:27 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.2.291.gf76a3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131602>

This in an effort to allow future remote helpers written in python to
re-use the non-cvs-specific code.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
CC: Johan Herland <johan@herland.net>
---

	As discussed with Johan Herland, refactored git_remote_cvs into a
	more reusable git_remote_helpers module.

	Resent as apparently I forgot to include '-C -M' in my
	'git format-patch' alias.

 Makefile                                           |    8 +++---
 git-remote-cvs.py                                  |   14 +++++-----
 git_remote_cvs/__init__.py                         |   27 --------------------
 git_remote_cvs/setup.py                            |   17 ------------
 {git_remote_cvs => git_remote_helpers}/.gitignore  |    0
 {git_remote_cvs => git_remote_helpers}/Makefile    |    2 +-
 git_remote_helpers/__init__.py                     |   27 ++++++++++++++++++++
 .../cvs}/changeset.py                              |    2 +-
 .../cvs}/commit_states.py                          |    4 +-
 {git_remote_cvs => git_remote_helpers/cvs}/cvs.py  |    6 ++--
 .../cvs/revision_map.py                            |    6 ++--
 .../cvs/symbol_cache.py                            |    4 +-
 {git_remote_cvs => git_remote_helpers/git}/git.py  |    4 +-
 git_remote_helpers/setup.py                        |   17 ++++++++++++
 {git_remote_cvs => git_remote_helpers}/util.py     |    0
 t/test-lib.sh                                      |    4 +-
 16 files changed, 71 insertions(+), 71 deletions(-)
 delete mode 100644 git_remote_cvs/__init__.py
 delete mode 100644 git_remote_cvs/setup.py
 rename {git_remote_cvs => git_remote_helpers}/.gitignore (100%)
 rename {git_remote_cvs => git_remote_helpers}/Makefile (92%)
 create mode 100644 git_remote_helpers/__init__.py
 create mode 100644 git_remote_helpers/cvs/__init__.py
 rename {git_remote_cvs => git_remote_helpers/cvs}/changeset.py (98%)
 rename {git_remote_cvs => git_remote_helpers/cvs}/commit_states.py (95%)
 rename {git_remote_cvs => git_remote_helpers/cvs}/cvs.py (99%)
 rename git_remote_cvs/cvs_revision_map.py => git_remote_helpers/cvs/revision_map.py (98%)
 rename git_remote_cvs/cvs_symbol_cache.py => git_remote_helpers/cvs/symbol_cache.py (98%)
 create mode 100644 git_remote_helpers/git/__init__.py
 rename {git_remote_cvs => git_remote_helpers/git}/git.py (99%)
 create mode 100644 git_remote_helpers/setup.py
 rename {git_remote_cvs => git_remote_helpers}/util.py (100%)

diff --git a/Makefile b/Makefile
index 21da297..fa3f768 100644
--- a/Makefile
+++ b/Makefile
@@ -1335,7 +1335,7 @@ ifndef NO_PERL
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' all
 endif
 ifndef NO_PYTHON
-	$(QUIET_SUBDIR0)git_remote_cvs $(QUIET_SUBDIR1) PYTHON_PATH='$(PYTHON_PATH_SQ)' prefix='$(prefix_SQ)' all
+	$(QUIET_SUBDIR0)git_remote_helpers $(QUIET_SUBDIR1) PYTHON_PATH='$(PYTHON_PATH_SQ)' prefix='$(prefix_SQ)' all
 endif
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1)
 
@@ -1459,7 +1459,7 @@ ifndef NO_PYTHON
 $(patsubst %.py,%,$(SCRIPT_PYTHON)): GIT-CFLAGS
 $(patsubst %.py,%,$(SCRIPT_PYTHON)): % : %.py
 	$(QUIET_GEN)$(RM) $@ $@+ && \
-	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C git_remote_cvs -s \
+	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C git_remote_helpers -s \
 		--no-print-directory prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' \
 		instlibdir` && \
 	sed -e '1{' \
@@ -1709,7 +1709,7 @@ ifndef NO_PERL
 	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
 endif
 ifndef NO_PYTHON
-	$(MAKE) -C git_remote_cvs prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
+	$(MAKE) -C git_remote_helpers prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
 endif
 ifndef NO_TCLTK
 	$(MAKE) -C gitk-git install
@@ -1826,7 +1826,7 @@ ifndef NO_PERL
 	$(MAKE) -C perl clean
 endif
 ifndef NO_PYTHON
-	$(MAKE) -C git_remote_cvs clean
+	$(MAKE) -C git_remote_helpers clean
 endif
 	$(MAKE) -C templates/ clean
 	$(MAKE) -C t/ clean
diff --git a/git-remote-cvs.py b/git-remote-cvs.py
index 94b61e7..f322f96 100755
--- a/git-remote-cvs.py
+++ b/git-remote-cvs.py
@@ -36,16 +36,16 @@ configuration details of this remote helper.
 import sys
 import os
 
-from git_remote_cvs.util import (debug, error, die, ProgressIndicator,
+from git_remote_helpers.util import (debug, error, die, ProgressIndicator,
                                  run_command)
-from git_remote_cvs.cvs import CVSState, CVSWorkDir, fetch_revs
-from git_remote_cvs.git import (get_git_dir, parse_git_config, git_config_bool,
+from git_remote_helpers.cvs.cvs import CVSState, CVSWorkDir, fetch_revs
+from git_remote_helpers.git.git import (get_git_dir, parse_git_config, git_config_bool,
                                 valid_git_ref, GitObjectFetcher, GitRefMap,
                                 GitFICommit, GitFastImport, GitNotes)
-from git_remote_cvs.cvs_symbol_cache import CVSSymbolCache
-from git_remote_cvs.commit_states import CommitStates
-from git_remote_cvs.cvs_revision_map import CVSRevisionMap, CVSStateMap
-from git_remote_cvs.changeset import build_changesets_from_revs
+from git_remote_helpers.cvs.symbol_cache import CVSSymbolCache
+from git_remote_helpers.cvs.commit_states import CommitStates
+from git_remote_helpers.cvs.revision_map import CVSRevisionMap, CVSStateMap
+from git_remote_helpers.cvs.changeset import build_changesets_from_revs
 
 
 class Config(object):
diff --git a/git_remote_cvs/__init__.py b/git_remote_cvs/__init__.py
deleted file mode 100644
index 4956d2d..0000000
--- a/git_remote_cvs/__init__.py
+++ /dev/null
@@ -1,27 +0,0 @@
-#!/usr/bin/env python
-
-"""Support library package for git-remote-cvs.
-
-git-remote-cvs is a Git remote helper command that interfaces with a
-CVS repository to provide automatic import of CVS history into a Git
-repository.
-
-This package provides the support library needed by git-remote-cvs.
-The following modules are included:
-
-- cvs - Interaction with CVS repositories
-
-- cvs_symbol_cache - Local CVS symbol cache
-
-- changeset - Collect individual CVS revisions into commits
-
-- git - Interaction with Git repositories
-
-- commit_states - Map Git commits to CVS states
-
-- cvs_revision_map - Map CVS revisions to various metainformation
-
-- util - General utility functionality use by the other modules in
-         this package, and also used directly by git-remote-cvs.
-
-"""
diff --git a/git_remote_cvs/setup.py b/git_remote_cvs/setup.py
deleted file mode 100644
index 21f521a..0000000
--- a/git_remote_cvs/setup.py
+++ /dev/null
@@ -1,17 +0,0 @@
-#!/usr/bin/env python
-
-"""Distutils build/install script for the git_remote_cvs package."""
-
-from distutils.core import setup
-
-setup(
-    name = 'git_remote_cvs',
-    version = '0.1.0',
-    description = 'Git remote helper program for CVS repositories',
-    license = 'GPLv2',
-    author = 'The Git Community',
-    author_email = 'git@vger.kernel.org',
-    url = 'http://www.git-scm.com/',
-    package_dir = {'git_remote_cvs': ''},
-    packages = ['git_remote_cvs'],
-)
diff --git a/git_remote_cvs/.gitignore b/git_remote_helpers/.gitignore
similarity index 100%
rename from git_remote_cvs/.gitignore
rename to git_remote_helpers/.gitignore
diff --git a/git_remote_cvs/Makefile b/git_remote_helpers/Makefile
similarity index 92%
rename from git_remote_cvs/Makefile
rename to git_remote_helpers/Makefile
index 0d9eb31..c62dfd0 100644
--- a/git_remote_cvs/Makefile
+++ b/git_remote_helpers/Makefile
@@ -1,5 +1,5 @@
 #
-# Makefile for the git_remote_cvs python support modules
+# Makefile for the git_remote_helpers python support modules
 #
 pysetupfile:=setup.py
 
diff --git a/git_remote_helpers/__init__.py b/git_remote_helpers/__init__.py
new file mode 100644
index 0000000..38c7b5f
--- /dev/null
+++ b/git_remote_helpers/__init__.py
@@ -0,0 +1,27 @@
+#!/usr/bin/env python
+
+"""Support library package for git remote helpers.
+
+Git remote helpers are helper commands that interfaces with a non-git
+repository to provide automatic import of non-git history into a Git
+repository.
+
+This package provides the support library needed by these helpers..
+The following modules are included:
+
+- cvs/cvs - Interaction with CVS repositories
+
+- cvs/symbol_cache - Local CVS symbol cache
+
+- cvs/changeset - Collect individual CVS revisions into commits
+
+- cvs/commit_states - Map Git commits to CVS states
+
+- cvs/revision_map - Map CVS revisions to various metainformation
+
+- git/git - Interaction with Git repositories
+
+- util - General utility functionality use by the other modules in
+         this package, and also used directly by git-remote-cvs.
+
+"""
diff --git a/git_remote_helpers/cvs/__init__.py b/git_remote_helpers/cvs/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/git_remote_cvs/changeset.py b/git_remote_helpers/cvs/changeset.py
similarity index 98%
rename from git_remote_cvs/changeset.py
rename to git_remote_helpers/cvs/changeset.py
index 9eea9d2..4865c37 100644
--- a/git_remote_cvs/changeset.py
+++ b/git_remote_helpers/cvs/changeset.py
@@ -11,7 +11,7 @@ module tries to reconstruct this notion of related revisions.
 
 """
 
-from git_remote_cvs.util import debug, error, die
+from git_remote_helpers.util import debug, error, die
 
 
 class Changeset(object):
diff --git a/git_remote_cvs/commit_states.py b/git_remote_helpers/cvs/commit_states.py
similarity index 95%
rename from git_remote_cvs/commit_states.py
rename to git_remote_helpers/cvs/commit_states.py
index 2e0af6c..a796bb1 100644
--- a/git_remote_cvs/commit_states.py
+++ b/git_remote_helpers/cvs/commit_states.py
@@ -2,8 +2,8 @@
 
 """Code for relating Git commits to corresponding CVSState objects."""
 
-from git_remote_cvs.util import debug, error, die
-from git_remote_cvs.cvs import CVSState
+from git_remote_helpers.util import debug, error, die
+from git_remote_helpers.cvs.cvs import CVSState
 
 
 class CommitStates(object):
diff --git a/git_remote_cvs/cvs.py b/git_remote_helpers/cvs/cvs.py
similarity index 99%
rename from git_remote_cvs/cvs.py
rename to git_remote_helpers/cvs/cvs.py
index f870ae0..a1a02be 100644
--- a/git_remote_cvs/cvs.py
+++ b/git_remote_helpers/cvs/cvs.py
@@ -17,9 +17,9 @@ import time
 from calendar import timegm
 import unittest
 
-from git_remote_cvs.util import (debug, error, die, ProgressIndicator,
-                                 start_command, run_command,
-                                 file_reader_method, file_writer_method)
+from git_remote_helpers.util import (debug, error, die, ProgressIndicator,
+                                     start_command, run_command,
+                                     file_reader_method, file_writer_method)
 
 
 class CVSNum(object):
diff --git a/git_remote_cvs/cvs_revision_map.py b/git_remote_helpers/cvs/revision_map.py
similarity index 98%
rename from git_remote_cvs/cvs_revision_map.py
rename to git_remote_helpers/cvs/revision_map.py
index 0e65ba6..b7b17bc 100644
--- a/git_remote_cvs/cvs_revision_map.py
+++ b/git_remote_helpers/cvs/revision_map.py
@@ -18,9 +18,9 @@ CVSStateMap - provides a mapping from CVS states to corresponding
 
 import os
 
-from git_remote_cvs.util import debug, error, die, file_reader_method
-from git_remote_cvs.cvs import CVSNum, CVSDate
-from git_remote_cvs.git import GitFICommit
+from git_remote_helpers.util import debug, error, die, file_reader_method
+from git_remote_helpers.cvs.cvs import CVSNum, CVSDate
+from git_remote_helpers.git.git import GitFICommit
 
 
 class _CVSPathInfo(object):
diff --git a/git_remote_cvs/cvs_symbol_cache.py b/git_remote_helpers/cvs/symbol_cache.py
similarity index 98%
rename from git_remote_cvs/cvs_symbol_cache.py
rename to git_remote_helpers/cvs/symbol_cache.py
index cc8d88b..6bd1715 100644
--- a/git_remote_cvs/cvs_symbol_cache.py
+++ b/git_remote_helpers/cvs/symbol_cache.py
@@ -23,8 +23,8 @@ synchronizing _all_ CVS symbols in one operation (by executing
 import sys
 import os
 
-from git_remote_cvs.util import debug, error, die, ProgressIndicator
-from git_remote_cvs.cvs import CVSNum, CVSState, CVSLogParser
+from git_remote_helpers.util import debug, error, die, ProgressIndicator
+from git_remote_helpers.cvs.cvs import CVSNum, CVSState, CVSLogParser
 
 
 class CVSSymbolStateLister(CVSLogParser):
diff --git a/git_remote_helpers/git/__init__.py b/git_remote_helpers/git/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/git_remote_cvs/git.py b/git_remote_helpers/git/git.py
similarity index 99%
rename from git_remote_cvs/git.py
rename to git_remote_helpers/git/git.py
index cf037e3..8e1bc77 100644
--- a/git_remote_cvs/git.py
+++ b/git_remote_helpers/git/git.py
@@ -12,8 +12,8 @@ from binascii import hexlify
 from cStringIO import StringIO
 import unittest
 
-from git_remote_cvs.util import debug, error, die, start_command, run_command
-from git_remote_cvs.cvs import CVSDate
+from git_remote_helpers.util import debug, error, die, start_command, run_command
+from git_remote_helpers.cvs.cvs import CVSDate
 
 
 def get_git_dir ():
diff --git a/git_remote_helpers/setup.py b/git_remote_helpers/setup.py
new file mode 100644
index 0000000..327f0ff
--- /dev/null
+++ b/git_remote_helpers/setup.py
@@ -0,0 +1,17 @@
+#!/usr/bin/env python
+
+"""Distutils build/install script for the git_remote_helpers package."""
+
+from distutils.core import setup
+
+setup(
+    name = 'git_remote_helpers',
+    version = '0.1.0',
+    description = 'Git remote helper program for non-git repositories',
+    license = 'GPLv2',
+    author = 'The Git Community',
+    author_email = 'git@vger.kernel.org',
+    url = 'http://www.git-scm.com/',
+    package_dir = {'git_remote_helpers': ''},
+    packages = ['git_remote_helpers', 'git_remote_helpers.git', 'git_remote_helpers.cvs'],
+)
diff --git a/git_remote_cvs/util.py b/git_remote_helpers/util.py
similarity index 100%
rename from git_remote_cvs/util.py
rename to git_remote_helpers/util.py
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 5cd2b1c..20216a5 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -637,9 +637,9 @@ test -d ../templates/blt || {
 
 if test -z "$GIT_TEST_INSTALLED"
 then
-	GITPYTHONLIB="$(pwd)/../git_remote_cvs/build/lib"
+	GITPYTHONLIB="$(pwd)/../git_remote_helpers/build/lib"
 	export GITPYTHONLIB
-	test -d ../git_remote_cvs/build || {
+	test -d ../git_remote_helpers/build || {
 		error "You haven't built git_remote_cvs yet, have you?"
 	}
 fi
-- 
1.6.5.2.291.gf76a3
