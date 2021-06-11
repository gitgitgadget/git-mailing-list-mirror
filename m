Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8F9C48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 18:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9801A6140B
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 18:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhFKScI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 14:32:08 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:34361 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFKScH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 14:32:07 -0400
Received: by mail-ot1-f48.google.com with SMTP id w22-20020a0568304116b02904060c6415c7so1690765ott.1
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 11:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=PmFmm/rEQbOWI0KnoSMK/D0rOYuy1aXhUOA+yHuXVHs=;
        b=HXCXS+je/tPUJ45/tO0fvwsUDuBy7KunicvDkqMv3ZQChnejh39KyxuWCvykGHUUHD
         oS6mb6AWHuue9fDbHi3NZoBgWrkgThxCcOepWIDUNne9hq6muVM5weyB4CqUGjFtYrkJ
         0h68j5IBJuZbRvVMRYdS3lz21t8aoa5e0KrDtvbb0TZCqEnZF9D/iwSXzrquwVAUH3UE
         3YZsdI8E1uA8yP7dpNkjdTJI63OqDSrLMcnTxfYUL+rt3UozYkqkQX6BmIGy/XXAIVa+
         SB+1gxLjIC7MmhHabmiqlA8DUxU3ptRuj8C0xw1DsEki/ZPMLRUE2ikMxBPbrlZ5+hVW
         DI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=PmFmm/rEQbOWI0KnoSMK/D0rOYuy1aXhUOA+yHuXVHs=;
        b=CzsYDz2owlbUuOez/IK9e3Y45wzWohPc5qWl965Tjh2yXzPvKidGwnlvTmBrSzvMqE
         Y25XN4vPSar2niNQtaD4LmcuKqJceUmC2EOTJw5W2RkNQXZJ7r2J1EG91n+0/TWoLT+k
         vRO4J8jNz2t5okqvBKM9ezRt8CVBdCfm/AU+XvsskjqrRHCqZ187qJ/E17lwC3/cPpXa
         VN/yk6r/6pEvjg9yu+K5+UIJ1psK7s/K+uA8+3kdHiyo656bBSRNYN4KCh31AA2BKPYk
         +Rzyn9SgPcItkdcvmIVcW6Kx5HvaImvgvU1wF2hFDwVo2+EUO2CAbjdhY9TVLtKoWAL8
         EYIQ==
X-Gm-Message-State: AOAM531GHHOcjq7eDjT4kAV9sijKS2dUDSZZbJZRZ/PL1S/C3eA8LXyv
        JpzLIhJf7tYjQ0iGjUyZ0h0=
X-Google-Smtp-Source: ABdhPJzYrs/57Gl0AVPbHfRQIt7U45t782ADNnzGfnUI/49fzIX2k2qnsEL3LJS6kGzCUVrW7gFCcw==
X-Received: by 2002:a9d:6054:: with SMTP id v20mr4255970otj.39.1623436132954;
        Fri, 11 Jun 2021 11:28:52 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id m18sm1413192otr.61.2021.06.11.11.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 11:28:52 -0700 (PDT)
Date:   Fri, 11 Jun 2021 13:28:46 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, David Aguilar <davvid@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <60c3ab5e62dbf_8d0f20887@natae.notmuch>
In-Reply-To: <CABPp-BGtYnVPijg2OWoDBM915-PPFXk1O3H=BMf_itc4dNjAxQ@mail.gmail.com>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-8-felipe.contreras@gmail.com>
 <60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org>
 <YMIYUgo71aKJ1Nnx@coredump.intra.peff.net>
 <xmqqh7i5ci3t.fsf@gitster.g>
 <638a0500-459a-a25b-afca-904ec0e09866@kdbg.org>
 <xmqqy2bg3nqw.fsf@gitster.g>
 <07ef3a3b-4812-4fa1-c60c-b9085a268bc3@kdbg.org>
 <60c3724de35b4_3ad920839@natae.notmuch>
 <CABPp-BH0aRiSUw03nSK6jHRNQ+zcpUzr6WjeJ5GpdUCqCKxbag@mail.gmail.com>
 <60c39e1c52c04_8d0f208b2@natae.notmuch>
 <CABPp-BGtYnVPijg2OWoDBM915-PPFXk1O3H=BMf_itc4dNjAxQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Fri, Jun 11, 2021 at 10:32 AM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > Elijah Newren wrote:
> > > On Fri, Jun 11, 2021 at 7:25 AM Felipe Contreras <felipe.contreras@gmail.com>
> > > wrote:
> >
> > > > Personally I have never experienced what you posted, so maybe there's
> > > > something else happening behind the scenes.
> > > >
> > > > Maybe merge-ort changed something.
> > >
> > > merge-ort made no changes relative to content merges or choice of merge
> > > bases.  (In fact, merge ort doesn't even handle content merges; that's the
> > > xdiff layer.)  Even if merge-ort had made changes in this area, merge-ort
> > > is not the default and I didn't see the necessary config tweaks in your
> > > list of config options.  (I would have recommended against people using
> > > merge ort until 7bec8e7fa6 ("Merge branch 'en/ort-readiness'", 2021-04-16),
> > > which only made it into a release last week with 2.32.  I probably won't be
> > > recommending it as the default at least until the optimization work is
> > > merged and it's hard to predict how many more months that will take.)
> >
> > Indeed, I tested on v2.25 and found the same output.
> >
> > I thought of merge-ort because 1) I've never seen such kind of output
> > before, and 2) grepping the code I thought I saw merge-ort being the
> > default of something, but now I seem to be unable to find where.
> 
> We have briefly discussed multiple times what things might be needed
> to eventually make merge-ort the default (though it's not even
> complete yet; I'm five months into upstreaming the optimization
> patches with an unknown number of months left).  There were also a
> couple patches to make the _tests_ default to using merge-ort on most
> platforms, while still keeping one suite that tests merge-recursive to
> ensure we don't add breakage.  Perhaps one of those is what you're
> thinking of?

Nah, I think I just read something wrong.

> > > It's more likely that the codebases you work with just don't have
> > > criss-cross merges.
> >
> > Yes, that's it.
> >
> > I don't see why people in these kinds of codebases would like diff3
> > doing that by default.
> 
> I suspect they don't[1].  What's the alternative, though?  Not using
> diff3?  Picking a different base to avoid the occasional nested
> conflict in the inner merge region, but which overall has much worse
> other side effects?

Picking a different conflict style for the inner merge.

> I think Junio was addressing this when he
> recently said elsewhere in this thread that "Rejecting diff3 style
> output because of the way a conflicted part in the inner merge appears
> as a common ancestor version may be throwing the baby out with the
> bathwater"[2].  Sure, it's an annoyance, but diff3 is still a good
> option and there is no current solution to the annoying nested merge
> display.

Yes, but he proceeded to say we could not recommend diff3 to new users,
so I see the baby out on the floor.

I don't think it's likely new users will experience a problem with diff3
inner conflict markers (in 15 years of using git I've never encountered
them myself [or I blocked them out my mind]).

Even with this problem, experienced developers seem to be unable to live
without diff3, so I don't know if there's a valid argument against
making it the default.

Yes, improving inner conflict markers would make life better for new
users, but also everyone else. Software can always be better.

Let's not make perfect be the enemy of the good; diff3 is more than good
enough already.

Cheers.

-- 
Felipe Contreras
