Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC0CC12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 19:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5561D611C0
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 19:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240427AbhGNUCj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 16:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243602AbhGNUBM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 16:01:12 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023D9C04FAE6
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 12:51:31 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id w188so3591148oif.10
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 12:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=KfCZAZ6ZQ+Z06wWHdQIIiBmiBr4YXZFcXg2T6+4moOc=;
        b=uw3f3118ye1N7iMjVp+fjXykgLT0wetPg9cA7KLvLx20u8WkxpDWUURCNFw8amE5qI
         u6mkr1qNxf0RksICNcAsrMRYYq5u72l/pT5mvOkEI0QwLDXDDbtBHSjNt3B881/QDllx
         yCljJDPrPWOw+cKAAkU3x3KQtv2sUr/dVHObIJAF9X1ZDSIW4XNWSF/7DwjTV9qO1jjM
         cInKHOwD9TB1v4CrXra7p+WGwIXmpTDBT5emTIOtmwAxxEYPnMPNjBemLAlX88e4m/kN
         cQRuUFGGGk5Y0W2TMA+49eSjS9mi1DInh3y7lrxZ6cUJJwU/Fh668nUn+aCX+wGqdmQ8
         Jtpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=KfCZAZ6ZQ+Z06wWHdQIIiBmiBr4YXZFcXg2T6+4moOc=;
        b=YpW2yWiNLLoX+GFxaxg4u1eQLmGKvs0iV4ZkagJLVjfAbYVEUbUPNovnw+bRH38IpE
         MlGIPjN+ODhcBGdsdLd8X/yy7+jvGd5bTlVAEh7xixybCSWrh9u86CDbxikoa3yWS3OW
         ufXEQkcgnCW94bIji+tMeUGjCEwIYohXN7QHYjha/+oGK5+c8jwmkmirBW+ujAHjLx85
         NuMMYWTTMnEKNZy1OjYX6RCGN+831jyFR/tn0Dya08EXZONUNv7ZRfsUwlLSP/pYZgzN
         1heZ7dOyGRRtVtSvsnH11YSqNWOkzfL4PAxEJITKxYkKRilcqFeiErtuUdpQsgSUP2wH
         183w==
X-Gm-Message-State: AOAM532sOWGBV7oayA55vpEp29yOxPy8/pN0qNpJW7CirtUFGJ5Vj3A8
        NyCEkPxxOU+xM6kNh40hxxI=
X-Google-Smtp-Source: ABdhPJyegRfjPxNhf5uVB3rSjKCjp6nE5tfy88KAQehYcpwXqg7nOyAFij5jxaoezx+hD6lLbkF7Ew==
X-Received: by 2002:a54:4d8f:: with SMTP id y15mr4301446oix.32.1626292290387;
        Wed, 14 Jul 2021 12:51:30 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id m21sm597565oov.43.2021.07.14.12.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 12:51:29 -0700 (PDT)
Date:   Wed, 14 Jul 2021 14:51:28 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Martin <git@mfriebe.de>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Message-ID: <60ef404076d18_9578a2089a@natae.notmuch>
In-Reply-To: <874kcwemhn.fsf@osv.gnss.ru>
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
 <87im1ieaba.fsf@osv.gnss.ru>
 <60e9fa5132e14_7ef20849@natae.notmuch>
 <87im1hfa8r.fsf@osv.gnss.ru>
 <60ec715c8338_a452520896@natae.notmuch>
 <87y2aalbvq.fsf@osv.gnss.ru>
 <60edbaefa0208_ab6dd2081f@natae.notmuch>
 <874kcwemhn.fsf@osv.gnss.ru>
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
> > Sergey Organov wrote:
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:

> >> > Compound operations soon become basic operations in the mind of an
> >> > expert.
> >> >
> >> > Lifting your feet, and then landing your feet might be basic operations
> >> > when you are 1 yo, but soon enough they become "walking".
> >> 
> >> [caveat: please don't take the rest of this post too seriously]
> >> 
> >> Yeah, using another name for a compound is yet another option indeed.
> >> "git cretching"?
> >> 
> >> > Similarly checking out a commit and then cherry-picking a sequence of
> >> > commits while resolving conflicts becomes "rebasing".
> >> 
> >> This is very questionable example. Please don't let me even start on
> >> this.
> >
> > You don't need to validate the concept, but chunking is an established
> > concept in cognitive pshychology [1]. It's how humans learn (and
> > possibly machines too).
> 
> The urdge to dive into the muddy waters of psychology to support your
> example, where pure logic should probably have sufficed, makes the
> example only even more suspect.

Suspect to you, maybe, not to anyone who works in the teaching industry,
where this concept is well understood and accepted.

Cheers.

-- 
Felipe Contreras
