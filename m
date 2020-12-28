Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FF4C433E0
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 14:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 635DE22573
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 14:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502194AbgL1O2B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 09:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503997AbgL1O2A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 09:28:00 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B07C061794
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 06:27:20 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id r9so9204331otk.11
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 06:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=KJ1l/0YZaiXgd7YjzaBvpdahGsSwbPzt3wiopDz2rSY=;
        b=mwl/e0r1CTSC/9ZNXrkYQEoI3g63lqrGSeKdMBpndiqK7JgXkmL+szcVwwPOB1A5Aw
         2FW6JovRPXXN835e2f0Gw1mnkEFs/wWAvGl+ycE3D7jOmtn+O9JTKH4aXYRR4e3ZVTZg
         33twfAn/gPH4SW56k8yrH68vWuhLT0a7flvoasCl3UprNGgkH59DI5uKNWEBKtPvBIWW
         fbX1H7p+vYYxESQjnaJD2ApolT0QGW1VLwWspfry4XmjKPeOM96gUJKKNCWmCzyIVNR7
         3UG+7uA8YGAGoGTOdk5p0B6cLutdDfNuqPLAdrjkqhg5tJjBef5fkICrN8MoPENNFF16
         OijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=KJ1l/0YZaiXgd7YjzaBvpdahGsSwbPzt3wiopDz2rSY=;
        b=QP5rU4BLTVJlJwgIRRZidB2YzBugacb8sFnTob4I5WcXgEinYMDNXVAOgf0AYBsx1q
         QsWJOgFQOXtBpfVA8R5Xl3HuMGxwfj5i0XtF4bQ9WVSz1va5Uh+iL15cKHN+qYhXZ+Xy
         9cNsclxomhu5bxxwSq6TqZ4flFwSeUtuCHD0C7ScH5Af/7mdl8wh76XcM5p8qeqPKqgs
         s158v3TdOJiYf5e48pr5H09FnU4reonc7bhfdadsoD8St9kzFLo4H2PVJ6kGg3AZPswh
         oYIPSRH1JhT6X0hmgxmg8F7ULL3iIr9Rwkb1BRoG4XC2xpC6DQlW4i8guHcVUyGAFNnu
         KCCg==
X-Gm-Message-State: AOAM5307Kg3+O4kcwId7CBDzGs6BmpAUNm9V3By2ExQzzrbd2hlm5uYE
        chm6z1kta687vgXRV80G1MvsA34q8QWIPg==
X-Google-Smtp-Source: ABdhPJwcqbXL9X6oMUPY0u5GZbULhaAOddRDI7Hy3hSvQpPLj3X6+hR7AOMDXH8DAoqPkk/DEFb1Tg==
X-Received: by 2002:a05:6830:19ca:: with SMTP id p10mr33229793otp.233.1609165639752;
        Mon, 28 Dec 2020 06:27:19 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id v207sm9040784oif.58.2020.12.28.06.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 06:27:18 -0800 (PST)
Date:   Mon, 28 Dec 2020 08:27:17 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        David Aguilar <davvid@gmail.com>, Seth House <seth@eseth.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        git@sfconservancy.org
Message-ID: <5fe9eb45aa314_209d2088e@natae.notmuch>
In-Reply-To: <xmqqmtxyjjt2.fsf@gitster.c.googlers.com>
References: <5fdc18a91c402_f2faf20837@natae.notmuch>
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
 <87o8ijv124.fsf@evledraar.gmail.com>
 <5fe4b33dbc028_19c920834@natae.notmuch>
 <xmqqtusa24oa.fsf@gitster.c.googlers.com>
 <5fe8c464bc190_e22d2086a@natae.notmuch>
 <xmqq5z4nqey1.fsf@gitster.c.googlers.com>
 <5fe8d6bf1a1a3_f1c220893@natae.notmuch>
 <xmqqmtxyjjt2.fsf@gitster.c.googlers.com>
Subject: Re: Nobody is THE one making contribution
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Junio C Hamano wrote:
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >> 
> >> >> But if you are arguing that when you write "Signed-off-by:" your
> >> >> sign-off can mean something other than what DCO says it means,
> >> >
> >> > The DCO has clause (d), which clearly states the developer must agree
> >> > that a record of his/her contribution is maintained indefinitely (and
> >> > that includes his/her sign off).
> >> 
> >> Yes.  Are you saying that you are OK with (a)-(c) but not (d)?
> >
> > I'm saying if the author of the patch states "I don't agree with a
> > record of my contribution being maintained indefinitely with my sign
> > off", then clause (d) isn't met.
> 
> Yeah, but then why does such an author add Signed-off-by: trailer to
> begin with?

Why an author does anything is not something even the greatest
psychologist of all time would know with 100% certainty, unless he/she
reads minds, which nobody can do.

All we know is what the author does.

> So, "by making a contribution", the author who added a Signed-off-by
> trailer is certifying that (a|b|c)&d is true.

Yes, (d) is a requirement.

But agreeing (d) applies for patch A is not agreeing that it applies for
patch B.

Apples are not oranges.

> Perhaps we can tighten the language to say "If (and only if) you can
> certify" and that may reduce confusion?

Clause (d) still must apply.

-- 
Felipe Contreras
