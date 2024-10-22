Received: from aib29agh126.zrh1.oracleemaildelivery.com (aib29agh126.zrh1.oracleemaildelivery.com [192.29.178.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216AD81AB6
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 19:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729626545; cv=none; b=iFMY8tsSInC1+TO/kYAyWwhuSYFLmVoghph4ILFciy82KlNPTKI4TlPxpkSR9NQ4ueV7BElMqlZ6gURN0YaAwJxppuzKcgJJhRHkv+74wMoRtGIJ8DxfcU9ihAOIuclkBBprA5BqOnI0w36p7jh1UzaUQlrHNu8ZzSo2q7khaBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729626545; c=relaxed/simple;
	bh=zMNzg2CJa3X4BrWf3X1nyNKvz2AOc/y+0ue+iOZLXno=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=k1MbEjGpCarlnhkm8vYOglA6pbGL1djQvYS78ifpBkV1kDBhCXmS48XHkeiOhB9jOOnLADeQXmqnTKWDcu1qNSMShnY9d9zeq+5F1ZKJnu0WADv/77IwpxBlZbJNt8noZAVxxUmmfTYX+uFiil7fyRZazKEmm2nK/hpkuYFr53c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=RPH1YjfC; arc=none smtp.client-ip=192.29.178.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="RPH1YjfC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=/GoyyFXCFrh8IJ5Vv8oStZBynWNL3tgZxKrVDVEmXTk=;
 b=RPH1YjfCT1HTCN3/eZM20QtdKAwTwjNzkNaIQwNed9SOo4RZJjndyih2o6zd1fvGS2tEttUUk03P
   IcpWzuzOftOriPHOc2yyrjrbZC1kORDXgfFmoPtpjqJpyNOYyZMI+Lx0WuZF076MkRMAhp2u3Yn4
   t0MpH3/WLDP2W4yHsUdtynJaOS9AhsRgMbw3xA/Y0pjbmPo1nu96+TfZSrU18TK1BkGkGF+p9kpB
   rXP6FNKreY3znLKoUnPGF6O3Eonl501sOnctNIQBxnJkFoaLMOlSTP1R7u6tJ1dUA/MjngBSwswj
   DVwupGEQ10hiL/gsRNm993MtBzxkz7TKT77+jQ==
Received: by omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLR00I5GWDQ2330@omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 22 Oct 2024 19:49:02 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v11 6/8] refs: add create_only option to
 refs_update_symref_extended
Date: Tue, 22 Oct 2024 21:45:43 +0200
Message-id: <20241022194710.3743691-7-bence@ferdinandy.com>
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
 AAEaY43CsX4NS5gnX13mxeflHPj4BoTX7uiPTxCe+2EPNdQOKX973DeBaZxpBN4U
 b0AA7+5xFQF/if8asurBYWPxeYf7X5xNvraMBAtqLoFWlNurCrUhXZwVUBUBHItn
 ZgYwuFN5t2fOnlJfZqK3e1PD2vG7/5lhqQIhNxVZsY+/9uG1S0af6HlEqNZDZ1D1
 +IgdpmY1Mcxg44NdA/U69Fjnm1muSqLDc36QjuX1qu7fK7iBHOuDMc7jbD0EY6k8
 N1ECbuhhqlvIlVs0rJ7beXyToqdExKMzMB4w2ArYZZPkV3SEPLGJ2aJJGDLWpW45
 lqM7oQAMQYyF5SSx2rqXN88BNiOSf/eBakN243XXMlEcH2hjegVSuTFfZUxHwBQW
 V+antl0teyMrtlpeXDOfEjgEWKA6evkY3MbCwkWfeK32npeYNEngCh47RMg5CdTt
 SJ4DWjzsv/zTJYj1onA4pfyzA/CMzo+3HkhZa1augG8wdr1CLKQXDgvF

Allow the caller to specify that it only wants to update the symref if
it does not already exist. Silently ignore the error from the
transaction API if the symref already exists.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v4: new patch
    v5: no change
    
    v6: - switched from bool to int for create_only
        - refactored logic in refs_update_symref with goto as layed out by
          Junio
    
    v7: - change commit prefix to be more in line with project standards
        - refactored code to accommodate changes in the first patch, but
          otherwise no change
    
    v8: no change
    
    v9: - no change (except for following through the
          refs_update_symref_extended refactoring)
    
    v10: no change
    
    v11: no change

 builtin/remote.c |  2 +-
 refs.c           | 32 +++++++++++++++++++++++---------
 refs.h           |  2 +-
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 108f1271d3..b1eba75a2b 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1471,7 +1471,7 @@ static int set_head(int argc, const char **argv, const char *prefix)
 		if (!refs_ref_exists(refs, b_remote_head.buf))
 			result |= error(_("Not a valid ref: %s"), b_remote_head.buf);
 		else if (refs_update_symref_extended(refs, b_head.buf, b_remote_head.buf,
-					"remote set-head", &b_local_head))
+					"remote set-head", &b_local_head, 0))
 			result |= error(_("Could not setup %s"), b_head.buf);
 		else if (opt_a)
 			report_set_head_auto(argv[0], head_name, &b_local_head);
