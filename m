Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF5FC07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 20:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 304B861C3B
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 20:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhGFUyT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 16:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhGFUyS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 16:54:18 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD009C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 13:51:37 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 75-20020a9d08510000b02904acfe6bcccaso71848oty.12
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 13:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=KP4QYtQGMWUIhe2JduJocV71BPUBhttzktnEMUeVdlc=;
        b=XefeaQT2qqohbgZoSzYi8W8VN0WV64+tUbs3dUh/HepqUnKKmlok0b22vsfYqzMJm+
         QfUrt5HETUcmSREI4PklE9Leb0Z5CnKzMR2PdKaFzNRBSUpAP2Mna2Hb+dTqgvIVH5OD
         UHzAyF7V3wI8jwyc+gPXzhFdCgCcLeG33NnSejh0UXpmeb6IJdKEFWxdXRVlQLM6iBm5
         U0LIRxAP3hnsUjZbRGSKmFA37EhwKU6+gY56kvDPlo7BX9vr3Uxk4DMeCG/sBSrq6WRX
         2U7tfXzDVO4eGLESGjCREc8wBG3E6P6VjVkWRUzdRlcLynDIJ4bNE5GSAQvojARoPMs5
         yPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=KP4QYtQGMWUIhe2JduJocV71BPUBhttzktnEMUeVdlc=;
        b=aS/L6luYxQNfuAiS6l5Ye9HxzSP5zGFYYZZk4VQm9diKVrY7mLY3yrCyg8c2z4Lofm
         yPJe2qbSl6YnYOzJ4ySt0Uj+xnVV4pQtXb5Nsoiw3sRfDbZn7SIV3EaLr5Whfxt+Tmzc
         mJcd4BMdP0g3/hicyHv0qfn4lHfxdl/jJHtG38OPB0yqthPmyltoUYf/j+mZEP6vWWH2
         D4iMRVAYFX/LMDmn5ah88tvxy958KS88RxRSHgnTKxA/OzVgaqIUnpIf9qzs9a5m+xn4
         o8S8NtTD/sGcxIeeGOBByeA2Lkb4QPfuS3REzRtbxcTkEmfh7zQZNM+QH0UVoFs9jzv7
         PsfA==
X-Gm-Message-State: AOAM533UYJZbyY7LrCp6SL4fs2iHDNSlOCi7ovgS/37W7ov6rYqTaT0G
        hmf2MJkNru5ItEaGe5rDkt8=
X-Google-Smtp-Source: ABdhPJyYSAc19KWwfap656z7mwwJAEMMz69dDJ8wq7f2CJXJlOtPOGwUErUk2w+ZwerMWaBWYpbBLA==
X-Received: by 2002:a9d:2289:: with SMTP id y9mr3487215ota.211.1625604697275;
        Tue, 06 Jul 2021 13:51:37 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id 186sm3069965ooe.28.2021.07.06.13.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 13:51:36 -0700 (PDT)
Date:   Tue, 06 Jul 2021 15:51:35 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60e4c257a998d_1c42812085c@natae.notmuch>
In-Reply-To: <8735sr5hfg.fsf@evledraar.gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
 <20210705123209.1808663-12-felipe.contreras@gmail.com>
 <8735sr5hfg.fsf@evledraar.gmail.com>
Subject: Re: [RFC PATCH 11/35] update: add --merge mode
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Mon, Jul 05 2021, Felipe Contreras wrote:

> > --- a/t/t5563-update.sh
> > +++ b/t/t5563-update.sh
> > @@ -42,4 +42,19 @@ test_expect_success 'non-fast-forward update' '
> >  	)
> >  '
> >  =

> > +test_expect_success 'git update non-fast-forward with merge' '
> > +	test_when_finished "rm -rf test" &&
> > +	(
> > +	git clone . test &&
> > +	cd test &&
> > +	git checkout -b other master^ &&
> > +	>new &&
> =

> We usually indent the subshell...

All right.

> > +	git add new &&
> > +	git commit -m new &&
> =

> And if we can use test_commit, less verbose.

OK. Sure.

FTR. These tests come from 2013, they don't fit my current style and I
wanted to rewrite them completely since there's a lot of duplicated
code. But I thought: what the hell, they work. Plus there's only so much
time I'm willing to spend on an RFC v1 of this series (which probably
won't be merged anyway).

Cheers.

-- =

Felipe Contreras=
