Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB2AC07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 10:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A8896127C
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 10:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbhGMLAX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 07:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbhGMLAW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 07:00:22 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFABC0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 03:57:32 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id r20so29284362ljd.10
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 03:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=+kwXSccbbHVoLn6kEoP+uPPHgn+uW2AxNLVAff1Kx8M=;
        b=NNEEn01ioHrzCpOQaCf5Y7AKzJ2tX4sdl0Lf2nquxImXyLvFs+NIdKmhQovkQVhB1y
         /Pl/b/PUZO0A6Rbo3bjnUgZ0LjdtWGOUs61rJ85SrsRSWzkNuFEvxpammYwZOBYQZ3OU
         0wleX5X5gEN2OyrhliEAh5E0nTaTUyFEGBWAaFI6TRD+p/Bv9tr9a5BVMK+PPE4xFP+j
         138QATMTZeBiQRPSS1dakf/IBKV8zuYPRnIPSvI9uqrYK6yhOshUAaEJzhZXiIs2amtY
         nmW6pf7OY8tUOsZAkoli8QVf1o6jhJrE4p8kJVZCFFoyD7Lmi+ROgImOZhfXcddbEOU0
         Yl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:message-id
         :user-agent:mime-version;
        bh=+kwXSccbbHVoLn6kEoP+uPPHgn+uW2AxNLVAff1Kx8M=;
        b=E8rE3Eu8s7uHC1bUrb5gO/bi+VUj1urvTbhmFqM4QE6lwzZd+bJwSMljTfBCKq+1dt
         i212Qy2++gJd5R+LZz392PY2nmQYZFFwjaGx2uMXu9AoYf+NVDGtKCUCsdw9uK2FCffd
         JOe8YQWgmEAYd2bf/fP/iO5w71vIANk7pKSV57FU3sTXSQCe+uv1QXaILXFzjxr5UGXj
         hj62m3EGDN0SOvjRqrwlxQp68gnNpqPNYOrl8NFM60AS/TDWqG/6s806inI5FP4qV5gE
         skUrOLBSajoe+tzajAvQYGNEYQSnyDRiU1VjqI0dDGPgXDt9t3xJ6+X6Mtg3rU5RxVlB
         ERtQ==
X-Gm-Message-State: AOAM530zu4nHAErrvtjjhZ68umrNSxy683cE369NzSPSEDtSsrXP9TDK
        2lcifBW5f71+Ao/i69j/26HhyV0V5Q0=
X-Google-Smtp-Source: ABdhPJwpLxiXvq4tMOS83L34X/Yg6+znkFRYaeczar23xVP9MUX8VMCXxWGrJHy7ccNj9mDpuUre7A==
X-Received: by 2002:a2e:b750:: with SMTP id k16mr3733031ljo.154.1626173850928;
        Tue, 13 Jul 2021 03:57:30 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f2sm1440078lft.225.2021.07.13.03.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 03:57:30 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Martin <git@mfriebe.de>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: PATCH: improve git switch documentation
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
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
        <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
        <60e874e1c6845_215320861@natae.notmuch>
        <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
        <87im1ieaba.fsf@osv.gnss.ru> <60e9fa5132e14_7ef20849@natae.notmuch>
        <87im1hfa8r.fsf@osv.gnss.ru> <60ec715c8338_a452520896@natae.notmuch>
Date:   Tue, 13 Jul 2021 13:57:29 +0300
Message-ID: <87y2aalbvq.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Sergey Organov wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> 
>> > Sergey Organov wrote:
>> 
>> [...]
>> 
>> >> Creating (a branch) is fundamentally different operation than switching
>> >> to (a branch), and that's why the former doesn't fit into "git switch".
>> >
>> > Not in my mind. Instead of switching to an existing branch, I'm switching
>> > to a new branch, which is easily understood by
>> > `git switch --new branch`.
>> 
>> To me:
>> 
>> "create a new branch" is basic operation.
>> 
>> "switch to another branch" is basic operation.
>> 
>> "create a new branch and then switch to it" is compound operation.
>
> Compound operations soon become basic operations in the mind of an
> expert.
>
> Lifting your feet, and then landing your feet might be basic operations
> when you are 1 yo, but soon enough they become "walking".

[caveat: please don't take the rest of this post too seriously]

Yeah, using another name for a compound is yet another option indeed.
"git cretching"?

>
> Similarly checking out a commit and then cherry-picking a sequence of
> commits while resolving conflicts becomes "rebasing".

This is very questionable example. Please don't let me even start on
this.

>
> In my mind I'm not doing two operations, it's one operation with a
> modifier:
>
>   git switch --new branch
>
> --new is an adverb, not an operation.

Well, let's see:

    git walk "First Avenue"
    git walk parkway

then, suddenly:

    git walk --new road

Just an adverb, a modifier. As if no any additional operations were
actually needed. Minecraft: who cares? Just saying.

Thanks,
-- 
Sergey Organov
