Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B331C47089
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 23:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbiLEXei (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 18:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbiLEXe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 18:34:29 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7081F9EB
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 15:34:13 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id q190so3568787iod.10
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 15:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mQQu8zIk30+hj25brk/cwZQnqynEbP3GJv+UYLkDXWM=;
        b=DiA2KvS04Um/VmLVXKX4l22xRqk1XfVs4hkwx4BPuBHBjrfuuZgksPPQk6hM+ulodR
         xwrYgyX0RfmYLtAIlT2Jb06k85DGUCM7uMDM0kEXFyYwvLA6Gh2dnHGbx8jdwVZY25Ql
         5Llk2t5c+6vS0zaLmYZdsXowYSu/Yl4SUa44q/IVP5SfXDpMDG/e8c02A5MFAcDJPuxw
         ++DbIUjGOobGy/0YwBHazHYU0sFgusuhRdTvIZtn4/T+/I+S3zHvxplcVN7dBxYfjiSf
         UgeG0EuwdTsauvqqdNgRCytP2pmOfdr3FYcvdfKp9hm+cd8ZkgNWkeOdvtIg8fwseHpw
         mPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mQQu8zIk30+hj25brk/cwZQnqynEbP3GJv+UYLkDXWM=;
        b=a08kQzR8GS4LjgBar8bNo/7X21Tfho+3qtdtze+C/e7tWyy82IkbiJgdBfpIuVDyPr
         6lWL4p9LRG73NNQRJk9NUwwMg2kFiTFx3XdMQYxKz6YjG9VWlsESL6Io6yhUUMVCsRIn
         MiURe1mLWzYLY6v708W80rQfwzihTvi5HBOg/wowOCLmxhLKYhzCK8HBDfw+3uV/JQq+
         kvmnpqGC0MpB7HWO2ytjyeGlmlmZMgFQJMV8dCJ/sfG1SGRDbG3LKKeNeJ1MUghde2kF
         Yj8HKjnaOA04kjOT1aIqw4p+P2GMYve1hIci1IvenXozqXXsxCA7OYlRtIy2V/BH/b5r
         dO5Q==
X-Gm-Message-State: ANoB5pmZkzbVAL0BmP3TUPE0pGvZI6plNHH6cdve+vM3iSTsgXqfGTa7
        qodAI7QKcxSuTSl6g/refBMZVg==
X-Google-Smtp-Source: AA0mqf62MuY81hUdnDY6pT4fc0NzMARnjRmSqv4gIMghaCMQXz7gCWOJ0nKOzY1lBx4Ys0qfPdLTIQ==
X-Received: by 2002:a02:7a06:0:b0:374:c658:2141 with SMTP id a6-20020a027a06000000b00374c6582141mr37110313jac.210.1670283251119;
        Mon, 05 Dec 2022 15:34:11 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q5-20020a056e02106500b002f9b55e7e92sm5604737ilj.0.2022.12.05.15.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 15:34:10 -0800 (PST)
Date:   Mon, 5 Dec 2022 18:34:09 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] test-lib.sh: discover "git" in subdirs of
 "contrib/buildsystems/out"
Message-ID: <Y45/8WnuUnP9gOMo@nand.local>
References: <663b93ef-0c89-a5f6-1069-b4be97915d20@dunelm.org.uk>
 <patch-1.1-f27d8bd4491-20221201T162451Z-avarab@gmail.com>
 <xmqq5yeuspam.fsf@gitster.g>
 <87f22a55-ee84-2f76-7b9b-924a97f44f89@dunelm.org.uk>
 <221202.86sfhxg2ng.gmgdl@evledraar.gmail.com>
 <Y4qF3iHW2s+I0yNe@coredump.intra.peff.net>
 <221203.86pmd1dyqn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221203.86pmd1dyqn.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 03, 2022 at 02:41:04AM +0100, Ævar Arnfjörð Bjarmason wrote:
> > I have similar feelings to you here. Back when cmake support was
> > introduced, I explicitly wanted it to be something for people who cared
> > about it, but that wouldn't bother people who didn't use it:
> >
> >   https://lore.kernel.org/git/20200427200852.GC1728884@coredump.intra.peff.net/
> >
> > I stand by that sentiment, but it seems to have crept up as a required
> > thing to deal with, and that is mostly because of CI. Using cmake in CI
> > is good for telling developers when a change they make has broken cmake.
> > But it also makes cmake their problem, and not the folks interested in
> > cmake.
>
> That's a bit of a pain, but I don't think the main problem is its
> integration with CI. It's that there doesn't really seem to be an
> interest in its active maintenance & review from its supposed main
> target audience.
>
> Case in point this "ab/cmake-nix-and-ci" topic: It's been queued for
> around 2 months now.

I think CI *is* the problem here. The CMake bits are basically a black
box to me (and I suspect a large number of other contributors, too). But
when it breaks, the only reason we as a project end up noticing it is
because it has fallout in CI.

I would not be sad to make CI failures that are derived from CMake
"soft" failures in the sense that they don't make the build red. But I
think it's masking over a couple of bigger issues:

  - Why do we "support" two build systems in CI if one is supposed to
    only be here for those that care about it? IOW, even if we say that
    CMake support is nominally an opt-in thing, in reality it isn't
    because of the dependency via CI.

  - Why do we only *notice* these failures in CI? I found during my time
    as interim-maintainer the task of tracking down CI failures to quite
    frustrating. It is often quite difficult to reproduce CI failures
    locally (especially with exotic build and test configurations[^1]).

It would be nice to be able to more easily see these failures locally
before they hit CI. E.g., is it possible that I would work on a feature
which somehow breaks the CMake build, and fail to notice it if I use
"make" locally?

Personally, I would not be sad to see CMake removed from the tree
entirely because it has not seen enough maintenance and seems to be
quite a headache.

Thanks,
Taylor

[^1]: Not to mention non-Linux failures, though I think that is sort of
  par for the course if you're not using one of those platforms
  yourself.
