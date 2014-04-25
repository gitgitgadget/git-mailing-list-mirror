From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v11 11/11] Documentation: add documentation for 'git
 interpret-trailers'
Date: Fri, 25 Apr 2014 21:07:02 +0200
Message-ID: <20140425190703.28550.28842.chriscool@tuxfamily.org>
References: <20140425185719.28550.27059.chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Fri Apr 25 21:11:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdlXP-0001K5-6k
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 21:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754670AbaDYTLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 15:11:45 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:43473 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932106AbaDYTHw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 15:07:52 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id BD27877;
	Fri, 25 Apr 2014 21:07:49 +0200 (CEST)
X-git-sha1: 5fa9a883033aa89ee9df36b6c41b913f261ee37e 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140425185719.28550.27059.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247101>

While at it add git-interpret-trailers to "command-list.txt".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-interpret-trailers.txt | 143 +++++++++++++++++++++++++++++++
 command-list.txt                         |   1 +
 2 files changed, 144 insertions(+)
 create mode 100644 Documentation/git-interpret-trailers.txt

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
new file mode 100644
index 0000000..450ec54
--- /dev/null
+++ b/Documentation/git-interpret-trailers.txt
@@ -0,0 +1,143 @@
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
+By default, if there are already trailers with the same <token>, the
+new trailer will appear just after the last trailer with the same
+<token>. Otherwise it will appear at the end of the message.
+
+The trailers are recognized in the input commit message using the
+following rules:
+
+* only lines that contains a ':' are considered trailers,
+* the trailer lines must all be next to each other,
+* after them it's only possible to have some lines that contain only spaces,
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
+	trailer. After the last alphanumeric character, it can contain
+	some non alphanumeric characters like ':', '=' or '#' that
+	will be used instead of ':' to separate the <token> from the
+	<value> in the trailer, though the default ':' is more
+	standard.
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
+SEE ALSO
+--------
+linkgit:git-commit[1]
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
1.9.1.636.g20d5f34
