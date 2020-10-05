Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E3AC4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 09:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7D7620796
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 09:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDL7MZnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgJEJ7d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 05:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgJEJ7d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 05:59:33 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA4FC0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 02:59:33 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id n14so6522508pff.6
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 02:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WWs0cD+PSXgUEhhg3KthYDtCezVfstBDWuaT/Qk8T94=;
        b=kDL7MZnE7FdnLIbQXmmdVyNXbkMQ9KE+kHnzKAzqeUpxXUqnE0V3oJVBeYOOgGPV2C
         oefLrMuFKOMDLehDyHgccJZ9u9dnz3C7zgWshM56neTMOfYHFWn7iPlk4gR9JzqCRNId
         JH9x1UemZ6islUGHTLoZRqFr0ofgNRZptLF6W79k3C0Jyk2PqfQhueyKXSiPMBlbhAJX
         RHTYwmNiChO4ad4G64+dQjfnwV0SpcI07SbWwZIA87e9Lv407kOu6AAgPA7xhgQSWzfL
         6u0qxa4xojhgGpVZCTJ+0rJcMNze+rSFCZ3//xtXVCQN4REG9N8KojujJm8IErWRYx9T
         sqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WWs0cD+PSXgUEhhg3KthYDtCezVfstBDWuaT/Qk8T94=;
        b=AWX4QP22JSlflZe6CW0N72Vl1Yl51Z9k4S0t2bAIrjEHm4t8NM4WNYXtb1svwTV3ME
         HOsb6xpvwVov5/qZQ1NsO4V7+24g8nCescQ127vn7zfVz7xqsjsBODATLwdtWg8joBuz
         4WU9+AERI+69dNq0eblZD6aHOXbhLCHpb8oAySa/1JC3VU4BtulrmYRDCokxQYeZmydj
         qITFwhj6/4Zaa4cT/KFVwXyLJP6WcFW4pPDFAlHEcSOD1Ry/+GM80jHROt3sTu++JM/B
         wZw7380vBrKVZ84yurPTI5vODwbI+c7arql7Oi7L7yOEB9DHq/OwxAeS8MlViTsvOXlg
         5I/A==
X-Gm-Message-State: AOAM5306KjFz3LJy+2tjlGRymlLaYb+AD4umjdExQHyqlwuCfX10Fdr9
        IrcAKT7bS89ANDDcKMKsyMw=
X-Google-Smtp-Source: ABdhPJzK1W2EeR5h+S1huHr+6QW43AMJR21fYlshWNoM06xMAKa89RLYXTgAgbtHnIRE3fHaBwzStg==
X-Received: by 2002:aa7:8885:0:b029:142:2501:39ea with SMTP id z5-20020aa788850000b0290142250139eamr7116302pfe.57.1601891973133;
        Mon, 05 Oct 2020 02:59:33 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id v129sm12279318pfc.76.2020.10.05.02.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 02:59:32 -0700 (PDT)
Date:   Mon, 5 Oct 2020 02:59:30 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] tests: avoid using the branch name `main`
Message-ID: <20201005095930.GO1166820@google.com>
References: <pull.743.git.1601888196.gitgitgadget@gmail.com>
 <6045ceb938836355b7d43bc2088ca2504b05dde4.1601888196.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6045ceb938836355b7d43bc2088ca2504b05dde4.1601888196.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:

> In the near future, we want to change Git's default branch name to
> `main`. In preparation for that, stop using it as a branch name in the
> test suite. Replace that branch name by `primary`.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t6012-rev-list-simplify.sh |  8 ++++----
>  t/t6400-merge-df.sh          |  8 ++++----
>  t/t6409-merge-subtree.sh     | 12 ++++++------
>  t/t6430-merge-recursive.sh   |  4 ++--
>  4 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
> index b6fa43ace0..f1296c29e6 100755
> --- a/t/t6012-rev-list-simplify.sh
> +++ b/t/t6012-rev-list-simplify.sh
> @@ -171,7 +171,7 @@ test_expect_success '--full-diff is not affected by --parents' '
>  test_expect_success 'rebuild repo' '
>  	rm -rf .git * &&
>  	git init &&
> -	git switch -c main &&
> +	git switch -c primary &&

Is there a secondary corresponding to this primary?

I guess the idea is that this is the trunk that other branches branch
from?  Looking at the history, it seems that this test was added
relatively recently and it may have had the upcoming branch name change
in mind (or in other words if it were an older test it might be expected
to use "master").

That suggests an alternative that is agnostic to init.defaultBranch:
what if this uses "git switch -C main"?

Thanks,
Jonathan
