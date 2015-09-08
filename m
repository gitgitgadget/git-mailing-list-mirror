From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC/PATCH] git-multimail version 1.2 Alpha 1
Date: Tue,  8 Sep 2015 14:27:23 +0200
Message-ID: <1441715243-8691-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Sep 08 14:27:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZI06-0000ES-IU
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 14:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754585AbbIHM1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2015 08:27:46 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42880 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754175AbbIHM1m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 08:27:42 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t88CRV8R006716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 8 Sep 2015 14:27:31 +0200
Received: from scolette (scolette.imag.fr [129.88.43.86])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t88CRWCG006967;
	Tue, 8 Sep 2015 14:27:32 +0200
Received: from moy by scolette with local (Exim 4.84)
	(envelope-from <moy@imag.fr>)
	id 1ZZHzo-0002bt-DX; Tue, 08 Sep 2015 14:27:32 +0200
X-Mailer: git-send-email 2.5.0.402.g8854c44
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 08 Sep 2015 14:27:31 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t88CRV8R006716
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1442320055.19195@UasNQC64C4VC17tTMEQi4w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277502>

The changes are described in CHANGES.

Contributions-by: Job Snijders <job@instituut.net>
Contributions-by: Richard Hansen <rhansen@rhansen.org>
Contributions-by: Elijah Newren <newren@gmail.com>
Contributions-by: Michael Haggerty <mhagger@alum.mit.edu>
Contributions-by: Paul Sokolovsky <paul.sokolovsky@linaro.org>
Contributions-by: Vadim Zeitlin <vadim@zeitlins.org>
Contributions-by: Edward d'Auvergne <edward@nmr-relax.com>
Contributions-by: Elijah Newren <newren@palantir.com>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
This patch is not meant to be merged in master, but it probably makes
sense to get it in pu to give it some exposure and allow people to
provide feedback before the final release.

I'm tagging this as "Alpha" because the UI may still change depending
on user feedback.

 contrib/hooks/multimail/CHANGES                 |  41 ++
 contrib/hooks/multimail/README                  | 255 ++++---
 contrib/hooks/multimail/README.Git              |   4 +-
 contrib/hooks/multimail/doc/gerrit.rst          |  56 ++
 contrib/hooks/multimail/doc/gitolite.rst        | 109 +++
 contrib/hooks/multimail/git_multimail.py        | 912 ++++++++++++++++++++----
 contrib/hooks/multimail/migrate-mailhook-config |   2 +-
 contrib/hooks/multimail/post-receive.example    |   8 +-
 8 files changed, 1163 insertions(+), 224 deletions(-)
 create mode 100644 contrib/hooks/multimail/doc/gerrit.rst
 create mode 100644 contrib/hooks/multimail/doc/gitolite.rst

diff --git a/contrib/hooks/multimail/CHANGES b/contrib/hooks/multimail/CHANGES
index 6bb1230..768f455 100644
--- a/contrib/hooks/multimail/CHANGES
+++ b/contrib/hooks/multimail/CHANGES
@@ -1,3 +1,44 @@
+Release 1.2.0 Alpha 1
+=====================
+
+This release has been well tested, but contains possibly controversial
+changes visible to the user. It is an alpha release in the sense that
+the user-interface may still change before the final release depending
+on the user feedback.
+
+* It is now possible to exclude some refs (e.g. exclude some branches
+  or tags). See refFilterDoSendRegex, refFilterDontSendRegex,
+  refFilterInclusionRegex and refFilterExclusionRegex.
+
+* New commitEmailFormat option which can be set to "html" to generate
+  simple colorized diffs using HTML for the commit emails.
+
+* git-multimail can now be ran as a Gerrit ref-updated hook, or from
+  Atlassian Stash.
+
+* The From: field is now more customizeable. It can be set
+  independently for refchange emails and commit emails (see
+  fromCommit, fromRefChange). The special values pusher and author can
+  be used in these configuration variable.
+
+* A new command-line option, --version, was added. The version is also
+  available in the X-Git-Multimail-Version header of sent emails.
+
+* Set X-Git-NotificationType header to differentiate the various types
+  of notifications. Current values are: diff, ref_changed_plus_diff,
+  ref_changed.
+
+* Preliminary support for Python 3. The testsuite passes with Python 3,
+  but it has not received as much testing as the Python 2 version yet.
+
+* Several encoding-related fixes. UTF-8 characters work in more
+  situations (but non-ascii characters in email address are still not
+  supported).
+
+* The testsuite and its documentation has been greatly improved.
+
+Plus all the bugfixes from version 1.1.1.
+
 Release 1.1.1 (bugfix-only release)
 ===================================
 
diff --git a/contrib/hooks/multimail/README b/contrib/hooks/multimail/README
index e552c90..619653f 100644
--- a/contrib/hooks/multimail/README
+++ b/contrib/hooks/multimail/README
@@ -1,5 +1,5 @@
-git-multimail Version 1.1.1
-===========================
+git-multimail (version 1.2 Alpha 1)
+===================================
 
 .. image:: https://travis-ci.org/git-multimail/git-multimail.svg?branch=master
     :target: https://travis-ci.org/git-multimail/git-multimail
@@ -53,11 +53,13 @@ By default, for each push received by the repository, git-multimail:
      + [git] 07/08: Merge branch 'mm/api-credentials-doc'
      + [git] 08/08: Git 1.7.11-rc2
 
-   Each commit appears in exactly one commit email, the first time
-   that it is pushed to the repository.  If a commit is later merged
-   into another branch, then a one-line summary of the commit is
-   included in the reference change email (as usual), but no
-   additional commit email is generated.
+   By default, each commit appears in exactly one commit email, the
+   first time that it is pushed to the repository.  If a commit is later
+   merged into another branch, then a one-line summary of the commit
+   is included in the reference change email (as usual), but no
+   additional commit email is generated. See
+   `multimailhook.refFilter(Inclusion|Exclusion|DoSend|DontSend)Regex`
+   below to configure which branches and tags are watched by the hook.
 
    By default, reference change emails have their "Reply-To" field set
    to the person who pushed the change, and commit emails have their
@@ -73,21 +75,8 @@ Requirements
 ------------
 
 * Python 2.x, version 2.4 or later.  No non-standard Python modules
-  are required.  git-multimail does *not* currently work with Python
-  3.x.
-
-  The example scripts invoke Python using the following shebang line
-  (following PEP 394 [1]_)::
-
-      #! /usr/bin/env python2
-
-  If your system's Python2 interpreter is not in your PATH or is not
-  called ``python2``, you can change the lines accordingly.  Or you can
-  invoke the Python interpreter explicitly, for example via a tiny
-  shell script like::
-
-      #! /bin/sh
-      /usr/local/bin/python /path/to/git_multimail.py "$@"
+  are required.  git-multimail has preliminary support for Python 3
+  (but it has been better tested with Python 2).
 
 * The ``git`` command must be in your PATH.  git-multimail is known to
   work with Git versions back to 1.7.1.  (Earlier versions have not
@@ -146,7 +135,9 @@ following ``git config`` settings:
 
 multimailhook.environment
 
-    This describes the general environment of the repository.
+    This describes the general environment of the repository. In most
+    cases, you do not need to specify a value for this variable:
+    `git-multimail` will autodetect which environment to use.
     Currently supported values:
 
     * generic
@@ -161,18 +152,54 @@ multimailhook.environment
       optionally read from gitolite.conf (see multimailhook.from).
 
       For more information about gitolite and git-multimail, read
-      doc/gitolite.rst
+      `<doc/gitolite.rst>`__
+
+    * stash
+
+      **Warning:** this mode was provided by a third-party contributor
+      and never tested by the git-multimail maintainers. It is
+      provided as-is and may or may not work for you.
 
-    If neither of these environments is suitable for your setup, then
-    you can implement a Python class that inherits from Environment
-    and instantiate it via a script that looks like the example
+      This value is automatically assumed when the stash-specific
+      flags (``--stash-user`` and ``--stash-repo``) are specified on
+      the command line. When this environment is active, the username
+      and repo come from these two command line flags, which must be
+      specified.
+
+    * gerrit
+
+      Environment to use when ``git-multimail`` is ran as a
+      ``ref-updated`` Gerrit hook.
+
+      This value is used when the gerrit-specific command line flags
+      (``--oldrev``, ``--newrev``, ``--refname``, ``--project``) for
+      gerrit's ref-updated hook are present. When this environment is
+      active, the username of the pusher is taken from the
+      ``--submitter`` argument if that command line option is passed,
+      otherwise 'Gerrit' is used. The repository name is taken from
+      the ``--project`` option on the command line, which must be passed.
+
+      For more information about gerrit and git-multimail, read
+      `<doc/gerrit.rst>`__
+
+    If none of these environments is suitable for your setup, then you
+    can implement a Python class that inherits from Environment and
+    instantiate it via a script that looks like the example
     post-receive script.
 
     The environment value can be specified on the command line using
-    the --environment option.  If it is not specified on the command
-    line or by multimailhook.environment, then it defaults to
-    ``gitolite`` if the environment contains variables $GL_USER and
-    $GL_REPO; otherwise ``generic``.
+    the ``--environment`` option. If it is not specified on the
+    command line or by ``multimailhook.environment``, the value is
+    guessed as follows:
+
+    * If stash-specific (respectively gerrit-specific) command flags
+      are present on the command-line, then ``stash`` (respectively
+      ``gerrit``) is used.
+
+    * If the environment variables $GL_USER and $GL_REPO are set, then
+      ``gitolite`` is used.
+
+    * If none of the above apply, then ``generic`` is used.
 
 multimailhook.repoName
 
@@ -196,8 +223,8 @@ multimailhook.refchangeList
     reference changes should be sent, as RFC 2822 email addresses
     separated by commas.  This configuration option can be
     multivalued.  The default is the value in
-    multimailhook.mailingList.  Set this value to the empty string to
-    prevent reference change emails from being sent even if
+    multimailhook.mailingList.  Set this value to "none" (or the empty
+    string) to prevent reference change emails from being sent even if
     multimailhook.mailingList is set.
 
 multimailhook.announceList
@@ -206,9 +233,9 @@ multimailhook.announceList
     tags should be sent, as RFC 2822 email addresses separated by
     commas.  This configuration option can be multivalued.  The
     default is the value in multimailhook.refchangeList or
-    multimailhook.mailingList.  Set this value to the empty string to
-    prevent annotated tag announcement emails from being sent even if
-    one of the other values is set.
+    multimailhook.mailingList.  Set this value to "none" (or the empty
+    string) to prevent annotated tag announcement emails from being sent
+    even if one of the other values is set.
 
 multimailhook.commitList
 
@@ -216,7 +243,7 @@ multimailhook.commitList
     commits should be sent, as RFC 2822 email addresses separated by
     commas.  This configuration option can be multivalued.  The
     default is the value in multimailhook.mailingList.  Set this value
-    to the empty string to prevent notification emails about
+    to "none" (or the empty string) to prevent notification emails about
     individual commits from being sent even if
     multimailhook.mailingList is set.
 
@@ -230,6 +257,20 @@ multimailhook.announceShortlog
     not so straightforward, then the shortlog might be confusing
     rather than useful.  Default is false.
 
+multimailhook.commitEmailFormat
+
+    The format of email messages for the individual commits, can be "text" or
+    "html". In the latter case, the emails will include diffs using colorized
+    HTML instead of plain text used by default. Note that this  currently the
+    ref change emails are always sent in plain text.
+
+    Note that when using "html", the formatting is done by parsing the
+    output of ``git log`` with ``-p``. When using
+    ``multimailhook.commitLogOpts`` to specify a ``--format`` for
+    ``git log``, one may get false positive (e.g. lines in the body of
+    the message starting with ``+++`` or ``---`` colored in red or
+    green).
+
 multimailhook.refchangeShowGraph
 
     If this option is set to true, then summary emails about reference
@@ -305,7 +346,7 @@ multimailhook.mailer
 
       * multimailhook.smtpEncryption
 
-        Set the security type. Allowed values: none, ssl.
+        Set the security type. Allowed values: none, ssl, tls.
         Default=none.
 
       * multimailhook.smtpServerDebugLevel
@@ -313,9 +354,26 @@ multimailhook.mailer
         Integer number. Set to greater than 0 to activate debugging.
 
 multimailhook.from
+multimailhook.fromCommit
+multimailhook.fromRefchange
+
+    If set, use this value in the From: field of generated emails.
+    ``fromCommit`` is used for commit emails, ``fromRefchange`` is
+    used for refchange emails, and ``from`` is used as fall-back in
+    all cases.
+
+    The value for these variables can be either:
+
+    - An email address, which will be used directly.
+
+    - The value ``pusher``, in which case the pusher's address (if
+      available) will be used.
+
+    - The value ``author`` (meaningful only for replyToCommit), in which
+      case the commit author's address will be used.
 
