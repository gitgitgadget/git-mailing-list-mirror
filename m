Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4836A1F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 19:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755077AbdKMTsM (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 14:48:12 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:46118 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755205AbdKMTsF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 14:48:05 -0500
Received: by mail-qk0-f172.google.com with SMTP id o6so21263467qkh.3
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 11:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RXZhBz4iUvAEUBij3Dxac1jwtBakGkM58NKl3hWRvqo=;
        b=pv1nr7DXAE8hyFvqoihMWq5JCbsFcokkLUiVFoJt7LfV7NzqWydNh0hhWyR4ULQT1x
         6UNk/qqCSyhaqIeTEKEYueYFXc/YGgh565gFhX1qKxdH6QNV7xqsSKug/l9/jMzcoI0j
         ME6fPiSD7zXr5ywjC0xwkgwweCOvPRcP0haqyFxJGA13S+tlyd3sgl6EcV9HMhbooX7o
         NolxT6jrlE9Pqns3rvzPRi8y6+MkcoNfzwOLz6rkVW2ZhJlQYHCtgVZf/KPboLq4a3gh
         fyxAFV8xluovXj8ZhO2E7tKWlmuZihP60xPgSseSQURa4RQYNeseQk+Qa2BtR7VJKjR1
         1G0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RXZhBz4iUvAEUBij3Dxac1jwtBakGkM58NKl3hWRvqo=;
        b=nCtTEb04zaBRknC6FX9VOSseBm4w8BNB76DkFbxdlxXM1UPeJWWkuTB+cc7bk4hBOq
         o9dFDgj+Z6EmliWfQOQhlbnShzC6zK0uXxLPCIW0YXqXgf9iChVnu6AGpnyFK6wXixDI
         z20uwTMhy873dvovRWlt4aNHICDEhtC3m6iRcwj9MGukIesAPOygSeyG76KVYXyH+wy5
         j63fwkRoX5ZiGBKztHF3xTztkGCeFSzlIKsv787Dy/1Cgj///NXxLHMSxIqxjcmOPCNa
         ds4LIxC6qMvC5fZl4CiYj2OIwKikH/mozI7VQ6DVNxMh/K9nXuU9gWUX9RwSYkisvjf4
         4v/w==
X-Gm-Message-State: AJaThX6MzG2bFLkT8YPArIPLnlTe4Jx8fA5oUf+bFdMSv79xMQHN0U6a
        VYafQSGURPvjSVt6kY8zWeSWIHOUJKQ3xshWn09AgQ==
X-Google-Smtp-Source: AGs4zMZj7qsN1Fi39SaTeQPrf5Yly+8ZsTfia/1NsYABtMuRjPQXYby+OmWjMf01ggr3Db+1NB3Qq8LF3wO8SMWNRIc=
X-Received: by 10.55.129.70 with SMTP id c67mr16355918qkd.230.1510602484797;
 Mon, 13 Nov 2017 11:48:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 13 Nov 2017 11:48:04 -0800 (PST)
In-Reply-To: <20171110190550.27059-3-newren@gmail.com>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-3-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Nov 2017 11:48:04 -0800
Message-ID: <CAGZ79kYXbvDL_SoEENf60DsDFA-yEWfvgv8bNv_v+mw042ZH=w@mail.gmail.com>
Subject: Re: [PATCH 02/30] merge-recursive: Fix logic ordering issue
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 10, 2017 at 11:05 AM, Elijah Newren <newren@gmail.com> wrote:
> merge_trees() did a variety of work, including:
>   * Calling get_unmerged() to get unmerged entries
>   * Calling record_df_conflict_files() with all unmerged entries to
>     do some work to ensure we could handle D/F conflicts correctly
>   * Calling get_renames() to check for renames.
>
> An easily overlooked issue is that get_renames() can create more
> unmerged entries and add them to the list, which have the possibility of
> being involved in D/F conflicts.

I presume these are created via insert_stage_data called in
get_renames, when the path entry is not found?

> So the call to
> record_df_conflict_files() should really be moved after all the rename
> detection.  I didn't come up with any testcases demonstrating any bugs
> with the old ordering, but I suspect there were some for both normal
> renames and for directory renames.  Fix the ordering.

It is hard to trace this down, though looking at
3af244caa8 (Cumulative update of merge-recursive in C, 2006-07-27)
may help us reason about it.

How would a bug look like?

>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-recursive.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 1d3f8f0d22..52521faf09 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1981,10 +1981,10 @@ int merge_trees(struct merge_options *o,
>                 get_files_dirs(o, merge);
>
>                 entries = get_unmerged();
> -               record_df_conflict_files(o, entries);
>                 re_head  = get_renames(o, head, common, head, merge, entries);
>                 re_merge = get_renames(o, merge, common, head, merge, entries);
>                 clean = process_renames(o, re_head, re_merge);
> +               record_df_conflict_files(o, entries);
>                 if (clean < 0)
>                         goto cleanup;
>                 for (i = entries->nr-1; 0 <= i; i--) {
> --
> 2.15.0.5.g9567be9905
>
