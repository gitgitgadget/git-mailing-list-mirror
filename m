From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] git-multimail: update to release 1.1.0
Date: Thu, 18 Jun 2015 10:46:04 +0200
Message-ID: <1434617164-9417-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 18 10:46:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5VT5-0003TS-LG
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 10:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428AbbFRIqf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Jun 2015 04:46:35 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54531 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753868AbbFRIq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 04:46:26 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5I8kHZV009014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Jun 2015 10:46:17 +0200
Received: from anie.imag.fr (ensi-vpn-247.imag.fr [129.88.57.247])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5I8kIup026761;
	Thu, 18 Jun 2015 10:46:18 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z5VSk-00030B-4o; Thu, 18 Jun 2015 10:46:18 +0200
X-Mailer: git-send-email 2.4.3.435.g7f6fd76
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 18 Jun 2015 10:46:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5I8kHZV009014
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1435221979.4462@7c+PapwJMGtrM6mbbDa3Dg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271939>

The changes are described in CHANGES.

Contributions-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Contributions-by: Richard Hansen <rhansen@rhansen.org>
Contributions-by: Michael Haggerty <mhagger@alum.mit.edu>
Contributions-by: Elijah Newren <newren@gmail.com>
Contributions-by: Luke Mewburn <luke@mewburn.net>
Contributions-by: Dave Boutcher <daveboutcher@gmail.com>
Contributions-by: Azat Khuzhin <a3at.mail@gmail.com>
Contributions-by: Sebastian Schuberth <sschuberth@gmail.com>
Contributions-by: Mikko Johannes Koivunalho <mikko.koivunalho@iki.fi>
Contributions-by: Elijah Newren <newren@palantir.com>
Contributions-by: Beno=C3=AEt Ryder <benoit@ryder.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/hooks/multimail/CHANGES                    |  48 +
 contrib/hooks/multimail/README                     | 279 ++++--
 contrib/hooks/multimail/README.Git                 |   4 +-
 contrib/hooks/multimail/git_multimail.py           | 967 +++++++++++++=
+++-----
 contrib/hooks/multimail/migrate-mailhook-config    |  18 +-
 .../{post-receive =3D> post-receive.example}         |  27 +-
 6 files changed, 1017 insertions(+), 326 deletions(-)
 rename contrib/hooks/multimail/{post-receive =3D> post-receive.example=
} (74%)

diff --git a/contrib/hooks/multimail/CHANGES b/contrib/hooks/multimail/=
CHANGES
index 3603d56..0b823d8 100644
--- a/contrib/hooks/multimail/CHANGES
+++ b/contrib/hooks/multimail/CHANGES
@@ -1,3 +1,51 @@
+Release 1.1.0
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+* When a single commit is pushed, omit the reference changed email.
+  Set multimailhook.combineWhenSingleCommit to false to disable this
+  new feature.
+
+* In gitolite environments, the pusher's email address can be used as
+  the From address by creating a specially formatted comment block in
+  gitolite.conf (see multimailhook.from in README).
+
+* Support for SMTP authentication and SSL/TLS encryption was added,
+  see smtpUser, smtpPass, smtpEncryption in README.
+
+* A new option scanCommitForCc was added to allow git-multimail to
+  search the commit message for 'Cc: ...' lines, and add the
+  corresponding emails in Cc.
+
+* If $USER is not set, use the variable $USERNAME. This is needed on
+  Windows platform to recognize the pusher.
+
+* The emailPrefix variable can now be set to an empty string to remove
+  the prefix.
+
+* A short tutorial was added in doc/gitolite.rst to set up
+  git-multimail with gitolite.
+
+* The post-receive file was renamed to post-receive.example. It has
+  always been an example (the standard way to call git-multimail is to
+  call git_multimail.py), but it was unclear to many users.
+
+* A new refchangeShowGraph option was added to make it possible to
+  include both a graph and a log in the summary emails.  The options
+  to control the graph formatting can be set via the new graphOpts
+  option.
+
+* New option --force-send was added to disable new commit detection
+  for update hook. One use-case is to run git_multimail.py after
+  running "git fetch" to send emails about commits that have just been
+  fetched (the detection of new commits was unreliable in this mode).
+
+* The testing infrastructure was considerably improved (continuous
+  integration with travis-ci, automatic check of PEP8 and RST syntax,
+  many improvements to the test scripts).
+
+This version has been tested with Python 2.4 to 2.7, and Git 1.7.1 to
+2.4.
+
 Release 1.0.0
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
diff --git a/contrib/hooks/multimail/README b/contrib/hooks/multimail/R=
EADME
index 6efa4ff..3a33cb7 100644
--- a/contrib/hooks/multimail/README
+++ b/contrib/hooks/multimail/README
@@ -1,5 +1,8 @@
-			   git-multimail
-			   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+git-multimail Version 1.1.0
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+
+.. image:: https://travis-ci.org/git-multimail/git-multimail.svg?branc=
h=3Dmaster
+    :target: https://travis-ci.org/git-multimail/git-multimail
=20
 git-multimail is a tool for sending notification emails on pushes to a
 Git repository.  It includes a Python module called git_multimail.py,
@@ -38,17 +41,17 @@ By default, for each push received by the repositor=
y, git-multimail:
    list) makes it easy to scan through the emails, jump to patches
    that need further attention, and write comments about specific
    commits.  Commits are handled in reverse topological order (i.e.,
-   parents shown before children).  For example,
-
-   [git] branch master updated
-   + [git] 01/08: doc: fix xref link from api docs to manual pages
-   + [git] 02/08: api-credentials.txt: show the big picture first
-   + [git] 03/08: api-credentials.txt: mention credential.helper expli=
citly
-   + [git] 04/08: api-credentials.txt: add "see also" section
-   + [git] 05/08: t3510 (cherry-pick-sequence): add missing '&&'
-   + [git] 06/08: Merge branch 'rr/maint-t3510-cascade-fix'
-   + [git] 07/08: Merge branch 'mm/api-credentials-doc'
-   + [git] 08/08: Git 1.7.11-rc2
+   parents shown before children).  For example::
+
+     [git] branch master updated
+     + [git] 01/08: doc: fix xref link from api docs to manual pages
+     + [git] 02/08: api-credentials.txt: show the big picture first
+     + [git] 03/08: api-credentials.txt: mention credential.helper exp=
licitly
+     + [git] 04/08: api-credentials.txt: add "see also" section
+     + [git] 05/08: t3510 (cherry-pick-sequence): add missing '&&'
+     + [git] 06/08: Merge branch 'rr/maint-t3510-cascade-fix'
+     + [git] 07/08: Merge branch 'mm/api-credentials-doc'
+     + [git] 08/08: Git 1.7.11-rc2
=20
    Each commit appears in exactly one commit email, the first time
    that it is pushed to the repository.  If a commit is later merged
@@ -74,19 +77,19 @@ Requirements
   3.x.
=20
   The example scripts invoke Python using the following shebang line
-  (following PEP 394 [1]):
+  (following PEP 394 [1]_)::
=20
       #! /usr/bin/env python2
=20
   If your system's Python2 interpreter is not in your PATH or is not
-  called "python2", you can change the lines accordingly.  Or you can
+  called ``python2``, you can change the lines accordingly.  Or you ca=
n
   invoke the Python interpreter explicitly, for example via a tiny
-  shell script like
+  shell script like::
=20
       #! /bin/sh
       /usr/local/bin/python /path/to/git_multimail.py "$@"
=20
-* The "git" command must be in your PATH.  git-multimail is known to
+* The ``git`` command must be in your PATH.  git-multimail is known to
   work with Git versions back to 1.7.1.  (Earlier versions have not
   been tested; if you do so, please report your results.)
=20
@@ -101,7 +104,7 @@ Requirements
 Invocation
 ----------
=20
-git_multimail.py is designed to be used as a "post-receive" hook in a
+git_multimail.py is designed to be used as a ``post-receive`` hook in =
a
 Git repository (see githooks(5)).  Link or copy it to
 $GIT_DIR/hooks/post-receive within the repository for which email
 notifications are desired.  Usually it should be installed on the
@@ -109,10 +112,10 @@ central repository for a project, to which all co=
mmits are eventually
 pushed.
=20
 For use on pre-v1.5.1 Git servers, git_multimail.py can also work as
-an "update" hook, taking its arguments on the command line.  To use
+an ``update`` hook, taking its arguments on the command line.  To use
 this script in this manner, link or copy it to $GIT_DIR/hooks/update.
 Please note that the script is not completely reliable in this mode
-[2].
+[2]_.
=20
 Alternatively, git_multimail.py can be imported as a Python module
 into your own Python post-receive script.  This method is a bit more
@@ -129,7 +132,7 @@ arbitrary Python code.  For example, you can use a =
custom environment
   only about changes affecting particular files or subdirectories)
=20
 Or you can change how emails are sent by writing your own Mailer
-class.  The "post-receive" script in this directory demonstrates how
+class.  The ``post-receive`` script in this directory demonstrates how
 to use git_multimail.py as a Python module.  (If you make interesting
 changes of this type, please consider sharing them with the
 community.)
@@ -139,18 +142,26 @@ Configuration
 -------------
=20
 By default, git-multimail mostly takes its configuration from the
-following "git config" settings:
+following ``git config`` settings:
=20
 multimailhook.environment
=20
     This describes the general environment of the repository.
     Currently supported values:
=20
-    "generic" -- the username of the pusher is read from $USER and the
-        repository name is derived from the repository's path.
+    * generic
+
+      the username of the pusher is read from $USER or $USERNAME and
+      the repository name is derived from the repository's path.
+
+    * gitolite
=20
-    "gitolite" -- the username of the pusher is read from $GL_USER and
-        the repository name from $GL_REPO.
+      the username of the pusher is read from $GL_USER, the repository
+      name is read from $GL_REPO, and the From: header value is
+      optionally read from gitolite.conf (see multimailhook.from).
+
+      For more information about gitolite and git-multimail, read
+      doc/gitolite.rst
=20
     If neither of these environments is suitable for your setup, then
     you can implement a Python class that inherits from Environment
@@ -160,8 +171,8 @@ multimailhook.environment
     The environment value can be specified on the command line using
     the --environment option.  If it is not specified on the command
     line or by multimailhook.environment, then it defaults to
-    "gitolite" if the environment contains variables $GL_USER and
-    $GL_REPO; otherwise "generic".
+    ``gitolite`` if the environment contains variables $GL_USER and
+    $GL_REPO; otherwise ``generic``.
=20
 multimailhook.repoName
=20
@@ -219,61 +230,109 @@ multimailhook.announceShortlog
     not so straightforward, then the shortlog might be confusing
     rather than useful.  Default is false.
=20
+multimailhook.refchangeShowGraph
+
+    If this option is set to true, then summary emails about reference
+    changes will additionally include:
+
+    * a graph of the added commits (if any)
+
+    * a graph of the discarded commits (if any)
+
+    The log is generated by running ``git log --graph`` with the optio=
ns
+    specified in graphOpts.  The default is false.
+
 multimailhook.refchangeShowLog
=20
     If this option is set to true, then summary emails about reference
     changes will include a detailed log of the added commits in
     addition to the one line summary.  The log is generated by running
-    "git log" with the options specified in multimailhook.logOpts.
+    ``git log`` with the options specified in multimailhook.logOpts.
     Default is false.
=20
 multimailhook.mailer
=20
     This option changes the way emails are sent.  Accepted values are:
=20
-    - sendmail (the default): use the command /usr/sbin/sendmail or
-      /usr/lib/sendmail (or sendmailCommand, if configured).  This
+    - sendmail (the default): use the command ``/usr/sbin/sendmail`` o=
r
+      ``/usr/lib/sendmail`` (or sendmailCommand, if configured).  This
       mode can be further customized via the following options:
