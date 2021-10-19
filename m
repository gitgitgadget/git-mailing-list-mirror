Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC36C433EF
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 23:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABBFD610FC
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 23:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhJSXOh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 19:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhJSXOg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 19:14:36 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460FCC06161C
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 16:12:23 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ec8so19126542edb.6
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 16:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=HUjp3pkoRoHTrzCA4pwwS1IWXV44jGyIyORIH4ag0dc=;
        b=WdSCKcBedX3JbtcXfKqXunH1B1jnzNtXwQfm8w2ZMk28z97cTeHuVX4qguEgR5qGWg
         IxdxrdwAAAJbbWiB+bcsNlbqX082fk5FDDyxRK+24yy9SOiMVyuYIlxZGBjuGfBZQuHz
         arIoKMAA0x0VBAxnPJ+cgB1Nl8i/eN4huyposxm+XJyAagNz6XxO+AsWpm/8sy1HgyaI
         2jgOS5w/LbjH9jOWLoGsVA3D4rNINOdQDlfUpdE/QrBwcaXgUz2KK71kTofoCt1FVdGL
         w6aH3HQQd58zSHoKqgDYAy06VF8F6OrxbAMuA0CO8V0qxI7nRjjmaOBjPzYpdpySBiVa
         48mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=HUjp3pkoRoHTrzCA4pwwS1IWXV44jGyIyORIH4ag0dc=;
        b=xU/ZuMuYahbE4qa+GPl8xNZd4RFRbZdWxUqN1FTPnhdc4S9phCjVr3mBfFD3gW5ZYY
         SMfH8ktAUd5Y6ABqaC4m7ZsA5exdN/nbklUrqVy+RAY70pDBO2Ken+Xdzb+RfveK2ezr
         zZQpzxsze1411LvWvVttsy++WAM/CbP6sINAdOWxsou9Y3MyKXYMXxhHkshIi7wECxP7
         dGLv65KTeqqWOCGpVrl6aDJBfuudop5bYM1/2DVurHDPFg5ahNuWL0OE3I2C8M65d1p3
         2is9+OwouY/n5tcrHcRC2RLuA4dRzlLO1uPG3iGpMeNGI1qw5PZI5e/jN+VqCvH7FNDi
         8RHA==
X-Gm-Message-State: AOAM5321D52q0pJhRDQo0iOGDK+g+eZSNU/4LlNky4uNSKNt9rCBL40Z
        cCfStKuF8w2+Bmvn/GwlRgJI8Dr2KLSG5g==
X-Google-Smtp-Source: ABdhPJxUcEcAIA2JBCibvfKesBVWZMk2mFoUdQaOmuUwLC54z31OWupcHNJH4girWpWHF5gkIGVMUA==
X-Received: by 2002:a17:906:4950:: with SMTP id f16mr40416236ejt.297.1634685141531;
        Tue, 19 Oct 2021 16:12:21 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id au26sm135250ejc.53.2021.10.19.16.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 16:12:17 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mcyHI-000ayF-W9;
        Wed, 20 Oct 2021 01:12:17 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 01/13] hook: add 'run' subcommand
Date:   Wed, 20 Oct 2021 01:08:14 +0200
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
 <patch-v2-01.13-ba64faf0580-20211015T093918Z-avarab@gmail.com>
 <YWmrL/POUE8P8Od1@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <YWmrL/POUE8P8Od1@google.com>
Message-ID: <211020.86mtn4obhr.gmgdl@evledraar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 15 2021, Emily Shaffer wrote:

> On Tue, Oct 12, 2021 at 03:30:26PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>>=20
>> In order to enable hooks to be run as an external process, by a
>> standalone Git command, or by tools which wrap Git, provide an external
>> means to run all configured hook commands for a given hook event.
>>=20
>> Most of our hooks require more complex functionality than this, but
>> let's start with the bare minimum required to support our simplest
>> hooks.
>>=20
>> In terms of implementation the usage_with_options() and "goto usage"
>> pattern here mirrors that of
>> builtin/{commit-graph,multi-pack-index}.c.
>>=20
>> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>> diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
>> new file mode 100644
>> index 00000000000..660d6a992a0
>> --- /dev/null
>> +++ b/Documentation/git-hook.txt
>> @@ -0,0 +1,38 @@
>> +git-hook(1)
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +NAME
>> +----
>> +git-hook - run git hooks
>> +
>> +SYNOPSIS
>> +--------
>> +[verse]
>> +'git hook' run <hook-name> [-- <hook-args>]
>> +
>> +DESCRIPTION
>> +-----------
>> +
>> +This command is an interface to git hooks (see linkgit:githooks[5]).
>> +Currently it only provides a convenience wrapper for running hooks for
>> +use by git itself. In the future it might gain other functionality.
>
> s/git/Git/g nit, no? I thought we were somewhat picky about capitalizing =
Git
> when we don't mean `git`?

I'm not sure how this got mixed up, but the text you've got quoted here
is from the v1 at:
https://lore.kernel.org/git/patch-01.13-a39c0748d3f-20211012T131934Z-avarab=
@gmail.com/

But you're replying to the v2 here, i.e. this, which has no such text:
https://lore.kernel.org/git/patch-v2-01.13-ba64faf0580-20211015T093918Z-ava=
rab@gmail.com/

I see I managed to omit the In-Reply-To link from v2 to v1 by mistake,
maybe some funny mailer interaction with that?

Anyway for all the rest of the comments below & in this thread I tried
to address them in some way, re-rolling soon...
