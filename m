Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA99C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 09:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbiKGJMk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 04:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbiKGJMf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 04:12:35 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560C61706E
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 01:12:27 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id r3so12823513yba.5
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 01:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nalSsntV/tTtAhh6FI5fvmfntYbmMSd89qOR5sP9r3g=;
        b=da3yc+4Q61K5KpyPUEOzkjw7D/dzS4YPV6m+TDk82pepoYKep4n82ADGehO3fnYwN0
         baKILlNxC3gYfwhnUme/R2kCMT9Lq+OqAbIhKjeJt27ik+icg1y6LuArFfwergyyadnR
         ELDBGK9e6jjKtxu0ZH6Dfb5z0H+kE4z3y+QTCUgDdsVc/DopKl9azvjedVoygHlQ5gau
         hG7J7cdoGRaj8OsFCr6Kuq5GzfFho2l+ZyHaAt2KsUT75fMPvUnnrpjQTCEsK9gSiWil
         FnODuiaJYi5DR0o07ZMQRgaI//NtL5nUsKvFTuppH9Iist446HA2ixPCUTsLnARa7VjU
         +ZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nalSsntV/tTtAhh6FI5fvmfntYbmMSd89qOR5sP9r3g=;
        b=3LXecbxBbWHJFP8vJYctI/6g/yok/FIxYTGYLUeePb/j/RYY8kruBewAwSzZxaZBj6
         sIMbeuDJdhNDCseOsCrGlVz3y0tkA9eODGjO71h1Uvrbq+z986i5ww4BBomKm+j1ow30
         WI2up53rSpw9aipIAaVifISsjRU3BUTlXWNKKIl9zoVuzUPYP1LwUMByfYJBeQdoRKZ/
         qJ04sc/z3FbzVMR1JgD5T6J8cU9v1RNCc6YLmAp6VxpgorAEnEUFAASRp5tSSoXApIsn
         BvxogB84jhrkC7dE9vR/2qBNyj4TlSDYYKjO/9lQlq1XJ++ozhLaaghBIbO4oHS5fNwj
         WAIA==
X-Gm-Message-State: ANoB5pmDF88+FGsh3FKdrHl1e+Nl1BCIrjTTUysT4n4VWVoFfhDfXmqf
        oSJHd6AgZISnpPGZTneqObUHsspG865UqTqO8xk=
X-Google-Smtp-Source: AA0mqf47UHuOmGDIv+FbI1nrmu9cAY3fj+a53ZAtt/Grz7q0F2rf8NxYq2XiNw6o0/oMWEzKbOF1TPWhgquJZmfwKeU=
X-Received: by 2002:a25:40ce:0:b0:6d5:34ad:10c5 with SMTP id
 n197-20020a2540ce000000b006d534ad10c5mr9732132yba.494.1667812347050; Mon, 07
 Nov 2022 01:12:27 -0800 (PST)
MIME-Version: 1.0
References: <20221012135114.294680-1-christian.couder@gmail.com>
 <xmqqilkm9wv6.fsf@gitster.g> <CAP8UFD2HX6rK4TRP6ynUzWn4eoHa1FrbiFOtxBaxX-ZkBF3FJw@mail.gmail.com>
 <Y1wyVpHprWGxEDi/@nand.local> <xmqqwn8jheyb.fsf@gitster.g>
In-Reply-To: <xmqqwn8jheyb.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 7 Nov 2022 10:12:15 +0100
Message-ID: <CAP8UFD04HWO0kwuxzuRKutuWuHn26iWhC-CCuyaJz3-jjHzOWw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Implement filtering repacks
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2022 at 10:26 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Taylor Blau <me@ttaylorr.com> writes:
>
> >> > This feature is, from an end-user's point of view, very similar to
> >> > "git prune-packed", in that we prune data that is not necessary due
> >> > to redundancy.  Nobody runs "prune-packed" directly; most people are
> >> > even unaware of it being run on their behalf when they run "git gc".
> >> ...
> > If we don't intend to have `git repack --filter` part of our backwards
> > compatibility guarantee, then I would prefer to see the implementation
> > just live in git-gc from start to finish.
>
> I am OK with that, too.  We do not have to expose the option to
> users of pack-objects at all.

You might mean "to users of `git repack`", as `git pack-objects`
already has a `--filter=<filter-spec>` option.

> Just make "gc" the single entry point
> and that should be quite clean.

I am Ok with that if there is a simple way to not call `git
pack-objects` twice in some cases (once through git repack and once
through this new feature). I may be missing something, but
unfortunately I don't see one.

(Or maybe you mean that `--filter` in `git gc` should be an option
that is incompatible with other `git gc` options and configuration
parameters, so that when `git gc --filter=XXX` is called it only
performs what `git repack --filter=XXX` performs in the implementation
I sent, but then people might want to call `git gc` twice instead of
once, if they also want other usual gc housekeeping tasks to be
performed. I don't think that's the way `git gc` has been designed for
now though.)
