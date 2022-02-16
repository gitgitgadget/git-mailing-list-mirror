Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B6BC433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 03:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343942AbiBPDBb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 22:01:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240388AbiBPDBa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 22:01:30 -0500
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28711FBF2D
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 19:01:19 -0800 (PST)
Received: by mail-pl1-f173.google.com with SMTP id 10so952731plj.1
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 19:01:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iKnj/jQUd6dOImyiAR1ak/M6UvtzMwqYJawunUbbI+U=;
        b=KsggevAICEYaiafc9ernNKVRZJ2ko0mcWynDj1aAPvvOkI0Zan9PtS7i6TipZRJVEl
         UuZqUESq9VsQPOThBS4+CxbVo8CRDUdEaZs0O5PVEFa0mnUOEizTwknt81gacui1Ka7Q
         mOqbF2LIsKZGx9EDJnUlj48vtchGlvZ7YGAtLFb+ado+98ANgY/X5O97XaNcHeCffG2f
         3Dx1b51LWCOnM0FPWV0KtXywLcDI20VXbiWPO3GD0lYObn3SHJ/ynfmlytUALYuBPnPh
         YX2LwNCOn8L3dunzlL+McDyMaME/wbEYM37PPe+JB1lpzf+XjVP2jG9YYLmIPZghfRSR
         AlzQ==
X-Gm-Message-State: AOAM533lwOeXnbEoa6OnjR/fDSnrgD0HILrrhtaWBgAsMFK1io+JMfCs
        jTM2Fr/km/0ANmZQ7HKrr64olnHL1sHTD9MF567ZT9Yw7i10FQ==
X-Google-Smtp-Source: ABdhPJyILbqLoEHdwrz8sMRVtShqchs7dWIoPgGR2M2JZFVW4n5kpz7GgrChz9iQXOekTRK8rD/a7XcLypM9A+il/BU=
X-Received: by 2002:a17:902:a713:b0:14d:8f49:84cd with SMTP id
 w19-20020a170902a71300b0014d8f4984cdmr333738plq.145.1644980478460; Tue, 15
 Feb 2022 19:01:18 -0800 (PST)
MIME-Version: 1.0
References: <pull.1212.v6.git.git.1644862988.gitgitgadget@gmail.com>
 <pull.1212.v7.git.git.1644972810.gitgitgadget@gmail.com> <aebaf7e3fe1d4448037d2caf03f3de393908ff9a.1644972810.git.gitgitgadget@gmail.com>
 <xmqqfsojy50b.fsf@gitster.g> <BE7471F8-0141-49ED-A34B-04D69BE18D96@gmail.com>
In-Reply-To: <BE7471F8-0141-49ED-A34B-04D69BE18D96@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 15 Feb 2022 22:01:07 -0500
Message-ID: <CAPig+cQUwErXaZR-xZ8u9iz4kpEkE4G5QaxNRCuUx_Xt0rQ_-g@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] cat-file: add --batch-command mode
To:     John Cai <johncai86@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Wong <e@80x24.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 15, 2022 at 9:48 PM John Cai <johncai86@gmail.com> wrote:
> On 15 Feb 2022, at 20:28, Junio C Hamano wrote:
> > and make the caller do
> >
> >     dispatch_calls(opt, ..., nr);
> >     nr = 0;
> >
> > instead of passing a pointer to nr like the posted patch?
>
> Yeah, this is what I had before but there was discussion about separation of concerns in [1]. But perhaps it's preferable compared to passing a pointer to nr.
>
> 1. https://lore.kernel.org/git/CAPig+cTwLhn1GZ_=6s0FXL0z=Q=p1w9ZGK0hAV8wfK9RsQYjnA@mail.gmail.com/

My biggest concern when mentioning it during review was that if a
caller forgets to do `nr = 0`, then a sequence such as:

    dispatch_calls(...);
    ...
    dispatch_calls(...);

will send dangling pointers to the command handlers in the second
dispatch_calls() invocation because the first call to dispatch_calls()
did free(cmd[i].line). In that sense, it's an accident waiting to
happen if people modifying this code in the future aren't paying close
attention.

That said, I don't feel too strongly about it and mentioned in my
review that it might be "good enough" as-is (with the caller having to
remember to `nr = 0`) since it's a local helper function.
