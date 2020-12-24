Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080A0C433E0
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 12:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D046E227BF
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 12:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgLXMbP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Dec 2020 07:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbgLXMbN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Dec 2020 07:31:13 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF57C061794
        for <git@vger.kernel.org>; Thu, 24 Dec 2020 04:30:33 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id 6so3177385ejz.5
        for <git@vger.kernel.org>; Thu, 24 Dec 2020 04:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=hBJ1/uJpr5EKW7x/osVtsSYVx4cJedbR2CRh4aCTpcg=;
        b=RcTnuX2MpvTpuNzLSJIdoU3jcn9ZgJWLLaTcsAVU9TEiljevKUCE82oUNLeldZUJGM
         BEPtKLbxCSx/5uHBj1fRdZtX0R+5l8Y/PQdJORXEXdhbcKGdX80p/BTfG3GoI7fAt0Rs
         XvCBwY8x7K9VNM11PaWLiB6blbxhfgLY4e163PVUN9uy1uOQ+TTrKWMvqebOctGC21oC
         fwOorm25SFr5D8zUkp+g3JPV1o36C9/8PZbkd3CQ5Ql0nG+6Ch+SJhmUR+sntYsNpPlQ
         H/ssZ7YkD0Be62xOIDt6IDQRMVPyHl+Mnngis5ZOEB1NVt0KI4196pk/gvO1nYpJiJtn
         nX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=hBJ1/uJpr5EKW7x/osVtsSYVx4cJedbR2CRh4aCTpcg=;
        b=V++HnMHWP4tpNRUU/5JnKsXsFtJjFRMYdJq1QE+k7FVhQv03CEiGF/2ZFPI29hPOpm
         iXPRu7X4ZVMYrbqHg9EeT04y9g976tA4RMTZXRu+tCP2DZ7RWmQUXlAxzIlj8hR5lu31
         l2EsouSUgbDPzSh5fzNM3j6vKQjKVB4IjuA7Opv6uvam8P5WZucYpRbv/E3EtGe1k3Mn
         YOtHAfaG3pOvXfZ/A/fhcKT8ikn1jFPZgdeFydgJsvLwKUPnVsii/V4zzOqWh+iq/VTZ
         XqAJmQLWMpmZVqWe284fa98t1L+vSync15E+G2ogd4M4RsbSMMSlGY+sK1r968JM4/nM
         NonQ==
X-Gm-Message-State: AOAM532hZgX+RV2dD5EmTEiOAO+yWLm+AIV15GhW75eD9sR+KclfCyCi
        e63sXjHu79Tzh84IpwEoSIDPIJJw8zI=
X-Google-Smtp-Source: ABdhPJyBBM8ZeoPheB13Vdzsep/RP2W8hOPKGXfnyYcGMVlEsG6YbyfriiXkNYO0sRU2JSIAzB0zJg==
X-Received: by 2002:a17:906:a192:: with SMTP id s18mr26654254ejy.249.1608813031912;
        Thu, 24 Dec 2020 04:30:31 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id a23sm5344355ejg.7.2020.12.24.04.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Dec 2020 04:30:30 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        David Aguilar <davvid@gmail.com>, Seth House <seth@eseth.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        git@sfconservancy.org
Subject: Re: Nobody is THE one making contribution
References: <5fdc18a91c402_f2faf20837@natae.notmuch>
        <20201218054947.GA123376@ellen>
        <5fdc7a7d3a933_f4673208d0@natae.notmuch>
        <20201219001358.GA153461@ellen>
        <xmqq1rfmqc8g.fsf@gitster.c.googlers.com>
        <20201221042501.GA146725@ellen>
        <5fe033e0ec278_96932089d@natae.notmuch>
        <20201221073633.GA157132@ellen>
        <CAJDDKr6LrBMyfdp5Tutp29W9OqhbW4ffcP5e6PD8ruyxk3rQxA@mail.gmail.com>
        <5fe134eeaec71_11498208f9@natae.notmuch>
        <20201222150124.mnfcyofm4qyvvj4n@yadavpratyush.com>
        <5fe2c64bd3790_17f6720897@natae.notmuch>
        <xmqq5z4tdsiz.fsf@gitster.c.googlers.com>
        <5fe2d89c212e8_18dc12083e@natae.notmuch>
        <xmqqzh248sy0.fsf@gitster.c.googlers.com>
        <5fe36790793ae_2354120839@natae.notmuch>
        <87r1ngufmf.fsf@evledraar.gmail.com>
        <5fe424d0528a2_7855a208d3@natae.notmuch>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <5fe424d0528a2_7855a208d3@natae.notmuch>
