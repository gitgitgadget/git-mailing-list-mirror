Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432C0C07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 19:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2539F61356
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 19:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhGJTVb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 15:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhGJTVa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 15:21:30 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739A1C0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 12:18:45 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id j10-20020a05683015cab02904b568e08dccso7229097otr.4
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 12:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=OhphQYiXQqfLBNZ1PStpcv2hCsafdXEqVBtBRRnYR1U=;
        b=XIxvPObgMKuha6gR0tEXPjXM0hF2le5TMdZ2o5JzszlOFFdM5wcemf6FJdFB9J+9S1
         sks32F8Liz/RQyx4gWUG7FdAHCCmvVmAUWDk7p+AzbgSEMaJoDZ7PhJT/vjhrtq8t4Gk
         F4sxp+MVrWtQkxaBNAWhvuiknG/5tdAMkYF+7PHKY5h1U3GBQU1TDP5rBMfH8CQooWdN
         Al4mJtZzLMVbM3bcM8Cmo509Ahn3HSCKKN6tmb2wPG05kaYWgvmtLRHdy8VSoNyurZZO
         d3kv73pPgUf4DlkX4fVF14WmdvRUtCRhc1Arhsfucff3cz82rORD+on/D8eoDS5dJui0
         +cvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=OhphQYiXQqfLBNZ1PStpcv2hCsafdXEqVBtBRRnYR1U=;
        b=oDrYXGSme3kus+kEuhXPBXbRT49+0xL341RgAclOocZUpmexYTNlLaDgkmv4Svbaz+
         Eh3UMMskO7NhnMBI6zRkRPEaT+zg6KLqSw9riqx1fvr2lu1HTtyEJdx+Es9yRpJ3XIvb
         JMd2vJc1lJAtHO7YXuEvYBvYfkbKhOgUT9TdVw/1o2R4Emfi4Qlcw6blBAitnFdlVIQD
         zzud3V3Rpk5xql5GDP/7Q4nwe2b6x04tjFMFEGWGsGWDJdeTUqJF0ru6tzg7JMLtkm4k
         25R1pUgkz9YnJzHMi82Lquzo5NlPuQzKaM0xBPJrcuu6AnrPnTiAR4Joui4MafmRE/Oi
         wDzQ==
X-Gm-Message-State: AOAM533wXd0aimItilxytXzJ6eMZooc7MnzIICvKZ2Y2KXynYLZ7DjXP
        GHxoZHBz1S8jrOMa/oxUgQ0=
X-Google-Smtp-Source: ABdhPJxx5SY2x/VVHFnCVYEQhH5ivJj3YeqW4e7WnL5toEdMs7GpxkQIk+/XyiZgxwQnghBEUummKw==
X-Received: by 2002:a05:6830:1d8c:: with SMTP id y12mr3056886oti.75.1625944724615;
        Sat, 10 Jul 2021 12:18:44 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id o20sm1675264ook.40.2021.07.10.12.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 12:18:43 -0700 (PDT)
Date:   Sat, 10 Jul 2021 14:18:32 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>, Martin <git@mfriebe.de>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <60e9f28885c5a_7ef2081e@natae.notmuch>
In-Reply-To: <87h7h2mqgm.fsf@osv.gnss.ru>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <xmqqpmw4uwh2.fsf@gitster.g>
 <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
 <xmqqy2arrmba.fsf@gitster.g>
 <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
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
 <084a355e-95cd-5c84-2fa5-a901da3e0e49@mfriebe.de>
 <60e8666c8707f_2153208c0@natae.notmuch>
 <57f316cb-850d-706a-592b-4376f240e032@mfriebe.de>
 <87h7h2mqgm.fsf@osv.gnss.ru>
Subject: Re: switch requires --detach [[Re: What actually is a branch]]
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> Martin <git@mfriebe.de> writes:
> 
> > On 09/07/2021 17:08, Felipe Contreras wrote:
> >> and the fact that
> >> `git switch` expects branches is one of the things that bothers me about
> >> it.
> >
> > Ah, good point.
> >
> > I would word it differently though.
> > "git switch forces the use of --detach if switching to a non branch"
> >
> > Bit of a twist.
> > It's a nice safety for beginners. I remember when I started, I kept
> > ending up detached. And I had no idea what to do next.
> 
> I think it's more because of too technical and thus confusing name for
> it rather than the state itself. In fact this could be described as
> "being on unnamed branch", as if HEAD points to a branch with empty
> name, and is not detached in any sense.
> 
> It's nice that once you are on unnamed branch, nothing actually changes,
> so no any mental shift is needed to get out of this "state". BTW,
> unnamed branch could probably even start to have entries in the reflog.
> 
> Overall, I think Git needs to move into direction of getting rid of
> "detached head" in favor of "unnamed branch" at least at the UI level.

I agree. But UI changes in git are pretty much impossible (although not
100%).

> Getting back to "git switch", if the above sounds reasonable, "--detach"
> is a bad choice for the option name in the first place.

True. Maybe --unamed.

-- 
Felipe Contreras
