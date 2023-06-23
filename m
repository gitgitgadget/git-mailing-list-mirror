Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021A0EB64DD
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 07:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjFWH1B (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 03:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjFWH07 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 03:26:59 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A791E6E
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 00:26:58 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-562fe8dda4fso225780eaf.1
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 00:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687505217; x=1690097217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9CZucAcwUwWWey6fy+NFw+vIpIL98/WY04mrJIF0DY=;
        b=dL1YpIwerUtRhAFZgCGaKUGcWQRysdiRKQVAFJPJTp33ObCdEu8hekl3rP16320faj
         JTP/riQ7W/kXkT+7mhQRvP6Nw/hFjqQlxbPhgCWGcfD00g5q+2ptJHlP0e7vrM7IV2nl
         LfpozKQPthBdjySqdP+Hbini4ncI3UrTQghVZL/6l1sjc7VUshJu+/xxkmFk37xA+WI8
         WQjahufJCNXSTD4sDJshaJAHJC+VvP47sXmryNADzpLkbBJSPq851dYj0eUNkD5rey3W
         Qy4NfURBrsmmdYNZiNCcqpPaVNTj5PWMYzvd/HbXtVw5QUrMXuPeQg4ZG1zlE9cL8jIa
         0ujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687505217; x=1690097217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9CZucAcwUwWWey6fy+NFw+vIpIL98/WY04mrJIF0DY=;
        b=OXlnjNEjTnIT9cu3VMMQ2y7Bc7L6vayBjWHDpHkR/84rUQAdOmQ6AN8ExTvDbr+loy
         hxNl7vEwGkKGBUxmsdMK5xnLZv54HwKMgQNhMkvjiZCwu6lHKHByWp6IMKpmB0+R2uNl
         cyXKIOsfj0LojHZcrcn6EMld17eX0dsWPLbY8eSQAw9Z2ksa6fZaOXIQy/PmpTRkUFB5
         5FHmZhjnmJwAX/0x2w6EKgnbdRsdjMIflfcoZI9wqDRU5RqAA37zTNdG3HF2dyIRIbHJ
         uI/rOyHAIjzgzoLRZgMMDlEZPVdK3aaI9ZFkn9xYUQb7RIaKZLL27OCh6UPzzcv2K2eY
         JcIA==
X-Gm-Message-State: AC+VfDxlwx9eQdZLr5tOXfBGZ3dO3BYguuycX5BPQWuJw7pLA26Xf8ZX
        HQvxZoM9dBswuLJDd7YiwRyQ10toPknvRF/k02SPd1Bg
X-Google-Smtp-Source: ACHHUZ6+d99GcCKYLk5OhC5zGW+SK3nsbFJOml1WSCoY6E9JaDUH0arXN53CSFmPtEqpuCmyo20ZkftmlVYVDbQKBg4=
X-Received: by 2002:a05:6820:614:b0:55e:5c65:c6cd with SMTP id
 e20-20020a056820061400b0055e5c65c6cdmr12941631oow.6.1687505217440; Fri, 23
 Jun 2023 00:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <ZJQr0_aC-NlLXDgj@pweza> <ZJRHlJvE4BMue1/Z@nand.local> <ZJR5SPDj4Wt_gmRO@pweza>
In-Reply-To: <ZJR5SPDj4Wt_gmRO@pweza>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 23 Jun 2023 00:26:46 -0700
Message-ID: <CA+P7+xoj=4tdMtsyB3=8DADkygDV9Tsiv03puSyh4mVR-Nz2ag@mail.gmail.com>
Subject: Re: bug: submodule update fails to fetch
To:     Sergei Golubchik <vuvova@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2023 at 9:57=E2=80=AFAM Sergei Golubchik <vuvova@gmail.com>=
 wrote:
>
> Hi, Taylor,
>
> On Jun 22, Taylor Blau wrote:
> > On Thu, Jun 22, 2023 at 01:09:07PM +0200, Sergei Golubchik wrote:
> > > Hi,
> > >
> > > Sometimes (my local repository has lots of branches) after switching
> > > branches
> > >
> > >   git submodule update --init --recursive
> > >
> > > fails with something like
> > >
> > >   fatal: transport 'file' not allowed
> > >   fatal: Fetched in submodule path 'wsrep-lib', but it did not contai=
n e238c0d240c2557229b0523a4a032f3cf8b41639. Direct fetching of that commit =
failed.
> > >
> > > the submodule transport is not 'file' (it's https) and the direct
> > > fetching of the commit actually works:
> > >
> > >   cd wsrep-lib
> > >   git fetch origin e238c0d240c2557229b0523a4a032f3cf8b41639
> > >   git checkout e238c0d240c2557229b0523a4a032f3cf8b41639
> > >   cd ..
> > >
> > > after that
> > >
> > >   git submodule update --init --recursive
> > >
> > > succeeds.
> >
> > It makes sense that after manually fetching the desired tip that the
> > submodule update goes through OK, because there is nothing to do (the
> > checked-out state matches what's in .gitmodules), so we don't have to
> > use any transport mechanism.
>
> Right. I just used it to show that git thinks the submodule was updated
> correctly and doesn't try to do anything after that.
>
> > I recently changed the submodule update rules to disallow file-based
> > submodules when not directly executed by the user. See a1d4f67c12
> > (transport: make `protocol.file.allow` be "user" by default, 2022-07-29=
)
> > for more of the details there.
>
> Yes, I've seen it. That submodule shouldn't be affected:
>
>   $ git remote -v
>   origin  https://github.com/codership/wsrep-lib.git (fetch)
>   origin  https://github.com/codership/wsrep-lib.git (push)
>
> so I wouldn't want to circumvent your fix and allow the file transport
> that we aren't using.
>
> > But in the short-term, I am curious why we are complaining about needin=
g
> > to use the file transport when you claim that the submodule actually
> > needs the HTTPS transport.
> >
> > Are you able to share a copy of your repository, and/or its .gitmodules
> > file, and your repository-local .gitconfig, as well? Do you have some
> > `url.<base>.insteadOf` value configured elsewhere that would be
> > rewriting those paths for you?
>
> No insteadOf. Let me try to...
> Okay, here's the bug. In submodule--helper.c, fetch_in_submodule()
> function, there're lines:
> ---------------------------
> 2211         if (oid) {
> 2212                 char *hex =3D oid_to_hex(oid);
> 2213                 char *remote =3D get_default_remote();
> 2214
> 2215                 strvec_pushl(&cp.args, remote, hex, NULL);
> 2216                 free(remote);
> 2217         }
> ---------------------------
>
> this get_default_remote() appears to be getting the default remote name
> for the main repository and then uses it to fetch from the submodule.
>
> It happens that my default remote isn't "origin" (long story), it's
> "github", but in the submodule it's of course "origin", there's no
> "github" remote there. As a result, `git submodule update` runs the
> command
>
>   git fetch github ${commit_hash}
>
> in the submodule, and that's interpreted as 'file' transport.
>
> To repeat this you need a repository where the default remote isn't
> "origin" and a submodule where the commit cannot be fetched by simply
> `git fetch` and needs a direct fetch.
>
> Hope this helps.
>
> Regards,
> Sergei

I recently experienced something similar when changing the default
remote name for some of my repositories. I had wondered what causes
problems because submodule update would sometimes fail but other times
succeed.
