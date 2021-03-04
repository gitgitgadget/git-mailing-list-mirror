Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F973C433E9
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 02:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D49B65032
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 02:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhCDCBn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 21:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbhCDCBG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 21:01:06 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E326FC061574
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 18:00:19 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id h126so21731827qkd.4
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 18:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=QVwYn7VN+s1MQJd9WPKkvLcQMC/eC5LDol6s6MfOv9Y=;
        b=U2c/ZK5tNthcBZvdc1Ae0eBtx5cbVchBTb8423AeZlIrKYbWDdU1qO5QuiX2TAADMm
         T1AcuKLNskrhrShv85gP+syfIyJtjsq3/xEnIsQsHXtecoWJOFpsE/6/gvXPO2zl9EHi
         yofrEqeXaYkd6s6zIYsfIvt2rEpZQ7E3VFwVNcoxWgGaM+MUo9+iOI7FmPkT27QkEf16
         O859oPlFPokqqKAWxO3v8nEizrJbE8TlxxdSgjsjzbr7S8uvIBfrxQwP76QxbDuS/I29
         jprEfvbVzj1sbM5wFFTJWWvsSvkUVX3S+TZmmTOW0mwxDxms9OIlc3hgW/NSFK/T+xkx
         3XPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QVwYn7VN+s1MQJd9WPKkvLcQMC/eC5LDol6s6MfOv9Y=;
        b=fUKUB3Vr9n7GvohFPSrVoH9bBwgJai+v5jl2zyrVvv7CZwowf6rSJCGve4793jNYyf
         lqUWAI1+ocJtrLBDSkF3F88i3EQHdJWfa9uLbZNffaZI5WdT43ZeDkp7Q0hkohuN3xcE
         woL9Ogj8WIb77WW+v5EBhYGD9G62s0ywrXWofpQ6R0HxmW7DO3SX3X9a3vbAXbwYoOU+
         Og8Z/h7HU79ubHTNjWmYIaDbgdeVsZ6x/cA+LiB3r735yv8M/o5z5UrlYtlYu2lSH7Tc
         8QmxqHCFHF/ZhkVf4Y4o6utN6LmCnA42axB2q0sFIZoJuPgrxPIiAGZ5aMLx5lKCTpP7
         k/qQ==
X-Gm-Message-State: AOAM530uic8FwHTVeH2tfpTZi0f0XDOrWKLzCGpGD45opjvWRhYKGbQN
        P//Jdq1POW1c2zfumzYvsIW76B0sDPY4dXeIWXG3
X-Google-Smtp-Source: ABdhPJwsmw+NBAigcc/ovSuDec+9nRMVH1JRGE96z7Dv3SGzLDrrDC1LGqIEAyqfjx26LqzGJaiqUb99DS8RGHeZaywV
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:b8a3:: with SMTP id
 y35mr2183183qvf.23.1614823219009; Wed, 03 Mar 2021 18:00:19 -0800 (PST)
Date:   Wed,  3 Mar 2021 18:00:17 -0800
In-Reply-To: <YD6NVxDib8ccf/6Z@nand.local>
Message-Id: <20210304020017.1802260-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YD6NVxDib8ccf/6Z@nand.local>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: Re: [PATCH v2 08/15] midx: allow marking a pack as preferred
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, avarab@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Funny you mention that; I was wondering the same thing myself the other
> day when reading these patches again before deploying them to a couple
> of testing repositories at GitHub.
> 
> It is totally unnecessary: since we have already marked objects from the
> preferred pack in get_sorted_entries(), the rest of the code doesn't
> care if the preferred pack was permuted or not.
> 
> But we *do* care if the pack which was preferred expired. The 'git
> repack --geometric --write-midx' caller (which will appear in a later
> series) should never do that, so emitting a warning() is worthwhile.

Ah, this makes sense.

> I
> think ultimately you want something like this squashed in:
> 
> --- >8 ---
> 
> diff --git a/midx.c b/midx.c
> index d2c56c4bc6..46f55ff6cf 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -582,7 +582,7 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
>  						  struct pack_info *info,
>  						  uint32_t nr_packs,
>  						  uint32_t *nr_objects,
> -						  uint32_t preferred_pack)
> +						  int preferred_pack)

Why this change?

>  {
>  	uint32_t cur_fanout, cur_pack, cur_object;
>  	uint32_t alloc_fanout, alloc_objects, total_objects = 0;
> @@ -869,6 +869,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
>  	if (ctx.m && ctx.nr == ctx.m->num_packs && !packs_to_drop)
>  		goto cleanup;
> 
> +	ctx.preferred_pack_idx = -1;
>  	if (preferred_pack_name) {
>  		for (i = 0; i < ctx.nr; i++) {
>  			if (!cmp_idx_or_pack_name(preferred_pack_name,
> @@ -877,8 +878,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
>  				break;
>  			}
>  		}
> -	} else
> -		ctx.preferred_pack_idx = -1;
> +	}
> 
>  	ctx.entries = get_sorted_entries(ctx.m, ctx.info, ctx.nr, &ctx.entries_nr,
>  					 ctx.preferred_pack_idx);
> @@ -942,28 +942,21 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
>  			pack_name_concat_len += strlen(ctx.info[i].pack_name) + 1;
>  	}
> 
> -	/*
> -	 * Recompute the preferred_pack_idx (if applicable) according to the
> -	 * permuted pack order.
> -	 */
> -	ctx.preferred_pack_idx = -1;
> +	/* Check that the preferred pack wasn't expired (if given). */
>  	if (preferred_pack_name) {
> -		ctx.preferred_pack_idx = lookup_idx_or_pack_name(ctx.info,
> -							     ctx.nr,
> -							     preferred_pack_name);
> -		if (ctx.preferred_pack_idx < 0)
> +		int preferred_idx = lookup_idx_or_pack_name(ctx.info,
> +							    ctx.nr,
> +							    preferred_pack_name);
> +		if (preferred_idx < 0)
>  			warning(_("unknown preferred pack: '%s'"),
>  				preferred_pack_name);
>  		else {
> -			uint32_t orig = ctx.info[ctx.preferred_pack_idx].orig_pack_int_id;
> +			uint32_t orig = ctx.info[preferred_idx].orig_pack_int_id;
>  			uint32_t perm = ctx.pack_perm[orig];
> 
> -			if (perm == PACK_EXPIRED) {
> +			if (perm == PACK_EXPIRED)
>  				warning(_("preferred pack '%s' is expired"),
>  					preferred_pack_name);
> -				ctx.preferred_pack_idx = -1;
> -			} else
> -				ctx.preferred_pack_idx = perm;
>  		}
>  	}

The rest makes sense.
> 
