Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C28C48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 16:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A84096101B
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 16:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhFKQiq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 12:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhFKQip (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 12:38:45 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF308C061574
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 09:36:47 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id a26so6376012oie.11
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 09:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=pXOv/uwAIkZrn5DdWInnJTHDyTo12aPnVA/Y7GCxxgw=;
        b=Ns3r4QlzpAHkPA1ggRxkUYug2a1RdYVOwm0QuOI8mfzqsMYU3LmhJzZ65kmUe1IuqT
         5R9Iij3+L9dcxTZhqOpofI28IFAIvepsrTJJvF2k6OGpjKsuZwIvK06BC9hF0gusu/x1
         WIGOK2NwhTI8XJoz93tWvBsKsj8OtIKq/8pJHSY5xf9lDMStS9kpD4itjzyG1ewXMMTA
         XFD66GKvvFDGqB19nQ+HEyxxFslhk9V4QRGJeJI7hwSQi3XqG2XfFJrpZc/FGrbzTfA8
         HmpxpFn0TpktN2gZVMdJA8kBC64bCOck/ITQwU35VidtUy6sOr++gdJ6KxAFIxD67o6u
         YaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=pXOv/uwAIkZrn5DdWInnJTHDyTo12aPnVA/Y7GCxxgw=;
        b=SbdpN/aR5tQ5sMixPpDokGegaYDVo74rasqJ2dBMm2Bn5XqhDwDtWee+SSfoaMnJ6y
         uzv5816SZJQtIZDhf2rT2Zas+H6T5XPpR621OKRnopZOacTPvOcMPaqGfjJe8cxcyFXf
         Iry/uknUH5xL3J4Kes/0ZuiOCch5aC2CqzQGNytx5UHijVtWVXp0MnF152m7vUZVj/DH
         ovcuE5hEHYN5oc16gurXwlGC/jr7C14597PeqsppiauCdIOdwqMKVrPCNsFyG2JllGX7
         PVWHLUgupEI/rOQTzxlOky1Bnuhwm31NVUB1dLhToxLe1vuhTTJIVbWdKeVZFTUoTqxC
         3+6Q==
X-Gm-Message-State: AOAM530zIPvOYDBkrryGVT1GYPc7K54saqHQ1ztnxcR96rTWa8egngUC
        WYBs5V95GKutmIpZdmNfxDQ=
X-Google-Smtp-Source: ABdhPJyV/koAahNDKbpL1zk16z69Dvlbsy2+08iqA0QbmYlnBwAYfwxH+updr+S0YYCrqmeThAwT1w==
X-Received: by 2002:a54:4692:: with SMTP id k18mr14196559oic.118.1623429406958;
        Fri, 11 Jun 2021 09:36:46 -0700 (PDT)
Received: from localhost ([187.188.155.231])
        by smtp.gmail.com with ESMTPSA id c11sm1252397oot.25.2021.06.11.09.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 09:36:46 -0700 (PDT)
Date:   Fri, 11 Jun 2021 11:36:45 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>, David Aguilar <davvid@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
Message-ID: <60c3911d48f3c_85c8208f6@natae.notmuch>
In-Reply-To: <87a6nwflez.fsf@osv.gnss.ru>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-8-felipe.contreras@gmail.com>
 <60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org>
 <YMIYUgo71aKJ1Nnx@coredump.intra.peff.net>
 <xmqqh7i5ci3t.fsf@gitster.g>
 <638a0500-459a-a25b-afca-904ec0e09866@kdbg.org>
 <xmqqy2bg3nqw.fsf@gitster.g>
 <07ef3a3b-4812-4fa1-c60c-b9085a268bc3@kdbg.org>
 <xmqqo8cc3maq.fsf@gitster.g>
 <875yykipq2.fsf@osv.gnss.ru>
 <60c38205cdbf8_3ad92084@natae.notmuch>
 <87a6nwflez.fsf@osv.gnss.ru>
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Sergey Organov wrote:
> >> Junio C Hamano <gitster@pobox.com> writes:
> >
> >> > I notice that "git merge --help" tells what each part separated by
> >> > conflict markers mean in both output styles, but does not make a
> >> > specific recommendation as to which one to use in what situation,
> >> > and it might benefit a few additional sentences to help readers
> >> > based on what you said, i.e. the "RCS merge" style that hides the
> >> > original is succinct and easier to work with when you are familiar
> >> > with what both sides did, while a more verbose "diff3" style helps
> >> > when you are unfamiliar with what one side (or both sides) did.
> >> 
> >> I don't get it. Once you have diff3 output, and you want something
> >> simpler, you just kill the inner section, right? RCS merge output style
> >> is simply inferior.
> >
> > The issue here is not a mere inner section, it's a nested inner section
> > due to a recursive merge.
> 
> No, this one is just generic suggestion by Junio to improve
> documentation, unrelated to particular problematic contents of the inner
> section of diff3.

OK, but diff3 is not always just merge minus some stuff.

It would be nice if it was, which is what triggered the proposal of
zdiff3:

https://lore.kernel.org/git/20130306150548.GC15375@pengutronix.de/

-- 
Felipe Contreras
