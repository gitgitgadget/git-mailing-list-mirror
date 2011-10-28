From: mhagger@alum.mit.edu
Subject: [PATCH 19/28] search_ref_dir(): take (ref_entry *) instead of (ref_dir *)
Date: Fri, 28 Oct 2011 14:28:32 +0200
Message-ID: <1319804921-17545-20-git-send-email-mhagger@alum.mit.edu>
References: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 14:31:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJlaM-0004R6-F1
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 14:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932701Ab1J1Ma4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 08:30:56 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:55806 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932552Ab1J1May (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 08:30:54 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJlRw-0007Ud-O9; Fri, 28 Oct 2011 14:22:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184386>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 35b3ff2..e91cc15 100644
--- a/refs.c
+++ b/refs.c
@@ -288,11 +288,14 @@ static void sort_ref_dir(struct ref_dir *dir);
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
 
@@ -342,7 +345,7 @@ static struct ref_entry *find_containing_direntry(struct ref_entry *direntry,
 		char tmp = slash[1];
 		struct ref_entry *entry;
 		slash[1] = '\0';
-		entry = search_ref_dir(&direntry->u.subdir, refname_copy);
+		entry = search_ref_dir(direntry, refname_copy);
 		if (!entry) {
 			if (!mkdir) {
 				direntry = NULL;
@@ -372,7 +375,7 @@ static struct ref_entry *find_ref(struct ref_entry *direntry, const char *refnam
 	direntry = find_containing_direntry(direntry, refname, 0);
 	if (!direntry)
 		return NULL;
-	entry = search_ref_dir(&direntry->u.subdir, refname);
+	entry = search_ref_dir(direntry, refname);
 	return (entry && !(entry->flag & REF_DIR)) ? entry : NULL;
 }
 
-- 
1.7.7
