Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BF8C4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 01:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C1160F5E
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 01:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbhG3BdY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 21:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbhG3BdV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 21:33:21 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF92C061575
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 18:33:17 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id m12so3788169qvt.1
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 18:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qeQWNK8UN+w995XKtWCdZf1LhFx6jKO2sNQe7FvGMQQ=;
        b=CHITctNVxu1+nFHqdhMkOZg4utI+ux7ZUjFylIiWeMEcIk5lQSrRi9WVjJ3PPV+F79
         NuZRUnRIWu63cBc+NAE3+3XvsUI2ul2wYXNwBqIA93H+wdM8KS8peakTfMyEHjBfIGU3
         auOo6DMwsrj9AVNOd112ECoBVZ3xcyqhNUwaZs2Aj/0LP+P5e/DmlvmpQ5W9+AiXeDTd
         qt1RFA3T4F9hjAY3A5A+kMyPypfs+1J0YIqdLff3U5cbhYzHuNqKzPqIqYwnivgis5/h
         cQJK1qAA2EfSVTT3REwrgybZHWYLVIyuBLHeLnQwl/ygCMVUy521cVyLgLUiQBOiF1DK
         6xeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qeQWNK8UN+w995XKtWCdZf1LhFx6jKO2sNQe7FvGMQQ=;
        b=dO0WYQ0gbzpvXxQ0VNW237SGq7ynU4tqZvmNRHKmnIPUz3w6sdnOOAnaVf1Dd2/r0K
         h36EAJP5KwpGEDkxVE6jAvD2ZSKmW3XkZ6PCsdPKSQ8OjzXhN72uJ+FpTNT3+gu46oji
         LmLFLZYcirDsOIhAw1vZNFuJ3VnqqUG3jrlpMSXKDHyiUVXzd30m40NxVVSHacDpTcCv
         PLsrpAfy8Dkgy/YGmXB2lEnxdxmwFn7maChvBRPYZ7TIAt5LcjDZd0nbKqA7HRs1/GmM
         Lm+w9XWC5lC4q/3i4UMS6ao6Mdq6edEyT9/LDdLUymxEDTFv2M01FIGNm5pA1LnsgmIx
         r7Qg==
X-Gm-Message-State: AOAM532kjDNM6trUsohnsGujDJalgOs+eNTydjwOy87bw1wyPy9DYDIE
        ROAzR6jV0dQ1W3rLZAZH6GA=
X-Google-Smtp-Source: ABdhPJzYICCu2sZyzDMdj4a9gbqMe9W7nJ7D/Gc2Pt5vuFRgKyov4P9wGg2LMDOYBljbtnSXk8xLag==
X-Received: by 2002:a0c:c612:: with SMTP id v18mr306529qvi.20.1627608797064;
        Thu, 29 Jul 2021 18:33:17 -0700 (PDT)
Received: from localhost ([24.169.20.255])
        by smtp.gmail.com with ESMTPSA id i67sm104224qkd.90.2021.07.29.18.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 18:33:16 -0700 (PDT)
Date:   Thu, 29 Jul 2021 21:33:15 -0400
From:   Ben Boeckel <mathstuf@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 0/1] Improve automatic setup of tracking for new branches
Message-ID: <YQNW27NAHbET5CeH@erythro.dev.benboeckel.internal>
References: <20210728135041.501850-1-mathstuf@gmail.com>
 <20210729020125.746206-1-mathstuf@gmail.com>
 <xmqqim0s394n.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqim0s394n.fsf@gitster.g>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 29, 2021 at 18:04:08 -0700, Junio C Hamano wrote:
> Ben Boeckel <mathstuf@gmail.com> writes:
> > I searched the docs (including `Documentation/gitworkflows.txt`), but
> > didn't see anywhere to describe the fork-based workflow common on forges
> > (such as GitHub and GitLab) where this felt "at home".
> 
> Before you came, many users have used Git with these forges, so it
> might be just the matter of correct terminology to use to find what
> to read about.  Does the keyword "triangular workflow" find what may
> help your way of working?

Oh, I'm familiar with it, I just didn't see a place which discussed it
in the docs with respect to it as a *workflow*. The existing references
are about the `@{push}`…selector (is there a name for these `@{}`
suffixes as a collection?) and a note under "Future Work" in
partial-clone. Neither of these seemed like relevant places to discuss
how to set up remotes and tracking branches for the triangular workflow.
I would expect it to be discussed in `gitworkflows.txt`, but I think
such an addition is worthy of its own patchset rather than tacking it
onto this.

Thanks,

--Ben
