Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5C8C43331
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 23:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 548FD223C8
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 23:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbgL1XQq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 18:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgL1XQm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 18:16:42 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB594C0613D6
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 15:16:01 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id f9so7028785pfc.11
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 15:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8JofnjkOKwmReQ0Hs0XJkfR3rt5fbuw9s8tclX6sOuE=;
        b=p4z6BcZpCZjNizcKO+/LaMsBZu+ZLhgWPfv0FyKpTW78O5mWKtsR2wk5TgfN2jAfMl
         Xvco7sdjA2tNryCQGNcNbYia5z3MpSKlpEMoHymcZyyCf0/A76w6Dw4uz93bjRUiBXeV
         m5dh63O6VBtba7ZPtP37+Y4Fd9MRZZijI01RIYA52qjVeIrDCiIx3IhhkUjXVKSlZOeu
         9vUBmaM5vRHX2nKkP2HIdPoNov5SOdVFcft1Anz6Sb0tqriUhvgstZNAXPkNJWKUmqrF
         XcAJ/O2BxBsMR6DlUtZXDDJZbiFC06yqWQl8mQlNdGloPYTJPIq6papam3c/Lb6q3d3F
         BISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8JofnjkOKwmReQ0Hs0XJkfR3rt5fbuw9s8tclX6sOuE=;
        b=GiTxHfUzrSTuE2roL3dVZ/kAcutIao7/Y1PUve04PNQr4TpJEgX7i9VMPikNSVp1+D
         DHg2g69H5wdPLV0F2wj6r306Jsq6VgqxjgG78rS1vK/3H34Mk2uUiRMza3GMTwOke6gF
         n5VkuaDiYH7yYDnbf9/dGsO2Z2TH8o85LNHQ+iXjSCAYEH0oYgcPhtJYVk/ILjrmVZQj
         aMg01KCB6n1vMepuajcv5zw8tKJJDDsSvYePOrjo/nIJIbJVxr00RV53ue1icuHrT56b
         kaAVn09jT+d5eq/7xw316ky5Zgdohu3BcNJJzDIu/Q+3Zpn21SRyQSlodEiIkIV9dr32
         eRaQ==
X-Gm-Message-State: AOAM533lInMOf3tE6Zfoq+ZKJGDjSfPs8Tn4nb1bnhmC2X8mSfdTzrQQ
        lQev2gb9Yp3Otn008G9yiaNSaKH9qsjGYw==
X-Google-Smtp-Source: ABdhPJwUJZSLkDVlUyRQf+2Dk434Cv3pGWX2s5uIjIOi+tnrUNlAA/YQQuMi/du1Vonuu5xQV0e6ww==
X-Received: by 2002:a63:4b5c:: with SMTP id k28mr43291196pgl.294.1609197360841;
        Mon, 28 Dec 2020 15:16:00 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id y190sm38238788pgb.36.2020.12.28.15.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 15:16:00 -0800 (PST)
Date:   Mon, 28 Dec 2020 15:15:55 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 18/17] doc: make git-hook.txt point of truth
Message-ID: <X+pnK0336CPBaAEe@google.com>
References: <20201222000435.1529768-1-emilyshaffer@google.com>
 <20201228224015.286845-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201228224015.286845-1-emilyshaffer@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 28, 2020 at 02:40:15PM -0800, Emily Shaffer wrote:
> 
> By showing the list of all hooks in 'git help hook' for users to refer
> to, 'git help hook' becomes a one-stop shop for hook authorship. Since
> some may still have muscle memory for 'git help githooks', though,
> reference the 'git hook' commands and otherwise don't remove content.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> 
> Sorry for the wonky subject. It seemed unnecessary to send the entirety
> of the topic again when there were no changes. (I was able to push this
> patch to my fork without -f, so indeed the rest is unchanged.)
> 
> I'd really prefer if 'git help githooks' opens the 'git-hook.txt' manpage,
> but I couldn't figure out how to do that. This seemed like the next best thing
> to me - users can still find information at the old manpage, but get a little
> nudge towards the new manpage in case they didn't notice it.
> 
> Extremely open to other notes about the direction of these docs; I'm not
> confident in anything except that it'd be annoying to have 'git help
> githooks' remain unchanged.

Even now, this is missing the native-hooks.txt from the commit. Ugh.
This commit breaks the build; please do not add it to the topic. I will
include a fixed version with the next reroll. Sorry.

That said, the intent is clear enough for me to still feel comfortable
inviting review.

 - Emily
