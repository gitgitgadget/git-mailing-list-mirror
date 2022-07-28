Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75FBC04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 23:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbiG1XSZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 19:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiG1XSX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 19:18:23 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581F97393A
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 16:18:22 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ez10so5574616ejc.13
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 16:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=A5U09sj3IIWLmt/9/oR9G1kO3aoIHubKpoWui+czhgw=;
        b=jJxpuEqbl5Ic0rz3//d+IDZfan0MEQybaLTiIr7frUwYbovwU7KL6t9VDogfp0R1vE
         6GXm0xGJXrqJjgbw9dWVZB4Pl4dDofMztz/8qqgfWIzeCAtnUgHUFXqkQD5CWco4hrST
         iKMsck1zmkJChJr1pBgYQn4oc5KN8/m4gH3+YOWSoi7RhTuH8UsQPqVETXWs3u712rxx
         WAUFJzMYFay/DImi1y9yJc5c/EZGkaX16VtkWgBgfZFSdspqAoP7IHKXmCDgF4hXE6uv
         WXN8dPB8AKfk/xn4ae8apL/rPPdnDaV6m8HylTUQ9VHpuuVg8uwKs7fqRVR7gWM0wW0v
         N8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=A5U09sj3IIWLmt/9/oR9G1kO3aoIHubKpoWui+czhgw=;
        b=jmaSJNTBdTwDsWBz7WmojedSaMnvbXILkUeocKiumFuycCdQQOkBykX9U4/4Lk49In
         spUYKh9HltB5VLYeTVO5v4tV2SJagjz9WIniGiPDCcXu8pyFwSbyIGp9y2DPperVHDaG
         cX4UZOjvyBXwOk+RYb0PTMcFonAZNU23/wuiJw6zr4tiHw/IGDk8W+DKb9W1kh2WyOu5
         hVDqCrRzi6yy/CBrP9fbbZBqettDwOICf0KZy7pBvS0A7VJZC2XTVmIAS7gIrQCz5jW6
         cmvj5nj8FbA0g/3TdWTq5427kMm96Oy8K0DXZN+Wu2eb6SOEQEl30FZ1PbgL+9WuYN/b
         4s/w==
X-Gm-Message-State: AJIora8jZntp9CDwFs0QUtrjAOEu1uLS3spUg5g1PagX9tsbCtQycgq7
        JAoXDv+Lf+h0cYHq76no2c9rM/x55fNjIA==
X-Google-Smtp-Source: AGRyM1tgu4pogtQg+ImFnHmRUEGcQ1K6zm91+7yfSMr9PU7jZDR2Mda+Gdtp/By/r9Bq+6GjZRrmzA==
X-Received: by 2002:a17:906:7007:b0:6ff:8028:42e with SMTP id n7-20020a170906700700b006ff8028042emr861739ejj.278.1659050300603;
        Thu, 28 Jul 2022 16:18:20 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id kf23-20020a17090776d700b00718d18a1860sm921722ejc.61.2022.07.28.16.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 16:18:19 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oHClm-007JNQ-VQ;
        Fri, 29 Jul 2022 01:18:18 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH] CI: add SANITIZE=[address|undefined] jobs
Date:   Fri, 29 Jul 2022 01:10:21 +0200
References: <patch-1.1-e48b6853dd5-20220726T110716Z-avarab@gmail.com>
 <YuGPeHn9wfF6tWA5@coredump.intra.peff.net>
 <220728.86o7x9jhrp.gmgdl@evledraar.gmail.com>
 <YuL7EotrIpnOn5BT@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YuL7EotrIpnOn5BT@coredump.intra.peff.net>
Message-ID: <220729.8635ekkerp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 28 2022, Jeff King wrote:

> On Thu, Jul 28, 2022 at 06:54:37PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
> [...]
>> We also leave a lot of CI performance on the table by e.g. doing "chain
>> lint" in every single test run (except Windows), there *are* platform
>> edge-cases there like with SANITIZE=3Daddress, but I wonder if we should
>> just declare it good enough to do it in 1-2 jobs.
>
> I'd be fine with that, but I think chain lint isn't actually that
> expensive. The original in-shell bits are super cheap. The extra
> sed process is measurable, but I think I blunted the worst of it in the
> 2d86a96220 (t: avoid sed-based chain-linting in some expensive cases,
> 2021-05-13).
>
> Still, that patch should make it easy to time things just by setting
> GIT_TEST_CHAIN_LINT_HARDER=3D0 in various jobs. It does seem to buy ~100s
> of CPU time per test run on my Linux box. That's not a lot in the grand
> scheme, but perhaps adds up. And I could believe it's much worse on
> Windows. Maybe worth seeing how it performs in the actual CI
> environments.
>
>> Ditto TEST_NO_MALLOC_CHECK=3D1 & --no-bin-wrappers, but we can think abo=
ut
>> all of those some other time....
>
> I'd be surprised if the malloc checking itself is all that expensive,
> though it does look like we call getconf and expr once per test there
> for setup. We could almost certainly hoist that out and call it once per
> script.

I posted some benchmarks for these a while ago:
https://lore.kernel.org/git/220405.86k0c3lt2l.gmgdl@evledraar.gmail.com/

YMMV, but these make a big difference for some tests, although less for
a whole run, as you point out disabling chain lint least impact.

For me a full test suite run is:

* TEST_NO_MALLOC_CHECK=3D1 --no-bin-wrappers --no-chain-lint:
	real    1m55.600s
	user    8m48.039s
	sys     3m17.776s
* [no opts, TEST_NO_MALLOC_CHECK=3D0 & --bin-wrappers && --chain-lint are o=
n]
	real    2m18.126s
	user    10m40.230s
	sys     4m7.152s

So far from the >2x speedup you can get with some tests, but a big
difference nonetheless.
