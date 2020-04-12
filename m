Return-Path: <SRS0=e9fP=54=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06534C2BB85
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 20:34:15 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CA6206C3
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 20:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="EtBdLQF0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8CA6206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=git-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgDLUeN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Apr 2020 16:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbgDLUeM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Apr 2020 16:34:12 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E17C0A3BF0
        for <git@vger.kernel.org>; Sun, 12 Apr 2020 13:34:12 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x2so2694089plv.13
        for <git@vger.kernel.org>; Sun, 12 Apr 2020 13:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6H3EE/SI3FlCZtE/yVJsVawgflpWUlPJGH5LhdzTsOM=;
        b=EtBdLQF0contZFSpWxuF0Qe/tSD0Xd2ApYS7Hwl6o+I0Ou0yjMmc4LtkIO7Grp/5DD
         cgUuAlj1MmsRd+dVTGKWKcdtO3tQ57qjD8obGsiRapI9+ZAW2d48BbmhKhaAVpuPqEpV
         NFZX70zUFHfXdmoiJ91u9uIgN/EN3pFmr47jaXxyN0YDqY6e0DdkpZi5h63p8TFEdN/T
         RYLQ1SOZ+SqU3mj4e+T+EquADQ5QuLHwKXyBZytWYnLAf/UxZQeYAqPB2WG2KZokvsnK
         OS1R0CoYz0Ic69GZx6DsBdzM6kDshdtTRCD+VkOfpQiYn20wgOdwt/ylblYvX4yJTCl/
         wvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6H3EE/SI3FlCZtE/yVJsVawgflpWUlPJGH5LhdzTsOM=;
        b=IVp73zH1q1Hv8DY84Gms1YO9X6Rtpt8PvhaCqYobzH+YGoKVDBu5IoTNyJlz+ZzLc6
         Vd5BYXTL+/aBjTWjQpJtxl8bOC71pDJEDLIP2Ia4n0pVZ375pi8t/a0fi7u0vnj+5Ljb
         qJHYQJCuryspY/sHoGNc24wl/Juh+QWta0cC0+7YO+OsjDicW0K38Jkf8Av7ZSsb7RN0
         RnD0l2dhOAOzaanuXLiaWLAa8NybOCFOTqVihCD6peSGluEsmvMnVvcegBhehfK0JjY9
         5A0/VQe2lagdSjHiVgA46pAQAFspjTIJwwZ0ntBK6kQokZAu9MiziNti1MkpzATGgR8d
         pqmA==
X-Gm-Message-State: AGi0PuZTjGtmf2EL5RvIz2jcrzSIurZw9wv+CK9PzkFmNPH7SGjZ1Xw3
        NeyNXWeHvyIrd7EM8rPCIR4s3Q==
X-Google-Smtp-Source: APiQypLL8xxkftAD1HEEO6dAhDj3U2gVVTtFbVS7xRN/wszPyHsp/aJ4gQb2O39plbjc4Gm+QZSc3g==
X-Received: by 2002:a17:902:9889:: with SMTP id s9mr13330993plp.252.1586723652257;
        Sun, 12 Apr 2020 13:34:12 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id y5sm6980350pfg.141.2020.04.12.13.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2020 13:34:11 -0700 (PDT)
Date:   Sun, 12 Apr 2020 14:34:10 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, szeder.dev@gmail.com,
        jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>
Subject: Re: [PATCH v4 00/15] Changed Paths Bloom Filters
Message-ID: <20200412203410.GA50412@syl.local>
References: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
 <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
 <ced7a793-47d9-8254-93fe-acdda8f12334@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ced7a793-47d9-8254-93fe-acdda8f12334@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Wed, Apr 08, 2020 at 11:51:14AM -0400, Derrick Stolee wrote:
> On 4/6/2020 12:59 PM, Garima Singh via GitGitGadget wrote:
> > Hey!
> >
> > The commit graph feature brought in a lot of performance improvements across
> > multiple commands. However, file based history continues to be a performance
> > pain point, especially in large repositories.
> >
> > Adopting changed path Bloom filters has been discussed on the list before,
> > and a prototype version was worked on by SZEDER Gábor, Jonathan Tan and Dr.
> > Derrick Stolee [1]. This series is based on Dr. Stolee's proof of concept in
> > [2]
> >
> > With the changes in this series, git users will be able to choose to write
> > Bloom filters to the commit-graph using the following command:
> >
> > 'git commit-graph write --changed-paths'
> >
> > Subsequent 'git log -- path' commands will use these computed Bloom filters
> > to decided which commits are worth exploring further to produce the history
> > of the provided path.
>
> I noticed Jakub was not CC'd on this email. Jakub: do you plan to re-review
> the new version? Or are you satisfied with the resolutions to your comments?
>
> Is anyone else planning to review this series?

I feel horribly that I've had this patch series sitting in my review
backlog for months and haven't gotten to it yet, especially because I
have such an interest in these patches and know that much care was taken
to prepare them.

I read through these patches over some coffee today at a cursory level.
The high-level approach makes sense to me, and the implementation looks
solid. I think that anything that does come up (see below) can be
addressed in 'next' rather than waiting longer on this series.

For what it's worth, I'm planning on starting to test this series in
some of our testing repositories at GitHub, and I'll report back on our
experience with some notes (and patches) should anything come up.

> I'm just wondering when we should take this series to cook in 'next' and
> start building things on top of it, such as "git blame" or "git log -L"
> improvements. While it cooks, any bugs or issues could be resolved with
> patches on top of this version. That would be my preference, anyway.

That would be my preference, too.

I noticed a few small things (mostly a couple of typos and other very
minor details). But, I'd much rather build on top of this series once it
has landed in 'next' than go to a fifth re-roll since there are many
patches involved.

I also noticed that you have already sent some patches in a separate
series that are based on this one, which would apply cleanly if this
series is merged into next.

I figure that this will also be helpful as I send some patches about
extra 'commit-graph write' options out of GitHub's fork, since they will
inevitably create merge conflicts if we both are targeting 'next'. So,
I figure that this approach will ease some maintainer burden ;-).

>
> What do you think, Junio?
>
> Thanks,
> -Stolee

Thanks,
Taylor
