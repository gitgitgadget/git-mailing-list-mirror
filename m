Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932F2C433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 01:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A99D6115A
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 01:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238782AbhIWB30 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 21:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238177AbhIWB3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 21:29:25 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02062C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 18:27:54 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id dj4so17368844edb.5
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 18:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=FaSF8qI02KiuWej6tbMJqGaJkN/7rE1yTieS/vJpTPo=;
        b=D6eOpnaDHN6y0rb2RcmcPQLaD+yRKhoO3OQxZ1dsPGu7ZF8FnVGqgnzQLmRbxXgIh6
         O3zCpGRLF67YSBGkCZRt7YrEnu9yXhNTOWeuffF981miE/1dZ4GA28OKwD83YSFDVTfE
         jNl1ThtKbgtRWsxuHurYBWXbhMPJOpSs3d5nf04hvIL9pOQdiQ+MgHh02bWpEvCiBGi9
         k5Na7lF/cPRO7eXaruTM7lCFKKLXkihWVi7rLh/HtC32Ecgi64nvxhreI1GFdQSeHZPo
         ZDiaLbk8kBTc8qmr82UZcQWPFqD0vXop9biBX10HTmInzUzBIdEb/p/nRmDG1RRG0lCQ
         4LFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=FaSF8qI02KiuWej6tbMJqGaJkN/7rE1yTieS/vJpTPo=;
        b=uouu3nZIUDHAOA9jcmgCcHGLh/Dl94GVfIYLNk61WtrAe4TL/5svSc72TfG8nLvqpn
         wtaC/YZdlECd256KaAtIb+1+WHzz7K4DoAJ+QliejQg/TcugEkeCUrIoqgiTqiR79vQf
         H1TqGcvCjvltyIP3zvlPpnzcg/cCkUDPU4cZ0p7D7l8L3qz2cU6S1DI5wixWJ6lV5nGp
         DpY4Bg/4AIT97dRlyjEtlGuPLesKTV/UB+Hv3D+7Fi1K8lIY9S23mqj77NPvWGXyw80I
         1IMSdU2mf84PT0I1l9MJt2H767D1NHmUfuky2rdKG+oeuf8Nf3pGs6qdeW4WlmtoVHMd
         Y0zw==
X-Gm-Message-State: AOAM531oFXIMDTTGmVh1SSi4pqBdtQlw8vynzVIpr6/N/3kVLN0qXmHz
        e7wVIb43RsuzV36MtT71B617P7K9F+fnNQ==
X-Google-Smtp-Source: ABdhPJz8TvYYcxOSVof0TY3EIRMRyZ54xk1lDCKX0nbodg9y/SY+8hE1IHostjKZAcPLPh30IcJY0A==
X-Received: by 2002:a17:906:7855:: with SMTP id p21mr2335738ejm.330.1632360473369;
        Wed, 22 Sep 2021 18:27:53 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bf28sm2216053edb.45.2021.09.22.18.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 18:27:52 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH] http: match headers case-insensitively when redacting
Date:   Thu, 23 Sep 2021 03:22:04 +0200
References: <YUonS1uoZlZEt+Yd@coredump.intra.peff.net>
 <afd7bd6b-52bf-7fd8-d13e-6dcd660c4100@gmail.com>
 <YUuN+KguN0WetC49@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YUuN+KguN0WetC49@coredump.intra.peff.net>
Message-ID: <87lf3o5bdz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 22 2021, Jeff King wrote:

> On Wed, Sep 22, 2021 at 09:32:41AM +0700, Bagas Sanjaya wrote:
>
>> > but this has a few issues:
>> > 
>> >    - it's not necessarily portable. The http2 apache module might not be
>> >      available on all systems. Further, the http2 module isn't compatible
>> >      with the prefork mpm, so we have to switch to something else. But we
>> >      don't necessarily know what's available. It would be nice if we
>> >      could have conditional config, but IfModule only tells us if a
>> >      module is already loaded, not whether it is available at all.
>> > 
>> >      This might be a non-issue. The http tests are already optional, and
>> >      modern-enough systems may just have both of these. But...
>> > 
>> >    - if we do this, then we'd no longer be testing HTTP/1.1 at all. I'm
>> >      not sure how much that matters since it's all handled by curl under
>> >      the hood, but I'd worry that some detail leaks through. We'd
>> >      probably want two scripts running similar tests, one with HTTP/2 and
>> >      one with HTTP/1.1.
>> 
>> Maybe for httpd config we can say that if mpm_prefork isn't loaded, load
>> mpm_event and mod_http2.
>
> That doesn't work. We can say "is mpm_prefork" loaded, and indeed we
> already do, in order to load mpm_prefork! That's because the module may
> or may not be built-in, and if not, we have to load it (or some mpm
> module). See 296f0b3ea9 (t/lib-httpd/apache.conf: configure an MPM
> module for apache 2.4, 2013-06-09).
>
> But we have no way of knowing _which_ modules are available. It may just
> be that "event" or "worker" (both of which support mod_http2) are
> available close enough to everywhere that we can just guess.
>
>> And for testing both HTTP/2 and HTTP/1.1 did you mean sharing the same test
>> code (with adjustments for each protocol)?
>
> Yes. I'd literally run the same battery of tests against both protocols
> (see my other response to Taylor with a sketched-out example). I'm still
> not sure it's entirely worth the effort, though. The underlying
> transport should be pretty transparent to Git, with the exception of
> things like debugging output.

Maybe I'm missing something, but it seems to me that trying to figure
out if we support http v2 or not beforehand is the wrong thing to do in
this case. Why don't we simply try to start the server, and fail and
skip_all="sorry, no httpv2" if it fails?

Then have 2 test files:

t1234-http-v1.sh
t1235-http-v2.sh

Where the latter includes the former (or is a symlink with a $0 check),
or both include a library. Doing it this way also means you'll get a
message you notice via "prove", since you won't run all v1 tests in one
file, then skip some v2.

It also means we could add "ssl" in that mix and have 4x files, and
unlike a GIT_TEST_* mode or shoving it all in one test we can run these
in parallel and test all combinations in one test run.

