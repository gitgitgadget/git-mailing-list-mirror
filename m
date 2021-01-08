Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADFFC433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 05:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C81D6233FB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 05:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbhAHFqS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 00:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbhAHFqS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 00:46:18 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3461FC0612F4
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 21:45:38 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 15so6964311pgx.7
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 21:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=42g0YjsxyiKxLrJjQACqYAM9x5DytP3l1sW8sHgGlEo=;
        b=WtbsS9tFbSj4M++hvqBYFPlBriW01aKFnV5aUyxP10k+UhjW6gmmeRR4fWr5aP6VRo
         R6LZo5qASvHYLUVpV8crMTV7Ht4fVn9TZQ0O3joKhCsFGUEa0X4j1de2g9/fHixK1WxZ
         RARh3bx33J5STNxgWXEr3+V9ajm9GulWsfBpXNnrOj8axTThKImVemFyyCOy+ltiHGVY
         oWv23EKEfjD/X0itFcYX76z91Fl3JmWkY1Y6k3H9dMw7EDIIqgSjAR05Z+lsOovyNB/M
         W2cMskDGeAHcOe36jYIoWduyZNMsPGDmjPWl2cZrkDKm7WQQCf/XCe72oe54ne0XXfGB
         bePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=42g0YjsxyiKxLrJjQACqYAM9x5DytP3l1sW8sHgGlEo=;
        b=kXaW4bqao78ulp1myXSseySJ54fMHVoZ0yFVBItjPONnbDIMetc36GlTCKMIYO4can
         SBZjk4PK/LzRhgfqLCqv/ebH+A2rKats8n8GWMMohlfl4Ziieg0Sj7KxkqEbahZwFrsD
         bgXPW1P7KddrznyAYpWGQX229ugPd4BXTpIFBSDVKDIlJr+bai/gxO/qbo9FfDBhfWKA
         wss5wVLy3t3TIWS0LRW4I3PK5/FXUqYnOoiWrWfWKIvSBn9foPdrw71Wh7DvQeci7xjH
         i+3O2grrDumVU2Of3r6IIgYLltlUWeBLslerCEuV9MWNGX5b5ewnJBsA8cpEV+eqcDkQ
         nTSg==
X-Gm-Message-State: AOAM531i2mz+rtt+R4+USgSEIPXpBtWC3g2SSmdkHQvtoIs8iRIeO8L+
        6JhDPQca6V3pFuMYzv4Q0pA=
X-Google-Smtp-Source: ABdhPJxHpMZtcRETUHbidkUppuP2BYlxUGWT018SxehCEpwP3Qv4Wg60NDvf38vJorjXNtm4oZpLYw==
X-Received: by 2002:a63:5304:: with SMTP id h4mr5341489pgb.199.1610084737644;
        Thu, 07 Jan 2021 21:45:37 -0800 (PST)
Received: from Abhishek-Arch ([2409:4064:81c:cdaa:1c32:5945:1b72:d1f4])
        by smtp.gmail.com with ESMTPSA id cl23sm6470072pjb.23.2021.01.07.21.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 21:45:37 -0800 (PST)
Date:   Fri, 8 Jan 2021 11:15:57 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, jnareb@gmail.com, me@ttaylor.com
Subject: Re: [PATCH v5 01/11] commit-graph: fix regression when computing
 Bloom filters
Message-ID: <X/fxlVc8UK7FQRpP@Abhishek-Arch>
Reply-To: 1694688e-0253-9d67-1982-8ce483183162@gmail.com
References: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
 <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
 <c4e817abf7dbcd6c99da404507ea940305c521b6.1609154168.git.gitgitgadget@gmail.com>
 <1694688e-0253-9d67-1982-8ce483183162@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1694688e-0253-9d67-1982-8ce483183162@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 29, 2020 at 08:35:56PM -0500, Derrick Stolee wrote:
> On 12/28/2020 6:15 AM, Abhishek Kumar via GitGitGadget wrote:
> > From: Abhishek Kumar <abhishekkumar8222@gmail.com>
> > 
> > Before computing Bloom fitlers, the commit-graph machinery uses
> 
> s/fitlers/filters/
> 
> > commit_gen_cmp to sort commits by generation order for improved diff
> > performance. 3d11275505 (commit-graph: examine commits by generation
> > number, 2020-03-30) claims that this sort can reduce the time spent to
> > compute Bloom filters by nearly half.
> > 
> > But since c49c82aa4c (commit: move members graph_pos, generation to a
> > slab, 2020-06-17), this optimization is broken, since asking for a
> > 'commit_graph_generation()' directly returns GENERATION_NUMBER_INFINITY
> > while writing.
> > 
> > Not all hope is lost, though: 'commit_graph_generation()' falls back to
> > comparing commits by their date when they have equal generation number,
> > and so since c49c82aa4c is purely a date comparision function. This
> 
> s/comparision/comparison/
> 
> > heuristic is good enough that we don't seem to loose appreciable
> > performance while computing Bloom filters. Applying this patch (compared
> > with v2.29.1) speeds up computing Bloom filters by around ~4
> > seconds.
> 
> Using "~4 seconds" here is odd since there is no baseline. Which
> repository did you use?
> 

I used the linux repository, will mention that.

> Previous discussion used relative terms. Something like "speeds up by
> a factor of 1.25" or something might be interesting.
> 

As SZEDER Gábor found, the improvements are rather minor - ranging from
0.40% to 5.19% [1]. I want to make sure this is the correct way to word
in the commit message:

Applying this patch (compared with v2.30.0) speeds up computing Bloom
filters by factors ranging from 0.40% to 5.19% on various
repositories. 

https://lore.kernel.org/git/20210105094535.GN8396@szeder.dev/

> > So, avoid the useless 'commit_graph_generation()' while writing by
> > instead accessing the slab directly. This returns the newly-computed
> > generation numbers, and allows us to avoid the heuristic by directly
> > comparing generation numbers.
> 
> This introduces some timing restrictions to the ability for this
> comparison function. It would be dangerous if someone extracted
> the method for another purpose. A comment above these lines could
> warn future developers from making that mistake, but they would
> probably use the comparison functions in commit.c instead.
> 

Sure, will add a comment above.

> > Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> > ---
> >  commit-graph.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/commit-graph.c b/commit-graph.c
> > index 06f8dc1d896..caf823295f4 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -144,8 +144,8 @@ static int commit_gen_cmp(const void *va, const void *vb)
> >  	const struct commit *a = *(const struct commit **)va;
> >  	const struct commit *b = *(const struct commit **)vb;
> >  
> > -	uint32_t generation_a = commit_graph_generation(a);
> > -	uint32_t generation_b = commit_graph_generation(b);
> > +	uint32_t generation_a = commit_graph_data_at(a)->generation;
> > +	uint32_t generation_b = commit_graph_data_at(b)->generation;
> >  	/* lower generation commits first */
> >  	if (generation_a < generation_b)
> >  		return -1;
> > 
> 
