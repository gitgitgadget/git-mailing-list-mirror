Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E05FC04FE0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 16:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236334AbjHJQA6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 12:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236300AbjHJQAr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 12:00:47 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5596E7F
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 09:00:45 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-c5ffb6cda23so1033435276.0
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 09:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691683245; x=1692288045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t4wfN92lFGmQi6We+dulZJR/U/5KNhIvZQrN3jPhu8k=;
        b=pUdundQIgmxXoZhpX1FAYedRnB7HJ4StV20F7NnIqNDheg8BRBumBEGGOG3PAqqXpk
         KoZK6w9TWggbYUiyqZRzNbolxkGdS0SWCbmHVjqH5UfHPUQ2IkiljeIC6iMqh/crdI8L
         GBPAy1P7bcac63gKS6lXDyOOoURGgxXwF+smx595lwo2qY9rvepgcI24KL0lJ93E+das
         WuuK6rWSHu8HUq771Uj9pegUJlUzCxQcVMvbglbaiKgNCWvcGLRv1FktfDJobLcG4Uc5
         qMOIFQt8pAwjCivWCJkOCUhC/lhxmSN7sdB9PuaIpaG9QiC+/FSZDhtdBBj7JtaFz/6M
         ib4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691683245; x=1692288045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4wfN92lFGmQi6We+dulZJR/U/5KNhIvZQrN3jPhu8k=;
        b=QFPofpy3a5shuu65hGt1G+JC3QWTwU4nNMdPNs/tsgRYKUcKNUjwqIDvP/TbjMeFhE
         LQx8EdBvkdv6zQL8RzbXGBLbbAi3RNNCWmuT+mWDuPQy7B+DysnEnbE7Z7la8OoOZJLE
         GM5dWN2AVm1UpspkMI0Zn9SSV4pd2bh4nMyfXAh9LNQt95QcAmEO51imzjO20FNa9a6+
         eT8LTTsiURPTUs7RnJvH0CtcNq3N6Bi2H14jZBg3Xj3/dMWW9V8AfSg11IjUnE/u2YHW
         6urCcu2XgNDfOLIV9nz0pReLFATDyHHWK4l870BFr7usitFdxBcXeZoU8ofNhCN9EKzO
         f/OQ==
X-Gm-Message-State: AOJu0Yws0G1RQqIb22v22UND76MyyijrI6W9LY3AJeeOko6XyE50hR4a
        QVFgipAPaDq3zEMbFjIOmW9h1w==
X-Google-Smtp-Source: AGHT+IGiJwLJSZFAQs6022wE1w2L0Ua9LwwBbMDvkUTTcNgoB56xEVINgXNJRaKUaZKCuFqLnAXRrw==
X-Received: by 2002:a25:680e:0:b0:d12:1094:2036 with SMTP id d14-20020a25680e000000b00d1210942036mr2890616ybc.43.1691683244964;
        Thu, 10 Aug 2023 09:00:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j71-20020a25d24a000000b00c5fc63686f1sm417318ybg.16.2023.08.10.09.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:00:44 -0700 (PDT)
Date:   Thu, 10 Aug 2023 12:00:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [RFC/PATCH] commit-graph: verify swapped zero/non-zero
 generation cases
Message-ID: <ZNUJq2nFEDHwrF0U@nand.local>
References: <20230808191536.GA4033224@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230808191536.GA4033224@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 08, 2023 at 03:15:36PM -0400, Jeff King wrote:
> This is marked as RFC because I'm still confused about a lot of things.
> For one, my explanation above about what the code is doing is mostly a
> guess. It _looks_ to me like that's what the existing check is trying to
> do. But if so, then why is the generation_zero flag defined outside the
> loop over each object? I'd think it would be a per-object thing.

I thought the same thing initially, but looking back at 1373e547f7
(commit-graph: verify generation number, 2018-06-27), I think the scope
of generation_zero is correct.

This is an artifact from when commit-graphs were written with all commit
generation numbers equal to zero. So I think the logic is something
like:

- If the commit-graph has a generation number of 0 for some commit, but
  we saw a non-zero value from any another commit, report it.

- Otherwise, if the commit-graph had a non-zero value for the commit's
  generation number, and we had previously seen a generation number of
  zero for some other commit, report it.

IOW, I think we expect to see either all zeros, or all non-zero values
in a single commit-graph's set of generation numbers.

Earlier in your message, you wrote:

> There's a matching GENERATION_NUMBER_EXISTS value, which in theory would
> be used to find the case that we see the entries in the opposite order:
>
>   1. When we see an entry with a non-zero generation, we set the
>      generation_zero flag to GENERATION_NUMBER_EXISTS.
>
>   2. When we later see an entry with a zero generation, we complain if
>      the flag is GENERATION_NUMBER_EXISTS.
>
> But that doesn't work; step 2 is implemented, but there is no step 1. We
> never use NUMBER_EXISTS at all, and Coverity rightly complains that step
> 2 is dead code.

So I think the missing part is setting GENERATION_NUMBER_EXISTS when we
have a non-zero generation number from the commit-graph, but have
generation_zero set to GENERATION_ZERO_EXISTS (IOW, we have seen at
least one commit with generation number 0).

--- 8< ---
diff --git a/commit-graph.c b/commit-graph.c
index 0aa1640d15..935bc15440 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2676,9 +2676,11 @@ static int verify_one_commit_graph(struct repository *r,
 				graph_report(_("commit-graph has generation number zero for commit %s, but non-zero elsewhere"),
 					     oid_to_hex(&cur_oid));
 			generation_zero = GENERATION_ZERO_EXISTS;
-		} else if (generation_zero == GENERATION_ZERO_EXISTS)
+		} else if (generation_zero == GENERATION_ZERO_EXISTS) {
 			graph_report(_("commit-graph has non-zero generation number for commit %s, but zero elsewhere"),
 				     oid_to_hex(&cur_oid));
+			generation_zero = GENERATION_NUMBER_EXISTS;
+		}

 		if (generation_zero == GENERATION_ZERO_EXISTS)
 			continue;
--- >8 ---

> So I kind of wonder if there's something I'm not getting here. Coverity
> is definitely right that our "step 2" is dead code (because we never set
> NUMBER_EXISTS). But I'm not sure if we should be deleting it, or trying
> to fix an underlying bug.

I think that above is correct in that we should be fixing an underlying
bug. But the fact that this isn't caught by our existing tests indicates
that there is a gap in coverage. Let me see if I can find a test case
that highlights this bug...

Thanks,
Taylor
