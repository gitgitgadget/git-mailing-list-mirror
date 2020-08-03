Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A998DC433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFDD122BF3
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="towhq2iw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgHCS7u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCS7t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 14:59:49 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77050C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 11:59:49 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b79so36097324qkg.9
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 11:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nYg9ffI3bexUVduBAhZmgGY78hoKwRUPQe/G72i2G88=;
        b=towhq2iwFVYNHuAyZjIyBSh0lrxx+smqs4ynC6498JK1wgO9STOLB6hW4Yo2hJO1kU
         b+RG3aveiaxT66nsBsDXOo4+/oNMOwoSKTJf4K1cqXvVLrKfNaNmJfJewAc/t4vacfIk
         cs6ZlPyefyCDzRSueD63f2wWU9U44fZFHQx3Akmkk6SBgwf7SkuswezRG7IsR8tEmaL/
         g/Af6cpZCxl6VDMUYA9bUH5Ygyn1tX9qytCbzcz5nswJ+dPhtSfmlSwTwRKZSFLdWvho
         pKujd+rYmV9idCpyv1OQYow/VB7UqUsiCWhcdsCPInFpB1cQnpTzRNdUyIFFQ8X5BDaa
         6DjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nYg9ffI3bexUVduBAhZmgGY78hoKwRUPQe/G72i2G88=;
        b=RyLwzRhPakvsiPPf7heWf0uqo3UOVQAonRJar1RB+pQnfrMVGS5J3AFMu1/aOaXAn+
         qG6fQWHM/0ywYzvmz3H4zOMwQej58EaqfRD7raEzfDzODiap5BNWTxFdSrY+H/GaLTVQ
         T1F2aLuK7GVsmCsG2E716d4sHbNKrvkmXHdCHJmTcDcZHe4COFovapAVq037RkCd6BH9
         X7y/Gy+a3fSFFHRtfifrbpdaHZnZasUV2mv368pd1Nr/P0F0vOhU2IaX5bbbYSD56Nfi
         QIAknTOKrU12MoVVK654+P3LThZo2sROUzij4D9uPQCh1W4Nk8LEL3L6nkpHzgI5jWb1
         WI+g==
X-Gm-Message-State: AOAM5335WDgDKitmUZzmaBRGRMPF4NPnjKGWckQs90BVIJH1UYu57NZ4
        oxEQ7eMUP441nQzt+YYtwE5PKA==
X-Google-Smtp-Source: ABdhPJw1Df9OleT3MZpZ3u3McDEs46JmtnpiQXkOB9lC38ibbhWyJAHivYGwMLLW83HE1VUcEmf03w==
X-Received: by 2002:a37:4391:: with SMTP id q139mr13901519qka.118.1596481188589;
        Mon, 03 Aug 2020 11:59:48 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:3475:b417:c07c:c811])
        by smtp.gmail.com with ESMTPSA id t35sm23124754qth.79.2020.08.03.11.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 11:59:48 -0700 (PDT)
Date:   Mon, 3 Aug 2020 14:59:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH 07/10] commit-graph: add large-filters bitmap chunk
Message-ID: <20200803185947.GA67482@syl.lan>
References: <cover.1596480582.git.me@ttaylorr.com>
 <ab789072331127079347742b6ce3b3415bbbe4f6.1596480582.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ab789072331127079347742b6ce3b3415bbbe4f6.1596480582.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 03, 2020 at 02:57:33PM -0400, Taylor Blau wrote:
> When a commit has 512 changed paths or greater, the commit-graph
> machinery represents it as a zero-length filter since having many
> entries in the Bloom filter has undesirable effects on the false
> positivity rate.

One thing that occurs to me after sending this patch is that 512 may not
be the upper-bound on the number of changed-paths forever.

Maybe we should store a uint32_t as the first four bytes of this chunk
specifying where we draw the line?

Thanks,
Taylor
