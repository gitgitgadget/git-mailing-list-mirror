Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DAE1F943A
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518307; cv=none; b=tBU0RWH3KXquFQxA515c5+Z1g/H6l7j7rN8ikWrioSHzV1c3TEtVx+Np40GYCuPgnLe+P6Y98Yl1SAZHTWPwoJ58+oJ6JbIXbrGvPcK4M5k9Of+ACZU2Dm/WZ8dfgbO9iait5et8/CNA0zzPZ7oKOoUoVuXvPq2fWWy6LJw6360=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518307; c=relaxed/simple;
	bh=0zCB6/6fMIyeEsqSpXI5MpSSnB2yHYrhWfqp/EBwWHY=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=DiszvL3F54YqQyQM4lon39xkc/5uCvcPVPVunOVDWSspwrs5osNyJDdNt8rLKVMCJ4gAvMsu2jiN+J41cIDZlPiugdlN/nfJcHGNXfSUM0bYNRTmwEUfvzZccrEeVEfQ2RbwBdb5nJa3b3bQQqVcBNR0W2wRhciLavI5vBNcLpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=IsGWimob; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="IsGWimob"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=iDxWrGlS6yzsnvct9yRow1UT5o1dQn7yf6TkJjhQVkA=;
 b=IsGWimobxmo+RSVYsSDaTP38JPgjjArexygX4gPqFTEuFiaciAGXeuVvWGd78mvlckp2ZNeZAy9M
   Tb7VDGAKJCI0jwgYCxyp1H+5sUf0PnLGYc8m8w4DetiU/0+O/sVDAPKRHmSipEUHmheUfDx3L2fu
   fLPQEOlDS1N/GHdcSnPc1dq4ejW/sZztW7NxbJ8tlJZz82nlEa23kAh4j/UJUA/CeN6hYRXdMBPu
   YejRf8DhUxG5i98nXzf8VfDFAFR75iDKd0Jr5rOoDJLO7DVoWl5NKBsjmBXAPgZvyvkGTsjOrzm1
   AYJmFvL9qA70fOp1dKuB/eJi37UuQCNQkfVACQ==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLP0076HKV27WB0@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 21 Oct 2024 13:45:02 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?F=C5=91v=C3=A1rosi=20V=C3=ADzm=C5=B1vek=20Zrt=2E?=
 <noreply@vizmuvek.hu>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v10 6/8] refs: add create_only option to
 refs_update_symref_extended
Date: Mon, 21 Oct 2024 15:37:03 +0200
Message-id: <20241021134354.705636-7-bence@ferdinandy.com>
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
 ++x4+j0FghhrTN7ScZ0X+hHho01Zki0BZtRvoxgZ/9IQox4gUEqVYoYUIb4e9R6u
 V9Zw56utf1TEd0bIQDz/MHgd3HV3gBvK2rW15lVVukYU7E2e2j2IZd7+dw/bv3ij
 ePblh/lz7q0j94dTfshdwsR16eTa4KaVtRgfkTWDpEJTJIGp6/pBNz5fn2ndP0SG
 zv5KYzXxeKDTjTeLi+gtvbkQPyl73z6fxC/7WkyHzWLGqRVfnOi8YVnhtC0faUNG
 xYgK93KG/LzJgX9QCNvMgn38RK7Pqncn7J2g6dpLJ9HmSB2C3o0hzh0yjInVZZHo
 L6K5zqbqpIaP8mfS54SeQ+EtHIr4mbwdsWvUW5I8Tnj+uP52f11kdfIXzjolTkPE
 88yedwh6kpwcggwrlPlGqrr21S3p4anYrKkt5WPV0u0tWTmNAaFhOoMR

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
2.47.0.94.g8861098b6d

