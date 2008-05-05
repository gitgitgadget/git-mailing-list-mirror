From: imyousuf@gmail.com
Subject: [PATCH v2 4/5] git-submodule.sh: Add pre command argument to git submodule recurse subcommand
Date: Mon,  5 May 2008 15:09:41 +0600
Message-ID: <1209978582-5785-4-git-send-email-imyousuf@gmail.com>
References: <1209978582-5785-1-git-send-email-imyousuf@gmail.com>
 <1209978582-5785-2-git-send-email-imyousuf@gmail.com>
 <1209978582-5785-3-git-send-email-imyousuf@gmail.com>
Cc: gitster@pobox.com, Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 05 11:11:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JswjU-00050d-8p
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 11:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755802AbYEEJKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 05:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755668AbYEEJKv
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 05:10:51 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:64628 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755797AbYEEJKu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 05:10:50 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1027289nfc.21
        for <git@vger.kernel.org>; Mon, 05 May 2008 02:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hcTPnYZbD3dWWe6GWwHzuw8ckYE64U/w7EYqN4q50pU=;
        b=foYCUU97u9tcOJMbSMBqHvxQoLbfFqkJo3XLM+InYBmM2LHGj/Vk+Zfn742DDy9uE2G9K7Bj7JpHQtv/g8JfkEFNJPmzCVu6diIA/imkHnTHnh8bp+GNsccxFEwI3MoNRwcroh6qTy/1mgl6dXvmr3DLn41uivYrobyjW/6HY4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=s2asgo2tmQDPGENUSiCFny2M9h/TKKgKo5d9QzVRjP8Mo3ALxzxWl8iVyjVUOJodNI29NHRZ8xl9/iJRdYbVDMjc3/QtlKOm4a/+6R+WwwCPwemIJ6y8y1I9FcozGguiWZdyY72bM/ppGd6kSRIHoUI//sxpjHupUsrPhdXUODo=
Received: by 10.210.22.10 with SMTP id 10mr5372518ebv.37.1209978650254;
        Mon, 05 May 2008 02:10:50 -0700 (PDT)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id h1sm11184253nfh.19.2008.05.05.02.10.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 May 2008 02:10:49 -0700 (PDT)
X-Mailer: git-send-email 1.5.4.2
In-Reply-To: <1209978582-5785-3-git-send-email-imyousuf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81258>

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
