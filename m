From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 3/7 v2] git_extract_argv0_path(): Move check for valid argv0 from caller to callee
Date: Sun, 18 Jan 2009 13:00:11 +0100
Message-ID: <1232280015-8144-4-git-send-email-prohaska@zib.de>
References: <1232280015-8144-1-git-send-email-prohaska@zib.de>
 <1232280015-8144-2-git-send-email-prohaska@zib.de>
 <1232280015-8144-3-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 13:02:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOWLl-00079T-JS
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 13:01:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765454AbZARMAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 07:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765405AbZARMAf
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 07:00:35 -0500
Received: from mailer.zib.de ([130.73.108.11]:32920 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763779AbZARMAe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 07:00:34 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n0IC0GsM026430;
	Sun, 18 Jan 2009 13:00:21 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n0IC0FJ4001758;
	Sun, 18 Jan 2009 13:00:16 +0100 (MET)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1232280015-8144-3-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106174>

This simplifies the calling code.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 exec_cmd.c |    3 +++
 git.c      |    5 ++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 23a52cf..89931e4 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -23,6 +23,9 @@ const char *system_path(const char *path)
 
 const char *git_extract_argv0_path(const char *argv0)
 {
+	if (!argv0 || !*argv0)
+		return 0;
+
 	const char *slash = argv0 + strlen(argv0);
 
 	while (argv0 <= slash && !is_dir_sep(*slash))
diff --git a/git.c b/git.c
index b99b1b2..9c8da93 100644
--- a/git.c
+++ b/git.c
@@ -422,9 +422,8 @@ int main(int argc, const char **argv)
 	const char *cmd;
 	int done_alias = 0;
 
-	if (argv[0] && *argv[0])
-		cmd = git_extract_argv0_path(argv[0]);
-	else
+	cmd = git_extract_argv0_path(argv[0]);
+	if (!cmd)
 		cmd = "git-help";
 
 	/*
-- 
1.6.1.87.g15624
