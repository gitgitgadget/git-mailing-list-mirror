Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2941CC433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 15:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02F2D6023D
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 15:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbhIIPwJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 11:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbhIIPwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 11:52:09 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C8DC061574
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 08:50:59 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id a15so2905299iot.2
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 08:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3kTbXSuc9Wiv4Uan82hmx3ZxexLGbqxFRCmHGeXUHHE=;
        b=IMSH2nmjBOhjdAoNlQ5sQrBCcJrW673yT/pDsh8hmR6TrLUYAUbJYC+Pz7djdmXB5P
         1wQVTunSmRbIP7ZvXNaYpI2PmXQcDCMaJQWiNl9IekJJOLnfDP++5L8eaf49M+UsAvrD
         VVHp3rNjnm0pcFHHnmMGl4AsOjG+gJbSYpfsIu5Rpe9+fc/I+NcmIt/1xr4TLuaAvQRc
         B3MYr/OQM7BBhXrEVhKpBMxPQNnr9q7EOlme4+fz8VIVNu0OOY15ArFwhOYOxV3grlTM
         0tDWFexNXJIl06I+1mLlDvubrFtMI5WdUSBzQFgZvg/kOPQk7cpdlJlWAdX56ioZG14C
         yoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3kTbXSuc9Wiv4Uan82hmx3ZxexLGbqxFRCmHGeXUHHE=;
        b=LoMVecDoviartjybZ8a6QcfuzpaMoIuozrid1HJVvn9ZoMLsMDm0YntOc+LVm2Yiph
         EIfgmjQ9ii9EdMZnDKTRyjiKnY6CWzonx3okiaEdnHBjvn98R5oYAF+y7ABFsMRzYl0G
         j70ejYHf78zopHh8+N/1r+bqHwn+ht+oulVKAng/caQUHZ7vCpX3733K+JluL+rTFCrL
         awF1uxzft8moslwHHe9sI9DF0nGQlPasDr+2NClgDbebViX90tI/t6R3+kSUEr4L0ZSF
         oWWjxAMMDxuarhVo5i0S26sQ9YlwntkJeYKYykEu/H7XQDXl8ypW32sBIp6scUNn8faH
         Nvyw==
X-Gm-Message-State: AOAM530LQMOcIulavtAYREWyUgziW5Z17hZbsvRdAdVD+duVOXLElotu
        +DgL3nYQb45oUd6i65GZlOF+TvC4TDgizdt056ZluhwnXDU=
X-Google-Smtp-Source: ABdhPJzksRrWp0a3jVsqTHfM2UrnF/4w8XG51VbSFYNvA98FweLePvsKHQDXP+IcliJr9NeKe3xMLzFcD2v/nJH241o=
X-Received: by 2002:a05:6638:2726:: with SMTP id m38mr432660jav.13.1631202658997;
 Thu, 09 Sep 2021 08:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAF8BazDKG03bpBEQyC9EsM8WxV_7WnQ386T=VT49EHNzsZ3PPw@mail.gmail.com>
 <YTktpQ9uZkbwtuLO@coredump.intra.peff.net>
In-Reply-To: <YTktpQ9uZkbwtuLO@coredump.intra.peff.net>
From:   Aleksey Midenkov <midenok@gmail.com>
Date:   Thu, 9 Sep 2021 18:45:42 +0300
Message-ID: <CAF8BazB+RLrzD7eO_fmsUbLY0DbqFeum+eMeY1hdZSAnWTxn4A@mail.gmail.com>
Subject: Re: git diff: print hunk numbers?
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 9, 2021 at 12:39 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Sep 08, 2021 at 11:40:20PM +0300, Aleksey Midenkov wrote:
>
> > Is that possible/how to print hunk numbers with git diff?
> >
> > F.ex. instead of:
> >
> > @@ -106,7 +110,6 @@ while ($r < $statement_count)
> > ...
> >
> > To print something like:
> >
> > @@ -106,7 +110,6 @@ 4 @@ while ($r < $statement_count)
> > ...
> >
> > filterdiff uses hunk numbers intensively. Work with line-number ranges
> > is not so effective.
>
> No, Git doesn't know how to do any annotations on hunk lines (aside from
> finding and reporting the funcname lines from the source). So you'd have
> to post-process it, like:
>
>   git diff ... |
>   perl -pe 's/^@@.*?@@/join(" ", $&, ++$i, "@@")/e'
>
> but I'm not sure if that's quite what you're after. If you're using
> filterdiff to pick out hunks, then piping through "filterdiff
> --annotate" does something similar.
>
> If you want to post-process your diffs all the time, you can do
> something like:
>
>   git config pager.color false
>   git config pager.diff 'filterdiff --annotate | less'
>

Thanks!

 git config pager.color false
 git config pager.diff 'filterdiff --annotate | colordiff | less -FRX'
 git config pager.show 'filterdiff --annotate | colordiff | less -FRX'

did the job for me.

> to show the annotations anytime the output is going to a terminal.
> Though sadly filterdiff does not handle the colors; other
> post-processors like diff-highlight parse around them.
>
> And finally, if your ultimate goal is to use filterdiff to pick out
> hunks, you might find using Git's picking tools like "checkout -p"
> easier. Even if you are starting with an actual patch, you can apply it
> and then pick out bits, like:
>
>   git checkout --detach ;# temporary head for applying patch
>   git apply </path/to/patch
>   git commit -m "temporary commit for patch"
>   git checkout - ;# back to the original branch
>   git checkout -p HEAD@{1} ;# now selectively grab parts
>
> Of course that only helps if the patch actually applies. If your goal is
> to filter out hunks that don't apply, it won't help. :)
>
> -Peff

-- 
@midenok
