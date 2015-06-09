From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 2/8] sha1_file: introduce has_object_file helper.
Date: Tue,  9 Jun 2015 16:28:30 +0000
Message-ID: <1433867316-663554-3-git-send-email-sandals@crustytoothpaste.net>
References: <1433867316-663554-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 18:29:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2MP6-0001Qc-B7
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 18:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753741AbbFIQ3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 12:29:18 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:38333 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753153AbbFIQ3O (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2015 12:29:14 -0400
Received: from vauxhall.crustytoothpaste.net (107-1-110-101-ip-static.hfc.comcastbusiness.net [107.1.110.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id B4C8028093;
	Tue,  9 Jun 2015 16:29:13 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1433867316-663554-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -1.5 BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271193>

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
index 7e38148..09f7f03 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3173,6 +3173,11 @@ int has_sha1_file(const unsigned char *sha1)
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
