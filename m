Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AF5C61DA3
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 17:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbjBURen (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 12:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjBURem (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 12:34:42 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103C71CF7D
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 09:34:41 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id z20-20020a17090a8b9400b002372d7f823eso1754491pjn.4
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 09:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/vCz162e34uVY1UTRbdBk69Y+wMbFZsT7Y/CDleOjA=;
        b=W+TSHoW3f+OxJRZVbieCnxV2eBn5cOYTv8F1eMbCU1UuL7svUYI318T+I0nx6vak+w
         ZnITsGYlXyiGs+SNEGT9BxiMaxztM3OohGDoKFEOTCuitl52121ItXtAHzek2E7iIKkm
         nplkrk3N3rpk2L1c9ShglKSxO+xOcEKkpyd2gDAJ6FjPFR6VwW9wGPAeQgjZ6LwLCVMW
         BTn6harIGpBMVDUhb5IH1uF/SXeTWdpqUQ2T0UYItXWbdJOhe49kA+xKrxvERLEFqjWu
         DlbbGRtrrxsrMZl45araXWoRbHvAH8hcDxzAdbUpF4VIYM/Lt6j8MJJm/sUnkF9bCVek
         LdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/vCz162e34uVY1UTRbdBk69Y+wMbFZsT7Y/CDleOjA=;
        b=OlOzda2ny9VTwP5pFkCfcnu1QKYFOAYsTuKLEi6NTH+zi3c9Rmo776yWm3lOi8mIRE
         Njg52f04Z+eDbTyEa7PY2qh0Ikd8LP+fuS7Jeh525f3ik9xfbueptuJoS2vxPp4yIQW8
         gPwn/3hPJdV0A9qFNd6WPBiKnq7wj4Jjiwn7IrdPxqP2fQLKVaiol1y8nTPwmD1zUI1k
         X6RUPSLJyIpGuUwBI1J6XmFaCTbWmcvHXJNNa68zK0KXr6IurMU3y0XabQd5kWOwJJCX
         xxiHzkwuXk9yqI6D8A+WNdOJHWWo2zXPtlLyzRyjMMDNNEDP2Jlnwx7gzxF7Eq0ZHGiM
         L75w==
X-Gm-Message-State: AO0yUKW0Xc9qVFrQGNgeOxOW9jCBKUt8kuabsVmclH/fKNAdmPOpS6ly
        YU/cdvm7GW2DFRlkig8Tl024S0ZACRs=
X-Google-Smtp-Source: AK7set8DLrzWD5Swv3cmV9kBqz3cm8KdviyoFpbdVZrNaINsy8cUFyRWWKKtxczH6L1hEInDRCR9HQ==
X-Received: by 2002:a17:902:e5d2:b0:19a:80b2:e94b with SMTP id u18-20020a170902e5d200b0019a80b2e94bmr9544084plf.33.1677000880383;
        Tue, 21 Feb 2023 09:34:40 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id s9-20020a170902a50900b0019a7363e752sm10097400plq.276.2023.02.21.09.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 09:34:39 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v4 0/2] Teach diff to honor diff algorithms set through
 git attributes
References: <pull.1452.v3.git.git.1676665285.gitgitgadget@gmail.com>
        <pull.1452.v4.git.git.1676927082.gitgitgadget@gmail.com>
Date:   Tue, 21 Feb 2023 09:34:39 -0800
In-Reply-To: <pull.1452.v4.git.git.1676927082.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Mon, 20 Feb 2023 21:04:40 +0000")
Message-ID: <xmqq5ybuhqhc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> When a repository contains different kinds of files, it may be desirable to
> use different algorithms based on file type. This is currently not feasible
> through the command line or using git configs. However, we can leverage the
> fact that gitattributes are path aware.
> ...
> To address some of the performance concerns in the previous series, a
> benchmark shows that now only a minor performance penalty is incurred, now
> that we are no longer adding an additional attributes parsing call:
>
> $ echo "*.[ch] diff=other" >> .gitattributes $ hyperfine -r 10 -L a
> git-bin-wrapper,git '{a} -c diff.other.algorithm=myers diff v2.0.0 v2.28.0'
> Benchmark 1: git-bin-wrapper -c diff.other.algorithm=myers diff v2.0.0
> v2.28.0 Time (mean ± σ): 716.3 ms ± 3.8 ms [User: 660.2 ms, System: 50.8 ms]
> Range (min … max): 709.8 ms … 720.6 ms 10 runs
>
> Benchmark 2: git -c diff.other.algorithm=myers diff v2.0.0 v2.28.0 Time
> (mean ± σ): 704.3 ms ± 2.9 ms [User: 656.6 ms, System: 44.3 ms] Range (min …
> max): 700.1 ms … 708.6 ms 10 runs
>
> Summary 'git -c diff.other.algorithm=myers diff v2.0.0 v2.28.0' ran 1.02 ±
> 0.01 times faster than 'git-bin-wrapper -c diff.other.algorithm=myers diff
> v2.0.0 v2.28.0'

Hopefully this round can immediately be merged down to 'next'?
Thanks.

