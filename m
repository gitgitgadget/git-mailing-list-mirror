Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3202C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 21:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3097613E3
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 21:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbhGPV75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 17:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbhGPV7v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 17:59:51 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E92C06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 14:56:55 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 75-20020a9d08510000b02904acfe6bcccaso11332136oty.12
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 14:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=q8MQEfX6wqpZ5J9vwQcRY4RcxLlSmWSJn1qcu8l24Bg=;
        b=Sl+rBZh3uiUuZIgplMmSHRfPrYYGeK0lkTJX990Z4dG7GunuACC7/ST5xmZCSft06v
         V1HbIaKBhClz0C2eBASilmTutsO8VL6srLA3Hw6CW3IySASMjL8tLW9XLM53YEWTRxdC
         dpw7Bky6fXg9YxIJc1Rk0MCb6MX2bECglXclnEIWlmoiUWwTZush1k3a1pGmGIHLsWEy
         VNBP1vFOeHeD/CJa9BjkR6iOOaryQF2jBRfx5RQbP0r0Onr7u8N3rD9snuVOIIAHiNAc
         tYhnuXeOvh3LFeAZFjAk3Jto1/W7Ki76THRxZDzIxJJ6k+88IKPXNV3pcInP0wHLTRuX
         qVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=q8MQEfX6wqpZ5J9vwQcRY4RcxLlSmWSJn1qcu8l24Bg=;
        b=AYICTD8jwluE63QgJhgJyTVrnZCtNmMjOHAbF8PAy2rYr6sxzg2c8V8lpE4d/g7Piv
         IBcDV+bV0AwjdFSCbWLIAl4hNuW/ufN3rZsFRdFCYllakLyOZnbgzp/0beanqZB7KwSG
         R9hMPaoqVwP1Yy/4cOFAW/8ftQeJv5AalB4GimJMoPiTV1H/xhY+za03//4tfwVs2FS2
         Fb4TI+ExU2dVJ07Y5vG8/5xK10heuB3i3hWdwd69yDEOuTV2H8IKBhjXdG/L1FdzAdEG
         zlEFeiJF3V+xQ+RyjkqOLx6tE2jHgDXGZf2IJWWMRCH5JswBwLp+bV89+Ld+dn4pG2Tn
         3L4Q==
X-Gm-Message-State: AOAM531NnGq/E9u6hlFNwyqnzxT9gD7HcIlWe1Vl2t9is85WltJ7CvRq
        15d8npnmpPEWjOV0birbYXg=
X-Google-Smtp-Source: ABdhPJzCHN6yO8HRE7ChOpSjQQen3tYACPa4PrfU3Inq8hztarb7UdXUKDkD161V5qzjMxUc9AjC+Q==
X-Received: by 2002:a05:6830:2783:: with SMTP id x3mr4245768otu.37.1626472614387;
        Fri, 16 Jul 2021 14:56:54 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id c11sm2111920oot.25.2021.07.16.14.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 14:56:53 -0700 (PDT)
Date:   Fri, 16 Jul 2021 16:56:52 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>
Message-ID: <60f200a49dac3_14cb2089b@natae.notmuch>
In-Reply-To: <xmqqwnpqot4m.fsf@gitster.g>
References: <pull.1047.git.git.1626316849.gitgitgadget@gmail.com>
 <3c07ce978caa832b08c6bef1c48c061e41a6fd0b.1626316849.git.gitgitgadget@gmail.com>
 <xmqq7dhrtrc2.fsf@gitster.g>
 <CABPp-BExWMSFr7CQskjKVhr5fiWCnxoaN_RaJ2Yir+36aiyBjQ@mail.gmail.com>
 <xmqqpmvjs61c.fsf@gitster.g>
 <CABPp-BE8Qiu8Sdk8FD+UcAtZnToXFOv+Y+8Rwf3DyiZP6Te-SQ@mail.gmail.com>
 <xmqqh7gvs2mu.fsf@gitster.g>
 <CABPp-BEHNpfm6mJBDZ30wCEraT03p+2-gGZyZcnUV34trAzAzw@mail.gmail.com>
 <xmqqwnpqot4m.fsf@gitster.g>
Subject: Re: [PATCH 3/5] pull: handle conflicting rebase/merge options via
 last option wins
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
> 
> >     <unset>     *        --no-rebase            merge --ff
> >     only        *        --no-rebase            merge --ff[2]
> >     false       *        --no-rebase            merge --no-ff
> >     true        *        --no-rebase            merge --ff
> 
> I think the second one deserves an explanation.  The rationale for
> ignoring --ff-only is because the act of giving an explicit
> "--rebase" or "--no-rebase" from the command line, when the
> configured default is "I expect to have no development on my own
> here, and only want to follow along", is a sign enough that the user
> does not want to follow along in this particular invocation of
> "pull".  And the rationale for the entire thing to become --ff is
> only because between --ff and --no-ff, the former is the default.
> 
> About the second one, I would understand it if it became "merge
> --ff-only", too.  That is more trivially explained.  I however
> suspect that it would be less useful, but that is open to
> discussion.

It would be very hard to explain in the documentation why these are
different:

  git -c pull.ff=only pull --merge
  git pull --ff-only --merge

And this of course will break behavior for people that arely already
relying on pull.ff=only to do --ff-only (as it was its whole purpose).

Not to mention that this isn't even listed in the table:

  git -c pull.ff=only pull

As well as *all* the configurations with no command line arguments.

-- 
Felipe Contreras
