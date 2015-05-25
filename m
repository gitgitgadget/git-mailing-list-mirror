From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 37/56] handle_one_reflog(): rewrite to take an object_id argument
Date: Mon, 25 May 2015 18:39:03 +0000
Message-ID: <1432579162-411464-38-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:41:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxJs-0001dP-Bm
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbbEYSlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:41:45 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50690 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750837AbbEYSkY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:24 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A7882280A1;
	Mon, 25 May 2015 18:40:23 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269883>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 revision.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index cfe3876..1d903cf 100644
--- a/revision.c
+++ b/revision.c
@@ -1293,7 +1293,8 @@ static int handle_one_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	return 0;
 }
 
-static int handle_one_reflog(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static int handle_one_reflog(const char *path, const struct object_id *oid,
+			     int flag, void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
 	cb->warned_bad_reflog = 0;
@@ -1305,12 +1306,10 @@ static int handle_one_reflog(const char *path, const unsigned char *sha1, int fl
 void add_reflogs_to_pending(struct rev_info *revs, unsigned flags)
 {
 	struct all_refs_cb cb;
-	struct each_ref_fn_sha1_adapter wrapped_handle_one_reflog =
-		{handle_one_reflog, &cb};
 
 	cb.all_revs = revs;
 	cb.all_flags = flags;
-	for_each_reflog(each_ref_fn_adapter, &wrapped_handle_one_reflog);
+	for_each_reflog(handle_one_reflog, &cb);
 }
 
 static void add_cache_tree(struct cache_tree *it, struct rev_info *revs,
-- 
2.4.0
