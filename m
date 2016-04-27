From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC/PATCH] git-multimail: update to release 1.3.0-rc1
Date: Wed, 27 Apr 2016 16:59:52 +0200
Message-ID: <20160427145952.9032-1-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 17:00:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avQwy-0002jn-6j
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 17:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753066AbcD0PAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 11:00:16 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41733 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752339AbcD0PAL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 11:00:11 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u3RF04QO020868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 27 Apr 2016 17:00:04 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u3RF06YZ002137;
	Wed, 27 Apr 2016 17:00:06 +0200
X-Mailer: git-send-email 2.8.1.339.g3ad15fd
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Wed, 27 Apr 2016 17:00:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u3RF04QO020868
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1462374006.27031@a0lCNswBPwuVrQWD75r6ZQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292726>

The changes are described in CHANGES.

Contributions-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Contributions-by: Stefan Tatschner <rumpelsepp@sevenbyte.org>
Contributions-by: Simon P <simon.git@le-huit.fr>
Contributions-by: Leander Hasty <leander@1stplayable.com>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Not for inclusion, but tests and reviews welcome.

 contrib/hooks/multimail/CHANGES                    |  33 +++
 contrib/hooks/multimail/CONTRIBUTING.rst           |  17 +-
 contrib/hooks/multimail/README                     | 215 +++++++++---------
 contrib/hooks/multimail/README.Git                 |   4 +-
 contrib/hooks/multimail/doc/customizing-emails.rst |  56 +++++
 contrib/hooks/multimail/doc/troubleshooting.rst    |  44 ++++
 contrib/hooks/multimail/git_multimail.py           | 242 ++++++++++++++++++---
 contrib/hooks/multimail/post-receive.example       |   6 +
 8 files changed, 474 insertions(+), 143 deletions(-)
 create mode 100644 contrib/hooks/multimail/doc/customizing-emails.rst
 create mode 100644 contrib/hooks/multimail/doc/troubleshooting.rst

diff --git a/contrib/hooks/multimail/CHANGES b/contrib/hooks/multimail/CHANGES
index bc77e66..ecbdb4e 100644
--- a/contrib/hooks/multimail/CHANGES
+++ b/contrib/hooks/multimail/CHANGES
@@ -1,3 +1,36 @@
+Release 1.3 RC1
+===============
+
+* New options multimailhook.htmlInIntro and multimailhook.htmlInFooter
+  now allow using HTML in the introduction and footer of emails (e.g.
+  for a more pleasant formatting or to insert a link to the commit on
+  a web interface).
+
+* A new option multimailhook.commitBrowseURL gives a simpler (and less
+  flexible) way to add a link to a web interface for commit emails
+  than multimailhook.htmlInIntro and multimailhook.htmlInFooter.
+
+* A new public function config.add_config_parameters was added to
+  allow custom hooks to set specific Git configuration variables
+  without modifying the configuration files. See an example in
+  post-receive.example.
+
+* Error handling for SMTP has been improved (we used to print Python
+  backtraces for legitimate errors).
+
+* The SMTP mailer can now check TLS certificates when the newly added
+  configuration variable multimailhook.smtpCACerts.
+
+* Python 3 portability has been improved.
+
+* The documentation's formatting has been improved.
+
+* The testsuite has been improved (we now use pyflakes to check for
+  errors in the code).
+
+This version has been tested with Python 2.4 and 2.6 to 3.5, and Git
+v1.7.10-406-gdc801e7, 2.1.4 and 2.8.1.339.g3ad15fd.
+
 Release 1.2.0
 =============
 
diff --git a/contrib/hooks/multimail/CONTRIBUTING.rst b/contrib/hooks/multimail/CONTRIBUTING.rst
index 09efdb0..530ecbf 100644
--- a/contrib/hooks/multimail/CONTRIBUTING.rst
+++ b/contrib/hooks/multimail/CONTRIBUTING.rst
@@ -1,3 +1,6 @@
+Contributing
+============
+
 git-multimail is an open-source project, built by volunteers. We would
 welcome your help!
 
@@ -6,9 +9,7 @@ and Matthieu Moy <matthieu.moy@grenoble-inp.fr>.
 
 Please note that although a copy of git-multimail is distributed in
 the "contrib" section of the main Git project, development takes place
-in a separate git-multimail repository on GitHub:
-
-    https://github.com/git-multimail/git-multimail
+in a separate `git-multimail repository on GitHub`_.
 
 Whenever enough changes to git-multimail have accumulated, a new
 code-drop of git-multimail will be submitted for inclusion in the Git
@@ -21,10 +22,12 @@ to the maintainers). Please sign off your patches as per the `Git
 project practice
 <https://github.com/git/git/blob/master/Documentation/SubmittingPatches#L234>`__.
 
-General discussion of git-multimail can take place on the main Git
-mailing list,
-
-    git@vger.kernel.org
+General discussion of git-multimail can take place on the main `Git
+mailing list`_.
 
 Please CC emails regarding git-multimail to the maintainers so that we
 don't overlook them.
+
+
+.. _`git-multimail repository on GitHub`: https://github.com/git-multimail/git-multimail
+.. _`Git mailing list`: git@vger.kernel.org
diff --git a/contrib/hooks/multimail/README b/contrib/hooks/multimail/README
index 5512068..26b3a0a 100644
--- a/contrib/hooks/multimail/README
+++ b/contrib/hooks/multimail/README
@@ -1,5 +1,5 @@
-git-multimail (version 1.2.0)
-=============================
+git-multimail 1.3rc1
+====================
 
 .. image:: https://travis-ci.org/git-multimail/git-multimail.svg?branch=master
     :target: https://travis-ci.org/git-multimail/git-multimail
@@ -127,6 +127,13 @@ changes of this type, please consider sharing them with the
 community.)
 
 
+Troubleshooting/FAQ
+-------------------
+
+Please read `<doc/troubleshooting.rst>`__ for frequently asked
+questions and common issues with git-multimail.
+
+
 Configuration
 -------------
 
@@ -134,19 +141,16 @@ By default, git-multimail mostly takes its configuration from the
 following ``git config`` settings:
 
 multimailhook.environment
