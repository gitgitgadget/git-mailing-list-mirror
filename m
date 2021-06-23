Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD299C48BC2
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 19:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A14166115A
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 19:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhFWTxp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 15:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWTxp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 15:53:45 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D364C061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 12:51:26 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id hq39so5784773ejc.5
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 12:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=KuHaeGRXNl4+COeoea+4o2jqVLiaJdfoZWvg5ba/q1M=;
        b=edspNJExUgj6bRwkvAcm+655wFqAko80HnZYTvEtmZWixMYBv6OzWM/SOgGTCKPjxT
         22KVM5SN/KwX7rHANnWFytZow0JpUQHuNAI1tTzqcS0sW0yuLXoDRg6JGRiw/yYo3HPF
         TPMEmIyIrP9CRGhGPcTcFMRGNfUjapLxusUc2tfOUpw1lYzXpFFlM5hRWQV+/jCT3z3p
         G7GXMomeDIlmbaO3gGLR7rxQgwBcG9aRvjElHxrxbA6dtjhquf5LwS44D1RbxN6Tcxb4
         0MyoZ4uAOIaqaO1/rtNRUmbTWMzL+UeIij/HlP0RY60QYKD+RusOu909A79Mka7QT6y2
         5zKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=KuHaeGRXNl4+COeoea+4o2jqVLiaJdfoZWvg5ba/q1M=;
        b=Omuq9ywlPDq8wk6YD8czEkX1zwvMG7cbKstQdA5on+WTZZt9RgqXqSKHmOKb9U8bEJ
         tuxH/DK5bi152/T5dBuXwcPyfU0J8SMbZLkbXcx9mmKIRvbB0SBYeYUe8vReosIkYk4R
         nV+3Z7+8eyQwNHsLYPFsmiZBGH4sq7TdnesxqdHXkiN56dZACix4cVfBtQGXHQGMX6Vl
         nYqMnvBtBF/QeEUjvWtMX8B6Qbl+hSIpvSowXhwjseWpRmbxcrg0WtdoQu0xIPtnrwj4
         zbMklvLrI5rZEWVxsWi3lqFtJvYbgb7VaqP/FcEB3G7NGb7NYF1lhekPQLvuQ1RL1TLr
         Fhyg==
X-Gm-Message-State: AOAM5311/UfPb6c1CK4o1tjJ1fJURLBudA/2+hw/tAaHdOitxG6mIHnp
        kIkHowcx1i4e3Boj8+oFx9o=
X-Google-Smtp-Source: ABdhPJz1LZ6scnUAnrkDoKhsFbsob7Df/DXkZDkxTu3/Rj8JKihTSc+nK25N8YiNLP3VaZFqUcC+kw==
X-Received: by 2002:a17:906:a38d:: with SMTP id k13mr1760665ejz.250.1624477884881;
        Wed, 23 Jun 2021 12:51:24 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id h7sm287682ejl.8.2021.06.23.12.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 12:51:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] Makefile: add and use the ".DELETE_ON_ERROR" flag
Date:   Wed, 23 Jun 2021 21:45:04 +0200
References: <patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com>
 <60d384ecd5ad3_4290208c@natae.notmuch>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <60d384ecd5ad3_4290208c@natae.notmuch>
Message-ID: <87tulo1hs4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 23 2021, Felipe Contreras wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> As in db10fc6c09f this allows us to remove patterns of removing
>> leftover $@ files at the start of rules, since previous failing runs
>> of the Makefile won't have left those littered around anymore.
>>=20
>> I'm not as confident that we should be replacing the "mv $@+ $@"
>> pattern entirely, since that means that external programs or one of
>> our other Makefiles might race and get partial content.
>
> The reason I did it in db10fc6c09 is because both asciidoctor and
> asciidoc should deal with temporary files by themselves (like gcc). If
> you interrupt the build nothing gets generated.

If you interrupt the build default make behavior without
.DELETE_ON_ERROR kicks in.

My gcc 8.3.0 just does an unlink()/openat(..., O_RDWR|O_CREAT|O_TRUNC)
dance followed by chmod() when I do e.g.:

    gcc -o main main.c

So no in-place atomic renaming, does yours do something different?

But yes, some tools do this themselves, I think in general it's less
annoying to deal with it yourself in a case like git's, because if they
do it their idea of an in-tree tempfile may not jive with your
.gitignore, so you'll racily see ghost files during build, or those
files getting left behind if the tool hard dies.

> However, other scripts like build-docdep.perl would indeed generate
> partial output.
>
> In my opinion it's the scripts themselves that should be fixed, and not
> the Makefile, *if* we care about this at all.

I don't think default tool/make/*nix semantics are broken, I just think
it's neat to do that rename dance yourself, it's a cheap way to
guarantee that we always have working tools for use by other concurrent
scripts.

Many build systems or modes of running them don't care about that
use-case.
