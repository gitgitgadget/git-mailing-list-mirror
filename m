Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECF8C4363E
	for <git@archiver.kernel.org>; Mon, 17 May 2021 14:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B742361D50
	for <git@archiver.kernel.org>; Mon, 17 May 2021 14:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240961AbhEQOrH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 10:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240999AbhEQOl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 10:41:57 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D77BC08C5EE
        for <git@vger.kernel.org>; Mon, 17 May 2021 07:16:15 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id v18so3128962qvx.10
        for <git@vger.kernel.org>; Mon, 17 May 2021 07:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vxk2CW0WP5H+y05YhR1GQoBfn8BDDjJDa3Jy880pje4=;
        b=R2cyj58OK17R3QUD1VOry/Jg1ulksSWP6Wwg1Wz/vMpa3ojhFDqBpTyhgf+jVZKaBz
         Efg8QEXv33VClgLFp9iWA+ZwH6T/O10CQkkgd5S+/aIblUMg20sTXz5XXKe/JNKPhQZP
         CI10KTfbEYRNc3XWLtCXlttSjYcpffeWKM/hay3h+PAHCaxk6/aKh0ysvbM68VXKXN5H
         E/LqhccYWuWV9WorLzxqEm1c3R0+F5203oClNg5oCIL2kMo0Cl8jai8X4NbdmGe6txgL
         WyAF/KvJ2ruNt+63AqsKMKJjSCDN2hpVR4hcE+ZWsVzAQ+9fFqQ7hR8jvXggsVm849YB
         8/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vxk2CW0WP5H+y05YhR1GQoBfn8BDDjJDa3Jy880pje4=;
        b=QjgkecxycqE1UZnmajdtaA8uuKJReEtNQbO9uc7jjpWYX1K1nUtlBI0o1oaGIuFUwS
         xqJGds7maFipfzPTYUWcdhWDnSEyMFVaA/vFxiDOlSV/lam6yUZSqPoG8dLCEQ3FXRJW
         13CvYsVWallmqKdJ5ZprRPr61JUT8JiexdOjtCHGZVjtLJQDqk2uGt6HOuELETrA+gmx
         yVlLAF/HNHP2HsVN7kXtOFgtYP2Ubl62iJHnQc4+MIJcSFOhjgZHN4pJ7LIcPjA98ePH
         ba3jdB9EiwSK7//u2xLSXpXZ52cgFyPVFIl42mo05WZP2n+Poum93YmBqW7wdyhNfQyx
         VvUA==
X-Gm-Message-State: AOAM532atI+0Oo3zOG7yQahqBP+gpGGeB+QOYnJRtvSWcLddFPWperCX
        KjV7QXHVj8Skwcn1H1le+jRv0MU2OBgLcQ==
X-Google-Smtp-Source: ABdhPJxElwdWb0QaDIyDvqNNdgUopYiEH5VA7Yi8/mDvGSC5MTnf9gyTpxmFDbDXkDTyC4SSvs6atg==
X-Received: by 2002:a0c:a483:: with SMTP id x3mr154495qvx.28.1621260974447;
        Mon, 17 May 2021 07:16:14 -0700 (PDT)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:20ee:d66c:315:bb13])
        by smtp.gmail.com with ESMTPSA id j23sm8577366qtq.50.2021.05.17.07.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 07:16:14 -0700 (PDT)
Subject: Re: [PATCH v2 12/13] merge-ort: handle interactions of caching and
 rename/rename(1to1) cases
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
 <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
 <28b622a8261b8bf9190ecc9ce4189334ca553109.1620094339.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0794d786-352f-33cb-19c4-0b4671ab51b7@gmail.com>
Date:   Mon, 17 May 2021 10:16:13 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <28b622a8261b8bf9190ecc9ce4189334ca553109.1620094339.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/3/21 10:12 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> As documented in Documentation/technical/remembering-renames.txt, and as
> tested for in the two testcases in t6429 with "rename same file
> identically" in their description, there is one case where we need to
> have renames in one commit NOT be cached for the next commit in our
> rebase sequence -- namely, rename/rename(1to1) cases.  Rather than
> specifically trying to uncache those and fix up dir_rename_counts() to
> match (which would also be valid but more work), we simply disable the
> optimization when this really rare type of rename occurs.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/merge-ort.c b/merge-ort.c
> index 741970cd05e7..2fc98b803d1c 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -2100,6 +2100,9 @@ static int process_renames(struct merge_options *opt,
>  			VERIFY_CI(side2);
>  
>  			if (!strcmp(pathnames[1], pathnames[2])) {
> +				struct rename_info *ri = &opt->priv->renames;
> +				int j;
> +
>  				/* Both sides renamed the same way */
>  				assert(side1 == side2);
>  				memcpy(&side1->stages[0], &base->stages[0],
> @@ -2109,6 +2112,16 @@ static int process_renames(struct merge_options *opt,
>  				base->merged.is_null = 1;
>  				base->merged.clean = 1;
>  
> +				/*
> +				 * Disable remembering renames optimization;
> +				 * rename/rename(1to1) is incredibly rare, and
> +				 * just disabling the optimization is easier
> +				 * than purging cached_pairs,
> +				 * cached_target_names, and dir_rename_counts.
> +				 */
> +				for (j = 0; j < 3; j++)
> +					ri->merge_trees[j] = NULL;
> +

nit: it might be helpful to initialize ri closer to when it will
be used, just to have the value of 'ri' be easier to find when
looking at this loop.

> @@ -3896,7 +3909,22 @@ static void merge_check_renames_reusable(struct merge_options *opt,
>  
>  	renames = &opti->renames;
>  	merge_trees = renames->merge_trees;
> -	/* merge_trees[0..2] will only be NULL if opti is */
> +
> +	/*
> +	 * Handle case where previous merge operation did not want cache to
> +	 * take effect, e.g. because rename/rename(1to1) makes it invalid.
> +	 */
> +	if (!merge_trees[0]) {
> +		assert(!merge_trees[0] && !merge_trees[1] && !merge_trees[2]);
> +		renames->cached_pairs_valid_side = 0; /* neither side valid */
> +		return;
> +	}
> +
> +	/*
> +	 * Handle other cases; note that merge_trees[0..2] will only
> +	 * be NULL if opti is, or if all three were manually set to
> +	 * NULL by e.g. rename/rename(1to1) handling.
> +	 */
>  	assert(merge_trees[0] && merge_trees[1] && merge_trees[2]);

Thanks,
-Stolee
