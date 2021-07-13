Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB574C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 16:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8D86611AC
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 16:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhGMQNR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 12:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhGMQNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 12:13:16 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45898C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 09:10:26 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id u11so29201873oiv.1
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 09:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=/l9iDoz3Gb74n0aa0j7waFiaMgn2GAmB67iwF8lxfb8=;
        b=Bq+tbUM7BoAq5kF4pP9jyje5AG8AITL12t4qmn7qIXEAgBRCtQ+OCt+/7CKIATu536
         O24RyW51T2os0A+KQ8fxmf/TVH9qnDPu6a6oyZFOezseukAu/hFCc+fyoU2y0BKsqitd
         dXQtBdmYfAn/dUDMf2NpINQ7/xaMQ0SDne4YUgTDvwLeerSJyl7pooFrIRLH5Lgxsx4L
         064QhfBRH5M3cMuaOMPWmxjMQV3Tq4/jdwLtJDICQauoWwIkfjGdz22nBBBHi+bqUA8j
         koPx9VJBdC6HVRVDC7lE4Tza/aDghXDJ+DwL3/9hHWilDiHt07XWdoGgUrayDP8sYYmH
         FXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=/l9iDoz3Gb74n0aa0j7waFiaMgn2GAmB67iwF8lxfb8=;
        b=bGeRBGeAStx3SNS+NU/FfAjuTfL6iNwk4pRzbJ1Ejgbw0R+Bm90xJniNXRb8NCVDv/
         g+2xDynnAfxOC7Au9suKFfdXj/BWcaztam/58/Qt4EnNiD0k88ZyquBC1GXc1EUyrcN8
         Af8rD1jw0i8YWKzn/0ysyjNTMMeibCiQJyDxML5tb4i7klR0OPhZes2As/GA/kCgnDE/
         M/mTPyQmruRdqb2y0pLJu/WgBEpjY709e0PecGk2uhQtjA2itGBZF9bqS8aIM2+pM3ca
         NKwbh0+H2Lg0CvqMWfGsJ92SnedVMxG3BGr58TJl/WM+oTR4X5UqNbraRhm802N0YJBJ
         G8zQ==
X-Gm-Message-State: AOAM532CtkGbLlX23h53GnoAgTbxn/8atymR0NrdRJP3ouOxPdC6yeHJ
        ExGBZFYcfvFQAF+z2CAIwNY=
X-Google-Smtp-Source: ABdhPJydBpIc1+4UODY5UaSZlytNa0WKykgUy9cwquz2oz4llNrmQtN1nann0WzVlbo9VosWw2BNTQ==
X-Received: by 2002:aca:4302:: with SMTP id q2mr3642802oia.111.1626192625676;
        Tue, 13 Jul 2021 09:10:25 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id q9sm3845648otk.18.2021.07.13.09.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 09:10:25 -0700 (PDT)
Date:   Tue, 13 Jul 2021 11:10:23 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Martin <git@mfriebe.de>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Message-ID: <60edbaefa0208_ab6dd2081f@natae.notmuch>
In-Reply-To: <87y2aalbvq.fsf@osv.gnss.ru>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <87wnqaclz8.fsf@osv.gnss.ru>
 <60e5f3981de5f_301437208bc@natae.notmuch>
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
 <87im1ieaba.fsf@osv.gnss.ru>
 <60e9fa5132e14_7ef20849@natae.notmuch>
 <87im1hfa8r.fsf@osv.gnss.ru>
 <60ec715c8338_a452520896@natae.notmuch>
 <87y2aalbvq.fsf@osv.gnss.ru>
Subject: Re: PATCH: improve git switch documentation
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
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >> 
> >> > Sergey Organov wrote:
> >> 
> >> [...]
> >> 
> >> >> Creating (a branch) is fundamentally different operation than switching
> >> >> to (a branch), and that's why the former doesn't fit into "git switch".
> >> >
> >> > Not in my mind. Instead of switching to an existing branch, I'm switching
> >> > to a new branch, which is easily understood by
> >> > `git switch --new branch`.
> >> 
> >> To me:
> >> 
> >> "create a new branch" is basic operation.
> >> 
> >> "switch to another branch" is basic operation.
> >> 
> >> "create a new branch and then switch to it" is compound operation.
> >
> > Compound operations soon become basic operations in the mind of an
> > expert.
> >
> > Lifting your feet, and then landing your feet might be basic operations
> > when you are 1 yo, but soon enough they become "walking".
> 
> [caveat: please don't take the rest of this post too seriously]
> 
> Yeah, using another name for a compound is yet another option indeed.
> "git cretching"?
> 
> > Similarly checking out a commit and then cherry-picking a sequence of
> > commits while resolving conflicts becomes "rebasing".
> 
> This is very questionable example. Please don't let me even start on
> this.

You don't need to validate the concept, but chunking is an established
concept in cognitive pshychology [1]. It's how humans learn (and
possibly machines too).

> > In my mind I'm not doing two operations, it's one operation with a
> > modifier:
> >
> >   git switch --new branch
> >
> > --new is an adverb, not an operation.
> 
> Well, let's see:
> 
>     git walk "First Avenue"
>     git walk parkway
> 
> then, suddenly:
> 
>     git walk --new road
> 
> Just an adverb, a modifier. As if no any additional operations were
> actually needed. Minecraft: who cares? Just saying.

That's how my mind works, regardless of what you think about it.

And any experienced driver of manual cars would tell you that they don't
think in terms of pressing pedals and moving the gear stick. The
individual operations are meaningless.

[1] https://en.wikipedia.org/wiki/Chunking_(psychology)

-- 
Felipe Contreras
