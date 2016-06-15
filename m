From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v13 11/11] Documentation: add documentation for 'git
 interpret-trailers'
Date: Sat, 16 Aug 2014 18:06:21 +0200
Message-ID: <20140816160622.18221.71416.chriscool@tuxfamily.org>
References: <20140816153440.18221.29179.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 16 18:54:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIhFa-0005wB-6E
	for gcvg-git-2@plane.gmane.org; Sat, 16 Aug 2014 18:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbaHPQyZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2014 12:54:25 -0400
Received: from gleek.ethostream.com ([66.195.129.15]:59022 "EHLO
	barracuda.ethostream.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbaHPQyY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2014 12:54:24 -0400
X-ASG-Debug-ID: 1408208000-016a7707b5114ebe0001-QuoKaX
Received: from relay.ethostream.com (www1.ethostream.com [66.195.129.11]) by barracuda.ethostream.com with ESMTP id N1Ks8UbpwpIsgQBg; Sat, 16 Aug 2014 11:53:20 -0500 (CDT)
X-Barracuda-Envelope-From: chriscool@tuxfamily.org
X-Barracuda-Apparent-Source-IP: 66.195.129.11
Received: from ethoserver.ezone.net (unknown [10.230.15.218])
	by relay.ethostream.com (Postfix) with ESMTPA id 7B7CF891183;
	Sat, 16 Aug 2014 11:37:49 -0500 (CDT)
Received: from [127.0.1.1] (unknown [10.0.7.4])
	by ethoserver.ezone.net (Postfix) with ESMTP id 9FCC0C549C5;
	Sat, 16 Aug 2014 11:11:15 -0500 (CDT)
X-ASG-Orig-Subj: [PATCH v13 11/11] Documentation: add documentation for 'git
 interpret-trailers'
X-git-sha1: 40f5a73778896cb558323173140221376b4aa50b 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140816153440.18221.29179.chriscool@tuxfamily.org>
X-Barracuda-Connect: www1.ethostream.com[66.195.129.11]
X-Barracuda-Start-Time: 1408208000
X-Barracuda-URL: http://66.195.129.15:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at ethostream.com
X-Barracuda-Spam-Score: 3.88
X-Barracuda-Spam-Status: No, SCORE=3.88 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=5.0 tests=BSF_RULE7568M, FH_DATE_PAST_20XX
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.138343
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	3.38 FH_DATE_PAST_20XX      The date is grossly in the future.
	0.50 BSF_RULE7568M          Custom Rule 7568M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255335>

While at it add git-interpret-trailers to "command-list.txt".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-interpret-trailers.txt | 308 +++++++++++++++++++++++++++++++
 command-list.txt                         |   1 +
 2 files changed, 309 insertions(+)
 create mode 100644 Documentation/git-interpret-trailers.txt

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
new file mode 100644
index 0000000..cf5b194
--- /dev/null
+++ b/Documentation/git-interpret-trailers.txt
@@ -0,0 +1,308 @@
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
+using `--trailer` will be appended after the existing trailers only if
+the last trailer has a different (<token>, <value>) pair (or if there
+is no existing trailer). The <token> and <value> parts will be trimmed
+to remove starting and trailing whitespace, and the resulting trimmed
+<token> and <value> will appear in the message like this:
+
+------------------------------------------------
+token: value
+------------------------------------------------
+
+This means that the trimmed <token> and <value> will be separated by
+`': '` (one colon followed by one space).
+
+By default the new trailer will appear at the end of all the existing
+trailers. If there is no existing trailer, the new trailer will appear
+after the commit message part of the ouput, and, if there is no line
+with only spaces at the end of the commit message part, one blank line
+will be added before the new trailer.
+
+The trailers are recognized in the input message using the following
+rules:
+
+* by default only lines that contains a ':' (colon) are considered
+  trailers,
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
+trailer.separators::
+	This option tells which characters are recognized as trailer
+	separators. By default only ':' is recognized as a trailer
+	separator, except that '=' is always accepted on the command
+	line for compatibility with other git commands.
++
+The first character given by this option will be the default character
+used when another separator is not specified in the config for this
+trailer.
++
+For example, if the value for this option is "%=$", then only lines
+using the format '<token><sep><value>' with <sep> containing '%', '='
+or '$' and then spaces will be considered trailers. And '%' will be
+the default separator used, so by default trailers will appear like:
+'<token>% <value>' (one percent sign and one space will appear between
+the token and the value).
+
+trailer.where::
+	This option tells where a new trailer will be added.
++
+This can be `end`, which is the default, `start`, `after` or `before`.
++
+If it is `end`, then each new trailer will appear at the end of the
+existing trailers.
++
+If it is `start`, then each new trailer will appear at the start,
+instead of the end, of the existing trailers.
++
+If it is `after`, then each new trailer will appear just after the
+last trailer with the same <token>.
++
+If it is `before`, then each new trailer will appear just before the
+last trailer with the same <token>.
+
+trailer.ifexists::
+	This option makes it possible to choose what action will be
+	performed when there is already at least one trailer with the
+	same <token> in the message.
++
+The valid values for this option are: `addIfDifferentNeighbor` (this
+is the default), `addIfDifferent`, `add`, `overwrite` or `doNothing`.
++
+With `addIfDifferentNeighbor`, a new trailer will be added only if no
+trailer with the same (<token>, <value>) pair is above or below the line
+where the new trailer will be added.
++
+With `addIfDifferent`, a new trailer will be added only if no trailer
+with the same (<token>, <value>) pair is already in the message.
++
+With `add`, a new trailer will be added, even if some trailers with
+the same (<token>, <value>) pair are already in the message.
++
+With `replace`, an existing trailer with the same <token> will be
+deleted and the new trailer will be added. The deleted trailer will be
+the closest one (with the same <token>) to the place where the new one
+will be added.
++
+With `doNothing`, nothing will be done; that is no new trailer will be
+added if there is already one with the same <token> in the message.
+
+trailer.ifmissing::
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
+trailer.<token>.key::
+	This `key` will be used instead of <token> in the trailer. At
+	the end of this key, a separator can appear and then some
+	space characters. By default the only valid separator is ':',
+	but this can be changed using the `trailer.separators` config
+	variable.
++
+If there is a separator, then the key will be used instead of both the
+<token> and the default separator when adding the trailer.
+
+trailer.<token>.where::
+	This option takes the same values as the 'trailer.where'
+	configuration variable and it overrides what is specified by
+	that option for trailers with the specified <token>.
+
+trailer.<token>.ifexist::
+	This option takes the same values as the 'trailer.ifexist'
+	configuration variable and it overrides what is specified by
+	that option for trailers with the specified <token>.
+
+trailer.<token>.ifmissing::
+	This option takes the same values as the 'trailer.ifmissing'
+	configuration variable and it overrides what is specified by
+	that option for trailers with the specified <token>.
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
+$ git config trailer.separators ":#"
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
+$ git config trailer.see.ifExists "replace"
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
+> #!/bin/sh
+> git interpret-trailers --trim-empty --trailer "git-version: \$(git describe)" "\$1" > "\$1.new"
+> mv "\$1.new" "\$1"
+> EOF
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
index a3ff0c9..f1eae08 100644
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
2.0.1.674.ga7f57b7
