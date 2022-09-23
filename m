Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BF7C54EE9
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 01:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiIWBiR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 21:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiIWBiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 21:38:16 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FB61176E8
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 18:38:14 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id u18so17488308lfo.8
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 18:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=3f0349LqUmSY4x14SLX5O6mkbhThXn7rY3eSMdtcBsQ=;
        b=cLMrh7B2ZP/ot4vADL8ipRb1L6UiuDyJ14Z3piAwdjTvMPIqF90hKaiNwQodAbDjQM
         LpbXTVcXQGIDPVln14jHrxx/368ypzrfzv/UwiFUD050aaNIVG29COsh7mooniMJenoF
         a3KYPMARV6F5QenoGG9/tI7bQkRtmeDP+u13i4RWIclC+aB1dd6JEROpBwrfX6AodyvG
         twKgAYANc2JZN0D9bPGCrelBHLqtvAqOLkU6KpCVpL9WC9I/IzIkjQy+xOyask2sXasO
         n/GZN4T601KEorCPW+qg1+PV33GKQZEgNT4J9RvoR2O6vn+wQ6zN2DqV/WP5h2YwoIFf
         /N5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3f0349LqUmSY4x14SLX5O6mkbhThXn7rY3eSMdtcBsQ=;
        b=YjgYtNVW19uLe+YDQNY1IOvurw+7Yjs8INuyHCk6CbOILMNwaZpl70b6xjL7Vy1FCu
         xum82Mp1VxOg0tMZ176JjF6x7SSBJxTXQj9G1OG9Q0STTnrnHosF2KIJhasxPdC1Myty
         xhow6iTNCoYejFjaH2VToH6TwSRQ3a6eAO/sUv+pHDJ7XQGjyCZwj1/6JJ43ZPKTmNPL
         T5lK/h59T4XMLxo9Pv8Yw2PM1f0sVP71+Dyh2/XcBVByDPXgGtSf7UFE42KDKyV2wPqj
         DsPlTbcAG7ISit2/pOKplqVM3XYWqGGmXTv36Xro6qtyYhtfFF5jtN0RqDHJJFMqWdWF
         yXTQ==
X-Gm-Message-State: ACrzQf10WSUNHlCKHhUFhq/Tpzi7Mpbx3wGnK+h6i+WKBpt6dSoZH71M
        B+SfxIXWt2eicyRROE3Qf2RA9rutK1VZr6MNIAJVjv1xEQumqw==
X-Google-Smtp-Source: AMsMyM650u6m6OgIB+7dTx1G2tYUD5H/6mjaEYesmEXPFcH1GtjaSX/jjr8MHqGob7gsz3t73/tx4uDyZKoAOsti84I=
X-Received: by 2002:a05:6512:310:b0:496:a0ca:1613 with SMTP id
 t16-20020a056512031000b00496a0ca1613mr2533395lfp.394.1663897092309; Thu, 22
 Sep 2022 18:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1362.v2.git.1663798083240.gitgitgadget@gmail.com> <pull.1362.v3.git.1663875999939.gitgitgadget@gmail.com>
In-Reply-To: <pull.1362.v3.git.1663875999939.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 22 Sep 2022 18:38:00 -0700
Message-ID: <CABPp-BGizu+dq+8Hbqo5EjKFAWU_Ni9RwQ6p+4oUMLp0oamu7w@mail.gmail.com>
Subject: Re: [PATCH v3] merge-ort: fix segmentation fault in read-only repositories
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2022 at 12:46 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> If the blob/tree objects cannot be written, we really need the merge
> operations to fail, and not to continue (and then try to access the tree
> object which is however still set to `NULL`).
>
> Let's stop ignoring the return value of `write_object_file()` and
> `write_tree()` and set `clean = -1` in the error case.

:-)

