Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB8DC2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 15:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FEAC20857
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 15:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNKLTLew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgDJPbh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 11:31:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53031 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgDJPbh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 11:31:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id t203so2823621wmt.2
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 08:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/Px0q9LEmvp+k/R3pPe40n9JjlOfPvYIgXT2AYxkq9c=;
        b=CNKLTLewD5ccVj2JP/so3WAni76LcavasDrN8r/qrPwRXgWYJC1OvZ3CuBYuXDsQ09
         f/ilMbqNB2tMH5/S1yniLp3xWDx+ycihO565tOAE9w3OwX/ymdjWqbHzNDeLfMQY+W3Z
         4Cws04B11S2QIKWR0ecpjHdzbJHS9VjUZKMbmK73Tj6Iroyo+h+pMwaPgYPOzTSBtdQx
         XTImzF18B07V4lEH3i/ief4+xw4Eo4CnK+Fga6DPYH7Rqi4tuhf3z+nMJe/gcJ3EYo8B
         gpHwGznX0XIoI3BDXSz4/PSfAY9HjGWcTG3i/eO1uZ7FglPq2OjPS9QqrcNQ9xL7pbzK
         jqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/Px0q9LEmvp+k/R3pPe40n9JjlOfPvYIgXT2AYxkq9c=;
        b=t5aOOTpnnY7qfZJFApzE8aAG1KH8m5szkLSH/YHx0nFBjfhKGUjrWnavterQN/448y
         enJedHwkNET3GW5Qm6vRTvej8CRbe4kl08jddVSPe/YpF2Ng/LbkZ+LukZ6kevGplwPV
         IP6KU+bBnRsbuMv/NwPwsijAi0yqfCJ6O8IrTDV0cTkoNHZd82jYKJXpxtKzVC+Agmxs
         3FpAaaa6sMsCepFKV7yXBJoQVU40MvRHf5wH8q8s44hK+Isl4SQuWehAkSXtDOLGCyxS
         9dA/f+4nwFeNKSmVtFC5IFORjt5895YJms4WqvmP4p3r9K57Fsuy3PPuf8eXCtkUDar/
         wC2g==
X-Gm-Message-State: AGi0Puas9YGwGhzm4ZigA+mLOurKFs16vv6IpK79ChWWkXP2YG6u+7Qk
        Xu3k3gPP80aLtG5mT1cNaBr4xe68
X-Google-Smtp-Source: APiQypIj8J4rTgkpvW+vbqIURSGqcCjBfUZqajblDKYDBJut47XQALF0MZWjvDF0HR9wCqJLnbmnlg==
X-Received: by 2002:a7b:c5c6:: with SMTP id n6mr5531799wmk.74.1586532695542;
        Fri, 10 Apr 2020 08:31:35 -0700 (PDT)
Received: from szeder.dev (78-131-17-184.pool.digikabel.hu. [78.131.17.184])
        by smtp.gmail.com with ESMTPSA id i8sm3525200wrb.41.2020.04.10.08.31.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2020 08:31:34 -0700 (PDT)
Date:   Fri, 10 Apr 2020 17:31:31 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/5] ci/lib: allow running in GitHub Actions
Message-ID: <20200410153131.GM2224@szeder.dev>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
 <d9227c87a7bb2872f6a69f48f6a4988f08545d8a.1585658913.git.gitgitgadget@gmail.com>
 <20200403084654.GK2224@szeder.dev>
 <nycvar.QRO.7.76.6.2004042207410.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2004042207410.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 04, 2020 at 10:08:56PM +0200, Johannes Schindelin wrote:

> > > +	test macos != "$CI_OS_NAME" || CI_OS_NAME=osx
> >
> > Hmm, if "macos" isn't not equal to $CI_OS_NAME, then set
> > CI_OS_NAME=osx.  This is head-scratchingly backwards, and I think
> >
> >   test "$CI_OS_NAME" = macos && CI_OS_NAME=osx
> >
> > would read better.
> 
> I can understand where you come from, but your code is not `set -e` safe,

It works as expected in at least in dash, Bash, BusyBox sh, ksh,
ksh93, mksh/lksh, yash, posh, FreeBSD /bin/sh, NetBSD /bin/sh.  But it
doesn't really matter.

This is not in the part of Git that should run on a wide variety of
platforms, but only in our CI systems, where we do know which system
and which shell we use, and we can rely on that it just works.

> which is the reason why I wrote the code this way (compare to the already
> existing code in the previous clause, which was copy-edited here).

Didn't like it there, either.

