Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC664C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7B9F61287
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhELNEs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 09:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbhELNEl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 09:04:41 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03542C061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 06:03:31 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id f184so1969952oig.3
        for <git@vger.kernel.org>; Wed, 12 May 2021 06:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=at1YuYZsQBUFmqJiQfWD2kClxHwek7K8/o0vhWS9Zmo=;
        b=AY4jyDjzWQjqEtyutRXea0f9Hi4HYQYDJdUxCeig88Lpc4QI/MROeVrIhBO7P1wnpV
         mv8VJAn+WD2JI4Ynhu/+CZ6IkEdDsgL++xN+FoTxbIzt6uTvIhZ2Xbcv546Y1SBXop3b
         OpOUX1Csbjx0CrNi9FYFZl3iz3alPUaFhBPsNkESG0aEsf3aIsdMW0mMFColQsUh1gyG
         Wy0cF/xOjaNkBw0uiTCMyR0gBo0PezNWXGo7wxZKvZcdj0OrGf4nW+CObUMeF61t/vaH
         H0Xhp5P6zCQ9JpM10llDPTRm1B+n/U46ol7HMVr+wXK683R4cS7b2owYoNK98DPmgLNk
         aWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=at1YuYZsQBUFmqJiQfWD2kClxHwek7K8/o0vhWS9Zmo=;
        b=Cz3YwJe+o6HvoaRc27/pdnMPn6jx+TzM4kHQWXkz5Kx6oiqVPQgZQy5zmVdjFJePfq
         v5nU84LAezqlO1qUWfYvs/loQSnfzRrnbj04got83CLBfgBevFtxGPrWy0Db/yGRBvKL
         EPfQ3nYpcY38TRZYuZY0TB2jlGlEAUkurIIoF+NnOYuhANszVIGT2Lfns+E005NycLCq
         bC1VcWnkb5SmYwl2omkqkDwR4RBEpFGC5CDQJChawf1CQXQVJpvi5MUDduLrQLAlThki
         r3aNtc9/xuLkm5Fsm+gPED5T34FT5yNP/7I36QurvzmltTs4Q52UK9PJ8hFPphDix9he
         JhlA==
X-Gm-Message-State: AOAM533B4TTbJiAW9EAI72hcQ2SB/WDNporDflvDmM1QxZWpVRczRMIe
        pz2ji7DKZ8UyQonf6rj4wHpN9asDVL8Dpg==
X-Google-Smtp-Source: ABdhPJxapAw9Ztri3QM2Zwj8zPfw6b/gfN+6fkOl8+knIfoaZZYT9H3bJ7FY/IJpmVW8byQ0wi3ymw==
X-Received: by 2002:aca:b5c4:: with SMTP id e187mr26481519oif.149.1620824610047;
        Wed, 12 May 2021 06:03:30 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:49c7:8eaa:aef9:ce4b? ([2600:1700:e72:80a0:49c7:8eaa:aef9:ce4b])
        by smtp.gmail.com with ESMTPSA id e7sm2488570oos.15.2021.05.12.06.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 06:03:29 -0700 (PDT)
Subject: Re: What's cooking in git.git (May 2021, #02; Wed, 12)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqo8dgfl8l.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <05932ebc-04ac-b3c5-a460-5d37d8604fd9@gmail.com>
Date:   Wed, 12 May 2021 09:03:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <xmqqo8dgfl8l.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/12/2021 3:46 AM, Junio C Hamano wrote:

> * ds/status-with-sparse-index (2021-04-28) 10 commits
>  - fsmonitor: test with sparse index
>  - status: use sparse-index throughout
>  - status: skip sparse-checkout percentage with sparse-index
>  - dir.c: accept a directory as part of cone-mode patterns
>  - unpack-trees: stop recursing into sparse directories
>  - unpack-trees: compare sparse directories correctly
>  - unpack-trees: preserve cache_bottom
>  - t1092: add tests for status/add and sparse files
>  - Merge branch 'mt/add-rm-in-sparse-checkout' into ds/status-with-sparse-index
>  - Merge branch 'ds/sparse-index-protections' into ds/status-with-sparse-index
> 
>  "git status" codepath learned to work with sparsely populated index
>  without hydrating it fully.
> 
>  What's the status of this thing?

There has been no review on the simplified v2. But also I've been working
to integrate the sparse-index work into our Scalar functional tests and
have found some issues with the series. I'm working through those issues
now and will send a v3 when I'm ready. Feel free to eject it until then.

Thanks,
-Stolee
