From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 17/17] Documentation: add documentation for 'git
 interpret-trailers'
Date: Sun, 26 Jan 2014 18:00:10 +0100
Message-ID: <20140126170011.24291.26146.chriscool@tuxfamily.org>
References: <20140126165018.24291.47716.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 26 18:24:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7TRa-0004RL-P5
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jan 2014 18:24:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147AbaAZRYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 12:24:18 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:65177 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753066AbaAZRYF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jan 2014 12:24:05 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 9544473;
	Sun, 26 Jan 2014 18:24:04 +0100 (CET)
X-git-sha1: e0bbb064d4b6fef78782db99e6835b6a9b0e1657 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140126165018.24291.47716.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241100>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-interpret-trailers.txt | 137 +++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)
 create mode 100644 Documentation/git-interpret-trailers.txt

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
new file mode 100644
index 0000000..f74843e
--- /dev/null
+++ b/Documentation/git-interpret-trailers.txt
@@ -0,0 +1,137 @@
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
+'git interpret-trailers' [--trim-empty] [--infile=file] [<token[=value]>...]
+
+DESCRIPTION
+-----------
+Help add RFC 822 like headers, called 'trailers', at the end of the
+otherwise free-form part of a commit message.
+
+Unless `--infile=file` is used, this command is a filter. It reads the
+standard input for a commit message and apply the `token` arguments,
+if any, to this message. The resulting message is emited on the
+standard output.
+
+Some configuration variables control the way the `token` arguments are
+applied to the message and the way any existing trailer in the message
+is changed. They also make it possible to automatically add some
+trailers.
+
+By default, a 'token=value' or 'token:value' argument will be added
+only if no trailer with the same (token, value) pair is already in the
+message. The 'token' and 'value' parts will be trimmed to remove
+starting and trailing white spaces, and the resulting trimmed 'token'
+and 'value' will appear in the message like this:
+
+------------------------------------------------
+token: value
+------------------------------------------------
+
+By default, if there are already trailers with the same 'token' the
+trailer will appear just after the last trailer with the same
+'token'. Otherwise it will appear at the end of the message.
+
+Note that 'trailers' do not follow and are not intended to follow many
+rules that are in RFC 822. For example they do not follow the line
+breaking rules, the encoding rules and probably many other rules.
+
+Trailers have become a de facto standard way to add helpful structured
+information into commit messages. For example the well known
+"Signed-off-by: " trailer is used by many projects like the Linux
+kernel and Git.
+
+OPTIONS
+-------
+--trim-empty::
+	If the 'value' part of any trailer contains onlywhite spaces,
+	the whole trailer will be removed from the resulting message.
+
+----infile=file::
+	Read the commit message from `file` instead of the standard
+	input.
+
+CONFIGURATION VARIABLES
+-----------------------
+
+trailer.<token>.key::
+	This 'key' will be used instead of 'token' in the
+	trailer. After some alphanumeric characters, it can contain
+	some non alphanumeric characters like ':', '=' or '#' that will
+	be used instead of ':' to separate the token from the value in
+	the trailer, though the default ':' is more standard.
+
+trailer.<token>.where::
+	This can be either `after`, which is the default, or
+	`before`. If it is `before`, then a trailer with the specified
+	token, will appear before, instead of after, other trailers
+	with the same token, or otherwise at the beginning, instead of
+	at the end, of all the trailers.
+
+trailer.<token>.ifexist::
+	This option makes it possible to chose what action will be
+	performed when there is already at least one trailer with the
+	same token in the message.
++
+The valid values for this option are: `addIfDifferent` (this is the
+default), `addIfDifferentNeighbor`, `add`, `overwrite` or `doNothing`.
++
+With `addIfDifferent`, a new trailer will be added only if no trailer
+with the same (token, value) pair is already in the message.
++
+With `addIfDifferentNeighbor`, a new trailer will be added only if no
+trailer with the same (token, value) pair is above or below the line
+where the new trailer will be added.
++
+With `add`, a new trailer will be added, even if some trailers with
+the same (token, value) pair are already in the message.
++
+With `overwrite`, the new trailer will overwrite an existing trailer
+with the same token.
++
+With `doNothing`, nothing will be done, that is no new trailer will be
+added if there is already one with the same token in the message.
+
+trailer.<token>.ifmissing::
+	This option makes it possible to chose what action will be
+	performed when there is not yet any trailer with the same
+	token in the message.
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
+	specified 'token'.
++
+When this option is specified, it is like if a special 'token=value'
+argument is added at the end of the command line, where 'value' will
+be given by the standard output of the specified command.
++
+If the command contains the `$ARG` string, this string will be
+replaced with the 'value' part of an existing trailer with the same
+token, if any, before the command is launched.
++
+The following environment variables are set when the command is run:
+GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, GIT_COMMITTER_NAME,
+GIT_COMMITTER_EMAIL.
+
+SEE ALSO
+--------
+linkgit:git-commit[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
-- 
1.8.5.2.201.gacc5987
