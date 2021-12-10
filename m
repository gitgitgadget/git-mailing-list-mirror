Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24000C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 07:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbhLJH5S (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbhLJH5S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 02:57:18 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F69C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 23:53:43 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id z8so12516228ljz.9
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 23:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Jh1CqFsrI/crwP35gLPP9k2bGNY41UuhpH2pP/PfN8=;
        b=i5k9ZfOW52aw9RNu39QK34rgrpkszOAMFcPk3mYmqgbFe7hdesTwCD6u0oSTDcFjJH
         ao6dQy1D9W+UuorFp/cpAJ/m+FRZOIrdd59JZtkN52IWlcUO8DeP6xBe3RugSuETLvaS
         y0JYs4ULbhqEWYc411rx9AnO/nzk25t4Z4LqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Jh1CqFsrI/crwP35gLPP9k2bGNY41UuhpH2pP/PfN8=;
        b=n1PQpEzvSt15xky28+FfrR/PDzJeW88qaZ4RG5rO+SHf7XmASxj8WGArj10LpI6s/z
         +uAyntqcOyW0JqHLz+1tgk7wybueDoK7u0zbbsxACW0t6qsKMFMmajjEY0OcIeWDR5NZ
         Fy4rhB5z6c2HYxBVIxJnxyxz8xklr+hGQ/0i14hc4Mp4G89iF0VYkaI7vWYNPk/atEGb
         VbZRjJH8H5hKBzGcGiihqyGUOsaMe1IrXrKN3T7/OpVvPOvt2HlapU8MF2LwYQsQfovS
         hLcvYBbcjO4Y2wpi5SVOZW8pnm5tUhsunWHVs4gA29q9uOJ0hzwFmOm5K4PQepfs9vzy
         aNqA==
X-Gm-Message-State: AOAM530U1RC/u7yb5g00V9R+Z31vW69H247vhOSGwF9bpVwP3Xfu58ZB
        7U3YTjnK45OfwglHTlG2fMigPf6n4Qk1FVewQKq5YQ==
X-Google-Smtp-Source: ABdhPJxrkwEGYyYJ8onDYiJ7Ytd2Zt1Y1tkgJhWMus0X8qm8sOgX60aVCpI2C/aVtyAmD//1Ve4zXiJ9WYspWgkcQyk=
X-Received: by 2002:a05:651c:1687:: with SMTP id bd7mr11624217ljb.305.1639122821513;
 Thu, 09 Dec 2021 23:53:41 -0800 (PST)
MIME-Version: 1.0
References: <20211209201029.136886-1-jholdsworth@nvidia.com>
In-Reply-To: <20211209201029.136886-1-jholdsworth@nvidia.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Fri, 10 Dec 2021 07:53:30 +0000
Message-ID: <CAE5ih7872E8X-qRfBrBOHmKcUCX46GkXwq2WD3UUX8TuYczZDw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Transition git-p4.py to support Python 3 only
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 9 Dec 2021 at 20:10, Joel Holdsworth <jholdsworth@nvidia.com> wrote:
>
> The git-p4.py script currently implements code-paths for both Python 2 and
> 3.
>
> Python 2 was discontinued in 2020, and there is no longer any officially
> supported interpreter. Further development of git-p4.py will require
> would-be developers to test their changes with all supported dialects of
> the language. However, if there is no longer any supported runtime
> environment available, this places an unreasonable burden on the Git
> project to maintain support for an obselete dialect of the language.
>
> This patch-set removes all Python 2-specific code-paths, and then
> applies some simplifications to the code which are available given
> Python 3's improve delineation between bytes and strings.

I might as well take this opportunity to say that I've stopped needing
to worry about git-p4!

Hurrah!

I'm finding that the unit tests no longer pass with this change. I'm
not exactly sure why.


Luke





>
> Joel Holdsworth (6):
>   git-p4: Always pass cmd arguments to subprocess as a python lists
>   git-p4: Don't print shell commands as python lists
>   git-p4: Removed support for Python 2
>   git-p4: Decode byte strings before printing
>   git-p4: Eliminate decode_stream and encode_stream
>   git-p4: Resolve RCS keywords in binary
>
>  git-p4.py | 319 +++++++++++++++++++++---------------------------------
>  1 file changed, 123 insertions(+), 196 deletions(-)
>
> --
> 2.33.0
>
