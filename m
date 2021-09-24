Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74751C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 01:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 571E260EB4
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 01:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243820AbhIXBy2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 21:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243823AbhIXByY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 21:54:24 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBF0C061756
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 18:52:52 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v10so25416924edj.10
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 18:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=FC62zdPufCONtCTPFOQ4jSvBg7YQtr/iPHzeoanrffo=;
        b=bk/8ngm8Sh0TLBrrCxVAxCDWiXkFvj6tstTnl/g4nHGWW7HPmbG7sOolmIzKGuiQql
         d0+mLN3Il/ChE03n2KsmBUtdSMcriBefi6BnqUQlKGiwJq5g+n18+p59kSQV3rKFbWmM
         KjZ4JJzOtwiGOQSBjBZMNPy4W157v4/H+y2me8TWx4AXxxSGgHGgR2TeiciVVLf3K8nQ
         0B1g0Tz26oaLfy6Wd09UvAOoPowZ6ehxv6J5nrSW1FAasceGbo7OmAYLAv5PSR5xGKw+
         xkK3a/gaRRPrVUX09ArcaBTVXQThvZBxjRvXjL7wQ7cV+auieatpZiDFjbwMLTsjATbT
         5b0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=FC62zdPufCONtCTPFOQ4jSvBg7YQtr/iPHzeoanrffo=;
        b=azds5BzLYcR5JWJnCAG/BrGrgT+GHjmqgNGGwdXF95mm5LtHIhMXqhoE+92pPKefWY
         6Cn+EtxZl++9hjBQVMCQLgW1vvBllUYu6zwckhUFNKeBxjrWcWaTJbn1nhli0i7JN0Mp
         ThN/V9JmyUlBaG5tPezFW7CA2XZ6615z1Jz6R+yy6LS/FmSd6HhMaRKn76uvQHs4JWxC
         CVGSKo+D/SBCWf9dDoBsKRgR3Hd57qPUCLlX8ruNFVsXWKr8ZKoxt8dSBdyWiR8bsYCF
         b3CI35Aj/29uVqE5OXenUqInHZ0mLCaWzwbGSwe25Hw6wqzRNV7Zl35IQ6ZATAlSOyM6
         z5Ww==
X-Gm-Message-State: AOAM531yo+GL9Ib+MaIkbRKAl5B/Fx/tXOhQQdY2PhwctZV133CIfNvf
        +rZkIWBVI+8YJ6M6sEJ4DcA=
X-Google-Smtp-Source: ABdhPJxhRHJ6E4ywoRW5L2/aiPPkVAbo5KKvjZrYWZOKdAWMVwIwK+a/KfRC+AK3S/peQr75PGP5KQ==
X-Received: by 2002:a17:907:76b2:: with SMTP id jw18mr8876351ejc.120.1632448370643;
        Thu, 23 Sep 2021 18:52:50 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id a4sm4876386edb.79.2021.09.23.18.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 18:52:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2] Makefile: make the "sparse" target non-.PHONY
Date:   Fri, 24 Sep 2021 03:30:10 +0200
References: <cover-0.3-00000000000-20210921T224944Z-avarab@gmail.com>
 <patch-v2-1.1-059829f2195-20210923T000654Z-avarab@gmail.com>
 <YUyqIpOLFDqG/kEJ@coredump.intra.peff.net> <xmqqtuib199x.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqtuib199x.fsf@gitster.g>
Message-ID: <875yuq4u4u.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 23 2021, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>> On Thu, Sep 23, 2021 at 02:07:16AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>>
>>> We ensure that the recursive dependencies are correct by depending on
>>> the *.o file, which in turn will have correct dependencies by either
>>> depending on all header files, or under
>>> "COMPUTE_HEADER_DEPENDENCIES=3Dyes" the headers it needs.
>>>=20
>>> This means that a plain "make sparse" is much slower, as we'll now
>>> need to make the *.o files just to create the *.sp files, but
>>> incrementally creating the *.sp files is *much* faster and less
>>> verbose, it thus becomes viable to run "sparse" along with "all" as
>>> e.g. "git rebase --exec 'make all sparse'".
>>
>> OK. I think this solves the dependency issues sufficiently. It is a
>> tradeoff that you must do the normal build in order to do the sparse
>> check now. That is certainly fine for my workflow (I am building Git all
>> the time, and only occasionally run "make sparse"). I don't know if
>> others would like it less (e.g., if Ramsay is frequently running sparse
>> checks without having just built).
>>
>> (I'd say "I do not care that much either way", but then I do not care
>> all that much either way about incremental sparse checks either, so I'm
>> not sure my opinion really matters).
>
> My build procedure runs "make sparse" before the primary build,
> simply because the former tends to be much faster to fail when there
> is an issue in the code.  I can understand that depending on .o is a
> cheap way to piggyback on the dependencies it has, but my latency
> will get much slower if this goes in _and_ I keep trying to pick up
> potentially problematic patches from the list.

Would you be OK with just running something like this instead?:

    make -j $(nproc) objects CC=3Dcgcc CFLAGS=3D"-no-compile -Wsparse-error=
 -Wno-pointer-arith -Wno-memcpy-max-count"

It gives you almost exactly the same thing as the old "sparse" target. I
think the way it worked is really not something we needed a special
target for in the first place, or perhaps just a .PHONY alias.

The "almost" is because those -Wno-* are now per-file via
SP_EXTRA_FLAGS.

I.e. if we have a $(CC) that's willing to accept CC-like options but
just won't create output files we can use "objects" (or other targets I
added in 029bac01a87 (Makefile: add {program,xdiff,test,git,fuzz}-objs &
objects targets, 2021-02-23)). Even if the tool itself created broken
*.o files a change of $(CC) to the "real" compiler would ensure that
they'd get regenerated.
