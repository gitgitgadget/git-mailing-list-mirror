Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0341CC433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 08:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB4D160C3F
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 08:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhDZIYA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 04:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbhDZIXw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 04:23:52 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5DCC061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 01:23:09 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g14so4976213edy.6
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 01:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:message-id:references:user-agent:in-reply-to
         :date:mime-version;
        bh=8osKDcl3OFA9i25Cm3/v8TLEEANGHz+wYSBT1GGvbgo=;
        b=jm6F+bBnsmEhFxQEOZ3NFZYFS1KiTudSVxMGa/Axe7zgDZEPdVCgmzFkMDkLqu1EVV
         hX4VNIKcwz9JV5NrioRMdUa+oIYWjsCXVUndT8N0xSCv/Y+SUass2N/CWw/yP/Zo9d4M
         uV7h5jeBgpuVnVDQranORK6rxrFl+6Rd+nXWCm3jJdbBp+UVFNfh0TM1C/3oIac6pRqy
         kAWhnTkfwFXIjSTo2PfZEZiA9EWhW3jCFzZEsj/ZC61Hbr+egkvpaTvv0USHVWX+Mfro
         LOAZZ3pwT9bqlfES/+cEioTbejotB6hMaLlYC1WB6rva5mb4s1p1KQ8V6MX+BuaSzcxL
         w/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:message-id:references
         :user-agent:in-reply-to:date:mime-version;
        bh=8osKDcl3OFA9i25Cm3/v8TLEEANGHz+wYSBT1GGvbgo=;
        b=RHi7n0Zn4LRK/aG011ERAnD+mdnHvI7mceuxpPJ8LLjKI1+lAPx3AcOJo1MdMMgMqX
         a+HE4p4j3a0flTuQCFDAtjYb6oI9Z3gKM22ivX3PGgva2SUdWpYi13XKyUnL5l5KhzEc
         Fx0EHE25MuyBmSRu2FftkAbSDtIpy2LGSWb9O+p1EBH3h9CxN0IPex4z6IsFvs8aTZ4z
         flaDRefK9kJp481aLp4AV1JRGYebFTx+0gYIypIgQve8wRylbRTROV4H2u2kvF7XMtEu
         FZ4e3Ab54531X4VqZHWFw9C045VqZZjqqM9PEiobWk5I6QaRuBaa69D3IoBXZD2WIf9u
         fvuQ==
X-Gm-Message-State: AOAM530Vxlc1Sge6ooNtjkaydkGlDREujf6L8rw8+7bfKlJx0cZbcNGa
        c83Qm23i2XZBOOONGNsP0Cs=
X-Google-Smtp-Source: ABdhPJyQ6etvsNsEKB2Nl8sRaJsG+HjYBY+2Lt43cQ38z7Lailv5+sPZ0W6KTe+UA+wQbRYr4ex3Jw==
X-Received: by 2002:a05:6402:35d3:: with SMTP id z19mr19542958edc.143.1619425387922;
        Mon, 26 Apr 2021 01:23:07 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id j8sm3625935edq.67.2021.04.26.01.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 01:23:07 -0700 (PDT)
From:   =?us-ascii?Q?=3D=3Futf-8=3FB=3Fw4Z2YXIgQXJuZmrDtnLDsA=3D=3D=3F=3D?=
         Bjarmason <avarab@gmail.com>
To:     Shoaib Meenai <smeenai@fb.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] ** glob pattern in git diff doesn't match root directory
Message-ID: <87k0oq21md.fsf@evledraar.gmail.com>
References: <79834D18-EAF4-4748-9B96-38AAA0760499@fb.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <79834D18-EAF4-4748-9B96-38AAA0760499@fb.com>
Date:   Mon, 26 Apr 2021 10:23:07 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 24 2021, Shoaib Meenai wrote:

> Hi all,
>
> When I use a `**/` glob pattern with `git diff`, it doesn't seem to
> match in the root directory. The documentation for gitgnore says that a
> leading `**/` should match in all directories, and I would expect it to
> behave the same way for `git diff`. For example:
>
> $ git --version
> git version 2.31.1.527.g47e6f16901 # built from the `next` branch
> $ mkdir /tmp/globtest && cd /tmp/globtest
> $ git init
> $ echo foo > foo
> $ mkdir sub
> $ echo subfoo > sub/foo
> $ git add .
> $ git commit -m 'Initial commit'
> $ echo bar > foo
> $ echo subbar > sub/foo
> $ git --no-pager diff '**/foo'
> diff --git a/sub/foo b/sub/foo
> index ef7889f..2b2ab6c 100644
> --- a/sub/foo
> +++ b/sub/foo
> @@ -1 +1 @@
> -subfoo
> +subbar
>
> Only the diff to `sub/foo` is printed, whereas I'd expect the change to
> the top-level `foo` to be printed as well. `git diff '**foo'` does behave
> as I would expect. This also happens with a `**` in the middle of a
> pattern; e.g., `sub/**/bar` will match `sub/dir/bar` but not `sub/bar`.
>
> Am I misunderstanding how `**` should work, or is this a bug?

It's not a bug in behavior, but reading the documentation I think it's
buggy in describing how it works.

The behavior of ** here is to match anything, including a slash, but you
yourself are providing the slash with "**/".

This behavior is different under :(glob) where we would match "foo" on
the top-level.

See t/t3070-wildmatch.sh, is particular the "**/foo" test-case.

We adopted this code from rsync originally, I think its manual page is
better at describing how it works, as an aside I see they've since added
a "***" which we won't have, and maybe some other features.
