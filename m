Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC01C07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 11:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 408F46145F
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 11:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhGCLan (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 07:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhGCLam (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 07:30:42 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D3DC061762
        for <git@vger.kernel.org>; Sat,  3 Jul 2021 04:28:07 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ga42so3513719ejc.6
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 04:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=et8NKH9Gt2gRrovLpGYk+m8NMSsn1NuAkhQRSI6ULjI=;
        b=pxg+8uqF6RpjqjlY0IyyYP0UQqFqP54DjwL2s/Pj5x7HWt89+WlTf/mrRhzMEan2/3
         xMde0UjPU3+SlTRtkJgwlzyacdy61p1qiVnje5yqvU36Ac5HTCRiKYJHVWWKMA0OWnFu
         t9rXVVUbqrJbgy59xrS6JhW7jYPuyBnWyoItxY52HOrTBrLU2b012U5GbyXkc/aKeXXn
         3rUewqromqFPfl2pwvXo21GJm49C/kU+DTQliXOnppiKMLATC2qrProfzzgCOIigkJAj
         9wNRXZ0Xdxm/3iv488B7aLd8bc3DA9VIgDFjvbEgN+OVNI2dv95SyusH6XUgwOl62vsi
         2OHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=et8NKH9Gt2gRrovLpGYk+m8NMSsn1NuAkhQRSI6ULjI=;
        b=rfvtbFUs3DS6C5HB7UKg57MVaNocSKDNbpTSyq9EO6yOeEVgygiMR/MRUgZL/hqmEG
         q2Q2FGjkBDy5ALeDHHHbANjJegWOceZEWJgcSTt8qSy4a+snpoL8aWFLQg0xpmsCWI5J
         uhVef4/Wdjnb38hvSeWXEJAN7uYqv72SSP17VOjyB9D4rLcgvA/3wMwzI9GXANQSVfel
         wqdOoIF0IcjX3KSyhyDxjO6ynpirqtngT+4GFkxH5EwFhryLt3IsUR2yc82N9cP7HhIv
         vgcwmJ40WKn4Hhrc60qkcHL9Gzxid6l8bUIoRiavBlSyU0nclxJj/mhu3seRHCvlzcdJ
         J+qg==
X-Gm-Message-State: AOAM533fAVnQ8MjVucHFPGg5y0BLyntdT/75l2dfSuvJkFN78TASmvex
        Ovx0037jRw4hlcANlUTO/Nw=
X-Google-Smtp-Source: ABdhPJxc79Z2ytePaIASBmjpkSAbzvC7P+EefRCJVPaYzwEcsxBag1C+iIvFnuh23f7npkeAXHDA8Q==
X-Received: by 2002:a17:906:bb10:: with SMTP id jz16mr4442324ejb.252.1625311686371;
        Sat, 03 Jul 2021 04:28:06 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id eb9sm2099800ejc.32.2021.07.03.04.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 04:28:05 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     skottkuk@wp.pl
Cc:     git@vger.kernel.org, Atharva Raykar <raykar.ath@gmail.com>
Subject: Re: Logical bug during MERGE or REBASE
Date:   Sat, 03 Jul 2021 13:03:50 +0200
References: <1932019063.20210702192555@wp.pl>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <1932019063.20210702192555@wp.pl>
Message-ID: <871r8fab7e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 02 2021, skottkuk@wp.pl wrote:

> Hello.
>
> I got a strange result in the process of "merge" and/or "rebase".

Atharva already replied to most of this, just adding on this point:

> [...]
> But as for me, it would be logical to consider the construction inside
> {} as something whole, and not just put all the changes into one heap
> with notification what all OK, no conflicts.

Git in general is not aware that your programming language considers {}
to be special, we don't try to do language detection, or to semantically
parse the program.

It's a general merge driver on text lines that works the same whether
you have a language like C# that uses {} braces, or a language like
Emacs Lisp which does not.

There's particular common cases where this logic goes "wrong", I've run
into it the most with repetitive declarations like:

    {
        {
            description =3D> "some thingy",
            callback    =3D> function { foo },
            strict      =3D> 1,
            warn        =3D> 1,
        },
        [... lots of these omitted ... ]
        {
            description =3D> "other thingy",
            callback    =3D> function { bar },
            strict      =3D> 1,
            warn        =3D> 1,
        },
    },

I didn't bother to check this specific example, but in cases *like that*
the merge driver will often append "duplicates" when two branches added
the same "other thingy", since the boilerplate at the end (or beginning,
depending) is repetitive, so a duplication becomes indistinguishable
from an addition for a na=C3=AFve merge driver).

You can define your own merge driver that's aware of your language, I
think this is probably a too complex and Bad Idea in general.

Custom merge drivers are very useful for e.g. the git-annex case, which
ends up merging really simple "log" files. merges there are always
equivalent to basically a "sort -u". I.e. keep all lines added, remove
duplicates.

But for a programming language a "smart merge" is, I'd like to submit,
simply an impossible task. Even if you had perfect AI you couldn't do
it, even if I had a clone of myself from yesterday we probably couldn't
agree on how to solve all merges.

That's because once you get past the simple cases a merge resolution is
something that requires judgement calls from the programmer. E.g. I
worked on a topic branch, and now I've got a conflict because someone
changed the function signature. I can either do the bare minimum and use
some compatibility interface today, or convert all my work to the "new
API" and not have to convert from the legacy API in the future.

Either one would be a valid resolution, which the perfect AI, or even my
clone from yesterday might do differently.

But most importantly having a textual conflict in a program when you
merge/rebase is almost always the trivial case, having a semantic
conflict is something you always need to check for.

Git (or merge tools in general) can't help you with that, because your
"conflict" is in a conflict between the expectations of your topic
branch, and whether or not they hold given whatever's happened on an
advancing upstream.

So whether you have textual conflicts on merge/rebase from git or not,
your workflow really should be to always assume that you have a semantic
conflict, unless you're already completely familiar with the new code
you're merging into your branch.

I.e. after a merge/rebase look at your patches again to see if they make
sense given what changed on the upstream, compile, run the tests you
have etc.



