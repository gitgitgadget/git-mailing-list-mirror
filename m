Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B74C07E9D
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 17:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0073660720
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 17:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350601AbhGSRIx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 13:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376722AbhGSRFw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 13:05:52 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9CDC0610D4
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 10:25:39 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id a17-20020a9d3e110000b02904ce97efee36so7227579otd.7
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 10:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=VJ7yliNo8ogzCmyYJkcApQ0HPUNEJup7Q3nifWk/OPA=;
        b=oJGonPXJPLoZMZlKMbETCPZcJyz8ETsRXzJgw9ibrWjJjDRZuD+ROkwAb2JSxi5qQD
         akcZ3k7ji00I+ml1LY8COkXfF292Gla0JKbLJGyD1S/WJdJc4U2JF5AZAzRI2zvQTVVh
         siw7wblXqUKDtU/2yFbqwY35gdkYLQJdtVbVwpVoLKstLK61RWxOy6swOUfXC9gr72nO
         frVVSyW7uAHkEot1ruFox9UEjBU5g2MJhRf9Zt5IDiUV+voB/zntwGHKIlThc+ggCfUT
         RjiR9Xt3yaVEPEsVPj+FIrH2Jn4YTRBb2vinE8IiMg7wfH/AE6c98c4nR2ZlskEff4/7
         oBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=VJ7yliNo8ogzCmyYJkcApQ0HPUNEJup7Q3nifWk/OPA=;
        b=GCO3AJsfmUw+uZZrjsNqyGjQHeuNiYb2jdi4YzYJqdTVxaI9j/6BCBjuYroNGiU5/h
         8yYZHcWSCRBsK4IJd1mMLrXfCsimsr2vrX2bac2jKrWqHKUV5cSpZrbBMW9KMkW2JJJP
         KNBClYW96DmGO3HOztbuC6wmXbhddRTlj8Y6jMCZ4TbYnSNaqV+2PNXxz+yDb4fTtfLh
         jS3fN5ykA88vinrEgP8fzTOvwjzjedayFRsRw7c/LT2A7NS8ycu96NLI7okheILCUqym
         s56p8/EVIapYrobl33sx1XRtRqmE480lpYKMeLUJ86o9p/DNrcv/KoHQV/+yRKiabZ+X
         pEFQ==
X-Gm-Message-State: AOAM533TzEpoPmw97whLMxUUE9jDRHk8JPkZ/7jhmeIJBp23q9bgVNBF
        UULBiWqaD5m2rbCTwmJGlTs=
X-Google-Smtp-Source: ABdhPJxH14ggzXENk6f9gX3EmwpoL4inmbmUVm4MYX/KNNPE9Zb1S8kh18SewZVB7RcAmC070KNnUw==
X-Received: by 2002:a9d:6b03:: with SMTP id g3mr19070414otp.187.1626716587400;
        Mon, 19 Jul 2021 10:43:07 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id x20sm3745902otq.62.2021.07.19.10.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 10:43:06 -0700 (PDT)
Date:   Mon, 19 Jul 2021 12:43:05 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <60f5b9a9e29d8_13f2e22084b@natae.notmuch>
In-Reply-To: <fa757764-db25-849d-d8d5-e28908059f6b@aixigo.com>
References: <c62933fb-96b2-99f5-7169-372f486f6e39@aixigo.com>
 <CABPp-BEHZcfZNL+PG1vmqXGf4Qs3eoULb4NDDgbmOB30HzJu_Q@mail.gmail.com>
 <60f1b7853b8a2_ade9208c1@natae.notmuch>
 <00b50aa6-9b61-9f80-1d8d-2db3ed5e7638@aixigo.com>
 <60f1c9378d5a1_3302085c@natae.notmuch>
 <fa757764-db25-849d-d8d5-e28908059f6b@aixigo.com>