-
     This describes the general environment of the repository. In most
     cases, you do not need to specify a value for this variable:
     `git-multimail` will autodetect which environment to use.
     Currently supported values:
 
-    * generic
-
+    generic
       the username of the pusher is read from $USER or $USERNAME and
       the repository name is derived from the repository's path.
 
-    * gitolite
-
+    gitolite
       the username of the pusher is read from $GL_USER, the repository
       name is read from $GL_REPO, and the From: header value is
       optionally read from gitolite.conf (see multimailhook.from).
@@ -154,8 +158,7 @@ multimailhook.environment
       For more information about gitolite and git-multimail, read
       `<doc/gitolite.rst>`__
 
-    * stash
-
+    stash
       Environment to use when ``git-multimail`` is ran as an Atlassian
       BitBucket Server (formerly known as Atlassian Stash) hook.
 
@@ -169,8 +172,7 @@ multimailhook.environment
       and repo come from these two command line flags, which must be
       specified.
 
-    * gerrit
-
+    gerrit
       Environment to use when ``git-multimail`` is ran as a
       ``ref-updated`` Gerrit hook.
 
@@ -205,14 +207,12 @@ multimailhook.environment
     * If none of the above apply, then ``generic`` is used.
 
 multimailhook.repoName
-
     A short name of this Git repository, to be used in various places
     in the notification email text.  The default is to use $GL_REPO
     for gitolite repositories, or otherwise to derive this value from
     the repository path name.
 
 multimailhook.mailingList
-
     The list of email addresses to which notification emails should be
     sent, as RFC 2822 email addresses separated by commas.  This
     configuration option can be multivalued.  Leave it unset or set it
@@ -221,7 +221,6 @@ multimailhook.mailingList
     specific types of notification email.
 
 multimailhook.refchangeList
-
     The list of email addresses to which summary emails about
     reference changes should be sent, as RFC 2822 email addresses
     separated by commas.  This configuration option can be
@@ -231,7 +230,6 @@ multimailhook.refchangeList
     multimailhook.mailingList is set.
 
 multimailhook.announceList
-
     The list of email addresses to which emails about new annotated
     tags should be sent, as RFC 2822 email addresses separated by
     commas.  This configuration option can be multivalued.  The
@@ -241,7 +239,6 @@ multimailhook.announceList
     even if one of the other values is set.
 
 multimailhook.commitList
-
     The list of email addresses to which emails about individual new
     commits should be sent, as RFC 2822 email addresses separated by
     commas.  This configuration option can be multivalued.  The
@@ -251,7 +248,6 @@ multimailhook.commitList
     multimailhook.mailingList is set.
 
 multimailhook.announceShortlog
-
     If this option is set to true, then emails about changes to
     annotated tags include a shortlog of changes since the previous
     tag.  This can be useful if the annotated tags represent releases;
@@ -261,7 +257,6 @@ multimailhook.announceShortlog
     rather than useful.  Default is false.
 
 multimailhook.commitEmailFormat
-
     The format of email messages for the individual commits, can be "text" or
     "html". In the latter case, the emails will include diffs using colorized
     HTML instead of plain text used by default. Note that this  currently the
@@ -274,8 +269,43 @@ multimailhook.commitEmailFormat
     the message starting with ``+++`` or ``---`` colored in red or
     green).
 
-multimailhook.refchangeShowGraph
+    By default, all the message is HTML-escaped. See
+    ``multimailhook.htmlInIntro`` to change this behavior.
+
+multimailhook.commitBrowseURL
+    Used to generate a link to an online repository browser in commit
+    emails. This variable must be a string. Format directives like
+    ``%(<variable>)s`` will be expanded the same way as template
+    strings. In particular, ``%(id)s`` will be replaced by the full
+    Git commit identifier (40-chars hexadecimal).
+
+    If the string does not contain any format directive, then
+    ``%(id)s`` will be automatically added to the string. If you don't
+    want ``%(id)s`` to be automatically added, use the empty format
+    directive ``%()s`` anywhere in the string.
+
+    For example, a suitable value for the git-multimail project itself
+    would be
+    ``https://github.com/git-multimail/git-multimail/commit/%(id)s``.
+
+multimailhook.htmlInIntro, multimailhook.htmlInFooter
+    When generating an HTML message, git-multimail escapes any HTML
+    sequence by default. This means that if a template contains HTML
+    like ``<a href="foo">link</a>``, the reader will see the HTML
+    source code and not a proper link.
+
+    Set ``multimailhook.htmlInIntro`` to true to allow writting HTML
+    formatting in introduction templates. Similarly, set
+    ``multimailhook.htmlInFooter`` for HTML in the footer.
 
+    Variables expanded in the template are still escaped. For example,
+    if a repository's path contains a ``<``, it will be rendered as
+    such in the message.
+
+    Read `<doc/customizing-emails.rst>`__ for more details and
+    examples.
+
+multimailhook.refchangeShowGraph
     If this option is set to true, then summary emails about reference
     changes will additionally include:
 
@@ -287,7 +317,6 @@ multimailhook.refchangeShowGraph
     specified in graphOpts.  The default is false.
 
 multimailhook.refchangeShowLog
-
     If this option is set to true, then summary emails about reference
     changes will include a detailed log of the added commits in
     addition to the one line summary.  The log is generated by running
@@ -295,71 +324,80 @@ multimailhook.refchangeShowLog
     Default is false.
 
 multimailhook.mailer
-
     This option changes the way emails are sent.  Accepted values are:
 
-    - sendmail (the default): use the command ``/usr/sbin/sendmail`` or
+    * **sendmail (the default)**: use the command ``/usr/sbin/sendmail`` or
       ``/usr/lib/sendmail`` (or sendmailCommand, if configured).  This
       mode can be further customized via the following options:
 
-      * multimailhook.sendmailCommand
-
-        The command used by mailer ``sendmail`` to send emails.  Shell
-        quoting is allowed in the value of this setting, but remember that
-        Git requires double-quotes to be escaped; e.g.::
+      multimailhook.sendmailCommand
+          The command used by mailer ``sendmail`` to send emails.  Shell
+          quoting is allowed in the value of this setting, but remember that
+          Git requires double-quotes to be escaped; e.g.::
 
