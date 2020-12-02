Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460F5C64E7C
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 08:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D898620DD4
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 08:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgLBIIx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 03:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgLBIIv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 03:08:51 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED1AC0613CF
        for <git@vger.kernel.org>; Wed,  2 Dec 2020 00:08:11 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z29so833761ybi.23
        for <git@vger.kernel.org>; Wed, 02 Dec 2020 00:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=zx2XSakvgklwZarkG14s0QxGh45/G81XJUEuxfktv+M=;
        b=mmxX+DAxfF60D2DurZa6ZgsZ/gHzNLqgsraXSeqOIwMvMHczib0z9/BQMefaVk6vz+
         wbzlb22sJU6ti+jBHsWQ5IsE6ALy2fracsJPTUtxTYoU6pykMKCxITguTQCCPemNPxAj
         jGql0DMzbeFErCyM3OQTsoQPW2BbLIt8BCr/ygN6wC330oKCqw1HC7oemxdeklH5n9eT
         I4ttieSdDXuzdtqB5cnWMS31eeB2urXu/L424FlE7CC9q+dalG5wp2n9hIDuMpQDyWVz
         u/PEUF/U4zqX5AlYQGS3IKuW6EG5SnqnLnufCXbMsktH6CNFymxZEIdoJHiGWsomGqPp
         dMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zx2XSakvgklwZarkG14s0QxGh45/G81XJUEuxfktv+M=;
        b=TDmhEZUoQmseHNzlrjXPYq4Aw+ye6AESnjW54jm0ViZqJsYmDR0TKnrjjooWzaxJuN
         7iNEzGjtgi17/aWBk8ftvgJOoudRSwxeB/59C9JIEZzLKZRYBZh/G0y3VnF+6TpRQIXJ
         spPKa9LLgVJeHDQSgJSMWMhCYfPcwip3KjmWmep84Cdfzjd3T0bUFbym4tXaaMrv27LP
         fuClmfZ78fRTrMCAs5N48cOogVXt8MLJKiw8+puU0DS300LNeFBsL0dUphZDnybwYxVZ
         XzMRxqPm5J4MsUjigaRsq0dMtPRfkEqXHPUhttserQfI+bT/kIC2NcrO2LJx8cYtT4Mn
         937w==
X-Gm-Message-State: AOAM531HNZWf+pB6KLNFoO0mPrH0RqMT/akNSFDDDaPp8qyxV8ZOByvS
        1xuD4rIcM6noFhtrqLMDjfrn10BPygUMuLWOx76G
X-Google-Smtp-Source: ABdhPJy+tdHMJhKAnG0dMLHSZZKezGHtXIPQtwPKO9ouv2E/3K2tWQYM5oej16xnx6ntQc2vzvpZiUeqkl11J11QN18C
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:d695:: with SMTP id
 n143mr1909670ybg.125.1606896491070; Wed, 02 Dec 2020 00:08:11 -0800 (PST)
Date:   Wed,  2 Dec 2020 00:08:08 -0800
In-Reply-To: <42399a1c2e52e1d055a2d0ad96af2ca4dce6b1a0.1605649533.git.me@ttaylorr.com>
Message-Id: <20201202080808.3482917-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <42399a1c2e52e1d055a2d0ad96af2ca4dce6b1a0.1605649533.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: Re: [PATCH v2 24/24] pack-bitmap-write: better reuse bitmaps
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net, martin.agren@gmail.com, szeder.dev@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> index b0493d971d..3ac90ae410 100644
> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -195,7 +195,8 @@ struct bitmap_builder {
>  };
>  
>  static void bitmap_builder_init(struct bitmap_builder *bb,
> -				struct bitmap_writer *writer)
> +				struct bitmap_writer *writer,
> +				struct bitmap_index *old_bitmap)
>  {
>  	struct rev_info revs;
>  	struct commit *commit;
> @@ -234,12 +235,26 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
>  
>  		c_ent = bb_data_at(&bb->data, commit);
>  
> +		if (old_bitmap && bitmap_for_commit(old_bitmap, commit)) {
> +			/*
> +			 * This commit has an existing bitmap, so we can
> +			 * get its bits immediately without an object
> +			 * walk. There is no need to continue walking
> +			 * beyond this commit.
> +			 */

OK - as far as I understand, the reason for continuing the walk would be
to find reverse edges that connect this commit and its ancestors so that
this commit's ancestors can contribute bitmaps to this commit, but we do
not need such contributions, so we do not need to continue the walk.
Makes sense.

> +			c_ent->maximal = 1;
> +			p = NULL;

Here, we're setting maximal without also setting a bit in this commit's
commit_mask. This is fine because we're not propagating this commit's
commit_mask to any parents (we're not continuing the walk from this
commit), but it seems like a code smell. Suggested fix is below.

> +		}
> +
>  		if (c_ent->maximal) {
>  			num_maximal++;
>  			ALLOC_GROW(bb->commits, bb->commits_nr + 1, bb->commits_alloc);
>  			bb->commits[bb->commits_nr++] = commit;
>  		}

As far as I can tell, this means that this commit occupies a bit
position in the commit mask that it doesn't need. Could this go into a
separate list instead, to be appended to bb->commits at the very end?

We could even skip the whole maximal stuff (for commits with existing
bitmaps) and replace "c_ent->maximal = 1;" above with "add to list that
we're going to append to bb->commits at the very end". That has the
advantage of not having to redefine "maximal".

>  
> +		if (!c_ent->commit_mask)
> +			continue;

I think this should be moved as far up as possible (right after
the call to bb_data_at()) and commented, something like:

  If there is no commit_mask, there is no reason to iterate over this
  commit; it is not selected (if it were, it would not have a blank
  commit mask) and all its children have existing bitmaps (see the
  comment starting with "This commit has an existing bitmap" below), so
  it does not contribute anything to the final bitmap file or its
  descendants.
