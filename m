Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F6AC433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 21:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392635AbiDUVEv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 17:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244830AbiDUVEt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 17:04:49 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68066161
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 14:01:58 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id r18so7270182ljp.0
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 14:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TZNo19nV+GF8lwWI/KLDAcCDzJWinwP6nQnb6hPuXUA=;
        b=szi8JHRJ827h87zR1hbcIqP9aFkQ33jrQJ6jgbtXbzm/S0fqAEvyzEPw9QcJOVLxSE
         c5RerYqlbWNPNRKtnNFAG4mFjRKsuM/e/BYmMf62W7UTBwu718T0IcHzLgeYfzavClSJ
         J5m0qOMuOCAO3jdsaB8maZpPRhBMWY30fsxSHm13qUU5W1xYJYVx247xsTLbf4yWaTZI
         6rzUl/nmWq3xtQZKmes+4gk9Bdg6tMF0sHKVo5jd9+fImduHAXFSj8f38V6i6HpzSNRM
         +wzTW2lKx9tPZiKrlnMzWkp0YGzGZYnLqq+sPGlyLMsUaCRUhvHK0TGHHJSePsYH0EOy
         NPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZNo19nV+GF8lwWI/KLDAcCDzJWinwP6nQnb6hPuXUA=;
        b=CTwB6M6GTzt8CPQ+KrlAUdp2pWzUC+wGZoNG2HzfpUbJAYayOmB4MNhYUFQ+cGiqo/
         1vvVx8ooDLtrLUGObkwN7FGMQ4pXCuc8xvseYuU9WVo19NrJ9IwZX7L8J8SYWa3rVu2F
         VkeFd3VwFvkXrbv/VIQlLjRwmON9CDJb9uUd1moiEeFtaJU95RnWpm4JvlvyWUCgaujV
         PVthGROZkvvg5cT05HrB8/n/rJe+RU4hfGWRZEmCr3bBf8KDiGJiCfk4sognNJgK2xlp
         cawe9ZfgWWOJTVZdS8oN1+L9KgWtu/CNBlcizjMX7bBmv4vcOQQvyMP6iyNBwtyAmidP
         mjKw==
X-Gm-Message-State: AOAM532VRJhOBRV+HB4luHz7PPD6bAWMXl5ih3uBkM0l6nN3XLnV3XnJ
        FvLzc1P/co+6XhkPAwnlKspYh+FbBkwFAYSQ/HtElQ==
X-Google-Smtp-Source: ABdhPJxwlbO5R9Pa/NnkJVMWV1og8fzU3LUyUpUVDVcVuFT5B2cV7WaPLQLuEKC/du+F1ZBX/aL19HERJOLlMBpMyOQ=
X-Received: by 2002:a2e:b892:0:b0:24b:6c87:7248 with SMTP id
 r18-20020a2eb892000000b0024b6c877248mr902573ljp.53.1650574916288; Thu, 21 Apr
 2022 14:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lwnfp7tbc.fsf@chooglen-macbookpro.roam.corp.google.com>
 <Ylobp7sntKeWTLDX@nand.local> <CAJoAoZkgnnvdymuBsM9Ja3+eYSnyohr=FQZMVX_uzZ_pkQhgaw@mail.gmail.com>
 <YmGr0upicQJML+9B@nand.local>
In-Reply-To: <YmGr0upicQJML+9B@nand.local>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Thu, 21 Apr 2022 14:01:44 -0700
Message-ID: <CAJoAoZnd=BKycr0c71-BQJyO3zoymC7p++Zke+OSkV4neweAOQ@mail.gmail.com>
Subject: Re: Bare repositories in the working tree are a security risk
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Glen Choo <chooglen@google.com>, Git List <git@vger.kernel.org>,
        justin@justinsteven.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Martin von Zweigbergk <martinvonz@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 21, 2022 at 12:09 PM Taylor Blau <me@ttaylorr.com> wrote:
> On Thu, Apr 21, 2022 at 11:25:39AM -0700, Emily Shaffer wrote:
> > On Fri, Apr 15, 2022 at 6:28 PM Taylor Blau <me@ttaylorr.com> wrote:
> > >   3. This seems the most promising approach so far. Similar to (1), I
> > >      would also want to make sure we provide an easy way to declare a
> > >      bare repository as "safe" in order to avoid permanently disrupting
> > >      valid workflows that have accumulated over the past >15 years.
> >
> > I'd like to think a little more about how we want to determine that a
> > bare repo isn't embedded - wantonly scanning up the filesystem for any
> > gitdir above the current one is really expensive. When I tried that
> > approach for the purposes of including some shared config between
> > superproject and submodules, it slowed down the Git test suite by
> > something like 3-5x. So, I suppose that "we think this is bare" means
> > refs/ and objects/ present in a directory that isn't named '.git/',
> > and then we hunt anywhere above us for another .git/? Of course being
> > careful not to accept another bare repo as the "parent" gitdir.
>
> Definitely worth considering. Fundamentally I think if you're going to
> allow checking out embedded bare repositories (which I strongly think
> that we should), any search for "is this repository embedded in another
> one?" needs to walk along its entire path up to the filesystem root.
>
> I'd think that we could offer some tools, perhaps "safe.boundary",
> specifying a list of directories to halt our traversal at. IOW, if you
> have a bunch of bare repositories underneath /data/repositories, and
> know that they're all safe, you could set your boundary there to signal
> to Git "if my path is a subdirectory of anything in safe.boundary, then
> I don't care whether the repo is embedded or not".

Ah, I'm sorry to say that I was more on board before I read this mail
than I am after :)

I don't think there is much reason to continue searching above the
first found '.git' because we disallow '.git' from being committed or
checked out, right? So this extra filesystem hunting and ceiling math
seems unnecessary to me. I know I am slightly allergic to searching
the filesystem for a parent repo to begin with, so I'm sure I've got
some bias here ;)

> > > Here's an alternative approach, which I haven't seen discussed thus
> > > far: [...]
> >
> > Nice - a more strict spin on proposal 3 from above, if I understand it
> > right. Rather than allowing any and all bare repos, avoid someone
> > sneaking in a malicious one next to legitimate ones by using an
> > allowlist. Seems reasonable to me.
>
> We'd probably want to allow saying "all embedded bare repositories are
> safe to read config/hooks from", too. I hadn't considered this approach
> as a way to read some embedded repos and not others; I suspect the
> overwhelmingly common use-case would be: `git config --local
> safe.embeddedRepo '*'`.

Ah, I dislike this option for the exact reason I mentioned - avoiding
a malicious repo being snuck in next to legitimate repos. I'd prefer
to rely on exact matching only - but as the config needs to be set by
every contributor every time the set of bare repos changes, that
sounds impossible to manage for a project which may be constantly
adding and removing these repos.

That said.... I'm biased again, but if you want to be certain of the
state of another repository in order to run tests in it... why not use
a submodule for that repository? Not a helpful comment for those
already using embedded bare repos, though ;)

Thanks for the food for thought.
 - Emily