=20
-       multimailhook.sendmailCommand
+      * multimailhook.sendmailCommand
=20
-           The command used by mailer "sendmail" to send emails.  Shel=
l
-           quoting is allowed in the value of this setting, but rememb=
er that
-           Git requires double-quotes to be escaped; e.g.,
+        The command used by mailer ``sendmail`` to send emails.  Shell
+        quoting is allowed in the value of this setting, but remember =
that
+        Git requires double-quotes to be escaped; e.g.::
=20
              git config multimailhook.sendmailcommand '/usr/sbin/sendm=
ail -oi -t -F \"Git Repo\"'
=20
-           Default is '/usr/sbin/sendmail -oi -t' or
-           '/usr/lib/sendmail -oi -t' (depending on which file is
-           present and executable).
+        Default is '/usr/sbin/sendmail -oi -t' or
+        '/usr/lib/sendmail -oi -t' (depending on which file is
+        present and executable).
=20
-       multimailhook.envelopeSender
+      * multimailhook.envelopeSender
=20
-           If set then pass this value to sendmail via the -f option t=
o set
-           the envelope sender address.
+        If set then pass this value to sendmail via the -f option to s=
et
+        the envelope sender address.
=20
     - smtp: use Python's smtplib.  This is useful when the sendmail
       command is not available on the system.  This mode can be
       further customized via the following options:
=20
-       multimailhook.smtpServer
+      * multimailhook.smtpServer
+
+        The name of the SMTP server to connect to.  The value can
+        also include a colon and a port number; e.g.,
+        ``mail.example.com:25``.  Default is 'localhost' using port 25=
=2E
+
+      * multimailhook.smtpUser
+      * multimailhook.smtpPass
+
+        Server username and password. Required if smtpEncryption is 's=
sl'.
+        Note that the username and password currently need to be
+        set cleartext in the configuration file, which is not
+        recommended. If you need to use this option, be sure your
+        configuration file is read-only.
+
+      * multimailhook.envelopeSender
+
+        The sender address to be passed to the SMTP server.  If
+        unset, then the value of multimailhook.from is used.
+
+      * multimailhook.smtpServerTimeout
+
+        Timeout in seconds.
=20
-           The name of the SMTP server to connect to.  The value can
-           also include a colon and a port number; e.g.,
-           "mail.example.com:25".  Default is 'localhost' using port
-           25.
+      * multimailhook.smtpEncryption
=20
-       multimailhook.envelopeSender
+        Set the security type. Allowed values: none, ssl.
+        Default=3Dnone.
=20
-           The sender address to be passed to the SMTP server.  If
-           unset, then the value of multimailhook.from is used.
+      * multimailhook.smtpServerDebugLevel
+
+        Integer number. Set to greater than 0 to activate debugging.
=20
 multimailhook.from
=20
-    If set then use this value in the From: field of generated emails.
-    If unset, then use the repository's user configuration (user.name
-    and user.email).  If user.email is also unset, then use
-    multimailhook.envelopeSender.
+    If set, use this value in the From: field of generated emails.  If
+    unset, the value of the From: header is determined as follows:
+
+    1. (gitolite environment only) Parse gitolite.conf, looking for a
+       block of comments that looks like this::
+
+           # BEGIN USER EMAILS
+           # username Firstname Lastname <email@example.com>
+           # END USER EMAILS
+
+       If that block exists, and there is a line between the BEGIN
+       USER EMAILS and END USER EMAILS lines where the first field
+       matches the gitolite username ($GL_USER), use the rest of the
+       line for the From: header.
+
+    2. If the user.email configuration setting is set, use its value
+       (and the value of user.name, if set).
+
+    3. Use the value of multimailhook.envelopeSender.
=20
 multimailhook.administrator
=20
@@ -287,7 +346,8 @@ multimailhook.emailPrefix
     All emails have this string prepended to their subjects, to aid
     email filtering (though filtering based on the X-Git-* email
     headers is probably more robust).  Default is the short name of
-    the repository in square brackets; e.g., "[myrepo]".
+    the repository in square brackets; e.g., ``[myrepo]``.  Set this
+    value to the empty string to suppress the email prefix.
=20
 multimailhook.emailMaxLines
=20
@@ -299,7 +359,7 @@ multimailhook.emailMaxLines
 multimailhook.emailMaxLineLength
=20
     The maximum length of a line in the email body.  Lines longer than
-    this limit are truncated to this length with a trailing " [...]"
+    this limit are truncated to this length with a trailing `` [...]``
     added to indicate the missing text.  The default is 500, because
     (a) diffs with longer lines are probably from binary files, for
     which a diff is useless, and (b) even if a text file has such long
@@ -316,54 +376,62 @@ multimailhook.maxCommitEmails
=20
 multimailhook.emailStrictUTF8
=20
-    If this boolean option is set to "true", then the main part of the
+    If this boolean option is set to `true`, then the main part of the
     email body is forced to be valid UTF-8.  Any characters that are
     not valid UTF-8 are converted to the Unicode replacement
-    character, U+FFFD.  The default is "true".
+    character, U+FFFD.  The default is `true`.
=20
 multimailhook.diffOpts
=20
-    Options passed to "git diff-tree" when generating the summary
-    information for ReferenceChange emails.  Default is "--stat
-    --summary --find-copies-harder".  Add -p to those options to
+    Options passed to ``git diff-tree`` when generating the summary
+    information for ReferenceChange emails.  Default is ``--stat
+    --summary --find-copies-harder``.  Add -p to those options to
     include a unified diff of changes in addition to the usual summary
     output.  Shell quoting is allowed; see multimailhook.logOpts for
     details.
=20
+multimailhook.graphOpts
+
+    Options passed to ``git log --graph`` when generating graphs for t=
he
+    reference change summary emails (used only if refchangeShowGraph
+    is true).  The default is '--oneline --decorate'.
+
+    Shell quoting is allowed; see logOpts for details.
+
 multimailhook.logOpts
=20
-    Options passed to "git log" to generate additional info for
+    Options passed to ``git log`` to generate additional info for
     reference change emails (used only if refchangeShowLog is set).
-    For example, adding --graph will show the graph of revisions, -p
-    will show the complete diff, etc.  The default is empty.
+    For example, adding -p will show each commit's complete diff.  The
+    default is empty.
=20
     Shell quoting is allowed; for example, a log format that contains
-    spaces can be specified using something like:
+    spaces can be specified using something like::
=20
       git config multimailhook.logopts '--pretty=3Dformat:"%h %aN <%aE=
>%n%s%n%n%b%n"'
=20
     If you want to set this by editing your configuration file
     directly, remember that Git requires double-quotes to be escaped
-    (see git-config(1) for more information):
+    (see git-config(1) for more information)::
=20
       [multimailhook]
               logopts =3D --pretty=3Dformat:\"%h %aN <%aE>%n%s%n%n%b%n=
\"
=20
 multimailhook.commitLogOpts
=20
-    Options passed to "git log" to generate additional info for
+    Options passed to ``git log`` to generate additional info for
     revision change emails.  For example, adding --ignore-all-spaces
-    will suppress whitespace changes.  The default options are "-C
-    --stat -p --cc".  Shell quoting is allowed; see
+    will suppress whitespace changes.  The default options are ``-C
+    --stat -p --cc``.  Shell quoting is allowed; see
     multimailhook.logOpts for details.
=20
 multimailhook.emailDomain
=20
     Domain name appended to the username of the person doing the push
-    to convert it into an email address (via "%s@%s" % (username,
-    emaildomain)).  More complicated schemes can be implemented by
-    overriding Environment and overriding its get_pusher_email()
-    method.
+    to convert it into an email address
+    (via ``"%s@%s" % (username, emaildomain)``). More complicated
+    schemes can be implemented by overriding Environment and
+    overriding its get_pusher_email() method.
=20
 multimailhook.replyTo
 multimailhook.replyToCommit
@@ -377,26 +445,48 @@ multimailhook.replyToRefchange
=20
     - An email address, which will be used directly.
=20
-    - The value "pusher", in which case the pusher's address (if
+    - The value `pusher`, in which case the pusher's address (if
       available) will be used.  This is the default for refchange
       emails.
=20
-    - The value "author" (meaningful only for replyToCommit), in which
+    - The value `author` (meaningful only for replyToCommit), in which
       case the commit author's address will be used.  This is the
       default for commit emails.
=20
-    - The value "none", in which case the Reply-To: field will be
+    - The value `none`, in which case the Reply-To: field will be
       omitted.
=20
+multimailhook.quiet
+
+    Do not output the list of email recipients from the hook
+
+multimailhook.stdout
+
+    For debugging, send emails to stdout rather than to the
+    mailer.  Equivalent to the --stdout command line option
+
+multimailhook.scanCommitForCc
+
+    If this option is set to true, than recipients from lines in commi=
t body
+    that starts with ``CC:`` will be added to CC list.
+    Default: false
+
+multimailhook.combineWhenSingleCommit
+
+    If this option is set to true and a single new commit is pushed to
+    a branch, combine the summary and commit email messages into a
+    single email.
+    Default: true
+
=20
 Email filtering aids
 --------------------
=20
 All emails include extra headers to enable fine tuned filtering and
 give information for debugging.  All emails include the headers
-"X-Git-Host", "X-Git-Repo", "X-Git-Refname", and "X-Git-Reftype".
-ReferenceChange emails also include headers "X-Git-Oldrev" and "X-Git-=
Newrev";
-Revision emails also include header "X-Git-Rev".
+``X-Git-Host``, ``X-Git-Repo``, ``X-Git-Refname``, and ``X-Git-Reftype=
``.
+ReferenceChange emails also include headers ``X-Git-Oldrev`` and ``X-G=
it-Newrev``;
+Revision emails also include header ``X-Git-Rev``.
=20
=20
 Customizing email contents
@@ -420,16 +510,17 @@ environment are built in:
 * GenericEnvironment: a stand-alone Git repository.
=20
 * GitoliteEnvironment: a Git repository that is managed by gitolite
-  [3].  For such repositories, the identity of the pusher is read from
-  environment variable $GL_USER, and the name of the repository is
-  read from $GL_REPO (if it is not overridden by
-  multimailhook.reponame).
+  [3]_.  For such repositories, the identity of the pusher is read fro=
m
+  environment variable $GL_USER, the name of the repository is read
+  from $GL_REPO (if it is not overridden by multimailhook.reponame),
+  and the From: header value is optionally read from gitolite.conf
+  (see multimailhook.from).
=20
 By default, git-multimail assumes GitoliteEnvironment if $GL_USER and
 $GL_REPO are set, and otherwise assumes GenericEnvironment.
 Alternatively, you can choose one of these two environments explicitly
-by setting a "multimailhook.environment" config setting (which can
-have the value "generic" or "gitolite") or by passing an --environment
+by setting a ``multimailhook.environment`` config setting (which can
+have the value `generic` or `gitolite`) or by passing an --environment
 option to the script.
=20
 If you need to customize the script in ways that are not supported by
@@ -439,8 +530,8 @@ git_multimail.py as a Python module, as demonstrate=
d by the example
 post-receive script.  Then implement your environment class; it should
 usually inherit from one of the existing Environment classes and
 possibly one or more of the EnvironmentMixin classes.  Then set the
-"environment" variable to an instance of your own environment class
-and pass it to run_as_post_receive_hook().
+``environment`` variable to an instance of your own environment class
+and pass it to ``run_as_post_receive_hook()``.
=20
 The standard environment classes, GenericEnvironment and
 GitoliteEnvironment, are in fact themselves put together out of a
@@ -490,12 +581,14 @@ don't overlook them.
 Footnotes
 ---------
