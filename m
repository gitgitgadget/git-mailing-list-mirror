Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F9DC433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 18:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344574AbiEZSrX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 14:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344615AbiEZSrU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 14:47:20 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EC52E6B0
        for <git@vger.kernel.org>; Thu, 26 May 2022 11:47:19 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gh17so4666307ejc.6
        for <git@vger.kernel.org>; Thu, 26 May 2022 11:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=MpBuzbheQiajUL6Fx+vHgFeJrFFwixNdIdFThYpj7uU=;
        b=MK7ohuKSC9Ti/2zR4aofUOYxXQZiwd7I1hnn3b+goTvD4jpwNMngFJaf1ky2cef9Yu
         fIFQrHVc71xmP+7eg0ETZ2sgYXS53y6QDz78n0/7+90b2liqFeRgdt+sTCSOkEkUNdVR
         gO4G5wtO42dHqmbTRu+qM5V84J7MgemFVKZd6kFAq5N55j6qwwRBKGdeN/zGZXA5GDVB
         wkIIro0CqXC4c3B7rHf4v1uJR4b6rxtQ7dvwO91chpdbVNwxaeODeMEiE2H8YvlqNYwM
         Is2L8u3LuM9PRbf1m/tR7+FTQ7TRLBwHAjruGfcVU7RRho64BIwJ78BJ7hoBdzkHXDsB
         RoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=MpBuzbheQiajUL6Fx+vHgFeJrFFwixNdIdFThYpj7uU=;
        b=d5ovZVz57dg9CZgoS8hawLUGJmMp0el2EggBsL6v4xZhuvJfTwc0V+2cTx6ml8VZLV
         PNW2XYr+9skOufbu1lz1bbcaVQ5MWVmH/N9yjgDQNmxpjQ6kaLarURaPxJEZZHeVWlib
         AQsMhdYnXdyNOStCw47YOa9JjZyEXGmVd+t8cOsSLMFNkfa/NeMfmQ9UchS36lYUEOlY
         SOtTCJzFC4Q9k8g0mz+6mchR0ohi2lScPDlq4jXaQJimvu4ehlVykQ6baCgurpXVYQJ8
         wklVjsKIdt5beCIDXRkPTUAWjvuRZNCFLpepLMgIKRrU5gvrNq35fKqWb31Cxl1jHfNY
         AiRA==
X-Gm-Message-State: AOAM532+cRosskWcX/K2wCeHPJX6rImamYc9nATVbn/OVPebm33Sb/pB
        oXiT1ncC71tqRkNnwXVoSxE=
X-Google-Smtp-Source: ABdhPJxyVxf9bPC61nCEEeufWKnoHxqNqHg4SDto6hhW7jWwL5CVk8FqS29pgvEn289P3nTYXAUHEg==
X-Received: by 2002:a17:906:9c82:b0:6df:baa2:9f75 with SMTP id fj2-20020a1709069c8200b006dfbaa29f75mr34799240ejc.762.1653590837640;
        Thu, 26 May 2022 11:47:17 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id z73-20020a509e4f000000b0042aa23fa93bsm1098650ede.20.2022.05.26.11.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 11:47:17 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nuIVw-000FZJ-NE;
        Thu, 26 May 2022 20:47:16 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: What's cooking in git.git (May 2022, #07; Wed, 25)
Date:   Thu, 26 May 2022 20:40:30 +0200
References: <xmqqzgj41ya2.fsf@gitster.g>
        <df44b0cd-bba7-19f0-4e45-c0988239cc4d@github.com>
        <xmqq4k1c1a34.fsf@gitster.g>
        <8b57f907-3db1-9fe1-d582-e2d05acbe5ce@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <8b57f907-3db1-9fe1-d582-e2d05acbe5ce@github.com>
Message-ID: <220526.864k1c5dxn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 26 2022, Victoria Dye wrote:

> I'm not sure 'ab/ci-setup-simplify' would need to "die", more that it
> would be adjusted to rebase on top of an updated 'next' (including
> 'js/ci-github-workflow-markup'). That said, a re-sent version focusing
> on its own optimizations/improvements (rather than a comparisons
> against an IMO largely unrelated series) would almost certainly
> benefit both the series and[...]

We probably just crossed E-Mails, but it would be good to know if your
assessment that they're "largely unrelated" is before or after seeing
the numbers I noted at
https://lore.kernel.org/git/220526.86leuo5f2g.gmgdl@evledraar.gmail.com/

I.e. that it improves the performance of js/ci-github-workflow-markup by
~20%. That's the reason I originally looked at combining the two,
because that series was doing a lot of work to re-implement features we
could get "natively" in the GitHub CI if we just split certain things by
steps, instead of dividing those same things with the "group" output.

There's a few other things where they combine
nicely. E.g. js/ci-github-workflow-markup contains its own mini-version
re-invention of ci/print-test-failures.sh, in the combined version it
can just use that (adjusted) script to get the same output.
