Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94B0C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 12:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D2C61353
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 12:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbhGAMZv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 08:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236388AbhGAMZu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 08:25:50 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B70C061756
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 05:23:20 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bu12so10149496ejb.0
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 05:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=rqcrgEerI9PIA0i+kWmxI0RMssNqEFl7HVv62nLvL0Q=;
        b=lJE8gS1GbB/WDQB0G9eAb/8L6TwhHPDRMftJdNDcYssJrVdJNL5vjQZzHyRtLw84Cf
         RuMWnHFJhBUY8TPcfhb3YW4wwTqOMOyKyI4GPji9LTsLtEzVvBLbpnOJ9Fqc65RqKBhS
         gCr/Z0xvxMRnAxb1JRM3kzmKSsRFR0ZzllrnRRSmAmYFQCXaFR0TehBr+F3+9vM6D3ZR
         KRSd7sTD2PozI9hp3UjaSuvn9btncd9XeLx0gfMSenIuZMT3jybi7sDtOomLsq8V9ZlL
         gbEaeN5jaaJ8jvoTtpQyC1bmotBDn1U55UAdytR1HQzs2Tt8fOSM8WNVnabMCXPnUFjv
         sjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=rqcrgEerI9PIA0i+kWmxI0RMssNqEFl7HVv62nLvL0Q=;
        b=T5/KgTCOvSe92aElwYJvzbqpCoiVljjv9shvtmaMKSLDs2Q3eQJj9VIG0RIVb1b5Iy
         CFo/btnHuAxevGccniI7CCPufvWez4rng05GQdFIJ9WeP/3LG2OZpESrl+Gf6FrMAF84
         wHZVe6RZZGZh6J0bHhjhXLRb/QFHRDT6NKCRTo4NolB20prOo8mudGDUPcbvtes25tPY
         JKDTpVWdIYdIaLDuZ1OtM8BV7DP/OzN09kAOYztlrkKTFk1fb3t4ZEcnrcaq+Qk+kByI
         tjj2Y8APpC6PJBarps/LMLxt88ez8zlLzSQ10c4nyTlUDZ2XYE+z+nCJsPyDqSb3V3xj
         EIqA==
X-Gm-Message-State: AOAM532eebi2GRp9Wunax4xsDqZioud4tewdROCevanFeAeubysjnWzr
        VgJ4NL2KWNUy0L4wpBFyJ+NUiZpJ9mqbmQ==
X-Google-Smtp-Source: ABdhPJzBSLtjTRO5bP0na9S6ikFFABmTUY+sK4117Qw7eyEUvwbsM2EKs9651Qjdcb1Kbrng3JWvlA==
X-Received: by 2002:a17:906:1982:: with SMTP id g2mr40754305ejd.184.1625142198046;
        Thu, 01 Jul 2021 05:23:18 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id p19sm13925686edr.73.2021.07.01.05.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 05:23:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 7/8] refs: clear errno return in
 refs_resolve_ref_unsafe()
Date:   Thu, 01 Jul 2021 14:19:18 +0200
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
 <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
 <d86516219689e9179f3ba18c2ad2391d8ca27076.1623329869.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <d86516219689e9179f3ba18c2ad2391d8ca27076.1623329869.git.gitgitgadget@gmail.com>
Message-ID: <875yxudxzf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 10 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> This is done in a separate commit, to pinpoint the precise cause should there be
> regressions in error reporting.
>
> This is implemented by renaming the existing logic to a static function
> refs_resolve_unsafe_implicit_errno(), minimizing the code diff.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  refs.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index ed2dde1c0c6d..191cbf5a330f 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1687,10 +1687,10 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
>  }
>  
>  /* This function needs to return a meaningful errno on failure */
> -const char *refs_resolve_ref_unsafe(struct ref_store *refs,
> -				    const char *refname,
> -				    int resolve_flags,
> -				    struct object_id *oid, int *flags)
> +static const char *

The "let's make this static" seems like an unrelated change we should
squash into the earlier "refs: use refs_resolve_ref_unsafe_with_errno()
where needed", we stopped using it in the files backend then. No?

> +refs_resolve_ref_unsafe_implicit_errno(struct ref_store *refs,
> +				       const char *refname, int resolve_flags,
> +				       struct object_id *oid, int *flags)
>  {
>  	static struct strbuf sb_refname = STRBUF_INIT;
>  	struct object_id unused_oid;
> @@ -1779,14 +1779,24 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
>  	return NULL;
>  }
>  
> +const char *refs_resolve_ref_unsafe(struct ref_store *refs, const char *refname,
> +				    int resolve_flags, struct object_id *oid,
> +				    int *flags)
> +{
> +	const char *result = refs_resolve_ref_unsafe_implicit_errno(
> +		refs, refname, resolve_flags, oid, flags);
> +	errno = 0;
> +	return result;
> +}
> +
>  const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
>  					       const char *refname,
>  					       int resolve_flags,
>  					       struct object_id *oid,
>  					       int *flags, int *failure_errno)
>  {
> -	const char *result = refs_resolve_ref_unsafe(refs, refname,
> -						     resolve_flags, oid, flags);
> +	const char *result = refs_resolve_ref_unsafe_implicit_errno(
> +		refs, refname, resolve_flags, oid, flags);
>  	*failure_errno = errno;
>  	return result;
>  }

Per my earlier comments this whole thing again seems a bit backwards. We
explicitly clear errno instead of telling the caller to care.

Has this whole thing perhaps had the unstated aim that you were trying
to distinguish the now-remaining refs_resolve_ref_unsafe() callers from
the "I care about errno" by explicitly clearing out errno for them, thus
ensuring that they need to use the wrapper function with "errno" in the
name to get the errno they'd otherwise get?
