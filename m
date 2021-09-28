Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631C6C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 17:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41D036127C
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 17:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241960AbhI1RSv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 13:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbhI1RSu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 13:18:50 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8803C06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 10:17:10 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x27so10813471lfa.9
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 10:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P0MhaJPH1M6oDQXvhriNDKlUl+RWpZZETzjKIdPL8c8=;
        b=GYt35TW5CbQj/IlKAD5FMNi1GDL8hJxd/mQzLipqKmIqNtbg++dNArBkEJHuHRglGC
         FrJ0Y2hqTGKmVT0Mc1QseE69KgBKFZF0v+g0vTSELmnCcMhWJZWqDYFutL0/bgtc5MUS
         WDTeYsU7W3ygRM5oEAnEd3EJzqmm79aLtCkB/ukVvLvlHUx5aU9a+vc2gBmu2xfDkkOP
         zV7NlK+sHP1L4JFzvor2qPziTXQtQbCDcbpnOt5BkNR08Of0s0kKQX3iDIXSZxO3/xQP
         zGRgUHsiZfzY3j6CuYyENM3D4OmHc6eoinSi/EGlnz7GfjTX22KeuYFjmrnCJRdEGDOv
         PCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P0MhaJPH1M6oDQXvhriNDKlUl+RWpZZETzjKIdPL8c8=;
        b=QAUE3kvgbPLQ3qaka9N0mCRliHZQOc+cRp76MJNpJfF1Ysh1ep9/AoaTeTVWn44v7f
         8D/0LRgqvss52iexTbPNLvv5xE5P5/f1eB7HN9IJcejtm31oDQqXgREjxa/NERNz65k3
         RQvhHHVGZ7BxJuzvkMJZNtsqJemveP6Z+HYvys8LI8NMTcu0DoUhJtfD6dOn2P9vLrFY
         ZVZFkGM7AZfZMgcqfqGfF9PaChQO5terLT6QGTpLtJ3A6zerzrGjOmwDt+40UjbKJadn
         1+MniQnxCxdgZ6dfyOxO4boiZ7j1gV49Fz6vnuSPPG8M30zULcmaOu3xOHng1drpTNrE
         GVvw==
X-Gm-Message-State: AOAM533FC3De0cDDKcbHE2D9/mshHzN94AldYeeXNdUD69Y9HtnFNypA
        GZdn34sAuA389wmVsOX8hvwfGooGddAH+SAuADdzk1bfDSjMCQ==
X-Google-Smtp-Source: ABdhPJw9QRKBmI4cocBCGm4d9WfQzCgGDh2nffPbSF6XbM2Y8Kqn/DMiNH2IhOYCCKWcPBVyXHZd+W87v/4LAM7mlAQ=
X-Received: by 2002:a2e:b892:: with SMTP id r18mr1149776ljp.220.1632849428864;
 Tue, 28 Sep 2021 10:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <8c266e58dede247b2c97ad2870c7c24c3b35ed55.1632848754.git.matheus.bernardino@usp.br>
In-Reply-To: <8c266e58dede247b2c97ad2870c7c24c3b35ed55.1632848754.git.matheus.bernardino@usp.br>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Date:   Tue, 28 Sep 2021 14:16:57 -0300
Message-ID: <CAHd-oW4aQtY8gBG_UhcgU6kfbkBX1TkjHBTLnNJsCGJdMrBfhQ@mail.gmail.com>
Subject: Re: [PATCH] grep: demonstrate bug with textconv attributes and submodules
To:     git <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 2:08 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> Subject: [PATCH] grep: demonstrate bug with textconv attributes and submodules

I probably should have referenced (or linked to) the thread this came
from: https://lore.kernel.org/git/87zgryylfx.fsf@evledraar.gmail.com/