-             git config multimailhook.sendmailcommand '/usr/sbin/sendmail -oi -t -F \"Git Repo\"'
+              git config multimailhook.sendmailcommand '/usr/sbin/sendmail -oi -t -F \"Git Repo\"'
 
-        Default is '/usr/sbin/sendmail -oi -t' or
-        '/usr/lib/sendmail -oi -t' (depending on which file is
-        present and executable).
+          Default is '/usr/sbin/sendmail -oi -t' or
+          '/usr/lib/sendmail -oi -t' (depending on which file is
+          present and executable).
 
-      * multimailhook.envelopeSender
+      multimailhook.envelopeSender
+          If set then pass this value to sendmail via the -f option to set
+          the envelope sender address.
 
-        If set then pass this value to sendmail via the -f option to set
-        the envelope sender address.
-
-    - smtp: use Python's smtplib.  This is useful when the sendmail
+    * **smtp**: use Python's smtplib.  This is useful when the sendmail
       command is not available on the system.  This mode can be
       further customized via the following options:
 
-      * multimailhook.smtpServer
-
-        The name of the SMTP server to connect to.  The value can
-        also include a colon and a port number; e.g.,
-        ``mail.example.com:25``.  Default is 'localhost' using port 25.
-
-      * multimailhook.smtpUser
-      * multimailhook.smtpPass
-
-        Server username and password. Required if smtpEncryption is 'ssl'.
-        Note that the username and password currently need to be
-        set cleartext in the configuration file, which is not
-        recommended. If you need to use this option, be sure your
-        configuration file is read-only.
+      multimailhook.smtpServer
+          The name of the SMTP server to connect to.  The value can
+          also include a colon and a port number; e.g.,
+          ``mail.example.com:25``.  Default is 'localhost' using port 25.
 
-      * multimailhook.envelopeSender
+      multimailhook.smtpUser, multimailhook.smtpPass
+          Server username and password. Required if smtpEncryption is 'ssl'.
+          Note that the username and password currently need to be
+          set cleartext in the configuration file, which is not
+          recommended. If you need to use this option, be sure your
+          configuration file is read-only.
 
+      multimailhook.envelopeSender
         The sender address to be passed to the SMTP server.  If
         unset, then the value of multimailhook.from is used.
 
-      * multimailhook.smtpServerTimeout
-
+      multimailhook.smtpServerTimeout
         Timeout in seconds.
 
-      * multimailhook.smtpEncryption
-
-        Set the security type. Allowed values: none, ssl, tls.
-        Default=none.
-
-      * multimailhook.smtpServerDebugLevel
-
+      multimailhook.smtpEncryption
+        Set the security type. Allowed values: ``none``, ``ssl``, ``tls`` (starttls).
+        Default is ``none``.
+
+      multimailhook.smtpCACerts
+        Set the path to a list of trusted CA certificate to verify the
+        server certificate, only supported when ``smtpEncryption`` is
+        ``tls``. If unset or empty, the server certificate is not
+        verified. If it targets a file containing a list of trusted CA
+        certificates (PEM format) these CAs will be used to verify the
+        server certificate. For debian, you can set
+        ``/etc/ssl/certs/ca-certificates.crt`` for using the system
+        trusted CAs. For self-signed server, you can add your server
+        certificate to the system store::
+
+            cd /usr/local/share/ca-certificates/
+            openssl s_client -starttls smtp \
+                   -connect mail.example.net:587 -showcerts \
+                   </dev/null 2>/dev/null \
+                 | openssl x509 -outform PEM >mail.example.net.crt
+            update-ca-certificates
+
+        and used the updated ``/etc/ssl/certs/ca-certificates.crt``. Or
+        directly use your ``/path/to/mail.example.net.crt``. Default is
+        unset.
+
+      multimailhook.smtpServerDebugLevel
         Integer number. Set to greater than 0 to activate debugging.
 
-multimailhook.from
-multimailhook.fromCommit
-multimailhook.fromRefchange
-
+multimailhook.from, multimailhook.fromCommit, multimailhook.fromRefchange
     If set, use this value in the From: field of generated emails.
     ``fromCommit`` is used for commit emails, ``fromRefchange`` is
     used for refchange emails, and ``from`` is used as fall-back in
@@ -372,7 +410,7 @@ multimailhook.fromRefchange
     - The value ``pusher``, in which case the pusher's address (if
       available) will be used.
 
-    - The value ``author`` (meaningful only for replyToCommit), in which
+    - The value ``author`` (meaningful only for ``fromCommit``), in which
       case the commit author's address will be used.
 
     If config values are unset, the value of the From: header is
@@ -396,14 +434,12 @@ multimailhook.fromRefchange
     3. Use the value of multimailhook.envelopeSender.
 
 multimailhook.administrator
-
     The name and/or email address of the administrator of the Git
     repository; used in FOOTER_TEMPLATE.  Default is
     multimailhook.envelopesender if it is set; otherwise a generic
     string is used.
 
 multimailhook.emailPrefix
-
     All emails have this string prepended to their subjects, to aid
     email filtering (though filtering based on the X-Git-* email
     headers is probably more robust).  Default is the short name of
@@ -411,16 +447,14 @@ multimailhook.emailPrefix
     value to the empty string to suppress the email prefix.
 
 multimailhook.emailMaxLines
-
     The maximum number of lines that should be included in the body of
     a generated email.  If not specified, there is no limit.  Lines
     beyond the limit are suppressed and counted, and a final line is
     added indicating the number of suppressed lines.
 
 multimailhook.emailMaxLineLength
-
     The maximum length of a line in the email body.  Lines longer than
-    this limit are truncated to this length with a trailing `` [...]``
+    this limit are truncated to this length with a trailing ``[...]``
     added to indicate the missing text.  The default is 500, because
     (a) diffs with longer lines are probably from binary files, for
     which a diff is useless, and (b) even if a text file has such long
@@ -428,7 +462,6 @@ multimailhook.emailMaxLineLength
     truncation, set this option to 0.
 
 multimailhook.maxCommitEmails
-
     The maximum number of commit emails to send for a given change.
     When the number of patches is larger that this value, only the
     summary refchange email is sent.  This can avoid accidental
