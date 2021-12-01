Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B08EC433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 05:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346678AbhLAFPt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 00:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbhLAFPp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 00:15:45 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1946C061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 21:12:24 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id c32so59768254lfv.4
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 21:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c0FP52ZJVRedf143mKqr8T/0ACjtxEcOV0CBi0OW39o=;
        b=NIRJKZJIm7GkyYXxiVPaCgHTb+Mtd927Nnl38/tkb24bHDRYlAkX1PpcwwTIY8Ah5Q
         wK8FRmm9DQTtWxqxQRiHhpU7m8lkV2aunmrDqtKJvQHqwn6P2/3NLS++BANCzLWNrfAQ
         h7rHt+WitUUPWfO1Gk10YaexbN1z47N6lKVndINTMa8TmbVzj6Y+svPMmRTcXHernsPa
         3cZzikQvSycWCxL+62rLs43OW+A4U5DRln6RF8Qsv+tIgdkCqD71ZBu962cBQbXhtcwy
         tlRX4Iqnjw+qVbaWIzAxK60AIVRii1jYG4CMQ0+/m8GyqT8FuloeUt6FAF94nEXciPuS
         POzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c0FP52ZJVRedf143mKqr8T/0ACjtxEcOV0CBi0OW39o=;
        b=g8CyZEu+nCt0f+50mQHBlLPgxca5ofmxz92KFpLDI+OeIQOpDQM1GJSgc6gpP9aCXt
         WL+d3AYXD1EF6PJFY7dicHP4GuNVZoWOriQDPwdYH5lrMNbikAu7KHP5hERsPOIwqQ82
         eVcaf6DTYhPbl4LwhIDpJw8GZfutNb3hdZg0uvBwgzw+r1kqBsnYyyxMf5DMYJ2QNF2Q
         qfCzJBZ9DTssBi53StfY0ILSe8fuwnoXQpc1Y8WaHAfU2qU1YOzVZLtE1VwpGakHouYR
         2QrcYIvMzcyuMu4S0byw0LG2V87h0YsP4SDlbnDOH1/q4SFmBvngwcylcWwNEz4ZBkfS
         d3yg==
X-Gm-Message-State: AOAM533LQPK1CYhiTKkC0rgxBf2IwfANFtxKaen80+UvnL0UoKvLUyxN
        x6mLczmWcFBp6xcqpmfPsPthcXsL1VUb6CZo1jg=
X-Google-Smtp-Source: ABdhPJw12HAOQ/P1gQI3pOsjlzcAagFv6Z7BH6u0W6gZllHsYiw0giPemq/p38j6yhjFtAL7KkyOmBpZmkd/yXTckrM=
X-Received: by 2002:a05:6512:32ca:: with SMTP id f10mr3873965lfg.364.1638335543301;
 Tue, 30 Nov 2021 21:12:23 -0800 (PST)
MIME-Version: 1.0
References: <04ab7301-ea34-476c-eae4-4044fef74b91@gmail.com>
 <20211122222850.674-1-carenas@gmail.com> <b1f2257a-044c-17bb-2737-42b8026421eb@gmail.com>
 <CAPUEsphP2GRaHJa0Qnvf22WUnNB+GnnfG8TgHqwJvSGdYfUQGA@mail.gmail.com> <7138fa14-02b2-b123-4d8d-df73763f8431@gmail.com>
In-Reply-To: <7138fa14-02b2-b123-4d8d-df73763f8431@gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Tue, 30 Nov 2021 21:12:12 -0800
Message-ID: <CAPx1GvcML9TvmP1BSLN0vKWD++8LBj-68Xwmz-KrZM32Q=0_Ug@mail.gmail.com>
Subject: Re: [PATCH] editor: only save (and restore) the terminal if using a tty
To:     phillip.wood@dunelm.org.uk
Cc:     Carlo Arenas <carenas@gmail.com>, Git List <git@vger.kernel.org>,
        thomas.wolf@paranor.ch, Alexander Veit <alexander.veit@gmx.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 30, 2021 at 2:41 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> On 23/11/2021 17:31, Carlo Arenas wrote:
> > Restricting this feature further, maybe through a configuration
> > property or even special casing the EDITOR is also IMHO a good idea.
>
> I think just doing this when we run the editor may be the way to go as I
> think it is only that case that can mess up the terminal.

If it only happens with certain versions of vi / vim, perhaps Git could come
with a front end program that saves the tty state, runs vim, and restores the
tty state. (Or set this up so that the program can run any editor.)  Then add
a FAQ entry if needed: "if your editor goofs up the terminal, insert this front
end program".

Chris
