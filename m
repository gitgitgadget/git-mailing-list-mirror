Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BE5C43334
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 02:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbiFDCd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 22:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiFDCdy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 22:33:54 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1565997A
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 19:33:51 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id r3so8638314ilt.8
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 19:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hq36R5dp9tvhrvor2dkTGJrl0E4kMk4zm/CCbKab/BI=;
        b=CTq9jQ2Oo9K9DRWsWP3/XlOIbc19+pQDH1ot6rFA/V1EG6ZhIPK6OZinwuLJ2n0Mr9
         oIWLzZ5oQRE5ofKETF9YGR2zMFo4MvW0/OeJcvryxPHYDQbDhoPJ135Fpgr7AIXcZX5S
         GYnu0CO17EBtiKcOQWotaj5uWDkSF+j2LJwrwB/m6omOxLla4dXkO3+CGeMtoXmZb8B+
         Tf+//WbLXRTtsyRHjteFyo5PQsaZ6AmDbkgistjPl8kJrob16o00wRaMLSuGmjoeNdHP
         VRtyxyoc2MQWEyQ/TrLJ3EOvSgakvlNS9RNgS0+qYXzOSyfdiV9Bow6oNjMAzALsc0rX
         HeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hq36R5dp9tvhrvor2dkTGJrl0E4kMk4zm/CCbKab/BI=;
        b=KB7R+8u2Jm4piJe0Vn2NZh7zNqV8TDpfU3kM3hcZVqatPsN9I8aTpwyDyw1jLCRmrJ
         N6cvDGGMhvrjNIyvrat/0OPCWT+9QtmtyAQ90Ljxi2JgzqAFqK23FPpbzgkaPhfoPUvG
         F8RE4LScxc94lOTvweyufAxbjaj4wvarv9MlI4+pgQK+5qfDRcAVUdq0XaYEyI2nDGyn
         z2T8bhRkTVg7J2+PTZrrLkyG09I27Jjk8pTuaxwAhybgXwi/rx9FWQ1VOGbSBFmXxA0Y
         i+4E1UV9uWVpykWT9KZ6Er1c6XPiIzNYgaaLZkBXMw4ekHBWJ1X4gMcvgAgea/2WCmt8
         +c9Q==
X-Gm-Message-State: AOAM532dDtCG22lnCXyL7t3MGJavUz4hEwN8afWP8YdL3AsEUMOKxQ7B
        E9XLyfXi3v46kvH4lmOrevYP
X-Google-Smtp-Source: ABdhPJyNl92B29v6ZCCWdG0H4o2YiD6Zy9KVOpA7t9/YYf3/HF8lEl/yGYffZo6diSsBw08bGjTy5w==
X-Received: by 2002:a05:6e02:198e:b0:2d3:f382:bbc1 with SMTP id g14-20020a056e02198e00b002d3f382bbc1mr5145510ilf.129.1654310030696;
        Fri, 03 Jun 2022 19:33:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:258a:4978:615e:2484? ([2600:1700:e72:80a0:258a:4978:615e:2484])
        by smtp.gmail.com with ESMTPSA id f12-20020a02a04c000000b0032e5205f4e7sm3179529jah.4.2022.06.03.19.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 19:33:50 -0700 (PDT)
Message-ID: <af32aefc-8184-94ff-fd80-76221dc313b4@github.com>
Date:   Fri, 3 Jun 2022 22:33:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] builtin/show-ref.c: avoid over-iterating with --heads,
 --tags
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <3fa6932641f18d78156bbf60b1571383f2cb5046.1654293264.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <3fa6932641f18d78156bbf60b1571383f2cb5046.1654293264.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/3/2022 5:55 PM, Taylor Blau wrote:
> When `show-ref` is combined with the `--heads` or `--tags` options, it
> can avoid iterating parts of a repository's references that it doesn't
> care about.
> 
> But it doesn't take advantage of this potential optimization. When this
> command was introduced back in 358ddb62cf (Add "git show-ref" builtin
> command, 2006-09-15), `for_each_ref_in()` did exist. But since most
> repositories don't have many (any?) references that aren't branches or
> tags already, this makes little difference in practice.
...
> Nonetheless, in our synthetic example above, this provides a significant
> speed-up ("git" is roughly v2.36, "git.compile" is this patch):
> 
>     $ hyperfine -N 'git show-ref --heads' 'git.compile show-ref --heads'
>     Benchmark 1: git show-ref --heads
>       Time (mean ± σ):      49.9 ms ±   6.2 ms    [User: 45.6 ms, System: 4.1 ms]
>       Range (min … max):    46.1 ms …  73.6 ms    43 runs
> 
>     Benchmark 2: git.compile show-ref --heads
>       Time (mean ± σ):       2.8 ms ±   0.4 ms    [User: 1.4 ms, System: 1.2 ms]
>       Range (min … max):     1.3 ms …   5.6 ms    957 runs
> 
>     Summary
>       'git.compile show-ref --heads' ran
>        18.03 ± 3.38 times faster than 'git show-ref --heads'

Excellent speedup.

> -	for_each_ref(show_ref, NULL);
> +	if (heads_only || tags_only) {
> +		if (heads_only)
> +			for_each_fullref_in("refs/heads/", show_ref, NULL);
> +		if (tags_only)
> +			for_each_fullref_in("refs/tags/", show_ref, NULL);

This looks a little silly if these were truly "only" (they
could not both be true), but indeed they could both be true
and the names are just slightly misleading.

Indeed, t1403-show-ref.sh tests all combinations of these
options.

> +	} else {
> +		for_each_ref(show_ref, NULL);
> +	}

Thanks for finding this!
-Stolee
