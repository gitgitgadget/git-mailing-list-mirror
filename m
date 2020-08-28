Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D8BC433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 00:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D0ED208D5
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 00:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="LHUkbD4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgH1Ajs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 20:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH1Ajs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 20:39:48 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAAAC061264
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 17:39:45 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id j10so3602613qvo.13
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 17:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6ta0smEPSrMWV2QXAedKiL2DTFciTX4sgxr5ntJvdiI=;
        b=LHUkbD4+5F3U5HtFJ6RWtrrm/T0Cl/AYfQ4zmdJ360u0E6hzWpwh3pWIbKxrOg8XOH
         79qn9cenMyO38OyAe3M4R5ieceaOG93XKDt2dxkgfVesW+PDMZ5HD1YoyC6Lf9Ch6y9p
         02EoRVuTrsO9n8oglV+/078yO5aN9eUrqJlGxuESzPFWPdmeVEvL4ljCA8HIunAZc8xb
         vjLeluLc4qNl9VBnjA0uFfHMEjbxRqLsLzt8X19dapsHwNnce1R7eM14V4OuSEXr6doa
         SKlsav81PPxHeVRBUWWBhi6h/e7JaTQcG8UDDfsCZYgYFuA+FD1ZzuCgD+jdejtaTvKp
         tCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6ta0smEPSrMWV2QXAedKiL2DTFciTX4sgxr5ntJvdiI=;
        b=bd2CZl7yekRKneEM278inRVLNMukgAAAbtfPoOw+qtVHXy4NAgQ6w3F/NmVR4k7689
         6fGUvhUWUSpVLgqD65rGiWy6wFKOFWEASvjaMRYpytbbX0yywcHWXpZtJxACgUzm7DXr
         r/wIOn2WA8CZFnbE4wmJk4vUe2GKqcSgzMQtP99t2Ao7rPC3vpxkzKJI4xyyU//3HwyZ
         lD+8AmDlZ6MAVgjsygNVHxUOsOvoZRIep4+nArQdgfOMhm0cP7h4DUzTCpGJc3u2FcfL
         drEl6f135iMGxIJ3AUO1lQ5e7VWVQF+ykTmc3GxJZPzX6snw1wyc19v9Mi4S3x9SRLVx
         r6Sg==
X-Gm-Message-State: AOAM533/jZSb5ju1apbeYJHP773c8+nOZT/s9e8Ya79bnsVzrziqlIV5
        Zl60VB8H5Wb+er/QEFKSeuahXw==
X-Google-Smtp-Source: ABdhPJzbeeD5W0JvVA1bVjzYqcq+WDz04OOwCSmIfPpmD+C7KuowrFog8FS738mTelE42noxUbfA+g==
X-Received: by 2002:a0c:f9cd:: with SMTP id j13mr21310099qvo.227.1598575182719;
        Thu, 27 Aug 2020 17:39:42 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:1fb:e542:467f:ba2b])
        by smtp.gmail.com with ESMTPSA id j74sm1584403qke.7.2020.08.27.17.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 17:39:42 -0700 (PDT)
Date:   Thu, 27 Aug 2020 20:39:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2020, #07; Thu, 27)
Message-ID: <20200828003940.GA80266@syl.lan>
References: <xmqqh7snpxy1.fsf@gitster.c.googlers.com>
 <20200827233454.GA3973432@coredump.intra.peff.net>
 <xmqqzh6foe44.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzh6foe44.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 27, 2020 at 04:36:43PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
> > On Thu, Aug 27, 2020 at 02:43:02PM -0700, Junio C Hamano wrote:
> >
> >> * tb/repack-clearing-midx (2020-08-26) 1 commit
> >>   (merged to 'next' on 2020-08-27 at a465875cbb)
> >>  + builtin/repack.c: invalidate MIDX only when necessary
> >>
> >>  When a packfile is removed by "git repack", multi-pack-index gets
> >>  cleared; the code was taught to do so less aggressively by first
> >>  checking if the midx actually refers to a pack that no longer
> >>  exists.
> >>
> >>  Will merge to 'master'.
> >
> > This seems to break t7700 when run with midx support:
> >
> >   $ git checkout e08f7bb093
> >   HEAD is now at e08f7bb093 builtin/repack.c: invalidate MIDX only when necessary
> >
> >   $ make && (cd t && GIT_TEST_MULTI_PACK_INDEX=1 ./t7700-repack.sh -i)
> >   [...]
> >   + git repack -a -d
> >   Enumerating objects: 10, done.
> >   Counting objects: 100% (10/10), done.
> >   Delta compression using up to 16 threads
> >   Compressing objects: 100% (5/5), done.
> >   Writing objects: 100% (10/10), done.
> >   Total 10 (delta 1), reused 10 (delta 1), pack-reused 0
> >   fatal: error preparing packfile from multi-pack-index
> >   error: last command exited with $?=128
> >   not ok 6 - packed obs in alt ODB are repacked when local repo has packs
> >   #
> >   #		rm -f .git/objects/pack/* &&
> >   #		echo new_content >>file1 &&
> >   #		git add file1 &&
> >   #		test_tick &&
> >   #		git commit -m more_content &&
> >   #		git repack &&
> >   #		git repack -a -d &&
> >   #		test_no_missing_in_packs
> >
> > I didn't look into whether it's a bug in the actual code, or just a
> > weird interaction with the way GIT_TEST_MULTI_PACK_INDEX triggers
> > git-repack to write a midx. But either way we should figure that out
> > before it graduates.
>
> Thanks for stopping us ;-)

Thanks indeed. I started looking into this tonight thinking that it'd be
an easy fix, but I think there is a deeper bug that is worth
investigating further.

Let's eject this for now. If the bug turns out to be easier than I
thought, I'll send the patch again, otherwise I'll send it with my
larger series when that's ready.


Thanks,
Taylor
