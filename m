Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D761C433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 21:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbiBUVKz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 16:10:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbiBUVKy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 16:10:54 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FCF23BE3
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 13:10:29 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id lw4so36348536ejb.12
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 13:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eIjDEoF3ih/anlsGNcrHv0099P1h5luyGdZmo0Cad0c=;
        b=Dl6VQAt+eJfv3vXO5P++gNHAYX4AH/XRXq5oP302M3gLa3uNoUnjzwEb+YsGZlBsj0
         3RQCfmXM9LVNI561GGUdUIMQ/JIufUnmQQCyGYjwQNpU60qROnMLxFsWW/haeA9vG9/w
         /q28WmTgPpLtpGlDc4+2pwohHP6/aWssGm/y/9uXpYorRL9q8OktoURanD9YSo+pjdAo
         I8V+ThttAGAfiqk6cRvDLUuJlv6pMaSuQVQwlsdJXULzFxdAIF45hdMzqSGG/M6IwknX
         /wyNnlWp0iLPdIyAmKaOLMrzAMIvoQWnez/wy3edZjz2ltI5G0IjkImzhXbySAA42lLw
         69lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eIjDEoF3ih/anlsGNcrHv0099P1h5luyGdZmo0Cad0c=;
        b=0tKtE1ISdh694d+jTb9B0F9nLjoz18Cvl3CMqh+AkBb2wxzxYHNAKqus72bI7Gyz9H
         yaOvCRsOfrpefJCtJ6onEO7NoGf7m0L0YAURbQ0nbhOCZNVJHpBCvjLE0Zjo7VwxKgV0
         ZSomTGtPY6+siVbiPPgBQWpEmnOwSe0A2lGzLxA6m2nG0+R41viKw7Sb7a5IEfoGG6mH
         AzNvfzycFS4fvK4769Mn5VGYytObtSxhTupJzV1S6ua9HTJ5YzabUkLyLwMnWPW/CjNS
         TPszaQZJatOgFq0UyyYRfT5dsGArx/SvC6jFSHAAIX7MLu1uWVO2QNrQS/JfM/hb6uv7
         5RDA==
X-Gm-Message-State: AOAM530IgNoW3O4YF08RC8mOk1IN3qk5TV0kn6csLR1NN+Ia4XYMwGee
        HLHMO0k9OpogXYnZYPopYfrOCb29n/gnNnL6s+6GK2qIBKo=
X-Google-Smtp-Source: ABdhPJyQjIp6JWRsMqd2RwAlyPlTYr++qMbOV8GsTY+wpSmK8a7Lkrprecl2L01mk6fHZc4LGt0AAUojoN+nzFgtODA=
X-Received: by 2002:a17:907:29d7:b0:6cd:19bc:2857 with SMTP id
 ev23-20020a17090729d700b006cd19bc2857mr17391073ejc.159.1645477828042; Mon, 21
 Feb 2022 13:10:28 -0800 (PST)
MIME-Version: 1.0
References: <pull.1206.git.git.1643248180.gitgitgadget@gmail.com>
 <pull.1206.v2.git.git.1644372606.gitgitgadget@gmail.com> <CAFLLRpJ1aDyLb4qAoQwYDyGdP1_PH8kzLAQCKJpQwiYiapZ5Aw@mail.gmail.com>
 <CB2ACEF7-76A9-4253-AD43-7BC842F9576D@gmail.com> <YhMC+3FdSEZz22qX@nand.local>
In-Reply-To: <YhMC+3FdSEZz22qX@nand.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 21 Feb 2022 22:10:15 +0100
Message-ID: <CAP8UFD2dpicW64eqBK47g43xDWA1qv2BMBEOSqj_My5PUs8TSg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] [RFC] repack: add --filter=
To:     Taylor Blau <me@ttaylorr.com>
Cc:     John Cai <johncai86@gmail.com>,
        Robert Coup <robert.coup@koordinates.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 21, 2022 at 4:11 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Wed, Feb 16, 2022 at 04:07:14PM -0500, John Cai wrote:
> > > I don't know whether that is just around naming (--delete-filter /
> > > --drop-filter /
> > > --expire-filter ?), and/or making the documentation very explicit that
> > > this isn't so
> > > much "omitting certain objects from a packfile" as irretrievably
> > > deleting objects.
> >
> > Yeah, making the name very clear (I kind of like --delete-filter) would certainly help.

I am ok with making the name and doc very clear that it deletes
objects and they might be lost if they haven't been saved elsewhere
first.

> > Also, to have more protection we can either
> >
> > 1. add a config value that needs to be set to true for repack to remove
> > objects (repack.allowDestroyFilter).

I don't think it's of much value. We don't have such config values for
other possibly destructive operations.

> > 2. --filter is dry-run by default and prints out objects that would have been removed,
> > and it has to be combined with another flag --destroy in order for it to actually remove
> > objects from the odb.

I am not sure it's of much value either compared to naming it
--filter-destroy. It's likely to just make things more difficult for
users to understand.

> I share the same concern as Robert and Stolee do. But I think this issue
> goes deeper than just naming.
>
> Even if we called this `git repack --delete-filter` and only ran it with
> `--i-know-what-im-doing` flag, we would still be leaving repository
> corruption on the table, just making it marginally more difficult to
> achieve.

My opinion on this is that the promisor object mechanism assumes by
design that some objects are outside a repo, and that this repo
shouldn't care much about these objects possibly being corrupted.

It's the same for git LFS. As only a pointer file is stored in Git and
the real file is stored elsewhere, the Git repo doesn't care by design
about possible corruption of the real file.

I am not against a name and some docs that strongly state that users
should be very careful when using such a command, but otherwise I
think such a command is perfectly ok. We have other commands that by
design could lead to some objects or data being lost.

> I'm not familiar enough with the proposal to comment authoritatively,
> but it seems like we should be verifying that there is a promisor remote
> which promises any objects that we are about to filter out of the
> repository.

I think it could be a follow up mode that could be useful and safe,
but there should be no requirement for such a mode. In some cases you
know very much what you want and you don't want checks. For example if
you have taken proper care to transfer large objects to another
remote, you might just not need other possibly expansive checks.

[...]

> But as it stands right now, I worry that this feature is too easily
> misused and could result in unintended repository corruption.

Are you worrying about the UI or about what it does?

I am ok with improving the UI, but I think what it does is reasonable.

> I think verifying that that any objects we're about to delete exist
> somewhere should make this safer to use, though even then, I think we're
> still open to a TOCTOU race whereby the promisor has the objects when
> we're about to delete them (convincing Git that deleting those objects
> is OK to do) but gets rid of them after objects have been deleted from
> the local copy (leaving no copies of the object around).

Possible TOCTOU races are a good reason why something with no check is
perhaps a better goal for now.