-    If set, use this value in the From: field of generated emails.  If
-    unset, the value of the From: header is determined as follows:
+    If config values are unset, the value of the From: header is
+    determined as follows:
 
     1. (gitolite environment only) Parse gitolite.conf, looking for a
        block of comments that looks like this::
@@ -425,6 +483,15 @@ multimailhook.commitLogOpts
     --stat -p --cc``.  Shell quoting is allowed; see
     multimailhook.logOpts for details.
 
+multimailhook.dateSubstitute
+
+    String to use as a substitute for ``Date:`` in the output of ``git
+    log`` while formatting commit messages. This is usefull to avoid
+    emitting a line that can be interpreted by mailers as the start of
+    a cited message (Zimbra webmail in particular). Defaults to
+    ``CommitDate: ``. Set to an empty string or ``none`` to deactivate
+    the behavior.
+
 multimailhook.emailDomain
 
     Domain name appended to the username of the person doing the push
@@ -440,21 +507,13 @@ multimailhook.replyToRefchange
     Addresses to use in the Reply-To: field for commit emails
     (replyToCommit) and refchange emails (replyToRefchange).
     multimailhook.replyTo is used as default when replyToCommit or
-    replyToRefchange is not set.  The value for these variables can be
-    either:
-
-    - An email address, which will be used directly.
-
-    - The value `pusher`, in which case the pusher's address (if
-      available) will be used.  This is the default for refchange
-      emails.
-
-    - The value `author` (meaningful only for replyToCommit), in which
-      case the commit author's address will be used.  This is the
-      default for commit emails.
+    replyToRefchange is not set. The shortcuts ``pusher`` and
+    ``author`` are allowed with the same semantics as for
+    ``multimailhook.from``. In addition, the value ``none`` can be
+    used to omit the ``Reply-To:`` field.
 
-    - The value `none`, in which case the Reply-To: field will be
-      omitted.
+    The default is ``pusher`` for refchange emails, and ``author`` for
+    commit emails.
 
 multimailhook.quiet
 
@@ -478,6 +537,63 @@ multimailhook.combineWhenSingleCommit
     single email.
     Default: true
 
+multimailhook.refFilterInclusionRegex
+multimailhook.refFilterExclusionRegex
+multimailhook.refFilterDoSendRegex
+multimailhook.refFilterDontSendRegex
+
+    **Warning:** these options are experimental. They should work, but
+    the user-interface is not stable yet (in particular, the option
+    names may change). If you want to participate in stabilizing the
+    feature, please contact the maintainers and/or send pull-requests.
+
+    Regular expressions that can be used to limit refs for which email
+    updates will be sent.  It is an error to specify both an inclusion
+    and an exclusion regex.  If a ``refFilterInclusionRegex`` is
+    specified, emails will only be sent for refs which match this
+    regex.  If a ``refFilterExclusionRegex`` regex is specified,
+    emails will be sent for all refs except those that match this
+    regex (or that match a predefined regex specific to the
+    environment, such as "^refs/notes" for most environments and
+    "^refs/notes|^refs/changes" for the gerrit environment).
+
+    The expressions are matched against the complete refname, and is
+    considered to match if any substring matches. For example, to
+    filter-out all tags, set ``refFilterExclusionRegex`` to
+    ``^refs/tags/`` (note the leading ``^`` but no trailing ``$``). If
+    you set ``refFilterExclusionRegex`` to ``master``, then any ref
+    containing ``master`` will be excluded (the ``master`` branch, but
+    also ``refs/tags/master`` or ``refs/heads/foo-master-bar``).
+
+    ``refFilterDoSendRegex`` and ``refFilterDontSendRegex`` are
+    analogous to ``refFilterInclusionRegex`` and
+    ``refFilterExclusionRegex`` with one difference: with
+    ``refFilterDoSendRegex`` and ``refFilterDontSendRegex``, commits
+    introduced by one excluded ref will not be considered as new when
+    they reach an included ref. Typically, if you add a branch ``foo``
+    to  ``refFilterDontSendRegex``, push commits to this branch, and
+    later merge branch ``foo`` into ``master``, then the notification
+    email for ``master`` will contain a commit email only for the
+    merge commit. If you include ``foo`` in
+    ``refFilterExclusionRegex``, then at the time of merge, you will
+    receive one commit email per commit in the branch.
+
+    These variables can be multi-valued, like::
+
+      [multimailhook]
+              refFilterExclusionRegex = ^refs/tags/
+              refFilterExclusionRegex = ^refs/heads/master$
+
+    You can also provide a whitespace-separated list like::
+
+      [multimailhook]
+              refFilterExclusionRegex = ^refs/tags/ ^refs/heads/master$
+
+    Both examples exclude tags and the master branch, and are
+    equivalent to::
+
+      [multimailhook]
+              refFilterExclusionRegex = ^refs/tags/|^refs/heads/master$
 
 Email filtering aids
 --------------------
@@ -547,35 +663,8 @@ consider sharing them with the community!
 Getting involved
 ----------------
 
-git-multimail is an open-source project, built by volunteers. We would
-welcome your help!
-
-The current maintainers are Michael Haggerty <mhagger@alum.mit.edu>
-and Matthieu Moy <matthieu.moy@grenoble-inp.fr>.
-
-Please note that although a copy of git-multimail is distributed in
-the "contrib" section of the main Git project, development takes place
-in a separate git-multimail repository on GitHub:
-
-    https://github.com/git-multimail/git-multimail
-
-Whenever enough changes to git-multimail have accumulated, a new
-code-drop of git-multimail will be submitted for inclusion in the Git
-project.
-
-We use the GitHub issue tracker to keep track of bugs and feature
-requests, and we use GitHub pull requests to exchange patches (though,
-if you prefer, you can send patches via the Git mailing list with CC
-to the maintainers). Please sign off your patches as per the Git
-project practice.
-
-General discussion of git-multimail can take place on the main Git
-mailing list,
-
-    git@vger.kernel.org
-
-Please CC emails regarding git-multimail to the maintainers so that we
-don't overlook them.
+Please, read `<CONTRIBUTING.rst>`__ for instructions on how to
+contribute to git-multimail.
 
 
 Footnotes
diff --git a/contrib/hooks/multimail/README.Git b/contrib/hooks/multimail/README.Git
index f5d59a8..2315c21 100644
--- a/contrib/hooks/multimail/README.Git
+++ b/contrib/hooks/multimail/README.Git
@@ -6,10 +6,10 @@ website:
     https://github.com/git-multimail/git-multimail
 
 The version in this directory was obtained from the upstream project
-on July 03 2015 and consists of the "git-multimail" subdirectory from
+on September 08 2015 and consists of the "git-multimail" subdirectory from
 revision
 
-    6d6c9eb62a054143322cfaecde3949189c065b46 refs/tags/1.1.1
+    5c6358a01711725856d5ce474c1dc120408cd5a0 refs/tags/1.2.a1
 
 Please see the README file in this directory for information about how
 to report bugs or contribute to git-multimail.
