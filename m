Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3288EC433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D46B611ED
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347762AbhIUCVp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236457AbhIUBuT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:50:19 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762EBC06AB3D
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 15:14:45 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id x2so20423521ila.11
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 15:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kSJVfr/mGWnGjZ1afLBC8uRfpYGD+DZs4wQuLjN2LQQ=;
        b=C+0zjnV791Uak19czQBf0LrYdUbboR1nKIIlcwPezbomQCDQH/+Wfs7RNS4GKxYKFU
         rr/nonilIXFQGM043ROQsrb4AQbFcbKySdLdu12TIvV0h6288Rw6an7bRhdgDebEsROA
         flBZubvfaY+Pfr/L233wIsoQWV8vHZCCcV2IgLHpHlx3jE7UcTmyZEIBFSK5XFgp/6BB
         YJl633xy3OrpPPtWS3+hKI+jtaKxzttJAgvHVxcem/xN3H5DEiVkoZ5R2oYeGpnfLCVC
         lX+xfIeLATMfM4ycD3yI07mekYbbDiqs6xIwBXCLB/c0J+8DN3OcE8pyjJ/Da7hZe3VY
         Y5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kSJVfr/mGWnGjZ1afLBC8uRfpYGD+DZs4wQuLjN2LQQ=;
        b=nMYZxCVP0jvNkJW/uABwP3Tp7IY8KO4IxerJj71UjNAQIlQjR8lvoe000dpJVFdTrH
         J72OGHdH9I9HWPU/FDvnuL52F6KaoTqtvFNCW9VtMphsi2COE9SMTRKrP418KqnZA4e5
         Jpmh7IbHgy7uhFWEyUXqQ3iA/hBXW4Teoo2a45IlXpOnfsTDSKgwTAEzyXofLwv5DHYj
         Tx/3An4y8Uj3NI6dtlq3/SG6aRUloMi/Or/DxWiHIvBBZVOKf158KtkP/P4iq4TlZTtp
         hOZsmPLAKi3ziXrwNNLuqXf27u/9Df/KP8rSyLPqkwg4QfEFxzsEFsBWcYoWUuuXMrFE
         jZ1Q==
X-Gm-Message-State: AOAM532Ii2+TWTmITxsCuDa/HQd3+Do60H7qV0aH9QpOat8NwEf2EjKy
        /bqqkT+WAWB8FKS2413TzWHstw==
X-Google-Smtp-Source: ABdhPJx8bA7aDmxrQakErgnXUYV8Vvwh/5Y29FmrVuEpAu0jOmIcHxNO/g3btRarDnOpHlVpjiBKOg==
X-Received: by 2002:a05:6e02:1a8c:: with SMTP id k12mr19609646ilv.312.1632176084928;
        Mon, 20 Sep 2021 15:14:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e9sm3734371iob.52.2021.09.20.15.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 15:14:44 -0700 (PDT)
Date:   Mon, 20 Sep 2021 18:14:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/5] read-cache & fetch-negotiator: check "enum"
 values in switch()
Message-ID: <YUkH1LSa1WcFDmvr@nand.local>
References: <cover-v2-0.5-00000000000-20210916T182918Z-avarab@gmail.com>
 <cover-v3-0.5-00000000000-20210919T084703Z-avarab@gmail.com>
 <patch-v3-3.5-d837d905825-20210919T084703Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v3-3.5-d837d905825-20210919T084703Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 19, 2021 at 10:47:17AM +0200, Ævar Arnfjörð Bjarmason wrote:
> Change tweak_untracked_cache() in "read-cache.c" to use a switch() to
> have the compiler assert that we checked all possible values in the
> "enum untracked_cache_setting" type, and likewise remove the "default"
> case in fetch_negotiator_init() in favor of checking for
> "FETCH_NEGOTIATION_UNSET" and "FETCH_NEGOTIATION_NONE".
>
> As will be discussed in a subsequent we'll only ever have either of

s/subsequent/& patch/ ?

> these set to FETCH_NEGOTIATION_NONE, FETCH_NEGOTIATION_UNSET and
> UNTRACKED_CACHE_UNSET within the prepare_repo_settings() function
> itself. In preparation for fixing that code let's add a BUG() here to
> mark this as unreachable code.
>
> See ad0fb659993 (repo-settings: parse core.untrackedCache, 2019-08-13)
> for when the "unset" and "keep" handling for core.untrackedCache was
> consolidated, and aaf633c2ad1 (repo-settings: create
> feature.experimental setting, 2019-08-13) for the addition of the
> "default" pattern in "fetch-negotiator.c".
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  fetch-negotiator.c |  4 +++-
>  read-cache.c       | 15 ++++++++++-----
>  2 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/fetch-negotiator.c b/fetch-negotiator.c
> index 57ed5784e14..237f92b8696 100644
> --- a/fetch-negotiator.c
> +++ b/fetch-negotiator.c
> @@ -19,8 +19,10 @@ void fetch_negotiator_init(struct repository *r,
>  		return;
>
>  	case FETCH_NEGOTIATION_DEFAULT:
> -	default:
>  		default_negotiator_init(negotiator);
>  		return;
> +	case FETCH_NEGOTIATION_NONE:
> +	case FETCH_NEGOTIATION_UNSET:
> +		BUG("FETCH_NEGOTIATION_UNSET only in prepare_repo_settings()");

I was briefly confused why this BUG message mentioned
FETCH_NEGOTIATION_UNSET, since we only support FETCH_NEGOTIATION_DEFAULT
here.

But then I realized that it said "only in prepare_repo_settings()", and
we're in fetch_negotiator_init(). So this makes sense to me.

Other than the small typo in the patch message, this looks good to me.

Thanks,
Taylor
