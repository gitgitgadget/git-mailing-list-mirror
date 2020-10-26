Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC0EC4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 16:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F393221FC
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 16:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbtLabYB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786573AbgJZQwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 12:52:43 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35909 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1786528AbgJZQwm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 12:52:42 -0400
Received: by mail-ot1-f68.google.com with SMTP id 32so8617499otm.3
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 09:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T+s+vsPTeXwFSvIG3JWYP6sBQxNGB2l5Nl536mOBj9M=;
        b=jbtLabYBzQMEOVMCrcNoPRA8BR8mimkTv21dA8VSeM+eAuaRHC/X+hqZiRC98qxews
         0+77sz0ZqXNgmPZxijGx9VS0ZxQReAqQJbcFHHcGWsvtOBFVQNvIjzldeXE9AsIk/tud
         7m+m+/2fowK0IG982/J6lyQAlYg74GJbQqLlNz/xdY+rUD1wON99K2BrpMd8tezUEn/g
         ekt4enU6c5jm+03D86wyQRpGQpOnDoBxBgLzTUNQuD+0Bhb6O6nx7yTbJV7Up/fQSXbS
         +FGt2YE+R938KzKcgn9BKf2ZeqvrGIlnhJS2z69nsG4I7naZ36rUz3mFLC680zcfdPny
         dYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T+s+vsPTeXwFSvIG3JWYP6sBQxNGB2l5Nl536mOBj9M=;
        b=cZ93kdRwkJZz1b5G3mOziJfPlcDI0Nx5qHsvKsdu8Ig5EuRtN5f7m6nGy6TZAzMVbQ
         qhY+4OEMClXCLdpj1nEjUVo51v7QbYYAXjQ/QO5xM0yE04T5ng3VH0r97N8H3gh4I6rc
         XhS8g/+KsLB7PQVuun1Rh0097hY8OW5+jtaKDaC4YCmVDfN5V90WoFeqXeHXCq3CiUzE
         ZeS6hr/KLrPqWNW0tHdewO+/nUyvOZwlUaQ3u7Pwzl7TDGLeW1T8bxp5Bt5cslChWj5G
         +aewi3cBFPTrgyFoKcWi/zl6+dkYrwQ+kMOd1jt80DY+chYLEsKJS2aWl+Ps26nSiyah
         J3xw==
X-Gm-Message-State: AOAM53106dg6eywhIobQXvASDX+ZEmOWuvD3K4QrjyiwS+4yHG1bSlXC
        B+FHtRQuhyJcH1LJA6ZSZovMdIIi59YQfJTtSj4VmgkVyalA0g==
X-Google-Smtp-Source: ABdhPJz7QBOfBF++mRyiqlf3CQKkGoLHoiL0O2ZV+n/3tkqPbh5QRgMQRO6kvDPPxPXmDIWTH63matq16Ooq3F4MfmY=
X-Received: by 2002:a9d:6003:: with SMTP id h3mr15726710otj.345.1603731161539;
 Mon, 26 Oct 2020 09:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHjREB6Hh+urW3j2c9p45ZudSdDv0rUP28Lb4e4TZasqTzRmDA@mail.gmail.com>
In-Reply-To: <CAHjREB6Hh+urW3j2c9p45ZudSdDv0rUP28Lb4e4TZasqTzRmDA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 26 Oct 2020 09:52:30 -0700
Message-ID: <CABPp-BF3MEAkJmmLv_0fWBJV_2AMqh_8P7Dqk62c2_Uz9Pa3Lw@mail.gmail.com>
Subject: Re: [Outreachy][Proposal] Accelerate rename detection and the range-diff
To:     Sangeeta NB <sangunb09@gmail.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi and welcome!

On Mon, Oct 26, 2020 at 1:44 AM Sangeeta NB <sangunb09@gmail.com> wrote:
>
> Hey Everyone,
>
> I would love to participate in outreachy this year with Git in the
> project "Accelerate rename detection and the range-diff command in
> Git". I have contributed to the microproject "Unify the meaning of
> dirty between diff and describe"[1] which is still under review, but
> through the process, I have got myself familiar with the mailing list
> and patch review system. I am also contributing to another issue[2]
> which is still under discussion[3] about `git bisect` and `git
> rebase`.
>
> [1] https://lore.kernel.org/git/pull.751.git.1602781723670.gitgitgadget@gmail.com
> [2] https://github.com/gitgitgadget/git/issues/486
> [3] https://lore.kernel.org/git/pull.765.git.1603271344522.gitgitgadget@gmail.com/
>
> Coming to the project, I have read more about it[4] and have created
> the initial version for the timeline. I would really love to have
> comments on it.
>
> [4] https://github.com/gitgitgadget/git/issues/519

I might be the bearer of some bad or concerning news.  This email is
directed more to the mentors and others on the git mailing list, but
obviously may affect you as well:

I apologize for not stating my concerns more forcefully earlier, but I
didn't have as many details at the time or have an idea how fast
merge-ort could be upstreamed.  Anyway, I'm still concerned that this
might not be a good project for Outreachy due to two factors: unclear
benefit, and conflicts:

1) I've got merges down to the point where even if there is a massive
rename of 26000 files (e.g. renaming "drivers/" to "pilots/" in the
linux kernel), rename detection is NOT the long tent pole in a merge.
So although this project is interesting, it's not clear that this
project will help us much.  It might be better to get my changes
merged down and see if there's enough need for additional
optimizations first.

2) Ignoring what I've already submitted, the remaining diffstat for
merge-ort is about 5500 lines....
  2a) If I break that ~5500 lines into patches with 50 lines each,
that's 111 patches.  If I assume I can send 10-20 patches per week
without overwhelming folks, that's 6-11 weeks, pulling us somewhere
into mid-December or mid-January.  10-20 patches per week might be
over-optimistic on reviewer fatigue, which would push it out even
further.
  2b) Work is going to soon rotate me onto other non-git projects,
meaning even if the mailing list can review my changes aggressively,
there's a chance I might not be able to keep up on feeding them to the
list.
  2c) diffcore-rename.c is only ~700 lines right now.  My 5500 lines
of changes includes over 1000 new lines for diffcore-rename.c and
about 150 line removals for it.  These changes are spread all over the
file; only four small functions remain untouched.  In fact, I even
made big changes to struct diff_rename_dst too, so any new uses of it
would almost certainly have textual conflicts.
  2d) My diffcore-rename.c changes probably do not make logical sense
to submit first.  They should come after some groundwork is laid for
merge-ort.

Even though at a high level this project is complementary to the
optimizations I made in my 'merge-ort' work, I fear there will be LOTS
of intermediate conflicts as we both make changes to the same areas
during the same time and make a mess of things.

If you all think this is still a good project to have an intern work
on, I'll defer to you, but I am concerned.


Elijah
