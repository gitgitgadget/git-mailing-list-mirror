From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH] Share color list between graph and show-branch
Date: Wed, 30 Mar 2011 20:38:26 -0500
Message-ID: <1301535506-1166-1-git-send-email-dpmcgee@gmail.com>
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 03:38:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q56qR-0003Um-Ke
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 03:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933810Ab1CaBic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 21:38:32 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33023 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932822Ab1CaBia (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 21:38:30 -0400
Received: by mail-iw0-f174.google.com with SMTP id 34so1864765iwn.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 18:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=xv3I4Cm8MxIsosGsvMmavqBntJo29Hcup0p+iJlRdLI=;
        b=CinghNdrhd66vOft7XfgRRnscChvlf6tx7X69Kmx+ZwLBwlO36ZoZuR4L4R8dJrh56
         k5X3aHM04M2YbISBg2ALP9l4nCuSfj8Ih+YxfSC2swQ2uDPt/H4evJ8nyS531h69Xgbh
         uEPGVEVGvMNhhH9bHCHChsuUW93HwjmSvS2l8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=f2ASu6Gpf/YvsW9F95jxR/SgZ/T/iiKl6PDeD1WJZhDcIewboPTzmclr90PRerM+ZK
         uVCMPJvQdnMex1AAKvB5VZBIVrjOLbEvLAYIabhgibiLuSqOj+stJHN47gbI14xMz7ri
         iBeVtSx+B28B65x/9Tl4m3HAFlfG//PACQgpk=
Received: by 10.231.24.193 with SMTP id w1mr2126631ibb.41.1301535509870;
        Wed, 30 Mar 2011 18:38:29 -0700 (PDT)
Received: from localhost (c-71-239-242-45.hsd1.il.comcast.net [71.239.242.45])
        by mx.google.com with ESMTPS id mv26sm384060ibb.28.2011.03.30.18.38.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 18:38:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170442>

This also adds the new colors to show-branch that were added a while
back for graph output.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 builtin/show-branch.c |   16 +++-------------
 color.c               |   19 +++++++++++++++++++
 color.h               |    4 ++++
 graph.c               |   21 ---------------------
 4 files changed, 26 insertions(+), 34 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index da69581..d00c0ac 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -12,16 +12,6 @@ static const char* show_branch_usage[] = {
 };
 
 static int showbranch_use_color = -1;
-static char column_colors[][COLOR_MAXLEN] = {
-	GIT_COLOR_RED,
-	GIT_COLOR_GREEN,
-	GIT_COLOR_YELLOW,
-	GIT_COLOR_BLUE,
-	GIT_COLOR_MAGENTA,
-	GIT_COLOR_CYAN,
-};
-
-#define COLUMN_COLORS_MAX (ARRAY_SIZE(column_colors))
 
 static int default_num;
 static int default_alloc;
@@ -37,7 +27,7 @@ static const char **default_arg;
 static const char *get_color_code(int idx)
 {
 	if (showbranch_use_color)
-		return column_colors[idx];
+		return column_colors_ansi[idx % COLUMN_COLORS_ANSI_MAX];
 	return "";
 }
 
@@ -892,7 +882,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 				for (j = 0; j < i; j++)
 					putchar(' ');
 				printf("%s%c%s [%s] ",
-				       get_color_code(i % COLUMN_COLORS_MAX),
+				       get_color_code(i),
 				       is_head ? '*' : '!',
 				       get_color_reset_code(), ref_name[i]);
 			}
@@ -954,7 +944,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 				else
 					mark = '+';
 				printf("%s%c%s",
-				       get_color_code(i % COLUMN_COLORS_MAX),
+				       get_color_code(i),
 				       mark, get_color_reset_code());
 			}
 			putchar(' ');
diff --git a/color.c b/color.c
index 417cf8f..6631346 100644
--- a/color.c
+++ b/color.c
@@ -3,6 +3,25 @@
 
 int git_use_color_default = 0;
 
+/*
+ * The list of available column colors.
+ */
+const char *column_colors_ansi[13] = {
+	GIT_COLOR_RED,
+	GIT_COLOR_GREEN,
+	GIT_COLOR_YELLOW,
+	GIT_COLOR_BLUE,
+	GIT_COLOR_MAGENTA,
+	GIT_COLOR_CYAN,
+	GIT_COLOR_BOLD_RED,
+	GIT_COLOR_BOLD_GREEN,
+	GIT_COLOR_BOLD_YELLOW,
+	GIT_COLOR_BOLD_BLUE,
+	GIT_COLOR_BOLD_MAGENTA,
+	GIT_COLOR_BOLD_CYAN,
+	GIT_COLOR_RESET,
+};
+
 static int parse_color(const char *name, int len)
 {
 	static const char * const color_names[] = {
diff --git a/color.h b/color.h
index c0528cf..a7da793 100644
--- a/color.h
+++ b/color.h
@@ -53,6 +53,10 @@ struct strbuf;
  */
 extern int git_use_color_default;
 
+extern const char *column_colors_ansi[13];
+
+/* Ignore the RESET at the end when giving the size */
+#define COLUMN_COLORS_ANSI_MAX (ARRAY_SIZE(column_colors_ansi) - 1)
 
 /*
  * Use this instead of git_default_config if you need the value of color.ui.
diff --git a/graph.c b/graph.c
index ef2e24e..d1dd15e 100644
--- a/graph.c
+++ b/graph.c
@@ -59,27 +59,6 @@ enum graph_state {
 	GRAPH_COLLAPSING
 };
 
-/*
- * The list of available column colors.
- */
-static const char *column_colors_ansi[] = {
-	GIT_COLOR_RED,
-	GIT_COLOR_GREEN,
-	GIT_COLOR_YELLOW,
-	GIT_COLOR_BLUE,
-	GIT_COLOR_MAGENTA,
-	GIT_COLOR_CYAN,
-	GIT_COLOR_BOLD_RED,
-	GIT_COLOR_BOLD_GREEN,
-	GIT_COLOR_BOLD_YELLOW,
-	GIT_COLOR_BOLD_BLUE,
-	GIT_COLOR_BOLD_MAGENTA,
-	GIT_COLOR_BOLD_CYAN,
-	GIT_COLOR_RESET,
-};
-
-#define COLUMN_COLORS_ANSI_MAX (ARRAY_SIZE(column_colors_ansi) - 1)
-
 static const char **column_colors;
 static unsigned short column_colors_max;
 
-- 
1.7.4.2
