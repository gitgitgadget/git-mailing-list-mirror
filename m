Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06369C433EF
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 02:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348633AbiDOCYg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 22:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239639AbiDOCYe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 22:24:34 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664CE4091F
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 19:22:08 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id c4so3066624vkq.9
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 19:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xEgEyTQuiMFY4mGWMr6V0MX/+ourL9mlLfpFOk7n+Ec=;
        b=E2zVEJwvrEMMHWPB/s1fKJ5/lLc2wM1ShKDzva1crXt79k/amViAaDMwOTGQmqD4wl
         FVeupZB1ycPCbC/PzDnOUU+pSj4GvgMkVcT+gw4PrKMi5wIqpS6TvPPD1lyv+PjHHIgc
         pzEzjxIhfWeUvVvAZLE4TtDWc91114TQin+8WJytxm887mj7DarWSB9sVxttVYCFr8ph
         rmxK4B62Vl9SWdFU73w9lkGBN/wkjH82VaF2MBffYgCVU+I2HFdNYPBchfzIx1tg3b5I
         JLBNFMYXE0DJ9GAI7mO9phYX21IgmYqII8tfWZm5n/+KsUaCD+UJdEq43d0DFzEI9uQM
         HLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xEgEyTQuiMFY4mGWMr6V0MX/+ourL9mlLfpFOk7n+Ec=;
        b=NU5pRJGdwPOPBf3qI6MDtVsfCETvYdh+uyCNshVXyYwfFfLkOQ1Ra3b0SI1CiqYdvJ
         Li7gNpmdlWrF/Z7zLT108okmXTh8PD2hQgGRDW8kF/wIK7NZOq9EeWFqtRe5PeE71JZ7
         HeJUYJhRxV+I44CD6pPHvT+V918GBmwaFoNkn5t8CQcqKgZKuTtqL7Y2P4Wh5sxPBzAP
         782r3Q/4P1K4JKr/XoEBQ+T8xj+sW+hMza89Xdsz52cNvKuGkD2Jvu7G3YF3USJ+9CR2
         ZUC5PKE6sDPE3ikKcQIRvz87paRov+sb9+iO5VcqDFk/UWlX1nZ2qjGKZjiVtTVqLPM1
         u1RA==
X-Gm-Message-State: AOAM530yKNNRj6EY34FNbzEco34RZz9f5lTiTCKNNZM526jKdxvv5u3/
        Zk1ndCkvbSiiECZyVusKYdvC13YBiPU+N6iLtDY=
X-Google-Smtp-Source: ABdhPJwgmAgWNL3Cia3kFdpl8XCG1HJYoMz9hhxAEkjRZ0xjIGxxCH5YPxxqvGgFOvmxtO8Ny6XsPxPGOcReD9WSx8w=
X-Received: by 2002:a05:6122:118f:b0:348:f961:5814 with SMTP id
 x15-20020a056122118f00b00348f9615814mr2372346vkn.14.1649989327386; Thu, 14
 Apr 2022 19:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
 <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com> <patch-v3-25.29-1268792233f-20220413T194847Z-avarab@gmail.com>
In-Reply-To: <patch-v3-25.29-1268792233f-20220413T194847Z-avarab@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 14 Apr 2022 19:21:56 -0700
Message-ID: <CAPUEspjT23rqBwkgARf90me1n0dd4pjS4i+ya=Vo=xCBCTjp4g@mail.gmail.com>
Subject: Re: [PATCH v3 25/29] CI: set CC in MAKEFLAGS directly, don't add it
 to the environment
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 13, 2022 at 12:52 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> @@ -160,13 +169,23 @@ linux-TEST-vars)
>         setenv --test GIT_TEST_WRITE_REV_INDEX 1
>         setenv --test GIT_TEST_CHECKOUT_WORKERS 2
>         ;;
> +osx-gcc)
> +       CC=3Dgcc
> +       CC_PACKAGE=3Dgcc-9

not sure when this was broken since there were too many refactorings
around this code, but this is definitely wrong.

macos' gcc is really clang, so if we really want to build with gcc
instead (and there are 9, 10 and 11 versions installed) need to use
instead (for version 9, which was what was used originally and what
CC_PACKAGE was installing if needed)

CC=3Dgcc-9

Right now both macos jobs are using clang, regardless of what the
nicely named label says.

Carlo