diff --git a/contrib/hooks/multimail/doc/gerrit.rst b/contrib/hooks/multimail/doc/gerrit.rst
new file mode 100644
index 0000000..8011d05
--- /dev/null
+++ b/contrib/hooks/multimail/doc/gerrit.rst
@@ -0,0 +1,56 @@
+Setting up git-multimail on Gerrit
+==================================
+
+Gerrit has its own email-sending system, but you may prefer using
+``git-multimail`` instead. It supports Gerrit natively as a Gerrit
+``ref-updated`` hook (Warning: `Gerrit hooks
+<https://gerrit-review.googlesource.com/Documentation/config-hooks.html>`__
+are distinct from Git hooks). Setting up ``git-multimail`` on a Gerrit
+installation can be done following the instructions below.
+
+The explanations show an easy way to set up ``git-multimail``,
+but leave ``git-multimail`` installed and unconfigured for a while. If
+you run Gerrit on a production server, it is advised that you
+execute the step "Set up the hook" last to avoid confusing your users
+in the meantime.
+
+Set up the hook
+---------------
+
+Create a directory ``$site_path/hooks/`` if it does not exist (if you
+don't know what ``$site_path`` is, run ``gerrit.sh status`` and look
+for a ``GERRIT_SITE`` line). Either copy ``git_multimail.py`` to
+``$site_path/hooks/ref-updated`` or create a wrapper script like
+this::
+
+  #! /bin/sh
+  exec /path/to/git_multimail.py "$@"
+
+In both cases, make sure the file is named exactly
+``$site_path/hooks/ref-updated`` and is executable.
+
+(Alternatively, you may configure the ``[hooks]`` section of
+gerrit.config)
+
+Configuration
+-------------
+
+Log on the gerrit server and edit ``$site_path/git/$project/config``
+to configure ``git-multimail``.
+
+Troubleshooting
+---------------
+
+Warning: this will disable ``git-multimail`` during the debug, and
+could confuse your users. Don't run on a production server.
+
+To debug configuration issues with ``git-multimail``, you can add the
+``--stdout`` option when calling ``git_multimail.py`` like this::
+
+  #!/bin/sh
+  exec /path/to/git-multimail/git-multimail/git_multimail.py \
+    --stdout "$@" >> /tmp/log.txt
+
+and try pushing from a test repository. You should see the source of
+the email that would have been sent in the output of ``git push`` in
+the file ``/tmp/log.txt``.
diff --git a/contrib/hooks/multimail/doc/gitolite.rst b/contrib/hooks/multimail/doc/gitolite.rst
new file mode 100644
index 0000000..00aedd9
--- /dev/null
+++ b/contrib/hooks/multimail/doc/gitolite.rst
@@ -0,0 +1,109 @@
+Setting up git-multimail on gitolite
+====================================
+
+``git-multimail`` supports gitolite 3 natively.
+The explanations below show an easy way to set up ``git-multimail``,
+but leave ``git-multimail`` installed and unconfigured for a while. If
+you run gitolite on a production server, it is advised that you
+execute the step "Set up the hook" last to avoid confusing your users
+in the meantime.
+
+Set up the hook
+---------------
+
+Log in as your gitolite user.
+
+Create a file ``.gitolite/hooks/common/post-receive`` on your gitolite
+account containing (adapt the path, obviously)::
+
+  #!/bin/sh
+  exec /path/to/git-multimail/git-multimail/git_multimail.py "$@"
+
+Make sure it's executable (``chmod +x``). Record the hook in
+gitolite::
+
+  gitolite setup
+
+Configuration
+-------------
+
+First, you have to allow the admin to set Git configuration variables.
+
+As gitolite user, edit the line containing ``GIT_CONFIG_KEYS`` in file
+``.gitolite.rc``, to make it look like::
+
+  GIT_CONFIG_KEYS                 =>  'multimailhook\..*',
+
+You can now log out and return to your normal user.
+
+In the ``gitolite-admin`` clone, edit the file ``conf/gitolite.conf``
+and add::
+
+  repo @all
+      # Not strictly needed as git_multimail.py will chose gitolite if
+      # $GL_USER is set.
+      config multimailhook.environment = gitolite
+      config multimailhook.mailingList = # Where emails should be sent
+      config multimailhook.from = # From address to use
+
+Obviously, you can customize all parameters on a per-repository basis by
+adding these ``config multimailhook.*`` lines in the section
+corresponding to a repository or set of repositories.
+
+To activate ``git-multimail`` on a per-repository basis, do not set
+``multimailhook.mailingList`` in the ``@all`` section and set it only
+for repositories for which you want ``git-multimail``.
+
+Alternatively, you can set up the ``From:`` field on a per-user basis
+by adding a ``BEGIN USER EMAILS``/``END USER EMAILS`` section (see
+``../README``).
+
+Specificities of Gitolite for Configuration
+-------------------------------------------
+
+Empty configuration variables
+.............................
+
+With gitolite, the syntax ``config multimailhook.commitList = ""``
+unsets the variable instead of setting it to an empty string (see
+`here
+<http://gitolite.com/gitolite/git-config.html#an-important-warning-about-deleting-a-config-line>`__).
+As a result, there is no way to set a variable to the empty string.
+In all most places where an empty value is required, git-multimail
+now allows to specify special ``"none"`` value (case-sensitive) to
+mean the same.
+
+Alternatively, one can use ``" "`` (a single space) instead of ``""``.
+In most cases (in particular ``multimailhook.*List`` variables), this
+will be equivalent to an empty string.
+
+If you have a use-case where ``"none"`` is not an acceptable value and
+you need ``" "`` or  ``""`` instead, please report it as a bug to
+git-multimail.
+
+Allowing Regular Expressions in Configuration
+.............................................
+
+gitolite has a mechanism to prevent unsafe configuration variable
+values, which prevent characters like ``|`` commonly used in regular
+expressions. If you do not need the safety feature of gitolite and
+need to use regular expressions in your configuration (e.g. for
+``multimailhook.refFilter*`` variables), set
+`UNSAFE_PATT
+<http://gitolite.com/gitolite/git-config.html#unsafe-patt>`__ to a
+less restrictive value.
+
+Troubleshooting
+---------------
+
+Warning: this will disable ``git-multimail`` during the debug, and
+could confuse your users. Don't run on a production server.
+
+To debug configuration issues with ``git-multimail``, you can add the
+``--stdout`` option when calling ``git_multimail.py`` like this::
+
+  #!/bin/sh
+  exec /path/to/git-multimail/git-multimail/git_multimail.py --stdout "$@"
+
+and try pushing from a test repository. You should see the source of
+the email that would have been sent in the output of ``git push``.
diff --git a/contrib/hooks/multimail/git_multimail.py b/contrib/hooks/multimail/git_multimail.py
index c06ce7a..9987099 100755
--- a/contrib/hooks/multimail/git_multimail.py
+++ b/contrib/hooks/multimail/git_multimail.py
@@ -1,4 +1,6 @@
-#! /usr/bin/env python2
+#! /usr/bin/env python
+
+__version__ = '1.2.a1'
 
 # Copyright (c) 2015 Matthieu Moy and others
 # Copyright (c) 2012-2014 Michael Haggerty and others
@@ -56,8 +58,54 @@ import shlex
 import optparse
 import smtplib
 import time
+import cgi
+
+PYTHON3 = sys.version_info >= (3, 0)
+
+if sys.version_info <= (2, 5):
+    def all(iterable):
+        for element in iterable:
+            if not element:
+                return False
+            return True
+
+
+def is_ascii(s):
+    return all(ord(c) < 128 and ord(c) > 0 for c in s)
+
+
+if PYTHON3:
+    def str_to_bytes(s):
+        return s.encode(ENCODING)
+
+    def bytes_to_str(s):
+        return s.decode(ENCODING)
+
+    unicode = str
+
+    def write_str(f, msg):
+        # Try outputing with the default encoding. If it fails,
+        # try UTF-8.
+        try:
+            f.buffer.write(msg.encode(sys.getdefaultencoding()))
+        except UnicodeEncodeError:
+            f.buffer.write(msg.encode(ENCODING))
+else:
+    def str_to_bytes(s):
+        return s
+
+    def bytes_to_str(s):
+        return s
+
+    def write_str(f, msg):
+        f.write(msg)
+
+    def next(it):
+        return it.next()
+
 
 try:
+    from email.charset import Charset
     from email.utils import make_msgid
     from email.utils import getaddresses
     from email.utils import formataddr
@@ -65,6 +113,7 @@ try:
     from email.header import Header
 except ImportError:
     # Prior to Python 2.5, the email module used different names:
+    from email.Charset import Charset
     from email.Utils import make_msgid
     from email.Utils import getaddresses
     from email.Utils import formataddr
@@ -109,7 +158,7 @@ Date: %(send_date)s
 To: %(recipients)s
 Subject: %(subject)s
 MIME-Version: 1.0
-Content-Type: text/plain; charset=%(charset)s
+Content-Type: text/%(contenttype)s; charset=%(charset)s
 Content-Transfer-Encoding: 8bit
 Message-ID: %(msgid)s
 From: %(fromaddr)s
@@ -120,6 +169,8 @@ X-Git-Refname: %(refname)s
 X-Git-Reftype: %(refname_type)s
 X-Git-Oldrev: %(oldrev)s
 X-Git-Newrev: %(newrev)s
+X-Git-NotificationType: ref_changed
+X-Git-Multimail-Version: %(multimail_version)s
 Auto-Submitted: auto-generated
 """
 
@@ -238,7 +289,7 @@ To: %(recipients)s
 Cc: %(cc_recipients)s
 Subject: %(emailprefix)s%(num)02d/%(tot)02d: %(oneline)s
 MIME-Version: 1.0
-Content-Type: text/plain; charset=%(charset)s
+Content-Type: text/%(contenttype)s; charset=%(charset)s
 Content-Transfer-Encoding: 8bit
 From: %(fromaddr)s
 Reply-To: %(reply_to)s
@@ -249,6 +300,8 @@ X-Git-Repo: %(repo_shortname)s
 X-Git-Refname: %(refname)s
 X-Git-Reftype: %(refname_type)s
 X-Git-Rev: %(rev)s
+X-Git-NotificationType: diff
+X-Git-Multimail-Version: %(multimail_version)s
 Auto-Submitted: auto-generated
 """
 
@@ -270,7 +323,7 @@ Date: %(send_date)s
 To: %(recipients)s
 Subject: %(subject)s
 MIME-Version: 1.0
-Content-Type: text/plain; charset=%(charset)s
+Content-Type: text/%(contenttype)s; charset=%(charset)s
 Content-Transfer-Encoding: 8bit
 Message-ID: %(msgid)s
 From: %(fromaddr)s
@@ -282,6 +335,8 @@ X-Git-Reftype: %(refname_type)s
 X-Git-Oldrev: %(oldrev)s
 X-Git-Newrev: %(newrev)s
 X-Git-Rev: %(rev)s