@@ -436,14 +469,12 @@ multimailhook.maxCommitEmails
     emails limit, set this option to 0.  The default is 500.
 
 multimailhook.emailStrictUTF8
-
     If this boolean option is set to `true`, then the main part of the
     email body is forced to be valid UTF-8.  Any characters that are
     not valid UTF-8 are converted to the Unicode replacement
     character, U+FFFD.  The default is `true`.
 
 multimailhook.diffOpts
-
     Options passed to ``git diff-tree`` when generating the summary
     information for ReferenceChange emails.  Default is ``--stat
     --summary --find-copies-harder``.  Add -p to those options to
@@ -452,7 +483,6 @@ multimailhook.diffOpts
     details.
 
 multimailhook.graphOpts
-
     Options passed to ``git log --graph`` when generating graphs for the
     reference change summary emails (used only if refchangeShowGraph
     is true).  The default is '--oneline --decorate'.
@@ -460,7 +490,6 @@ multimailhook.graphOpts
     Shell quoting is allowed; see logOpts for details.
 
 multimailhook.logOpts
-
     Options passed to ``git log`` to generate additional info for
     reference change emails (used only if refchangeShowLog is set).
     For example, adding -p will show each commit's complete diff.  The
@@ -479,7 +508,6 @@ multimailhook.logOpts
               logopts = --pretty=format:\"%h %aN <%aE>%n%s%n%n%b%n\"
 
 multimailhook.commitLogOpts
-
     Options passed to ``git log`` to generate additional info for
     revision change emails.  For example, adding --ignore-all-spaces
     will suppress whitespace changes.  The default options are ``-C
@@ -487,26 +515,21 @@ multimailhook.commitLogOpts
     multimailhook.logOpts for details.
 
 multimailhook.dateSubstitute
-
     String to use as a substitute for ``Date:`` in the output of ``git
     log`` while formatting commit messages. This is usefull to avoid
     emitting a line that can be interpreted by mailers as the start of
     a cited message (Zimbra webmail in particular). Defaults to
-    ``CommitDate: ``. Set to an empty string or ``none`` to deactivate
+    ``CommitDate:``. Set to an empty string or ``none`` to deactivate
     the behavior.
 
 multimailhook.emailDomain
-
     Domain name appended to the username of the person doing the push
     to convert it into an email address
     (via ``"%s@%s" % (username, emaildomain)``). More complicated
     schemes can be implemented by overriding Environment and
     overriding its get_pusher_email() method.
 
-multimailhook.replyTo
-multimailhook.replyToCommit
-multimailhook.replyToRefchange
-
+multimailhook.replyTo, multimailhook.replyToCommit, multimailhook.replyToRefchange
     Addresses to use in the Reply-To: field for commit emails
     (replyToCommit) and refchange emails (replyToRefchange).
     multimailhook.replyTo is used as default when replyToCommit or
@@ -519,32 +542,24 @@ multimailhook.replyToRefchange
     commit emails.
 
 multimailhook.quiet
-
     Do not output the list of email recipients from the hook
 
 multimailhook.stdout
-
     For debugging, send emails to stdout rather than to the
     mailer.  Equivalent to the --stdout command line option
 
 multimailhook.scanCommitForCc
-
     If this option is set to true, than recipients from lines in commit body
     that starts with ``CC:`` will be added to CC list.
     Default: false
 
 multimailhook.combineWhenSingleCommit
-
     If this option is set to true and a single new commit is pushed to
     a branch, combine the summary and commit email messages into a
     single email.
     Default: true
 
-multimailhook.refFilterInclusionRegex
-multimailhook.refFilterExclusionRegex
-multimailhook.refFilterDoSendRegex
-multimailhook.refFilterDontSendRegex
-
+multimailhook.refFilterInclusionRegex, multimailhook.refFilterExclusionRegex, multimailhook.refFilterDoSendRegex, multimailhook.refFilterDontSendRegex
     **Warning:** these options are experimental. They should work, but
     the user-interface is not stable yet (in particular, the option
     names may change). If you want to participate in stabilizing the
@@ -626,14 +641,16 @@ git-multimail is mostly customized via an "environment" that describes
 the local environment in which Git is running.  Two types of
 environment are built in:
 
-* GenericEnvironment: a stand-alone Git repository.
+GenericEnvironment
+    a stand-alone Git repository.
 
-* GitoliteEnvironment: a Git repository that is managed by gitolite
-  [3]_.  For such repositories, the identity of the pusher is read from
-  environment variable $GL_USER, the name of the repository is read
-  from $GL_REPO (if it is not overridden by multimailhook.reponame),
-  and the From: header value is optionally read from gitolite.conf
-  (see multimailhook.from).
+GitoliteEnvironment
+    a Git repository that is managed by gitolite
+    [3]_.  For such repositories, the identity of the pusher is read from
+    environment variable $GL_USER, the name of the repository is read
+    from $GL_REPO (if it is not overridden by multimailhook.reponame),
+    and the From: header value is optionally read from gitolite.conf
+    (see multimailhook.from).
 
 By default, git-multimail assumes GitoliteEnvironment if $GL_USER and
 $GL_REPO are set, and otherwise assumes GenericEnvironment.
diff --git a/contrib/hooks/multimail/README.Git b/contrib/hooks/multimail/README.Git
index 300a2a4..6c4faf5 100644
--- a/contrib/hooks/multimail/README.Git
+++ b/contrib/hooks/multimail/README.Git
@@ -6,10 +6,10 @@ website:
     https://github.com/git-multimail/git-multimail
 
 The version in this directory was obtained from the upstream project
-on October 11 2015 and consists of the "git-multimail" subdirectory from
+on April 27 2016 and consists of the "git-multimail" subdirectory from
 revision
 
-    c0791b9ef5821a746fc3475c25765e640452eaae refs/tags/1.2.0
+    b512b8ea5fdc625a6b800da6c7354bd366312857 refs/tags/1.3.0-rc1
 
 Please see the README file in this directory for information about how
 to report bugs or contribute to git-multimail.
