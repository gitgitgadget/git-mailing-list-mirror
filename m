Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E0DC4708D
	for <git@archiver.kernel.org>; Fri, 28 May 2021 21:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF19E6135F
	for <git@archiver.kernel.org>; Fri, 28 May 2021 21:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhE1VIz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 17:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhE1VIy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 17:08:54 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5ACC061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 14:07:19 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id a13so139750oid.9
        for <git@vger.kernel.org>; Fri, 28 May 2021 14:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=53oSdmatW+NlPRXpqSeAw9mlVgOxyM4EokTFYNSpMyA=;
        b=LcQPtqClD8+0IBtmtvUfUyYzFSr0OIoyq24xtNXSt1evieFYxLOJZ/OX61m4ELJCMf
         sTBXb6LuNirOKDtCK7jp3JPzdk+EnKriW2tdkw5bdJ0nUUnGyNrmoMmYji3qtIKvTS67
         NXQSE5ZpowOn+CJxX0j6NthaFvqpxlnI9x7Wa6SJl8c3L6xGlXGabuCAFD8qB7HMPDgR
         XrfnKbCFcv8mYKqMgZyXpuMGur5f+qQcdL4ZIoZ2h5TJHZML6r5jTmnt7wmF37O1erMP
         tPXDzkJTPIIYsi5eOA/qsidJYCqAGC1PZegiZMgUX4gedjtu0SrAS8X0Y1e/spHU9Vuf
         LDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=53oSdmatW+NlPRXpqSeAw9mlVgOxyM4EokTFYNSpMyA=;
        b=toaL3BP6S08LLVCytwUfgkLzYaPHQ71HZQwjlnckvaVqRvJhZCiTxk6dCl5mqdKP4V
         eAPO265oV0UAEst7tntv44IKwjrcui5hx4F4FTJ8HZgTBPH2z0vD49ELAV5FId6vfMUS
         TVlce5nrLLKiEWdrb0BB1dpIaVERMkqzQDcupgpuFNiRMS26iNHQ9Hzfs/eGC8NVUBbA
         5d6S+nFicND37TMic4XAA/KfmOYM+4cQJsNXYEXMNLU1HV+Wer0Wi4WroYybjuCJMNJw
         vEMu1Ai0QLTR0Ne/E1sPCnjiJQdsDUkQDvp//w9mL0JAZ4S6D6mVYQ2e4pziXGPg97EP
         v/wA==
X-Gm-Message-State: AOAM530oXvn+GkoMO2hY79FhtR04+7pEs/pRq4hdTA0Pl56jxbrgtd3k
        lY2xwewgutjQQuPW3wAyy2TgjadJCVVStncRPw0=
X-Google-Smtp-Source: ABdhPJzlRIRtoPzwVk7kHwiuXq78grkaK/7Dl+kWqnxo9eIFixTk9r+atZJDIEc03NwwCIID5WUNcj8W5xd1AhHXg1w=
X-Received: by 2002:aca:30cd:: with SMTP id w196mr10135264oiw.167.1622236038421;
 Fri, 28 May 2021 14:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210528201014.2175179-1-felipe.contreras@gmail.com> <20210528201014.2175179-12-felipe.contreras@gmail.com>
In-Reply-To: <20210528201014.2175179-12-felipe.contreras@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 28 May 2021 14:07:07 -0700
Message-ID: <CABPp-BFsugBhk8-jkCpruFqn2W0aVjbyALwQgBYj56X9cf9vMw@mail.gmail.com>
Subject: Re: [PATCH 11/11] doc: push: explain default=simple correctly
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 28, 2021 at 1:10 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Now that the code has been unconvolutized and it's clear what it's
> actually doing, update the documentation to reflect that.
>
> Namely; the simple mode only barfs when working on a centralized
> workflow, and there's no configured upstream branch with the same name.
>
> Cc: Elijah Newren <newren@gmail.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/config/push.txt | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
> index f2667b2689..632033638c 100644
> --- a/Documentation/config/push.txt
> +++ b/Documentation/config/push.txt
> @@ -24,15 +24,14 @@ push.default::
>
>  * `tracking` - This is a deprecated synonym for `upstream`.
>
> -* `simple` - in centralized workflow, work like `upstream` with an
> -  added safety to refuse to push if the upstream branch's name is
> -  different from the local one.
> +* `simple` - pushes the current branch with the same name on the remote.
>  +
> -When pushing to a remote that is different from the remote you normally
> -pull from, work as `current`.  This is the safest option and is suited
> -for beginners.
> +If you are working on a centralized workflow (pushing to the same repository you
> +pull from, which is typically `origin`), then you need to configure an upstream
> +branch with the same name.
>  +
> -This mode has become the default in Git 2.0.
> +This mode is the default since Git 2.0, and is the safest option suited for
> +beginners.
>
>  * `matching` - push all branches having the same name on both ends.
>    This makes the repository you are pushing to remember the set of
> --
> 2.32.0.rc0

Much clearer.  Well done.
