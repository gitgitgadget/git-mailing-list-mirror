Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88138C433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 06:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EE786102A
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 06:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237510AbhDSG64 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 02:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbhDSG6z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 02:58:55 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521DBC06174A
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 23:58:24 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s22so2486695pgk.6
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 23:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Yuq9h9EIUsfqlBX8jkZrrDlLrJepfh0olU1Mez0uagk=;
        b=VlGigfnXdSIgNpig1+/ZyWk5Pr0ZbSfMHIKRSctS/XH1kKDWVLnGoWLh2YI4wE4+EF
         PteQQXrf7tqg0weFCNAzsoFzUYEtCXqICbHEPSrM5TKUbN5vuOUTnFtk8TmX41HncFl9
         Puwv9xVpoIShEoeHTyRp31SXwRlTHPIbYLeU5FYdSeUt53PRc54vlvXrgUctzQgEENg8
         LjaZyggXCXksNPDez+bjAZewDoJumv0DSLBKkEpb8847Wy/i4JkGj7b9SABm7LRxWlfa
         AiCO5nCEcO/pSmIj2kQJKeZgbYvGRPWzpt6QB1+lEUpKdAE+L1xHZRKMclN+dPFG43Os
         KekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yuq9h9EIUsfqlBX8jkZrrDlLrJepfh0olU1Mez0uagk=;
        b=s1BdXVcTdJZwx993EMEG1bHOXQVjbkdSwuCOc9p8ZF2jJlbxR+FkenVzhIEwQtIgEZ
         WYaT0CgjFuhD6tMZQTEqbIR5ZAoVC9Qn8UurxTCHb9zaG1UNGflHBFJXpVWCAfeUUlwX
         +l+8kq3z9ttqBM4qccl8HpYYwJicGHo+EQ58WSRjUL8VQgFLJGUIJ3uH/FG9uCrtcPUv
         +e+LtqxT3eIpMeWqsTCdV7SSdhNulFtLbBZQa946sOY4GgsFp/DnIASjeRxgC6n7VX1J
         cH0rWgN47vZLCVRWffbO9Izu8+icvGi9XzsVWL/oFfDV7GVTifL52Zzzg3YMbKM1Lao4
         iXdg==
X-Gm-Message-State: AOAM531YtFEg/LARxIcLIoEb6aMuK4HR6A3So29d+Y+K3gW8gU1lK+rb
        7znhcb/cCR/8rtqXZZy2IBw=
X-Google-Smtp-Source: ABdhPJx63Ns0Q9HFfCwYzpomPRC3xv1OxCbXiatABCGlFgnJiXpbLdosDdu1DOBCxbKiEA7E1Y+GmA==
X-Received: by 2002:a05:6a00:23c2:b029:24c:4748:4a80 with SMTP id g2-20020a056a0023c2b029024c47484a80mr18679276pfc.13.1618815503873;
        Sun, 18 Apr 2021 23:58:23 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-18.three.co.id. [116.206.28.18])
        by smtp.gmail.com with ESMTPSA id x83sm6147586pfc.219.2021.04.18.23.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Apr 2021 23:58:23 -0700 (PDT)
Subject: Re: Using --term-* with bisect breaks skip
To:     Trygve Aaberge <trygveaa@gmail.com>
References: <20210418151459.GC10839@aaberge.net>
Cc:     Git Users <git@vger.kernel.org>, Miriam Rubio <mirucam@gmail.com>,
        Jeff King <peff@peff.net>,
        Pranit Bauva <pranit.bauva@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <c29ef929-4744-a498-540d-1b7df0afa0a0@gmail.com>
Date:   Mon, 19 Apr 2021 13:58:20 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210418151459.GC10839@aaberge.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/04/21 22.14, Trygve Aaberge wrote:
> What's different between what you expected and what actually happened?
> After running bisect skip, HEAD was still at the same commit as before,
> instead of having changed to a new that I can test. The usual output about
> steps left to test and the new commit was also missing, skip did not output
> anything.
I can reproduce the issue, thanks.
> Anything else you want to add:
> - If I don't provide any --term-* options, skip works as expected.
The issue still persists without --term-* options on my computer.

To reproduce in git.git:
   1. git bisect start
   2. git bisect new v2.31.0
   3. git bisect old v2.30.0
   4. git bisect skip

[CC] I'd CCed Miriam and Pranit (who submitted git-bisect in C) and Jeff
for the issue.

-- 
An old man doll... just what I always wanted! - Clara
