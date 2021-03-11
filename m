Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92061C433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 19:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4199364F6A
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 19:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhCKThS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 14:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhCKThA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 14:37:00 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B4FC061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 11:36:59 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id w8so3968209pjf.4
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 11:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YrjWGHPDRw+g9XjFETM36FKsLXb4fJ5eS7hgCALdKtg=;
        b=FqjfshsD7pi9k3Y1hht3oN2HxGEUgHTCu8vpX8bK9IpRlvJRbKMU51aPXDcVmARG0N
         dLBkTCRf67S0OF3kwfn4p6m36CnpKvKC3SV5KndWYV6cBa4yu8a9grmm4H8m4ycv7tut
         5hob3Kdfr81YsFrE9/J2yKvyrX0WsRL6783t7jjvfoqRkhGqQbDCTTlqk/rV/xTbWYt6
         bMO51ksCSyat5R6JqdPzaLh8tq+I44FJUONA5xKECGhBqTnUa2UVEVS+EboWPxCiu1qG
         HsA/BcUj19Kl1PhqAyIdFGvMsutHvf+W4c30/oHFOGfu3cOryBR8NfhyKD8REw6eHRKx
         pAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YrjWGHPDRw+g9XjFETM36FKsLXb4fJ5eS7hgCALdKtg=;
        b=enTH5NRNH3Cu2J0e6PV+gPcQeScJJd0S59u8goZNLYl6xj4nOPOtMgXOwz9Dfsaf9m
         9O/z48tayXRCp/vHoGAtx+b/n1Gepog+EoYRJpgH2ALBXoKvh9jhJumsdrsi7tMs3yzk
         SztOWY5UD5gyp2o3GUK3ZFrlunXIPbDT79oZVFtz+esdYrL6r78sIS4boXHCcFWbujt1
         5SElcDjhFrVb52sK39NGw3y+l4ynOwp81etfbrFyM4tQcWaMimk3vucgDY/Zlg65eDnA
         pDznmYxhAEo75Mz5FT88dVwz25HDmnQjCL4Ac7oiWAi5B2m1onixGfX1OtxDPJtRCVl1
         7SSw==
X-Gm-Message-State: AOAM532nR5mI32m2fe1bhLy1MiWtAAUPibrmLNeYOpjMxnI7YlyNALe0
        NFB7WtxMQj0Hxe+FUvRkfay6BQ==
X-Google-Smtp-Source: ABdhPJxp53xe7zuYNZIOhToawe7O89musOMxmcsipainDEjYGUoSW+YqxwmwaLOGKcPCKliRjvriuQ==
X-Received: by 2002:a17:90a:a789:: with SMTP id f9mr10746583pjq.192.1615491418979;
        Thu, 11 Mar 2021 11:36:58 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:e0c1:812:ced1:739])
        by smtp.gmail.com with ESMTPSA id y15sm3505623pgi.31.2021.03.11.11.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 11:36:58 -0800 (PST)
Date:   Thu, 11 Mar 2021 11:36:52 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Kevin Willford <Kevin.Willford@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff King <peff@peff.net>
Subject: Re: What to do with fsmonitor-watchman hook and config-based hooks?
Message-ID: <YEpxVELGCxtnNxQK@google.com>
References: <CAJoAoZk0fSyPSJZ51wNv4XujPA_-hPfh8eMRQPbyeTXFvKJ9+Q@mail.gmail.com>
 <33a12a7a-d19c-63b8-f21e-db7e517b0f53@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33a12a7a-d19c-63b8-f21e-db7e517b0f53@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 02:23:03PM -0500, Derrick Stolee wrote:
> 
> On 3/11/2021 1:42 PM, Emily Shaffer wrote:
> > Hi folks, I grabbed a bunch of CC from 'git blame fsmonitor.c' so
> > sorry if you don't care about fsmonitor-watchman anymore... :) Note
> > that this whole conversation has to do with the series proposed at
> > https://lore.kernel.org/git/20210311021037.3001235-1-emilyshaffer@google.com.
> > 
> > When I was looking through the remaining hooks in
> > Documentation/githooks.txt I noticed that the fsmonitor-watchman hook
> > is implemented somewhat differently than most other hooks. As I
> > understand it, to use that hook someone needs to:
> > 
> > 1. Configure core.fsmonitor with a path to some fsmonitor-watchman
> > hook. The documentation in 'Documentation/githooks.txt' claims that it
> > needs to point to '.git/hooks/fsmonitor-watchman' or
> > '.git/hooks/fsmonitor-watchmanv2', but I don't see that constraint
> > enforced when the config is read (config.c:git_config_get_fsmonitor()
> > and fsmonitor.c:query_fsmonitor()), so it seems that core.fsmonitor
> > can point to wherever it wants. (Plus
> > 'templates/blt/hooks/fsmonitor-watchman.sample' suggests setting
> > 'core.fsmonitor' = '.git/hooks/query-watchman'...)
> > 2. Configure core.fsmonitorhookversion to 1 or 2, to indicate the arg
> > structure for the executable specified in core.fsmonitor.
> 
> This is correct.
> 
> > Because the executable doesn't necessarily live in .git/hooks/,
> > fsmonitor.c:query_fsmonitor() completely skips the "API" for running
> > hooks (run-command.h:run_hook_le()) and just uses
> > run-command.h:capture_command() directly.
> > 
> > Interestingly, this is really similar to the way config-based hooks
> > (https://lore.kernel.org/git/20210311021037.3001235-1-emilyshaffer@google.com)
> > work - but different enough that I think it may be awkward to
> > transition fsmonitor-watchman to work like everything else. So, some
> > questions, plus a proposal:
> 
> You'll want to get Jeff Hostetler's perspective first, but I'm of
> the opinion that we'll want to stop recommending the Watchman hook
> when the Git-native FS Monitor feature lands, with some time to
> let things release and simmer before we remove the core.fsmonitor
> config option. We would also need a Linux implementation, but that
> is planned.
> 
> If we think that the plan of "eventually, FS Monitor won't use hooks"
> is reasonable, then how much do you want to spend time unifying it
> with your config-based hooks? Can they live together temporarily?

Oh, that's useful context. If fsmonitor-watchman hook is going away, I
don't think it's necessary to convert it at all, unless someone starts
asking for multihooks or something. There's no practical conflict between
config-based hooks and the current implementation - it's just a
surprising inconsistency. I'll be curious to hear Jeff's opinion, of
course, but given what you're describing, I'm not convinced it's worth
spending any time on - and when we're ready to stop checking
core.fsmonitor then the inconsistency will just go away.

The documentation in githooks.txt could use an update, though. :)

 - Emily
