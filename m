Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F1F1AA1E7
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944043; cv=none; b=Rr3NLJb2rFQqa/F+LXO515a8rWGwc2C/Bc7SKx+FkRO+OlcdGgyvlrnkE2BpmaClZH8wMOo3f1pJBzv5keS3ewgL0QZS/M6aRPFyp9zhRw1rmeEJa6cSuTo8HqbtdP25bd6QoTbpmU7GrTQbBNZaHr6FSsrT+6U4ahnOvXsJry4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944043; c=relaxed/simple;
	bh=pLK5b0YNVVVheJj9E8hupcCeCAHUxIxGlRiO+8DSJ7s=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=TO39Sh5YsLbNz55TsEErxvrpHhSj0VcffpeMRgEP03Iw2CSGGc566Dry4BaiKksSyfuoBBCoUe1OC81P13aqCZVbPwdXn+bevWlNMkaCwLw3UlFe1QcJ8n/LGb4O20AU5icG36ZX/HDnHgSD3APzZRxc0oUuxiFHeLi8inha0yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=qID1gq5r; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="qID1gq5r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=Z/5pzN4QNdN+w7fyEoUS6LNASjCShAXJK5+seRkhh2E=;
 b=qID1gq5r4n5WHTJM1Jr2l8AwDaCmqLgSKhUmW6lheyoDjRGoSrEwcYNy6ouze2GYHVxe2p4sDzua
   Oc3lxnQH3Cv4SOIXOKRdc/xYliOEhY2kZCXUREVb4SKT6VEwxN6xfkFTFbf3f9nO2bBN2rWMRKhs
   R70OnrP/C8nyFgu6ghDwZ4FR0/lrQpHtNwAZXJyOIvkTnV4jVoYmCUVlQNDiYNWU8qrOubtT35Hw
   kIyiNxQv97pOhSFFXO37aL6Vin3Ksqw3XoDie4WShkiyk5l4Q+xYsAntT3IJN00hnW26M1GEAv8B
   j8C68okYrVjuiotNCL71nlwaBpiJr2iOn02EKg==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SN500N2HKKOTF90@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 18 Nov 2024 15:34:00 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v13 6/9] refs: add TRANSACTION_CREATE_EXISTS error
Date: Mon, 18 Nov 2024 16:09:25 +0100
Message-id: <20241118151755.756265-7-bence@ferdinandy.com>
In-reply-to: <20241118151755.756265-1-bence@ferdinandy.com>
References: <20241023153736.257733-1-bence@ferdinandy.com>
 <20241118151755.756265-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAFvTuQ4QnxnNFVnn7+iC2xfXYfLionyixwsJlGteyHBnL0/Z3kkHEL/JVBOjy1C
 YIE7yhfq6ogUbW6gQDk4AhqB5i6nsjAkPr/z2C1L2rST9OKu6gN92/O1aoMOJaCH
 UeX9Bi1ZebzSISQbhPmKDSLU5AtLDWBzARcoYtWEdikHBAiOH0OWZSb031ulJEzr
 7FuI9aFCuzeM9r2a/tpqBWv/7DFD3jarTalBtMRIqq/kDwOsx9/SwP7TgKwteEiw
 2Oy5OKURG+ha+8WGTk34uOhlmd011bGaxhFRKxVNuWHmA6s9JlmKmN8aLlV/7NWU
 RFBkK0pSUBLZdvOTWlCcRUqjNy6yNDLLLwesWylY6B4VRTXCa/JjqvxU3erRpIg6
 my8wB9C8hNI6vnA43+J/jHHDFPW+4s5bLB8Fd4+dLeF9LunqWPkHBo46uAcvTl8m
 /yjFG4N1qRO7nFPGVF6XOJZhMcZyB/qPBcIyxtH8Qi/MNRb/QOygWeV0

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

 refs.h                  |  4 +++-
 refs/files-backend.c    | 24 ++++++++++++++++--------
 refs/reftable-backend.c |  6 ++++--
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/refs.h b/refs.h
index 92622e807d..6a32f82f8c 100644
--- a/refs.h
+++ b/refs.h
@@ -768,8 +768,10 @@ int ref_transaction_verify(struct ref_transaction *transaction,
 
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
index 81e650ec48..86674705a7 100644
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
index 60cb83f23a..4f2e615eae 100644
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
2.47.0.296.gda1ecfef29.dirty

