Received: from aib29agh126.zrh1.oracleemaildelivery.com (aib29agh126.zrh1.oracleemaildelivery.com [192.29.178.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DE8193435
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 22:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729378465; cv=none; b=iJ/5vu4qGqXhc7GyTvaZS7PRUWnVsQ7qSyoU7fALVcarFw98adikqZ7ERVlzjR+fxUenpQKXCM4/kB9DQo9OYoasWgSWm9D1VpOPzX2B6wPD4lAls9WZzL8ILjPwj8yB8OmhuAqV6Ai1OReSt8GSWmckXPvzk3fR821XqjM1xwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729378465; c=relaxed/simple;
	bh=YIPWJUzmunGroE1lXghkvynrUIKUUzjH4eQwWX6ugs4=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=QA6Djo9pV/JsI3l+YD+LUiFIRBnvMcgoGmNKoOvt/21ssBx+SSB5AmY0JIbCFP0+MQr+YOKOFAv+mcuPUf5zoC2+LmLr+upYotUE0vT4/zCakpYK1VksABT8uzloqC1kL899boo5GddH/vq5IOca4NIl0MPPh4TqPRJfyA9NJ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=En7UjPjh; arc=none smtp.client-ip=192.29.178.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="En7UjPjh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=OQhhL4JzFUlq2U3VwT3FOJngbSS3rxyYMz8u09+euvA=;
 b=En7UjPjhyswzdXkJAnAoFX91EG+CJ5eT4pmVEMQfax0ZQRiBzCI+rleaVGqBGVfGOjNS850VL47R
   /TLzIB1aR+7ybluLvgTrp7BWFGg2pVk63QwrJRmnm4PXYSBwdl3FvQF2Vw3+O/SM84SvPn6gg2Tx
   feOCyII6QUoouFt4JTl9EON3gAsRMfHmAZzaubYbDjw5fJV3DqhRT7OBFOAt6oljFpnTztQ+rhNn
   OOX/UvStztPO/YfqO9/RM02woid48lqJDAV9jnvjnelukL65QdyMtdtDr8TrrtWGfQGwlLvcbnhT
   40vfMxYy7PjVxPKPLeCoJfAG141OWYwnIg+QHA==
Received: by omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLM001DOKYGCC50@omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sat, 19 Oct 2024 22:54:16 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v9 5/7] refs: add TRANSACTION_CREATE_EXISTS error
Date: Sun, 20 Oct 2024 00:53:12 +0200
Message-id: <20241019225330.4001477-6-bence@ferdinandy.com>
In-reply-to: <20241019225330.4001477-1-bence@ferdinandy.com>
References: <Zw8IKyPkG0Hr6/5t@nand.local>
 <20241019225330.4001477-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAHFb1MxOxZAb3dhaH7XFcSq8YxJFc7aIXeP7+waHOfFkHkx9UZQnVAEHJwh/6c2
 bjYDgUfBMMPvyd0vtrpJG4gVSsZtVDNTrrNkW0iFmbAe8LImalUIvxDgkAmzHSML
 KihiavBTcYR/W8okjtmmMl5yQ7CMkxrycB2afmME6IVbDe+FoKNygLfGcN6w7BER
 xus/WMOID+HRqPmFZ15TTQ09U1LH6fk25vdNMLYScDWOGdvkg0I4FCUFP4PwNSOb
 4h8HQ/q+2fsYCdfxwo51lT11OCb897DX1rz6928llVSEZLAuW8EZayyAd2EmD1Qx
 EJcxZHKy3KEFDmxpdvtaBSa1APWq3LZ12mPDTbJJLXdXS8PNG4cQGvtuWKVd0mft
 zYC5opBxYZkh6fiFQgNWYQy8pZmt99SDJcpPiwyrn79H2ou0S72G4X4JFZ6kfndM
 Vfocq0TuR2DFrp5hz3BPyX/P0BMidR1keWyFG0Rd8k5QVuRf6oi+Lok=

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
2.47.0.92.g83fdbe24c3.dirty

