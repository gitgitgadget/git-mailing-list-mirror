Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCBDFA3743
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 18:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJaSEP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 14:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiJaSDy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 14:03:54 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DBC13E84
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 11:03:45 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id t25so31450891ejb.8
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 11:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E79iMPt/nXs478w7OPXjGaOhwt/dN6jjXnDrR0eZmRg=;
        b=WdCXRJs98Zk9d/87dhgMXGFQCZ9WvnPXvg39g3n1Q6maCOFzdbmNdL1RqxKX0LOYLB
         Cj5wD8ScDs8ipZlPig2unEXDNd66ZtVeg2/uCwcpgVh4f/cvz4Wqn6d9J0GJ9826+jFH
         7rKZR9m2x3umW+q7f4vdZfatucBGOA3r8CT95NWKldwtT4ONfqFMvLMiLOZoZ98DWkoa
         s2qfj8AA4o+/+J1/0ubAjVx+KuwG60LESWFNTpul1bqHntdlPKtBB3wGsxdk3FhuHi5g
         cqQy8bhVAb/18XMmrdc1WJNJmVxmmr77uWbhSGnXN1Z9J1tvItg6lwW/A0vn0cVtbsUq
         9CRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E79iMPt/nXs478w7OPXjGaOhwt/dN6jjXnDrR0eZmRg=;
        b=dhyLx8uuqFJZrq+SuOy4r/ibLAwI+zQNtsPTg6WrPQ1ybjES4kIEdTNoQhTkAz1LJE
         xQzedcQ3yK17tkKAAnxXCujhPidNPxrDoNigY1z+3T4HFQ+CMeZOlgpO71LzUvnkwrfx
         DhbxVkM7GOTfNzxxgt8G29TPaVc3/1rFSML5k6Ypnm7Qys8Qt2d3LNVDGj0gqR3168re
         58J+aHvru/07uc7aPY6MZchLAzH5MIHOd9ccePNeeyLdZvHLGQQzl6Quhxqe9m+idvZz
         GHEYgHcDjo4oo0Wfq4TYRvgK9ArT0msyRuPNY07gsHwT6R5EzIi123B9iwxI3D4X305P
         BCRw==
X-Gm-Message-State: ACrzQf2Pbz2XmS1pX52Le2iYTbO7Cy/YShU6Xpvld2KxQl7Kpg9VJNpW
        FogKA5qtf1qgbcR2HeC3uFcdqXxFxqE=
X-Google-Smtp-Source: AMsMyM4eFLx+ucFYIUv+1HvarKHAAfA1h+Z+3zLDzfSLunv19cM46Jq7UqR38m5NQM9d7QBMyWBp8w==
X-Received: by 2002:a17:906:3287:b0:78d:8877:d50f with SMTP id 7-20020a170906328700b0078d8877d50fmr14516346ejw.486.1667239423705;
        Mon, 31 Oct 2022 11:03:43 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id qc9-20020a170906d8a900b0078b1ff41f05sm3180048ejb.43.2022.10.31.11.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 11:03:43 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1opZ8Q-00Al1u-2Q;
        Mon, 31 Oct 2022 19:03:42 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>
Subject: C99 -> C11 or C17? (was: [PATCH 3/5] roaring: teach Git to write
 roaring bitmaps)
Date:   Mon, 31 Oct 2022 18:51:04 +0100
References: <pull.1357.git.1663609659.gitgitgadget@gmail.com>
        <4364224f9bddc8f1e40875ebc540b28225317176.1663609659.git.gitgitgadget@gmail.com>
        <xmqqczbdl6wl.fsf@gitster.g>
        <CAPOJW5yxRETdVk014gQYFud9_Nrt+OQGSVNQ8Pw2wDEMMFMm1Q@mail.gmail.com>
        <CAPOJW5z_ZRChNo8PGBmJu=vvjTL2cYL8oTdVwoDRh-UHt2Dy4w@mail.gmail.com>
        <58841dcd-e732-416f-5ab0-fd5a5d8de4c7@github.com>
        <xmqqcza8dlkn.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqcza8dlkn.fsf@gitster.g>
Message-ID: <221031.86cza77tvl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 31 2022, Junio C Hamano wrote:

> Derrick Stolee <derrickstolee@github.com> writes:
>
>> I HAVE OPINIONS! :D
>>
>> Mostly, there are two things I'd like for you to keep in mind:
>
> Nicely summarised.
>
> Stepping back a bit, we do not care about how the sources to some
> pieces of software we depend on, say OpenSSL, match our style guide.
> It is because we do not even have to see them while working on Git,
> but also because we do not have to maintain it.
>
> So a third-option could be to fill pieces missing from the upstream
> (e.g. big endian support) and contribute them back, and after that
> treat them as just one of the external dependencies, just like we
> happen to have a copy of sha1dc code for convenience but have an
> option to use the upstream code as a submodule.
>
> Assuming that such a "they are just one of our external
> dependencies, just like OpenSSL or cURL libraries" happens, I would
> not worry too much about C11, as long as use of roaring bitmaps can
> be made an optional feature that can be disabled at compile time.
> Bitmaps are used only for local optimization and never transferred
> across repositories, so you having only ewah would not prevent you
> from talking with other people with both ewah and roaring.

As an aside: We might think about just requiring C11 or C17 sooner than
later.

For the longest time we couldn't, because of MSVC, but it now supports
it.

Per[1] we've now ended up with a bit of an odd scenario, where on MSCV
we ask to compile with C11, but everywhere else with C99, even though
"everywhere else" is likely to support at least C11 by now.

This is because MSVC doesn't and hasn't ever supported C99, they jumped
straight from C89 to C11/C17 (I'm not certain it was in one go, but
that's my understanding of [1]).

Of course there may be platforms, compilers etc. that have C99 support,
but not C11. So we'd need to tread carefully. I haven't e.g. tested on
the usual older RHEL versions we tend to care about.

1. 7bc341e21b5 (git-compat-util: add a test balloon for C99 support, 2021-12-01)
