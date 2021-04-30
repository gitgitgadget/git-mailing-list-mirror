Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4567C433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 09:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BB536141C
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 09:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhD3KA0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 06:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhD3KA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 06:00:26 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540C5C06174A
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 02:59:38 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a4so11012447ejk.1
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 02:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=sBo5rc6aXRM7SzjzgMnfxBOhhdyly4g9gyWZrOwfFlY=;
        b=gfZ/nXEWKkrLNoPP6zCdn2tk9n5DTXPiirEttJU4fJPMjtAwZnmFVXmJ/KFnDR2LKr
         cmVOPdIGKK4Yd0A0vAEUUn/rBg1oQZNeXm7Y36684IC0oV59ZMrIhG0tXfRD+h/OnYXI
         +GZH2m8be144BniL5jdN73P0xQE8UWb3vm6uuB1gn3KVctSkYkRbWXZ4dUkyKprhMWRG
         dDA5evlb+lHapHel+HaYk5LMpHP11uj7VozE3CrwPlcTAndLIR9lNDf/0wKY8lYff6yi
         JsOH53Xy9gjDNPdYJ0EUi2GEC8tKo5BW0iwVZDHGHOk1iRrHOI8aw7YINGbl9obQ5z6J
         H6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=sBo5rc6aXRM7SzjzgMnfxBOhhdyly4g9gyWZrOwfFlY=;
        b=lIj+t3NKOGTCvG0iGf0OllUS8Oo1PoQ5ysfhq2gbABgQD1tCNtpVwqURoSPPaCWWuf
         ajMtS2t8C6lU4SR5euWGQUd3du7loaoANIO8OCppP7Z+Ge9ev5lXyhW4eZCHudbu5Ugq
         RGlECPzl0q2Bw8SPg5mjXLQaf/lODjUFl6Z8fLrziBasPgHLHFscPFmUDh2HRnB/vbjw
         L96Yv+VaB4LoHFEqA23HclG9uTAgIU7bdHks5FsvuFCAgg1lqMmq3rMWDxCG3TCIUVYI
         oWRlj3pD3Sn/pykDFkdh8Sc/qa4pYnuzWMsQdemgH+Prd8gGBEVRlKf60D4islTP01Kx
         TAbQ==
X-Gm-Message-State: AOAM533zmdmd2IxJS6KT4zODCd5XCqoNrjDpJWolNZojhMKLEkPs6Pun
        OhqEKRVuvj3tG1YIG/ktRrM=
X-Google-Smtp-Source: ABdhPJwJDs4F3yxYtwynZ6t6xgT254FxFslC+B0u8LkLYazneZY1l1dc5YZP/Vga1NvX2R2rr9QvLQ==
X-Received: by 2002:a17:906:a006:: with SMTP id p6mr3437681ejy.350.1619776777038;
        Fri, 30 Apr 2021 02:59:37 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id t20sm1621404ejc.61.2021.04.30.02.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 02:59:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Luke Shumaker <lukeshu@datawire.io>
Subject: Re: [PATCH v3 09/30] subtree: t7900: rename last_commit_message to
 last_commit_subject
Date:   Fri, 30 Apr 2021 11:59:10 +0200
References: <20210426174525.3937858-1-lukeshu@lukeshu.com>
 <20210427211748.2607474-1-lukeshu@lukeshu.com>
 <20210427211748.2607474-10-lukeshu@lukeshu.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210427211748.2607474-10-lukeshu@lukeshu.com>
Message-ID: <87o8dwxfco.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 27 2021, Luke Shumaker wrote:

> From: Luke Shumaker <lukeshu@datawire.io>
>
> t7900-subtree.sh defines a helper function named last_commit_message.
> However, it only returns the subject line of the commit message, not the
> entire commit message.  So rename it, to make the name less confusing.

This and 06/30 (which I also had a comment on) would be less churn if it
were arranged to e.g. use the helper / only touch all these lines once.