>  merge-ort.c                      | 64 +++++++++++++++++++-------------
>  t/t4301-merge-tree-write-tree.sh |  9 +++++
>  2 files changed, 48 insertions(+), 25 deletions(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 99dcee2db8a..f654296220e 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -3571,15 +3571,15 @@ static int tree_entry_order(const void *a_, const void *b_)
>                                  b->string, strlen(b->string), bmi->result.mode);
>  }
>
> -static void write_tree(struct object_id *result_oid,
> -                      struct string_list *versions,
> -                      unsigned int offset,
> -                      size_t hash_size)
> +static int write_tree(struct object_id *result_oid,
> +                     struct string_list *versions,
> +                     unsigned int offset,
> +                     size_t hash_size)
>  {
>         size_t maxlen = 0, extra;
>         unsigned int nr;
>         struct strbuf buf = STRBUF_INIT;
> -       int i;
> +       int i, ret;
>
>         assert(offset <= versions->nr);
>         nr = versions->nr - offset;
> @@ -3605,8 +3605,9 @@ static void write_tree(struct object_id *result_oid,
>         }
>
>         /* Write this object file out, and record in result_oid */
> -       write_object_file(buf.buf, buf.len, OBJ_TREE, result_oid);
> +       ret = write_object_file(buf.buf, buf.len, OBJ_TREE, result_oid);

This sent me into a bit of a hunt to try to figure out what the return
value of write_object_file() is.  I know it's non-zero on failure, but
don't know if it's always positive or always negative or possibly a
mix and how that maps to the idea of "clean_merge".  I gave up after a
few indirections, to be honest.

Anyway, regardless of my inability to find the answer to the above
question, would this be a bit easier to read if we initialized ret to
0 and then did something like

    if (write_object_file(buf.buf, buf.len, OBJ_TREE, result_oid))
        ret = -1;

?

>         strbuf_release(&buf);
> +       return ret;
>  }
>
>  static void record_entry_for_tree(struct directory_versions *dir_metadata,
> @@ -3625,13 +3626,13 @@ static void record_entry_for_tree(struct directory_versions *dir_metadata,
>                            basename)->util = &mi->result;
>  }
>
> -static void write_completed_directory(struct merge_options *opt,
> -                                     const char *new_directory_name,
> -                                     struct directory_versions *info)
> +static int write_completed_directory(struct merge_options *opt,
> +                                    const char *new_directory_name,
> +                                    struct directory_versions *info)
>  {
>         const char *prev_dir;
>         struct merged_info *dir_info = NULL;
> -       unsigned int offset;
> +       unsigned int offset, ret = 0;
>
>         /*
>          * Some explanation of info->versions and info->offsets...
> @@ -3717,7 +3718,7 @@ static void write_completed_directory(struct merge_options *opt,
>          * strcmp here.)
>          */
>         if (new_directory_name == info->last_directory)
> -               return;
> +               return 0;
>
>         /*
>          * If we are just starting (last_directory is NULL), or last_directory
> @@ -3739,7 +3740,7 @@ static void write_completed_directory(struct merge_options *opt,
>                  */
>                 string_list_append(&info->offsets,
>                                    info->last_directory)->util = (void*)offset;
> -               return;
> +               return 0;
>         }
>
>         /*
> @@ -3769,8 +3770,9 @@ static void write_completed_directory(struct merge_options *opt,
>                  */
>                 dir_info->is_null = 0;
>                 dir_info->result.mode = S_IFDIR;
> -               write_tree(&dir_info->result.oid, &info->versions, offset,
> -                          opt->repo->hash_algo->rawsz);
> +               if (write_tree(&dir_info->result.oid, &info->versions, offset,
> +                              opt->repo->hash_algo->rawsz) < 0)
> +                       ret = -1;

This makes me wonder about write_tree() again.  What if its call to
write_object_file() returns a value greater than 0?  Is that possible?
 If it is, are those error cases or not?  About half the callers in
the code base that check the return value of write_object_file() check
for a non-zero value, the other half check for a value less than 0.
And I can't find any documentation.  And it seemed like too much time
for me to figure out what its range of return values was.