diff --git a/contrib/hooks/multimail/doc/customizing-emails.rst b/contrib/hooks/multimail/doc/customizing-emails.rst
new file mode 100644
index 0000000..3f5b67f
--- /dev/null
+++ b/contrib/hooks/multimail/doc/customizing-emails.rst
@@ -0,0 +1,56 @@
+Customizing the content and formatting of emails
+================================================
+
+Overloading template strings
+----------------------------
+
+The content of emails is generated based on template strings defined
+in ``git_multimail.py``. You can customize these template strings
+without changing the script itself, by defining a Python wrapper
+around it. The python wrapper should ``import git_multimail`` and then
+override the ``git_multimail.*`` strings like this::
+
+  import sys  # needed for sys.argv
+
+  # Import and customize git_multimail:
+  import git_multimail
+  git_multimail.REVISION_INTRO_TEMPLATE = """..."""
+  git_multimail.COMBINED_INTRO_TEMPLATE = git_multimail.REVISION_INTRO_TEMPLATE
+
+  # start git_multimail itself:
+  git_multimail.main(sys.argv[1:])
+
+The template strings can use any value already used in the existing
+templates (read the source code).
+
+Using HTML in template strings
+------------------------------
+
+If ``multimailhook.commitEmailFormat`` is set to HTML, then
+git-multimail will generate HTML emails for commit notifications. The
+log and diff will be formatted automatically by git-multimail. By
+default, any HTML special character in the templates will be escaped.
+
+To use HTML formatting in the introduction of the email, set
+``multimailhook.htmlInIntro`` to ``true``. Then, the template can
+contain any HTML tags, that will be sent as-is in the email. For
+example, to add some formatting and a link to the online commit, use
+a format like::
+
+  git_multimail.REVISION_INTRO_TEMPLATE = """\
+  <span style="color:#808080">This is an automated email from the git hooks/post-receive script.</span><br /><br />
+
+  <strong>%(pusher)s</strong> pushed a commit to %(refname_type)s %(short_refname)s
+  in repository %(repo_shortname)s.<br />
+
+  <a href="https://github.com/git-multimail/git-multimail/commit/%(newrev)s">View on GitHub</a>.
+  """
+
+Note that the values expanded from ``%(variable)s`` in the format
+strings will still be escaped.
+
+For a less flexible but easier to set up way to add a link to commit
+emails, see ``multimailhook.commitBrowseURL``.
+
+Similarly, one can set ``multimailhook.htmlInFooter`` and override any
+of the ``*_FOOTER*`` template strings.
diff --git a/contrib/hooks/multimail/doc/troubleshooting.rst b/contrib/hooks/multimail/doc/troubleshooting.rst
new file mode 100644
index 0000000..542d30e
--- /dev/null
+++ b/contrib/hooks/multimail/doc/troubleshooting.rst
@@ -0,0 +1,44 @@
+Troubleshooting issues with git-multimail: a FAQ
+================================================
+
+Git is not using the right address in the From/To/Reply-To field
+----------------------------------------------------------------
+
+First, make sure that git-multimail actually uses what you think it is
+using. A lot happens to your email (especially when posting to a
+mailing-list) between the time `git_multimail.py` sends it and the
+time it reaches your inbox.
+
+A simple test (to do on a test repository, do not use in production as
+it would disable email sending): change your post-receive hook to call
+`git_multimail.py` with the `--stdout` option, and try to push to the
+repository. You should see something like::
+
+  Counting objects: 3, done.
+  Writing objects: 100% (3/3), 263 bytes | 0 bytes/s, done.
+  Total 3 (delta 0), reused 0 (delta 0)
+  remote: Sending notification emails to: foo.bar@example.com
+  remote: ===========================================================================
+  remote: Date: Mon, 25 Apr 2016 18:39:59 +0200
+  remote: To: foo.bar@example.com
+  remote: Subject: [git] branch master updated: foo
+  remote: MIME-Version: 1.0
+  remote: Content-Type: text/plain; charset=utf-8
+  remote: Content-Transfer-Encoding: 8bit
+  remote: Message-ID: <20160425163959.2311.20498@anie>
+  remote: From: Auth Or <Foo.Bar@example.com>
+  remote: Reply-To: Auth Or <Foo.Bar@example.com>
+  remote: X-Git-Host: example
+  ...
+  remote: -- 
+  remote: To stop receiving notification emails like this one, please contact
+  remote: the administrator of this repository.
+  remote: ===========================================================================
+  To /path/to/repo
+     6278f04..e173f20  master -> master
+  
+Note: this does not include the sender (Return-Path: header), as it is
+not part of the message content but passed to the mailer. Some mailer
+show the ``Sender:`` field instead of the ``From:`` field (for
+example, Zimbra Webmail shows ``From: <sender-field> on behalf of
+<from-field>``).
diff --git a/contrib/hooks/multimail/git_multimail.py b/contrib/hooks/multimail/git_multimail.py
index 0180dba..a486f33 100755
--- a/contrib/hooks/multimail/git_multimail.py
+++ b/contrib/hooks/multimail/git_multimail.py
@@ -1,6 +1,6 @@
 #! /usr/bin/env python
 
-__version__ = '1.2.0'
+__version__ = '1.3.rc1'
 
 # Copyright (c) 2015 Matthieu Moy and others
 # Copyright (c) 2012-2014 Michael Haggerty and others
@@ -57,6 +57,11 @@ import subprocess
 import shlex
 import optparse
 import smtplib
+try:
+    import ssl
+except ImportError:
+    # Python < 2.6 do not have ssl, but that's OK if we don't use it.
+    pass
 import time
 import cgi
 
@@ -75,6 +80,9 @@ def is_ascii(s):
 
 
 if PYTHON3:
+    def is_string(s):
+        return isinstance(s, str)
+
     def str_to_bytes(s):
         return s.encode(ENCODING)
 
@@ -91,6 +99,12 @@ if PYTHON3:
         except UnicodeEncodeError:
             f.buffer.write(msg.encode(ENCODING))
 else:
+    def is_string(s):
+        try:
+            return isinstance(s, basestring)
+        except NameError:  # Silence Pyflakes warning
+            raise
+
     def str_to_bytes(s):
         return s
 
