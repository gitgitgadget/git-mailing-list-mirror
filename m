Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1893BC433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 13:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbiAMNCK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 08:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiAMNCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 08:02:09 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945D8C06173F
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 05:02:08 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id b13so22968515edn.0
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 05:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=VESOsSJqfEE1atoOLgEv6UXk4xATq0rr+dX2ErAC1Dw=;
        b=hOWvjFvqN7ZJxf+BqrTRPFtZBJ/3O4TnVWOPtJycndYiRZPe08SDRRf/WYPHh5zOm5
         KBpMDuNhIjqXXo0wMYi/9fLwgK/rLvwdrUgv9Fp0LfiTd+gytnK8qnI7KKHFCGhdMJxg
         fOupm9EJXlLZ9f+t379WjRpiVEhavMIAIsxZsnv2MATZBah7vqbzmT1TAgGOLIZiknbl
         4NGXNPIYdKMwNcGufCspoKXZKGwBMQLgb4yGA9jsAUt6W7JwdIDejVpuHhN64WmxWRKY
         pL0sSL3hE6RZfR9T/Dj5BB1c1JWbMYiYJ3bdMwPsdD2EwPH0rn13dKagSEtv96jJdezH
         TP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=VESOsSJqfEE1atoOLgEv6UXk4xATq0rr+dX2ErAC1Dw=;
        b=DwpynAI7DQTg/RLW2m3SgsXYEz2yjSR11JRMRAVyU6yMORkCKvofpDsnVNQoG0CvHY
         uScdJAJW7Hcjd3URt0lDyjfV5UMdxK2aYy05UNi+1/j4aUkUfUhOS6yIGfbVvZ3D9KLw
         AEyS/1QRiWHXElgj+l//sBs31IOLuG696w3O3Uz2QVhKTHK1OffYCgujNCa6CAoCDRGl
         kWTX8zeCjvjqSpzwxQ/S9R0qH3HHh+BnF6zDWL7a24IWW1ZQfS5ZkoZedxumdTXjh8i2
         ApoWy2fY9JtnqyEBkr4mGNyQ3OPG7G8Vg7WvYkrxe7g48KGx0e5DR95ayveQxsiq94bF
         iWXA==
X-Gm-Message-State: AOAM530qvueXXBWdKHD7livxuK12WB3rbACKIpE7LGg7QJEczdv0r92j
        oL8e0WIA3OzbrHNwl/MvzWc=
X-Google-Smtp-Source: ABdhPJxJkVs5eEW2Vh164x6F/491DMC1K9DSMnpdlTK8MO+daMiK9YuwvfZO94CvyHGgPGMD56X0pw==
X-Received: by 2002:a05:6402:1941:: with SMTP id f1mr4108742edz.396.1642078927002;
        Thu, 13 Jan 2022 05:02:07 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f27sm166324ejd.95.2022.01.13.05.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 05:02:06 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n7zjx-000vVA-P7;
        Thu, 13 Jan 2022 14:02:05 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v3 5/6] refs: do not execute reference-transaction hook
 on packing refs
Date:   Thu, 13 Jan 2022 14:00:10 +0100
References: <cover.1641556319.git.ps@pks.im>
 <cover.1642054003.git.ps@pks.im>
 <d83f309b9c988d7cad9524ac56c0b4c81e2d863f.1642054003.git.ps@pks.im>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <d83f309b9c988d7cad9524ac56c0b4c81e2d863f.1642054003.git.ps@pks.im>
Message-ID: <220113.86czkvvlf6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 13 2022, Patrick Steinhardt wrote:

> [[PGP Signed Part:Undecided]]
> The reference-transaction hook is supposed to track logical changes to
> references, but it currently also gets executed when packing refs in a
> repository. This is unexpected and ultimately not all that useful:
> packing refs is not supposed to result in any user-visible change to the
> refs' state, and it ultimately is an implementation detail of how refs
> stores work.
>
> Fix this excessive execution of the hook when packing refs.
>
> Reported-by: Waleed Khan <me@waleedkhan.name>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/files-backend.c             |  6 ++++--
>  t/t1416-ref-transaction-hooks.sh | 11 +----------
>  2 files changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index ecf88cee04..3c0f3027fe 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1121,7 +1121,8 @@ static void prune_ref(struct files_ref_store *refs, struct ref_to_prune *r)
>  	if (check_refname_format(r->name, 0))
>  		return;
>  
> -	transaction = ref_store_transaction_begin(&refs->base, 0, &err);
> +	transaction = ref_store_transaction_begin(&refs->base,
> +						  REF_TRANSACTION_SKIP_HOOK, &err);
>  	if (!transaction)
>  		goto cleanup;
>  	ref_transaction_add_update(
> @@ -1192,7 +1193,8 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
>  	struct strbuf err = STRBUF_INIT;
>  	struct ref_transaction *transaction;
>  
> -	transaction = ref_store_transaction_begin(refs->packed_ref_store, 0, &err);
> +	transaction = ref_store_transaction_begin(refs->packed_ref_store,
> +						  REF_TRANSACTION_SKIP_HOOK, &err);
>  	if (!transaction)
>  		return -1;
>  
> diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
> index 0567fbdf0b..f9d3d5213f 100755
> --- a/t/t1416-ref-transaction-hooks.sh
> +++ b/t/t1416-ref-transaction-hooks.sh
> @@ -150,21 +150,12 @@ test_expect_success 'hook does not get called on packing refs' '
>  	git pack-refs --all &&
>  
>  	# We only expect a single hook invocation, which is the call to
> -	# git-update-ref(1). But currently, packing refs will also trigger the
> -	# hook.
> +	# git-update-ref(1).
>  	cat >expect <<-EOF &&
>  		prepared
>  		$ZERO_OID $POST_OID refs/heads/unpacked-ref
>  		committed
>  		$ZERO_OID $POST_OID refs/heads/unpacked-ref
> -		prepared
> -		$ZERO_OID $POST_OID refs/heads/unpacked-ref
> -		committed
> -		$ZERO_OID $POST_OID refs/heads/unpacked-ref
> -		prepared
> -		$POST_OID $ZERO_OID refs/heads/unpacked-ref
> -		committed
> -		$POST_OID $ZERO_OID refs/heads/unpacked-ref
>  	EOF
>  
>  	test_cmp expect actual

I wondered how we'd deal with cases where the loose ref != the
corresponding packed ref, but I can't think of ones where it won't be
invisible externally, i.e. we'll correctly update the packed-refs and
delete that loose ref as part of this transaction.

I do wonder if the docs also need updating, currently they say:

    [The hook] executes whenever a reference transaction is prepared,
    committed or aborted[...]

But now we'll explicitly exclude certain classes of
transactions. Perhaps we should expand:

    "The hook does not cover symbolic references (but that may change in
    the future)."

Into some list of types of changes we intentionally exclude, might
include in the future etc.
