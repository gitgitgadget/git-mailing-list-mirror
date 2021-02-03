Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BF4C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61D5F64F6C
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbhBCVOP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 16:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbhBCVOO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 16:14:14 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4E7C061573
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 13:13:33 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id 19so1254786qkh.3
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 13:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xcLgv3fPVGyxNfZzh3u0FVz/1KnBEaIt9ys08o2rEow=;
        b=dyMkvG8qq7XAGB58ktfnIy5gg5kjcJL+M7Hw0t++SkfH8TGcKqgAD/q2oqL9wRQfap
         jWrUY3OYjdR8ySEcPfQ8OUQga49BL8kzo1mk+mCudIjcCjatlUN68PB59x9xVHBjMSQ8
         ZY+gJc+0VUhjXZp31ImQPZGSDTXB8vCTaGjK/PMzxh0vZs+GTzE3QSb8C5ZkdUdvtGNN
         5jpYvNZROm7Ei2wtqNIP5xVISqiEPt5QdqM9qtrO9XA6j4ppL3+nIjwG5KEL4GgxbErM
         zrsWxlMtNtR4fAVJoMRJ9q0uQSFDScdUDo3XDdZaP47JoSAo8yoDx9JfQyVzGjtkQR3s
         +ahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xcLgv3fPVGyxNfZzh3u0FVz/1KnBEaIt9ys08o2rEow=;
        b=r4eCC30ryZu0Dftm/dKI73lk1bkuQw8OnTbAYNuSEizDH1yS0afMAHqUIx8EugdRMu
         7Ok7I1JNrKImHX1RNHX6pUzE+HglxlAt3/ostflh3aBR9Pj9pIlUDaB+BaEwSLBmAnfS
         xgpUjreLaZkEUh6wFbPirqRy6MAK9XfOEVsRX9VBP3dWzxbzOJAp9qiOEfYB1rl/10Ca
         SQzgApI1/ZPAo/QZbgjtpoFiZGh/1hkCJujlKCmadgVrS47CK01OIMnIs9Iyxse5Jt1S
         3RB4eF8yje82gWHGEs3Dm5pHyZSueW7g15kF5HyE52mfQMDC9Gkp/NIl7qW/oFXXD4Fg
         mA+Q==
X-Gm-Message-State: AOAM530h6nuqwIY/6Odq7rg8k2oF4Qm/uyaDPpzph8u75nIM5JxxAXGF
        sTEwFoMy3Yjl7a8O5ZE+EHAw7ihcjWDtZQ==
X-Google-Smtp-Source: ABdhPJzIo8Vrp7KOjs072GacuDgdkyabxL/cJwsioRhbnFGRe7+6BUyefxrG+dySQCjXI9V5+u4QaQ==
X-Received: by 2002:a37:e217:: with SMTP id g23mr4616899qki.283.1612386812996;
        Wed, 03 Feb 2021 13:13:32 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:3a5f:649:7bf7:4ac8])
        by smtp.gmail.com with ESMTPSA id o88sm2406113qtd.79.2021.02.03.13.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 13:13:32 -0800 (PST)
Date:   Wed, 3 Feb 2021 16:13:28 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc/git-branch: fix awkward wording for "-c"
Message-ID: <YBsR+DALwV4Xxgvf@nand.local>
References: <YBsQlC03pJgYUHde@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBsQlC03pJgYUHde@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 03, 2021 at 04:07:32PM -0500, Jeff King wrote:
> The description for "-c" is hard to parse. I think the big issue is lack
> of commas, but I've also reordered the words to keep the main focus
> point of "instead of renaming, copy" together.
>
> Signed-off-by: Jeff King <peff@peff.net>

Much clearer, thanks. I'm only responding to acknowledge that it reads
more clearly to me, too.
