Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B574C77B61
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 18:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbjDYSGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 14:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbjDYSGa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 14:06:30 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCF4449E
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 11:06:27 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6a5f852002dso4203065a34.3
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 11:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1682445987; x=1685037987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wAaZvjz54YwJoBM1mmDsJ5XJlRJ1vA3yg7tC+J1Lwl0=;
        b=WBWvwU4GHvvrwniKCSslCa3xvAlf+fJHKcdDikMjlSO8nJzlINSfhUAxfAGIRRCZs7
         DWnGmBVkX4ukP2D2i1U9MezfCr4RTw0XoMvvuGsxpvA2/SksqO3GXB3uuG+RdbjaeWMW
         Ffn5JbRzKkU/QvHOCbJFWpzQC0hrXmSJpdoj4CjcrW8wO7fKAcMLBI61XhhJoGzszAYj
         dA+iXtWovzJqPKs+UiuboRPIS8vP6a2K/Tkzpn7fxOC/vfC6x1A1gyne2vFKRAmiQdSO
         hzeirsNVQEP+1QSeJtib90eu4EFlOsR3Iy41/kU3w2Au0Lhfh1/C4N0y0FeurOL5eFGD
         3mHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682445987; x=1685037987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wAaZvjz54YwJoBM1mmDsJ5XJlRJ1vA3yg7tC+J1Lwl0=;
        b=Ks2IjwGCAtzqvRcerpiHImyGwPpxTZlK0WdvyvPIuys0ImrG0IE1t53S4jAsudxmWr
         dEo2Qid8CNgf26KtcOLY6XAx6yk5bl/S1DB4dTk8GoiW62Uhu5RVC4xfFYysrZfQbjZx
         FM+ertWsiG4hnlFBtRFxjD8dURywTx6m+im1DwVp1lVInXXuICU3IemNJ1evJzxU8TbS
         NaeLID49fnuToPAQThd6sfb0amrexqsGJ/RZqX+86YSwQBtjctB5wGf+Df2xEsDASYpg
         XZER38HRJFiMeMJ5p6E8eY97m5Z4gsoM5dgsdGFidzdImFLhKFfosMM+LcvDkaFOZ8Um
         Q6Rw==
X-Gm-Message-State: AAQBX9cQYCdf5Jl5g7FFAHOAywIG4k3b/s/N44LYZu6hxAtQrkqpashf
        vZ/1zjswvizABbGFMvshQR43y46rQCfbHmsPqQ==
X-Google-Smtp-Source: AKy350Yi49fvENXRKFSlq0OypFDpnSilVWx/KgEddmWpVT+BWpeSRkdXntVc6G48WznoFtdyySLNcQ==
X-Received: by 2002:a05:6870:a406:b0:17f:cf1f:9d8f with SMTP id m6-20020a056870a40600b0017fcf1f9d8fmr11601292oal.8.1682445987182;
        Tue, 25 Apr 2023 11:06:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9117:8293:39bd:7100? ([2600:1700:e72:80a0:9117:8293:39bd:7100])
        by smtp.gmail.com with ESMTPSA id r3-20020a056870734300b0017ad7a5f57dsm650256oal.11.2023.04.25.11.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 11:06:26 -0700 (PDT)
Message-ID: <f25c6234-83c0-fa49-85f5-9005e312b8a3@github.com>
Date:   Tue, 25 Apr 2023 14:06:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/3] pack-bitmap: boundary-based bitmap traversal
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <cover.1682380788.git.me@ttaylorr.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <cover.1682380788.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/24/2023 8:00 PM, Taylor Blau wrote:
> Here is a short (but dense) series that I worked on towards the end of
> 2021 with Peff.
> 
> Its goal is to improve the bitmap traversal we implement in
> prepare_bitmap_walk(). Specifically, it avoids building up a complete
> bitmap of the "haves" side, and instead uses a combination of (a)
> UNINTERESTING commits between the tips and boundary, and (b) the
> boundary itself.
> 
> The gory details are laid out in 3/3, but the high-level overview of the
> new algorithm to compute the set of objects between "haves" and "wants"
> using bitmaps is:
> 
>   1. Build a (partial) bitmap of the haves side by first OR-ing any
>      bitmap(s) that already exist for UNINTERESTING commits between the
>      haves and the boundary.
> 
>   2. For each commit along the boundary, add it as a fill-in traversal
>      tip (where the traversal terminates once an existing bitmap is
>      found), and perform fill-in traversal.
> 
>   3. Build up a complete bitmap of the wants side as usual, stopping any
>      time we intersect the (partial) haves side.

In other words: this generates something closer to the object set in the
non-bitmapped object walk. The only difference is that the new bitmapped
algorithm will see objects that were re-introduced across the boundary
(say, a blob was reverted to its older mode).
 
> This improves many cases where using bitmaps was significantly *slower*
> than regular, non-bitmap traversal. In some instances, using bitmaps is
> still slower than the non-bitmap case, but it is a substantial
> improvement over the classic bitmap walk.> 
>     $ ours="$(git branch --show-current)"
>       argv="--count --objects $ours --not --exclude=$ours --branches"
>       hyperfine \
>         -n 'no bitmaps' "git.compile rev-list $argv" \
>         -n 'existing bitmap traversal' "git rev-list --use-bitmap-index $argv" \
>         -n 'this commit' "git.compile rev-list --use-bitmap-index $argv"
>     Benchmark 1: no bitmaps
>       Time (mean ± σ):      15.1 ms ±   4.1 ms    [User: 8.1 ms, System: 6.9 ms]
>       Range (min … max):     7.4 ms …  21.8 ms    131 runs
> 
>     Benchmark 2: existing bitmap traversal
>       Time (mean ± σ):      82.6 ms ±   9.2 ms    [User: 63.6 ms, System: 19.0 ms]
>       Range (min … max):    73.8 ms … 105.4 ms    28 runs
> 
>     Benchmark 3: this commit
>       Time (mean ± σ):      19.8 ms ±   3.1 ms    [User: 13.0 ms, System: 6.8 ms]
>       Range (min … max):    17.7 ms …  38.6 ms    158 runs
> 
>     Summary
>       'no bitmaps' ran
>         1.31 ± 0.41 times faster than 'this commit'
>         5.49 ± 1.62 times faster than 'existing bitmap traversal'
> 
> In a large repository on GitHub.com, the timings to compute the objects
> unique to "master", as in:
> 
>     $ git rev-list --count --objects master --not --exclude=master --branches
> 
> improve as follows:
> 
>   - 1.012 sec (without bitmaps)
>   - 29.571 sec (with the existing bitmap walk)
>   - 2.279 sec (with these patches)

For my curiosity, and since you already have a test environment set up,
could you redo the "without bitmaps" case with pack.useSparse true and
false? When the option was created and defaulted to true, we never
really explored comparing it to the bitmap case. In fact, I assumed the
bitmap case was faster in important cases like this (where there is a
substantial difference in object counts), but your data is surprising me
that the sparse algorithm is outperforming bitmaps, even with this new
algorithm.

The main question I'd like to ask is: is pack.useSparse contributing
in an important way to the performance here?
 
I'll go poking into the patches now.

Thanks,
-Stolee
