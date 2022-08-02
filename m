Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31F5C19F2C
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 12:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbiHBMmQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 08:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbiHBMmO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 08:42:14 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F8BDECE
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 05:42:13 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id z5so21566994yba.3
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 05:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+gjEu5Md8OYv+xNZN3zdBd/eAPe/cy9Vyf0qzOZyKPw=;
        b=h8UGdTyV3cB0fdQBz+JPG3uiCvWTRmvnuFFOkd1lNTNSp2kquYeRYKOR1TdfvYgleA
         hofZx9hqahNkyyuAoNThD4JBhePfRDD05PwE4jMzwQzPWyIPWZ05XziwYQBSHuQ41PeC
         /z5mR75HWyM6VG0qoVxxh31xwHi2m4AvuVhDhihFFcA7B9Q/+5tekI79sOj0w8jjDTZG
         /JSycN3+CcktUL39xuswyQKtav5+8D4KBvWj0TSmFOmeoILfMMaqTzolNed6yVgJEruR
         VeGhyvxzxNlN3eQJMJXf7jiWue7d8wbz7rZ/tgiefVJD4DlZVMIBBfv6p+0Z3M8OJmNh
         K+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+gjEu5Md8OYv+xNZN3zdBd/eAPe/cy9Vyf0qzOZyKPw=;
        b=CrlTH7jqBAN2jWGK5BMu07y6HMapXVA3EDSTo1Z/dYkTOOHJZ+WrqMp+NBNbyvUpWs
         IVOhwSwDh4jGfeOd1xz2F/4npDFOybZ32c1tFMCQ9tTckr9Hn4E9Oa/yAn+YTA+sGDmS
         w9rLOxQAE+jcPA7OzcXxH/JibL3U33RIK1mc2J/5T2VMO+BJkoKyzYg8cOkVMpZ5ow6+
         LW9RTPevvmconLH0LmNTqDpi1JOOUbZEMlILCvGuFcmRWfWoZ+YePEhpM5B75FOzfdvv
         dovAV/N/vtg9xLesYp1uulxm5KHI7UUMq2/UGWSZbktyg3Vh4wqn9oC/wkOLLeLFsE9d
         rK0w==
X-Gm-Message-State: ACgBeo0OHlguGTJJi0MriYd7+09Z8H8wXDCx0kOGEhwB7xbGBUi17Vq3
        PA31+T7ggy5BUBUKnApOMGePVgoVpbM713vmc27YrQn6cnAv4Q==
X-Google-Smtp-Source: AA6agR5VuHLf9q8enHj8Yht1Ede6/WFMb9IAiSMZYvh3dQaEVP1CiwYk+piUjYGF69Fc19guoDk08UMnJqjBih1x+gg=
X-Received: by 2002:a25:a41:0:b0:673:746:76ef with SMTP id 62-20020a250a41000000b00673074676efmr15731312ybk.132.1659444132676;
 Tue, 02 Aug 2022 05:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220729101245.6469-1-worldhello.net@gmail.com> <20220729101245.6469-10-worldhello.net@gmail.com>
In-Reply-To: <20220729101245.6469-10-worldhello.net@gmail.com>
From:   Michael Heemskerk <mheemskerk@atlassian.com>
Date:   Tue, 2 Aug 2022 14:42:01 +0200
Message-ID: <CAJDSCnMHHdYGeyXKj=ztUKBv2vRTn5BEXUR_7fAfATJxn_uwww@mail.gmail.com>
Subject: Re: [PATCH 9/9] refs: reimplement refs_delete_refs() and run hook once
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let me re-share some questions/suggestions/objections I got on a patch I
shared with similar changes:
https://lore.kernel.org/git/pull.1228.git.1651676435634.gitgitgadget@gmail.com/

There's a lot to like about the change; it fixes the incorrect invocation of
the reference-transaction hooks when (bulk) deleting refs, but there is a
down-side that Patrick pointed out. We never got to a satisfactory solution,
so let me reshare his feedback to pick up the discussion.

