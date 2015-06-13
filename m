From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 07/10] push_refs_with_export: convert to struct object_id
Date: Sat, 13 Jun 2015 22:16:40 +0000
Message-ID: <1434233803-422442-8-git-send-email-sandals@crustytoothpaste.net>
References: <1434233803-422442-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 00:17:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3tjw-0002tS-P9
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 00:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807AbbFMWRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 18:17:11 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:42872 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751237AbbFMWQw (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2015 18:16:52 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E57E528098;
	Sat, 13 Jun 2015 22:16:51 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1434233803-422442-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -0.99 ALL_TRUSTED,T_FILL_THIS_FORM_SHORT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271596>

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 transport-helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 4ca3e80..1f28b82 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -877,13 +877,13 @@ static int push_refs_with_export(struct transport *transport,
 
 	for (ref = remote_refs; ref; ref = ref->next) {
 		char *private;
-		unsigned char sha1[20];
+		struct object_id oid;
 
 		private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
-		if (private && !get_sha1(private, sha1)) {
+		if (private && !get_sha1(private, oid.hash)) {
 			strbuf_addf(&buf, "^%s", private);
 			string_list_append(&revlist_args, strbuf_detach(&buf, NULL));
-			hashcpy(ref->old_oid.hash, sha1);
+			oidcpy(&ref->old_oid, &oid);
 		}
 		free(private);
 
@@ -897,7 +897,7 @@ static int push_refs_with_export(struct transport *transport,
 					name = resolve_ref_unsafe(
 						 ref->peer_ref->name,
 						 RESOLVE_REF_READING,
-						 sha1, &flag);
+						 oid.hash, &flag);
 					if (!name || !(flag & REF_ISSYMREF))
 						name = ref->peer_ref->name;
 
-- 
2.4.0
