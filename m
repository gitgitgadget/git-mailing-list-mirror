Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D402C433E1
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 07:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 673F3206E6
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 07:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWtRtNQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgG3H3W (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 03:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgG3H3U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 03:29:20 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2F9C061794
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 00:29:19 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id kr4so1507426pjb.2
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 00:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=FwcwQoQ1L8Jt0JJcNHPjjABcyfL7Qfglgx47apUZDEY=;
        b=mWtRtNQvzMN85lCY7Gdb9ml/4wgxwrNbZIK8HInQdyD3p7RCjJJRN2V8zws0YeYmZA
         PnnePForfCIgYIuTFcXUwDPU9/sgtbZ8uRdKpe6PZHO0CU75SuezFNog/9DuJ2k5KGLB
         p7eZgS+tBaD6JBCbE2DvBGP32kciJUWI8bpZ05qPAKKV9IWDgFD9gW1fNlRC1kHit6ul
         e1w22fuhQyx3w2q8BQzLXYKiFLNFw0UcncYRxoWBtt/iqL21FvPbMNYdZfrUN9fptkHX
         qFj+AlTQqGc4TFdURd1ylvM6fgzmLQx2zdlCLPApjvS2RPcJ8TuuefQ0QbNttnyaP+Tm
         L5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=FwcwQoQ1L8Jt0JJcNHPjjABcyfL7Qfglgx47apUZDEY=;
        b=gj91CcY4D09nYXX6dojlu1EWHTZZmbagvkb4qTvoNlcGENH/H8rT5hBQoF013VlRGw
         LQmB7XIt7RkM4clTihzl+qG8k4ynQ6wB8voQJRsotx7gZZlTmoEXH3/gNCqK0Af6KP3S
         ISiuaVOCsrNVIskvgfuDkMfsdmbi8FOW6WXfbGIQFDR73DY6Udg3D5kzodAz7CeU1N7u
         AS4fZJixYCaEImXOfO5YQzSjVFbXZDbPS5xyDyjw25XdmhQ/CYPVmHFGpPhu+LYjcoA2
         0wVI2XiH2NSOQoT/KJ9QQLtbPiRTu5sT1FOxyynTPTmox3lka2stvDtsfB06nx6fuILU
         Irwg==
X-Gm-Message-State: AOAM532LVDMluvNAmjCDdcLJOfvFiGH5HLVMAkdc31OrtjuAKYud3YoJ
        Io6a0B48QV6M22xj30k/oLE=
X-Google-Smtp-Source: ABdhPJxCScpBoG4z/SyznHdBekQUag6z8oT204T48PA8PKTyNHAwzLEFYoNQHlmkqy5opzkWkZx2jw==
X-Received: by 2002:a17:902:db83:: with SMTP id m3mr5226663pld.68.1596094159244;
        Thu, 30 Jul 2020 00:29:19 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:208c:7cf0:d18:2f72:fb83:4831])
        by smtp.gmail.com with ESMTPSA id 129sm4883387pfv.161.2020.07.30.00.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 00:29:18 -0700 (PDT)
Date:   Thu, 30 Jul 2020 12:57:14 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org, jnareb@gmail.com,
        gitgitgadget@gmail.com
Subject: Re: [PATCH 6/6] commit-graph: implement corrected commit date offset
Message-ID: <20200730072714.GA964@Abhishek-Arch>
Reply-To: e8646aaa-667f-b7d8-f8f2-efbaaeb8877d@gmail.com
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
 <647290d0368e385227614dd1822aa9083b0dba5e.1595927632.git.gitgitgadget@gmail.com>
 <e8646aaa-667f-b7d8-f8f2-efbaaeb8877d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8646aaa-667f-b7d8-f8f2-efbaaeb8877d@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 11:55:12AM -0400, Derrick Stolee wrote:
> On 7/28/2020 5:13 AM, Abhishek Kumar via GitGitGadget wrote:
> > From: Abhishek Kumar <abhishekkumar8222@gmail.com>
> > 
> > With preparations done,...
> 
> I feel like this commit could have been made smaller by doing the
> uint32_t -> timestamp_t conversion in a separate patch. That would
> make it easier to focus on the changes to the generation number v2
> logic.
> 

Sure, would seperate into two patches.

> > let's implement corrected commit date offset.
> > We add a new commit-slab to store topological levels while writing
> 
> It's important to add: we store topological levels to ensure that older
> versions of Git will still have the performance benefits from generation
> number v1.
> 

Will do.

> > commit graph and upgrade number of struct commit_graph_data to 64-bits.
> 
> Do you mean "update the generation member in struct commit_graph_data
> to a 64-bit timestamp"? The struct itself also has the 32-bit graph_pos
> member.
> 

Yes, "update the generation number".

> > We have to touch many files, upgrading generation number from uint32_t
> > to timestamp_t.
> 
> Yes, that's why I recommend doing that in a different step.
> 
> > We drop 'detect incorrect generation number' from t5318-commit-graph.sh,
> > which tests if verify can detect if a commit graph have
> > GENERATION_NUMBER_ZERO for a commit, followed by a non-zero generation.
> > With corrected commit dates, GENERATION_NUMBER_ZERO is possible only if
> > one of dates is Unix epoch zero.
> 
> What about the topological levels? Are we caring about verifying the data
> that we start to ignore in this new version? I'm hesitant to drop this
> right now, but I'm open to it if we really don't see it as a valuable test.
> 

We haven't tested the scenario "New Git reads a commit graph without
GDAT chunk" yet. Verifying topological levels (along with many of the
changed offsets) would be a part of the scenario.

Now that I think about it, those tests should have been included with
this patch.

> > Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> 
> [...]
>
> Later you assign data->generation to be "max_corrected_commit_date + 1",
> which made me think this should be "current->date - 1". Is that so? Or,
> do we want most offsets to be one instead of zero? Is there value there?
> 

Does it? 

I had hoped most of the offsets could have been zero, as we could take
advantage of the fact that commit-slab zero initializes values and avoid
a commit-slab access.

Right, What I meant to do was:

        /*
         * max_parent_corrected_commit_date is initialized with zero and
         * takes the maximum of
         * (parent->item->date + commit_graph_data_at(parent->item)->generation)
        */

        if (max_parent_corrected_commit_date >= current->date)
        {
                struct commit_graph_data *data = commit_graph_data_at(current);
                data->generation = max_parent_corrected_commit_date + 1;
        }

Thanks for pointing this out!

> [...]

- Abhishek
