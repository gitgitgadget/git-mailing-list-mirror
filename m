From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 24/38] repack_without_refs(): add a files_ref_store argument
Date: Fri,  3 Jun 2016 23:03:59 +0200
Message-ID: <7ee1796e8cdfe95c043663f2c1446944012467d6.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:05:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wHo-00013O-0Y
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbcFCVFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:05:38 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:60912 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932945AbcFCVFK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:05:10 -0400
X-AuditID: 12074411-e2bff70000000955-c8-5751f1048924
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 67.79.02389.401F1575; Fri,  3 Jun 2016 17:05:08 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4Kco003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:05:06 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsUixO6iqMvyMTDc4EWTksX8TScYLbqudDNZ
	NPReYba4vWI+s0X3lLeMFj9aepgtZl61tjjzppHRgcPj7/sPTB47Z91l93jWu4fR4+IlZY/9
	S7exeSx+4OWx4Pl9do/Pm+QCOKK4bZISS8qCM9Pz9O0SuDPefZ3GXLCRr+L+7AdsDYx3uLsY
	OTgkBEwkOv56djFycggJbGWUmPfUAsI+ziRx7l0OiM0moCuxqKeZCcQWEYiQaHjVwtjFyMXB
	LDCHSeL2w05mkISwgI/E/+XrGUFmsgioSmz54w9i8gpESWybKAlSISEgJ3F5+gM2EJtTwEKi
	5fMqVohV5hKNpw6zTGDkWcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11QvN7NELzWldBMj
	JNgEdzDOOCl3iFGAg1GJh/fEi8BwIdbEsuLK3EOMkhxMSqK8e+8AhfiS8lMqMxKLM+KLSnNS
	iw8xSnAwK4nwprwGyvGmJFZWpRblw6SkOViUxHn5lqj7CQmkJ5akZqemFqQWwWRlODiUJHgX
	vQdqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAeFfnwxMPhBUjxAe2NA2nmLCxJz
	gaIQracYFaXEeUNBEgIgiYzSPLixsBTyilEc6Eth3jkgVTzA9APX/QpoMBPQ4IJH/iCDSxIR
	UlINjHPWHFgQ+DZNX+vK3PpPFzt4pyrxib1/E/U437BId//282dc17Cfi5+8YrFUxQedm3tl
	7IQEf60/t1t1+dXfe0pDz17cst1Nfvt5Ja0HE5/J/X76gMe7Umrh3X+nM+46bPp/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296387>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 91dcfcb..48b37fa 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2388,14 +2388,14 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
  *
  * The refs in 'refnames' needn't be sorted. `err` must not be NULL.
  */
-static int repack_without_refs(struct string_list *refnames, struct strbuf *err)
+static int repack_without_refs(struct files_ref_store *refs,
+			       struct string_list *refnames, struct strbuf *err)
 {
-	struct files_ref_store *refs =
-		get_files_ref_store(NULL, "repack_without_refs");
 	struct ref_dir *packed;
 	struct string_list_item *refname;
 	int ret, needs_repacking = 0, removed = 0;
 
+	assert_main_repository(&refs->base, "repack_without_refs");
 	assert(err);
 
 	/* Look for a packed ref */
@@ -2457,13 +2457,15 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 
 int delete_refs(struct string_list *refnames, unsigned int flags)
 {
+	struct files_ref_store *refs =
+		get_files_ref_store(NULL, "delete_refs");
 	struct strbuf err = STRBUF_INIT;
 	int i, result = 0;
 
 	if (!refnames->nr)
 		return 0;
 
-	result = repack_without_refs(refnames, &err);
+	result = repack_without_refs(refs, refnames, &err);
 	if (result) {
 		/*
 		 * If we failed to rewrite the packed-refs file, then
@@ -3773,7 +3775,7 @@ static int files_transaction_commit(struct ref_store *ref_store,
 		}
 	}
 
-	if (repack_without_refs(&refs_to_delete, err)) {
+	if (repack_without_refs(refs, &refs_to_delete, err)) {
 		ret = TRANSACTION_GENERIC_ERROR;
 		goto cleanup;
 	}
-- 
2.8.1
