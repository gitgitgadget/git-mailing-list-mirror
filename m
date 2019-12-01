Return-Path: <SRS0=LEOb=ZX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B3CC432C0
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 20:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CDF20833
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 20:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=deltaq.org header.i=@deltaq.org header.b="LjIlZR1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfLAUKU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Dec 2019 15:10:20 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42854 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfLAUKU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Dec 2019 15:10:20 -0500
Received: by mail-lf1-f68.google.com with SMTP id y19so26263047lfl.9
        for <git@vger.kernel.org>; Sun, 01 Dec 2019 12:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deltaq.org; s=deltaq;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3oBApDGQJm4ngkQM/HM8fkAB2ftPQbCTwaw4w0neRT0=;
        b=LjIlZR1/dX5eZbAwWQWsyD7JqjqwJFuq/6ca924cQzSDhPA5Wj1o4ymt1684EWUK+1
         8tM5JQzCU/0zt8nOzJ52usDD+qevRAbIPoIuVwtLKZXVHhrAAiomPzGgeiaKVmBidDNm
         M867Ilf8bS7UCeNwigMLIpkp9+Yt+KYd6lMfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3oBApDGQJm4ngkQM/HM8fkAB2ftPQbCTwaw4w0neRT0=;
        b=Eca3UHNlp7Zk0Voi0CR/NoE/u5Bd6mKs5Q5vkhSNNRyL808OkZsQw5L5bZW3SDw2zK
         Kn58fKVx3/cg2H7as6GdrRkB71WyjW3NxeCgLR0kr646jER0cxp4ZEsF6Q/rfnjMiIX/
         e3qE1G5/DfzHON0yjKuXBg5hAm4IB9thbtgahVwiUjp+dDNuQsd+ivovcJG5W44iCZe9
         GgTXT93A/xF2r/Lt/Kol1PkYPJvzJ4AGXZKPJs3se+fzgv96KjgNR+hGKFzKzGZ6K9I5
         mw+n5unTh4DKhTMDPG/bzD7Tr2qkFxkgNaVhztQqjJBF8Vllk4NwBG5M5WipMhApcuKV
         xSHA==
X-Gm-Message-State: APjAAAUNqvwDLHL+1TkZr8IPxpNThyTb1Me6Atq9VnwFgF5Yax/ckCbH
        m/dJGMuaAkyNVWbf//iF1N5ikW4z9nQIoo2/PxyIug==
X-Google-Smtp-Source: APXvYqxViGcI/lT1mFONTRMba2l6PfHo0YNddZuaJKiJMGisCugShfW3bYUwB1L2SOZFXfhUoIQmAA4yDbCTme2bAh4=
X-Received: by 2002:a19:cc08:: with SMTP id c8mr40412552lfg.124.1575231012846;
 Sun, 01 Dec 2019 12:10:12 -0800 (PST)
MIME-Version: 1.0
References: <pull.436.v5.git.1574627876.gitgitgadget@gmail.com>
 <pull.436.v6.git.1574929833.gitgitgadget@gmail.com> <ab3d8e54c3d3d5174fe222ee77101ab3b8e9cab8.1574929833.git.gitgitgadget@gmail.com>
 <20191130230543.p5xtapnx5a56arng@yadavpratyush.com> <90eb7e96-6352-deb9-0c22-14993ce42c8e@iee.email>
In-Reply-To: <90eb7e96-6352-deb9-0c22-14993ce42c8e@iee.email>
From:   Jonathan Gilbert <logic@deltaq.org>
Date:   Sun, 1 Dec 2019 14:09:54 -0600
Message-ID: <CAPSOpYuLWzqYBvP_4y__UTV_Krv0A2FqKKQir-xadWNbN5zq-Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] git-gui: update status bar to track operations
To:     "Philip Oakley philipoakley-at-iee.email |GitHub Public/Example Allow|" 
        <ogvdf9gsg7oxult@sneakemail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Jonathan Gilbert <JonathanG@iqmetrix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 1, 2019 at 5:43 AM Philip Oakley philipoakley-at-iee.email
|GitHub Public/Example Allow| <ogvdf9gsg7oxult@sneakemail.com> wrote:
> On 30/11/2019 23:05, Pratyush Yadav wrote:
>  > On 28/11/19 08:30AM, Jonathan Gilbert via GitGitGadget wrote:
> >> +# Operation displayed by status mega-widget during _do_clone_checkout =>
> >> +# _readtree_wait => _postcheckout_wait => _do_clone_submodules =>
> >> +# _do_validate_submodule_cloning. The status mega-widget is a difference
>
> should this be "different", rather than 'difference'?

It absolutely should and I have corrected that in the re-roll.

Thanks :-)

Jonathan
