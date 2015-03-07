From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 01/10] Define a structure for object IDs.
Date: Sat,  7 Mar 2015 23:23:56 +0000
Message-ID: <1425770645-628957-2-git-send-email-sandals@crustytoothpaste.net>
References: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Andreas Schwab <schwab@linux-m68k.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 00:24:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUO4z-0001T5-W0
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 00:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753167AbbCGXYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2015 18:24:19 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49819 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752975AbbCGXYP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Mar 2015 18:24:15 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id CC82028092;
	Sat,  7 Mar 2015 23:24:14 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265011>

Many places throughout the code use "unsigned char [20]" to store object IDs
(SHA-1 values).  This leads to lots of hardcoded numbers throughout the
codebase.  It also leads to confusion about the purposes of a buffer.

Introduce a structure for object IDs.  This allows us to obtain the benefits
of compile-time checking for misuse.  The structure is expected to remain
the same size and have the same alignment requirements on all known
platforms, compared to the array of unsigned char, although this is not
required for correctness.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 object.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/object.h b/object.h
index 6416247..f99b502 100644
--- a/object.h
+++ b/object.h
@@ -1,6 +1,14 @@
 #ifndef OBJECT_H
 #define OBJECT_H
 
+/* The length in bytes and in hex digits of an object name (SHA-1 value). */
+#define GIT_SHA1_RAWSZ 20
+#define GIT_SHA1_HEXSZ 40
+
+struct object_id {
+	unsigned char sha1[GIT_SHA1_RAWSZ];
+};
+
 struct object_list {
 	struct object *item;
 	struct object_list *next;
-- 
2.2.1.209.g41e5f3a
