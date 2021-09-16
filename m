Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2197C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 05:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DE4360E05
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 05:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbhIPFS7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 01:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhIPFS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 01:18:59 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305C6C061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 22:17:39 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id v16so5460108ilg.3
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 22:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EbUu9JpeHmTjCFcfT5sRqHnyOiMlTEZ9Yu2m16LlZME=;
        b=LrYoIu5SEJTepCaDEFchtF0xrxEBW4whWSiOlaX4HWYHoKCskA5hS3y3P8sM1kDXvc
         yCSU9VnvavrWdHdInPBMg733LzNTuu85Vf41u0C9wbzQ2XgSpyrfiw3E+BoNXlxsVoFR
         6cNTcyHHom3laUY1BE46wzFV0lKG+TKKRCQVevNFHbHdpH2fXfdcvSRM7h8Mw9NLZSbP
         c+z5g37QjXRfN/e7jhOeeICJ72f3Ws30Il2YfEPE0f5nHRvNrDsS21cJxAkrW94yk3ka
         2m60kzpEkrxby3HjQIehiRhjDRObtkv5qUwpF9Y7D1uN022Op5tejlY9zUf6d+KMh4lJ
         BDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EbUu9JpeHmTjCFcfT5sRqHnyOiMlTEZ9Yu2m16LlZME=;
        b=drMnhX7143iGYZQcOYYaxL7So8KxKQS+fUJN6ZFBtAz/oSsOGb8m4hQUP3O6R4I34M
         ThwHNXGjX8gAPuxA1SEr9PFTvRLzqwdinXCxrVsrdLAuq9Tz4I/b2Tay7/0uVD/nq1rt
         BSnakdZBCMWHX86kDVOhySQad7fdjAMCO+DDAHnXwcw4xLWeVyAWlOABwQDzoxwbEPzO
         +zyLIYsdcz+ZbxX7WxWGQuBDZpEJx7be8d/0G2HlsLoTGze7nw3UEyR3KCgiCusbP2FM
         h36USI9C7hxv2F/JbSx58oiKQFjyFXLE/wDBK23dp8Qe5fqvEtDrp2THPndnf5W3MuoS
         gidg==
X-Gm-Message-State: AOAM531HnDk21C6TXOmT4ruo4GiBiODDIyUO5TqQA2JpFI/3FY+WZ2Sm
        kqZc2e1LW7/P3P44QYTThXB/fA==
X-Google-Smtp-Source: ABdhPJzxC8a2+NzX3dHCirx6RfzGpiWZRRfDWpcOsYFMibqSJNjU/oOcuyjn2t2TuWIfYwNdU2CRGw==
X-Received: by 2002:a92:d5c5:: with SMTP id d5mr2723189ilq.36.1631769458585;
        Wed, 15 Sep 2021 22:17:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g8sm1087036ild.31.2021.09.15.22.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 22:17:38 -0700 (PDT)
Date:   Thu, 16 Sep 2021 01:17:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH 1/2] tree-diff: fix leak when not HAVE_ALLOCA
Message-ID: <YULTcXX6i2pXW0BE@nand.local>
References: <20210916023706.55760-1-carenas@gmail.com>
 <20210916023706.55760-2-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210916023706.55760-2-carenas@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 15, 2021 at 07:37:05PM -0700, Carlo Marcelo Arenas Belón wrote:
> b8ba412bf7 (tree-diff: avoid alloca for large allocations, 2016-06-07)
> adds a way to route some bigger allocations out of the stack and free
> them through the addition of two conveniently named macros, but leaves
> the calls to free the xalloca part, which could be also in the heap,
> if the system doesn't HAVE_ALLOCA (ex: macOS).
>
> Add the missing free call, and while at it, change the expression to
> match in both macros for easy of readability.

s/easy/ease/ or s/easy of/easier/.

> This avoids a leak reported by LSAN as while running t0000 but that
> wouldn't fail the test (which will be fixed next) :

Nit; extra space between the closing parenthesis and colon.

> diff --git a/tree-diff.c b/tree-diff.c
> index 1572615bd9..437c98a70e 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -21,7 +21,9 @@
>  		ALLOC_ARRAY((x), nr); \
>  } while(0)
>  #define FAST_ARRAY_FREE(x, nr) do { \
> -	if ((nr) > 2) \
> +	if ((nr) <= 2) \
> +		xalloca_free((x)); \

OK. So the point is that FAST_ARRAY_ALLOC uses xalloca() for small
arrays. But that might turn into a full-blown malloc() if we don't have
alloca.h. So we need to call xalloca_free() which is a noop if we used
alloca(), but calls free() if we actually used malloc() instead.

Now that I wrote it out myself, I think you basically said as much in
the patch message. But it may have been clearer to say:

    Add the missing free call, [xmalloca_free(), which is a noop if we
    allocated memory in the stack frame, but a real free() if we
    allocaegd in the heap instead].

Thanks,
Taylor