@@ -313,6 +327,16 @@ in repository %(repo_shortname)s.
 
 """
 
+LINK_TEXT_TEMPLATE = """\
+View the commit online:
+%(browse_url)s
+
+"""
+
+LINK_HTML_TEMPLATE = """\
+<p><a href="%(browse_url)s">View the commit online</a>.</p>
+"""
+
 
 REVISION_FOOTER_TEMPLATE = FOOTER_TEMPLATE
 
@@ -532,6 +556,28 @@ class Config(object):
         assert words[-1] == ''
         return words[:-1]
 
+    @staticmethod
+    def add_config_parameters(c):
+        """Add configuration parameters to Git.
+
+        c is either an str or a list of str, each element being of the
+        form 'var=val' or 'var', with the same syntax and meaning as
+        the argument of 'git -c var=val'.
+        """
+        if isinstance(c, str):
+            c = (c,)
+        parameters = os.environ.get('GIT_CONFIG_PARAMETERS', '')
+        if parameters:
+            parameters += ' '
+        # git expects GIT_CONFIG_PARAMETERS to be of the form
+        #    "'name1=value1' 'name2=value2' 'name3=value3'"
+        # including everything inside the double quotes (but not the double
+        # quotes themselves).  Spacing is critical.  Also, if a value contains
+        # a literal single quote that quote must be represented using the
+        # four character sequence: '\''
+        parameters += ' '.join("'" + x.replace("'", "'\\''") + "'" for x in c)
+        os.environ['GIT_CONFIG_PARAMETERS'] = parameters
+
     def get(self, name, default=None):
         try:
             values = self._split(read_git_output(
@@ -745,6 +791,12 @@ class Change(object):
         values['multimail_version'] = get_version()
         return values
 
+    # Aliases usable in template strings. Tuple of pairs (destination,
+    # source).
+    VALUES_ALIAS = (
+        ("id", "newrev"),
+        )
+
     def get_values(self, **extra_values):
         """Return a dictionary {keyword: expansion} for this Change.
 
@@ -760,6 +812,9 @@ class Change(object):
         values = self._values.copy()
         if extra_values:
             values.update(extra_values)
+
+        for alias, val in self.VALUES_ALIAS:
+            values[alias] = values[val]
         return values
 
     def expand(self, template, **extra_values):
@@ -772,10 +827,14 @@ class Change(object):
 
         return template % self.get_values(**extra_values)
 
-    def expand_lines(self, template, **extra_values):
+    def expand_lines(self, template, html_escape_val=False, **extra_values):
         """Break template into lines and expand each line."""
 
         values = self.get_values(**extra_values)
+        if html_escape_val:
+            for k in values:
+                if is_string(values[k]):
+                    values[k] = cgi.escape(values[k], True)
         for line in template.splitlines(True):
             yield line % values
 
@@ -787,9 +846,10 @@ class Change(object):
 
         values = self.get_values(**extra_values)
         if self._contains_html_diff:
-            values['contenttype'] = 'html'
+            self._content_type = 'html'
         else:
-            values['contenttype'] = 'plain'
+            self._content_type = 'plain'
+        values['contenttype'] = self._content_type
 
         for line in template.splitlines():
             (name, value) = line.split(': ', 1)
@@ -819,7 +879,11 @@ class Change(object):
 
         raise NotImplementedError()
 
-    def generate_email_intro(self):
+    def generate_browse_link(self, base_url):
+        """Generate a link to an online repository browser."""
+        return iter(())
+
+    def generate_email_intro(self, html_escape_val=False):
         """Generate the email intro for this Change, a line at a time.
 
         The output will be used as the standard boilerplate at the top
@@ -835,7 +899,7 @@ class Change(object):
 
         raise NotImplementedError()
 
-    def generate_email_footer(self):
+    def generate_email_footer(self, html_escape_val):
         """Generate the footer of the email, a line at a time.
 
         The footer is always included, irrespective of
@@ -876,9 +940,18 @@ class Change(object):
         for line in self.generate_email_header(**extra_header_values):
             yield line
         yield '\n'
-        for line in self._wrap_for_html(self.generate_email_intro()):
+        html_escape_val = (self.environment.html_in_intro and
+                           self._contains_html_diff)
+        intro = self.generate_email_intro(html_escape_val)
+        if not self.environment.html_in_intro:
+            intro = self._wrap_for_html(intro)
+        for line in intro:
             yield line
 
+        if self.environment.commitBrowseURL:
+            for line in self.generate_browse_link(self.environment.commitBrowseURL):
+                yield line
+
         body = self.generate_email_body(push)
         if body_filter is not None:
             body = body_filter(body)
@@ -939,8 +1012,12 @@ class Change(object):
             yield line
         if self._contains_html_diff:
             yield '</pre>'
-
-        for line in self._wrap_for_html(self.generate_email_footer()):
+        html_escape_val = (self.environment.html_in_footer and
+                           self._contains_html_diff)
+        footer = self.generate_email_footer(html_escape_val)
+        if not self.environment.html_in_footer:
+            footer = self._wrap_for_html(footer)
+        for line in footer:
             yield line
 
     def get_alt_fromaddr(self):
@@ -992,6 +1069,7 @@ class Revision(Change):
         values['rev_short'] = self.rev.short
         values['change_type'] = self.change_type
         values['refname'] = self.refname
+        values['newrev'] = self.rev.sha1
         values['short_refname'] = self.reference_change.short_refname
         values['refname_type'] = self.reference_change.refname_type
         values['reply_to_msgid'] = self.reference_change.msgid
@@ -1015,8 +1093,26 @@ class Revision(Change):
                 ):
             yield line
 
-    def generate_email_intro(self):
-        for line in self.expand_lines(REVISION_INTRO_TEMPLATE):
+    def generate_browse_link(self, base_url):
+        if '%(' not in base_url:
+            base_url += '%(id)s'
+        url = "".join(self.expand_lines(base_url))
+        if self._content_type == 'html':
+            for line in self.expand_lines(LINK_HTML_TEMPLATE,
+                                          html_escape_val=True,
+                                          browse_url=url):
+                yield line
+        elif self._content_type == 'plain':
+            for line in self.expand_lines(LINK_TEXT_TEMPLATE,
+                                          html_escape_val=False,
+                                          browse_url=url):
+                yield line
+        else:
+            raise NotImplementedError("Content-type %s unsupported. Please report it as a bug.")
+
+    def generate_email_intro(self, html_escape_val=False):
+        for line in self.expand_lines(REVISION_INTRO_TEMPLATE,
+                                      html_escape_val=html_escape_val):
             yield line
 
     def generate_email_body(self, push):