=20
-[1] http://www.python.org/dev/peps/pep-0394/
+.. [1] http://www.python.org/dev/peps/pep-0394/
=20
-[2] Because of the way information is passed to update hooks, the
-    script's method of determining whether a commit has already been
-    seen does not work when it is used as an "update" script.  In
-    particular, no notification email will be generated for a new
-    commit that is added to multiple references in the same push.
+.. [2] Because of the way information is passed to update hooks, the
+       script's method of determining whether a commit has already
+       been seen does not work when it is used as an ``update`` script=
=2E
+       In particular, no notification email will be generated for a
+       new commit that is added to multiple references in the same
+       push. A workaround is to use --force-send to force sending the
+       emails.
=20
-[3] https://github.com/sitaramc/gitolite
+.. [3] https://github.com/sitaramc/gitolite
diff --git a/contrib/hooks/multimail/README.Git b/contrib/hooks/multima=
il/README.Git
index ab3ece5..449d36f 100644
--- a/contrib/hooks/multimail/README.Git
+++ b/contrib/hooks/multimail/README.Git
@@ -6,10 +6,10 @@ website:
     https://github.com/git-multimail/git-multimail
=20
 The version in this directory was obtained from the upstream project
-on 2015-04-27 and consists of the "git-multimail" subdirectory from
+on Jun 18 2015 and consists of the "git-multimail" subdirectory from
 revision
=20
-    8c3aaafa873bf10de8dddf1d202c449b3eff3b42 refs/tags/1.0.2
+    1f0dbb3b60035767889b913df16d9231ecdb8709 refs/tags/1.1.0
=20
 Please see the README file in this directory for information about how
 to report bugs or contribute to git-multimail.
diff --git a/contrib/hooks/multimail/git_multimail.py b/contrib/hooks/m=
ultimail/git_multimail.py
index 8b58ed6..7cb2b36 100755
--- a/contrib/hooks/multimail/git_multimail.py
+++ b/contrib/hooks/multimail/git_multimail.py
@@ -1,5 +1,6 @@
 #! /usr/bin/env python2
=20
+# Copyright (c) 2015 Matthieu Moy and others
 # Copyright (c) 2012-2014 Michael Haggerty and others
 # Derived from contrib/hooks/post-receive-email, which is
 # Copyright (c) 2007 Andy Parkins
@@ -99,6 +100,10 @@ REF_DELETED_SUBJECT_TEMPLATE =3D (
     ' (was %(oldrev_short)s)'
     )
=20
+COMBINED_REFCHANGE_REVISION_SUBJECT_TEMPLATE =3D (
+    '%(emailprefix)s%(refname_type)s %(short_refname)s updated: %(onel=
ine)s'
+    )
+
 REFCHANGE_HEADER_TEMPLATE =3D """\
 Date: %(send_date)s
 To: %(recipients)s
@@ -230,6 +235,7 @@ how to provide full information about this referenc=
e change.
 REVISION_HEADER_TEMPLATE =3D """\
 Date: %(send_date)s
 To: %(recipients)s
+Cc: %(cc_recipients)s
 Subject: %(emailprefix)s%(num)02d/%(tot)02d: %(oneline)s
 MIME-Version: 1.0
 Content-Type: text/plain; charset=3D%(charset)s
@@ -258,6 +264,38 @@ in repository %(repo_shortname)s.
 REVISION_FOOTER_TEMPLATE =3D FOOTER_TEMPLATE
=20
=20
+# Combined, meaning refchange+revision email (for single-commit additi=
ons)
+COMBINED_HEADER_TEMPLATE =3D """\
+Date: %(send_date)s
+To: %(recipients)s
+Subject: %(subject)s
+MIME-Version: 1.0
+Content-Type: text/plain; charset=3D%(charset)s
+Content-Transfer-Encoding: 8bit
+Message-ID: %(msgid)s
+From: %(fromaddr)s
+Reply-To: %(reply_to)s
+X-Git-Host: %(fqdn)s
+X-Git-Repo: %(repo_shortname)s
+X-Git-Refname: %(refname)s
+X-Git-Reftype: %(refname_type)s
+X-Git-Oldrev: %(oldrev)s
+X-Git-Newrev: %(newrev)s
+X-Git-Rev: %(rev)s
+Auto-Submitted: auto-generated
+"""
+
+COMBINED_INTRO_TEMPLATE =3D """\
+This is an automated email from the git hooks/post-receive script.
+
+%(pusher)s pushed a commit to %(refname_type)s %(short_refname)s
+in repository %(repo_shortname)s.
+
+"""
+
+COMBINED_FOOTER_TEMPLATE =3D FOOTER_TEMPLATE
+
+
 class CommandError(Exception):
     def __init__(self, cmd, retcode):
         self.cmd =3D cmd
@@ -336,6 +374,47 @@ def read_git_lines(args, keepends=3DFalse, **kw):
     return read_git_output(args, keepends=3DTrue, **kw).splitlines(kee=
pends)
=20
=20
+def git_rev_list_ish(cmd, spec, args=3DNone, **kw):
+    """Common functionality for invoking a 'git rev-list'-like command=
=2E
+
+    Parameters:
+      * cmd is the Git command to run, e.g., 'rev-list' or 'log'.
+      * spec is a list of revision arguments to pass to the named
+        command.  If None, this function returns an empty list.
+      * args is a list of extra arguments passed to the named command.
+      * All other keyword arguments (if any) are passed to the
+        underlying read_git_lines() function.
+
+    Return the output of the Git command in the form of a list, one
+    entry per output line.
+    """
+    if spec is None:
+        return []
+    if args is None:
+        args =3D []
+    args =3D [cmd, '--stdin'] + args
+    spec_stdin =3D ''.join(s + '\n' for s in spec)
+    return read_git_lines(args, input=3Dspec_stdin, **kw)
+
+
+def git_rev_list(spec, **kw):
+    """Run 'git rev-list' with the given list of revision arguments.
+
+    See git_rev_list_ish() for parameter and return value
+    documentation.
+    """
+    return git_rev_list_ish('rev-list', spec, **kw)
+
+
+def git_log(spec, **kw):
+    """Run 'git log' with the given list of revision arguments.
+
+    See git_rev_list_ish() for parameter and return value
+    documentation.
+    """
+    return git_rev_list_ish('log', spec, **kw)
+
+
 def header_encode(text, header_name=3DNone):
     """Encode and line-wrap the value of an email header field."""
=20
@@ -388,9 +467,9 @@ class Config(object):
     def get(self, name, default=3DNone):
         try:
             values =3D self._split(read_git_output(
-                    ['config', '--get', '--null', '%s.%s' % (self.sect=
ion, name)],
-                    env=3Dself.env, keepends=3DTrue,
-                    ))
+                ['config', '--get', '--null', '%s.%s' % (self.section,=
 name)],
+                env=3Dself.env, keepends=3DTrue,
+                ))
             assert len(values) =3D=3D 1
             return values[0]
         except CommandError:
@@ -449,9 +528,14 @@ class Config(object):
             env=3Dself.env,
             )
=20
-    def has_key(self, name):
+    def __contains__(self, name):
         return self.get_all(name, default=3DNone) is not None
