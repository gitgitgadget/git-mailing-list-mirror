Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0BFC433FE
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 08:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbhL3IBh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 03:01:37 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:37552 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbhL3IBf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 03:01:35 -0500
Received: by mail-pl1-f175.google.com with SMTP id j13so17742652plx.4
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 00:01:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5OQI1Ns61SpEo0os9ANrVqSSEcwb5vB5LlkC7VgqWq0=;
        b=5vl9Mv0bzhh98ripUnwVPxukLtj5xw0LDBOYoG7glqSKI+RRKKU33dr2o+PzVbHROG
         xsgGYoyz1g5Kf7e98uQoYIcz7TDDpSlga21nUXGnRxUV4I9Jcdw8cY/PuGJG/9Lz7Yzw
         Mue3ymp7JYbLy2Ajh5/dSHYhYKeGWtRtNelx3sCzjDk0Hx5s+z0e9rGe9Iw3jMCc5QTu
         S27+l83gHDSgn5TlOcqG7aDit7+/N2aziboYWwvoK7vRDucx8If7xfwUQg6Ld++Pta+3
         gtYjwNRLebMmDAUlqXHhZdxy9s7JGOT5SxXXDnS4SilarpMbOy4dmC6BKigWMsaVx3P7
         hXxA==
X-Gm-Message-State: AOAM531Jh55nG1LxsK3KYqXEpJoCpxdMNhKplDFbfbV/F1QzOGOqSFi/
        YdaxGuVWUhW9v1Adpzbn2XK7NfZfsMMxr4kcdhY=
X-Google-Smtp-Source: ABdhPJzAjOPOunkzasM5o5eaNjEANOl41rR6kkxv+LGAKNEyLJcEl+ch32/SEq3N8k7ZzaQ8TW0CHZuqi3UvrIdMdUM=
X-Received: by 2002:a17:90b:783:: with SMTP id l3mr36498761pjz.104.1640851295409;
 Thu, 30 Dec 2021 00:01:35 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
 <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com> <fcece09546cbdb5f1bcd0d0c5aaa3a54e9d3b852.1640727143.git.gitgitgadget@gmail.com>
 <CAPig+cSUOknNC9GMyPvAqdBU0r1MVgvSpvgpSpXUmBm67HO7PQ@mail.gmail.com>
 <e2ef25b5-9802-1dd9-b96c-ea85d2082b48@gmail.com> <CABPp-BE9umOTkjfnB0X+9nTZaBmeXd4z5DmiZ1Upzds=m1spPw@mail.gmail.com>
In-Reply-To: <CABPp-BE9umOTkjfnB0X+9nTZaBmeXd4z5DmiZ1Upzds=m1spPw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 30 Dec 2021 03:01:24 -0500
Message-ID: <CAPig+cSEbiLJ1yCCv_hsoWVgpXE13B9-UwWzi7jhWq4NgYc0Nw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] worktree: copy sparse-checkout patterns and config
 on add
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 29, 2021 at 2:52 PM Elijah Newren <newren@gmail.com> wrote:
> On Wed, Dec 29, 2021 at 9:31 AM Derrick Stolee <stolee@gmail.com> wrote:
> > I'll wait for more feedback on the overall ideas (and names of things
> > like the init-worktree-config subcommand).
>
> What value does the init-worktree-config subcommand provide; why
> shouldn't we just get rid of it?
>
> I know Eric was strongly suggesting it, but he was thinking in terms
> of always doing that full switchover step, or never doing it.  Both
> extremes had the potential to cause user-visible bugs, and thus he
> suggested providing a command to allow users to pick their poison.  I
> provided a suggestion avoiding both extremes that doesn't have that
> pick-your-poison approach, so I don't see why forcing users into this
> extra step makes any sense.

Right. The minimally invasive, minimally dangerous approach you
outlined at the very bottom of [1] obviates the need for
`init-worktree-config`. We still want the underlying function for `git
worktree add` to call, but a user-facing command providing the same
functionality becomes much less meaningful since enabling per-worktree
configuration involves no more than simply setting
`extension.worktreeConfig=true` in all cases.

So, I can't think of any reason to add `init-worktree-config`
presently (if ever).

[1]: https://lore.kernel.org/git/CABPp-BHuO3B366uJuODMQo-y449p8cAMVn0g2MTcO5di3Xa7Zg@mail.gmail.com/
