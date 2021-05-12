Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD88BC433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 03:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6946961941
	for <git@archiver.kernel.org>; Wed, 12 May 2021 03:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhELDLH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 23:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhELDLG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 23:11:06 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767B9C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 20:09:58 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso19407167ote.1
        for <git@vger.kernel.org>; Tue, 11 May 2021 20:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=xLC09sKaGCeOVR13oE4lkwbUG6tuOGBYCn9bEiGWRb0=;
        b=YbjZ5wLZBFOVPGuVzohHUkhkV/7zH5ZFCO1kT+9myTT47DTvs7pl8JYj/aXXkNYpJx
         uOlDSdkVFdP92MA/FVZ+3SlkG/wCGVC67N2fuTHSXLeUj+Iy6D68Bcgshzff2xwsxjl5
         ty+1LVSl7r8ycu45jBZjH8+F3qsQy441lH3EVNDu19rcV4+reBjGIZboUw9oEch/v/pp
         GKG/N/6BGqgsYRTY6C0w7HAQYE+1TIHLaVYLL7VkxiNKzXekFttugkbR2gtKh3zdY6+r
         0zkKLnqNZLZ6wmFDrcZ93ihlh98ih2jZAvhcFO0252YASLC6AOjuigvHuTAa1Q3fjbEr
         BlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=xLC09sKaGCeOVR13oE4lkwbUG6tuOGBYCn9bEiGWRb0=;
        b=TdRUkGcyY7ZJgjWKqiYAVI8HzH7heywspY8KnJ+uMQZG7Z5ktnMdYJQZSE31p1Djea
         1lEN/osezV2HXhwRsmTbx4H2t1EKytnubve9x2kGPag9S1pg8wPvN0bHeYQa/jm4UNsb
         zk92a29cDH9dn2EiI76RRrLdcGwcDjVdqGWZ39UN/uP6S5Gddnt+GrmmXc/oF6vEMrhA
         GrRUx3pOTCwrsiuXe7fOHTqNFCLnql4xNhPWLPzwa1WkXFYYiXCVovcB8kE6LulWYvao
         7rBPlmn4/Vfkiz4NutBNmKv/pbXggwTKUG8Y3YfZqQFyb4EYWFJSJCuF6j+8AP8ZhCbc
         tltg==
X-Gm-Message-State: AOAM533Ef8Jo2GZ/Rh2dzXsZowfyQJgF/VhNbiXMbMz0wtm+J3BIK8Jt
        4C/TgWzCQdjdFRKThO+aNIL2onYM0sVF4g==
X-Google-Smtp-Source: ABdhPJwgbPmjUwsfLvhYYDOAYBGVr1tmSq/aZ/HEjDkSu5RsxjaHV3rjHWNUvRy/RDTDSMCCTrq8gA==
X-Received: by 2002:a05:6830:15d2:: with SMTP id j18mr29023960otr.89.1620788997947;
        Tue, 11 May 2021 20:09:57 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id b19sm1338169oib.46.2021.05.11.20.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 20:09:57 -0700 (PDT)
Date:   Tue, 11 May 2021 22:09:56 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Varun Varada <varuncvarada@gmail.com>, git@vger.kernel.org
Message-ID: <609b47043a719_678ff208e@natae.notmuch>
In-Reply-To: <20210511195723.GL12700@kitsune.suse.cz>
References: <CAD2i4DBj6fNvq=Lc3KiXJj5uBpteyKfEKp7ATOWrTE36KUeRww@mail.gmail.com>
 <20210406092440.GZ6564@kitsune.suse.cz>
 <609ad9473d535_6011e2082@natae.notmuch>
 <20210511195723.GL12700@kitsune.suse.cz>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Such=C3=A1nek wrote:
> On Tue, May 11, 2021 at 02:21:43PM -0500, Felipe Contreras wrote:
> > Michal Such=C3=A1nek wrote:

> > > If you are concerned about correctness and clarity of the documenta=
tion please
> > > avoid spreading misinformation.
> > =

> > Under certain definition of "jaron" Varun's statement would be
> > incorrect, but not under all definitions. If you use the definition
> > I stated above, "impact" can be considered jargon, because it's a bit=

> > obscure language.
> =

> Do you have any frequency data that supports your claim that the word
> 'impact' is obscure?

This is not how logic works.

If I don't have frequency data that supports $x, but you have no
frequency data that supports !$x, then we return to the default position;=

we don't know if $x is true or not.

Do **you** have any frequency data that supports the negative claim that
the word "impact" is not obscure?

> The bar for change should be that the word as used is very unfitting or=

> unintelligible.

No. The bar is that **nobody** have any problem with "affect", and some
people have a problem with "impact".

Do you have any problem with "affect"?

-- =

Felipe Contreras=
