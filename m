Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A25C48BDF
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 01:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7BBE61166
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 01:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbhFPBmN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 21:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbhFPBmM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 21:42:12 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697C5C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 18:40:07 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id p66so1261077iod.8
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 18:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rosekunkel-me.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=m34uXPJ50s82xwe6pPqQSOwkPNzDffbzKTACGjzZErQ=;
        b=kLdqyceaCjqB2n8nZZRtSBfvPqYVY6K83SIkNpJWS9cM+BszzuiMnaqZixZVRBobvl
         Jx35tOUqv+15yH+JewqxTIfslJ/ORacDaghmHKcLSkY9XLa8URwYv4gp1l/1QB+hjD34
         g2uR0FMIVGt2jRJSy9YS7ZTwgtav4CjoK0vkifPG5raB8Lwe7cbCjJkyZCFbsXNEuDmx
         kdLAIizb13OmoeDu/Zzf7ZUeyh9s7jWXifR/NFyeI5YOGU2rllB9IxfG4/yQkGIe6W44
         NZ1uTvZSUtvXfw5qm2vjfudPXmfFAoC+45zPyCISmEKeupSP8AEJ4WBLimMVX3cTAtRD
         wupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=m34uXPJ50s82xwe6pPqQSOwkPNzDffbzKTACGjzZErQ=;
        b=IrvaH7F9R+C0jGH9sfqc49w+cNEEjK27jQkyEnmOqArxwENZDQKrJbGiDIQGVazQJZ
         GKGvU/nWhuq8zL41yL9eqS6kSsFhscRq0HKilSVPZQqRiWS8k1eoHGItioyKN6W5snzO
         Y1tHOjwt2z8kh6v+ZAkiIPoAVD8lw/ZFNijfJwMkFOymIn0iG3pOvdq5KJ5uwC0R2YDh
         ubpi7pAxTJ3xButwzD43awAY7CQ6494AQzvDW0GYgRvwVNEvw9Zy/ZOdgU+ml5DqbftS
         fBgBppizj1tTqSyTSjtyTIXW3stfFw/otuRfmIF5KD2ZUDxU1DfI4EMc/xOr0TBEJ05p
         3UpQ==
X-Gm-Message-State: AOAM5330ewo1LmU6iQwXcJeqAB+CTZR42Kw079GWvprN85YSjbBYqZmN
        ++b0isMQTaan2K1n/R3QzCgbUltPM84JdlkMHX/y/UvVXDo=
X-Google-Smtp-Source: ABdhPJwz+9RNSzPX4h+mIABNeXu7C+jumbrfxJIqUZsrSJmAOVZQXPnt94ed4nKtUoj5JiEVZBzJ2xg9tEMGvOKrpoA=
X-Received: by 2002:a5d:9059:: with SMTP id v25mr1627754ioq.113.1623807606700;
 Tue, 15 Jun 2021 18:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAKjYmsELpf9r3bAJj_JUHgVegw_7z2KzyuR_6FYYngpC1XmNeg@mail.gmail.com>
 <YMlLGwScowX8eXeJ@camp.crustytoothpaste.net> <CAKjYmsHD2MuTE+drebKichz_0wquPN8ZTLbiPkUCZJyLsSFh8Q@mail.gmail.com>
 <CAKjYmsEHWShuKEOFWnCyU1x5rM7kFrcaN78D7KhhUay8kCvA2g@mail.gmail.com> <YMlS+1F9IND7vxNI@camp.crustytoothpaste.net>
In-Reply-To: <YMlS+1F9IND7vxNI@camp.crustytoothpaste.net>
From:   Rose Kunkel <rose@rosekunkel.me>
Date:   Tue, 15 Jun 2021 18:39:55 -0700
Message-ID: <CAKjYmsFVfMW4DKz4cA_fNugGim4m+-aJgOW+k0za+T-D8YHc7g@mail.gmail.com>
Subject: Re: [BUG] `git reset --hard` fails with `update = none` submodules
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Rose Kunkel <rose@rosekunkel.me>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That sounds reasonable to me.

I do think it's pretty unintuitive that `update = none` means that
submodules never get initialized, even with an explicit `git submodule
init` command. If this is intended behavior, it should be better
documented. If not, fixing that would also fix this bug.

On Tue, Jun 15, 2021 at 6:25 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2021-06-16 at 01:03:40, Rose Kunkel wrote:
> > Potentially relevant: `git config --global --list` shows
> > ```
> > status.showstash=true
> > status.submodulesummary=true
> > submodule.recurse=true
>
> Thanks for this additional information.  This line is the critical
> piece.  Now I get this:
>
>   $ git reset --hard
>   fatal: not a git repository: ../../.git/modules/repos/agda
>   fatal: could not reset submodule index
>
> Predictably, "git -c submodules.recurse=true reset --hard" also results
> in the same thing.
>
> The --recurse-submodules option for git reset says this (emphasis mine):
>
>   When the working tree is updated, using --recurse-submodules will also
>   recursively reset the working tree of all *active* submodules
>   according to the commit recorded in the superproject, also setting the
>   submodules' HEAD to be detached at that commit.
>
> On my system, .git/config has this:
>
>   [submodule]
>           active = .
>
> So these submodules are active, but they probably should not be, since
> we haven't checked anything out (or, for that matter, cloned any data)
> and it wouldn't make sense to try to operate on them automatically with
> submodules.recurse or --recurse-submodules.
>
> My gut tells me that we should probably mark submodules with update=none
> set on a clone as inactive.  Of course, this is a tricky area that I'm
> not super familiar with, so opinions or thoughts are welcome.
>
> If folks think this is a good way forward, I'll look into writing a
> patch, probably tomorrow evening since it's starting to get late here.
> --
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA
