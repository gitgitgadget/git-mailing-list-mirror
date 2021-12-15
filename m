Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280C2C433EF
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 00:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhLOAAw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 19:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhLOAAw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 19:00:52 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773BBC061574
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 16:00:51 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id t5so68457511edd.0
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 16:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gGwRyKWqJQRxgfTeh3EBChMvWUXCUr165UJ0mG26kDs=;
        b=i9RpzDUyvEeP+AnExJ2SW3VR4x4vrS7HdizDK+1dxkv3Nh3sM5/4Rm/5wYZSZNRAkm
         qlhvw4QoroCs1+pYcdwUKmsyKd6EC3Lzv4KvJ11DPxTFrgSxDc4/wOWrkyHeWK1xMY60
         vA6WpSa72/F6kR7FnH98BHb+SorGFMIn8KH7hRYRLGMcyCHDnYzh3ckioJGNC8QIXgou
         agBC+7zErNOuMwnJwEDQoIkR0GwBAvOfa5aqoCMlhDUeuNW5/E7xq/tkM6oMZT3JWlST
         fe4YEOyyWqWnsHnnAQDw5c7skbmJPKNNpOqOeVDr4uUp4vSKkV5J+h2xsq4spwHqY9JT
         iReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gGwRyKWqJQRxgfTeh3EBChMvWUXCUr165UJ0mG26kDs=;
        b=zAhef9x5KPec5Ji/U1259UP1rzZ87vwIBziu8hlj+uGczkK13xAUtHCN14PBZQogP2
         8UHVoXgshQQvG9WcQ3zZPhq3pF3elHRlPV6Oo9vlmDwRYd+Pg2rTPDySY0zDd6XgsBXl
         52iN+g6UhMyE26YEwAz0mWG90u9YAaF9fPyZtoYSTusnU7n51INcEuWcUqRou+BYEf8/
         6h3/SfPz1pdKBpFL/xGK5d4IWVjA091YKdxGPZJr3l/UJ+XaVCt3R+MpXW1fxRe+JK7E
         NCEpmoiKJs6oiWtF/Rv+X1edT2H7muJBQZMnHOeyCZThTW3WHXBPA447xE8bi8O7xYkm
         brog==
X-Gm-Message-State: AOAM5308ZuxeeNxdhRFwyMdfDS3SomVeg9CZ5dtnJP1YLuy6Odu4TxIl
        lIEzuqsNLHNEqPygfOH2Pxv4xrTX0/LzSmJLzNdWtaQhTAA=
X-Google-Smtp-Source: ABdhPJzOhWpBcwL/NiAurhqr8Q1x2s5Rb1mVoayzfwOWI9zYaHQGqcdVDM0S6g57IbGjq53CZoCtSUvgH14FD0CaiEk=
X-Received: by 2002:a05:6402:1014:: with SMTP id c20mr11812321edu.186.1639526449699;
 Tue, 14 Dec 2021 16:00:49 -0800 (PST)
MIME-Version: 1.0
References: <20211213063059.19424-1-sunshine@sunshineco.com>
In-Reply-To: <20211213063059.19424-1-sunshine@sunshineco.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 14 Dec 2021 16:00:37 -0800
Message-ID: <CABPp-BFNEPkEaY-MT1Ot7EzHkW=7FHGbJxU=pr226M43BvHwTw@mail.gmail.com>
Subject: Re: [PATCH 00/15] generalize chainlint self-tests
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Fabian Stelzer <fs@gigacodes.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 12, 2021 at 10:31 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> A while back, Peff successfully nerd-sniped[1] me into tackling a
> long-brewing idea I had about (possibly) improving `chainlint`
> performance by linting all tests in all scripts with a single command
> invocation instead of running `sed` 25300+ times (once for each test).
> A description of some of the important features of the new linter can be
> found at [2].
>
> Although the new chainlint implementation has been complete for several
> months, I'm still working out how to organize its patch series. In the
> meantime, _this_ patch series makes it possible for the new linter to
> re-use the existing chainlint self-tests. It does so by cleansing the
> self-test ".test" and ".expect" files of implementation details and
> limitations specific to chainlint.sed.

I read through the patches in this series, and didn't note any
problems.  However, my knowledge of sed is just the basics.  Even in a
few cases where regexes were all that were really involved, the
regexes were lengthy enough that my eyes just glazed over.  So, my
review is kind of superficial, but the preparatory patches certainly
seem good to me, and the commit messages are well explained, and the
non-sed changes are consistent with the described changes, and the
easier sed stuff looked good.  It's clear you put a lot of care into
carefully explaining and dividing up the patches in a nice and logical
manner.