+X-Git-NotificationType: ref_changed_plus_diff
+X-Git-Multimail-Version: %(multimail_version)s
 Auto-Submitted: auto-generated
 """
 
@@ -352,12 +407,14 @@ def read_git_output(args, input=None, keepends=False, **kw):
 def read_output(cmd, input=None, keepends=False, **kw):
     if input:
         stdin = subprocess.PIPE
+        input = str_to_bytes(input)
     else:
         stdin = None
     p = subprocess.Popen(
         cmd, stdin=stdin, stdout=subprocess.PIPE, stderr=subprocess.PIPE, **kw
         )
     (out, err) = p.communicate(input)
+    out = bytes_to_str(out)
     retcode = p.wait()
     if retcode:
         raise CommandError(cmd, retcode)
@@ -418,26 +475,37 @@ def git_log(spec, **kw):
 def header_encode(text, header_name=None):
     """Encode and line-wrap the value of an email header field."""
 
-    try:
-        if isinstance(text, str):
-            text = text.decode(ENCODING, 'replace')
-        return Header(text, header_name=header_name).encode()
-    except UnicodeEncodeError:
-        return Header(text, header_name=header_name, charset=CHARSET,
-                      errors='replace').encode()
+    # Convert to unicode, if required.
+    if not isinstance(text, unicode):
+        text = unicode(text, 'utf-8')
+
+    if is_ascii(text):
+        charset = 'ascii'
+    else:
+        charset = 'utf-8'
+
+    return Header(text, header_name=header_name, charset=Charset(charset)).encode()
 
 
 def addr_header_encode(text, header_name=None):
     """Encode and line-wrap the value of an email header field containing
     email addresses."""
 
-    return Header(
-        ', '.join(
-            formataddr((header_encode(name), emailaddr))
-            for name, emailaddr in getaddresses([text])
-            ),
-        header_name=header_name
-        ).encode()
+    # Convert to unicode, if required.
+    if not isinstance(text, unicode):
+        text = unicode(text, 'utf-8')
+
+    text = ', '.join(
+        formataddr((header_encode(name), emailaddr))
+        for name, emailaddr in getaddresses([text])
+        )
+
+    if is_ascii(text):
+        charset = 'ascii'
+    else:
+        charset = 'utf-8'
+
+    return Header(text, header_name=header_name, charset=Charset(charset)).encode()
 
 
 class Config(object):
@@ -496,7 +564,8 @@ class Config(object):
                 ['config', '--get-all', '--null', '%s.%s' % (self.section, name)],
                 env=self.env, keepends=True,
                 ))
-        except CommandError, e:
+        except CommandError:
+            t, e, traceback = sys.exc_info()
             if e.retcode == 1:
                 # "the section or key is invalid"; i.e., there is no
                 # value for the specified key.
@@ -504,18 +573,6 @@ class Config(object):
             else:
                 raise
 
-    def get_recipients(self, name, default=None):
-        """Read a recipients list from the configuration.
-
-        Return the result as a comma-separated list of email
-        addresses, or default if the option is unset.  If the setting
-        has multiple values, concatenate them with comma separators."""
-
-        lines = self.get_all(name, default=None)
-        if lines is None:
-            return default
-        return ', '.join(line.strip() for line in lines)
-
     def set(self, name, value):
         read_git_output(
             ['config', '%s.%s' % (self.section, name), value],
@@ -542,7 +599,8 @@ class Config(object):
                 ['config', '--unset-all', '%s.%s' % (self.section, name)],
                 env=self.env,
                 )
-        except CommandError, e:
+        except CommandError:
+            t, e, traceback = sys.exc_info()
             if e.retcode == 5:
                 # The name doesn't exist, which is what we wanted anyway...
                 pass
@@ -636,7 +694,7 @@ class GitObject(object):
         if not self.sha1:
             raise ValueError('Empty commit has no summary')
 
-        return iter(generate_summaries('--no-walk', self.sha1)).next()
+        return next(iter(generate_summaries('--no-walk', self.sha1)))
 
     def __eq__(self, other):
         return isinstance(other, GitObject) and self.sha1 == other.sha1
@@ -647,6 +705,10 @@ class GitObject(object):
     def __nonzero__(self):
         return bool(self.sha1)
 
+    def __bool__(self):
+        """Python 2 backward compatibility"""
+        return self.__nonzero__()
+
     def __str__(self):
         return self.sha1 or ZEROS
 
@@ -661,6 +723,12 @@ class Change(object):
     def __init__(self, environment):
         self.environment = environment
         self._values = None
+        self._contains_html_diff = False
+
+    def _contains_diff(self):
+        # We do contain a diff, should it be rendered in HTML?
+        if self.environment.commit_email_format == "html":
+            self._contains_html_diff = True
 
     def _compute_values(self):
         """Return a dictionary {keyword: expansion} for this Change.
@@ -670,7 +738,12 @@ class Change(object):
         get_values().  The return value should always be a new
         dictionary."""
 
-        return self.environment.get_values()
+        values = self.environment.get_values()
+        fromaddr = self.environment.get_fromaddr(change=self)
+        if fromaddr is not None:
+            values['fromaddr'] = fromaddr
+        values['multimail_version'] = get_version()
+        return values
 
     def get_values(self, **extra_values):
         """Return a dictionary {keyword: expansion} for this Change.
@@ -713,12 +786,18 @@ class Change(object):
         skip lines that contain references to unknown variables."""
 
         values = self.get_values(**extra_values)
+        if self._contains_html_diff:
+            values['contenttype'] = 'html'
+        else:
+            values['contenttype'] = 'plain'
+
         for line in template.splitlines():
-            (name, value) = line.split(':', 1)
+            (name, value) = line.split(': ', 1)
 
             try:
                 value = value % values
-            except KeyError, e:
+            except KeyError:
+                t, e, traceback = sys.exc_info()
                 if DEBUG:
                     self.environment.log_warning(
                         'Warning: unknown variable %r in the following line; line skipped:\n'
@@ -764,6 +843,24 @@ class Change(object):
 
         raise NotImplementedError()
 
+    def _wrap_for_html(self, lines):
+        """Wrap the lines in HTML <pre> tag when using HTML format.
+
+        Escape special HTML characters and add <pre> and </pre> tags around
+        the given lines if we should be generating HTML as indicated by
+        self._contains_html_diff being set to true.
+        """
+        if self._contains_html_diff:
+            yield "<pre style='margin:0'>\n"
+
+            for line in lines:
+                yield cgi.escape(line)
+
+            yield '</pre>\n'
+        else:
+            for line in lines:
+                yield line
+
     def generate_email(self, push, body_filter=None, extra_header_values={}):
         """Generate an email describing this change.
 
@@ -779,18 +876,56 @@ class Change(object):
         for line in self.generate_email_header(**extra_header_values):
             yield line
         yield '\n'
-        for line in self.generate_email_intro():
+        for line in self._wrap_for_html(self.generate_email_intro()):
             yield line
 
         body = self.generate_email_body(push)
         if body_filter is not None:
             body = body_filter(body)
+
+        diff_started = False
         for line in body:
+            if self._contains_html_diff:
+                # This is very, very naive. It would be much better to really
+                # parse the diff, i.e. look at how many lines do we have in
+                # the hunk headers instead of blindly highlighting everything
+                # that looks like it might be part of a diff.
+                color = ''
+                if line.startswith('--- a/'):
+                    diff_started = True
+                    color = 'e0e0ff'
+                elif diff_started:
+                    if line.startswith('+++ '):
+                        color = 'e0e0ff'
+                    elif line.startswith('@@'):
+                        color = 'e0e0e0'
+                    elif line.startswith('+'):
+                        color = 'e0ffe0'
+                    if line.startswith('-'):
+                        color = 'ffe0e0'
+
+                # Chop the trailing LF, we don't want it inside <pre>.
+                line = cgi.escape(line[:-1])
+                if line:
+                    line = "<pre style='margin:0'>%s</pre>" % line
+                else:
+                    # Empty <pre> is just ignored, so represent blank lines
+                    # otherwise.
+                    line = '<br>'
+
+                if color:
+                    line = "<div style='background:#%s'>%s</div>\n" % (color, line)
+                else:
+                    line = line + '\n'
+
             yield line
 
-        for line in self.generate_email_footer():
+        for line in self._wrap_for_html(self.generate_email_footer()):
             yield line
 
+    def get_alt_fromaddr(self):
+        return None
+
 
 class Revision(Change):
     """A Change consisting of a single git commit."""
@@ -867,14 +1002,25 @@ class Revision(Change):
     def generate_email_body(self, push):
         """Show this revision."""
 
-        return read_git_lines(
-            ['log'] + self.environment.commitlogopts + ['-1', self.rev.sha1],
-            keepends=True,
-            )
+        for line in read_git_lines(
+                ['log'] + self.environment.commitlogopts + ['-1', self.rev.sha1],
+                keepends=True,
+                ):
+            if line.startswith('Date:   ') and self.environment.date_substitute:
+                yield self.environment.date_substitute + line[len('Date:   '):]
+            else:
+                yield line
 
     def generate_email_footer(self):
         return self.expand_lines(REVISION_FOOTER_TEMPLATE)
 