diff --git a/refs.c b/refs.c
index 24a4172cd2..093ee11ab0 100644
--- a/refs.c
+++ b/refs.c
@@ -2116,31 +2116,45 @@ int peel_iterated_oid(struct repository *r, const struct object_id *base, struct
 int refs_update_symref(struct ref_store *refs, const char *ref,
 		       const char *target, const char *logmsg)
 {
-	return refs_update_symref_extended(refs, ref, target, logmsg, NULL);
+	return refs_update_symref_extended(refs, ref, target, logmsg, NULL, 0);
 }
 
 int refs_update_symref_extended(struct ref_store *refs, const char *ref,
 		       const char *target, const char *logmsg,
-		       struct strbuf *referent)
+		       struct strbuf *referent, int create_only)
 {
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
-	int ret = 0;
+	int ret = 0, prepret = 0;
 
 	transaction = ref_store_transaction_begin(refs, &err);
-	if (!transaction ||
-		ref_transaction_update(transaction, ref, NULL, NULL,
-				   target, NULL, REF_NO_DEREF,
-				   logmsg, &err) ||
-		ref_transaction_prepare(transaction, &err)) {
+	if (!transaction) {
+	error_return:
 		ret = error("%s", err.buf);
 		goto cleanup;
 	}
+	if (create_only) {
+		if (ref_transaction_create(transaction, ref, NULL, target,
+					   REF_NO_DEREF, logmsg, &err))
+			goto error_return;
+		prepret = ref_transaction_prepare(transaction, &err);
+		if (prepret && prepret != TRANSACTION_CREATE_EXISTS)
+			goto error_return;
+	} else {
+		if (ref_transaction_update(transaction, ref, NULL, NULL,
+					   target, NULL, REF_NO_DEREF,
+					   logmsg, &err) ||
+			ref_transaction_prepare(transaction, &err))
+			goto error_return;
+	}
+
 	if (referent)
 		refs_read_symbolic_ref(refs, ref, referent);
 
+	if (prepret == TRANSACTION_CREATE_EXISTS)
+		goto cleanup;
 	if (ref_transaction_commit(transaction, &err))
-		ret = error("%s", err.buf);
+		goto error_return;
 
 cleanup:
 	strbuf_release(&err);
diff --git a/refs.h b/refs.h
index a5bc25442b..458582ebcf 100644
--- a/refs.h
+++ b/refs.h
@@ -575,7 +575,7 @@ int refs_update_symref(struct ref_store *refs, const char *refname,
 
 int refs_update_symref_extended(struct ref_store *refs, const char *refname,
 		       const char *target, const char *logmsg,
-		       struct strbuf *referent);
+		       struct strbuf *referent, int create_only);
 
 enum action_on_err {
 	UPDATE_REFS_MSG_ON_ERR,
-- 
2.47.0.94.gb64850d498

