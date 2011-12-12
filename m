From: mhagger@alum.mit.edu
Subject: [PATCH v2 42/51] search_ref_dir(): take (ref_entry *) instead of (ref_dir *)
Date: Mon, 12 Dec 2011 06:38:49 +0100
Message-ID: <1323668338-1764-43-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:42:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZyeF-00015m-Sz
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179Ab1LLFld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:41:33 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34961 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085Ab1LLFkx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:40:53 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8at015577;
	Mon, 12 Dec 2011 06:40:45 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186870>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index d89c3d0..30ff9b8 100644
--- a/refs.c
+++ b/refs.c
@@ -246,11 +246,14 @@ static void sort_ref_dir(struct ref_dir *dir);
  * Return the entry with the given refname from the ref_dir
  * (non-recursively).  Return NULL if no such entry is found.
  */
-static struct ref_entry *search_ref_dir(struct ref_dir *dir, const char *refname)
+static struct ref_entry *search_ref_dir(struct ref_entry *direntry, const char *refname)
 {
 	struct ref_entry *e, **r;
 	int len;
+	struct ref_dir *dir;
 
+	assert(direntry->flag & REF_DIR);
+	dir = &direntry->u.subdir;
 	if (refname == NULL || !dir->nr)
 		return NULL;
 
@@ -300,7 +303,7 @@ static struct ref_entry *find_containing_direntry(struct ref_entry *direntry,
 		char tmp = slash[1];
 		struct ref_entry *entry;
 		slash[1] = '\0';
-		entry = search_ref_dir(&direntry->u.subdir, refname_copy);
+		entry = search_ref_dir(direntry, refname_copy);
 		if (!entry) {
 			if (!mkdir) {
 				direntry = NULL;
@@ -330,7 +333,7 @@ static struct ref_entry *find_ref(struct ref_entry *direntry, const char *refnam
 	direntry = find_containing_direntry(direntry, refname, 0);
 	if (!direntry)
 		return NULL;
-	entry = search_ref_dir(&direntry->u.subdir, refname);
+	entry = search_ref_dir(direntry, refname);
 	return (entry && !(entry->flag & REF_DIR)) ? entry : NULL;
 }
 
-- 
1.7.8
