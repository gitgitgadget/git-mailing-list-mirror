Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A78DC4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 13:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 776BB60F12
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 13:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhG3N54 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 09:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238998AbhG3N5y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 09:57:54 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54F4C06175F
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 06:57:48 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id f22so9465352qke.10
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 06:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5YmCE6hp+VT0m3HDF9X38sTaTP7CwAIdeFRFSGIfKQE=;
        b=YoRdtsCj7as2fepdYRwAql54GSvbeLIw9jabgTRtV6u+q3FYR3gw0n0ta4Rm4CYd7g
         CAzcLaMyORqH/sGeiPZd4zkX5z+sGxSiQWvIoTC4IaQ86dY1HCM5qCarDNUnSd/Pp94X
         ho0uEcqmCCcicLqMdlpwZvv5eMD6KnMmK5duiYe9cKlVvR/EdhhwMD/plOb79gD3IL1I
         Fas15xbNND8AcXZebHFEUiEZ6JgxTn19NjQxYEt2HSLvF+LqVE8sFrudZXFAqOCKuJfl
         a/hFOw5E+I0pWPXzNk1byk1t7SZKpA/EI7qAqmAxbWm5+c65KFztftI6Ht26erITvv22
         QM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5YmCE6hp+VT0m3HDF9X38sTaTP7CwAIdeFRFSGIfKQE=;
        b=SyzPMjSr9SeFmTjfFqEESU2kG1Pr1sYJF0NKhhAwAkAWmShdoCajh76ed6ic/hRxWR
         sX8g3dRiFiSve0ZZdLhyoEKpR1X4uaPDpEy+kUb/PmaoFFeh7a+XLbpOqk6P8yYOrMbN
         Kw6WvXyrPUkHf0c5x088RycH96pNuFFkQ+Ls4+PwtPBy/lrnOwpk8WixGAYrILqw7Clc
         WakBoqX9jiasjdZOlk8Bfu9YwYSOMZCU/iyh6P+yHK0I/eHUkjMEQoLZA1FuaipAxrx/
         7p8hGSWlM2Z/+Q0766BpJPkUYmgmuDq0y3xJfeLQ/tN0dUrHKQhf/a8lwXT04DataIIU
         Gvcw==
X-Gm-Message-State: AOAM531E79gG21PQmNhfBK/iVqKm6zeeoaNDYYEtU57OuC+vNQFc5Vt/
        5okFUbi3O20FwFiWGJp4fMs=
X-Google-Smtp-Source: ABdhPJyrY9NK7Dql+y1z42TA9th8gdDUhvV6A2giPUG81eCR5xE282eIzeWlDPjjNQKdj2xWk+1SRg==
X-Received: by 2002:a37:6143:: with SMTP id v64mr2435115qkb.419.1627653467836;
        Fri, 30 Jul 2021 06:57:47 -0700 (PDT)
Received: from localhost ([24.169.20.255])
        by smtp.gmail.com with ESMTPSA id p19sm611600qtx.10.2021.07.30.06.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 06:57:47 -0700 (PDT)
Date:   Fri, 30 Jul 2021 09:57:46 -0400
From:   Ben Boeckel <mathstuf@gmail.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 0/1] Improve automatic setup of tracking for new branches
Message-ID: <YQQFWtKo8b1WJIGe@erythro.dev.benboeckel.internal>
References: <20210728135041.501850-1-mathstuf@gmail.com>
 <20210729020125.746206-1-mathstuf@gmail.com>
 <9b8b3a12-6801-1c5d-9cfb-c87b51cd9548@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b8b3a12-6801-1c5d-9cfb-c87b51cd9548@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 30, 2021 at 09:35:39 -0400, Philippe Blain wrote:
> I'm in favor of a change like the one you propose, thanks for working on this!

Thanks :) . Nice to know it'll be of use for others.

> The 'triangular' aka 'forking' workflow is, as you discovered, only explicitely
> mentioned in the description of '@{push}' [1]. 'gitworkflows(5)' is mostly about
> how the workflow used by the Git projet itself (from the description):
> 
>      This document attempts to write down and motivate some of the workflow
>      elements used for git.git itself.

Ah, I missed that.

> Le 2021-07-28 à 22:01, Ben Boeckel a écrit :
> > v1 -> v2:
> >    - removed `branch.defaultPushRemote` (`remote.pushDefault` covers this
> >      case already)
> >    - improved the commit message with more background and an expanation
> >      of the intended uses
> > 
> 
> Small nit: usually when sending a second version of a patch, you would use
> the '-v2' argument to 'git format-patch' so that the patch and cover letter
> is prefixed [PATCH v2].

Yes, I realized that I had forgotten the `--reroll-count=` argument when
making this patch (I suppose a way to store the Cc list for a topic
somewhere would be nice so I didn't lean so heavily on shell history
would help this).

FWIW, my main gripe with the email-based workflow is the lack of
coordinated metadata (LWN has numerous comments by me about my views if
you're curious, but I should really formalize them into blog posts). But
when in Rome :) .

Thanks,

--Ben
