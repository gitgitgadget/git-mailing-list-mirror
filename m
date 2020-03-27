Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E05C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 20:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A95A20716
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 20:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgC0UY1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 16:24:27 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:46981 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgC0UY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 16:24:27 -0400
Received: by mail-wr1-f44.google.com with SMTP id j17so13001344wru.13
        for <git@vger.kernel.org>; Fri, 27 Mar 2020 13:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=15yukV3bIv8QDQWdkKPGIicLQLMyn8+bdhhvtriIefA=;
        b=TDAuWxWfqIrKdl8BlG8DpdShZViwBadNcosFegYfoPNZ0MvQwAaOrByfBrCZqaL8nQ
         0u97f+f+/iRTaSj7KlGEVw6eW2/srghuMI6qnYjkQToLUWOE5GNNI9QcVxRtWLod9Sis
         coOllaCwql2rorOHIKo/J4KdJDh7C3aPpzhRUldawHm3Ejxk3sqaYYLHtpJF5qHA4LFA
         53ZErKEOkB84F2doejd5VPoAEV5y0ZtpMJaudbXTQonydBo99OG+DAjzWb+9RwmJgP8O
         zVul0Twg6uoCZcoNdSNS80nqwp72j9bxTvY2tjL6D6eC4wwGXnZFs8OLcvlT6QI48nPY
         GxLA==
X-Gm-Message-State: ANhLgQ0Xjx2tyKwExHeHeVFt4aFwpPGVUa++WkAyNpkQi1l0y0co8wuB
        zZhUBqvhohWuGxmSRI8fGPYOhtS3V1wU4OTbDoo=
X-Google-Smtp-Source: ADFU+vshO02aqweG5g82OJxhjASG8WFJ5cRAcp/FbEpo/4tgxL9HUC5sDF7I4cuMylxbXviHDwHpZ2CfhpUYjStRaqo=
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr1230539wro.415.1585340664868;
 Fri, 27 Mar 2020 13:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
 <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com> <85457a7b61874e8e9f3af9c231451df0aba7a7b5.1585114881.git.gitgitgadget@gmail.com>
 <20200326083519.GD2200716@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2003261450590.46@tvgsbejvaqbjf.bet>
 <20200327091004.GA610157@coredump.intra.peff.net> <xmqqr1xdhev8.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqr1xdhev8.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 27 Mar 2020 16:24:13 -0400
Message-ID: <CAPig+cT6CQsYyMR=-nAo7GD8mXAWyUWPrbTnCZ0nBs54Ah0PbQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] tests: turn GPG, GPGSM and RFC1991 into lazy prereqs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 27, 2020 at 1:44 PM Junio C Hamano <gitster@pobox.com> wrote:
> Subject: [PATCH] t/README: suggest how to leave test early with failure
> +       test_expect_success 'git frotz on various versions' '
> +           for revision in one two three
> +           do
> +                   echo "frotz $revision" >expect &&
> +                   git frotz "$revision" >actual &&
> +                   test_cmp expect actual || return 1
> +           done &&
> +           test something else
> +       '
> +
> +    Note that this is only possible in our test suite, where we
> +    arrange to run your test <script> wrapped inside a helper
> +    function to ensure that return values matter; in your own script
> +    outside any function, this technique may not work.
> +
>  And here are the "don'ts:"
>
>   - Don't exit() within a <script> part.

We use 'exit 1' to terminate subshells[1] inside tests.

[1]: https://lore.kernel.org/git/20150325052952.GE31924@peff.net/
