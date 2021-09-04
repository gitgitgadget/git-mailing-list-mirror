Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8697BC433F5
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 14:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BD4A6054E
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 14:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbhIDOw2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Sep 2021 10:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbhIDOw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Sep 2021 10:52:27 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2ABC061575
        for <git@vger.kernel.org>; Sat,  4 Sep 2021 07:51:25 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id b64so2211973qkg.0
        for <git@vger.kernel.org>; Sat, 04 Sep 2021 07:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qwKYyMNARc8RIwnPxFaH/AwHwk8FGvQH81ANtgd+guU=;
        b=RfeLCdC+j0Gp4aennqMSMphOP/0pCqrW7JZdJCOLZ9FrnpGfe4gc83ZjkYcH1bC8Rc
         3OUVMQcT7a7+hfQFmNiyWQlC7U0Hn8dnHWeKR2tt3B3y0cRnbpsIUP4ZKMGRsPwLvdzW
         kFkJpHLukUDvxKExlD5FOcfrdA2g+zlSNYRL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qwKYyMNARc8RIwnPxFaH/AwHwk8FGvQH81ANtgd+guU=;
        b=DRgg5vtXoOtDYXLdV94ydIon/VwlpdDTqjJVFTQIj0P0xJQCO9Lpg8qrF8UJ6LkPn2
         PILVV01IUkIAFlK4+MV5tPDHpm/inBTxa8HjGMYoRJAKZuqI//yB2CmOF7WerO6hCsRR
         GMn2ZGLwmU+JYI5mlQGyA+HmytNFbp/ZKa01kYobaxBPId6CUYXlMzlxXCJYiKG8yi74
         e7i1GtaHYBl8XvL/kXSwNnMG60DGpTq1OOpavlqQI9L9jyKIzJTz2VAR1KPIjZj8soHi
         ovIznlQL1jR7JLedK0lF0DM7B/VFFmB2reNF2xkW1H5bAxj09z6CqA7Q5D6bnnCNDw+S
         XjcQ==
X-Gm-Message-State: AOAM530aniaqWjpZltkYeeethlruTJ+gbiZhL8oODayv9XwxXGvoBZlg
        8X0cegD2I5ZLZgKkUkNJP8Wq0Q==
X-Google-Smtp-Source: ABdhPJwjHPJzbIo1oqiMmI1JILtCwbNT2+n2l5yGBisLsOoD3VTMfR/w2a+SZ8dudiZYLonGek7bjA==
X-Received: by 2002:ae9:f44c:: with SMTP id z12mr3517864qkl.433.1630767084662;
        Sat, 04 Sep 2021 07:51:24 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id t24sm1871850qkg.28.2021.09.04.07.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 07:51:24 -0700 (PDT)
Date:   Sat, 4 Sep 2021 10:51:22 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jeff King <peff@peff.net>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Kevin Phillips <thefriendlycoder@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: Weird interaction between Git protocol versions and git:// and
 https:// URLs (was: Re: Bug with Git shallow clones and submodules)
Message-ID: <20210904145122.4glsdicbx56cs3ji@meerkat.local>
References: <CANNNLMC_XEqjYPOig+pbqrS30dPCTmcDSev6yg+5EEBkJCaaig@mail.gmail.com>
 <1a98c659-e7db-50a6-faf3-b3b4c15df679@gmail.com>
 <542a68a5-d439-921e-2691-bb8890584f27@gmail.com>
 <YTNtVJy6sCfQ7T3L@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YTNtVJy6sCfQ7T3L@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 04, 2021 at 08:57:56AM -0400, Jeff King wrote:
> The server has to be configured correctly at the HTTP level, too. The v2
> probe for HTTP is a "Git-Protocol: version=2" header in the HTTP
> request. The webserver has to be configured to communicate that to the
> rest of Git somehow. In our test setup for Apache, we do:
> 
>   SetEnvIf Git-Protocol ".*" GIT_PROTOCOL=$0
> 
> If that doesn't happen, then the server doesn't see the header at all,
> and just speaks v0 as usual.
> 
> I suspect this could be better documented.

Indeed, I was surprised to find out that all this time we were serving v0 for
http requests. /o\

For the record, the magic nginx+uwsgi incantation is:

    uwsgi_param GIT_PROTOCOL $http_git_protocol;

that gets us what we want:

    $ GIT_TRACE_PACKET=1 GIT_TRACE_BARE=1 git ls-remote https://git.kernel.org/pub/scm/git/git.git 2>&1 | grep version
    packet:          git< version 2
    packet:          git< version 2
    packet:          git< version 2

I will submit a patch for the docs to indicate that this is required, because
right now the only mention of GIT_PROTOCOL env variable are for the file://
and ssh:// schemes.

-K
