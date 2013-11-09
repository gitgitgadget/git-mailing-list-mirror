From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 16/86] git: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:09 +0100
Message-ID: <20131109070720.18178.44846.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:08:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2fB-0002lM-3z
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:08:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758620Ab3KIHIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:08:49 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:54114 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933253Ab3KIHI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:27 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 4B21378;
	Sat,  9 Nov 2013 08:08:26 +0100 (CET)
X-git-sha1: 66a394305d7b82e2020caf29d6b9cb7d4c0f3882 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237485>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/git.c b/git.c
index cb5208d..f077f49 100644
--- a/git.c
+++ b/git.c
@@ -54,7 +54,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 		/*
 		 * Check remaining flags.
 		 */
-		if (!prefixcmp(cmd, "--exec-path")) {
+		if (has_prefix(cmd, "--exec-path")) {
 			cmd += 11;
 			if (*cmd == '=')
 				git_set_argv_exec_path(cmd + 1);
@@ -92,7 +92,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 			(*argv)++;
 			(*argc)--;
-		} else if (!prefixcmp(cmd, "--git-dir=")) {
+		} else if (has_prefix(cmd, "--git-dir=")) {
 			setenv(GIT_DIR_ENVIRONMENT, cmd + 10, 1);
 			if (envchanged)
 				*envchanged = 1;
@@ -106,7 +106,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 			(*argv)++;
 			(*argc)--;
-		} else if (!prefixcmp(cmd, "--namespace=")) {
+		} else if (has_prefix(cmd, "--namespace=")) {
 			setenv(GIT_NAMESPACE_ENVIRONMENT, cmd + 12, 1);
 			if (envchanged)
 				*envchanged = 1;
@@ -120,7 +120,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 			(*argv)++;
 			(*argc)--;
-		} else if (!prefixcmp(cmd, "--work-tree=")) {
+		} else if (has_prefix(cmd, "--work-tree=")) {
 			setenv(GIT_WORK_TREE_ENVIRONMENT, cmd + 12, 1);
 			if (envchanged)
 				*envchanged = 1;
@@ -569,7 +569,7 @@ int main(int argc, char **av)
 	 * So we just directly call the internal command handler, and
 	 * die if that one cannot handle it.
 	 */
-	if (!prefixcmp(cmd, "git-")) {
+	if (has_prefix(cmd, "git-")) {
 		cmd += 4;
 		argv[0] = cmd;
 		handle_internal_command(argc, argv);
@@ -581,7 +581,7 @@ int main(int argc, char **av)
 	argc--;
 	handle_options(&argv, &argc, NULL);
 	if (argc > 0) {
-		if (!prefixcmp(argv[0], "--"))
+		if (has_prefix(argv[0], "--"))
 			argv[0] += 2;
 	} else {
 		/* The user didn't specify a command; give them help */
-- 
1.8.4.1.566.geca833c
