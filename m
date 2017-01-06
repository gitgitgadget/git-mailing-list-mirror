Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A36D1FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 16:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967487AbdAFQXl (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 11:23:41 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:54540 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967337AbdAFQX0 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Jan 2017 11:23:26 -0500
X-AuditID: 12074413-44dff70000000a33-cd-586fc47d815b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 3D.A8.02611.D74CF685; Fri,  6 Jan 2017 11:23:25 -0500 (EST)
Received: from bagpipes.fritz.box (p57906F4E.dip0.t-ipconnect.de [87.144.111.78])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v06GMmX9023262
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 6 Jan 2017 11:23:23 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 19/23] delete_ref_loose(): inline function
Date:   Fri,  6 Jan 2017 17:22:39 +0100
Message-Id: <17c81b14014932c31c22812f499a93a7afce88ac.1483719289.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483719289.git.mhagger@alum.mit.edu>
References: <cover.1483719289.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsUixO6iqFt7JD/CoOcln0XXlW4mi4beK8wW
        uxf3M1vcXjGf2WLJw9fMFj9aepgtOqfKOrB7/H3/gclj56y77B7Ll65j9OhqP8Lm8ax3D6PH
        xUvKHp83yQWwR3HZpKTmZJalFunbJXBl7P0iVLCJp2Lz5g72BsZHnF2MnBwSAiYSv19fYeti
        5OIQErjMKHHl5G4WCOcEk8TZA19YQKrYBHQlFvU0M4HYIgJqEhPbDoEVMQt8YJT41TmLHSQh
        LGAr8e75GkYQm0VAVeJ9M8hYTg5egSiJEz/7WSDWyUlc2vaFGcTmFLCQaNz1DaxeSMBc4tPE
        w8wTGHkWMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI118vNLNFLTSndxAgJMOEdjLtOyh1i
        FOBgVOLhjfDKixBiTSwrrsw9xCjJwaQkyhvmmB8hxJeUn1KZkVicEV9UmpNafIhRgoNZSYTX
        7hBQjjclsbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEkwfsHpFGwKDU9tSIt
        M6cEIc3EwQkynAdouOBhkOHFBYm5xZnpEPlTjIpS4rxbQJoFQBIZpXlwvbAE8IpRHOgVYd4g
        kHYeYPKA634FNJgJZLAn2OCSRISUVAPjwv+cAZ2GAqaWCQl6K3k+Bd3wuSe0bEsck+Kfs2vW
        2J3/c9B6dpaOfGBBHrfVv3M/zswOK7dJmJfVv0pkjYIxb16CLlvb0/w/yXsnnmXTy2x2iXiT
        +mitGde+l8+kXx95//xx9MP6d/99lm6Y1DCf29LTm+Vbw8WrGQHP92W2OkXNf3NmZ3iJEktx
        RqKhFnNRcSIApmYjItsCAAA=
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
index 4d55364..9abd7c3 100644
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
@@ -3788,9 +3773,13 @@ static int files_transaction_commit(struct ref_store *ref_store,
 
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

