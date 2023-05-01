Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6F8C77B61
	for <git@archiver.kernel.org>; Mon,  1 May 2023 17:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjEARe3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 13:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjEARe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 13:34:27 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8FB18B
        for <git@vger.kernel.org>; Mon,  1 May 2023 10:34:26 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94ef0a8546fso449756766b.1
        for <git@vger.kernel.org>; Mon, 01 May 2023 10:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682962464; x=1685554464;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/Qv+3wX2ymOiC/bnHyUyHykjLMMgqtJFI6GfeC/QWs8=;
        b=gCfdy5Ra8ia+mIRmiMlaCJORMeve+hgu5WcgeGAuSJAHikdfAPDH0ooitHYRldpvnH
         N0SDAJY9yuLpOqxZUMB2FuB8snDjQpA3CzeiJ0hNlHGCGOz4KnTfe4vRLg/abdryhsX5
         kb1r2SJk/hPVPNUib3vO5rsU1eSaUrT/fkGSNSTyPjoGxnp1zwCtf6lxND3et1NrbKff
         OeemylXR2mLcOM07DfERDs6Z5s+XMiv/E44VewxBgG8mbRvy3+j1KOxFkgcA03CCPWNw
         zU6kVj3eSW8GSkxrGJ3oXiRwkVbPH3xS1nLsZApvcxRYVFudBxVlwm+0j4XRsfyAnBUA
         6kLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682962464; x=1685554464;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Qv+3wX2ymOiC/bnHyUyHykjLMMgqtJFI6GfeC/QWs8=;
        b=WKbyuKD22wGIMWBuQ31NTuMv2+F6CKSdFWkcMR/HlL6THJtp5Z7z9juUqGftb7UCYF
         +CNSmyH5gpL955VofyGCZF2wRf5P+6iL1+sGi0/6QVm12X6KGnGsn03BrrlB2iPWfDAp
         8oYi6c13NmY8BGHGnDTouWoggTWNstscUoiyQot/Egxo2r6MEd0bHTIXVqxoQPLxxe2s
         md72GnRox/0z1APGrS+gaoK+GXnfJnOO8Huy/Wsq1TXSELUbwilZQFZED58T7G28TSyS
         ZDmiDLinBCPQQomi5bySZX5+OnTaMCAdBdDjCOYzzuP0QAVgo5ohmLP5ix2Rp/yI06IR
         /RAg==
X-Gm-Message-State: AC+VfDyYQwvu9fvxklkhmSULBg3EQRowG5gJk3+8PSmn02uAKpRrWfqF
        492n+cO/qgp3F2pfeHyZvJyILmGV2Ik=
X-Google-Smtp-Source: ACHHUZ7EMteSbNDmTjsud4kjHesatgMv/+OP9kwkuOC/wNN6cSK1zKucAkXaWaRwjpvsVbeH/HesYw==
X-Received: by 2002:a17:906:dac2:b0:94a:9ae2:1642 with SMTP id xi2-20020a170906dac200b0094a9ae21642mr12420282ejb.46.1682962463931;
        Mon, 01 May 2023 10:34:23 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id g22-20020a170906595600b0094ed3abc937sm14940488ejr.82.2023.05.01.10.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 10:34:23 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ptXPq-000G0K-32;
        Mon, 01 May 2023 19:34:22 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH] cocci: remove 'unused.cocci'
Date:   Mon, 01 May 2023 19:28:50 +0200
References: <kl6lzg731xib.fsf@chooglen-macbookpro.roam.corp.google.com>
        <20230420205350.600760-1-szeder.dev@gmail.com>
        <230501.864jowjh15.gmgdl@evledraar.gmail.com>
        <xmqqlei86o7s.fsf@gitster.g>
User-agent: Debian GNU/Linux 12 (bookworm); Emacs 28.2; mu4e 1.9.0
In-reply-to: <xmqqlei86o7s.fsf@gitster.g>
Message-ID: <230501.865y9chs69.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 01 2023, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> It wasn't something I intended at the time, but arguably the main use of
>> this rule since it was added was that it served as a canary for the tree
>> becoming completely broken with coccinelle, due to adding C syntax it
>> didn't understand:
>> https://lore.kernel.org/git/220825.86ilmg4mil.gmgdl@evledraar.gmail.com/
>
> If it weren't Coccinelle, we could have used the much nicer looking
> UNUSED(var) notation, and the compilers were all fine.
>
> Only because Coccinelle did not understand the "cute" syntax trick,
> we couldn't.  Yes, it caught us when we used a syntax it couldn't
> understand, but is that a good thing in the first place?

I think it's unambiguously a good thing that we spotted an otherwise
unknown side-effect of the proposed UNUSED(var) syntax on coccinelle.

We might also say that some bit of syntax that coccinelle doesn't
understand is so valuable that we'd like to make coccinelle itself
significantly less useful (as it wouldn't reach into those functions),
or stop using it altogether.

But that's a seperate question. I'm just pointing out that we'd be
losing a very valuable check on future syntax incompatibilities,
particularly when it comes to clever use of macros.

A better way to spot that would be to start parsing the coccinelle logs,
and detect when we have unknown parsing issues, and error on those. But
until then...

