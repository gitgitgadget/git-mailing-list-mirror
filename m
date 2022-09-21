Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A5DECAAD8
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 22:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiIUW4y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 18:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiIUW4w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 18:56:52 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1119A895C
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 15:56:50 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id j24so8331817lja.4
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 15:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=EFA1R8UBfmqz2BqYD7rpTZYpz77BhJ3GwizU3HBNu4U=;
        b=o8Oe1MMyzM3kJFIyqfpprcsv94rR07DhniYirOZtOQ9TS6oTFrBPYn/rcM3IaRZEUX
         9luS6R0jDh0wYVpBcRohtHm9ZFJwFHRFpBhAaQ4UsrEdR9la5MWHvs2MvBKhkYxHProg
         JOvKDuEAWUDGKnXTnds75JwToRqLV3xPUh1qKAt0rKTd9OBy4Wsl0+HfyBFWqtvMlMXR
         nZ0BsAUjt3WfW+xIlUJe0P8Dl10jJkVewO3x/Zj6Ni965wDkq7nFUEd4xeeD+7FEfDVA
         s3vmPYR7BnZme2FZn62myjG2iTgQswDcTq3w89ls+6BTBtRUX74LU8KZRm25iwJ7S1Bu
         xlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=EFA1R8UBfmqz2BqYD7rpTZYpz77BhJ3GwizU3HBNu4U=;
        b=MGenJacwvOOwz5IF1EwEIcNtHogJ5XSndoitttXCDUZNki3OGSPdpblugdKTFANEq5
         wRPrUrmoX69IK4kQLcLQEf7Z6b8m/E+G1K7dD8iuLqDhMSkNdACRvUBemy5zBgmJDgqh
         oMi1v3iUFylABwtm01QqpMgH/njv95inZUxfIWT92Js+h1Sz+WWLJx8MTEuowXitw1Y3
         N0FWzpmXQynCg48OQlq0IQBexlKdzqDd1dkPy5uZJoC0jx4M3T4bWMc0M7R2uB4+f/0A
         +WkSuinosEih159XMWay5e9M6EuG7ac8FQOkeOAqNHuibTbrOVT+NGegkPL4vn+y3SY4
         Dl0g==
X-Gm-Message-State: ACrzQf0thimo5tIPPfS4S2j/AMIJOnW4PvMPK9IeZkedXWbf3Af69tD9
        VeFHY1ULEK9Tracwujv0qLMfR4L5mchzoYohuQs=
X-Google-Smtp-Source: AMsMyM4ClcgYPOCofrmPliF5tmqUmsVlBhks5b5oU1makivREI3VmlCX972AHn/J4ZRiqkTA9tVXcsTrWql2r6ONsdk=
X-Received: by 2002:a2e:bd03:0:b0:261:8b4d:7c5c with SMTP id
 n3-20020a2ebd03000000b002618b4d7c5cmr138020ljq.194.1663801008693; Wed, 21 Sep
 2022 15:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1362.git.1663774248660.gitgitgadget@gmail.com> <pull.1362.v2.git.1663798083240.gitgitgadget@gmail.com>
In-Reply-To: <pull.1362.v2.git.1663798083240.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 21 Sep 2022 15:56:37 -0700
Message-ID: <CABPp-BGUiDXxv8eQhKQXHcem3ke9e=Q99a_FDExZ5XZYUgir6A@mail.gmail.com>
Subject: Re: [PATCH v2] merge-tree: fix segmentation fault in read-only repositories
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 21, 2022 at 3:08 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Independent of the question whether we want `git merge-tree` to report
> the tree name even when it failed to write the tree objects in a
> read-only repository, there is no question that we should avoid a
> segmentation fault.

Ah, a read-only repo.  Looks like we didn't bother to check the return
status of write_object_file() in one of the two cases; oops.  (And it
looks like the other case does not correctly propagate the error
upwards far enough...)

> And when we report an invalid tree name (because the tree could not be
> written), we need the exit status to be non-zero.
>
> Let's make it so.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     merge-tree: fix segmentation fault in read-only repositories
>
>     Turns out that the segmentation fault reported by Taylor
>     [https://lore.kernel.org/git/YyopQD+LvPucnz3w@nand.local/] happened
>     while testing merge-ort in a read-only repository, and that the upstream
>     version of git merge-tree is as affected as GitHub's internal version.
>
>     Note: I briefly considered using the OID of the_hash_algo->empty_tree
>     instead of null_oid() when no tree object could be constructed. However,
>     I have come to the conclusion that this could potentially cause its own
>     set of problems because it would relate to a valid tree object even if
>     we do not have any valid tree object to play with.
>
>     Also note: The question I hinted at in the commit message, namely
>     whether or not to try harder to construct a tree object even if we
>     cannot write it out, maybe merits a longer discussion, one that I think
>     we should have after v2.38.0 is released, so as not to distract from
>     focusing on v2.38.0.

That's fair, but you know I'm going to have a hard time refraining
from commenting on it anyway...  :-)

