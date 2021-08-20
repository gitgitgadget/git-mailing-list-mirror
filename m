Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E001C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 14:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA45461102
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 14:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240921AbhHTOvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 10:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240879AbhHTOvK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 10:51:10 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEDFC061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 07:50:32 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id l24so7656540qtj.4
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 07:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=04WcK7hjDuzm6EgD1Fv11UE4led2akAdZIqSjlI7xYc=;
        b=joeqpog98ruPsLZNRd8MV3RFHotOqqKV3nD3HnwGDM0eygRI1BuqsOnOiSZDDy6Uyp
         L1nV1Fjpf9Jdpj2nPC+qTC+MuANgyoMZvidYrt+ljbj9WuNy9wUdQEFMeqsQ8J2HNBAw
         /5C85YrXeR6EvOVkTBp/EisonSBw0AqyPwlyO2y3sVD4UNTi4zYlLMRUsCwU8WvLZFw3
         5/wiqT0qaXiK0fHF/P48Xl4WPFWMDk/ocKqUMOaK+MIhpU9hmjOHoTvh+8T8hJWZTe/W
         AqPEFgJ2Reico7QoWi+n1QoaFOLO4QKlXmrFztTiU/DcaOweNdXDkwtqWaOpVWWNrU6a
         KuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=04WcK7hjDuzm6EgD1Fv11UE4led2akAdZIqSjlI7xYc=;
        b=umGS12FjBY8Ttmt0hsGsaC+7vj0XogvOKjENfNEaryNLzWhCEY8/gsS77yN9+62/OX
         SaM4RJEGe/wH2lCS3MmRbFtR3tyHgMLciElew3DpMFvXvQwnz1HRcxoC2FcfyS7xIZxx
         074NPO6IX5lnCsGgMG3G9P5P2/KibpUakyUWtbcldY7BGYRmbK0Afsf+MvZ+JRF3dATR
         A3i5Zm5KZ9u5gFgqctgaQKq6qBocxXKZsV1T53WXCWZDQVYFXF91I5bYMDrsP4/eQT17
         MC2kWMCbiUJ0cj4xujlatjenuvIdACfhBwlGuoDmPcqqIs3U4hc8R7JTYxm7iub2LUey
         CpbQ==
X-Gm-Message-State: AOAM530wDRgA63UGubnARrxj8aQfGpgVXoS88y74MxfKYfwm3z7VcLwP
        4yvICPTrdNDZOSb02+skqqk=
X-Google-Smtp-Source: ABdhPJwqi+ed1OoWkRKX/0zQk5wkvo9fy8IWFncbH8wTD6PW/CSMjjxqHKhoLQyDPnBzMy1bfxjopw==
X-Received: by 2002:ac8:4c89:: with SMTP id j9mr3954663qtv.78.1629471031342;
        Fri, 20 Aug 2021 07:50:31 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:f436:fc6f:2dd3:d49? ([2600:1700:e72:80a0:f436:fc6f:2dd3:d49])
        by smtp.gmail.com with ESMTPSA id o10sm2582823qtv.31.2021.08.20.07.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 07:50:30 -0700 (PDT)
Subject: Re: [PATCH 0/6] Speed up mirror-fetches with many refs
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <cover.1629452412.git.ps@pks.im>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <857d18a1-97b2-b7a6-64d4-4b31daf79e64@gmail.com>
Date:   Fri, 20 Aug 2021 10:50:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <cover.1629452412.git.ps@pks.im>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/20/2021 6:08 AM, Patrick Steinhardt wrote:
...
> As it turns out, many of the issues are again caused by loading and
> dereferencing refs. This patch series thus mostly focusses on optimizing
> the patterns there, where the biggest win is to opportunistically load
> refs via commit-graphs.

You caught my attention at "commit-graph" and I found your use of them
to be interesting. You strike a balance in checking the commit-graph
when it is likely to be helpful, and skip the commit-graph when it is
not. (For example, PATCH 2 is unlikely to benefit from checking the
commit-graph at that point, because we are looking for objects that
were just downloaded.)

I read all the patches and checked the full context of the functions
to see if there were any issues, but found none. My only comments are
about the case of many annotated tags (do we slow down?) and some
nitpicks.

Thanks,
-Stolee
