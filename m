Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC372C07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 10:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A734D613C3
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 10:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbhGJKK7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 06:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbhGJKK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 06:10:59 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546A5C0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 03:08:13 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id t30so12585625ljo.5
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 03:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HHgRLiinkvTYTfoXYdpk0KBsOudCsS5MqQiCjljobxE=;
        b=Ee/AurAXBJ8iZRnoXGj6SyXB3btWEz2ZO2l8+FQvz4dLZihJ7j2d2MSy/uLcJT93yF
         JCYryKYLQcJR/AcCfRzKj6nLWKwzZ1XYbV2Ngq0LLxpOfOkGos9ituR94Sl+E8qN0h+u
         yGZ0i4Q1lAycqeojtvnU8KvHPf14jFlTNK5vrvxnfIro5bCyrLpNNqyaVKRGv6XBPfjG
         yzXTO1XXaymrxB3uf9msTTgW9wi8SWayt9HCuK0zzL0poQfTGs5d4vHnAOkny7MTtgxh
         2zMWKy4nZN5NDMUF0q5mXI6z9dIWK42df/SGkDw2np/obVcYQu31tZIzCeqWg1LImlQg
         ZOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=HHgRLiinkvTYTfoXYdpk0KBsOudCsS5MqQiCjljobxE=;
        b=PYLZUwpVQ9TC2Z1ImCMePbzieS8AFI/KTNZ2pViNJdW1Jt9FzxvRqqrH9coBaJ7gH6
         AjIdk2h7SGNtBo5x62nKayqB/8bQ+00taXwi94EZoiwtVrTcQ1ed2JYZVvzHkdHI81Qh
         OKu1K/QCNioFLY7x6V33k02071GWgLdMC4kL6aJQJa3Y6YLySkeHaJCglIJjrzAUeMEo
         KxGEE40OUQLn8gB4SQINKumnkAkb0b462QVIB9maBDl12gv1MDCn1+3qpmRM3o3AA6qW
         VI0SpTSRwrvrd906A5jg1KrXLpcl3zmgUDHa1Fbjtyjs+88Q2d+MFZw4A5JnNUl5UpI1
         J7VA==
X-Gm-Message-State: AOAM531LJs3utVJUZUZiAgeOBfsefEfPD1IwEmGhXhXjwDAi5ptQGS/d
        MhsN8u6ZiaNP74FfawQkD3/W5RIhqgs=
X-Google-Smtp-Source: ABdhPJx0W5DA5bssBQ/2wwYN0cA2eSoDxYGEn0BQ7yBoaGXf2S2rrppOhcYxXl9vacIdT99gRRrbdA==
X-Received: by 2002:a2e:9cc7:: with SMTP id g7mr16427675ljj.217.1625911691271;
        Sat, 10 Jul 2021 03:08:11 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id h2sm674740lfk.97.2021.07.10.03.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 03:08:10 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Martin <git@mfriebe.de>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: switch requires --detach [[Re: What actually is a branch]]
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
        <xmqqpmw4uwh2.fsf@gitster.g>
        <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
        <xmqqy2arrmba.fsf@gitster.g>
        <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
        <87wnqaclz8.fsf@osv.gnss.ru> <60e5f3981de5f_301437208bc@natae.notmuch>
        <87bl7d3l8r.fsf@osv.gnss.ru> <60e61bbd7a37d_3030aa2081a@natae.notmuch>
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
Date:   Sat, 10 Jul 2021 13:08:09 +0300
In-Reply-To: <57f316cb-850d-706a-592b-4376f240e032@mfriebe.de> (Martin's
        message of "Fri, 9 Jul 2021 17:23:23 +0200")
Message-ID: <87h7h2mqgm.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin <git@mfriebe.de> writes:

> On 09/07/2021 17:08, Felipe Contreras wrote:
>> and the fact that
>> `git switch` expects branches is one of the things that bothers me about
>> it.
>
> Ah, good point.
>
> I would word it differently though.
> "git switch forces the use of --detach if switching to a non branch"
>
> Bit of a twist.
> It's a nice safety for beginners. I remember when I started, I kept
> ending up detached. And I had no idea what to do next.

I think it's more because of too technical and thus confusing name for
it rather than the state itself. In fact this could be described as
"being on unnamed branch", as if HEAD points to a branch with empty
name, and is not detached in any sense.

It's nice that once you are on unnamed branch, nothing actually changes,
so no any mental shift is needed to get out of this "state". BTW,
unnamed branch could probably even start to have entries in the reflog.

Overall, I think Git needs to move into direction of getting rid of
"detached head" in favor of "unnamed branch" at least at the UI level.

Getting back to "git switch", if the above sounds reasonable, "--detach"
is a bad choice for the option name in the first place.

Thanks,
-- 
Sergey Organov
