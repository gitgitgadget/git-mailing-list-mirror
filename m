Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768C8C5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 08:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236907AbjAII4K (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 03:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbjAIIz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 03:55:29 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA5D15FF9
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 00:47:40 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id fz16-20020a17090b025000b002269d6c2d83so10860805pjb.0
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 00:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qAgeydHLtMDsBxpXnWtG9KaZW8lSAYVbtnnJjNxOrY=;
        b=GbLlzC3XvOCGhbUIur1r3Xv3w//ltrsqFD1MnGuosbQIg4lCMeKH3ztydgWUpEQ+EW
         ZryDw5lqkzNT4T20UN2E3Lfb4iYx0/0+vNtlYJIkVWXq7I75pRbhWkmSSxF51I2LscZv
         ieK0YOdq6BrYvwvLgL9CyH67UTtPbP5edLWvfJ4b25Hi1pFeEJQDZt6LgRovI9bpn/cf
         Kjnn697aZ8x9UyYbloK9Co92rAEj5m0SE4k9+OSZjNbpcDRqUgBZ6aLudk1bxdIu5q6S
         uL37V3ZX1T4IeHI5YZnDIEFHz4XzbDG+4RYiLL+Fd7234gwyutnAI88h5f4A0bljb4Pr
         9a3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qAgeydHLtMDsBxpXnWtG9KaZW8lSAYVbtnnJjNxOrY=;
        b=fD/y9B7A0ZT+nVC7gzCDHdu9GOBdLjhkAnHhgBgriIJJKa6i96TbCxirVApGk38mkI
         itznGK0Nf4Eo9S2VHbjJGWUOxWhhMb+APpWvwyxxqWe4+d47w6ZhW5UqzpLAA42WcX4H
         fw+nlLcA1h3dLv77WGtsDhxkDqJ7l+wjBAvxf6nGtYVMgwPnHdyNWMP2UHSyu4TQffZn
         Fo1nyPPudq2yVAytRoV/wmJcn/zg1WsyAvN2bBAILeA+RX/7FOu37PxugdFjkiU2Dn0+
         oBknVfCnKypdc4XEI47Scr2e1ey7rRBjplpx6qvQTLwu2NHhCGYGWkgx2Gd0MdzPw+Lt
         zeAg==
X-Gm-Message-State: AFqh2kr0xR49GzdpZemB4BMgVouXJVao/HvxrHRNHw/p8j5dZZTbzoUR
        7FAtUIc/Mh5rf54K4Br0dOZVVouZZmDAHg==
X-Google-Smtp-Source: AMrXdXtj2kXWVpTCU1bsZKNMjDdhcdQ4rP95FFl0g4GILueAVw4LYaePFydHNmwh6SsKcXMucW860A==
X-Received: by 2002:a17:903:2341:b0:192:5e53:15f3 with SMTP id c1-20020a170903234100b001925e5315f3mr86430977plh.48.1673254059851;
        Mon, 09 Jan 2023 00:47:39 -0800 (PST)
Received: from ohno ([2001:f70:860:4100:d109:ad21:5267:d40d])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902ef4400b0016d72804664sm5482497plx.205.2023.01.09.00.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 00:47:39 -0800 (PST)
From:   Yutaro Ohno <yutaro.ono.418@gmail.com>
To:     sunshine@sunshineco.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com, gitster@pobox.com,
        yutaro.ono.418@gmail.com
Subject: Re: [PATCH] doc: use "git switch -c" rather than "git checkout -b" consistently
Date:   Mon,  9 Jan 2023 17:47:43 +0900
Message-Id: <20230109084743.328294-1-yutaro.ono.418@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <CAPig+cTO1jBjcwjX4UpxG813OwrDAaYVvViC_XGWorwbXvOfvw@mail.gmail.com>
References: <CAPig+cTO1jBjcwjX4UpxG813OwrDAaYVvViC_XGWorwbXvOfvw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Jan 9, 2023 at 1:30 AM Junio C Hamano <gitster@pobox.com> wrote:
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> > > touches is given merely as examples one might use, then I could see
> > > git-switch being prepended to the list rather than entirely replacing
> > > git-checkout. For instance:
> > >
> > >     $ git switch -c foo     <1>
> > >     $ git checkout -b foo   <1>
> > >     $ git branch foo        <2>
> > >     $ git tag foo           <3>
> >
> > That can invite "do we need to use checkout after doing switch?"
> > confusion.  I would understand if it were
> >
> >         $ git checkout -b foo # or "git switch -c foo" <1>
> >
> > or something that makes it clear either one, but not both, is used
> > there.

This looks good. I'll send a v2 patch. Thank you!
