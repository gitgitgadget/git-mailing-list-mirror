Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53E7C433EF
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 22:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiCQWM4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 18:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiCQWMy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 18:12:54 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0A52467EC
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 15:11:36 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id t6-20020a1709028c8600b001534eaec77bso3258771plo.7
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 15:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UxbAlbRpRCtcYjP1KyBV6bhakQLPPx7p0m/XKz5CfZY=;
        b=DVK6KT9L90+eilIFlqpR46Qf9X5i4IEH/qq2F8H9XwA6leut+OiSbLiTC+6wbGZ2sq
         mfkI0S2D9RkQ0AsoQBN++V6IlNR1DF150Uhsbf354TR7sC4Vgd37OpL86wxHFlrgWu/f
         WZqQYhO+HWGhqa/OAtk4H8bfgSRgcsWVA2a+Vi9MwLfgGByNuZ6Bvf+a+A3PGioczDuX
         SpGD1XkEqpHcUGOQiZxfk+EtiTGvzYykp8BYnxs8Y8Yv3Ju/d9uV4oYlC3bpLQT9vu9b
         XBbf3SojHpnHcJ5i+oucdkQ7RpfdY4DFXdSTMTZVZXXTsRYJcAGfDUrrj1l8MbpFbXKb
         lnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UxbAlbRpRCtcYjP1KyBV6bhakQLPPx7p0m/XKz5CfZY=;
        b=GTEPYE+e1HJGnVYEjbVFsUEZt+xnuvrLVKlwUL696/GgGZ/tJVWQcsWad3Equ476l6
         5/tkDKIuQ6Nk05bAKv4rIlesSxVe6csM2pxYXU/VjBDK/qPIFlefwSrebtcGLVhAtZ52
         fNx+RHUdwkvSiwD+Zpb0xWnVJgtfx65PaeosMj207+yxLamLdW76jC9kSSsc2kFFNDsk
         cUhnqCN8hrs2pVGvwmFDzXqqKN2MHOaiFjArbaNXpFJ4JWbDzMfQzRG4w329qjnRcbdW
         irRh+MwRT7bvB4Au/vcGdJ1efi3V8gC0vJo4I8dcVU9UmT0XeCLYBn5K45i0gMvYdGzg
         EEXg==
X-Gm-Message-State: AOAM53181+Wz451+YkTz509fX8nygWBL6HVi5LpDIPwaUkbR8Kn6/3pZ
        RlL3yKFalgyin+UksQSohrFOBzGgqvu3Aw==
X-Google-Smtp-Source: ABdhPJxZ/A7HnMgSihCDBN4M0DN/sq8QEtialwbXvIy85DDnS3aR7WD7EfBS/J7ojgZbKgnVao8HFbzmtCaBHQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:8b91:b0:1be:db25:eecd with SMTP
 id z17-20020a17090a8b9100b001bedb25eecdmr7871384pjn.10.1647555095959; Thu, 17
 Mar 2022 15:11:35 -0700 (PDT)
Date:   Thu, 17 Mar 2022 15:11:25 -0700
In-Reply-To: <20220317182448.1633847-1-jonathantanmy@google.com>
Message-Id: <kl6l4k3wkz5e.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220317182448.1633847-1-jonathantanmy@google.com>
Subject: Re: [PATCH] shallow: reset commit grafts when shallow is reset
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I'm not an expert on shallows or commit grafts, so I hesitate to give a
"Reviewed-by", but the description of the bug and fix make sense.

Jonathan Tan <jonathantanmy@google.com> writes:

> When reset_repository_shallow() is called, Git clears its cache of
> shallow information, so that if shallow information is re-requested, Git
> will read fresh data from disk instead of reusing its stale cached data.
> However, the cache of commit grafts is not likewise cleared, even though
> there are commit grafts created from shallow information.
>
> This means that if on-disk shallow information were to be updated and
> then a commit-graft-using codepath were run (for example, a revision
> walk), Git would be using stale commit graft information. This can be
> seen from the test in this patch, in which Git performs a revision walk
> (to check for changed submodules) after a fetch with --update-shallow.

Hm, as a non-expert, I wasn't able to immediately draw the link between
"reset_repository_shallow() doesn't do enough" to "we reproduce this bug
using fetch --update-shallow with submodules".

What would make this sequence of events clearer to me is describing
why reset_repository_shallow() is called. From reading receive-pack.c
and shallow.c, I believe we call reset_repository_shallow() whenever a
shallow file is written (or more specifically, whenever we commit or
rollback a shallow lock file), invalidating the cache of shallow
information.

One thing I noticed when writing my test case is that fetch without
--update-shallow would never run into this bug. But if one reads 
Documentation/fetch-options.txt:

  --update-shallow::
    By default when fetching from a shallow repository,
    `git fetch` refuses refs that require updating
    .git/shallow. This option updates .git/shallow and accept such
    refs.

