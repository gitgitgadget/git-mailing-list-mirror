Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F96C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC78B6024A
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbhGLQSR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 12:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhGLQSR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 12:18:17 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE8BC0613E8
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 09:15:27 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id w127so25063817oig.12
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 09:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=yAW+ApP+4LaZZNjka9edrVA9zKUg8X6LfJenFaPcw2c=;
        b=C1JahhGEbyOnNUjcU6KS2MSa+LArZ668OUoniA35w6CpnpmigntSMJ9GvrHCxSVUfZ
         SetcA0r2uzl4J5ctsCC0AOwa+jjBNPn2Kupx+ez+Tk+7+lMGzTO3mhHUM9DbcIs3pn7c
         f3mo1DL9PXo4Ccb92UbrKR09Ha9udp2UHIGkk+9uaAMDZfpD5e4cCENp/FcnliH8eFTC
         tQk42LNN9Jk5iYvS0h19imH5qkkIDNqj4pzGasfxB5Eb72Zjc5Rte9IxYx5kxvo7eNki
         lOP54J03e3TnV9wcZkE3IdGXphFgI9QzF++D774q6MWMkyE0csfQXfQBLblp0nHBKYEm
         zL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=yAW+ApP+4LaZZNjka9edrVA9zKUg8X6LfJenFaPcw2c=;
        b=OL8tQhnMHdgfD6ThuMFkBtvMLA3jIAk3d5FiK4YZDqR381P4fxYIjjdoysyjveAAlT
         WjcXZaRabAKfrGdXm2EiZYPQ/aButgmI2Pvw31wzC9j/6T1Qhi15Z2lS0e/XXoRNAeXB
         nTfH6SJVr7XglVhythQYddmnVTktSEplH0d7PCawM89V/PCmjdxhivsLsV1/T6NkCO6G
         MXH6nE/qxW9j3EXDWKnypNho71O3owIgHFY+cnogKP/wUjjG4Q7T8+F2lEZTbiUn1/e0
         15P/913YdzFilAmD4dueqjmcQXMIm9EKmH+8B8K9lL15zFsJlsFLvCIqXxGWcWG4fgSb
         vlnA==
X-Gm-Message-State: AOAM531BBzaGdd2RUs3evxoDEbyg7ItjtAhMOl7ggfnVF92vYFPXV/cs
        6G5UG7yX1WMtz/J9sZb6A54=
X-Google-Smtp-Source: ABdhPJzTj3uQJjKI7c7Sfgg6OdQGMn4eR01hS7DcykjgwAxW7J6112+Pp8Cmlk0yME12RxEd9DjAMg==
X-Received: by 2002:a05:6808:2024:: with SMTP id q36mr19901914oiw.130.1626106526692;
        Mon, 12 Jul 2021 09:15:26 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id x198sm3283542oif.23.2021.07.12.09.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 09:15:26 -0700 (PDT)
Date:   Mon, 12 Jul 2021 11:15:25 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Martin <git@mfriebe.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <60ec6a9d1ffd6_a45252083d@natae.notmuch>
In-Reply-To: <e9c2b9cd-edfb-cbed-9638-382a6b0da59b@mfriebe.de>
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
 <43b8d0bb-67f3-11dd-ec31-e102ce8e3b31@mfriebe.de>
 <60ea2ad64878_2a692084e@natae.notmuch>
 <e9c2b9cd-edfb-cbed-9638-382a6b0da59b@mfriebe.de>
Subject: Re: Naming the --forec option [[Re: PATCH: improve git switch
 documentation]]
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin wrote:
> On 11/07/2021 01:18, Felipe Contreras wrote:

> >> Also "--reset" does not have the same alerting properties to me, as
> >> "force" or "discard" have.
> >> This may be my English, but to me "reset" does not have the same
> >> alerting property.
> > 
> > OK, maybe it's a language issue. I'm not a native English speaker, my
> > mother tongue is Spanish, but I'm pretty sure my understanding of
> > "reset" is what most people understand: set again.
> 
> I am German. And yes "set again" (sometimes "restart", but that does not 
> matter here)
> 
> If a branch is set, as base and head. Then "reset" means to set those 
> two again.
> 
>       "set again" => They will still be there.
>       (changed indeed, but there)
> 
> The commits hold by that branch, are not "set again".
> They may become unreachable.
> 
> The word "reset" gives no indication on knock on effects.
> However, I prefer if those effects are made clear.

I gave plenty of examples where "reset" implies the previous state is
gone after it.

-- 
Felipe Contreras
