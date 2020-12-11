Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366EEC433FE
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 03:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5B3A23C16
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 03:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390777AbgLKDdj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 22:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395136AbgLKDdN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 22:33:13 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A52C0613CF
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 19:32:33 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id b18so7081008ots.0
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 19:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RcOVHtDgZgtvtT70lj7Cmv1qmyYLc5G+8o65yuetmQQ=;
        b=UJ4v70VU3BGDH/ejKucwtBOZxptiwHrww48c6gvnGBYZdncflPTrnonWRb49kR0yQq
         XphcMTUj3ifMH1SG3udhgLnd0llo/SrI1vASEAL69HbwYojZuULFNS1zWx4Ubd/7ecaP
         SelWOsszNFGEibcLErhHDCcTkhEYQnblVsN4goeZXQEXlPaIqexFWtAFR4WPVr4EppL1
         l6E8Il7rhN8Q8yc4u67cxroXMq4VXN0gCl1encEtZxz3ZbVEG+c72YBdPjbAoeMjrObz
         H3LqwZKLJNUy0FcgfzlYmXRRJeHJDYLkMdW7K/xmqUKPyCZOCFNfC/U92Tki2ssj6hUF
         OzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RcOVHtDgZgtvtT70lj7Cmv1qmyYLc5G+8o65yuetmQQ=;
        b=BVi0xaMUhIzjg2hBIh/HYmNt2CeIBhl6m9b6KNBdCxhNj266ZBT64lWzPvwIAd7eyv
         hLe78novJitA7kXeRtMibTDgPW7Wb1/BNBx4TnJ0rLaYmAT2yGMWs12O3g4FsMqmfQsY
         jUHlLpKMrr+iSvb/pzf2w/httUFg3x2OQ9vlSAHanjOHBRTby+JNb+6d3NOSmiRG+cS2
         QxghMNOxiDj88F4qvGJVh1yRrO4jZiGoCWVuQFcvhVytnNNkktoHp2gUYc63JKVc/Iog
         HSflKh7g6Wt2ldM37N9FvmNLTYSmlQPH0lrt8RUDSF1dTAeOnNSns5lRHl4RiCToMP9W
         NvSg==
X-Gm-Message-State: AOAM531E7TGmZPpc9Hmx7hVGDwbphM8dqcQkEf2LMZIzENKwaxmbgl8i
        rZ9F7qlM0hft0QSncS/k5+I=
X-Google-Smtp-Source: ABdhPJxdaeqp4mqPdD64WyCfc4anjE7Qo5fY6qL5+EVLOQLHHjUoS/URiVOA2rC0XPujFMDUyL1q6w==
X-Received: by 2002:a9d:892:: with SMTP id 18mr8685631otf.9.1607657552795;
        Thu, 10 Dec 2020 19:32:32 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:585e:c315:5afa:f8a1? ([2600:1700:e72:80a0:585e:c315:5afa:f8a1])
        by smtp.gmail.com with UTF8SMTPSA id j2sm1569492otq.78.2020.12.10.19.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 19:32:32 -0800 (PST)
Subject: Re: [PATCH 06/11] merge-ort: add implementation of both sides
 renaming identically
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
 <9c79b9f4a096afeef620ff4fc1f85525923e3d02.1607542887.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fb33f41f-ab00-fcb8-b64f-496c0e0450e7@gmail.com>
Date:   Thu, 10 Dec 2020 22:32:30 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <9c79b9f4a096afeef620ff4fc1f85525923e3d02.1607542887.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/9/2020 2:41 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Implement rename/rename(1to1) handling, i.e. both sides of history
> renaming a file but renaming the same way.  This code replaces the
> following from merge-recurisve.c:
> 
>   * all the 1to1 code in process_renames()
>   * the RENAME_ONE_FILE_TO_ONE case of process_entry()
> 
> Also, there is some shared code from merge-recursive.c for multiple
> different rename cases which we will no longer need for this case (or
> other rename cases):
> 
>   * handle_rename_normal()
>   * setup_rename_conflict_info()
> 
> The consolidation of four separate codepaths into one is made possible
> by a change in design: process_renames() tweaks the conflict_info
> entries within opt->priv->paths such that process_entry() can then
> handle all the non-rename conflict types (directory/file, modify/delete,
> etc.) orthogonally.  This means we're much less likely to miss special
> implementation of some kind of combination of conflict types (see
> commits brought in by 66c62eaec6 ("Merge branch 'en/merge-tests'",
> 2020-11-18), especially commit ef52778708 ("merge tests: expect improved
> directory/file conflict handling in ort", 2020-10-26) for more details).
> That, together with letting worktree/index updating be handled
> orthogonally in the merge_switch_to_result() function, dramatically
> simplifies the code for various special rename cases.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/merge-ort.c b/merge-ort.c
> index faec29db955..085e81196a5 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -647,14 +647,31 @@ static int process_renames(struct merge_options *opt,
>  		    !strcmp(oldpath, renames->queue[i+1]->one->path)) {
>  			/* Handle rename/rename(1to2) or rename/rename(1to1) */
>  			const char *pathnames[3];
> +			struct version_info merged;
> +			struct conflict_info *base, *side1, *side2;
> +			unsigned was_binary_blob = 0;

Since you are adding to the declarations here, I suppose it would be
reasonable to include the 1to2/1to1 split here instead of the previous
patch, if that seems useful to reduce the complexity of that patch.
  
>  			pathnames[0] = oldpath;
>  			pathnames[1] = newpath;
>  			pathnames[2] = renames->queue[i+1]->two->path;
>
> +			base = strmap_get(&opt->priv->paths, pathnames[0]);
> +			side1 = strmap_get(&opt->priv->paths, pathnames[1]);
> +			side2 = strmap_get(&opt->priv->paths, pathnames[2]);
> +
> +			VERIFY_CI(base);
> +			VERIFY_CI(side1);
> +			VERIFY_CI(side2);
> +
>  			if (!strcmp(pathnames[1], pathnames[2])) {
> -				/* Both sides renamed the same way. */
> -				die("Not yet implemented");
> +				/* Both sides renamed the same way */
> +				assert(side1 == side2);
> +				memcpy(&side1->stages[0], &base->stages[0],
> +				       sizeof(merged));
> +				side1->filemask |= (1 << 0);
> +				/* Mark base as resolved by removal */
> +				base->merged.is_null = 1;
> +				base->merged.clean = 1;

Looks good.

Thanks,
-Stolee

