Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469FDC433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 19:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiB1Tuq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 14:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiB1TuV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 14:50:21 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7F5F65F7
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 11:48:42 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id i11so19091346eda.9
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 11:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=dZfq44SkZrtqS3I0kSCUioQe0QAaM4Md+TKZUfiycC8=;
        b=bcyrOUK3Jq04MlKBqMYzsCQgi7dIFIhLwqxAC0Ht268pNsvUQKCKVvDsdSmxnVels6
         3pYWxjR/03k0sSreBicNlY7lzvNjr+1GmRS+JfdhcSl3i0fQlhduVq7/QN4ymfYIhrkl
         gpxpQaTxYIKBy91Jwngc4oGuBEhYZDl9pdPlZ5HSza/vSJitJDi6zkQnprUD76JuNtMH
         MFVY35E4mXieRtSH/J9w2utKNpImINoUr754Ct8g5awehGvf3V9lnrUj7qmMFNFl8/yf
         wPUaPaDRS0OO0iz5JVRarrHgDQRRH7gtG2yygbY205NFAFq63fDXefuT2euthlkB5d7i
         834w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=dZfq44SkZrtqS3I0kSCUioQe0QAaM4Md+TKZUfiycC8=;
        b=B2uW36t4y/zBUZcpY7UCSnM+LBSsH8vXbUjA3+iT/bMXlHgUqqVHUZmffcCzZrTf+o
         NfbcJaDnBBelcVu75k4iVyOG80pcdJS4u4c8Cs/Acr9bYLDTv6mW87h3vd6gmvP69LPd
         n/AAqpQIF7wu+4qsDUSpJTLpuyhHVuu7glWFfmu4Ci6SEMk+sajMw5RMrLlNVD5yGxts
         q8g13+44ERHiiTNBBMd4Y098JzzXzLRe3dwxlGRZyvwCbPZfPUZU7y2tnD6Tr7AyQwbk
         I1PegFt/36qq1pxjs+RsdDV3hmM49woDhlR2bUkqJerMmKAjtOdExaTwvUKyjGPW8fWD
         p8pg==
X-Gm-Message-State: AOAM533ewUOwGz70c3HuLGWW8OZ8tsfzAIRQnpCRBujfwDhRRv4sg90G
        JAbDn0E0vaxqATZytEwtKyvQjMtaNjs=
X-Google-Smtp-Source: ABdhPJyI7tshdKZ7nytH8W4VU1YRSv615B27NgcCQ0otyrV5JUnE/7WwyOWd5nk4L1QP7hk/dmSLHA==
X-Received: by 2002:a17:906:3905:b0:6cf:7ef5:fee0 with SMTP id f5-20020a170906390500b006cf7ef5fee0mr15862439eje.307.1646077047052;
        Mon, 28 Feb 2022 11:37:27 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i5-20020aa7dd05000000b00410d26d170bsm6492515edv.4.2022.02.28.11.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 11:37:26 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nOlpl-001ZiD-S7;
        Mon, 28 Feb 2022 20:37:25 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] parse-options.c: add style checks for usage-strings
Date:   Mon, 28 Feb 2022 20:32:18 +0100
References: <xmqqtuck3yv2.fsf@gitster.g>
 <20220228073908.20553-1-chakrabortyabhradeep79@gmail.com>
 <xmqqzgma287n.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqzgma287n.fsf@gitster.g>
Message-ID: <220228.86mtia3hqi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 28 2022, Junio C Hamano wrote:

> [...]
> So from my point of view, plan should be
>
>  (0) I have been assuming that the check we removed tentatively is
>      correct and the breakage in in-flight topic caught usage
>      strings that were malformed.  If not, we need to tweak it to
>      make sure it does not produce false positives.
>
>  (1) Help Microsoft folks fix the in-flight topic with faulty usage
>      strings.

Agreed.

>  (2) Rethink if parse_options_check() can be made optional at
>      runtime, which would (a) allow our test to enable it, and allow
>      us to test all code paths that use parse_options() centrally,
>      and (b) allow us to bypass the check while the end-user runs
>      "git", to avoid overhead of checking the same option[] array,
>      which does not change between invocations of "git", over and
>      over again all over the world.
>
>      We may add the check back to parse_options_check() after doing
>      the above.  There are already tons of "check sanity of what is
>      inside option[]" in there, and it would be beneficial if we can
>      separate out from parse_options_start() the sanity checking
>      code, regardless of this topic.

This is a good idea, but while t0012-help.sh catches most of it, it
doesn't cover e.g. sub-commands that call parse_options() in N functions
one after the other.

We could that in t0012-help.sh with (pseudocode):

    for subcmd write verify ...
    do
        test_expect_success '...' 'git commit-graph $subcmd -h'
    done

etc., but that still won't catch *all* of it, and we don't have a way to
spew out "what commands use subcommands".

Hence why we need to run the rest of the test suite, and why these
things aren't some one-off GIT_TEST_ mode or t/helper/*.c code already.

>  (3) While (2) is ongoing, we can let people also explore static
>      analysis possibilities.

I think with in-flight concerns with (0) and (1) addressed what we have
here is really good enough for now, and we could just add it to the
existing parse_options_check() without needing (2) and (3) at this
point.
