Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71107171088
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 12:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732278787; cv=none; b=bNyvuifY8vJva/v8mckQ1zKLcymLrcE1chq3poELAB+SkeUjA1tf9De1nSCjs8FV0J5+51joaAYL62f+4kVeviLNZ9FXAk2eplBbXd+P7NtQ7FRwhm+/tYtHj8OYNg1cZXXbZQ9PPfhaXraL1rNXgya3PLlYR1BbuqnVoJrm79Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732278787; c=relaxed/simple;
	bh=YJJNr41+sGGAgAE7ic//1sXvJ9lK/ef/V5AI46RTdmE=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=ku7PTKj4GOUdtlGnY9G5jWrUu8U0i7hGmZlFfeCyHiWFtply2YGT1MDs9X2DEncTaVKt2aDIJb/KY/QHMOWsMYDqRt/QyopeGf3YrUw7CmnXiF3XlrAlSiyUvL0jE+kvxbraleTBJb7OzCTrbxC5lwTx4X2QJanWsj15xmhfzH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=o1hDcCL0; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="o1hDcCL0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=ZwjOTSGd7MdY4McZ4kjRjEkoxDK2c4FLBNvSn5YBaJg=;
 b=o1hDcCL0weCOXSIhp/QPiHAYK9Plhp2RjBY5LEV+lwpJz3iY6xAhFwKPhwtb1kmkB8kCXhNc46Qg
   sPb5nE6q+Kh26h4TXof3Cl2wrCq2WmDyQnGweZ2ptsETNxDH/A3ahxznp4WAKxSeXmrqoT7VxcoS
   kmpvIwuTsJZqx8Wkd0KDgLG4dV3wlnscjARV2zPWSke79DKouE9kiPmkz80VJQJRAv7yy5aBUFTT
   bpdGkLok1x6H3lYKw+Yurhk8zA52gLAhcuI4S2inrI50XraJeFgjXg5/DGVTBcMukjMjZK/gxXIO
   8JsrVxFs01y94P/BeCIq+vtLw+EaeIn+GAhLTQ==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SNC00NK2QV3BTC0@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Fri, 22 Nov 2024 12:33:03 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v15 08/10] refs: add create_only option to
 refs_update_symref_extended
Date: Fri, 22 Nov 2024 13:28:49 +0100
Message-id: <20241122123138.66960-9-bence@ferdinandy.com>
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
 AAHPmg53zA5rWzJswmd0gUM+aW2QZ5S71jt8DkyZjMJTtCE6MlFfLVcEzwuGFcay
 04gdTC0WXFhQikV0a2w0cJrH+DS0/QWikdhykXHipalKBUcO5WLeNHqmMTjKhktM
 fDoGw6/Wvlem/yeCjxF+CoSr9xPEBr++NELK62jXofDZ8g8UYOjpBjkjtOsn6OGp
 6XzQ4e1o3II2T6AP7CVXbCg4muYUhioG+2WQt5OfZdvkK2cKc3bPlVOW8xRE8QFH
 Q/50vPiJ2epE5pTGPxYJ9NaQnFHSh5jOKHYo8mYZ+uxTHmKlssOY7QlZPwJx6MwF
 TBKMx4HXPG6MYrxW3K8o2niERWNQU+iaK4pnbbvvRYK9rn6RJOZaoyEZ8aYwlJ19
 jcskgE8y8CcrDvIE+VhFRiGIAZfgthtX1YqWY5rgviX5W68Ss7l+y91vYs1qbAUA
 /Ssfy5tA8c1i60G3C/ru/UBKb5F5ffLoyhl7n+Jc81vKNolSYIPMED8=

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
    
    v13: changes only due to changes in previous patch
    
    v14: no change
    
    v15: no change

 builtin/remote.c |  2 +-
 refs.c           | 33 ++++++++++++++++++++++++---------
 refs.h           |  2 +-
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index e1f15e68f4..4a8b2ef678 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1476,7 +1476,7 @@ static int set_head(int argc, const char **argv, const char *prefix)
 		goto cleanup;
 	}
 	was_detached = refs_update_symref_extended(refs, b_head.buf, b_remote_head.buf,
-			"remote set-head", &b_local_head);
+			"remote set-head", &b_local_head, 0);
 	if (was_detached == -1) {
 		result |= error(_("Could not set up %s"), b_head.buf);
 		goto cleanup;
diff --git a/refs.c b/refs.c
index d80efd58f0..2efa6bcc5c 100644
--- a/refs.c
+++ b/refs.c
@@ -2116,26 +2116,38 @@ int peel_iterated_oid(struct repository *r, const struct object_id *base, struct
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
-	    ref_transaction_update(transaction, ref, NULL, NULL,
-				   target, NULL, REF_NO_DEREF,
-				   logmsg, &err) ||
-	    ref_transaction_prepare(transaction, &err)) {
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
 	if (referent && refs_read_symbolic_ref(refs, ref, referent) == NOT_A_SYMREF) {
 		struct object_id oid;
 		if (!refs_read_ref(refs, ref, &oid)) {
@@ -2144,8 +2156,11 @@ int refs_update_symref_extended(struct ref_store *refs, const char *ref,
 		}
 	}
 
+	if (prepret == TRANSACTION_CREATE_EXISTS)
+		goto cleanup;
+
 	if (ref_transaction_commit(transaction, &err))
-		ret = error("%s", err.buf);
+		goto error_return;
 
 cleanup:
 	strbuf_release(&err);
diff --git a/refs.h b/refs.h
index b243739e4b..be38377b1f 100644
--- a/refs.h
+++ b/refs.h
@@ -586,7 +586,7 @@ int refs_update_symref(struct ref_store *refs, const char *refname,
 
 int refs_update_symref_extended(struct ref_store *refs, const char *refname,
 		       const char *target, const char *logmsg,
-		       struct strbuf *referent);
+		       struct strbuf *referent, int create_only);
 
 enum action_on_err {
 	UPDATE_REFS_MSG_ON_ERR,
-- 
2.47.0.298.g52a96ec17b

