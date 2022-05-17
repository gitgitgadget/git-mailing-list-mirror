Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658F9C433EF
	for <git@archiver.kernel.org>; Tue, 17 May 2022 15:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237466AbiEQPYC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 May 2022 11:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349914AbiEQPX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 May 2022 11:23:57 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357FE4F46A
        for <git@vger.kernel.org>; Tue, 17 May 2022 08:23:56 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id z2so35368699ejj.3
        for <git@vger.kernel.org>; Tue, 17 May 2022 08:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=gnWrI/9b8jWPCScl0VvtUYSH/TFClBEqJfnSVQDD0q8=;
        b=Ypb5FPgvoZG11nslMaEtsgOU8wfNRuUndcEC+OAxJlHhfnKD8+HqWlzc1VRnS0eKu+
         xeyUM16edfq1MC8Tjh/6TESIPJDFTG/a8zU/yShf5JtQ7Bzxc/vfWn0SEilBKWYCHO93
         9BMsbQeKAYzDGoFE59jq3ZGyYwyByCYkZu6tsRyoFU0xkK35uWKu2ckJsV+Ujn81byUS
         Gb221qP9EiUWv1Ni+jEaL2n3WleJlp9BjFEvoxIhrwS2L+mWv4nnTPzcmh5p2aLPUnx5
         ojLcrPuSlEcUXlYI/YbbuLr7gYMHF2m4ytjPF5gh6CiB9ziRIxLV3n9DdrL7TW0VIN/m
         ysfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=gnWrI/9b8jWPCScl0VvtUYSH/TFClBEqJfnSVQDD0q8=;
        b=2goBLSVMQWivPCBMmr6+OB6Ko+tpr85fIWP2YwHq7d2X2Vrwd6CEw1PqTwR1/QdsuS
         EpNxLRAtVGRwv90cu1G+5lMMwAPM/8c8Vk9mOSvzNQWnTYeKrLx0rcYODC6ncFZLLfYB
         mygfTsAC4puRmRlcLjm+3gR6DIfiz5zFdfojkoG02MtIBGpMkFOtr1qYAY+FHqM6mZ8Z
         L2BmKnqyARRD7YYgRMcY/f/iJ74t31S0y9kEYgp2G9gJhA+dheI+znmwn4y+XHoUU9fl
         /BFhzGlsqEFq2HiTjBjyYRnYCLLnQUw++gFmecDmQscDBGMnR1PjXNQpU9S4Og7krBMF
         wEqg==
X-Gm-Message-State: AOAM531yTvLcSM9ZmAc7kFM8loAtmFRWoM14HVGMpqA+h/Vlvr6gp+4Q
        i5ytyxiRMVSzJGd8aFNlpPTTlVVWfso=
X-Google-Smtp-Source: ABdhPJwy8290BncgoZBTYoP0gxJrf6+qsG4+sj+FlhAGEgPZ+j+bSEmylz8KSHPMJnv4scvKrDgUSQ==
X-Received: by 2002:a17:906:656:b0:6f4:ebc2:da81 with SMTP id t22-20020a170906065600b006f4ebc2da81mr20440453ejb.757.1652801034455;
        Tue, 17 May 2022 08:23:54 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id hy6-20020a1709068a6600b006f3ef214e70sm1092161ejc.214.2022.05.17.08.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 08:23:53 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nqz3B-001eXE-ET;
        Tue, 17 May 2022 17:23:53 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 0/7] scalar: implement the subcommand "diagnose"
Date:   Tue, 17 May 2022 17:03:27 +0200
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
 <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
Message-ID: <220517.86y1z05gja.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 10 2022, Johannes Schindelin via GitGitGadget wrote:

> Over the course of the years, we developed a sub-command that gathers
> diagnostic data into a .zip file that can then be attached to bug reports.
> This sub-command turned out to be very useful in helping Scalar developers
> identify and fix issues.

I don't mind this as some intermediate step, but re the context of the
plan for scalar "eventually going away" (discussed in previous threads)
I wonder why (especially re the earlier thread upthread at [1]) this
isn't being added to "git bugreport".

Is the plan to integrate this into "git bugreport" eventually?

1. https://lore.kernel.org/git/nycvar.QRO.7.76.6.2202062213030.347@tvgsbejvaqbjf.bet/
