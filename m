From: Namhyung Kim <namhyung.kim@lge.com>
Subject: [PATCH 2/2] ctype: implement islower/isupper macro
Date: Fri, 10 Feb 2012 11:13:31 +0900
Message-ID: <1328840011-19028-2-git-send-email-namhyung.kim@lge.com>
References: <1328840011-19028-1-git-send-email-namhyung.kim@lge.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 03:13:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvfzN-0001jT-HA
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 03:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757893Ab2BJCNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 21:13:25 -0500
Received: from LGEMRELSE6Q.lge.com ([156.147.1.121]:50856 "EHLO
	LGEMRELSE6Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754005Ab2BJCNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 21:13:25 -0500
X-AuditID: 9c930179-b7cf1ae000000e40-72-4f3479aefd20
Received: from MultiCore.156.147.1.1 ( [165.186.175.80])
	by LGEMRELSE6Q.lge.com (Symantec Brightmail Gateway) with SMTP id CE.1C.03648.EA9743F4; Fri, 10 Feb 2012 10:58:06 +0900 (KST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1328840011-19028-1-git-send-email-namhyung.kim@lge.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190366>

The git-compat-util.h provides various ctype macros but lacks those two
(along with others). Add them.

Signed-off-by: Namhyung Kim <namhyung.kim@lge.com>
---
 git-compat-util.h |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 8f3972c..d3f8f17 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -463,6 +463,8 @@ static inline int has_extension(const char *filename, const char *ext)
 #undef isdigit
 #undef isalpha
 #undef isalnum
+#undef islower
+#undef isupper
 #undef tolower
 #undef toupper
 extern unsigned char sane_ctype[256];
@@ -478,6 +480,8 @@ extern unsigned char sane_ctype[256];
 #define isdigit(x) sane_istest(x,GIT_DIGIT)
 #define isalpha(x) sane_istest(x,GIT_ALPHA)
 #define isalnum(x) sane_istest(x,GIT_ALPHA | GIT_DIGIT)
+#define islower(x) sane_iscase(x, 1)
+#define isupper(x) sane_iscase(x, 0)
 #define is_glob_special(x) sane_istest(x,GIT_GLOB_SPECIAL)
 #define is_regex_special(x) sane_istest(x,GIT_GLOB_SPECIAL | GIT_REGEX_SPECIAL)
 #define tolower(x) sane_case((unsigned char)(x), 0x20)
@@ -491,6 +495,17 @@ static inline int sane_case(int x, int high)
 	return x;
 }
 
+static inline int sane_iscase(int x, int lower)
+{
+	if (!sane_istest(x, GIT_ALPHA))
+		return 0;
+
+	if (lower)
+		return (x & 0x20) != 0;
+	else
+		return (x & 0x20) == 0;
+}
+
 static inline int strtoul_ui(char const *s, int base, unsigned int *result)
 {
 	unsigned long ul;
-- 
1.7.9
