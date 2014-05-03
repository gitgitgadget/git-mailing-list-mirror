From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 1/9] Define a structure for object IDs.
Date: Sat,  3 May 2014 20:12:14 +0000
Message-ID: <1399147942-165308-2-git-send-email-sandals@crustytoothpaste.net>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 22:12:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WggIS-0002kw-Vg
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 22:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300AbaECUM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 16:12:29 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47527 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752193AbaECUM1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 May 2014 16:12:27 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 93AE628088
	for <git@vger.kernel.org>; Sat,  3 May 2014 20:12:26 +0000 (UTC)
X-Mailer: git-send-email 2.0.0.rc0
In-Reply-To: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 () ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248047>

Many places throughout the code use "unsigned char [20]" to store object IDs
(SHA-1 values).  This leads to lots of hardcoded numbers throughout the
codebase.  It also leads to confusion about the purposes of a buffer.

Introduce a structure for object IDs.  This allows us to obtain the benefits
of compile-time checking for misuse.  The structure is expected to remain
the same size and have the same alignment requirements on all known
platforms, compared to the array of unsigned char.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 object.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/object.h b/object.h
index 6e12f2c..6a9680d 100644
--- a/object.h
+++ b/object.h
@@ -1,6 +1,17 @@
 #ifndef OBJECT_H
 #define OBJECT_H
 
+/*
+ * The length in bytes and in hex digits of an object name (SHA-1 value).
+ * These are the same names used by libgit2.
+ */
+#define GIT_OID_RAWSZ 20
+#define GIT_OID_HEXSZ 40
+
+struct object_id {
+	unsigned char oid[GIT_OID_RAWSZ];
+};
+
 struct object_list {
 	struct object *item;
 	struct object_list *next;
@@ -49,7 +60,7 @@ struct object {
 	unsigned used : 1;
 	unsigned type : TYPE_BITS;
 	unsigned flags : FLAG_BITS;
-	unsigned char sha1[20];
+	unsigned char sha1[GIT_OID_RAWSZ];
 };
 
 extern const char *typename(unsigned int type);
-- 
2.0.0.rc0
