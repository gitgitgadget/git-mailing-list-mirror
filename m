Received: from aib29agh123.zrh1.oracleemaildelivery.com (aib29agh123.zrh1.oracleemaildelivery.com [192.29.178.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88E61DE2A0
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732230613; cv=none; b=IDvARv2+bEEGMGCqUOaMwlEiPbQ/H67xgP0y3ek8Mf+d9NiJu5y8HjOlsggEdXPt3z3dEkSHSuYf5twI0ti7wgoLADIi+Z1Re9rX7jpdj77SMr0lfaYp4nL4eQtsvfTN38p3uVbvc0vxOXsOj+RuKjC6tdaKikOdG8y9zPULCzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732230613; c=relaxed/simple;
	bh=9u8CWB8t3IKwzuSPfjqqakUwJm5aQAgCRDDR0v1p/bM=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=ch/pc8y9/p++58fXw0JmUEQcbythsqXX6JQwmkDqA0+kDlowSxlezcOUCryRGll3sTPs20ry+/UwlYQ08C2T9tNRvdRk2r4u7zbgO5FuusnbnSA3APL1OuqI3N5Um6KkoaGGK0PfxVa66nC+OEubOA5vMts1BT7/RvpPFhrCYMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=eZGy2X/O; arc=none smtp.client-ip=192.29.178.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="eZGy2X/O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=Bq7OuG2BXemEVOpnHAljAu/vQHGEfM95UJifpZJGZX4=;
 b=eZGy2X/O5hAaMNfXnburgRS8ZZeFNoNiIVnIZDvjwkt4+wfFKvTKLJy3UNKTBuJLesUWKmM/O+K5
   lJDNjJtDlSUbttXN8NOcKzYjg7FplTaIig6gZ4blrnFFTbXO9jYE+17knKhFwxV+a3p3Xi5xC+sL
   TrbcY5VvZtDTKTsVLuG3+C+94rn0E6h4hVS1+Rh+81IKldBeH7SkY6kSC37kJUILAY92GZYyonqc
   Xx8xSeToHBkbm2zLRiwLN1Dw3z1hfp0m7RftwpQ4gfk8HYI8tj8aRlDpGqNOJxNZgQZLFvQ/YuIu
   s+zArR50aE+ntq5IOAxtzVZ+rJWugAkqgYK40g==
Received: by omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SNB00BR5POZ0770@omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 21 Nov 2024 23:10:11 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v14 03/10] refs: standardize output of refs_read_symbolic_ref
Date: Thu, 21 Nov 2024 23:55:03 +0100
Message-id: <20241121225757.3877852-4-bence@ferdinandy.com>
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
 AAHd84Hzpuqkwcc35CxQIH07TVs1gyHKWGJbWSYW9PUVbdWjPAD9MsAm+uD4T00S
 KKfP9LBszRWf7ki3EBJnu86foe85HPzO9kvOxxjZagnDUUeBSkhSIGJ6EGDXyshb
 o2OqF8jkVLYAkpuv3jvnr1eMh2VJZultQBlujITQ71vNiXsrbnwFWpXIYirDFIqc
 HnWgRaUk9izBR2L8rm7zfpEZpLqvR2z4rfW/OXBPZvFAeAhj3+jfQru513xUQSVP
 ZDvIrvQ8XZWQdX7uOa01wi0jg6wsIc8CY/wrdHHbW9A8cw5L0vFxiZPiPi25afUm
 31uBMPj4zWo5gaT7SKWSZXp5xSm5keQDYjRaU1OLyr2Kmavfavveip1oJvddaDoI
 JcLvJol2jdPxuyRc6uXpr4SilvkNx4YtdBzRzIG2b8FPEYaN97mkLe8MHGPyokzA
 1pXHrp3BkVzLP+CesRipnkEC9UPCX9LY8G8JY/P09lDvfZ1YF5NajO54

When the symbolic reference we want to read with refs_read_symbolic_ref
is actually not a symbolic reference, the files and the reftable
backends return different values (1 and -1 respectively). Standardize
the returned values so that 0 is success, -1 is a generic error and -2
is that the reference was actually non-symbolic.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v13: new patch
    
    v14: - simplified the logic in reftables backend (thanks Junio)
         - update the comment in refs.h (thanks Patrick)
         - rewrote comment in refs-internal.h to point to the one in refs.h
         - created NOT_A_SYMREF=-2 constant

 refs.h                  | 11 +++++++++++
 refs/files-backend.c    |  7 +++----
 refs/refs-internal.h    |  5 +++++
 refs/reftable-backend.c |  8 +++++---
 4 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/refs.h b/refs.h
index 108dfc93b3..22c2b45b8b 100644
--- a/refs.h
+++ b/refs.h
@@ -83,6 +83,17 @@ int refs_read_ref_full(struct ref_store *refs, const char *refname,
 
 int refs_read_ref(struct ref_store *refs, const char *refname, struct object_id *oid);
 
+#define NOT_A_SYMREF -2
+
+/*
+ * Read the symbolic ref named "refname" and write its immediate referent into
+ * the provided buffer. Referent is left empty if "refname" is not a symbolic
+ * ref. It does not resolve the symbolic reference recursively in case the
+ * target is also a symbolic ref.
+ *
+ * Returns 0 on success, -2 if the "refname" is not a symbolic ref,
+ * -1 otherwise.
+ */
 int refs_read_symbolic_ref(struct ref_store *ref_store, const char *refname,
 			   struct strbuf *referent);
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0824c0b8a9..4cc43c32f2 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -596,10 +596,9 @@ static int files_read_symbolic_ref(struct ref_store *ref_store, const char *refn
 	unsigned int type;
 
 	ret = read_ref_internal(ref_store, refname, &oid, referent, &type, &failure_errno, 1);
-	if (ret)
-		return ret;
-
-	return !(type & REF_ISSYMREF);
+	if (!ret && !(type & REF_ISSYMREF))
+		return NOT_A_SYMREF;
+	return ret;
 }
 
 int parse_loose_ref_contents(const struct git_hash_algo *algop,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 2313c830d8..1399fee61c 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -673,6 +673,11 @@ struct ref_storage_be {
 
 	ref_iterator_begin_fn *iterator_begin;
 	read_raw_ref_fn *read_raw_ref;
+
+	/*
+	 * Please refer to `refs_read_symbolic_ref()` for the expected
+	 * behaviour.
+	 */
 	read_symbolic_ref_fn *read_symbolic_ref;
 
 	reflog_iterator_begin_fn *reflog_iterator_begin;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 38eb14d591..1809e3426a 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -830,10 +830,12 @@ static int reftable_be_read_symbolic_ref(struct ref_store *ref_store,
 		return ret;
 
 	ret = reftable_stack_read_ref(stack, refname, &ref);
-	if (ret == 0 && ref.value_type == REFTABLE_REF_SYMREF)
+        if (ret)
+                ret = -1;
+        else if (ref.value_type == REFTABLE_REF_SYMREF)
 		strbuf_addstr(referent, ref.value.symref);
-	else
-		ret = -1;
+        else
+                ret = NOT_A_SYMREF;
 
 	reftable_ref_record_release(&ref);
 	return ret;
-- 
2.47.0.298.g52a96ec17b