>         }
>
>         /*
> @@ -3798,6 +3800,8 @@ static void write_completed_directory(struct merge_options *opt,
>         /* And, of course, we need to update last_directory to match. */
>         info->last_directory = new_directory_name;
>         info->last_directory_len = strlen(info->last_directory);
> +
> +       return ret;
>  }
>
>  /* Per entry merge function */
> @@ -4214,8 +4218,8 @@ static void prefetch_for_content_merges(struct merge_options *opt,
>         oid_array_clear(&to_fetch);
>  }
>
> -static void process_entries(struct merge_options *opt,
> -                           struct object_id *result_oid)
> +static int process_entries(struct merge_options *opt,
> +                          struct object_id *result_oid)
>  {
>         struct hashmap_iter iter;
>         struct strmap_entry *e;
> @@ -4224,11 +4228,12 @@ static void process_entries(struct merge_options *opt,
>         struct directory_versions dir_metadata = { STRING_LIST_INIT_NODUP,
>                                                    STRING_LIST_INIT_NODUP,
>                                                    NULL, 0 };
> +       int ret;
>
>         trace2_region_enter("merge", "process_entries setup", opt->repo);
>         if (strmap_empty(&opt->priv->paths)) {
>                 oidcpy(result_oid, opt->repo->hash_algo->empty_tree);
> -               return;
> +               return 0;
>         }
>
>         /* Hack to pre-allocate plist to the desired size */
> @@ -4270,8 +4275,11 @@ static void process_entries(struct merge_options *opt,
>                  */
>                 struct merged_info *mi = entry->util;
>
> -               write_completed_directory(opt, mi->directory_name,
> -                                         &dir_metadata);
> +               if (write_completed_directory(opt, mi->directory_name,
> +                                             &dir_metadata) < 0) {
> +                       ret = -1;
> +                       goto cleanup;
> +               }
>                 if (mi->clean)
>                         record_entry_for_tree(&dir_metadata, path, mi);
>                 else {
> @@ -4291,12 +4299,15 @@ static void process_entries(struct merge_options *opt,
>                 fflush(stdout);
>                 BUG("dir_metadata accounting completely off; shouldn't happen");
>         }
> -       write_tree(result_oid, &dir_metadata.versions, 0,
> -                  opt->repo->hash_algo->rawsz);
> +       ret = write_tree(result_oid, &dir_metadata.versions, 0,
> +                        opt->repo->hash_algo->rawsz);
> +cleanup:
>         string_list_clear(&plist, 0);
>         string_list_clear(&dir_metadata.versions, 0);
>         string_list_clear(&dir_metadata.offsets, 0);
>         trace2_region_leave("merge", "process_entries cleanup", opt->repo);
> +
> +       return ret;
>  }
>
>  /*** Function Grouping: functions related to merge_switch_to_result() ***/
> @@ -4928,15 +4939,18 @@ redo:
>         }
>
>         trace2_region_enter("merge", "process_entries", opt->repo);
> -       process_entries(opt, &working_tree_oid);
> +       if (process_entries(opt, &working_tree_oid) < 0)
> +               result->clean = -1;
>         trace2_region_leave("merge", "process_entries", opt->repo);
>
>         /* Set return values */
>         result->path_messages = &opt->priv->conflicts;
>
> -       result->tree = parse_tree_indirect(&working_tree_oid);
> -       /* existence of conflicted entries implies unclean */
> -       result->clean &= strmap_empty(&opt->priv->conflicted);
> +       if (result->clean >= 0) {
> +               result->tree = parse_tree_indirect(&working_tree_oid);
> +               /* existence of conflicted entries implies unclean */
> +               result->clean &= strmap_empty(&opt->priv->conflicted);
> +       }
>         if (!opt->priv->call_depth) {
>                 result->priv = opt->priv;
>                 result->_properly_initialized = RESULT_INITIALIZED;
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

Nice to see that it didn't take too much work to propagate the -1
value from write_tree() up the hierarchy.  Nice work!

I think we've still got some separate problems related to propagating
the return value of the other write_object_file() call, from
handle_content_merge().  The direct call in that other case is okay,
but the higher levels at process_renames() and process_entry() seem to
fumble it.  Your fix for failed tree writes is still valid without
fixing the failed blob writes, and I'm happy to tackle the other half
if you'd prefer to hand it off.  But, if you'd like to tackle that
half too, you might see fewer error messages when it fails to write to
the read-only repository, since it'll fail early on the first blob
write instead of only failing when it gets around to trying to write a
new tree.
