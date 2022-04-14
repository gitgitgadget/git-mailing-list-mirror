Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE21C433FE
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 18:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239861AbiDNSw6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 14:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344972AbiDNSwj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 14:52:39 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34642E0ACA
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 11:50:14 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id z16so5624691pfh.3
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 11:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=qNdD8Xq8Ui4q52GAZvn6xpCjUReECoN1Xu/d0jNAPp4=;
        b=GXoZ0PAqga6q3ig1MdYCHfQy9ZfgEAUa3sNQxqpTYCd1pqQ9RYm4HhsIGgLuNEDl3Z
         XxNTbkzPFkW4G5xBPJRV7f0sHNA6YESC5dKNK4b7w+gc2u5kNRi+B7tJdm2NnRXQ20IV
         /ncZsXD1zyyRun1xiF25feYoWGs+BvfhCRf1uS6jgzSzC1nj1OBJHAO4zueH6ynuOZ4Y
         Njg6WlFskHynJRoFPM8T6EkR+Qn6mptAbVVlhR7yWtLcNU9+3TCEJhgZiYyjS4pxFNYK
         +5xCO5CoS87dDOp7LQGVLBOF5+cnf+3oeL1LJ8GF6LzNSfTBeSpmTjEcewROmq9NtKTf
         D1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=qNdD8Xq8Ui4q52GAZvn6xpCjUReECoN1Xu/d0jNAPp4=;
        b=HKQpPilFgXYS5PQYrdexaUuqf6an5S/LfH8Hq3xUYc2iIFRbc2sa/Rt/WwmS1206/g
         BNX9GsG4/7j1bHkreYwp2VnJapFqMXM9Eqe2cfaq0TzWt6MCng/a7dU5SUJ02cKGV07H
         y/G3a6Ge+EKTyVx+6LJgoLa5J7gr3Ip+DBuk0xE+RXM3fDuw9t25SXVVj67RV+zGy9L7
         FJfCbNJnBN5VVv+C67MKzb0KsZXEhBZsQFgAKQqnRnGZq+4OkqND69OhFo3rV/oSUpro
         7sPHIPJg7ADA4X9j+EZgUloeV2jP1yMKvWlPGuHdKXcucqvlkER9HdbJ48J2eii+NM+6
         GjkA==
X-Gm-Message-State: AOAM5339aLEhGWV5GaidJxzGwkuYgWe7JAk5nQkXxv89sz3PSWnPKZ5W
        gSAxQIJ9mMhTjTTVt5yRj9uMzA==
X-Google-Smtp-Source: ABdhPJzPqAHvEJCHMw75AzqIcpqjXsxXPSaznefMRzgINuXQk5o45oGXbzLsmyglzY8jFf44pfQ9Hg==
X-Received: by 2002:a63:4e45:0:b0:39d:4d2d:815e with SMTP id o5-20020a634e45000000b0039d4d2d815emr3335061pgl.198.1649962213526;
        Thu, 14 Apr 2022 11:50:13 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:c26e:8dc1:2f6e:26bc])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090a390d00b001c995e0a481sm2627026pjb.30.2022.04.14.11.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 11:50:12 -0700 (PDT)
Date:   Thu, 14 Apr 2022 11:50:06 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/4] show: integrate with the sparse index
Message-ID: <Ylhs3t9nFS/IeO2Y@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1207.git.1649349442.gitgitgadget@gmail.com>
 <27ab853a9b4f0a50880c92dd8949d6fe9b7f00ba.1649349442.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27ab853a9b4f0a50880c92dd8949d6fe9b7f00ba.1649349442.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.04.07 16:37, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The 'git show' command can take an input to request the state of an
> object in the index. This can lead to parsing the index in order to load
> a specific file entry. Without the change presented here, a sparse index
> would expand to a full one, taking much longer than usual to access a
> simple file.
> 
> There is one behavioral change that happens here, though: we now can
> find a sparse directory entry within the index! Commands that previously
> failed because we could not find an entry in the worktree or index now
> succeed because we _do_ find an entry in the index.

As with the test in the previous commit, a reminder that sparse-indexes
are not necessarily subsets of a full index could be helpful here.


> There might be more work to do to make other situations succeed when
> looking for an indexed tree, perhaps by looking at or updating the
> cache-tree extension as needed. These situations include having a full
> index or asking for a directory that is within the sparse-checkout cone
> (and hence is not a sparse directory entry in the index).
> 
> For now, we demonstrate how the sparse index integration is extremely
> simple for files outside of the cone as well as directories within the
> cone. A later change will resolve this behavior around sparse
> directories.
> 
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  builtin/log.c                            |  5 +++++
>  t/t1092-sparse-checkout-compatibility.sh | 23 +++++++++++++++++++----
>  2 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/log.c b/builtin/log.c
> index c211d66d1d0..8e2e9912ab9 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -661,6 +661,11 @@ int cmd_show(int argc, const char **argv, const char *prefix)
>  	init_log_defaults();
>  	git_config(git_log_config, NULL);
>  
> +	if (the_repository->gitdir) {
> +		prepare_repo_settings(the_repository);
> +		the_repository->settings.command_requires_full_index = 0;
> +	}
> +
>  	memset(&match_all, 0, sizeof(match_all));
>  	repo_init_revisions(the_repository, &rev, prefix);
>  	git_config(grep_config, &rev.grep_filter);
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 74792b5ebbc..f6a14e08b81 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -1159,12 +1159,20 @@ test_expect_success 'show (cached blobs/trees)' '
>  	test_sparse_match git show :folder1/a &&
>  
>  	# Asking "git show" for directories in the index
> -	# does not work as implemented. The error message is
> -	# different for a full checkout and a sparse checkout
> -	# when the directory is outside of the cone.
> +	# changes depending on the existence of a sparse index.

The wording here seems awkward after these changes are applied. Without
other context, it makes it sound to me like the command(s) used to show
a directory change depending on the existence of a sparse index, rather
than the fact that the behavior of `git show` changes.


>  	test_all_match test_must_fail git show :deep/ &&
>  	test_must_fail git -C full-checkout show :folder1/ &&
> -	test_sparse_match test_must_fail git show :folder1/
> +	test_must_fail git -C sparse-checkout show :folder1/ &&
> +
> +	git -C sparse-index show :folder1/ >actual &&
> +	git -C full-checkout show HEAD:folder1 >expect &&
> +
> +	# The output of "git show" includes the way we referenced the
> +	# objects, so strip that out.
> +	test_line_count = 4 actual &&
> +	tail -n 2 actual >actual-trunc &&
> +	tail -n 2 expect >expect-trunc &&
> +	test_cmp expect-trunc actual-trunc
>  '

It's not specific to this commit, but in general I think the series of
changes to this test would be easier to follow if we used hard-coded
strings to compare against, rather than matching parts of files against
each other. It makes it more clear to the reader exactly which behavior
is changing, and can make it more obvious why certain output is
undesirable. However, it would make the test more brittle to future
changes.


>  test_expect_success 'submodule handling' '
> @@ -1388,6 +1396,13 @@ test_expect_success 'sparse index is not expanded: diff' '
>  	ensure_not_expanded diff --cached
>  '
>  
> +test_expect_success 'sparse index is not expanded: show' '
> +	init_repos &&
> +
> +	ensure_not_expanded show :a &&
> +	ensure_not_expanded show :deep/a
> +'
> +
>  test_expect_success 'sparse index is not expanded: update-index' '
>  	init_repos &&
>  
> -- 
> gitgitgadget
> 
