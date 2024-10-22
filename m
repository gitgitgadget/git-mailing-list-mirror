Received: from aib29agh123.zrh1.oracleemaildelivery.com (aib29agh123.zrh1.oracleemaildelivery.com [192.29.178.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFDA1C9ED4
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 19:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729626541; cv=none; b=ejPmXQGbb4KYKIcf+GLRRhpD/SbSjusoZ1AhGVviRpc29mCbqGB+mpiBsaug0oyAvshxUGEqrcLk/1+IN6uYRVCTnk0LN2TJIHO9Fa6JtFtJf9go9lbu4BWW9QRrgqbV0ht5lCCGszxeVixpwUqIH4CWgGvtm5djP2+xA0X7d60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729626541; c=relaxed/simple;
	bh=A/uM8XwdG/ozIj5gNcO5ACe3q2Aa0lSrj7nFxHl7NR0=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=Kb/Pe/RXc/7e25j79twJMbDdkUY7FAr7GdFl0o2ERE0ko6P6PqUZh2loOrEE65TyT5uV01CPmOToXnFH+xVqgGIvBI2CK5VEb+iOwVflnGeYptyqhGBvCdwk2N8Ctfgvndlg4sTyQb3Dq/2ntuWmfPaHBoHUj5V1ij4rCi/7saY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=pxqB17iY; arc=none smtp.client-ip=192.29.178.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="pxqB17iY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=bUjQjLMJNaMxDsTDlGSC9kY/bdIWliZ9BmqijzU64QE=;
 b=pxqB17iYELgf9GbUKtYm1aU6n7EJ1dEM7W8ziG6Q56CQjTXQL/ZHUB42CPwIbhSb6WmvSQNPwPEH
   uH63y5QS9DACLSeVDt9SdSJoHeVOQArVNaN309isrg/SAHnuOxtBqYUDE7TiHwjXFGZ3XTLdvldC
   uRJjXlQD0N7BD/2p8x4NOYBexpS4TYiaNSMbSCaKnCYxw5Nd2uRQz80kxnj8HIvMiXcHIy/+y4vY
   s6Bml3Nvz54zWbl97QV52DfDD4swyP9EI4KN0PCBivc3QhbZ23Zvfud934OrY9vyWH4AdEZAZJO2
   WzjokgoNuVUH+6Y+n1ZFH9wr6J/OziO70+4mOw==
Received: by omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLR00ISYWDI9OF0@omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 22 Oct 2024 19:48:54 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v11 5/8] refs: add TRANSACTION_CREATE_EXISTS error
Date: Tue, 22 Oct 2024 21:45:42 +0200
Message-id: <20241022194710.3743691-6-bence@ferdinandy.com>
In-reply-to: <20241022194710.3743691-1-bence@ferdinandy.com>
References: <43d44c82-b93d-4ac9-a5ac-ae5f70982cfd@ferdinandy.com>
 <20241022194710.3743691-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAG656Mgg8rkdVTkhA9mTB/tlXmcC2Vv9h4yPU9dKJPc5HdMkMGX4ZKUOB6YvE+z
 l01DlZftdJvDV31NUU8i4CQpbNnTHNWvBZhePg+II47A36KaDeNqxsLWXYyLaD4+
 6xMENLpLxZFO6P7YoDhuo38yAZl/654RSpyh48wRvyV8BCABSkIw8JMiN1q6D+57
 9hDeRCid0xcPJ+e0wXuRFDK6kO/32Ot4BQhJOPzlm/RCIvdVpTqE0ZUQvaznvGMQ
 2oH9U4mSGOm94Gy5ZWumZX9poQKij188eGjflSy+9LM55lLSsIAUNDPVZpoh8avv
 MFCpHTjvAcGk+fNYlPjCx1MMNlnbVS+t0SbX2CM24OQ4joA9h3Vk5BJZ2UpwJOla
 TSYoEyFdRYcMJMa8sNDmf/rmODk/TpZRyK7cE7b1fh5bMTVK0Zvzt+zzhDjZQoCW
 Sr9wtwcXn/Y4z5rMzhuXEpJK12zxN3FyXnAiR7HRwG36p9yus7xCkvE=

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

 refs.h                  |  4 +++-
 refs/files-backend.c    | 24 ++++++++++++++++--------
 refs/reftable-backend.c |  6 ++++--
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/refs.h b/refs.h
index 259191a485..a5bc25442b 100644
--- a/refs.h
+++ b/refs.h
@@ -762,8 +762,10 @@ int ref_transaction_verify(struct ref_transaction *transaction,
 
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
index 3c6107c7ce..b3b5ce77dd 100644
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
2.47.0.94.gb64850d498

