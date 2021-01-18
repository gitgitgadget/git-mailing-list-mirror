Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06865C433E0
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 16:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C713A22BE9
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 16:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404434AbhARQIj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 11:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406039AbhARQFI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 11:05:08 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0039C061757
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 08:04:28 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id z6so4502825qtn.0
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 08:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tVwToxfc2EWL5sENmiEP3KSRIL52tU6GRfetWtklPZY=;
        b=mROp1XffP7TbTHVi8WP9ZDiPNEE/tnPM3T+GuZLvcoPAKSS/NNOjD4N3CrNbGuSxA2
         0lIarZ0r8HOXCACUpuFfJUPpe6dA6foSks01m0IMAPRDOvNf0NOMgGq632S5wNEad2kv
         /kn/j0k7+9izVpuBNuZCX9ZvvAEaIkkKS1yfHRitp67Mx58tAQujtwEVgZ6LlcjRWHdq
         Wt9A5tQVduSZAykPLkCE9M2EGc9DBHAh0hxdQRSyHyFYKhwHeeDnX9w3z6h+uP5zglag
         VQ4rcX5xd5dkZeJO0E+6xH3Tes7oxbfqS//szuiNdvHBduR5H82FTcbLvlLSn4yy/KNt
         82BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tVwToxfc2EWL5sENmiEP3KSRIL52tU6GRfetWtklPZY=;
        b=jXxmEgxjER2KZQx59THMkTm5r5Rk3WBILTmWG9ypme6DRF76KXZbzcz7O351dap813
         0kdC6/YUTuamngs6nZrTXJVBSv0UUfLlXDWmqLCGUHeHlsPcySN6asv4Ul3tfaEaXkUY
         yxVBSfS/GEPknm/ypjnnfv5p1cL61nfo+Wox0gdq++tk1w8aQOKO8UvYpf0WyGxIHmiP
         8V/RsUcFayAULihGXTFaatn5B6Q/6JGnOeWPSwnhYUwYC+xf0PlYYRdXtssshgGnXXxY
         mf3jbZ+3khjzYjm+BpXi5oNdqEbGGRJiJX8vRsy2ESLSRem9JEEqV7VDTgJSQknaObTX
         c5nQ==
X-Gm-Message-State: AOAM533GYX0lgPGSFRsI5jTUnNDO+pG2qU5eTYNyZbCFV8k+5sm7+UiD
        6tWoT3zUUxSpG1zA8bPnNzqLOy6zHfrBww==
X-Google-Smtp-Source: ABdhPJyHIZSJwI0GM4RAnstPlqGTl7EATgHeNgKKkfQoUKPV5IveDo4XHaziSdYSflPvxnRTuSbEYw==
X-Received: by 2002:ac8:4894:: with SMTP id i20mr294340qtq.244.1610985866444;
        Mon, 18 Jan 2021 08:04:26 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:2483:e3d9:d273:1d4b])
        by smtp.gmail.com with ESMTPSA id q3sm10981263qkq.118.2021.01.18.08.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 08:04:25 -0800 (PST)
Date:   Mon, 18 Jan 2021 11:04:23 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/2] t7900: clean up some broken refs
Message-ID: <YAWxh8O/XlxIfcv3@nand.local>
References: <pull.838.git.1610940216.gitgitgadget@gmail.com>
 <616b73a6556824fb94753cfcc62bf01d36b8b311.1610940216.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <616b73a6556824fb94753cfcc62bf01d36b8b311.1610940216.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 18, 2021 at 03:23:36AM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The tests for the 'prefetch' task create remotes and fetch refs into
> 'refs/prefetch/<remote>/' and tags into 'refs/tags/'. These tests use
> the remotes to create objects not intended to be seen by the "local"
> repository.
>
> In that sense, the incrmental-repack tasks did not have these objects
> and refs in mind. That test replaces the object directory with a
> specific pack-file layout for testing the batch-size logic. However,
> this causes some operations to start showing warnings such as:
>
>  error: refs/prefetch/remote1/one does not point to a valid object!
>  error: refs/tags/one does not point to a valid object!
>
> This only shows up if you run the tests verbosely and watch the output.
> It caught my eye and I _thought_ that there was a bug where 'git gc' or
> 'git repack' wouldn't check 'refs/prefetch/' before pruning objects.
> That is incorrect. Those commands do handle 'refs/prefetch/' correctly.

Do you think it would be worth checking that 'does not point to a valid
object' doesn't appear in the output?

> All that is left is to clean up the tests in t7900-maintenance.sh to
> remove these tags and refs that are not being repacked for the
> incremental-repack tests.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t7900-maintenance.sh | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index f9031cbb44b..6be9d42767a 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -256,6 +256,11 @@ test_expect_success 'incremental-repack task' '
>  	HEAD
>  	^HEAD~1
>  	EOF
> +
> +	# Replace the object directory with this pack layout.
> +	# However, it does not include all objects from the remotes.
> +	rm -rf .git/refs/prefetch &&
> +	rm -rf .git/refs/tags &&

Hmm. Makes sense, but this will certainly need to be updated to work
with reftables, and it would break if you ran 'git pack-refs'.

Perhaps instead:

  git for-each-ref --format='delete %(refname)' \
    refs/prefetch refs/tags >refs &&
  git update-ref --stdin <refs

?

Thanks,
Taylor
