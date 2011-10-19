From: mhagger@alum.mit.edu
Subject: [PATCH 02/12] repack_without_ref(): remove temporary
Date: Wed, 19 Oct 2011 23:44:42 +0200
Message-ID: <1319060692-27216-3-git-send-email-mhagger@alum.mit.edu>
References: <1319060692-27216-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 23:45:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGdwt-00006A-1w
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 23:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754639Ab1JSVpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 17:45:14 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:33119 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754452Ab1JSVpN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 17:45:13 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RGdqr-0004K1-Ek; Wed, 19 Oct 2011 23:39:05 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319060692-27216-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183970>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

Trivial and boring.

 refs.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index f6752a4..431d3c6 100644
--- a/refs.c
+++ b/refs.c
@@ -1190,12 +1190,10 @@ static struct lock_file packlock;
 static int repack_without_ref(const char *refname)
 {
 	struct ref_array *packed;
-	struct ref_entry *ref;
 	int fd, i;
 
 	packed = get_packed_refs(get_ref_cache(NULL));
-	ref = search_ref_array(packed, refname);
-	if (ref == NULL)
+	if (search_ref_array(packed, refname) == NULL)
 		return 0;
 	fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0);
 	if (fd < 0) {
@@ -1206,8 +1204,7 @@ static int repack_without_ref(const char *refname)
 	for (i = 0; i < packed->nr; i++) {
 		char line[PATH_MAX + 100];
 		int len;
-
-		ref = packed->refs[i];
+		struct ref_entry *ref = packed->refs[i];
 
 		if (!strcmp(refname, ref->name))
 			continue;
-- 
1.7.7
