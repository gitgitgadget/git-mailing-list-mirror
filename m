Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B46C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 21:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6AC860ED7
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 21:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbhGWUyO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 16:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbhGWUyO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 16:54:14 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C227C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 14:34:46 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id i39-20020a9d17270000b02904cf73f54f4bso1559237ota.2
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 14:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8E9frrs/O1JJ+vToAWIXip7KGfUfQcRpP7wgxdrIpfE=;
        b=nr71stfu9embLM/IunUl2n5QwzL7kLHfiye3XszNVUoWxNRfeae30JMI6BNE3VufY9
         TtR2oYtRlfNxS/cgOsqVhIVjuvS05JEheoTUCeTXqF755IX5craPzCk9tSKMgx3LWiAA
         vSZm2t9ZNWi0Eah67ByMV/Bd5RN6GQPli+n9IY7mKu4C2Q8pTs33lXGM3hUChEa+v1yd
         pup+A/Iix+R0f/HTbyOY+ktJEhkLEjNbRRUNllDOL7NomfB6NXQ/ydUNgqU5mayq5jT/
         bvryLBFQhCO2J0Y/cCG2XFt80Z6KGLgDgwnCTy0NkTWwV2offqszutiy4ZqgZBa3GHYt
         9pJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8E9frrs/O1JJ+vToAWIXip7KGfUfQcRpP7wgxdrIpfE=;
        b=U39HRrNwYCnkGjVeFuiTDRVui4t/B9eTgSfzSrkiu80OrBMC1LCj+LWkek7dsGbCqn
         Qlo/uYYzdHic6NDItruDwnfJiRkTTRJjei8LJikEUGK4hDaiF09ibLgItTXFktvEYuc3
         BXs9XW7/inKe9ESwQO+NaYhZxBKE8aWo1QyBOchJtD0qZW/w+Nk2gdPxvIFbqWSJVPiD
         kFvWp5Eq2tUuAOH1Auo4QPKPf0DInbsQGBiF+QUjPeelGe2nwkWoMuK/j9oQzLeCnbRa
         oBp0fnL9wfPORzpIFJbuIy5yVdiZVNobuk92vgu8QEFlwQR8rbl3DmuOWRDLRhnIMPXT
         1mOw==
X-Gm-Message-State: AOAM532oMemRpthmYRXtbQqbOkjFEp2/KQzgJWXAsPGW+LYNhPLxX/ad
        1DK9BPFpN9uz4p6cwRiHnbB00mvd8mOQRZEY5GM=
X-Google-Smtp-Source: ABdhPJw4cbmkBp2wcPC1wy2C+Jlf1BQQK+0/3jJw0x+QKjVzegWDNmz3TjApBujJP86CHb6JB0mQVLgvTAfrlPSlNHc=
X-Received: by 2002:a05:6830:78c:: with SMTP id w12mr4329853ots.162.1627076085776;
 Fri, 23 Jul 2021 14:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1627066238.git.jonathantanmy@google.com> <f4881b7455b9d33c8a53a91eda7fbdfc5d11382c.1627066238.git.jonathantanmy@google.com>
In-Reply-To: <f4881b7455b9d33c8a53a91eda7fbdfc5d11382c.1627066238.git.jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 23 Jul 2021 14:34:34 -0700
Message-ID: <CABPp-BHtJPp3qi3ww3EcxxzyCUU8DjS1ZWnEQfd4A2rqXyGUXg@mail.gmail.com>
Subject: Re: [PATCH 2/2] cache-tree: prefetch in partial clone read-tree
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 23, 2021 at 11:55 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> "git read-tree" checks the existence of the blobs referenced by the
> given tree, but does not bulk prefetch them. Add a bulk prefetch.
>
> The lack of prefetch here was noticed at $DAYJOB during a merge
> involving some specific commits, but I couldn't find a minimal merge
> that didn't also trigger the prefetch in check_updates() in
> unpack-trees.c (and in all these cases, the lack of prefetch in
> cache-tree.c didn't matter because all the relevant blobs would have
> already been prefetched by then). This is why I used read-tree here to
> exercise this code path.

Okay, you have me stumped, I can't figure out what kind of a merge
would bypass the check_updates() in unpack-trees.c either.  I was
curious about octopus or merge.autostash, but I just can't trigger it.

Using read-tree to trigger the case makes perfect sense, though.

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  cache-tree.c                       | 11 ++++++++--
>  t/t1022-read-tree-partial-clone.sh | 33 ++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 2 deletions(-)
>  create mode 100755 t/t1022-read-tree-partial-clone.sh
>
> diff --git a/cache-tree.c b/cache-tree.c
> index 45e58666af..9ba2c7c6b2 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -237,6 +237,11 @@ int cache_tree_fully_valid(struct cache_tree *it)
>         return 1;
>  }
>
> +static int must_check_existence(const struct cache_entry *ce)
> +{
> +       return !(has_promisor_remote() && ce_skip_worktree(ce));
> +}
> +
>  static int update_one(struct cache_tree *it,
>                       struct cache_entry **cache,
>                       int entries,
> @@ -378,8 +383,7 @@ static int update_one(struct cache_tree *it,
>                 }
>
>                 ce_missing_ok = mode == S_IFGITLINK || missing_ok ||
> -                       (has_promisor_remote() &&
> -                        ce_skip_worktree(ce));
> +                       !must_check_existence(ce);
>                 if (is_null_oid(oid) ||
>                     (!ce_missing_ok && !has_object_file(oid))) {
>                         strbuf_release(&buffer);
> @@ -466,6 +470,9 @@ int cache_tree_update(struct index_state *istate, int flags)
>         if (!istate->cache_tree)
>                 istate->cache_tree = cache_tree();
>
> +       if (!(flags & WRITE_TREE_MISSING_OK) && has_promisor_remote())
> +               prefetch_cache_entries(istate, must_check_existence);
> +

Nice that the fix is so simple.

>         trace_performance_enter();
>         trace2_region_enter("cache_tree", "update", the_repository);
>         i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
> diff --git a/t/t1022-read-tree-partial-clone.sh b/t/t1022-read-tree-partial-clone.sh
> new file mode 100755
> index 0000000000..a763e27c7d
> --- /dev/null
> +++ b/t/t1022-read-tree-partial-clone.sh
> @@ -0,0 +1,33 @@
> +#!/bin/sh
> +
> +test_description='git read-tree in partial clones'
> +
> +TEST_NO_CREATE_REPO=1
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'read-tree in partial clone prefetches in one batch' '
> +       test_when_finished "rm -rf server client trace" &&
> +
> +       git init server &&
> +       echo foo >server/one &&
> +       echo bar >server/two &&
> +       git -C server add one two &&
> +       git -C server commit -m "initial commit" &&
> +       TREE=$(git -C server rev-parse HEAD^{tree}) &&
> +
> +       git -C server config uploadpack.allowfilter 1 &&
> +       git -C server config uploadpack.allowanysha1inwant 1 &&
> +       git clone --bare --filter=blob:none "file://$(pwd)/server" client &&
> +       GIT_TRACE_PACKET="$(pwd)/trace" git -C client read-tree $TREE &&
> +
> +       # "done" marks the end of negotiation (once per fetch). Expect that
> +       # only one fetch occurs.
> +       grep "fetch> done" trace >donelines &&
> +       test_line_count = 1 donelines
> +'
> +
> +test_done
> --
> 2.32.0.432.gabb21c7263-goog

Any reason for preferring GIT_TRACE_PACKET over GIT_TRACE2_PERF and
looking for the reported fetch_count (or even the number of
fetch_count lines)?  Just curious.

Anyway, looks good to me.
