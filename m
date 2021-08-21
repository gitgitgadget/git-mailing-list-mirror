Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D447C4338F
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 23:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0206E61178
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 23:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhHUXts (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Aug 2021 19:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhHUXtr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Aug 2021 19:49:47 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52882C061575
        for <git@vger.kernel.org>; Sat, 21 Aug 2021 16:49:07 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id a20-20020a0568300b9400b0051b8ca82dfcso3834030otv.3
        for <git@vger.kernel.org>; Sat, 21 Aug 2021 16:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WrJaxPxN9IH9JmHdOiujQY6zgosMpTh6oo1a9RjPQpU=;
        b=eIY6fGOxiVknMS9jKs7Omsva/l6l4sRBWkiOHmhcySOY62sM7eTYrTNwXOlgvrD7BT
         2xdfyAXlgOQNLF/HXwpcQEgCR5XWNDl9alsvMXwxRWXaO+VriIy/vEwjlWbGk+xV+YnX
         TvulG+8M9uazeSqR8ZdL6kROkUera/rwo215uQhfOO6nHbPLQ3AdvUJhZoaQZ9PP7/Xe
         zXvZ5kxozOIKHWw+CUsD+dm1tZpRNJDx4y4TPMHjPKcmoUTOAbGIrIcibiy0xSqtX9v4
         0by7+lJih2kg9PAfgfRo4JTobdFC8K1hnGM2v1vXhYM8COWy2NNg5x416pOXRe4CQvz5
         3RUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WrJaxPxN9IH9JmHdOiujQY6zgosMpTh6oo1a9RjPQpU=;
        b=Imy0JpfZ/ZCB31nv48wEYEROIRI/6vacySU70rUksjz2MfKl8VH75883W7yGja7lXG
         78lGFtcSXKXYI36g/tkvmccQOlCjDtvyK8VfUAeXywNC+2UpXi5g+fSahaiupaB4da2e
         4mH6QRvXnuhdLuYnDPK5d/Ux1zT3AEbsi0/e2pcfagbP3Nwn0v7raBdFil6/K4ux80cN
         +RvfTPgZd5V0DkU//PeEc1G6nbbTpW3Svgwb2L4ZUtKTDwYncIUmqoWFqeZf7/TqJFX9
         iXass4YQVCAMvBxf6XZN2Kh8EqFqoix6zQtEw48/wgED193yM0tqMg5v4LTfmQZ4r9CJ
         TldQ==
X-Gm-Message-State: AOAM531zYn7qd1sHKfe0id0j6UzVTKf1nqY8gsmEHlZLyOtZAx63+pJe
        XpbVbiTZqV5awYTtxzyQAsgTai76HlK7FWyu6ZA=
X-Google-Smtp-Source: ABdhPJyenrpnKdG3jgQAib7QbYZpdE+U8pn7uwitonuAh4yNYvoUFBmHBII1Ekg6By9bpjAAN1pJlvqocRpaDLGJy8U=
X-Received: by 2002:aca:bfc6:: with SMTP id p189mr7429888oif.167.1629589746627;
 Sat, 21 Aug 2021 16:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
 <7cad9eee90bcee3cb98be5c7a2edaca5e855c157.1629220124.git.gitgitgadget@gmail.com>
 <xmqqzgte62ud.fsf@gitster.g> <b3c7e700-f36c-d58f-0c49-450444df8c63@gmail.com>
 <CABPp-BEtOWUGCcn3B0On80=tMZ_Re9ScHnBiwPPPFY=x2TwG5Q@mail.gmail.com>
 <xmqq7dgfu1zb.fsf@gitster.g> <CABPp-BHLw-h0oQLNwT+DAXeHZZfJRaiyoM+kDuqx_aT80-zM3w@mail.gmail.com>
 <xmqqwnofsa24.fsf@gitster.g>
In-Reply-To: <xmqqwnofsa24.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 21 Aug 2021 16:48:55 -0700
Message-ID: <CABPp-BGkqfx8kHA9o0sYhBQxcN0c_KSrvWczY+KNExhXD3ZeUQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] t1092: use ORT merge strategy
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 20, 2021 at 9:20 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> It seems that merge_recursive() and merge_ort_recursive() are
> >> interface compatible and the latter can serve as a drop-in
> >> replacement for the former?
> >
> > Yes, merge_ort_recursive() and merge_ort_nonrecursive() were meant as
> > interface compatible drop-in replacements for merge_recursive() and
> > merge_trees(), to make it easy to switch callers over.
> >
> > There is no such replacement for merge_recursive_generic(), though,
> > and builtin/{am, merge-recursive, stash}.c will all need to be
> > modified to work with merge-ort.
>
> But merge_recursive_generic() eventually calls into merge_recursive();
> as long as you hook into the latter, you're covered, no?

Okay, you caught me.  merge_ort_recursive() has one API difference
from merge_recursive(), namely, it does not allow opt->ancestor to be
anything other than NULL, whereas merge_recursive() does.  The only
caller where that distinction matters is
merge_recursive_generic()...but that does prevent
merge_recursive_generic() from just calling merge_ort_recursive().

The original patches I sent in for merge_incore_recursive() would have
provided for this same ability (and made merge_ort_recursive()
actually be a drop in replacement), but you rightfully pointed out
that the relevant opt->ancestor portion of the patches made no sense.
At the time, I responded (at
https://lore.kernel.org/git/CABPp-BFr=1iVY739cfh-1Hp82x-Mny-k4y0f3zZ_YuP3PxiGfQ@mail.gmail.com/):

"""
Yeah, you're making me lean towards thinking that
merge_recursive_generic() is just a broken API that I shouldn't port
over (even as a wrapper), and that I further shouldn't support using
the merge_ort_recursive() API in a fashion wanted by that function.
"""

The problem with opt->ancestor in merge_recursive_generic() is as follows:

  * When there is only one merge base (and opt->ancestor is not set),
merge_ort_recursive() and merge_recursive() will both set
opt->ancestor to the hash of the merge base commit.

  * The hash of the merge base is great when the merge base is a real
commit, less so when fake commits are generated (as
merge_recursive_generic() does) to pass along.

  * Because of the above, merge_recursive_generic() overrides
opt->ancestor with the value "constructed merge base" when there is
exactly one merge base tree.  That was done with git-am in mind, and
makes sense for am because it does create a fake or constructed merge
base.  It does not make sense to me for stash, which has a real
commit.  It also seems suboptimal or wrong for
builtin/merge-recursive.c as well -- it's hard to be sure since
builtin/merge-recursive simply takes an OID rather than actual branch
names and thus those OIDs could correspond to fake or constructed
commits, but builtin/merge-recursive does have the
better_branch_name() function it uses for o.branch1 and o.branch2 and
it seems like it should do the same on the merge base when it's
unique.


Rather than porting this bug (these bugs?) over from merge-recursive,
I'll just convert the merge_recursive_generic() callers over to the
new API.
