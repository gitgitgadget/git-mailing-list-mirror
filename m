Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5624C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 20:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8294C23AFB
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 20:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgLHU4c (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 15:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbgLHU4c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 15:56:32 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FD2C0613D6
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 12:55:46 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id x16so8945oic.3
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 12:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Inn/xgdv1p2i/lqSSPVEk62bZxaLZD8WiKZFJLblvHk=;
        b=Xt7htJtag7Jc95qcP/bUEjy3QuGcq6qQHJO3OMaE/AfoVsoBtKghahigoxNVP+NQ2z
         wcTZJuDrpwllAaiU+VYm9pKQgveS2uI9NAjqEdsVqQTFvpkq/dOkctCipl270rAIX5KJ
         DBXfSiX8vwMKHMq+2xBTdkg3MAZVBhFe0XhrJjr7Dfz50v7Tw3OqrPgmbJM8sNqzIO0y
         n3REssL6uy9ig4Kkwb1UvJ3bc2r/Jdc2wmaUYStE/+Be8AMkQBt75SKT/vVq647sdqkK
         WbchdiaC9RDiW4diAE/UTA3Kzy0V5GOLyXKNy0UFMlmKdUq8u8huJjfTtNWcqUGpAAXD
         zWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Inn/xgdv1p2i/lqSSPVEk62bZxaLZD8WiKZFJLblvHk=;
        b=EdyuqPfd7lV+KeN+x6KQwCNIPo+/h/sivj+jVYftvDzQdc3l8kVRxwXK0l8SvONeJ+
         IDyIRh7qbXveI5mw13jgrePoSioCIsr/rU/YGa0GZbjxU7CthvW2MQz43SCdOyY6X52V
         EDYFXUIRi2SCq0/jtN32ioADr+kpfAN6W0Yb9eufhZNz3xt/5zobrm2HYfXEgF2aoKCm
         evjVE5i0E2Zk//swRP7CT+nDe8HsmywR6QsyZh1dhsh+kEqIJiBQRGu1X1zG1jnTrstL
         Gf9axtFFwod4hICbo4VCmkfKpVdFr8KoaM5lve6vxdJLFDFtz5Drw4ehv4BNPENAc8Uj
         Mq/g==
X-Gm-Message-State: AOAM530hr0BPtBc5oXvQ5JrkQ7T+1Ra0b48eLRqYm2pA92+8eKWrOeTp
        2PYwgISn3KxCLw4tS+AdkmQAhLhRwb60EGat
X-Google-Smtp-Source: ABdhPJyK74MzYcSqzP+fhwZow14zwMH5YMddn3Re+WlW7Cz5FnFjKJgYpWfEGtjZxO/BIzqVwyjo1A==
X-Received: by 2002:aca:ec13:: with SMTP id k19mr3869277oih.97.1607453024531;
        Tue, 08 Dec 2020 10:43:44 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id r4sm3480895ooa.29.2020.12.08.10.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 10:43:43 -0800 (PST)
Date:   Tue, 8 Dec 2020 13:43:41 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, szeder.dev@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 11/15] midx: use 64-bit multiplication for chunk sizes
Message-ID: <X8/JXfTlbhuhgizF@nand.local>
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
 <c6a433efba3214e83a7265e53c24cb4001345f14.1607012215.git.gitgitgadget@gmail.com>
 <xmqqa6uuh7n1.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6uuh7n1.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 03, 2020 at 02:00:50PM -0800, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Derrick Stolee <dstolee@microsoft.com>
> >
> > When calculating the sizes of certain chunks, we should use 64-bit
> > multiplication always. This allows us to properly predict the chunk
> > sizes without risk of overflow.
>
> That's quite an obvious fix, applicable even before this entire
> series.  I think we saw quite similar bugfixes in different parts of
> the codebase recently.

:-). Indeed, Stolee and I were probably looking at output from the same
static analysis tool, which seems to be eager to catch these sorts of
multiplication-widening errors.

I'd be happy to see this patch get applied down regardless of what
happens with the rest of the series.

Thanks,
Taylor
