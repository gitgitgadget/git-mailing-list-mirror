Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C17FC07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 14:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 189B161178
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 14:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbhGKOwR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 10:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbhGKOwR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 10:52:17 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CBBC0613DD
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 07:49:29 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id f30so36289701lfj.1
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 07:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nRIox1Z1C4SAGRFXt/pqTD2gcqeWXS2lNWuJc6KINDI=;
        b=MSwvWWdFELPj1IdjW27zKGGnRon0jnu7ZwyEOHEgBHv2Q5ZfXrLHk3thKyZbyx5w2n
         br45jRRqZ1GqeOyvsQaF+VRzUzBaxjBGhPR2vSLyufuvi0X3j1jKOx1+4kH7GpN6xxaF
         ObiG/eWa2Ry3gvWp5QJLdKBHVFi9XEooBzuRC274Wa+oidK5Anyy4/m/MaI++RK68jXJ
         cfPQU2YnpzxXLtfPrWWi52OYlk8soUXQbH7elFZmcaMbQVHJfmPqmxPxCiFW36jaR5Wo
         TNB3bfXgN/sMgsNjnuWe/QTdKd9Vr8rB3IVqb6210iqbEtmwpVQbykjF9ceXVwKQe4yV
         th3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=nRIox1Z1C4SAGRFXt/pqTD2gcqeWXS2lNWuJc6KINDI=;
        b=rbenMvTRfjq2gDmoygi9E9cu6JNHNMn9HnVwjJFdH7Rq8MPelHrE+s01SODXDHpohJ
         p51sFuUI+CF/z/7Yeh2DT3kk9Mr/kNwpaTHfC+O1msugKh3AgbMeONRlAvd39J+JL4mz
         fOUkdjjs69Bxxdz41XoZFE+1J5ReIgLE1Gdy9TeuiANxNVRQv+wRA8bZc1UCozBmuPm1
         vRFqFrVHijPSu1TVoHJFeXZ3VEm+rjQFb/1lxXqIBql+1uktl9Syn3SRn+46jFuXvDFd
         wzON2Ah16eLE2onv2Mq+VhMeeA9Nii0lcFy4Ke2LoihJyxQZBYfiHVuSDrKi9ezoukmC
         qHEQ==
X-Gm-Message-State: AOAM530aFVX/J6wP4y1jerAhk4WctaUau8eB+Y6RnLSVVHg1Q/MXhh3J
        c/IW7jQXEROEUFNEq+fvASL8JO0Jf7s=
X-Google-Smtp-Source: ABdhPJy93wejOO10RzlELc3ty6mytly7k9y8Q7cLCaGmlac3oRicW2+shlMzXY45sCW3d903UTc3GQ==
X-Received: by 2002:ac2:42d6:: with SMTP id n22mr36347031lfl.41.1626014967365;
        Sun, 11 Jul 2021 07:49:27 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id q17sm1230779ljp.3.2021.07.11.07.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 07:49:26 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Martin <git@mfriebe.de>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
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
        <87im1ieaba.fsf@osv.gnss.ru>
        <1bd36aa2-ac90-f7d4-9d48-1aa39159b263@mfriebe.de>
        <87a6mudt9b.fsf@osv.gnss.ru> <60e9ff4430c57_7ef20815@natae.notmuch>
        <874kd1gr0q.fsf@osv.gnss.ru>
        <6ffd7f1c-97be-a57c-b738-31deae26e8fc@mfriebe.de>
        <871r85f39n.fsf@osv.gnss.ru>
        <33af677c-8fec-5b49-0e00-878918c4ea1d@mfriebe.de>
Date:   Sun, 11 Jul 2021 17:49:25 +0300
In-Reply-To: <33af677c-8fec-5b49-0e00-878918c4ea1d@mfriebe.de> (Martin's
        message of "Sun, 11 Jul 2021 15:39:19 +0200")
Message-ID: <87sg0kewi2.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin <git@mfriebe.de> writes:

> On 11/07/2021 14:23, Sergey Organov wrote:

[...]

>>>> Once that is regularized, we may as well consider allowing for inverse
>>>> order of the first 2 arguments, by making
>>>>     git new remote
>>>>     git remote new
>>>> the synonyms.
>>>
>>> Having even more ways to do one and the same thing....
>> Python was aiming to have one obvious way of doing every single thing...
>> Did it succeed in that, I wonder? Maybe this aim is only good in theory?
>
> We are way away from having "one single way". But aiming for the
> extreme opposite may not be any smarter.

I don't like extremes either, but when there is a choice, there should
be at last a stated preferred way of doing things. Guidelines, if not
the rules. Otherwise we end up with an ugly mix of random preferences of
different authors.

>
> While there is nothing wrong with going our own way in the end, maybe
> we should look around before?
>
> How do other vcs do it?
>
> svn has at least status and log, which I would consider nouns, the way
> they are used. And it has verbs too.
>
> hg as "branches", "files" which are nouns. And "log".
> And it has verbs too.
>
> So there seems to be a pattern to using "mixed" verbs and nouns.

There are so many things they did wrong... This could well be just
another one.

Thanks,
-- 
Sergey Organov
