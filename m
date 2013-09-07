From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] git_remote_helpers: remove little used Python library
Date: Sat,  7 Sep 2013 17:19:29 +0100
Message-ID: <23afa908bb2e21779ea96da8c149dcc43aa72eda.1378570768.git.john@keeping.me.uk>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 07 18:19:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VILEn-0004My-GH
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 18:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188Ab3IGQTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 12:19:49 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:52338 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881Ab3IGQTp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 12:19:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 23A80CDA4DF;
	Sat,  7 Sep 2013 17:19:45 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jO1nijmiMDV0; Sat,  7 Sep 2013 17:19:41 +0100 (BST)
Received: from river.lan (mukota.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id ADDC6CDA59F;
	Sat,  7 Sep 2013 17:19:35 +0100 (BST)
X-Mailer: git-send-email 1.8.4.239.g2332621
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234137>

When it was originally added, the git_remote_helpers library was used as
part of the tests of the remote-helper interface, but since commit
fc407f9 (Add new simplified git-remote-testgit, 2012-11-28) a simple
shell script is used for this.

A search on Ohloh [1] indicates that this library isn't used by any
external projects and even the Python remote helpers in contrib/ don't
use this library, so it is only used by its own test suite.

Since this is the only Python library in Git, removing it will make
packaging easier as the Python scripts only need to be installed for one
version of Python, whereas the library should be installed for all
available versions.

[1] http://code.ohloh.net/search?s=%22git_remote_helpers%22

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Makefile                            |  16 -
 git-remote-testpy.py                | 305 ----------------
 git_remote_helpers/.gitignore       |   3 -
 git_remote_helpers/Makefile         |  45 ---
 git_remote_helpers/__init__.py      |  16 -
 git_remote_helpers/git/__init__.py  |   5 -
 git_remote_helpers/git/exporter.py  |  58 ---
 git_remote_helpers/git/git.py       | 678 ------------------------------------
 git_remote_helpers/git/importer.py  |  69 ----
 git_remote_helpers/git/non_local.py |  61 ----
 git_remote_helpers/git/repo.py      |  76 ----
 git_remote_helpers/setup.cfg        |   3 -
 git_remote_helpers/setup.py         |  27 --
 git_remote_helpers/util.py          | 275 ---------------
 t/t5800-remote-testpy.sh            | 169 ---------
 t/test-lib.sh                       |   9 -
 16 files changed, 1815 deletions(-)
 delete mode 100644 git-remote-testpy.py
 delete mode 100644 git_remote_helpers/.gitignore
 delete mode 100644 git_remote_helpers/Makefile
 delete mode 100644 git_remote_helpers/__init__.py
 delete mode 100644 git_remote_helpers/git/__init__.py
 delete mode 100644 git_remote_helpers/git/exporter.py
 delete mode 100644 git_remote_helpers/git/git.py
 delete mode 100644 git_remote_helpers/git/importer.py
 delete mode 100644 git_remote_helpers/git/non_local.py
 delete mode 100644 git_remote_helpers/git/repo.py
 delete mode 100644 git_remote_helpers/setup.cfg
 delete mode 100644 git_remote_helpers/setup.py
 delete mode 100644 git_remote_helpers/util.py
 delete mode 100755 t/t5800-remote-testpy.sh

diff --git a/Makefile b/Makefile
index 7051956..4fd6815 100644
--- a/Makefile
+++ b/Makefile
@@ -488,11 +488,9 @@ SCRIPT_PERL += git-relink.perl
 SCRIPT_PERL += git-send-email.perl
 SCRIPT_PERL += git-svn.perl
 
-SCRIPT_PYTHON += git-remote-testpy.py
 SCRIPT_PYTHON += git-p4.py
 
 NO_INSTALL += git-remote-testgit
-NO_INSTALL += git-remote-testpy
 
 # Generated files for scripts
 SCRIPT_SH_GEN = $(patsubst %.sh,%,$(SCRIPT_SH))
@@ -1670,9 +1668,6 @@ endif
 ifndef NO_PERL
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' localedir='$(localedir_SQ)' all
 endif
-ifndef NO_PYTHON
-	$(QUIET_SUBDIR0)git_remote_helpers $(QUIET_SUBDIR1) PYTHON_PATH='$(PYTHON_PATH_SQ)' prefix='$(prefix_SQ)' all
-endif
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) SHELL_PATH='$(SHELL_PATH_SQ)' PERL_PATH='$(PERL_PATH_SQ)'
 
 please_set_SHELL_PATH_to_a_more_modern_shell:
@@ -1840,12 +1835,7 @@ ifndef NO_PYTHON
 $(SCRIPT_PYTHON_GEN): GIT-CFLAGS GIT-PREFIX GIT-PYTHON-VARS
 $(SCRIPT_PYTHON_GEN): % : %.py
 	$(QUIET_GEN)$(RM) $@ $@+ && \
-	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C git_remote_helpers -s \
-		--no-print-directory prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' \
-		instlibdir` && \
 	sed -e '1s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
-	    -e 's|\(os\.getenv("GITPYTHONLIB"\)[^)]*)|\1,"@@INSTLIBDIR@@")|' \
-	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
 	    $< >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
@@ -2352,9 +2342,6 @@ ifndef NO_PERL
 	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
 	$(MAKE) -C gitweb install
 endif
-ifndef NO_PYTHON
-	$(MAKE) -C git_remote_helpers prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
-endif
 ifndef NO_TCLTK
 	$(MAKE) -C gitk-git install
 	$(MAKE) -C git-gui gitexecdir='$(gitexec_instdir_SQ)' install
@@ -2502,9 +2489,6 @@ ifndef NO_PERL
 	$(MAKE) -C gitweb clean
 	$(MAKE) -C perl clean
 endif
-ifndef NO_PYTHON
-	$(MAKE) -C git_remote_helpers clean
-endif
 	$(MAKE) -C templates/ clean
 	$(MAKE) -C t/ clean
 ifndef NO_TCLTK
