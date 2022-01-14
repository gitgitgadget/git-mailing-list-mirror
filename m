Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10E7C433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 11:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbiANL7u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 06:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiANL7u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 06:59:50 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36732C061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 03:59:49 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z22so34098462edd.12
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 03:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=nTlx+gEiRxLM0v0orMDxQ92wlS1WvjOmGHC6U44Kz4g=;
        b=n2juciQkTt0+C36VlftHr0wlOMFSL6JfZbnsKJgGrBZFY1tjJoUXpyuN0uxFWsn3H0
         8yN9/GnHXkKtQCEVI9M1pRL+c6UW86190DYWGTBhGN55ghwwC5vsXQE6RkBQBKQco6TD
         Z1umT0FPxxdOV9+Z/zCOcIE8h3COxKtQpievp1gdy7WjtLjxQCeS4LYpWOoInATZgXSo
         +QRqhVtS1k8/duSyanzU+JGW6Qtc5UcuJ1k4e2j7awr8ZLA6OhoLVPJRAxjgisIF3oT6
         pfNGLx1JoWNAFwaLbJ5pPmvjr5gcv8fxPYUppPwAlJSMeERM9gRIH+IvyanUK1CzoIGh
         /YgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=nTlx+gEiRxLM0v0orMDxQ92wlS1WvjOmGHC6U44Kz4g=;
        b=n8ToSMHcWEJ6jF6FnpOdiVBD7EW0RSEuGOc5S/lzvjU9W9PfgeJfqUMEoC1R+IkTp/
         gy6n80kq8NBD3CoDFaRC/j/wtbbWa2hwf/TA+tPV7aNxMBfcuWw2rxtJsKdLq+0meyvw
         DiYSPSPaRLc5P9qfEbAYMbw3Hi3d4BsVh/rJxp3EtD1ZpF1apeidYd3nv568UiVpQd+k
         Jt3+XV4250nun5irRyXDuT/36iKqouswBLlvck8kGg018OEtII76pxGwp260HozvsEh4
         puLXHQGUdAUPNuTIQpcpJtyoKHQV4JytyssJ3PvFDzmI3rappB4lY9dVtMURGHUa7wTx
         nxNg==
X-Gm-Message-State: AOAM533Kg4PunYkQlOSvYR3oV+uce5RvgPZb0nu/kjshzpK7o5GSPM1v
        tUiaVhghsw1tvsvR/jsbJuw=
X-Google-Smtp-Source: ABdhPJyHv4/1bM+ESk/NKJ29QL1NXWzFKhFVtB06FGs5YbEhIlQ5n7ZTy09wRjyQhFS9RAPPNmVM0g==
X-Received: by 2002:a17:906:58c8:: with SMTP id e8mr6854925ejs.380.1642161587635;
        Fri, 14 Jan 2022 03:59:47 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j7sm2332985edq.5.2022.01.14.03.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 03:59:47 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n8LFB-0015Ah-VD;
        Fri, 14 Jan 2022 12:59:45 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?xJBvw6Bu?= =?utf-8?B?IFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, tenglong.tl@alibaba-inc.com,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v10 6/9] ls-tree.c: support --object-only option for
 "git-ls-tree"
Date:   Fri, 14 Jan 2022 12:47:39 +0100
References: <cover.1641978175.git.dyroneteng@gmail.com>
 <bcfbc935b80b889273e3e54fec2a896e44acd2b5.1641978175.git.dyroneteng@gmail.com>
 <220113.86wnj4w228.gmgdl@evledraar.gmail.com>
 <CADMgQSQXLydvgpW+Vm_b-rkSWAuj9FezwveY-iRZnKfsGkOpCA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CADMgQSQXLydvgpW+Vm_b-rkSWAuj9FezwveY-iRZnKfsGkOpCA@mail.gmail.com>
Message-ID: <220114.86ilumttn2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 14 2022, Teng Long wrote:

> On Thu, Jan 13, 2022 at 3:02 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>
>> In the RFC series I sent this was first implemented in terms of the
>> --format option, and I skipped the custom implementation you're adding
>> here:
>> https://lore.kernel.org/git/RFC-patch-7.7-5e34df4f8dd-20211217T131635Z-a=
varab@gmail.com/
>>
>> I think in terms of patch series structure it would make sense to do
>> that, and then have this custom --object-only implementation in terms of
>> not-"--format " follow from that, and thus with the tests for the two
>
> Sorry, the "not-"--format" means?

Sorry about not being clear. I mean there's two potential
implementations. One that't is terms of --format=3D'%(objectname)', and
the other with your custom (faster) code to implement it.

>> (we'd add the tests you're adding here first, just for a
>> --format=3D"%(objectname)" or whatever) we'd see that the two are 1=3D1
>> equivalent in terms of functionality, but that this one is <X>% more
>> optimized.
>
> Please allow me to understand your advice,  if we put the commit of
> introducing "--format" before the commit of introducing "--object-only", =
will
> be better because it's possible to supply more optimized performance
> (if we have) information in the commit message.

Yes, you get the functionality you need with a simple alias of
--format=3D'%(objectname)' to --object-name (or whatever), so the only
reason to carry the extra code is for optimization.

I wonder if the extra difference in performance is still something you
care about, or if just the --format implementation would be OK.

But in any case, starting with a simpler implementation and testing it
makes the progression easier to reason about.
