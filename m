Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69B9C3F2D1
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 23:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50902072A
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 23:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Nc9hPV3i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgCCXF7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 18:05:59 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55118 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbgCCXF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 18:05:59 -0500
Received: by mail-pj1-f68.google.com with SMTP id dw13so1254pjb.4
        for <git@vger.kernel.org>; Tue, 03 Mar 2020 15:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=daQGPu9A207g1pz8fgg1C0S84LmIeWaaDoFq9Hi8/FM=;
        b=Nc9hPV3i1MpXXpdmsg/P7BNiV6qbQgatIrlf3QN8op8/AyNTsJptL2KhiqWnppj1Pu
         yCsT2+jeuJgO0omLGeLamzJckEcNEAiHAQuo/mGu1+nMyAMxK2SzztDfXPsjigN2GrJx
         YSkJ1luLvxCG2CI9/AlsUVV5meoLA6BIaMqqVZZwO7XYyiKAVr5hEWIcBP82S3KqpLwF
         3SSwGQa27VZf3UipWBKVxT9u7Le8SkNKsrVimtULgflN3PP3u4XeAO8Wu6gRSAQS2EqI
         76DT5KloDegX+QBAQM3fbkVoESnxv1AU+l8yJrwihJHXs564cULIskhlUOcbc5+YLZFM
         pM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=daQGPu9A207g1pz8fgg1C0S84LmIeWaaDoFq9Hi8/FM=;
        b=Y2OcyE72TfX7MqUTx0FcruEYUY/nqqa0/cz94+TRlwmpxWG5Xds7TD6BbWUO47xWM1
         74RybxXlKcVmfN8Mi0mV4j553kwn2kJV2zIBgU89YNvdmYnkkZMUTIXMLZ/nH0NlL1XU
         y+1p6nVps36rWh8/pFZam1SxAxAy08o28oMJ3QEhrA1UgaJeLeWbbJd1YxAQLiDIaaDk
         eUkjAVPnjR+L6dbV4Q8pJCjUKm28iPCZvJzx9J8O1EtrJehjGJG3yW6lSFqZ5q4Hovjr
         nyDqWRXF26CLJhW+u6p7Vvp7e96LoxYhNyh83OEq4YxqV6FLWL3DH0Rdxck9VHSzTuUs
         NMog==
X-Gm-Message-State: ANhLgQ2Dzl1PkMHZktGKvIUJ0U3RlxOiqX/90gxxQJcxmFvWcqzOXFkc
        WRSUDeBRTv2ElH4EZtGrObaQUg==
X-Google-Smtp-Source: ADFU+vuwenR06YSb7Jc5Fbz58/e8VoYNE3uoohNaiA+2Odlc4JjDFtysesOi/EJ94JHK8z716987lQ==
X-Received: by 2002:a17:90a:fa06:: with SMTP id cm6mr396533pjb.109.1583276756362;
        Tue, 03 Mar 2020 15:05:56 -0800 (PST)
Received: from localhost ([209.37.190.132])
        by smtp.gmail.com with ESMTPSA id x12sm3828610pfa.59.2020.03.03.15.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 15:05:55 -0800 (PST)
Date:   Tue, 3 Mar 2020 15:05:54 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2020, #01; Tue, 3)
Message-ID: <20200303230554.GA11837@syl.local>
References: <xmqqimjl6pvn.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqimjl6pvn.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, Mar 03, 2020 at 02:21:48PM -0800, Junio C Hamano wrote:
> * tb/commit-graph-split-merge (2020-02-12) 3 commits
>  - builtin/commit-graph.c: support '--input=none'
>  - builtin/commit-graph.c: introduce '--input=<source>'
>  - builtin/commit-graph.c: support '--split[=<strategy>]'
>
>  The code to write out the commit-graph has been taught a few
>  options to control if the resulting graph chains should be merged
>  or a single new incremental graph is created.
>
>  Waiting for the discussion to settle.
>  cf. <20200212205028.GE4364@syl.local>

I think that this may be as settled as this discussion is going to
reasonably get. I noticed that this has been on the "What's Cooking" as
waiting for the discussion to cool down, but there haven't been any new
messages.

I think that the options are probably unlikely to change in the future,
and unless there are some serious reservations that nobody has raised,
that we should go forward with the patches as they are.

What's in 'v3' of that series [1] is ready to merge, in my opinion.


Thanks,
Taylor

[1]: https://lore.kernel.org/git/cover.1581486293.git.me@ttaylorr.com/#t
