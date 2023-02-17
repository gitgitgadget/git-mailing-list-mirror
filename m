Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3F2C6379F
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 11:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjBQLP4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 06:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjBQLPt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 06:15:49 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98556537B
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 03:15:32 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id cn2so2965030edb.4
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 03:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W3nYijoikr5U8Zv57UKIa+d/J99djdwh7PzI/k+hDjE=;
        b=F+EYsCqqn0FLQqtKT+Rflf4IxgIKXtg3clLagzMyoSv2z8fqTK8JIPaYPB9DSv0WAr
         Nb7UH+oIgtSoQlJFpDMT7uBuSVPBbpydhGVRDSqBQ6E5NO1LTLNhumKtVxAFk+HX2nnC
         t2RkjjVsa8cuVOQD4+CZAbKyrFnLzKR5poRKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W3nYijoikr5U8Zv57UKIa+d/J99djdwh7PzI/k+hDjE=;
        b=iPXjqAYwoI8bB4m3lTvGbAMHikoobZ5ivFwcE7XhyoqnJ/dT17kG2hth56B3pLAbIm
         cMjHwvYEEVoYbOd2eAPkE8JLTC5TWWy8BMcqIZJsxqTzLznHBHfj0TGiLwjRHmyKjzg4
         kAxne9be2mL3Y0FMkdLgNNQ5r/NkZ+o3FpnjALwtwtMygWcrB3JNMVPObEwCrW6nTbNN
         Y4PVycpJAos8hGQScDDyRSRySQZJV1uHCXU0tG/NwIWcRuqiWmamh0/7aG75hdmakfY7
         rlJ5olPYf9qbWP0c+k1bULESg8qHBgxQ6rqbAEfCJmTaAMf1UKULZxzUOJZIbPXCTkTO
         rdaA==
X-Gm-Message-State: AO0yUKW5rPbwAyidl+mN7APEJ+drewJTrF8CAI54sQuMhMPq+qk+nKOE
        KIQ4ZWq8BBORvEJmODKyAjsrrdyErELTX6U2sIfSefGIZxRsGHuLIHo=
X-Google-Smtp-Source: AK7set+VbgVQ3JIlKO7+duxpam6qNCRnxIBuHGxeUN1cBTX83P9LUB78xxok9hk8BVW2c6puz/BW7xv34noNgFBpO20=
X-Received: by 2002:a50:d0d4:0:b0:4ab:44de:76ef with SMTP id
 g20-20020a50d0d4000000b004ab44de76efmr348546edf.0.1676632531367; Fri, 17 Feb
 2023 03:15:31 -0800 (PST)
MIME-Version: 1.0
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
 <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
 <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com> <CAMMLpeTQ1RpsvwRdZ0G3wdvH1+LXE5tw=7Cs6Q+HxMcRU0qj5Q@mail.gmail.com>
In-Reply-To: <CAMMLpeTQ1RpsvwRdZ0G3wdvH1+LXE5tw=7Cs6Q+HxMcRU0qj5Q@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Fri, 17 Feb 2023 12:15:19 +0100
Message-ID: <CAPMMpoj0Ts=c=Wq1eghjJ75HVyy5ZyKjL3o9=AB8SDb5Wf99mw@mail.gmail.com>
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2023 at 4:15 AM Alex Henrie <alexhenrie24@gmail.com> wrote:
>
> I would be OK with the proposed patch if it were part
> of a larger effort to make --rebase-merges the default behavior of
> `git rebase`.

Heh, what would it take to convince you there is such an effort? :) -
sparse and minor as my contributions are, I certainly believe that is
a "natural" effort that I will do what I can to support.

> That seems like an achievable goal, and I don't think it
> would take multiple years, maybe one year at the most.

My estimate is based on the observation that there are still, several
years after --rebase-merges was introduced, git GUIs that don't handle
it right - eg Jetbrains IDEA:
https://youtrack.jetbrains.com/issue/IDEA-232160/Rebase-merges-is-not-properly-supported

This kind of functionality change should be slow, not because it's a
huge amount of work, but more because it takes time for the entire
ecosystem to adapt. Git releases basically-monthly, but many of the
systems that users use git with release far less often; similarly,
it's helpful to users who use a mix of current and older systems (I'm
looking at you, CentOS 7) for the introduction and recommendation of a
behavior change to come *long* before its defaulting.

> The process
> would look something like this:
>
> 1. Add a --no-rebase-merges option to `git rebase`.
>
> 2. Add a rebase.merges config option.

Yes and yes! I alluded to this in
https://lore.kernel.org/git/CAPMMpoj6E-85a59EaHD2aR_oKA=_u78qRV+wp8mqXkR39KctmA@mail.gmail.com/
but didn't feel I'd likely to make a solid change along these lines.

>
> 3. Add a warning to `git rebase` that appears if rebase.merges is
> unset and neither --rebase-merges nor --no-rebase-merges is given. The
> warning would advise the user that the default behavior of `git
> rebase` will change in a future release and suggest setting
> rebase.merges=no-rebase-cousins to get the new behavior now.
>

Makes sense to me!

> 4. Change the `git pull` advice to recommend --rebase=merges and
> pull.rebase=merges.
>

I'm not sure why this would be step 4 - I would (and did try to) make
it step 1 :)

> 5. Wait a couple of releases.
>

As I noted above, I believe it should be far more than a couple.

> 6. Change the default behavior of `git rebase` to `git rebase
> --rebase-merges` and the default behavior of `git pull --rebase` to
> `git pull --rebase=merges`. At the same time, remove the warning from
> `git rebase`. The old `git pull` behavior would still be available as
> `git pull --rebase=true`.
>

Makes sense to me!

> 7. Change the `git pull` advice to recommend the short and simple
> --rebase option again (leaving the recommendation of
> pull.rebase=merges for the config option).
>
> Does that sound reasonable? I think I could lend a hand with steps 1-3.
>

I'm sold, except insofar as I think the right approach is to move step
4 to be the first :)
