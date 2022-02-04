Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6C5C433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 12:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358702AbiBDMYL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 07:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237442AbiBDMYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 07:24:09 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346C8C061714
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 04:24:09 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id s13so18961531ejy.3
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 04:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=cRxV89QmGTrEjO9+gno06L3eLUcmV88V4bxbqSdxTy0=;
        b=B2l5T/HQfkCBHttA986/zmK9URT5Nr3jEbgiCOTMXxJAlT1sK6+Fnusg5pw1lZspsF
         OY15EPmp45VtEZhTSHjsT5I06BgZmgveG0A1mouatpchEloBaBzJV0n4ONDgI4VGxhdt
         1kqqo1dS259R+FZ1RBX3/rhlGm1LIiLER+NGlUEKAUCXRVWvq6OkNFPuK8u2pcddGfsj
         qAjMKIZ5r9fCm3wEugZIKifGKOaPQcapnm9Ei1VLOv+pv2Oxbj/bn5sKwHoxxBQc3Erm
         1+U/WPaS1PS7aA3sbsxbJIMuAc5ONAHQrf1IUYsQNOO7LUSGAF8C3PaztjGpTBexwB3U
         MGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=cRxV89QmGTrEjO9+gno06L3eLUcmV88V4bxbqSdxTy0=;
        b=ZDD7Lqk6EfHcpCS3mMUPWT3lCzMYKwpM/o8mtqRyHbI2BLWhfTS4wfCS5Waut+XIyJ
         POnvoO9fZlIU1dHuQwGsBVuBTlRAbjvhW+30ANGZnB6GEZ/UZ87G91vE4eG8KwREXHLV
         qC7OypaSlRjQeOl8D2kvBqrEkhWI5JEEatxzir3DtXB3Ltmwkd4MCddJIBknZf0S4/pd
         IcpGdssci3fzRpfbl0V3uc38KuGJaAdhIDyWi+KfhCJ33SrCBqsQloy0032lzZCnpTrL
         atsheeQNTkc7gypKm7JR/Ic2B+xrjBRDw57pEMKJF0a+6kyiZsB5Yt2VibAr0Efswb1R
         XycQ==
X-Gm-Message-State: AOAM5338dMGmyxAoX3Nv/YcIgKBco/kl/hNjBRHfJYXPlxPUgowwkwpK
        0Ny56aJotYcRRHLvnrmWbvE=
X-Google-Smtp-Source: ABdhPJyrUnukyGGCFWaS3bYFbqtHLCsvXSa3pFYvZyxgxNl5Y6qc76EIhniv1SIekNjXO8/PU+WRPg==
X-Received: by 2002:a17:907:6e1a:: with SMTP id sd26mr2227820ejc.270.1643977447628;
        Fri, 04 Feb 2022 04:24:07 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bf21sm803995edb.2.2022.02.04.04.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 04:24:07 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFxdG-00643k-8V;
        Fri, 04 Feb 2022 13:24:06 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Robin Jarry <robin.jarry@6wind.com>
Subject: rj/receive-pack-abort-upon-disconnect (was: What's cooking in
 git.git (Feb 2022, #01; Thu, 3))
Date:   Fri, 04 Feb 2022 13:23:15 +0100
References: <xmqqr18jnr2t.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqr18jnr2t.fsf@gitster.g>
Message-ID: <220204.86r18i3jmh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 03 2022, Junio C Hamano wrote:

> * rj/receive-pack-abort-upon-disconnect (2022-01-28) 1 commit
>  - receive-pack: check if client is alive before completing the push
>
>  "git push" may be killed by the user when the server side has
>  finished receiving all data and is about to commit the result.
>  Give the latter a better chance to notice such situation and abort
>  processing the ref updates.
>
>  Will merge to 'next'?
>  source: <20220128194811.3396281-1-robin.jarry@6wind.com>

I had some comments on the goals & possible bug/incompleteness just now:
https://lore.kernel.org/git/220204.864k5e4yvf.gmgdl@evledraar.gmail.com/