+    def generate_email(self, push, body_filter=None, extra_header_values={}):
+        self._contains_diff()
+        return Change.generate_email(self, push, body_filter, extra_header_values)
+
+    def get_alt_fromaddr(self):
+        return self.environment.from_commit
+
 
 class ReferenceChange(Change):
     """A Change to a Git reference.
@@ -1096,10 +1242,10 @@ class ReferenceChange(Change):
             yield '\n'
             yield 'Detailed log of new commits:\n\n'
             for line in read_git_lines(
-                    ['log', '--no-walk']
-                    + self.logopts
-                    + new_commits_list
-                    + ['--'],
+                    ['log', '--no-walk'] +
+                    self.logopts +
+                    new_commits_list +
+                    ['--'],
                     keepends=True,
                     ):
                 yield line
@@ -1253,9 +1399,9 @@ class ReferenceChange(Change):
             yield '\n'
             yield 'Summary of changes:\n'
             for line in read_git_lines(
-                    ['diff-tree']
-                    + self.diffopts
-                    + ['%s..%s' % (self.old.commit_sha1, self.new.commit_sha1,)],
+                    ['diff-tree'] +
+                    self.diffopts +
+                    ['%s..%s' % (self.old.commit_sha1, self.new.commit_sha1,)],
                     keepends=True,
                     ):
                 yield line
@@ -1316,6 +1462,9 @@ class ReferenceChange(Change):
             )
         yield '\n'
 
+    def get_alt_fromaddr(self):
+        return self.environment.from_refchange
+
 
 class BranchChange(ReferenceChange):
     refname_type = 'branch'
@@ -1397,9 +1546,9 @@ class BranchChange(ReferenceChange):
             # commit is a non-merge commit, though it may make sense to
             # combine if it is a merge as well.
             if not (
-                    len(new_commits) == 1
-                    and len(new_commits[0][1]) == 1
-                    and new_commits[0][0] in known_added_sha1s
+                    len(new_commits) == 1 and
+                    len(new_commits[0][1]) == 1 and
+                    new_commits[0][0] in known_added_sha1s
                     ):
                 return None
 
@@ -1432,6 +1581,7 @@ class BranchChange(ReferenceChange):
             values['subject'] = self.expand(COMBINED_REFCHANGE_REVISION_SUBJECT_TEMPLATE, **values)
 
         self._single_revision = revision
+        self._contains_diff()
         self.header_template = COMBINED_HEADER_TEMPLATE
         self.intro_template = COMBINED_INTRO_TEMPLATE
         self.footer_template = COMBINED_FOOTER_TEMPLATE
@@ -1690,17 +1840,18 @@ class SendMailer(Mailer):
     def send(self, lines, to_addrs):
         try:
             p = subprocess.Popen(self.command, stdin=subprocess.PIPE)
-        except OSError, e:
+        except OSError:
             sys.stderr.write(
-                '*** Cannot execute command: %s\n' % ' '.join(self.command)
-                + '*** %s\n' % str(e)
-                + '*** Try setting multimailhook.mailer to "smtp"\n'
+                '*** Cannot execute command: %s\n' % ' '.join(self.command) +
+                '*** %s\n' % sys.exc_info()[1] +
+                '*** Try setting multimailhook.mailer to "smtp"\n' +
                 '*** to send emails without using the sendmail command.\n'
                 )
             sys.exit(1)
         try:
+            lines = (str_to_bytes(line) for line in lines)
             p.stdin.writelines(lines)
-        except Exception, e:
+        except Exception:
             sys.stderr.write(
                 '*** Error while generating commit email\n'
                 '***  - mail sending aborted.\n'
@@ -1710,7 +1861,7 @@ class SendMailer(Mailer):
                 p.terminate()
             except AttributeError:
                 pass
-            raise e
+            raise
         else:
             p.stdin.close()
             retcode = p.wait()
@@ -1770,11 +1921,11 @@ class SMTPMailer(Mailer):
                     "*** Setting debug on for SMTP server connection (%s) ***\n"
                     % self.smtpserverdebuglevel)
                 self.smtp.set_debuglevel(self.smtpserverdebuglevel)
-        except Exception, e:
+        except Exception:
             sys.stderr.write(
                 '*** Error establishing SMTP connection to %s ***\n'
                 % self.smtpserver)
-            sys.stderr.write('*** %s\n' % str(e))
+            sys.stderr.write('*** %s\n' % sys.exc_info()[1])
             sys.exit(1)
 
     def __del__(self):
@@ -1784,16 +1935,15 @@ class SMTPMailer(Mailer):
     def send(self, lines, to_addrs):
         try:
             if self.username or self.password:
-                sys.stderr.write("*** Authenticating as %s ***\n" % self.username)
                 self.smtp.login(self.username, self.password)
             msg = ''.join(lines)
             # turn comma-separated list into Python list if needed.
             if isinstance(to_addrs, basestring):
                 to_addrs = [email for (name, email) in getaddresses([to_addrs])]
             self.smtp.sendmail(self.envelopesender, to_addrs, msg)
-        except Exception, e:
+        except Exception:
             sys.stderr.write('*** Error sending email ***\n')
-            sys.stderr.write('*** %s\n' % str(e))
+            sys.stderr.write('*** %s\n' % sys.exc_info()[1])
             self.smtp.quit()
             sys.exit(1)
 
@@ -1809,9 +1959,10 @@ class OutputMailer(Mailer):
         self.f = f
 
     def send(self, lines, to_addrs):
-        self.f.write(self.SEPARATOR)
-        self.f.writelines(lines)
-        self.f.write(self.SEPARATOR)
+        write_str(self.f, self.SEPARATOR)
+        for line in lines:
+            write_str(self.f, line)
+        write_str(self.f, self.SEPARATOR)
 
 
 def get_git_dir():
@@ -1877,11 +2028,13 @@ class Environment(object):
             Return the address to be used as the 'From' email address
             in the email envelope.
 
-        get_fromaddr()
+        get_fromaddr(change=None)
 
             Return the 'From' email address used in the email 'From:'
-            headers.  (May be a full RFC 2822 email address like 'Joe
-            User <user@example.com>'.)
+            headers.  If the change is known when this function is
+            called, it is passed in as the 'change' parameter.  (May
+            be a full RFC 2822 email address like 'Joe User
+            <user@example.com>'.)
 
         get_administrator()
 
@@ -1901,12 +2054,29 @@ class Environment(object):
             get_reply_to_commit() is used for individual commit
             emails.
 
+        get_ref_filter_regex()
+
+            Return a tuple -- a compiled regex, and a boolean indicating
+            whether the regex picks refs to include (if False, the regex
+            matches on refs to exclude).
+
+        get_default_ref_ignore_regex()
+
+            Return a regex that should be ignored for both what emails
+            to send and when computing what commits are considered new
+            to the repository.  Default is "^refs/notes/".
+
     They should also define the following attributes:
 
         announce_show_shortlog (bool)
 
             True iff announce emails should include a shortlog.
 
+        commit_email_format (string)
+
+            If "html", generate commit emails in HTML instead of plain text
+            used by default.
+
         refchange_showgraph (bool)
 
             True iff refchanges emails should include a detailed graph.
@@ -1939,6 +2109,11 @@ class Environment(object):
             commit mail.  The value should be a list of strings
             representing words to be passed to the command.
 
+        date_substitute (string)
+
+            String to be used in substitution for 'Date:' at start of
+            line in the output of 'git log'.
+
         quiet (bool)
             On success do not write to stderr
 
@@ -1950,6 +2125,13 @@ class Environment(object):
             True if a combined email should be produced when a single
             new commit is pushed to a branch, False otherwise.
 
+        from_refchange, from_commit (strings)
+
+            Addresses to use for the From: field for refchange emails
+            and commit emails respectively.  Set from
+            multimailhook.fromRefchange and multimailhook.fromCommit
+            by ConfigEnvironmentMixin.
+
     """
 
     REPO_NAME_RE = re.compile(r'^(?P<name>.+?)(?:\.git)$')
@@ -1957,6 +2139,7 @@ class Environment(object):
     def __init__(self, osenv=None):
         self.osenv = osenv or os.environ
         self.announce_show_shortlog = False
+        self.commit_email_format = "text"
         self.maxcommitemails = 500
         self.diffopts = ['--stat', '--summary', '--find-copies-harder']
         self.graphopts = ['--oneline', '--decorate']
@@ -1964,6 +2147,7 @@ class Environment(object):
         self.refchange_showgraph = False
         self.refchange_showlog = False
         self.commitlogopts = ['-C', '--stat', '-p', '--cc']
+        self.date_substitute = 'AuthorDate: '
         self.quiet = False
         self.stdout = False
         self.combine_when_single_commit = True
@@ -1972,7 +2156,6 @@ class Environment(object):
             'administrator',
             'charset',
             'emailprefix',
-            'fromaddr',
             'pusher',
             'pusher_email',
             'repo_path',
@@ -1998,7 +2181,7 @@ class Environment(object):
     def get_pusher_email(self):
         return None
 
-    def get_fromaddr(self):
+    def get_fromaddr(self, change=None):
         config = Config('user')
         fromname = config.get('name', default='')
         fromemail = config.get('email', default='')
@@ -2080,6 +2263,15 @@ class Environment(object):
     def get_reply_to_commit(self, revision):
         return revision.author
 
+    def get_default_ref_ignore_regex(self):
+        # The commit messages of git notes are essentially meaningless
+        # and "filenames" in git notes commits are an implementational
+        # detail that might surprise users at first.  As such, we
+        # would need a completely different method for handling emails
+        # of git notes in order for them to be of benefit for users,
+        # which we simply do not have right now.
+        return "^refs/notes/"
+
     def filter_body(self, lines):
         """Filter the lines intended for an email body.
 
@@ -2095,19 +2287,19 @@ class Environment(object):
         """Write the string msg on a log file or on stderr.
 
         Sends the text to stderr by default, override to change the behavior."""
-        sys.stderr.write(msg)
+        write_str(sys.stderr, msg)
 
     def log_warning(self, msg):
         """Write the string msg on a log file or on stderr.
 
         Sends the text to stderr by default, override to change the behavior."""
-        sys.stderr.write(msg)
+        write_str(sys.stderr, msg)
 
     def log_error(self, msg):
         """Write the string msg on a log file or on stderr.
 
         Sends the text to stderr by default, override to change the behavior."""
-        sys.stderr.write(msg)
+        write_str(sys.stderr, msg)
 
 
 class ConfigEnvironmentMixin(Environment):
@@ -2128,6 +2320,14 @@ class ConfigEnvironmentMixin(Environment):
 class ConfigOptionsEnvironmentMixin(ConfigEnvironmentMixin):
     """An Environment that reads most of its information from "git config"."""
 
+    @staticmethod
+    def forbid_field_values(name, value, forbidden):
+        for forbidden_val in forbidden:
+            if value is not None and value.lower() == forbidden:
+                raise ConfigurationException(
+                    '"%s" is not an allowed setting for %s' % (value, name)
+                    )
+
     def __init__(self, config, **kw):
         super(ConfigOptionsEnvironmentMixin, self).__init__(
             config=config, **kw
@@ -2144,14 +2344,26 @@ class ConfigOptionsEnvironmentMixin(ConfigEnvironmentMixin):
             if val is not None:
                 setattr(self, var, val)
 
+        commit_email_format = config.get('commitEmailFormat')
+        if commit_email_format is not None:
+            if commit_email_format != "html" and commit_email_format != "text":
+                self.log_warning(
+                    '*** Unknown value for multimailhook.commitEmailFormat: %s\n' %
+                    commit_email_format +
+                    '*** Expected either "text" or "html".  Ignoring.\n'
+                    )
+            else:
+                self.commit_email_format = commit_email_format
+
         maxcommitemails = config.get('maxcommitemails')
         if maxcommitemails is not None:
             try:
                 self.maxcommitemails = int(maxcommitemails)
             except ValueError:
                 self.log_warning(
-                    '*** Malformed value for multimailhook.maxCommitEmails: %s\n' % maxcommitemails
-                    + '*** Expected a number.  Ignoring.\n'
+                    '*** Malformed value for multimailhook.maxCommitEmails: %s\n'
+                    % maxcommitemails +
+                    '*** Expected a number.  Ignoring.\n'
                     )
 
         diffopts = config.get('diffopts')
@@ -2170,32 +2382,44 @@ class ConfigOptionsEnvironmentMixin(ConfigEnvironmentMixin):
         if commitlogopts is not None:
             self.commitlogopts = shlex.split(commitlogopts)
 
+        date_substitute = config.get('dateSubstitute')
+        if date_substitute == 'none':
+            self.date_substitute = None
+        elif date_substitute is not None:
+            self.date_substitute = date_substitute
+
         reply_to = config.get('replyTo')
         self.__reply_to_refchange = config.get('replyToRefchange', default=reply_to)
-        if (
-                self.__reply_to_refchange is not None
-                and self.__reply_to_refchange.lower() == 'author'
-                ):
-            raise ConfigurationException(
-                '"author" is not an allowed setting for replyToRefchange'
-                )
+        self.forbid_field_values('replyToRefchange',
+                                 self.__reply_to_refchange,
+                                 ['author'])
         self.__reply_to_commit = config.get('replyToCommit', default=reply_to)
 
+        from_addr = self.config.get('from')
+        self.from_refchange = config.get('fromRefchange')
+        self.forbid_field_values('fromRefchange',
+                                 self.from_refchange,
+                                 ['author', 'none'])
+        self.from_commit = config.get('fromCommit')
+        self.forbid_field_values('fromCommit',
+                                 self.from_commit,
+                                 ['none'])
+
         combine = config.get_bool('combineWhenSingleCommit')
         if combine is not None:
             self.combine_when_single_commit = combine
 
     def get_administrator(self):
         return (
-            self.config.get('administrator')
-            or self.get_sender()
-            or super(ConfigOptionsEnvironmentMixin, self).get_administrator()
+            self.config.get('administrator') or
+            self.get_sender() or
+            super(ConfigOptionsEnvironmentMixin, self).get_administrator()
             )
 
     def get_repo_shortname(self):
         return (
-            self.config.get('reponame')
-            or super(ConfigOptionsEnvironmentMixin, self).get_repo_shortname()
+            self.config.get('reponame') or
+            super(ConfigOptionsEnvironmentMixin, self).get_repo_shortname()
             )
 
     def get_emailprefix(self):
@@ -2212,33 +2436,42 @@ class ConfigOptionsEnvironmentMixin(ConfigEnvironmentMixin):
     def get_sender(self):
         return self.config.get('envelopesender')
 
-    def get_fromaddr(self):
+    def process_addr(self, addr, change):
+        if addr.lower() == 'author':
+            if hasattr(change, 'author'):
+                return change.author
+            else:
+                return None
+        elif addr.lower() == 'pusher':
+            return self.get_pusher_email()
+        elif addr.lower() == 'none':
+            return None
+        else:
+            return addr
+
+    def get_fromaddr(self, change=None):
         fromaddr = self.config.get('from')
+        if change:
+            alt_fromaddr = change.get_alt_fromaddr()
+            if alt_fromaddr:
+                fromaddr = alt_fromaddr
+        if fromaddr:
+            fromaddr = self.process_addr(fromaddr, change)
         if fromaddr:
             return fromaddr
-        return super(ConfigOptionsEnvironmentMixin, self).get_fromaddr()
+        return super(ConfigOptionsEnvironmentMixin, self).get_fromaddr(change)
 
     def get_reply_to_refchange(self, refchange):
         if self.__reply_to_refchange is None:
             return super(ConfigOptionsEnvironmentMixin, self).get_reply_to_refchange(refchange)
-        elif self.__reply_to_refchange.lower() == 'pusher':
-            return self.get_pusher_email()
-        elif self.__reply_to_refchange.lower() == 'none':
-            return None
         else:
-            return self.__reply_to_refchange
+            return self.process_addr(self.__reply_to_refchange, refchange)
 
     def get_reply_to_commit(self, revision):
         if self.__reply_to_commit is None:
             return super(ConfigOptionsEnvironmentMixin, self).get_reply_to_commit(revision)
-        elif self.__reply_to_commit.lower() == 'author':
-            return revision.author
-        elif self.__reply_to_commit.lower() == 'pusher':
-            return self.get_pusher_email()
-        elif self.__reply_to_commit.lower() == 'none':
-            return None
         else:
-            return self.__reply_to_commit
+            return self.process_addr(self.__reply_to_commit, revision)
 
     def get_scancommitforcc(self):
         return self.config.get('scancommitforcc')
@@ -2270,12 +2503,14 @@ class FilterLinesEnvironmentMixin(Environment):
     def filter_body(self, lines):
         lines = super(FilterLinesEnvironmentMixin, self).filter_body(lines)
         if self.__strict_utf8:
-            lines = (line.decode(ENCODING, 'replace') for line in lines)
+            if not PYTHON3:
+                lines = (line.decode(ENCODING, 'replace') for line in lines)
             # Limit the line length in Unicode-space to avoid
             # splitting characters:
             if self.__emailmaxlinelength:
                 lines = limit_linelength(lines, self.__emailmaxlinelength)
-            lines = (line.encode(ENCODING, 'replace') for line in lines)
+            if not PYTHON3:
+                lines = (line.encode(ENCODING, 'replace') for line in lines)
         elif self.__emailmaxlinelength:
             lines = limit_linelength(lines, self.__emailmaxlinelength)
 
@@ -2404,10 +2639,10 @@ class StaticRecipientsEnvironmentMixin(Environment):
         # actual *contents* of the change being reported, we only
         # choose based on the *type* of the change.  Therefore we can
         # compute them once and for all:
-        if not (refchange_recipients
-                or announce_recipients
-                or revision_recipients
-                or scancommitforcc):
+        if not (refchange_recipients or
+                announce_recipients or
+                revision_recipients or
+                scancommitforcc):
             raise ConfigurationException('No email recipients configured!')
         self.__refchange_recipients = refchange_recipients
         self.__announce_recipients = announce_recipients
@@ -2457,13 +2692,104 @@ class ConfigRecipientsEnvironmentMixin(
         found, raise a ConfigurationException."""
 
         for name in names:
