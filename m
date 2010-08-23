From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Work around em-dash handling in newer AsciiDoc
Date: Mon, 23 Aug 2010 14:20:25 -0700
Message-ID: <7vhbilyqjq.fsf_-_@alter.siamese.dyndns.org>
References: <AANLkTimMZGswhWXyDMaFa9N1ipzoBXT7RptHMq2TYhmv@mail.gmail.com>
 <7vmxsd1b2a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Nathan W. Panike" <nathan.panike@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 23 23:20:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OneRb-0003ba-PK
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 23:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069Ab0HWVUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 17:20:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37066 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948Ab0HWVUd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 17:20:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BC82D01F4;
	Mon, 23 Aug 2010 17:20:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X4VIEtIAMcaDd4ewuCWRq+Pddog=; b=Eu+Bj2
	xrfZI0epr74pHX6/jU3gOY96QrI6IHpP8c4S06kSGCA9G11aJh3MVmpD6nZAf0ZI
	V9t3B9v6+9GUH17ZIoEZuOj2wPfCobBXebreWhPi5GdJH5dUoyQ1QFnOEgQfXMnA
	bDuSud6fYGobu5byVmdI8gqYcEtjWAiR4kL8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nim/iN75CleoiDFQkI2WWVCsmH403IXR
	+/uPbMPHDMRYyINhJMb1H48WvguzNd5RBMP1Pq8JaC5LwoOeIRJVZG+zB4L1erla
	GuPx4LXAVYMhW4+Ff/GSWMASVMzqBB97rwmn9SfkF5bg72TDDWVYxpjklTlEaO5G
	ABQcMwY0n3Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6847FD01F3;
	Mon, 23 Aug 2010 17:20:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B157D01F2; Mon, 23 Aug
 2010 17:20:27 -0400 (EDT)
In-Reply-To: <7vmxsd1b2a.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 23 Aug 2010 10\:41\:17 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 41D60858-AEFC-11DF-8EE6-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154258>

Older versions of AsciiDoc used to literally pass double dashes when we
used them in our linkgit macros and manpage titles, but newer ones (the
issue was first reported with AsciiDoc 8.5.2) turn them into em dashes.

Define litdd (literal double-dash) custom attribute in asciidoc.conf to
work this around.  While we are at it, fix a few double-dashes (e.g. the
description of "project--devo--version" convention used by tla, among
other things) that used to be incorrectly written as em dashes in the body
text to also use this attribute.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

  * Only lightly tested on boxes with AsciiDoc 8.5.2 (that has this
  problem) and 8.2.7 (that doesn't---to make sure this does not regress
  the resulting output for the current documentation toolchain), by
  eyeballing the resulting HTML and manpage output.  Help testing by
  people with other AsciiDoc versions are welcome.

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 87a90f2..3267bae 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -18,6 +18,7 @@ startsb=&#91;
 endsb=&#93;
 tilde=&#126;
 backtick=&#96;
+litdd=&#45;&#45;
 
 ifdef::backend-docbook[]
 [linkgit-inlinemacro]
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index e22a62f..a008f7e 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -220,7 +220,7 @@ binary so line count cannot be shown) and there is no
 difference between indexed copy and the working tree
 version (if the working tree version were also different,
 'binary' would have been shown in place of 'nothing').  The
-other file, git-add--interactive.perl, has 403 lines added
+other file, git-add{litdd}interactive.perl, has 403 lines added
 and 35 lines deleted if you commit what is in the index, but
 working tree file has further modifications (one addition and
 one deletion).
diff --git a/Documentation/git-archimport.txt b/Documentation/git-archimport.txt
index 4d4325f..4f358c8 100644
--- a/Documentation/git-archimport.txt
+++ b/Documentation/git-archimport.txt
@@ -44,7 +44,7 @@ archives that it imports, it is also possible to specify git branch names
 manually.  To do so, write a git branch name after each <archive/branch>
 parameter, separated by a colon.  This way, you can shorten the Arch
 branch names and convert Arch jargon to git jargon, for example mapping a
-"PROJECT--devo--VERSION" branch to "master".
+"PROJECT{litdd}devo{litdd}VERSION" branch to "master".
 
 Associating multiple Arch branches to one git branch is possible; the
 result will make the most sense only if no commits are made to the first
@@ -85,8 +85,8 @@ OPTIONS
 -o::
 	Use this for compatibility with old-style branch names used by
 	earlier versions of 'git archimport'.  Old-style branch names
