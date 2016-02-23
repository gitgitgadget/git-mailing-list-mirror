From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] refs: reduce the visibility of do_for_each_ref()
Date: Tue, 23 Feb 2016 00:39:13 +0000
Message-ID: <56CBAA31.7030809@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 01:39:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY10i-0004Tj-9I
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 01:39:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756631AbcBWAjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 19:39:24 -0500
Received: from avasout01.plus.net ([84.93.230.227]:52933 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755859AbcBWAjX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 19:39:23 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout01 with smtp
	id McfL1s0064mu3xa01cfMSs; Tue, 23 Feb 2016 00:39:22 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bsGxfxui c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=7pY-7TPnZjXjs4SiriQA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287004>


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi David,

Again, If you need to re-roll your 'dt/refs-backend-lmdb' branch ...

Thanks!

ATB,
Ramsay Jones

 refs.c               | 16 ++++++++--------
 refs/refs-internal.h |  6 ------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index 337f110..bf70876 100644
--- a/refs.c
+++ b/refs.c
@@ -1236,6 +1236,14 @@ static int get_affected_refnames(struct ref_transaction *transaction,
 	return 0;
 }
 
+static int do_for_each_ref(const char *submodule, const char *base,
+			   each_ref_fn fn, int trim, int flags,
+			   void *cb_data)
+{
+	return the_refs_backend->do_for_each_ref(submodule, base, fn, trim,
+						 flags, cb_data);
+}
+
 int for_each_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(NULL, "", fn, 0, 0, cb_data);
@@ -1501,14 +1509,6 @@ int resolve_gitlink_ref(const char *path, const char *refname,
 	return the_refs_backend->resolve_gitlink_ref(path, refname, sha1);
 }
 
-int do_for_each_ref(const char *submodule, const char *base,
-		    each_ref_fn fn, int trim, int flags,
-		    void *cb_data)
-{
-	return the_refs_backend->do_for_each_ref(submodule, base, fn, trim,
-						 flags, cb_data);
-}
-
 int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn,
 				void *cb_data)
 {
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index ced6af4..4922e25 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -227,12 +227,6 @@ int do_for_each_per_worktree_ref(const char *submodule, const char *base,
 				 each_ref_fn fn, int trim, int flags,
 				 void *cb_data);
 
-/*
- * The common backend for the for_each_*ref* functions
- */
-int do_for_each_ref(const char *submodule, const char *base,
-		    each_ref_fn fn, int trim, int flags, void *cb_data);
-
 /* refs backends */
 typedef int ref_init_db_fn(int shared, struct strbuf *err);
 typedef int ref_transaction_commit_fn(struct ref_transaction *transaction,
-- 
2.7.0
