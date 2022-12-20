Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB212C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 00:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbiLTAte (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 19:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiLTAtc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 19:49:32 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E7BE013
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 16:49:30 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 7so2293085pga.1
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 16:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7d9hicHRXFuYZs7eBCqfrFDbNqpMcSzwtIX5R7nF9SA=;
        b=Y9Ncfo4cJlIgP3+B2wRf2aJipB2Ws5LQ6e+mIODVZE30jW4vkBldJyeUlzjan64xRu
         1K4vummaxHrkFblKh1gbGdxN11IDgd/5CuPW93vMo9OhC54iHUVrJJRbP8k0dJqxZbYG
         AsgxubCt39AWe/SCkJppP98X6BuCSA7FmaQpF7ayrC6a0S0QWo5ylEYp3XXEW51R267Y
         h4Fsc21l66GJfm6D9N8vx4Q/mrBhaYBWNZA9Cqq1UsUFvaEJMlO2s4v8GfYskdETVFIu
         sp0DB+wcehfIBOYCdjynowqf4q9H+J+xgIWog0CWPP2BB+jN891kY0DJlnhHZZnkXr3T
         dDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7d9hicHRXFuYZs7eBCqfrFDbNqpMcSzwtIX5R7nF9SA=;
        b=nYWIegh3+P/DsY/FNRRPnrzf8eonQC288zH888ByYIbYKFvdUYhppVX7PPZdXMT5hu
         VmXlkFNschOrILw9Zy3tgZ4kk2ZhJ+UOGz7VsR0G5Hl98mxqHqnLczuN2hDz9J0FveF2
         NaCr/lLjo/8x5MtMoGfbnnM3UE+QPNt7uYGGdBskskBA1l0Dvlv9x6NpfqhyYJ5ko82K
         /EXq1WgOyuPDuCqm28TVmGJRauTdrxBs8HfjcdnSQ+5PV9LnhTSMND+GaVxGWW4p+66+
         +fn2fT20QgMgB3r8HNYdRO7XCGoIxeIanSWmEy5TDJ3S0vLkaZCo+EdvmpsSnoUqLrch
         viwg==
X-Gm-Message-State: ANoB5pnwDNsMj0VKadm04tgxWDyL/gblpC3Ww80JXc7eo5LmEvmTs+Vd
        yAUPyeP14+AsqvF5XTK92Jo=
X-Google-Smtp-Source: AA0mqf7KJ7grblW7wcvbg3YT89SggtGvwPf+hcBI5ykf0yDH0WA6kRiskim0Lpogb2VfNays04ZMEQ==
X-Received: by 2002:a62:3287:0:b0:56b:d0eb:47b3 with SMTP id y129-20020a623287000000b0056bd0eb47b3mr42479511pfy.5.1671497370268;
        Mon, 19 Dec 2022 16:49:30 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id f4-20020aa79d84000000b00576e75e753asm7286914pfq.27.2022.12.19.16.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 16:49:29 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/3] bundle-uri: drop unused 'uri' parameter
References: <pull.1443.git.1670866407.gitgitgadget@gmail.com>
        <d17f08ed4b68d711b452b5cfb54a949845bdea81.1670866407.git.gitgitgadget@gmail.com>
        <221219.86tu1rzmbs.gmgdl@evledraar.gmail.com>
Date:   Tue, 20 Dec 2022 09:49:29 +0900
In-Reply-To: <221219.86tu1rzmbs.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 19 Dec 2022 11:57:17 +0100")
Message-ID: <xmqq4jtq292e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> ...here we have a stray typo fix, not called out in the commit
> message. I think that can pass, but if you're re-rolling I think any
> such "while-at-it" would be better split into their own commits.
>
> But more importantly:
> ...
> But looking again is this because in 7cc47a980ac (bundle-uri: download
> bundles from an advertised list, 2022-12-05) you accidentally
> copy/pasted the documentation for fetch_bundle_uri(), and this was never
> applicable to this function?
> ...

I think these three patches were designed to be "oops, that was
wrong and here is a band-aid" follow-up fixes on top of what was
back then in 'next'.  Now the base topic has been kicked out of
'next' together with these, we can afford to roll them into the base
series before merging it back to 'next', but due to things generally
being slow toward the end of the year, that hasn't happened yet.

Thanks for reviewing these carefully.
