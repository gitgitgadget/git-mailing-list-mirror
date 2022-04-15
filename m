Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB07C433EF
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 13:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354174AbiDONzG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 09:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354169AbiDONzE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 09:55:04 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B34BD2C9
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 06:52:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u15so15426836ejf.11
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 06:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=x8YGIVWmVPYxgZU4DOipD7q/8qBC5wWRH+OC/TE1KLc=;
        b=U7kgyH5EXtS+T9EUY1U2vB2LLWqOrQQ35DcqBALIkXDPCykjeMuYfTAAWlNYNCY3tM
         3cESEb6k9iVPDbSFlT3SNnFAxIW5KiWjVIbQYsUm+bwksqWwqCJGO5XIsqIlTK99axPc
         4qtasVLE+2vsOdg1ABSQ8IR4sM3WihBusJPrhfmroNc6rz4wo4DGQ3wRH+GgpDsZxkFi
         lXWo0Itm1vhCfAB2U3w6Af7q5vLSbIFzPNpyA3Gs0ZFBlOTfQN/clnoF5O4CGhap37bv
         YYFyROeURC04y3QlI36MyZVfbCN7Pknhs8Oh5fI8u8/15xWP/Xuk22ZCmr6SY7UGpNjF
         IX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=x8YGIVWmVPYxgZU4DOipD7q/8qBC5wWRH+OC/TE1KLc=;
        b=cMECWeWMyl0ZXgj3VV03iqZyz3tIeE17SriWkhB0xfA98L7Hc2Iu6cI9mMrtpGsUZ1
         Exgq1jlb/AwnVGKN6D71QUavxQR1kBQkDk1paBOKW8elLuIzqxi/Q55vjrYv+yQzeJyM
         no4MTMlCM+63mY4WPyi5JVrWLbd2kxrV3kCREx9wPJVrTuWnQrNvR8qWTT1g8sOoROnD
         H1XUUDSFPWAew+DCnnrGOv0dQOqyYB6X9uugORXCZWfYSQ4tnkYHhuNEY5ADe3pQfw9M
         xza0eqnu7nI6fd01ksRPLuHBqIo6vEXoTgm9OTDJk2UGWWwL/BJF2v6r1N58zqVinAzI
         6J4g==
X-Gm-Message-State: AOAM532j+ZgTocEt81VgpOdfxaIv2s8IfDwbH33EbfKi9r8z7sMIFx+R
        AUR9qIDNEB26swS2ptPC1xEJ5FqM1c9v/A==
X-Google-Smtp-Source: ABdhPJzSTf0eBAu++84mtrKXy6BMMfp3zUf7357zP4WvhNfE0jw6QcpTMw+rwlXO7ok9zr2XQEMtbg==
X-Received: by 2002:a17:906:c151:b0:6e8:9cbc:ac04 with SMTP id dp17-20020a170906c15100b006e89cbcac04mr6380579ejc.423.1650030753448;
        Fri, 15 Apr 2022 06:52:33 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j2-20020a056402238200b0041f351a8b83sm2623235eda.43.2022.04.15.06.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 06:52:32 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nfMNE-005fXB-8Z;
        Fri, 15 Apr 2022 15:52:32 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3 25/29] CI: set CC in MAKEFLAGS directly, don't add it
 to the environment
Date:   Fri, 15 Apr 2022 15:47:22 +0200
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
 <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
 <patch-v3-25.29-1268792233f-20220413T194847Z-avarab@gmail.com>
 <CAPUEspjT23rqBwkgARf90me1n0dd4pjS4i+ya=Vo=xCBCTjp4g@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAPUEspjT23rqBwkgARf90me1n0dd4pjS4i+ya=Vo=xCBCTjp4g@mail.gmail.com>
Message-ID: <220415.86k0bqbgin.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 14 2022, Carlo Arenas wrote:

> On Wed, Apr 13, 2022 at 12:52 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> @@ -160,13 +169,23 @@ linux-TEST-vars)
>>         setenv --test GIT_TEST_WRITE_REV_INDEX 1
>>         setenv --test GIT_TEST_CHECKOUT_WORKERS 2
>>         ;;
>> +osx-gcc)
>> +       CC=3Dgcc
>> +       CC_PACKAGE=3Dgcc-9
>
> not sure when this was broken since there were too many refactorings
> around this code, but this is definitely wrong.
>
> macos' gcc is really clang, so if we really want to build with gcc
> instead (and there are 9, 10 and 11 versions installed) need to use
> instead (for version 9, which was what was used originally and what
> CC_PACKAGE was installing if needed)
>
> CC=3Dgcc-9
>
> Right now both macos jobs are using clang, regardless of what the
> nicely named label says.

I didn't know gcc on OSX was clang, that does seem broken.

But unless I'm missing something that's already been the case on
"master" for a while, i.e. this is the master run showing that we'll
invoke "gcc":
https://github.com/git/git/runs/6031562726?check_suite_focus=3Dtrue#step:3:6

And "seen", with this change, which shows that we'll do the same:
https://github.com/git/git/runs/6031564900?check_suite_focus=3Dtrue#step:5:7

If I understand you correctly both are effectively a NOOP and we don't
use that "gcc-9", but we should.

It looks like it was broken in my 707d2f2fe86 (CI: use "$runs_on_pool",
not "$jobname" to select packages & config, 2021-11-23).

I'll fix that as along with any small follow-ups after this series,
sound good?
