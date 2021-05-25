Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F93C2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 06:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94E816141C
	for <git@archiver.kernel.org>; Tue, 25 May 2021 06:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhEYG4P (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 02:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhEYG4O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 02:56:14 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4D3C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 23:54:45 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id q17-20020a4a33110000b029020ebab0e615so5018106ooq.8
        for <git@vger.kernel.org>; Mon, 24 May 2021 23:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=DMgPVfULaP9q6/Kv50vDbrpPo48GaJp4htmebJi2ZTY=;
        b=g7ZsHFfEjUvq/ApPMcIUvyzuqDYLrFffxLMSp0F8o1UcYgYRoBZY3uGuyldjNpPNRM
         EYwhcnGnNfuIdvL3fk8madscBMWBSNYltD/XlPctP3NUKg6B/5G0+RdJ3pPCkzzm+lRz
         7SuoMGN/jDGWWhvpX15UD8WijezD737s/5CttvT5QIXHJ9XmjttWuwgknG72IiW7eA0j
         bhzTPTAVS7dLLW4hFpKDWxlPoGQztQUYUXU0Q/6U+mjQeqcPj+0Xe8OutT/uqnhXEFp9
         wiX4vzBrjDzSZTAciqccxdGw5GNa4rflSVW5kvEnAH52qLcqIXCvkmoOKR+0fgkw1YvO
         HSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=DMgPVfULaP9q6/Kv50vDbrpPo48GaJp4htmebJi2ZTY=;
        b=GryVi+0Cu+y1Ys5LiSoZBGXWyrJ0uWbSAJx0N4zMUt+qLIJly6mAUKraYAT4qairNw
         5p7A5uK+6wp+vsEtAvtFPJ7LZ7mmUrjRLTsh+6JxF5NfRQ8Eqa1ZUIOZuazwg5YVi1/F
         jfRVKCMvKuS/7ocBEKgeQnWuMwPJE7GOUNGygmwvSLAzx0ZvCg3sx1EYvhsuDnHoF5ev
         ixoyV/gDkAFEc58PTB8ZMCoBmhRmwhxw6Y4GlifbGb/Qytog4RuduyZXa1nKJAeSHRVU
         YmAfKRDup57ckGirSMG8j5XtzRshqoGGfJnLCtHCrtMT37v97i6tMN2S4dw49sNg4YV9
         3gzQ==
X-Gm-Message-State: AOAM532jVULFNHKHyPP6YlQxnkaQhX2Cg/ouDRuJjgAD621B0vli6M+s
        Pm1rfRT5tNBHBifBmxwPeKs=
X-Google-Smtp-Source: ABdhPJxZ564hmkXHYbyKWCf3jK6qFDiSsD6UYa0Ll2U9YcXpqjFR+OxyzT6+4R+3W0syc9o1KFIUPA==
X-Received: by 2002:a4a:a3c3:: with SMTP id t3mr21024385ool.50.1621925685155;
        Mon, 24 May 2021 23:54:45 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id a7sm3352982ooo.9.2021.05.24.23.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 23:54:44 -0700 (PDT)
Date:   Tue, 25 May 2021 01:54:43 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60ac9f332eeec_225d820832@natae.notmuch>
In-Reply-To: <xmqqwnrnh626.fsf@gitster.g>
References: <20210521222941.525901-1-felipe.contreras@gmail.com>
 <20210521222941.525901-4-felipe.contreras@gmail.com>
 <xmqqcztgj9za.fsf@gitster.g>
 <60abf32038579_1b209208d2@natae.notmuch>
 <xmqqwnrnh626.fsf@gitster.g>
Subject: Re: [PATCH v3 3/5] doc: remove unnecessary rm instances
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
> > I happen to have at hand a script that ranks the most common trailer
> > lines:
> >
> >  * acked-by: 25% (1945)
> >
> > Doesn't apply.
> >
> >  * reviewed-by: 22% (1729)
> >
> > This does apply, but I'm not confident Jeff would like me to add that.
> >
> >  * helped-by: 17% (1336)
> 
> I actually think people use this one to say "person X gave a
> valuable input in the review discussion", which is exactly the case
> here, and that was why I wondered you needed to invent a completely
> new one.

I think the opposite: "helped-by" encompasses virtually anything. A
person that reviews, reports, mentors, suggests, tests, provides a
patch, contributes, and co-authors... is helping.

The question is *how* he helped in this particular patch... By providing
comments.

-- 
Felipe Contreras
