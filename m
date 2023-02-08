Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D297FC05027
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 03:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjBHDeD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 22:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjBHDeB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 22:34:01 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E082558C
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 19:33:59 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bi36so25291111lfb.8
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 19:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4ilqt0DIp77pq4xBZSXUYSIA4vnl5HsYddkiVSLlmX0=;
        b=HsMNzr6LClnNwAAEgnocnFF9h2FY0OXHB2QR3D01mPj12AY0tIUZgp3TryZUdshENR
         Z4kTzcnXG3u7L2+E1rRXXoK7nVJmzQAwoual+NOZT16pA+/gC7EOYiCEWEqNWgNAPDkD
         5NxJ3gXxc31BpjiHIF4NkYnNldJwpzBd1UuNHbmdOliN4daUd4tQhQxwBi4WighpuuMT
         2puZapP3uWDguTFPimkpsr/DrgqzNfWOGC6UqbzZlgv6SsYoP983ivNsc0hfitzMjLKv
         QT4Be8jmw9XvWlLi9JmSj4QKlIL9YSzGOUdadt2df8umW3tiksXJTDHABz0JXhXLvXLY
         UNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ilqt0DIp77pq4xBZSXUYSIA4vnl5HsYddkiVSLlmX0=;
        b=t/MxdjRitolRS/XoKiXXhwyEYs69LWxHdKNUM7d6+Vk4qH/s7FnYJ1MBCVHUWzdLhy
         BB5Ho/KKtqMhJ+j7GNgLBAxbnVJXWXjBfh+GCqCT8+ASzsxF1GHTTQONsE2ZjwaCr8EH
         XVb0vFaWks0g4/s5kfgS/q/dIPryH1cJCwM4l9rZw+tZ6slHxeomzN+BbqwPurfOnlOK
         50KV1wnBR6lSws4hd4KYQNA7UOYsHlaFzIVOyChNurxLG559sXBBA39DpgecUyHF8kvq
         CM9bLWYsRmMlj3ThxtGSIgBtZSdhIKKJi/UnjhqwB/xo+4B+zPgJ0qPFXV2tDTr6KdMX
         gndw==
X-Gm-Message-State: AO0yUKV1QQPA997Xt+IuLKcdmWnlP5UsjjGJpjb/59DDmSsL6V/WsH2e
        pYU8xlosivX9zQpZZV9r2KAqW7Fighu1y2O3+vQ=
X-Google-Smtp-Source: AK7set+7yMQhNAY9RcDTyp2EnL37wqM+v5nb0ZYOleW/VnAJiLCGH1OCdkcbbc2CPZCrUMGdVfAvXi+D/f4eyfTm118=
X-Received: by 2002:ac2:4255:0:b0:4d1:3e32:6417 with SMTP id
 m21-20020ac24255000000b004d13e326417mr1030541lfl.61.1675827237163; Tue, 07
 Feb 2023 19:33:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.1468.v2.git.1675751527365.gitgitgadget@gmail.com> <20230207193407.394971-1-calvinwan@google.com>
In-Reply-To: <20230207193407.394971-1-calvinwan@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 7 Feb 2023 19:33:45 -0800
Message-ID: <CABPp-BHbqQtws3cg4-udC4XixeFk+BTp43xA48G-ok9tfcZcVg@mail.gmail.com>
Subject: Re: [PATCH v2] name-rev: fix names by dropping taggerdate workaround
To:     Calvin Wan <calvinwan@google.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 7, 2023 at 11:34 AM Calvin Wan <calvinwan@google.com> wrote:
>
> Are there any cases where a taggerdate heuristic would be useful now?
> I'm having a hard time coming up with an example of such, so this
> change looks very reasonable to me. Even if there existed such a case,
> I would imagine it would be better solved using other heuristics rather
> than checking the taggerdate since that was a very loose heuristic to
> begin with.

I'm currently only aware of cases where the heuristic hurts and none
where it helps.  I know it historically helped, but that was just a
workaround to the algorithm being suboptimal.  Since the algorithm has
been fixed, I think the workaround can be shelved.

> > diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> > index 15535e914a6..df50abcdeb9 100644
> > --- a/builtin/name-rev.c
> > +++ b/builtin/name-rev.c
> > @@ -113,9 +113,7 @@ static int is_better_name(struct rev_name *name,
> >        * based on the older tag, even if it is farther away.
> >        */
> >       if (from_tag && name->from_tag)
> > -             return (name->taggerdate > taggerdate ||
> > -                     (name->taggerdate == taggerdate &&
> > -                      name_distance > new_distance));
> > +             return name_distance > new_distance;
>
> Comment above this block should be updated to match the new logic.

Good catch; will fix.