[...]
> @@ -446,7 +447,8 @@ static int real_merge(struct merge_tree_options *o,
>         if (o->show_messages == -1)
>                 o->show_messages = !result.clean;
>
> -       printf("%s%c", oid_to_hex(&result.tree->object.oid), line_termination);
> +       tree_oid = result.tree ? &result.tree->object.oid : null_oid();
> +       printf("%s%c", oid_to_hex(tree_oid), line_termination);

Perhaps also print a warning to stderr when result.tree is NULL?

>         if (!result.clean) {
>                 struct string_list conflicted_files = STRING_LIST_INIT_NODUP;
>                 const char *last = NULL;
> @@ -473,7 +475,7 @@ static int real_merge(struct merge_tree_options *o,
>                                               &result);
>         }
>         merge_finalize(&opt, &result);
> -       return !result.clean; /* result.clean < 0 handled above */
> +       return !result.tree || !result.clean; /* result.clean < 0 handled above */

Thinking out loud, should this logic be at the merge-ort.c level,
perhaps something like this:

@@ -4940,6 +4941,9 @@ static void
merge_ort_nonrecursive_internal(struct merge_options *opt,
        result->tree = parse_tree_indirect(&working_tree_oid);
        /* existence of conflicted entries implies unclean */
        result->clean &= strmap_empty(&opt->priv->conflicted);
+       if (!result->tree)
+               /* This shouldn't happen, because if we did fail to
write a tree we should have returned early before getting here.  But
just in case we have some bugs... */
+               result->clean = -1;
        if (!opt->priv->call_depth) {
                result->priv = opt->priv;
                result->_properly_initialized = RESULT_INITIALIZED;

That might benefit callers other than merge-tree, though maybe it
makes it harder to print a helpful error message (unless we're fine
with the library always throwing one?)

> diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
> index 28ca5c38bb5..013b77144bd 100755
> --- a/t/t4301-merge-tree-write-tree.sh
> +++ b/t/t4301-merge-tree-write-tree.sh
> @@ -810,4 +810,13 @@ test_expect_success 'can override merge of unrelated histories' '
>         test_cmp expect actual
>  '
>
> +test_expect_success SANITY 'merge-ort fails gracefully in a read-only repository' '
> +       git init --bare read-only &&
> +       git push read-only side1 side2 side3 &&
> +       test_when_finished "chmod -R u+w read-only" &&
> +       chmod -R a-w read-only &&
> +       test_must_fail git -C read-only merge-tree side1 side3 &&
> +       test_must_fail git -C read-only merge-tree side1 side2
> +'
> +
>  test_done
>
> base-commit: dda7228a83e2e9ff584bf6adbf55910565b41e14
> --
> gitgitgadget

This is a reasonable workaround from the merge-tree side, if we expect
merge-ort to not correctly notify us of issues (which may be fair
given that a quick glance suggests we have more than one problematic
codepath, which I'll discuss more below).  However, I do think
merge-ort should be returning a negative value for the "clean" status
in such a case.  If merge-ort did that, then we wouldn't even get to
your new code because merge-tree.c already checks for that:

    merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
    if (result.clean < 0)
        die(_("failure to merge"));

I have a hack above which sets a negative return value, but it's only
a workaround since it comes from a late detect-after-the-fact
location.  Here's another ugly hack, but one which highlights exactly
where the real problem occurs:

diff --git a/merge-ort.c b/merge-ort.c
index 99dcee2db8..c2144e9220 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3605,7 +3605,8 @@ static void write_tree(struct object_id *result_oid,
        }

        /* Write this object file out, and record in result_oid */
-       write_object_file(buf.buf, buf.len, OBJ_TREE, result_oid);
+       if (write_object_file(buf.buf, buf.len, OBJ_TREE, result_oid))
+               die(_("Unable to add new tree to database"));
        strbuf_release(&buf);
 }

die()ing, of course, is not a good choice, we should really return -1
instead.  Unfortunately, the callers aren't currently prepared to
propagate such a value upwards (as reflected in the return type of the
function) so any fix in this area is a little more involved than just
modifying these few lines.  Also, there is one other call to
write_object_file() in merge-ort.c which does check and return a value
of -1, though looking around it appears the callers of that other site
do not always correctly check and propagate a return value of -1
further upwards as they should, meaning we are losing track of the
fact that the merge failed to function.

Given the lack of correct propagation of -1 return values in the other
codepath plus the error here, keeping some form of workaround sounds
fair (though it may be nice to print an error that something fishy
happened).

And then, possibly post-v2.38.0 though we may be able to get it in
before, getting correct propagation of a -1 return value from the
source of the error would be good.  Would you like to look into that,
or would you prefer I did?
