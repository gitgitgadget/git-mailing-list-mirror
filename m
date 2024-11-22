Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C873B1DE882
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 12:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732278780; cv=none; b=BgPMiyq9iLc9X5JAs8YRWkcjergqGC5yYIku6MADhklIk1jBkbN511Ba4IioM/AY1tMEB5scnOwlxuZSOOTv4sXelg61ZCOszH8sL8ptzX7cHInMVp/bwZcBLp2f3e9vwl1TMKCtzECwNs6aNukO4/xQAb2JGOjeGstUovbWkaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732278780; c=relaxed/simple;
	bh=wL1B3kE/YKcW02mzD8J/E6BsYujyTItoEWojtjYowV8=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=nPP1Pndldpc+Y8JZylmOtSTD0DwLDNubqO+vc18YaTe84V8eYkSqUY5HVEBHt/NNpBwe5Iy4vvcekasX9qc5j72da3ajBMmmB3KhkACmSBOTHHwIoqm7meKF1BAWjiKNtXdbWW1LR1bgH6v3RHrN+S+qEIRoPF7+hnUbHp4a2n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=O2QHHwxV; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="O2QHHwxV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=DLz1OJc5jAvqKMGIAjYA8wHl5npMYB3PQ15RurI1HuQ=;
 b=O2QHHwxVir7lDFVezbj8jlTSD6g+17HHNaiC/0HBq/sr22eiHpmfdFbim+tfNPQYFJMjXkAcXd2l
   N/aPW/ExPefVOjSQQz8OSQJdxJcLRZKCtu71/9KFQti4YTArbZbFY2YNt6AHZHv3IYu6bo0uE70r
   fShFT89ien7klYOo0se78jC1qL70Cq3ZR7kp4tfYU0BU3fd0pEgqYI1iLjhhXV4bezcm4tAKAa0U
   rqveZ1tYPu0nWt7S+i052slCVHGyaBR8iAPfcMaahJGDcZE+lqfWVfM8A7f9UIueVqo7km8tZYl9
   MRFw+tkHgtKop28pOGZUOIMYQTaCE/5rl4EKyQ==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SNC00FQJQUXVB90@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Fri, 22 Nov 2024 12:32:57 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v15 07/10] refs: add TRANSACTION_CREATE_EXISTS error
Date: Fri, 22 Nov 2024 13:28:48 +0100
Message-id: <20241122123138.66960-8-bence@ferdinandy.com>
In-reply-to: <20241122123138.66960-1-bence@ferdinandy.com>
References: <20241121225757.3877852-1-bence@ferdinandy.com>
 <20241122123138.66960-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAG/BPE2Gx8pkLvG8hopB4zX7FvKjrqK44Vl5GFUxSCbTi05zQ93/fmccNGAJtv9
 Ul6VMUbN6v80/W7C6h5NX+CTQkZJwKy9KOWUNNN+u0V+6WFXKKwoNDDmKiRS7JGU
 5CXMEv2CEtYhCPtdgKXfev+D4ujTrXSPR2t8Q0ynuy0YufPbgeyIWczK/hkKrdF3
 TGRoZ3u+UPnQJzw0Nkpyn4NX2JukD3dyCKfqAPUWF9rcQjvdXoYKru4y1YX8AQY3
 oUJlNfB8AVh4wG95Ta21P3VjtZgTzigTARF3/2TekfRM8rlTyoIeLpvBJbhPJku9
 Nt5EGLMW407RpMZAv13CC71Gs7mBUcZyDNfIvuuLIu9fu5Y2c1Esx3WF5rf9SOWD
 W6LJ+g6BgynH6XZBpNKVHP5zO/1hcEYATt94aLq2PQ3Lo1jzkpQc20wBk0R0NtUj
 zs96tQ/GpsRZ7BGCGB+isZLwUxHGpXGhs2MVqqoT1ApZOlDOgMWJxMsW

