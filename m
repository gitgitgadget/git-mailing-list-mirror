Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C917AC47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 11:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99533206A5
	for <git@archiver.kernel.org>; Tue,  5 May 2020 11:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+OMza9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgEELfc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 07:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725766AbgEELfc (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 07:35:32 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0970BC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 04:35:32 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 72so1350199otu.1
        for <git@vger.kernel.org>; Tue, 05 May 2020 04:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZQMu5UsYDcgRPad78mx102v2NEvJv7YB07IXGrHpa1Y=;
        b=P+OMza9+NSNkEnOedYey2ELPLVrOlvgcH6NGOFA8MH/QNzN3BBkSUAUxpVGauTgH6W
         pAGymYggzRDO1jpM9C470AflLxyKIojEqeyeOXyK6VbKgv9wvP1BDkaQBWrhL/5VI8Gi
         065Baq8IQRe0PjdYkz0+va1qGthCLoJHKF9ZJeOsrXxS62EJ26kJTkcl/WHycReA7T65
         xD65moyC6EeBP6ZWDEPsjiPIU0gSftudPejCDeKE7jreEdN0TFsmE4BWDbiqwpRvV0IF
         gBBmSVZEbjHJYHL7DoKHkTFGhxKyyh8m/j8J6y2afs7bdVu/oXij7DNkhdOzNhHetEw7
         NAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZQMu5UsYDcgRPad78mx102v2NEvJv7YB07IXGrHpa1Y=;
        b=HZaMJtbDSz0XbAm3M2onskHd07QmQwFQyr16zA4BwqkGu0ha3+RqxUTgtQVdHe4Wg5
         GcB8+A8/97bX4ZZmkWn3g6kjqe3HhF6XA4OsjWt1eJAvP8QtyI2d3fgXZ/D2ERjdx8hH
         DMqebME/yTi1KMJQ74hvIxci4Y4AdX1S/ktuL/VllvKD5pFLWRC3aUdtvUFSIWlC33tr
         BUDK80BgC22SAR+R50DVd63+los4mDJDWqBhG4ZWnoI7KtVDgLTmEmaT4oqECaSM8tmF
         TBX28VwI9wvtE4dmW9E3Y9yrVPfxHkiS3bwbQE/bz7zQipR4mg+p4HTMdcFc9MxKAy1Q
         YI6Q==
X-Gm-Message-State: AGi0PuYbQheQoSCCeYTlBo7BxRdWDJNNDZCCg33cbFBL0sdih25Ddrph
        oe1VLlYqHJvsBKWFLunzR26nQG64Tbg=
X-Google-Smtp-Source: APiQypJUr/BJhqhI0qQ02Mf1rs28Zgid03Gssfx6rMBVeBMRe64v2DND05BYAB0x0cdlCuzBfwdtWg==
X-Received: by 2002:a05:6830:1e8d:: with SMTP id n13mr1730446otr.217.1588678531280;
        Tue, 05 May 2020 04:35:31 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id l19sm551649otp.16.2020.05.05.04.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 04:35:30 -0700 (PDT)
Subject: Re: [PATCH 0/8] commit-graph: drop CHECK_OIDS, peel in callers
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
References: <cover.1588641176.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bc41469c-a55a-49a4-5e2e-096bbdd52751@gmail.com>
Date:   Tue, 5 May 2020 07:35:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <cover.1588641176.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/4/2020 9:13 PM, Taylor Blau wrote:
> Hi,
> 
> These are a few patches to address [1]

We seem to be missing links [1] and [2].

>   - It is often convenient to pipe the output of 'git for-each-ref' into
>     'git commit-graph write --stdin-commits', but handling multi-layer
>     tags is frustrating (at the very least, you have to peel them
>     yourself in 'for-each-ref', incurring a higher-than-necessary cost
>     outside of the commit-graph invocation)
> 
>   - It would be much more convenient if 'git commit-graph write
>     --stdin-commits' ignored OIDs that peel down to non-commit objects
>     silently, while still warning the caller about objects that (a)
>     don't exist, or (b) invalid hash inputs (for e.g., "HEAD", or
>     "refs/heads/foo").
> 
>   - By making this change, we are allowing *more* possible behaviors
>     than in previous versions, and the only case that we are breaking
>     (that 'git commit-graph write --stdin-commits' complains on
>     non-commit OIDs) can be addressed by peeling outside of
>     'commit-graph write' [2].

I agree that these are worthy goals. If someone was _depending_ on
the "git commit-graph write" command to _fail_, then they chose a
strange way to discover a ref that points to a non-commit.

> The first six patches move peeling refs out from the commit-graph
> internals, and into the callers.
> 
> This has no impact on the '--stdin-commits' case, but is a potential
> improvement for '--reachable', where it is more efficient to call
> 'peel_ref()' than 'lookup_commit_reference_gently()'. There is an
> intermediate state (that is resolved in the final patch) where we can
> have more than one progress meter (since the progress meter moved with
> the perhaps-expensive operations out of the commit-graph internals,
> too), but the final patch addresses this.

Interesting. I'll be sure to look carefully at this progress handling
as this has potential to lose our progress options. I expect that you
were careful about this.

> The last two patches lift the restriction on input to '--stdin-commits'
> resolving to commit objects, instead making the behavior to silently
> drop non-commit OIDs, and continue complain about invalid OIDs, and
> valid-but-missing OIDs.
> 
> Finally, this topic isn't based on anything that isn't already in
> 'master', so I think the days of many tangle commit-graph topics are
> behind us.

Woo!

-Stolee

