Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E44C433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 07:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEDB6207DD
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 07:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fogHbS5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389561AbgFXHLX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387849AbgFXHLX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 03:11:23 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECC9C061573
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 00:11:22 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f2so682243plr.8
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 00:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jORqRQbi3VgwbRYXJA3YqsI9KCo7gJEDIAXbZNawt0Q=;
        b=fogHbS5HSDYvZ8UKOO9VfxAAVQByK5Tzn9QUwe9KuDArz/jjoJU/omU5KT8hUCrIzq
         A9A0PYPtinv6+3pWleJifmMkPjG32veiG/QzZZAvB6D9+p2aLMOQw67aZ9j2Re1pLJsU
         kY3FFBOcaujY6QECkLEUHRoWA11AfrupujgQrKq8Kz0P/Wg7ZMBxT3vzTAuFmaiOhTDi
         2fKcXrWoevEP2ad6Jc9ooCGT35aQsWrnkm4GaYFPIOjEy0uAeRtMbw7MkLb9dcXBPNSC
         siyzZAWx/cuZLyMsUk9pIAGzswyVZ1zuK40RrjqTV1+L1O20Sz77erP5daGCPS0KzZLW
         7frA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jORqRQbi3VgwbRYXJA3YqsI9KCo7gJEDIAXbZNawt0Q=;
        b=SVfmPoKsiVWG78vUDZv5avYBy7evsvsS0iHRf3B3SJT99dpRxoIQ3G5Mw6X4YFr3WB
         rk0slgXb+urZk3DJ4sQ26p1+6P+quAhPKaIcTqWFMIcKCMO7NTnSuu98a05aCxfFjM5O
         5cwyMTIrH44x3OgRzeDQ/wYetqnB8M6Eloo6cTrAn6aCJ7mhnbRKHp+05AlteaUlLJWO
         Iz8kRLd6VPq+636z3qaoFZ+Pv1mjgV5NRnLRyvkKT98qdnucOQg01Ncw9i7vEModpZE/
         1biRnXncd4u7P++pP7A8kMUNnUU9xjUq9lx3naMUVHZJLlQAcGAVPI0uY22HFUrRs8/w
         qKEQ==
X-Gm-Message-State: AOAM533xtqVyrfdQUr/CaXJIGQxLz5T4ut8JDa8RNgUb8lnFsdWOj5Rg
        GZqqHyTtEJ7mKodLAyiklVk=
X-Google-Smtp-Source: ABdhPJxoAnDfpH5plUFrdYCn87XWPnEq9wqTVMZupWcDLux0FdRqRt8i8lSTcdRHCyzyB74Eh5TL2w==
X-Received: by 2002:a17:90a:ae11:: with SMTP id t17mr28393469pjq.157.1592982682435;
        Wed, 24 Jun 2020 00:11:22 -0700 (PDT)
Received: from mail.clickyotomy.dev ([49.206.13.94])
        by smtp.gmail.com with ESMTPSA id k14sm18437921pfk.97.2020.06.24.00.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 00:11:21 -0700 (PDT)
Date:   Wed, 24 Jun 2020 12:41:16 +0530
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/3] diff-files --raw: handle intent-to-add files
 correctly
Message-ID: <20200624071116.GA79097@mail.clickyotomy.dev>
References: <pull.654.git.1591879139.gitgitgadget@gmail.com>
 <pull.654.v2.git.1592916485.gitgitgadget@gmail.com>
 <640e225550886727594ca9dfaee6c9e6ea4b1014.1592916485.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <640e225550886727594ca9dfaee6c9e6ea4b1014.1592916485.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

> The underlying problem is that some time ago, the (already incorrect)
> empty blob constant was replaced by the empty tree constant, by mistake. I
> contributed a patch series to fix that, and Cc:ed you you in v2 that I
> sent out earlier today.

Thanks for CC-ing me!

[...]

> +			} else if (ce_intent_to_add(ce) &&
> +				   !(revs->diffopt.output_format &
> +				     ~(DIFF_FORMAT_RAW | DIFF_FORMAT_NAME_STATUS))) {
> +				struct object_id oid;
> +				int ret = lstat(ce->name, &st);
> +
> +				if (ret < 0)
> +					oidclr(&oid);
> +				else
> +					ret = index_path(istate, &oid,
> +						 ce->name, &st, 0);
> +				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
> +					       &oid, ret >= 0, ce->name, 0);
> +				continue;

Instead of showing the hash for empty blobs for all entries previously,
introducing this shows the hash of non-empty "i-t-a" files correctly.
Nice.

[...]

>  			} else if (revs->diffopt.ita_invisible_in_index &&
>  				   ce_intent_to_add(ce)) {
>  				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
> -					       the_hash_algo->empty_tree, 0,
> +					       the_hash_algo->empty_blob, 0,
>  					       ce->name, 0);
>  				continue;
>  			}

Oh, I totally missed this in my patch; the change looks good!

> -  :000000 100644 0000000 $(git rev-parse --short $hash_t) A$(printf "\t")empty
> -  :000000 100644 0000000 $(git rev-parse --short $hash_t) A$(printf "\t")not-empty
> +  :000000 100644 0000000 $(git rev-parse --short $hash_e) A$(printf "\t")empty
> +  :000000 100644 0000000 $(git rev-parse --short $hash_n) A$(printf "\t")not-empty

Changing the test-case to reflect to the hash of the blob also makes
sense.


[...]

> > +     hash_e=$(git hash-object empty) &&
> > +     hash_n=$(git hash-object not-empty) &&
> > +     hash_t=$(git hash-object -t tree /dev/null) &&
>
> > So this is the hash of the empty tree object, and...

I guess we can get rid of the `hash_t' assignment here, because it
won't be used anywhere else in the test.

Thanks.
