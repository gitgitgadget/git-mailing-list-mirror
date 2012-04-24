From: mhagger@alum.mit.edu
Subject: [PATCH 19/30] get_ref_dir(): remove dirname argument
Date: Wed, 25 Apr 2012 00:45:25 +0200
Message-ID: <1335307536-26914-20-git-send-email-mhagger@alum.mit.edu>
References: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 00:57:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMogF-0000SK-6U
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 00:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485Ab2DXW5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 18:57:44 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:60973 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758441Ab2DXW47 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 18:56:59 -0400
Received: from michael.berlin.jpk.com (unknown [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id 25A9B248165;
	Wed, 25 Apr 2012 00:46:17 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196275>

From: Michael Haggerty <mhagger@alum.mit.edu>

The dirname can be determined from the direntry argument.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 2057380..bc4a69b 100644
--- a/refs.c
+++ b/refs.c
@@ -768,16 +768,14 @@ void add_packed_ref(const char *refname, const unsigned char *sha1)
 }
 
 /*
- * Read the loose references for refs from the namespace dirname.
- * dirname must end with '/'.  direntry must be the directory entry
- * corresponding to dirname.
+ * Read the loose references for direntry in refs.
  */
-static void get_ref_dir(struct ref_cache *refs, const char *dirname,
-			struct ref_entry *direntry)
+static void get_ref_dir(struct ref_cache *refs, struct ref_entry *direntry)
 {
 	DIR *d;
 	const char *path;
 	struct dirent *de;
+	const char *dirname = direntry->name;
 	int dirnamelen = strlen(dirname);
 	struct strbuf refname;
 
@@ -813,7 +811,7 @@ static void get_ref_dir(struct ref_cache *refs, const char *dirname,
 			/* Silently ignore. */
 		} else if (S_ISDIR(st.st_mode)) {
 			strbuf_addch(&refname, '/');
-			get_ref_dir(refs, refname.buf,
+			get_ref_dir(refs,
 				    search_for_subdir(&direntry->u.subdir,
 						      refname.buf, 1));
 		} else {
@@ -841,7 +839,7 @@ static struct ref_entry *get_loose_refs(struct ref_cache *refs)
 {
 	if (!refs->loose) {
 		refs->loose = create_dir_entry("");
-		get_ref_dir(refs, "refs/",
+		get_ref_dir(refs,
 			    search_for_subdir(&refs->loose->u.subdir,
 					      "refs/", 1));
 	}
-- 
1.7.10
