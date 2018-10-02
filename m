Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D97421F453
	for <e@80x24.org>; Tue,  2 Oct 2018 19:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbeJCBxv (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 21:53:51 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:42665 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeJCBxv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 21:53:51 -0400
Received: by mail-ed1-f54.google.com with SMTP id n2-v6so3079173edo.9
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 12:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7VkZlkHtDr3x5ErH96zHqhq2Toupmtlf3WBE0NJpax0=;
        b=l5tOzwjfAdSu4lkxb5nZX29P+ePsZdE8XR0+A/ntoINnT5vpnfoxFAXdbVwCH18vwd
         ufGBZU4UT/7lHaRjnkcIUJyFfkoxnWLb5jKPNTFVUN9e9rvCc7Qnp9jBdUFUobaX43/K
         nwLIT7v587PmNxYuYSFjXTbY8NZNqCl/v9EH0MmGvlIHUp6DptKrY6wpw+OP1tZUpXPJ
         AqbIu7bS4hrDDG+GR1w3/JdQT1gabzEL2PaJbQ9jqjOw03XoOaMJzM2T7UQqVFjbkYGH
         GZQ5bJtsaltPn5slbsKKPgtK6yFHYqjolsJ9TvfH/+/Ob1BtGxitiOY2C4hBbmyLZiSe
         k53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7VkZlkHtDr3x5ErH96zHqhq2Toupmtlf3WBE0NJpax0=;
        b=Qoxoto8rE9OucivICW6K6bGgmLVoKRxWO9wn1mDpeAo5xYeNsEgNgpN3iI+Dv0kh8v
         JQYID/uWZI/F0pUNLoDIr7UNeCdXFg+/O4Y15GtzF8eDUYXNY0kAbSfilB3pO33ubi0K
         u7VKMMI41oXCSBYiKhJsPrj6oBeKayUFpe8IYqLlTT6E5c/K92uAnqCVNd7oZSKV7wvO
         DB3IrSEGkdjBa7WCh+FUCAPJbp2N+MVqc4HbxeqrpK08DFrxI6QFScNSQuAZ8OMrjiuL
         OUiuHOW1MnxcIUCVnAAVDSk1MIrl0lqhGLwp+yTMhC7A9MOC/6Icr0PWgGuhE1MKLUEK
         lndQ==
X-Gm-Message-State: ABuFfojVTOtTqcjb1nfDGZj4/5UMwyRnspxtXsyG5yNtNt3Y+oDTnEIr
        zQkY9d3dBRRd1W8Peh6dR2w+87wdaVCAzDZE/PnRNA==
X-Google-Smtp-Source: ACcGV61luqLW98ocMmEsRUGa1eBSufZCI/FkIyxjxOqgZvc5rddUTCr+7JqTAMuQgCMFRboaZpY2w9M1xLCo1hKzhR8=
X-Received: by 2002:a17:906:f45:: with SMTP id h5-v6mr20670140ejj.106.1538507339904;
 Tue, 02 Oct 2018 12:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181002175514.31495-1-phillip.wood@talktalk.net> <20181002175514.31495-4-phillip.wood@talktalk.net>
In-Reply-To: <20181002175514.31495-4-phillip.wood@talktalk.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 2 Oct 2018 12:08:49 -0700
Message-ID: <CAGZ79kasT3ygWGArL5t+O4modkDG7AwzXmpf7vi1TdkZBTh1Uw@mail.gmail.com>
Subject: Re: [PATCH 4/5] diff --color-moved-ws: fix another memory leak
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 2, 2018 at 10:55 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> This is obvious in retrospect, it was found with asan.

Indeed. :/

Thanks,
Stefan
