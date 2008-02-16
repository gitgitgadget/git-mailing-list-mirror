From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/6] Add "const" qualifier to "char *pager_program".
Date: Sat, 16 Feb 2008 06:01:11 +0100
Message-ID: <20080216060111.6ed7c673.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio Hamano <junkio@cox.net>,
	Pierre Habouzit <madcoder@debian.org>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 16 05:56:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQF5x-00042t-E6
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 05:56:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758897AbYBPEzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 23:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758733AbYBPEzR
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 23:55:17 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:34761 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754558AbYBPEzO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 23:55:14 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id A8B641AB2AA;
	Sat, 16 Feb 2008 05:55:13 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 5905B1AB2A9;
	Sat, 16 Feb 2008 05:55:13 +0100 (CET)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74011>

Also use "git_config_string" to simplify "config.c" code
where "pager_program" is set.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h       |    2 +-
 config.c      |    8 ++------
 environment.c |    2 +-
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index cef058d..892f374 100644
--- a/cache.h
+++ b/cache.h
@@ -651,7 +651,7 @@ extern int write_or_whine_pipe(int fd, const void *buf, size_t count, const char
 
 /* pager.c */
 extern void setup_pager(void);
-extern char *pager_program;
+extern const char *pager_program;
 extern int pager_in_use(void);
 extern int pager_use_color;
 
diff --git a/config.c b/config.c
index ca6af2d..01e3843 100644
--- a/config.c
+++ b/config.c
@@ -440,12 +440,8 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}
 
-	if (!strcmp(var, "core.pager")) {
-		if (!value)
-			return config_error_nonbool(var);
-		pager_program = xstrdup(value);
-		return 0;
-	}
+	if (!strcmp(var, "core.pager"))
+		return git_config_string(&pager_program, var, value);
 
 	if (!strcmp(var, "core.editor")) {
 		if (!value)
diff --git a/environment.c b/environment.c
index 18a1c4e..b8869e9 100644
--- a/environment.c
+++ b/environment.c
@@ -30,7 +30,7 @@ int core_compression_seen;
 size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit = 16 * 1024 * 1024;
-char *pager_program;
+const char *pager_program;
 int pager_use_color = 1;
 char *editor_program;
 char *excludes_file;
-- 
1.5.4.1.129.gf12af-dirty
