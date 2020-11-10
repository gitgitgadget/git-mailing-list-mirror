Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B27C2D0A3
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 00:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E76E20789
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 00:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuNO9HTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgKJA7n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 19:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKJA7n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 19:59:43 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83C0C0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 16:59:42 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id l1so6431849wrb.9
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 16:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1iHOV3xC/BIbuEy6JpfFCfyCKx//V45llMXoqmeVZ90=;
        b=XuNO9HTFlY7Yo0yQIOG6ISpLDI0kx8ZXFiNu+1zLCicetgstIOzDG4whevbLqgku2u
         YMnCo3faYrOJYdvrtmlf051TyqVIwTl8F+6M2Cmm1Vqrt7dCPmUz8AA48bOTYbzs5Qcb
         AX7eSO4WvBfEuLt627ro0i/yR/RF/nBcCNCU+Qkvo8j+r3cxUs5xxtyhtW3gWaVFv82J
         BYEvAMVDSG+6sUoPkwLf4Yo+dftYL7SFmgasgdyyUvrjYdf7dOZexzusLwaxe/g0MLb5
         JdOqkTIrOsWNntcJPGlOGiYx/P/DqrwVy7dCfhvTHhWEWpxyBu6arJFPvlB2G7ixVDzl
         0CEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1iHOV3xC/BIbuEy6JpfFCfyCKx//V45llMXoqmeVZ90=;
        b=ATaHw6LSNS74DHddF6vNibYcJjLlRDVg2Rmq6bmo86wMb1TFxvRhGGInxdE3VgWIV7
         jp/OzNTygOQPeGTCZNfQg8yTn4v9BuU0SwEvXqaMF55LYnAv/ApN8pFKH9ghWKz4n9PD
         aHiLVx0ef3eyz8Rsjg6Dgc73dop8LOLWGrkCqWGEtJVFEx80PrYfRh3x1FAF3HLlzHCL
         2ELHY60fectQ5E73HAZO6vFRObGamtwU92Q6gcDCkXRmioqEAISWuV6Wc/Ucg52xvAzd
         J5W6DkAKiQP2wplt3lTyaUKS2dM9bqkEZ7ivUOXnrEhHVlmLjfI+JT3ZwwfsMSBZTC3b
         Q9BA==
X-Gm-Message-State: AOAM5330cRZpjg6JtP/Wmr04cJam8V8N0DQF/mar9ptRV43xjSIBYyU5
        naOt8t5u3wKBCHUdKWrLRioxzdSRzEzyvAOI7mY=
X-Google-Smtp-Source: ABdhPJxaUJFyGdPObM126TzSEqA8v04cl8Lo9+ENVENxg5R3LhzseXUhBiZ4gTrdeNRIUIym323Vbp+i6Xt9fpSmASI=
X-Received: by 2002:adf:dd51:: with SMTP id u17mr21249242wrm.139.1604969981542;
 Mon, 09 Nov 2020 16:59:41 -0800 (PST)
MIME-Version: 1.0
References: <20201109215248.461167-1-felipe.contreras@gmail.com> <X6m8R9erSxGlPXq2@nand.local>
In-Reply-To: <X6m8R9erSxGlPXq2@nand.local>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 9 Nov 2020 18:59:30 -0600
Message-ID: <CAMP44s3CsC_gHNA2SjfAqhPorKHCgK-yG39fN+VzUw4Q+opwNg@mail.gmail.com>
Subject: Re: [PATCH] completion: bash: support recursive aliases
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git <git@vger.kernel.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 9, 2020 at 4:01 PM Taylor Blau <me@ttaylorr.com> wrote:

> >   l = log --oneline
> >   lg = l --graph
>
> Is not even recursive. I would instead recommend calling 'lg' a "nested"
> alias.

Perhaps. In my mind these are recursive.

It also follows the more general understanding of recursion, for example:

"Dorothy thinks witches are dangerous".

Is considered a recursive sentence. See [1].

But if anyone else prefers the term "nested" for this, I would gladly
update the patch.

Cheers.

[1] https://en.wikipedia.org/wiki/Recursion#In_language

-- 
Felipe Contreras
