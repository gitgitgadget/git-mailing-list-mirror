Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB61C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 08:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 198AD610CF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 08:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhJ1Ihy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 04:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJ1Ihw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 04:37:52 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765C5C061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 01:35:25 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r4so21099601edi.5
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 01:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=sX423X5ZpByL12GgHYYdGhGodwxLOLJM9XemC3UUPiM=;
        b=PzLlGWcCkClFxMBkasC3jEWgrNlkA8uklrVjKjUKQjXXa4nhT4X5IV/md7Qt7q/33R
         /d0yI5opWejjqYgy4R/wtq2mF9WjcPS9KI8OQnnhC3l1k+MT+zjvk5Sj6OSAZs0QBw1J
         NAyU15uzn9JN61oXGNbG/kRQGA6YcOiIHFM9e8zrau3Qwsh1K6dvyECwuU1AdXkWMJX7
         MI3Jq+TMge3GZSajE1eSyjFeRab7aCOk9ModYCMiDDslRJ+oboLUj6ScBF+0hrRl15xb
         sttqPxttlAY0xMPKRYQQTUL9LGs7R/yp8vluUTIejGCTjwfws1qMF2Jr/jSyYPX6F1ue
         fdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=sX423X5ZpByL12GgHYYdGhGodwxLOLJM9XemC3UUPiM=;
        b=DnTnU1LsNTq2L4KzHMO9lANzh2XZx37fyeGB3RfmBQVEUtA2p4PvqDAuLvcbbUcTKa
         61r8dwoFX5Iy6OjP/OTLDWQFEAJ0GA/g6fTflTxlq5RVN2R8aQV9Msdry3JkC8SHsp1p
         gRx4NwysNcXRbbW2ONthFBsnyygTjcQLElVY2aUAxBzk3qbmJGbp0yjz+kwDjjnr907v
         pzzp/EROfByjFrfVVGtmYQrajzNg8fOo7hnYd9TSj6UAezMzIHp5VSoOxy/52ZTeV5xX
         ZqINDsokAj0gY63EBeNz18YecQopCCg4rxno0CNoGy5bzLB0EprArekMCQNIabD1h7Pl
         pKhg==
X-Gm-Message-State: AOAM533VZYGnqtpswxkSU2RI/Cd+E+Av9oI8COjfIGTMxgfKB5kOkGhr
        G3rHo+C9G/nrmH1t0l9a0T3dAnn63cA=
X-Google-Smtp-Source: ABdhPJzXK7ufsPVfzn0Z9Jf9dPJSUZiJ+h3/mfe98/2xPBf71vKJo/7MEWnk3FxQFfTOSJxXx5Hvqg==
X-Received: by 2002:a17:906:70c5:: with SMTP id g5mr3750988ejk.63.1635410123683;
        Thu, 28 Oct 2021 01:35:23 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id he17sm1036338ejc.58.2021.10.28.01.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 01:35:23 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mg0sc-0022Jf-Mz;
        Thu, 28 Oct 2021 10:35:22 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Cc:     git@vger.kernel.org
Subject: Re: "git describe --debug" does not show the latest tag for "groff"
Date:   Thu, 28 Oct 2021 10:26:21 +0200
References: <20211027233101.GA762862@rhi.hi.is>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <20211027233101.GA762862@rhi.hi.is>
Message-ID: <211028.86wnlxwnqt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 27 2021, Bjarni Ingi Gislason wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
>
>   I do not know, it could have happened anytime after the latest tag
> was committed (11th Nov. 2020).
>
> What did you expect to happen? (Expected behavior)
>
>   Seeing the latest tag "1.23.0.rc1" in the version string of "groff"
> (and in the output of "git describe --debug")
>
> What happened instead? (Actual behavior)
>
>   "groff --version" shows for example "1.22.4.3317-8f8c8-dirty"
>
>   "git describe --debug" shows:
>
> describe HEAD
> No exact match on refs or tags, searching to describe
> finished search at 2ac1f9ba5578cad27dc547d5be3c91753db436ea
>  annotated       3318 1.22.4
>  annotated       3319 1.22.4.rc5
>  annotated       3352 1.22.4.rc4
>  annotated       3464 1.22.4.rc3
>  annotated       3485 1.23.0.rc1
>  annotated       3572 1.22.4.rc2
>  annotated       3619 1.22.3.rc1
> traversed 3833 commits
> 1.22.4-3318-g3a1e750d
>
> What's different between what you expected and what actually happened?
>
>   The latest tag is not shown for the groff version.
>
> Anything else you want to add:
>
>
>   The latest tag in "git log" is 1.23.0.rc1 in my branch.
>   It is 1.23.0.rc1 in branch master.
>
>   Search for "tag:" in "git log" in my branch shows:
>
> commit c05b538c504106d55b81caa6400ea80797f03775 (tag: 1.23.0.rc1)
> Author: Bertrand Garrigues <...>
> Date:   Wed Nov 11 01:58:55 2020 +0100
>
>   "git show-ref 1.23.0.rc1" in my branch shows:
>
> faa3dff8d011e61721e763c71b6ccbf20a4675bc refs/tags/1.23.0.rc1
>
> ####
>
>   "git-version-gen" (gnulib) does not get the latest tag.
>
>   The call in configure.am is:
>
> AC_INIT([GNU Troff],[m4_esyscmd(build-aux/git-version-gen --prefix ""
> .tarball-version)],[http://savannah.gnu.org/bugs/?group=g$
>
>   The files ".git/packed-refs" and ".git/info/refs" are the same in both
> branches.
>
> #####
>
> [System Info]
> git version 2.33.0 (Debian/testing Version: 1:2.33.0-1)
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 5.14.9-2 #1 SMP Sun Oct 10 01:53:44 UTC 2021 x86_64
> compiler info: gnuc: 10.2
> libc info: glibc: 2.32
> $SHELL (typically, interactive shell): /bin/bash

Daginn.

The "git describe" command won't just return the latest tag name, but if
you're not on such an exact tag name find the "closest", and then add a
suffix indicating the distance and HEAD commit.

Reading between the lines I think you know that, but you're suprised
that it's finding 1.22.4 instead of 1.23.0.rc1, which newer.

I tried to reproduce this and cloned
https://git.savannah.gnu.org/git/groff.git; If you run e.g. this
command:
    
    $ for c in $(git log --oneline 1.22.4..1.23.0.rc1 | awk '{print $1}'); do git describe $c; done
    1.23.0.rc1
    1.22.4-765-g10cd0b66
    1.22.4-764-ge3b774ad
    1.22.4-763-gfb52df3b
    1.22.4-762-g0f42ca27
    1.22.4-761-gdf73fc2b
    1.22.4-760-g3afeb883
    1.22.4-759-gcb1a9dc5
    [...]

You'll see us describing all commits between 1.22.4..1.23.0-rc0, ending with:
    
    [...]
    1.22.4-7-g72b4440e
    1.22.4-6-g81908bc0
    1.22.4-5-g9da68905
    1.22.4-4-g2212cba0
    1.22.4-3-ga3068bfd
    1.22.4-2-g607236cc
    1.22.4-1-gde9f9bfd

But as your tag "1.22.4.3317-8f8c8-dirty" shows we're at a distance of
3317 from 1.22.4. Are you able to share whatever your 8f8c8 is
somewhere? I wonder if you're on some commit based off an older version.

Aside from what ref "describe" picked it's weird that a new version of
git would choose to show a 5-character hex abbreviation of the commit,
the minimum we show these days is 7, unless you have something setting
e.g. this in config:

    core.abbrev=5

Or maybe that AC_INIT() macro does that somehow...
