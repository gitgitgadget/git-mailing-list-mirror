Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A52FC433EF
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 09:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbiARJzf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 04:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236894AbiARJz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 04:55:29 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F06C061755
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 01:55:29 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id 2so10712636uax.10
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 01:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=27/qqlHSjPMexck06HTMXRVUdaYCAVgyqdAFeRpCXH4=;
        b=Sm6Wh/fOaQf+I+Nya44RowhD99sOTnKt6IM3rAfTQ9X4KNT3G3/kNwUoqgE06/GTs7
         Gq+bncbt8c4Bv4/fteAbcW00nh5NlLQ0UDzkb/Q7sdVOVg6kSBZ641Frxo+fK5XuFEtE
         XbrSznPSvAmaLEZB9hezEaATIJ+JKDT7Ip8iG4XrQWrDPK/8abyiqJvVG3k8Qi6lAbVk
         0Kb1A4nDEeOzWnmom/sGLF032wJV1faoz64fUTrhxGKDEBQ8bO6+Ubr190TVbdUQQm/M
         W8dgiLN/ZOfePlNF+s5tYpydNKtkvKtVtv4NLFCrgOW/ZYD9K8S3PtyT1jETt9DWrJn2
         PkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=27/qqlHSjPMexck06HTMXRVUdaYCAVgyqdAFeRpCXH4=;
        b=WxIE4FEVPNMa+6a8JOK4b2GIeaTtDwxAFznmDZvuZeD/nyJeFLBMwhgIXovLdB8NyZ
         KXyNU0vNfl/w3MW4rmEbHNd5M8YEk4PDhp8MfHY6JZGD80RP5uD6syg8/9so0ebm5M1K
         lVnclDbvL3BmV18gTnQ2/YlbwcMXfkanlPeawUz16AIlQpa+esvGSz2FmxoYbbau6yVB
         rMd47IxTJeXS86Lp99IziHGWJMK2O9fNf0a7656Y4OKxyrZogYH+uAYEvF3siWpc9MX4
         tQQe1AK35FeVsP679DsebYxEbH7Orq1v0m38xLkUaCGTxR640MKXjit3CYr1NORsucYa
         x3pQ==
X-Gm-Message-State: AOAM5323MdNv0zRILS91G8VjyC2vSFm2nkKmYcOVgEcpFWXZWSdt0Nnk
        zpXzheAgQ+2vjpcYJ7SmNCejZ2MSd/tmUFiDxfo=
X-Google-Smtp-Source: ABdhPJwS4ZU1HbJGt7oZcCGfwOrOVSwhiu1eqK378FnI4Cdc2s8WmR2KcADSZsfSeIJJxbVnjYt1PpdZABhJ+1Dy36o=
X-Received: by 2002:a05:6102:e4e:: with SMTP id p14mr8137937vst.26.1642499728668;
 Tue, 18 Jan 2022 01:55:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641978175.git.dyroneteng@gmail.com> <bcfbc935b80b889273e3e54fec2a896e44acd2b5.1641978175.git.dyroneteng@gmail.com>
 <220113.86wnj4w228.gmgdl@evledraar.gmail.com> <CADMgQSQXLydvgpW+Vm_b-rkSWAuj9FezwveY-iRZnKfsGkOpCA@mail.gmail.com>
 <220114.86ilumttn2.gmgdl@evledraar.gmail.com>
In-Reply-To: <220114.86ilumttn2.gmgdl@evledraar.gmail.com>
From:   Teng Long <dyroneteng@gmail.com>
Date:   Tue, 18 Jan 2022 17:55:17 +0800
Message-ID: <CADMgQSQzqW9m1XM7_EE09eBhkheMj6QCZ+pVjtHWW2HY=u_o2g@mail.gmail.com>
Subject: Re: [PATCH v10 6/9] ls-tree.c: support --object-only option for "git-ls-tree"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, tenglong.tl@alibaba-inc.com,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 14, 2022 at 7:59 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

> Yes, you get the functionality you need with a simple alias of
> --format=3D'%(objectname)' to --object-name (or whatever), so the only
> reason to carry the extra code is for optimization.
>
> I wonder if the extra difference in performance is still something you
> care about, or if just the --format implementation would be OK.
>
> But in any case, starting with a simpler implementation and testing it
> makes the progression easier to reason about.

Actually, at first, I wanted to achieve this in a simple way, as the
"--object-only" implementation.

With the discussion in the community, I think both of them can achieve
this purpose. "--object-only" is more intuitive, while "--format "is
more flexible.
For example, if the terminal supports automatic completion, the function of
this option can be clearly known with typing TAB and lower costs of use and
understanding. "--format"  also works, but maybe have to check the help
document to see if there are fields that support the same purpose.

Because the community had a different opinion about it. Junio, might prefer
an "--object-only" approach, if I understand the context correctly.

So I have some inclination to support both. However, I can accept that only
"--format" is supported.

So in the next patch, I hope to do some refactoring of the commit to suppor=
t
"--object-only" as the top commit. If in the end, we decide that "--format"=
 is
enough, we can discard the top "--object-only" commit.

I know you guys currently are busy on the new 2.35 release, so a later repl=
y
is OK.

Thanks.
