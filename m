From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 44/56] find_symref(): rewrite to take an object_id argument
Date: Mon, 25 May 2015 18:39:10 +0000
Message-ID: <1432579162-411464-45-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:40:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxIu-00013c-Fm
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbbEYSkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:40:45 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50739 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751487AbbEYSkb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:31 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7A32A2809B;
	Mon, 25 May 2015 18:40:30 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269864>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 upload-pack.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 52fab23..96dbedc 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -741,8 +741,8 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	return 0;
 }
 
-static int find_symref(const char *refname, const unsigned char *sha1, int flag,
-		       void *cb_data)
+static int find_symref(const char *refname, const struct object_id *oid,
+		       int flag, void *cb_data)
 {
 	const char *symref_target;
 	struct string_list_item *item;
@@ -761,10 +761,8 @@ static int find_symref(const char *refname, const unsigned char *sha1, int flag,
 static void upload_pack(void)
 {
 	struct string_list symref = STRING_LIST_INIT_DUP;
-	struct each_ref_fn_sha1_adapter wrapped_find_symref =
-		{find_symref, &symref};
 
-	head_ref_namespaced(each_ref_fn_adapter, &wrapped_find_symref);
+	head_ref_namespaced(find_symref, &symref);
 
 	if (advertise_refs || !stateless_rpc) {
 		struct each_ref_fn_sha1_adapter wrapped_send_ref =
-- 
2.4.0
