From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 02/10] sha1_file: introduce has_object_file helper.
Date: Sat, 13 Jun 2015 22:16:35 +0000
Message-ID: <1434233803-422442-3-git-send-email-sandals@crustytoothpaste.net>
References: <1434233803-422442-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 00:17:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3tjr-0002tS-Pp
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 00:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbbFMWQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 18:16:53 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:42852 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751150AbbFMWQu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2015 18:16:50 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 211C228093;
	Sat, 13 Jun 2015 22:16:50 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1434233803-422442-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -1 ALL_TRUSTED
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271599>

Add has_object_file, which is a wrapper around has_sha1_file, but for
struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h     | 3 +++
 sha1_file.c | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/cache.h b/cache.h
index 571c98f..fa1f067 100644
--- a/cache.h
+++ b/cache.h
@@ -946,6 +946,9 @@ extern int has_sha1_pack(const unsigned char *sha1);
  */
 extern int has_sha1_file(const unsigned char *sha1);
 
+/* Same as the above, except for struct object_id. */
+extern int has_object_file(const struct object_id *oid);
+
 /*
  * Return true iff an alternate object database has a loose object
  * with the specified name.  This function does not respect replace
diff --git a/sha1_file.c b/sha1_file.c
index 5038475..2bad0cd 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3180,6 +3180,11 @@ int has_sha1_file(const unsigned char *sha1)
 	return find_pack_entry(sha1, &e);
 }
 
+int has_object_file(const struct object_id *oid)
+{
+	return has_sha1_file(oid->hash);
+}
+
 static void check_tree(const void *buf, size_t size)
 {
 	struct tree_desc desc;
-- 
2.4.0
