Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1601AC433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 13:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbiAMN6c (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 08:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiAMN6c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 08:58:32 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82F4C06173F
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 05:58:31 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id i5so23351098edf.9
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 05:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=iHpQgmFVr6l0dVxf17EF4oylSYGgslzYWpKTjanUDkc=;
        b=Ds82MZLK15oRkLaom+0vT8AyWQTjM+pVlLXFwINBHm9ZZDurqJ5pExF+xRLUCrWaeX
         f/3in5PiT+aqk9HD8g56StY24jVlM2JoNQEldFQsUg0/pb+KHTAf+UNsR47dY3UtvO1e
         AB9YEmTHYGVCHO9+vEPMn+DEmAuRXoJ5dl4qEgcTyYwzC9NJpXz4lBhjGdBX9Tz+lLOm
         bFuYrZpa2eCD7m8cu3Gmv8A/FzwBkdd8Sg01jbc8akdqu4pKFNIEQeCGSn2YhVoqFLw8
         seHQGGf+haGaH4tXvt/DKifpItG5htj/glCfO5YsKUqiIcWO+euTnAyR/NLD8NyWbf6l
         PZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=iHpQgmFVr6l0dVxf17EF4oylSYGgslzYWpKTjanUDkc=;
        b=wIbOpZBlpTY3M1A58did94Da6CdsctI1XGxghhqN5OvSoP4Dkovd2amTAFRUnqf79w
         QBDydhAvsePTBEh5V+A4KHWzxft7wB+OeAFU3ajqXzCYCH+tbkeMd6L2JOYQVAlBklPZ
         42M4GZEcycLGCAtRgAAAlS/m5e2UcfIvoox5suJJog9bwkxcP+KbPpHFrU985NXoDZgF
         R3YYw/DIzVdNgAFSpXmMiO3TjBlGRwf9mULDxdDOe5PoWSliLVVlAvvnpAAezH1A6RLI
         gFQf7+BO/wi27n5m4G9jBelGPuLLaJag0d4qmIheNC5zrGwnjKXFn/KrPRtcR7FvOMlq
         j8mg==
X-Gm-Message-State: AOAM5322NeNo0RrO21MobnrVUJU26sis0Je/9UIUrpdfu5TDVGjw/dUj
        xNABhTcsTGpGc7yx8pR7Q/agICxi8eSdwg==
X-Google-Smtp-Source: ABdhPJzfA3vR6BLhyyUxrUGFFQYhh0+B+1fcDUbuNmmMIDb8sSYW53g1Iw0JGlUGnIy2K3TnoQHiEw==
X-Received: by 2002:a17:907:8687:: with SMTP id qa7mr3551244ejc.106.1642082310063;
        Thu, 13 Jan 2022 05:58:30 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j11sm1200325edv.0.2022.01.13.05.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 05:58:29 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n80cX-000wyR-5H;
        Thu, 13 Jan 2022 14:58:29 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v3 3/6] refs: allow skipping the reference-transaction hook
Date:   Thu, 13 Jan 2022 14:34:41 +0100
References: <cover.1641556319.git.ps@pks.im>
 <cover.1642054003.git.ps@pks.im>
 <be826bae3b564fe003778ea10cb2e06fc753c21d.1642054003.git.ps@pks.im>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <be826bae3b564fe003778ea10cb2e06fc753c21d.1642054003.git.ps@pks.im>
Message-ID: <220113.86zgnzu48q.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 13 2022, Patrick Steinhardt wrote:

