Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE21C433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 18:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9037220709
	for <git@archiver.kernel.org>; Wed, 20 May 2020 18:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apbdPI+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgETSKd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 14:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgETSKd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 14:10:33 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B52C061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 11:10:32 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id a68so3241278otb.10
        for <git@vger.kernel.org>; Wed, 20 May 2020 11:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xfdj/DlP9Ydhv/NZK6Tw9N20Off47S4h1ZRafPUIhh0=;
        b=apbdPI+1+T/TsBBnntRGrLywrh5YUSfFTIRxZ+i5/yq5sT+8WPsmNYGBRsJ/OJtn7e
         H1o5rvSp4FLHk+8guJ9buyYPmtEnx38Y3dJcoCynvthy7Z60WZ8qJ/sMqQs0Y/3iSeew
         jLIcQRP6fZ/2Uyu5JaoOgdpZFoQ2UfDyeRlvme/l5evLj7wSBm6CidI6Vnk06iGP0tPh
         wHs2IDgEwpRQpYP7pcmPpSql+bbWQ4dENgpZTw6f/Fx2XrW1Mq8JjyPsCetOkbH5RmFK
         hYa2ewLOvwRNpe7zjFameu+CaROg7GbhS/fkQmvqOtytqZBvqMM4JM1rIQicYpfKgKu9
         kjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xfdj/DlP9Ydhv/NZK6Tw9N20Off47S4h1ZRafPUIhh0=;
        b=NL1fk4lOM/XBS1LPIqKifgKY1ESAn4mHvFEVQ3RHAk9p1RQpcFgjGkrssa5TGtqBn8
         UGi/cAsnlRo2AUDzojSifcOTO7MP3EdXP8b8dUp8bMKwGVqnRHzME4HnQIk34if8TEvg
         tTExBLYmYiSpSEc/QlUGZ+Z+9Dk6K1KrlGCKH8XHp6Zjs+cu9m7vVgsXe0+HCYZj77kF
         dsIUSDUdyJxWs+hoVjrpgZideSRj8tSQmOVrHy4A/l07ta7F4zb2owbGYLkSn2xNhiSH
         UZ8XQctg9KK4+ZKB+mFEAA9F2DJ//OOtW+MxvVafiysgl93H0H7KWYuf4rnv4x9Yq17H
         w53g==
X-Gm-Message-State: AOAM532lOsSmioo64zx6CWCin6NkEh4tOmiEVYT/HpMKlLHyj09Ca3Ix
        QJ04ma1kkk7bNwOlJtfvm+e4KY7Pk0ige7gMjeI=
X-Google-Smtp-Source: ABdhPJx5S+7yhGK0L0VlcWryS77zlq8afaOpCzJO75Vp6+hhpJD4uewdBj9Pw4WshLz8WN+d/3o2Ck98aqCQ1bzGjM0=
X-Received: by 2002:a9d:7998:: with SMTP id h24mr1127240otm.316.1589998231187;
 Wed, 20 May 2020 11:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.627.git.1588857462.gitgitgadget@gmail.com> <f55cd0fb3897db9ca22156347293ca830cdf018c.1588857462.git.gitgitgadget@gmail.com>
