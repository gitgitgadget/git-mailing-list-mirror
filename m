Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85541DE3B4
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 23:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732230638; cv=none; b=bGD8DDtPbaQl05fv7NbrsLcGeaBsMXFVKXEHmG7R7AgJTMzZ5ZeSj4HQcqFeXIbpmUgWzdlsHBZXOQcqC8EOqTFdg3/N0mehiYp06fWGgZNTCYPb7pShjCQvD+bOa3J75QnHBbDDc4oXW5Kpc332DMK6NBBZyHJ/LagyUSs4AQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732230638; c=relaxed/simple;
	bh=vkL3KG6On7lyfhtBP7H7pLoTpoOImQXQfN3TSOFHtgg=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=Gi6d0c5/jP4rUuNYrzjiA8yCsyhtNPHySGl6bNx0emLOnwrywpBEHrgUR+J1OS7fAANrFbQyt5Oa87UNQDY4ait3F05h+qbZZa0moQbhkdK9+5htSM+UINA+AKFL4a69hIGTrQrIDSFit0iOFhm5Q4UHJg0CrsBR/Pw2apNbCoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=o+7sMWVN; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="o+7sMWVN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=MGw21Qx2y07VWfMCLJUi4EwXww94rafVGDoCzKmADw4=;
 b=o+7sMWVN54r85CMr42nsmF/W2RjifWQ2IBI7rxCKmCie/iZSMufzNb4zZeVG9GpQFBp7uFzStr4D
   19QSpn2G+f//bwxZsiMzppMs5LwlREWvigRT8W8qHoS9/KZfY6Zv9LwPfheEwzGfnzPqFoWY7XW/
   GeC1DlnD7nEwqDMjX4mkXZNL1JiyUK3a+++RS43AWsCZFPjbIoXTZQCFtw/W12CvSAMigW1CB1i1
   rnjdkWQRFLnNVH4+II12cNEbT/XW/T8wzErb+beNoNs2y4qAqxOyd1b/Erx1OmTy6gmLfxePRKhQ
   KOPro4WWwgmAnkbSJmbce5pmdfv3mh0T08rCLQ==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SNB000Q8PPGC850@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 21 Nov 2024 23:10:28 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v14 07/10] refs: add TRANSACTION_CREATE_EXISTS error
Date: Thu, 21 Nov 2024 23:55:07 +0100
Message-id: <20241121225757.3877852-8-bence@ferdinandy.com>
In-reply-to: <20241121225757.3877852-1-bence@ferdinandy.com>
References: <20241118151755.756265-1-bence@ferdinandy.com>
 <20241121225757.3877852-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAHhvjVTsuHmBCPUrQOL6MO+xdHx7LLWLQsTikv1tJ+ekdKIG5aMsXK/QPMYOoHV
 0/XbNXs+MVi+NbzsHfkRxHWW56COkth9Cg2yLOnUX7W8QJYT129NTuI+VM8zXhgT
 XOmaPmwlEKaNOjB/JLbP/nyyxHtAEkcuMsWNnF5GN3Qy4yo0mIAba0xm947Ejfs/
 Kc3FOhFRjmup5MrOXdbZ90T1AExtdkyi1was1kZ0WFL/HE7lgBGjfS4NpfJJeOxo
 W5IahW63u1DCOY3TDMcaQeQJyJN6TZMq6ZHm/CjDAkIwWYgfuhsk8+GMGua4sgqA
 DBi3Futyl476vxf6qIZPHsq9xT98cpG4CPLQ81eneyuquE2hy9EwUsvFc3sWn/2H
 u3+BaSQLcVjTFy/uf3/n3/xuRfsROS+Qb7n+Itkj79BZq0mooIx6NZvYOS0xV1UY
 jEVhpH+wWWogMFQMQ8l7RIgOCi1joafIDsupGMQ1DQCzN/PRznUzZXo=

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
index 1809e3426a..75b04e84a2 100644
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