> [[PGP Signed Part:Undecided]]
> The reference-transaction hook is executing whenever we prepare, commit
> or abort a reference transaction. While this is mostly intentional, in
> case of the files backend we're leaking the implementation detail that
> the store is in fact a composite store with one loose and one packed
> backend to the caller. So while we want to execute the hook for all
> logical updates, executing it for such implementation details is
> unexpected.
>
> Prepare for a fix by adding a new flag which allows to skip execution of
> the hook.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs.c | 3 +++
>  refs.h | 5 +++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/refs.c b/refs.c
> index 7415864b62..526bf5ed97 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2084,6 +2084,9 @@ static int run_transaction_hook(struct ref_transaction *transaction,
>  	const char *hook;
>  	int ret = 0, i;
>  
> +	if (transaction->flags & REF_TRANSACTION_SKIP_HOOK)
> +		return 0;
> +
>  	hook = find_hook("reference-transaction");
>  	if (!hook)
>  		return ret;
> diff --git a/refs.h b/refs.h
> index 31f7bf9642..d4056f9fe2 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -568,6 +568,11 @@ enum action_on_err {
>  	UPDATE_REFS_QUIET_ON_ERR
>  };
>  
> +/*
> + * Skip executing the reference-transaction hook.
> + */
> +#define REF_TRANSACTION_SKIP_HOOK (1 << 0)
> +
>  /*
>   * Begin a reference transaction.  The reference transaction must
>   * be freed by calling ref_transaction_free().

This isn't needed in refs.h, so let's put it in refs-internal.h where
e.g. "enum ref_transaction_state" now lives:
    
    diff --git a/refs.h b/refs.h
    index d4056f9fe26..31f7bf96424 100644
    --- a/refs.h
    +++ b/refs.h
    @@ -568,11 +568,6 @@ enum action_on_err {
            UPDATE_REFS_QUIET_ON_ERR
     };
     
    -/*
    - * Skip executing the reference-transaction hook.
    - */
    -#define REF_TRANSACTION_SKIP_HOOK (1 << 0)
    -
     /*
      * Begin a reference transaction.  The reference transaction must
      * be freed by calling ref_transaction_free().
    diff --git a/refs/refs-internal.h b/refs/refs-internal.h
    index a0af63f162f..87da39243f7 100644
    --- a/refs/refs-internal.h
    +++ b/refs/refs-internal.h
    @@ -201,6 +201,11 @@ enum ref_transaction_state {
            REF_TRANSACTION_CLOSED   = 2
     };
     
    +/*
    + * Skip executing the reference-transaction hook.
    + */
    +#define REF_TRANSACTION_SKIP_HOOK (1 << 0)
    +
     /*
      * Data structure for holding a reference transaction, which can
      * consist of checks and updates to multiple references, carried out

A bit more odd is that this series ends up with a
ref_transaction_begin() that doesn't correspond to its ref_store_*()
parent, i.e. the others pass the ref store for you, but now we omit the
flags too.

I see why you did that, to avoid tweaking every existing
ref_transaction_begin() caller.

But isn't something like the below a better approach? We can introduce a
refs-internal.h-only flag enum, and then just have a new
ref_store_transaction_begin_no_hook() called from these new
files-backend.c users.

The diff on top is a bit verbose, but the exposed API is cleaner
(presumably no "public" user should be allowed to skip the hook), and
the overall diff if this is squashed in is smaller.

diff --git a/refs.c b/refs.c
index 526bf5ed97a..ffaf34e9710 100644
--- a/refs.c
+++ b/refs.c
@@ -800,7 +800,7 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 
-	transaction = ref_store_transaction_begin(refs, 0, &err);
+	transaction = ref_store_transaction_begin(refs, &err);
 	if (!transaction ||
 	    ref_transaction_delete(transaction, refname, old_oid,
 				   flags, msg, &err) ||
@@ -1004,22 +1004,36 @@ int read_ref_at(struct ref_store *refs, const char *refname,
 	return 1;
 }
 
-struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
-						    unsigned int flags,
-						    struct strbuf *err)
+static struct ref_transaction *ref_store_transaction_begin_1(struct ref_store *refs,
+							     unsigned int no_hook,
+							     struct strbuf *err)
 {
 	struct ref_transaction *tr;
 	assert(err);
 
 	CALLOC_ARRAY(tr, 1);
 	tr->ref_store = refs;
-	tr->flags = flags;
+	if (no_hook)
+		tr->flags &= REF_TRANSACTION_SKIP_HOOK;
 	return tr;
 }
 
 struct ref_transaction *ref_transaction_begin(struct strbuf *err)
 {
-	return ref_store_transaction_begin(get_main_ref_store(the_repository), 0, err);
+	return ref_store_transaction_begin_1(get_main_ref_store(the_repository),
+					     0, err);
+}
+
+struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
+						    struct strbuf *err)
+{
+	return ref_store_transaction_begin_1(refs, 0, err);
+}
+
+struct ref_transaction *ref_store_transaction_begin_no_hook(struct ref_store *refs,
+							    struct strbuf *err)
+{
+	return ref_store_transaction_begin_1(refs, 1, err);
 }
 
 void ref_transaction_free(struct ref_transaction *transaction)
@@ -1158,7 +1172,7 @@ int refs_update_ref(struct ref_store *refs, const char *msg,
 	struct strbuf err = STRBUF_INIT;
 	int ret = 0;
 
-	t = ref_store_transaction_begin(refs, 0, &err);
+	t = ref_store_transaction_begin(refs, &err);
 	if (!t ||
 	    ref_transaction_update(t, refname, new_oid, old_oid, flags, msg,
 				   &err) ||
diff --git a/refs.h b/refs.h
index 31f7bf96424..3663e0347ff 100644
--- a/refs.h
+++ b/refs.h
@@ -573,8 +573,9 @@ enum action_on_err {
  * be freed by calling ref_transaction_free().
  */
 struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
-						    unsigned int flags,
 						    struct strbuf *err);
