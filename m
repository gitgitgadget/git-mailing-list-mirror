Return-Path: <SRS0=iBdC=IG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A0DC433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 13:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3E0065200
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 13:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhCHNGN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 08:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhCHNGE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 08:06:04 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85011C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 05:06:03 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id bm21so20234779ejb.4
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 05:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Sp4GKfh8YqL0Zqk0a/BN/4755ALpdMojXMo1U58DYrs=;
        b=QR9CPcQ57NnjmE593m9Nhs0xrXjNv31JYl0mI2WtKPBs2k56h+ldjAUuTQasiPnzm1
         6g8g52sEkMIXhfStcnvR3ZcHNPLriAz3DcnObd2JOt7kOEwd7hyvGkMfK4CpKSwd2RUV
         FLcydw80cE+ONqnfmrpNo9Xigc0RY71Ey6NPeRx2WANIR8nUixBMTBjgTvU8ausr2q6i
         1XLxzdc2VMtqLCKNm9q4S2x2iPzrvhIj5RHjfymj7yOpRoW8Xad55wj2g92L51kO762Z
         Y+zap7rBecQoEjgY2CPb1/4uCiL8C6cciiwQno1xhHO2LY5AEelh8ohanffGVGKi8Qwv
         Q5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Sp4GKfh8YqL0Zqk0a/BN/4755ALpdMojXMo1U58DYrs=;
        b=sJeM5kBbNKapGQ8ic9DIqlQBElbDl3Y+1fm5GvjVEIS7i1YacE9o6GDRQrjq+DVGX1
         A5OsXZR/wjx+sHkf9hgs/EICt9KCqJ0xDBwXJLpKL8Ridi9QofC3LIiFHsFEzKPyHA4H
         /Fd7IqUC9CBeFRSospbXnCqeezleuLVYt/NWkd7ID0WFcy0nkilQeTRtly4w9vMTWe2i
         EaIOGD7ZOeda6jZmvHnOHdSWwMIVCEINFreSmEDg+nt+9JkyqVjxpT+Zfa2LvNGB3FmU
         Xd2i8IGOiyB6So6vdUqRrIYYt0ZD/mYtnuOk7IwrEX3lkHY1ZBbYtDxJCVCjM8c3nEWB
         BhVg==
X-Gm-Message-State: AOAM532fXa5rW90vrLjvGKkgtIMYwy0byk+8YJvFMUg2vPOTfdSkyewS
        3xjCo8S2A2TC25gjXZMOIpynan9p5HdSRQ==
X-Google-Smtp-Source: ABdhPJx81On4JC482QaFkIbrRmy9QnbykUFel6AXbHbQXA/tpvWHxWjmlXMiBV7dqM0jHFRHW2cxSg==
X-Received: by 2002:a17:906:5e50:: with SMTP id b16mr15245637eju.272.1615208761927;
        Mon, 08 Mar 2021 05:06:01 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id v9sm6471181ejd.92.2021.03.08.05.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 05:06:01 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 08/11] merge-ort: implement CE_SKIP_WORKTREE handling
 with conflicted entries
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
 <100c0187bdfeef5c560ecd17160ed7c9a3032156.1614905738.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <100c0187bdfeef5c560ecd17160ed7c9a3032156.1614905738.git.gitgitgadget@gmail.com>
Date:   Mon, 08 Mar 2021 14:06:00 +0100
Message-ID: <871rcpkd6v.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 05 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> When merge conflicts occur in paths removed by a sparse-checkout, we
> need to unsparsify those paths (clear the SKIP_WORKTREE bit), and write
> out the conflicted file to the working copy.  In the very unlikely case
> that someone manually put a file into the working copy at the location
> of the SKIP_WORKTREE file, we need to avoid overwriting whatever edits
> they have made and move that file to a different location first.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c                       | 43 +++++++++++++++++++++----------
>  t/t6428-merge-conflicts-sparse.sh |  4 +--
>  2 files changed, 32 insertions(+), 15 deletions(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index a998f843a1da..37b69cbe0f9a 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -3235,23 +3235,27 @@ static int checkout(struct merge_options *opt,
>  	return ret;
>  }
>  
> -static int record_conflicted_index_entries(struct merge_options *opt,
> -					   struct index_state *index,
> -					   struct strmap *paths,
> -					   struct strmap *conflicted)
> +static int record_conflicted_index_entries(struct merge_options *opt)
>  {
>  	struct hashmap_iter iter;
>  	struct strmap_entry *e;
> +	struct index_state *index = opt->repo->index;
> +	struct checkout state = CHECKOUT_INIT;
>  	int errs = 0;
>  	int original_cache_nr;
>  
> -	if (strmap_empty(conflicted))
> +	if (strmap_empty(&opt->priv->conflicted))
>  		return 0;
>  
> +	/* If any entries have skip_worktree set, we'll have to check 'em out */
> +	state.force = 1;
> +	state.quiet = 1;
> +	state.refresh_cache = 1;
> +	state.istate = index;
>  	original_cache_nr = index->cache_nr;
>  
>  	/* Put every entry from paths into plist, then sort */
> -	strmap_for_each_entry(conflicted, &iter, e) {
> +	strmap_for_each_entry(&opt->priv->conflicted, &iter, e) {
>  		const char *path = e->key;
>  		struct conflict_info *ci = e->value;
>  		int pos;
> @@ -3292,9 +3296,23 @@ static int record_conflicted_index_entries(struct merge_options *opt,
>  			 * the higher order stages.  Thus, we need override
>  			 * the CE_SKIP_WORKTREE bit and manually write those
>  			 * files to the working disk here.
> -			 *
> -			 * TODO: Implement this CE_SKIP_WORKTREE fixup.
>  			 */
> +			if (ce_skip_worktree(ce)) {
> +				struct stat st;
> +
> +				if (!lstat(path, &st)) {
> +					char *new_name = unique_path(&opt->priv->paths,
> +								     path,
> +								     "cruft");
> +
> +					path_msg(opt, path, 1,
> +						 _("Note: %s not up to date and in way of checking out conflicted version; old copy renamed to %s"),
> +						 path, new_name);

I see this follows existing uses in merge-ort.c, but I wonder if this
won't be quite unreadable on long paths, i.e.:

    <long x> renamed to <long x.new>

As opposed to:

    We had to rename your thing:
        from: <long x>
          to: <long x.new>