In-Reply-To: <f55cd0fb3897db9ca22156347293ca830cdf018c.1588857462.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 May 2020 11:10:20 -0700
Message-ID: <CABPp-BEz42zvT_Vsu2xxg9RnuhBZ2aF8b+KYEu-CW=bMGQOC=Q@mail.gmail.com>
Subject: Re: [PATCH 07/10] sparse-checkout: define in-tree dependencies
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, newren@gmaill.com,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 7, 2020 at 6:22 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> As mentioned in the definition of the in-tree sparse-checkout
> definitions, a large repository could have many different roles for the
> users of that repository. That means that many different in-tree
> sparse-checkout definitions need to exist. If a directory needs to be
> added to many of these roles, then many of these files need to be
> edited. This is too much work to scale properly.
>
> Instead, let's make these definitions easier to maintain by following
> basic principles of build dependencies. Add simple links between these
> in-tree files using the new "sparse.inherit" config key. This multi-
> valued config setting specifies more files that are needed to define the
> sparse-checkout for a role. By separating out the common directories
> into a base file, the more specialized roles can focus their files on
> the directories only needed by those roles and leave the common
> directories to that base file.
>
> For example, suppose that .sparse/base has the following data:
>
>         [sparse]
>                 dir = A
>                 dir = B/C
>                 dir = D/E/F
>
> and .sparse/extra has the following data:
>
>         [sparse]
>                 dir = D
>                 dir = X
>                 inherit = .sparse/base
>
> Now, a user can run "git sparse-checkout set --in-tree .sparse/extra"
> and the resulting directories will define their cone-mode
> sparse-checkout patterns:
>
>         A
>         B/C
>         D
>         X
>
> Thus, the resulting sparse-checkout definition is the union of the
> definitions from .sparse/base and .sparse/extra, but the user only has
> one value of sparse.inTree of ".sparse/extra".
>
> It is simple to modify our existing logic to explore the directed graph
> created by the sparse.inherit values. We simply need to append to the
> string_list containing the list of in-tree files. Since we never repeat
> parsing on the same blob oid, this will not lead to infinite loops or
> exponential blowups in the parsing time.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-sparse-checkout.txt | 26 ++++++++++++++++++++++
>  sparse-checkout.c                     | 27 ++++++++++++++++++-----
>  sparse-checkout.h                     |  1 +
>  t/t1091-sparse-checkout-builtin.sh    | 31 +++++++++++++++++++++++++++
>  4 files changed, 80 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> index c1713ebb1d2..941658e0011 100644
> --- a/Documentation/git-sparse-checkout.txt
> +++ b/Documentation/git-sparse-checkout.txt
> @@ -238,6 +238,32 @@ definition according to the files available at the new commit. If any of
>  the specified files do not exist at the new commit, then the sparse-checkout
>  definition will not change.
>
> +In a very large repository, there may be need to have multiple of these
> +in-tree sparse-checkout definitions to fit the roles of multiple types of
> +users. As each definition grows and the number of user types grow, it can
> +be difficult to manage updating all of the definitions when a common core
> +is modified somehow. For this reason, the in-tree pattern sets can inherit
> +the directories from other in-tree pattern sets. Use the `sparse.inherit`
> +option to specify other files in the tree.
> +
> +For example, suppose the file listed earlier is at `.sparse/core`. Another
> +file could be stored as `.sparse/extra` with contents
> +
> +----------------------------------
> +[sparse]
> +       dir = X
> +       dir = Y/Z
> +       inherit = .sparse/core
> +----------------------------------

So you apparently expect full path rather than a relative path.  This
example does imply this, but it might be good to explicitly state it.

What happens if the user specifies a non-existent path, or perhaps
equivalently, didn't understand and specified the path using a
relative path specification?  What if the user specifies a path that
doesn't exist in the commit, but happens to exist in someones's
working directory?  (And maybe even did it intentionally as a way to
cheat and add user-defined additional paths to include?  Do we want to
allow that, or do we want to enforce that extra includes use some kind
of pre-defined path?)  What if they specify some path that is invalid
to record in a git commit (.git/mydeps or
../../../../../../../otherdeps) but happens to exist on some machines?
 (Are there future security vulnerabilities of any sort going down
this path?)

