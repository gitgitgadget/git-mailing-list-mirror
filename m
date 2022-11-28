Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733A1C43217
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 12:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiK1Mru (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 07:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiK1Mrm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 07:47:42 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EFF114A
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 04:47:38 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id td2so11371431ejc.5
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 04:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ajpMRTgHX9zdYCCiYmmd7K5V8om0Ac/YpmMRLbD9ayc=;
        b=Kq7z8xaJ4Pju8Owky/b6nJ0/J8ZccCuG+F1ssF+yHKgjVYzgcaVXG+N+H+r6Ju7UcR
         AwBemxKj9IsPVwoJThlXyHdL8RmXILGTHTih6l6HXc261NYgfQ9i5LCU5yb391Nlk1HV
         g7DjJkcuOuWPgR66g8jXnOdPufAET1vMJfyrnyXeZYD7P0mJmyHnr/VURJhRYvVdEsyx
         /OvGOOPYEU/kC32FKdxSPBhghRhqARLUQcvHCxfPDUurZBYJt5kYDDggC52J0L6TtiG+
         awi6+fp/0KJDUPOMrNqyEQJ7FI9HdF/IkiYznA0NTFErJL+/97vdimpzPu1WDS+06UPy
         Q42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ajpMRTgHX9zdYCCiYmmd7K5V8om0Ac/YpmMRLbD9ayc=;
        b=yoYz/lyck70JxxSzJ1Sy+NiQEn/at2Arom9bUgSc+3GnTj2bR5tDt6ipHzXlDT0AIM
         vBWyo4f1jxEumu1FlXZaiY6MYKayoZW9X+torh5yCuTEzg0v7mKCqY4lndRrBdFXr+gz
         JClDhvPLC1d/WZEKy00Gx71SA18UMUY8niXEnCjfIRmWQcv0Gn5XLbOJN4p4gx54Cdm6
         57PtEOGhwPIS6WVqURsZtL1QCXbP2okR3g4czg9Tna5w31i/wyokCO0bMlAtenSp7x52
         JAZtQ3KUxHRQ0rxhZro36b/BJkHZVZ6JsASwgPvqnBp5WsbrAr5KVpdirbp3bd5bWnnX
         Mi4w==
X-Gm-Message-State: ANoB5plYmMnFjmTX2LIvJGhxz4LHQcAc/UlNAzlwWOfn5wk0yrkN3ZOn
        St0wa0NCV9NInNuKvrBpiJCTOqr4XO8xpQ==
X-Google-Smtp-Source: AA0mqf4bh8HJaCSF59lYilUAXTtrvf+3dKxdKl6LYtDeG5mbneuNpSs6Lps8pxIQvNd3hgSwviVmUQ==
X-Received: by 2002:a17:907:c24a:b0:7ac:2e16:bc31 with SMTP id tj10-20020a170907c24a00b007ac2e16bc31mr3891358ejc.242.1669639656541;
        Mon, 28 Nov 2022 04:47:36 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id j14-20020aa7de8e000000b004616b006871sm5140040edv.82.2022.11.28.04.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 04:47:36 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ozdXr-0012Ow-2I;
        Mon, 28 Nov 2022 13:47:35 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "signal@dynax.at" <signal@dynax.at>
Cc:     git@vger.kernel.org
Subject: Re: making use of $sm_path @ git submodule foreach
 =?utf-8?Q?=E2=80=94recursive?=
Date:   Mon, 28 Nov 2022 13:43:08 +0100
References: <70ED2ECF-DAF1-4CCB-9E05-2599211F3569@dynax.at>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <70ED2ECF-DAF1-4CCB-9E05-2599211F3569@dynax.at>
Message-ID: <221128.86r0xnkzyw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 27 2022, signal@dynax.at wrote:

> Hi,
>
> when using=20
> git submodule foreach =E2=80=94recursive [..]=20
> $sm_path contains only the relative part of the latest
> recursion. Since the command has no generic way of knowing from which
> recursion level it is executed any $sm_path of deeper recursion level
> is useless unless there is a way for the command to find out from
> which recursion it is called.
>
> I suggest $sm_path should be extended to be relative to the repo from whe=
re the submodule recursion started or another variable should contain the r=
ecursive part.
>
> Viele Gr=C3=BC=C3=9Fe/Cheers,
> Hagen.

I think it might be sensible to have a $super_prefix_sm_path or
something which does what you suggest here.

But the current "$sm_path" is far from useless, it's just not useful for
what you're trying to do.

When we run a command in sub1/sub2 or whatever the "$sm_path" will be
"sub1", then as we cd to "sub1" it'll be "sub2".

You want "sub1/sub2" there, but a "sub2" is still useful, because we've
chdir()'d to the "sub1" at that point.

So you can e.g. run 'git -C "$sm_path" log' in your 'foreach', or
another command that expects to get the *relative* submodule path.

If we simply changed how "$sm_path" works that would break, and if we
"fixed" that by not chdir()-ing from the super-project we'd break even
more things, as e.g.:

	git submodule foreach 'git pull'

Or whatever wouldn't behave as you'd expect.
