Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA423C433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 01:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD7A360EFF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 01:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhJTBlN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 21:41:13 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:42802 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhJTBlM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 21:41:12 -0400
Received: by mail-ed1-f53.google.com with SMTP id t16so19931576eds.9
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 18:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7AIOdNiGtysnGP2CPGtUNLk1w693ejQ8Hxo/U0Ms0eI=;
        b=LFnqNI9YTQ65fbYoHPjVSGmA1U7ZFuY20I0skQdvvzQiv14F403LaSffG1gVtDzAzB
         C+M3JhniKwUPGmOw9j4koN1+vAIVYegUwJSATNB/wyZvIX+ZUP0xdDcxcaH9Mx3yxuRH
         ynDC9ZdEi7tAe9WYdAg/tAsxV/UtwHlysvHT/0duQHtZuuouRBJeQy1p8AA4Vi+8BqPT
         O+r3zCNx5XT8bLKZyl7M/Xbu54n1n//jMJF9+S/o8Uo2Sn4qe2fD1111Je+poT+ipiqp
         TjqPt52KxrOHimvDQo37TDOxDQHVJNBvusPHqMwp81VsRSK8CDLK1Id3bsoSJCHr3NW7
         0YNw==
X-Gm-Message-State: AOAM531Krxr+AYV7ue5moeSZhiam9axQLTH/R8MTSRGDITABP4jT+/1X
        tJ39kKAf6W5M4vfYB10yA/Mg3AZx9dHeFFJHGDI=
X-Google-Smtp-Source: ABdhPJxJqayA8H8jENGSsgJBt0KHK1ORmE30Rzex/Jjd1+9CWEKIwADUc/IUsfR231HqN5x27G8QV2u+ewDcd9TQZQo=
X-Received: by 2002:a50:e0c3:: with SMTP id j3mr57892285edl.97.1634693938339;
 Tue, 19 Oct 2021 18:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <20211020010624.675562-1-sandals@crustytoothpaste.net> <20211020010624.675562-6-sandals@crustytoothpaste.net>
In-Reply-To: <20211020010624.675562-6-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 19 Oct 2021 21:38:47 -0400
Message-ID: <CAPig+cR=wQYthORMfyf4ShBCTXyWkQJqH6YHuW4Uv-Ys3wef5g@mail.gmail.com>
Subject: Re: [PATCH 4/4] gitfaq: add entry about syncing working trees
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 19, 2021 at 9:06 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> gitfaq: add entry about syncing working trees

You sent two [4/4] patches. I'm guessing the one prefixed by "gitfaq:"
is the correct one.

> Users very commonly want to sync their working tree across machines,
> often to carry across in-progress work or stashes.  Despite this not
> being a recommended approach, users want to do it and are not dissuaded
> by suggestions not to, so let's recommend a sensible technique.
> [...]
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> @@ -185,6 +185,45 @@ Then, you can adjust your push URL to use `git@example_author` or
> +[[sync-working-tree]]
> +How do I sync a working tree across systems?::
> +       First, decide whether you want to do this at all.  Git usually works better
> +       when you push or pull your work using the typical `git push` and `git fetch`
> +       commands and isn't designed to share a working tree across systems.  Doing so
> +       can cause `git status` to need to re-read every file in the working tree.
> +       Additionally, Git's security model does not permit sharing a working tree
> +       across untrusted users, so it is only safe to sync a working tree if it will
> +       only be used by a single user across all machines.
> ++
> +Therefore, it's better to push your work to either the other system or a central
> +server using the normal push and pull mechanism.  However, this doesn't always
> +preserve important data, like stashes, so some people prefer to share a working
> +tree across systems.
> ++
> +It is important not to use a cloud syncing service to sync any portion of a Git
> +repository, since this can cause corruption, such as missing objects, changed
> +or added files, broken refs, and a wide variety of other corruption.  These
> +services tend to sync file by file and don't understand the structure of a Git
> +repository.  This is especially bad if they sync the repository in the middle of
> +it being updated, since that is very likely to cause incomplete or partial
> +updates and therefore data loss.
> ++
> +The recommended approach is to use `rsync -a --delete-after` (ideally with an
> +encrypted connection such as with `ssh`) on the root of repository.  You should
> +ensure several things when you do this:
> [...]
> +Be aware that even with these recommendations, syncing in this way is
> +potentially risky since it bypasses Git's normal integrity checking for
> +repositories, so having backups is advised.

Considering the potential damage which can result from this sort of
synching, this entire section seems too gentle. My knee-jerk reaction
is that it would be better to strongly dissuade upfront rather than
saying that it's okay to do this if you really want to. As such, I'm
wondering if organizing the section like this would be better:

(1) Make a strong statement against doing this: "<strong>Don't do it.</strong>"

(2) Explain why users shouldn't do it; in particular, the final
paragraph above which talks about integrity checks and whatnot should
be right up near the top along with discussion of corruption.

(3) Say that cloud-synching services must _not_ be used and explain why.

(4) Relent a tiny bit and explain that the only slightly acceptable
mechanism is `rsync` when used in a very strict fashion (quiescent
repository, etc.)
