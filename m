Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7632AC433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 22:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4415164DD5
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 22:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhA0W4o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 17:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbhA0W4K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 17:56:10 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D7BC0617A9
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 14:48:50 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id x81so3543393qkb.0
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 14:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=urQujDLm4P69tfYH3fUIzaDSxjnHSD7IeOTOpLCiRoQ=;
        b=Xl8b6jz4tctRw8TaIyKxb81kH1xOKuFtM2P9BRClvPGwftInoLiM1eIes6dp1PYWp4
         tRTOhNmhbg/DIrSm8A3FRcbcDia1tKyipUKi43lf7Ou5oAYu9+eP1naA54YNUALrf8UV
         RNyxqEXkwYETT/ea7L6Wlb4wmKMrx2WWR8zcOsQg9X4cWSGcf4hmoeh05vNFt/p2XUZp
         vQJLEnKL+K6NTfdx6/m1CDt+sjQ9HSC4hS/L+H+TCpBc6wZMW2dlFiKY6HyXiNi7heCX
         SgTXGVVg4SDjXcgUrqqCigk9oVWRFcqZcgvKDuVngTP9IwoW16+9xaqSq5CPx3cznHFJ
         NPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=urQujDLm4P69tfYH3fUIzaDSxjnHSD7IeOTOpLCiRoQ=;
        b=IfLBZoljBOBpyLCI51kfjwBQb47aoY0mEnRSiyMeABwvCZWRBtGo3OSFK2zPPmKsD7
         6HR1H/RVj9q/i6a87L6hwkl3oae1DVeSHP7mwL4Ykb0ECUZuDG9uqTQQ3fSvoaElLvv1
         iGkzFBtkGquLt4HEphYfZY+luJBLtysu7FxGcfW3XFQ7iENEbQU11aqopy8NzEmbfdAG
         Kk10erHZzf8PQ/iaKDxUXcnEOtyGERy+MQ3TwyCmuuNF7toaeoR04ufKbor/B+XPn10R
         ktULQzggUa569jcNs5xdkJk6LfJta3DVdT/N8X98hA0mCoc9HCDmJx1MBvaTSicglalx
         Ncfg==
X-Gm-Message-State: AOAM531xx4b3buJh7LDlW+rMdOV/KHQRnGTVysXFilMPEvL+Fy8+qdsC
        K7YxelctC8LmVNRYOlf8mWZ4pMeSOapnwg==
X-Google-Smtp-Source: ABdhPJxRU3TcIyJySe+TtFGnns6RQr3pyaeokWIZj9/tZ9B6dt1ZrZWi7efuRw9vj180wFBQ1l30bA==
X-Received: by 2002:a37:e97:: with SMTP id 145mr13137679qko.8.1611787729211;
        Wed, 27 Jan 2021 14:48:49 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:8b08:17f3:5149:2ab0])
        by smtp.gmail.com with ESMTPSA id s5sm2213470qke.71.2021.01.27.14.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 14:48:48 -0800 (PST)
Date:   Wed, 27 Jan 2021 17:48:46 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/2] t: add --no-tag option to test_commit
Message-ID: <YBHtztEsqqvz5zUK@nand.local>
References: <YBHlGPBSJC++CnPy@coredump.intra.peff.net>
 <YBHlSQ6cSJWHWeWo@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBHlSQ6cSJWHWeWo@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 27, 2021 at 05:12:25PM -0500, Jeff King wrote:
> The alternative is that scripts have to call test_tick, git-add, and
> git-commit themselves. Let's add a --no-tag option to give them the
> one-liner convenience of using test_commit.

Thanks for finding a spot that does this and making it more readable
with the new --no-tag option.

This patch looks obviously correct. I'm sure that (as you note) there
are more cleanups possible, but I'm happy to just grab an easy one and
let future refactorings clean up the remaining ones.

Thanks,
Taylor
