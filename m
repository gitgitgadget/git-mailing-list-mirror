Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7214DC433ED
	for <git@archiver.kernel.org>; Fri, 21 May 2021 10:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51720613BD
	for <git@archiver.kernel.org>; Fri, 21 May 2021 10:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhEUK1w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 06:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhEUK1k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 06:27:40 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EAAC06138F
        for <git@vger.kernel.org>; Fri, 21 May 2021 03:26:14 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so7110303wmk.1
        for <git@vger.kernel.org>; Fri, 21 May 2021 03:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=Mz++3/i8ztzXwhZx1kasrUmhonGnKdXapn/ueYLb7N8=;
        b=jcbuKhqhFBOXT4BD7WtC1B+u7fpd3bM32hWjl72dfKPG6sWZO49wF39yYPfisXo7RH
         O1zWeoyKsdEfs/W8k2rnmsBnteCewmJWBa9uKaI4cAKTpQ+dw+3b5jyIs3/1hzcRTt8i
         LqhHF5hhGTe49AFP/ONUheBvhHehc2TmL2a1ROGg5Q1ff2zpMw9AsSdDEAHixVXNeuth
         AhuZWwhaOLWZJhFwPsxRITHl98Jp/HcjunZ+OimTx2jRjiL+JFpDtKIt/bB0V5zQ1pk/
         deEzGMvWGArAyZoGd6qQbeM2doec+I2iMx1uoic41Ypb+0Ne21W8Wkceeu2di1T/sNv3
         VaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=Mz++3/i8ztzXwhZx1kasrUmhonGnKdXapn/ueYLb7N8=;
        b=Q3R/mgSQyzEWymGhWeBnkybjDmuxpMUwVDW87Clm+nrTD5uKEzoqyU77XmaPR1I7J8
         SRnUvo2jH1E8izy/5MI8nQAaiI5EBtMpwGtQJQ32PPS/WH85jeWrfuTolvYmCr5Uy2Tf
         qWJ447OPcQpMcGfV2a+yojWpL0+vpTiBhvJyU/FoNrS5sYYrngIq2/QWHh5lPldPEiAy
         sUfTeXVxtfPzZceyVLIRBK18NLzq7TZutlhyNlq9Eu8BHPbjzBqbe6D7cPhzNYUMxHdq
         EG0lI0FCivwMejd7V1VU6Apc1iN5Wyz8zLQMrAnhBRV1yV+FeVNI6Gm4wW+B1Z3jQcHx
         lJ/A==
X-Gm-Message-State: AOAM532OEe2M63wgZ4nR13YGtbDve0YoIptZCFx/WEKXMSG5ikdiiPz+
        kvWIbzxV2GTG+pC8W/j8YM2loLWIu6fgbw==
X-Google-Smtp-Source: ABdhPJxrHI0ZGGjhsTs+5FM3Gq5Qxd7eDmOwDX9nVoZz4dch/1hUy+ZWPtCNgN4qJdAuAfrCfOjd0w==
X-Received: by 2002:a1c:1dcf:: with SMTP id d198mr7849972wmd.40.1621592773138;
        Fri, 21 May 2021 03:26:13 -0700 (PDT)
Received: from arch ([2a01:5ec0:2001:6a76:224:1dff:feda:be78])
        by smtp.gmail.com with ESMTPSA id z17sm1834198wrt.81.2021.05.21.03.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 03:26:12 -0700 (PDT)
References: <87k0nt3f8i.fsf@gmail.com> <YKbJdiMNGaJAls4y@google.com>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Siavash <siavash.askari.nasr@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Siavash <siavash.askari.nasr@gmail.com>, git@vger.kernel.org
Subject: Re: [Bug] git-credential-netrc.perl is not built and is not
 available in `exec-path`
In-reply-to: <YKbJdiMNGaJAls4y@google.com>
Message-ID: <87zgwocri7.fsf@gmail.com>
Date:   Fri, 21 May 2021 14:56:09 +0430
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi,

On 2021-05-21 01:11:26 +0430, Jonathan Nieder <jrnieder@gmail.com> wrote:
> I'm missing some basic information:
> - what platform are you running on?

I'm using Arch Linux with Linux v5.12.5-arch1-1.

> - what commands did you use to install Git?

`sudo pacman -S git`

> - what are you trying to do?  That can help us with understanding the
>   problem or giving better advice tailored to the use case.  The netrc
>   credential helper is mostly meant as a demo, since libcurl supports
>   ~/.netrc on its own already.

I wanted to use `git-credential-netrc.perl` to use `.authinfo.gpg` as
git credential. The `gitcredentials` manual said use:
`git config --global credential-helper foo`
for using credential helpers. It also mentioned that `git credential-`
gets prepended to the external helpers. So I expected:
`git config --global credential-helper 'netrc'`
to work.

I can use it as a helper if I use an absolute path:
'/usr/share/git/credential/netrc/git-credential-netrc.perl'

After looking at the `PKGBUILD` file in Arch Linux's git repository, I
found out that they are not making "netrc".
https://github.com/archlinux/svntogit-packages/blob/4864e39da0bc99e373f3cb728272a93d66b58cd6/trunk/PKGBUILD#L63-L64

So this is not a bug. As Jeff King mentioned as well.
I should have checked the `PKGBUILD`.

The output of `git --exec-path` is `/usr/lib/git-core`. And there are
other helpers there(made by Arch Linux).
This is the output of `lsd /usr/lib/git-core/ | rg credential`:
git-credential
git-credential-cache
git-credential-cache--daemon
git-credential-gnome-keyring
git-credential-libsecret
git-credential-store

I expected the third-party helpers to be in the output of `git help -a`
as mentioned in the manual. They are not in the `PATH`, but they are in
git's `exec-path`.  So shouldn't they be printed in the help output?
