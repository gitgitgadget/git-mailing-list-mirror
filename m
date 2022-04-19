Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE04C433F5
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 04:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347557AbiDSE1o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 00:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiDSE1n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 00:27:43 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D085E34
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 21:25:01 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id f32so14492082vsv.1
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 21:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WlqOflHTLFBq3KaUvYsIR2Xl2oNFWzYF+FPxSJ7wJ98=;
        b=Feu8dYTPMhnqiVPClLv6PTUG9qZ6ib5EXFH+pAV+VJ0Oz3CrPFxhS6+BqRDyjF1RtD
         i/gu2vqbe8hTc9W6EXNtwAlFJIYyBtp/T+t2HlhcbkmhJFxM2GKrADYZt8PUEAAMo3pi
         eVasCurzElfbUUJfdGj4X+zhd88MtSVVMnmxL0bq7fce2YsCEWJxGKgfOFpezR616hD+
         dLCCpP64Ug3SlCxjoHXRlbGRcoxSV95MnHvdVk1z5KCpNnEkheihTfIB9WyD4df1Il0c
         MvRbo/ssTurtYy0Gcbgdxp+OG5U9jbZIjIxUO+fvnjIWWX2yRfD5YXlIg80mRvK+8owK
         1XAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WlqOflHTLFBq3KaUvYsIR2Xl2oNFWzYF+FPxSJ7wJ98=;
        b=n/d3KVIKJSPHnRG4lCFDca2obTZr6hv7gpX08AtJsLOMpCO9NJpMvh8fy2bLS2VUKy
         6Fq+twLp4YDJzRM28XJw1tRv2U6p25uu2UxVAMSrIMZLKWZ9G+sfxivs5jtsuY9ehFJ9
         CMQBbN4l3qzq4fpc87NnA6Vv4V8Jca5lpqaq68O1i2qfQfQDsUmtOR66Mixb7xegz6Jo
         oiLDvPWCALFciVfngA4q/WcI26ir0mB/4lQpRedZNoomNJvYwXLjVBvsDuxOfj17JKSD
         aMMARqBjsD+CDhp1N9ouHVzd5LkSW3UFwjcRvgRLkHR39ldfyvOQBGa6UkwxImQyLsFV
         JjRA==
X-Gm-Message-State: AOAM533N3+ma/S4xY+4Z5xqi6uOZ2NzcXxYmARhuZojm7Elfp9ug1/uL
        HFA6uGxOROjkHBxBHGo5rcv7/oZHDc2R3xDUbC2GN0kk
X-Google-Smtp-Source: ABdhPJzCYIB78blaydcWBPw3Y/SOHdv5jMuHPvCL+niigMCHCnhQO6wvxe7U9E6AlIbzmM3Mf17Sh//bsNFcQdqwiLM=
X-Received: by 2002:a05:6102:7a2:b0:32a:382a:3c06 with SMTP id
 x2-20020a05610207a200b0032a382a3c06mr3944674vsg.1.1650342300427; Mon, 18 Apr
 2022 21:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpojjs4sjKdN6DAJFSwERdjq9XQgi35CcqkXu7HijadHa1Q@mail.gmail.com>
In-Reply-To: <CAPMMpojjs4sjKdN6DAJFSwERdjq9XQgi35CcqkXu7HijadHa1Q@mail.gmail.com>
From:   Martin von Zweigbergk <martinvonz@gmail.com>
Date:   Mon, 18 Apr 2022 21:24:48 -0700
Message-ID: <CANiSa6ipgk3dRJfOh6i1nL=QqtPTZ6n4ZheT+JowarMTOaeuDg@mail.gmail.com>
Subject: Re: Current state / standard advice for rebasing merges without
 information loss/re-entry?