Currently there is only one special error for transaction, for when
there is a naming conflict, all other errors are dumped under a generic
error. Add a new special error case for when the caller requests the
reference to be updated only when it does not yet exist and the
reference actually does exist.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v4: new patch
    v5: no change
    v6: no change
    
    v7: - change commit prefix to be more in line with project standards
        - changed error checking to Karthik's suggestion
    
    v8: no change
    
    v9: - no change
    
    v10: no change
    
    v11: no change
    
    v12: no change
    
    v13: no change
    
    v14: no change
    
    v15: no change

 refs.h                  |  4 +++-
 refs/files-backend.c    | 24 ++++++++++++++++--------
 refs/reftable-backend.c |  6 ++++--
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/refs.h b/refs.h
index 5c46ac9f34..b243739e4b 100644
--- a/refs.h
+++ b/refs.h
@@ -773,8 +773,10 @@ int ref_transaction_verify(struct ref_transaction *transaction,
 
 /* Naming conflict (for example, the ref names A and A/B conflict). */
 #define TRANSACTION_NAME_CONFLICT -1
+/* When only creation was requested, but the ref already exists. */
+#define TRANSACTION_CREATE_EXISTS -2
 /* All other errors. */
-#define TRANSACTION_GENERIC_ERROR -2
+#define TRANSACTION_GENERIC_ERROR -3
 
 /*
  * Perform the preparatory stages of committing `transaction`. Acquire
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4cc43c32f2..23ae74089d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2501,14 +2501,18 @@ static int split_symref_update(struct ref_update *update,
 static int check_old_oid(struct ref_update *update, struct object_id *oid,
 			 struct strbuf *err)
 {
+	int ret = TRANSACTION_GENERIC_ERROR;
+
 	if (!(update->flags & REF_HAVE_OLD) ||
 		   oideq(oid, &update->old_oid))
 		return 0;
 
-	if (is_null_oid(&update->old_oid))
+	if (is_null_oid(&update->old_oid)) {
 		strbuf_addf(err, "cannot lock ref '%s': "
 			    "reference already exists",
 			    ref_update_original_update_refname(update));
+		ret = TRANSACTION_CREATE_EXISTS;
+	}
 	else if (is_null_oid(oid))
 		strbuf_addf(err, "cannot lock ref '%s': "
 			    "reference is missing but expected %s",
@@ -2521,7 +2525,7 @@ static int check_old_oid(struct ref_update *update, struct object_id *oid,
 			    oid_to_hex(oid),
 			    oid_to_hex(&update->old_oid));
 
-	return -1;
+	return ret;
 }
 
 /*
@@ -2601,9 +2605,11 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 					ret = TRANSACTION_GENERIC_ERROR;
 					goto out;
 				}
-			} else if  (check_old_oid(update, &lock->old_oid, err)) {
-				ret = TRANSACTION_GENERIC_ERROR;
-				goto out;
+			} else {
+				ret = check_old_oid(update, &lock->old_oid, err);
+				if  (ret) {
+					goto out;
+				}
 			}
 		} else {
 			/*
@@ -2634,9 +2640,11 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 				    update->old_target);
 			ret = TRANSACTION_GENERIC_ERROR;
 			goto out;
-		} else if  (check_old_oid(update, &lock->old_oid, err)) {
-			ret = TRANSACTION_GENERIC_ERROR;
-			goto out;
+		} else {
+			ret = check_old_oid(update, &lock->old_oid, err);
+			if  (ret) {
+				goto out;
+			}
 		}
 
 		/*
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index e8afcda1f9..965c17d795 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1208,10 +1208,13 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 				goto done;
 			}
 		} else if ((u->flags & REF_HAVE_OLD) && !oideq(&current_oid, &u->old_oid)) {
-			if (is_null_oid(&u->old_oid))
+			ret = TRANSACTION_NAME_CONFLICT;
+			if (is_null_oid(&u->old_oid)) {
 				strbuf_addf(err, _("cannot lock ref '%s': "
 						   "reference already exists"),
 					    ref_update_original_update_refname(u));
+				ret = TRANSACTION_CREATE_EXISTS;
+			}
 			else if (is_null_oid(&current_oid))
 				strbuf_addf(err, _("cannot lock ref '%s': "
 						   "reference is missing but expected %s"),
@@ -1223,7 +1226,6 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 					    ref_update_original_update_refname(u),
 					    oid_to_hex(&current_oid),
 					    oid_to_hex(&u->old_oid));
-			ret = -1;
 			goto done;
 		}
 
-- 
2.47.0.298.g52a96ec17b

