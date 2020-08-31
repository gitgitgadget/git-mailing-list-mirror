Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDACC433E6
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 06:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48DB820578
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 06:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOY1oEw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgHaGzs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 02:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgHaGzq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 02:55:46 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C40FC061573
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 23:55:45 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id c8so753254edv.5
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 23:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JTOOLgK0WqaXF5zh0iB8OYocH7jwUyhjYAV2VyQjxcs=;
        b=fOY1oEw9H8caG7a61x5xcUTnp7F/68ns+SGYMh0U+gT40j4P1AJfjcRBgpxeC09m+p
         S82axw5wPuBTvdOSkfyoqckG/WDM3EqJW2T8t5KCiXBGR5POu7uK0oLqSmasufjkGToN
         YS97V9VWZ0gtY3wOorOJRmhywaL6Uf+DItbMeVp9CZJ6QbSUAE9Qz/7IGy2ySmq2/wje
         UAqyIdC7IcDvuld/I5Vr2Hj81F1H+9WQF9cy5gXMSpPTulGuI9OFrmpJgn8sPzKrRInp
         ncZTeiyWyqSNjtmf2taNeho8BIPzgSwTQLy3lxNP4/NdjCaCgjRYK2LUB7DLtVK+Bpng
         RMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JTOOLgK0WqaXF5zh0iB8OYocH7jwUyhjYAV2VyQjxcs=;
        b=j7UjUIc7xu93qKvHeFIKY29B1BkclRD58TZ+BYFMZJcNowm5ZXotK2C+mmrTdSe41R
         eTSj1Qff5xeycfQBUhGZ/IctELAhT0Lzs7MrHtEh6R1BNp1ohDRHCFskYr6qTaw01KoC
         jHnv3W0bTchGYeIab4gRdU2hbnllsf6DQjGDCI/rtIbF3A+raEDdzHaP38G7xAtLb1Zl
         4UTmINpZJS+7m4crfzOl0e5nkFo6Xb27ktD690thfjGJ0mIAYmMgjKGfcJcen//SXWhU
         Bfb1QoKUMcMjG4O/I9r5+w5u8zcslRcD8DbXiO5frf9Nwa2b9VSGLMmCHZXS7LFOGeC0
         DwtQ==
X-Gm-Message-State: AOAM530xwn0S27vUi9iQ+EHDfjBBZAs4/M8dJZcUxBbOnJNnheR8EIQ6
        ysQBUSdW44oGrVs/mgrSFzCPFP5YHomuVie4hO52f+UGL9bSvw==
X-Google-Smtp-Source: ABdhPJz7fubcOMjQmus580EkzvW/KXuBFr9riH98LYSdqms6EEbnQaFdZURHNvRHM5x4KsXpmxXHbKTv7QpFcoT8858=
X-Received: by 2002:aa7:dcc6:: with SMTP id w6mr10162027edu.273.1598856943969;
 Sun, 30 Aug 2020 23:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200828065609.GA2105118@coredump.intra.peff.net>
In-Reply-To: <20200828065609.GA2105118@coredump.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 31 Aug 2020 08:55:33 +0200
Message-ID: <CAP8UFD2rpNhDhyHdQNxS-KJZgcumsCpK_JQ5koCqXJd70s-+_w@mail.gmail.com>
Subject: Re: Git in Outreachy?
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 28, 2020 at 8:56 AM Jeff King <peff@peff.net> wrote:
>
> Are we interested in participating in the December 2020 round of
> Outreachy? The community application period is now open.

I am interested in participating.

> I can look into lining up funding, but we'd also need:
>
>   - volunteers to act as mentors

I am interested in mentoring, but would prefer to co-mentor.

>   - updates to our applicant materials (proposed projects, but also
>     microproject / patch suggestions)

It looks like many micro-project ideas from GSoC 2020 are still valid,
and I have a few new ones, so I am ok to create a micro-project page.

I would appreciate help to find project ideas though. Are there still
scripts that are worth converting to C (excluding git-bisect.sh and
git-submodule.sh that are still worked on)? Are there worthy
refactorings or improvements that we could propose as projects?
