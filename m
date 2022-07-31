Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB87C19F28
	for <git@archiver.kernel.org>; Sun, 31 Jul 2022 00:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbiGaAou (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jul 2022 20:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiGaAos (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jul 2022 20:44:48 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B6313D59
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 17:44:44 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w5so9746266edd.13
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 17:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Ldk7fUIoQVPqiyUbIKwBzm8LYvhUAFVD143RXKDV+JU=;
        b=EC+RPdh6HCDtix+lhGtAa+k4vJxpOX6jgMJIYg1bzguaRBv/xHtAnzy3AItQbtpe8F
         cp/0h+H3BgmE2bxLoDN0MRASuiC/eP9Y7FZGgTYgpSbYcX8/1GwLSQGMT4JMHMYREkTn
         eXZiugq2+NDgwoVMmOEFfGjqURRXLIf/4Cae8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Ldk7fUIoQVPqiyUbIKwBzm8LYvhUAFVD143RXKDV+JU=;
        b=O2ebJvUWpNl6Op4M41N6qd1+8Nkm7DalAcmiNSzNy5tRTgVy63M7Eq1CYW7kYQTPH1
         z/XU7fdS7eIAr90QuJO24Lmr+dd8GwSSMl+vHZ9Oo8AQOQAPI8NovIG96o/kuFOojqVG
         c6dFa9lZHavwFTFCO2cYaPTIQTyRCFzALlPIMZlDHJdW1ihZHPFemfyhh5MCa/6KTdP4
         pKegr1F0lGlwz1LPU9MGJK2pVlO44aLeroAkR6myIaye3bwPnnJyGdR8fnxG8u2QWk8q
         ZI8dPmgxGbMTDalJ0KuOd9zELFPgO14lnyWorRqYPglUWmE99GwSNNM6j8o44eIkjnr4
         +aTQ==
X-Gm-Message-State: AJIora+vFEY2o2y4htek+2+GDvxKBKI68l0vRQURGu7Ev1NGge5QkLgB
        g4RyelogMMpyEgBaTzr+aAAFrKJ+Skm8Ll/E
X-Google-Smtp-Source: AGRyM1tPEfmMGRjztyxII11/kvgFma97ltks5RTvZfvdRfUEYAJSPTe95IxqsikGpx8CtZmvuKuzmA==
X-Received: by 2002:a05:6402:26d6:b0:43c:ff17:7508 with SMTP id x22-20020a05640226d600b0043cff177508mr9720568edd.26.1659228282345;
        Sat, 30 Jul 2022 17:44:42 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id u19-20020a05640207d300b00435a62d35b5sm4571987edy.45.2022.07.30.17.44.41
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jul 2022 17:44:41 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id bk11so162092wrb.10
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 17:44:41 -0700 (PDT)
X-Received: by 2002:a05:6000:1a88:b0:21d:aa97:cb16 with SMTP id
 f8-20020a0560001a8800b0021daa97cb16mr6356829wry.97.1659228281277; Sat, 30 Jul
 2022 17:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh9f0EmsNFgoxUa8BzVej06+7MbLr-MLBjDjtj_=Pf90A@mail.gmail.com>
 <CAHk-=wg9LaHeg0UmZ90gLOaBpO-5fhoaH22iNNm=1eror95pFg@mail.gmail.com>
 <YuXKaLXhnR3mVlWk@coredump.intra.peff.net> <YuXLtIBXYG+JBKdV@coredump.intra.peff.net>
In-Reply-To: <YuXLtIBXYG+JBKdV@coredump.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Jul 2022 17:44:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5pfUcuaAUz=rifon9d51mshE7k6bkpMXddog0On9jow@mail.gmail.com>
Message-ID: <CAHk-=wi5pfUcuaAUz=rifon9d51mshE7k6bkpMXddog0On9jow@mail.gmail.com>
Subject: Re: "git symbolic-ref" doesn't do a very good job
To:     Jeff King <peff@peff.net>
Cc:     Junio Hamano C <gitster@pobox.com>,
        Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 30, 2022 at 5:24 PM Jeff King <peff@peff.net> wrote:
>>
> Hmph, maybe not. The sticking point was topgit, which points HEAD at
> refs/top-bases. There's a fork here:
>
>   https://github.com/mackyle/topgit
>
> which has been active in the last 12 months and which still uses that
> convention. So maybe people really are still using it.
>
> (Again, neither here nor there for your patch).

Well, it *is* relevant for my patch in the sense that I clearly didn't
think of all the crazy things people might have been doing.

That

     git symbolic-ref refs/heads/foo FETCH_HEAD

that you mentioned in the other mail would obviously be entirely
disallowed by my patch, and again, I didn't for a second imagine that
somebody would do something that strange. Junio mentioned a similarly
odd possible situation.

So while I think my patch is the right thing to do, I will also admit
that it's perhaps a "we should always have done this, but we didn't"
situation, and maybe those really odd cases need to be allowed.

Adding ALLOW_ONELEVEL would make those things presumably still work,
and would at least improve things *somewhat* - it would protect people
from syntactically invalid branches (ie bad characters in the branch
name etc).

That would imply still having to fix up that t4202-log.sh testcase,
and I didn't even know or realize about that REFFILES prerequisite,
since obviously in all my use it has been true. I still use and test
only on Linux..

You are also right that without the ALLOW_ONELEVEL, the special-case
check for HEAD should just be removed. That patch started out as the
minimal possible "let's just disallow invalid ref names" patch, so I
didn't touch that odd special case code.

Put another way: I think my patch is likely the right thing to do (and
I'd personally prefer the stricter check without the ALLOW_ONELEVEL
flag), but you and Junio are right about it being a bigger change than
I in my naivete thought it was.

So I won't really push for this, I suspect this needs very much to be
a judgement call by you guys.

Thanks,

                   Linus
