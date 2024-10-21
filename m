Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A03E1F9410
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518300; cv=none; b=Oqi5rPEbh9hnP5uEUXsPn8phTz0V0afceLmC8FgXj/fdEAUBtHCmZhnNewTf1CcsB6DvZJqzktXZ/unnr97dOT8IimWK1MbJjAQXIUJfBJ8azCXC2nP/j4YVTDCn107QcZ0Zet8aLsMPwfFP8H/BypiXg2XvXViKpS3vis8xpno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518300; c=relaxed/simple;
	bh=e/y6O7dsmn9zIfqQrzGiyb1BBd+gReVU9OfJfRBOSOg=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=YUZZ+DGMlEJNx4FTfIZDqMW8b6hIGpztGHLHtJaQTX8VZNIw3bCZSrllk7PcIL4mgylUBc2FX3o4fQOdjUzngWy9+ey6Vv3P6vvmFTA5hZ0RLIrilyPvB2zKaVlCq/wX7YTdmwDQ18UJLQbugEOVdtV9sRyjfjuozVE6ReCzLvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=AkfAaq4T; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="AkfAaq4T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=FkxENzZrwMFFFCC+UcLcU90Gvs9mhacaH37ZT7WGfoM=;
 b=AkfAaq4TC5p8o/OmD6hBwIQJlH0Tkf2NkXelTk3I9Nm4Y0iGAU+dvd91FtcSOy5a4GqX3LwT9hUG
   AWqHcrGtoUA7VNJN8ChOdf0eSQyxxYNAbGQREqgdnivdXHKm5PD4+hQaCKgL5SYayGhwmQiDPmkP
   Maz9viJBYhUkYZba/evi4SqTkNzbhfUSXm/vt88I9l19AfSaX6EFUgpJQ/xbBaRBizrogKTCGoGr
   3TVHTGqckMa5dXNW3cPrCFrSQbE+OLdF9jmcJd2AeXluEp9tWfpmnzYFYDuHKrIaeTtCuPjQeQ1q
   4i3py1R72f4O0OoIPjYi9y26Sf73dKWzjsn6Vw==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLP00KT8KUR3U20@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 21 Oct 2024 13:44:51 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?F=C5=91v=C3=A1rosi=20V=C3=ADzm=C5=B1vek=20Zrt=2E?=
 <noreply@vizmuvek.hu>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v10 5/8] refs: add TRANSACTION_CREATE_EXISTS error
Date: Mon, 21 Oct 2024 15:37:02 +0200
Message-id: <20241021134354.705636-6-bence@ferdinandy.com>
In-reply-to: <20241021134354.705636-1-bence@ferdinandy.com>
References: <1088915169.629942.1729445083543@FVRT-HAMMYAS-P.vizmuvek.hu>
 <20241021134354.705636-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAGKQKp0eSHkB/MBfNPQLYFnMiOGBdGLhzF7U4/j75BiK9nU/kpGSfTnKXbeOE3M
 ++x4+j0FghhrTN7ScZ0U+hHho01Zki0BZtS305QdoK64oHL3IQ8SRGwUtWgMiVba
 petzUg1mwu0xlEwlIk8mNU5CfsSYr0lZAH8VxCtVz2zYTEE9jewg8VXwSiAtSCx5
 iWrrE5/WqtoD4y9L1wKyC65kSr9L4maceUqxCuUXNTC3AWEgjoxqkqGNOVVYQ7RL
 29HKKCN/BYsQG4yTJ89+Uoo92BPUghFgeL2xz9tTOkMvkoHk1QF/TNueIF19dE6L
 6hgSr7WMaL+zQM/fp3ceQuxRFkwA8QBJFImQbtQhpdndwygJKOiPUGGAqwn14fGF
 LbAhM9QqGOlnxIlo5UjTJst5VjFTK+s2RFW+yRNFLNlRpIFjAPgvPLrW94vK58N1
 9i5Yscw19pXj9DUAIq2QmS0Q5M7n/NA4AdcImzeOM1aZwKmehK5L6HSf

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
2.47.0.94.g8861098b6d