To:     Tao Klerks <tao@klerks.biz>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 18, 2022 at 9:52 AM Tao Klerks <tao@klerks.biz> wrote:
>
> Hi folks,
>
> The discussion around Edmundo Carmona Antoranz's recent "git replay"
> proposal ([1]) led me down a rabbit-hole reminding me I really don't
> understand where we stand with rebasing merges, and I don't think I'm
> alone.
>
> I understand the standard advice at the moment to be something like:
> ---
> Use a recent git client, use the '--rebase-merges' option (avoid the
> --preserve-merges option if you find it), and re-resolve any textual
> and/or semantic conflicts manually (possibly using rerere if you know
> what you're doing).
> ---
> Is this correct?
>
> This current state/advice seems... suboptimal, at best, because it
> ignores any information encoded in the original merge commit, as
> clearly documented in the help. It will often result in you having to
> resolve conflicts that you already resolved, *where nothing relevant
> to that merge/commit has changed in your rebase*. If you have rerere,
> and you know what you are doing, and you were the one that performed
> the merge, in this repo, then maybe you're ok; similarly if it's a
> clean merge of course.
>
> Elijah Newren describes this problem/opportunity quite carefully in
> [2], and mentions a bunch of WIP that I have a hard time getting my
> head around.
>
> Similarly, Sergey Organov refers to a thread/discussion four years ago
> [3], largely involving a debate around two implementations (his and
> that of Phillip Wood?) that are largely theoretically-equivalent (in a
> majority of cases), with a lovely explanation of the theory behind the
> proposal by Igor Djordjevic / Buga [4], but that discussion appears to
> have dried up; I can't tell whether anything came of it, even if only
> a manually-usable "rebase a merge" script.
>
> Finally, Martin von Zweigbergk mentions his git-like VCS [5] which
> stores conflict data in some kinds of commit as part of a general
> "working state is always committable and auto-committed"
> state-management strategy;

Just so there's no misunderstanding, the "auto-committed working copy"
idea is not a requirement for storing conflict objects in trees.

> I may be misunderstanding something, but I
> *think* the resulting conflict-resolution information ends up being
> reusable in a manner theoretically equivalent to the strategy
> described by Buga as referenced above.

I think it's more similar to what Elijah suggested, actually. For
example, my VCS lets you rebase a merge commit (the "evil" part of it)
even if you don't rebase all its ancestors. Consider this case:

  X
 /
A---B---C
 \       \
  D---E---F

If you now want to rebase E onto X, and then F onto E' and C, then
Elijah's suggestion (and what my VCS does) will work correctly. If I
understood Sergey's proposal, on the other hand, the utility merge
would bring in the changes from D as well. Or, put another way, that
algorithm is only useful for rebasing "internal" merges, where the
merge commit is being rebased along with both (all of) its legs
(again, if I understood it correctly). With the "rebase changes
compared to auto-merged parents" idea, you can even change the number
of parents of a commit as you rebase it.


>
> These kinds of discussions frequently seem to feature git experts
> saying "I have a script for my version of this problem" (Elijah,
> Junio, Johannes Schindelin, ...), or even "I have a VCS for this
> problem" :), but I seem to be too stupid or impatient to dig
> through/understand whether or when these things will work for a
> regular joe and how to use them.
>
> The temptation, obviously(?), is to write a "rebase a merge" script to
> do something like Sergey Organov's V2 proposal referenced above... but
> it feels like I'd be spending a bunch of time and ultimately just
> making things worse for the community, rather than better - helping
> myself based on my (very limited, but still above average)
> understanding of merge mechanics, in a way that leaves the general
> public message / status just as unsatisfactory/unhelpful.
>
> Does anyone have an existing simpler answer? Ideally I'm looking for
> something like:
> ---
> * When you have a merge in your history, and you are rebasing, follow
> steps XXXXXX, involving this publicly available gist, or contrib
> script, or experimental flag, and it will probably do what you want.
> If there is a (new) conflict when rebasing the merge commit, you can
> expect conflicts to be presented as YYYYY, because rebasing a merge in
> this "informed" way can fundamentally involve multiple different
> steps/phases of conflict resolution - rebase conflicts vs merge
> conflicts.
> * Something like this will likely be introduced as a new rebase option
> in a future release, something like "--reapply-merges", or
> "--rebase-merges-better", because it will always require the user to
> understand that the three-way conflicts presented as part of such an
> "informed" merge rebase are subtly different to regular rebase or
> merge conflicts.
> ---
>
> Is it possible to get that sort of simplistic message for this complex topic?
>
> My apologies if this request is a duplicate - obviously a pointer to
> some sort of existing summary would be perfect.
>
> Thanks,
> Tao
>
> [1]: https://lore.kernel.org/git/20220413164336.101390-1-eantoranz@gmail.com/
> [2]: https://lore.kernel.org/git/CABPp-BE=H-OcvGNJKm2zTvV3jEcUV0L=6W76ctpwOewZg56FKg@mail.gmail.com/
> [3]: https://public-inbox.org/git/87r2oxe3o1.fsf@javad.com/
> [4]: https://public-inbox.org/git/a0cc88d2-bfed-ce7b-1b3f-3c447d2b32da@gmail.com/
> [5]: https://github.com/martinvonz/jj
