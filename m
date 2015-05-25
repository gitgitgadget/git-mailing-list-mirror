From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 42/56] write_refs_to_temp_dir(): convert local variable sha1 to object_id
Date: Mon, 25 May 2015 18:39:08 +0000
Message-ID: <1432579162-411464-43-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:40:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxIs-00013c-Ik
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbbEYSkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:40:41 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50732 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751481AbbEYSka (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:30 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7706928093;
	Mon, 25 May 2015 18:40:29 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269863>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 transport.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/transport.c b/transport.c
index 58cb9ed..df87386 100644
--- a/transport.c
+++ b/transport.c
@@ -299,18 +299,18 @@ static int write_one_ref(const char *name, const unsigned char *sha1,
 }
 
 static int write_refs_to_temp_dir(struct strbuf *temp_dir,
-		int refspec_nr, const char **refspec)
+				  int refspec_nr, const char **refspec)
 {
 	int i;
 
 	for (i = 0; i < refspec_nr; i++) {
-		unsigned char sha1[20];
+		struct object_id oid;
 		char *ref;
 
-		if (dwim_ref(refspec[i], strlen(refspec[i]), sha1, &ref) != 1)
+		if (dwim_ref(refspec[i], strlen(refspec[i]), oid.hash, &ref) != 1)
 			return error("Could not get ref %s", refspec[i]);
 
-		if (write_one_ref(ref, sha1, 0, temp_dir)) {
+		if (write_one_ref(ref, oid.hash, 0, temp_dir)) {
 			free(ref);
 			return -1;
 		}
-- 
2.4.0