> +
> +Then, if you run `git sparse-checkout set --in-tree .sparse/extra`, the
> +sparse-checkout definition will include `X` and `Y/Z` from `.sparse/extra`
> +as well as `A`, `B/C`, and `D/E/F` from `.sparse/core`. This is similar
> +to specifying both `.sparse/core` and `.sparse/extra` in the `set`
> +subcommand, but has a slight advantage. If the `.sparse/extra` file changes
> +the set of `inherit` files, then your sparse-checkout definition will
> +update accordingly as you switch between commits.
> +
>
>  SUBMODULES
>  ----------
> diff --git a/sparse-checkout.c b/sparse-checkout.c
> index d01f4d7b525..4edeab49a10 100644
> --- a/sparse-checkout.c
> +++ b/sparse-checkout.c
> @@ -66,12 +66,29 @@ static int sparse_dir_cb(const char *var, const char *value, void *data)
>         return 0;
>  }
>
> +static int sparse_inherit_cb(const char *var, const char *value, void *data)
> +{
> +       struct string_list *sl = (struct string_list *)data;
> +
> +       if (!strcmp(var, SPARSE_CHECKOUT_INHERIT))
> +               string_list_append(sl, value);

So anyone can record lots of additional items within these files, and
we'll ignore them and only pay attention to certain fields.  That
probably allows future versions of git to write new values and old
versions of git to not choke on them.  Does it lead to entrepreneurial
developers cramming random additional fields in these files that
possibly conflict with fieldnames that we want to use in the future?
Do we want to document what is allowed and what is not?

> +
> +       return 0;
> +}
> +
>  static int load_in_tree_from_blob(struct pattern_list *pl,
> -                                 struct object_id *oid)
> +                                 struct object_id *oid,
> +                                 struct string_list *inherit)
>  {
> -       return git_config_from_blob_oid(sparse_dir_cb,
> -                                       SPARSE_CHECKOUT_DIR,
> -                                       oid, pl);
> +       if (git_config_from_blob_oid(sparse_dir_cb,
> +                                    SPARSE_CHECKOUT_DIR,
> +                                    oid, pl))
> +               return 1;
> +       if (git_config_from_blob_oid(sparse_inherit_cb,
> +                                    SPARSE_CHECKOUT_INHERIT,
> +                                    oid, inherit))
> +               return 1;
> +       return 0;
>  }
>
>  int load_in_tree_pattern_list(struct repository *r,
> @@ -121,7 +138,7 @@ int load_in_tree_pattern_list(struct repository *r,
>                         goto cleanup;
>                 }
>
> -               load_in_tree_from_blob(pl, oid);
> +               load_in_tree_from_blob(pl, oid, sl);
>         }
>
>  cleanup:
> diff --git a/sparse-checkout.h b/sparse-checkout.h
> index fb0ba48524a..8b766ea38fb 100644
> --- a/sparse-checkout.h
> +++ b/sparse-checkout.h
> @@ -5,6 +5,7 @@
>  #include "repository.h"
>
>  #define SPARSE_CHECKOUT_DIR "sparse.dir"
> +#define SPARSE_CHECKOUT_INHERIT "sparse.inherit"
>  #define SPARSE_CHECKOUT_IN_TREE "sparse.intree"
>
>  struct pattern_list;
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index fdaafba5377..b2389e5b5e6 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -716,4 +716,35 @@ test_expect_success 'keep definition when in-tree file is missing' '
>         test_path_is_dir repo/.sparse
>  '
>
> +test_expect_success 'inherit definition from other files' '
> +       cat >repo/.sparse/inherit <<-EOF &&
> +       [sparse]
> +               inherit = .sparse/sparse
> +               inherit = .sparse/deep
> +               inherit = .sparse/deeper1
> +       EOF
> +       git -C repo add .sparse &&
> +       git -C repo commit -m "Add inherited file" &&
> +       git -C repo sparse-checkout set --in-tree .sparse/inherit &&
> +       check_files repo a deep folder1 &&
> +       check_files repo/deep a deeper1 deeper2 &&
> +       test_path_is_dir repo/.sparse &&
> +       cat >repo/.sparse/sparse <<-EOF &&
> +       [sparse]
> +               dir = .sparse
> +       EOF
> +       git -C repo commit -a -m "drop folder1 from sparse" &&
> +       check_files repo a deep &&
> +       check_files repo/deep a deeper1 deeper2 &&
> +       test_path_is_dir repo/.sparse
> +'
> +
> +test_expect_success 'inherit files can have cycles' '
> +       echo "\tinherit = .sparse/inherit" >>repo/.sparse/sparse &&
> +       git -C repo commit -a -m "create inherit cycle" &&
> +       check_files repo a deep &&
> +       check_files repo/deep a deeper1 deeper2 &&
> +       test_path_is_dir repo/.sparse
> +'
> +
>  test_done
> --
> gitgitgadget
>
