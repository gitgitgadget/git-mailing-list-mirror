Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE56BC433F5
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 22:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbiBNWHo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 17:07:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiBNWHn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 17:07:43 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BCB13C391
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 14:07:35 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id g20so8351874vsb.9
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 14:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HQkuFKhTfzbdeV9hp/rxPUESKmMInyPejq5uHJiS1Y8=;
        b=CAD1WrPUlcp6h7HyQIl3SdcLqGw7UfDaAZejzwoxKcIq18kZPbjjB/1h94tuJZmo00
         ube5wRIF47WRVjP6ReL3YFm/fZuWytAINBRHM4Dxnupm46tGbBy9itU3r3sqIZJpmpSQ
         2Z4hLxTHAOeO+b8/c+xbk0xyTP0B0KmxoGQ6y4y4r61s3qxBfmuHgWreJSvJrWbsb0ig
         DW8J1etH/vNSO9BfYYh36srmb8dJYp/tCFJGfWM5Z0iHrtRXdXmfy93l4cy6QYndCAVo
         N1b7dSm3NWUpLlorMg/aI23luNNus/dgewyCQWybminzio1en7JnEqSB5P0KjBd3Ttxc
         jKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HQkuFKhTfzbdeV9hp/rxPUESKmMInyPejq5uHJiS1Y8=;
        b=BxCHEeaGW5/vENhS6Fhd5iFafL65sO7ncgU2B9peF1bSpZot2F8dLMBEw4UqcuxDlF
         Jj7H0hywQULYa/ZKGR7GMCYcFzKAVDXgSTYwASUBiXEXeYERj8Ei4ohmoZ6Y7JlpY5Qh
         K/KwT+E5Fbvl86KI631aZPjTi8YKicUvGEzOAlyV+JXWKjiq31LQAqLCIjBix4sRxawP
         gDX2S6AzSjS7Kr8b8fd8jRRB6LqcnI64VAtnPb0yrogkqYQjTlJwortRn4GiTzUT0AZv
         +eQO86KQqRnBeiWn1nLqr1DrPHRN5c9yI2oBUYJtug33z7XPC/g4q3/T5S5c0cHIMhY+
         YIdg==
X-Gm-Message-State: AOAM530DwRAmfod84HGgeWUwKw0pq5IsVcfB0wWIpIQYMfVD0rmkqIUB
        p/zFxL61nbyP1swwG16yc4hMuI/bdOGzxDa/0tg=
X-Google-Smtp-Source: ABdhPJz1G85/8hWDY/4DgLpAJggIK2dZxg3hIpH7HvZoT60hD4OibRVMpX5gPdrM1eVzZ+U7DPzm4F7J7TZWDxR2qv0=
X-Received: by 2002:a67:ae0a:: with SMTP id x10mr398112vse.87.1644876454099;
 Mon, 14 Feb 2022 14:07:34 -0800 (PST)
MIME-Version: 1.0
References: <20220214210136.1532574-1-jacob.e.keller@intel.com> <xmqqr18515jr.fsf@gitster.g>
In-Reply-To: <xmqqr18515jr.fsf@gitster.g>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 14 Feb 2022 14:07:23 -0800
Message-ID: <CA+P7+xrN0zPWfxO1roWzR+MBHntTv8jr9OGdNcN9RPA=ebK24A@mail.gmail.com>
Subject: Re: [PATCH] name-rev: test showing failure with non-monotonic commit dates
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 14, 2022 at 1:50 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
> > From: Jacob Keller <jacob.keller@gmail.com>
> >
> > If a commit in a sequence of linear history has a non-monotonically
> > increasing commit timestamp, git name-rev will not properly name the
> > commit.
> >
> > However, if you use --annotate-stdin then the commit does actually get
> > picked up and named properly.
>
> IIRC, this is to be expected.
>

Right. I figured this is somehow expected behavior...

> When preparing to answer --annotate-stdin request, the command has
> to dig down to the root of the history, which would be too expensive
> in some repositories and wants to stop traversal early when it knows
> particular commits it needs to describe.
>

And this method of cutting the search relies on monotonic commit times right?

Is there any other method we could use (commit graph?) or perhaps to
add an option so that you could go "git name-rev --no-cutoff <commid
id>"? That would potentially allow working around this particular
problem on repositories where its known to be problematic.

Alternatively is there some other way to apply the cutoff heuristic
only in some cases? I get the sense this is intended to allow cutting
off merged branches? i.e. not applying it when history is linear? I'd
have to study it further but the existing algorithm seems to break
because as it goes up the history it has found an "older" commit, so
it stops trying to blame that line...?

> Dscho?  I think this is pretty much a fundamental part of the
> initial version added by bd321bcc (Add git-name-rev, 2005-10-26) and
> kept that way to this day, I think.
>

The reason we ended up with non-monotonic commit timestamps is a bit
strange, and at least going forward I can remove the cause. However
the history I deal with already has this, so perhaps a simple
"--no-cutoff" option would be sufficient? This would allow getting the
equivalent behavior to annotate-stdin without needing to script it
myself.

Thanks,
Jake
