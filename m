From: mhagger@alum.mit.edu
Subject: [PATCH 27/30] read_loose_refs(): rename function from get_ref_dir()
Date: Wed, 25 Apr 2012 00:45:33 +0200
Message-ID: <1335307536-26914-28-git-send-email-mhagger@alum.mit.edu>
References: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 00:57:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMogD-0000SK-0w
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 00:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758460Ab2DXW46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 18:56:58 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:60962 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758439Ab2DXW44 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 18:56:56 -0400
Received: from michael.berlin.jpk.com (unknown [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id D959B248174;
	Wed, 25 Apr 2012 00:46:25 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196273>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 11ebc02..0f5aab2 100644
--- a/refs.c
+++ b/refs.c
@@ -791,7 +791,7 @@ void add_packed_ref(const char *refname, const unsigned char *sha1)
 /*
  * Read the loose references for direntry in refs.
  */
-static void get_ref_dir(struct ref_cache *refs, struct ref_entry *direntry)
+static void read_loose_refs(struct ref_cache *refs, struct ref_entry *direntry)
 {
 	DIR *d;
 	const char *path;
@@ -832,9 +832,9 @@ static void get_ref_dir(struct ref_cache *refs, struct ref_entry *direntry)
 			/* Silently ignore. */
 		} else if (S_ISDIR(st.st_mode)) {
 			strbuf_addch(&refname, '/');
-			get_ref_dir(refs,
-				    search_for_subdir(direntry,
-						      refname.buf, 1));
+			read_loose_refs(refs,
+					search_for_subdir(direntry,
+							  refname.buf, 1));
 		} else {
 			if (*refs->name) {
 				hashclr(sha1);
@@ -860,8 +860,8 @@ static struct ref_entry *get_loose_refs(struct ref_cache *refs)
 {
 	if (!refs->loose) {
 		refs->loose = create_dir_entry(refs, "");
-		get_ref_dir(refs,
-			    search_for_subdir(refs->loose, "refs/", 1));
+		read_loose_refs(refs,
+				search_for_subdir(refs->loose, "refs/", 1));
 	}
 	return refs->loose;
 }
-- 
1.7.10
