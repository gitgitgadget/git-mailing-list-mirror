Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1CE282FA
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 12:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732278768; cv=none; b=cJCRRYCAqpz0G+L5OtopNGymB1q000L0wxDa/EATpHFie5ppFkaiXWIkbEOBovorEtcFE37s3GDqs/b1AHYuQ/Wd7n9YI+MFjZ5wXEDbl9Rkxt6ibWU8uQhj0Is45dBvndAqfM9Baw9Pf8YGa1pMEQ7i78++HfXeH0Y4iutYyuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732278768; c=relaxed/simple;
	bh=V5QaZS7f+Dh8E95oGg8+75OO6smeOvZljUWu0F3GrZA=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=AqRbMqCuu0ihDvQrUewxSJ7s+kNaV8eiYbZTExJbTR2cXhpwYGidHZDDwBPbTQ+lJ6qFoLIUNDhuNpWeGFfeGpGydT3NJhOq6w7OtkjafLMxs7ZGjkGUzqtoqeMEyl9CG9VH8o65aOS3sa5zNMywxJ/NQtSKkmTAPHma/9iweLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=gZFsVKkY; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="gZFsVKkY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=xQ3S/doNTjnBAD1nwcpSmrKTvdm0bK0tzeTczr1J0ig=;
 b=gZFsVKkYGo2Sza65u3FgvAExnqBelNYIu5ju/KBtNLdz+blkQk3ZpxyOi+dQVp12BTG1W3MOOi7c
   qTM7WDR5lrClM+Do8rLxExesDaSQOMupO8X288OM7yUw8IanQ59mQSozUJuCug5sQCGdOc+4OZE7
   1VRsHZaY+lEY0mkKkKJoWoYUZ66kSz8lSbIfQbgIoQ1myOvnciHZTIcSMiUmYb1wfjJVsIxNpE6q
   zoXZwf9+jx8wFAQIzt7YIm6Z/QTug9YxMi+kdMDOWCFhwp6StfD0WkDx8Aq/eW0IZORIWY7DqlGu
   f0+TMAIqA8zgUBgJ5Xq22EjwiSgTlKYqFQcC9A==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SNC0058DQUKX060@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Fri, 22 Nov 2024 12:32:45 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v15 03/10] refs: standardize output of refs_read_symbolic_ref
Date: Fri, 22 Nov 2024 13:28:44 +0100
Message-id: <20241122123138.66960-4-bence@ferdinandy.com>
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
 Ul6VMUbN6v80/W7C6h44X+CTQkZJwKy9KOWNX+wXr9WE8CxwaE1C4FSIeGrHO5wx
 TgBUTPVJfwX9ncjjZ7K+sFjtOpHCxS9OzeaTgn8NQ0rLlRJkU6xgT5hiYzTFHIkn
 5SFlpe0EFbcoY/GItcH4OTfWU9PDy2coVoDjJ+leN8WHpQ+nj1dJFFTj80HqMadv
 PfpnpT9DbZzwZcprq8aTiYxKbZzoHI6rQ+dpg9pIljuY1rHndMSqfUZ5addFfHLS
 W4NKO63zen1IxVP/K9/SclvlViUYiFxjuW8h9KKkCxAawyMpiMCs15dTpYE/A0Wx
 zi4vY+c2RYHyQgHnykaaAt9OazkZzLb006HTfacUmnp9oCRzT1GHAwFM8lv+gccC
 xw2sw4V0LDGnPV9MyPAF5xb7jSh956VgF64dfsZGJAEo5BryYps9yWA=

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
    
    v15: fix whitespace issues

 refs.h                  | 11 +++++++++++
 refs/files-backend.c    |  7 +++----
 refs/refs-internal.h    |  5 +++++
 refs/reftable-backend.c |  6 ++++--
 4 files changed, 23 insertions(+), 6 deletions(-)

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
index 38eb14d591..e8afcda1f9 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -830,10 +830,12 @@ static int reftable_be_read_symbolic_ref(struct ref_store *ref_store,
 		return ret;
 
 	ret = reftable_stack_read_ref(stack, refname, &ref);
-	if (ret == 0 && ref.value_type == REFTABLE_REF_SYMREF)
+	if (ret)
+		ret = -1;
+	else if (ref.value_type == REFTABLE_REF_SYMREF)
 		strbuf_addstr(referent, ref.value.symref);
 	else
-		ret = -1;
+		ret = NOT_A_SYMREF;
 
 	reftable_ref_record_release(&ref);
 	return ret;
-- 
2.47.0.298.g52a96ec17b

