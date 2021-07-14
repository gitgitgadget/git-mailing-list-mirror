Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF833C12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 20:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98160613BF
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 20:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhGNUpD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 16:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhGNUpD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 16:45:03 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698C3C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 13:42:10 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 8so5831053lfp.9
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 13:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vqMyozeRBw0AAZDh2B/5qmEba0lzSFA2yPPrHxiOxfU=;
        b=S1mSvv+6mbXgqHpAElcOXrhGUl0iVzPWxssb+NyMYS4qvlLfo2AD/qJdndKST99nn3
         ThqMK9jXAdSlCYjCrSFGFod4N5Hyr/oBlbM/eSiKGczDgA73xjSd/VNEKoAQwQdh1mm7
         8eu+L1yeMK1SEjDpj61eipEb+VPKjvVUUhezM4qqA1uB93rEVgq1jYyIM0SHLaV2l2n/
         hnmDxC1S0fNSIbtkU7bft4v2qHlyj+y7WM2wdCSWf6NR4uoChrC40T90Pf2OMUCwAINb
         Ivq0GUMWVgukI8n7NBrYkxkEOwa9Tq5n3rP6WxG2GcIAR+t/FzRFMdeVAyX8HUQLN7qW
         HU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=vqMyozeRBw0AAZDh2B/5qmEba0lzSFA2yPPrHxiOxfU=;
        b=oUivEDJ/O3wydbYdAn4QRhMjUpLSmpp0yrhPUkr05Zt7GdY7tiwWMpOoKJF81yMQd0
         5GyAb7EIzSuZvVbujnJRsRn0yf4IqGQgJouvvP35gId6eEJHfoVGHqFdr39cJ/3XYU/H
         E7FKQmIyZTCO7rmCfQWpiY80MDKofjRob5Ff5g3k3F4EV4dgvxzp1F1ypRJY8i5CXfKP
         +CocfQul/h7GJ/HXqfrSoRfIV/PwDPEj6g8RSyZO0M7BrcgEkv5zr5ePvFsxHPwxJC4C
         oufwnyAdHPjH6bA0yAPmiq5zpZasM1dUjspFKJZctafc9JsjrF1wbko4SQkVnlKKzFxq
         ZpnA==
X-Gm-Message-State: AOAM5337s/nT5kEmlawk5EC5k8rIWh7tVls+9c455THZhxpRHZXZAmCn
        z91ppb6H9TXSVkBQK6Fx87qJTShKtYA=
X-Google-Smtp-Source: ABdhPJx9H5llg3JLwCHFmNc/ius7Lh4tTLRB9h9NmA76EoaPvZuVyZXWnp+VxuFFoe7kpXy+6jSfJw==
X-Received: by 2002:a05:6512:3f20:: with SMTP id y32mr66853lfa.655.1626295328485;
        Wed, 14 Jul 2021 13:42:08 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id j14sm263519lfc.20.2021.07.14.13.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 13:42:07 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Martin <git@mfriebe.de>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: PATCH: improve git switch documentation
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
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
        <87im1ieaba.fsf@osv.gnss.ru> <60e9fa5132e14_7ef20849@natae.notmuch>
        <87im1hfa8r.fsf@osv.gnss.ru> <60ec715c8338_a452520896@natae.notmuch>
        <87y2aalbvq.fsf@osv.gnss.ru> <60edbaefa0208_ab6dd2081f@natae.notmuch>
        <874kcwemhn.fsf@osv.gnss.ru> <60ef404076d18_9578a2089a@natae.notmuch>
Date:   Wed, 14 Jul 2021 23:42:06 +0300
In-Reply-To: <60ef404076d18_9578a2089a@natae.notmuch> (Felipe Contreras's
        message of "Wed, 14 Jul 2021 14:51:28 -0500")
Message-ID: <87o8b4d3vl.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Sergey Organov wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> > Sergey Organov wrote:
>> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> >> > Compound operations soon become basic operations in the mind of an
>> >> > expert.
>> >> >
>> >> > Lifting your feet, and then landing your feet might be basic operations
>> >> > when you are 1 yo, but soon enough they become "walking".
>> >> 
>> >> [caveat: please don't take the rest of this post too seriously]
>> >> 
>> >> Yeah, using another name for a compound is yet another option indeed.
>> >> "git cretching"?
>> >> 
>> >> 
>> >> This is very questionable example. Please don't let me even start on
>> >> this.
>> >
>> > You don't need to validate the concept, but chunking is an established
>> > concept in cognitive pshychology [1]. It's how humans learn (and
>> > possibly machines too).
>> 
>> The urdge to dive into the muddy waters of psychology to support your
>> example, where pure logic should probably have sufficed, makes the
>> example only even more suspect.
>
> Suspect to you, maybe, not to anyone who works in the teaching industry,
> where this concept is well understood and accepted.

Well, if you've replied to them, then I'm sorry.

To me your particular example:

>>> Similarly checking out a commit and then cherry-picking a sequence
>>> of commits while resolving conflicts becomes "rebasing".

remains controversial; concepts or no concepts.

Thanks,
-- 
Sergey Organov
