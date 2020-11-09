Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D6DC2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 21:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 424BF206CB
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 21:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHV4tM6Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbgKIVwT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 16:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgKIVwT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 16:52:19 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A70C0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 13:52:18 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id k9so10437825edo.5
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 13:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J+jCGZlW4FeARdquUYZ7qx3PrWx2kFp6P2aC4Za3HFQ=;
        b=dHV4tM6QxsuLjd7w04USqOmJces8d0aTLj+8tG1jRt/34dcRdf7aFPGBSfCOAAMmZl
         gs9ZkrFSOufnKktT9WqIQ/ZNKD0WNuKF6VnFmXiSDaKTHH0JVHa4tzbaQlq78ojWlIx6
         zquFbELCayW0wzMjLPIKRl0yUagNKYufbpZUuJ4F+7J8pV3TI3OykJS7488uCw+JNnBp
         IjijRJuGNX4UIZYESYwZ9w8xzCU4D/L8fVDF2WzgbMbJvUnrYNFvmxOel1Vb2yxbOv6s
         ZzCnnV8ke8iGXb4bUPV+jwKR6hg9uMk6AN7zF0AwEmFSnv6I/Ixmv9yUHO90uu36RQvb
         UkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J+jCGZlW4FeARdquUYZ7qx3PrWx2kFp6P2aC4Za3HFQ=;
        b=B9l/qRnvDA3tcPwF1sQKZJAW3seWeub3H+qMldu9KwrsRXFt0p4YQBDpcHp5ezaBl2
         bsedK2y43LbR1OuJkfixQe0CVoSjixwRHr0WOFEv+caSN80WGXd96Rf57n3uOu/1dWUy
         n4iHsRo/TH4ZlIOJ8wNpD0uyF2+9+ppuJWuvk24TcfDHoOYWKw4FqM7D4wTH/7wmN3dp
         FV0PXAffdTERXVjXqJr37XhZKc27ze658Oam1PKs6cXASsPCERCgoXQTIJmbXe79wZ3q
         nyFszWHYRcH7gxHMTNfhqUfsS5AZFb8L5FFxr89fMR1vpSu2VXm4ysLKz1/EGc7DvHM1
         usww==
X-Gm-Message-State: AOAM5309Pnv2ZoMiE4//HJ8c5u4P9OKH4vTPhWF6TZDAeNdT5jVx9rho
        QG+qcMX8LatJ5WtBb4vD3Mc=
X-Google-Smtp-Source: ABdhPJx+NQFGglBI8lF/fxnj638ZB9usc/Pzw3RTAfRwTORtyrev5o0PTMfomjSNJ6ZEFgN65s8AXA==
X-Received: by 2002:aa7:da13:: with SMTP id r19mr18103019eds.386.1604958737610;
        Mon, 09 Nov 2020 13:52:17 -0800 (PST)
Received: from contrib-buster.localdomain ([79.140.115.247])
        by smtp.gmail.com with ESMTPSA id y1sm9711570edj.76.2020.11.09.13.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:52:16 -0800 (PST)
Date:   Mon, 9 Nov 2020 21:52:15 +0000
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t2402: fix typo
Message-ID: <20201109215215.GA1911@contrib-buster.localdomain>
References: <pull.777.git.1604404087749.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.777.git.1604404087749.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 03, 2020 at 11:48:07AM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> In c57b3367bed (worktree: teach `list` to annotate locked worktree,
> 2020-10-11), we introduced a test case that wanted to talk about
> "worktrees" but talked about "worktress" instead. Let's fix that.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     t2402: fix typo
>     
>     Just a fix for a typo introduced in c57b3367bed (worktree: teach list to
>     annotate locked worktree, 2020-10-11).
> 

Oops, how embarrassing.

Thank you Johannes Schindelin for catching this typo and sorry for the late reply.
