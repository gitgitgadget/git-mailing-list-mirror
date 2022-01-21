Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3319C433FE
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 12:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350406AbiAUMGl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 07:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380310AbiAUMGc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 07:06:32 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C62CC061574
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 04:06:32 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id f21so42127618eds.11
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 04:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=NH0l6Bs6r/cIN3xOk2N4GJwfJ+3VgDpBFMlNxPz6W2c=;
        b=bYo244vOg0HsITt517cwVRdN5wiGNFVl4fovQ/4GBhtFtfRSHSQF1gagujJyrcOL6R
         XhXDEcMad/a2e2YRD2JYbsaFwCep0AlAD8gGfUIp3jrMjtKt7IeqIZcY5G/Jq4sfjWOQ
         wA/gPgt8HqS/X2stC9QOBXJTg1Oq4XKbKpYsLTh7u6Q7uJaNB5Y1lMO351qBpAOb9/d2
         Ai8OKFLOy97qPzWbLYsexT884MeYTS1UljbOsg/FONuzAScSxUBmzCueivLYH/pmOj8Z
         Ze/KEe6KkAei9PX2l4FLd0ZEMJI9GcAoTsZIK/3gXSM/EY+0jJAWw47AZVWBjOTjDffF
         5DYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=NH0l6Bs6r/cIN3xOk2N4GJwfJ+3VgDpBFMlNxPz6W2c=;
        b=yjKF7hu7mcLcJLCIiRFwWKyzTA+SIYMO/OoWnff6lDLhDDyiFsXyBCARL28PU9UNUt
         mRExRPZn2V/9gmc9dAlZjJ47bpv1hPq1SvyHoVVpArD0FAxPF4uUO11h+wtmTcaP0wsU
         NlXBGqgGvaHGFJlACUhMKOHWYXGWCjRLo59WqSn67MRxkUO1LbqGSQEtV6drJBb7Oed9
         Vi/UHnXlqaRPRMniuJ4QhMOxk5cwraVM+y4UqKxFBU9Yb+CYpEi7jzGohJHNx81xp/gm
         Zl92XsQx94zwTEwzIuGkIDQdz4IJDpBYGgu5w+snygmxnxSRknwNC50jF8mtLd2tbiUU
         ksQA==
X-Gm-Message-State: AOAM5323zNc/dEA77fTq6o2XnlPeQl6YJhBdl6J4+JmefH8/a0Pa3ooQ
        rlEZw7ayV6gmJsP192KCW1WhtNakfkJonA==
X-Google-Smtp-Source: ABdhPJxnWFTbifGgR7zmnf3XSjx9wVOWH90sdMQwI0izUJKDp+bR9rz53KvzeFBm1/dQIMZv/NlfbQ==
X-Received: by 2002:a17:906:f01:: with SMTP id z1mr3102726eji.346.1642766790334;
        Fri, 21 Jan 2022 04:06:30 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l3sm2000835ejg.44.2022.01.21.04.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 04:06:29 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nAsgX-00281i-Ab;
        Fri, 21 Jan 2022 13:06:29 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v6 13/15] reftable: remove outdated file reftable.c
Date:   Fri, 21 Jan 2022 13:05:43 +0100
References: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
 <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
 <69c4a55488209f96ae605047ecd1709678518fa5.1642691534.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <69c4a55488209f96ae605047ecd1709678518fa5.1642691534.git.gitgitgadget@gmail.com>
Message-ID: <220121.86k0etjnsq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 20 2022, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> This was renamed to generic.c, but the origin was never removed

I thought "hrm, didn't I have a way to assert this?" before I remembered
that yes, we could use $(wildcard) in the Makefile to avoid this class
of problem in the future:
https://lore.kernel.org/git/220121.86o845jnvv.gmgdl@evledraar.gmail.com/

Just food for thought :) The change itself LGTM.
