Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AE8C433EF
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 17:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236891AbiCQR3E (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 13:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236878AbiCQR25 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 13:28:57 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C932128CC
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 10:27:40 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u10so8315386wra.9
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 10:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HkTxsmlloSd9rqcoAN+RIyGbbAVwzNH8yZe3cYdWZsY=;
        b=ijuloPuaycYx9OHcqhdtMkmEX4JuwivSCDXC8zKnYJWoXDGxynRMBaxuxigOzdDe+M
         42+62DsScmYWV/kGwZhoNPpKHAGU9WF98XM/1323N1USvHshBa5PU5REGNLgqZJOITzD
         HCROHf+qJgEroYnrKe7TOQceSnVfGD+j98A/7ZV1cc/rHjv64ankjYHfXcEfeyi+aOu/
         JJZSj558Dzi39fm08LSdgVQSdyn9XVUHxXfOTzV5eWyydtw4J7m+86NDNr0FulGzMpCO
         hcHr4AfKlyDHh65cf5xcsKWXoLwC99G6IiLlEIpa4IMHlBAP/VjU6RaRNtD7mC8EAnUX
         TSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HkTxsmlloSd9rqcoAN+RIyGbbAVwzNH8yZe3cYdWZsY=;
        b=uKg9zsYTzQOPcc5EZT7uaknNEd97FEXFL31dmB4tNUd2GWRfsEuNYckWge66D4joEx
         K+u945mkR/wtoZz90cDpYnsLpoFzk5BaPe6QX7cR09gsHs24tBKsqSvY6ZYFS4j1phWJ
         N/q46tuoPaErWeOqYDqsWxe2wGYI2hRxICpIhLkUbW6HVR9mcvP2Us/WO3am4Syi7dAL
         /070Emr04bwy1V7Bx6n3pGZmeC/IMDQJU8ShHk/32KV+dyaL1+3P0Hv39ZCU2newLZGs
         e2IdP+4B1GWk1J+Leuyl/RJDMSmE21MnD9PnKtqRMKPVtV8kELnt0Qd5mUYBvOBsQ97c
         7PxQ==
X-Gm-Message-State: AOAM5302V73JgmWP9N/7+C2yUrXPTm8svfEVTeHjaWHM+gAWev7+Lkqm
        VuOEKNljqRRe5oC3HpJX+j5iLUaD3HmQAQ==
X-Google-Smtp-Source: ABdhPJwsvkQGFHIhzlCACKXz8S/+4z+Z93GAFszDLjIbdaQmlFjEQTpTWO0c6AZaFNcO1YkvFeRxHA==
X-Received: by 2002:a05:6000:1868:b0:203:732e:6a96 with SMTP id d8-20020a056000186800b00203732e6a96mr5011199wri.39.1647538058353;
        Thu, 17 Mar 2022 10:27:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f18-20020a5d6652000000b001e669ebd528sm4690693wrw.91.2022.03.17.10.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 10:27:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/5] refs debug: add a wrapper for "read_symbolic_ref"
Date:   Thu, 17 Mar 2022 18:27:19 +0100
Message-Id: <patch-5.5-ad45319b19a-20220317T171618Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1384.g7d2906948a1
In-Reply-To: <cover-0.5-00000000000-20220317T171618Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220317T171618Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In cd475b3b038 (refs: add ability for backends to special-case reading
of symbolic refs, 2022-03-01) when the "read_symbolic_ref" callback
was added we'd fall back on "refs_read_raw_ref" if there wasn't any
backend implementation of "read_symbolic_ref".

As discussed in the preceding commit this would only happen if we were
running the "debug" backend, e.g. in the "setup for ref completion"
test in t9902-completion.sh with:

    GIT_TRACE_REFS=1 git fetch --no-tags other

Let's improve the trace output, but and also eliminate the
now-redundant refs_read_raw_ref() fallback case. As noted in the
preceding commit the "packed" backend will never call
refs_read_symbolic_ref() (nor is it ever going to). For any future
backend such as reftable it's OK to ask that they either implement
this (or a wrapper) themselves.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c       | 13 +------------
 refs/debug.c | 27 ++++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index 0b79bdd7c37..1a964505f92 100644
--- a/refs.c
+++ b/refs.c
@@ -1676,18 +1676,7 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 int refs_read_symbolic_ref(struct ref_store *ref_store, const char *refname,
 			   struct strbuf *referent)
 {
-	struct object_id oid;
-	int ret, failure_errno = 0;
-	unsigned int type = 0;
-
-	if (ref_store->be->read_symbolic_ref)
-		return ref_store->be->read_symbolic_ref(ref_store, refname, referent);
-
-	ret = refs_read_raw_ref(ref_store, refname, &oid, referent, &type, &failure_errno);
-	if (ret || !(type & REF_ISSYMREF))
-		return -1;
-
-	return 0;
+	return ref_store->be->read_symbolic_ref(ref_store, refname, referent);
 }
 
 const char *refs_resolve_ref_unsafe(struct ref_store *refs,
diff --git a/refs/debug.c b/refs/debug.c
index b83b5817118..eed8bc94b04 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -262,6 +262,24 @@ static int debug_read_raw_ref(struct ref_store *ref_store, const char *refname,
 	return res;
 }
 
+static int debug_read_symbolic_ref(struct ref_store *ref_store, const char *refname,
+				   struct strbuf *referent)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	struct ref_store *refs = drefs->refs;
+	int res;
+
+	res = refs->be->read_symbolic_ref(refs, refname, referent);
+	if (!res)
+		trace_printf_key(&trace_refs, "read_symbolic_ref: %s: (%s)\n",
+				 refname, referent->buf);
+	else
+		trace_printf_key(&trace_refs,
+				 "read_symbolic_ref: %s: %d\n", refname, res);
+	return res;
+
+}
+
 static struct ref_iterator *
 debug_reflog_iterator_begin(struct ref_store *ref_store)
 {
@@ -423,6 +441,13 @@ struct ref_storage_be refs_be_debug = {
 	.name = "debug",
 	.init = NULL,
 	.init_db = debug_init_db,
+
+	/*
+	 * None of these should be NULL. If the "files" backend (in
+	 * "struct ref_storage_be refs_be_files" in files-backend.c)
+	 * has a function we should also have a wrapper for it here.
+	 * Test the output with "GIT_TRACE_REFS=1".
+	 */
 	.transaction_prepare = debug_transaction_prepare,
 	.transaction_finish = debug_transaction_finish,
 	.transaction_abort = debug_transaction_abort,
@@ -436,7 +461,7 @@ struct ref_storage_be refs_be_debug = {
 
 	.iterator_begin = debug_ref_iterator_begin,
 	.read_raw_ref = debug_read_raw_ref,
-	.read_symbolic_ref = NULL,
+	.read_symbolic_ref = debug_read_symbolic_ref,
 
 	.reflog_iterator_begin = debug_reflog_iterator_begin,
 	.for_each_reflog_ent = debug_for_each_reflog_ent,
-- 
2.35.1.1384.g7d2906948a1

