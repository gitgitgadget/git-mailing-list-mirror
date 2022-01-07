Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EAAC433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 13:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347418AbiAGNE5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 08:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347407AbiAGNE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 08:04:56 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54566C061245
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 05:04:56 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 127so337279ybb.4
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 05:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gKVwEBPhnfdhWAcbSjQ5zOq/wuPPTboQoJEN2GlwStk=;
        b=CWn2zrLCF9F9X0Nj2UrwMFtcxoUYpvFduyQOgeEP7uio2SoeMtucxR5abynmzftxw/
         RvyZF0QJJhFqus8QEgmKbvLemuuoYiY8Yfo+89QOsfxa162jEB/SRwA8MCeHgG1FA622
         L1NpTf/IjRHeiyLy/NOZWPZsnjEZOxuPjQ2Vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gKVwEBPhnfdhWAcbSjQ5zOq/wuPPTboQoJEN2GlwStk=;
        b=VHT9a1lGgf02vjhhzxVT10ASjE1TuhLq2uw42a/VPCgsmjmczmdpUnhVxn56WcOPUn
         POgE52b2tCd/zChQv2p1nXU49TWi19MQWFlVr7CJloxT0N9eOhGItxO+R2xGYhuAgz7x
         wd22or3LP2PLSasVYLOQxjev2ZV1R3pTneCYVS5Y0pD8H8lZvRfan86Rpc3WQHx4EEet
         tlGZ5B7zNAICGL+x3k8r/xiHfmQzXQP7/Y9heGQ1KOWzPKgS/UfLyNwuIxCRXWeh3FDv
         TNElWctq9LdGUT3M3GenlLmT4Le0DB0jpon6e6MUg8XnBwm0igEtwfIKo9kSv8hFRxjM
         dGQg==
X-Gm-Message-State: AOAM531zwlm4S4/G7YtYqaRzrnL8nSIbNTwQ6KY2n+L6WNsBhwyldNpY
        BFM0JQOhd1blXdNFYi5VYZoun3CuKCofREl0U0QIoSGQVqc=
X-Google-Smtp-Source: ABdhPJxOGNx2EWadvMiyY+kGT8+AaL+myfQ/GBxLOwCYe8NAJAUw4nvTYpbFlreMeQwB3S8TVhK0tRLjRNlM1oyg0ks=
X-Received: by 2002:a25:452:: with SMTP id 79mr66140090ybe.421.1641560695369;
 Fri, 07 Jan 2022 05:04:55 -0800 (PST)
MIME-Version: 1.0
References: <CA+kUOak9_RLpdr9d4pQiwU=K42taCwhMdg5WkLP4GreQd4yWig@mail.gmail.com>
 <CAGyf7-HSia4pRs4FZ107v0jmP4k4Zfw5zJ-3Oz8UvF9oobczEw@mail.gmail.com>
 <CA+kUOam-Dd-XUk0XaOfw4_rUTg=Ws7w5H=vZ=ZZeEo4XJfsVOg@mail.gmail.com> <Ydg3hE+ZcCq4qW9m@ncase>
