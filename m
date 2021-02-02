Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EC3C433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 13:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C38D64ED7
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 13:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhBBNLN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 08:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbhBBNK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 08:10:57 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34280C061573
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 05:10:16 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id d18so22668584oic.3
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 05:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B/TVdK9YdXLL3p0O+kf4N9Iodr7ziej/r/lv3XSpsxw=;
        b=MEjgA7C6Aa/M0oFU1H71RvZSap5dxfWg0ScXYl+Uz8tN1lMxzMmapnzUllo8VMaQ8K
         QUZd5wFK+mD9nd47SK4S+YImqYjraZda+aV6KHv9vIHpvejPgaTA52GaS+7HCI/uENVa
         VPml4K37zypWmc83f2LnobJdEKQhvTqcPpU/70flr5FuvU5v7aAIGxGc4mUafrvsqN7I
         8MiQETBAZdLc73ITN60KggY51ZfM+01eGhdMG9N0wdnqUbAgUz/B5J1cgeI3+mhgWX+y
         JL3Bx0bA0Y2TdVy3jrwr+0tlFefCQGf7Hdz24ARWdMG4fQy6GWe5gbmpkQIlsqAqeC7b
         1yEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B/TVdK9YdXLL3p0O+kf4N9Iodr7ziej/r/lv3XSpsxw=;
        b=ZVEMcOp/AGTvGMbeqdSGuNx3Q0qRYu7PFPEhAd4prjvjS+cDfTU7VsIWo08X8fhQXq
         4vw2bfZ5npoVpEp6+fdELot7rJ0ygB32pJL0sanfFmqRWbjbFDCNT/zJBGZVqFtXNXp2
         jHx0ucEqBriOoBuLR6sTANcBKa7KzPQVqK2/E2tgBS/qdoWX4gFOm/cjK2kgwvM7WkyI
         BvLVZV8j0jASJKfVBpBlJ+WZ7lwyTDqmgd3RRxvB8Z2GsjIFEv2SVg0ZmKEIEAXl4ZdC
         wVZn1KOucncgYY9t1fjrhe4OMrnbA8Py5/5Bwvx6+iDr19mrE7c1gwU3PrdjFpwAKnNz
         FyHA==
X-Gm-Message-State: AOAM532qOdvJHHx74UEdHK51wjFnRBhPKUdJEdWZA8QbBByFeBiwVrXD
        774RRK1k2U52qoXQiWdHApNtcS62dmtuRWINFFQ=
X-Google-Smtp-Source: ABdhPJxuEoAg92XGjJvypdN9aCU03HLPlW9ESNkfrUfPTyro1as48DSmNuuU/Rfxauh0/YOxs4fFgYSO+me93ljmfrY=
X-Received: by 2002:aca:5b46:: with SMTP id p67mr2691398oib.179.1612271415697;
 Tue, 02 Feb 2021 05:10:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.857.git.1612011569489.gitgitgadget@gmail.com>
 <pull.857.v2.git.1612175966786.gitgitgadget@gmail.com> <7a9e78d0-732d-a990-0cb5-6bd8cf940a88@web.de>
In-Reply-To: <7a9e78d0-732d-a990-0cb5-6bd8cf940a88@web.de>
From:   =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Date:   Tue, 2 Feb 2021 21:12:10 +0800
Message-ID: <CAOLTT8Rf0vjB1+RuChbVPgf=YDif4B1mnro2MEF6E8+uGXM24Q@mail.gmail.com>
Subject: Re: [PATCH v2] alloc.h|c: migrate alloc_states to mem-pool
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     =?UTF-8?B?6Zi/5b6354OIIHZpYSBHaXRHaXRHYWRnZXQ=?= 
        <gitgitgadget@gmail.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To Ren=C3=A9 Scharfe:
Thanks for checking in.

Ren=C3=A9 Scharfe <l.s.r@web.de> =E4=BA=8E2021=E5=B9=B42=E6=9C=882=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=881:55=E5=86=99=E9=81=93=EF=BC=9A
>
> Am 01.02.21 um 11:39 schrieb =E9=98=BF=E5=BE=B7=E7=83=88 via GitGitGadget=
:
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > "alloc_state" may have similar effects with "mem_pool".
> > Using the new memory pool API may be more beneficial
> > to our memory management in the future.
>
> Replacing the custom object allocator with mem-pool would allow reducing
> the code size.  What other effects might it have?  Do you expect changes
> in memory use and/or performance with the current code and your patch?
>
> > functions "alloc_*_node" now change to "mem_pool_alloc_*_node".
>
> Why rename these functions?  Do callers need to care about the
> underlying allocator?  The function signatures stay the same.  In any
> case, this renaming would be easier to review if it was moved to a
> separate patch.
>
Truly,I will change it.
> > At the same time ,I add the member `alloc_count` of
> > struct mem_pool ,so that we can effective track
> > node alloc count,and adapt to the original interface `alloc_report`.
>
> This function has no callers.  Why not remove it (in a separate patch)?
>
Before I may have some confuse about choosing `alloc_state`or`mem_pool`,
so It has not been deleted yet.I remember that now.
> > diff --git a/alloc.c b/alloc.c
> > index 957a0af3626..951ef3e4ed7 100644
> > --- a/alloc.c
> > +++ b/alloc.c
> > @@ -71,30 +71,30 @@ static inline void *alloc_node(struct alloc_state *=
s, size_t node_size)
> >       return ret;
> >  }
>
> This keeps the now unused function alloc_node(), which breaks the build
> with -Werror.
>
> allocate_alloc_state() and clear_alloc_state() become unused as well,
> but the compiler doesn't complain because those functions are
> exported.  Nevertheless this patch should remove them, no?
>
> > diff --git a/object.h b/object.h
> > index 59daadce214..43031d8dc04 100644
> > --- a/object.h
> > +++ b/object.h
> > @@ -10,11 +10,11 @@ struct parsed_object_pool {
> >       int nr_objs, obj_hash_size;
> >
> >       /* TODO: migrate alloc_states to mem-pool? */
>
> This comment becomes stale with this patch and should be removed at
> the same time.
>
OK.
> > -     struct alloc_state *blob_state;
> > -     struct alloc_state *tree_state;
> > -     struct alloc_state *commit_state;
> > -     struct alloc_state *tag_state;
> > -     struct alloc_state *object_state;
> > +     struct mem_pool *blob_pool;
> > +     struct mem_pool *tree_pool;
> > +     struct mem_pool *commit_pool;
> > +     struct mem_pool *tag_pool;
> > +     struct mem_pool *object_pool;
>
> Why have pointers here instead of the structs themselves?  It's not like
> a struct parsed_object_pool is of much use without them, right?
>
> The same question applies to the original code as well, of course.
Here I may have some questions: why use `struct mem_pool` instead of
using `struct mem_pool *`?
I hope you can answer my doubts, thank you!
>
> Ren=C3=A9
