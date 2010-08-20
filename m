From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] shell: Rewrite documentation and improve error message
Date: Sat, 21 Aug 2010 01:14:12 +0530
Message-ID: <1282333452-25278-1-git-send-email-artagnon@gmail.com>
Cc: Greg Brockman <gdb@MIT.EDU>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 20 21:46:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmXXl-0005MD-Q8
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 21:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023Ab0HTTqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 15:46:21 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:53122 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228Ab0HTTqT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 15:46:19 -0400
Received: by pvg2 with SMTP id 2so1333407pvg.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 12:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Ihlu/QhXeY+syubr0NT7z1LSIyYToKP6ANCnEqoyj0I=;
        b=OgWZeWczVQjT/tfTURD3/aKyzte3IBkVbAk1c+RAz+OeY/kFDeUukNmRMBuhIBM2Cw
         zohuSPzfXIKy7oXsNvXCDLPkGh1RyC3+1IHGMOLI4VhL+f3OWdN+Hmm1rErl2RFmoXmW
         Srh67a3qCgBb1jzM39BqvZIutuY0l3aKTMc08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=umIwemuT/fuLVu0KSwA7qmYY88uiBupct/cMXIqg8uEP1bjD5S9fJ5XPtp24zQd89u
         ADS81hCcek4OhRhy4u0moS+GNNZCPcW2Sj1nBDCboiyRWmlSPBF6sCz56k/jRShMUzDJ
         9zRZxChB+1iv587grPM7SLlwg9T4fxbN46GdY=
Received: by 10.142.199.20 with SMTP id w20mr1353933wff.291.1282333579226;
        Fri, 20 Aug 2010 12:46:19 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id b19sm3641572wff.7.2010.08.20.12.46.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 12:46:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154075>

Update the documentation of 'git shell' to mention the interactive
mode and COMMAND_DIR. Also provide a hint when interactive mode is not
available in the shell.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Cc: Greg Brockman <gdb@MIT.EDU>
Cc: Petr Baudis <pasky@suse.cz>
---
 Documentation/git-receive-pack.txt |    2 +-
 Documentation/git-shell.txt        |   27 ++++++++++++++++-----------
 shell.c                            |    7 +++++--
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 2790eeb..2b07e44 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -8,7 +8,7 @@ git-receive-pack - Receive what is pushed into the repository
 
 SYNOPSIS
 --------
-'git-receive-pack' <directory>
+'git receive-pack' <directory>
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.txt
index 0f3ad81..c9f1dc9 100644
--- a/Documentation/git-shell.txt
+++ b/Documentation/git-shell.txt
@@ -3,24 +3,29 @@ git-shell(1)
 
 NAME
 ----
-git-shell - Restricted login shell for GIT-only SSH access
+git-shell - Restricted login shell for Git-only SSH access
 
 
 SYNOPSIS
 --------
-'$(git --exec-path)/git-shell' -c <command> <argument>
+'git shell' [-c <command> <argument>]
 
 DESCRIPTION
 -----------
-This is meant to be used as a login shell for SSH accounts you want
-to restrict to GIT pull/push access only. It permits execution only
-of server-side GIT commands implementing the pull/push functionality.
-The commands can be executed only by the '-c' option; the shell is not
-interactive.
-
-Currently, only four commands are permitted to be called, 'git-receive-pack'
-'git-upload-pack' and 'git-upload-archive' with a single required argument, or
-'cvs server' (to invoke 'git-cvsserver').
+
+A login shell for SSH accounts to provide restricted Git access. When
+'-c' is given, the program executes <command> non-interactively;
+<command> can be one of 'git receive-pack', 'git upload-pack', 'git
+upload-archive', 'cvs server', or a command in COMMAND_DIR. The shell
+is started in interactive mode when no arguments are given; in this
+case, COMMAND_DIR must exist, and any of the executables in them can
+be invoked.
+
+'cvs server' is a special command which executes git-cvsserver.
+
+COMMAND_DIR is the path 'git-shell-commands' in the user's home
+directory. The user must have read and execute permissions to the
+directory for it to be useful.
 
 Author
 ------
diff --git a/shell.c b/shell.c
index ffed615..3fb804e 100644
--- a/shell.c
+++ b/shell.c
@@ -152,8 +152,11 @@ int main(int argc, char **argv)
 	} else if (argc == 1) {
 		/* Allow the user to run an interactive shell */
 		cd_to_homedir();
-		if (access(COMMAND_DIR, R_OK | X_OK) == -1)
-			die("Sorry, the interactive git-shell is not enabled");
+		if (access(COMMAND_DIR, R_OK | X_OK) == -1) {
+			die("Inteactive git shell is not enabled.\n"
+			    "hint: " COMMAND_DIR " should exist "
+			    "and have read and execute access.");
+		}
 		run_shell();
 		exit(0);
 	} else if (argc != 3 || strcmp(argv[1], "-c")) {
-- 
1.7.2.2.409.gdbb11.dirty
