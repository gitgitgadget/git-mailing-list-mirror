Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D394C433DB
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 02:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C4B22571
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 02:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgLXCB4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 21:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbgLXCBz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 21:01:55 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E71EC061794
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 18:01:15 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id cm17so955863edb.4
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 18:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=yPDI8yF7BIARECc7uLWl0TxtX/9lX4IGSXN/o9v2ZLI=;
        b=k5OX2sGc09zHNq5r8paPG7SuDDbPkvNRPhXF8hnT8d20AL+wRBMOVvCe1kBsHvQvWV
         g+9p76ngIZYoA4qWy+vuOQcdCMs6+uHhTy+SezoYE/wO7nLSBdZOAxJmO5E4If4Ur38P
         mc4wVbG89MXt8Y5wr7oywDDOesG6MMxqez+SfrY/X7KEHPBsKDcqK5QUJr202PdCE07S
         mNIU5qfSLa3DxMT72oAqC5vQeKgWxQrlDTrtBSMpv0FXXdjjiwl63mphpqF5IFrMX65u
         Ib2F1VFkU1MKEETruoFfQsU29SmusrqtWIUuAA+X5UPhUBby6KWVRoIF+QQjC1Rp5kbU
         zbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=yPDI8yF7BIARECc7uLWl0TxtX/9lX4IGSXN/o9v2ZLI=;
        b=p09Vgj0gomdJroEI0XIme6FEmvDLr4SyNZjrji/k94vWDmS6eWe9dpTlWpvHOYqRd+
         zTPVCfPVb1uFa63sM0yona5KnOwIWCm9ZqbocQfhbLyqaE27Q0w9rywGq1Dr8DDk/hWU
         GJUkrWCdBaDnLyhQ5so7dXx00JxTLpS/VA6EE42pYO0VyxaTsvVi/3j2w6rWOPdiuN2l
         t+yr/fVBnjvWGFRY5R6Iws3tXKwW6uDC9gvLTbT09Kz+7rhzLyBxDdxzJhN7wnLci1H+
         La36gNHZTi2kCPqa4ES2uVH3W9ssqPtXHdp1aMZmnFzyFmqMtfmCHZ+TrFtdNH1PhGAe
         2HRg==
X-Gm-Message-State: AOAM530SnEaeZQVQwk81zYNZdf+YJ6tW7RO51KbgmFEmBfktW7EbzSCR
        /AzNuK7JohYHHKowMtmhj+Y=
X-Google-Smtp-Source: ABdhPJzkxdk1xElXLbCFk/9WlIAFMrNaOSCE9fITGdhvTk5LgYkWmZMeiI88TLSOHBh0AVpHY2IyuA==
X-Received: by 2002:a50:c209:: with SMTP id n9mr26920875edf.123.1608775273818;
        Wed, 23 Dec 2020 18:01:13 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id c14sm31608271edy.56.2020.12.23.18.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 18:01:13 -0800 (PST)
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
 <20201218054947.GA123376@ellen> <5fdc7a7d3a933_f4673208d0@natae.notmuch>
 <20201219001358.GA153461@ellen> <xmqq1rfmqc8g.fsf@gitster.c.googlers.com>
 <20201221042501.GA146725@ellen> <5fe033e0ec278_96932089d@natae.notmuch>
 <20201221073633.GA157132@ellen>
 <CAJDDKr6LrBMyfdp5Tutp29W9OqhbW4ffcP5e6PD8ruyxk3rQxA@mail.gmail.com>
 <5fe134eeaec71_11498208f9@natae.notmuch>
 <20201222150124.mnfcyofm4qyvvj4n@yadavpratyush.com>
 <5fe2c64bd3790_17f6720897@natae.notmuch>
 <xmqq5z4tdsiz.fsf@gitster.c.googlers.com>
 <5fe2d89c212e8_18dc12083e@natae.notmuch>
 <xmqqzh248sy0.fsf@gitster.c.googlers.com>
 <5fe36790793ae_2354120839@natae.notmuch>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <5fe36790793ae_2354120839@natae.notmuch>
Date:   Thu, 24 Dec 2020 03:01:12 +0100
Message-ID: <87r1ngufmf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 23 2020, Felipe Contreras wrote:

> When I express my dissenting opinion I'm not saying nobody should write
> a patch on top of mine. Of course they can. Anybody can take my code and
> do whatever they want with it (as long as they don't violate the license
> of the project).
>
> What they cannot do is add my Signed-off-by line to code I don't agree
> with.

I don't think that's what Signed-off-by means, per SubmittingPatches:

    To improve tracking of who did what, we ask you to certify that you
    wrote the patch or have the right to pass it on under the same
    license as ours, by "signing off" your patch[...under the DCO:
    https://developercertificate.org/]

So I find this rather unlikely, but let's say I author a patch for
git.git and send it to this ML with a Signed-off-by.

If someone else then takes that patch and changes it in a way that I
vehemently disagree with and gets Junio to accept it into git.git in its
altered form, that altered patch should still carry my Signed-off-by, as
well as that of whoever altered it.

Because it's a trailer for maintaining the licensing paper trail. It
doesn't mean "=C3=86var thinks this patch as it stands is a good idea"[1].

"No Discrimination Against Fields of Endeavor" is an integral part of
free software & open source. In our case it means that when you
contribute code under our COPYING terms someone else might use in a way
you don't approve of.

E.g. I'm sure that arms contractors, totalitarian regimes etc. or other
entities some might disapprove of are using git in some way.

That non-restriction on fields of endeavor also extends to individual
patches licensed under a free software license & the necessity to
maintain a paper trail about who their authors are and if they certified
them under the DCO.

1. As an aside, I haven't needed involvement from others to later
   realize that an integrated patch of mine with my SOB maybe wasn't
   such a good idea after all :)
