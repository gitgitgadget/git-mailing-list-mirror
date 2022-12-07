Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0942BC63703
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 23:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiLGXtb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 18:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiLGXta (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 18:49:30 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9A567210
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 15:49:29 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id d20so55031edn.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 15:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rGz+N63L6v1MyzUIUxEHsq1VnXL1EAAErIdm+BqWP8w=;
        b=W2CF1lcE0WFLUIXv/Vy9mwLKSTSSqpeuJfY3iiah+jhXg/rSrClEEkrDjL8jZplm+7
         K5/Vuf3E5mCkecolavNSqX4pP6CfXd7dPw7IY9yl083ZHWSAWjXqig6/X8lR1ZzuuZ6p
         hjV15vpjqAY6hr4GhvA49/BvPCVlaLRYRDUfMA9+OdARPr4OrOI1gWKVS/Vx8+oMEbyy
         bIUDAk8k2xpZbhtEZjiWeZAU9v4aTNz6PRUsWRJzz3SgBgagdgDQwdnIGjisnBsXl6cT
         Zm/3NNf3MXZdIDpp1k0SxDf7/lmRuN8pJL6QyaIATcqorzFj7mM3CCeuMlZ9GNSE2liZ
         QjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGz+N63L6v1MyzUIUxEHsq1VnXL1EAAErIdm+BqWP8w=;
        b=x+XcgtekUOoBrjzTrGvuhiRUUiu5eKwvS5EMuI6PvlhZUWcxS68BOqvH1Co8pk0RtF
         KvPeBIMMCEieb/9nkvj/5x13uC8h4jbkpasLBtKzwmEp2P0nMtdXd7FRQPfr2qbnVZEV
         RdmvDevl3lr2vEh0Zknu9StQTVQoPZB1J8h0e5OQrPcTm5J2D2pxvLQ7u29iV9FYBGuB
         oD3nkNxLEWxRmwYPy2E9oqwaWF6SGZHEzazz3plxyw9qAgm6pH+em/zQNbn9lPVuTptV
         qPvdPh68Kt3RP3VbQc/dcrV/Lll9Tm+k/TuPKa9xQUJHJvzUY/xNTeX5oP9/XABM2vMq
         5fow==
X-Gm-Message-State: ANoB5pnxor4izvzbeFeINf8SHZ0sFlnEnMZv396x5C2URRJ+pzbz5MCn
        YOTt6FP2qIqBdljiLidT3XM=
X-Google-Smtp-Source: AA0mqf4S0zQScRIoQlwHKXWk9cp1RIXdPqBdaoxu+BFai27gf03nCQR7ZV6jYZnL2WTyxSniYtBJ6w==
X-Received: by 2002:a05:6402:5011:b0:469:ee22:d97a with SMTP id p17-20020a056402501100b00469ee22d97amr1196156eda.32.1670456967956;
        Wed, 07 Dec 2022 15:49:27 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id i26-20020aa7dd1a000000b0045c47b2a800sm2742294edv.67.2022.12.07.15.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 15:49:27 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p34AI-004hxl-35;
        Thu, 08 Dec 2022 00:49:26 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com, newren@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/4] Optionally skip hashing index on write
Date:   Thu, 08 Dec 2022 00:42:30 +0100
References: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
 <xmqqilim6bhh.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqilim6bhh.fsf@gitster.g>
Message-ID: <221208.86ilim93ll.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 08 2022, Junio C Hamano wrote:

> Protecting files from bit flipping filesystem corruption is a
> different matter.  Folks at hosting sites like GitHub would know how
> often they detect object corruption (I presume they do not have to
> deal with the index file on the server end that often, but loose and
> pack object files have the trailing checksums the same way) thanks
> to the trailing checksum, and what the consequences are if we lost
> that safety (I am guessing it would be minimum, though).

I don't think this checksum does much for us in practice, but just on
this point in general: Extrapolating results at <hosting site> when it
comes to making general decisions about git's data safety isn't a good
idea.

I don't know about GitHub's hardware, but servers almost universally use
ECC ram, and tend to use things like error-correcting filesystem RAID
etc.

Data in that area is really interesting when it comes to running git in
that sort of setup, but it really shouldn't be extrapolated to git's
userbase in general.

A lot of those users will be using cheap memory and/or storage devices
without any error correction.

They're also likely to stress our reliability guarantees in other ways,
e.g. yanking their power cord (or equivalent), which a server typically
won't need to deal with.
