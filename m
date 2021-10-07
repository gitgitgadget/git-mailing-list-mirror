Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6656C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 11:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B510160FD7
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 11:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240708AbhJGL3k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 07:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhJGL3j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 07:29:39 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73156C061746
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 04:27:46 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id z3so3893949qvl.9
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 04:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NwDPAXXs8CfonqfYtN3DyAbQIjd2HorZkvTwLxDmbVU=;
        b=jk3VdgMVkeid+ce4sa7a6QgSy4JVoz1YoCKMQBf2AnnzVpXlXET7t9tukQlwDcHl3r
         3oHT0N5r5KT85fdnTugtcAtwYnatMVUzVCnTsXxQ22sXl+scFJ26gqSDjWxepNGY6ERC
         y/qmLE2HsEyrWjvaCt8y/wJHtVuPsiaBKREhvHx6acNTUzkjNQBrRqMFuDbs6EFYtnJM
         pciBQ7ogNaT4X97YbRYYV7nqbtkk5lniN8a8nxychIF96cnNK/2BIASGUDNvdXfYi48S
         //EgkJC2eDVK/oY4aCjs8P7oOQQrO5bW64GCcQb1MzYIkVC8AuninOa8O2I7gmvh+fV7
         OiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NwDPAXXs8CfonqfYtN3DyAbQIjd2HorZkvTwLxDmbVU=;
        b=lyeA2AXluj7OCaaOCenRna5vrxSFWls7gxqLjlWGQ4h1890LYf8wolful7EkBStLic
         hdmqsKnbspmTksZDZULaYbSW89NObJ+DXk4xEh0xMydUupk3Dfz9LO/eg9DcwIoX7hT4
         7TsPd6NbEBwPJsFfGdbS6zYtWwZFn+olpkZUJImOMSbv0TSfbC+no8u+Ek9CrFgpnneV
         zIxpNhaQWBNjzg8FNsO8VNT98yV5ups10O3pdnLRCBiDHp8tadlma+pXRWYY5cIiFy1L
         7rbieQGocKaJnm9Gv4mbMjjaagD7HMfheS4lOGz4iUxAyG587W2QvfDtK+H/4SJ2k+ip
         pqEA==
X-Gm-Message-State: AOAM532fo9Mt3I/ry34fyYvT2HTb5oGk5ptE6r+QVqDjHekmInVufxkV
        oawV+PYAJJKDOhol5NOLDFXU4/h9JKTRV9scCagJAzw3NRXqHyL3
X-Google-Smtp-Source: ABdhPJxh9p0lfx446y2nbEL88kHSiH0sBxxBGUPBg52aCeBB8dBijSEcNXLSIpHIN2zm+xxHOsqZ9hOfcOSdnLHYYbE=
X-Received: by 2002:a0c:f0c4:: with SMTP id d4mr3357142qvl.38.1633606065585;
 Thu, 07 Oct 2021 04:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <7b4b59a4-7e58-3db2-d934-d570cdebbf31@gmail.com>
 <CABkJDHHDjwviVmCR=tu3JBx+7BMmbmesOrkymq0fH4PXE5=i1g@mail.gmail.com>
 <135f854b-7975-a6a0-69ea-8697583a87b2@gmail.com> <CAJDDKr7itDvy1WPoC=kBPpT4_qm6MKWWfxwt96wQJKnGBGW5ng@mail.gmail.com>
 <CABkJDHFMy6yS40jn-NJ8mwrv6jxdjgNWQ6mJmEK1FYV0gvpLEQ@mail.gmail.com>
 <CABkJDHEZuZSun0spZ8SAcgQQvu-zamnJiqGk7VnS6agU-_KqqA@mail.gmail.com>
 <20211004075600.5lbqed4mnwfsy4al@yadavpratyush.com> <CABkJDHGdzOFW5yP43LZtuUrV7WsDTvAi+kxka84-5P7ShbV9FQ@mail.gmail.com>
 <20211006113912.n7xpnuzd25256cjm@yadavpratyush.com> <CABkJDHFap2DmjMr1Ri-Mrud+msChB3uEGRKYyczAxfmaLnF6jA@mail.gmail.com>
 <20211006180348.22e5c2z4pqkwtokx@yadavpratyush.com>
In-Reply-To: <20211006180348.22e5c2z4pqkwtokx@yadavpratyush.com>
From:   Sashank Bandi <bandi.rao999@gmail.com>
Date:   Thu, 7 Oct 2021 16:57:37 +0530
Message-ID: <CABkJDHFadi60bbwN758f2qov5dMXV2nWOwYHYVPtdfScze1XmQ@mail.gmail.com>
Subject: Re: [INFO] Does Git GUI support Dark Mode on Windows 10 ?
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> You are of course free to design your own theme, but I would suggest you
> try all these themes already available first and see if any of them fit
> your needs.
I have tried all of these themes. "default" seems like it will fit. I
have some color changes and a preview linked at the bottom. If you
agree with that, I will work on other pages/sections too.

> Anyway, I came up with a quick proof of concept for a theme selector. It
> has many limitations and is not fit to apply just yet, but it should
> help you get started.
>
> -- 8< --
> Subject: [PATCH] git-gui: Add a very crude theme selector
>
> Tk themeing is not very well documented and is not easy to get right.
> Ideally one would want to set the theme for a toolkit in one standard,
> but it is hard to find that standard config for Tk and even harder to
> get it to work consistently.
>
> Add a theme selection menu to make the lives of the user easier. Those
> who would wish to use the Tk provided theme should be able to do so.
>
> This is a very crude patch and it does not really ensure that. This is
> more of a proof of concept.
>
> Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
> ---
>  git-gui.sh     | 4 ++++
>  lib/option.tcl | 1 +
>  2 files changed, 5 insertions(+)
>
> diff --git a/git-gui.sh b/git-gui.sh
> index 201524c..ff2ec1b 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -862,6 +862,9 @@ proc apply_config {} {
>                         set NS ttk
>                         bind [winfo class .] <<ThemeChanged>> [list InitTheme]
>                         pave_toplevel .
> +                       if {[get_config gui.theme] != {}} {
> +                               ttk::style theme use [get_config gui.theme]
> +                       }
>                         color::sync_with_theme
>                 }
>         }
> @@ -895,6 +898,7 @@ set default_config(gui.fontdiff) [font configure font_diff]
>  # TODO: this option should be added to the git-config documentation
>  set default_config(gui.maxfilesdisplayed) 5000
>  set default_config(gui.usettk) 1
> +set default_config(gui.theme) "default"
>  set default_config(gui.warndetachedcommit) 1
>  set default_config(gui.tabsize) 8
>  set font_descs {
> diff --git a/lib/option.tcl b/lib/option.tcl
> index e43971b..acce160 100644
> --- a/lib/option.tcl
> +++ b/lib/option.tcl
> @@ -160,6 +160,7 @@ proc do_options {} {
>                 {c gui.encoding {mc "Default File Contents Encoding"}}
>                 {b gui.warndetachedcommit {mc "Warn before committing to a detached head"}}
>                 {s gui.stageuntracked {mc "Staging of untracked files"} {list "yes" "no" "ask"}}
> +               {s gui.theme {mc "GUI theme"} {ttk::style theme names}}
>                 {b gui.displayuntracked {mc "Show untracked files"}}
>                 {i-1..99 gui.tabsize {mc "Tab spacing"}}
>                 } {
> --
Thank you. This helps me find the location of the options. I will
further improve this.

Here is the preview I said: https://pasteboard.co/rwUBvWbX6m66.png .
The checkbox needs some tinkering.
Looking forward to any suggestions.
