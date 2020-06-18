Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE933C433E1
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 03:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEEA621655
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 03:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tAbIjSc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgFRDBz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 23:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgFRDBz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 23:01:55 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B33C06174E
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 20:01:55 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id d4so3407851otk.2
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 20:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wl5StVe2D5e1IpDq2L2Hv32GzmMoY8FQPrtvDJhq8d0=;
        b=tAbIjSc70YOHkcvr4vewmLwrPRueF7/pzIfMoeciMc5IdbkqPTpZVtIqCN6I4DCZBD
         SxER3FmpHsfqlDf0psvO0G17cByocBNlN3wwQI8nAZgFzljcpWj3RVdvwCSnNpWyel17
         98WbLExQaeIREJm4prZ9jafvj46hfNHNGZxrW+z0OrQePGE/pvGa1I1UOh3k9EYK5sHh
         T7TyBaCyMcnp0Q0oXRq6kzZT2QeuGn7km3dJsYihmiFWoR1lJ0MgKBgTAhCUKJ4O8/vv
         6XnCTJUP2XffxBldYxQUw1knUkKURkLrHPHvVNxVseaRqYk3L8+DMp5nXoJ41CrXcLsu
         qVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wl5StVe2D5e1IpDq2L2Hv32GzmMoY8FQPrtvDJhq8d0=;
        b=OVvMPJpvGClcdYAdVmXTMC2GD/u3WRq296uOfrmJEzD+1LGKTVmh/f/ZsCgCDfxhe9
         UJgD3nVjBUVnmeJxCvWedWujAZQrESfbuIn3x+g+MglRhDQV1tkOVePP5khyq1YQDrlW
         gpWdZ0qySnxWAdzKIWdzXFBOpnYNvT0PBNL9DzLXaglDKFUysQl9B8qsrXuisMxvvd+O
         JfFUnO+8DhSQoKpfrRkj05hUQb1DiQFL8I/Z6gniK4db7uXCPMDddB7J4jtajReBCKua
         pjO0Wl94PBKIrEVZ/Rjaqd5Ls1bA6Mbfjko4cZY+m0k6l876SeTPwDbxobjRJ9WeR9k4
         joMA==
X-Gm-Message-State: AOAM533KScWtwVAeccU8d1PIz7l3GQpDuLWpD9bCcgiMkOpquLbRjbu7
        W6dzMZbBefunNC80Zdb8O8GWOfPIKnI=
X-Google-Smtp-Source: ABdhPJwKOTANGBMDkFD+rGyOtdSEG8Ps/je0PYkJmeVDF01k73bhIgi5eRht0Ai52KQZ4dAQuzASqA==
X-Received: by 2002:a9d:554d:: with SMTP id h13mr1573082oti.201.1592449314254;
        Wed, 17 Jun 2020 20:01:54 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id w10sm424795oon.40.2020.06.17.20.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 20:01:53 -0700 (PDT)
Subject: Re: [PATCH 00/10] [RFC] In-tree sparse-checkout definitions
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.627.git.1588857462.gitgitgadget@gmail.com>
 <CABPp-BET86K_N5_W1pXMWeFccbUdxU8+vNvi+m-i6PX0MrXknw@mail.gmail.com>
 <64d477b6-7bf2-fa0d-b9b4-821285af386e@gmail.com>
 <CABPp-BFDcM+QSx_YSAAazkN9AoTPWVYV+ZpSQBPTihVM=gP-qw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2ee11a3c-9785-fa29-afa4-9eeac2248972@gmail.com>
Date:   Wed, 17 Jun 2020 23:01:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFDcM+QSx_YSAAazkN9AoTPWVYV+ZpSQBPTihVM=gP-qw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/17/2020 9:59 PM, Elijah Newren wrote:
> On Wed, Jun 17, 2020 at 6:42 PM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 6/17/2020 7:14 PM, Elijah Newren wrote:
>> You mentioned in another thread that it is a bit unwieldy for a user
>> to rely on a committed (or staged?) file, so adding the ability to
>> check the working directory first is interesting. I wonder how the
>> timing comes into play when changing HEAD to a new commit? Seems
>> tricky, but solvable.
> 
> Isn't that essentially the same timing issue that comes into play if
> you only look at the index, and are changing HEAD to a new commit?

It adds to the complexity. We can inspect the new index for the
in-tree definition and update the skip-worktree bits before actually
changing the working directory to match the new index. However, if
we trust the working directory copy over the index copy, then we
need to also decide if the working directory copy _would_ change
in this move before using it.

Of course, maybe I'm making it over-complicated. I still know so
little about the index. I got into this feature due to a simple
pattern-matching problem that I could understand, but now I'm
getting lost in index states and dirty statuses. ;)

Thanks,
-Stolee
