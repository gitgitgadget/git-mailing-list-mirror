Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6707C07E9C
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF80860724
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbhGLQay (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 12:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234441AbhGLQaw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 12:30:52 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CC2C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 09:28:04 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id w127so25115822oig.12
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 09:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=nvu/CbA4T5quxMw3+Pw5fvqKesOEQbo+GPBl0eYMP38=;
        b=iJjTZX7dYHP6WqWw6J9GLlW/LcJNUQSHbFd80kQGauX99LIaJqcCmXyQkhjqnfTq9E
         fB3MNhA6EzJQNE/EJ1SlL/c6PcBeBrXJ1ON43ux4HRBji+bEQJaEYF5UDI4CG6NHc520
         UpXOQVGAJ4FkVo3RI01UpKzJx52cqb/pb/gelmRU3FFf0NXWwooJVacc8GEa5u4n6C3L
         FxLaYx9Ast4FQRpbLGhzF8SiIoCgkC0E5UCdp04VIMH1usICGca6hsG7GBmcWPd4KeIr
         ymDOYuRlCwU+SKkrcboPF6UKU83HMb+zvfQ0s3pUuQYveb6esaafmHYWqD6S8L1cfkrW
         T4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=nvu/CbA4T5quxMw3+Pw5fvqKesOEQbo+GPBl0eYMP38=;
        b=Ymhl1Rq4+GnDL8ZAqqPrJd7bkg6nYfpRYz0c50P+3D3L3xxVgAwxCYlJipDmYYjLcI
         +3CuuUJ5PtfBRu5JN6lc2NR+ofHQmcYxjizY5cHZwJjmAqtfjlkckIAQ4oNE+/xir/qC
         K5O/cYuIL187X2wAkHnfcCeBcmi+04K5+J1SN1dL3RzRgjVZhe+GIVfZPq9vGsMuAuis
         OyKxkK3gk9lryrlmwty8ktoqoZYKmKcCzqx98rIJUyYh2leU2v4nvkAfL+LvaePvAXvB
         cIz3sQiKrYfT6QB0Ri0e6sK/r+imEGsxH/lkh+eXtwwDe+uJ34PhnTKiaD6KjvgSy+3/
         6LPA==
X-Gm-Message-State: AOAM531kKX2gSb6PXsKEyI/b2sHoQVBKG0qa4DVQSWLjFd9aQCphT+dj
        nomyLQsIiS4wLUTQEaJLv/Q=
X-Google-Smtp-Source: ABdhPJzyE6/UEM3oLnJF4ZcXl21usnEOSlQH4T4A95cmtBDt2Eyuuxw9wel2OBQLhU8nKGxnUQpsPA==
X-Received: by 2002:a05:6808:1506:: with SMTP id u6mr11106343oiw.83.1626107283549;
        Mon, 12 Jul 2021 09:28:03 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id l3sm1730949otp.9.2021.07.12.09.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 09:28:03 -0700 (PDT)
Date:   Mon, 12 Jul 2021 11:28:01 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Martin <git@mfriebe.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <60ec6d91deced_a452520825@natae.notmuch>
In-Reply-To: <1e18c4ed-6975-5041-4b4f-75c4d3d21860@mfriebe.de>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <87bl7d3l8r.fsf@osv.gnss.ru>
 <60e61bbd7a37d_3030aa2081a@natae.notmuch>
 <877di13hhe.fsf@osv.gnss.ru>
 <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
 <60e67389a4adc_306ac1208fd@natae.notmuch>
 <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
 <60e736e72da68_30939020850@natae.notmuch>
 <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
 <60e762243aab1_30a7b02089@natae.notmuch>
 <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
 <60e79c31aaa72_30b8a4208c1@natae.notmuch>
 <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
 <60e874e1c6845_215320861@natae.notmuch>
 <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
 <60e88a4b8592f_16bcb2082b@natae.notmuch>
 <ad58bd54-a9dd-59a9-4fce-f90be469cd60@mfriebe.de>
 <60e9f8d462bd9_7ef20898@natae.notmuch>
 <6f43b36b-abe1-41f2-6138-e820c974b1bd@mfriebe.de>
 <60ea07e3495e8_7ef2081d@natae.notmuch>
 <30e4c874-6b87-b03d-fa33-fde5b7e50b2a@mfriebe.de>
 <60ea2eb562f26_2a69208e8@natae.notmuch>
 <1e18c4ed-6975-5041-4b4f-75c4d3d21860@mfriebe.de>
Subject: Re: PATCH: improve git switch documentation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin wrote:
> On 11/07/2021 01:35, Felipe Contreras wrote:

> > Do this:
> > 
> >    -N <branch>::
> >      Create a new branch like '--new', but if it already exists reset it
> >      like '--reset'.

> Or even shorter
>        See the --new option.
>        Allows to re-use a branch-name and may drop commits
>        [resetting it].

Yes, it is shorter, but now it doesn't even say what it does.

-- 
Felipe Contreras
