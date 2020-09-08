Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78876C433E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 21:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CC5F2080C
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 21:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pj/+5lXQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgIHVPj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 17:15:39 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56515 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgIHVPj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 17:15:39 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 72FA4E7851;
        Tue,  8 Sep 2020 17:15:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u+KVBgxdjoBCz1Ko0safLdlfum8=; b=Pj/+5l
        XQV8fs3bx91QgXs1JawNrWQoRW19J6ffl29pYjh8fQ0SJ8EWu5t2ukBouRAJ2k0V
        sOizofYbnGYIhBYx5SsbRJo7V9FGkrkodvemq8KCURl2iW5yuJUKoYmIRlWMuAr9
        5GkFpIRVoGGmlBCS3xtb3i84Zta+id4zk62lI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dbOBe2VjgjQgEDixZzrSURv6IPSTgzsN
        pD+stWZMISgqqXLnwhUqaJCNAGkkITZP3jjZgxVkc3fx2GyWSAb03SshCGkNBmgN
        7kQqcjtozfzfJx+XR+0VO+muT/MGgh+gkf19i3R3s7SwCgy1m09D/IUzLeYdffuC
        IBwhJxF0YMc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 695DBE7850;
        Tue,  8 Sep 2020 17:15:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 81B47E781E;
        Tue,  8 Sep 2020 17:15:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2] refs: add GIT_TRACE_REFS debugging mechanism
References: <pull.713.git.1598628529512.gitgitgadget@gmail.com>
        <pull.713.v2.git.1599492274909.gitgitgadget@gmail.com>
Date:   Tue, 08 Sep 2020 14:15:32 -0700
In-Reply-To: <pull.713.v2.git.1599492274909.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Mon, 07 Sep 2020 15:24:34
        +0000")
Message-ID: <xmqq7dt4x957.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F1C429A-F218-11EA-ACA2-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/refs.c b/refs.c
> index 156fdcd459..5febfe2281 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1774,6 +1774,7 @@ struct ref_store *get_main_ref_store(struct repository *r)
>  		BUG("attempting to get main_ref_store outside of repository");
>  
>  	r->refs_private = ref_store_init(r->gitdir, REF_STORE_ALL_CAPS);
> +	r->refs_private = maybe_debug_wrap_ref_store(r->gitdir, r->refs_private);

So the idea is to capture calls to backend, emit tracing events and
defer to the real backend?

Cute.  I like it.

> diff --git a/refs/debug.c b/refs/debug.c
> new file mode 100644
> index 0000000000..68ae531b45
> --- /dev/null
> +++ b/refs/debug.c
> @@ -0,0 +1,396 @@
> +
> +#include "refs-internal.h"
> +#include "trace.h"
> +
> +static struct trace_key trace_refs = TRACE_KEY_INIT(REFS);
> +
> +struct debug_ref_store {
> +	struct ref_store base;
> +	struct ref_store *refs;
> +};
> +
> +extern struct ref_storage_be refs_be_debug;
> +
> +struct ref_store *maybe_debug_wrap_ref_store(const char *gitdir, struct ref_store *store)
> +{
> +	struct debug_ref_store *res;
> +	struct ref_storage_be *be_copy;
> +
> +	if (!trace_want(&trace_refs)) {
> +		return store;
> +	}
> +	res = malloc(sizeof(struct debug_ref_store));
> +	be_copy = malloc(sizeof(*be_copy));

Not xmalloc() and friends?

> +	*be_copy = refs_be_debug;
> +	be_copy->name = store->be->name;

I guess we never destroy the ref-store instances so it is OK to
assume that it would not cause problems later by sharing pieces of
memory with underlying "real" thing like this.

> +	trace_printf_key(&trace_refs, "ref_store for %s\n", gitdir);
> +	res->refs = store;
> +	base_ref_store_init((struct ref_store *)res, be_copy);
> +	return (struct ref_store *)res;
> +}
> + ...
> +static void print_update(int i, const char *refname,
> +			 const struct object_id *old_oid,
> +			 const struct object_id *new_oid, unsigned int flags,
> +			 unsigned int type, const char *msg)
> +{
> +	char o[200] = "null";
> +	char n[200] = "null";

I thought we had better constant than 200 (later you use 100 in the
same patch).  I am not sure how I feel about "null"; all places in
Git, we tend to use 0{length-of-the-hash} for "no object name on
this side", I think.

> +	if (old_oid)
> +		oid_to_hex_r(o, old_oid);
> +	if (new_oid)
> +		oid_to_hex_r(n, new_oid);
> +
> +	type &= 0xf; /* see refs.h REF_* */
> +	flags &= REF_HAVE_NEW | REF_HAVE_OLD | REF_NO_DEREF |
> +		REF_FORCE_CREATE_REFLOG;
> +	trace_printf_key(&trace_refs, "%d: %s %s -> %s (F=0x%x, T=0x%x) \"%s\"\n", i, refname,
> +		o, n, flags, type, msg);
> +}
> +
> +static void print_transaction(struct ref_transaction *transaction)
> +{
> +	trace_printf_key(&trace_refs, "transaction {\n");
> +	for (int i = 0; i < transaction->nr; i++) {

We still do not allow variable decl inside the set-up part of a
for(;;) statement, if I recall Documentation/CodingGuidelines
correctly.

> +static int debug_delete_refs(struct ref_store *ref_store, const char *msg,
> +			     struct string_list *refnames, unsigned int flags)
> +{
> +	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
> +	int res =
> +		drefs->refs->be->delete_refs(drefs->refs, msg, refnames, flags);
> +	int i = 0;

No need to initialize 'i' here.

> +	trace_printf_key(&trace_refs, "delete_refs {\n");
> +	for (i = 0; i < refnames->nr; i++)
> +		trace_printf_key(&trace_refs, "%s\n", refnames->items[i].string);
> +	trace_printf_key(&trace_refs, "}: %d\n", res);
> +	return res;
> +}

Thanks.
