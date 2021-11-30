Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91372C433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 00:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbhK3Aid (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 19:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbhK3Aic (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 19:38:32 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F97EC061574
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 16:35:14 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id h16so18535661ila.4
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 16:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MPYhPNqhFyIKF603Hk+5zbpzfn1VFdPrJkcQZ5f7404=;
        b=1aFzqDdraHMYR+xoJ+fHVPsHrUBtalyJMIv4rYxczObf9k1bs0OTVtkEhn9YmpIm94
         uzGQs+tDFafxrQPzY4JpM/ZWBiZhCF2hcafKlDe3iEgiSuwwrbzPWNWzN6yFAuVqxGD5
         Ar0NV0uqT7D6ncU4yVYOhptx4x4iNskJZP39UiqTbbmh6bKjRgToaEGBGw087ryhILKs
         sUhQmrQ6IONwjGIEEUAvCw4cws2rULYxEcDUaT3aXTLaa/rPBLHMC2krgRplPuzsuFEs
         XmS6fDpGIAZCOhYoJ8/hGcFA/cjuu2gw4ar+NA0bbizynez+H2mtYjDfPLMnzCnkXFFO
         nfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MPYhPNqhFyIKF603Hk+5zbpzfn1VFdPrJkcQZ5f7404=;
        b=I9C+uRdhTVQOCMqgglzJAhV7O7qSP6s261l5RJGmHMKPby/Drb6XIVeaCFkKym2lY7
         +4kVIVLn0BAW0Ox++MrMLlut2wZOsXep2GybQDSQXQ5LoMvhW3u2oRSNsvBd20UYAs61
         aRZUqPXDA0Q/jBgnj+2MCO/nA9fvYIsVBo4EkFVEDCiYoImNJKvXKqVz/deTg7gP69QS
         Fq+ic+0Cb+g9Whwu+UdDpI6/zMjVZhwNasnSEVOLVVQO3cN6mHZAOiCMLRqRRPbqZR7X
         crd7OBhYQA4JN/1LqDaA6CMn8Smt9t4b/B4nystMAi6gY1RedWK2TKz6eSZlvMV0OeT/
         lnMw==
X-Gm-Message-State: AOAM532YyvfpK1spOgSoD23DMeloeqAy1yIBujo6o3Jd0tC6cSCuJU+c
        W+M1bRvvWvuTEWOmxg9w5PB3/A==
X-Google-Smtp-Source: ABdhPJxUjQc9/BX+Z+QAfCIbDhOTGTLMGwvmhhLDrR5xENhTHREU+onLmUtt1IEdEb5fQsWmtFTe0w==
X-Received: by 2002:a05:6e02:1845:: with SMTP id b5mr7550259ilv.168.1638232514119;
        Mon, 29 Nov 2021 16:35:14 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b7sm9486383iln.34.2021.11.29.16.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 16:35:13 -0800 (PST)
Date:   Mon, 29 Nov 2021 19:35:12 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/4] repack.c: LLP64 compatibility, upcast unity for left
 shift
Message-ID: <YaVxwFuMeK3QsfZj@nand.local>
References: <20211126113614.709-1-philipoakley@iee.email>
 <20211126113614.709-3-philipoakley@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211126113614.709-3-philipoakley@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 26, 2021 at 11:36:12AM +0000, Philip Oakley wrote:
> Visual Studio reports C4334 "was 64-bit shift intended" warning
> because of size miss-match.

s/miss-/mis

> diff --git a/builtin/repack.c b/builtin/repack.c
> index 0b2d1e5d82..6da66474fd 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -842,7 +842,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  			fname_old = mkpathdup("%s-%s%s",
>  					packtmp, item->string, exts[ext].name);
>
> -			if (((uintptr_t)item->util) & (1 << ext)) {
> +			if (((uintptr_t)item->util) & ((uintptr_t)1 << ext)) {

This line blames to me from back in 2fcb03b52d (builtin/repack.c: don't
move existing packs out of the way, 2020-11-17).

The proposed fix here looks good to me (though we were never at any
practical risk of getting bitten by a down-cast here since the maximum
value for `ext` is 5).

Thanks,
Taylor