@@ -1031,8 +1127,9 @@ class Revision(Change):
             else:
                 yield line
 
-    def generate_email_footer(self):
-        return self.expand_lines(REVISION_FOOTER_TEMPLATE)
+    def generate_email_footer(self, html_escape_val):
+        return self.expand_lines(REVISION_FOOTER_TEMPLATE,
+                                 html_escape_val=html_escape_val)
 
     def generate_email(self, push, body_filter=None, extra_header_values={}):
         self._contains_diff()
@@ -1217,8 +1314,9 @@ class ReferenceChange(Change):
                 ):
             yield line
 
-    def generate_email_intro(self):
-        for line in self.expand_lines(self.intro_template):
+    def generate_email_intro(self, html_escape_val=False):
+        for line in self.expand_lines(self.intro_template,
+                                      html_escape_val=html_escape_val):
             yield line
 
     def generate_email_body(self, push):
@@ -1238,8 +1336,9 @@ class ReferenceChange(Change):
         for line in self.generate_revision_change_summary(push):
             yield line
 
-    def generate_email_footer(self):
-        return self.expand_lines(self.footer_template)
+    def generate_email_footer(self, html_escape_val):
+        return self.expand_lines(self.footer_template,
+                                 html_escape_val=html_escape_val)
 
     def generate_revision_change_graph(self, push):
         if self.showgraph:
@@ -1896,6 +1995,7 @@ class SMTPMailer(Mailer):
                  smtpservertimeout=10.0, smtpserverdebuglevel=0,
                  smtpencryption='none',
                  smtpuser='', smtppass='',
