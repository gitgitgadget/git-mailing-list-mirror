Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76D1C636CC
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 18:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjBMSa0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 13:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjBMSaW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 13:30:22 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317D06E98
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 10:30:08 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id x71so14545369ybg.6
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 10:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=un2hfn9RJuZsyRwN29IE6hd4xq6G7vUsiBrT4jdYyhk=;
        b=ZhIQj3r15YJpXLI+wetOhlUi3us8aZrR/nlh12mBOnxDVlZDfqJzUONlKiVZD4LBKJ
         sN8tjyxfvNuD9QgR2EmAiEjkD8rUZ8CZcKaNZcgdlM+MkzUvl0cTlJeg2vE30pppeNxk
         WJ0ZbNrFqY28sGlhayHYb28Ya5KsD8jfS+42Gt/78AoBGUuQ3dtkfhppW70ggP16OWW7
         QwlLzinRWPR9l/XiaeZxUA7P2K5D8EBrtZxXmTvf/vkPe0xKev9kG5ji62MSobvj5k3X
         NoEVCdBxZ7nlvPVM84YFewnQBQ7BTlhFHoLvmI7S6rv33wuhnjx79coK0zRvc9vKM9yg
         hPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=un2hfn9RJuZsyRwN29IE6hd4xq6G7vUsiBrT4jdYyhk=;
        b=ulQ/Z5/syNOnAWLvmlWzn3DW4SBSrAzsxPJoyo9pDf0h5YUVUVfUJhpcSlxTJCRkF6
         FiZwW5Iu5mWlcVZUTDd6ExJvxBMldYEmNfQu77pzjYwOHuUbx5lcU0SS3d0x0H2PzENg
         czVVxtR5K2uhZ2M++yvFWwQ7SSaKJjqM03vD+taEc7y6X7gmdfacQLl1XvaKW42MFvs6
         JXHPmw9/om+9lJ/WmlgWCx1ucq4bYxEXdzxn6alyFwrrqkmZrLetGWniJMEFLFPV/tTC
         LYgNb+08sPjJT1aL497asQQdrTRLoKbvuwU8YG7WwcLSH08gemr72+55Qh4igWVCCImr
         4Yeg==
X-Gm-Message-State: AO0yUKWLI5/l9ZKBIWBnL46YVCJL9hEwguvui3wS58gdlrowfXjC65mV
        R4F+/WV8J21TP+46glZKNQPHd2uGyRsUoVkCRAvuWA==
X-Google-Smtp-Source: AK7set/1S++trsPTOU9jnQaXyetDVlBRMswPfRhPG28NZ6Dn3/Gdky1UVYc/bCRWnaZSSNzoraat26EfVeaP67F6b1k=
X-Received: by 2002:a25:9e8a:0:b0:880:c663:5d5 with SMTP id
 p10-20020a259e8a000000b00880c66305d5mr2725680ybq.307.1676313006402; Mon, 13
 Feb 2023 10:30:06 -0800 (PST)
MIME-Version: 1.0
References: <20230207181706.363453-1-calvinwan@google.com> <20230209000212.1892457-6-calvinwan@google.com>
 <kl6la61iardd.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6la61iardd.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 13 Feb 2023 10:29:55 -0800
Message-ID: <CAFySSZDz2BE4yrWKrWZhBx_yFBTUcWYtM9Fie-Npa84Ln0RTZA@mail.gmail.com>
Subject: Re: [PATCH v8 5/6] diff-lib: refactor out diff_change logic
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, newren@gmail.com,
        jonathantanmy@google.com, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 13, 2023 at 12:42 AM Glen Choo <chooglen@google.com> wrote:
>
> Calvin Wan <calvinwan@google.com> writes:
>
> > Refactor out logic that sets up the diff_change call into a helper
> > function for a future patch.
>
> This seems underspecified; there are two diff_change calls in diff-lib,
> and the call in show_modified() is not changed in this patch.
>
> > +static int diff_change_helper(struct diff_options *options,
> > +           unsigned newmode, unsigned dirty_submodule,
> > +           int changed, struct index_state *istate,
> > +           struct cache_entry *ce)
>
> The function name is very generic, and it's not clear:
>
> - What this does besides calling "diff_change()".
> - When I should call this instead of "diff_change()".
> - What the return value means.
>
> Both of these should be documented in a comment, and I also suggest
> renaming the function.

ack.

> > @@ -245,21 +269,9 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
> >                       newmode = ce_mode_from_stat(ce, st.st_mode);
> >               }
> >
> > -             if (!changed && !dirty_submodule) {
> > -                     ce_mark_uptodate(ce);
> > -                     mark_fsmonitor_valid(istate, ce);
> > -                     if (!revs->diffopt.flags.find_copies_harder)
> > -                             continue;
> > -             }
> > -             oldmode = ce->ce_mode;
> > -             old_oid = &ce->oid;
> > -             new_oid = changed ? null_oid() : &ce->oid;
> > -             diff_change(&revs->diffopt, oldmode, newmode,
> > -                         old_oid, new_oid,
> > -                         !is_null_oid(old_oid),
> > -                         !is_null_oid(new_oid),
> > -                         ce->name, 0, dirty_submodule);
> > -
> > +             if (diff_change_helper(&revs->diffopt, newmode, dirty_submodule,
> > +                                    changed, istate, ce))
> > +                     continue;
> >       }
>
> If I'm reading the indentation correctly, the "continue" comes right
> before the end of the for-loop block, so it's a no-op and should be
> removed.

It is a no-op, but I left it in as future-proofing in case more code is
added after that block later. I'm not sure whether that line of
reasoning is enough to leave it in though.
