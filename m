From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 5/6] Add "const" qualifier to "char *excludes_file".
Date: Sat, 16 Feb 2008 06:01:59 +0100
Message-ID: <20080216060159.e74e6948.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio Hamano <junkio@cox.net>,
	Pierre Habouzit <madcoder@debian.org>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 16 05:56:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQF6R-0004AK-E3
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 05:56:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845AbYBPE4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 23:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754820AbYBPE4F
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 23:56:05 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:34830 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754688AbYBPE4C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 23:56:02 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id BD9FA1AB2AA;
	Sat, 16 Feb 2008 05:56:01 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 6DC2D1AB2A9;
	Sat, 16 Feb 2008 05:56:01 +0100 (CET)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74013>

Also use "git_config_string" to simplify "config.c" code
where "excludes_file" is set.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h       |    2 +-
 config.c      |    8 ++------
 environment.c |    2 +-
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index 2af1468..cdcabe9 100644
--- a/cache.h
+++ b/cache.h
@@ -656,7 +656,7 @@ extern int pager_in_use(void);
 extern int pager_use_color;
 
 extern const char *editor_program;
-extern char *excludes_file;
+extern const char *excludes_file;
 
 /* base85 */
 int decode_85(char *dst, const char *line, int linelen);
diff --git a/config.c b/config.c
index 07027de..ad47dc3 100644
--- a/config.c
+++ b/config.c
@@ -446,12 +446,8 @@ int git_default_config(const char *var, const char *value)
 	if (!strcmp(var, "core.editor"))
 		return git_config_string(&editor_program, var, value);
 
-	if (!strcmp(var, "core.excludesfile")) {
-		if (!value)
-			return config_error_nonbool(var);
-		excludes_file = xstrdup(value);
-		return 0;
-	}
+	if (!strcmp(var, "core.excludesfile"))
+		return git_config_string(&excludes_file, var, value);
 
 	if (!strcmp(var, "core.whitespace")) {
 		if (!value)
diff --git a/environment.c b/environment.c
index 9556009..fa36333 100644
--- a/environment.c
+++ b/environment.c
@@ -33,7 +33,7 @@ size_t delta_base_cache_limit = 16 * 1024 * 1024;
 const char *pager_program;
 int pager_use_color = 1;
 const char *editor_program;
-char *excludes_file;
+const char *excludes_file;
 int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 
-- 
1.5.4.1.129.gf12af-dirty