+                 smtpcacerts=''
                  ):
         if not envelopesender:
             sys.stderr.write(
@@ -1915,6 +2015,7 @@ class SMTPMailer(Mailer):
         self.security = smtpencryption
         self.username = smtpuser
         self.password = smtppass
+        self.smtpcacerts = smtpcacerts
         try:
             def call(klass, server, timeout):
                 try:
@@ -1925,13 +2026,56 @@ class SMTPMailer(Mailer):
             if self.security == 'none':
                 self.smtp = call(smtplib.SMTP, self.smtpserver, timeout=self.smtpservertimeout)
             elif self.security == 'ssl':
+                if self.smtpcacerts:
+                    raise smtplib.SMTPException(
+                        "Checking certificate is not supported for ssl, prefer starttls"
+                        )
                 self.smtp = call(smtplib.SMTP_SSL, self.smtpserver, timeout=self.smtpservertimeout)
             elif self.security == 'tls':
+                if 'ssl' not in sys.modules:
+                    sys.stderr.write(
+                        '*** Your Python version does not have the ssl library installed\n'
+                        '*** smtpEncryption=tls is not available.\n'
+                        '*** Either upgrade Python to 2.6 or later\n'
+                        '    or use git_multimail.py version 1.2.\n')
                 if ':' not in self.smtpserver:
                     self.smtpserver += ':587'  # default port for TLS
                 self.smtp = call(smtplib.SMTP, self.smtpserver, timeout=self.smtpservertimeout)
+                # start: ehlo + starttls
+                # equivalent to
+                #     self.smtp.ehlo()
+                #     self.smtp.starttls()
+                # with acces to the ssl layer
                 self.smtp.ehlo()
-                self.smtp.starttls()
+                if not self.smtp.has_extn("starttls"):
+                    raise smtplib.SMTPException("STARTTLS extension not supported by server")
+                resp, reply = self.smtp.docmd("STARTTLS")
+                if resp != 220:
+                    raise smtplib.SMTPException("Wrong answer to the STARTTLS command")
+                if self.smtpcacerts:
+                    self.smtp.sock = ssl.wrap_socket(
+                        self.smtp.sock,
+                        ca_certs=self.smtpcacerts,
+                        cert_reqs=ssl.CERT_REQUIRED
+                        )
+                else:
+                    self.smtp.sock = ssl.wrap_socket(
+                        self.smtp.sock,
+                        cert_reqs=ssl.CERT_NONE
+                        )
+                    sys.stderr.write(
+                        '*** Warning, the server certificat is not verified (smtp) ***\n'
+                        '***          set the option smtpCACerts                   ***\n'
+                        )
+                if not hasattr(self.smtp.sock, "read"):
+                    # using httplib.FakeSocket with Python 2.5.x or earlier
+                    self.smtp.sock.read = self.smtp.sock.recv
+                self.smtp.file = smtplib.SSLFakeFile(self.smtp.sock)
+                self.smtp.helo_resp = None
+                self.smtp.ehlo_resp = None
+                self.smtp.esmtp_features = {}
+                self.smtp.does_esmtp = 0
+                # end:   ehlo + starttls
                 self.smtp.ehlo()
             else:
                 sys.stdout.write('*** Error: Control reached an invalid option. ***')
@@ -1951,6 +2095,7 @@ class SMTPMailer(Mailer):
     def __del__(self):
         if hasattr(self, 'smtp'):
             self.smtp.quit()
+            del self.smtp
 
     def send(self, lines, to_addrs):
         try:
@@ -1958,13 +2103,24 @@ class SMTPMailer(Mailer):
                 self.smtp.login(self.username, self.password)
             msg = ''.join(lines)
             # turn comma-separated list into Python list if needed.
-            if isinstance(to_addrs, basestring):
+            if is_string(to_addrs):
                 to_addrs = [email for (name, email) in getaddresses([to_addrs])]
             self.smtp.sendmail(self.envelopesender, to_addrs, msg)
-        except Exception:
+        except smtplib.SMTPResponseException:
             sys.stderr.write('*** Error sending email ***\n')
-            sys.stderr.write('*** %s\n' % sys.exc_info()[1])
-            self.smtp.quit()
+            err = sys.exc_info()[1]
+            sys.stderr.write('*** Error %d: %s\n' % (err.smtp_code,
+                                                     bytes_to_str(err.smtp_error)))
+            try:
+                smtp = self.smtp
+                # delete the field before quit() so that in case of
+                # error, self.smtp is deleted anyway.
+                del self.smtp
+                smtp.quit()
+            except:
+                sys.stderr.write('*** Error closing the SMTP connection ***\n')
+                sys.stderr.write('*** Exiting anyway ... ***\n')
+                sys.stderr.write('*** %s\n' % sys.exc_info()[1])
             sys.exit(1)
 
 
@@ -2097,6 +2253,14 @@ class Environment(object):
             If "html", generate commit emails in HTML instead of plain text
             used by default.
 
+        html_in_intro (bool)
+        html_in_footer (bool)
+
+            When generating HTML emails, the introduction (respectively,
+            the footer) will be HTML-escaped iff html_in_intro (respectively,
+            the footer) is true. When false, only the values used to expand
+            the template are escaped.
+
         refchange_showgraph (bool)
 
             True iff refchanges emails should include a detailed graph.
@@ -2160,6 +2324,9 @@ class Environment(object):
         self.osenv = osenv or os.environ
         self.announce_show_shortlog = False
         self.commit_email_format = "text"
+        self.html_in_intro = False
+        self.html_in_footer = False
+        self.commitBrowseURL = None
         self.maxcommitemails = 500
         self.diffopts = ['--stat', '--summary', '--find-copies-harder']
         self.graphopts = ['--oneline', '--decorate']
@@ -2236,7 +2403,7 @@ class Environment(object):
         The return value is always a new dictionary."""
 
         if self._values is None:
-            values = {}
+            values = {'': ''}  # %()s expands to the empty string.
 
             for key in self.COMPUTED_KEYS:
                 value = getattr(self, 'get_%s' % (key,))()
@@ -2375,6 +2542,16 @@ class ConfigOptionsEnvironmentMixin(ConfigEnvironmentMixin):
             else:
                 self.commit_email_format = commit_email_format
 
+        html_in_intro = config.get_bool('htmlInIntro')
+        if html_in_intro is not None:
+            self.html_in_intro = html_in_intro
+
+        html_in_footer = config.get_bool('htmlInFooter')
+        if html_in_footer is not None:
+            self.html_in_footer = html_in_footer
+
+        self.commitBrowseURL = config.get('commitBrowseURL')
+
         maxcommitemails = config.get('maxcommitemails')
         if maxcommitemails is not None:
             try:
@@ -2415,7 +2592,6 @@ class ConfigOptionsEnvironmentMixin(ConfigEnvironmentMixin):
                                  ['author'])
         self.__reply_to_commit = config.get('replyToCommit', default=reply_to)
 
-        from_addr = self.config.get('from')
         self.from_refchange = config.get('fromRefchange')
         self.forbid_field_values('fromRefchange',
                                  self.from_refchange,
@@ -3390,6 +3566,8 @@ def run_as_post_receive_hook(environment, mailer):
     if changes:
         push = Push(environment, changes)
         push.send_emails(mailer, body_filter=environment.filter_body)
+    if hasattr(mailer, '__del__'):
+        mailer.__del__()
 
 
 def run_as_update_hook(environment, mailer, refname, oldrev, newrev, force_send=False):
@@ -3406,6 +3584,8 @@ def run_as_update_hook(environment, mailer, refname, oldrev, newrev, force_send=
         ]
     push = Push(environment, changes, force_send)
     push.send_emails(mailer, body_filter=environment.filter_body)
+    if hasattr(mailer, '__del__'):
+        mailer.__del__()
 
 
 def choose_mailer(config, environment):
@@ -3418,6 +3598,7 @@ def choose_mailer(config, environment):
         smtpencryption = config.get('smtpencryption', default='none')
         smtpuser = config.get('smtpuser', default='')
         smtppass = config.get('smtppass', default='')
+        smtpcacerts = config.get('smtpcacerts', default='')
         mailer = SMTPMailer(
             envelopesender=(environment.get_sender() or environment.get_fromaddr()),
             smtpserver=smtpserver, smtpservertimeout=smtpservertimeout,
@@ -3425,6 +3606,7 @@ def choose_mailer(config, environment):
             smtpencryption=smtpencryption,
             smtpuser=smtpuser,
             smtppass=smtppass,
+            smtpcacerts=smtpcacerts
             )
     elif mailer == 'sendmail':
         command = config.get('sendmailcommand')
@@ -3691,17 +3873,7 @@ def main(args):
         return
 
     if options.c:
-        parameters = os.environ.get('GIT_CONFIG_PARAMETERS', '')
-        if parameters:
-            parameters += ' '
-        # git expects GIT_CONFIG_PARAMETERS to be of the form
-        #    "'name1=value1' 'name2=value2' 'name3=value3'"
-        # including everything inside the double quotes (but not the double
-        # quotes themselves).  Spacing is critical.  Also, if a value contains
-        # a literal single quote that quote must be represented using the
-        # four character sequence: '\''
-        parameters += ' '.join("'" + x.replace("'", "'\\''") + "'" for x in options.c)
-        os.environ['GIT_CONFIG_PARAMETERS'] = parameters
+        Config.add_config_parameters(options.c)
 
     config = Config('multimailhook')
 
diff --git a/contrib/hooks/multimail/post-receive.example b/contrib/hooks/multimail/post-receive.example
index 9975df7..1ea113d 100755
--- a/contrib/hooks/multimail/post-receive.example
+++ b/contrib/hooks/multimail/post-receive.example
@@ -55,6 +55,12 @@ import git_multimail
 # git-multimail:
 config = git_multimail.Config('multimailhook')
 
+# Set some Git configuration variables. Equivalent to passing var=val
+# to "git -c var=val" each time git is called, or to adding the
+# configuration in .git/config (must come before instanciating the
+# environment) :
+#git_multimail.Config.add_config_parameters('multimailhook.commitEmailFormat=html')
+#git_multimail.Config.add_config_parameters(('user.name=foo', 'user.email=foo@example.com'))
 
 # Select the type of environment:
 try:
-- 
2.8.1.339.g3ad15fd
