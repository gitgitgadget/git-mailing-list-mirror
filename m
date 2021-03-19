Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359ACC433DB
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 10:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0001A64F70
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 10:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhCSKdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 06:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhCSKcm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 06:32:42 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDFAC06174A
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 03:32:42 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id k10so8860500ejg.0
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 03:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=+pw5mp768G9Um/LreKfHZ2wJI/Gm7u/2LEgXTHoCoho=;
        b=ZzKJIxHRDm6mzezHtXt3+wfdVqijugqt8Wt0bXYZCDoawBqTIGoudZfh91RMQp/VQf
         1G6AkDq+egDQNdVII3oacPtnt5pRLVb53s47bPo8kw27Jz6KqPxJtzpLyeb0NRAhRzJ7
         CBivdNld3URDbMapBzArG67YdHrk+B5oayU1b7D0+cyfaplOD05oGrL7mEUPuQh6C7UE
         8YCupI5ppHUd73tAyQgqEUR+jvarqqFiYVkKMMD4ZuJG/LdHBBceJZ0B/hV4a3IIosLt
         Bk+ltkyRxkFxSDAiTn2SHW7c3tcfvNOt9TOapeaqa0fcyUKTmdItfhkdPpv8SkbMx3et
         uaig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=+pw5mp768G9Um/LreKfHZ2wJI/Gm7u/2LEgXTHoCoho=;
        b=XSMyIUqPE82z/MtXIraLSLcdFStf08Iho/xqRkzmUtYvonQ3IRjpyIbjedpZUBdLL5
         WsnZc9kbgcv//xZyVkV5KYnLTYsX+FWf5s7t4t5GyoNTbBeIZy2OR0FpB9Srfh08/Nsh
         41HwI16JhWRqAHTvM4KxwEBnlomGYz2c6akYp/7+WprmG1gUET4CE4OOjCQ7Z9s5dn/F
         g6OcXjAN14MDiek0G8htoWoGk9zXCWVJbb4P4KTCtT+W6LlydT5/mtJ0UGvmbcDzQKhz
         AiYJIQ6y3jK0tH7geQAW6GkaTiutm7173mdmv26XH1rOoVyKRN04AytHXdDGkCzpQy7+
         Lvxw==
X-Gm-Message-State: AOAM531DxSzecLXWmI1/0YeXcnSNFIpBa20DHWy7Yc5lmFSi7DUIbScH
        XbZClcWrReE5+gsFy6jRN72BPdnzols=
X-Google-Smtp-Source: ABdhPJyQhKLHa1IQa6f4qrFdMDAAqqSliBE8bA+50RvcsKnZ2XOk/dP6FYkZuWw0olcpHf5P6/BDng==
X-Received: by 2002:a17:906:dfcc:: with SMTP id jt12mr3524533ejc.31.1616149960942;
        Fri, 19 Mar 2021 03:32:40 -0700 (PDT)
Received: from evledraar (77-60-191-25.biz.kpn.net. [77.60.191.25])
        by smtp.gmail.com with ESMTPSA id j14sm3758124edr.97.2021.03.19.03.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 03:32:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 5/4] Makefile/coccicheck: use
 --include-headers-for-types
References: <20210305170724.23859-5-avarab@gmail.com>
 <20210306192525.15197-1-avarab@gmail.com>
 <20210318204957.GA1938@szeder.dev>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210318204957.GA1938@szeder.dev>
Date:   Fri, 19 Mar 2021 11:32:39 +0100
Message-ID: <87ft0rzb5k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 18 2021, SZEDER G=C3=A1bor wrote:

> On Sat, Mar 06, 2021 at 08:25:25PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Change the recently added --no-includes out for --all-includes
>> --include-headers-for-types.
>>=20
>> When I moved from --all-includes to --no-includes I missed that rules
>> that use "type T" such as the one added dbc540c7a58 (add QSORT,
>> 2016-09-29) won't work as intended. See [1] for a report of that.
>>=20
>> So let's move back to --all-includes to potentially scour our includes
>> for definitions, but supply --include-headers-for-types so we won't
>> racily emit duplicate hunks. See [2] for more discussion about that
>> issue.
>>=20
>> This undoes most of the optimization we gained with --no-includes,
>> using a very basic benchmark script [3] I get these results:
>>=20
>>  * ~1m50s: --all-includes (before my recent patches)
>>    38 files changed, 74 insertions(+), 78 deletions(-)
>>  * ~55s:   --no-includes
>>    27 files changed, 55 insertions(+), 57 deletions(-)
>>  * ~1m35s: --all-includes --include-headers-for-types
>>    38 files changed, 74 insertions(+), 78 deletions(-)
>>  * ~1m20s: --local-includes --include-headers-for-types
>>    36 files changed, 70 insertions(+), 72 deletions(-)
>>  * ~1m20s: --local-includes --include-headers-for-types --no-loops
>>    36 files changed, 70 insertions(+), 72 deletions(-)
>
> Where do these changes come from?  I can't reproduce it running your
> script below, and get empty contrib/coccinelle/*.patch files for each
> sets of options.

It's from Ren=C3=A9's patch in <3aac381e-2ce9-e35e-498c-9c26df235aed@web.de>
patch in the side-thread.

I'll clarify that commit message in any re-roll, i.e. it should just be
something like: Here's a test of a patch that applies widely to the
tree, showing that using [options] it's the same or different as before,
as expected.

>> And only the "--all-includes --include-headers-for-types" gets the
>> same results as the previous "--all-includes", even with
>> "--local-includes" we miss out on some definitions.
>>=20
>> 1. https://lore.kernel.org/git/3aac381e-2ce9-e35e-498c-9c26df235aed@web.=
de/
>> 2. https://lore.kernel.org/git/YENdUMLTM+cerfqJ@coredump.intra.peff.net/
>> 3.
>>    for flags in \
>>        '--all-includes' \
>>        '--no-includes' \
>>        '--all-includes --include-headers-for-types' \
>>        '--local-includes --include-headers-for-types' \
>>        '--local-includes --include-headers-for-types --no-loops'
>>    do
>>    	git reset --hard &&
>>            git clean -dxfq contrib/
>>    	time make -j8 coccicheck SPATCH_FLAGS=3D"$flags --patch ." SPATCH_XA=
RGS=3D"xargs -P 8 -n 16" 2>&1 | grep -v SPATCH
>>    	cat contrib/coccinelle/*.patch | git apply
>>    	git --no-pager diff --shortstat
>>    	git --no-pager diff | git patch-id
>>    done

