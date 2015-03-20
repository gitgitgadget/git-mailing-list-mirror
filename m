From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 06/16] refs: convert for_each_ref_submodule to struct object_id
Date: Fri, 20 Mar 2015 19:28:26 +0000
Message-ID: <1426879716-47835-7-git-send-email-sandals@crustytoothpaste.net>
References: <1426879716-47835-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 20:29:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ2bP-0001gd-Vo
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 20:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbbCTT2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 15:28:54 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50657 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751129AbbCTT2t (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2015 15:28:49 -0400
Received: from vauxhall.crustytoothpaste.net (wsip-184-177-1-73.no.no.cox.net [184.177.1.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A832D28097;
	Fri, 20 Mar 2015 19:28:48 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1426879716-47835-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: 0.163 () BAYES_00,RDNS_DYNAMIC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265943>

Convert the callers as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 refs.c     | 4 ++--
 refs.h     | 2 +-
 revision.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 75d8970..758bdd9 100644
--- a/refs.c
+++ b/refs.c
@@ -1964,9 +1964,9 @@ int for_each_ref(each_ref_fn fn, void *cb_data)
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
index 6c4a8c0..d3ff0b1 100644
--- a/refs.h
+++ b/refs.h
@@ -106,7 +106,7 @@ extern int for_each_glob_ref(each_ref_fn, const char *pattern, void *);
 extern int for_each_glob_ref_in(each_ref_fn, const char *pattern, const char* prefix, void *);
 
 extern int head_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data);
-extern int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
+extern int for_each_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data);
 extern int for_each_ref_in_submodule(const char *submodule, const char *prefix,
 		each_ref_fn_oid fn, void *cb_data);
 extern int for_each_tag_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data);
diff --git a/revision.c b/revision.c
index 7b05c89..c2d8b1c 100644
--- a/revision.c
+++ b/revision.c
@@ -2099,7 +2099,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	 * register it in the list at the top of handle_revision_opt.
 	 */
 	if (!strcmp(arg, "--all")) {
-		handle_refs(submodule, revs, *flags, for_each_ref_submodule);
+		handle_refs_oid(submodule, revs, *flags, for_each_ref_submodule);
 		handle_refs_oid(submodule, revs, *flags, head_ref_submodule);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--branches")) {
-- 
2.2.1.209.g41e5f3a
