Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E05BC433E4
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 15:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CE7720829
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 15:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="tfXDSlbo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgHMPNj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgHMPNh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 11:13:37 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD44BC061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 08:13:32 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id r19so2760751qvw.11
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 08:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2kPp13dciGhbwlxQzhED4/vcW5PVG6Qt3q0J5Z3iA4Y=;
        b=tfXDSlboGh7EJmHJ/gY5Pp1dZU+NrSXMZrZ3f4UfmHDb0jUK52DalRgzLqKe19tD5d
         O1JrhmQoBS2D28z27RlyFTfWrOkPUoK8QeEr3z2SxOQWQBFLakbpfb5quVIimUSQELGK
         tTAdxA2DTX49wXKIHUI+2kc3hZY5vpNTP72uOZyN1n2i0WgJX/y0+IirolIqMDP29CFt
         W2LbWJ6fGAPj1LCubjzI7BqdrvkBx6ZdiziQohba+ciuf4TqD35vxQEv9+3i9gjM0YYA
         EDOO456baHCJxaT8kfIbyJAP3qC0XtnC6dnCOovlul/Ln/HzJTvM6aYkJitgS88hMqoP
         5dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2kPp13dciGhbwlxQzhED4/vcW5PVG6Qt3q0J5Z3iA4Y=;
        b=A2IEU2bgQD9u6VEjVmifGpJ1nURDc8o/QRwEQ4YozjTQeN801MALurPRIWI1L6GIOw
         EhOsVWSeVN4eH6rGMiE56cASmuPNDMxWmUBoS6SV+yKlJIbZJ5oLJr7mteKput3NJ7c2
         Pit110lmODa1mxYPs2e2387aJrxlk0qnpBp3A/iQTjwAthjZVEzIyUGj7QSPH5FwqF+S
         DNBiJGd4MqORN9Ia2S/GvBxp0to2F3P2/U4ZiSWjlu0qYldwA0mxbbzWZwHe4PA/SjYv
         nNb9KoDdbaYp4qd9agCC6eDBVGYj4nQDs4VNSpfCrmUCxmJWo3hkI5MPV5ijsbNctWfJ
         ue6w==
X-Gm-Message-State: AOAM531vLr2N4j45PzOc1ZFM5RzZCLZuuMFBccVlsRfD0LWfqlU1mlLE
        Zxwl+bLskeykP+mmrlHl8r2jP+Uu8pO69Q==
X-Google-Smtp-Source: ABdhPJyEm7nOqtD6Ii9l6ox6s5u7q+CYmFbEr2iXFwohV0zaHLyfk6o3tySo+caicviDnMsX0QDWYg==
X-Received: by 2002:a0c:8c0e:: with SMTP id n14mr5210271qvb.86.1597331611649;
        Thu, 13 Aug 2020 08:13:31 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:cdcd:c658:5bb1:ebc9])
        by smtp.gmail.com with ESMTPSA id h55sm7320441qte.16.2020.08.13.08.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 08:13:30 -0700 (PDT)
