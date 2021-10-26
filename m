Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCB5C433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 16:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20EF8610A6
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 16:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbhJZQS1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 12:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237300AbhJZQSB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 12:18:01 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB74C061767
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 09:15:37 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id s3so17990485ild.0
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 09:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Sso0CkdH7caSDxOPkFVkHZgtwKfVuV+vRGkz4G4ocjE=;
        b=HtJjF1w8CyEDVN4wREZuheADvBh5osndhmgaGEcELFvPV+5DJTvvE4ALejW4bktnMd
         LZ8a7giPeRgsN+Tc2EumEpVAPkYd9CRpDFGDiDO7jFkZEWMxR6qXTE/U9B/COX4TrvFJ
         6Pk3ggqHDNCXguooCnD9h85cNC+yEeqYFuUv9Jy9rvc5wj4jK8t6hPS7yF8spBPgv2yi
         5+yYaS3A6rRY/PW0z5y22xw4bv0/25YuwYrcvmCA4IAnVHI+2JBwWdkLUeAuiU+Rz5BQ
         EqAHRHRN3+fozMpBo2N9QdL5T3sELF1ijoYLjzjpj0jNKnpHl1Qg1Yu2LOg1M+gT+eL9
         Gs8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sso0CkdH7caSDxOPkFVkHZgtwKfVuV+vRGkz4G4ocjE=;
        b=FAy4eE+YMPL+RbIJEEnbgiNo3bbqi7zhVTkA6j4MiMjDrOD2xEkKuAv6hOBsVwX0Az
         69azr+fky0md/vI2kUkfPadGRbMJjE+u30wVDxlfy23ZFh8YNEnoOkGJHYD6EoP0O9A/
         +Pr7TMmJ7OI8fGdxvL4e+vs8Eiayv0JOlCQ56bwS297oQU40Qlp7u+iDviKN1zC+6Lxi
         rny8GQi48ZW5DWR9lvju5sTzmMv7KPWDPLytc3ejH+vGvnuWpYEiLC7Rrp0fsu1FqOj5
         C+ZNiM8CKDdHF/OLVkCapT/djsOakGaasGU/5Wpj4FA3F4bTkI/Z3b3L6nxc5Kax8OHM
         NmQQ==
X-Gm-Message-State: AOAM530r3XUBf5LF5qTZvCVbimAMbFwoinEZY9O4DmC6UZtwByXS8TSB
        9dn6WdgtCtZf6pY/79gtpB9wIg==
X-Google-Smtp-Source: ABdhPJyZ5jagu74/9AbGcr/RHYJeNa/c8LO6/yaY+4IOY6BwRgIGWx9CZK9V8dKuV2xVMRzPEyHgFw==
X-Received: by 2002:a92:d852:: with SMTP id h18mr3444433ilq.173.1635264937200;
        Tue, 26 Oct 2021 09:15:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x8sm8366588ilu.72.2021.10.26.09.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 09:15:36 -0700 (PDT)
Date:   Tue, 26 Oct 2021 12:15:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Lessley Dennington <lessleydennington@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        newren@gmail.com
Subject: Re: [PATCH v2 1/2] diff: enable and test the sparse index
Message-ID: <YXgpqJIS2OgOgS+k@nand.local>
References: <pull.1050.git.1634232352.gitgitgadget@gmail.com>
 <pull.1050.v2.git.1634332835.gitgitgadget@gmail.com>
 <ac33159d020cc0c0f6fbee36eb74fff773cb8f9f.1634332836.git.gitgitgadget@gmail.com>
 <YXcX5QWFQFIFNXo0@nand.local>
 <6e2c07e7-c66f-01c0-a64e-2e8b5b7c1f8e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e2c07e7-c66f-01c0-a64e-2e8b5b7c1f8e@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 26, 2021 at 09:10:20AM -0700, Lessley Dennington wrote:
> > But isn't the top-level directory always part of the cone? If so, I
> > think that what this (and the below test) is demonstrating is that we
> > can show changes inside of the cone without expanding the sparse-index.
> >
> > Having that test makes absolute sense to me. But I think it might also
> > make sense to have a test that creates some directory structure outside
> > of the cone, modifies it, and then ensures that both (a) those changes
> > aren't visible to `git diff` when the sparse-checkout is active and (b)
> > that running `git diff` doesn't cause the sparse-index to be expanded.
> >
> README.md is actually within the sparse checkout cone - all files at root
> are included by default. So your understanding is correct - we are ensuring
> that making a change to a file in the cone and running both diff and diff
> --staged once the file is in the index doesn't expand the sparse index.
>
> I like your idea of verifying that running diff against files outside the
> sparse checkout cone won't expand the index. I've updated the diff tests in
> v3 (which I will send out shortly) to do so.

Great, thank you! There is no hurry to send out an updated revision from
me, either. It may be good to wait a day or two and see if any other
review trickles in before sending another revision to the list that way
you can batch together updates from multiple reviewers.

Thanks,
Taylor
