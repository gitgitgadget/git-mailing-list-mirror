Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3B7C433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 02:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AFE364E27
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 02:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhBHCC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 21:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhBHCC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 21:02:27 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975ACC06174A
        for <git@vger.kernel.org>; Sun,  7 Feb 2021 18:01:47 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id 19so2845913qkc.13
        for <git@vger.kernel.org>; Sun, 07 Feb 2021 18:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ddc1tiDa3ex+gION8USppcwUXRFguIkiG32cU6wGRoc=;
        b=bZoC9G9MAXRvpG+0tnFl/G4Bl6gU2Vzq6rO5izjb/G5SQ+O6Mf4ONZvf2Xrpvyvz/5
         Gr8np+WH2WmaJzbPGYTdKOvyKd3XUH0rekKFP44wMZyMmRrSYc1CCYyOo0gyVbB3h7Vj
         haNfMXjw+/XKJiBthmEr4tj05P00WJySjLLR0nEijm9yneKXvAomEOjRcXmAgb3/e+A/
         i9lMLgYw8tUrWkNTSGSWO8OdLpx9pTcR0SvY9y5kUhKdRpnX4kIQ+khNLqjZTx39TeOo
         v1yTUvcJkLYULhyv4BZ/sMIbx2itGDjFY3MyFFrDuw49HrJWezGVn03ewlUv1ZHtmP9R
         zu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ddc1tiDa3ex+gION8USppcwUXRFguIkiG32cU6wGRoc=;
        b=hxZ9R8FrvLnmhoKm8YckltD+eyugwDHGEzpd+afVJFk01zxUT7qFKp72FnLx00QEE+
         G8AiGQYPTTDnOId14KnBBcDj3bFymIiO+r2P5ry0kbHxP4xT3oqFC1CfXl8g6JZWuKd8
         1/No1rG3sRfKBzrcT2chJpCEweFA1FdJ0iapEHlJ1Vyn8ha2XR7QEnQznvYcUFCoLWdI
         ZHUJ+RKR8THWrX7+zVaw95WiOHkD3fnynIC4B9yIOziS3UBKVJz07nmJpE5dCM7bXpRU
         nsAeX/kOnuUgiotEoUoaABep94DrMaHk9Rj0XWz7XoFLDGzaRaotdUK34MXyIjMaEqYf
         qJIw==
X-Gm-Message-State: AOAM531EmhAgH/GyxAOt6062b3PPOaIyachpJPnJthEgMFwQW/OOcHNx
        9QGBx1AkTVv6MBLzIeKYy3zCaZEcEc/RNg==
X-Google-Smtp-Source: ABdhPJzxi3qlYmsbWhk/mLJmAYyx7HcHeOtf8ep77fpubuxl9Cw4VRKMlw1/7tP5+fkUt4Cd5nVIHA==
X-Received: by 2002:a37:9c05:: with SMTP id f5mr14856557qke.189.1612749706782;
        Sun, 07 Feb 2021 18:01:46 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:b91a:dd2f:a591:6ed1? ([2600:1700:e72:80a0:b91a:dd2f:a591:6ed1])
        by smtp.gmail.com with UTF8SMTPSA id r4sm15658458qkf.112.2021.02.07.18.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Feb 2021 18:01:45 -0800 (PST)
Message-ID: <74f1eeab-3211-71e5-c83c-19c0b7c0257d@gmail.com>
Date:   Sun, 7 Feb 2021 21:01:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v2 2/6] commit-graph: always parse before
 commit_graph_data_at()
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        abhishekkumar8222@gmail.com, Taylor Blau <ttaylorr@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
 <pull.850.v2.git.1612234883.gitgitgadget@gmail.com>
 <454b183b9ba502da7f40dc36aaa95cc3d12b5c2f.1612234883.git.gitgitgadget@gmail.com>
 <YBn3fxFe978Up5Ly@google.com>
 <1dab0bf0-9a7f-370a-c807-25d67ac7a0a0@gmail.com>
 <xmqq7dnpewg4.fsf@gitster.c.googlers.com>
 <20210207190415.GB1015009@szeder.dev>
 <xmqqh7mn7i3m.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqh7mn7i3m.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/7/2021 3:12 PM, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
>> Scanning all objects in all packfiles is a very inefficient way to
>> find the commits to be recorded in the commit-graph, and depending on
>> the repository's shape and size can have several times higher runtime
>> and memory footprint.
> 
> But wouldn't it make the resulting graph file not very useful for
> the purpose of say deciding what object to pack when running "gc" or
> "repack" or "prune"?  The fact that it ignores the index and the reflog
> entries as roots of traversal with "--reachable" bothers me.

The reflog _might_ have something of value there, but the hope is
that very few commits are actually being force-pushed away. The focus
is to prioritize the deep history, and it would definitely be an
anti-pattern if the commits in the reflog are so numerous that they
must be tracked by the commit-graph. Of course, skipping the --reachable
option enables a way to gather these commits as necessary.

The index won't have commit oids that matter (yes, for submodules they
will exist, but those are not commits for the super repo).

Thanks,
-Stolee
