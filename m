Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6F5C433F5
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 19:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhL2TwF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 14:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhL2TwE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 14:52:04 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A967C061574
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 11:52:04 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id m21so91272788edc.0
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 11:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=82Dr4yA68jlKeNzp4hQoiJmIeZzsA/x1c9gkFIgOsM4=;
        b=Pus03v1hnPkREsDFuMHmGclckMKJvpjZSkPpvRx1Ymhu1/gErGk6nuE4e67RGBJSrK
         QFtVRs2Yuw0zES/gkThJ5lC0wrfZimn8UkT91LuxSiDXC+gymn+Ug5/jR1VTJytTusQd
         Wy8611al3gRzYaWqs3a7VpmSDpiNsV2CH98TwNnjqujURmfZMoYLXq19qrVOnQ+j6r+d
         xBNvUtFCo1SSRz28YtHE5/o8ekdjxI9iGxkG4qRVBwy6EBVej2T4xyn0ma59DZaJRQNA
         rMra6Sfjxjvo9XTswnGCvbo+d4yXlWxAcDKQb3oAAhYsfAMLw0XFkgMk0TCvAN5kC1Jo
         fDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=82Dr4yA68jlKeNzp4hQoiJmIeZzsA/x1c9gkFIgOsM4=;
        b=GJAPVdrWMNo4s7oPcOpyfPPbFc1XYTzVMw9PA37MiVoztJSsNIzh2uEwhYf0fv2ZW6
         SFJ+xuXSDdTry3g/f4AcAWvX7H65kX6EX3vZel3hpb65GmAQNIyFOMaGllQew2bKcGvz
         CCjfrJcXy2eFJXFbg43u57r0YF3spvpu6NTLaBOd9RQkqvlGSR4cx1d2qmZwnJL0L8es
         BbQocp8iVjbIau61U/axZ/FeLa0mpTu80mgfL5vo1aLerqB1YYaVHG8ROQXIzREcY97e
         q/iVMOvoyCNBNGFVVVDTzEbQ04YUGJQTDeOszcZFD+fwGlI6ZiR4OtNh+52INTepUTKn
         E5SQ==
X-Gm-Message-State: AOAM531PHgrcEE3ndsnyb4VnMGhyCHZTyFEryFHRzM8CMsIcuRphEoEG
        l/Z/G53Nr0mHMd6E1dUFuIAHcbsuNaqwqn6gPhs=
X-Google-Smtp-Source: ABdhPJz3xLU/d3iBRHyHX1g5ywFKFBVVjKMcPIz3aoj9QCC4CriU2rJHxj+PveTI0DMCEdkqQNz5IVoiSn3vDq0yp7U=
X-Received: by 2002:a17:906:4790:: with SMTP id cw16mr22206065ejc.493.1640807522616;
 Wed, 29 Dec 2021 11:52:02 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
 <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com> <fcece09546cbdb5f1bcd0d0c5aaa3a54e9d3b852.1640727143.git.gitgitgadget@gmail.com>
 <CAPig+cSUOknNC9GMyPvAqdBU0r1MVgvSpvgpSpXUmBm67HO7PQ@mail.gmail.com> <e2ef25b5-9802-1dd9-b96c-ea85d2082b48@gmail.com>
In-Reply-To: <e2ef25b5-9802-1dd9-b96c-ea85d2082b48@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 29 Dec 2021 11:51:51 -0800
Message-ID: <CABPp-BE9umOTkjfnB0X+9nTZaBmeXd4z5DmiZ1Upzds=m1spPw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] worktree: copy sparse-checkout patterns and config
 on add
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
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

On Wed, Dec 29, 2021 at 9:31 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 12/29/2021 1:37 AM, Eric Sunshine wrote:
> > On Tue, Dec 28, 2021 at 4:32 PM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:

> > The obvious way to work around this problem is to (again) special-case
> > `core.bare` and `core.worktree` to remove them when copying the
> > worktree-specific configuration. Whether or not that is the best
> > solution or even desirable is a different question. (I haven't thought
> > it through enough to have an opinion.)
>
> It makes sense to special case these two settings since we want to
> allow creating a working worktree from a bare repo, even if it has
> worktree config stating that it is bare.

Agreed.

> As far as the implementation goes, we could do the copy and then
> unset those two values in the new file. That's an easy enough change.

> I'll wait for more feedback on the overall ideas (and names of things
> like the init-worktree-config subcommand).

What value does the init-worktree-config subcommand provide; why
shouldn't we just get rid of it?

I know Eric was strongly suggesting it, but he was thinking in terms
of always doing that full switchover step, or never doing it.  Both
extremes had the potential to cause user-visible bugs, and thus he
suggested providing a command to allow users to pick their poison.  I
provided a suggestion avoiding both extremes that doesn't have that
pick-your-poison approach, so I don't see why forcing users into this
extra step makes any sense.

But perhaps I missed something.  Is there a usecase for users to
explicitly use this?
