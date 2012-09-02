From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH 3/9] Rename cryptic 'which' variable to more consistent name
Date: Sun,  2 Sep 2012 01:12:05 +0100
Message-ID: <1346544731-938-4-git-send-email-git@adamspiers.org>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 02 02:19:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7xuv-00016s-SE
	for gcvg-git-2@plane.gmane.org; Sun, 02 Sep 2012 02:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906Ab2IBAS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 20:18:57 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:55518 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624Ab2IBAS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 20:18:56 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 6CB812E5E7;
	Sun,  2 Sep 2012 01:12:15 +0100 (BST)
X-Mailer: git-send-email 1.7.12.155.ge5750d5.dirty
In-Reply-To: <1346544731-938-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204653>

'el' is only *slightly* less cryptic, but is already used as the
variable name for a struct exclude_list pointer in numerous other
places, so this reduces the number of cryptic variable names in use by
one :-)

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 dir.c | 10 +++++-----
 dir.h |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/dir.c b/dir.c
index c9f341a..57a5d11 100644
--- a/dir.c
+++ b/dir.c
@@ -311,7 +311,7 @@ static int no_wildcard(const char *string)
 }
 
 void add_exclude(const char *string, const char *base,
-		 int baselen, struct exclude_list *which)
+		 int baselen, struct exclude_list *el)
 {
 	struct exclude *x;
 	size_t len;
@@ -346,8 +346,8 @@ void add_exclude(const char *string, const char *base,
 	x->nowildcardlen = simple_length(string);
 	if (*string == '*' && no_wildcard(string+1))
 		x->flags |= EXC_FLAG_ENDSWITH;
-	ALLOC_GROW(which->excludes, which->nr + 1, which->alloc);
-	which->excludes[which->nr++] = x;
+	ALLOC_GROW(el->excludes, el->nr + 1, el->alloc);
+	el->excludes[el->nr++] = x;
 }
 
 static void *read_skip_worktree_file_from_index(const char *path, size_t *size)
@@ -389,7 +389,7 @@ int add_excludes_from_file_to_list(const char *fname,
 				   const char *base,
 				   int baselen,
 				   char **buf_p,
-				   struct exclude_list *which,
+				   struct exclude_list *el,
 				   int check_index)
 {
 	struct stat st;
@@ -436,7 +436,7 @@ int add_excludes_from_file_to_list(const char *fname,
 		if (buf[i] == '\n') {
 			if (entry != buf + i && entry[0] != '#') {
 				buf[i - (i && buf[i-1] == '\r')] = 0;
-				add_exclude(entry, base, baselen, which);
+				add_exclude(entry, base, baselen, el);
 			}
 			entry = buf + i + 1;
 		}
diff --git a/dir.h b/dir.h
index a226fbc..549a187 100644
--- a/dir.h
+++ b/dir.h
@@ -117,10 +117,10 @@ extern int path_excluded(struct path_exclude_check *, const char *, int namelen,
 
 
 extern int add_excludes_from_file_to_list(const char *fname, const char *base, int baselen,
-					  char **buf_p, struct exclude_list *which, int check_index);
+					  char **buf_p, struct exclude_list *el, int check_index);
 extern void add_excludes_from_file(struct dir_struct *, const char *fname);
 extern void add_exclude(const char *string, const char *base,
-			int baselen, struct exclude_list *which);
+			int baselen, struct exclude_list *el);
 extern void free_excludes(struct exclude_list *el);
 extern int file_exists(const char *);
 
-- 
1.7.12.155.ge5750d5.dirty
