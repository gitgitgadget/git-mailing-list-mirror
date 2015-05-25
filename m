From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 33/56] string_list_add_one_ref(): rewrite to take an object_id argument
Date: Mon, 25 May 2015 18:38:59 +0000
Message-ID: <1432579162-411464-34-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:42:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxKI-0001pW-8g
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbbEYSl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:41:57 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50686 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751442AbbEYSkW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:22 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 3821228099;
	Mon, 25 May 2015 18:40:21 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269891>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 notes.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/notes.c b/notes.c
index baa1c41..df08209 100644
--- a/notes.c
+++ b/notes.c
@@ -918,7 +918,7 @@ out:
 	return ret;
 }
 
-static int string_list_add_one_ref(const char *refname, const unsigned char *sha1,
+static int string_list_add_one_ref(const char *refname, const struct object_id *oid,
 				   int flag, void *cb)
 {
 	struct string_list *refs = cb;
@@ -932,12 +932,9 @@ static int string_list_add_one_ref(const char *refname, const unsigned char *sha
  */
 void string_list_add_refs_by_glob(struct string_list *list, const char *glob)
 {
-	struct each_ref_fn_sha1_adapter wrapped_string_list_add_one_ref =
-		{string_list_add_one_ref, list};
-
 	assert(list->strdup_strings);
 	if (has_glob_specials(glob)) {
-		for_each_glob_ref(each_ref_fn_adapter, glob, &wrapped_string_list_add_one_ref);
+		for_each_glob_ref(string_list_add_one_ref, glob, list);
 	} else {
 		unsigned char sha1[20];
 		if (get_sha1(glob, sha1))
-- 
2.4.0