Patrick:
> I really like these changes given that they simplify things, but I
> wonder whether we can do them. In the preimage we're eagerly removing
> loose refs: any error encountered when deleting a reference is recorded,
> but we keep on trying to remove the other refs, as well. With the new
> behaviour we now create a single transaction for all refs and try to
> commit it. This also means that we'll abort the transaction when locking
> any of the refs fails, which is a change in behaviour.
>
> The current behaviour is explicitly documented in `refs.h:refs_delete_refs()`:
>
>     /*
>      * Delete the specified references. If there are any problems, emit
>      * errors but attempt to keep going (i.e., the deletes are not done in
>      * an all-or-nothing transaction). msg and flags are passed through to
>      * ref_transaction_delete().
>      */
>    int refs_delete_refs(struct ref_store *refs, const char *msg,
>                          struct string_list *refnames, unsigned int flags);
>
> There are multiple callsites of this function via `delete_refs()`. Now
> honestly, most of these callsites look somewhat broken:
>
>     - `bisect.c` simply does its best to clean up bisect state. This
>       usecase looks fine to me.
>
>    - `builtin/branch.c` reports the branches as deleted even if
>       `delete_refs()` failed.
>
>     - `builtin/remote.c` also misreports the deleted branches for the
>       `prune` verb. The `rm` verb looks alright: if deletion of any
>       branch failed then it doesn't prune the remote's config in the end
>       and reports an error.
>
>     - `builtin/fetch.c` also misreports deleted branches with `--prune`.
>
> So most of these commands incorrectly handle the case where only a
> subset of branches has been deleted. This raises the question whether
> the interface provided by `refs_delete_refs()` is actually sensible if
> it's so easy to get wrong. It doesn't even report which branches could
> be removed and which couldn't. Furthermore, the question is whether new
> backends like the reftable backend which write all refs into a single
> slice would actually even be in a position to efficiently retain
> semantics of this function.
>
> I'm torn. There are valid usecases for eagerly deleting refs even if a
> subset of deletions failed, making this change a tough sell, but most of
> the callsites don't actually handle this correctly in the first place.

At the time, the only solution I could see was to switch to
transaction-per-ref semantics, but this results in bad performance when
deleting tens of thousands of refs.

One option might be to optimistically try to delete the refs in a single
transaction. If that fails for whatever reason and multiple ref deletions are
requested, we could fall back to a transaction-per-ref approach. That'd keep
the common case fast, and still provide best effort deletes.

Thoughts?

Cheers,
Michael Heemskerk

