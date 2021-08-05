Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980F1C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 14:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 771936113B
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 14:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241816AbhHEOAW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 10:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238069AbhHEOAV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 10:00:21 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1C9C061765
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 07:00:07 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id d22so6813093ioy.11
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 07:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cdCvHXzSdcYc4+/NqeKABybd9/kt9NeX26siUpayaSA=;
        b=bEwsUc+3F7XOdKdLqgo7/eQek3uImArHxCgi8bIUl6cnDoD3QSsvFyBLfVUb1+JhQV
         ofQnMigDaIulHkMJHP1PylYB3NxbfbXdXclDaY1Um0tyCTDgwseDjpFDhDrUks5QUTtt
         B9KbJ3ONDp4WehK3MCVgD9xvvIJd+lS2PXdm+jxAMN3fVQoq6wdCYwsK5MDWgnfqb2Vt
         phCUL9ScpKzFQd/qJ9oy7KvznA4gkTHHaT72pHp/P92UpHn5ZmxGx0accsOxw3ajMp9v
         XXPxl5d7ehL5cse5OdTwvgwEilmidM75cPY+OH31JAuSC/aWZ7nCIPwAkmQ/GGDHt8Ph
         aEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cdCvHXzSdcYc4+/NqeKABybd9/kt9NeX26siUpayaSA=;
        b=XyB23ZeDusz4qNmi9PLqaRudXCLfQEL0GLJuAZ28H1VW7RP70IO9Xjr/9bOhthq3Hj
         h5ECr+QzISPXLVHvc+3aJn7wdiFCmTild/p4qr7zT4hIXy8be6TQyyKctFwcgFXYYjhy
         ab78JHHxA8MRlA7DeifuG3IL+kGEeJVZWW7tF5s9NK7xLERKxqxt8DEMSYFvFQqMpN+/
         MPfmIx/4/JOMxjLC4J1UmViyBQ6Iu1Fh16LY3AXalnwpaEWLHpXJ/NIO7PvEJCXGhbCi
         co7k/costyvQE5QcrTFcokjQAWajvUpxhGQO5xswLTozEfBmWCWVKAaoOoNuaRgCbt9n
         dgdA==
X-Gm-Message-State: AOAM531fPf4KWt81juZXq4JyhSVJig5CZwNWJG65HZx5IO6RHOMfAxm7
        K9a8cIgQXy3EgqTUtHo96vFCkDXgzB8Fd/j3Ryk=
X-Google-Smtp-Source: ABdhPJzhOKSYGXC/wueFIZsLHbS0rulp8V6P5pyjA0kZs2otAay+vxtDTadJzk+mSkaV2jIzp/5JgVdATK923AdmGfI=
X-Received: by 2002:a6b:6319:: with SMTP id p25mr1152355iog.100.1628172004299;
 Thu, 05 Aug 2021 07:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <CANt7McFAu5gAFcgd+dejQjDQDxfcnyhz=BxSAejXGMMtGQzO_w@mail.gmail.com>
 <YPHgUuxqmKFkbEku@camp.crustytoothpaste.net> <CANt7McHrYhSe3JsS8UKX8NgsUajwxQY4h9KTtXkEXdd0Be_+yw@mail.gmail.com>
 <46F5B91F-4DBE-4F34-9395-7CC808FAC359@gmail.com>
In-Reply-To: <46F5B91F-4DBE-4F34-9395-7CC808FAC359@gmail.com>
From:   Rostislav Krasny <rosti.bsd@gmail.com>
Date:   Thu, 5 Aug 2021 16:59:54 +0300
Message-ID: <CANt7McE4N0wv5bik8tSNrdTs-mcL20cJPMP42iPtZqhUpKgirA@mail.gmail.com>
Subject: Re: Why do submodules detach HEAD? (was Re: Incorrect and
 inconsistent End-Of-Line characters in .gitmodules ...)
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 21, 2021 at 10:26 AM Atharva Raykar <raykar.ath@gmail.com> wrote:
> The default mode for the update command is to checkout to the
> revision that the parent project expects the submodule to be in, ie,
> it checks out to the commit hash directly, and detaches the HEAD.
>
> Why not checkout to a branch? This is because branches may change
> which commits they point to.
>
> For example, if you had a submodule 'foo'. I go into the 'foo'
> folder and amend the last commit.
>
> Now if I run 'submodule update' in the parent repository. If it had
> checked out to the branch instead of the revision, I would be on a
> different commit in 'foo' than the one that was registered by the
> parent repo!
>
> We want to have idempotence, ie, for a particular revision that is
> registered by our parent project, we want 'update' to give the same
> outcome every time, and not be dependent on whatever the state of the
> branch is. This way we ensure that for a particular commit in the
> parent project, the submodules will be in the same state for every
> system in the world, after an 'update' is run.

All this is ok, but there could be other uses of sub-modules. Why not
to make this behavior configurable?

As a developer I may want to make new commits on those sub-modules and
always work with latest versions of their particular branches. In the
detached HEAD mode this is much harder to be done and also an error
prone operation. Commits that are done in the detached HEAD state may
easily be lost. Google is full of questions about how this could be
done, i.e. there is an essential demand of such a new behavior.
