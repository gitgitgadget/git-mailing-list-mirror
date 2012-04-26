From: mhagger@alum.mit.edu
Subject: [PATCH v2 17/18] read_loose_refs(): eliminate ref_cache argument
Date: Fri, 27 Apr 2012 00:27:06 +0200
Message-ID: <1335479227-7877-18-git-send-email-mhagger@alum.mit.edu>
References: <1335479227-7877-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 00:27:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNXAK-0008Gp-2T
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 00:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756035Ab2DZW1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 18:27:42 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:37164 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759512Ab2DZW1l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 18:27:41 -0400
Received: from michael.berlin.jpk.com (michael2.berlin.jpk.com [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id 7FE3024813F;
	Fri, 27 Apr 2012 00:27:40 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335479227-7877-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196435>

From: Michael Haggerty <mhagger@alum.mit.edu>

The ref_cache can now be read from the ref_dir.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 110e801..a0c687f 100644
--- a/refs.c
+++ b/refs.c
@@ -785,9 +785,9 @@ void add_packed_ref(const char *refname, const unsigned char *sha1)
  * dirname must end with '/'.  dir must be the directory entry
  * corresponding to dirname.
  */
-static void read_loose_refs(struct ref_cache *refs, const char *dirname,
-			    struct ref_dir *dir)
+static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 {
+	struct ref_cache *refs = dir->ref_cache;
 	DIR *d;
 	const char *path;
 	struct dirent *de;
@@ -824,7 +824,7 @@ static void read_loose_refs(struct ref_cache *refs, const char *dirname,
 			/* Silently ignore. */
 		} else if (S_ISDIR(st.st_mode)) {
 			strbuf_addch(&refname, '/');
-			read_loose_refs(refs, refname.buf,
+			read_loose_refs(refname.buf,
 					search_for_subdir(dir, refname.buf, 1));
 		} else {
 			if (*refs->name) {
@@ -851,7 +851,7 @@ static struct ref_dir *get_loose_refs(struct ref_cache *refs)
 {
 	if (!refs->loose) {
 		refs->loose = create_dir_entry(refs, "");
-		read_loose_refs(refs, "refs/",
+		read_loose_refs("refs/",
 				search_for_subdir(get_ref_dir(refs->loose),
 						  "refs/", 1));
 	}
-- 
1.7.10
