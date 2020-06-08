Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975FCC433DF
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 19:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63F3A2068D
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 19:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="om5bFl08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgFHTim (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 15:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgFHTil (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 15:38:41 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8DEC08C5C2
        for <git@vger.kernel.org>; Mon,  8 Jun 2020 12:38:41 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q24so278365pjd.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2020 12:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I1AkBoIufbqvgPw1P3lFW8eMMPSFl741Nc0LVd5KGZw=;
        b=om5bFl08USTMIuLaMz+x1oP+1Om4X+ovwl2/YzMTLxxsrsJpcvvkPgEA4V5wrbiCn+
         O1pTIKpB4dRR07PHVxttO4j0/0Jmv4FVVcy+3ERQ6tqJNqSSUDJJNUYIt7tCYmq+p2NP
         wJse6bDR8uF4Fcm3hRNdcTn8uVY4N1+BBPMFlEq0UgxV4GaFgUUceLN6+I4EEUkXfQ0P
         ePmZjZdxRa3BG26izSwfY3S69vyY7uBKmyiV7mT2P8sn2i8FNbVj1p61wB0R42aUdChA
         ZvedK440vz4mZraVZoAc/TIJGZpqY7gfjKAj6TI/57ByWzjk/94SPim5zdK548Pq2HLI
         A8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I1AkBoIufbqvgPw1P3lFW8eMMPSFl741Nc0LVd5KGZw=;
        b=KG0toZg+M8vExlCGP1EEdGOtQKS3VzMZAHm4ySC64e/8GGzBFF8h9EneBeJ8DkVkec
         JRXJJ5LCYvLTy28abm/BnyKGoQmpQAPsqPzz6WT4WAf6x8oAqLsnYn+pzE9VRcJQ8Vki
         GmlicDmmuD1xUfysc9B5Ln3N2CLy/KdBjg7Lcv7DVqUsdpD2P4DSX/VavrsCEPJlxmPo
         9vEx0d62MJJNAcUwjbtLs3xCtLBcitRgvpc86Nr+RQfCxo+VPSK6fVHQADM40VNubAaj
         b7ahcnKvrHr+YkNsjtV6va8WhNQbdOjYAOOxbemOzUJlNglOx1KC8w6EjeKsDFoJJnJk
         DD0A==
X-Gm-Message-State: AOAM533oXDZK0nrL2Xqu24mYnBaRGS9NuWOta6EVnxvblQFouiXO4txb
        /O069sEo9k8UZSGjr3zHUqh9bpEQZyalUw==
X-Google-Smtp-Source: ABdhPJwBwAtJCkY2Gczz4o8yxvRdPcyoJ7SnfHaqRlewJM+8CJSscaFzu3pJXE9hGdK6DY84wvcF6Q==
X-Received: by 2002:a17:90a:4d4e:: with SMTP id l14mr882198pjh.10.1591645121183;
        Mon, 08 Jun 2020 12:38:41 -0700 (PDT)
Received: from konoha ([103.37.201.178])
        by smtp.gmail.com with ESMTPSA id q6sm8054624pff.79.2020.06.08.12.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 12:38:40 -0700 (PDT)
Date:   Tue, 9 Jun 2020 01:08:34 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        jonathanmueller.dev@gmail.com
Subject: Re: [PATCH 1/8] worktree: factor out repeated string literal
Message-ID: <20200608193834.GA4196@konoha>
References: <20200608062356.40264-1-sunshine@sunshineco.com>
 <20200608062356.40264-2-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608062356.40264-2-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/06 02:23, Eric Sunshine wrote:
Hello Eric!

> Although this change seems to increase the "sentence lego quotient", it
> should be reasonably safe, as the reason for removal is a distinct
> clause, not strictly related to the prefix. Moreover, the "worktrees" in
> "Removing worktrees/%s:" is a path literal which ought not be localized,
> so by factoring it out, we can more easily avoid exposing that path
> fragment to translators.

Could you explain the above paragraph just a bit more? The English is
confusing me a bit.