it becomes pretty easy to put two and two together - fetch with
--update-shallow writes shallow files, clearing the cache of
shallows (but not commit grafts), so it thinks it has all of the correct
commit graft info. It then tries to perform a rev walk and fails.

It is also worth noting that we only do this rev walk if Git thinks that
there are submodules, as indicated by the presence of .gitmodules (or
after gc/fetch-unused-submodules, whether .git/modules is nonempty).
This would also explain why we never noticed the bug before - it only
occurs when we have both --update-shallow and submodules.

> Therefore, clear the cache of commit grafts whenever
> reset_repository_shallow() is called.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> This is the same bug noticed by Glen Choo, as can be seen by the patch
> here [1]. (That patch doesn't seem to be carried forward to subsequent
> versions of the patch set, presumably because it is not needed in that
> patch set.)
>
> I have verified that Glen's test also works with the fix in this patch.
> But I have written a test in t5537-fetch-shallow instead, as I think
> that this is more about updating shallows than fetching submodules.

Makes sense, this is more about shallows.

> [1] https://lore.kernel.org/git/20220215172318.73533-9-chooglen@google.com/
> ---
>  commit.c                 | 10 ++++++++++
>  commit.h                 |  1 +
>  shallow.c                |  1 +
>  submodule.c              |  1 +
>  t/t5537-fetch-shallow.sh |  9 +++++++++
>  5 files changed, 22 insertions(+)
>
> diff --git a/commit.c b/commit.c
> index d400f5dfa2..f8405fe46e 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -249,6 +249,16 @@ int for_each_commit_graft(each_commit_graft_fn fn, void *cb_data)
>  	return ret;
>  }
>  
> +void reset_commit_grafts(struct repository *r)
> +{
> +	int i;
> +
> +	for (i = 0; i < r->parsed_objects->grafts_nr; i++)
> +		free(r->parsed_objects->grafts[i]);
> +	r->parsed_objects->grafts_nr = 0;
> +	r->parsed_objects->commit_graft_prepared = 0;
> +}
> +
>  struct commit_buffer {
>  	void *buffer;
>  	unsigned long size;
> diff --git a/commit.h b/commit.h
> index 38cc542661..336e0bfa42 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -249,6 +249,7 @@ int commit_graft_pos(struct repository *r, const struct object_id *oid);
>  int register_commit_graft(struct repository *r, struct commit_graft *, int);
>  void prepare_commit_graft(struct repository *r);
>  struct commit_graft *lookup_commit_graft(struct repository *r, const struct object_id *oid);
> +void reset_commit_grafts(struct repository *r);
>  
>  struct commit *get_fork_point(const char *refname, struct commit *commit);
>  
> diff --git a/shallow.c b/shallow.c
> index 71e5876f37..e158be58b0 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -90,6 +90,7 @@ static void reset_repository_shallow(struct repository *r)
>  {
>  	r->parsed_objects->is_shallow = -1;
>  	stat_validity_clear(r->parsed_objects->shallow_stat);
> +	reset_commit_grafts(r);
>  }
>  

Makes sense. [un]register_shallow(), register and unregister commit
grafts correctly, so it makes sense that reset_repository_shallow()
should reset the commit grafts too. I don't see any existing functions
that reset commit grafts.

>  int commit_shallow_file(struct repository *r, struct shallow_lock *lk)
> diff --git a/submodule.c b/submodule.c
> index 5ace18a7d9..7a0515913c 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -22,6 +22,7 @@
>  #include "parse-options.h"
>  #include "object-store.h"
>  #include "commit-reach.h"
> +#include "shallow.h"
>  
>  static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
>  static int initialized_fetch_ref_tips;
> diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
> index 11d5ea54a9..92948de7a0 100755
> --- a/t/t5537-fetch-shallow.sh
> +++ b/t/t5537-fetch-shallow.sh
> @@ -161,6 +161,15 @@ test_expect_success 'fetch --update-shallow' '
>  	)
>  '
>  
> +test_expect_success 'fetch --update-shallow into a repo with submodules' '
> +	git init a-submodule &&
> +	test_commit -C a-submodule foo &&
> +	git init repo-with-sub &&
> +	git -C repo-with-sub submodule add ../a-submodule a-submodule &&
> +	git -C repo-with-sub commit -m "added submodule" &&
> +	git -C repo-with-sub fetch --update-shallow ../shallow/.git refs/heads/*:refs/remotes/shallow/*
> +'
> +
>  test_expect_success 'fetch --update-shallow (with fetch.writeCommitGraph)' '
>  	(
>  	cd shallow &&
> -- 
> 2.35.1.894.gb6a874cedc-goog
