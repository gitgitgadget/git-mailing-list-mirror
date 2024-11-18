Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E901B6CF1
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944035; cv=none; b=Hc5ySA8M3w7oeE2bY9VrCBtFdkuXAYKDhcP4DtdCukX+Yo9TyEYmaq9jJsSJP9rnkadhlp4yz0PERoClcTvekToGdce+VGcQMUbZ5To8m39JcGjqRkDS13/S1Jd7jWVw5v1KaG+YPcyDh+3wbYPQ5FjThMQrhYLqBiS0nA6bgMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944035; c=relaxed/simple;
	bh=ndEtPEXCcHgVHzPnMsMp/YCudanAcKqzaS1geH7XZGA=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=unGwVgPrxXKk1L92gOvBKq1weKR3mkgLkToseTmgjvn+3VilPcxAMoBWR7oXaC6ttugEa5MqVPxYt7qAFvTloqtMNaUhj7wic8FRuHy4rnxa6+XVFIROpCqJqN0IjtgDCeX3jchI8VubBKkOCunKVWVfhLAo7f8DZfHwk48OZto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=OGurj+NH; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="OGurj+NH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=BQ94gtHn8fkDdLCvcQilV0+2IZN9w0HAcYudTP5NCvA=;
 b=OGurj+NHaohMzcQD40aDcE0UZAHPLtXoLyJSGaK86t0kJGj8X1LVLEjahXE9NBja0s03w5XAbEXJ
   NmikfSzBLMZzQxSeVaoUo9B9QVe6hil1onoZxZs9KkLNWgYPv2rlD4DWyhjx1lM0yb38UAOzqlI9
   gIWttvWI03jxMdNsxN4+VXTQWdmoQgFk77Hae6FfoHrVnGUmoGCzRoY56mLevuSVq9UZKyb3z1Mp
   rELf/FGh05E9oiX63J7+ConWvECaLarPWT4sTijCzp7irabUosGAeVBP/m70oEtHsgImT+Cji3wq
   ctyeglrzvKEfGIqY53qyO8T+z6ePJ5G0+EpLiA==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SN500NA6KKE6H50@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 18 Nov 2024 15:33:50 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v13 2/9] refs: standardize output of refs_read_symbolic_ref
Date: Mon, 18 Nov 2024 16:09:21 +0100
Message-id: <20241118151755.756265-3-bence@ferdinandy.com>
In-reply-to: <20241118151755.756265-1-bence@ferdinandy.com>
References: <20241023153736.257733-1-bence@ferdinandy.com>
 <20241118151755.756265-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAG4Oex3YRGiNXWfKTm/PSO3GSKpZyuOLR0uSheYu1h3XN7shxKTsD8ll2cqGSAH
 br72+svqw7Qt9tiMBELBW1TIBoeicNDuxqIgIKLQkIYzoxLKYjkUZYZlYIj167Kx
 3uEtUg1MTu5nUrjDnHrM67mpJPq2vxxdDIhMW1N3PGw2VjuUrTxo8yKMdmQ+cfMM
 WxFP722e8WaTvh2ltsiI+Bh2jLkasQBhBXQV5iXiYgVvqKyDrrYXpq0Ws0JUwfbc
 6FUCr0aKTZzbQQpRGNq2ZS6Y2BiStX9tCJXFjeSU1cs/pxyLI8HEy5QOv0f2/9m+
 yAPlfD9+CGELFYg4lnBzwe6FJEvuhyUDGuvmyVxsVT13LqfOrHRw9C/nmu740ihc
 P4MGXrlxqg/6gdXngqg3LQ3auOrPvSbc1k3eW1JKxHAEaQL9T/OzBncCxm9Gki2g
 meIQe7V/3ytWzUMbfLpkWncdjsdguPYYk5Mj/+U6rn1BWFA437nptxXd

When the symbolic reference we want to read with refs_read_symbolic_ref
is actually not a symbolic reference, the files and the reftable
backends return different values (1 and -1 respectively). Standardize
the returned values so that 0 is success, -1 is a generic error and -2
is that the reference was actually non-symbolic.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v13: new patch

 refs.h                  | 6 ++++++
 refs/files-backend.c    | 7 +++----
 refs/refs-internal.h    | 6 ++++++
 refs/reftable-backend.c | 4 +++-
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/refs.h b/refs.h
index 108dfc93b3..f8b714ca1d 100644
--- a/refs.h
+++ b/refs.h
@@ -83,6 +83,12 @@ int refs_read_ref_full(struct ref_store *refs, const char *refname,
 
 int refs_read_ref(struct ref_store *refs, const char *refname, struct object_id *oid);
 
+/*
+ * Return 0 if the symbolic reference could be read without error.
+ * Return -1 for generic errors.
+ * Return -2 if the reference was actually non-symbolic.
+ */
+
 int refs_read_symbolic_ref(struct ref_store *ref_store, const char *refname,
 			   struct strbuf *referent);
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0824c0b8a9..81e650ec48 100644
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
+		return -2;
+	return ret;
 }
 
 int parse_loose_ref_contents(const struct git_hash_algo *algop,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 2313c830d8..f0ef354bce 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -673,6 +673,12 @@ struct ref_storage_be {
 
 	ref_iterator_begin_fn *iterator_begin;
 	read_raw_ref_fn *read_raw_ref;
+
+	/*
+	 * Return 0 if the symbolic reference could be read without error.
+	 * Return -1 for generic errors.
+	 * Return -2 if the reference was actually non-symbolic.
+	 */
 	read_symbolic_ref_fn *read_symbolic_ref;
 
 	reflog_iterator_begin_fn *reflog_iterator_begin;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 38eb14d591..60cb83f23a 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -830,7 +830,9 @@ static int reftable_be_read_symbolic_ref(struct ref_store *ref_store,
 		return ret;
 
 	ret = reftable_stack_read_ref(stack, refname, &ref);
-	if (ret == 0 && ref.value_type == REFTABLE_REF_SYMREF)
+	if (!ret && (ref.value_type != REFTABLE_REF_SYMREF))
+		ret = -2;
+	else if (!ret && (ref.value_type == REFTABLE_REF_SYMREF))
 		strbuf_addstr(referent, ref.value.symref);
 	else
 		ret = -1;
-- 
2.47.0.296.gda1ecfef29.dirty