diff --git a/git-remote-testpy.py b/git-remote-testpy.py
deleted file mode 100644
index ca67899..0000000
--- a/git-remote-testpy.py
+++ /dev/null
@@ -1,305 +0,0 @@
-#!/usr/bin/env python
-
-# This command is a simple remote-helper, that is used both as a
-# testcase for the remote-helper functionality, and as an example to
-# show remote-helper authors one possible implementation.
-#
-# This is a Git <-> Git importer/exporter, that simply uses git
-# fast-import and git fast-export to consume and produce fast-import
-# streams.
-#
-# To understand better the way things work, one can activate debug
-# traces by setting (to any value) the environment variables
-# GIT_TRANSPORT_HELPER_DEBUG and GIT_DEBUG_TESTGIT, to see messages
-# from the transport-helper side, or from this example remote-helper.
-
-# hashlib is only available in python >= 2.5
-try:
-    import hashlib
-    _digest = hashlib.sha1
-except ImportError:
-    import sha
-    _digest = sha.new
-import sys
-import os
-import time
-sys.path.insert(0, os.getenv("GITPYTHONLIB","."))
-
-from git_remote_helpers.util import die, debug, warn
-from git_remote_helpers.git.repo import GitRepo
-from git_remote_helpers.git.exporter import GitExporter
-from git_remote_helpers.git.importer import GitImporter
-from git_remote_helpers.git.non_local import NonLocalGit
-
-if sys.hexversion < 0x02000000:
-    # string.encode() is the limiter
-    sys.stderr.write("git-remote-testgit: requires Python 2.0 or later.\n")
-    sys.exit(1)
-
-
-def encode_filepath(path):
-    """Encodes a Unicode file path to a byte string.
-
-    On Python 2 this is a no-op; on Python 3 we encode the string as
-    suggested by [1] which allows an exact round-trip from the command line
-    to the filesystem.
-
-    [1] http://docs.python.org/3/c-api/unicode.html#file-system-encoding
-
-    """
-    if sys.hexversion < 0x03000000:
-        return path
-    return path.encode(sys.getfilesystemencoding(), 'surrogateescape')
-
-
-def get_repo(alias, url):
-    """Returns a git repository object initialized for usage.
-    """
-
-    repo = GitRepo(url)
-    repo.get_revs()
-    repo.get_head()
-
-    hasher = _digest()
-    hasher.update(encode_filepath(repo.path))
-    repo.hash = hasher.hexdigest()
-
-    repo.get_base_path = lambda base: os.path.join(
-        base, 'info', 'fast-import', repo.hash)
-
-    prefix = 'refs/testgit/%s/' % alias
-    debug("prefix: '%s'", prefix)
-
-    repo.gitdir = os.environ["GIT_DIR"]
-    repo.alias = alias
-    repo.prefix = prefix
-
-    repo.exporter = GitExporter(repo)
-    repo.importer = GitImporter(repo)
-    repo.non_local = NonLocalGit(repo)
-
-    return repo
-
-
-def local_repo(repo, path):
-    """Returns a git repository object initalized for usage.
-    """
-
-    local = GitRepo(path)
-
-    local.non_local = None
-    local.gitdir = repo.gitdir
-    local.alias = repo.alias
-    local.prefix = repo.prefix
-    local.hash = repo.hash
-    local.get_base_path = repo.get_base_path
-    local.exporter = GitExporter(local)
-    local.importer = GitImporter(local)
-
-    return local
-
-
-def do_capabilities(repo, args):
-    """Prints the supported capabilities.
-    """
-
-    print("import")
-    print("export")
-    print("refspec refs/heads/*:%s*" % repo.prefix)
-
-    dirname = repo.get_base_path(repo.gitdir)
-
-    if not os.path.exists(dirname):
-        os.makedirs(dirname)
-
-    path = os.path.join(dirname, 'git.marks')
-
-    print("*export-marks %s" % path)
-    if os.path.exists(path):
-        print("*import-marks %s" % path)
-
-    print('') # end capabilities
-
-
-def do_list(repo, args):
-    """Lists all known references.
-
-    Bug: This will always set the remote head to master for non-local
-    repositories, since we have no way of determining what the remote
-    head is at clone time.
-    """
-
-    for ref in repo.revs:
-        debug("? refs/heads/%s", ref)
-        print("? refs/heads/%s" % ref)
-
-    if repo.head:
-        debug("@refs/heads/%s HEAD" % repo.head)
-        print("@refs/heads/%s HEAD" % repo.head)
-    else:
-        debug("@refs/heads/master HEAD")
-        print("@refs/heads/master HEAD")
-
-    print('') # end list
-
-
-def update_local_repo(repo):
-    """Updates (or clones) a local repo.
-    """
-
-    if repo.local:
-        return repo
-
-    path = repo.non_local.clone(repo.gitdir)
-    repo.non_local.update(repo.gitdir)
-    repo = local_repo(repo, path)
-    return repo
-
-
-def do_import(repo, args):
-    """Exports a fast-import stream from testgit for git to import.
-    """
-
-    if len(args) != 1:
-        die("Import needs exactly one ref")
-
-    if not repo.gitdir:
-        die("Need gitdir to import")
-
-    ref = args[0]
-    refs = [ref]
-
-    while True:
-        line = sys.stdin.readline().decode()
-        if line == '\n':
-            break
-        if not line.startswith('import '):
-            die("Expected import line.")
-
-        # strip of leading 'import '
-        ref = line[7:].strip()
-        refs.append(ref)
-
-    print("feature done")
-
-    if os.environ.get("GIT_REMOTE_TESTGIT_FAILURE"):
-        die('Told to fail')
-
-    repo = update_local_repo(repo)
-    repo.exporter.export_repo(repo.gitdir, refs)
-
-    print("done")
-
-
-def do_export(repo, args):
-    """Imports a fast-import stream from git to testgit.
-    """
-
-    if not repo.gitdir:
-        die("Need gitdir to export")
-
-    if os.environ.get("GIT_REMOTE_TESTGIT_FAILURE"):
-        die('Told to fail')
-
-    update_local_repo(repo)
-    changed = repo.importer.do_import(repo.gitdir)
-
-    if not repo.local:
-        repo.non_local.push(repo.gitdir)
-
-    for ref in changed:
-        print("ok %s" % ref)
-    print('')
-
-
-COMMANDS = {
-    'capabilities': do_capabilities,
-    'list': do_list,
-    'import': do_import,
-    'export': do_export,
-}
-
-
-def sanitize(value):
-    """Cleans up the url.
-    """
-
-    if value.startswith('testgit::'):
-        value = value[9:]
-
-    return value
-
-
-def read_one_line(repo):
-    """Reads and processes one command.
-    """
-
-    sleepy = os.environ.get("GIT_REMOTE_TESTGIT_SLEEPY")
-    if sleepy:
-        debug("Sleeping %d sec before readline" % int(sleepy))
-        time.sleep(int(sleepy))
-
-    line = sys.stdin.readline()
-
-    cmdline = line.decode()
-
-    if not cmdline:
-        warn("Unexpected EOF")
-        return False
-
-    cmdline = cmdline.strip().split()
-    if not cmdline:
-        # Blank line means we're about to quit
-        return False
-
-    cmd = cmdline.pop(0)
-    debug("Got command '%s' with args '%s'", cmd, ' '.join(cmdline))
-
-    if cmd not in COMMANDS:
-        die("Unknown command, %s", cmd)
-
-    func = COMMANDS[cmd]
-    func(repo, cmdline)
-    sys.stdout.flush()
-
-    return True
-
-
-def main(args):
-    """Starts a new remote helper for the specified repository.
-    """
-
-    if len(args) != 3:
-        die("Expecting exactly three arguments.")
-        sys.exit(1)
-
-    if os.getenv("GIT_DEBUG_TESTGIT"):
-        import git_remote_helpers.util
-        git_remote_helpers.util.DEBUG = True
-
-    alias = sanitize(args[1])
-    url = sanitize(args[2])
-
-    if not alias.isalnum():
-        warn("non-alnum alias '%s'", alias)
-        alias = "tmp"
-
-    args[1] = alias
-    args[2] = url
-
-    repo = get_repo(alias, url)
-
-    debug("Got arguments %s", args[1:])
-
-    more = True
-
-    # Use binary mode since Python 3 does not permit unbuffered I/O in text
-    # mode.  Unbuffered I/O is required to avoid data that should be going
-    # to git-fast-import after an "export" command getting caught in our
-    # stdin buffer instead.
-    sys.stdin = os.fdopen(sys.stdin.fileno(), 'rb', 0)
-    while (more):
-        more = read_one_line(repo)
-
-if __name__ == '__main__':
-    sys.exit(main(sys.argv))
diff --git a/git_remote_helpers/.gitignore b/git_remote_helpers/.gitignore
deleted file mode 100644
index cf040af..0000000
--- a/git_remote_helpers/.gitignore
+++ /dev/null
@@ -1,3 +0,0 @@
-/GIT-PYTHON-VERSION
-/build
-/dist
diff --git a/git_remote_helpers/Makefile b/git_remote_helpers/Makefile
deleted file mode 100644
index 3d12232..0000000
--- a/git_remote_helpers/Makefile
+++ /dev/null
@@ -1,45 +0,0 @@
-#
-# Makefile for the git_remote_helpers python support modules
-#
-pysetupfile:=setup.py
-
-# Shell quote (do not use $(call) to accommodate ancient setups);
-DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
-
-ifndef PYTHON_PATH
-	ifeq ($(uname_S),FreeBSD)
-		PYTHON_PATH = /usr/local/bin/python
-	else
-		PYTHON_PATH = /usr/bin/python
-	endif
-endif
-ifndef prefix
-	prefix = $(HOME)
-endif
-ifndef V
-	QUIET = @
-	QUIETSETUP = --quiet
-endif
-
-PYLIBDIR=$(shell $(PYTHON_PATH) -c \
-	 "import sys; \
-	 print('lib/python%i.%i/site-packages' % sys.version_info[:2])")
-
-py_version=$(shell $(PYTHON_PATH) -c \
-	'import sys; print("%i.%i" % sys.version_info[:2])')
-
-all: $(pysetupfile)
-	$(QUIET)test "$$(cat GIT-PYTHON-VERSION 2>/dev/null)" = "$(py_version)" || \
-	flags=--force; \
-	$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) build $$flags
-	$(QUIET)echo "$(py_version)" >GIT-PYTHON-VERSION
-
-install: $(pysetupfile)
-	$(PYTHON_PATH) $(pysetupfile) install --prefix $(DESTDIR_SQ)$(prefix)
-
-instlibdir: $(pysetupfile)
-	@echo "$(DESTDIR_SQ)$(prefix)/$(PYLIBDIR)"
-
-clean:
-	$(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) clean -a
-	$(RM) *.pyo *.pyc GIT-PYTHON-VERSION
diff --git a/git_remote_helpers/__init__.py b/git_remote_helpers/__init__.py
deleted file mode 100644
index 00f69cb..0000000
--- a/git_remote_helpers/__init__.py
+++ /dev/null
@@ -1,16 +0,0 @@
-#!/usr/bin/env python
-
-"""Support library package for git remote helpers.
-
-Git remote helpers are helper commands that interfaces with a non-git
-repository to provide automatic import of non-git history into a Git
-repository.
-
-This package provides the support library needed by these helpers..
-The following modules are included:
-
-- git.git - Interaction with Git repositories
-
-- util - General utility functionality use by the other modules in
-         this package, and also used directly by the helpers.
-"""
diff --git a/git_remote_helpers/git/__init__.py b/git_remote_helpers/git/__init__.py
deleted file mode 100644
index 1dbb1b0..0000000
--- a/git_remote_helpers/git/__init__.py
+++ /dev/null
@@ -1,5 +0,0 @@
-import sys
-if sys.hexversion < 0x02040000:
-    # The limiter is the subprocess module
-    sys.stderr.write("git_remote_helpers: requires Python 2.4 or later.\n")
-    sys.exit(1)
diff --git a/git_remote_helpers/git/exporter.py b/git_remote_helpers/git/exporter.py
deleted file mode 100644
index 9ee5f96..0000000
--- a/git_remote_helpers/git/exporter.py
+++ /dev/null
@@ -1,58 +0,0 @@
-import os
-import subprocess
-import sys
-
-from git_remote_helpers.util import check_call
-
-
-class GitExporter(object):
-    """An exporter for testgit repositories.
-
-    The exporter simply delegates to git fast-export.
-    """
-
-    def __init__(self, repo):
-        """Creates a new exporter for the specified repo.
-        """
-
-        self.repo = repo
-
-    def export_repo(self, base, refs=None):
-        """Exports a fast-export stream for the given directory.
-
-        Simply delegates to git fast-epxort and pipes it through sed
-        to make the refs show up under the prefix rather than the
-        default refs/heads. This is to demonstrate how the export
-        data can be stored under it's own ref (using the refspec
-        capability).
-
-        If None, refs defaults to ["HEAD"].
-        """
-
-        if not refs:
-            refs = ["HEAD"]
-
-        dirname = self.repo.get_base_path(base)
-        path = os.path.abspath(os.path.join(dirname, 'testgit.marks'))
-
-        if not os.path.exists(dirname):
-            os.makedirs(dirname)
-
-        print "feature relative-marks"
-        if os.path.exists(os.path.join(dirname, 'git.marks')):
-            print "feature import-marks=%s/git.marks" % self.repo.hash
-        print "feature export-marks=%s/git.marks" % self.repo.hash
-        sys.stdout.flush()
-
-        args = ["git", "--git-dir=" + self.repo.gitpath, "fast-export", "--export-marks=" + path]
-
-        if os.path.exists(path):
-            args.append("--import-marks=" + path)
-
-        args.extend(refs)
-
-        p1 = subprocess.Popen(args, stdout=subprocess.PIPE)
-
-        args = ["sed", "s_refs/heads/_" + self.repo.prefix + "_g"]
-
-        check_call(args, stdin=p1.stdout)
diff --git a/git_remote_helpers/git/git.py b/git_remote_helpers/git/git.py
deleted file mode 100644
index 007a1bf..0000000
--- a/git_remote_helpers/git/git.py
+++ /dev/null
@@ -1,678 +0,0 @@
-#!/usr/bin/env python
-
-"""Functionality for interacting with Git repositories.
-
-This module provides classes for interfacing with a Git repository.
-"""
-
-import os
-import re
-import time
-from binascii import hexlify
-from cStringIO import StringIO
-import unittest
-
-from git_remote_helpers.util import debug, error, die, start_command, run_command
-
-
-def get_git_dir ():
-    """Return the path to the GIT_DIR for this repo."""
-    args = ("git", "rev-parse", "--git-dir")
-    exit_code, output, errors = run_command(args)
-    if exit_code:
-        die("Failed to retrieve git dir")
-    assert not errors
-    return output.strip()
-
-
-def parse_git_config ():
-    """Return a dict containing the parsed version of 'git config -l'."""
-    exit_code, output, errors = run_command(("git", "config", "-z", "-l"))
-    if exit_code:
-        die("Failed to retrieve git configuration")
-    assert not errors
-    return dict([e.split('\n', 1) for e in output.split("\0") if e])
-
-
-def git_config_bool (value):
-    """Convert the given git config string value to True or False.
-
-    Raise ValueError if the given string was not recognized as a
-    boolean value.
-
-    """
-    norm_value = str(value).strip().lower()
-    if norm_value in ("true", "1", "yes", "on", ""):
-        return True
-    if norm_value in ("false", "0", "no", "off", "none"):
-        return False
-    raise ValueError("Failed to parse '%s' into a boolean value" % (value))
-
-
-def valid_git_ref (ref_name):
-    """Return True iff the given ref name is a valid git ref name."""
-    # The following is a reimplementation of the git check-ref-format
-    # command.  The rules were derived from the git check-ref-format(1)
-    # manual page.  This code should be replaced by a call to
-    # check_refname_format() in the git library, when such is available.
-    if ref_name.endswith('/') or \
-       ref_name.startswith('.') or \
-       ref_name.count('/.') or \
-       ref_name.count('..') or \
-       ref_name.endswith('.lock'):
-        return False
-    for c in ref_name:
-        if ord(c) < 0x20 or ord(c) == 0x7f or c in " ~^:?*[":
-            return False
-    return True
-
-
-class GitObjectFetcher(object):
-
-    """Provide parsed access to 'git cat-file --batch'.
-
-    This provides a read-only interface to the Git object database.
-
-    """
-
-    def __init__ (self):
-        """Initiate a 'git cat-file --batch' session."""
-        self.queue = []  # List of object names to be submitted
-        self.in_transit = None  # Object name currently in transit
-
-        # 'git cat-file --batch' produces binary output which is likely
-        # to be corrupted by the default "rU"-mode pipe opened by
-        # start_command.  (Mode == "rU" does universal new-line
-        # conversion, which mangles carriage returns.) Therefore, we
-        # open an explicitly binary-safe pipe for transferring the
-        # output from 'git cat-file --batch'.
-        pipe_r_fd, pipe_w_fd = os.pipe()
-        pipe_r = os.fdopen(pipe_r_fd, "rb")
-        pipe_w = os.fdopen(pipe_w_fd, "wb")
-        self.proc = start_command(("git", "cat-file", "--batch"),
-                                  stdout = pipe_w)
-        self.f = pipe_r
-
-    def __del__ (self):
-        """Verify completed communication with 'git cat-file --batch'."""
-        assert not self.queue
-        assert self.in_transit is None
-        self.proc.stdin.close()
-        assert self.proc.wait() == 0  # Zero exit code
-        assert self.f.read() == ""  # No remaining output
-
-    def _submit_next_object (self):
-        """Submit queue items to the 'git cat-file --batch' process.
-
-        If there are items in the queue, and there is currently no item
-        currently in 'transit', then pop the first item off the queue,
-        and submit it.
-
-        """
-        if self.queue and self.in_transit is None:
-            self.in_transit = self.queue.pop(0)
-            print >> self.proc.stdin, self.in_transit[0]
-
-    def push (self, obj, callback):
-        """Push the given object name onto the queue.
-
-        The given callback function will at some point in the future
-        be called exactly once with the following arguments:
-        - self - this GitObjectFetcher instance
-        - obj  - the object name provided to push()
-        - sha1 - the SHA1 of the object, if 'None' obj is missing
-        - t    - the type of the object (tag/commit/tree/blob)
-        - size - the size of the object in bytes
-        - data - the object contents
-
-        """
-        self.queue.append((obj, callback))
-        self._submit_next_object()  # (Re)start queue processing
-
-    def process_next_entry (self):
-        """Read the next entry off the queue and invoke callback."""
-        obj, cb = self.in_transit
-        self.in_transit = None
-        header = self.f.readline()
-        if header == "%s missing\n" % (obj):
-            cb(self, obj, None, None, None, None)
-            return
-        sha1, t, size = header.split(" ")
-        assert len(sha1) == 40
-        assert t in ("tag", "commit", "tree", "blob")
-        assert size.endswith("\n")
-        size = int(size.strip())
-        data = self.f.read(size)
-        assert self.f.read(1) == "\n"
-        cb(self, obj, sha1, t, size, data)
-        self._submit_next_object()
-
-    def process (self):
-        """Process the current queue until empty."""
-        while self.in_transit is not None:
-            self.process_next_entry()
-
-    # High-level convenience methods:
-
-    def get_sha1 (self, objspec):
-        """Return the SHA1 of the object specified by 'objspec'.
-
-        Return None if 'objspec' does not specify an existing object.
-
-        """
-        class _ObjHandler(object):
-            """Helper class for getting the returned SHA1."""
-            def __init__ (self, parser):
-                self.parser = parser
-                self.sha1 = None
-
-            def __call__ (self, parser, obj, sha1, t, size, data):
-                # FIXME: Many unused arguments. Could this be cheaper?
-                assert parser == self.parser
-                self.sha1 = sha1
-
-        handler = _ObjHandler(self)
-        self.push(objspec, handler)
-        self.process()
-        return handler.sha1
-
-    def open_obj (self, objspec):
-        """Return a file object wrapping the contents of a named object.
-
-        The caller is responsible for calling .close() on the returned
-        file object.
-
-        Raise KeyError if 'objspec' does not exist in the repo.
-
-        """
-        class _ObjHandler(object):
-            """Helper class for parsing the returned git object."""
-            def __init__ (self, parser):
-                """Set up helper."""
-                self.parser = parser
-                self.contents = StringIO()
-                self.err = None
-
-            def __call__ (self, parser, obj, sha1, t, size, data):
-                """Git object callback (see GitObjectFetcher documentation)."""
-                assert parser == self.parser
-                if not sha1:  # Missing object
-                    self.err = "Missing object '%s'" % obj
-                else:
-                    assert size == len(data)
-                    self.contents.write(data)
-
-        handler = _ObjHandler(self)
-        self.push(objspec, handler)
-        self.process()
-        if handler.err:
-            raise KeyError(handler.err)
-        handler.contents.seek(0)
-        return handler.contents
-
-    def walk_tree (self, tree_objspec, callback, prefix = ""):
-        """Recursively walk the given Git tree object.
-
-        Recursively walk all subtrees of the given tree object, and
-        invoke the given callback passing three arguments:
-        (path, mode, data) with the path, permission bits, and contents
-        of all the blobs found in the entire tree structure.
-
-        """
-        class _ObjHandler(object):
-            """Helper class for walking a git tree structure."""
-            def __init__ (self, parser, cb, path, mode = None):
-                """Set up helper."""
-                self.parser = parser
-                self.cb = cb
-                self.path = path
-                self.mode = mode
-                self.err = None
-
-            def parse_tree (self, treedata):
-                """Parse tree object data, yield tree entries.
-
-                Each tree entry is a 3-tuple (mode, sha1, path)
-
-                self.path is prepended to all paths yielded
-                from this method.
-
-                """
-                while treedata:
-                    mode = int(treedata[:6], 10)
-                    # Turn 100xxx into xxx
-                    if mode > 100000:
-                        mode -= 100000
-                    assert treedata[6] == " "
-                    i = treedata.find("\0", 7)
-                    assert i > 0
-                    path = treedata[7:i]
-                    sha1 = hexlify(treedata[i + 1: i + 21])
-                    yield (mode, sha1, self.path + path)
-                    treedata = treedata[i + 21:]
-
-            def __call__ (self, parser, obj, sha1, t, size, data):
-                """Git object callback (see GitObjectFetcher documentation)."""
-                assert parser == self.parser
-                if not sha1:  # Missing object
-                    self.err = "Missing object '%s'" % (obj)
-                    return
-                assert size == len(data)
-                if t == "tree":
-                    if self.path:
-                        self.path += "/"
-                    # Recurse into all blobs and subtrees
-                    for m, s, p in self.parse_tree(data):
-                        parser.push(s,
-                                    self.__class__(self.parser, self.cb, p, m))
-                elif t == "blob":
-                    self.cb(self.path, self.mode, data)
-                else:
-                    raise ValueError("Unknown object type '%s'" % (t))
-
-        self.push(tree_objspec, _ObjHandler(self, callback, prefix))
-        self.process()
-
-
-class GitRefMap(object):
-
-    """Map Git ref names to the Git object names they currently point to.
-
-    Behaves like a dictionary of Git ref names -> Git object names.
-
-    """
-
-    def __init__ (self, obj_fetcher):
-        """Create a new Git ref -> object map."""
-        self.obj_fetcher = obj_fetcher
-        self._cache = {}  # dict: refname -> objname
-
-    def _load (self, ref):
-        """Retrieve the object currently bound to the given ref.
-
-        The name of the object pointed to by the given ref is stored
-        into this mapping, and also returned.
-
-        """
-        if ref not in self._cache:
-            self._cache[ref] = self.obj_fetcher.get_sha1(ref)
-        return self._cache[ref]
-
-    def __contains__ (self, refname):
-        """Return True if the given refname is present in this cache."""
-        return bool(self._load(refname))
-
-    def __getitem__ (self, refname):
-        """Return the git object name pointed to by the given refname."""
-        commit = self._load(refname)
-        if commit is None:
-            raise KeyError("Unknown ref '%s'" % (refname))
-        return commit
-
-    def get (self, refname, default = None):
-        """Return the git object name pointed to by the given refname."""
-        commit = self._load(refname)
-        if commit is None:
-            return default
-        return commit
-
-
-class GitFICommit(object):
-
-    """Encapsulate the data in a Git fast-import commit command."""
-
-    SHA1RE = re.compile(r'^[0-9a-f]{40}$')
-
-    @classmethod
-    def parse_mode (cls, mode):
-        """Verify the given git file mode, and return it as a string."""
-        assert mode in (644, 755, 100644, 100755, 120000)
-        return "%i" % (mode)
-
-    @classmethod
-    def parse_objname (cls, objname):
-        """Return the given object name (or mark number) as a string."""
-        if isinstance(objname, int):  # Object name is a mark number
-            assert objname > 0
-            return ":%i" % (objname)
-
-        # No existence check is done, only checks for valid format
-        assert cls.SHA1RE.match(objname)  # Object name is valid SHA1
-        return objname
-
-    @classmethod
-    def quote_path (cls, path):
-        """Return a quoted version of the given path."""
-        path = path.replace("\\", "\\\\")
-        path = path.replace("\n", "\\n")
-        path = path.replace('"', '\\"')
-        return '"%s"' % (path)
-
-    @classmethod
-    def parse_path (cls, path):
-        """Verify that the given path is valid, and quote it, if needed."""
-        assert not isinstance(path, int)  # Cannot be a mark number
-
-        # These checks verify the rules on the fast-import man page
-        assert not path.count("//")
-        assert not path.endswith("/")
-        assert not path.startswith("/")
-        assert not path.count("/./")
-        assert not path.count("/../")
-        assert not path.endswith("/.")
-        assert not path.endswith("/..")
-        assert not path.startswith("./")
-        assert not path.startswith("../")
-
-        if path.count('"') + path.count('\n') + path.count('\\'):
-            return cls.quote_path(path)
-        return path
-
-    def __init__ (self, name, email, timestamp, timezone, message):
-        """Create a new Git fast-import commit, with the given metadata."""
-        self.name = name
-        self.email = email
-        self.timestamp = timestamp
-        self.timezone = timezone
-        self.message = message
-        self.pathops = []  # List of path operations in this commit
-
-    def modify (self, mode, blobname, path):
-        """Add a file modification to this Git fast-import commit."""
-        self.pathops.append(("M",
-                             self.parse_mode(mode),
-                             self.parse_objname(blobname),
-                             self.parse_path(path)))
-
-    def delete (self, path):
-        """Add a file deletion to this Git fast-import commit."""
-        self.pathops.append(("D", self.parse_path(path)))
-
-    def copy (self, path, newpath):
-        """Add a file copy to this Git fast-import commit."""
-        self.pathops.append(("C",
-                             self.parse_path(path),
-                             self.parse_path(newpath)))
-
-    def rename (self, path, newpath):
-        """Add a file rename to this Git fast-import commit."""
-        self.pathops.append(("R",
-                             self.parse_path(path),
-                             self.parse_path(newpath)))
-
-    def note (self, blobname, commit):
-        """Add a note object to this Git fast-import commit."""
-        self.pathops.append(("N",
-                             self.parse_objname(blobname),
-                             self.parse_objname(commit)))
-
-    def deleteall (self):
-        """Delete all files in this Git fast-import commit."""
-        self.pathops.append("deleteall")
-
-
-class TestGitFICommit(unittest.TestCase):
-
-    """GitFICommit selftests."""
-
-    def test_basic (self):
-        """GitFICommit basic selftests."""
-
-        def expect_fail (method, data):
-            """Verify that the method(data) raises an AssertionError."""
-            try:
-                method(data)
-            except AssertionError:
-                return
-            raise AssertionError("Failed test for invalid data '%s(%s)'" %
-                                 (method.__name__, repr(data)))
-
-    def test_parse_mode (self):
-        """GitFICommit.parse_mode() selftests."""
-        self.assertEqual(GitFICommit.parse_mode(644), "644")
-        self.assertEqual(GitFICommit.parse_mode(755), "755")
-        self.assertEqual(GitFICommit.parse_mode(100644), "100644")
-        self.assertEqual(GitFICommit.parse_mode(100755), "100755")
-        self.assertEqual(GitFICommit.parse_mode(120000), "120000")
-        self.assertRaises(AssertionError, GitFICommit.parse_mode, 0)
-        self.assertRaises(AssertionError, GitFICommit.parse_mode, 123)
-        self.assertRaises(AssertionError, GitFICommit.parse_mode, 600)
-        self.assertRaises(AssertionError, GitFICommit.parse_mode, "644")
-        self.assertRaises(AssertionError, GitFICommit.parse_mode, "abc")
-
-    def test_parse_objname (self):
-        """GitFICommit.parse_objname() selftests."""
-        self.assertEqual(GitFICommit.parse_objname(1), ":1")
-        self.assertRaises(AssertionError, GitFICommit.parse_objname, 0)
-        self.assertRaises(AssertionError, GitFICommit.parse_objname, -1)
-        self.assertEqual(GitFICommit.parse_objname("0123456789" * 4),
-                         "0123456789" * 4)
-        self.assertEqual(GitFICommit.parse_objname("2468abcdef" * 4),
-                         "2468abcdef" * 4)
-        self.assertRaises(AssertionError, GitFICommit.parse_objname,
-                          "abcdefghij" * 4)
-
-    def test_parse_path (self):
-        """GitFICommit.parse_path() selftests."""
-        self.assertEqual(GitFICommit.parse_path("foo/bar"), "foo/bar")
-        self.assertEqual(GitFICommit.parse_path("path/with\n and \" in it"),
-                         '"path/with\\n and \\" in it"')
-        self.assertRaises(AssertionError, GitFICommit.parse_path, 1)
-        self.assertRaises(AssertionError, GitFICommit.parse_path, 0)
-        self.assertRaises(AssertionError, GitFICommit.parse_path, -1)
-        self.assertRaises(AssertionError, GitFICommit.parse_path, "foo//bar")
-        self.assertRaises(AssertionError, GitFICommit.parse_path, "foo/bar/")
-        self.assertRaises(AssertionError, GitFICommit.parse_path, "/foo/bar")
-        self.assertRaises(AssertionError, GitFICommit.parse_path, "foo/./bar")
-        self.assertRaises(AssertionError, GitFICommit.parse_path, "foo/../bar")
-        self.assertRaises(AssertionError, GitFICommit.parse_path, "foo/bar/.")
-        self.assertRaises(AssertionError, GitFICommit.parse_path, "foo/bar/..")
-        self.assertRaises(AssertionError, GitFICommit.parse_path, "./foo/bar")
-        self.assertRaises(AssertionError, GitFICommit.parse_path, "../foo/bar")
-
-
-class GitFastImport(object):
-
-    """Encapsulate communication with git fast-import."""
-
-    def __init__ (self, f, obj_fetcher, last_mark = 0):
-        """Set up self to communicate with a fast-import process through f."""
-        self.f = f  # File object where fast-import stream is written
-        self.obj_fetcher = obj_fetcher  # GitObjectFetcher instance
-        self.next_mark = last_mark + 1  # Next mark number
-        self.refs = set()  # Keep track of the refnames we've seen
-
-    def comment (self, s):
-        """Write the given comment in the fast-import stream."""
-        assert "\n" not in s, "Malformed comment: '%s'" % (s)
-        self.f.write("# %s\n" % (s))
-
-    def commit (self, ref, commitdata):
-        """Make a commit on the given ref, with the given GitFICommit.
-
-        Return the mark number identifying this commit.
-
-        """
-        self.f.write("""\
-commit %(ref)s
-mark :%(mark)i
-committer %(name)s <%(email)s> %(timestamp)i %(timezone)s
-data %(msgLength)i
-%(msg)s
-""" % {
-    'ref': ref,
-    'mark': self.next_mark,
-    'name': commitdata.name,
-    'email': commitdata.email,
-    'timestamp': commitdata.timestamp,
-    'timezone': commitdata.timezone,
-    'msgLength': len(commitdata.message),
-    'msg': commitdata.message,
-})
-
-        if ref not in self.refs:
-            self.refs.add(ref)
-            parent = ref + "^0"
-            if self.obj_fetcher.get_sha1(parent):
-                self.f.write("from %s\n" % (parent))
-
-        for op in commitdata.pathops:
-            self.f.write(" ".join(op))
-            self.f.write("\n")
-        self.f.write("\n")
-        retval = self.next_mark
-        self.next_mark += 1
-        return retval
-
-    def blob (self, data):
-        """Import the given blob.
-
-        Return the mark number identifying this blob.
-
-        """
-        self.f.write("blob\nmark :%i\ndata %i\n%s\n" %
-                     (self.next_mark, len(data), data))
-        retval = self.next_mark
-        self.next_mark += 1
-        return retval
-
-    def reset (self, ref, objname):
-        """Reset the given ref to point at the given Git object."""
-        self.f.write("reset %s\nfrom %s\n\n" %
-                     (ref, GitFICommit.parse_objname(objname)))
-        if ref not in self.refs:
-            self.refs.add(ref)
-
-
-class GitNotes(object):
-
-    """Encapsulate access to Git notes.
-
-    Simulates a dictionary of object name (SHA1) -> Git note mappings.
-
-    """
-
-    def __init__ (self, notes_ref, obj_fetcher):
-        """Create a new Git notes interface, bound to the given notes ref."""
-        self.notes_ref = notes_ref
-        self.obj_fetcher = obj_fetcher  # Used to get objects from repo
-        self.imports = []  # list: (objname, note data blob name) tuples
-
-    def __del__ (self):
-        """Verify that self.commit_notes() was called before destruction."""
-        if self.imports:
-            error("Missing call to self.commit_notes().")
-            error("%i notes are not committed!", len(self.imports))
-
-    def _load (self, objname):
-        """Return the note data associated with the given git object.
-
-        The note data is returned in string form. If no note is found
-        for the given object, None is returned.
-
-        """
-        try:
-            f = self.obj_fetcher.open_obj("%s:%s" % (self.notes_ref, objname))
-            ret = f.read()
-            f.close()
-        except KeyError:
-            ret = None
-        return ret
-
-    def __getitem__ (self, objname):
-        """Return the note contents associated with the given object.
-
-        Raise KeyError if given object has no associated note.
-
-        """
-        blobdata = self._load(objname)
-        if blobdata is None:
-            raise KeyError("Object '%s' has no note" % (objname))
-        return blobdata
-
-    def get (self, objname, default = None):
-        """Return the note contents associated with the given object.
-
-        Return given default if given object has no associated note.
-
-        """
-        blobdata = self._load(objname)
-        if blobdata is None:
-            return default
-        return blobdata
-
-    def import_note (self, objname, data, gfi):
-        """Tell git fast-import to store data as a note for objname.
-
-        This method uses the given GitFastImport object to create a
-        blob containing the given note data.  Also an entry mapping the
-        given object name to the created blob is stored until
-        commit_notes() is called.
-
-        Note that this method only works if it is later followed by a
-        call to self.commit_notes() (which produces the note commit
-        that refers to the blob produced here).
-
-        """
-        if not data.endswith("\n"):
-            data += "\n"
-        gfi.comment("Importing note for object %s" % (objname))
-        mark = gfi.blob(data)
-        self.imports.append((objname, mark))
-
-    def commit_notes (self, gfi, author, message):
-        """Produce a git fast-import note commit for the imported notes.
-
-        This method uses the given GitFastImport object to create a
-        commit on the notes ref, introducing the notes previously
-        submitted to import_note().
-
-        """
-        if not self.imports:
-            return
-        commitdata = GitFICommit(author[0], author[1],
-                                 time.time(), "0000", message)
-        for objname, blobname in self.imports:
-            assert isinstance(objname, int) and objname > 0
-            assert isinstance(blobname, int) and blobname > 0
-            commitdata.note(blobname, objname)
-        gfi.commit(self.notes_ref, commitdata)
-        self.imports = []
-
-
-class GitCachedNotes(GitNotes):
-
-    """Encapsulate access to Git notes (cached version).
-
-    Only use this class if no caching is done at a higher level.
-
-    Simulates a dictionary of object name (SHA1) -> Git note mappings.
-
-    """
-
-    def __init__ (self, notes_ref, obj_fetcher):
-        """Set up a caching wrapper around GitNotes."""
-        GitNotes.__init__(self, notes_ref, obj_fetcher)
-        self._cache = {}  # Cache: object name -> note data
-
-    def __del__ (self):
-        """Verify that GitNotes' destructor is called."""
-        GitNotes.__del__(self)
-
-    def _load (self, objname):
-        """Extend GitNotes._load() with a local objname -> note cache."""
-        if objname not in self._cache:
-            self._cache[objname] = GitNotes._load(self, objname)
-        return self._cache[objname]
-
-    def import_note (self, objname, data, gfi):
-        """Extend GitNotes.import_note() with a local objname -> note cache."""
-        if not data.endswith("\n"):
-            data += "\n"
-        assert objname not in self._cache
-        self._cache[objname] = data
-        GitNotes.import_note(self, objname, data, gfi)
-
-
-if __name__ == '__main__':
-    unittest.main()
diff --git a/git_remote_helpers/git/importer.py b/git_remote_helpers/git/importer.py
deleted file mode 100644
index d3f90e1..0000000
--- a/git_remote_helpers/git/importer.py
+++ /dev/null
@@ -1,69 +0,0 @@
-import os
-import subprocess
-
-from git_remote_helpers.util import check_call, check_output
-
-
-class GitImporter(object):
-    """An importer for testgit repositories.
-
-    This importer simply delegates to git fast-import.
-    """
-
-    def __init__(self, repo):
-        """Creates a new importer for the specified repo.
-        """
-
-        self.repo = repo
-
-    def get_refs(self, gitdir):
-        """Returns a dictionary with refs.
-
-        Note that the keys in the returned dictionary are byte strings as
-        read from git.
-        """
-        args = ["git", "--git-dir=" + gitdir, "for-each-ref", "refs/heads"]
-        lines = check_output(args).strip().split('\n'.encode('ascii'))
-        refs = {}
-        for line in lines:
-            value, name = line.split(' '.encode('ascii'))
-            name = name.strip('commit\t'.encode('ascii'))
-            refs[name] = value
-        return refs
-
-    def do_import(self, base):
-        """Imports a fast-import stream to the given directory.
-
-        Simply delegates to git fast-import.
-        """
-
-        dirname = self.repo.get_base_path(base)
-        if self.repo.local:
-            gitdir = self.repo.gitpath
-        else:
-            gitdir = os.path.abspath(os.path.join(dirname, '.git'))
-        path = os.path.abspath(os.path.join(dirname, 'testgit.marks'))
-
-        if not os.path.exists(dirname):
-            os.makedirs(dirname)
-
-        refs_before = self.get_refs(gitdir)
-
-        args = ["git", "--git-dir=" + gitdir, "fast-import", "--quiet", "--export-marks=" + path]
-
-        if os.path.exists(path):
-            args.append("--import-marks=" + path)
-
-        check_call(args)
-
-        refs_after = self.get_refs(gitdir)
-
-        changed = {}
-
-        for name, value in refs_after.iteritems():
-            if refs_before.get(name) == value:
-                continue
-
-            changed[name] = value
-
-        return changed
diff --git a/git_remote_helpers/git/non_local.py b/git_remote_helpers/git/non_local.py
deleted file mode 100644
index e700250..0000000
--- a/git_remote_helpers/git/non_local.py
+++ /dev/null
@@ -1,61 +0,0 @@
-import os
-import subprocess
-
-from git_remote_helpers.util import check_call, die, warn
-
-
-class NonLocalGit(object):
-    """Handler to interact with non-local repos.
-    """
-
-    def __init__(self, repo):
-        """Creates a new non-local handler for the specified repo.
-        """
-
-        self.repo = repo
-
-    def clone(self, base):
-        """Clones the non-local repo to base.
-
-        Does nothing if a clone already exists.
-        """
-
-        path = os.path.join(self.repo.get_base_path(base), '.git')
-
-        # already cloned
-        if os.path.exists(path):
-            return path
-
-        os.makedirs(path)
-        args = ["git", "clone", "--bare", "--quiet", self.repo.gitpath, path]
-
-        check_call(args)
-
-        return path
-
-    def update(self, base):
-        """Updates checkout of the non-local repo in base.
-        """
-
-        path = os.path.join(self.repo.get_base_path(base), '.git')
-
-        if not os.path.exists(path):
-            die("could not find repo at %s", path)
-
-        args = ["git", "--git-dir=" + path, "fetch", "--quiet", self.repo.gitpath]
-        check_call(args)
-
-        args = ["git", "--git-dir=" + path, "update-ref", "refs/heads/master", "FETCH_HEAD"]
-        child = check_call(args)
-
-    def push(self, base):
-        """Pushes from the non-local repo to base.
-        """
-
-        path = os.path.join(self.repo.get_base_path(base), '.git')
-
-        if not os.path.exists(path):
-            die("could not find repo at %s", path)
-
-        args = ["git", "--git-dir=" + path, "push", "--quiet", self.repo.gitpath, "--all"]
-        child = check_call(args)
diff --git a/git_remote_helpers/git/repo.py b/git_remote_helpers/git/repo.py
deleted file mode 100644
index acbf8d7..0000000
--- a/git_remote_helpers/git/repo.py
+++ /dev/null
@@ -1,76 +0,0 @@
-import os
-import subprocess
-
-from git_remote_helpers.util import check_call
-
-
-def sanitize(rev, sep='\t'):
-    """Converts a for-each-ref line to a name/value pair.
-    """
-
-    splitrev = rev.split(sep)
-    branchval = splitrev[0]
-    branchname = splitrev[1].strip()
-    if branchname.startswith("refs/heads/"):
-        branchname = branchname[11:]
-
-    return branchname, branchval
-
-def is_remote(url):
-    """Checks whether the specified value is a remote url.
-    """
-
-    prefixes = ["http", "file", "git"]
-
-    for prefix in prefixes:
-        if url.startswith(prefix):
-            return True
-    return False
-
-class GitRepo(object):
-    """Repo object representing a repo.
-    """
-
-    def __init__(self, path):
-        """Initializes a new repo at the given path.
-        """
-
-        self.path = path
-        self.head = None
-        self.revmap = {}
-        self.local = not is_remote(self.path)
-
-        if(self.path.endswith('.git')):
-            self.gitpath = self.path
-        else:
-            self.gitpath = os.path.join(self.path, '.git')
-
-        if self.local and not os.path.exists(self.gitpath):
-            os.makedirs(self.gitpath)
-
-    def get_revs(self):
-        """Fetches all revs from the remote.
-        """
-
-        args = ["git", "ls-remote", self.gitpath]
-        path = ".cached_revs"
-        ofile = open(path, "w")
-
-        check_call(args, stdout=ofile)
-        output = open(path).readlines()
-        self.revmap = dict(sanitize(i) for i in output)
-        if "HEAD" in self.revmap:
-            del self.revmap["HEAD"]
-        self.revs = self.revmap.keys()
-        ofile.close()
-
-    def get_head(self):
-        """Determines the head of a local repo.
-        """
-
-        if not self.local:
-            return
-
-        path = os.path.join(self.gitpath, "HEAD")
-        head = open(path).readline()
-        self.head, _ = sanitize(head, ' ')
diff --git a/git_remote_helpers/setup.cfg b/git_remote_helpers/setup.cfg
deleted file mode 100644
index 4bff887..0000000
--- a/git_remote_helpers/setup.cfg
+++ /dev/null
@@ -1,3 +0,0 @@
-[build]
-build_purelib = build/lib
-build_platlib = build/lib
diff --git a/git_remote_helpers/setup.py b/git_remote_helpers/setup.py
deleted file mode 100644
index 6de41de..0000000
--- a/git_remote_helpers/setup.py
+++ /dev/null
@@ -1,27 +0,0 @@
-#!/usr/bin/env python
-
-"""Distutils build/install script for the git_remote_helpers package."""
-
-from distutils.core import setup
-
-# If building under Python3 we need to run 2to3 on the code, do this by
-# trying to import distutils' 2to3 builder, which is only available in
-# Python3.
-try:
-    from distutils.command.build_py import build_py_2to3 as build_py
-except ImportError:
-    # 2.x
-    from distutils.command.build_py import build_py
-
-setup(
-    name = 'git_remote_helpers',
-    version = '0.1.0',
-    description = 'Git remote helper program for non-git repositories',
-    license = 'GPLv2',
-    author = 'The Git Community',
-    author_email = 'git@vger.kernel.org',
-    url = 'http://www.git-scm.com/',
-    package_dir = {'git_remote_helpers': ''},
-    packages = ['git_remote_helpers', 'git_remote_helpers.git'],
-    cmdclass = {'build_py': build_py},
-)
diff --git a/git_remote_helpers/util.py b/git_remote_helpers/util.py
deleted file mode 100644
index fbbb01b..0000000
--- a/git_remote_helpers/util.py
+++ /dev/null
@@ -1,275 +0,0 @@
-#!/usr/bin/env python
-
-"""Misc. useful functionality used by the rest of this package.
-
-This module provides common functionality used by the other modules in
-this package.
-
-"""
-
-import sys
-import os
-import subprocess
-
-try:
-    from subprocess import CalledProcessError
-except ImportError:
-    # from python2.7:subprocess.py
-    # Exception classes used by this module.
-    class CalledProcessError(Exception):
-        """This exception is raised when a process run by check_call() returns
-        a non-zero exit status.  The exit status will be stored in the
-        returncode attribute."""
-        def __init__(self, returncode, cmd):
-            self.returncode = returncode
-            self.cmd = cmd
-        def __str__(self):
-            return "Command '%s' returned non-zero exit status %d" % (self.cmd, self.returncode)
-
-
-# Whether or not to show debug messages
-DEBUG = False
-
-def notify(msg, *args):
-    """Print a message to stderr."""
-    print >> sys.stderr, msg % args
-
-def debug (msg, *args):
-    """Print a debug message to stderr when DEBUG is enabled."""
-    if DEBUG:
-        print >> sys.stderr, msg % args
-
-def error (msg, *args):
-    """Print an error message to stderr."""
-    print >> sys.stderr, "ERROR:", msg % args
-
-def warn(msg, *args):
-    """Print a warning message to stderr."""
-    print >> sys.stderr, "warning:", msg % args
-
-def die (msg, *args):
-    """Print as error message to stderr and exit the program."""
-    error(msg, *args)
-    sys.exit(1)
-
-
-class ProgressIndicator(object):
-
-    """Simple progress indicator.
-
-    Displayed as a spinning character by default, but can be customized
-    by passing custom messages that overrides the spinning character.
-
-    """
-
-    States = ("|", "/", "-", "\\")
-
-    def __init__ (self, prefix = "", f = sys.stdout):
-        """Create a new ProgressIndicator, bound to the given file object."""
-        self.n = 0  # Simple progress counter
-        self.f = f  # Progress is written to this file object
-        self.prev_len = 0  # Length of previous msg (to be overwritten)
-        self.prefix = prefix  # Prefix prepended to each progress message
-        self.prefix_lens = [] # Stack of prefix string lengths
-
-    def pushprefix (self, prefix):
-        """Append the given prefix onto the prefix stack."""
-        self.prefix_lens.append(len(self.prefix))
-        self.prefix += prefix
-
-    def popprefix (self):
-        """Remove the last prefix from the prefix stack."""
-        prev_len = self.prefix_lens.pop()
-        self.prefix = self.prefix[:prev_len]
-
-    def __call__ (self, msg = None, lf = False):
-        """Indicate progress, possibly with a custom message."""
-        if msg is None:
-            msg = self.States[self.n % len(self.States)]
-        msg = self.prefix + msg
-        print >> self.f, "\r%-*s" % (self.prev_len, msg),
-        self.prev_len = len(msg.expandtabs())
-        if lf:
-            print >> self.f
-            self.prev_len = 0
-        self.n += 1
-
-    def finish (self, msg = "done", noprefix = False):
-        """Finalize progress indication with the given message."""
-        if noprefix:
-            self.prefix = ""
-        self(msg, True)
-
-
-def start_command (args, cwd = None, shell = False, add_env = None,
-                   stdin = subprocess.PIPE, stdout = subprocess.PIPE,
-                   stderr = subprocess.PIPE):
-    """Start the given command, and return a subprocess object.
-
-    This provides a simpler interface to the subprocess module.
-
-    """
-    env = None
-    if add_env is not None:
-        env = os.environ.copy()
-        env.update(add_env)
-    return subprocess.Popen(args, bufsize = 1, stdin = stdin, stdout = stdout,
-                            stderr = stderr, cwd = cwd, shell = shell,
-                            env = env, universal_newlines = True)
-
-
-def run_command (args, cwd = None, shell = False, add_env = None,
-                 flag_error = True):
-    """Run the given command to completion, and return its results.
-
-    This provides a simpler interface to the subprocess module.
-
-    The results are formatted as a 3-tuple: (exit_code, output, errors)
-
-    If flag_error is enabled, Error messages will be produced if the
-    subprocess terminated with a non-zero exit code and/or stderr
-    output.
-
-    The other arguments are passed on to start_command().
-
-    """
-    process = start_command(args, cwd, shell, add_env)
-    (output, errors) = process.communicate()
-    exit_code = process.returncode
-    if flag_error and errors:
-        error("'%s' returned errors:\n---\n%s---", " ".join(args), errors)
-    if flag_error and exit_code:
-        error("'%s' returned exit code %i", " ".join(args), exit_code)
-    return (exit_code, output, errors)
-
-
-# from python2.7:subprocess.py
-def call(*popenargs, **kwargs):
-    """Run command with arguments.  Wait for command to complete, then
-    return the returncode attribute.
-
-    The arguments are the same as for the Popen constructor.  Example:
-
-    retcode = call(["ls", "-l"])
-    """
-    return subprocess.Popen(*popenargs, **kwargs).wait()
-
-
-# from python2.7:subprocess.py
-def check_call(*popenargs, **kwargs):
-    """Run command with arguments.  Wait for command to complete.  If
-    the exit code was zero then return, otherwise raise
-    CalledProcessError.  The CalledProcessError object will have the
-    return code in the returncode attribute.
-
-    The arguments are the same as for the Popen constructor.  Example:
-
-    check_call(["ls", "-l"])
-    """
-    retcode = call(*popenargs, **kwargs)
-    if retcode:
-        cmd = kwargs.get("args")
-        if cmd is None:
-            cmd = popenargs[0]
-        raise CalledProcessError(retcode, cmd)
-    return 0
-
-
-# from python2.7:subprocess.py
-def check_output(*popenargs, **kwargs):
-    r"""Run command with arguments and return its output as a byte string.
-
-    If the exit code was non-zero it raises a CalledProcessError.  The
-    CalledProcessError object will have the return code in the returncode
-    attribute and output in the output attribute.
-
-    The arguments are the same as for the Popen constructor.  Example:
-
-    >>> check_output(["ls", "-l", "/dev/null"])
-    'crw-rw-rw- 1 root root 1, 3 Oct 18  2007 /dev/null\n'
-
-    The stdout argument is not allowed as it is used internally.
-    To capture standard error in the result, use stderr=STDOUT.
-
-    >>> check_output(["/bin/sh", "-c",
-    ...               "ls -l non_existent_file ; exit 0"],
-    ...              stderr=STDOUT)
-    'ls: non_existent_file: No such file or directory\n'
-    """
-    if 'stdout' in kwargs:
-        raise ValueError('stdout argument not allowed, it will be overridden.')
-    process = subprocess.Popen(stdout=subprocess.PIPE, *popenargs, **kwargs)
-    output, unused_err = process.communicate()
-    retcode = process.poll()
-    if retcode:
-        cmd = kwargs.get("args")
-        if cmd is None:
-            cmd = popenargs[0]
-        raise subprocess.CalledProcessError(retcode, cmd)
-    return output
-
-
-def file_reader_method (missing_ok = False):
-    """Decorator for simplifying reading of files.
-
-    If missing_ok is True, a failure to open a file for reading will
-    not raise the usual IOError, but instead the wrapped method will be
-    called with f == None.  The method must in this case properly
-    handle f == None.
-
-    """
-    def _wrap (method):
-        """Teach given method to handle both filenames and file objects.
-
-        The given method must take a file object as its second argument
-        (the first argument being 'self', of course).  This decorator
-        will take a filename given as the second argument and promote
-        it to a file object.
-
-        """
-        def _wrapped_method (self, filename, *args, **kwargs):
-            if isinstance(filename, file):
-                f = filename
-            else:
-                try:
-                    f = open(filename, 'r')
-                except IOError:
-                    if missing_ok:
-                        f = None
-                    else:
-                        raise
-            try:
-                return method(self, f, *args, **kwargs)
-            finally:
-                if not isinstance(filename, file) and f:
-                    f.close()
-        return _wrapped_method
-    return _wrap
-
-
-def file_writer_method (method):
-    """Decorator for simplifying writing of files.
-
-    Enables the given method to handle both filenames and file objects.
-
-    The given method must take a file object as its second argument
-    (the first argument being 'self', of course).  This decorator will
-    take a filename given as the second argument and promote it to a
-    file object.
-
-    """
-    def _new_method (self, filename, *args, **kwargs):
-        if isinstance(filename, file):
-            f = filename
-        else:
-            # Make sure the containing directory exists
-            parent_dir = os.path.dirname(filename)
-            if not os.path.isdir(parent_dir):
-                os.makedirs(parent_dir)
-            f = open(filename, 'w')
-        try:
-            return method(self, f, *args, **kwargs)
-        finally:
-            if not isinstance(filename, file):
-                f.close()
-    return _new_method
diff --git a/t/t5800-remote-testpy.sh b/t/t5800-remote-testpy.sh
deleted file mode 100755
index 1e683d4..0000000
--- a/t/t5800-remote-testpy.sh
+++ /dev/null
@@ -1,169 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2010 Sverre Rabbelier
-#
-
-test_description='Test python remote-helper framework'
-
-. ./test-lib.sh
-
-if ! test_have_prereq PYTHON ; then
-	skip_all='skipping python remote-helper tests, python not available'
-	test_done
-fi
-
-"$PYTHON_PATH" -c '
-import sys
-if sys.hexversion < 0x02040000:
-    sys.exit(1)
-' || {
-	skip_all='skipping python remote-helper tests, python version < 2.4'
-	test_done
-}
-
-compare_refs() {
-	git --git-dir="$1/.git" rev-parse --verify $2 >expect &&
-	git --git-dir="$3/.git" rev-parse --verify $4 >actual &&
-	test_cmp expect actual
-}
-
-test_expect_success 'setup repository' '
-	git init --bare server/.git &&
-	git clone server public &&
-	(cd public &&
-	 echo content >file &&
-	 git add file &&
-	 git commit -m one &&
-	 git push origin master)
-'
-
-test_expect_success 'cloning from local repo' '
-	git clone "testpy::${PWD}/server" localclone &&
-	test_cmp public/file localclone/file
-'
-
-test_expect_success 'cloning from remote repo' '
-	git clone "testpy::file://${PWD}/server" clone &&
-	test_cmp public/file clone/file
-'
-
-test_expect_success 'create new commit on remote' '
-	(cd public &&
-	 echo content >>file &&
-	 git commit -a -m two &&
-	 git push)
-'
-
-test_expect_success 'pulling from local repo' '
-	(cd localclone && git pull) &&
-	test_cmp public/file localclone/file
-'
-
-test_expect_success 'pulling from remote remote' '
-	(cd clone && git pull) &&
-	test_cmp public/file clone/file
-'
-
-test_expect_success 'pushing to local repo' '
-	(cd localclone &&
-	echo content >>file &&
-	git commit -a -m three &&
-	git push) &&
-	compare_refs localclone HEAD server HEAD
-'
-
-# Generally, skip this test.  It demonstrates a now-fixed race in
-# git-remote-testpy, but is too slow to leave in for general use.
-: test_expect_success 'racily pushing to local repo' '
-	test_when_finished "rm -rf server2 localclone2" &&
-	cp -R server server2 &&
-	git clone "testpy::${PWD}/server2" localclone2 &&
-	(cd localclone2 &&
-	echo content >>file &&
-	git commit -a -m three &&
-	GIT_REMOTE_TESTGIT_SLEEPY=2 git push) &&
-	compare_refs localclone2 HEAD server2 HEAD
-'
-
-test_expect_success 'synch with changes from localclone' '
-	(cd clone &&
-	 git pull)
-'
-
-test_expect_success 'pushing remote local repo' '
-	(cd clone &&
-	echo content >>file &&
-	git commit -a -m four &&
-	git push) &&
-	compare_refs clone HEAD server HEAD
-'
-
-test_expect_success 'fetch new branch' '
-	(cd public &&
-	 git checkout -b new &&
-	 echo content >>file &&
-	 git commit -a -m five &&
-	 git push origin new
-	) &&
-	(cd localclone &&
-	 git fetch origin new
-	) &&
-	compare_refs public HEAD localclone FETCH_HEAD
-'
-
-test_expect_success 'fetch multiple branches' '
-	(cd localclone &&
-	 git fetch
-	) &&
-	compare_refs server master localclone refs/remotes/origin/master &&
-	compare_refs server new localclone refs/remotes/origin/new
-'
-
-test_expect_success 'push when remote has extra refs' '
-	(cd clone &&
-	 echo content >>file &&
-	 git commit -a -m six &&
-	 git push
-	) &&
-	compare_refs clone master server master
-'
-
-test_expect_success 'push new branch by name' '
-	(cd clone &&
-	 git checkout -b new-name  &&
-	 echo content >>file &&
-	 git commit -a -m seven &&
-	 git push origin new-name
-	) &&
-	compare_refs clone HEAD server refs/heads/new-name
-'
-
-test_expect_failure 'push new branch with old:new refspec' '
-	(cd clone &&
-	 git push origin new-name:new-refspec
-	) &&
-	compare_refs clone HEAD server refs/heads/new-refspec
-'
-
-test_expect_success 'proper failure checks for fetching' '
-	(GIT_REMOTE_TESTGIT_FAILURE=1 &&
-	export GIT_REMOTE_TESTGIT_FAILURE &&
-	cd localclone &&
-	test_must_fail git fetch 2>&1 | \
-		grep "Error while running fast-import"
-	)
-'
-
-# We sleep to give fast-export a chance to catch the SIGPIPE
-test_expect_failure 'proper failure checks for pushing' '
-	(GIT_REMOTE_TESTGIT_FAILURE=1 &&
-	export GIT_REMOTE_TESTGIT_FAILURE &&
-	GIT_REMOTE_TESTGIT_SLEEPY=1 &&
-	export GIT_REMOTE_TESTGIT_SLEEPY &&
-	cd localclone &&
-	test_must_fail git push --all 2>&1 | \
-		grep "Error while running fast-export"
-	)
-'
-
-test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1aa27bd..0fa7dfd 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -700,15 +700,6 @@ test -d "$GIT_BUILD_DIR"/templates/blt || {
 	error "You haven't built things yet, have you?"
 }
 
-if test -z "$GIT_TEST_INSTALLED" && test -z "$NO_PYTHON"
-then
-	GITPYTHONLIB="$GIT_BUILD_DIR/git_remote_helpers/build/lib"
-	export GITPYTHONLIB
-	test -d "$GIT_BUILD_DIR"/git_remote_helpers/build || {
-		error "You haven't built git_remote_helpers yet, have you?"
-	}
-fi
-
 if ! test -x "$GIT_BUILD_DIR"/test-chmtime
 then
 	echo >&2 'You need to build test-chmtime:'
-- 
1.8.4.239.g2332621