On Fri, Jul 29, 2022 at 12:13 PM Jiang Xin <worldhello.net@gmail.com> wrote:
>
> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> When delete references using "git branch -d" or "git tag -d", there will
> be duplicate call of "reference-transaction committed" for same refs.
> This is because "refs_delete_refs()" is called twice, once for
> files-backend and once for packed-backend, and we used to reinvented the
> wheel in "files_delete_refs()" and "packed_delete_refs()". By removing
> "packed_delete_refs()" and reimplement "files_delete_refs()", the
> "reference-transaction" hook will run only once for deleted branches and
> tags.
>
> The behavior of the following git commands and the last two testcases
> have been fixed in t1416:
>
>  * git branch -d <branch>
>  * git tag -d <tag>
>
> A testcase in t5510 is broken because we used to call the function
> "packed_refs_lock()", but it is not necessary if the deleted reference
> is not in the "packed-refs" file.
>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  refs/files-backend.c             | 21 ++++++-------
>  refs/packed-backend.c            | 51 +-------------------------------
>  t/t1416-ref-transaction-hooks.sh |  4 +--
>  t/t5510-fetch.sh                 | 17 +++++++++++
>  4 files changed, 29 insertions(+), 64 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 8baea66e58..21426efaae 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1268,31 +1268,27 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
>  static int files_delete_refs(struct ref_store *ref_store, const char *msg,
>                              struct string_list *refnames, unsigned int flags)
>  {
> -       struct files_ref_store *refs =
> -               files_downcast(ref_store, REF_STORE_WRITE, "delete_refs");
> +       struct ref_transaction *transaction;
>         struct strbuf err = STRBUF_INIT;
>         int i, result = 0;
>
>         if (!refnames->nr)
>                 return 0;
>
> -       if (packed_refs_lock(refs->packed_ref_store, 0, &err))
> -               goto error;
> -
> -       if (refs_delete_refs(refs->packed_ref_store, msg, refnames, flags)) {
> -               packed_refs_unlock(refs->packed_ref_store);
> +       transaction = ref_store_transaction_begin(ref_store, &err);
> +       if (!transaction)
>                 goto error;
> -       }
> -
> -       packed_refs_unlock(refs->packed_ref_store);
>
>         for (i = 0; i < refnames->nr; i++) {
>                 const char *refname = refnames->items[i].string;
> -
> -               if (refs_delete_ref(&refs->base, msg, refname, NULL, flags))
> +               if (ref_transaction_delete(transaction, refname, NULL,
> +                                          flags, msg, &err))
>                         result |= error(_("could not remove reference %s"), refname);
>         }
> +       if (ref_transaction_commit(transaction, &err))
> +               goto error;
>
> +       ref_transaction_free(transaction);
>         strbuf_release(&err);
>         return result;
>
> @@ -1309,6 +1305,7 @@ static int files_delete_refs(struct ref_store *ref_store, const char *msg,
>         else
>                 error(_("could not delete references: %s"), err.buf);
>
> +       ref_transaction_free(transaction);
>         strbuf_release(&err);
>         return -1;
>  }
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 97b6837767..fdb7a0a52c 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1519,55 +1519,6 @@ static int packed_initial_transaction_commit(struct ref_store *ref_store,
>         return ref_transaction_commit(transaction, err);
>  }
>
> -static int packed_delete_refs(struct ref_store *ref_store, const char *msg,
> -                            struct string_list *refnames, unsigned int flags)
> -{
> -       struct packed_ref_store *refs =
> -               packed_downcast(ref_store, REF_STORE_WRITE, "delete_refs");
> -       struct strbuf err = STRBUF_INIT;
> -       struct ref_transaction *transaction;
> -       struct string_list_item *item;
> -       int ret;
> -
> -       (void)refs; /* We need the check above, but don't use the variable */
> -
> -       if (!refnames->nr)
> -               return 0;
> -
> -       /*
> -        * Since we don't check the references' old_oids, the
> -        * individual updates can't fail, so we can pack all of the
> -        * updates into a single transaction.
> -        */
> -
> -       transaction = ref_store_transaction_begin(ref_store, &err);
> -       if (!transaction)
> -               return -1;
> -
> -       for_each_string_list_item(item, refnames) {
> -               if (ref_transaction_delete(transaction, item->string, NULL,
> -                                          flags, msg, &err)) {
> -                       warning(_("could not delete reference %s: %s"),
> -                               item->string, err.buf);
> -                       strbuf_reset(&err);
> -               }
> -       }
> -
> -       ret = ref_transaction_commit(transaction, &err);
> -
> -       if (ret) {
> -               if (refnames->nr == 1)
> -                       error(_("could not delete reference %s: %s"),
> -                             refnames->items[0].string, err.buf);
> -               else
> -                       error(_("could not delete references: %s"), err.buf);
> -       }
> -
> -       ref_transaction_free(transaction);
> -       strbuf_release(&err);
> -       return ret;
> -}
> -
>  static int packed_pack_refs(struct ref_store *ref_store, unsigned int flags)
>  {
>         /*
> @@ -1595,7 +1546,7 @@ struct ref_storage_be refs_be_packed = {
>
>         .pack_refs = packed_pack_refs,
>         .create_symref = NULL,
> -       .delete_refs = packed_delete_refs,
> +       .delete_refs = NULL,
>         .rename_ref = NULL,
>         .copy_ref = NULL,
>
> diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
> index df75e5727c..f64166f9d7 100755
> --- a/t/t1416-ref-transaction-hooks.sh
> +++ b/t/t1416-ref-transaction-hooks.sh
> @@ -744,7 +744,7 @@ test_expect_success "branch: rename branches" '
>         test_cmp_heads_and_tags -C workdir expect
>  '
>
> -test_expect_failure "branch: remove branches" '
> +test_expect_success "branch: remove branches" '
>         test_when_finished "rm -f $HOOK_OUTPUT" &&
>
>         cat >expect <<-EOF &&
> @@ -873,7 +873,7 @@ test_expect_success "tag: update refs to create loose refs" '
>         test_cmp_heads_and_tags -C workdir expect
>  '
>
> -test_expect_failure "tag: remove tags with mixed ref_stores" '
> +test_expect_success "tag: remove tags with mixed ref_stores" '
>         test_when_finished "rm -f $HOOK_OUTPUT" &&
>
>         cat >expect <<-EOF &&
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index b45879a760..22de7ac9ec 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -168,6 +168,8 @@ test_expect_success REFFILES 'fetch --prune fails to delete branches' '
>         cd "$D" &&
>         git clone . prune-fail &&
>         cd prune-fail &&
> +       git update-ref refs/remotes/origin/extrabranch main~ &&
> +       git pack-refs --all &&
>         git update-ref refs/remotes/origin/extrabranch main &&
>         : this will prevent --prune from locking packed-refs for deleting refs, but adding loose refs still succeeds  &&
>         >.git/packed-refs.new &&
> @@ -175,6 +177,21 @@ test_expect_success REFFILES 'fetch --prune fails to delete branches' '
>         test_must_fail git fetch --prune origin
>  '
>
> +test_expect_success REFFILES 'fetch --prune ok for loose refs not in locked packed-refs' '
> +       test_when_finished "cd \"$D\"; rm -rf \"prune-ok-ref-not-packed\"" &&
> +       cd "$D" &&
> +       git clone . prune-ok-ref-not-packed &&
> +       (
> +               cd prune-ok-ref-not-packed &&
> +               git update-ref refs/remotes/origin/extrabranch main &&
> +               : for loose refs not in packed-refs, we can delete them even the packed-refs is locked &&
> +               :>.git/packed-refs.new &&
> +
> +               git fetch --prune origin &&
> +               test_must_fail git rev-parse refs/remotes/origin/extrabranch --
> +       )
> +'
> +
>  test_expect_success 'fetch --atomic works with a single branch' '
>         test_when_finished "rm -rf \"$D\"/atomic" &&
>
> --
> 2.36.1.25.gc87d5ad63a.dirty
>
