Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C671C433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 12:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358779AbiBDM16 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 07:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358595AbiBDM15 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 07:27:57 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C846C061714
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 04:27:57 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ka4so18858942ejc.11
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 04:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=6IzDVgmrb0AgIX5WIgQIqz8BQQFeCch5fPYYyRSCFpI=;
        b=W3QQCU01jHB+BCXFSSK+75qmNVINksRaGDjpUYm+t6+Y8C+9mQcBLpCAGPXiLAd36r
         Ssgox7E7DO5vMR6PS/+eyJ5TMCnkz0vsLYQEuNdnGRMAaKoFO0voBeSOU50Ma9FRZNgt
         +5vtb8bKVMxUmKCYqGzaPKW09O6qt1+q3cIhPr5WWl3/yjBF2eiSLNsC4IokF9YqJfp5
         P73ReL1WhjdzudkSUwz5q1YWFPeRIyC7X5JKu2BQwSsxZ+xEo7lv+YNb4q5XSUPjPkxM
         61Ft2ThL8c0PFPWoV0ockHQ1DwumeKB1vm/cLY/S/o1sDF1x0KllW3D2AcOu2ZzTdH2f
         eP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=6IzDVgmrb0AgIX5WIgQIqz8BQQFeCch5fPYYyRSCFpI=;
        b=usS5yiudhVHWTDLPmWTDnlx+3xLFxeCnFuxHp4w392yMiwiOcDj/QqZgeWYxBKPBeN
         k6D8urWNMaYU5M6e8LVxhOG/gzzGr3EhULP6bBqlMjcnwS/s2f7klpXJfDos6O7rIzSR
         Z2EylVThjOpb+oXOr5IJY7K3QR6hUHDZVG1StCAEn2oMv5jjGBZQEfhiRU2bcb05PeO2
         bW5sPlkNZkzq1x9RTHWYFAw+lMvYzhno29FIi9mk9vNjgUdx9kV28xDMxWxM0P+hsF8T
         +vY6OaWJGCSO+03Ob2/PhJ5ZkcofUZwSAqjR76f6PInSjziVdY8qXD7LR4pihe/RO5vd
         +Giw==
X-Gm-Message-State: AOAM530T70h1qrKJSYsLqm3G+MlKVd35qUPTQBvNU24VnunN2sq0GjSZ
        1l7UENegrEC3N/owjYe+tjs=
X-Google-Smtp-Source: ABdhPJyqSmbXpBnr7+Czj/1ogeitpTnZ41h+Qt0AveG2YvHH4XwObAqhPCYleewBHHACd/degpqW8Q==
X-Received: by 2002:a17:907:9716:: with SMTP id jg22mr2347692ejc.378.1643977676098;
        Fri, 04 Feb 2022 04:27:56 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id jt17sm602722ejb.161.2022.02.04.04.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 04:27:55 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFxgw-0064ET-Us;
        Fri, 04 Feb 2022 13:27:54 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Chen BoJun <bojun.cbj@gmail.com>,
        Robin Jarry <robin.jarry@6wind.com>
Subject: cb/clear-quarantine-early-on-all-ref-update-errors (was: What's
 cooking in git.git (Feb 2022, #01; Thu, 3))
Date:   Fri, 04 Feb 2022 13:25:26 +0100
References: <xmqqr18jnr2t.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqr18jnr2t.fsf@gitster.g>
Message-ID: <220204.86mtj63jg5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 03 2022, Junio C Hamano wrote:

> * cb/clear-quarantine-early-on-all-ref-update-errors (2022-02-01) 1 commit
>  - receive-pack: purge temporary data if no command is ready to run
>
>  Check if "receive-pack" will do any ref updates (various conditions
>  could reject a push) before received objects are taken out of the
>  temporary directory used for quarantine purposes, so that a push
>  that is known-to-fail will not leave crufts that a future "gc"
>  needs to clean up.
>
>  Will merge to 'next'?
>  source: <20220129063538.24038-1-bojun.cbj@gmail.com>

Ah, I see it's even in the same function as
rj/receive-pack-abort-upon-disconnect. That's a very well reasoned &
sensible isolated change. I think it's ready for "next".
