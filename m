Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D39C433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 14:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CBCD20756
	for <git@archiver.kernel.org>; Wed, 20 May 2020 14:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LW+88hlf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgETOEH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 10:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgETOEH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 10:04:07 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4408BC061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 07:04:07 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id c75so1486159pga.3
        for <git@vger.kernel.org>; Wed, 20 May 2020 07:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JBoxiavVSDpwpozKDKT6Pdhv1x/Ndr1bjCn2yQYXz9g=;
        b=LW+88hlf/DSA1RwRE8eV61d04PfO8sRmDmvd0SFhqBxHTvUZPHRPrTq3A53fJ3fXds
         de/TwWnNgt7d3iOyIzhky+ncZeARepx+uL6u61mTw55PPPlu2Ouw0BB9gsKuScuz/Esn
         8bdC9xy3+7DfmFKHhIg77lB2UDKgw/++YmKdDu6H/NUMjnsAH67+h3mCIaGgf9011/tq
         X//hUAvPDPDPZQRKE2UnpGb2elGNjm0YcAHfq18nGQHNiyx9h/ZxlrTw7lhsnorKbOQm
         ieQADSadurEidmuYbeCQv6Jp5SHtKWxm5KJr6YX1l9gdgQoPXOd6RFFb2ZOUod5LFfNc
         5w7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JBoxiavVSDpwpozKDKT6Pdhv1x/Ndr1bjCn2yQYXz9g=;
        b=FjEIQi+/HlPZ8CEJCbSHCdl23hKg19VAJobjkv5TMQhkgVKLNDW0o1Mr/ydEzKAHb8
         1vR82WPWsTwyTkBQYTGGGGvSEr1NyVG9EKyT6M2Zzoent17jZ6juTNlg5UgxTdE5DDta
         Kb31vFUPYsLspLNN43B1J86clyB3/jKYOWjCEHMdW+Cy92jX9lVyvT85oW23ynzNwYaL
         nGamWM82B/CsxT/v+92BSZB8NCCKa9o0iv4R6/LEyjX0q7dnSFTfuZKX6nYbttwVLvOy
         AZeeKla5IcY5XZsxOG6IrFLmevayVpDwKHjOKaBOr9TJTQyPanpa98YQ3LU84K4maH+e
         3gzA==
X-Gm-Message-State: AOAM533lfuA/n+VGw7hik4idazEYa+796ZBb2k79pwnLAHgUnRloSNMO
        zK0CuGNaFLAKUKzeyVE8NpY=
X-Google-Smtp-Source: ABdhPJzj7QyF47fp+g7LOo9/ctAa16e0kVr6sL/DYE+Pz/dHcgco5xhg9vJK1jUqVt6eT0HdmkWrdQ==
X-Received: by 2002:a62:6d03:: with SMTP id i3mr4342639pfc.249.1589983446645;
        Wed, 20 May 2020 07:04:06 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id m63sm2360020pfb.101.2020.05.20.07.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 07:04:06 -0700 (PDT)
Date:   Wed, 20 May 2020 21:04:04 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>,
        git-for-windows <git-for-windows@googlegroups.com>,
        git-packagers@googlegroups.com
Subject: Re: pseudo terminal support, was Re: [git-for-windows] Re:
 [ANNOUNCE] Git for Windows 2.27.0-rc0
Message-ID: <20200520140404.GA2893@danh.dev>
References: <20200515173242.6154-1-johannes.schindelin@gmx.de>
 <CAGyf7-HbnCip8WZ9vtc_KW1kXMBUoPZQ8GD7H=1DOAk45Wbjxw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2005161044580.55@tvgsbejvaqbjf.bet>
 <CAGyf7-Fkn2uHLCqM-4qfM0YQAXoMgiMwKEaxkGkOtz=pYYKQWg@mail.gmail.com>
 <nycvar.QRO.7.76.6.2005180503440.55@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2005191311540.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.2005191311540.56@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-19 13:16:40+0200, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > > To be honest, this time round I would _really_ like to ask for some manual
> > > > testing. I upgraded the MSYS2 runtime from being based on Cygwin v3.0.7 to
> > > > v3.1.4, and the biggest new feature is support for those new-fangled
> > > > pseudo terminals that Windows 10 now supports. I did find a couple of
> > > > rough edges in my use cases, but I am not exactly a typical Git for
> > > > Windows user...

Hi Dscho,

I've installed Git for Windows 2.27.0 rc0 in my $work_machine today,
I've run into this error during installation:

	Cannot create file "<my %localappdata%>\Programs\Git\dev\fd".
	Access is denied.

I have GfW 2.19.0 installed (by IT policy) in "%programfiles%\Git", and
GfW 2.26.2 installed in %localappdata%\Programs\Git. I don't have the
right to install software in my $work_machine

I can still use git-bash (by double-click git-bash.exe) after
installation, though.

If you want more information, please tell me,
I'll try to get it, tomorrow.

> > > > Could I ask for some manual testing in particular of anything run inside
> > > > the Git Bash?
> > >
> > >
> > > I’m happy to set it up and use it as my daily driver on one of my
> > > workstations, but I don’t want to overpromise how much help I can really
> > > offer for that sort of testing. I don’t do much of my full-time development
> > > on Windows anymore for a variety of reasons, so even if I install it in my
> > > Windows machines I won’t get that much active use in. And when I do use
> > > Windows, I keep my workflow pretty simple, so aside from basic adds and
> > > commits with an occasional checkout or very rare rebase, I just don’t cover
> > > that much functionality.
> 
> Turns out that I ran into even more issues when trying to do a visual
> selection in `vim`: it would frequently "lose" the selection when I moved
> via the cursor keys.

My Windows machine is only used to run Ubuntu in a Virtual Box.
My limited exposure to GfW doesn't have any trouble.
My normal vim usage in GfW's git-bash works pretty well.
FWIW, I don't use arrow keys with vim.

> So I've come to the conclusion that the pseudo console support code is
> still too buggy to unleash onto Git for Windows' users, except as an
> experimental option. I will patch it to make the pseudo console feature
> opt-in instead of opt-out, and then also offer to configure it in Git for
> Windows' installer via an experimental option.
> 
> Has anybody else run into issues with console programs (such as `vim`,
> interactive Bash, etc)? Or is there anybody with a very different
> experience than mine, i.e. _not_ having run into any issues despite using
> (interactively) Git Bash extensively?

Is there anything that you would like to have a cross-check,
I can check during my free time, I can't promise much since I mostly
work inside my Ubuntu virtual machine.

-- 
Danh
