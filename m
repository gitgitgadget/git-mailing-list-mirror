From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 18/20] delete_ref_loose(): inline function
Date: Thu, 25 Feb 2016 14:16:17 +0100
Message-ID: <663b630a54a4d497ee2b49a24c3a783a80761065.1456405699.git.mhagger@alum.mit.edu>
References: <cover.1456405698.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 14:17:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYvnB-000412-4r
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 14:17:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760603AbcBYNRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 08:17:09 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:64407 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760071AbcBYNRH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 08:17:07 -0500
X-AuditID: 1207440e-befff70000000398-87-56cefecc39fe
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 01.7A.00920.CCEFEC65; Thu, 25 Feb 2016 08:17:00 -0500 (EST)
Received: from michael.fritz.box (p548D63F1.dip0.t-ipconnect.de [84.141.99.241])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1PDGPrw024973
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 25 Feb 2016 08:16:59 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1456405698.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqHv237kwg92nGC3mbzrBaNF1pZvJ
	oqH3CrPFh7WH2Cx6J/eyWtxeMZ/Z4kdLD7MDu8ff9x+YPJ5un8Ls8eJ8hcez3j2MHhcvKXss
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oz5p9YyFczkqXi97TZ7A+MNzi5GTg4JAROJgzdf
	soDYQgJbGSUenM/pYuQCsk8wSRx8d4UNJMEmoCuxqKeZCcQWEVCTmNh2iAWkiFngEaNE1/7t
	jCAJYQFbicn9n8AaWARUJT4s3skOYvMKREks2rCCCWKbnETLj92sIDangIXExZPTmSE2m0us
	urGHfQIjzwJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFusZ6uZkleqkppZsYISHGt4Oxfb3M
	IUYBDkYlHt6I32fDhFgTy4orcw8xSnIwKYny7nl+LkyILyk/pTIjsTgjvqg0J7X4EKMEB7OS
	CO+Kv0A53pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IE7yaQRsGi1PTU
	irTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQDMQXA6MAJMUDtDfmH8je4oLEXKAoROspRkUp
	cV4ZkIQASCKjNA9uLCxxvGIUB/pSmLcFZDsPMOnAdb8CGswENHjmBrDBJYkIKakGRnaZWSd2
	79jKqX2CY9GU8t3TeYVMeX+tuvVF/b9FwO3V+ypUZXn/N3y2Z/EKDTi0c3bqJ6W5fs4dtg16
	y3r+l9yz/R/8YOUfh/cb4me7fL7704+nVaroQerDcz/zdx3ktDzdLLPr3f/Nk5Tm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287377>

It was hardly doing anything anymore.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 7e825bd..b137171 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2336,21 +2336,6 @@ static int repack_without_refs(struct string_list *refnames, struct strbuf *err)
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
 int delete_refs(struct string_list *refnames)
 {
 	struct strbuf err = STRBUF_INIT;
@@ -3257,9 +3242,13 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (update->flags & REF_DELETING) {
-			if (delete_ref_loose(update->lock, update->type, err)) {
-				ret = TRANSACTION_GENERIC_ERROR;
-				goto cleanup;
+			if (!(update->type & REF_ISPACKED) ||
+			    update->type & REF_ISSYMREF) {
+				/* It is a loose reference. */
+				if (unlink_or_msg(git_path("%s", update->lock->ref_name), err)) {
+					ret = TRANSACTION_GENERIC_ERROR;
+					goto cleanup;
+				}
 			}
 
 			if (!(update->flags & REF_ISPRUNING))
-- 
2.7.0
