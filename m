From: Joe Ratterman <jratt0@gmail.com>
Subject: [PATCH] Add '-P' as a synonym for '--no-pager' in the git command
Date: Tue, 13 Dec 2011 16:35:06 -0600
Message-ID: <1323815706-10560-2-git-send-email-jratt0@gmail.com>
References: <1323815706-10560-1-git-send-email-jratt0@gmail.com>
Cc: Joe Ratterman <jratt0@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 23:35:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Raawj-0006yc-Q0
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 23:35:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773Ab1LMWfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 17:35:20 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:34093 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305Ab1LMWfS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 17:35:18 -0500
Received: by vcbfk14 with SMTP id fk14so149000vcb.19
        for <git@vger.kernel.org>; Tue, 13 Dec 2011 14:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=CBZuZ0IjhLT3lut8PBEsAVPWHbT6eEXtHWnqSvA+/ec=;
        b=fqYaJ+p8/2mrN3VCfSm0Cl/2diyHWaowXLmRYaN8wotDlWS64tfoHHYnjx6enUU/D2
         pjT3Nevdz5OX90esvwCtUOsiPnDBwCvqLNDjgBHiUznWNQGwyXeY6k8nvrXZhIKIMbqI
         TjBWjaRxt/791og1zmV9wmyndgPMttOSN+5SQ=
Received: by 10.220.227.66 with SMTP id iz2mr2959745vcb.16.1323815718207;
        Tue, 13 Dec 2011 14:35:18 -0800 (PST)
Received: from localhost.localdomain (rchp4.rochester.ibm.com. [129.42.161.36])
        by mx.google.com with ESMTPS id em10sm484385vdc.6.2011.12.13.14.35.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Dec 2011 14:35:17 -0800 (PST)
X-Mailer: git-send-email 1.7.7.1.3.ge148a
In-Reply-To: <1323815706-10560-1-git-send-email-jratt0@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187069>

  Also, add both -P|--no-pager to the existing -p|--paginate in bash
  completion.

Signed-off-by: Joe Ratterman <jratt0@gmail.com>
---
 Documentation/git.txt                  |    3 ++-
 contrib/completion/git-completion.bash |    2 +-
 git.c                                  |    4 ++--
 t/t7006-pager.sh                       |    8 ++++++++
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index e869032..c7f8445 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git' [--version] [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
-    [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]
+    [-p|--paginate|-P|--no-pager] [--no-replace-objects] [--bare]
     [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
     [-c <name>=<value>]
     [--help] <command> [<args>]
@@ -329,6 +329,7 @@ help ...`.
 	configuration options (see the "Configuration Mechanism" section
 	below).
 
+-P::
 --no-pager::
 	Do not pipe git output into a pager.
 
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index cc1bdf9..8b9ea1b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2640,7 +2640,7 @@ _git ()
 		case "$i" in
 		--git-dir=*) __git_dir="${i#--git-dir=}" ;;
 		--bare)      __git_dir="." ;;
-		--version|-p|--paginate) ;;
+		--version|-p|--paginate|-P|--no-pager) ;;
 		--help) command="help"; break ;;
 		*) command="$i"; break ;;
 		esac
diff --git a/git.c b/git.c
index 8e34903..baa1613 100644
--- a/git.c
+++ b/git.c
@@ -7,7 +7,7 @@
 
 const char git_usage_string[] =
 	"git [--version] [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
-	"           [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]\n"
+	"           [-p|--paginate|-P|--no-pager] [--no-replace-objects] [--bare]\n"
 	"           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"
 	"           [-c name=value] [--help]\n"
 	"           <command> [<args>]";
@@ -103,7 +103,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			exit(0);
 		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
 			use_pager = 1;
-		} else if (!strcmp(cmd, "--no-pager")) {
+		} else if (!strcmp(cmd, "-P") || !strcmp(cmd, "--no-pager")) {
 			use_pager = 0;
 			if (envchanged)
 				*envchanged = 1;
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 320e1d1..783915e 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -84,6 +84,14 @@ test_expect_success 'no pager even with --paginate when stdout is a pipe' '
 	! test -e paginated.out
 '
 
+test_expect_success TTY 'no pager with -P' '
+	rm -f paginated.out ||
+	cleanup_fail &&
+
+	test_terminal git -P log &&
+	! test -e paginated.out
+'
+
 test_expect_success TTY 'no pager with --no-pager' '
 	rm -f paginated.out ||
 	cleanup_fail &&
-- 
1.7.7.1
