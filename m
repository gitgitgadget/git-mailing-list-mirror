From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 28/56] append_similar_ref(): rewrite to take an object_id argument
Date: Mon, 25 May 2015 18:38:54 +0000
Message-ID: <1432579162-411464-29-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:42:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxKC-0001mx-6b
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbbEYSmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:42:00 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50678 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751290AbbEYSkT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:19 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id B460528093;
	Mon, 25 May 2015 18:40:18 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269889>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 help.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/help.c b/help.c
index f813093..6f3415b 100644
--- a/help.c
+++ b/help.c
@@ -407,7 +407,7 @@ struct similar_ref_cb {
 	struct string_list *similar_refs;
 };
 
-static int append_similar_ref(const char *refname, const unsigned char *sha1,
+static int append_similar_ref(const char *refname, const struct object_id *oid,
 			      int flags, void *cb_data)
 {
 	struct similar_ref_cb *cb = (struct similar_ref_cb *)(cb_data);
@@ -425,12 +425,10 @@ static struct string_list guess_refs(const char *ref)
 {
 	struct similar_ref_cb ref_cb;
 	struct string_list similar_refs = STRING_LIST_INIT_NODUP;
-	struct each_ref_fn_sha1_adapter wrapped_append_similar_ref =
-		{append_similar_ref, &ref_cb};
 
 	ref_cb.base_ref = ref;
 	ref_cb.similar_refs = &similar_refs;
-	for_each_ref(each_ref_fn_adapter, &wrapped_append_similar_ref);
+	for_each_ref(append_similar_ref, &ref_cb);
 	return similar_refs;
 }
 
-- 
2.4.0
