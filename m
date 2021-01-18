Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33E4C433E6
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 21:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90531229C6
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 21:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394512AbhARVKx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 16:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394464AbhARVBn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 16:01:43 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E422CC061574
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 13:00:56 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id d15so6834796qtw.12
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 13:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fEwu3GbA/a6spniryYpYqHcCzf48QnCQoqCriYNGQiE=;
        b=PxsISqoab/BPJV7TIc6o7B/oRBKeYiP4mJtS6JgxSUcQQCpXJZtFPMo1KXk/hRgUgE
         EZoSmAZgCd8IUFpXBlIVhAGFPkXV0lGz1RRMzmlRzMgV8XlofUpYIZlP0pgiz5GNnwoQ
         n/PgdrWNhEZgM0/dIH0hnrYCzBTF4aJh/8gX1vo0IcLzjs5+0txPrgCFjnYUpyhTb++9
         0U4pLY04UijXAw20X8rj00UMbZfK0j9BbQQ33KfPLDWteFxc1Ms1tlhmLbQ2kDHkc7LP
         98cTI5pRAs3y7tPQo5v/4AQcLcJCcTph3lpnEQO/joNFtoL+syVX9WbrVrEVgcDkgYul
         vyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fEwu3GbA/a6spniryYpYqHcCzf48QnCQoqCriYNGQiE=;
        b=p0n0v98dEEUFJxDWSRstW9i+YCumDakaRWN0dKyJ/V+1KqY+yvUQMbMpR8ue48gxbA
         rp/wyyTkvj0yYzgj9MS19zKClsgcin5vDnT1ORfe+djI22HGPcApvO4bh7XXiiwhvQOe
         qVOKbiAm6A7InchIRNVnBP4f4DoEPkiw+vMydbXbuyCCL/yPbT3MUt2GsZwyDgavkQMj
         AyjW4WHmQWfYgY0+5IwBDaTIUijgKAVQbCFDTFe22f9/I9kXWgn75s3sCBkwFGgGZQmx
         mX4trmAV7tQCJq7UJh6iSCDXnIUaw6O3CSCa0d1oCvcf8rUUDZJJ6FYuto76clFbnW5b
         cm/w==
X-Gm-Message-State: AOAM533iFwc7F+wJwpucdQ/hayIDrhhOoo5a4390dHoX9htm4Oo+29rP
        p/H2ntlt2tHpiJQx55byDa03xXe5W2q5Rw==
X-Google-Smtp-Source: ABdhPJzlsVj1enzhZCSLHS4vTG6+vFhZKctkquRZScFYqnRJIF6IwwZv9UC+fsw+W5BevhQFLLe/OA==
X-Received: by 2002:ac8:6b0a:: with SMTP id w10mr1462867qts.224.1611003656191;
        Mon, 18 Jan 2021 13:00:56 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:626b:1275:5dba:df42])
        by smtp.gmail.com with ESMTPSA id b12sm10897377qtj.12.2021.01.18.13.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 13:00:55 -0800 (PST)
Date:   Mon, 18 Jan 2021 16:00:53 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 08/17] merge-ort: implement
 handle_directory_level_conflicts()
Message-ID: <YAX3BdzYLyudD325@nand.local>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
 <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
 <f6efa4350d621cd955965e13329f15f4d1b91bb4.1610055365.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f6efa4350d621cd955965e13329f15f4d1b91bb4.1610055365.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 07, 2021 at 09:35:56PM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
>
> This is modelled on the version of handle_directory_level_conflicts()
> from merge-recursive.c, but is massively simplified due to the following
> factors:
>   * strmap API provides simplifications over using direct hashamp
>   * we have a dirs_removed field in struct rename_info that we have an
>     easy way to populate from collect_merge_info(); this was already
>     used in compute_rename_counts() and thus we do not need to check
>     for condition #2.
>   * The removal of condition #2 by handling it earlier in the code also
>     obviates the need to check for condition #3 -- if both sides renamed
>     a directory, meaning that the directory no longer exists on either
>     side, then neither side could have added any new files to that
>     directory, and thus there are no files whose locations we need to
>     move due to such a directory rename.
>
> In fact, the same logic that makes condition #3 irrelevant means
> condition #1 is also irrelevant so we could drop this function.
> However, it is cheap to check if both sides rename the same directory,
> and doing so can save future computation.  So, simply remove any
> directories that both sides renamed from the list of directory renames.

Beautiful.

>  static void handle_directory_level_conflicts(struct merge_options *opt)
>  {
> -	die("Not yet implemented!");
> +	struct hashmap_iter iter;
> +	struct strmap_entry *entry;
> +	struct string_list duplicated = STRING_LIST_INIT_NODUP;
> +	struct strmap *side1_dir_renames = &opt->priv->renames.dir_renames[1];
> +	struct strmap *side2_dir_renames = &opt->priv->renames.dir_renames[2];

Obviously saying "1" or "MERGE_SIDE1" are two ways of saying the same
thing, but perhaps the latter is more easily grep-able? Dunno.

> +	int i;
> +
> +	strmap_for_each_entry(side1_dir_renames, &iter, entry) {
> +		if (strmap_contains(side2_dir_renames, entry->key))
> +			string_list_append(&duplicated, entry->key);
> +	}
> +
> +	for (i=0; i<duplicated.nr; ++i) {

One small nit: this spacing and prefixed ++ reads a little oddly to me.
Perhaps:

  for (i = 0; i < duplicated.nr; i++) {

?

> +		strmap_remove(side1_dir_renames, duplicated.items[i].string, 0);
> +		strmap_remove(side2_dir_renames, duplicated.items[i].string, 0);
> +	}
> +	string_list_clear(&duplicated, 0);

And this looks like a faithful implementation of what you described
above. Thanks.

Thanks,
Taylor
