Return-Path: <SRS0=WTnS=CW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248ECC43461
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 22:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAF072220E
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 22:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgIMWb0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Sep 2020 18:31:26 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:46151 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgIMWbY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Sep 2020 18:31:24 -0400
Received: by mail-ej1-f67.google.com with SMTP id z23so20473222ejr.13
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 15:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yk+vW/zf6xQoAOkSqIFugALKw6Hcka/JshF5+9NYi1Q=;
        b=ckMFmeCVVOsbycGKs2YPc71ARVEUK5JDtLeV4wmcjAFHlIOPWoj68H1wZ1IEj95NPB
         zBOSD/Ir8Leg3UeIMI0Lqne9SicJOH1D+nz4rmzm1n3qRLzSsU7gkvEP5bA3f8qPRwHM
         0q+ecNmTjUibBzGOljAgEM294jci1t7vMihj5iYYT4Y0F94V4R4ZADe/jnZGDkDwl43D
         1PcgPhp8OtTat2KnHImlghJaKLfTkp0bxR62m1JLTQsEaPCiF7sigVTMiaBbFhaN98XV
         8pmqGLxwd6P+uPBFryJZoTbOMA7DwSFdsN2+aqoOiGNLVFjTUCTqEYGGjhcQEuefiRz3
         9Ing==
X-Gm-Message-State: AOAM533kCUOPO5auxbvtsmP2Idy0TVooC28kvv/qQ6/svvqFLXrESEW7
        0y1anRIPK3G/DqZ8oloZY/TWFdYf87pwlDeUD+8=
X-Google-Smtp-Source: ABdhPJynwBp7ynWrGcTWrWa+y/fJ6h2wNYLKQMs8WbxR0eQPAFaJ+6WX6FYebbeSrz02LQNdQwvThc0XUpzbmZ7ZJZM=
X-Received: by 2002:a17:906:850e:: with SMTP id i14mr11682375ejx.168.1600036282506;
 Sun, 13 Sep 2020 15:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200911185754.64173-3-alipman88@gmail.com> <20200913193140.66906-1-alipman88@gmail.com>
 <20200913193140.66906-4-alipman88@gmail.com> <CAPig+cTNp84Dm=0n-Bb9o=1nZNDFRE20XDWUPJT8yjdefv15rA@mail.gmail.com>
 <xmqqo8m9mjcb.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8m9mjcb.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 13 Sep 2020 18:31:11 -0400
Message-ID: <CAPig+cQewCckH2P5qW9DZqWOHU3ZsGyBUGStv6cKAwzBOh4Ptw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ref-filter: allow merged and no-merged filters
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Aaron Lipman <alipman88@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 13, 2020 at 5:56 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > Rather than adding a boolean 'reachable' parameter to the function
> > signature, you could instead directly pass in the `struct commit_list
> > *` upon which to operate, which would allow you to drop the ternary
> > operator here, and...
>
> There is this code in do_merge_filter(), though.
>
>                 if (is_merged == reachable)
>                         array->items[array->nr++] = array->items[i];
>                 else
>                         free_array_item(item);
>
> By losing the 'reachable' bit, you make this switch impossible.

True. I missed that.
