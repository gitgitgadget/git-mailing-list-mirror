Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AC7C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 16:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2536611BF
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 16:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhHFQPv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 12:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhHFQPv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 12:15:51 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40533C0613CF
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 09:15:35 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id v24-20020a0568300918b02904f3d10c9742so6127891ott.4
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 09:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=b5PJGw+pGEISqwz9WhYaOLMHyoXaImMORegN+pznqEk=;
        b=U43dLnFPekTe+m/GnvhJ/50M8dOEcs7xLDH5nqhF5hMVPFXjs1hhTJSgnHFXWtTDjD
         gTkDs+vV+7TX/EKXXJ9iqIiUqnPNy5ohck1iuA/QeP43F/zw2QSDG8QQdqdhqRZkOcIu
         3hG87H5mAJ+es90FJIO0er16pqXsHt1T6mHNnexaryrkbl0CLAmCLy7qokMj0ejFZVJS
         YqSWABATAVHryk+WRu87KReo5rt1bibnQgfI6434BcrOPAuoVSlPi648oSDOk5aPwAVD
         IJ5+P1VGLDEL9mInptNfUcNlrEbdYTxzIp0Or1DoFQChjfmKnv3zwPDRbFGmikhnnkqw
         6LsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=b5PJGw+pGEISqwz9WhYaOLMHyoXaImMORegN+pznqEk=;
        b=JwVj0r7qmYipUYYyRBooqUW+TI8vf4KLz8FiBueN4AgkYvQfQHzHG+CrdY/PMdx1DA
         eAIq9fH2A6dnezGm9IT28j6Kr6MYYeORNwnVVEWsm3uOQwMu787b/XcdIiQFXcrBKZ5i
         42GGzuKpePhz4wx8UYWL+JDzBZho3m5Rhs6Urlz4HlV4CtUVcM05dEdh74AVA75P8heC
         PwRmiNqOTVVbyf28vw4hsZbJ/X81kzsazTSCqylz+qEJgI7mgx0RwV6hD85uaLfWYyWO
         n8GlpP+22rZADbqzGp9435cTFpAjTogb2W6LN1sIfb5mz4son1Gnv8EnIvrYKIoSGo5U
         gJzw==
X-Gm-Message-State: AOAM533tm6/9/qIVb679TaKpVmNqmVEETukRCaFmi4SzKd+TlivkrtMA
        +9sxfaTMuuYIa3n/3z9dILA=
X-Google-Smtp-Source: ABdhPJwRy3s5DN9WXV6q67rSCzYSJg21XpHCDCrOvj1A9KFQgJfNkTLSoxSNa7CbG8lOjLoJkUW1/A==
X-Received: by 2002:a9d:7d10:: with SMTP id v16mr7828947otn.121.1628266534592;
        Fri, 06 Aug 2021 09:15:34 -0700 (PDT)
Received: from localhost (fixed-187-189-69-1.totalplay.net. [187.189.69.1])
        by smtp.gmail.com with ESMTPSA id v4sm1551457otk.75.2021.08.06.09.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 09:15:34 -0700 (PDT)
Date:   Fri, 06 Aug 2021 11:15:32 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>,
        Fabian Stelzer <fabian.stelzer@campoint.net>,
        =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <610d6024abb9d_1594208ae@natae.notmuch>
In-Reply-To: <87k0kzzc91.fsf@evledraar.gmail.com>
References: <20210805194825.1796765-1-felipe.contreras@gmail.com>
 <87k0kzzc91.fsf@evledraar.gmail.com>
Subject: Re: [PATCH] test: fix for COLUMNS and bash 5
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Thu, Aug 05 2021, Felipe Contreras wrote:
> =

> > Since c49a177bec (test-lib.sh: set COLUMNS=3D80 for --verbose
> > repeatability, 2021-06-29) multiple tests have been failing when usin=
g
> > bash 5 because checkwinsize is enabled by default, therefore COLUMNS =
is
> > reset using TIOCGWINSZ even for non-interactive shells.
> >
> > It's debatable whether or not bash should even be doing that, but for=

> > now we can avoid this undesirable behavior by disabling this option.
> >
> > Reported-by: Fabian Stelzer <fabian.stelzer@campoint.net>
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> =

> I've got an alternative way of solving the same immeditate issue in[1],=

> there's discussion on that approach in the latest What's Cooking[2].

Yes, but I'm not allowed to participate in that discussion.

> My preference for mine is in no small part that I'd like to not be
> responsible for into-the-past test suite breakage the next time a
> popular shell decides to be clever about COLUMNS.
> =

> But this way we'll solve the immediate problem with bash, and I can say=

> I told you so if that submarine breakage occurs with this approach :)

I believe what bash is doing is a mistake. I don't think COLUMNS should
be updated within a non-interactive shell by default. I'll report that
as a bug once I'm able to subsscribe to the bug-bash mailing list.

So I think it's the opposite: not only would similar fixes not be needed
for other shells, but it won't be needed for bash either.

-- =

Felipe Contreras=
