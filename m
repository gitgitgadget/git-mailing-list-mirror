Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80049C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 05:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbiI1Fp4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 01:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbiI1Fpw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 01:45:52 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2C674E32
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 22:45:51 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x92so2692119ede.9
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 22:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=f1M0gLFmF06Neg6q38OHsd7RuNg4Q1BLsgeOKNlgqXw=;
        b=ZbwTDvVhShrZO5qE9oUweDbEaDIDlgTo8RjSjfw3aIIFDTULgp9h3V/k0JJLdBOpIm
         ulfmT90LhXTPt7WvzXXAnJVg/RaD+AIzrZJ0LIjd9FLiJu8mTfFDavXxdO6l0ymjnQ0w
         j2hVvkS1P5XaIqm5/XkVcdNaLpCi5oIdU0fqKsRFKjRWJTBi07/b5M8RaPx8tE+IOmPy
         0xYdZ/Ufg/bTFgxSbeSEGqiC49rJN4ClgWaWYLlIP1dADVd3tWtYponFGzVorqfyaLYQ
         4lZhP2Z2QmUPy9HD0w/zsFAVKOcxs/FZWeZssc8tVyCbg/RSyUiS1lGG0KsSNgAdqmPo
         gNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=f1M0gLFmF06Neg6q38OHsd7RuNg4Q1BLsgeOKNlgqXw=;
        b=6Mt4UeeKSthoD972nR5NkYEKVm718ssplxwuvgzJqgG0AdC+0QwgUfbv3ShBFelP63
         6nBY1kl+iXnnEnQDjzxgvkc2Zi5K2zfle3hop4sJpX5ZdQiv/gIiqgzeyVmI8tQhv28b
         fI0ovVUp2EsELOd/pRJax8jOTnMlWuNSJdnY0YG+5YZmQuTEL3eKXjlZgNz6h1QK/ycf
         vESeUAOao4kEt1vud1mh5ETWJ22SRuLFcwy2PKy8qsYoeXjJsdMGCGg6qMmwKA5ajXG8
         FXTVtsvuw+IAko1zfQyHYBUrIH1ZFWmLSmedxyQaMr8KfzsP4eR9AMC11U1ayVjp9rqz
         ABUg==
X-Gm-Message-State: ACrzQf0on+cAebedsduPGQQ2T9lZ7SR7kfaJRjd1sLj/JGRmE63HCOAy
        6EmTFwPQKHs1K2O0Zqo64JY=
X-Google-Smtp-Source: AMsMyM5NI2+6l7yNnVog9rKzrV/3NEZgNToMssvccZOxx5qM8oE49UZxYyOEJQpsiow/Mn/iusfdsw==
X-Received: by 2002:a05:6402:28ca:b0:43b:5235:f325 with SMTP id ef10-20020a05640228ca00b0043b5235f325mr31204380edb.320.1664343949503;
        Tue, 27 Sep 2022 22:45:49 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id c17-20020aa7c751000000b0044ee91129f9sm2626266eds.70.2022.09.27.22.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 22:45:48 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1odPtE-000neE-0A;
        Wed, 28 Sep 2022 07:45:48 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        emilyshaffer@google.com
Subject: Re: [PATCH 1/4] run-command: add pipe_output to run_processes_parallel
Date:   Wed, 28 Sep 2022 07:40:02 +0200
References: <20220922232947.631309-1-calvinwan@google.com>
        <20220922232947.631309-2-calvinwan@google.com>
        <xmqqy1u9uddc.fsf@gitster.g>
        <CAFySSZA=tThoHdTY7+bMStvC=xeeyMiv4aVDYt-eNW2mQE10qg@mail.gmail.com>
        <220927.86ill9yymv.gmgdl@evledraar.gmail.com>
        <CAFySSZBSAW=zea8UoMiaQkf8rdJUBGHDYZQFkPLW7mRSciS-FA@mail.gmail.com>
        <220927.86fsgcy5j9.gmgdl@evledraar.gmail.com>
        <CAFySSZB3hp2WWk0bL77FBR91ueJ1eJFtuVCoyE-ooVT77Vo_vw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CAFySSZB3hp2WWk0bL77FBR91ueJ1eJFtuVCoyE-ooVT77Vo_vw@mail.gmail.com>
Message-ID: <220928.86bkr0xd9w.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 27 2022, Calvin Wan wrote:

>> Okey, if it's not blocking a re-submission of yours then I'll definitely
>> wait until after the RC to submit the above, at least, but if you'd like
>> it earlier...
>
> I just tested a solution where I add pipe_output_fn to
> parallel_processes instead of having it as a variable. Not only does
> it work but it also solves my unbounded output problem, so this is
> no longer blocked resubmission.

You mean the internal "struct parallel_processes"? How do you get the
parameter there, presumably by passing it to
run_processes_parallel{,_tr2}() as a new parameter?

The reason for why the "ungroup" wasn't added as a parameter at the time
was to avoid the churn of changing every single caller of the API.

But it should really be a "parameter", and doing it via a struct means
adding such parameters doesn't need to change every single caller.

Then we have outstanding WIP patches for the hook.[ch] API which needed
to add two other parameters...

So I think first ripping off the band-aid of making it painless to
extend the interface is the right thing to do, unless I've missed some
way of doing it that you've just discovered...




