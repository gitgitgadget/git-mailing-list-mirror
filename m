Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A134C433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 22:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C447264FA7
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 22:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhBDWs7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 17:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbhBDWs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 17:48:58 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D383CC0613D6
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 14:48:17 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id e15so3696077qte.9
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 14:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GrYyWi0UohOvSvtdtUp2udwt4EerRuvdiZZuv9XRLAg=;
        b=NWfKRcjdKEFQn9zd7nP5XHhIrX+OIpmkCxJJSvgxNUn54sE1q9YDfLpuMY/ec8+hUs
         B2X/lvvILO+aWs5rh4zjdwXRiA+6DYW5m1HWxsoXhwwwQ25NqrPhxM1GCkdtGG+tz6bd
         jcAJO0P3JkgwDMLiXsr6N9iSkl+ppx6il0kse0gWNc2CyJ0GKa0Drr1bmB+zdMVkS/z0
         QXdiSdbSbWhbUy5wSUuoe1UviOXhbtb6Be46yRCzC8oD4RzI6NQFoYm9iL9vuwOEz0yK
         SVJ3C0JcXzbtOJRQfm6AJ1HlQIGNBFgAteGw77OAn1n6h79a8iYpVxtF6BK0Lr3qUZ6x
         WcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GrYyWi0UohOvSvtdtUp2udwt4EerRuvdiZZuv9XRLAg=;
        b=Yzp/4oaEVQaqcWw+51uvqV8II23SkuVaUn3KGluDHVxB1t60bp05GDlpvOcgz5heXV
         8xq2wDGNY32yXVjJuhkgpxNTQWn8dPpqD+6bKp5HAYgAS/XUD6gJh8/ldxykFnLEdQ8+
         wUV6mJDF0E7H44ZJyHuhmm+otB5dNA8rBwnNQs3JtiLsHqJmmfuUZ68i/0rEx2uVfDgK
         iE/xUKSPxVZwF62blV0v+I77zWIjqEqoiWSwju49r8TtMuSAAYHeB4ssbFeCWw7w6mKQ
         UEIg3BL3xAxfe+YH77sS0wiYemii1ZRd//omwEmpWGsiLKEnuphQUs8iyvBSIhagY+JM
         xqWw==
X-Gm-Message-State: AOAM530hICqZKoZHW4sMidqvKEQLdZHLoJ6i9sr2Yj5i4QxjmpU3DrJX
        KN0pGbFuRdtQlTwoSqdLgFdQqJV8i0jSCg==
X-Google-Smtp-Source: ABdhPJyFnVT26uENmrnzfT6RA2moZ/2gYP8sp4qbAKTnmljGt/s/duc0uIaxty3H6GxsqQO61xBdfg==
X-Received: by 2002:ac8:70d3:: with SMTP id g19mr1844182qtp.127.1612478896968;
        Thu, 04 Feb 2021 14:48:16 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:d1cf:24a5:841d:d52b])
        by smtp.gmail.com with ESMTPSA id c1sm6542649qke.2.2021.02.04.14.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 14:48:16 -0800 (PST)
Date:   Thu, 4 Feb 2021 17:48:14 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/6] Optionally restrict range-diff output to "left" or
 "right" range only
Message-ID: <YBx5rmVsg1LJhSKN@nand.local>
References: <pull.869.git.1612469275.gitgitgadget@gmail.com>
 <xmqqtuqr4frw.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtuqr4frw.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 04, 2021 at 02:41:39PM -0800, Junio C Hamano wrote:
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > One of my quite common workflows is to see whether an ancient topic branch I
> > have lying about has made it into Git. Since my local commit OIDs have
> > nothing to do with the OIDs of the corresponding commits in git/git, my only
> > way is to fire up git range-diff ...upstream/master, but of course that
> > output contains way more commits than I care about.
> >
> > To help this use case, here is a patch series that teaches git range-diff
> > the --left-only and --right-only options in the end, restricting the output
> > to those commits and commit pairs that correspond to the commits in the
> > first and the second range, respectively.
>
> Makes sense.

I'd add an additional use-case, which is ignoring new commits from
upstream when displaying a range-diff in rerolled patch series.

Oftentimes I'll find that the automatically-prepared range diff that
'git format-patch --cover-letter --range-diff' generates will include
new commits from upstream, so these new options should help me ignore
those in the output.

As an aside: I am curious if I'm missing something when you say the
"only way" is to ask for a 'git range-diff ...@{u}'. IIUC what you're
describing, I often resort to using 'git cherry' for that exact thing.
But, I may not be quite understanding your use-case (and why git-cherry
doesn't do what you want already).

My latter question is purely for satisfying my own curiosity; I don't
have any problem with a '--{left,right}-only' option in range-diff. From
my quick read of the patches, it all looks pretty sane to me.


Thanks,
Taylor
