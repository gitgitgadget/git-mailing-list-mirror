Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C994C47E48
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 19:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB179613D2
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 19:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237579AbhGNTrI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 15:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbhGNTqR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 15:46:17 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAE7C0613E9
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 12:40:08 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x17so4663081edd.12
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 12:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=RaFX0tFkQogY542EMTcNJHMix5aBURAyvK0LWD31b1o=;
        b=J3Xt1GjlAMW1sw6tKqPHRaK7EikxZ1xUeF5u6XHmdD6uhgtgwRE37gkMaRWqrHkKk4
         pqXrNndOaCGoB7rGWq49CqlV8K0mWMS8mUn6Iw0Tw2PJhIT3bgViCHE9IsI87BtWJRxl
         J1NhKJoJn9f+yF0cKqMDVLZryNfJUpEcrnLwwE1Xegroh0eX2evL5ABrzA94eYrQjF6d
         OsqKMUJ+tUkcY67QnzRLiWMaCk65hFTQCwWFnqNtXWPeS1s2jvQrROsiQ1Pe/JfW3ndB
         LElMdTdUPJNsdEV2qqVLFF5dFIr4963uaTmurNzC8bhuXZ+1YfHO81+pSQQlGt4v2Pwl
         e27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=RaFX0tFkQogY542EMTcNJHMix5aBURAyvK0LWD31b1o=;
        b=BTvU9RwjrtNscQ3w44aZa11WW0df4AZIeBk0ZJNom2ayeP1Eu7auUUIYxY7KLHT7LJ
         Ha7/6bP2+0/i0tKzS5g9gjWIP9QcYtqzBPR7RE97ao7QhuUez9HIX3kihBKmD7zuoEaf
         w35HdIa/0sv8+aOWV+eNXcbAOl4VLfDClx/vic3V50+Gf35n7P5oaCIOVqWxabR+piWF
         P9BNPwXEeD/+B2VAcqGpyKMcX7rKnEwHB8uCCl+j1adhaF0sj9briEg55mpgl/o1dM1e
         ldShfTXGFV3Sx/L/U/Qvng/q62nFbUCfFCQpTY9bPnpZf74MuPX/KvyZ9//sH6AahOG/
         UGPA==
X-Gm-Message-State: AOAM533Y3dUZklVavWG0S0l992IJzzXIys1xHDgTeXfsvvlLZGeJcAdv
        HSMyXYXyDPa5UXAV3aHHDOc=
X-Google-Smtp-Source: ABdhPJxMTsO6JdxJ0fKT/xD7TwxcL9KRjJzQepGR84iblrGRt0viOGIzERalR98O2RJz1A1IDw0SAw==
X-Received: by 2002:a05:6402:42d2:: with SMTP id i18mr15928000edc.168.1626291606830;
        Wed, 14 Jul 2021 12:40:06 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id b12sm1441471edu.30.2021.07.14.12.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 12:40:06 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Taylor Blau <ttaylorr@github.com>, Sun Chao <16657101987@163.com>,
        Sun Chao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] packfile: freshen the mtime of packfile by
 configuration
Date:   Wed, 14 Jul 2021 21:32:26 +0200
References: <pull.1043.git.git.1625943685565.gitgitgadget@gmail.com>
        <pull.1043.v2.git.git.1626226114067.gitgitgadget@gmail.com>
        <87wnpt1wwc.fsf@evledraar.gmail.com> <YO5RZ0Wix/K5q53Z@nand.local>
        <ACE7ECBE-0D7A-4FB8-B4F9-F9E32BE2234C@163.com>
        <YO8XrOChAtxhpuxS@nand.local> <877dhs20x3.fsf@evledraar.gmail.com>
        <YO87ax2JpLndc5Ly@nand.local>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YO87ax2JpLndc5Ly@nand.local>
Message-ID: <87y2a8zntw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 14 2021, Taylor Blau wrote:

> On Wed, Jul 14, 2021 at 08:19:15PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> >> The reason why we want to avoid freshen the mtime of ".pack" file is =
to
>> >> improve the reading speed of Git Servers.
>> >
>> > That's surprising behavior to me. Are you saying that calling utime(2)
>> > causes the *page* cache to be invalidated and that most reads are
>> > cache-misses lowering overall IOPS?
>>
>> I think you may be right narrowly, but wrong in this context :)
>>
>> I.e. my understanding of this problem is that they have some incremental
>> backup job, e.g. rsync without --checksum (not that doing that would
>> help, chicken & egg issue)..
>
> Ah, thanks for explaining. That's helpful, and changes my thinking.
>
> Ideally, Sun would be able to use --checksum (if they are using rsync)
> or some equivalent (if they are not). In other words, this seems like a
> problem that Git shouldn't be bending over backwards for.

Even with my strong opinions about rsync being bad for this use-case, in
practice it does work for a lot of people, e.g. with nightly jobs
etc. Not everyone's repository is insanely busy, where I've mainly seen
this sort of corruption.

In that case making people use --checksum is borderline inhumane :)

> But if that isn't possible, then I find introducing a new file to
> redefine the pack's mtime just to accommodate a backup system that
> doesn't know better to be a poor justification for adding this
> complexity. Especially since we agree that rsync-ing live Git
> repositories is a bad idea in the first place ;).
>
> If it were me, I would probably stop here and avoid pursuing this
> further. But an OK middle ground might be core.freshenPackfiles=3D<bool>
> to indicate whether or not packs can be freshened, or the objects
> contained within them should just be rewritten loose.
>
> Sun could then set this configuration to "false", implying:
>
>   - That they would have more random loose objects, leading to some
>     redundant work by their backup system.
>   - But they wouldn't have to resync their huge packfiles.
>
> ...and we wouldn't have to introduce any new formats/file types to do
> it. To me, that seems like a net-positive outcome.

This approach is getting quite close to my core.checkCollisions patch,
to the point of perhaps being indistinguishable in practice:
https://lore.kernel.org/git/20181028225023.26427-5-avarab@gmail.com/

I.e. if you're happy to re-write out duplicate objects then you're going
to be ignoring the collision check and don't need to do it. It's not the
same in that you might skip writing objects you know are reachable, and
with the collisions check off and not-so-thin packs you will/might get
more redundancy than you asked for.

But in practice with modern clients mostly/entirely sending you just the
things you need in the common case it might be close enough.

I mean it addresses the expiry race that a unreachable-becomes-reachable
again race would be "solved" by just re-writing that data, hrm, but
there's probably aspects of that race I'm not considering.

Anyway, in the sense that for a lot of systems syncing file additions is
a lot cheaper than rewrites it might get you what you want...
