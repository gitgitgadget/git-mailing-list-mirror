Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444BCC433E0
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 19:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 183BD2074B
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 19:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="HiP2EfnS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbgFATgv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 15:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbgFATgu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 15:36:50 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D56C061A0E
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 12:36:50 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y11so336344plt.12
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 12:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S6VnVkd0fM1ndSWVjEGUBCFwG0y5w/xpFaI4MUwiyOo=;
        b=HiP2EfnSd4iEkAICYmOSx20guisiXphkGyWkfeSiOUUD18jWJTcGkpzX21g8RYhOIS
         fU2eBireSkVwPV0JyUKqJJWvRZoDr8Fe1M9RL76KAGms67WPOZn3coya/dfdRPHPN3AF
         SFBKeJePUk9J+I/2z7w1o/2r+93hJ7rrfzQsbZ+SODzCQy4iGDGE5dXjloEf3QJRUb7+
         WGw91AlW6XIjJat1E+ykxj6QeaQ/8GtuIbAqF/3n8oMnzeXQj4c4HGM0VA+/J0Wt7mTI
         2RMPbaqSRes5vyBYI63Ezz29wQmAE/+fw5v+o8rfe4I/kLW5DN05h2O0knBE6rtTKl2u
         Rn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S6VnVkd0fM1ndSWVjEGUBCFwG0y5w/xpFaI4MUwiyOo=;
        b=qKszTv05Cvqo+RkAwDXUnDZfq5joPR0l1Nvn5GykWpcOeDCguLPMm3Y9CIXsYeLtLw
         jMTBtb9F1ugYM4Im0lnFDjjcZ0j+xbJvsPfthkT0CEpu4RdPReEKynp0vQeTJcPJF0Pu
         9ZJodD9+0Z1fMqZPAfLwtRDlGXsHGPysp6VkToOaRfwcUFoV8xJVGF1sFB1KKE2sy08d
         hrqsEvMj5Ku24CMgqu521TAZqxhQz0rmrjM3129IB1BKJS0UsaigXnWIDLFelbI0uDuf
         jXdmbdlwMGAZ77PdtREohxgZtQMVP+a2OgLuwaiRGmynvhz+nTnSYqQUv+tH7ziYN5ta
         tbXQ==
X-Gm-Message-State: AOAM530gKKgojmnJmgmHJIBCG3RY0jbPk69wO2SohkiO1oLpERsTxpxV
        TZtIXwBFLfuw36eY6Qw+bPpxpg==
X-Google-Smtp-Source: ABdhPJx56NYSYWWaL3veJ7bIvOf/oFlS0Kq3DObsqU6nW33cCTHUoX4cGW6FpJuhWGrd5LPWvuRJqQ==
X-Received: by 2002:a17:902:549:: with SMTP id 67mr21339179plf.115.1591040209860;
        Mon, 01 Jun 2020 12:36:49 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id b11sm180896pfd.178.2020.06.01.12.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 12:36:49 -0700 (PDT)
Date:   Mon, 1 Jun 2020 13:36:48 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 0/2] t5318: test '--stdin-commits' with '--[no-]progress'
Message-ID: <20200601193648.GA32262@syl.local>
References: <cover.1591034353.git.me@ttaylorr.com>
 <153faa41-2801-d6bc-1f48-05a0ac08b446@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <153faa41-2801-d6bc-1f48-05a0ac08b446@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 01, 2020 at 03:35:31PM -0400, Derrick Stolee wrote:
> On 6/1/2020 2:01 PM, Taylor Blau wrote:
> > Here's a short pair of patches that I wrote this morning after looking
> > at Stolee's most recent coverage report.
> >
> > The first patch is just cleanup, and the second patch is the real
> > change. It would have been nice to parameterize these tests over the
> > arguments to 'git commit graph' (ie., have three tests for 'write',
> > 'verify', and 'write --stdin-commits'), but '--stdin-commits' is special
> > since it requires input.
> >
> > These patches are based off the tip of 'next', but really only need my
> > changes from 'tb/commit-graph-no-check-oids'.
>
> The first patch is an obviously good patch, and it even has a good
> justification in the message.

Thanks.

> The second is also good. The case of forcing "--progress" would be
> enough for covering your new-ish progress meter. Perhaps the other
> tests (or at least the one specifying "--no-progress") could be
> removed, but I don't feel strongly about that.

Yeah, I don't feel strongly either. I figured that it would at least be
more consistent with the surrounding tests to have the three variants. I
guess we can see what others think, too.

> Thanks,
> -Stolee

Thanks,
Taylor
