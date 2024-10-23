Received: from aib29agh123.zrh1.oracleemaildelivery.com (aib29agh123.zrh1.oracleemaildelivery.com [192.29.178.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8643A1DA
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697955; cv=none; b=Y897OUGJ60hN9Zowwn4R3x744mlYlN2jw6JWbHX2GIKoFjFHBDkaADHNYhF5wI/dKHtejnQtYrKokmGJf8Sk0as6aknyiJg0DKKE3hr9ggrMssrogdoHVNz3WsFxZNpifXtUSA/CxPBAMduKtdLtzyFFxyyEMrRkr0vInCL9794=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697955; c=relaxed/simple;
	bh=cPERsB7bIdoxQQHUKcU5C5dIh9EcuFxCY6kSH3mTB1s=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=MMgYy8FAgpA/VnWj4J0cAmNQgCm2x5L371tKpfjJNTl9KXHhUyI7nevcLt2dD8vnmST6KhOZ5AHPizI9IuiIAw65ARiPFTdGB0gIEIIR+KO0RQGcAD/52focIf+ZjYSNSjyUEAZu3K/mz4tEU9JLxMcvXkZNeBWIcruKpZfwTZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=kjGBrp4u; arc=none smtp.client-ip=192.29.178.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="kjGBrp4u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=QARkpg931901mCt1XZGEGqaUiaLwbSOsNnq7099kh9g=;
 b=kjGBrp4uptxFA2/WvHhi+dtz4eT5uUX1e4srEnyvRpJPIugOXUpkB2tLEZ4yYKKtWAWS3P4KhHfG
   uFTzQVOUXts1aQX7xwVF4FCe6q+gVikeq2PbLZRacvPXScw2TFhZ7LzqPPhdS4fbYwLB+bfT+Ovj
   vZy9nJw0objLOwsqGQcqM77EBGR0yrPBkUoycCgHQjo5R8VmMrp7KrNotCAMQAN92VfZ9Lfk9C69
   /YHPTX/cDVQy+NNNhOycGF/umigcO5UPzHXetiIva3lmER7xqr2bDC2mD9wokGB3ba0B1IVUaLzi
   j4SbadKH/73YfFtG3W34wtquRp2357cemNfFBg==
Received: by omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLT00DV2FHBYL40@omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 23 Oct 2024 15:39:11 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Bence Ferdinandy <bence@ferdinandy.com>,
	ferdinandy.bence@ttk.elte.hu
Subject: [PATCH v12 6/8] refs: add create_only option to
 refs_update_symref_extended
Date: Wed, 23 Oct 2024 17:36:40 +0200
Message-id: <20241023153736.257733-7-bence@ferdinandy.com>
In-reply-to: <20241023153736.257733-1-bence@ferdinandy.com>
References: <20241022194710.3743691-1-bence@ferdinandy.com>
 <20241023153736.257733-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAGcS2eyRyY/1wZGTbFnQr41s5yEFeYpPyFiEAiJ0SR5nHUsrjSlmWPSLymOhRh6
 +PoyTc214gI06UbADeA9+sqwv/vjwqZtn9zbDAf+DytgVaNRBiiZSh+JjRytOMBZ
 lLcfy5r7eux9wY0iarxUIVSBvvslhbscKGlX3cgNqfR9WQope1/WuHZvOztRmjOw
 zts1ykKuIlAuOnj7xU/i5HQZ8QFoISSIhL37EnUAEJaHRrEZSIaYdj6an73353wb
 gZSvn8CZ7Y+yDkyIfmlxjZC9Fx79U+A0cFrJ46yN9QURjsd5QeSe7+K1sFbrMXrx
 3P0Zq6dNKHZXdQ9YY5RdIXjW805AbTI1AP5Y8q4WbpzWnVnCj6F05ojMk2CexOh8
 xSUFyz0Wmh9jIZbCvmEcwnKP1QpXNvcdK9pFSGRD1EjtASfRUjtd+BM6eN634X7a
 7+c5uQYqhTZ7hgd7adl8yt5RjMEq6pNoCVhv0h823z9Iuu+NBJyW8MU=

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
    
    v12: no change

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
2.47.0.94.g1247fb88fd.dirty

