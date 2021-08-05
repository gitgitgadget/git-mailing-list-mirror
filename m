Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E56C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 01:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5213260F10
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 01:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbhHEBhd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 21:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbhHEBhc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 21:37:32 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9A4C061765
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 18:37:18 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id s184so4792541ios.2
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 18:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9VyIyvnaImK36/Z/k/aXTtz7hWpi6CkMrROm9OxQoY0=;
        b=CNAp/beDxsI6/+4LQzTCNYuah0agxB3P84BdUzgMtpLZlr5NcbLSsCYui/pLwnAObH
         3WVdKQGuY8dnTm0XhPrDgcm4aWoSagMfeaukTjX4EdPh0IvT06GIq2ZN0XRaolQFWnV0
         PnuOWLn+m7K1x9Xjh8LSPwPmMM0LKQgjkpUptgwz/xify0ByebqAlw81lHLfg+J+17ZL
         horjRWciyD4laiNTwIkcrn0IesAhICeo0e4WYhQeV7csA/z9kQk1JrioFgxj6KAtmZv4
         VZbFDco2e2BjpZ6Yn12ApA3stc16L6XXRg9kx6Pyne+cYrvaYX0EWWCeL54RLf5k28id
         eCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9VyIyvnaImK36/Z/k/aXTtz7hWpi6CkMrROm9OxQoY0=;
        b=R7KRczgEmw97odXD6zidxZMOoHsimK3fbtFIIueY/MPBhytxlEcokXa3VIohqL+gLb
         VHkUaFaH1uYNLBY0AGZ9U5VJ+1aX23igB31guZrgcbGxL2VnKiTf5dTBbtyfxJe317/v
         pZ4ma0qU4pKc1gkV5iE00RNwgZ89z9d+mba4sPo6OF8ODNdAUPxh1HHRX5c5TDRcZ49P
         ZWtKBWEvyd2Atl0BATuVngu0tjJ9TE2Ucc+8Ed3tUEL91WklGWY9fzK/Mir7rW9X+8EF
         iAYb/TUbPOU0SfnUdb1iq5CIPljhSgIPWN3bCIuXAwksDSOflTfbOaoSv2/PkXe2sjbP
         /eyA==
X-Gm-Message-State: AOAM530QJlCEjMSQ514JCPqv0KxM9Y1WTuzD9FfJDNZI18NO50eop1YJ
        SfiVMKDX79ZQaozViTXMnKvy8w==
X-Google-Smtp-Source: ABdhPJy6Tu2xZ0U74WHMlFbJKyT1O/PItcz9cvGvLc2vMXyfhhMruggqrXfVxaqzdP+b3aMtN0KBnw==
X-Received: by 2002:a5d:9eda:: with SMTP id a26mr330655ioe.166.1628127437605;
        Wed, 04 Aug 2021 18:37:17 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:dd9c:1551:d5f7:652c])
        by smtp.gmail.com with ESMTPSA id b8sm2145657ilh.74.2021.08.04.18.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 18:37:17 -0700 (PDT)
Date:   Wed, 4 Aug 2021 21:37:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2021, #02; Tue, 3)
Message-ID: <YQtAzPjkSHfVrLmK@nand.local>
References: <xmqqfsvpr8t5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfsvpr8t5.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 04, 2021 at 12:03:02AM -0700, Junio C Hamano wrote:
> * tb/multi-pack-bitmaps (2021-07-27) 25 commits
>
>  The reachability bitmap file used to be generated only for a single
>  pack, but now we've learned to generate bitmaps for history that
>  span across multiple packfiles.
>
>  Comments?

Peff completed a thorough review of the most substantial patches. We
found a few issues, which I addressed in v3. I'd like to have him read
through the tests, although I expect there to be far fewer changes
there, so I would anticipate that v4 would be suitable for merging.

But let's definitely wait until post-release to move this along further,
since we should be dedicating our efforts to polishing the release until
then. Feel free to eject it in the meantime if it's more convenient

Thanks,
Taylor
