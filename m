Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D296C433F5
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 23:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242348AbhL3XfX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 18:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240325AbhL3XfW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 18:35:22 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A180C061574
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 15:35:22 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id j6so103170723edw.12
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 15:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wUug42XEhlv2YEZNAqGOHJGZHj5s/yKC4n1Yip9lybM=;
        b=qNhBIc/YhrbVoiS1HnOBOzHIVKo+/agOpkOU/T3MEhu5ionT9lhZU7lcxIUtAZkrDy
         qm6GJufJyPeAF3QHn53uOPRONVCiaOGYcd9OQGKp4ZsjqnC0/oeA3VeSEoRWHqwELWSG
         Tlg+OrVZHnz01YSOGwLXQqzWu+ybvpszfhQVqDBIZByDfyMYM3HD/6E6xfogjjPzdt8T
         Y/XxpEgpLx4ShrO6ISqKUUJJ9FCdqIUGH3NWlhzHfGd6XJw+hWr4X1xRqs+EpDtzauWi
         3d6tR0DxfmP2arDqnM7sfkDNAHP18ktKxDQW8PuVN49q69UOBR/h0smg8tFMVINSRhZL
         GFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wUug42XEhlv2YEZNAqGOHJGZHj5s/yKC4n1Yip9lybM=;
        b=GJcxpoYPJtZ/0reLMQNAaUVDVxoa1odaKsugglwm/mUhND/GUebec7nDFAX3kTDwJD
         3eE6AuPSFvvl35gil29f5aFpObKRkgrJ/H3jj5DS51nkNnYcprkBsMR3jr+oDZfFmL8v
         NtDxXQHz6ZEM2eZFeaIOU9B/qp6NfSImuK1D4K9px/PpO9uCf8csTa0RVNu/oV2yiDhq
         pRfeknsf6UySM2k11+tAFjKnqiRfSclt4WSx6sucsq8ubr5rBZ+tmQ2RT+DYunZMDQrK
         uJd2QF6Ceaf1A4KdhovYONG5Mp0UXJj/s5DI6u2YnXcgio3K+gOJhWPfMyWdp9u5XmCW
         CJqQ==
X-Gm-Message-State: AOAM533Lp8cGxxFHs8JaReayvu5FpM6NmnWLr1MeZyu9axl8KTNfrliF
        CETpsUAYTSQ+WmwjXz+paL6Lg4GDyLBt04cV9GD7W3jSIMc=
X-Google-Smtp-Source: ABdhPJzbNYiFA5Uqn+ca9By5mP0nRMl5iu595syFJmc8PzmUR6kbvXI9Pwa/b4PrreEowRsseomTq3w2bYrG6me1qK4=
X-Received: by 2002:a17:907:968a:: with SMTP id hd10mr26049586ejc.269.1640907320467;
 Thu, 30 Dec 2021 15:35:20 -0800 (PST)
MIME-Version: 1.0
References: <pull.1174.git.git.1640650846612.gitgitgadget@gmail.com>
 <78ba0d99-246b-d90c-b725-c084c8304f02@gmail.com> <xmqqa6ghog5x.fsf@gitster.g>
In-Reply-To: <xmqqa6ghog5x.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Dec 2021 15:35:09 -0800
Message-ID: <CABPp-BHDsd66zE4GwNB45HSCffSD5gryUYtdL+9t4LdVCDk0Vw@mail.gmail.com>
Subject: Re: [PATCH] merge-ort: fix bug with renormalization and rename/delete conflicts
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 30, 2021 at 2:56 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Derrick Stolee <stolee@gmail.com> writes:
>
> > This breakdown of the cases is informative, and I like how self-contained
> > the change is.
> >  ....
> >
> > This patch looks good to me. Thanks!
> >
> > Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
>
> Thanks, both.
>
> A related tangent, but I was looking at the data structure involved
> and noticed that the casting between structure types "merged_info"
> and "conflict_info" looked a bit ugly.

Yes, that's true.

> It might be worth cleaning them up into
>
>  (A) a union with two struct, with "clean" member in the union to
>      switch between the two structures; or
>
>  (B) a single structure that looks like "conflict_info" but inlines
>      members of "merged_info" into it.
>
> The latter may be cleaner and simpler, and the unified data type
> would be the "merge info", which may be representing cleanly merged
> path, or conflicted path, and would justify conditional use of some
> members based on the value of the .clean member.

These are heavily used data structures.  Note that:
  sizeof(struct conflict_info) = 216
  sizeof(struct merged_info) = 64
In particular, we have to allocate one or the other of these for every
path (both file and directory) involved in the merge.  Since the
former is 3.375 times bigger than the latter, and the vast majority of
paths involved in a merge usually do not conflict (think of files only
changed on one side), using just one combined struct would require
more than 3x the amount of memory.  So I'd rather avoid (B).

(A) may work, but I'd still have to allocate merged_info instead of
the union type to avoid the memory increase.  And since we have an
amount of memory allocated that is smaller than the union, when
accessing it via the union, Stolee would probably still want all the
same casting safeguards (as a safety check to avoid out-of-bounds
accesses) that I think you're complaining about.
