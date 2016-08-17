Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 960891F6C1
	for <e@80x24.org>; Wed, 17 Aug 2016 06:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152AbcHQGlm (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 02:41:42 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33976 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750763AbcHQGlk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 02:41:40 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u7H6fUlh016769
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 17 Aug 2016 08:41:30 +0200
Received: from anie.imag.fr (ensi-vpn-237.imag.fr [129.88.57.237])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u7H6fU8I020925;
	Wed, 17 Aug 2016 08:41:30 +0200
From:	Matthieu Moy <Matthieu.Moy@imag.fr>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] git-multimail: update to release 1.4.0
Date:	Wed, 17 Aug 2016 08:41:16 +0200
Message-Id: <20160817064116.18399-1-Matthieu.Moy@imag.fr>
X-Mailer: git-send-email 2.10.0.rc0.1.g07c9292
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Wed, 17 Aug 2016 08:41:30 +0200 (CEST)
X-IMAG-MailScanner-Information:	Please contact MI2S MIM  for more information
X-MailScanner-ID: u7H6fUlh016769
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check:	1472020893.59767@b3nDdswmE6Mf7Rxs7mdGwA
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Changes are described in CHANGES.

Contributions-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Contributions-by: Irfan Adilovic <irfanadilovic@gmail.com>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/hooks/multimail/CHANGES                 |  59 ++
 contrib/hooks/multimail/CONTRIBUTING.rst        |   9 +-
 contrib/hooks/multimail/README                  |  85 ++-
 contrib/hooks/multimail/README.Git              |   4 +-
 contrib/hooks/multimail/doc/troubleshooting.rst |  34 +
 contrib/hooks/multimail/git_multimail.py        | 810 ++++++++++++++++--------
 6 files changed, 725 insertions(+), 276 deletions(-)

diff --git a/contrib/hooks/multimail/CHANGES b/contrib/hooks/multimail/CHANGES
index 100cc7a..2076cf9 100644
--- a/contrib/hooks/multimail/CHANGES
+++ b/contrib/hooks/multimail/CHANGES
@@ -1,3 +1,62 @@
+Release 1.4.0
+=============
+
+New features to troubleshoot a git-multimail installation
+---------------------------------------------------------
+
+* One can now perform a basic check of git-multimail's setup by
+  running the hook with the environment variable
+  GIT_MULTIMAIL_CHECK_SETUP set to a non-empty string. See
+  doc/troubleshooting.rst for details.
+
+* A new log files system was added. See the multimailhook.logFile,
+  multimailhook.errorLogFile and multimailhook.debugLogFile variables.
+
+* git_multimail.py can now be made more verbose using
+  multimailhook.verbose.
+
+* A new option --check-ref-filter is now available to help debugging
+  the refFilter* options.
+
+Formatting emails
+-----------------
+
+* Formatting of emails was made slightly more compact, to reduce the
+  odds of having long subject lines truncated or wrapped in short list
+  of commits.
+
+* multimailhook.emailPrefix may now use the '%(repo_shortname)s'
+  placeholder for the repository's short name.
+
+* A new option multimailhook.subjectMaxLength is available to truncate
+  overly long subject lines.
+
+Bug fixes and minor changes
+---------------------------
+
+* Options refFilterDoSendRegex and refFilterDontSendRegex were
+  essentially broken. They should work now.
+
+* The behavior when both refFilter{Do,Dont}SendRegex and
+  refFilter{Exclusion,Inclusion}Regex are set have been slightly
+  changed. Exclusion/Inclusion is now strictly stronger than
+  DoSend/DontSend.
+
+* The management of precedence when a setting can be computed in
+  multiple ways has been considerably refactored and modified.
+  multimailhook.from and multimailhook.reponame now have precedence
+  over the environment-specific settings ($GL_REPO/$GL_USER for
+  gitolite, --stash-user/repo for Stash, --submitter/--project for
+  Gerrit).
+
+* The coverage of the testsuite has been considerably improved. All
+  configuration variables now appear at least once in the testsuite.
+
+This version was tested with Python 2.6 to 3.5. It also mostly works
+with Python 2.4, but there is one known breakage in the testsuite
+related to non-ascii characters. It was tested with Git
+1.7.10.406.gdc801, 1.8.5.6, 2.1.4, and 2.10.0.rc0.1.g07c9292.
+
 Release 1.3.1 (bugfix-only release)
 ===================================
 
diff --git a/contrib/hooks/multimail/CONTRIBUTING.rst b/contrib/hooks/multimail/CONTRIBUTING.rst
index 530ecbf..da65570 100644
--- a/contrib/hooks/multimail/CONTRIBUTING.rst
+++ b/contrib/hooks/multimail/CONTRIBUTING.rst
@@ -4,8 +4,9 @@ Contributing
 git-multimail is an open-source project, built by volunteers. We would
 welcome your help!
 
-The current maintainers are Michael Haggerty <mhagger@alum.mit.edu>
-and Matthieu Moy <matthieu.moy@grenoble-inp.fr>.
+The current maintainers are Matthieu Moy
+<matthieu.moy@grenoble-inp.fr> and Michael Haggerty
+<mhagger@alum.mit.edu>.
 
 Please note that although a copy of git-multimail is distributed in
 the "contrib" section of the main Git project, development takes place
@@ -22,6 +23,10 @@ to the maintainers). Please sign off your patches as per the `Git
 project practice
 <https://github.com/git/git/blob/master/Documentation/SubmittingPatches#L234>`__.
 
+Please vote for issues you would like to be addressed in priority
+(click "add your reaction" and then the "+1" thumbs-up button on the
+GitHub issue).
+
 General discussion of git-multimail can take place on the main `Git
 mailing list`_.
 
diff --git a/contrib/hooks/multimail/README b/contrib/hooks/multimail/README
index 22a23cd..5105373 100644
--- a/contrib/hooks/multimail/README
+++ b/contrib/hooks/multimail/README
@@ -1,11 +1,11 @@
-git-multimail 1.3.1
-===================
+git-multimail version 1.4.0
+===========================
 
 .. image:: https://travis-ci.org/git-multimail/git-multimail.svg?branch=master
     :target: https://travis-ci.org/git-multimail/git-multimail
 
 git-multimail is a tool for sending notification emails on pushes to a
-Git repository.  It includes a Python module called git_multimail.py,
+Git repository.  It includes a Python module called ``git_multimail.py``,
 which can either be used as a hook script directly or can be imported
 as a Python module into another script.
 
@@ -93,20 +93,20 @@ Requirements
 Invocation
 ----------
 
-git_multimail.py is designed to be used as a ``post-receive`` hook in a
+``git_multimail.py`` is designed to be used as a ``post-receive`` hook in a
 Git repository (see githooks(5)).  Link or copy it to
 $GIT_DIR/hooks/post-receive within the repository for which email
 notifications are desired.  Usually it should be installed on the
 central repository for a project, to which all commits are eventually
 pushed.
 
-For use on pre-v1.5.1 Git servers, git_multimail.py can also work as
+For use on pre-v1.5.1 Git servers, ``git_multimail.py`` can also work as
 an ``update`` hook, taking its arguments on the command line.  To use
 this script in this manner, link or copy it to $GIT_DIR/hooks/update.
 Please note that the script is not completely reliable in this mode
-[2]_.
+[1]_.
 
-Alternatively, git_multimail.py can be imported as a Python module
+Alternatively, ``git_multimail.py`` can be imported as a Python module
 into your own Python post-receive script.  This method is a bit more
 work, but allows the behavior of the hook to be customized using
 arbitrary Python code.  For example, you can use a custom environment
@@ -122,7 +122,7 @@ arbitrary Python code.  For example, you can use a custom environment
 
 Or you can change how emails are sent by writing your own Mailer
 class.  The ``post-receive`` script in this directory demonstrates how