In-Reply-To: <Ydg3hE+ZcCq4qW9m@ncase>
From:   Adam Dinwoodie <adam@dinwoodie.org>
Date:   Fri, 7 Jan 2022 13:04:19 +0000
Message-ID: <CA+kUOamrMn-K8P34AmASaiXJvPu5OgYTXf6Rqwmm2+hjd5644A@mail.gmail.com>
Subject: Re: Bug using `fetch` with blank `-c` arguments to git
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 7 Jan 2022 at 12:52, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Tue, Jan 04, 2022 at 09:00:45PM +0000, Adam Dinwoodie wrote:
> > On Tue, 4 Jan 2022 at 20:04, Bryan Turner <bturner@atlassian.com> wrote:
> > >
> > > On Tue, Jan 4, 2022 at 4:37 AM Adam Dinwoodie <adam@dinwoodie.org> wrote:
> > > >
> > > > While investigating some issues with a different project, I discovered
> > > > the command `git -c config.helper= fetch` was working with the Debian
> > > > stable version of Git (v2.30.2) but not with my local build
> > > > (v2.34.1.428.gdcc0cd074f).
> > >
> > > Since you're working with a locally-built Git, have you, by chance,
> > > actually _installed_ that build, or is it simply in the Git repository
> > > itself after running make?
> > >
> > > If you haven't _installed_ your build, my guess is you might be
> > > getting a mismatch wherein your _built_ Git, when it forks out
> > > subprocesses, is triggering your _installed_ Git (which I assume you
> > > have, and which I assume is not 2.34.1). Git compiles paths into
> > > itself to know where to find certain binaries, and if you run a
> > > compiled-but-not-installed Git then those paths are "wrong". (I see
> > > administrators do this fairly often when building Git from source to
> > > set up Bitbucket Server.)
> > >
> > > What does `./git --exec-path` print, when you run your 2.34.1 binary?
> > > And is that where, for example, the compiled 2.34.1 versions of things
> > > like `git-remote-https` are?
> >
> > Good thoughts, but I initially hit this problem after having installed
> > it; I reproduced it running Git from the working copy for ease of
> > bisecting, but the problem definitely occurs using the compiled
> > version after installation. The below was collected after running
> > `make install` (plus all the previously noted build commands,
> > including running the configure script to specify the installation
> > path) with the commit I identified as introducing the problem:
> >
> > ```
> > $ type git
> > git is hashed (/home/adam/.local/bin/git)
> >
> > $ which git
> > /home/adam/.local/bin/git
> >
> > $ git --version
> > git version 2.29.2.372.g1ff21c05ba
> >
> > $ git --exec-path
> > /home/adam/.local/libexec/git-core
> >
> > $ ls $(git --exec-path)/git $(git --exec-path)/git-remote-https
> > /home/adam/.local/libexec/git-core/git
> > /home/adam/.local/libexec/git-core/git-remote-https
> >
> > $ $(git --exec-path)/git --version
> > git version 2.29.2.372.g1ff21c05ba
> >
> > $ rm -rf tmp && git -c core.autocrlf=true clone git://github.com/git/git tmp
> > Cloning into 'tmp'...
> > error: bogus format in GIT_CONFIG_PARAMETERS
> > fatal: unable to parse command-line config
> > ```
> >
> > For the sake of double-checking, though, I just uninstalled the
> > version of Git in /usr/bin (after spending some time working out how
> > to do that with apt, without also uninstalling dependencies I wanted
> > to leave alone) and repeated the above commands, and got exactly the
> > same output.
>
> I cannot really reproduce this locally. But given that it happens on
> some installations while it works alright on others my best guess is
> that you're effectively running a "mixed" setup, where Git binaries of
> one version execute Git binaries of a different version. The result
> would be that they have different ways to encode GIT_CONFIG_PARAMETERS,
> where new versions use the more robust, quoted format, which older
> versions don't understand, or the other way round.

Ah, that makes a lot of sense, thank you! In particular, I hadn't
quite put together that if different Git binaries compiled with code
both before and after this change attempted to communicate, they'd be
doing so using a mutually incompatible interface, and that would
produce this error.

> If my theory is correct, then I'm a bit on the edge to call this a bug.
> Git expects its binaries to all be of the same version, so running such
> a mixed setup is only going to cause problems. This isn't only true for
> internal variables like the one we have here, but we also introduce new
> command line switches and expect Git helpers to understand them without
> any fallback if an old binary was executed.
>
> You may want to verify that the Git executables you have are indeed able
> to execute the correct auxiliary binaries as expected and that they all
> stem from the same Git version.

Yes, that's very much the conclusion I'm coming to as well. As I
understand things, it should be possible to have multiple Git
installations at different versions on the same system, provided
they're all configured to find their libraries and executables in the
right place, so I've not yet ruled out there being a bug here. But if
there is a bug, it'll be something related to how Git finds its
libraries and executables at runtime, rather than anything directly to
do with this change. And at this point I very strongly suspect I've
just screwed up somewhere and there's no bug whatsoever.
