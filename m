From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 27/38] lock_ref_for_update(): add a files_ref_store argument
Date: Fri,  3 Jun 2016 23:04:02 +0200
Message-ID: <f9b7e6a1979e91115a549e94b365a3196ff5e3f5.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:06:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wI5-0001HP-5X
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbcFCVF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:05:56 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:58656 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932550AbcFCVFP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:05:15 -0400
X-AuditID: 1207440e-ef3ff700000008c5-cc-5751f109eedf
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 61.78.02245.901F1575; Fri,  3 Jun 2016 17:05:13 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4Kcr003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:05:12 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsUixO6iqMv1MTDcoPk+i8X8TScYLbqudDNZ
	NPReYba4vWI+s0X3lLeMFj9aepgtZl61tjjzppHRgcPj7/sPTB47Z91l93jWu4fR4+IlZY/9
	S7exeSx+4OWx4Pl9do/Pm+QCOKK4bZISS8qCM9Pz9O0SuDM23T3NUjCLt+LA6qnsDYynuLoY
	OTkkBEwkTt2fywZiCwlsZZRYO0G0i5ELyD7OJNH65DFYgk1AV2JRTzMTiC0iECHR8KqFEaSI
	WWAOk8Tth53MIAlhAR+JBbMms4LYLAKqEvM2TGAEsXkFoiR6O+cyQmyTk7g8/QHYUE4BC4mW
	z6tYITabSzSeOswygZFnASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdY73czBK91JTSTYyQ
	oOPbwdi+XuYQowAHoxIPb8GzwHAh1sSy4srcQ4ySHExKorx77wCF+JLyUyozEosz4otKc1KL
	DzFKcDArifCmvAbK8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeBe9
	B2oULEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB8VAfDEwCkBSPEB7uT+A7C0uSMwF
	ikK0nmJUlBLnPQQyVwAkkVGaBzcWlkpeMYoDfSnM2w/SzgNMQ3Ddr4AGMwENLnjkDzK4JBEh
	JdXA2Chs/S3ZsoxnZeLHlnUP9omdztr5NLv980WHRe0XX1bri6/5/fTvd7mI6aznz5rbt8se
	c26OWrydwSTAibstY9rM5r7P3qd/mlxcMPPtxV+iEZ8Fi4v1i6pqCv+XbI0rWury 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296392>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index bc7d250..225e0af 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3485,20 +3485,21 @@ static const char *original_update_refname(struct ref_update *update)
  * - If it is an update of head_ref, add a corresponding REF_LOG_ONLY
  *   update of HEAD.
  */
-static int lock_ref_for_update(struct ref_update *update,
+static int lock_ref_for_update(struct files_ref_store *refs,
+			       struct ref_update *update,
 			       struct ref_transaction *transaction,
 			       const char *head_ref,
 			       struct string_list *affected_refnames,
 			       struct strbuf *err)
 {
-	struct files_ref_store *refs =
-		get_files_ref_store(NULL, "lock_ref_for_update");
 	struct strbuf referent = STRBUF_INIT;
 	int mustexist = (update->flags & REF_HAVE_OLD) &&
 		!is_null_sha1(update->old_sha1);
 	int ret;
 	struct ref_lock *lock;
 
+	assert_main_repository(&refs->base, "lock_ref_for_update");
+
 	if ((update->flags & REF_HAVE_NEW) && is_null_sha1(update->new_sha1))
 		update->flags |= REF_DELETING;
 
@@ -3724,8 +3725,8 @@ static int files_transaction_commit(struct ref_store *ref_store,
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = updates[i];
 
-		ret = lock_ref_for_update(update, transaction, head_ref,
-					  &affected_refnames, err);
+		ret = lock_ref_for_update(refs, update, transaction,
+					  head_ref, &affected_refnames, err);
 		if (ret)
 			goto cleanup;
 	}
-- 
2.8.1
