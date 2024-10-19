Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F1B1940A2
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 22:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729378474; cv=none; b=FnI+O9aSfiLVkTHgqDd6Z6Hob1p9Ote2Ok4ywNq9fXP9Kf21hoqYu8lzsLd/x7Om6rn7MvQwJraKReSnDfWG+bzf5HPUXTLVRoUHnPRCo+h/fi1j9ys4YpnGGCXguy02N0J1DrH3AudW61M3UPZ+i6I2PzlGRY1vaGLad137PEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729378474; c=relaxed/simple;
	bh=nIBZdbTmDta75HLB7imASrRBjK8rscD3+utPiyFJvWs=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=M1qKS5j7OBL3DPt/9Q/HwrpyqN0neiJc79XsTDWqWfau1ZBxgeJikqZcvFIjeLx02IsLKSxpXMEkLe6A6qenBYek1TO35S513j7F8LgBOWmoNlVuKYtD7iqJXEEslvMcBqybZ19joY7Nafjs7OxiamJaoXsbeXBv99pSi6wThXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=VQvTrb+i; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="VQvTrb+i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=/xLMmhqlHjgLfu6faqE67RN52lpBLuFum7kcYNMBU/4=;
 b=VQvTrb+i9Q6Ync8sEP2ieDGZ5Oi9tEGnlUtin2de3/1LZTEUzuuvB3fLmpe+K6PPuXLck+wIwKIk
   wWHHZKwtjWGqY7L0kq7vDoeTerEco6n4d4Jo0BmJDgSEhMKuAYqndyiDzDh4ZwQlH3qiayiAHAsk
   l0qab+osGZlkZKZ9zKdVRSG1ihVqhKtw8xkYt64hJXdE4HV/tn9DoOCFi2b/v1qCJ1z9mCwUGy9O
   8LVq+fbHEnhmlQRB4qI9wfcyQYob1mSv0RhJdnRltOqVqdFvSU1vPP0FQLilLkebC/Sn5oCzIAVM
   Dnsw3egwIw3W9gy2FO71GfnQ53aKmHDEd/XHPA==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLM007H2KYNRJ10@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sat, 19 Oct 2024 22:54:23 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v9 6/7] refs: add create_only option to
 refs_update_symref_extended
Date: Sun, 20 Oct 2024 00:53:13 +0200
Message-id: <20241019225330.4001477-7-bence@ferdinandy.com>
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
 AAE2GdbF+mCcWjovfScOg+z3IZUY0hnhSpQctsQOhAOWKoxa7Cyuo8IjDh0hOxf1
 h7tysrbbirtWtpX0pL+YTOzCg+GfvzfDXgx4797R7uAKOZj3n9zzR1sOrMQGwXaA
 AWBtBNxvjm55kKKSpjQm5nmICmTxLiX6BxXuAZ6fX5sJTASlWl9/WtMX6Hi8005S
 I6l5PgCHQgcOTCtaYBLaB+1S9+yFwk0mye2NI+bdUEn+z51ciNTxH8WK48V1yf1k
 vZY54M4cAokAeDAVAtf9wchxgXpMCz/VviOK56c91gypeeRjWMmQJiHhOr+uabMV
 Ag0ytJNfK5BpTj36/R1dTgygnOReAtIqJ8RNuIMoDOzJ3ikS9+GsAIn1fRJKI7jx
 eAZZ5tA1SDTHm9Hpe4WeoaElusfQXtlx1XOO6cGzdU+xN+qKHL4AptyesjQPB2DM
 2Iq0FQxoaGu+jtQcO3E3zCsKo4lDg2wWZDZQTRvEhRwepzJEGH1yArsA

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
2.47.0.92.g83fdbe24c3.dirty

