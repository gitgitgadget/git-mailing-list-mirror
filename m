Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5946C433E5
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 23:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D155206D8
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 23:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgGZXae (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 19:30:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44899 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgGZXae (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jul 2020 19:30:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id b6so13054519wrs.11
        for <git@vger.kernel.org>; Sun, 26 Jul 2020 16:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XgBAzgYc7L7BBiYE7hnXr1YURs5wtxLz5pBnVC9iIJg=;
        b=pRYCdNSJBCSl9fJiaIkWQ3o1Zf6q8KYYd71THk7iJScYoi8cgVAlpGzbZG93q5z6aR
         ry+YUUp9H2Z1efL2BooXaAxmRekS7lwlUR7Bg0sBHEZLktU0x0YDFoJIvsDvaNZGwxpc
         qgbB2RS4x9IapX8k3/4ZC5NRMtdI9H12nqXJo/s56gKYA+scqgN05Pa6UoGFnjasoSyU
         xjH0vThqm8a+OzY/KHCfgx63dEX36frUK53GDKd1IevEJ2hApBr5w1Uhta9yXGJPQg/2
         XsbuMdvCoR+l3DCTfHgEwbbBcQ7p4LiqvxKpksRPtexG9b+FOAYTDof2hE8a9/4jdblf
         nsWA==
X-Gm-Message-State: AOAM5332BygOskLWZya1EYyjQTpGZIPWSADTrmjmn5wsIBOWekpxsFB2
        +xW/IZ7aeMXgLIme328TTUxOANUJzvT8T4XIDtk=
X-Google-Smtp-Source: ABdhPJwBqCfW+CLCyCt2uoL+NEEp862q4kxzp+7qVpLxCFRphicOL8XURbrADVICXAy8FJ2nlw3YZzdFR7fGIZ22ES4=
X-Received: by 2002:adf:fc45:: with SMTP id e5mr18998472wrs.226.1595806233071;
 Sun, 26 Jul 2020 16:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200726195424.626969-1-sandals@crustytoothpaste.net>
 <20200726195424.626969-30-sandals@crustytoothpaste.net> <CAPig+cR4G5czLgAo=H-+HXOye+qCLmtUcE9-DKoh=+yptMitPw@mail.gmail.com>
In-Reply-To: <CAPig+cR4G5czLgAo=H-+HXOye+qCLmtUcE9-DKoh=+yptMitPw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 26 Jul 2020 19:30:22 -0400
Message-ID: <CAPig+cTSxGC8ipo_NAByuiSzsV2kJAa_R1W34g2PP0+ZacH6Dw@mail.gmail.com>
Subject: Re: [PATCH v4 29/39] http-fetch: set up git directory before parsing
 pack hashes
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 26, 2020 at 7:28 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> This change has the unfortunate side-effect that "git http-fetch -h"
> will no longer work if setup_git_directory() fails, which could easily
> be the case if the user is trying to get help for the command from
> some arbitrary location in the filesystem.
>
> It might be better to setup_git_directory() on-demand when it's needed
> by --packfile= rather than doing it unconditionally before the
> argument-parsing loop.

Better yet, use setup_git_directory_gently() before entering the
argument-parsing loop.