-	were category--branch, whereas new-style branch names are
-	archive,category--branch--version.  In both cases, names given
+	were category{litdd}branch, whereas new-style branch names are
+	archive,category{litdd}branch{litdd}version.  In both cases, names given
 	on the command-line will override the automatically-generated
 	ones.
 
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index f8df109..eccd0ff 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -55,9 +55,9 @@ other display programs (see below).
 +
 The web browser can be specified using the configuration variable
 'help.browser', or 'web.browser' if the former is not set. If none of
-these config variables is set, the 'git web--browse' helper script
+these config variables is set, the 'git web{litdd}browse' helper script
 (called by 'git help') will pick a suitable default. See
-linkgit:git-web--browse[1] for more information about this.
+linkgit:git-web{litdd}browse[1] for more information about this.
 
 CONFIGURATION VARIABLES
 -----------------------
@@ -80,7 +80,7 @@ help.browser, web.browser and browser.<tool>.path
 The 'help.browser', 'web.browser' and 'browser.<tool>.path' will also
 be checked if the 'web' format is chosen (either by command line
 option or configuration variable). See '-w|--web' in the OPTIONS
-section above and linkgit:git-web--browse[1].
+section above and linkgit:git-web{litdd}browse[1].
 
 man.viewer
 ~~~~~~~~~~
diff --git a/Documentation/git-instaweb.txt b/Documentation/git-instaweb.txt
index e70cea9..7477ce8 100644
--- a/Documentation/git-instaweb.txt
+++ b/Documentation/git-instaweb.txt
@@ -44,9 +44,9 @@ OPTIONS
 -b::
 --browser::
 	The web browser that should be used to view the gitweb
-	page. This will be passed to the 'git web--browse' helper
+	page. This will be passed to the 'git web{litdd}browse' helper
 	script along with the URL of the gitweb instance. See
-	linkgit:git-web--browse[1] for more information about this. If
+	linkgit:git-web{litdd}browse[1] for more information about this. If
 	the script fails, the URL will be printed to stdout.
 
 start::
@@ -82,7 +82,7 @@ You may specify configuration in your .git/config
 
 If the configuration variable 'instaweb.browser' is not set,
 'web.browser' will be used instead if it is defined. See
-linkgit:git-web--browse[1] for more information about this.
+linkgit:git-web{litdd}browse[1] for more information about this.
 
 Author
 ------
diff --git a/Documentation/git-mergetool--lib.txt b/Documentation/git-mergetool--lib.txt
index 78eb03f..d8df553 100644
--- a/Documentation/git-mergetool--lib.txt
+++ b/Documentation/git-mergetool--lib.txt
@@ -1,5 +1,5 @@
-git-mergetool--lib(1)
-=====================
+git-mergetool{litdd}lib(1)
+==========================
 
 NAME
 ----
@@ -16,11 +16,11 @@ This is not a command the end user would want to run.  Ever.
 This documentation is meant for people who are studying the
 Porcelain-ish scripts and/or are writing new ones.
 
-The 'git-mergetool--lib' scriptlet is designed to be sourced (using
+The 'git-mergetool{litdd}lib' scriptlet is designed to be sourced (using
 `.`) by other shell scripts to set up functions for working
 with git merge tools.
 
-Before sourcing 'git-mergetool--lib', your script must set `TOOL_MODE`
+Before sourcing 'git-mergetool{litdd}lib', your script must set `TOOL_MODE`
 to define the operation mode for the functions listed below.
 'diff' and 'merge' are valid values.
 
diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index 7572049..e1586c7 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -1,5 +1,5 @@
-git-web--browse(1)
-==================
+git-web{litdd}browse(1)
+=======================
 
 NAME
 ----
@@ -7,7 +7,7 @@ git-web--browse - git helper script to launch a web browser
 
 SYNOPSIS
 --------
-'git web--browse' [OPTIONS] URL/FILE ...
+'git web{litdd}browse' [OPTIONS] URL/FILE ...
 
 DESCRIPTION
 -----------
@@ -71,7 +71,7 @@ browser.<tool>.cmd
 When the browser, specified by options or configuration variables, is
 not among the supported ones, then the corresponding
 'browser.<tool>.cmd' configuration variable will be looked up. If this
-variable exists then 'git web--browse' will treat the specified tool
+variable exists then 'git web{litdd}browse' will treat the specified tool
 as a custom command and will use a shell eval to run the command with
 the URLs passed as arguments.
 
