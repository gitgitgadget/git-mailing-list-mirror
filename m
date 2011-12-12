From: mhagger@alum.mit.edu
Subject: [PATCH v2 14/51] repack_without_ref(): remove temporary
Date: Mon, 12 Dec 2011 06:38:21 +0100
Message-ID: <1323668338-1764-15-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:42:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZyeU-0001E2-Gz
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:42:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753202Ab1LLFmC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:42:02 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34632 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140Ab1LLFj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:39:57 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8aR015577;
	Mon, 12 Dec 2011 06:39:41 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186875>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index ba7a8b0..2e7bc0c 100644
--- a/refs.c
+++ b/refs.c
@@ -1278,12 +1278,10 @@ static struct lock_file packlock;
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
@@ -1294,8 +1292,7 @@ static int repack_without_ref(const char *refname)
 	for (i = 0; i < packed->nr; i++) {
 		char line[PATH_MAX + 100];
 		int len;
-
-		ref = packed->refs[i];
+		struct ref_entry *ref = packed->refs[i];
 
 		if (!strcmp(refname, ref->name))
 			continue;
-- 
1.7.8
