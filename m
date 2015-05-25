From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 54/56] each_ref_fn_adapter(): remove adapter
Date: Mon, 25 May 2015 18:39:20 +0000
Message-ID: <1432579162-411464-55-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:41:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxJO-0001Mp-2X
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbbEYSlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:41:05 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50787 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751523AbbEYSki (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:38 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2A46C280A2;
	Mon, 25 May 2015 18:40:35 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269874>

From: Michael Haggerty <mhagger@alum.mit.edu>

All of the callers of the for_each_ref family of functions have now
been rewritten to work with object_ids, so this adapter is no longer
needed.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 refs.c |  8 --------
 refs.h | 11 -----------
 2 files changed, 19 deletions(-)

diff --git a/refs.c b/refs.c
index 43dce01..162760c 100644
--- a/refs.c
+++ b/refs.c
@@ -2176,14 +2176,6 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
-int each_ref_fn_adapter(const char *refname,
-			const struct object_id *oid, int flags, void *cb_data)
-{
-	struct each_ref_fn_sha1_adapter *cb = cb_data;
-
-	return cb->original_fn(refname, oid->hash, flags, cb->original_cb_data);
-}
-
 const char *prettify_refname(const char *name)
 {
 	return name + (
diff --git a/refs.h b/refs.h
index 4042109..8c3d433 100644
--- a/refs.h
+++ b/refs.h
@@ -69,17 +69,6 @@ struct ref_transaction;
 typedef int each_ref_fn(const char *refname,
 			const struct object_id *oid, int flags, void *cb_data);
 
-typedef int each_ref_sha1_fn(const char *refname,
-			     const unsigned char *sha1, int flags, void *cb_data);
-
-struct each_ref_fn_sha1_adapter {
-	each_ref_sha1_fn *original_fn;
-	void *original_cb_data;
-};
-
-extern int each_ref_fn_adapter(const char *refname,
-			       const struct object_id *oid, int flags, void *cb_data);
-
 /*
  * The following functions invoke the specified callback function for
  * each reference indicated.  If the function ever returns a nonzero
-- 
2.4.0