Date:   Thu, 13 Aug 2020 11:13:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/5] slimming down installed size
Message-ID: <20200813151329.GD2244@syl.lan>
References: <20200813145515.GA891139@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200813145515.GA891139@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 13, 2020 at 10:55:15AM -0400, Jeff King wrote:
> A while ago I was looking at the size of an installed (and stripped)
> build of Git, and noticed we could make a few more things into builtins.
>
> Patches 2-4 do that.  I don't think there's any real downside here.
> We're not bringing in any new link dependencies to the main binary. And
> even if these programs don't use all of the code that's in the main
> binary, operating systems are good at just loading the pages that we do
> need (and you're probably running other Git programs anyway, which means
> the main binary is in RAM anyway and we're actually reducing the overall
> memory footprint).
>
> The final patch is not strictly related, but it's something I've had
> sitting around for a long time. I actually posted it almost exactly two
> years ago:
>
>   https://lore.kernel.org/git/20180817190310.GA5360@sigill.intra.peff.net/
>
> which ended with Jonathan saying:
>
> >  - keeping this in-tree for the benefit of just one user is excessive,
> >    so removing it is probably the right thing
> >
> >  - it would be nice if the commit removing this code from Git includes
> >    a note to help people find its new home
> >
> > Would you mind holding off until I'm able to arrange that last bit?
>
> So...I held off for a bit, but I'd really like to be done with this (and
> I prefer dropping the code, because I have a few other tree-wide
> cleanups for which I'd just as soon not have to deal with vcs-svn).
>
>   [1/5]: Makefile: drop builtins from MSVC pdb list
>   [2/5]: make credential helpers builtins
>   [3/5]: make git-bugreport a builtin
>   [4/5]: make git-fast-import a builtin
>   [5/5]: drop vcs-svn experiment
>
>  .gitignore                                    |    1 -
>  Makefile                                      |   45 +-
>  builtin.h                                     |    5 +
>  bugreport.c => builtin/bugreport.c            |   10 +-
>  .../credential-cache--daemon.c                |   29 +-
>  .../credential-cache.c                        |   29 +-
>  .../credential-store.c                        |    6 +-
>  fast-import.c => builtin/fast-import.c        |    3 +-
>  contrib/buildsystems/CMakeLists.txt           |   52 +-
>  contrib/svn-fe/.gitignore                     |    4 -
>  contrib/svn-fe/Makefile                       |  105 --
>  contrib/svn-fe/svn-fe.c                       |   18 -
>  contrib/svn-fe/svn-fe.txt                     |   71 --
>  contrib/svn-fe/svnrdump_sim.py                |   68 -
>  git.c                                         |    5 +
>  remote-testsvn.c                              |  341 -----
>  t/helper/.gitignore                           |    2 -
>  t/helper/test-line-buffer.c                   |   81 --
>  t/helper/test-svn-fe.c                        |   52 -
>  t/t0081-line-buffer.sh                        |   90 --
>  t/t9010-svn-fe.sh                             | 1105 -----------------
>  t/t9011-svn-da.sh                             |  248 ----
>  t/t9020-remote-svn.sh                         |   95 --
>  t/test-lib-functions.sh                       |    2 +-
>  vcs-svn/LICENSE                               |   32 -
>  vcs-svn/fast_export.c                         |  365 ------
>  vcs-svn/line_buffer.c                         |  126 --
>  vcs-svn/line_buffer.txt                       |   77 --
>  vcs-svn/sliding_window.c                      |   79 --
>  vcs-svn/svndiff.c                             |  309 -----
>  vcs-svn/svndump.c                             |  540 --------
>  31 files changed, 80 insertions(+), 3915 deletions(-)
>  rename bugreport.c => builtin/bugreport.c (96%)
>  rename credential-cache--daemon.c => builtin/credential-cache--daemon.c (91%)
>  rename credential-cache.c => builtin/credential-cache.c (83%)
>  rename credential-store.c => builtin/credential-store.c (96%)
>  rename fast-import.c => builtin/fast-import.c (99%)
>  delete mode 100644 contrib/svn-fe/.gitignore
>  delete mode 100644 contrib/svn-fe/Makefile
>  delete mode 100644 contrib/svn-fe/svn-fe.c
>  delete mode 100644 contrib/svn-fe/svn-fe.txt
>  delete mode 100755 contrib/svn-fe/svnrdump_sim.py
>  delete mode 100644 remote-testsvn.c
>  delete mode 100644 t/helper/test-line-buffer.c
>  delete mode 100644 t/helper/test-svn-fe.c
>  delete mode 100755 t/t0081-line-buffer.sh
>  delete mode 100755 t/t9010-svn-fe.sh
>  delete mode 100755 t/t9011-svn-da.sh
>  delete mode 100755 t/t9020-remote-svn.sh
>  delete mode 100644 vcs-svn/LICENSE
>  delete mode 100644 vcs-svn/fast_export.c
>  delete mode 100644 vcs-svn/line_buffer.c
>  delete mode 100644 vcs-svn/line_buffer.txt
>  delete mode 100644 vcs-svn/sliding_window.c
>  delete mode 100644 vcs-svn/svndiff.c
>  delete mode 100644 vcs-svn/svndump.c

Looks all very good to me, and I'm certainly a fan of being able to drop
the installation size down substantially as you have done here. I didn't
comment on patches 3 and 4, since they are obviously correct and a good
thing to be doing.

It would be interesting to think about how we might prevent someone from
introducing something that should be a builtin and has to link against
libgit.a other than looking for it carefully in review, but that's
definitely outside the scope of what you're trying to do here.

Thanks.

Taylor
