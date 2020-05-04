Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E100C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 22:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F30E3206EB
	for <git@archiver.kernel.org>; Mon,  4 May 2020 22:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="fw/U38Nx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgEDWAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 18:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726334AbgEDWAp (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 18:00:45 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38E4C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 15:00:45 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u22so324771plq.12
        for <git@vger.kernel.org>; Mon, 04 May 2020 15:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ic8hWtU2KeoZXqbiAIzTLQJJ1SEG3qiO6aaVFsYi1yE=;
        b=fw/U38NxIbyGiUyQllJIkHupnYNWqVpS/xJDiu+A3qk7/PZx9Q3NO1BfpXNXOHeWuq
         H0OTP5yjP6uRLBKeDM27sdcwvYnT17xa9jf3JpZ17TVR6V7PYy8b3KteR6EwNt6/lfet
         JP/UuoO1AYbmRSffu+tKEe04vVmKFMftrh7tgKJbetn9chGGeATqaKuEROBkOkaCQv5w
         Zw+sXhC1Y8lqdEXFu00N4qZIqM2x7PewpPdz52p0XRMCDUHUMOA9XKBgjim/ZptxxZZx
         A/YdXiebtVcmHJGnAGrazv2U4M7fSAFef8KnZiehqLmeMzMVTt+LTeLBCaMwxn+Bvcgb
         16ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ic8hWtU2KeoZXqbiAIzTLQJJ1SEG3qiO6aaVFsYi1yE=;
        b=Bb9bX9vKsu0x3CJOlx7scMS1daCe/3IjA3sNJ7NpyfAj2Z9tOSTMDPi8AupB42N9DW
         NZGYhG66SQi31V+l2oCTdpua3hGBg3wTZVS4afk4RtvHXqYW2N0sgldzM0UPbgZeZ+ef
         EnFUFIQ8U64rAi3YKb2dz8z8yc5xfC/G3CroN5V3KMKjNW12ZMwzP6f2jkKy2F5Ffj7x
         MwV4bkt0PM2gHhhKs2KjUZTUBCS5dzJACw4aHdIBMyDtiX+uhsVnrdP5t06pvV/27sZc
         58F3EMiAecBT57mfZjxHi5HInrNNwYqZrQkyxA/W+/BIXt72VVn2y5xr2GXvldOIK2qY
         7bag==
X-Gm-Message-State: AGi0PubiZn3F0OsjQMhv34UFoN2wDe4wMKUYW+0Cf5Ok5GYeJwNkpy7V
        MLRWmmNzzn2mtpfLTd5MoGsgtA==
X-Google-Smtp-Source: APiQypJlnw0cxV5dF516Q27Mq2kdPg3QznQKcif61k+cVObTflRDLunqWuCnd8kQR0KqS8NGb64YwQ==
X-Received: by 2002:a17:90a:6782:: with SMTP id o2mr28998pjj.122.1588629644961;
        Mon, 04 May 2020 15:00:44 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id z1sm405729pjn.43.2020.05.04.15.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 15:00:43 -0700 (PDT)
Date:   Mon, 4 May 2020 16:00:42 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] sparse-checkout: stop blocking empty workdirs
Message-ID: <20200504220042.GD45250@syl.local>
References: <pull.624.git.1588616864222.gitgitgadget@gmail.com>
 <CABPp-BGO1AYsW-V1a_bSToihWg8yBYyUe3GFUqfaADFpcfEDoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGO1AYsW-V1a_bSToihWg8yBYyUe3GFUqfaADFpcfEDoQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 11:41:38AM -0700, Elijah Newren wrote:
