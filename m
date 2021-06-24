Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF51C49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 14:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4B5F613C7
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 14:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhFXODa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 10:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhFXOD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 10:03:28 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57376C061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 07:01:08 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id he7so9651987ejc.13
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 07:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=BRl2gyuiI9dYVMoaEhX7gOYot9FVmvwpO3WypxowhQg=;
        b=XGIrnPqrwYf8nzpbGPUSaaaL+7UaEKBvzMJ//CvCFohjNL4FpRVcjk/IwHfMfOQOSY
         wEqnThe1CgqMC/u+3OtR8OJ8CJvfp6s2MgypuzsAst0O5Agnqrigw5d/ndnJ1id4QMfV
         YIFWlGhD0D5sA+kBYBtkpDIx6Ac8ElRH5G8HhT05ABoEw+G+0QAQZMkT9rSdBGKDV1R3
         XNiT3HSiQJTGLrrjg+g4oaJjaXnps5Ud9yvRSGEY05YjkN1QE1IaCMUrljBM43o2VgYI
         n4/JIqYZNTK2iJJB6uzXj5ldzymWhSCssupBftXQCEorex2R/zEbdZ8+Ie1D7bXW3+NC
         UDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=BRl2gyuiI9dYVMoaEhX7gOYot9FVmvwpO3WypxowhQg=;
        b=CtXmDUig7ERo8VjAz1Pq5yRjZWYOFnLrLdRjmGfdj1ITQ2U0Ppw2xZGumKNaOM/84n
         hAXoHkm7soltHKWzINtazSud8UhZW5lGlOe8jTPRFgCu+gBQDjxT2eP6E6MPx35Tw47w
         Zhlof+YYg5a4aPceoBg5XR1CqGq99vHEO0n9h2G9e7aewhOjbb1JB+yo/8jDeRSA5e8Q
         D4ALdCAoDEsLm1odGnpQlcPcQnxWVw0J+M1EYNz+K3VKY1I2durDDVRfR+YjU2eOIXWc
         C4w8KMs+dEfrxL650p+79IV6H/n8CiGprMdGgcN8NrBNKmTTfUnKnHChxH59lHilvQuM
         WmxA==
X-Gm-Message-State: AOAM532Wb3er953GfWlXi2Ct5TBsCC8cUkFtc15b7pj7YF4oM5P8jZlW
        AdrwoLeSp2iH99NOk2ik4xI=
X-Google-Smtp-Source: ABdhPJwz3A0R+7Xn/fV57Rk37U97h71nfCYtn3uGWav9tBWNs2r6e0qoe2xdcDOL0dVEOPGZ9jVXMQ==
X-Received: by 2002:a17:906:6d16:: with SMTP id m22mr5552759ejr.333.1624543266925;
        Thu, 24 Jun 2021 07:01:06 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id j22sm1334003ejt.11.2021.06.24.07.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 07:01:06 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Makefile: add and use the ".DELETE_ON_ERROR" flag
Date:   Thu, 24 Jun 2021 15:53:51 +0200
References: <patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com>
 <YNIBRboFiCRAq3aA@nand.local> <8735t93h0u.fsf@evledraar.gmail.com>
 <YNI3WVu5SK7pHI7T@coredump.intra.peff.net>
 <87r1gs1hfx.fsf@evledraar.gmail.com>
 <YNOz1GD/8+CaUvRz@coredump.intra.peff.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <YNOz1GD/8+CaUvRz@coredump.intra.peff.net>
Message-ID: <871r8r1hwe.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 23 2021, Jeff King wrote:

> On Wed, Jun 23, 2021 at 09:54:06PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>>=20
>> > Just to be clear, I would be happy to drop the "oops, the tests barf if
>> > you recompile halfway through" feature away if it made things more
>> > robust overall (i.e., if we always did an atomic rename-into-place). I
>> > just consider it the fact that we do clobber to be an accidental featu=
re
>> > that is not really worth "fixing". But if we care about "oops, make was
>> > interrupted and now you have a stale build artifact with a bogus
>> > timestamp" type of robustness, and "the tests barf" goes away as a side
>> > effect, I won't complain.
>>=20
>> ..and "this behavior is really annoying on one platform we target, and
>> the fix is rather trivial".
>
> Yeah, that's a fine reason, too. I'm not entirely clear on what the
> problem is, though, or why this is the best solution (I expect you
> probably explained it in an earlier thread/series, but if so it went in
> one ear and out the other on my end).

On *nix systems you can open a file, and unlink() it in another process,
on Windows this is an error.

AIX has its own variant of this annoying behavior, you can't clobber (or
open for writing) binaries that are currently being run, you can unlink
and rename them though.

So without that "mv $@ $@+" trick you can't recompile if you have a
concurrent test (that you don't care about failing) running, and we have
bugs in our tests where e.g. "git-daemon" gets lost and won't get killed
on that platform, so you can't recompile and test without tracking it
down and killing it.
