Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF4EC433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 21:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbiADVBX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 16:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbiADVBW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 16:01:22 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEAEC061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 13:01:22 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id m19so94183565ybf.9
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 13:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YrKvZjhHUYjrK3qi8ljq0eIY7+p2pOOloQ6xXjYdvsE=;
        b=nOB8fwMVZ7uuHRNz/fn4BHywPCFMGt7qL7i1ZuzCeuoOXFxlPYh9xyRenubp5T5v0R
         AmPp05O54d+BvzIFrJ9OpwYclmHdxpqaS+39qhqLhxZPTXT9WkI+yJX+Dy5GycCXwBEm
         HY4ugpdkXISbJAyfiwm/PdbCuxVhBUVy8QtG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YrKvZjhHUYjrK3qi8ljq0eIY7+p2pOOloQ6xXjYdvsE=;
        b=a801JOmt8LQ5v21CVNb/vhhCPD+p8DZ+x15J7C1i59VCXQkV1zGZ8LC+xxzratGlha
         nItRw9Xtv0i2xus5VdyGnP1QW29SIvcfKrIM4hU0RS4mYvaSNd+aV3deyL0Gnh7lUO9y
         bVYXpd7D3ZeXl9Si91PXZuGQc9zn6NGFKofEu2MRVdApoXwtYiSYlovV/mbbyM24PdMf
         wb8iVbjatWyHL/d+E0opNeqc71CpvpxDcxo0ZZm3rw/7qgQG/AspDBdux+05cTkIeNRY
         FUJ85PKNAfmFl37f0w4lTDLBLI2BTNBBSY/Nm3w2EzKkcTUMW9SnPKtiTu10mYzpavz1
         PgyQ==
X-Gm-Message-State: AOAM533KJgiEKrEif9plCpVsKPPeXOuslgAlbHDV2Z3XvD/m0RZKluS4
        rFe2fzuyIfC4lDyXvH1dJQhMrPpP5aAOxBQbi17rdA==
X-Google-Smtp-Source: ABdhPJxPRbtt0D+nOEaHNO18O57fRTNWDsjtKAsoIXF2AVKEePy9yL9DG6R9mYvzUA4ZfrzuVXPY5CaZoMNOcvg+ulk=
X-Received: by 2002:a25:a321:: with SMTP id d30mr21826273ybi.373.1641330079451;
 Tue, 04 Jan 2022 13:01:19 -0800 (PST)
MIME-Version: 1.0
References: <CA+kUOak9_RLpdr9d4pQiwU=K42taCwhMdg5WkLP4GreQd4yWig@mail.gmail.com>
 <CAGyf7-HSia4pRs4FZ107v0jmP4k4Zfw5zJ-3Oz8UvF9oobczEw@mail.gmail.com>
In-Reply-To: <CAGyf7-HSia4pRs4FZ107v0jmP4k4Zfw5zJ-3Oz8UvF9oobczEw@mail.gmail.com>
From:   Adam Dinwoodie <adam@dinwoodie.org>
Date:   Tue, 4 Jan 2022 21:00:45 +0000
Message-ID: <CA+kUOam-Dd-XUk0XaOfw4_rUTg=Ws7w5H=vZ=ZZeEo4XJfsVOg@mail.gmail.com>
Subject: Re: Bug using `fetch` with blank `-c` arguments to git
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 4 Jan 2022 at 20:04, Bryan Turner <bturner@atlassian.com> wrote:
>
> On Tue, Jan 4, 2022 at 4:37 AM Adam Dinwoodie <adam@dinwoodie.org> wrote:
> >
> > While investigating some issues with a different project, I discovered
> > the command `git -c config.helper= fetch` was working with the Debian
> > stable version of Git (v2.30.2) but not with my local build
> > (v2.34.1.428.gdcc0cd074f).
>
> Since you're working with a locally-built Git, have you, by chance,
> actually _installed_ that build, or is it simply in the Git repository
> itself after running make?
>
> If you haven't _installed_ your build, my guess is you might be
> getting a mismatch wherein your _built_ Git, when it forks out
> subprocesses, is triggering your _installed_ Git (which I assume you
> have, and which I assume is not 2.34.1). Git compiles paths into
> itself to know where to find certain binaries, and if you run a
> compiled-but-not-installed Git then those paths are "wrong". (I see
> administrators do this fairly often when building Git from source to
> set up Bitbucket Server.)
>
> What does `./git --exec-path` print, when you run your 2.34.1 binary?
> And is that where, for example, the compiled 2.34.1 versions of things
> like `git-remote-https` are?

Good thoughts, but I initially hit this problem after having installed
it; I reproduced it running Git from the working copy for ease of
bisecting, but the problem definitely occurs using the compiled
version after installation. The below was collected after running
`make install` (plus all the previously noted build commands,
including running the configure script to specify the installation
path) with the commit I identified as introducing the problem:

```
$ type git
git is hashed (/home/adam/.local/bin/git)

$ which git
/home/adam/.local/bin/git

$ git --version
git version 2.29.2.372.g1ff21c05ba

$ git --exec-path
/home/adam/.local/libexec/git-core

$ ls $(git --exec-path)/git $(git --exec-path)/git-remote-https
/home/adam/.local/libexec/git-core/git
/home/adam/.local/libexec/git-core/git-remote-https

$ $(git --exec-path)/git --version
git version 2.29.2.372.g1ff21c05ba

$ rm -rf tmp && git -c core.autocrlf=true clone git://github.com/git/git tmp
Cloning into 'tmp'...
error: bogus format in GIT_CONFIG_PARAMETERS
fatal: unable to parse command-line config
```

For the sake of double-checking, though, I just uninstalled the
version of Git in /usr/bin (after spending some time working out how
to do that with apt, without also uninstalling dependencies I wanted
to leave alone) and repeated the above commands, and got exactly the
same output.
