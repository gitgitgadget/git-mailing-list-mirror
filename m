Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2590AC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 14:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C6E76135F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 14:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbhHXOYE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237496AbhHXOYD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 10:24:03 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877D3C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 07:23:19 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id me10so16404054ejb.11
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 07:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=+3JyBYALzDJKSGaoNMzfphoKypB7ODn1GfxrRXLSQUA=;
        b=OnNW9IsyDZBqSxE8ME3tk59CYKoGaarT6hZU7aKBL3penSLuw7p/qdUQwOMu/pfNbq
         eYQIiGhwGboCjALPA7FcRhPF8YNEvVctdP1SO5W2YCdpbUWLj/rdd2NbeSeFUV1jnN5M
         wYAbHR1dAvHCGxF7AC42njWM/9ENKoRKVzWW5ESH/SHGxJyu4SORFtJv2tgIDccXxH0V
         4EP/gp6HAs+cLw92LfUADcykh9QJWeBgyFBJPzh9VDXrzHQNr8DlfkRsi6zYWM/yZ4IB
         Zi9PFcvCZX5rhhawSaybcAmc8cXR6ejwT+9cXluZbFmWkHXGjEx6g6hJuXtBot2boa25
         PEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=+3JyBYALzDJKSGaoNMzfphoKypB7ODn1GfxrRXLSQUA=;
        b=syRSbRV34o1EkxZS2mPZCaeQWr3nGg6pmt5RymZsPs453bFtWo7gztPkBXhTkoCR4Z
         CSYLUStfX1Q4JQMxkdGz4NKg3mZAgbExqrdmkX8sf51S6MIwjDlScr+rOTZxXY/WqXq8
         YGMNhDbPuX7lX1uY8sjVio/X3Ds/EyZA/6yxp7XL3rR54PbF0ShB5hZlHVOyZZSY58Dl
         V/FBfHSJHK2lsU4Kg8VFN4Rwbih7hViLtelWWKDaMBfG9OUjzPmvPRd/T6OHMOmqH1F8
         wuUzSB9cz9riQHQOe+pINbhfJz0eCW+GSiQcF4DV/hvYu50qJn1PAWY6/XIy3QX4IHUJ
         zN6A==
X-Gm-Message-State: AOAM531T4i4fdH9LJzOWhOhhXU88Sc15fQTofD51i5Vu45m7VgY/wRl+
        xekcX0PTYIbuSdADCakqk003V0G8o6nyRQ==
X-Google-Smtp-Source: ABdhPJxYYn1cyrswWTu6y06s4sfZA2sIfswrAFG5tvGMNU42RuDexFjDPdNJtDlYrrpUmPdh+R1PrQ==
X-Received: by 2002:a17:906:6009:: with SMTP id o9mr41551265ejj.266.1629814997671;
        Tue, 24 Aug 2021 07:23:17 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i26sm9197470ejh.4.2021.08.24.07.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 07:23:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4 02/36] Makefile: stop hardcoding {command,config}-list.h
Date:   Tue, 24 Aug 2021 16:22:42 +0200
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
 <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
 <patch-v4-02.36-0f749530777-20210803T191505Z-avarab@gmail.com>
 <YR7xRYWSDAHPH2NS@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YR7xRYWSDAHPH2NS@google.com>
Message-ID: <8735qygbvv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 19 2021, Emily Shaffer wrote:

> On Tue, Aug 03, 2021 at 09:38:28PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>> Change various places that hardcode the names of these two files to
>> refer to either $(GENERATED_H), or to a new generated-hdrs
>> target. That target is consistent with the *-objs targets I recently
>> added in 029bac01a8 (Makefile: add {program,xdiff,test,git,fuzz}-objs
>> & objects targets, 2021-02-23).
>>=20
>> A subsequent commit will add a new generated hook-list.h. By doing
>> this refactoring we'll only need to add the new file to the
>> GENERATED_H variable, not EXCEPT_HDRS, the vcbuild/README etc.
>>=20
>> I have not tested the Windows-specific change in config.mak.uname
>> being made here, but we use other variables from the Makefile in the
>> same block, and the GENERATED_H is fully defined before we include
>> config.mak.uname.
>
> Is it not something you can get coverage for via, for example, the
> GitHub Actions CI suite? I wonder if that means we want some test to
> check that these generated lists came together correctly?

I'll amend this. Yes it's being tested via the CI, and it's the CI that
failed before. I should have said "I have not tested this directly",
i.e. I don't have a local Windows machine, but pushing it to the CI
build that uses this works...

> Otherwise the diff looks straightforward.
>>=20
>> Hardcoding command-list.h there seems to have been a case of
>> copy/paste programming in 976aaedca0 (msvc: add a Makefile target to
>> pre-generate the Visual Studio solution, 2019-07-29). The
>> config-list.h was added later in 709df95b78 (help: move
>> list_config_help to builtin/help, 2020-04-16).
>>=20
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Reviewed-by: Emily Shaffer <emilyshaffer@google.com>

