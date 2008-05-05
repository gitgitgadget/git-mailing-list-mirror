From: imyousuf@gmail.com
Subject: [PATCH] git-submodule.sh: Add pre command argument to git submodule recurse subcommand
Date: Mon,  5 May 2008 14:44:10 +0600
Message-ID: <1209977051-25896-4-git-send-email-imyousuf@gmail.com>
References: <1209977051-25896-1-git-send-email-imyousuf@gmail.com>
 <1209977051-25896-2-git-send-email-imyousuf@gmail.com>
 <1209977051-25896-3-git-send-email-imyousuf@gmail.com>
Cc: gitster@pobox.com, Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 05 10:46:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JswKq-0006Gl-ED
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 10:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756194AbYEEIpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 04:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756163AbYEEIpX
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 04:45:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:44279 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755909AbYEEIpV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 04:45:21 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1024831nfc.21
        for <git@vger.kernel.org>; Mon, 05 May 2008 01:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hcTPnYZbD3dWWe6GWwHzuw8ckYE64U/w7EYqN4q50pU=;
        b=UMu3jZFtqpXR3UkUHGRwhhnfqk6a8xVtkmt3KXnBYsvq0c354VvuIB2+pp1XG3cDxcznbIzUH+FlT+q4c+y34NUi73j/tNOVrXVtDzyVT2dlRJYwUIleTgmNfxp0HreSe1w/OjixKc2+EhBbz7SuWYU8+YVDLoXxlR7VMaiD2/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GUB+88o5zh1GUNoV886rVIiOsTqCObIiUp76kawjZHQtGlTdqeKumFvvU6u+3xR9MVwNsQ2F3l0N+dg213egf3V6VVg8yD5q5a5kM38Yh7cC24UJF7iZoEqcFx9bZzRIt27/o0H9XIXbO7Ps5yEasAfKcs8PLeLTYWWv/quA9GA=
Received: by 10.210.48.13 with SMTP id v13mr5345107ebv.132.1209977120751;
        Mon, 05 May 2008 01:45:20 -0700 (PDT)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id h6sm60153898nfh.29.2008.05.05.01.45.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 May 2008 01:45:20 -0700 (PDT)
X-Mailer: git-send-email 1.5.4.2
In-Reply-To: <1209977051-25896-3-git-send-email-imyousuf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81248>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

I usually feel that when typing a command, being able to see some options
come in handy. For example if I can see the available branches before checking
out a branch that would be useful, IOW, if I could do 'git branch' before git
checkout it would be helpful.

It is now possible using the [-p|--pre-command] option. Using this
subcommand command argument one can actually execute another command before
specifying the arguments or the original command getting executed.

	git submodule recurse -a -p checkout

it will prompt the user for the pre command until one is satisfied and later
the original command with the custom argument will get executed.

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 git-submodule.sh |   29 ++++++++++++++++++++++++++++-
 1 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 314652d..dd80850 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -12,7 +12,7 @@ LONG_USAGE="$0 add [-q|--quiet] [-b|--branch branch] <repository> [<path>]
 $0 [status] [-q|--quiet] [-c|--cached] [--] [<path>...]
 $0 init|update [-q|--quiet] [--] [<path>...]
 $0 summary [--cached] [-n|--summary-limit <n>] [<commit>]
-$0 recurse [-q|--quiet] [-e|--exit-after-error] [-d|--depth <recursion depth>] [-b|--breadth-first] [-a|--customized-argument] <git command> [<args> ...]"
+$0 recurse [-q|--quiet] [-e|--exit-after-error] [-d|--depth <recursion depth>] [-b|--breadth-first] [-a|--customized-argument] [-p|--pre-command] <git command> [<args> ...]"
 OPTIONS_SPEC=
 . git-sh-setup
 require_work_tree
@@ -27,6 +27,7 @@ depth_first=1
 on_error=
 use_custom_args=
 custom_args=
+pre_cmd=
 
 #
 # print stuff on stdout unless -q was specified
@@ -587,6 +588,28 @@ cmd_status()
 	done
 }
 
+# Take command from user and execute it until user wants to discontinue
+do_pre_command()
+{
+	say "Starting pre-comamnd execution!"
+	while :
+	do
+		(
+			printf "Please provide a command: "
+			read pre_command
+			test -z "$pre_command" ||
+			eval "$pre_command"
+		)
+		printf "Press y to continue with another shell command... "
+		read keypress
+		if test "$keypress" != "y" &&
+			test "$keypress" != "Y"
+		then
+			break
+		fi
+	done
+}
+
 # Take arguments from user to pass as custom arguments and execute the command
 exec_with_custom_args()
 {
@@ -673,6 +696,7 @@ traverse_module()
 		# If depth-first is specified in that case submodules are
 		# are traversed before executing the command on this submodule
 		test -n "$depth_first" && traverse_submodules "$@"
+		test -n "$pre_cmd" && do_pre_command
 		say "git submodule recurse $submod_path $*"
 		if test -n "$use_custom_args"
 		then
@@ -734,6 +758,9 @@ cmd_recurse() {
 		-a|--customized-argument)
 			use_custom_args=1
 			;;
+		-p|--pre-command)
+			pre_cmd=1
+			;;
 		-*)
 			usage
 			;;
-- 
1.5.4.2