-to use git_multimail.py as a Python module.  (If you make interesting
+to use ``git_multimail.py`` as a Python module.  (If you make interesting
 changes of this type, please consider sharing them with the
 community.)
 
@@ -151,7 +151,10 @@ multimailhook.environment
       the repository name is derived from the repository's path.
 
     gitolite
-      the username of the pusher is read from $GL_USER, the repository
+      Environment to use when ``git-multimail`` is ran as a gitolite_
+      hook.
+
+      The username of the pusher is read from $GL_USER, the repository
       name is read from $GL_REPO, and the From: header value is
       optionally read from gitolite.conf (see multimailhook.from).
 
@@ -444,7 +447,9 @@ multimailhook.emailPrefix
     email filtering (though filtering based on the X-Git-* email
     headers is probably more robust).  Default is the short name of
     the repository in square brackets; e.g., ``[myrepo]``.  Set this
-    value to the empty string to suppress the email prefix.
+    value to the empty string to suppress the email prefix. You may
+    use the placeholder ``%(repo_shortname)s`` for the short name of
+    the repository.
 
 multimailhook.emailMaxLines
     The maximum number of lines that should be included in the body of
@@ -461,6 +466,17 @@ multimailhook.emailMaxLineLength
     lines, the diffs are probably unreadable anyway.  To disable line
     truncation, set this option to 0.
 
+multimailhook.subjectMaxLength
+    The maximum length of the subject line (i.e. the ``oneline`` field
+    in templates, not including the prefix). Lines longer than this
+    limit are truncated to this length with a trailing ``[...]`` added
+    to indicate the missing text. This option The default is to use
+    ``multimailhook.emailMaxLineLength``. This option avoids sending
+    emails with overly long subject lines, but should not be needed if
+    the commit messages follow the Git convention (one short subject
+    line, then a blank line, then the message body). To disable line
+    truncation, set this option to 0.
+
 multimailhook.maxCommitEmails
     The maximum number of commit emails to send for a given change.
     When the number of patches is larger that this value, only the
@@ -474,12 +490,15 @@ multimailhook.emailStrictUTF8
     not valid UTF-8 are converted to the Unicode replacement
     character, U+FFFD.  The default is `true`.
 
+    This option is ineffective with Python 3, where non-UTF-8
+    characters are unconditionally replaced.
+
 multimailhook.diffOpts
     Options passed to ``git diff-tree`` when generating the summary
     information for ReferenceChange emails.  Default is ``--stat
     --summary --find-copies-harder``.  Add -p to those options to
     include a unified diff of changes in addition to the usual summary
-    output.  Shell quoting is allowed; see multimailhook.logOpts for
+    output.  Shell quoting is allowed; see ``multimailhook.logOpts`` for
     details.
 
 multimailhook.graphOpts
@@ -564,6 +583,8 @@ multimailhook.refFilterInclusionRegex, multimailhook.refFilterExclusionRegex, mu
     the user-interface is not stable yet (in particular, the option
     names may change). If you want to participate in stabilizing the
     feature, please contact the maintainers and/or send pull-requests.
+    If you are happy with the current shape of the feature, please
+    report it too.
 
     Regular expressions that can be used to limit refs for which email
     updates will be sent.  It is an error to specify both an inclusion
@@ -613,6 +634,32 @@ multimailhook.refFilterInclusionRegex, multimailhook.refFilterExclusionRegex, mu
       [multimailhook]
               refFilterExclusionRegex = ^refs/tags/|^refs/heads/master$
 
+    ``refFilterInclusionRegex`` and ``refFilterExclusionRegex`` are
+    strictly stronger than ``refFilterDoSendRegex`` and
+    ``refFilterDontSendRegex``. In other words, adding a ref to a
+    DoSend/DontSend regex has no effect if it is already excluded by a
+    Exclusion/Inclusion regex.
+
+multimailhook.logFile, multimailhook.errorLogFile, multimailhook.debugLogFile
+
+    When set, these variable designate path to files where
+    git-multimail will log some messages. Normal messages and error
+    messages are sent to ``logFile``, and error messages are also sent
+    to ``errorLogFile``. Debug messages and all other messages are
+    sent to ``debugLogFile``. The recommended way is to set only one
+    of these variables, but it is also possible to set several of them
+    (part of the information is then duplicated in several log files,
+    for example errors are duplicated to all log files).
+
+    Relative path are relative to the Git repository where the push is
+    done.
+
+multimailhook.verbose
+
+    Verbosity level of git-multimail on its standard output. By
+    default, show only error and info messages. If set to true, show
+    also debug messages.
+
 Email filtering aids
 --------------------
 
@@ -628,8 +675,8 @@ Customizing email contents
 
 git-multimail mostly generates emails by expanding templates.  The
 templates can be customized.  To avoid the need to edit
-git_multimail.py directly, the preferred way to change the templates
-is to write a separate Python script that imports git_multimail.py as
+``git_multimail.py`` directly, the preferred way to change the templates
+is to write a separate Python script that imports ``git_multimail.py`` as
 a module, then replaces the templates in place.  See the provided
 post-receive script for an example of how this is done.
 
@@ -645,8 +692,8 @@ GenericEnvironment
     a stand-alone Git repository.
 
 GitoliteEnvironment
-    a Git repository that is managed by gitolite
-    [3]_.  For such repositories, the identity of the pusher is read from
+    a Git repository that is managed by gitolite_.  For such
+    repositories, the identity of the pusher is read from
     environment variable $GL_USER, the name of the repository is read
     from $GL_REPO (if it is not overridden by multimailhook.reponame),
     and the From: header value is optionally read from gitolite.conf
@@ -662,7 +709,7 @@ option to the script.
 If you need to customize the script in ways that are not supported by
 the existing environments, you can define your own environment class
 class using arbitrary Python code.  To do so, you need to import
-git_multimail.py as a Python module, as demonstrated by the example
+``git_multimail.py`` as a Python module, as demonstrated by the example
 post-receive script.  Then implement your environment class; it should
 usually inherit from one of the existing Environment classes and
 possibly one or more of the EnvironmentMixin classes.  Then set the
@@ -690,9 +737,7 @@ contribute to git-multimail.
 Footnotes
 ---------
 
-.. [1] http://www.python.org/dev/peps/pep-0394/
-
-.. [2] Because of the way information is passed to update hooks, the
+.. [1] Because of the way information is passed to update hooks, the
        script's method of determining whether a commit has already
        been seen does not work when it is used as an ``update`` script.
        In particular, no notification email will be generated for a
@@ -700,4 +745,4 @@ Footnotes
        push. A workaround is to use --force-send to force sending the
        emails.
 
-.. [3] https://github.com/sitaramc/gitolite
+.. _gitolite: https://github.com/sitaramc/gitolite
diff --git a/contrib/hooks/multimail/README.Git b/contrib/hooks/multimail/README.Git
index 1210bde..161b023 100644
--- a/contrib/hooks/multimail/README.Git
+++ b/contrib/hooks/multimail/README.Git
@@ -6,10 +6,10 @@ website:
     https://github.com/git-multimail/git-multimail
 
 The version in this directory was obtained from the upstream project
-on May 13 2016 and consists of the "git-multimail" subdirectory from
+on August 17 2016 and consists of the "git-multimail" subdirectory from
 revision
 
-    3ce5470d4abf7251604cbf64e73a962e1b617f5e refs/tags/1.3.1
+    07b1cb6bfd7be156c62e1afa17cae13b850a869f refs/tags/1.4.0
 
 Please see the README file in this directory for information about how
 to report bugs or contribute to git-multimail.
diff --git a/contrib/hooks/multimail/doc/troubleshooting.rst b/contrib/hooks/multimail/doc/troubleshooting.rst
index d3f346f..651b509 100644
--- a/contrib/hooks/multimail/doc/troubleshooting.rst
+++ b/contrib/hooks/multimail/doc/troubleshooting.rst
@@ -1,6 +1,40 @@
 Troubleshooting issues with git-multimail: a FAQ
 ================================================
 
+How to check that git-multimail is properly set up?
+---------------------------------------------------
+
+Since version 1.4.0, git-multimail allows a simple self-checking of
+its configuration: run it with the environment variable
+``GIT_MULTIMAIL_CHECK_SETUP`` set to a non-empty string. You should
+get something like this::
+
+  $ GIT_MULTIMAIL_CHECK_SETUP=true /home/moy/dev/git-multimail/git-multimail/git_multimail.py
+  Environment values:
+      administrator : 'the administrator of this repository'
+      charset : 'utf-8'
+      emailprefix : '[git-multimail] '
+      fqdn : 'anie'
+      projectdesc : 'UNNAMED PROJECT'
+      pusher : 'moy'
+      repo_path : '/home/moy/dev/git-multimail'
+      repo_shortname : 'git-multimail'
+
+  Now, checking that git-multimail's standard input is properly set ...
+  Please type some text and then press Return
+  foo
+  You have just entered:
+  foo
+  git-multimail seems properly set up.
+
+If you forgot to set an important variable, you may get instead::
+
+  $ GIT_MULTIMAIL_CHECK_SETUP=true /home/moy/dev/git-multimail/git-multimail/git_multimail.py
+  No email recipients configured!
+
+Do not set ``$GIT_MULTIMAIL_CHECK_SETUP`` other than for testing your
+configuration: it would disable the hook completely.
+
 Git is not using the right address in the From/To/Reply-To field
 ----------------------------------------------------------------
 
diff --git a/contrib/hooks/multimail/git_multimail.py b/contrib/hooks/multimail/git_multimail.py
index 54ab4a4..c7f8640 100755
--- a/contrib/hooks/multimail/git_multimail.py
+++ b/contrib/hooks/multimail/git_multimail.py
@@ -1,8 +1,8 @@
 #! /usr/bin/env python
 
-__version__ = '1.3.1'
+__version__ = '1.4.0'
 
-# Copyright (c) 2015 Matthieu Moy and others
+# Copyright (c) 2015-2016 Matthieu Moy and others
 # Copyright (c) 2012-2014 Michael Haggerty and others
 # Derived from contrib/hooks/post-receive-email, which is
 # Copyright (c) 2007 Andy Parkins
@@ -56,6 +56,7 @@ import socket
 import subprocess
 import shlex
 import optparse
+import logging
 import smtplib
 try:
     import ssl
@@ -86,8 +87,8 @@ if PYTHON3:
     def str_to_bytes(s):
         return s.encode(ENCODING)
 
-    def bytes_to_str(s):
-        return s.decode(ENCODING)
+    def bytes_to_str(s, errors='strict'):
+        return s.decode(ENCODING, errors)
 
     unicode = str
 
@@ -98,6 +99,15 @@ if PYTHON3:
             f.buffer.write(msg.encode(sys.getdefaultencoding()))
         except UnicodeEncodeError:
             f.buffer.write(msg.encode(ENCODING))
+
+    def read_line(f):
+        # Try reading with the default encoding. If it fails,
+        # try UTF-8.
+        out = f.buffer.readline()
+        try:
+            return out.decode(sys.getdefaultencoding())
+        except UnicodeEncodeError:
+            return out.decode(ENCODING)
 else:
     def is_string(s):
         try:
@@ -108,12 +118,15 @@ else:
     def str_to_bytes(s):
         return s
 
-    def bytes_to_str(s):
+    def bytes_to_str(s, errors='strict'):
         return s
 
     def write_str(f, msg):
         f.write(msg)
 
+    def read_line(f):
+        return f.readline()
+
     def next(it):
         return it.next()
 
@@ -213,8 +226,8 @@ reference pointing at a previous point in the repository history.
             \\
              O -- O -- O   (%(oldrev_short)s)
 
-Any revisions marked "omits" are not gone; other references still
-refer to them.  Any revisions marked "discards" are gone forever.
+Any revisions marked "omit" are not gone; other references still
+refer to them.  Any revisions marked "discard" are gone forever.
 """
 
 
@@ -233,8 +246,8 @@ You should already have received notification emails for all of the O
 revisions, and so the following emails describe only the N revisions
 from the common base, B.
 
-Any revisions marked "omits" are not gone; other references still
-refer to them.  Any revisions marked "discards" are gone forever.
+Any revisions marked "omit" are not gone; other references still
+refer to them.  Any revisions marked "discard" are gone forever.
 """
 
 
@@ -258,22 +271,22 @@ from the repository.
 NEW_REVISIONS_TEMPLATE = """\
 The %(tot)s revisions listed above as "new" are entirely new to this
 repository and will be described in separate emails.  The revisions
-listed as "adds" were already present in the repository and have only
+listed as "add" were already present in the repository and have only
 been added to this reference.
 
 """
 
 
 TAG_CREATED_TEMPLATE = """\
-        at  %(newrev_short)-9s (%(newrev_type)s)
+      at %(newrev_short)-8s (%(newrev_type)s)
 """
 
 
 TAG_UPDATED_TEMPLATE = """\
 *** WARNING: tag %(short_refname)s was modified! ***
 
-      from  %(oldrev_short)-9s (%(oldrev_type)s)
-        to  %(newrev_short)-9s (%(newrev_type)s)
+    from %(oldrev_short)-8s (%(oldrev_type)s)
+      to %(newrev_short)-8s (%(newrev_type)s)
 """
 
 
@@ -286,7 +299,7 @@ TAG_DELETED_TEMPLATE = """\
 # The template used in summary tables.  It looks best if this uses the
 # same alignment as TAG_CREATED_TEMPLATE and TAG_UPDATED_TEMPLATE.
 BRIEF_SUMMARY_TEMPLATE = """\
-%(action)10s  %(rev_short)-9s %(text)s
+%(action)8s %(rev_short)-8s %(text)s
 """
 
 
@@ -434,11 +447,16 @@ def read_output(cmd, input=None, keepends=False, **kw):
         input = str_to_bytes(input)
     else:
         stdin = None
+    errors = 'strict'
+    if 'errors' in kw:
+        errors = kw['errors']
+        del kw['errors']
     p = subprocess.Popen(
-        cmd, stdin=stdin, stdout=subprocess.PIPE, stderr=subprocess.PIPE, **kw
+        tuple(str_to_bytes(w) for w in cmd),
+        stdin=stdin, stdout=subprocess.PIPE, stderr=subprocess.PIPE, **kw
         )
     (out, err) = p.communicate(input)
-    out = bytes_to_str(out)
+    out = bytes_to_str(out, errors=errors)
     retcode = p.wait()
     if retcode:
         raise CommandError(cmd, retcode)
@@ -1020,7 +1038,9 @@ class Change(object):
         for line in footer:
             yield line
 
-    def get_alt_fromaddr(self):
+    def get_specific_fromaddr(self):
+        """For kinds of Changes which specify it, return the kind-specific
+        From address to use."""
         return None
 
 
@@ -1045,7 +1065,7 @@ class Revision(Change):
             self.cc_recipients = ', '.join(to.strip() for to in self._cc_recipients())
             if self.cc_recipients:
                 self.environment.log_msg(
-                    'Add %s to CC for %s\n' % (self.cc_recipients, self.rev.sha1))
+                    'Add %s to CC for %s' % (self.cc_recipients, self.rev.sha1))
 
     def _cc_recipients(self):
         cc_recipients = []
@@ -1065,6 +1085,10 @@ class Revision(Change):
             ['log', '--format=%s', '--no-walk', self.rev.sha1]
             )
 
+        max_subject_length = self.environment.get_max_subject_length()
+        if max_subject_length > 0 and len(oneline) > max_subject_length:
+            oneline = oneline[:max_subject_length - 6] + ' [...]'
+
         values['rev'] = self.rev.sha1
         values['rev_short'] = self.rev.short
         values['change_type'] = self.change_type
@@ -1121,7 +1145,7 @@ class Revision(Change):
         for line in read_git_lines(
                 ['log'] + self.environment.commitlogopts + ['-1', self.rev.sha1],
                 keepends=True,
-                ):
+                errors='replace'):
             if line.startswith('Date:   ') and self.environment.date_substitute:
                 yield self.environment.date_substitute + line[len('Date:   '):]
             else:
@@ -1135,7 +1159,7 @@ class Revision(Change):
         self._contains_diff()
         return Change.generate_email(self, push, body_filter, extra_header_values)
 
-    def get_alt_fromaddr(self):
+    def get_specific_fromaddr(self):
         return self.environment.from_commit
 
 
@@ -1193,7 +1217,7 @@ class ReferenceChange(Change):
                 # Tracking branch:
                 environment.log_warning(
                     '*** Push-update of tracking branch %r\n'
-                    '***  - incomplete email generated.\n'
+                    '***  - incomplete email generated.'
                     % (refname,)
                     )
                 klass = OtherReferenceChange
@@ -1201,7 +1225,7 @@ class ReferenceChange(Change):
                 # Some other reference namespace:
                 environment.log_warning(
                     '*** Push-update of strange reference %r\n'
-                    '***  - incomplete email generated.\n'
+                    '***  - incomplete email generated.'
                     % (refname,)
                     )
                 klass = OtherReferenceChange
@@ -1209,7 +1233,7 @@ class ReferenceChange(Change):
             # Anything else (is there anything else?)
             environment.log_warning(
                 '*** Unknown type of update to %r (%s)\n'
-                '***  - incomplete email generated.\n'
+                '***  - incomplete email generated.'
                 % (refname, rev.type,)
                 )
             klass = OtherReferenceChange
@@ -1446,9 +1470,9 @@ class ReferenceChange(Change):
             if discards and adds:
                 for (sha1, subject) in discards:
                     if sha1 in discarded_commits:
-                        action = 'discards'
+                        action = 'discard'
                     else:
-                        action = 'omits'
+                        action = 'omit'
                     yield self.expand(
                         BRIEF_SUMMARY_TEMPLATE, action=action,
                         rev_short=sha1, text=subject,
@@ -1457,7 +1481,7 @@ class ReferenceChange(Change):
                     if sha1 in new_commits:
                         action = 'new'
                     else:
-                        action = 'adds'
+                        action = 'add'
                     yield self.expand(
                         BRIEF_SUMMARY_TEMPLATE, action=action,
                         rev_short=sha1, text=subject,
@@ -1469,9 +1493,9 @@ class ReferenceChange(Change):
             elif discards:
                 for (sha1, subject) in discards:
                     if sha1 in discarded_commits:
-                        action = 'discards'
+                        action = 'discard'
                     else:
-                        action = 'omits'
+                        action = 'omit'
                     yield self.expand(
                         BRIEF_SUMMARY_TEMPLATE, action=action,
                         rev_short=sha1, text=subject,
@@ -1490,7 +1514,7 @@ class ReferenceChange(Change):
                     if sha1 in new_commits:
                         action = 'new'
                     else:
-                        action = 'adds'
+                        action = 'add'
                     yield self.expand(
                         BRIEF_SUMMARY_TEMPLATE, action=action,
                         rev_short=sha1, text=subject,
@@ -1543,7 +1567,7 @@ class ReferenceChange(Change):
                 for r in discarded_revisions:
                     (sha1, subject) = r.rev.get_summary()
                     yield r.expand(
-                        BRIEF_SUMMARY_TEMPLATE, action='discards', text=subject,
+                        BRIEF_SUMMARY_TEMPLATE, action='discard', text=subject,
                         )
                 for line in self.generate_revision_change_graph(push):
                     yield line
@@ -1581,7 +1605,7 @@ class ReferenceChange(Change):
             )
         yield '\n'
 
-    def get_alt_fromaddr(self):
+    def get_specific_fromaddr(self):
         return self.environment.from_refchange
 
 
@@ -1791,13 +1815,13 @@ class AnnotatedTagChange(ReferenceChange):
             except CommandError:
                 prevtag = None
             if prevtag:
-                yield '  replaces  %s\n' % (prevtag,)
+                yield ' replaces %s\n' % (prevtag,)
         else:
             prevtag = None
-            yield '    length  %s bytes\n' % (read_git_output(['cat-file', '-s', tagobject]),)
+            yield '  length %s bytes\n' % (read_git_output(['cat-file', '-s', tagobject]),)
 
-        yield ' tagged by  %s\n' % (tagger,)
-        yield '        on  %s\n' % (tagged,)
+        yield '      by %s\n' % (tagger,)
+        yield '      on %s\n' % (tagged,)
         yield '\n'
 
         # Show the content of the tag message; this might contain a
@@ -1914,6 +1938,9 @@ class OtherReferenceChange(ReferenceChange):
 class Mailer(object):
     """An object that can send emails."""
 
+    def __init__(self, environment):
+        self.environment = environment
+
     def send(self, lines, to_addrs):
         """Send an email consisting of lines.
 
@@ -1948,14 +1975,14 @@ class SendMailer(Mailer):
                 'Try setting multimailhook.sendmailCommand.'
                 )
 
