Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB1DC07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0081761186
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbhGLQhX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 12:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbhGLQhW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 12:37:22 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2093BC0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 09:34:33 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so19444078otq.11
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 09:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Ans+30xye4j4r3KC9wN3cE4xHqB05+rG6sofHz1lzXs=;
        b=UgKdi/BxJIfooCx5PYct0ppGVkVSMl0a1Dw/2PXLUo2OHkfMR2yywgQKFpSh3f8lhx
         mgSrUvnlQRkbldt+KWItWy7Ks0LCe7tpRKVC30wvFtYkqQKAOP+zBCG8C8/AxmylaTjy
         4KUb0JnXxbsiF2tYeTC1BH5169IZYU5mI9AsZc8t6pcjVjSkvd4pmzsh5YXlpr1/NE2c
         IbzUXMroGOmYIT1wxHMzVcnMUuX9Q5/Z/Vsqdzahhn48mN1Er4Xb4bdcjVTjIhhgCntr
         z9rkhHxNGrU4XylPApMr53KVUnApg+bWnXLoPFIp6NJP9qKhvjW5Rm36bI9LERdBNP2J
         bgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Ans+30xye4j4r3KC9wN3cE4xHqB05+rG6sofHz1lzXs=;
        b=W2RqD7a3zibUB5BwgCMPsPSxrsylbslYVK95aiFaAx/NnoAfz54ZRuhiOnN0IJKiKC
         Q+cgZxbegbopsED5MKalqtul+syZLjyGZ+ONCExdFTfh6qyDBquk6YTLcTrijOcgviEN
         tTCS3hGRuchSfoGF6/UU5JJJsfnryXg1dmUuaOPyMf1rwbY4bqOvFO7up24TlfUXLz7V
         E4TyYoC7Sxf0SUWLOQ8WV/I0kPSQO69to8MQpliVhrhJGGl5Wa/AXzCGdal9Z29xIlZe
         fpYDMEzuidOfPHwhBB915uwbUDCnEk3wL97ishZE62xPrKIyfXoZ2Fg/ZEKsbHEkapHZ
         gpwQ==
X-Gm-Message-State: AOAM5310YgsQ6IVCv7ArzO059oKH2OTpbYVoLJS2THANAPghOCje/O6W
        g2+15/fpJXyRXi9XQBesoI4=
X-Google-Smtp-Source: ABdhPJylFkRAIbFCSskt0kab2dLKb/A6t76ms+mZ+ncGPQlReQEpMzymbj9eTX7eSlwlJveAGgN55g==
X-Received: by 2002:a05:6830:14c5:: with SMTP id t5mr35927otq.141.1626107672019;
        Mon, 12 Jul 2021 09:34:32 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id y18sm3168880oiv.46.2021.07.12.09.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 09:34:31 -0700 (PDT)
Date:   Mon, 12 Jul 2021 11:34:30 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Martin <git@mfriebe.de>, Sergey Organov <sorganov@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <60ec6f167968d_a4525208c4@natae.notmuch>
In-Reply-To: <0d7190ae-e64e-d1fa-2367-29f302c2ff7e@mfriebe.de>
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
 <878s2dgu4d.fsf@osv.gnss.ru>
 <0d7190ae-e64e-d1fa-2367-29f302c2ff7e@mfriebe.de>
Subject: Re: PATCH: improve git switch documentation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin wrote:
> On 11/07/2021 09:57, Sergey Organov wrote:
> > Martin <git@mfriebe.de> writes:
> > 
> > 
> > [...]
> > 
> >> Currently only the branch is mentioned.
> >> Currently nothing does explicitly say that *commits* can be affected.
> > 
> > Commits cannot be immediately affected. One of the most essential
> > features of Git is that commits could only be affected (deleted) by
> > garbage collection. That's what makes Git so nicely safe in operation.
> > 
> > It'd be unfortunate to have statements in the manual pages that
> > contradict this.
> 
> Tell that a new user, who never heard of "dangling commits" or the reflog.

The user doesn't need to understand what "dangling comments" are, not at
this point. All she needs is to know is that there's a concept she
doesn't understand yet.

> For ages, I wondered what git fsck meant by "dangling commits" and why 
> my repro always had "that problem".
> And what I might do with that hash it gave me.

Yes, but it's a thousand times better to not know what "dangling
commits" are, than to incorrectly think commits are somehow gone
forever.

It is fine that the user has knowledge gaps, and it is fine for the user
knows she has knowledge gaps.

-- 
Felipe Contreras
