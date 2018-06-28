Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14E8C1F516
	for <e@80x24.org>; Thu, 28 Jun 2018 21:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753410AbeF1VTf (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 17:19:35 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:44293 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752547AbeF1VTe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 17:19:34 -0400
Received: by mail-yw0-f194.google.com with SMTP id k18-v6so2669818ywm.11
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 14:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/iC8JczdG27efg6D1fsdQn022MVGFgXq2tQg5R8svOY=;
        b=rN8AfYjKT4cGDIAXmzlnvuHW/FUKB84IDwMCGhHm/aqudFq3g8di+mDwNHYsgBEE9d
         PEyg6btkSiJ8RO8Lsz5ccHOdRjDIxEabhkt4yylPMghIiFAdAL+Rso+MjPvdK3YRKjat
         LhRwezSQI4c6dac3ZEv0TBsAaINComw+vGPXIOL+QkwwC5FLXnZy9Gi+/RtwUjWCDJf8
         ZTxmO1GSDlCuoCD+fb5XzNnxTgycK6Le+mBD4Em7NJ6qu+w4TCdDd5tXGkn3HKXwt5mU
         IaIAe3wTfblQ3JVIY5CV51KSzUU7woSzRkTHL17gl1Uk+vrIcmBgdsTA45CNizJ1HC5y
         AN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/iC8JczdG27efg6D1fsdQn022MVGFgXq2tQg5R8svOY=;
        b=XOtLxigzN65PS85o6cSrjT/xGAvIeCqqKGAg3kZQvAheYpQOo7EMS6oq64eRHoaKQl
         kHFz9K+iUs5wpyq+BAAnGtvE5GAiN8yzX9zO97nceGVOlmVcA67RKSeLtTAi2vOOS84M
         L1FeYOWp4SdJBvD2CbgfnuxC60ETGPVS2ftb39d3Wn8bYmB8YBcW/WAd5QpSJE/1EuEl
         0owMj2gBXvjrF6sNYf8QmR7/7XBGyHhDYgfexxBvsnISO83mH08/wvpU5I1qluxXCPFb
         PQYdVVUuszaA5b6LgKycHXEDMY0o9WZJjnOcuZm+jPoy6Oegr+OrVr+0hAxY37yWwrM/
         8Glg==
X-Gm-Message-State: APt69E1zocmpJpVNalGfYrF++aj+ugxPpeawqAJiQlBP+ZMt/B41Zx4k
        OP2TUJk8HpljKKo6NKD8reD/XYr34NcRE7dVz9L9uQ==
X-Google-Smtp-Source: AAOMgpcReQmfr5KKAY7pxKLoYUgpF+J8IPqDkaP8sI3jwYyIoFDX67r7BbqP3nNC0qo1AviKgEOKIIruV7TL1RNujdM=
X-Received: by 2002:a0d:f442:: with SMTP id d63-v6mr5874200ywf.238.1530220772990;
 Thu, 28 Jun 2018 14:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180628074655.5756-1-predatoramigo@gmail.com> <20180628074655.5756-5-predatoramigo@gmail.com>
In-Reply-To: <20180628074655.5756-5-predatoramigo@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 28 Jun 2018 14:19:22 -0700
Message-ID: <CAGZ79kZbrk6rSNYx9XP+PWEgghMrgR6JKtdyS+3ku8eOk0X+-w@mail.gmail.com>
Subject: Re: [PATCH 4/5] sequencer: refactor the code to detach HEAD to checkout.c
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alban Gruin <alban.gruin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratik,
On Thu, Jun 28, 2018 at 12:48 AM Pratik Karki <predatoramigo@gmail.com> wrote:
>
> The motivation behind this commit is to extract the core part of
> do_reset() from sequencer.c and move it to a new detach_head_to()
> function in checkout.c.
>
[...]
>
> The new function will be used in the next commit by the builtin rebase,
> to perform the initial checkout.

This sounds like the actual motivation, which is fine.

> Here the index only gets locked after performing the first part of
> `do_reset()` rather than before which essentially derives the `oid`
> from the specified label/name passed to the `do_reset()` function.
> It also fixes two bugs: there were two `return error()` statements in
> the `[new root]` case that would have failed to unlock the index.

This sounds as if this fixes a problem? If so it would be nice to have
a test that demonstrates that these specific problems go away.
(but I think we could just argue based on the motivation above that this
is a good change on its own, with or without demonstrating these
additional issues)

> Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
> ---
>  checkout.c  | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  checkout.h  |  3 +++
>  sequencer.c | 58 +++++-------------------------------------------
>  3 files changed, 72 insertions(+), 53 deletions(-)
>
> diff --git a/checkout.c b/checkout.c
> index bdefc888b..da68915fd 100644
> --- a/checkout.c
> +++ b/checkout.c
> @@ -2,6 +2,11 @@
>  #include "remote.h"
>  #include "refspec.h"
>  #include "checkout.h"
> +#include "unpack-trees.h"
> +#include "lockfile.h"
> +#include "refs.h"
> +#include "tree.h"
> +#include "cache-tree.h"
>
>  struct tracking_name_data {
>         /* const */ char *src_ref;
> @@ -42,3 +47,62 @@ const char *unique_tracking_name(const char *name, struct object_id *oid)
>         free(cb_data.dst_ref);
>         return NULL;
>  }
> +
> +int detach_head_to(struct object_id *oid, const char *action,
> +                  const char *reflog_message)
> +{
> +       struct strbuf ref_name = STRBUF_INIT;
> +       struct tree_desc desc;
> +       struct lock_file lock = LOCK_INIT;
> +       struct unpack_trees_options unpack_tree_opts;
> +       struct tree *tree;
> +       int ret = 0;
> +
> +       if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
> +               return -1;
> +
> +       memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
> +       setup_unpack_trees_porcelain(&unpack_tree_opts, action);
> +       unpack_tree_opts.head_idx = 1;
> +       unpack_tree_opts.src_index = &the_index;
> +       unpack_tree_opts.dst_index = &the_index;
> +       unpack_tree_opts.fn = oneway_merge;
> +       unpack_tree_opts.merge = 1;
> +       unpack_tree_opts.update = 1;
> +
> +       if (read_cache_unmerged()) {
> +               rollback_lock_file(&lock);
> +               strbuf_release(&ref_name);
> +               return error_resolve_conflict(_(action));
> +       }
> +
> +       if (!fill_tree_descriptor(&desc, oid)) {
> +               error(_("failed to find tree of %s"), oid_to_hex(oid));
> +               rollback_lock_file(&lock);
> +               free((void *)desc.buffer);
> +               strbuf_release(&ref_name);

These lines are repeated as a very similar pattern after each
failing function. Maybe we can make it more readable by moving
all these to the end and then using goto to jump there.

For example see "write_pseudoref" in refs.c, that has some interesting
patterns to learn from, e.g. how the return code is constructed
(start off with setting it -1 and only if we go through the whole
function, just before the jump label, we'd set it to 0) and
how all the free/strbuf_releases are at the end (no need to
repeat them).

> +               return -1;
> +       }
> +
> +       if (unpack_trees(1, &desc, &unpack_tree_opts)) {
> +               rollback_lock_file(&lock);
> +               free((void *)desc.buffer);
> +               strbuf_release(&ref_name);
> +               return -1;
> +       }
> +
> +       tree = parse_tree_indirect(oid);

Awesome, the _indirect function can take commits/tags or trees.

> +       prime_cache_tree(&the_index, tree);

As there is a larger movement to get rid of globals, and the_index is one
of them[1]. So maybe just use the_repository->index already (the_repository
suffers a similar problem, but I think that is more futureproof for
the time being
as we'd want to kill off the_repository in library code eventually as
well and pass
through a repository struct. But for now I'd just use the_repository instead of
having a repository argument)

[1] c.f. https://public-inbox.org/git/20180616054157.32433-1-pclouds@gmail.com/


> -       struct lock_file lock = LOCK_INIT;
> -       struct tree_desc desc;
> -       struct tree *tree;
> -       struct unpack_trees_options unpack_tree_opts;
> -       int ret = 0, i;

[...]

Oh I misspoke above, this is moving code (I should have understood
the hint with 'extracting' by the commit message), so in this case we'd
rather want to move code most verbatim to make review easier, which
it is. So the idea with a goto cleanup could be an optional extra step.

Thanks,
Stefan
