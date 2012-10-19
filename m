From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] tree-walk: use enum interesting instead of integer
Date: Sat, 20 Oct 2012 00:14:42 +0700
Message-ID: <1350666882-30138-1-git-send-email-pclouds@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 19 19:15:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPGAA-0002v4-Ah
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 19:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757949Ab2JSRO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 13:14:59 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:47588 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab2JSRO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 13:14:58 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so516431pad.19
        for <git@vger.kernel.org>; Fri, 19 Oct 2012 10:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=TsKofaxc7d5DJI0SHYHBQOjNgCFSmPNVSfsNDZRR6Zk=;
        b=TJS0ooJ6PJSWfW/qLa3EsW6EIYGmToOigUcATE/EgGS3Hy5j5lM3wq5RnH7PX84HO8
         vv0cez26XU7JQ+nsR9LRO7ObanFOjWbUJdUECAYKT+hbj/2NgDkGUgndWcPEDvJsozNJ
         SG5ZI3UJz9EFPXpq/ZmXhOVZZeVH/yTi8+BFbdZRUAIUfLnPzM4Kp44g9vhxOKJ+8mia
         0snvJkadu7/I1H+lPi7VdRU1h0lVOj4hbc1hQJ1bkVBz1DOWtRiEP9JFWraZoSdMSBDb
         n9D+rdFN3b9iC1UoFgN161taRhGrk5Vx859woQvkoWSQSc/LFG4kA/8L6WYx9OKDvECc
         nIFQ==
Received: by 10.68.253.102 with SMTP id zz6mr7569129pbc.99.1350666897665;
        Fri, 19 Oct 2012 10:14:57 -0700 (PDT)
Received: from lanh ([115.74.57.39])
        by mx.google.com with ESMTPS id nt7sm1503618pbb.33.2012.10.19.10.14.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 19 Oct 2012 10:14:56 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 20 Oct 2012 00:14:51 +0700
X-Mailer: git-send-email 1.8.0.rc2.22.gad9383a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208052>

Commit d688cf0 (tree_entry_interesting(): give meaningful names to
return values - 2011-10-24) converts most of the tree_entry_interesting
values to the new enum, except "never_interesting". This completes the
conversion.
---
 tree-walk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 0e49299..42fe610 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -490,11 +490,11 @@ int get_tree_entry(const unsigned char *tree_sha1, const char *name, unsigned ch
 
 static int match_entry(const struct name_entry *entry, int pathlen,
 		       const char *match, int matchlen,
-		       int *never_interesting)
+		       enum interesting *never_interesting)
 {
 	int m = -1; /* signals that we haven't called strncmp() */
 
-	if (*never_interesting) {
+	if (*never_interesting != entry_not_interesting) {
 		/*
 		 * We have not seen any match that sorts later
 		 * than the current path.
@@ -522,7 +522,7 @@ static int match_entry(const struct name_entry *entry, int pathlen,
 		 * the variable to -1 and that is what will be
 		 * returned, allowing the caller to terminate early.
 		 */
-		*never_interesting = 0;
+		*never_interesting = entry_not_interesting;
 	}
 
 	if (pathlen > matchlen)
@@ -584,7 +584,7 @@ enum interesting tree_entry_interesting(const struct name_entry *entry,
 {
 	int i;
 	int pathlen, baselen = base->len - base_offset;
-	int never_interesting = ps->has_wildcard ?
+	enum interesting never_interesting = ps->has_wildcard ?
 		entry_not_interesting : all_entries_not_interesting;
 
 	if (!ps->nr) {
-- 
1.8.0.rc2.22.gad9383a
