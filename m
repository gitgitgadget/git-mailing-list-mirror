From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 47/56] send_ref(): convert local variable "peeled" to object_id
Date: Mon, 25 May 2015 18:39:13 +0000
Message-ID: <1432579162-411464-48-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:41:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxJl-0001Zq-5z
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbbEYSl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:41:28 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50751 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751498AbbEYSkc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:32 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id DF95028093;
	Mon, 25 May 2015 18:40:31 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269880>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 upload-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 929284f..1cb9a94 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -717,7 +717,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 		" side-band-64k ofs-delta shallow no-progress"
 		" include-tag multi_ack_detailed";
 	const char *refname_nons = strip_namespace(refname);
-	unsigned char peeled[20];
+	struct object_id peeled;
 
 	if (mark_our_ref(refname, oid))
 		return 0;
@@ -738,8 +738,8 @@ static int send_ref(const char *refname, const struct object_id *oid,
 		packet_write(1, "%s %s\n", oid_to_hex(oid), refname_nons);
 	}
 	capabilities = NULL;
-	if (!peel_ref(refname, peeled))
-		packet_write(1, "%s %s^{}\n", sha1_to_hex(peeled), refname_nons);
+	if (!peel_ref(refname, peeled.hash))
+		packet_write(1, "%s %s^{}\n", oid_to_hex(&peeled), refname_nons);
 	return 0;
 }
 
-- 
2.4.0
