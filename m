From: skimo@liacs.nl
Subject: [PATCH 3/6] Define ishex(x) in git-compat-util.h
Date: Thu, 12 Jul 2007 21:06:00 +0200
Message-ID: <11842671632000-git-send-email-skimo@liacs.nl>
References: <11842671631744-git-send-email-skimo@liacs.nl>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 21:07:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I940W-0003wn-O9
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 21:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754405AbXGLTGo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 15:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753358AbXGLTGo
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 15:06:44 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:46082 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753119AbXGLTGo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 15:06:44 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l6CJ63pW029832;
	Thu, 12 Jul 2007 21:06:08 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id B56CE3C00D; Thu, 12 Jul 2007 21:06:03 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc0.63.gc956
In-Reply-To: <11842671631744-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52326>

From: Sven Verdoolaege <skimo@kotnet.org>

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 builtin-name-rev.c |    1 -
 ctype.c            |    5 +++--
 git-compat-util.h  |    5 ++++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index 61eba34..b2ac40c 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -233,7 +233,6 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 				break;
 
 			for (p_start = p; *p; p++) {
-#define ishex(x) (isdigit((x)) || ((x) >= 'a' && (x) <= 'f'))
 				if (!ishex(*p))
 					forty = 0;
 				else if (++forty == 40 &&
diff --git a/ctype.c b/ctype.c
index ee06eb7..97b5724 100644
--- a/ctype.c
+++ b/ctype.c
@@ -6,7 +6,8 @@
 #include "cache.h"
 
 #define SS GIT_SPACE
-#define AA GIT_ALPHA
+#define HA GIT_HEXAL
+#define AA GIT_OTHAL
 #define DD GIT_DIGIT
 
 unsigned char sane_ctype[256] = {
@@ -16,7 +17,7 @@ unsigned char sane_ctype[256] = {
 	DD, DD, DD, DD, DD, DD, DD, DD, DD, DD,  0,  0,  0,  0,  0,  0,		/* 48-15 */
 	 0, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA,		/* 64-15 */
 	AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA,  0,  0,  0,  0,  0,		/* 80-15 */
-	 0, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA,		/* 96-15 */
+	 0, HA, HA, HA, HA, HA, HA, AA, AA, AA, AA, AA, AA, AA, AA, AA,		/* 96-15 */
 	AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA,  0,  0,  0,  0,  0,		/* 112-15 */
 	/* Nothing in the 128.. range */
 };
diff --git a/git-compat-util.h b/git-compat-util.h
index 362e040..1a36f4c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -325,12 +325,15 @@ static inline int has_extension(const char *filename, const char *ext)
 extern unsigned char sane_ctype[256];
 #define GIT_SPACE 0x01
 #define GIT_DIGIT 0x02
-#define GIT_ALPHA 0x04
+#define GIT_HEXAL 0x04
+#define GIT_OTHAL 0x08
+#define GIT_ALPHA (GIT_HEXAL | GIT_OTHAL)
 #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
 #define isspace(x) sane_istest(x,GIT_SPACE)
 #define isdigit(x) sane_istest(x,GIT_DIGIT)
 #define isalpha(x) sane_istest(x,GIT_ALPHA)
 #define isalnum(x) sane_istest(x,GIT_ALPHA | GIT_DIGIT)
+#define ishex(x) sane_istest(x,GIT_HEXAL | GIT_DIGIT)
 #define tolower(x) sane_case((unsigned char)(x), 0x20)
 #define toupper(x) sane_case((unsigned char)(x), 0)
 
-- 
1.5.3.rc0.100.ge60b4
