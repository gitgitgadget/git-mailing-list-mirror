Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 794362078D
	for <e@80x24.org>; Sat, 31 Dec 2016 03:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754706AbcLaDNw (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Dec 2016 22:13:52 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:53315 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754663AbcLaDNe (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 30 Dec 2016 22:13:34 -0500
X-AuditID: 12074411-fa3ff700000009b7-5e-5867225dee94
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 25.63.02487.D5227685; Fri, 30 Dec 2016 22:13:33 -0500 (EST)
Received: from bagpipes.fritz.box (p5B104C0E.dip0.t-ipconnect.de [91.16.76.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBV3D6uC010692
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 30 Dec 2016 22:13:32 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 18/23] delete_ref_loose(): inline function
Date:   Sat, 31 Dec 2016 04:12:58 +0100
Message-Id: <428b760cc6110ea89a47056b88bf36a7e7517fd4.1483153436.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483153436.git.mhagger@alum.mit.edu>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsUixO6iqBurlB5hcOMDv0XXlW4mi4beK8wW
        t1fMZ7ZY8vA1s8WPlh5mB1aPv+8/MHl0tR9h83jWu4fR4+IlZY/Pm+QCWKO4bFJSczLLUov0
        7RK4Mj5u/cBYsImnomnyX7YGxkecXYycHBICJhJ7171l6mLk4hASuMwocaN5LpRznEni4Nx/
        bCBVbAK6Eot6mplAbBEBNYmJbYdYQIqYBSYySkzbcgkowcEhLGArcblDAaSGRUBV4tm7ycwg
        Nq9AlMSdpqXsENvkJC5t+wIW5xSwkFj8qQ9sppCAucS6nZeYJzDyLGBkWMUol5hTmqubm5iZ
        U5yarFucnJiXl1qka6qXm1mil5pSuokREjqCOxhnnJQ7xCjAwajEw/vgRlqEEGtiWXFl7iFG
        SQ4mJVFeS8vUCCG+pPyUyozE4oz4otKc1OJDjBIczEoivAvl0iOEeFMSK6tSi/JhUtIcLEri
        vHxL1P2EBNITS1KzU1MLUotgsjIcHEoSvAqKQI2CRanpqRVpmTklCGkmDk6Q4TxAw/1BaniL
        CxJzizPTIfKnGBWlxHnXKgAlBEASGaV5cL2w2H7FKA70ijDvLpB2HmBagOt+BTSYCWiwWk4y
        yOCSRISUVAOjW2lU0zOzzx0L92+f+k9hx8IrOa85pqquE42KbTM28vPleKHwtaZ7H4OyZUxz
        3tJXU4RmK25U391cNuVMpe0jp37zSx3vTh3nlPU0Tl5fnu8/s05G+9L13tDjvsaNjR2L39Vd
        SfEQDkrbM3X59otZ4eo5W1Y/XHeLbb/t/oftL6f/zp2YG1ikxFKckWioxVxUnAgAfxH2M8gC
        AAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was hardly doing anything anymore, and had only one caller.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 847af81..e81c8a9 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2421,21 +2421,6 @@ static int repack_without_refs(struct files_ref_store *refs,
 	return ret;
 }
 
-static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
-{
-	assert(err);
-
-	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
-		/*
-		 * loose.  The loose file name is the same as the
-		 * lockfile name, minus ".lock":
-		 */
-		if (unlink_or_msg(git_path("%s", lock->ref_name), err))
-			return 1;
-	}
-	return 0;
-}
-
 static int files_delete_refs(struct ref_store *ref_store,
 			     struct string_list *refnames, unsigned int flags)
 {
@@ -3787,9 +3772,13 @@ static int files_transaction_commit(struct ref_store *ref_store,
 
 		if (update->flags & REF_DELETING &&
 		    !(update->flags & REF_LOG_ONLY)) {
-			if (delete_ref_loose(lock, update->type, err)) {
-				ret = TRANSACTION_GENERIC_ERROR;
-				goto cleanup;
+			if (!(update->type & REF_ISPACKED) ||
+			    update->type & REF_ISSYMREF) {
+				/* It is a loose reference. */
+				if (unlink_or_msg(git_path("%s", lock->ref_name), err)) {
+					ret = TRANSACTION_GENERIC_ERROR;
+					goto cleanup;
+				}
 			}
 
 			if (!(update->flags & REF_ISPRUNING))
-- 
2.9.3