Subject: Re: pull.rebase config vs. --ff-only on command line
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthias Baumgarten wrote:
> On 7/16/21 8:00 PM, Felipe Contreras wrote:
> > Matthias Baumgarten wrote:
> >> On 7/16/21 6:44 PM, Felipe Contreras wrote:
> >>> Elijah Newren wrote:
> >>>> On Fri, Jul 16, 2021 at 7:52 AM Matthias Baumgarten
> >>>> <matthias.baumgarten@aixigo.com> wrote:
> >>>>> this is my first time contacting you guys and girls so I hope this mail
> >>>>> achieves the expected standard. I've discovered the following behaviour
> >>>>> of git:
> >>>>>
> >>>>> If pull.rebase is configured to true and git pull --ff-only is executed
> >>>>> it seems like the config wins, i.e. issuing "Successfully rebased and
> >>>>> updated refs/heads/...", which is not what I would expect. I always
> >>>>> believed that command line options would overwrite configured options.
> >>>>>
> >>>>> Is my assumption that command line options always win wrong or is this a
> >>>>> bug?
> >>>>
> >>>> It's a bug.
> >>>
> >>> No it isn't.
> >>>
> >>> Elijah is elevating to fact his opinion of what --ff-only should be
> >>> changed to.
> >>>
> >>> But it has not been changed. Today --ff-only is meant only for the merge
> >>> mode of `git pull`, and like other merge-only options (e.g. --ff,
> >>> --no-ff, and --squash) it's ignored in the rebase mode.
> >>
> >> Shouldn't every explicitly given merge option (like --ff-only) overwrite
> >> any configured option that would not even result in a merge, i.e.
> >> forcing a merge and thus forcing ff-only?
> > 
> > Perhaps. Other developers have suggested that before.
> > 
> > The problem is that everyone wants to make --ff-only the default, and
> > then we start to get into a tricky situation, because what should these
> > do:
> > 
> >    git -c pull.ff=only pull
> >    git -c pull.ff=only pull --merge
> >    git -c pull.ff=only pull --rebase
> 
> If my assumption were true, and every explicit (cli given) option would 
> overwrite implicitly given ones (i.e. configured options), wouldn't
> 
>   * git -c pull.ff=only pull, do a fast-forward (or merge)
>   * git -c pull.ff=only pull --merge, force a merge commit
>   * git -c pull.ff=only pull --rebase, force rebase

The documentation says --ff-only is meant for merges, therefore these
three should be valid and do the same:

  git pull --ff-only # --merge is the default
  git pull --merge --ff-only
  git pull --ff-only --merge

In order for your assumption above to be correct, the semantics of
--ff-only have to be changed (along with the documentation), but people
are *already* relying on the current semantics:

  [pull]
    ff = only
    rebase = true

I made a poll on reddit [1], and 19% (so far) said they do use both
configurations, and they know what `git pull --no-rebase` would do.

In other words: they would expect `git pull` to do a rebase, but
`git pull --merge` to do a fast-forward merge.

Changing the semantics of --ff-only would break behavior they rely on,
unless we break symmetry from --ff-only and pull.ff=only which would be
very hard to explain the documentation.


However, if --ff-only wasn't mapped to pull.ff=only, but
pull.mode=fast-forward, then we can have both: the configurations people
rely on today wouldn't be broken, and your expectation that
`git pull --ff-only` overrides pull.mode=rebase would be met.

It's the perfect solution.

> > One of these will always fail, when it shouldn't
> Would this even apply under the above assumption?

[I think you meant to paste this]

Under your assumption it wouldn't fail, but other behavior users rely on
today would be broken.

> > I proposed a solution for that, but is has been ignored.
> I'm sorry!

It's not me the one that suffers (I don't even use `git pull`), it's the
users that have been negatively affected for more than ten years.

[1] https://www.reddit.com/r/git/comments/omcngl/do_you_use_both_pullff_and_pullrebase/

-- 
Felipe Contreras
