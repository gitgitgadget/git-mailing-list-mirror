Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026A1C2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 20:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D585161164
	for <git@archiver.kernel.org>; Sat, 22 May 2021 20:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhEVUzN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 16:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbhEVUzL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 16:55:11 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DA1C061574
        for <git@vger.kernel.org>; Sat, 22 May 2021 13:53:46 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id f22-20020a4aeb160000b029021135f0f404so2356595ooj.6
        for <git@vger.kernel.org>; Sat, 22 May 2021 13:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=l+Rw/khZPm5QBWFIoHaa/eO92wDc0AEeA2QDO4ybVA8=;
        b=OTMU3hOPh4R3KQHdzq7A31FiG2kEGG6ngq7HfP+REj6PhrefahTcJmCsyiv7/IY4L5
         h/uX6PR0UaxNXJsLn9CmcY7314wOv13iLou9SEpuDmbQgWuCrM0JU+Z51X6bas7S1gBg
         u5T9cQN5rEFuQYYqfYr09JzVTT8ytJtAWWAFNXs+N/cm/odW0T35nT1Q9eaH60SUXYWB
         fhnqj8PUvn0X8wIEJ6zrh5Bet7DF2vpYt2Ad8ma9Ywqhptulc8880JTTgYSF1Z3txswL
         d62OiJq0GGg/PZN5u/GUAUiL668pPki+6QW1hdvo0Y3Y/C/XosewySu2DhSm6jh+t+Eq
         qkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=l+Rw/khZPm5QBWFIoHaa/eO92wDc0AEeA2QDO4ybVA8=;
        b=kKudR8RQ0E+mjjO6tSK1+rzBkjAJjCgDk4LSvlVEFoMeY+x/fNZDeyNWQeUuIjjFhp
         kCLCTnvcRerEsoSBGRKHItcnzbuxFAGTUhX+WsoT5Z8WHTjKHubNTjLFdA8ob0fJxEAl
         FT76ZiGRt0DOPrqo0/3q5eDklXJY7aFFu2LqEIc3hQP0NcOG4UrnbnU5FN1bS4TMgCVF
         ICtwEFFt8WwtYEBHCDP4kpQ6LbAK7fUfSFnEZ6/peOUKBEl9viiwu2gisRmUoqFXz6Fy
         VAoWxvvYu/jo1XAqnqBFjKsxxDFcBcbc0strDUgTnaN416d+whUqm1tD821wyQJorlYr
         oBiQ==
X-Gm-Message-State: AOAM531e+2iWzHM0eUr/LaHqGAr+xtKw0jJ2yZctJd3W8M/XMmK/cxeC
        yDjC36CT3gmQvPoAwCkeSzI=
X-Google-Smtp-Source: ABdhPJyYN9lq1USRMxS8NPgqHW1Gf/7LX2OvEwu6TGWOo/u8A5vNqx2vjcc6VRKz8gVv7pkDFUq6yQ==
X-Received: by 2002:a4a:3b96:: with SMTP id s144mr13182588oos.22.1621716825819;
        Sat, 22 May 2021 13:53:45 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id 88sm2048502ott.51.2021.05.22.13.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 13:53:45 -0700 (PDT)
Date:   Sat, 22 May 2021 15:53:44 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Leah Neukirchen <leah@vuxu.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Message-ID: <60a96f581a80a_857e920890@natae.notmuch>
In-Reply-To: <362a8b5b-84cf-079d-a4c7-c714ed3a2f07@iee.email>
References: <20210520040725.133848-1-felipe.contreras@gmail.com>
 <842221d6-51c4-e08a-4299-c4efb8bf1dcb@gmail.com>
 <xmqqbl94smjb.fsf@gitster.g>
 <YKdy5jhHgG2who27@coredump.intra.peff.net>
 <60a7f57fe3301_5503920831@natae.notmuch>
 <YKgXXCvWYI9rjKJT@coredump.intra.peff.net>
 <60a828cebd2f1_77e4f208b2@natae.notmuch>
 <YKjU+/mGzWoqe88V@coredump.intra.peff.net>
 <362a8b5b-84cf-079d-a4c7-c714ed3a2f07@iee.email>
Subject: Re: [PATCH v4] help: colorize man pages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley wrote:
> And we have the whole Git for Windows community who don't have `man`
> anyway...

If they don't have man, then they won't be affected in any way.

-- 
Felipe Contreras