+struct ref_transaction *ref_store_transaction_begin_no_hook(struct ref_store *refs,
+							    struct strbuf *err);
 struct ref_transaction *ref_transaction_begin(struct strbuf *err);
 
 /*
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9a20cb8fa89..f85c8f3a692 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1121,8 +1121,7 @@ static void prune_ref(struct files_ref_store *refs, struct ref_to_prune *r)
 	if (check_refname_format(r->name, 0))
 		return;
 
-	transaction = ref_store_transaction_begin(&refs->base,
-						  REF_TRANSACTION_SKIP_HOOK, &err);
+	transaction = ref_store_transaction_begin_no_hook(&refs->base, &err);
 	if (!transaction)
 		goto cleanup;
 	ref_transaction_add_update(
@@ -1193,8 +1192,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 	struct strbuf err = STRBUF_INIT;
 	struct ref_transaction *transaction;
 
-	transaction = ref_store_transaction_begin(refs->packed_ref_store,
-						  REF_TRANSACTION_SKIP_HOOK, &err);
+	transaction = ref_store_transaction_begin_no_hook(refs->packed_ref_store, &err);
 	if (!transaction)
 		return -1;
 
@@ -1261,8 +1259,7 @@ static int files_delete_refs(struct ref_store *ref_store, const char *msg,
 	if (packed_refs_lock(refs->packed_ref_store, 0, &err))
 		goto error;
 
-	transaction = ref_store_transaction_begin(refs->packed_ref_store,
-						  REF_TRANSACTION_SKIP_HOOK, &err);
+	transaction = ref_store_transaction_begin_no_hook(refs->packed_ref_store, &err);
 	if (!transaction)
 		goto error;
 
@@ -2775,9 +2772,8 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 			 * packed-refs if it exists there.
 			 */
 			if (!packed_transaction) {
-				packed_transaction = ref_store_transaction_begin(
-						refs->packed_ref_store,
-						REF_TRANSACTION_SKIP_HOOK, err);
+				packed_transaction = ref_store_transaction_begin_no_hook(
+						refs->packed_ref_store, err);
 				if (!packed_transaction) {
 					ret = TRANSACTION_GENERIC_ERROR;
 					goto cleanup;
@@ -3048,8 +3044,7 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 				 &affected_refnames))
 		BUG("initial ref transaction called with existing refs");
 
-	packed_transaction = ref_store_transaction_begin(refs->packed_ref_store,
-							 REF_TRANSACTION_SKIP_HOOK, err);
+	packed_transaction = ref_store_transaction_begin_no_hook(refs->packed_ref_store, err);
 	if (!packed_transaction) {
 		ret = TRANSACTION_GENERIC_ERROR;
 		goto cleanup;
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index cfebcd0b46e..e97d67f9321 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1535,7 +1535,7 @@ static int packed_delete_refs(struct ref_store *ref_store, const char *msg,
 	 * updates into a single transaction.
 	 */
 
-	transaction = ref_store_transaction_begin(ref_store, 0, &err);
+	transaction = ref_store_transaction_begin(ref_store, &err);
 	if (!transaction)
 		return -1;
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 87da39243f7..8ff9e0e6e3a 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -204,7 +204,9 @@ enum ref_transaction_state {
 /*
  * Skip executing the reference-transaction hook.
  */
-#define REF_TRANSACTION_SKIP_HOOK (1 << 0)
+enum ref_transaction_flags {
+	REF_TRANSACTION_SKIP_HOOK = 1 << 0,
+};
 
 /*
  * Data structure for holding a reference transaction, which can
@@ -218,7 +220,7 @@ struct ref_transaction {
 	size_t nr;
 	enum ref_transaction_state state;
 	void *backend_data;
-	unsigned int flags;
+	enum ref_transaction_flags flags;
 };
 
 /*
diff --git a/sequencer.c b/sequencer.c
index 61edd39d7a4..6abd72160cc 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3588,7 +3588,7 @@ static int do_label(struct repository *r, const char *name, int len)
 	strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
 	strbuf_addf(&msg, "rebase (label) '%.*s'", len, name);
 
-	transaction = ref_store_transaction_begin(refs, 0, &err);
+	transaction = ref_store_transaction_begin(refs, &err);
 	if (!transaction) {
 		error("%s", err.buf);
 		ret = -1;