-            retval = config.get_recipients(name)
-            if retval is not None:
-                return retval
+            lines = config.get_all(name)
+            if lines is not None:
+                lines = [line.strip() for line in lines]
+                # Single "none" is a special value equivalen to empty string.
+                if lines == ['none']:
+                    lines = ['']
+                return ', '.join(lines)
         else:
             return ''
 
 
+class StaticRefFilterEnvironmentMixin(Environment):
+    """Set branch filter statically based on constructor parameters."""
+
+    def __init__(self, ref_filter_incl_regex, ref_filter_excl_regex,
+                 ref_filter_do_send_regex, ref_filter_dont_send_regex,
+                 **kw):
+        super(StaticRefFilterEnvironmentMixin, self).__init__(**kw)
+
+        if ref_filter_incl_regex and ref_filter_excl_regex:
+            raise ConfigurationException(
+                "Cannot specify both a ref inclusion and exclusion regex.")
+        self.__is_inclusion_filter = bool(ref_filter_incl_regex)
+        default_exclude = self.get_default_ref_ignore_regex()
+        if ref_filter_incl_regex:
+            ref_filter_regex = ref_filter_incl_regex
+        elif ref_filter_excl_regex:
+            ref_filter_regex = ref_filter_excl_regex + '|' + default_exclude
+        else:
+            ref_filter_regex = default_exclude
+        try:
+            self.__compiled_regex = re.compile(ref_filter_regex)
+        except Exception:
+            raise ConfigurationException(
+                'Invalid Ref Filter Regex "%s": %s' % (ref_filter_regex, sys.exc_info()[1]))
+
+        if ref_filter_do_send_regex and ref_filter_dont_send_regex:
+            raise ConfigurationException(
+                "Cannot specify both a ref doSend and dontSend regex.")
+        if ref_filter_do_send_regex or ref_filter_dont_send_regex:
+            self.__is_do_send_filter = bool(ref_filter_do_send_regex)
+            if ref_filter_incl_regex:
+                ref_filter_send_regex = ref_filter_incl_regex
+            elif ref_filter_excl_regex:
+                ref_filter_send_regex = ref_filter_excl_regex
+            else:
+                ref_filter_send_regex = '.*'
+                self.__is_do_send_filter = True
+            try:
+                self.__send_compiled_regex = re.compile(ref_filter_send_regex)
+            except Exception:
+                raise ConfigurationException(
+                    'Invalid Ref Filter Regex "%s": %s' %
+                    (ref_filter_send_regex, sys.exc_info()[1]))
+        else:
+            self.__send_compiled_regex = self.__compiled_regex
+            self.__is_do_send_filter = self.__is_inclusion_filter
+
+    def get_ref_filter_regex(self, send_filter=False):
+        if send_filter:
+            return self.__send_compiled_regex, self.__is_do_send_filter
+        else:
+            return self.__compiled_regex, self.__is_inclusion_filter
+
+
+class ConfigRefFilterEnvironmentMixin(
+        ConfigEnvironmentMixin,
+        StaticRefFilterEnvironmentMixin
+        ):
+    """Determine branch filtering statically based on config."""
+
+    def _get_regex(self, config, key):
+        """Get a list of whitespace-separated regex. The refFilter* config
+        variables are multivalued (hence the use of get_all), and we
+        allow each entry to be a whitespace-separated list (hence the
+        split on each line). The whole thing is glued into a single regex."""
+        values = config.get_all(key)
+        if values is None:
+            return values
+        items = []
+        for line in values:
+            for i in line.split():
+                items.append(i)
+        if items == []:
+            return None
+        return '|'.join(items)
+
+    def __init__(self, config, **kw):
+        super(ConfigRefFilterEnvironmentMixin, self).__init__(
+            config=config,
+            ref_filter_incl_regex=self._get_regex(config, 'refFilterInclusionRegex'),
+            ref_filter_excl_regex=self._get_regex(config, 'refFilterExclusionRegex'),
+            ref_filter_do_send_regex=self._get_regex(config, 'refFilterDoSendRegex'),
+            ref_filter_dont_send_regex=self._get_regex(config, 'refFilterDontSendRegex'),
+            **kw
+            )
+
+
 class ProjectdescEnvironmentMixin(Environment):
     """Make a "projectdesc" value available for templates.
 
@@ -2499,6 +2825,7 @@ class GenericEnvironment(
         ComputeFQDNEnvironmentMixin,
         ConfigFilterLinesEnvironmentMixin,
         ConfigRecipientsEnvironmentMixin,
+        ConfigRefFilterEnvironmentMixin,
         PusherDomainEnvironmentMixin,
         ConfigOptionsEnvironmentMixin,
         GenericEnvironmentMixin,
@@ -2513,14 +2840,14 @@ class GitoliteEnvironmentMixin(Environment):
         # repo_shortname (though it's probably not as good as a value
         # the user might have explicitly put in his config).
         return (
-            self.osenv.get('GL_REPO', None)
-            or super(GitoliteEnvironmentMixin, self).get_repo_shortname()
+            self.osenv.get('GL_REPO', None) or
+            super(GitoliteEnvironmentMixin, self).get_repo_shortname()
             )
 
     def get_pusher(self):
         return self.osenv.get('GL_USER', 'unknown user')
 
-    def get_fromaddr(self):
+    def get_fromaddr(self, change=None):
         GL_USER = self.osenv.get('GL_USER')
         if GL_USER is not None:
             # Find the path to gitolite.conf.  Note that gitolite v3
@@ -2557,7 +2884,7 @@ class GitoliteEnvironmentMixin(Environment):
                             return m.group(1)
                 finally:
                     f.close()
-        return super(GitoliteEnvironmentMixin, self).get_fromaddr()
+        return super(GitoliteEnvironmentMixin, self).get_fromaddr(change)
 
 
 class IncrementalDateTime(object):
@@ -2570,8 +2897,9 @@ class IncrementalDateTime(object):
 
     def __init__(self):
         self.time = time.time()
+        self.next = self.__next__  # Python 2 backward compatibility
 
-    def next(self):
+    def __next__(self):
         formatted = formatdate(self.time, True)
         self.time += 1
         return formatted
@@ -2583,6 +2911,7 @@ class GitoliteEnvironment(
         ComputeFQDNEnvironmentMixin,
         ConfigFilterLinesEnvironmentMixin,
         ConfigRecipientsEnvironmentMixin,
+        ConfigRefFilterEnvironmentMixin,
         PusherDomainEnvironmentMixin,
         ConfigOptionsEnvironmentMixin,
         GitoliteEnvironmentMixin,
@@ -2591,6 +2920,117 @@ class GitoliteEnvironment(
     pass
 
 
+class StashEnvironmentMixin(Environment):
+    def __init__(self, user=None, repo=None, **kw):
+        super(StashEnvironmentMixin, self).__init__(**kw)
+        self.__user = user
+        self.__repo = repo
+
+    def get_repo_shortname(self):
+        return self.__repo
+
+    def get_pusher(self):
+        return re.match('(.*?)\s*<', self.__user).group(1)
+
+    def get_pusher_email(self):
+        return self.__user
+
+    def get_fromaddr(self, change=None):
+        return self.__user
+
+
+class StashEnvironment(
+        StashEnvironmentMixin,
+        ProjectdescEnvironmentMixin,
+        ConfigMaxlinesEnvironmentMixin,
+        ComputeFQDNEnvironmentMixin,
+        ConfigFilterLinesEnvironmentMixin,
+        ConfigRecipientsEnvironmentMixin,
+        ConfigRefFilterEnvironmentMixin,
+        PusherDomainEnvironmentMixin,
+        ConfigOptionsEnvironmentMixin,
+        Environment,
+        ):
+    pass
+
+
+class GerritEnvironmentMixin(Environment):
+    def __init__(self, project=None, submitter=None, update_method=None, **kw):
+        super(GerritEnvironmentMixin, self).__init__(**kw)
+        self.__project = project
+        self.__submitter = submitter
+        self.__update_method = update_method
+        "Make an 'update_method' value available for templates."
+        self.COMPUTED_KEYS += ['update_method']
+
+    def get_repo_shortname(self):
+        return self.__project
+
+    def get_pusher(self):
+        if self.__submitter:
+            if self.__submitter.find('<') != -1:
+                # Submitter has a configured email, we transformed
+                # __submitter into an RFC 2822 string already.
+                return re.match('(.*?)\s*<', self.__submitter).group(1)
+            else:
+                # Submitter has no configured email, it's just his name.
+                return self.__submitter
+        else:
+            # If we arrive here, this means someone pushed "Submit" from
+            # the gerrit web UI for the CR (or used one of the programmatic
+            # APIs to do the same, such as gerrit review) and the
+            # merge/push was done by the Gerrit user.  It was technically
+            # triggered by someone else, but sadly we have no way of
+            # determining who that someone else is at this point.
+            return 'Gerrit'  # 'unknown user'?
+
+    def get_pusher_email(self):
+        if self.__submitter:
+            return self.__submitter
+        else:
+            return super(GerritEnvironmentMixin, self).get_pusher_email()
+
+    def get_fromaddr(self, change=None):
+        if self.__submitter and self.__submitter.find('<') != -1:
+            return self.__submitter
+        else:
+            return super(GerritEnvironmentMixin, self).get_fromaddr(change)
+
+    def get_default_ref_ignore_regex(self):
+        default = super(GerritEnvironmentMixin, self).get_default_ref_ignore_regex()
+        return default + '|^refs/changes/|^refs/cache-automerge/|^refs/meta/'
+
+    def get_revision_recipients(self, revision):
+        # Merge commits created by Gerrit when users hit "Submit this patchset"
+        # in the Web UI (or do equivalently with REST APIs or the gerrit review
+        # command) are not something users want to see an individual email for.
+        # Filter them out.
+        committer = read_git_output(['log', '--no-walk', '--format=%cN',
+                                     revision.rev.sha1])
+        if committer == 'Gerrit Code Review':
+            return []
+        else:
+            return super(GerritEnvironmentMixin, self).get_revision_recipients(revision)
+
+    def get_update_method(self):
+        return self.__update_method
+
+
+class GerritEnvironment(
+        GerritEnvironmentMixin,
+        ProjectdescEnvironmentMixin,
+        ConfigMaxlinesEnvironmentMixin,
+        ComputeFQDNEnvironmentMixin,
+        ConfigFilterLinesEnvironmentMixin,
+        ConfigRecipientsEnvironmentMixin,
+        ConfigRefFilterEnvironmentMixin,
+        PusherDomainEnvironmentMixin,
+        ConfigOptionsEnvironmentMixin,
+        Environment,
+        ):
+    pass
+
+
 class Push(object):
     """Represent an entire push (i.e., a group of ReferenceChanges).
 
