From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v12 11/11] Documentation: add documentation for 'git
 interpret-trailers'
Date: Sun, 25 May 2014 07:32:22 +0200
Message-ID: <20140525053223.5329.28002.chriscool@tuxfamily.org>
References: <20140525051254.5329.66539.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 25 07:46:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WoRGJ-0004q9-Ux
	for gcvg-git-2@plane.gmane.org; Sun, 25 May 2014 07:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbaEYFqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2014 01:46:19 -0400
Received: from mail-3y.bbox.fr ([194.158.98.45]:51396 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750787AbaEYFqP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2014 01:46:15 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 0A44160;
	Sun, 25 May 2014 07:46:14 +0200 (CEST)
X-git-sha1: 104a5f2ae7be3086ebc36752585ca69586097a18 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140525051254.5329.66539.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250069>

While at it add git-interpret-trailers to "command-list.txt".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-interpret-trailers.txt | 264 +++++++++++++++++++++++++++++++
 command-list.txt                         |   1 +
 2 files changed, 265 insertions(+)
 create mode 100644 Documentation/git-interpret-trailers.txt

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
new file mode 100644
index 0000000..45f1ed4
--- /dev/null
+++ b/Documentation/git-interpret-trailers.txt
@@ -0,0 +1,264 @@
+git-interpret-trailers(1)
+=========================
+
+NAME
+----
+git-interpret-trailers - help add stuctured information into commit messages
+
+SYNOPSIS
+--------
+[verse]
+'git interpret-trailers' [--trim-empty] [(--trailer <token>[(=|:)<value>])...] [<file>...]
+
+DESCRIPTION
+-----------
+Help adding 'trailers' lines, that look similar to RFC 822 e-mail
+headers, at the end of the otherwise free-form part of a commit
+message.
+
+This command reads some patches or commit messages from either the
+<file> arguments or the standard input if no <file> is specified. Then
+this command applies the arguments passed using the `--trailer`
+option, if any, to the commit message part of each input file. The
+result is emitted on the standard output.
+
+Some configuration variables control the way the `--trailer` arguments
+are applied to each commit message and the way any existing trailer in
+the commit message is changed. They also make it possible to
+automatically add some trailers.
+
+By default, a '<token>=<value>' or '<token>:<value>' argument given
+using `--trailer` will be added only if no trailer with the same
+(<token>, <value>) pair is already in the message. The <token> and
+<value> parts will be trimmed to remove starting and trailing
+whitespace, and the resulting trimmed <token> and <value> will appear
+in the message like this:
+
+------------------------------------------------
+token: value
+------------------------------------------------
+
+This means that the trimmed <token> and <value> will be separated by
+`': '` (one colon followed by one space).
+
+By default, if there are already trailers with the same <token>, the
+new trailer will appear just after the last trailer with the same
+<token>. Otherwise it will appear at the end of the commit message
+part of the ouput.
+
+The trailers are recognized in the input message using the following
+rules:
+
+* only lines that contains a ':' (colon) are considered trailers,
+
+* the trailer lines must all be next to each other,
+
+* after them it's only possible to have some lines that contain only
+  spaces, and then a patch; the patch part is recognized using the
+  fact that its first line starts with '---' (three minus signs),
+
+* before them there must be at least one line with only spaces.
+
+Note that 'trailers' do not follow and are not intended to follow many
+rules for RFC 822 headers. For example they do not follow the line
+folding rules, the encoding rules and probably many other rules.
+
+OPTIONS
+-------
+--trim-empty::
+	If the <value> part of any trailer contains only whitespace,
+	the whole trailer will be removed from the resulting message.
+	This apply to existing trailers as well as new trailers.
+
+--trailer <token>[(=|:)<value>]::
+	Specify a (<token>, <value>) pair that should be applied as a
+	trailer to the input messages. See the description of this
+	command.
+
+CONFIGURATION VARIABLES
+-----------------------
+
+trailer.<token>.key::
+	This `key` will be used instead of <token> in the
+	trailer. After the last alphanumeric character, this variable
+	can contain some non alphanumeric characters, like for example
+	`'%'` (one percent sign), `' = '` (one space followed by one
+	equal sign and then one space), `' #'` (one space followed by
+	one number sign) or even just `' '` (one space), that will be
+	used to separate the <token> from the <value> in the
+	trailer. The default separator, `': '` (one colon followed by
+	one space), which is the usual standard, is added only if the
+	last character in `key` is alphanumeric, so watch out for
+	unwanted trailing spaces in this variable.
+
+trailer.<token>.where::
+	This can be either `after`, which is the default, or
+	`before`. If it is `before`, then a trailer with the specified
+	<token>, will appear before, instead of after, other trailers
+	with the same <token>, or otherwise at the beginning, instead
+	of at the end, of all the trailers.
+
+trailer.<token>.ifexist::
+	This option makes it possible to choose what action will be
+	performed when there is already at least one trailer with the
+	same <token> in the message.
++
+The valid values for this option are: `addIfDifferent` (this is the
+default), `addIfDifferentNeighbor`, `add`, `overwrite` or `doNothing`.
++
+With `addIfDifferent`, a new trailer will be added only if no trailer
+with the same (<token>, <value>) pair is already in the message.
++
+With `addIfDifferentNeighbor`, a new trailer will be added only if no
+trailer with the same (<token>, <value>) pair is above or below the line
+where the new trailer will be added.
++
+With `add`, a new trailer will be added, even if some trailers with
+the same (<token>, <value>) pair are already in the message.
++
+With `overwrite`, the new trailer will overwrite an existing trailer
+with the same <token>.
++
+With `doNothing`, nothing will be done; that is no new trailer will be
+added if there is already one with the same <token> in the message.
+
+trailer.<token>.ifmissing::
+	This option makes it possible to choose what action will be
+	performed when there is not yet any trailer with the same
+	<token> in the message.
++
+The valid values for this option are: `add` (this is the default) and
+`doNothing`.
++
+With `add`, a new trailer will be added.
++
+With `doNothing`, nothing will be done.
+
+trailer.<token>.command::
+	This option can be used to specify a shell command that will
+	be used to automatically add or modify a trailer with the
+	specified <token>.
++
+When this option is specified, the behavior is as if a special
+'<token>=<value>' argument were added at the end of the command line,
+where <value> is taken to be the standard output of the specified
+command with any leading and trailing whitespace trimmed off.
++
+If the command contains the `$ARG` string, this string will be
+replaced with the <value> part of an existing trailer with the same
+<token>, if any, before the command is launched.
+
+EXAMPLES
+--------
+
+* Configure a 'sign' trailer with a 'Signed-off-by' key, and then
+  add two of these trailers to a message:
++
+------------
+$ git config trailer.sign.key "Signed-off-by"
+$ cat msg.txt
+subject
+
+message
+$ cat msg.txt | git interpret-trailers --trailer 'sign: Alice <alice@example.com>' --trailer 'sign: Bob <bob@example.com>'
+subject
+
+message
+
+Signed-off-by: Alice <alice@example.com>
+Signed-off-by: Bob <bob@example.com>
+------------
+
+* Extract the last commit as a patch, and add a 'Cc' and a
+  'Reviewed-by' trailer to it:
++
+------------
+$ git format-patch -1
+0001-foo.patch
+$ git interpret-trailers --trailer 'Cc: Alice <alice@example.com>' --trailer 'Reviewed-by: Bob <bob@example.com>' 0001-foo.patch >0001-bar.patch
+------------
+
+* Configure a 'sign' trailer with a command to automatically add a
+  'Signed-off-by: ' with the author information only if there is no
+  'Signed-off-by: ' already, and show how it works:
++
+------------
+$ git config trailer.sign.key "Signed-off-by: "
+$ git config trailer.sign.ifmissing add
+$ git config trailer.sign.ifexists doNothing
+$ git config trailer.sign.command 'echo "$(git config user.name) <$(git config user.email)>"'
+$ git interpret-trailers <<EOF
+> EOF
+
+Signed-off-by: Bob <bob@example.com>
+$ git interpret-trailers <<EOF
+> Signed-off-by: Alice <alice@example.com>
+> EOF
+
+Signed-off-by: Alice <alice@example.com>
+------------
+
+* Configure a 'fix' trailer with a key that contains a '#' and no
+  space after this character, and show how it works:
++
+------------
+$ git config trailer.fix.key "Fix #"
+$ echo "subject" | git interpret-trailers --trailer fix=42
+subject
+
+Fix #42
+------------
+
+* Configure a 'see' trailer with a command to show the subject of a
+  commit that is related, and show how it works:
++
+------------
+$ git config trailer.see.key "See-also: "
+$ git config trailer.see.ifExists "overwrite"
+$ git config trailer.see.command "git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \$ARG"
+$ git interpret-trailers <<EOF
+> subject
+> 
+> message
+> 
+> see: HEAD~2
+> EOF
+subject
+
+message
+
+See-also: fe3187489d69c4 (subject of related commit)
+------------
+
+* Configure a commit template with some trailers with empty values,
+  then configure a commit-msg hook that uses 'git interpret-trailers'
+  to remove trailers with empty values and to add a 'git-version'
+  trailer:
++
+------------
+$ cat >commit_template.txt <<EOF
+> ***subject***
+> 
+> ***message***
+> 
+> Fixes: 
+> Cc: 
+> Reviewed-by: 
+> Signed-off-by: 
+> EOF
+$ git config commit.template commit_template.txt
+$ cat >.git/hooks/commit-msg <<EOF
+#!/bin/sh
+git interpret-trailers --trim-empty --trailer "git-version: \$(git describe)" "\$1" > "\$1.new"
+mv "\$1.new" "\$1"
+EOF
+$ chmod +x .git/hooks/commit-msg
+------------
+
+SEE ALSO
+--------
+linkgit:git-commit[1], linkgit:git-format-patch[1], linkgit:git-config[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/command-list.txt b/command-list.txt
index cf36c3d..d5e0bed 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -62,6 +62,7 @@ git-imap-send                           foreignscminterface
 git-index-pack                          plumbingmanipulators
 git-init                                mainporcelain common
 git-instaweb                            ancillaryinterrogators
+git-interpret-trailers                  purehelpers
 gitk                                    mainporcelain
 git-log                                 mainporcelain common
 git-ls-files                            plumbinginterrogators
-- 
1.9.rc0.17.g651113e
