Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB70B1D89E2
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 22:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728946542; cv=none; b=RFHa5ql/JoZGsNJBYGTm+kdxnHTWi7gsCO/q4ZWIKQfL0EizYagEbGny5UmQP1AD3lCNSPQGLJuSUFj9m5dCh3Z0UKcCjYWBLqMdU8KMoIOS6kNtZ0pwkjo5Sq4Wtr3Vxcl6AUd+V7zhgYs5uIK4RVa6Ui96yvpU99t6vUNPbfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728946542; c=relaxed/simple;
	bh=pOJgOjo3fdR9oHe4WnAsQat3Tvvu7AuN4KT0BFSK7yk=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=oT7M4h8iatnjeyxUYJQzVJ2I0xTUcCglILIbeTlKOkqk4VJ1XKBmB2jVNKtCc5Gc9a8HFZQTuTk/3NZfB52X3NOxBYGh3984ccbdf8gA+dI6bLLob+jF7Pu1aMK7bnmeybyLH3UN4sQjossb5Yro+JcOYH/fmJM0g7FsI0R4IyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=eVIDG+cW; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="eVIDG+cW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=SBqfR8s00AfVK6FadKRCPg3nePwCminbF4sw5R8x0E8=;
 b=eVIDG+cWNmqMPY9R9X2Q1TPDo/8OHQjh7djLR+qyk2FQNDEFNQyLN9yFSA/rGKvi+nnpKj1rFQwM
   zKHoeYUecXCHTpVvOdFH9NRynrrpfe59tu1wyDaxkOkkmiswZjSkCLj4S0x2oPdlriTPsqArwnsl
   9HCpyEm/QybKMehPQPQqAiHCZAkUi1yOq3BlggBOmMX2WigYXvVt7L1W3M4In4UN0OJn801SOtJQ
   RybQg/1cwDzp42M0nWA/snEb0Fw//e0WnDU5xcEZeqIwRTW3L5nGOgSZDl3betgmQ1XRP8FCnNh1
   fTle6hLkdActxAgN2NCRDOYSb27ZE9n13j8OVw==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLD00GK9BOLT970@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 14 Oct 2024 22:55:33 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	Taylor Blau <me@ttaylorr.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	Bence Ferdinandy <bence@ferdinandy.com>,
	karthik.188@gmail.com
Subject: [PATCH v8 4/6] refs: add TRANSACTION_CREATE_EXISTS error
Date: Tue, 15 Oct 2024 00:53:13 +0200
Message-id: <20241014225431.1394565-5-bence@ferdinandy.com>
In-reply-to: <20241014225431.1394565-1-bence@ferdinandy.com>
References: <20241012230428.3259229-1-bence@ferdinandy.com>
 <20241014225431.1394565-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAGyUyoccjwg+DPq/RUqKKB7HW1cwrNdDQ4Km9MNht1P2yoegfdjKDNnYYqF/e+e
 8jnzQXWuHx6hIWAMmzBBkIP02gd9Z/JmfJGV56GXtc/RPmaSRy5pvTkqv0JnCdF/
 ln8ai30d05HGm6Dh1hwvFS154OWBgcJNLJEBYIxAi6vV9wOICKp6LjU8f5ZdkdWV
 TRstrpjJvP1ExRsOXlTR4x4hLYrpbIpL6ai32E+TpOdDCootK2YWZqu3bZSuLpa3
 cUfhv8FQGrwcS+dyYB97jv/6NnmcZeDj/uvUpgFdeahnYigSF7DapqsFdvvRSAaK
 Kzq11BkldXXUuj1A2HdKWShtNAUmloUK4kIFZqlWGODKANkbONXpZXHTA6mHRXZr
 eQjcmfvStZReM8TZl6fsQtMmKNtyiCp9EaCR23SQaJztFlpJILKvOm71KLyLjS95
 O/R5kRvaFMZbvsqbYmeSuKay3JCZzepuAL+sNaeqk4GEFNThrDC5ALyo

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

 refs.h                  |  4 +++-
 refs/files-backend.c    | 24 ++++++++++++++++--------
 refs/reftable-backend.c |  6 ++++--
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/refs.h b/refs.h
index b09a3a4384..c83b1ec76e 100644
--- a/refs.h
+++ b/refs.h
@@ -759,8 +759,10 @@ int ref_transaction_verify(struct ref_transaction *transaction,
 
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
index 0824c0b8a9..e743ec44b5 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2502,14 +2502,18 @@ static int split_symref_update(struct ref_update *update,
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
@@ -2522,7 +2526,7 @@ static int check_old_oid(struct ref_update *update, struct object_id *oid,
 			    oid_to_hex(oid),
 			    oid_to_hex(&update->old_oid));
 
-	return -1;
+	return ret;
 }
 
 /*
@@ -2602,9 +2606,11 @@ static int lock_ref_for_update(struct files_ref_store *refs,
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
@@ -2635,9 +2641,11 @@ static int lock_ref_for_update(struct files_ref_store *refs,
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
index 3c96fbf66f..ebf8e57fbc 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1206,10 +1206,13 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
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
@@ -1221,7 +1224,6 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 					    ref_update_original_update_refname(u),
 					    oid_to_hex(&current_oid),
 					    oid_to_hex(&u->old_oid));
-			ret = -1;
 			goto done;
 		}
 
-- 
2.47.0.7.g072c39eddb.dirty