@@ -2673,10 +3113,11 @@ class Push(object):
             ])
         )
 
-    def __init__(self, changes, ignore_other_refs=False):
+    def __init__(self, environment, changes, ignore_other_refs=False):
         self.changes = sorted(changes, key=self._sort_key)
         self.__other_ref_sha1s = None
         self.__cached_commits_spec = {}
+        self.environment = environment
 
         if ignore_other_refs:
             self.__other_ref_sha1s = set()
@@ -2703,10 +3144,14 @@ class Push(object):
                 '%(objectname) %(objecttype) %(refname)\n'
                 '%(*objectname) %(*objecttype) %(refname)'
                 )
+            ref_filter_regex, is_inclusion_filter = \
+                self.environment.get_ref_filter_regex()
             for line in read_git_lines(
                     ['for-each-ref', '--format=%s' % (fmt,)]):
                 (sha1, type, name) = line.split(' ', 2)
-                if sha1 and type == 'commit' and name not in updated_refs:
+                if (sha1 and type == 'commit' and
+                        name not in updated_refs and
+                        include_ref(name, ref_filter_regex, is_inclusion_filter)):
                     sha1s.add(sha1)
 
             self.__other_ref_sha1s = sha1s
@@ -2856,7 +3301,7 @@ class Push(object):
                 if not change.environment.quiet:
                     change.environment.log_msg(
                         'Sending notification emails to: %s\n' % (change.recipients,))
-                extra_values = {'send_date': send_date.next()}
+                extra_values = {'send_date': next(send_date)}
 
                 rev = change.send_single_combined_email(sha1s)
                 if rev:
@@ -2876,9 +3321,9 @@ class Push(object):
             max_emails = change.environment.maxcommitemails
             if max_emails and len(sha1s) > max_emails:
                 change.environment.log_warning(
-                    '*** Too many new commits (%d), not sending commit emails.\n' % len(sha1s)
-                    + '*** Try setting multimailhook.maxCommitEmails to a greater value\n'
-                    + '*** Currently, multimailhook.maxCommitEmails=%d\n' % max_emails
+                    '*** Too many new commits (%d), not sending commit emails.\n' % len(sha1s) +
+                    '*** Try setting multimailhook.maxCommitEmails to a greater value\n' +
+                    '*** Currently, multimailhook.maxCommitEmails=%d\n' % max_emails
                     )
                 return
 
@@ -2889,7 +3334,7 @@ class Push(object):
                     rev.recipients = rev.cc_recipients
                     rev.cc_recipients = None
                 if rev.recipients:
-                    extra_values = {'send_date': send_date.next()}
+                    extra_values = {'send_date': next(send_date)}
                     mailer.send(
                         rev.generate_email(self, body_filter, extra_values),
                         rev.recipients,
@@ -2904,18 +3349,33 @@ class Push(object):
                 )
 
 
+def include_ref(refname, ref_filter_regex, is_inclusion_filter):
+    does_match = bool(ref_filter_regex.search(refname))
+    if is_inclusion_filter:
+        return does_match
+    else:  # exclusion filter -- we include the ref if the regex doesn't match
+        return not does_match
+
+
 def run_as_post_receive_hook(environment, mailer):
+    ref_filter_regex, is_inclusion_filter = environment.get_ref_filter_regex(True)
     changes = []
     for line in sys.stdin:
         (oldrev, newrev, refname) = line.strip().split(' ', 2)
+        if not include_ref(refname, ref_filter_regex, is_inclusion_filter):
+            continue
         changes.append(
             ReferenceChange.create(environment, oldrev, newrev, refname)
             )
-    push = Push(changes)
-    push.send_emails(mailer, body_filter=environment.filter_body)
+    if changes:
+        push = Push(environment, changes)
+        push.send_emails(mailer, body_filter=environment.filter_body)
 
 
 def run_as_update_hook(environment, mailer, refname, oldrev, newrev, force_send=False):