=20
+    # We don't use this method anymore internally, but keep it here in
+    # case somebody is calling it from their own code:
+    def has_key(self, name):
+        return name in self
+
     def unset_all(self, name):
         try:
             read_git_output(
@@ -579,7 +663,7 @@ class Change(object):
         self._values =3D None
=20
     def _compute_values(self):
-        """Return a dictionary {keyword : expansion} for this Change.
+        """Return a dictionary {keyword: expansion} for this Change.
=20
         Derived classes overload this method to add more entries to
         the return value.  This method is used internally by
@@ -589,7 +673,7 @@ class Change(object):
         return self.environment.get_values()
=20
     def get_values(self, **extra_values):
-        """Return a dictionary {keyword : expansion} for this Change.
+        """Return a dictionary {keyword: expansion} for this Change.
=20
         Return a dictionary mapping keywords to the values that they
         should be expanded to for this Change (used when interpolating
@@ -636,7 +720,7 @@ class Change(object):
                 value =3D value % values
             except KeyError, e:
                 if DEBUG:
-                    sys.stderr.write(
+                    self.environment.log_warning(
                         'Warning: unknown variable %r in the following=
 line; line skipped:\n'
                         '    %s\n'
                         % (e.args[0], line,)
@@ -711,6 +795,8 @@ class Change(object):
 class Revision(Change):
     """A Change consisting of a single git commit."""
=20
+    CC_RE =3D re.compile(r'^\s*C[Cc]:\s*(?P<to>[^#]+@[^\s#]*)\s*(#.*)?=
$')
+
     def __init__(self, reference_change, rev, num, tot):
         Change.__init__(self, reference_change.environment)
         self.reference_change =3D reference_change
@@ -722,6 +808,24 @@ class Revision(Change):
         self.author =3D read_git_output(['log', '--no-walk', '--format=
=3D%aN <%aE>', self.rev.sha1])
         self.recipients =3D self.environment.get_revision_recipients(s=
elf)
=20
+        self.cc_recipients =3D ''
+        if self.environment.get_scancommitforcc():
+            self.cc_recipients =3D ', '.join(to.strip() for to in self=
=2E_cc_recipients())
+            if self.cc_recipients:
+                self.environment.log_msg(
+                    'Add %s to CC for %s\n' % (self.cc_recipients, sel=
f.rev.sha1))
+
+    def _cc_recipients(self):
+        cc_recipients =3D []
+        message =3D read_git_output(['log', '--no-walk', '--format=3D%=
b', self.rev.sha1])
+        lines =3D message.strip().split('\n')
+        for line in lines:
+            m =3D re.match(self.CC_RE, line)
+            if m:
+                cc_recipients.append(m.group('to'))
+
+        return cc_recipients
+
     def _compute_values(self):
         values =3D Change._compute_values(self)
=20
@@ -739,6 +843,8 @@ class Revision(Change):
         values['num'] =3D self.num
         values['tot'] =3D self.tot
         values['recipients'] =3D self.recipients
+        if self.cc_recipients:
+            values['cc_recipients'] =3D self.cc_recipients
         values['oneline'] =3D oneline
         values['author'] =3D self.author
=20
@@ -750,8 +856,8 @@ class Revision(Change):
=20
     def generate_email_header(self, **extra_values):
         for line in self.expand_header_lines(
-            REVISION_HEADER_TEMPLATE, **extra_values
-            ):
+                REVISION_HEADER_TEMPLATE, **extra_values
+                ):
             yield line
=20
     def generate_email_intro(self):
@@ -822,26 +928,26 @@ class ReferenceChange(Change):
                 klass =3D BranchChange
             elif area =3D=3D 'remotes':
                 # Tracking branch:
-                sys.stderr.write(
+                environment.log_warning(
                     '*** Push-update of tracking branch %r\n'
                     '***  - incomplete email generated.\n'
-                     % (refname,)
+                    % (refname,)
                     )
                 klass =3D OtherReferenceChange
             else:
                 # Some other reference namespace:
-                sys.stderr.write(
+                environment.log_warning(
                     '*** Push-update of strange reference %r\n'
                     '***  - incomplete email generated.\n'
-                     % (refname,)
+                    % (refname,)
                     )
                 klass =3D OtherReferenceChange
         else:
             # Anything else (is there anything else?)
-            sys.stderr.write(
+            environment.log_warning(
                 '*** Unknown type of update to %r (%s)\n'
                 '***  - incomplete email generated.\n'
-                 % (refname, rev.type,)
+                % (refname, rev.type,)
                 )
             klass =3D OtherReferenceChange
=20
@@ -854,9 +960,9 @@ class ReferenceChange(Change):
     def __init__(self, environment, refname, short_refname, old, new, =
rev):
         Change.__init__(self, environment)
         self.change_type =3D {
-            (False, True) : 'create',
-            (True, True) : 'update',
-            (True, False) : 'delete',
+            (False, True): 'create',
+            (True, True): 'update',
+            (True, False): 'delete',
             }[bool(old), bool(new)]
         self.refname =3D refname
         self.short_refname =3D short_refname
@@ -865,10 +971,16 @@ class ReferenceChange(Change):
         self.rev =3D rev
         self.msgid =3D make_msgid()
         self.diffopts =3D environment.diffopts
+        self.graphopts =3D environment.graphopts
         self.logopts =3D environment.logopts
         self.commitlogopts =3D environment.commitlogopts
+        self.showgraph =3D environment.refchange_showgraph
         self.showlog =3D environment.refchange_showlog
=20
+        self.header_template =3D REFCHANGE_HEADER_TEMPLATE
+        self.intro_template =3D REFCHANGE_INTRO_TEMPLATE
+        self.footer_template =3D FOOTER_TEMPLATE
+
     def _compute_values(self):
         values =3D Change._compute_values(self)
=20
@@ -894,11 +1006,39 @@ class ReferenceChange(Change):
=20
         return values
=20
+    def send_single_combined_email(self, known_added_sha1s):
+        """Determine if a combined refchange/revision email should be =
sent
+
+        If there is only a single new (non-merge) commit added by a
+        change, it is useful to combine the ReferenceChange and
+        Revision emails into one.  In such a case, return the single
+        revision; otherwise, return None.
+
+        This method is overridden in BranchChange."""
+
+        return None
+
+    def generate_combined_email(self, push, revision, body_filter=3DNo=
ne, extra_header_values=3D{}):
+        """Generate an email describing this change AND specified revi=
sion.
+
+        Iterate over the lines (including the header lines) of an
+        email describing this change.  If body_filter is not None,
+        then use it to filter the lines that are intended for the
+        email body.
+
+        The extra_header_values field is received as a dict and not as
+        **kwargs, to allow passing other keyword arguments in the
+        future (e.g. passing extra values to generate_email_intro()
+
+        This method is overridden in BranchChange."""
+
+        raise NotImplementedError
+
     def get_subject(self):
         template =3D {
-            'create' : REF_CREATED_SUBJECT_TEMPLATE,
-            'update' : REF_UPDATED_SUBJECT_TEMPLATE,
-            'delete' : REF_DELETED_SUBJECT_TEMPLATE,
+            'create': REF_CREATED_SUBJECT_TEMPLATE,
+            'update': REF_UPDATED_SUBJECT_TEMPLATE,
+            'delete': REF_DELETED_SUBJECT_TEMPLATE,
             }[self.change_type]
         return self.expand(template)
=20
@@ -907,12 +1047,12 @@ class ReferenceChange(Change):
             extra_values['subject'] =3D self.get_subject()
=20
         for line in self.expand_header_lines(
-            REFCHANGE_HEADER_TEMPLATE, **extra_values
-            ):
+                self.header_template, **extra_values
+                ):
             yield line
=20
     def generate_email_intro(self):
-        for line in self.expand_lines(REFCHANGE_INTRO_TEMPLATE):
+        for line in self.expand_lines(self.intro_template):
             yield line
=20
     def generate_email_body(self, push):
@@ -922,9 +1062,9 @@ class ReferenceChange(Change):
         generate_update_summary() / generate_delete_summary()."""
=20
         change_summary =3D {
-            'create' : self.generate_create_summary,
-            'delete' : self.generate_delete_summary,
-            'update' : self.generate_update_summary,
+            'create': self.generate_create_summary,
+            'delete': self.generate_delete_summary,
+            'update': self.generate_update_summary,
             }[self.change_type](push)
         for line in change_summary:
             yield line
@@ -933,7 +1073,23 @@ class ReferenceChange(Change):
             yield line
=20
     def generate_email_footer(self):
-        return self.expand_lines(FOOTER_TEMPLATE)
+        return self.expand_lines(self.footer_template)
+
+    def generate_revision_change_graph(self, push):
+        if self.showgraph:
+            args =3D ['--graph'] + self.graphopts
+            for newold in ('new', 'old'):
+                has_newold =3D False
+                spec =3D push.get_commits_spec(newold, self)
+                for line in git_log(spec, args=3Dargs, keepends=3DTrue=
):
+                    if not has_newold:
+                        has_newold =3D True
+                        yield '\n'
+                        yield 'Graph of %s commits:\n\n' % (
+                            {'new': 'new', 'old': 'discarded'}[newold]=
,)
+                    yield '  ' + line
+                if has_newold:
+                    yield '\n'
=20
     def generate_revision_change_log(self, new_commits_list):
         if self.showlog:
@@ -945,9 +1101,17 @@ class ReferenceChange(Change):
                     + new_commits_list
                     + ['--'],
                     keepends=3DTrue,
-                ):
+                    ):
                 yield line
=20
+    def generate_new_revision_summary(self, tot, new_commits_list, pus=
h):
+        for line in self.expand_lines(NEW_REVISIONS_TEMPLATE, tot=3Dto=
t):
+            yield line
+        for line in self.generate_revision_change_graph(push):
+            yield line
+        for line in self.generate_revision_change_log(new_commits_list=
):
+            yield line
+
     def generate_revision_change_summary(self, push):
         """Generate a summary of the revisions added/removed by this c=
hange."""
=20
@@ -960,7 +1124,7 @@ class ReferenceChange(Change):
             sha1s.reverse()
             tot =3D len(sha1s)
             new_revisions =3D [
-                Revision(self, GitObject(sha1), num=3Di+1, tot=3Dtot)
+                Revision(self, GitObject(sha1), num=3Di + 1, tot=3Dtot=
)
                 for (i, sha1) in enumerate(sha1s)
                 ]
=20
@@ -973,9 +1137,8 @@ class ReferenceChange(Change):
                         BRIEF_SUMMARY_TEMPLATE, action=3D'new', text=3D=
subject,
                         )
                 yield '\n'
-                for line in self.expand_lines(NEW_REVISIONS_TEMPLATE, =
tot=3Dtot):
-                    yield line
-                for line in self.generate_revision_change_log([r.rev.s=
ha1 for r in new_revisions]):
+                for line in self.generate_new_revision_summary(
+                        tot, [r.rev.sha1 for r in new_revisions], push=
):
                     yield line
             else:
                 for line in self.expand_lines(NO_NEW_REVISIONS_TEMPLAT=
E):
@@ -993,16 +1156,16 @@ class ReferenceChange(Change):
             # revisions in the summary even though we will not send
             # new notification emails for them.
             adds =3D list(generate_summaries(
-                    '--topo-order', '--reverse', '%s..%s'
-                    % (self.old.commit_sha1, self.new.commit_sha1,)
-                    ))
+                '--topo-order', '--reverse', '%s..%s'
+                % (self.old.commit_sha1, self.new.commit_sha1,)
+                ))
=20
             # List of the revisions that were removed from the branch
             # by this update.  This will be empty except for
             # non-fast-forward updates.
             discards =3D list(generate_summaries(
-                    '%s..%s' % (self.new.commit_sha1, self.old.commit_=
sha1,)
-                    ))
+                '%s..%s' % (self.new.commit_sha1, self.old.commit_sha1=
,)
+                ))
=20
             if adds:
                 new_commits_list =3D push.get_new_commits(self)
@@ -1071,13 +1234,14 @@ class ReferenceChange(Change):
             yield '\n'
=20
             if new_commits:
-                for line in self.expand_lines(NEW_REVISIONS_TEMPLATE, =
tot=3Dlen(new_commits)):
-                    yield line
-                for line in self.generate_revision_change_log(new_comm=
its_list):
+                for line in self.generate_new_revision_summary(
+                        len(new_commits), new_commits_list, push):
                     yield line
             else:
                 for line in self.expand_lines(NO_NEW_REVISIONS_TEMPLAT=
E):
                     yield line
+                for line in self.generate_revision_change_graph(push):
+                    yield line
=20
             # The diffstat is shown from the old revision to the new
             # revision.  This is to show the truth of what happened in
@@ -1089,11 +1253,11 @@ class ReferenceChange(Change):
             yield '\n'
             yield 'Summary of changes:\n'
             for line in read_git_lines(
-                ['diff-tree']
-                + self.diffopts
-                + ['%s..%s' % (self.old.commit_sha1, self.new.commit_s=
ha1,)],
-                keepends=3DTrue,
-                ):
+                    ['diff-tree']
+                    + self.diffopts
+                    + ['%s..%s' % (self.old.commit_sha1, self.new.comm=
it_sha1,)],
+                    keepends=3DTrue,
+                    ):
                 yield line
=20
         elif self.old.commit_sha1 and not self.new.commit_sha1:
@@ -1103,7 +1267,7 @@ class ReferenceChange(Change):
             sha1s =3D list(push.get_discarded_commits(self))
             tot =3D len(sha1s)
             discarded_revisions =3D [
-                Revision(self, GitObject(sha1), num=3Di+1, tot=3Dtot)
+                Revision(self, GitObject(sha1), num=3Di + 1, tot=3Dtot=
)
                 for (i, sha1) in enumerate(sha1s)
                 ]
=20
@@ -1116,6 +1280,8 @@ class ReferenceChange(Change):
                     yield r.expand(
                         BRIEF_SUMMARY_TEMPLATE, action=3D'discards', t=
ext=3Dsubject,
                         )
+                for line in self.generate_revision_change_graph(push):
+                    yield line
             else:
                 for line in self.expand_lines(NO_DISCARDED_REVISIONS_T=
EMPLATE):
                     yield line
@@ -1161,6 +1327,150 @@ class BranchChange(ReferenceChange):
             old=3Dold, new=3Dnew, rev=3Drev,
             )
         self.recipients =3D environment.get_refchange_recipients(self)
+        self._single_revision =3D None
+
+    def send_single_combined_email(self, known_added_sha1s):
+        if not self.environment.combine_when_single_commit:
+            return None
+
+        # In the sadly-all-too-frequent usecase of people pushing only
+        # one of their commits at a time to a repository, users feel
+        # the reference change summary emails are noise rather than
+        # important signal.  This is because, in this particular
+        # usecase, there is a reference change summary email for each
+        # new commit, and all these summaries do is point out that
+        # there is one new commit (which can readily be inferred by
+        # the existence of the individual revision email that is also
+        # sent).  In such cases, our users prefer there to be a combin=
ed
+        # reference change summary/new revision email.
+        #
+        # So, if the change is an update and it doesn't discard any
+        # commits, and it adds exactly one non-merge commit (gerrit
+        # forces a workflow where every commit is individually merged
+        # and the git-multimail hook fired off for just this one
+        # change), then we send a combined refchange/revision email.
+        try:
+            # If this change is a reference update that doesn't discar=
d
+            # any commits...
+            if self.change_type !=3D 'update':
+                return None
+
+            if read_git_lines(
+                    ['merge-base', self.old.sha1, self.new.sha1]
+                    ) !=3D [self.old.sha1]:
+                return None
+
+            # Check if this update introduced exactly one non-merge
+            # commit:
+
+            def split_line(line):
+                """Split line into (sha1, [parent,...])."""
+
+                words =3D line.split()
+                return (words[0], words[1:])
+
+            # Get the new commits introduced by the push as a list of
+            # (sha1, [parent,...])
+            new_commits =3D [
+                split_line(line)
+                for line in read_git_lines(
+                    [
+                        'log', '-3', '--format=3D%H %P',
+                        '%s..%s' % (self.old.sha1, self.new.sha1),
+                        ]
+                    )
+                ]
+
+            if not new_commits:
+                return None
+
+            # If the newest commit is a merge, save it for a later che=
ck
+            # but otherwise ignore it
+            merge =3D None
+            tot =3D len(new_commits)
+            if len(new_commits[0][1]) > 1:
+                merge =3D new_commits[0][0]
+                del new_commits[0]
+
+            # Our primary check: we can't combine if more than one com=
mit
+            # is introduced.  We also currently only combine if the ne=
w
+            # commit is a non-merge commit, though it may make sense t=
o
+            # combine if it is a merge as well.
+            if not (
+                    len(new_commits) =3D=3D 1
+                    and len(new_commits[0][1]) =3D=3D 1
+                    and new_commits[0][0] in known_added_sha1s
+                    ):
+                return None
+
+            # We do not want to combine revision and refchange emails =
if
+            # those go to separate locations.
+            rev =3D Revision(self, GitObject(new_commits[0][0]), 1, to=
t)
+            if rev.recipients !=3D self.recipients:
+                return None
+
+            # We ignored the newest commit if it was just a merge of t=
he one
+            # commit being introduced.  But we don't want to ignore th=
at
+            # merge commit it it involved conflict resolutions.  Check=
 that.
+            if merge and merge !=3D read_git_output(['diff-tree', '--c=
c', merge]):
+                return None
+
+            # We can combine the refchange and one new revision emails
+            # into one.  Return the Revision that a combined email sho=
uld
+            # be sent about.
+            return rev
+        except CommandError:
+            # Cannot determine number of commits in old..new or new..o=
ld;
+            # don't combine reference/revision emails:
+            return None
+
+    def generate_combined_email(self, push, revision, body_filter=3DNo=
ne, extra_header_values=3D{}):
+        values =3D revision.get_values()
+        if extra_header_values:
+            values.update(extra_header_values)
+        if 'subject' not in extra_header_values:
+            values['subject'] =3D self.expand(COMBINED_REFCHANGE_REVIS=
ION_SUBJECT_TEMPLATE, **values)
+
+        self._single_revision =3D revision
+        self.header_template =3D COMBINED_HEADER_TEMPLATE
+        self.intro_template =3D COMBINED_INTRO_TEMPLATE
+        self.footer_template =3D COMBINED_FOOTER_TEMPLATE
+        for line in self.generate_email(push, body_filter, values):
+            yield line
+
+    def generate_email_body(self, push):
+        '''Call the appropriate body generation routine.
+
+        If this is a combined refchange/revision email, the special lo=
gic
+        for handling this combined email comes from this function.  Fo=
r
+        other cases, we just use the normal handling.'''
+
+        # If self._single_revision isn't set; don't override
+        if not self._single_revision:
+            for line in super(BranchChange, self).generate_email_body(=
push):
+                yield line
+            return
+
+        # This is a combined refchange/revision email; we first provid=
e
+        # some info from the refchange portion, and then call the revi=
sion
+        # generate_email_body function to handle the revision portion.
+        adds =3D list(generate_summaries(
+            '--topo-order', '--reverse', '%s..%s'
+            % (self.old.commit_sha1, self.new.commit_sha1,)
+            ))
+
+        yield self.expand("The following commit(s) were added to %(ref=
name)s by this push:\n")
+        for (sha1, subject) in adds:
+            yield self.expand(
+                BRIEF_SUMMARY_TEMPLATE, action=3D'new',
+                rev_short=3Dsha1, text=3Dsubject,
+                )
+
+        yield self._single_revision.rev.short + " is described below\n=
"
+        yield '\n'
+
+        for line in self._single_revision.generate_email_body(push):
+            yield line
=20
=20
 class AnnotatedTagChange(ReferenceChange):
@@ -1390,13 +1700,17 @@ class SendMailer(Mailer):
             sys.exit(1)
         try:
             p.stdin.writelines(lines)
-        except:
+        except Exception, e:
             sys.stderr.write(
                 '*** Error while generating commit email\n'
                 '***  - mail sending aborted.\n'
                 )
-            p.terminate()
-            raise
+            try:
+                # subprocess.terminate() is not available in Python 2.=
4
+                p.terminate()
+            except AttributeError:
+                pass
+            raise e
         else:
             p.stdin.close()
             retcode =3D p.wait()
@@ -1407,34 +1721,72 @@ class SendMailer(Mailer):
 class SMTPMailer(Mailer):
     """Send emails using Python's smtplib."""
=20
-    def __init__(self, envelopesender, smtpserver):
+    def __init__(self, envelopesender, smtpserver,
+                 smtpservertimeout=3D10.0, smtpserverdebuglevel=3D0,
+                 smtpencryption=3D'none',
+                 smtpuser=3D'', smtppass=3D'',
+                 ):
         if not envelopesender:
             sys.stderr.write(
                 'fatal: git_multimail: cannot use SMTPMailer without a=
 sender address.\n'
                 'please set either multimailhook.envelopeSender or use=
r.email\n'
                 )
             sys.exit(1)
+        if smtpencryption =3D=3D 'ssl' and not (smtpuser and smtppass)=
:
+            raise ConfigurationException(
+                'Cannot use SMTPMailer with security option ssl '
+                'without options username and password.'
+                )
         self.envelopesender =3D envelopesender
         self.smtpserver =3D smtpserver
+        self.smtpservertimeout =3D smtpservertimeout
+        self.smtpserverdebuglevel =3D smtpserverdebuglevel
+        self.security =3D smtpencryption
+        self.username =3D smtpuser
+        self.password =3D smtppass
         try:
-            self.smtp =3D smtplib.SMTP(self.smtpserver)
+            if self.security =3D=3D 'none':
+                self.smtp =3D smtplib.SMTP(self.smtpserver, timeout=3D=
self.smtpservertimeout)
+            elif self.security =3D=3D 'ssl':
+                self.smtp =3D smtplib.SMTP_SSL(self.smtpserver, timeou=
t=3Dself.smtpservertimeout)
+            elif self.security =3D=3D 'tls':
+                if ':' not in self.smtpserver:
+                    self.smtpserver +=3D ':587'  # default port for TL=
S
+                self.smtp =3D smtplib.SMTP(self.smtpserver, timeout=3D=
self.smtpservertimeout)
+                self.smtp.ehlo()
+                self.smtp.starttls()
+                self.smtp.ehlo()
+            else:
+                sys.stdout.write('*** Error: Control reached an invali=
d option. ***')
+                sys.exit(1)
+            if self.smtpserverdebuglevel > 0:
+                sys.stdout.write(
+                    "*** Setting debug on for SMTP server connection (=
%s) ***\n"
+                    % self.smtpserverdebuglevel)
+                self.smtp.set_debuglevel(self.smtpserverdebuglevel)
         except Exception, e:
-            sys.stderr.write('*** Error establishing SMTP connection t=
o %s***\n' % self.smtpserver)
+            sys.stderr.write(
+                '*** Error establishing SMTP connection to %s ***\n'
+                % self.smtpserver)
             sys.stderr.write('*** %s\n' % str(e))
             sys.exit(1)
=20
     def __del__(self):
-        self.smtp.quit()
+        if hasattr(self, 'smtp'):
+            self.smtp.quit()
=20
     def send(self, lines, to_addrs):
         try:
+            if self.username or self.password:
+                sys.stderr.write("*** Authenticating as %s ***\n" % se=
lf.username)
+                self.smtp.login(self.username, self.password)
             msg =3D ''.join(lines)
             # turn comma-separated list into Python list if needed.
             if isinstance(to_addrs, basestring):
                 to_addrs =3D [email for (name, email) in getaddresses(=
[to_addrs])]
             self.smtp.sendmail(self.envelopesender, to_addrs, msg)
         except Exception, e:
-            sys.stderr.write('*** Error sending email***\n')
+            sys.stderr.write('*** Error sending email ***\n')
             sys.stderr.write('*** %s\n' % str(e))
             self.smtp.quit()
             sys.exit(1)
@@ -1549,6 +1901,10 @@ class Environment(object):
=20
             True iff announce emails should include a shortlog.
=20
+        refchange_showgraph (bool)
+
+            True iff refchanges emails should include a detailed graph=
=2E
+
         refchange_showlog (bool)
=20
             True iff refchanges emails should include a detailed log.
@@ -1559,6 +1915,12 @@ class Environment(object):
             summary email.  The value should be a list of strings
             representing words to be passed to the command.
=20
+        graphopts (list of strings)
+
+            Analogous to diffopts, but contains options passed to
+            'git log --graph' when generating the detailed graph for
+            a set of commits (see refchange_showgraph)
+
         logopts (list of strings)
=20
             Analogous to diffopts, but contains options passed to
@@ -1571,6 +1933,17 @@ class Environment(object):
             commit mail.  The value should be a list of strings
             representing words to be passed to the command.
=20
+        quiet (bool)
+            On success do not write to stderr
+
+        stdout (bool)
+            Write email to stdout rather than emailing. Useful for deb=
ugging
+
+        combine_when_single_commit (bool)
+
+            True if a combined email should be produced when a single
+            new commit is pushed to a branch, False otherwise.
+
     """
=20
     REPO_NAME_RE =3D re.compile(r'^(?P<name>.+?)(?:\.git)$')
@@ -1580,9 +1953,14 @@ class Environment(object):
         self.announce_show_shortlog =3D False
         self.maxcommitemails =3D 500
         self.diffopts =3D ['--stat', '--summary', '--find-copies-harde=
r']
+        self.graphopts =3D ['--oneline', '--decorate']
         self.logopts =3D []
+        self.refchange_showgraph =3D False
         self.refchange_showlog =3D False
         self.commitlogopts =3D ['-C', '--stat', '-p', '--cc']
+        self.quiet =3D False
+        self.stdout =3D False
+        self.combine_when_single_commit =3D True
=20
         self.COMPUTED_KEYS =3D [
             'administrator',
@@ -1614,6 +1992,14 @@ class Environment(object):
     def get_pusher_email(self):
         return None
=20
+    def get_fromaddr(self):
+        config =3D Config('user')
+        fromname =3D config.get('name', default=3D'')
+        fromemail =3D config.get('email', default=3D'')
+        if fromemail:
+            return formataddr([fromname, fromemail])
+        return self.get_sender()
+
     def get_administrator(self):
         return 'the administrator of this repository'
=20
@@ -1631,7 +2017,7 @@ class Environment(object):
         return CHARSET
=20
     def get_values(self):
-        """Return a dictionary {keyword : expansion} for this Environm=
ent.
+        """Return a dictionary {keyword: expansion} for this Environme=
nt.
=20
         This method is called by Change._compute_values().  The keys
         in the returned dictionary are available to be used in any of
@@ -1699,6 +2085,24 @@ class Environment(object):
=20
         return lines
=20
+    def log_msg(self, msg):
+        """Write the string msg on a log file or on stderr.
+
+        Sends the text to stderr by default, override to change the be=
havior."""
+        sys.stderr.write(msg)
+
+    def log_warning(self, msg):
+        """Write the string msg on a log file or on stderr.
+
+        Sends the text to stderr by default, override to change the be=
havior."""
+        sys.stderr.write(msg)
+
+    def log_error(self, msg):
+        """Write the string msg on a log file or on stderr.
+
+        Sends the text to stderr by default, override to change the be=
havior."""
+        sys.stderr.write(msg)
+
=20
 class ConfigEnvironmentMixin(Environment):
     """A mixin that sets self.config to its constructor's config argum=
ent.
@@ -1723,20 +2127,23 @@ class ConfigOptionsEnvironmentMixin(ConfigEnvir=
onmentMixin):
             config=3Dconfig, **kw
             )
=20
-        self.announce_show_shortlog =3D config.get_bool(
-            'announceshortlog', default=3Dself.announce_show_shortlog
-            )
-
-        self.refchange_showlog =3D config.get_bool(
-            'refchangeshowlog', default=3Dself.refchange_showlog
-            )
+        for var, cfg in (
+                ('announce_show_shortlog', 'announceshortlog'),
+                ('refchange_showgraph', 'refchangeShowGraph'),
+                ('refchange_showlog', 'refchangeshowlog'),
+                ('quiet', 'quiet'),
+                ('stdout', 'stdout'),
+                ):
+            val =3D config.get_bool(cfg)
+            if val is not None:
+                setattr(self, var, val)
=20
         maxcommitemails =3D config.get('maxcommitemails')
         if maxcommitemails is not None:
             try:
                 self.maxcommitemails =3D int(maxcommitemails)
             except ValueError:
-                sys.stderr.write(
+                self.log_warning(
                     '*** Malformed value for multimailhook.maxCommitEm=
ails: %s\n' % maxcommitemails
                     + '*** Expected a number.  Ignoring.\n'
                     )
@@ -1745,6 +2152,10 @@ class ConfigOptionsEnvironmentMixin(ConfigEnviro=
nmentMixin):
         if diffopts is not None:
             self.diffopts =3D shlex.split(diffopts)
=20
+        graphopts =3D config.get('graphOpts')
+        if graphopts is not None:
+            self.graphopts =3D shlex.split(graphopts)
+
         logopts =3D config.get('logopts')
         if logopts is not None:
             self.logopts =3D shlex.split(logopts)
@@ -1756,14 +2167,18 @@ class ConfigOptionsEnvironmentMixin(ConfigEnvir=
onmentMixin):
         reply_to =3D config.get('replyTo')
         self.__reply_to_refchange =3D config.get('replyToRefchange', d=
efault=3Dreply_to)
         if (
-            self.__reply_to_refchange is not None
-            and self.__reply_to_refchange.lower() =3D=3D 'author'
-            ):
+                self.__reply_to_refchange is not None
+                and self.__reply_to_refchange.lower() =3D=3D 'author'
+                ):
             raise ConfigurationException(
                 '"author" is not an allowed setting for replyToRefchan=
ge'
                 )
         self.__reply_to_commit =3D config.get('replyToCommit', default=
=3Dreply_to)
=20
+        combine =3D config.get_bool('combineWhenSingleCommit')
+        if combine is not None:
+            self.combine_when_single_commit =3D combine
+
     def get_administrator(self):
         return (
             self.config.get('administrator')
@@ -1779,8 +2194,12 @@ class ConfigOptionsEnvironmentMixin(ConfigEnviro=
nmentMixin):
=20
     def get_emailprefix(self):
         emailprefix =3D self.config.get('emailprefix')
-        if emailprefix and emailprefix.strip():
-            return emailprefix.strip() + ' '
+        if emailprefix is not None:
+            emailprefix =3D emailprefix.strip()
+            if emailprefix:
+                return emailprefix + ' '
+            else:
+                return ''
         else:
             return '[%s] ' % (self.get_repo_shortname(),)
=20
@@ -1791,14 +2210,7 @@ class ConfigOptionsEnvironmentMixin(ConfigEnviro=
nmentMixin):
         fromaddr =3D self.config.get('from')
         if fromaddr:
             return fromaddr
-        else:
-            config =3D Config('user')
-            fromname =3D config.get('name', default=3D'')
-            fromemail =3D config.get('email', default=3D'')
-            if fromemail:
-                return formataddr([fromname, fromemail])
-            else:
-                return self.get_sender()
+        return super(ConfigOptionsEnvironmentMixin, self).get_fromaddr=
()
=20
     def get_reply_to_refchange(self, refchange):
         if self.__reply_to_refchange is None:
@@ -1814,7 +2226,7 @@ class ConfigOptionsEnvironmentMixin(ConfigEnviron=
mentMixin):
         if self.__reply_to_commit is None:
             return super(ConfigOptionsEnvironmentMixin, self).get_repl=
y_to_commit(revision)
         elif self.__reply_to_commit.lower() =3D=3D 'author':
-            return revision.get_author()
+            return revision.author
         elif self.__reply_to_commit.lower() =3D=3D 'pusher':
             return self.get_pusher_email()
         elif self.__reply_to_commit.lower() =3D=3D 'none':
@@ -1822,6 +2234,9 @@ class ConfigOptionsEnvironmentMixin(ConfigEnviron=
mentMixin):
         else:
             return self.__reply_to_commit
=20
+    def get_scancommitforcc(self):
+        return self.config.get('scancommitforcc')
+
=20
 class FilterLinesEnvironmentMixin(Environment):
     """Handle encoding and maximum line length of body lines.
@@ -1862,9 +2277,9 @@ class FilterLinesEnvironmentMixin(Environment):
=20
=20
 class ConfigFilterLinesEnvironmentMixin(
-    ConfigEnvironmentMixin,
-    FilterLinesEnvironmentMixin,
-    ):
+        ConfigEnvironmentMixin,
+        FilterLinesEnvironmentMixin,
+        ):
     """Handle encoding and maximum line length based on config."""
=20
     def __init__(self, config, **kw):
@@ -1896,9 +2311,9 @@ class MaxlinesEnvironmentMixin(Environment):
=20
=20
 class ConfigMaxlinesEnvironmentMixin(
-    ConfigEnvironmentMixin,
-    MaxlinesEnvironmentMixin,
-    ):
+        ConfigEnvironmentMixin,
+        MaxlinesEnvironmentMixin,
+        ):
     """Limit the email body to the number of lines specified in config=
=2E"""
=20
     def __init__(self, config, **kw):
@@ -1927,9 +2342,9 @@ class FQDNEnvironmentMixin(Environment):
=20
=20
 class ConfigFQDNEnvironmentMixin(
-    ConfigEnvironmentMixin,
-    FQDNEnvironmentMixin,
-    ):
+        ConfigEnvironmentMixin,
+        FQDNEnvironmentMixin,
+        ):
     """Read the FQDN from the config."""
=20
     def __init__(self, config, **kw):
@@ -1970,10 +2385,10 @@ class StaticRecipientsEnvironmentMixin(Environm=
ent):
     """Set recipients statically based on constructor parameters."""
=20
     def __init__(
-        self,
-        refchange_recipients, announce_recipients, revision_recipients=
,
-        **kw
-        ):
+            self,
+            refchange_recipients, announce_recipients, revision_recipi=
ents, scancommitforcc,
+            **kw
+            ):
         super(StaticRecipientsEnvironmentMixin, self).__init__(**kw)
=20
         # The recipients for various types of notification emails, as
@@ -1985,7 +2400,8 @@ class StaticRecipientsEnvironmentMixin(Environmen=
t):
         # compute them once and for all:
         if not (refchange_recipients
                 or announce_recipients
-                or revision_recipients):
+                or revision_recipients
+                or scancommitforcc):
             raise ConfigurationException('No email recipients configur=
ed!')
         self.__refchange_recipients =3D refchange_recipients
         self.__announce_recipients =3D announce_recipients
@@ -2002,9 +2418,9 @@ class StaticRecipientsEnvironmentMixin(Environmen=
t):
=20
=20
 class ConfigRecipientsEnvironmentMixin(
-    ConfigEnvironmentMixin,
-    StaticRecipientsEnvironmentMixin
-    ):
+        ConfigEnvironmentMixin,
+        StaticRecipientsEnvironmentMixin
+        ):
     """Determine recipients statically based on config."""
=20
     def __init__(self, config, **kw):
@@ -2019,6 +2435,7 @@ class ConfigRecipientsEnvironmentMixin(
             revision_recipients=3Dself._get_recipients(
                 config, 'commitlist', 'mailinglist',
                 ),
+            scancommitforcc=3Dconfig.get('scancommitforcc'),
             **kw
             )
=20
@@ -2067,20 +2484,20 @@ class ProjectdescEnvironmentMixin(Environment):
=20
 class GenericEnvironmentMixin(Environment):
     def get_pusher(self):
-        return self.osenv.get('USER', 'unknown user')
+        return self.osenv.get('USER', self.osenv.get('USERNAME', 'unkn=
own user'))
=20
=20
 class GenericEnvironment(
-    ProjectdescEnvironmentMixin,
-    ConfigMaxlinesEnvironmentMixin,
-    ComputeFQDNEnvironmentMixin,
-    ConfigFilterLinesEnvironmentMixin,
-    ConfigRecipientsEnvironmentMixin,
-    PusherDomainEnvironmentMixin,
-    ConfigOptionsEnvironmentMixin,
-    GenericEnvironmentMixin,
-    Environment,
-    ):
+        ProjectdescEnvironmentMixin,
+        ConfigMaxlinesEnvironmentMixin,
+        ComputeFQDNEnvironmentMixin,
+        ConfigFilterLinesEnvironmentMixin,
+        ConfigRecipientsEnvironmentMixin,
+        PusherDomainEnvironmentMixin,
+        ConfigOptionsEnvironmentMixin,
+        GenericEnvironmentMixin,
+        Environment,
+        ):
     pass
=20
=20
@@ -2097,6 +2514,45 @@ class GitoliteEnvironmentMixin(Environment):
     def get_pusher(self):
         return self.osenv.get('GL_USER', 'unknown user')
=20
+    def get_fromaddr(self):
+        GL_USER =3D self.osenv.get('GL_USER')
+        if GL_USER is not None:
+            # Find the path to gitolite.conf.  Note that gitolite v3
+            # did away with the GL_ADMINDIR and GL_CONF environment
+            # variables (they are now hard-coded).
+            GL_ADMINDIR =3D self.osenv.get(
+                'GL_ADMINDIR',
+                os.path.expanduser(os.path.join('~', '.gitolite')))
+            GL_CONF =3D self.osenv.get(
+                'GL_CONF',
+                os.path.join(GL_ADMINDIR, 'conf', 'gitolite.conf'))
+            if os.path.isfile(GL_CONF):
+                f =3D open(GL_CONF, 'rU')
+                try:
+                    in_user_emails_section =3D False
+                    re_template =3D r'^\s*#\s*{}\s*$'
+                    re_begin, re_user, re_end =3D (
+                        re.compile(re_template.format(x))
+                        for x in (
+                            r'BEGIN\s+USER\s+EMAILS',
+                            re.escape(GL_USER) + r'\s+(.*)',
+                            r'END\s+USER\s+EMAILS',
+                            ))
+                    for l in f:
+                        l =3D l.rstrip('\n')
+                        if not in_user_emails_section:
+                            if re_begin.match(l):
+                                in_user_emails_section =3D True
+                            continue
+                        if re_end.match(l):
+                            break
+                        m =3D re_user.match(l)
+                        if m:
+                            return m.group(1)
+                finally:
+                    f.close()
+        return super(GitoliteEnvironmentMixin, self).get_fromaddr()
+
=20
 class IncrementalDateTime(object):
     """Simple wrapper to give incremental date/times.
@@ -2116,16 +2572,16 @@ class IncrementalDateTime(object):
=20
=20
 class GitoliteEnvironment(
-    ProjectdescEnvironmentMixin,
-    ConfigMaxlinesEnvironmentMixin,
-    ComputeFQDNEnvironmentMixin,
-    ConfigFilterLinesEnvironmentMixin,
-    ConfigRecipientsEnvironmentMixin,
-    PusherDomainEnvironmentMixin,
-    ConfigOptionsEnvironmentMixin,
-    GitoliteEnvironmentMixin,
-    Environment,
-    ):
+        ProjectdescEnvironmentMixin,
+        ConfigMaxlinesEnvironmentMixin,
+        ComputeFQDNEnvironmentMixin,
+        ConfigFilterLinesEnvironmentMixin,
+        ConfigRecipientsEnvironmentMixin,
+        PusherDomainEnvironmentMixin,
+        ConfigOptionsEnvironmentMixin,
+        GitoliteEnvironmentMixin,
+        Environment,
+        ):
     pass
=20
=20
@@ -2149,9 +2605,9 @@ class Push(object):
     references.
=20
     The first step is to determine the "other" references--those
-    unaffected by the current push.  They are computed by
-    Push._compute_other_ref_sha1s() by listing all references then
-    removing any affected by this push.
+    unaffected by the current push.  They are computed by listing all
+    references then removing any affected by this push.  The results
+    are stored in Push._other_ref_sha1s.
=20
     The commits contained in the repository before this push were
=20
@@ -2187,7 +2643,7 @@ class Push(object):
     possible and working with SHA1s thereafter (because SHA1s are
     immutable)."""
=20
-    # A map {(changeclass, changetype) : integer} specifying the order
+    # A map {(changeclass, changetype): integer} specifying the order
     # that reference changes will be processed if multiple reference
     # changes are included in a single push.  The order is significant
     # mostly because new commit notifications are threaded together
@@ -2211,66 +2667,134 @@ class Push(object):
             ])
         )
=20
-    def __init__(self, changes):
+    def __init__(self, changes, ignore_other_refs=3DFalse):
         self.changes =3D sorted(changes, key=3Dself._sort_key)
+        self.__other_ref_sha1s =3D None
+        self.__cached_commits_spec =3D {}
=20
-        # The SHA-1s of commits referred to by references unaffected
-        # by this push:
-        other_ref_sha1s =3D self._compute_other_ref_sha1s()
+        if ignore_other_refs:
+            self.__other_ref_sha1s =3D set()
=20
-        self._old_rev_exclusion_spec =3D self._compute_rev_exclusion_s=
pec(
-            other_ref_sha1s.union(
-                change.old.sha1
+    @classmethod
+    def _sort_key(klass, change):
+        return (klass.SORT_ORDER[change.__class__, change.change_type]=
, change.refname,)
+
+    @property
+    def _other_ref_sha1s(self):
+        """The GitObjects referred to by references unaffected by this=
 push.
+        """
+        if self.__other_ref_sha1s is None:
+            # The refnames being changed by this push:
+            updated_refs =3D set(
+                change.refname
                 for change in self.changes
-                if change.old.type in ['commit', 'tag']
                 )
-            )
-        self._new_rev_exclusion_spec =3D self._compute_rev_exclusion_s=
pec(
-            other_ref_sha1s.union(
-                change.new.sha1
-                for change in self.changes
-                if change.new.type in ['commit', 'tag']
+
+            # The SHA-1s of commits referred to by all references in t=
his
+            # repository *except* updated_refs:
+            sha1s =3D set()
+            fmt =3D (
+                '%(objectname) %(objecttype) %(refname)\n'
+                '%(*objectname) %(*objecttype) %(refname)'
                 )
-            )
+            for line in read_git_lines(
+                    ['for-each-ref', '--format=3D%s' % (fmt,)]):
+                (sha1, type, name) =3D line.split(' ', 2)
+                if sha1 and type =3D=3D 'commit' and name not in updat=
ed_refs:
+                    sha1s.add(sha1)
=20
-    @classmethod
-    def _sort_key(klass, change):
-        return (klass.SORT_ORDER[change.__class__, change.change_type]=
, change.refname,)
+            self.__other_ref_sha1s =3D sha1s
+
+        return self.__other_ref_sha1s
+
+    def _get_commits_spec_incl(self, new_or_old, reference_change=3DNo=
ne):
+        """Get new or old SHA-1 from one or each of the changed refs.
=20
-    def _compute_other_ref_sha1s(self):
-        """Return the GitObjects referred to by references unaffected =
by this push."""
+        Return a list of SHA-1 commit identifier strings suitable as
+        arguments to 'git rev-list' (or 'git log' or ...).  The
+        returned identifiers are either the old or new values from one
+        or all of the changed references, depending on the values of
+        new_or_old and reference_change.
=20
-        # The refnames being changed by this push:
-        updated_refs =3D set(
-            change.refname
+        new_or_old is either the string 'new' or the string 'old'.  If
+        'new', the returned SHA-1 identifiers are the new values from
+        each changed reference.  If 'old', the SHA-1 identifiers are
+        the old values from each changed reference.
+
+        If reference_change is specified and not None, only the new or
+        old reference from the specified reference is included in the
+        return value.
+
+        This function returns None if there are no matching revisions
+        (e.g., because a branch was deleted and new_or_old is 'new').
+        """
+
+        if not reference_change:
+            incl_spec =3D sorted(
+                getattr(change, new_or_old).sha1
+                for change in self.changes
+                if getattr(change, new_or_old)
+                )
+            if not incl_spec:
+                incl_spec =3D None
+        elif not getattr(reference_change, new_or_old).commit_sha1:
+            incl_spec =3D None
+        else:
+            incl_spec =3D [getattr(reference_change, new_or_old).commi=
t_sha1]
+        return incl_spec
+
+    def _get_commits_spec_excl(self, new_or_old):
+        """Get exclusion revisions for determining new or discarded co=
mmits.
+
+        Return a list of strings suitable as arguments to 'git
+        rev-list' (or 'git log' or ...) that will exclude all
+        commits that, depending on the value of new_or_old, were
+        either previously in the repository (useful for determining
+        which commits are new to the repository) or currently in the
+        repository (useful for determining which commits were
+        discarded from the repository).
+
+        new_or_old is either the string 'new' or the string 'old'.  If
+        'new', the commits to be excluded are those that were in the
+        repository before the push.  If 'old', the commits to be
+        excluded are those that are currently in the repository.  """
+
+        old_or_new =3D {'old': 'new', 'new': 'old'}[new_or_old]
+        excl_revs =3D self._other_ref_sha1s.union(
+            getattr(change, old_or_new).sha1
             for change in self.changes
+            if getattr(change, old_or_new).type in ['commit', 'tag']
             )
+        return ['^' + sha1 for sha1 in sorted(excl_revs)]
=20
-        # The SHA-1s of commits referred to by all references in this
-        # repository *except* updated_refs:
-        sha1s =3D set()
-        fmt =3D (
-            '%(objectname) %(objecttype) %(refname)\n'
-            '%(*objectname) %(*objecttype) %(refname)'
-            )
-        for line in read_git_lines(['for-each-ref', '--format=3D%s' % =
(fmt,)]):
-            (sha1, type, name) =3D line.split(' ', 2)
-            if sha1 and type =3D=3D 'commit' and name not in updated_r=
efs:
-                sha1s.add(sha1)
+    def get_commits_spec(self, new_or_old, reference_change=3DNone):
+        """Get rev-list arguments for added or discarded commits.
=20
-        return sha1s
+        Return a list of strings suitable as arguments to 'git
+        rev-list' (or 'git log' or ...) that select those commits
+        that, depending on the value of new_or_old, are either new to
+        the repository or were discarded from the repository.
=20
-    def _compute_rev_exclusion_spec(self, sha1s):
-        """Return an exclusion specification for 'git rev-list'.
+        new_or_old is either the string 'new' or the string 'old'.  If
+        'new', the returned list is used to select commits that are
+        new to the repository.  If 'old', the returned value is used
+        to select the commits that have been discarded from the
+        repository.
=20
-        git_objects is an iterable over GitObject instances.  Return a
-        string that can be passed to the standard input of 'git
-        rev-list --stdin' to exclude all of the commits referred to by
-        git_objects."""
+        If reference_change is specified and not None, the new or
+        discarded commits are limited to those that are reachable from
+        the new or old value of the specified reference.
=20
-        return ''.join(
-            ['^%s\n' % (sha1,) for sha1 in sorted(sha1s)]
-            )
+        This function returns None if there are no added (or discarded=
)
+        revisions.
+        """
+        key =3D (new_or_old, reference_change)
+        if key not in self.__cached_commits_spec:
+            ret =3D self._get_commits_spec_incl(new_or_old, reference_=
change)
+            if ret is not None:
+                ret.extend(self._get_commits_spec_excl(new_or_old))
+            self.__cached_commits_spec[key] =3D ret
+        return self.__cached_commits_spec[key]
=20
     def get_new_commits(self, reference_change=3DNone):
         """Return a list of commits added by this push.
@@ -2280,19 +2804,8 @@ class Push(object):
         reference_change is None, then return a list of *all* commits
         added by this push."""
=20
-        if not reference_change:
-            new_revs =3D sorted(
-                change.new.sha1
-                for change in self.changes
-                if change.new
-                )
-        elif not reference_change.new.commit_sha1:
-            return []
-        else:
-            new_revs =3D [reference_change.new.commit_sha1]
-
-        cmd =3D ['rev-list', '--stdin'] + new_revs
-        return read_git_lines(cmd, input=3Dself._old_rev_exclusion_spe=
c)
+        spec =3D self.get_commits_spec('new', reference_change)
+        return git_rev_list(spec)
=20
     def get_discarded_commits(self, reference_change):
         """Return a list of commits discarded by this push.
@@ -2301,13 +2814,8 @@ class Push(object):
         entirely discarded from the repository by the part of this
         push represented by reference_change."""
=20
-        if not reference_change.old.commit_sha1:
-            return []
-        else:
-            old_revs =3D [reference_change.old.commit_sha1]
-
-        cmd =3D ['rev-list', '--stdin'] + old_revs
-        return read_git_lines(cmd, input=3Dself._new_rev_exclusion_spe=
c)
+        spec =3D self.get_commits_spec('old', reference_change)
+        return git_rev_list(spec)
=20
     def send_emails(self, mailer, body_filter=3DNone):
         """Use send all of the notification emails needed for this pus=
h.
@@ -2325,30 +2833,43 @@ class Push(object):
         unhandled_sha1s =3D set(self.get_new_commits())
         send_date =3D IncrementalDateTime()
         for change in self.changes:
+            sha1s =3D []
+            for sha1 in reversed(list(self.get_new_commits(change))):
+                if sha1 in unhandled_sha1s:
+                    sha1s.append(sha1)
+                    unhandled_sha1s.remove(sha1)
+
             # Check if we've got anyone to send to
             if not change.recipients:
-                sys.stderr.write(
+                change.environment.log_warning(
                     '*** no recipients configured so no email will be =
sent\n'
                     '*** for %r update %s->%s\n'
                     % (change.refname, change.old.sha1, change.new.sha=
1,)
                     )
             else:
-                sys.stderr.write('Sending notification emails to: %s\n=
' % (change.recipients,))
-                extra_values =3D {'send_date' : send_date.next()}
-                mailer.send(
-                    change.generate_email(self, body_filter, extra_val=
ues),
-                    change.recipients,
-                    )
+                if not change.environment.quiet:
+                    change.environment.log_msg(
+                        'Sending notification emails to: %s\n' % (chan=
ge.recipients,))
+                extra_values =3D {'send_date': send_date.next()}
=20
-            sha1s =3D []
-            for sha1 in reversed(list(self.get_new_commits(change))):
-                if sha1 in unhandled_sha1s:
-                    sha1s.append(sha1)
-                    unhandled_sha1s.remove(sha1)
+                rev =3D change.send_single_combined_email(sha1s)
+                if rev:
+                    mailer.send(
+                        change.generate_combined_email(self, rev, body=
_filter, extra_values),
+                        rev.recipients,
+                        )
+                    # This change is now fully handled; no need to han=
dle
+                    # individual revisions any further.
+                    continue
+                else:
+                    mailer.send(
+                        change.generate_email(self, body_filter, extra=
_values),
+                        change.recipients,
+                        )
=20
             max_emails =3D change.environment.maxcommitemails
             if max_emails and len(sha1s) > max_emails:
-                sys.stderr.write(
+                change.environment.log_warning(
                     '*** Too many new commits (%d), not sending commit=
 emails.\n' % len(sha1s)
                     + '*** Try setting multimailhook.maxCommitEmails t=
o a greater value\n'
                     + '*** Currently, multimailhook.maxCommitEmails=3D=
%d\n' % max_emails
@@ -2356,9 +2877,13 @@ class Push(object):
                 return
=20
             for (num, sha1) in enumerate(sha1s):
-                rev =3D Revision(change, GitObject(sha1), num=3Dnum+1,=
 tot=3Dlen(sha1s))
+                rev =3D Revision(change, GitObject(sha1), num=3Dnum + =
1, tot=3Dlen(sha1s))
+                if not rev.recipients and rev.cc_recipients:
+                    change.environment.log_msg('*** Replacing Cc: with=
 To:\n')
+                    rev.recipients =3D rev.cc_recipients
+                    rev.cc_recipients =3D None
                 if rev.recipients:
-                    extra_values =3D {'send_date' : send_date.next()}
+                    extra_values =3D {'send_date': send_date.next()}
                     mailer.send(
                         rev.generate_email(self, body_filter, extra_va=
lues),
                         rev.recipients,
@@ -2366,7 +2891,7 @@ class Push(object):
=20
         # Consistency check:
         if unhandled_sha1s:
-            sys.stderr.write(
+            change.environment.log_error(
                 'ERROR: No emails were sent for the following new comm=
its:\n'
                 '    %s\n'
                 % ('\n    '.join(sorted(unhandled_sha1s)),)
@@ -2384,7 +2909,7 @@ def run_as_post_receive_hook(environment, mailer)=
:
     push.send_emails(mailer, body_filter=3Denvironment.filter_body)
=20
=20
-def run_as_update_hook(environment, mailer, refname, oldrev, newrev):
+def run_as_update_hook(environment, mailer, refname, oldrev, newrev, f=
orce_send=3DFalse):
     changes =3D [
         ReferenceChange.create(
             environment,
@@ -2393,7 +2918,7 @@ def run_as_update_hook(environment, mailer, refna=
me, oldrev, newrev):
             refname,
             ),
         ]
-    push =3D Push(changes)
+    push =3D Push(changes, force_send)
     push.send_emails(mailer, body_filter=3Denvironment.filter_body)
=20
=20
@@ -2402,9 +2927,18 @@ def choose_mailer(config, environment):
=20
     if mailer =3D=3D 'smtp':
         smtpserver =3D config.get('smtpserver', default=3D'localhost')
+        smtpservertimeout =3D float(config.get('smtpservertimeout', de=
fault=3D10.0))
+        smtpserverdebuglevel =3D int(config.get('smtpserverdebuglevel'=
, default=3D0))
+        smtpencryption =3D config.get('smtpencryption', default=3D'non=
e')
+        smtpuser =3D config.get('smtpuser', default=3D'')
+        smtppass =3D config.get('smtppass', default=3D'')
         mailer =3D SMTPMailer(
             envelopesender=3D(environment.get_sender() or environment.=
get_fromaddr()),
-            smtpserver=3Dsmtpserver,
+            smtpserver=3Dsmtpserver, smtpservertimeout=3Dsmtpservertim=
eout,
+            smtpserverdebuglevel=3Dsmtpserverdebuglevel,
+            smtpencryption=3Dsmtpencryption,
+            smtpuser=3Dsmtpuser,
+            smtppass=3Dsmtppass,
             )
     elif mailer =3D=3D 'sendmail':
         command =3D config.get('sendmailcommand')
@@ -2412,7 +2946,7 @@ def choose_mailer(config, environment):
             command =3D shlex.split(command)
         mailer =3D SendMailer(command=3Dcommand, envelopesender=3Denvi=
ronment.get_sender())
     else:
-        sys.stderr.write(
+        environment.log_error(
             'fatal: multimailhook.mailer is set to an incorrect value:=
 "%s"\n' % mailer
             + 'please use one of "smtp" or "sendmail".\n'
             )
@@ -2421,8 +2955,8 @@ def choose_mailer(config, environment):
=20
=20
 KNOWN_ENVIRONMENTS =3D {
-    'generic' : GenericEnvironmentMixin,
-    'gitolite' : GitoliteEnvironmentMixin,
+    'generic': GenericEnvironmentMixin,
+    'gitolite': GitoliteEnvironmentMixin,
     }
=20
=20
@@ -2439,8 +2973,8 @@ def choose_environment(config, osenv=3DNone, env=3D=
None, recipients=3DNone):
         ConfigOptionsEnvironmentMixin,
         ]
     environment_kw =3D {
-        'osenv' : osenv,
-        'config' : config,
+        'osenv': osenv,
+        'config': config,
         }
=20
     if not env:
@@ -2459,6 +2993,7 @@ def choose_environment(config, osenv=3DNone, env=3D=
None, recipients=3DNone):
         environment_kw['refchange_recipients'] =3D recipients
         environment_kw['announce_recipients'] =3D recipients
         environment_kw['revision_recipients'] =3D recipients
+        environment_kw['scancommitforcc'] =3D config.get('scancommitfo=
rcc')
     else:
         environment_mixins.insert(0, ConfigRecipientsEnvironmentMixin)
=20
@@ -2499,6 +3034,14 @@ def main(args):
             '(intended for debugging purposes).'
             ),
         )
+    parser.add_option(
+        '--force-send', action=3D'store_true', default=3DFalse,
+        help=3D(
+            'Force sending refchange email when using as an update hoo=
k. '
+            'This is useful to work around the unreliable new commits =
'
+            'detection in this mode.'
+            ),
+        )
=20
     (options, args) =3D parser.parse_args(args)
=20
@@ -2513,11 +3056,11 @@ def main(args):
=20
         if options.show_env:
             sys.stderr.write('Environment values:\n')
-            for (k,v) in sorted(environment.get_values().items()):
-                sys.stderr.write('    %s : %r\n' % (k,v))
+            for (k, v) in sorted(environment.get_values().items()):
+                sys.stderr.write('    %s : %r\n' % (k, v))
             sys.stderr.write('\n')
=20
-        if options.stdout:
+        if options.stdout or environment.stdout:
             mailer =3D OutputMailer(sys.stdout)
         else:
             mailer =3D choose_mailer(config, environment)
@@ -2528,7 +3071,7 @@ def main(args):
             if len(args) !=3D 3:
                 parser.error('Need zero or three non-option arguments'=
)
             (refname, oldrev, newrev) =3D args
-            run_as_update_hook(environment, mailer, refname, oldrev, n=
ewrev)
+            run_as_update_hook(environment, mailer, refname, oldrev, n=
ewrev, options.force_send)
         else:
             run_as_post_receive_hook(environment, mailer)
     except ConfigurationException, e:
diff --git a/contrib/hooks/multimail/migrate-mailhook-config b/contrib/=
hooks/multimail/migrate-mailhook-config
index 04eeaac..d0e9b39 100755
--- a/contrib/hooks/multimail/migrate-mailhook-config
+++ b/contrib/hooks/multimail/migrate-mailhook-config
@@ -22,6 +22,7 @@ OLD_NAMES =3D [
     'showrev',
     'emailmaxlines',
     'diffopts',
+    'scancommitforcc',
     ]
=20
 NEW_NAMES =3D [
@@ -38,6 +39,7 @@ NEW_NAMES =3D [
     'emailmaxlines',
     'diffopts',
     'emaildomain',
+    'scancommitforcc',
     ]
=20
=20
@@ -61,7 +63,7 @@ def _check_old_config_exists(old):
     """Check that at least one old configuration value is set."""
=20
     for name in OLD_NAMES:
-        if old.has_key(name):
+        if name in old:
             return True
=20
     return False
@@ -72,7 +74,7 @@ def _check_new_config_clear(new):
=20
     retval =3D True
     for name in NEW_NAMES:
-        if new.has_key(name):
+        if name in new:
             if retval:
                 sys.stderr.write('INFO: The following configuration va=
lues already exist:\n\n')
             sys.stderr.write('    "%s.%s"\n' % (new.section, name))
@@ -83,7 +85,7 @@ def _check_new_config_clear(new):
=20
 def erase_values(config, names):
     for name in names:
-        if config.has_key(name):
+        if name in config:
             try:
                 sys.stderr.write('...unsetting "%s.%s"\n' % (config.se=
ction, name))
                 config.unset_all(name)
@@ -170,7 +172,7 @@ def migrate_config(strict=3DFalse, retain=3DFalse, =
overwrite=3DFalse):
                 )
=20
     name =3D 'showrev'
-    if old.has_key(name):
+    if name in old:
         msg =3D 'git-multimail does not support "%s.%s"' % (old.sectio=
n, name,)
         if strict:
             sys.exit(
@@ -182,7 +184,7 @@ def migrate_config(strict=3DFalse, retain=3DFalse, =
overwrite=3DFalse):
             sys.stderr.write('\nWARNING: %s (ignoring).\n\n' % (msg,))
=20
     for name in ['mailinglist', 'announcelist']:
-        if old.has_key(name):
+        if name in old:
             sys.stderr.write(
                 '...copying "%s.%s" to "%s.%s"\n' % (old.section, name=
, new.section, name)
                 )
@@ -198,15 +200,15 @@ def migrate_config(strict=3DFalse, retain=3DFalse=
, overwrite=3DFalse):
             )
         new.set('announceshortlog', 'true')
=20
-    for name in ['envelopesender', 'emailmaxlines', 'diffopts']:
-        if old.has_key(name):
+    for name in ['envelopesender', 'emailmaxlines', 'diffopts', 'scanc=
ommitforcc']:
+        if name in old:
             sys.stderr.write(
                 '...copying "%s.%s" to "%s.%s"\n' % (old.section, name=
, new.section, name)
                 )
             new.set(name, old.get(name))
=20
     name =3D 'emailprefix'
-    if old.has_key(name):
+    if name in old:
         sys.stderr.write(
             '...copying "%s.%s" to "%s.%s"\n' % (old.section, name, ne=
w.section, name)
             )
diff --git a/contrib/hooks/multimail/post-receive b/contrib/hooks/multi=
mail/post-receive.example
similarity index 74%
rename from contrib/hooks/multimail/post-receive
rename to contrib/hooks/multimail/post-receive.example
index 4d46828..43f7b6b 100755
--- a/contrib/hooks/multimail/post-receive
+++ b/contrib/hooks/multimail/post-receive.example
@@ -2,16 +2,18 @@
=20
 """Example post-receive hook based on git-multimail.
=20
-This script is a simple example of a post-receive hook implemented
-using git_multimail.py as a Python module.  It is intended to be
-customized before use; see the comments in the script to help you get
-started.
+The simplest way to use git-multimail is to use the script
+git_multimail.py directly as a post-receive hook, and to configure it
+using Git's configuration files and command-line parameters.  You can
+also write your own Python wrapper for more advanced configurability,
+using git_multimail.py as a Python module.
=20
-It is possible to use git_multimail.py itself as a post-receive or
-update hook, configured via git config settings and/or command-line
-parameters.  But for more flexibility, it can also be imported as a
-Python module by a custom post-receive script as done here.  The
-latter has the following advantages:
+This script is a simple example of such a post-receive hook.  It is
+intended to be customized before use; see the comments in the script
+to help you get started.
+
+Using git-multimail as a Python module as done here provides more
+flexibility.  It has the following advantages:
=20
 * The tool's behavior can be customized using arbitrary Python code,
   without having to edit git_multimail.py.
@@ -56,8 +58,11 @@ config =3D git_multimail.Config('multimailhook')
=20
=20
 # Select the type of environment:
-environment =3D git_multimail.GenericEnvironment(config=3Dconfig)
-#environment =3D git_multimail.GitoliteEnvironment(config=3Dconfig)
+try:
+    environment =3D git_multimail.GenericEnvironment(config=3Dconfig)
+    #environment =3D git_multimail.GitoliteEnvironment(config=3Dconfig=
)
+except git_multimail.ConfigurationException, e:
+    sys.exit(str(e))
=20
=20
 # Choose the method of sending emails based on the git config:
--=20
2.4.3.435.g7f6fd76
