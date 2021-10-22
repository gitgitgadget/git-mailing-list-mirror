Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DFDC433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 22:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A03F860241
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 22:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhJVWyc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 18:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhJVWy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 18:54:29 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BD0C061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 15:52:10 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y12so6508442eda.4
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 15:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=3XniM6BKRVtkYtyoQUL4hMgLREGk3rFkCg8nhc0Ia/k=;
        b=kzXXgyTszp89bFlKedcNc8S1NPxdMC3KOu4vWB4FyFAt4DHC0NDd4Eptw1AF6bx2rm
         Coa2RB2jd3IgiuOiA0X2Qz2ZgYy0xI7+RpHwvJy7x4JRxZxrI32Wt9fXNBecFlU3Uz3K
         AL9e8u2q/Bpb1Wk+4FQvolYi51d+yWNL+11QsOzUPPNOVIylKnBdaoXiMixsOAxhLiun
         +qpG57FuEBWx7wu8w5269yp0jhLIN8trMG6cKj7RziQz7tg0gK1rwcFjADvZPb5uVfnl
         67v3Cymwf84nL4/ii0OMzny6dKuBv9qHP0jVALfeh53Ru4BNivg8JLzWoswdWsjEs4Fo
         D+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=3XniM6BKRVtkYtyoQUL4hMgLREGk3rFkCg8nhc0Ia/k=;
        b=55+oM5hVpNZyLCQ9gtctWDOxjj6dNp2s0B/lBBKH/NDO7kD7yGA8ozv2yWwUgpez8a
         AV9tMllRJwvyzYlOQYvE/C6Q36hKAycqgpwSTh4gg9AAhLZEoXwzLijBbngqBGQ2SGvy
         ZSh/We5DxmjDLQbDE2TZu66OjH4Pj5T6YyMn+6R+j3MjIkEgFcIqcBMCVOa7BQ4LENsd
         lUlmcNcZEWvwjj6sIBFIFwPm51/yiyEGTLadtiYFGbLwbO4TGZLLtFjiAsW7HfNSOAHK
         IOpqfSxo2gkHlnjmFrarMULFqn8MhMEK6z7m+vIYfPTtij2raz5504oQKZd81yhixtRG
         SZoQ==
X-Gm-Message-State: AOAM530ZyY7Ko9IXeVRPRpPC0oAOeBHM4touvlPqX/MrMv0Oh2DV8vzS
        6P95EQNKqpoNTJvP5rkzDUQ=
X-Google-Smtp-Source: ABdhPJw0PLv96cDaaPcl1vLaFOa7Cr+H8hW8o+UAF/RNSR0DYle9AHrSXNGAJqwfoSp03lblGZ1o6A==
X-Received: by 2002:a50:e041:: with SMTP id g1mr3863677edl.4.1634943129446;
        Fri, 22 Oct 2021 15:52:09 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id jg21sm4476111ejc.14.2021.10.22.15.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 15:52:08 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1me3OR-001OUV-Ii;
        Sat, 23 Oct 2021 00:52:07 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 2/3] config.c: don't leak memory in
 handle_path_include()
Date:   Sat, 23 Oct 2021 00:30:33 +0200
References: <patch-1.1-5a47bf2e9c9-20211021T114223Z-avarab@gmail.com>
 <cover-v2-0.3-00000000000-20211021T195133Z-avarab@gmail.com>
 <patch-v2-2.3-d6d04da1d9d-20211021T195133Z-avarab@gmail.com>
 <xmqqmtn2gdlv.fsf@gitster.g> <211022.86ilxpj7si.gmgdl@evledraar.gmail.com>
 <xmqqh7d8eox7.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <xmqqh7d8eox7.fsf@gitster.g>
Message-ID: <211023.86wnm4isfc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 22 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> Not a problem introduced by this function, but if you look at this
>>> change with "git show -W", we'd notice that the function name on the
>>> hunk header looks strange.  I think we should add a blank line
>>> before the beginning of the function.
>>
>> I think this is a bug in -W, after all if without it we we show the
>> function context line, but with it we advance further, then that means
>> that -W didn't find the correct function boundary.
>
> That's a chicken-and-egg argument, and I do not think it is a bug in
> "-W" nor the funcname regular expression pattern we use.  We expect
> a blank line there and the pattern reflects that expectation, so not
> having an expected blank line is what causes this problem.
>
> In any case, we should add a blank linke before the beginning of the
> function, and of course that is obviously outside the scope of these
> patches.

Sort of, if you were running with the patch I posted at [1] you wouldn't
see the bad value at @@, but we still extend upwards with -W, which I
consider a bug.

I.e. both the current context we display and the over-extension there is
ultimately a symptom of the same issue, which is that what we're doing
with -W gets conflated with behavior that makes sense without -W, notice
how if you do "git log -W" on anything that the @@ context we display is
the prototype of the function /above/ the one you're likely looking at
the code change in.

So the blank line is the cause of the over-extension, but we'd still
show the (IMO) incorrect context in either case.

Anyway, as you say a discussion for some other thread. I've been meaning
to get back to those patches at some point, the first problem is that
our test coverage for what function context we should find when is
really lacking, so any changes in that part of the xdiff code are likely
to break things. I had those tests, but they got lost in some
bikeshedding...

1. https://lore.kernel.org/git/20210215155020.2804-2-avarab@gmail.com/
