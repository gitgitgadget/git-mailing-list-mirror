Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEEDA1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 18:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbeGPTTR (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 15:19:17 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:41168 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbeGPTTR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 15:19:17 -0400
Received: by mail-yb0-f195.google.com with SMTP id s8-v6so15821610ybe.8
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 11:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=esNJuhL3VmwKp69ann3tu5gRfT0LL4xlLeOzPvDAJh4=;
        b=PW9UpG1bysOD6zk9WhLuEvNTeUI8Qn77MpxPV63LPhcHUj0Q0Ix0SbKMSYMeNPV2Id
         u5HUgKlIOaXia2LH0WIUzVhAk2V77kcQ2grN7+S+mG95FneCtP2n5bttj+wycrpmbJFp
         FgCiq30lR2xAlyWaPLThMSUvC+JyTdpO0H1XiGrsx9cP+Z+QmpLxsfjiJ+e2uwxnrdvW
         cObmhRlxuvHEvE7qrP1fCa9ueHAgGPQNVspdJcC26qXNSH/52lPxdUPuZH9e0ily8dYi
         XUo88MV7PrZMN40EsqY3MumEQHhJ0XGuhV/RUOTZ9GwaqZNWbdGojwq0IT+QY3bhY/j1
         AVfg==
X-Gm-Message-State: AOUpUlH4zGFAsnF0hO+oWCLo4N4n97qMR5+5brXYKhr275stVmFOBptX
        Rxcg1i49gOBEwpEUOiD0pCNS9wWmQgrAYPbFcZ+ljQ==
X-Google-Smtp-Source: AAOMgpfnr1K+bBa0wqYsYpgnTc4tQEn49RcK37WjfIiPYvxYfipAdiUqCXlYEFTd5Pp+Us6Jelt9MVzIZXzxpY8IZGs=
X-Received: by 2002:a25:9b03:: with SMTP id y3-v6mr9184962ybn.194.1531767034893;
 Mon, 16 Jul 2018 11:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180702002405.3042-1-sunshine@sunshineco.com>
 <20180702002405.3042-12-sunshine@sunshineco.com> <nycvar.QRO.7.76.6.1807161641140.71@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1807161749410.71@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1807161749410.71@tvgsbejvaqbjf.bet>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 16 Jul 2018 14:50:23 -0400
Message-ID: <CAPig+cRFeNt9FVDGnbGcp8Bvfh0ohay+p+tLhfx=EFvJg=Q1Sg@mail.gmail.com>
Subject: Re: [PATCH 11/25] t7400: fix broken "submodule add/reconfigure
 --force" test
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 11:51 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Mon, 16 Jul 2018, Johannes Schindelin wrote:
> > > -           git submodule add --force bogus-url submod &&
> > > +           git submodule add --force /bogus-url submod &&
> >
> > This breaks on Windows because of the absolute Unix-y path having to be
> > translated to a Windows path:
> >
> >       https://git-for-windows.visualstudio.com/git/git%20Team/_build/results?buildId=12365&view=logs
> >
> > I could imagine that using "$(pwd)/bogus-url" (which will generate a
> > Windows-y absolute path on Windows) would work, though.
>
> Yes, this works indeed, see the patch below. Could you please squash it in
> if you send another iteration of your patch series? Junio, could you
> please add this as a SQUASH??? commit so that `pu` is fixed on Windows?

Thanks for reporting and diagnosing. I wondered briefly if we could
get by with simply "./bogus-url" instead of having to use $(pwd),
however, "./bogus-url" gets normalized internally into an absolute
path, so $(pwd) is needed anyhow to make the test '"$bogus_url" =
"$(git config ...)"' check work.

So, this SQUASH looks like the correct way forward. Hopefully, Junio
can just squash it so I don't have to flood the list again with this
long series.