-    def __init__(self, command=None, envelopesender=None):
+    def __init__(self, environment, command=None, envelopesender=None):
         """Construct a SendMailer instance.
 
         command should be the command and arguments used to invoke
         sendmail, as a list of strings.  If an envelopesender is
         provided, it will also be passed to the command, via '-f
         envelopesender'."""
-
+        super(SendMailer, self).__init__(environment)
         if command:
             self.command = command[:]
         else:
@@ -1968,7 +1995,7 @@ class SendMailer(Mailer):
         try:
             p = subprocess.Popen(self.command, stdin=subprocess.PIPE)
         except OSError:
-            sys.stderr.write(
+            self.environment.get_logger().error(
                 '*** Cannot execute command: %s\n' % ' '.join(self.command) +
                 '*** %s\n' % sys.exc_info()[1] +
                 '*** Try setting multimailhook.mailer to "smtp"\n' +
@@ -1979,15 +2006,16 @@ class SendMailer(Mailer):
             lines = (str_to_bytes(line) for line in lines)
             p.stdin.writelines(lines)
         except Exception:
-            sys.stderr.write(
+            self.environment.get_logger().error(
                 '*** Error while generating commit email\n'
                 '***  - mail sending aborted.\n'
                 )
-            try:
+            if hasattr(p, 'terminate'):
                 # subprocess.terminate() is not available in Python 2.4
                 p.terminate()
-            except AttributeError:
-                pass
+            else:
+                import signal
+                os.kill(p.pid, signal.SIGTERM)
             raise
         else:
             p.stdin.close()
@@ -1999,14 +2027,16 @@ class SendMailer(Mailer):
 class SMTPMailer(Mailer):
     """Send emails using Python's smtplib."""
 
-    def __init__(self, envelopesender, smtpserver,
+    def __init__(self, environment,
+                 envelopesender, smtpserver,
                  smtpservertimeout=10.0, smtpserverdebuglevel=0,
                  smtpencryption='none',
                  smtpuser='', smtppass='',
                  smtpcacerts=''
                  ):
+        super(SMTPMailer, self).__init__(environment)
         if not envelopesender:
-            sys.stderr.write(
+            self.environment.get_logger().error(
                 'fatal: git_multimail: cannot use SMTPMailer without a sender address.\n'
                 'please set either multimailhook.envelopeSender or user.email\n'
                 )
@@ -2041,7 +2071,7 @@ class SMTPMailer(Mailer):
                 self.smtp = call(smtplib.SMTP_SSL, self.smtpserver, timeout=self.smtpservertimeout)
             elif self.security == 'tls':
                 if 'ssl' not in sys.modules:
-                    sys.stderr.write(
+                    self.environment.get_logger().error(
                         '*** Your Python version does not have the ssl library installed\n'
                         '*** smtpEncryption=tls is not available.\n'
                         '*** Either upgrade Python to 2.6 or later\n'
@@ -2071,7 +2101,7 @@ class SMTPMailer(Mailer):
                         self.smtp.sock,
                         cert_reqs=ssl.CERT_NONE
                         )
-                    sys.stderr.write(
+                    self.environment.get_logger().error(
                         '*** Warning, the server certificat is not verified (smtp) ***\n'
                         '***          set the option smtpCACerts                   ***\n'
                         )
@@ -2094,10 +2124,10 @@ class SMTPMailer(Mailer):
                     % self.smtpserverdebuglevel)
                 self.smtp.set_debuglevel(self.smtpserverdebuglevel)
         except Exception:
-            sys.stderr.write(
+            self.environment.get_logger().error(
                 '*** Error establishing SMTP connection to %s ***\n'
-                % self.smtpserver)
-            sys.stderr.write('*** %s\n' % sys.exc_info()[1])
+                '*** %s\n'
+                % (self.smtpserver, sys.exc_info()[1]))
             sys.exit(1)
 
     def __del__(self):
@@ -2115,10 +2145,11 @@ class SMTPMailer(Mailer):
                 to_addrs = [email for (name, email) in getaddresses([to_addrs])]
             self.smtp.sendmail(self.envelopesender, to_addrs, msg)
         except smtplib.SMTPResponseException:
-            sys.stderr.write('*** Error sending email ***\n')
             err = sys.exc_info()[1]
-            sys.stderr.write('*** Error %d: %s\n' % (err.smtp_code,
-                                                     bytes_to_str(err.smtp_error)))
+            self.environment.get_logger().error(
+                '*** Error sending email ***\n'
+                '*** Error %d: %s\n'
+                % (err.smtp_code, bytes_to_str(err.smtp_error)))
             try:
                 smtp = self.smtp
                 # delete the field before quit() so that in case of
@@ -2126,9 +2157,10 @@ class SMTPMailer(Mailer):
                 del self.smtp
                 smtp.quit()
             except:
-                sys.stderr.write('*** Error closing the SMTP connection ***\n')
-                sys.stderr.write('*** Exiting anyway ... ***\n')
-                sys.stderr.write('*** %s\n' % sys.exc_info()[1])
+                self.environment.get_logger().error(
+                    '*** Error closing the SMTP connection ***\n'
+                    '*** Exiting anyway ... ***\n'
+                    '*** %s\n' % sys.exc_info()[1])
             sys.exit(1)
 
 
@@ -2250,6 +2282,11 @@ class Environment(object):
             to send and when computing what commits are considered new
             to the repository.  Default is "^refs/notes/".
 
+        get_max_subject_length()
+
+            Return an int giving the maximal length for the subject
+            (git log --oneline).
+
     They should also define the following attributes:
 
         announce_show_shortlog (bool)
@@ -2324,6 +2361,15 @@ class Environment(object):
             multimailhook.fromRefchange and multimailhook.fromCommit
             by ConfigEnvironmentMixin.
 
+        log_file, error_log_file, debug_log_file (string)
+
+            Name of a file to which logs should be sent.
+
+        verbose (int)
+
+            How verbose the system should be.
+            - 0 (default): show info, errors, ...
+            - 1 : show basic debug info
     """
 
     REPO_NAME_RE = re.compile(r'^(?P<name>.+?)(?:\.git)$')
@@ -2346,6 +2392,7 @@ class Environment(object):
         self.quiet = False
         self.stdout = False
         self.combine_when_single_commit = True
+        self.logger = None
 
         self.COMPUTED_KEYS = [
             'administrator',
@@ -2360,6 +2407,12 @@ class Environment(object):
 
         self._values = None
 
+    def get_logger(self):
+        """Get (possibly creates) the logger associated to this environment."""
+        if self.logger is None:
+            self.logger = Logger(self)
+        return self.logger
+
     def get_repo_shortname(self):
         """Use the last part of the repo path, with ".git" stripped off if present."""
 
@@ -2467,6 +2520,11 @@ class Environment(object):
         # which we simply do not have right now.
         return "^refs/notes/"
 
+    def get_max_subject_length(self):
+        """Return the maximal subject line (git log --oneline) length.
+        Longer subject lines will be truncated."""
+        raise NotImplementedError()
+
     def filter_body(self, lines):
         """Filter the lines intended for an email body.
 
@@ -2482,19 +2540,22 @@ class Environment(object):
         """Write the string msg on a log file or on stderr.
 
         Sends the text to stderr by default, override to change the behavior."""
-        write_str(sys.stderr, msg)
+        self.get_logger().info(msg)
 
     def log_warning(self, msg):
         """Write the string msg on a log file or on stderr.
 
         Sends the text to stderr by default, override to change the behavior."""
-        write_str(sys.stderr, msg)
+        self.get_logger().warning(msg)
 
     def log_error(self, msg):
         """Write the string msg on a log file or on stderr.
 
         Sends the text to stderr by default, override to change the behavior."""
-        write_str(sys.stderr, msg)
+        self.get_logger().error(msg)
+
+    def check(self):
+        pass
 
 
 class ConfigEnvironmentMixin(Environment):
@@ -2613,6 +2674,14 @@ class ConfigOptionsEnvironmentMixin(ConfigEnvironmentMixin):
         if combine is not None:
             self.combine_when_single_commit = combine
 
+        self.log_file = config.get('logFile', default=None)
+        self.error_log_file = config.get('errorLogFile', default=None)
+        self.debug_log_file = config.get('debugLogFile', default=None)
+        if config.get_bool('Verbose', default=False):
+            self.verbose = 1
+        else:
+            self.verbose = 0
+
     def get_administrator(self):
         return (
             self.config.get('administrator') or
@@ -2631,11 +2700,21 @@ class ConfigOptionsEnvironmentMixin(ConfigEnvironmentMixin):
         if emailprefix is not None:
             emailprefix = emailprefix.strip()
             if emailprefix:
-                return emailprefix + ' '
-            else:
-                return ''
+                emailprefix += ' '
         else:
-            return '[%s] ' % (self.get_repo_shortname(),)
+            emailprefix = '[%(repo_shortname)s] '
+        short_name = self.get_repo_shortname()
+        try:
+            return emailprefix % {'repo_shortname': short_name}
+        except:
+            self.get_logger().error(
+                '*** Invalid multimailhook.emailPrefix: %s\n' % emailprefix +
+                '*** %s\n' % sys.exc_info()[1] +
+                "*** Only the '%(repo_shortname)s' placeholder is allowed\n"
+                )
+            raise ConfigurationException(
+                '"%s" is not an allowed setting for emailPrefix' % emailprefix
+                )
 
     def get_sender(self):
         return self.config.get('envelopesender')
@@ -2656,9 +2735,9 @@ class ConfigOptionsEnvironmentMixin(ConfigEnvironmentMixin):
     def get_fromaddr(self, change=None):
         fromaddr = self.config.get('from')
         if change:
-            alt_fromaddr = change.get_alt_fromaddr()
-            if alt_fromaddr:
-                fromaddr = alt_fromaddr
+            specific_fromaddr = change.get_specific_fromaddr()
+            if specific_fromaddr:
+                fromaddr = specific_fromaddr
         if fromaddr:
             fromaddr = self.process_addr(fromaddr, change)
         if fromaddr:
@@ -2684,7 +2763,7 @@ class ConfigOptionsEnvironmentMixin(ConfigEnvironmentMixin):
 class FilterLinesEnvironmentMixin(Environment):
     """Handle encoding and maximum line length of body lines.
 
-        emailmaxlinelength (int or None)
+        email_max_line_length (int or None)
 
             The maximum length of any single line in the email body.
             Longer lines are truncated at that length with ' [...]'
@@ -2699,10 +2778,13 @@ class FilterLinesEnvironmentMixin(Environment):
 
     """
 
-    def __init__(self, strict_utf8=True, emailmaxlinelength=500, **kw):
+    def __init__(self, strict_utf8=True,
+                 email_max_line_length=500, max_subject_length=500,
+                 **kw):
         super(FilterLinesEnvironmentMixin, self).__init__(**kw)
         self.__strict_utf8 = strict_utf8
-        self.__emailmaxlinelength = emailmaxlinelength
+        self.__email_max_line_length = email_max_line_length
+        self.__max_subject_length = max_subject_length
 
     def filter_body(self, lines):
         lines = super(FilterLinesEnvironmentMixin, self).filter_body(lines)
@@ -2711,15 +2793,18 @@ class FilterLinesEnvironmentMixin(Environment):
                 lines = (line.decode(ENCODING, 'replace') for line in lines)
             # Limit the line length in Unicode-space to avoid
             # splitting characters:
-            if self.__emailmaxlinelength:
-                lines = limit_linelength(lines, self.__emailmaxlinelength)
+            if self.__email_max_line_length > 0:
+                lines = limit_linelength(lines, self.__email_max_line_length)
             if not PYTHON3:
                 lines = (line.encode(ENCODING, 'replace') for line in lines)
-        elif self.__emailmaxlinelength:
-            lines = limit_linelength(lines, self.__emailmaxlinelength)
+        elif self.__email_max_line_length:
+            lines = limit_linelength(lines, self.__email_max_line_length)
 
         return lines
 
+    def get_max_subject_length(self):
+        return self.__max_subject_length
+
 
 class ConfigFilterLinesEnvironmentMixin(
         ConfigEnvironmentMixin,
@@ -2732,9 +2817,13 @@ class ConfigFilterLinesEnvironmentMixin(
         if strict_utf8 is not None:
             kw['strict_utf8'] = strict_utf8
 
-        emailmaxlinelength = config.get('emailmaxlinelength')
-        if emailmaxlinelength is not None:
-            kw['emailmaxlinelength'] = int(emailmaxlinelength)
+        email_max_line_length = config.get('emailmaxlinelength')
+        if email_max_line_length is not None:
+            kw['email_max_line_length'] = int(email_max_line_length)
+
+        max_subject_length = config.get('subjectMaxLength', default=email_max_line_length)
+        if max_subject_length is not None:
+            kw['max_subject_length'] = int(max_subject_length)
 
         super(ConfigFilterLinesEnvironmentMixin, self).__init__(
             config=config, **kw
@@ -2750,7 +2839,7 @@ class MaxlinesEnvironmentMixin(Environment):
 
     def filter_body(self, lines):
         lines = super(MaxlinesEnvironmentMixin, self).filter_body(lines)
-        if self.__emailmaxlines:
+        if self.__emailmaxlines > 0:
             lines = limit_lines(lines, self.__emailmaxlines)
         return lines
 
@@ -2843,25 +2932,64 @@ class StaticRecipientsEnvironmentMixin(Environment):
         # actual *contents* of the change being reported, we only
         # choose based on the *type* of the change.  Therefore we can
         # compute them once and for all:
-        if not (refchange_recipients or
-                announce_recipients or
-                revision_recipients or
-                scancommitforcc):
-            raise ConfigurationException('No email recipients configured!')
         self.__refchange_recipients = refchange_recipients
         self.__announce_recipients = announce_recipients
         self.__revision_recipients = revision_recipients
 
+    def check(self):
+        if not (self.get_refchange_recipients(None) or
+                self.get_announce_recipients(None) or
+                self.get_revision_recipients(None) or
+                self.get_scancommitforcc()):
+            raise ConfigurationException('No email recipients configured!')
+        super(StaticRecipientsEnvironmentMixin, self).check()
+
     def get_refchange_recipients(self, refchange):
+        if self.__refchange_recipients is None:
+            return super(StaticRecipientsEnvironmentMixin,
+                         self).get_refchange_recipients(refchange)
         return self.__refchange_recipients
 
     def get_announce_recipients(self, annotated_tag_change):
+        if self.__announce_recipients is None:
+            return super(StaticRecipientsEnvironmentMixin,
+                         self).get_refchange_recipients(annotated_tag_change)
         return self.__announce_recipients
 
     def get_revision_recipients(self, revision):
+        if self.__revision_recipients is None:
+            return super(StaticRecipientsEnvironmentMixin,
+                         self).get_refchange_recipients(revision)
         return self.__revision_recipients
 
 
+class CLIRecipientsEnvironmentMixin(Environment):
+    """Mixin storing recipients information comming from the
+    command-line."""
+
+    def __init__(self, cli_recipients=None, **kw):
+        super(CLIRecipientsEnvironmentMixin, self).__init__(**kw)
+        self.__cli_recipients = cli_recipients
+
+    def get_refchange_recipients(self, refchange):
+        if self.__cli_recipients is None:
+            return super(CLIRecipientsEnvironmentMixin,
+                         self).get_refchange_recipients(refchange)
+        return self.__cli_recipients
+
+    def get_announce_recipients(self, annotated_tag_change):
+        if self.__cli_recipients is None:
+            return super(CLIRecipientsEnvironmentMixin,
+                         self).get_announce_recipients(annotated_tag_change)
+        return self.__cli_recipients
+
+    def get_revision_recipients(self, revision):
+        if self.__cli_recipients is None:
+            return super(CLIRecipientsEnvironmentMixin,
+                         self).get_revision_recipients(revision)
+        return self.__cli_recipients
+
+
 class ConfigRecipientsEnvironmentMixin(
         ConfigEnvironmentMixin,
         StaticRecipientsEnvironmentMixin
@@ -2935,24 +3063,20 @@ class StaticRefFilterEnvironmentMixin(Environment):
         if ref_filter_do_send_regex and ref_filter_dont_send_regex:
             raise ConfigurationException(
                 "Cannot specify both a ref doSend and dontSend regex.")
-        if ref_filter_do_send_regex or ref_filter_dont_send_regex:
-            self.__is_do_send_filter = bool(ref_filter_do_send_regex)
-            if ref_filter_incl_regex:
-                ref_filter_send_regex = ref_filter_incl_regex
-            elif ref_filter_excl_regex:
-                ref_filter_send_regex = ref_filter_excl_regex
-            else:
-                ref_filter_send_regex = '.*'
-                self.__is_do_send_filter = True
-            try:
-                self.__send_compiled_regex = re.compile(ref_filter_send_regex)
-            except Exception:
-                raise ConfigurationException(
-                    'Invalid Ref Filter Regex "%s": %s' %
-                    (ref_filter_send_regex, sys.exc_info()[1]))
+        self.__is_do_send_filter = bool(ref_filter_do_send_regex)
+        if ref_filter_do_send_regex:
+            ref_filter_send_regex = ref_filter_do_send_regex
+        elif ref_filter_dont_send_regex:
+            ref_filter_send_regex = ref_filter_dont_send_regex
         else:
-            self.__send_compiled_regex = self.__compiled_regex
-            self.__is_do_send_filter = self.__is_inclusion_filter
+            ref_filter_send_regex = '.*'
+            self.__is_do_send_filter = True
+        try:
+            self.__send_compiled_regex = re.compile(ref_filter_send_regex)
+        except Exception:
+            raise ConfigurationException(
+                'Invalid Ref Filter Regex "%s": %s' %
+                (ref_filter_send_regex, sys.exc_info()[1]))
 
     def get_ref_filter_regex(self, send_filter=False):
         if send_filter:
@@ -3023,34 +3147,21 @@ class GenericEnvironmentMixin(Environment):
         return self.osenv.get('USER', self.osenv.get('USERNAME', 'unknown user'))
 
 
-class GenericEnvironment(
-        ProjectdescEnvironmentMixin,
-        ConfigMaxlinesEnvironmentMixin,
-        ComputeFQDNEnvironmentMixin,
-        ConfigFilterLinesEnvironmentMixin,
-        ConfigRecipientsEnvironmentMixin,
-        ConfigRefFilterEnvironmentMixin,
-        PusherDomainEnvironmentMixin,
-        ConfigOptionsEnvironmentMixin,
-        GenericEnvironmentMixin,
-        Environment,
-        ):
-    pass
+class GitoliteEnvironmentHighPrecMixin(Environment):
+    def get_pusher(self):
+        return self.osenv.get('GL_USER', 'unknown user')
 
 
-class GitoliteEnvironmentMixin(Environment):
+class GitoliteEnvironmentLowPrecMixin(Environment):
     def get_repo_shortname(self):
         # The gitolite environment variable $GL_REPO is a pretty good
         # repo_shortname (though it's probably not as good as a value
         # the user might have explicitly put in his config).
         return (
             self.osenv.get('GL_REPO', None) or
-            super(GitoliteEnvironmentMixin, self).get_repo_shortname()
+            super(GitoliteEnvironmentLowPrecMixin, self).get_repo_shortname()
             )
 
-    def get_pusher(self):
-        return self.osenv.get('GL_USER', 'unknown user')
-
     def get_fromaddr(self, change=None):
         GL_USER = self.osenv.get('GL_USER')
         if GL_USER is not None:
@@ -3088,7 +3199,7 @@ class GitoliteEnvironmentMixin(Environment):
                             return m.group(1)
                 finally:
                     f.close()
-        return super(GitoliteEnvironmentMixin, self).get_fromaddr(change)
+        return super(GitoliteEnvironmentLowPrecMixin, self).get_fromaddr(change)
 
 
 class IncrementalDateTime(object):
@@ -3109,67 +3220,43 @@ class IncrementalDateTime(object):
         return formatted
 
 
-class GitoliteEnvironment(
-        ProjectdescEnvironmentMixin,
-        ConfigMaxlinesEnvironmentMixin,
-        ComputeFQDNEnvironmentMixin,
-        ConfigFilterLinesEnvironmentMixin,
-        ConfigRecipientsEnvironmentMixin,
-        ConfigRefFilterEnvironmentMixin,
-        PusherDomainEnvironmentMixin,
-        ConfigOptionsEnvironmentMixin,
-        GitoliteEnvironmentMixin,
-        Environment,
-        ):
-    pass
-
-
-class StashEnvironmentMixin(Environment):
+class StashEnvironmentHighPrecMixin(Environment):
     def __init__(self, user=None, repo=None, **kw):
-        super(StashEnvironmentMixin, self).__init__(**kw)
+        super(StashEnvironmentHighPrecMixin,
+              self).__init__(user=user, repo=repo, **kw)
         self.__user = user
         self.__repo = repo
 
-    def get_repo_shortname(self):
-        return self.__repo
-
     def get_pusher(self):
         return re.match('(.*?)\s*<', self.__user).group(1)
 
     def get_pusher_email(self):
         return self.__user
 
-    def get_fromaddr(self, change=None):
-        return self.__user
 
+class StashEnvironmentLowPrecMixin(Environment):
+    def __init__(self, user=None, repo=None, **kw):
+        super(StashEnvironmentLowPrecMixin, self).__init__(**kw)
+        self.__repo = repo
+        self.__user = user
 
-class StashEnvironment(
-        StashEnvironmentMixin,
-        ProjectdescEnvironmentMixin,
-        ConfigMaxlinesEnvironmentMixin,
-        ComputeFQDNEnvironmentMixin,
-        ConfigFilterLinesEnvironmentMixin,
-        ConfigRecipientsEnvironmentMixin,
-        ConfigRefFilterEnvironmentMixin,
-        PusherDomainEnvironmentMixin,
-        ConfigOptionsEnvironmentMixin,
-        Environment,
-        ):
-    pass
+    def get_repo_shortname(self):
+        return self.__repo
+
+    def get_fromaddr(self, change=None):
+        return self.__user
 
 
-class GerritEnvironmentMixin(Environment):
+class GerritEnvironmentHighPrecMixin(Environment):
     def __init__(self, project=None, submitter=None, update_method=None, **kw):
-        super(GerritEnvironmentMixin, self).__init__(**kw)
+        super(GerritEnvironmentHighPrecMixin,
+              self).__init__(submitter=submitter, project=project, **kw)
         self.__project = project
         self.__submitter = submitter
         self.__update_method = update_method
         "Make an 'update_method' value available for templates."
         self.COMPUTED_KEYS += ['update_method']
 
-    def get_repo_shortname(self):
-        return self.__project
-
     def get_pusher(self):
         if self.__submitter:
             if self.__submitter.find('<') != -1:
@@ -3192,16 +3279,10 @@ class GerritEnvironmentMixin(Environment):
         if self.__submitter:
             return self.__submitter
         else:
-            return super(GerritEnvironmentMixin, self).get_pusher_email()
-
-    def get_fromaddr(self, change=None):
-        if self.__submitter and self.__submitter.find('<') != -1:
-            return self.__submitter
-        else:
-            return super(GerritEnvironmentMixin, self).get_fromaddr(change)
+            return super(GerritEnvironmentHighPrecMixin, self).get_pusher_email()
 
     def get_default_ref_ignore_regex(self):
-        default = super(GerritEnvironmentMixin, self).get_default_ref_ignore_regex()
+        default = super(GerritEnvironmentHighPrecMixin, self).get_default_ref_ignore_regex()
         return default + '|^refs/changes/|^refs/cache-automerge/|^refs/meta/'
 
     def get_revision_recipients(self, revision):
@@ -3214,25 +3295,26 @@ class GerritEnvironmentMixin(Environment):
         if committer == 'Gerrit Code Review':
             return []
         else:
-            return super(GerritEnvironmentMixin, self).get_revision_recipients(revision)
+            return super(GerritEnvironmentHighPrecMixin, self).get_revision_recipients(revision)
 
     def get_update_method(self):
         return self.__update_method
 
 
-class GerritEnvironment(
-        GerritEnvironmentMixin,
-        ProjectdescEnvironmentMixin,
-        ConfigMaxlinesEnvironmentMixin,
-        ComputeFQDNEnvironmentMixin,
-        ConfigFilterLinesEnvironmentMixin,
-        ConfigRecipientsEnvironmentMixin,
-        ConfigRefFilterEnvironmentMixin,
-        PusherDomainEnvironmentMixin,
-        ConfigOptionsEnvironmentMixin,
-        Environment,
-        ):
-    pass
+class GerritEnvironmentLowPrecMixin(Environment):
+    def __init__(self, project=None, submitter=None, **kw):
+        super(GerritEnvironmentLowPrecMixin, self).__init__(**kw)
+        self.__project = project
+        self.__submitter = submitter
+
+    def get_repo_shortname(self):
+        return self.__project
+
+    def get_fromaddr(self, change=None):
+        if self.__submitter and self.__submitter.find('<') != -1:
+            return self.__submitter
+        else:
+            return super(GerritEnvironmentLowPrecMixin, self).get_fromaddr(change)
 
 
 class Push(object):
@@ -3498,13 +3580,13 @@ class Push(object):
             if not change.recipients:
                 change.environment.log_warning(
                     '*** no recipients configured so no email will be sent\n'
-                    '*** for %r update %s->%s\n'
+                    '*** for %r update %s->%s'
                     % (change.refname, change.old.sha1, change.new.sha1,)
                     )
             else:
                 if not change.environment.quiet:
                     change.environment.log_msg(
-                        'Sending notification emails to: %s\n' % (change.recipients,))
+                        'Sending notification emails to: %s' % (change.recipients,))
                 extra_values = {'send_date': next(send_date)}
 
                 rev = change.send_single_combined_email(sha1s)
@@ -3527,14 +3609,14 @@ class Push(object):
                 change.environment.log_warning(
                     '*** Too many new commits (%d), not sending commit emails.\n' % len(sha1s) +
                     '*** Try setting multimailhook.maxCommitEmails to a greater value\n' +
-                    '*** Currently, multimailhook.maxCommitEmails=%d\n' % max_emails
+                    '*** Currently, multimailhook.maxCommitEmails=%d' % max_emails
                     )
                 return
 
             for (num, sha1) in enumerate(sha1s):
                 rev = Revision(change, GitObject(sha1), num=num + 1, tot=len(sha1s))
                 if not rev.recipients and rev.cc_recipients:
-                    change.environment.log_msg('*** Replacing Cc: with To:\n')
+                    change.environment.log_msg('*** Replacing Cc: with To:')
                     rev.recipients = rev.cc_recipients
                     rev.cc_recipients = None
                 if rev.recipients:
@@ -3548,7 +3630,7 @@ class Push(object):
         if unhandled_sha1s:
             change.environment.log_error(
                 'ERROR: No emails were sent for the following new commits:\n'
-                '    %s\n'
+                '    %s'
                 % ('\n    '.join(sorted(unhandled_sha1s)),)
                 )
 
@@ -3562,12 +3644,23 @@ def include_ref(refname, ref_filter_regex, is_inclusion_filter):
 
 
 def run_as_post_receive_hook(environment, mailer):
-    ref_filter_regex, is_inclusion_filter = environment.get_ref_filter_regex(True)
+    environment.check()
+    send_filter_regex, send_is_inclusion_filter = environment.get_ref_filter_regex(True)
+    ref_filter_regex, is_inclusion_filter = environment.get_ref_filter_regex(False)
     changes = []
-    for line in sys.stdin:
+    while True:
+        line = read_line(sys.stdin)
+        if line == '':
+            break
         (oldrev, newrev, refname) = line.strip().split(' ', 2)
+        environment.get_logger().debug(
+            "run_as_post_receive_hook: oldrev=%s, newrev=%s, refname=%s" %
+            (oldrev, newrev, refname))
+
         if not include_ref(refname, ref_filter_regex, is_inclusion_filter):
             continue
+        if not include_ref(refname, send_filter_regex, send_is_inclusion_filter):
+            continue
         changes.append(
             ReferenceChange.create(environment, oldrev, newrev, refname)
             )
@@ -3579,9 +3672,13 @@ def run_as_post_receive_hook(environment, mailer):
 
 
 def run_as_update_hook(environment, mailer, refname, oldrev, newrev, force_send=False):
-    ref_filter_regex, is_inclusion_filter = environment.get_ref_filter_regex(True)
+    environment.check()
+    send_filter_regex, send_is_inclusion_filter = environment.get_ref_filter_regex(True)
+    ref_filter_regex, is_inclusion_filter = environment.get_ref_filter_regex(False)
     if not include_ref(refname, ref_filter_regex, is_inclusion_filter):
         return
+    if not include_ref(refname, send_filter_regex, send_is_inclusion_filter):
+        return
     changes = [
         ReferenceChange.create(
             environment,
@@ -3596,6 +3693,75 @@ def run_as_update_hook(environment, mailer, refname, oldrev, newrev, force_send=
         mailer.__del__()
 
 
+def check_ref_filter(environment):
+    send_filter_regex, send_is_inclusion = environment.get_ref_filter_regex(True)
+    ref_filter_regex, ref_is_inclusion = environment.get_ref_filter_regex(False)
+
+    def inc_exc_lusion(b):
+        if b:
+            return 'inclusion'
+        else:
+            return 'exclusion'
+
+    if send_filter_regex:
+        sys.stdout.write("DoSend/DontSend filter regex (" +
+                         (inc_exc_lusion(send_is_inclusion)) +
+                         '): ' + send_filter_regex.pattern +
+                         '\n')
+    if send_filter_regex:
+        sys.stdout.write("Include/Exclude filter regex (" +
+                         (inc_exc_lusion(ref_is_inclusion)) +
+                         '): ' + ref_filter_regex.pattern +
+                         '\n')
+    sys.stdout.write(os.linesep)
+
+    sys.stdout.write(
+        "Refs marked as EXCLUDE are excluded by either refFilterInclusionRegex\n"
+        "or refFilterExclusionRegex. No emails will be sent for commits included\n"
+        "in these refs.\n"
+        "Refs marked as DONT-SEND are excluded by either refFilterDoSendRegex or\n"
+        "refFilterDontSendRegex, but not by either refFilterInclusionRegex or\n"
+        "refFilterExclusionRegex. Emails will be sent for commits included in these\n"
+        "refs only when the commit reaches a ref which isn't excluded.\n"
+        "Refs marked as DO-SEND are not excluded by any filter. Emails will\n"
+        "be sent normally for commits included in these refs.\n")
+
+    sys.stdout.write(os.linesep)
+
+    for refname in read_git_lines(['for-each-ref', '--format', '%(refname)']):
+        sys.stdout.write(refname)
+        if not include_ref(refname, ref_filter_regex, ref_is_inclusion):
+            sys.stdout.write(' EXCLUDE')
+        elif not include_ref(refname, send_filter_regex, send_is_inclusion):
+            sys.stdout.write(' DONT-SEND')
+        else:
+            sys.stdout.write(' DO-SEND')
+
+        sys.stdout.write(os.linesep)
+
+
+def show_env(environment, out):
+    out.write('Environment values:\n')
+    for (k, v) in sorted(environment.get_values().items()):
+        if k:  # Don't show the {'' : ''} pair.
+            out.write('    %s : %r\n' % (k, v))
+    out.write('\n')
+    # Flush to avoid interleaving with further log output
+    out.flush()
+
+
+def check_setup(environment):
+    environment.check()
+    show_env(environment, sys.stdout)
+    sys.stdout.write("Now, checking that git-multimail's standard input "
+                     "is properly set ..." + os.linesep)
+    sys.stdout.write("Please type some text and then press Return" + os.linesep)
+    stdin = sys.stdin.readline()
+    sys.stdout.write("You have just entered:" + os.linesep)
+    sys.stdout.write(stdin)
+    sys.stdout.write("git-multimail seems properly set up." + os.linesep)
+
+
 def choose_mailer(config, environment):
     mailer = config.get('mailer', default='sendmail')
 
@@ -3608,6 +3774,7 @@ def choose_mailer(config, environment):
         smtppass = config.get('smtppass', default='')
         smtpcacerts = config.get('smtpcacerts', default='')
         mailer = SMTPMailer(
+            environment,
             envelopesender=(environment.get_sender() or environment.get_fromaddr()),
             smtpserver=smtpserver, smtpservertimeout=smtpservertimeout,
             smtpserverdebuglevel=smtpserverdebuglevel,
@@ -3620,43 +3787,41 @@ def choose_mailer(config, environment):
         command = config.get('sendmailcommand')
         if command:
             command = shlex.split(command)
-        mailer = SendMailer(command=command, envelopesender=environment.get_sender())
+        mailer = SendMailer(environment,
+                            command=command, envelopesender=environment.get_sender())
     else:
         environment.log_error(
             'fatal: multimailhook.mailer is set to an incorrect value: "%s"\n' % mailer +
-            'please use one of "smtp" or "sendmail".\n'
+            'please use one of "smtp" or "sendmail".'
             )
         sys.exit(1)
     return mailer
 
 
 KNOWN_ENVIRONMENTS = {
-    'generic': GenericEnvironmentMixin,
-    'gitolite': GitoliteEnvironmentMixin,
-    'stash': StashEnvironmentMixin,
-    'gerrit': GerritEnvironmentMixin,
+    'generic': {'highprec': GenericEnvironmentMixin},
+    'gitolite': {'highprec': GitoliteEnvironmentHighPrecMixin,
+                 'lowprec': GitoliteEnvironmentLowPrecMixin},
+    'stash': {'highprec': StashEnvironmentHighPrecMixin,
+              'lowprec': StashEnvironmentLowPrecMixin},
+    'gerrit': {'highprec': GerritEnvironmentHighPrecMixin,
+               'lowprec': GerritEnvironmentLowPrecMixin},
     }
 
 
 def choose_environment(config, osenv=None, env=None, recipients=None,
                        hook_info=None):
+    env_name = choose_environment_name(config, env, osenv)
+    environment_klass = build_environment_klass(env_name)
+    env = build_environment(environment_klass, env_name, config,
+                            osenv, recipients, hook_info)
+    return env
+
+
+def choose_environment_name(config, env, osenv):
     if not osenv:
         osenv = os.environ
 
-    environment_mixins = [
-        ConfigRefFilterEnvironmentMixin,
-        ProjectdescEnvironmentMixin,
-        ConfigMaxlinesEnvironmentMixin,
-        ComputeFQDNEnvironmentMixin,
-        ConfigFilterLinesEnvironmentMixin,
-        PusherDomainEnvironmentMixin,
-        ConfigOptionsEnvironmentMixin,
-        ]
-    environment_kw = {
-        'osenv': osenv,
-        'config': config,
-        }
-
     if not env:
         env = config.get('environment')
 
@@ -3665,8 +3830,58 @@ def choose_environment(config, osenv=None, env=None, recipients=None,
             env = 'gitolite'
         else:
             env = 'generic'
+    return env
+
+
+COMMON_ENVIRONMENT_MIXINS = [
+    ConfigRecipientsEnvironmentMixin,
+    CLIRecipientsEnvironmentMixin,
+    ConfigRefFilterEnvironmentMixin,
+    ProjectdescEnvironmentMixin,
+    ConfigMaxlinesEnvironmentMixin,
+    ComputeFQDNEnvironmentMixin,
+    ConfigFilterLinesEnvironmentMixin,
+    PusherDomainEnvironmentMixin,
+    ConfigOptionsEnvironmentMixin,
+    ]
+
+
+def build_environment_klass(env_name):
+    if 'class' in KNOWN_ENVIRONMENTS[env_name]:
+        return KNOWN_ENVIRONMENTS[env_name]['class']
+
+    environment_mixins = []
+    known_env = KNOWN_ENVIRONMENTS[env_name]
+    if 'highprec' in known_env:
+        high_prec_mixin = known_env['highprec']
+        environment_mixins.append(high_prec_mixin)
+    environment_mixins = environment_mixins + COMMON_ENVIRONMENT_MIXINS
+    if 'lowprec' in known_env:
+        low_prec_mixin = known_env['lowprec']
+        environment_mixins.append(low_prec_mixin)
+    environment_mixins.append(Environment)
+    klass_name = env_name.capitalize() + 'Environement'
+    environment_klass = type(
+        klass_name,
+        tuple(environment_mixins),
+        {},
+        )
+    KNOWN_ENVIRONMENTS[env_name]['class'] = environment_klass
+    return environment_klass
+
 
-    environment_mixins.insert(0, KNOWN_ENVIRONMENTS[env])
+GerritEnvironment = build_environment_klass('gerrit')
+StashEnvironment = build_environment_klass('stash')
+GitoliteEnvironment = build_environment_klass('gitolite')
+GenericEnvironment = build_environment_klass('generic')
+
+
+def build_environment(environment_klass, env, config,
+                      osenv, recipients, hook_info):
+    environment_kw = {
+        'osenv': osenv,
+        'config': config,
+        }
 
     if env == 'stash':
         environment_kw['user'] = hook_info['stash_user']
@@ -3676,20 +3891,8 @@ def choose_environment(config, osenv=None, env=None, recipients=None,
         environment_kw['submitter'] = hook_info['submitter']
         environment_kw['update_method'] = hook_info['update_method']
 
-    if recipients:
-        environment_mixins.insert(0, StaticRecipientsEnvironmentMixin)
-        environment_kw['refchange_recipients'] = recipients
-        environment_kw['announce_recipients'] = recipients
-        environment_kw['revision_recipients'] = recipients
-        environment_kw['scancommitforcc'] = config.get('scancommitforcc')
-    else:
-        environment_mixins.insert(0, ConfigRecipientsEnvironmentMixin)
+    environment_kw['cli_recipients'] = recipients
 
-    environment_klass = type(
-        'EffectiveEnvironment',
-        tuple(environment_mixins) + (Environment,),
-        {},
-        )
     return environment_klass(**environment_kw)
 
 
@@ -3710,7 +3913,8 @@ def get_version():
     return __version__
 
 
-def compute_gerrit_options(options, args, required_gerrit_options):
+def compute_gerrit_options(options, args, required_gerrit_options,
+                           raw_refname):
     if None in required_gerrit_options:
         raise SystemExit("Error: Specify all of --oldrev, --newrev, --refname, "
                          "and --project; or none of them.")
@@ -3727,24 +3931,11 @@ def compute_gerrit_options(options, args, required_gerrit_options):
     # Gerrit oddly omits 'refs/heads/' in the refname when calling
     # ref-updated hook; put it back.
     git_dir = get_git_dir()
-    if (not os.path.exists(os.path.join(git_dir, options.refname)) and
+    if (not os.path.exists(os.path.join(git_dir, raw_refname)) and
         os.path.exists(os.path.join(git_dir, 'refs', 'heads',
-                                    options.refname))):
+                                    raw_refname))):
         options.refname = 'refs/heads/' + options.refname
 
-    # Convert each string option unicode for Python3.
-    if PYTHON3:
-        opts = ['environment', 'recipients', 'oldrev', 'newrev', 'refname',
-                'project', 'submitter', 'stash-user', 'stash-repo']
-        for opt in opts:
-            if not hasattr(options, opt):
-                continue
-            obj = getattr(options, opt)
-            if obj:
-                enc = obj.encode('utf-8', 'surrogateescape')
-                dec = enc.decode('utf-8', 'replace')
-                setattr(options, opt, dec)
-
     # New revisions can appear in a gerrit repository either due to someone
     # pushing directly (in which case options.submitter will be set), or they
     # can press "Submit this patchset" in the web UI for some CR (in which
@@ -3784,6 +3975,20 @@ def compute_gerrit_options(options, args, required_gerrit_options):
 
 
 def check_hook_specific_args(options, args):
+    raw_refname = options.refname
+    # Convert each string option unicode for Python3.
+    if PYTHON3:
+        opts = ['environment', 'recipients', 'oldrev', 'newrev', 'refname',
+                'project', 'submitter', 'stash_user', 'stash_repo']
+        for opt in opts:
+            if not hasattr(options, opt):
+                continue
+            obj = getattr(options, opt)
+            if obj:
+                enc = obj.encode('utf-8', 'surrogateescape')
+                dec = enc.decode('utf-8', 'replace')
+                setattr(options, opt, dec)
+
     # First check for stash arguments
     if (options.stash_user is None) != (options.stash_repo is None):
         raise SystemExit("Error: Specify both of --stash-user and "
@@ -3797,12 +4002,78 @@ def check_hook_specific_args(options, args):
     required_gerrit_options = (options.oldrev, options.newrev, options.refname,
                                options.project)
     if required_gerrit_options != (None,) * 4:
-        return compute_gerrit_options(options, args, required_gerrit_options)
+        return compute_gerrit_options(options, args, required_gerrit_options,
+                                      raw_refname)
 
     # No special options in use, just return what we started with
     return options, args, {}
 
 
+class Logger(object):
+    def parse_verbose(self, verbose):
+        if verbose > 0:
+            return logging.DEBUG
+        else:
+            return logging.INFO
+
+    def create_log_file(self, environment, name, path, verbosity):
+        log_file = logging.getLogger(name)
+        file_handler = logging.FileHandler(path)
+        log_fmt = logging.Formatter("%(asctime)s [%(levelname)-5.5s]  %(message)s")
+        file_handler.setFormatter(log_fmt)
+        log_file.addHandler(file_handler)
+        log_file.setLevel(verbosity)
+        return log_file
+
+    def __init__(self, environment):
+        self.environment = environment
+        self.loggers = []
+        stderr_log = logging.getLogger('git_multimail.stderr')
+
+        class EncodedStderr(object):
+            def write(self, x):
+                write_str(sys.stderr, x)
+
+            def flush(self):
+                sys.stderr.flush()
+
+        stderr_handler = logging.StreamHandler(EncodedStderr())
+        stderr_log.addHandler(stderr_handler)
+        stderr_log.setLevel(self.parse_verbose(environment.verbose))
+        self.loggers.append(stderr_log)
+
+        if environment.debug_log_file is not None:
+            debug_log_file = self.create_log_file(
+                environment, 'git_multimail.debug', environment.debug_log_file, logging.DEBUG)
+            self.loggers.append(debug_log_file)
+
+        if environment.log_file is not None:
+            log_file = self.create_log_file(
+                environment, 'git_multimail.file', environment.log_file, logging.INFO)
+            self.loggers.append(log_file)
+
+        if environment.error_log_file is not None:
+            error_log_file = self.create_log_file(
+                environment, 'git_multimail.error', environment.error_log_file, logging.ERROR)
+            self.loggers.append(error_log_file)
+
+    def info(self, msg):
+        for l in self.loggers:
+            l.info(msg)
+
+    def debug(self, msg):
+        for l in self.loggers:
+            l.debug(msg)
+
+    def warning(self, msg):
+        for l in self.loggers:
+            l.warning(msg)
+
+    def error(self, msg):
+        for l in self.loggers:
+            l.error(msg)
+
+
 def main(args):
     parser = optparse.OptionParser(
         description=__doc__,
@@ -3829,7 +4100,7 @@ def main(args):
         '--show-env', action='store_true', default=False,
         help=(
             'Write to stderr the values determined for the environment '
-            '(intended for debugging purposes).'
+            '(intended for debugging purposes), then proceed normally.'
             ),
         )
     parser.add_option(
@@ -3854,6 +4125,22 @@ def main(args):
             "Display git-multimail's version"
             ),
         )
+
+    parser.add_option(
+        '--python-version', action='store_true', default=False,
+        help=(
+            "Display the version of Python used by git-multimail"
+            ),
+        )
+
+    parser.add_option(
+        '--check-ref-filter', action='store_true', default=False,
+        help=(
+            'List refs and show information on how git-multimail '
+            'will process them.'
+            )
+        )
+
     # The following options permit this script to be run as a gerrit
     # ref-updated hook.  See e.g.
     # code.google.com/p/gerrit/source/browse/Documentation/config-hooks.txt
@@ -3880,11 +4167,16 @@ def main(args):
         sys.stdout.write('git-multimail version ' + get_version() + '\n')
         return
 
+    if options.python_version:
+        sys.stdout.write('Python version ' + sys.version + '\n')
+        return
+
     if options.c:
         Config.add_config_parameters(options.c)
 
     config = Config('multimailhook')
 
+    environment = None
     try:
         environment = choose_environment(
             config, osenv=os.environ,
@@ -3894,38 +4186,52 @@ def main(args):
             )
 
         if options.show_env:
-            sys.stderr.write('Environment values:\n')
-            for (k, v) in sorted(environment.get_values().items()):
-                sys.stderr.write('    %s : %r\n' % (k, v))
-            sys.stderr.write('\n')
+            show_env(environment, sys.stderr)
 
         if options.stdout or environment.stdout:
             mailer = OutputMailer(sys.stdout)
         else:
             mailer = choose_mailer(config, environment)
 
+        must_check_setup = os.environ.get('GIT_MULTIMAIL_CHECK_SETUP')
+        if must_check_setup == '':
+            must_check_setup = False
+        if options.check_ref_filter:
+            check_ref_filter(environment)
+        elif must_check_setup:
+            check_setup(environment)
         # Dual mode: if arguments were specified on the command line, run
         # like an update hook; otherwise, run as a post-receive hook.
-        if args:
+        elif args:
             if len(args) != 3:
                 parser.error('Need zero or three non-option arguments')
             (refname, oldrev, newrev) = args
+            environment.get_logger().debug(
+                "run_as_update_hook: refname=%s, oldrev=%s, newrev=%s, force_send=%s" %
+                (refname, oldrev, newrev, options.force_send))
             run_as_update_hook(environment, mailer, refname, oldrev, newrev, options.force_send)
         else:
             run_as_post_receive_hook(environment, mailer)
     except ConfigurationException:
         sys.exit(sys.exc_info()[1])
+    except SystemExit:
+        raise
     except Exception:
         t, e, tb = sys.exc_info()
         import traceback
-        sys.stdout.write('\n')
-        sys.stdout.write('Exception \'' + t.__name__ +
-                         '\' raised. Please report this as a bug to\n')
-        sys.stdout.write('https://github.com/git-multimail/git-multimail/issues\n')
-        sys.stdout.write('with the information below:\n\n')
-        sys.stdout.write('git-multimail version ' + get_version() + '\n')
-        sys.stdout.write('Python version ' + sys.version + '\n')
-        traceback.print_exc(file=sys.stdout)
+        sys.stderr.write('\n')  # Avoid mixing message with previous output
+        msg = (
+            'Exception \'' + t.__name__ +
+            '\' raised. Please report this as a bug to\n'
+            'https://github.com/git-multimail/git-multimail/issues\n'
+            'with the information below:\n\n'
+            'git-multimail version ' + get_version() + '\n'
+            'Python version ' + sys.version + '\n' +
+            traceback.format_exc())
+        try:
+            environment.get_logger().error(msg)
+        except:
+            sys.stderr.write(msg)
         sys.exit(1)
 
 if __name__ == '__main__':
-- 
2.10.0.rc0.1.g07c9292

