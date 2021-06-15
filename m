Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80B1C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 11:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 721CA61413
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 11:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhFOLLf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 07:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhFOLLL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 07:11:11 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF17C06175F
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 04:09:06 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id w22-20020a0568304116b02904060c6415c7so11553655ott.1
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 04:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=8cclCzEAw0+2pkpPR6dT/ibBM1Iln/E+BSnz1M5VCOk=;
        b=VCvsU6fMZfOfiMqr43ucfzQ7WbvJDNQ9D+OklqEuSnJ7a6Np9wVGpyc0Xwk3fBhVn6
         xDY2/misxJrHW1unPjcS5QXY9ShcADDCZipiEzNdGaS0NORdoFCt8G+Sl49xWWKVH96H
         g9pDDidDV0YsmrNpVQLejiuMWgFYSocdAwAKn8MkGnY6rTwbONnouCI0251p85t9VbhH
         j+Mp8fYXmS9qGHRIClb1cL4ZBGIr+WhFXjU2hIhwqZVOHdETJaflpKkZQpXkukKHnZAm
         zt1wDc3y3dadG69zj2oLgnO2Pxjm7YnuNOEUjrpHu6wRAzSvTilMkMAsSQP/BhEW3Nvz
         lZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=8cclCzEAw0+2pkpPR6dT/ibBM1Iln/E+BSnz1M5VCOk=;
        b=aUAslhYh7XQRTzTF6EInLX69TtH/FPoKCB2bF2LY0zFwLfhzP6+dbHcrxE3mZzwCc0
         eyeHHcYIbKQ6ihzmPdw6Cbbj2bC8tYH9bOg3lia/BTU/KdWrsTvUdJ7ewOWVFQ4T7DSo
         KXWZifSlHZkbzo5Coo4nmwzEPPajVEoC8ZYb7UzImYmFcR1VDUezJtBXfciyGovR/94D
         5VXnyctRcwQZwYGc2SJ9+jmjMKiP/o+5TANvZHTbNkEKpRt2+/Xn1y9EA71pQ08jkDnT
         pRn8tkPCJW2mwsqUFYxPUsUGHdsA45QP3p5SLMsSDGTb36hTaglt77PUNgI0Hm2q5H3L
         qDIA==
X-Gm-Message-State: AOAM531vq9ALpyiczIrdrc7XS5W2uHZzP6rsZobpKnviLugjEXpbCZV+
        priNhhQTzxDBnaz/iCKqCno=
X-Google-Smtp-Source: ABdhPJwFL2JaPeWJaHzSXi+qlVCUVkGcryUQU3ZHIR/S0xYN0seW9OiaROCS76MgqvZtnkApLR+XyA==
X-Received: by 2002:a05:6830:19c2:: with SMTP id p2mr17641140otp.11.1623755345615;
        Tue, 15 Jun 2021 04:09:05 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id i26sm3711688oig.13.2021.06.15.04.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 04:09:05 -0700 (PDT)
Date:   Tue, 15 Jun 2021 06:09:04 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Carlo Arenas <carenas@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Message-ID: <60c88a502d323_e633208fc@natae.notmuch>
In-Reply-To: <CAPUEspg_MmerWb7h8MyhgcJXbWrJeeSyeJ7z2S6eHgDfRDPKvA@mail.gmail.com>
References: <20210613045949.255090-1-felipe.contreras@gmail.com>
 <20210613045949.255090-2-felipe.contreras@gmail.com>
 <CAPUEspg_MmerWb7h8MyhgcJXbWrJeeSyeJ7z2S6eHgDfRDPKvA@mail.gmail.com>
Subject: Re: [PATCH 1/3] pull: cleanup autostash check
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas wrote:
> On Sat, Jun 12, 2021 at 10:11 PM Felipe Contreras <
> felipe.contreras@gmail.com> wrote:
> 
> > -       autostash = config_autostash;
> >         if (opt_rebase) {
> > +               int autostash = config_autostash;
> >                 if (opt_autostash != -1)
> >                         autostash = opt_autostash;
> >
> 
> since you are reducing the scope of the autostash variable anyway, why
> not refactor it additionally for clarity with (something like):
> 
>   int autostash = (opt_autostash != -1) ? opt_autostash : config_autostash;

Because I had like 15 branches on top of this, and wanted 1) to minimize
modifications, and 2) to minimize the chance of the patch being
rejected, and this is how the code was before f15e7cf5cc (pull: ff
--rebase --autostash works in dirty repo, 2017-06-01), so in theory
nobody could object.

But yeah, that version makes sense, and in fact I probably had such
cleanup in some branch.

-- 
Felipe Contreras
