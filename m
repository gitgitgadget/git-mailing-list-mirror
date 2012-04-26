From: mhagger@alum.mit.edu
Subject: [PATCH v2 13/18] read_loose_refs(): rename function from get_ref_dir()
Date: Fri, 27 Apr 2012 00:27:02 +0200
Message-ID: <1335479227-7877-14-git-send-email-mhagger@alum.mit.edu>
References: <1335479227-7877-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 00:27:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNXAI-0008Gp-Bm
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 00:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759519Ab2DZW1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 18:27:37 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:37135 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758989Ab2DZW1f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 18:27:35 -0400
Received: from michael.berlin.jpk.com (michael2.berlin.jpk.com [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id CDF0F24813F;
	Fri, 27 Apr 2012 00:27:33 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335479227-7877-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196432>

From: Michael Haggerty <mhagger@alum.mit.edu>

The new name better describes the function's purpose, and also makes
the old name available for a more suitable purpose.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index de14e75..1d18ae6 100644
--- a/refs.c
+++ b/refs.c
@@ -769,8 +769,8 @@ void add_packed_ref(const char *refname, const unsigned char *sha1)
  * dirname must end with '/'.  dir must be the directory entry
  * corresponding to dirname.
  */
-static void get_ref_dir(struct ref_cache *refs, const char *dirname,
-			struct ref_dir *dir)
+static void read_loose_refs(struct ref_cache *refs, const char *dirname,
+			    struct ref_dir *dir)
 {
 	DIR *d;
 	const char *path;
@@ -808,8 +808,8 @@ static void get_ref_dir(struct ref_cache *refs, const char *dirname,
 			/* Silently ignore. */
 		} else if (S_ISDIR(st.st_mode)) {
 			strbuf_addch(&refname, '/');
-			get_ref_dir(refs, refname.buf,
-				    &search_for_subdir(dir, refname.buf, 1)->u.subdir);
+			read_loose_refs(refs, refname.buf,
+					&search_for_subdir(dir, refname.buf, 1)->u.subdir);
 		} else {
 			if (*refs->name) {
 				hashclr(sha1);
@@ -835,9 +835,9 @@ static struct ref_dir *get_loose_refs(struct ref_cache *refs)
 {
 	if (!refs->loose) {
 		refs->loose = create_dir_entry("");
-		get_ref_dir(refs, "refs/",
-			    &search_for_subdir(&refs->loose->u.subdir,
-					       "refs/", 1)->u.subdir);
+		read_loose_refs(refs, "refs/",
+				&search_for_subdir(&refs->loose->u.subdir,
+						   "refs/", 1)->u.subdir);
 	}
 	return &refs->loose->u.subdir;
 }
-- 
1.7.10