+    ref_filter_regex, is_inclusion_filter = environment.get_ref_filter_regex(True)
+    if not include_ref(refname, ref_filter_regex, is_inclusion_filter):
+        return
     changes = [
         ReferenceChange.create(
             environment,
@@ -2924,7 +3384,7 @@ def run_as_update_hook(environment, mailer, refname, oldrev, newrev, force_send=
             refname,
             ),
         ]
-    push = Push(changes, force_send)
+    push = Push(environment, changes, force_send)
     push.send_emails(mailer, body_filter=environment.filter_body)
 
 
@@ -2953,8 +3413,8 @@ def choose_mailer(config, environment):
         mailer = SendMailer(command=command, envelopesender=environment.get_sender())
     else:
         environment.log_error(
-            'fatal: multimailhook.mailer is set to an incorrect value: "%s"\n' % mailer
-            + 'please use one of "smtp" or "sendmail".\n'
+            'fatal: multimailhook.mailer is set to an incorrect value: "%s"\n' % mailer +
+            'please use one of "smtp" or "sendmail".\n'
             )
         sys.exit(1)
     return mailer
@@ -2963,14 +3423,18 @@ def choose_mailer(config, environment):
 KNOWN_ENVIRONMENTS = {
     'generic': GenericEnvironmentMixin,
     'gitolite': GitoliteEnvironmentMixin,
+    'stash': StashEnvironmentMixin,
+    'gerrit': GerritEnvironmentMixin,
     }
 
 
-def choose_environment(config, osenv=None, env=None, recipients=None):
+def choose_environment(config, osenv=None, env=None, recipients=None,
+                       hook_info=None):
     if not osenv:
         osenv = os.environ
 
     environment_mixins = [
+        ConfigRefFilterEnvironmentMixin,
         ProjectdescEnvironmentMixin,
         ConfigMaxlinesEnvironmentMixin,
         ComputeFQDNEnvironmentMixin,
@@ -2992,7 +3456,15 @@ def choose_environment(config, osenv=None, env=None, recipients=None):
         else:
             env = 'generic'
 
-    environment_mixins.append(KNOWN_ENVIRONMENTS[env])
+    environment_mixins.insert(0, KNOWN_ENVIRONMENTS[env])
+
+    if env == 'stash':
+        environment_kw['user'] = hook_info['stash_user']
+        environment_kw['repo'] = hook_info['stash_repo']
+    elif env == 'gerrit':
+        environment_kw['project'] = hook_info['project']
+        environment_kw['submitter'] = hook_info['submitter']
+        environment_kw['update_method'] = hook_info['update_method']
 
     if recipients:
         environment_mixins.insert(0, StaticRecipientsEnvironmentMixin)
@@ -3011,6 +3483,116 @@ def choose_environment(config, osenv=None, env=None, recipients=None):
     return environment_klass(**environment_kw)
 
 
+def get_version():
+    oldcwd = os.getcwd()
+    try:
+        try:
+            os.chdir(os.path.dirname(os.path.realpath(__file__)))
+            git_version = read_git_output(['describe', '--tags', 'HEAD'])
+            if git_version == __version__:
+                return git_version
+            else:
+                return '%s (%s)' % (__version__, git_version)
+        except:
+            pass
+    finally:
+        os.chdir(oldcwd)
+    return __version__
+
+
+def compute_gerrit_options(options, args, required_gerrit_options):
+    if None in required_gerrit_options:
+        raise SystemExit("Error: Specify all of --oldrev, --newrev, --refname, "
+                         "and --project; or none of them.")
+
+    if options.environment not in (None, 'gerrit'):
+        raise SystemExit("Non-gerrit environments incompatible with --oldrev, "
+                         "--newrev, --refname, and --project")
+    options.environment = 'gerrit'
+
+    if args:
+        raise SystemExit("Error: Positional parameters not allowed with "
+                         "--oldrev, --newrev, and --refname.")
+
+    # Gerrit oddly omits 'refs/heads/' in the refname when calling
+    # ref-updated hook; put it back.
+    git_dir = get_git_dir()
+    if (not os.path.exists(os.path.join(git_dir, options.refname)) and
+        os.path.exists(os.path.join(git_dir, 'refs', 'heads',
+                                    options.refname))):
+        options.refname = 'refs/heads/' + options.refname
+
+    # Convert each string option unicode for Python3.
+    if PYTHON3:
+        opts = ['environment', 'recipients', 'oldrev', 'newrev', 'refname',
+                'project', 'submitter', 'stash-user', 'stash-repo']
+        for opt in opts:
+            if not hasattr(options, opt):
+                continue
+            obj = getattr(options, opt)
+            if obj:
+                enc = obj.encode('utf-8', 'surrogateescape')
+                dec = enc.decode('utf-8', 'replace')
+                setattr(options, opt, dec)
+
+    # New revisions can appear in a gerrit repository either due to someone
+    # pushing directly (in which case options.submitter will be set), or they
+    # can press "Submit this patchset" in the web UI for some CR (in which
+    # case options.submitter will not be set and gerrit will not have provided
+    # us the information about who pressed the button).
+    #
+    # Note for the nit-picky: I'm lumping in REST API calls and the ssh
+    # gerrit review command in with "Submit this patchset" button, since they
+    # have the same effect.
+    if options.submitter:
+        update_method = 'pushed'
+        # The submitter argument is almost an RFC 2822 email address; change it
+        # from 'User Name (email@domain)' to 'User Name <email@domain>' so it is
+        options.submitter = options.submitter.replace('(', '<').replace(')', '>')
+    else:
+        update_method = 'submitted'
+        # Gerrit knew who submitted this patchset, but threw that information
+        # away when it invoked this hook.  However, *IF* Gerrit created a
+        # merge to bring the patchset in (project 'Submit Type' is either
+        # "Always Merge", or is "Merge if Necessary" and happens to be
+        # necessary for this particular CR), then it will have the committer
+        # of that merge be 'Gerrit Code Review' and the author will be the
+        # person who requested the submission of the CR.  Since this is fairly
+        # likely for most gerrit installations (of a reasonable size), it's
+        # worth the extra effort to try to determine the actual submitter.
+        rev_info = read_git_lines(['log', '--no-walk', '--merges',
+                                   '--format=%cN%n%aN <%aE>', options.newrev])
+        if rev_info and rev_info[0] == 'Gerrit Code Review':
+            options.submitter = rev_info[1]
+
+    # We pass back refname, oldrev, newrev as args because then the
+    # gerrit ref-updated hook is much like the git update hook
+    return (options,
+            [options.refname, options.oldrev, options.newrev],
+            {'project': options.project, 'submitter': options.submitter,
+             'update_method': update_method})
+
+
+def check_hook_specific_args(options, args):
+    # First check for stash arguments
+    if (options.stash_user is None) != (options.stash_repo is None):
+        raise SystemExit("Error: Specify both of --stash-user and "
+                         "--stash-repo or neither.")
+    if options.stash_user:
+        options.environment = 'stash'
+        return options, args, {'stash_user': options.stash_user,
+                               'stash_repo': options.stash_repo}
+
+    # Finally, check for gerrit specific arguments
+    required_gerrit_options = (options.oldrev, options.newrev, options.refname,
+                               options.project)
+    if required_gerrit_options != (None,) * 4:
+        return compute_gerrit_options(options, args, required_gerrit_options)
+
+    # No special options in use, just return what we started with
+    return options, args, {}
+
+
 def main(args):
     parser = optparse.OptionParser(
         description=__doc__,
@@ -3019,7 +3601,7 @@ def main(args):
 
     parser.add_option(
         '--environment', '--env', action='store', type='choice',
-        choices=['generic', 'gitolite'], default=None,
+        choices=list(KNOWN_ENVIRONMENTS.keys()), default=None,
         help=(
             'Choose type of environment is in use.  Default is taken from '
             'multimailhook.environment if set; otherwise "generic".'
@@ -3048,8 +3630,58 @@ def main(args):
             'detection in this mode.'
             ),
         )
+    parser.add_option(
+        '-c', metavar="<name>=<value>", action='append',
+        help=(
+            'Pass a configuration parameter through to git.  The value given '
+            'will override values from configuration files.  See the -c option '
+            'of git(1) for more details.  (Only works with git >= 1.7.3)'
+            ),
+        )
+    parser.add_option(
+        '--version', '-v', action='store_true', default=False,
+        help=(
+            "Display git-multimail's version"
+            ),
+        )
+    # The following options permit this script to be run as a gerrit
+    # ref-updated hook.  See e.g.
+    # code.google.com/p/gerrit/source/browse/Documentation/config-hooks.txt
+    # We suppress help for these items, since these are specific to gerrit,
+    # and we don't want users directly using them any way other than how the
+    # gerrit ref-updated hook is called.
+    parser.add_option('--oldrev', action='store', help=optparse.SUPPRESS_HELP)
+    parser.add_option('--newrev', action='store', help=optparse.SUPPRESS_HELP)
+    parser.add_option('--refname', action='store', help=optparse.SUPPRESS_HELP)
+    parser.add_option('--project', action='store', help=optparse.SUPPRESS_HELP)
+    parser.add_option('--submitter', action='store', help=optparse.SUPPRESS_HELP)
+
+    # The following allow this to be run as a stash asynchronous post-receive
+    # hook (almost identical to a git post-receive hook but triggered also for
+    # merges of pull requests from the UI).  We suppress help for these items,
+    # since these are specific to stash.
+    parser.add_option('--stash-user', action='store', help=optparse.SUPPRESS_HELP)
+    parser.add_option('--stash-repo', action='store', help=optparse.SUPPRESS_HELP)
 
     (options, args) = parser.parse_args(args)
+    (options, args, hook_info) = check_hook_specific_args(options, args)
+
+    if options.version:
+        sys.stdout.write('git-multimail version ' + get_version() + '\n')
+        return
+
+    if options.c:
+        parameters = os.environ.get('GIT_CONFIG_PARAMETERS', '')
+        if parameters:
+            parameters += ' '
+        # git expects GIT_CONFIG_PARAMETERS to be of the form
+        #    "'name1=value1' 'name2=value2' 'name3=value3'"
+        # including everything inside the double quotes (but not the double
+        # quotes themselves).  Spacing is critical.  Also, if a value contains
+        # a literal single quote that quote must be represented using the
+        # four character sequence: '\''
+        parameters += ' '.join("'" + x.replace("'", "'\\''") + "'" for x in options.c)
+        os.environ['GIT_CONFIG_PARAMETERS'] = parameters
 
     config = Config('multimailhook')
 
@@ -3058,6 +3690,7 @@ def main(args):
             config, osenv=os.environ,
             env=options.environment,
             recipients=options.recipients,
+            hook_info=hook_info,
             )
 
         if options.show_env:
@@ -3080,9 +3713,20 @@ def main(args):
             run_as_update_hook(environment, mailer, refname, oldrev, newrev, options.force_send)
         else:
             run_as_post_receive_hook(environment, mailer)
-    except ConfigurationException, e:
-        sys.exit(str(e))
-
+    except ConfigurationException:
+        sys.exit(sys.exc_info()[1])
+    except Exception:
+        t, e, tb = sys.exc_info()
+        import traceback
+        sys.stdout.write('\n')
+        sys.stdout.write('Exception \'' + t.__name__ +
+                         '\' raised. Please report this as a bug to\n')
+        sys.stdout.write('https://github.com/git-multimail/git-multimail/issues\n')
+        sys.stdout.write('with the information below:\n\n')
+        sys.stdout.write('git-multimail version ' + get_version() + '\n')
+        sys.stdout.write('Python version ' + sys.version + '\n')
+        traceback.print_exc(file=sys.stdout)
+        sys.exit(1)
 
 if __name__ == '__main__':
     main(sys.argv[1:])
diff --git a/contrib/hooks/multimail/migrate-mailhook-config b/contrib/hooks/multimail/migrate-mailhook-config
index d0e9b39..992657b 100755
--- a/contrib/hooks/multimail/migrate-mailhook-config
+++ b/contrib/hooks/multimail/migrate-mailhook-config
@@ -1,4 +1,4 @@
-#! /usr/bin/env python2
+#! /usr/bin/env python
 
 """Migrate a post-receive-email configuration to be usable with git_multimail.py.
 
diff --git a/contrib/hooks/multimail/post-receive.example b/contrib/hooks/multimail/post-receive.example
index 43f7b6b..9975df7 100755
--- a/contrib/hooks/multimail/post-receive.example
+++ b/contrib/hooks/multimail/post-receive.example
@@ -1,4 +1,4 @@
-#! /usr/bin/env python2
+#! /usr/bin/env python
 
 """Example post-receive hook based on git-multimail.
 
@@ -42,7 +42,6 @@ import os
 
 import git_multimail
 
-
 # It is possible to modify the output templates here; e.g.:
 
 #git_multimail.FOOTER_TEMPLATE = """\
@@ -61,8 +60,9 @@ config = git_multimail.Config('multimailhook')
 try:
     environment = git_multimail.GenericEnvironment(config=config)
     #environment = git_multimail.GitoliteEnvironment(config=config)
-except git_multimail.ConfigurationException, e:
-    sys.exit(str(e))
+except git_multimail.ConfigurationException:
+    sys.stderr.write('*** %s\n' % sys.exc_info()[1])
+    sys.exit(1)
 
 
 # Choose the method of sending emails based on the git config:
-- 
2.5.0.402.g8854c44
