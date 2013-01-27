From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] add: warn when -u or -A is used without filepattern
Date: Sun, 27 Jan 2013 12:33:00 -0800
Message-ID: <7vehh6v01v.fsf@alter.siamese.dyndns.org>
References: <vpq1uddoedj.fsf@grenoble-inp.fr>
 <1359110978-20054-1-git-send-email-Matthieu.Moy@imag.fr>
 <7v8v7h3vx8.fsf@alter.siamese.dyndns.org> <vpqtxq28v3s.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Jan 27 21:33:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzYus-0004eL-TA
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 21:33:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756098Ab3A0UdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 15:33:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55239 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755445Ab3A0UdD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 15:33:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E831CB45A;
	Sun, 27 Jan 2013 15:33:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nPBNnyImm2EhloXIG0KSDkl9R1M=; b=dE7Is3
	75zlUEOtwm27xjh91exkc8n+gljo/sGZBiLkOmXWvRZhlNULCGmPkgZTbNEDXes/
	Y85ssYn0m+bJZ4b2KLfxy3fEKXwEXIw+FcrxqqnigNFN5K9sbZssieAyFOmvPjg/
	XdIM3lpm97G5+kY7TdndvMtToCJ6G2lTaqd9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y/LVt4ZUs0xRYeUvz3gSK40DCPyaRdgN
	Yg/MXjMrX2HT2BxRuD5DSqyQZkr4RxLF2JRoEvWOeAqPdFybcCadGE5N+qD4xLPG
	VOlizRAmbPZVH3wrkYIvOSci5Cl5JexeisZawy5frKM6IheuM9cOmcUHq1UJJNBs
	ESzYbdf6LNA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAE5FB457;
	Sun, 27 Jan 2013 15:33:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E5B1B455; Sun, 27 Jan 2013
 15:33:02 -0500 (EST)
In-Reply-To: <vpqtxq28v3s.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Sun, 27 Jan 2013 17:10:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF0CD8F8-68C0-11E2-A289-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214729>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Plus, option_with_implicit_dot is used in cut-and-paste ready commands
> below.

I do not think we should aim for easy cut-and-paste, especially when
the real purpose of the change is to train people's fingers; the
message should discouraging cut-and-paste in a case like this, if
anything.

But we could obviously do this, if you really want to cut-and-paste.

 builtin/add.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 7552f7f..ba72a57 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -363,7 +363,7 @@ static int add_files(struct dir_struct *dir, int flags)
 	return exit_status;
 }
 
-static void warn_pathless_add(const char *option_name) {
+static void warn_pathless_add(const char *option_name, const char *short_name) {
 	/*
 	 * To be consistent with "git add -p" and most Git
 	 * commands, we should default to being tree-wide, but
@@ -374,20 +374,21 @@ static void warn_pathless_add(const char *option_name) {
 	 * turned into a die(...), and eventually we may
 	 * reallow the command with a new behavior.
 	 */
-	warning(_("The behavior of 'git add %s' with no path argument from a subdirectory of the\n"
-		  "tree will change in Git 2.0 and shouldn't be used anymore.\n"
+	warning(_("The behavior of 'git add %s (or %s)' with no path argument from a\n"
+		  "subdirectory of the tree will change in Git 2.0 and should not be\n"
+		  "used anymore.\n"
 		  "To add content for the whole tree, run:\n"
 		  "\n"
-		  "  git add %s :/\n"
+		  "  git add %s :/ ;# or git add %s :/\n"
 		  "\n"
 		  "To restrict the command to the current directory, run:\n"
 		  "\n"
-		  "  git add %s .\n"
+		  "  git add %s . ;# or git add %s .\n"
 		  "\n"
 		  "With the current Git version, the command is restricted to the current directory."),
-		option_name,
-		option_name,
-		option_name);
+		option_name, short_name,
+		option_name, short_name,
+		option_name, short_name);
 }
 
 int cmd_add(int argc, const char **argv, const char *prefix)
@@ -401,6 +402,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	int require_pathspec;
 	char *seen = NULL;
 	const char *option_with_implicit_dot = NULL;
+	const char *short_option_with_implicit_dot = NULL;
 
 	git_config(add_config, NULL);
 
@@ -420,14 +422,19 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		die(_("-A and -u are mutually incompatible"));
 	if (!show_only && ignore_missing)
 		die(_("Option --ignore-missing can only be used together with --dry-run"));
-	if (addremove)
+	if (addremove) {
 		option_with_implicit_dot = "--all";
-	if (take_worktree_changes)
+		short_option_with_implicit_dot = "-A";
+	}
+	if (take_worktree_changes) {
 		option_with_implicit_dot = "--update";
+		short_option_with_implicit_dot = "-u";
+	}
 	if (option_with_implicit_dot && !argc) {
 		static const char *here[2] = { ".", NULL };
 		if (prefix)
-			warn_pathless_add(option_with_implicit_dot);
+			warn_pathless_add(option_with_implicit_dot,
+					  short_option_with_implicit_dot);
 		argc = 1;
 		argv = here;
 	}