> On Mon, May 4, 2020 at 11:27 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Derrick Stolee <dstolee@microsoft.com>
> >
> > Remove the error condition when updating the sparse-checkout leaves
> > an empty working directory.
> >
> > This behavior was added in 9e1afb167 (sparse checkout: inhibit empty
> > worktree, 2009-08-20). The comment was added in a7bc906f2 (Add
> > explanation why we do not allow to sparse checkout to empty working
> > tree, 2011-09-22) in response to a "dubious" comment in 84563a624
> > (unpack-trees.c: cosmetic fix, 2010-12-22).
> >
> > With the recent "cone mode" and "git sparse-checkout init [--cone]"
> > command, it is common to set a reasonable sparse-checkout pattern
> > set of
> >
> >         /*
> >         !/*/
> >
> > which matches only files at root. If the repository has no such files,
> > then their "git sparse-checkout init" command will fail.
> >
> > Now that we expect this to be a common pattern, we should not have the
> > commands fail on an empty working directory. If it is a confusing
> > result, then the user can recover with "git sparse-checkout disable"
> > or "git sparse-checkout set". This is especially simple when using cone
> > mode.
>
> Yeah, given that setting up a sparse-checkout is now easy (as opposed
> to setting both extensions.worktreeConfig and core.sparseCheckout
> settings, editing a .git/info/sparse-checkout file that is documented
> in some obscure section of the manual, and discovering the
> undocumented `git read-tree -mu HEAD` command that you need to run)
> and drastically less error-prone, and that recovery is now easy (also
> in contrast to before), I think this makes a lot of sense.
>
> I actually hit this error a couple times while testing with the old
> style and thought it was annoying (though understandable when the
> route for usage was so arcane and easy to mess up), but in my case I
> wasn't on a real world repository.  If we've got an example of people
> hitting it on real world repos, then by all means let's get rid of
> this annoying check.
>
> > Reported-by: Lars Schneider <larsxschneider@gmail.com>
> > Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> > ---
> >     sparse-checkout: stop blocking empty workdirs
> >
> >     This is based on en/sparse-checkout.
> >
> >     This is something that Lars Schneider discovered working with a repo
> >     that had no files at root.
> >
> >     Thanks, -Stolee
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-624%2Fderrickstolee%2Fsparse-checkout-allow-empty-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-624/derrickstolee/sparse-checkout-allow-empty-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/624
> >
> >  t/t1011-read-tree-sparse-checkout.sh | 12 +++++++---
> >  t/t1091-sparse-checkout-builtin.sh   |  8 +++----
> >  unpack-trees.c                       | 34 +---------------------------
> >  3 files changed, 13 insertions(+), 41 deletions(-)
> >
> > diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
> > index 63223e13bd1..140f4599773 100755
> > --- a/t/t1011-read-tree-sparse-checkout.sh
> > +++ b/t/t1011-read-tree-sparse-checkout.sh
> > @@ -74,13 +74,19 @@ test_expect_success 'read-tree --no-sparse-checkout with empty .git/info/sparse-
> >  test_expect_success 'read-tree with empty .git/info/sparse-checkout' '
> >         git config core.sparsecheckout true &&
> >         echo >.git/info/sparse-checkout &&
> > -       read_tree_u_must_fail -m -u HEAD &&
> > +       read_tree_u_must_succeed -m -u HEAD &&
> >         git ls-files --stage >result &&
> >         test_cmp expected result &&
> >         git ls-files -t >result &&
> > +       cat >expected.swt <<-\EOF &&
> > +       S init.t
> > +       S sub/added
> > +       S sub/addedtoo
> > +       S subsub/added
> > +       EOF
> >         test_cmp expected.swt result &&
> > -       test -f init.t &&
> > -       test -f sub/added
> > +       ! test -f init.t &&
> > +       ! test -f sub/added
> >  '
> >
> >  test_expect_success 'match directories with trailing slash' '
> > diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> > index dee99eeec30..88cdde255cd 100755
> > --- a/t/t1091-sparse-checkout-builtin.sh
> > +++ b/t/t1091-sparse-checkout-builtin.sh
> > @@ -106,10 +106,8 @@ test_expect_success 'set enables config' '
> >                 cd empty-config &&
> >                 test_commit test file &&
> >                 test_path_is_missing .git/config.worktree &&
> > -               test_must_fail git sparse-checkout set nothing &&
> > +               git sparse-checkout set nothing &&
> >                 test_path_is_file .git/config.worktree &&
> > -               test_must_fail git config core.sparseCheckout &&
> > -               git sparse-checkout set "/*" &&
> >                 test_cmp_config true core.sparseCheckout
> >         )
> >  '
> > @@ -302,8 +300,8 @@ test_expect_success 'revert to old sparse-checkout on empty update' '
> >                 echo >file &&
> >                 git add file &&
> >                 git commit -m "test" &&
> > -               test_must_fail git sparse-checkout set nothing 2>err &&
> > -               test_i18ngrep "Sparse checkout leaves no entry on working directory" err &&
> > +               git sparse-checkout set nothing 2>err &&
> > +               test_i18ngrep ! "Sparse checkout leaves no entry on working directory" err &&
> >                 test_i18ngrep ! ".git/index.lock" err &&
> >                 git sparse-checkout set file
> >         )
> > diff --git a/unpack-trees.c b/unpack-trees.c
> > index b43f3e775ad..9a3ccd9d083 100644
> > --- a/unpack-trees.c
> > +++ b/unpack-trees.c
> > @@ -1677,8 +1677,6 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
> >         }
> >
> >         if (!o->skip_sparse_checkout) {
> > -               int empty_worktree = 1;
> > -
> >                 /*
> >                  * Sparse checkout loop #2: set NEW_SKIP_WORKTREE on entries not in loop #1
> >                  * If they will have NEW_SKIP_WORKTREE, also set CE_SKIP_WORKTREE
> > @@ -1706,19 +1704,6 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
> >
> >                         if (apply_sparse_checkout(&o->result, ce, o))
> >                                 ret = 1;
> > -
> > -                       if (!ce_skip_worktree(ce))
> > -                               empty_worktree = 0;
> > -               }
> > -               /*
> > -                * Sparse checkout is meant to narrow down checkout area
> > -                * but it does not make sense to narrow down to empty working
> > -                * tree. This is usually a mistake in sparse checkout rules.
> > -                * Do not allow users to do that.
> > -                */
> > -               if (o->result.cache_nr && empty_worktree) {
> > -                       ret = unpack_failed(o, "Sparse checkout leaves no entry on working directory");
> > -                       goto done;
> >                 }
> >                 if (ret == 1) {
> >                         /*
> > @@ -1779,7 +1764,7 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
> >  {
> >         enum update_sparsity_result ret = UPDATE_SPARSITY_SUCCESS;
> >         struct pattern_list pl;
> > -       int i, empty_worktree;
> > +       int i;
> >         unsigned old_show_all_errors;
> >         int free_pattern_list = 0;
> >
> > @@ -1810,7 +1795,6 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
> >
> >         /* Then loop over entries and update/remove as needed */
> >         ret = UPDATE_SPARSITY_SUCCESS;
> > -       empty_worktree = 1;
> >         for (i = 0; i < o->src_index->cache_nr; i++) {
> >                 struct cache_entry *ce = o->src_index->cache[i];
> >
> > @@ -1824,28 +1808,12 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
> >
> >                 if (apply_sparse_checkout(o->src_index, ce, o))
> >                         ret = UPDATE_SPARSITY_WARNINGS;
> > -
> > -               if (!ce_skip_worktree(ce))
> > -                       empty_worktree = 0;
> > -       }
> > -
> > -       /*
> > -        * Sparse checkout is meant to narrow down checkout area
> > -        * but it does not make sense to narrow down to empty working
> > -        * tree. This is usually a mistake in sparse checkout rules.
> > -        * Do not allow users to do that.
> > -        */
> > -       if (o->src_index->cache_nr && empty_worktree) {
> > -               unpack_failed(o, "Sparse checkout leaves no entry on working directory");
> > -               ret = UPDATE_SPARSITY_INDEX_UPDATE_FAILURES;
> > -               goto done;
> >         }
> >
> >  skip_sparse_checkout:
> >         if (check_updates(o, o->src_index))
> >                 ret = UPDATE_SPARSITY_WORKTREE_UPDATE_FAILURES;
> >
> > -done:
> >         display_warning_msgs(o);
> >         o->show_all_errors = old_show_all_errors;
> >         if (free_pattern_list)
> >
> > base-commit: 5644ca28cded68972c74614fc06d6e0e1db1a7de
>
> Patch looks good to me.

To me as well. Thanks for sending something so quickly after Lars'
initial report.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
