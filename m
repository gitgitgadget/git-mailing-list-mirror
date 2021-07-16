Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF436C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 21:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDF85613F1
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 21:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbhGPVZc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 17:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhGPVZb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 17:25:31 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646B3C06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 14:22:35 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so11319991otl.3
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 14:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=coEcLUiwErTp44UDA6m8c5qW5Ua+Ft8xFC2QHTI1XIs=;
        b=KRxoCeJYN0c1iRVNZGXFLtBLfndZg5AGE6Tp4+EmTX5GqNKF9ABhWPeq1FYLBuUFW2
         hP3uq8l1oZJZFJtB8qAqXR3reqyAqo4wu29omVpRUOnZTIHNKlU6Y123b3AqwVfXe0RL
         jtdNCAIeCs1Bm6OtaOfNilLEnAVmsK5cCU4EKIWWWOV36D5zVLByDhmERRKZNvt3py0B
         g2Sg17d2qVbpegTjnV54IIMtvEpgcku5IEXuWNF8TSWL6VQpCtcDcP3KERGg+RCVdjPR
         FkcIP4K3we4mXGCJbDS7fAohlyvCnX+eh46kGW9oGvgF7+SrTy1FLwVzMjV+ZO5i8yRn
         Zymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=coEcLUiwErTp44UDA6m8c5qW5Ua+Ft8xFC2QHTI1XIs=;
        b=VhFLgk67jRIUC+icZMkZN7tRoEpgXGoTDllSywZM1h4cmBM5RrqrRicsKRz4mYCEDU
         0ypCsy0HYzOHD7yqYD8Msh6b8Ac3za2R7ndzBQFZVTP2I5tHkycM6CsSHR8skC+VXNGD
         Y5cqiXIJZNivOxS4kbGBZWeMVZgBsVBkBbkc77JPl5QEIvx2XimmZf/4JN42J/YAt8Ol
         4rACiv9CRClS314vk+OVFX1h4ITLZOY3vDnypq07Udp9mVZuJjDZeUbjZa9Uh+beLIk6
         tvhZ2luvQ/dNQGeqP+TWozpb4m60xgOli1gxhaiC9SYVOmS45oIbsjP6kCHHks7PUdK2
         cRJw==
X-Gm-Message-State: AOAM5301p1cXQ0wWQnA6c5Oc1ewPewSop7C+1UWQdp82Npnsbvlz6/GW
        DW7rB/QSzX6xqDbJAcFb+oQ=
X-Google-Smtp-Source: ABdhPJwA/ignyxny3opwn39th3uqlcuSZynJoLPOLxTOUze7oQb9dWBbKMtAO5OCnYNoqvdQMIVYUw==
X-Received: by 2002:a05:6830:9c7:: with SMTP id y7mr595724ott.111.1626470554719;
        Fri, 16 Jul 2021 14:22:34 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id y61sm2155325ota.31.2021.07.16.14.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 14:22:34 -0700 (PDT)
Date:   Fri, 16 Jul 2021 16:22:32 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
Message-ID: <60f1f898eaea9_14cb208e7@natae.notmuch>
In-Reply-To: <2bdd27b7-cbe1-6952-eca0-f6fcecdaec8c@gmail.com>
References: <xmqqmtqpzosf.fsf@gitster.g>
 <2c7f188a-6ebe-b116-8299-86ca3732d79a@gmail.com>
 <87czrl0wob.fsf@evledraar.gmail.com>
 <xmqqk0lrtuh4.fsf_-_@gitster.g>
 <CAPig+cT24=jy65C1cQ4WarakJHKm4F8_78nDm=jWOnHxfhtcRw@mail.gmail.com>
 <2bdd27b7-cbe1-6952-eca0-f6fcecdaec8c@gmail.com>
Subject: Re: [PATCH] CodingGuidelines: recommend gender-neutral description
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
> On 7/15/2021 12:35 PM, Eric Sunshine wrote:
> > On Thu, Jul 15, 2021 at 12:25 PM Junio C Hamano <gitster@pobox.com> wrote:
> >> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> >> @@ -541,6 +541,49 @@ Writing Documentation:
> >> +      A contributor asks their upstream to pull from them.
> >> +
> >> +    Note that this sounds ungrammatical and unnatural to those who
> >> +    learned English as a second language in some parts of the world.
> > 
> > It also sounds ungrammatical and unnatural to this native English speaker.
> 
> A way to adapt this idea more generally would be to pull a phrase
> from my commit message in v3:
> 
>   Note that this sounds ungrammatical and unnatural to readers
>   who learned English in a way that dictated "they" as always plural.
> 
> Learning English as a second language is one example of how one could
> find it ungrammatical. We could call it out explicitly:
> 
>   Note that this sounds ungrammatical and unnatural to readers
>   who learned English in a way that dictated "they" as always plural,
>   especially those who learned English as a second language.

This is loaded language. You are inserting your opinion into the text.

Don't. The guidelines are not a place to win arguments.

  Note that this sounds ungrammatical and unnatural to some people.

And it sounds ungrammatical because it *is* ungramatical, not only to
native English speakers, but professional linguists.

-- 
Felipe Contreras
