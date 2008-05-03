From: imyousuf@gmail.com
Subject: [PATCH 4/5] Add pre command argument to git submodule recurse subcommand
Date: Sat,  3 May 2008 19:53:32 +0600
Message-ID: <1209822813-12237-4-git-send-email-imyousuf@gmail.com>
References: <1209822813-12237-1-git-send-email-imyousuf@gmail.com>
 <1209822813-12237-2-git-send-email-imyousuf@gmail.com>
 <1209822813-12237-3-git-send-email-imyousuf@gmail.com>
Cc: gitster@pobox.com, Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 15:55:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsICx-0005Uk-5A
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 15:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755318AbYECNyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 09:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755296AbYECNyU
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 09:54:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:60977 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754976AbYECNyS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 09:54:18 -0400
Received: by ug-out-1314.google.com with SMTP id h3so301813ugf.16
        for <git@vger.kernel.org>; Sat, 03 May 2008 06:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=em5ky6YDiJ6TBWfEapxwi1H6E6E8bHOKR7a8GRQeGcI=;
        b=sBic5mg8FoRg1uCedcNR0QaQSGjw8bcTaMz+FCm/Mm5bHIlzMESMNeha9LyizyejNloJmM3a1r9xTRtLldIKf5WNPgomwPHl8p9Tmhbn8oOIFufe8FlL9UgqnzfKEv/c2fId9HBnOV3Xgy55J0huwP52HRPYCJATxPq6vj93x7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ux6JePLDGihN5sMeu8Jgg/NnGhXEB3OOTYBnTbLYw86nkVotjLL97y+AYjWSB4CO4KFYCPToug0DHw08RlrtfBS77LopCVoJb/mLGMgpNBGt7EZjFpP7c2U/BYKhITuEnFmG0Z/sgZFbrW6LImGhQ7dsuuQaPEIolKQw0hEg5F4=
Received: by 10.66.251.3 with SMTP id y3mr1486066ugh.88.1209822857199;
        Sat, 03 May 2008 06:54:17 -0700 (PDT)
Received: from localhost ( [122.248.32.83])
        by mx.google.com with ESMTPS id o30sm2482645ugd.84.2008.05.03.06.54.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 03 May 2008 06:54:16 -0700 (PDT)
X-Mailer: git-send-email 1.5.4.2
In-Reply-To: <1209822813-12237-3-git-send-email-imyousuf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81083>

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
index 59e58e5..6a85ba6 100755
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
@@ -674,6 +697,7 @@ traverse_module()
 		# If depth-first is specified in that case submodules are
 		# are traversed before executing the command on this submodule
 		test -n "$depth_first" && traverse_submodules "$@"
+		test -n "$pre_cmd" && do_pre_command
 		say "git submodule recurse $submod_path $*"
 		if test -n "$use_custom_args"
 		then
@@ -735,6 +759,9 @@ cmd_recurse() {
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
