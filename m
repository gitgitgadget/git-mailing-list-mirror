From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 06/16] refs: convert for_each_ref_submodule to struct object_id
Date: Wed, 22 Apr 2015 23:24:11 +0000
Message-ID: <1429745061-295908-7-git-send-email-sandals@crustytoothpaste.net>
References: <1429745061-295908-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 01:25:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl413-000415-70
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 01:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965571AbbDVXZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 19:25:07 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:44758 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758572AbbDVXYa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2015 19:24:30 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1909D282A6;
	Wed, 22 Apr 2015 23:24:30 +0000 (UTC)
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1429745061-295908-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267666>

Convert the callers as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 refs.c     | 4 ++--
 refs.h     | 2 +-
 revision.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 7a8b579..68d0af8 100644
--- a/refs.c
+++ b/refs.c
@@ -2014,9 +2014,9 @@ int for_each_ref(each_ref_fn fn, void *cb_data)
 	return do_for_each_ref(&ref_cache, "", fn, 0, 0, cb_data);
 }
 
-int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+int for_each_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data)
 {
-	return do_for_each_ref(get_ref_cache(submodule), "", fn, 0, 0, cb_data);
+	return do_for_each_ref_oid(get_ref_cache(submodule), "", fn, 0, 0, cb_data);
 }
 
 int for_each_ref_in(const char *prefix, each_ref_fn_oid fn, void *cb_data)
diff --git a/refs.h b/refs.h
index a14e7ef..2476951 100644
--- a/refs.h
+++ b/refs.h
@@ -97,7 +97,7 @@ extern int for_each_glob_ref(each_ref_fn, const char *pattern, void *);
 extern int for_each_glob_ref_in(each_ref_fn, const char *pattern, const char* prefix, void *);
 
 extern int head_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data);
-extern int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
+extern int for_each_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data);
 extern int for_each_ref_in_submodule(const char *submodule, const char *prefix,
 		each_ref_fn_oid fn, void *cb_data);
 extern int for_each_tag_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data);
diff --git a/revision.c b/revision.c
index 19005e8..825fbba 100644
--- a/revision.c
+++ b/revision.c
@@ -2116,7 +2116,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	 * register it in the list at the top of handle_revision_opt.
 	 */
 	if (!strcmp(arg, "--all")) {
-		handle_refs(submodule, revs, *flags, for_each_ref_submodule);
+		handle_refs_oid(submodule, revs, *flags, for_each_ref_submodule);
 		handle_refs_oid(submodule, revs, *flags, head_ref_submodule);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--branches")) {
-- 
2.3.5
