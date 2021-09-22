Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A430EC433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 11:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CC8E6109E
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 11:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbhIVLJq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 07:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbhIVLJp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 07:09:45 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFB4C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 04:08:16 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g8so8383599edt.7
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 04:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=x8I6N9wQJzPwazLiBvz+VX4YWmuZgL/mOeuVpVvTJso=;
        b=odjUosBpU4jPsRYwhyxj6dF3YUx33Vkg1hdc4OfjntQstF0BHWc3/eN65t5psjmqMT
         BiTOe+6aWV0wja1+XRPsiyptw1RJxuNP9aITrfIxuwlk9iLVLlfex6U+PE8oDUktJXYF
         i7F9n58eYkFeovpVqYVDTiE5g0E6BdNZR/7fHG41Xl6wJDiudh0QAmpG2iSpyMOc82PM
         PF/w07fjuSO5eb2MdQCcjUsutgDkmPs0kRJjci5ul4UHYMpEsKwXjYSwNkFhQX24RZLv
         OzPq7QmtKrHmYUPtXal7hgwekQeaQK5y8XUp1ulLYQX7zNjeXseCtX2ngrNePmAsEb8j
         3exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=x8I6N9wQJzPwazLiBvz+VX4YWmuZgL/mOeuVpVvTJso=;
        b=Sok3wae9g+E7kzH7wBUyqmP0Nw780TQhSMJVi3cxwD89Np3l16LiJKufViKjja0kq0
         PzqlHMNATRGvzkRNB8K5tu3+afqGQOiW0I2iYmdsLK/Pie8jAr9LtfsbA93mFM0nDqOa
         a2My/mdyM4U/21xbCsVxiwNz+YpeRuMAg5Yl36J4nGhnQ8H7IhLEbHCe60o1BvFWMHN+
         2d/HPjY0iu2aIMco/QyznpRDovT64KcEvV7RfrVBNCvl1OnIh9Lx/OJLCy97S24dLapI
         lrkhOAhh/dqeum3ZUF4ORlz4YoOR08cuGq8ywuLYmDnITTs7TrcZN8Rkv40zKubSFmbW
         Yk4A==
X-Gm-Message-State: AOAM533uF/JscImMmmlpoC1GLjUuzGvpt1e+tw/XES5GP6q/FQtwCpm/
        09MwsXWUQGBxE/bfDqoIncEFcjFqUktUYg==
X-Google-Smtp-Source: ABdhPJwdT/n4mBUzoUkQn5c+LTRtPP0L7y2nILkQTR9sTZIJbfRK5q1nL4zekCNoOZzjuvS2GLCWFg==
X-Received: by 2002:a05:6402:1ac5:: with SMTP id ba5mr41833904edb.20.1632308894421;
        Wed, 22 Sep 2021 04:08:14 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r26sm903589ejd.85.2021.09.22.04.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 04:08:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Makefile: make COMPUTE_HEADER_DEPENDENCIES=auto work
 with DEVOPTS=pedantic
Date:   Wed, 22 Sep 2021 13:04:48 +0200
References: <patch-1.1-6b2e9af5e67-20210922T103749Z-avarab@gmail.com>
 <CAPUEsph8TYokqLmiZjvu3VgmzLh4AFhp+0vh0nv+2+m351=n_A@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CAPUEsph8TYokqLmiZjvu3VgmzLh4AFhp+0vh0nv+2+m351=n_A@mail.gmail.com>
Message-ID: <87o88k7tr6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 22 2021, Carlo Arenas wrote:

> On Wed, Sep 22, 2021 at 3:38 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> The "COMPUTE_HEADER_DEPENDENCIES" feature added in [1] was extended to
>> use auto-detection in [2]. Then when -Wpedantic support was added to
>> DEVOPTS in [3] we started passing -Wpedantic in combination with
>> -Werror to the compiler here.
>
> It is my impression though that header dependencies computation is
> something that might only work in gcc and clang (because of its gcc
> compatibility), so shouldn't this be restricted to those compilers
> instead of forcing all others to error?

I think it's better to just have those not supporting
COMPUTE_HEADER_DEPENDENCIES define that, wanting to auto-detect things
is what led to the current breakage.

I.e. our whitelisting of GCC and Clang will be out of date if some other
compiler grows support for this, and even if we whitelist gcc and clang
we'll need some script like detect-compiler etc.

> Also, why is this process run with DEVELOPER=3D1 to begin with, if we
> obviously don't need/want any compilations warnings?

Hrm? We run the COMPUTE_HEADER_DEPENDENCIES=3Dyes process with and without
DEVELOPER=3D1, it's just that DEVELOPER=3D1 breaks it since it turns on
pedantic compilation flags now.

We want -Werror for the actual compilation under DEVELOPER=3D1, but a
one-off command to see if a compiler has support for something is
entirely different.
