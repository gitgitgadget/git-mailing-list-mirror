Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA41C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 14:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E3260E09
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 14:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240483AbhHJO2G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 10:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhHJO2D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 10:28:03 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7431C08EB3C
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 07:20:32 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id f11so32332781ioj.3
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 07:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oy0nL8vUV+luvgkaURtxb6oqxLmG8CD5UCjD+qgdamQ=;
        b=Zn5HZ8xEFtNVWB3Bjbrw+5WpcW1zeBD9PgNEeP0pc4fAaZVgK754EhufdfxpRTKnpH
         fesOzqF/K7tHZzFP0gsYZp5M86HhE7fnP9seL0RVIFxC0dyK/sE0wnFVvFOG49ODYB8m
         a2ct6Luu3l22cp2DKZHllWluwOqEWg7iMdhihLAj+wPsN4dOqDUMYinJ6LEBb8FOQ6No
         yXUXwo64xyUiupp05qZzMF43qeXxYhygb4TxZTexnnEVOLgNUq2pj56LtgMk5TrlYUaa
         LmGg8lOxUEA8ZAcBvP4uAF5EW8ZulgOEsYIpsQPSFRoQPTeN+CC/tvn+sGqw7BwCXe3w
         haPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oy0nL8vUV+luvgkaURtxb6oqxLmG8CD5UCjD+qgdamQ=;
        b=AOQx+pawacEa+UjVtQidJ3bo1A1PMotFu79B53a3eQuQiNvlXQHn7jf2PYjWMDo6rP
         uTM/NbnUWZ2FYyRsgxbkm8XKawRt8t4xE5KJuAF9ggVs5+CHJEoqHbuTieXrz3vY6krj
         LvSysRPp7SV6AU0NY6lFmw+VNk8APsQFsPzEsdOQbVOAqKxUs9C5Wu10+zsyTcBgh/0s
         j9/b/p+XK4r6s/dQlL6G96skXIlO1H/7Ks927gRtawYGa2/yGr9wt8HNn47nb/X9Dzwm
         oUwKpxfuAWa0Ba2wk47tUXdvRg08jw6UeuRv58tk4Lbyzcjj+iKKgKE8YMo0W4DghjXF
         SZcw==
X-Gm-Message-State: AOAM530T27DMxHPi9tMLyDHqDaB+0oV1bedBHqbzA27QWnS87A6vE0Zu
        VVe2mYUxUcNqQJNuOUTd9klIQq1gur00R0RwiOU=
X-Google-Smtp-Source: ABdhPJzGLIxUsKL73EhAVcmw+jCOWvw5vYHWYfSjihktkzMDEevBep3b7djmjYZJ/qTrNPBYJGtx7t8LYUc3j78ITB8=
X-Received: by 2002:a02:ca06:: with SMTP id i6mr27185282jak.29.1628605232378;
 Tue, 10 Aug 2021 07:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8TYiUbXbkSTPY50jCU1bYP3JFx2P+hVmGL58S8V=AUMbA@mail.gmail.com>
 <CAP8UFD2yG3cC3qM3Ty7prdpVd=gXvArjM1soXD7EUn_NFFODaw@mail.gmail.com>
In-Reply-To: <CAP8UFD2yG3cC3qM3Ty7prdpVd=gXvArjM1soXD7EUn_NFFODaw@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 10 Aug 2021 22:20:21 +0800
Message-ID: <CAOLTT8TQxz2xkQE7etDa3cgb-kRfho-WAyhfHTsK=FrYVsPN1A@mail.gmail.com>
Subject: Re: [GSoC] Git Blog 12
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=
=8810=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=884:04=E5=86=99=E9=81=93=
=EF=BC=9A

> > parse_object_buffer(), let's take a look at the result of gprof again:
> >
> > We need to call grab_sub_body_contents(), grab_person() to rescan the
> > buffer and extract the data.
> > What if we can combine these multiple scanning and parsing into one com=
pletion?
> > At least intuitively, this has an opportunity to improve performance.
>
> Yeah, but is there a way to check that we indeed scan or parse the
> same objects multiple times? This way we might get an idea about how
> much scanning and parsing we could save.
>

I think find_subpos() called by grab_sub_body_contents() and find_wholine()
called by grab_person() are evidences that we are repeating iteratively.
But the proportion of time they occupy is too small. 0.0142% and 0.0109%

Sorry, but my attempts over the past two days have not gone well, the chang=
es
here will make the program very complicated, the optimization here is not w=
orth
doing.

> > So I check the implementation
> > details of `parse_commit_buffer()` and `parse_tag_buffer()`, maybe we
> > can pass some "hook pointer"
> > to these parsing functions like `oid_object_info_extended()` does to
> > extract only the information we need?
>
> Would this also avoid scanning and parsing the same object many times?
>

oid_object_info_extended()? I think it can set the pointer and extract
the required
value. Well, the problem it solves may be a little different from here.

> > The commit-slab caught my attention. It can be used to get some
> > specified data content from the object.
>
> I thought it was for storing commit data in an efficient way.
>

Yeah.

> > I am thinking about whether it is possible to design a `struct
> > object_view` (temporarily called
> > `struct commit_view`) to store the offset of the parsed data in the
> > object content. `parse_commit_buffer()`
> > will check whether we need something for in-depth parsing. Like this:
> >
> > ```c
> > struct commit_view {
> > int need_tree : 1;
> > int need_parents : 1;
> >
> > int need_author : 1;
> > int need_author_name : 1;
> > int need_author_email : 1;
> > int need_author_date : 1;
> >
> > int need_committer : 1;
> > int need_committer_name : 1;
> > int need_committer_email : 1;
> > int need_committer_date : 1;
>
> Is the above info specific for each commit? Or will the above be the
> same for all the commits we are processing?
>

According to the my previous thoughts, I think it is same for all commits.

>
> Ok, so the idea is to use the commit slab feature to store the struct
> commit_view instances. That seems reasonable to me.
>

It's a pity that it may not bring much optimization in real situations.

> > It seems that GSOC has only the last few weeks left, I'm not sure how
> > far this patch series is from
> > being merged by the master branch. Performance optimization may have
> > no end.
>
> Yeah, but the idea for now is just to make using the ref-filter code
> as fast as the current code.
>

It seems difficult to achieve consistent performance. As we discussed
before, the
previous `git cat-file --batch` can only provide a few kinds of
metadata that does not
need to be parsed, and after using ref-filter logic allows cat-file to
use more structured
information about git objects. But this means it needs a harder path,
It requires many
traversals and many copies, If we really use the logic in ref-filter,
we can only do partial
optimization, we can't expect it to be as fast as the old function.
Unless we have the
opportunity to not use the logic in ref-filter, but use the new atoms
in ref-filter, this may
has a chance to escape the copy in the ref-filter. I don't know what
your opinion are...


Thanks.
--
ZheNing Hu