Date:   Thu, 24 Dec 2020 13:30:27 +0100
Message-ID: <87o8ijv124.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 24 2020, Felipe Contreras wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Wed, Dec 23 2020, Felipe Contreras wrote:
>>=20
>> > When I express my dissenting opinion I'm not saying nobody should write
>> > a patch on top of mine. Of course they can. Anybody can take my code a=
nd
>> > do whatever they want with it (as long as they don't violate the licen=
se
>> > of the project).
>> >
>> > What they cannot do is add my Signed-off-by line to code I don't agree
>> > with.
>>=20
>> I don't think that's what Signed-off-by means, per SubmittingPatches:
>>=20
>>     To improve tracking of who did what, we ask you to certify that you
>>     wrote the patch or have the right to pass it on under the same
>>     license as ours, by "signing off" your patch[...under the DCO:
>>     https://developercertificate.org/]
>
> Yes, but the DCO requires (d):
>
>   d. I understand and agree that this project and the contribution are
>      public and that a record of the contribution (including all personal
>      information I submit with it, including my sign-off) is maintained
>      indefinitely and may be redistributed consistent with this project or
>      the open source license(s) involved.
>
> We can narrow down the part I'm talking about:
>
>   d. I *agree* that a record of the contribution is maintained
>      indefinitely.
>
> I don't agree with that.

I don't understand you here. You don't agree that we retain
Signed-off-by lines indefinitely, or just in the case of amended
patches?

> Moreover, the relevant definition of "sign off" in English in my opinion
> is [1]:
>
>   to approve or acknowledge something by or as if by a signature (sign
>   off on a memo)
>
> If I didn't put my "signature" in a commit, then it's not signed off by
> me.

I think this use of 'signed off" makes perfect sense if you interpret
the sign-off to mean "I signed off on the copyright eligibility of this
work for inclusion" which is what I think it means.

Not "I signed off on my subjective approval of this patch & what it's
for etc.", which seems to be closer to your interpretation.

>> So I find this rather unlikely, but let's say I author a patch for
>> git.git and send it to this ML with a Signed-off-by.
>>=20
>> If someone else then takes that patch and changes it in a way that I
>> vehemently disagree with and gets Junio to accept it into git.git in its
>> altered form, that altered patch should still carry my Signed-off-by, as
>> well as that of whoever altered it.
>
> I don't think so.
>
> Even if you disregard clause (d) of the DCO, in English you didn't "sign
> off" on that particular version of the patch.

[...addressed below...]

>> "No Discrimination Against Fields of Endeavor" is an integral part of
>> free software & open source. In our case it means that when you
>> contribute code under our COPYING terms someone else might use in a way
>> you don't approve of.
>
> Yes, you just have to make the record straight; do your changes in a
> separate commit without my "sign off".

We like to maintain "make test" passing for every commit, and sometimes
we have patches on the ML with a SOB that don't even compile yet, let
alone pass tests, because they were provided by their authors as "maybe
try this" or other near-pseudocode.

We also like to optimize patch order/size/splits/etc. for the benefit of
reviewers. Sometimes someone might send a patch with a SOB that's better
squashed into another one, or refactored into N commits spread across a
series etc.

>> E.g. I'm sure that arms contractors, totalitarian regimes etc. or other
>> entities some might disapprove of are using git in some way.
>
> Yes, and you can modify my patch and keep my s-o-b, I'm not going to sue
> you.
>
> I just don't think that's right.
>
>> That non-restriction on fields of endeavor also extends to individual
>> patches licensed under a free software license & the necessity to
>> maintain a paper trail about who their authors are and if they certified
>> them under the DCO.
>
> Sure, so if you need to keep a paper trail about the copyright of the
> code, why would you risk that simply because the author didn't agree on
> the further changes.
>
> Just do them on a separate commit. Problem solved.

I don't understand how the copyright paper trail is at risk just because
we combine N patches into one.

The important part is that we have a declaration that the sum of the
work (and whatever it's derived from) is properly licensed, that the
authors had the right to license it for inclusion etc.
