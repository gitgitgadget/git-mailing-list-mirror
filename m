Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF15C433FE
	for <git@archiver.kernel.org>; Mon,  9 May 2022 10:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbiEIKXH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 06:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbiEIKXC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 06:23:02 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB391F7E01
        for <git@vger.kernel.org>; Mon,  9 May 2022 03:19:04 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id d15so14437390lfk.5
        for <git@vger.kernel.org>; Mon, 09 May 2022 03:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gzums7LZ8eksvC/Mwjv1P2c4wlT1oDTkejXAVFdBxBo=;
        b=nT+dn15Y0pMWEgnVG2nRg8cEHDKPCQBhbFWxtHf1PWmRJ/9tu5E7iNxGcQKSSgU5/x
         QJDQ/F36jBlEMtWF219EqjQiqHSKFWLyeDQK8Ghgj/+ApcD9JmIUOzMvmENKOafeSz4Y
         ZbwIDzZBgCyannq/Heo4I1dsVj1i44gqNeyOWALTF5uJZmOu0QYqcmGAoTpDePc4Ybtt
         MbojvKFIwl2kHkN0rUuaKxDr8y4MwfcV0oKXJ7IUsCtFlFJE3qvKeL5N49USSOb8TVTq
         XgCTxqx6fE9iGmDtse2UYnPIZI0UmZ5XKdvBfeXDh9nswh3zko1DvlfBUSyo4GWCVvlK
         +NbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gzums7LZ8eksvC/Mwjv1P2c4wlT1oDTkejXAVFdBxBo=;
        b=WSTOH7pFfX9iGPfYqIi//GWgs2foIvvqx+VdeMWsibDQCw+gIQT3H3/pn6CQmjjUXH
         O75NCMFzi1X5WWPxQo2vyvD778FQMdtvhqTr7bKBVoQbK4EIgNI5sZDKrI9DPeAuPGAG
         9OFo6mt9r6y67T6nImgAP5pDrg6M9fIL1qLzJr/R+rpchF9cdSqWmsA3oIcy3LEs6Pdi
         aiD5V9eEtPFLgN+HvCoIHQKbMPYgcbIilE2w/QiRWhxZg4MPIbHxwV7l3DKJ8UuHfPRq
         Nyhl8L1I51cLUK7/SsIlz0W8wA/2Pqp6yejkXs/lYfM9gwkMVxmOrwugiJtrMGka2t2U
         2BZw==
X-Gm-Message-State: AOAM532RTrphLV6uNTk3T9P1SZUzWfok4McHDmvv92siwZyGCPv64LNu
        d0fdTPFzhhJg/NYMJotrJEA0ie+bdfJAFfFO+MZqlg==
X-Google-Smtp-Source: ABdhPJxYcUhGT29dtbDT5OZTynWeYgEg1ORI7ne5xhIZmiNr7ljuWys5q4TYwKYflKwhrrYEUng7p9924uJmJftai1s=
X-Received: by 2002:a05:6512:b07:b0:473:c26a:7095 with SMTP id
 w7-20020a0565120b0700b00473c26a7095mr12317876lfu.603.1652091542351; Mon, 09
 May 2022 03:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1228.git.1651676435634.gitgitgadget@gmail.com> <YnizZ/a/hQ6hpRPB@ncase>
In-Reply-To: <YnizZ/a/hQ6hpRPB@ncase>
From:   Michael Heemskerk <mheemskerk@atlassian.com>
Date:   Mon, 9 May 2022 12:18:51 +0200
Message-ID: <CAJDSCnPfGhL+_AL5Q1uAs8LLvW=Yckx=Ev0tQy1myCvyNF955g@mail.gmail.com>
Subject: Re: [PATCH] refs: honor reference-transaction semantics when deleting refs
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Michael Heemskerk via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 9, 2022 at 8:23 AM Patrick Steinhardt <ps@pks.im> wrote:
>
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
>     int refs_delete_refs(struct ref_store *refs, const char *msg,
>                          struct string_list *refnames, unsigned int flags);
>
> There are multiple callsites of this function via `delete_refs()`. Now
> honestly, most of these callsites look somewhat broken:
>
>     - `bisect.c` simply does its best to clean up bisect state. This
>       usecase looks fine to me.
>
>     - `builtin/branch.c` reports the branches as deleted even if
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

Exactly; this is the reason that I initially suggested fixing the issue by
just removing the upfront rewrite of packed-refs. With that rewrite removed,
the refs-to-be-deleted are deleted in individual transactions, which may or
may not rewrite packed-refs. The downside, as you correctly pointed out,
is that we could end up rewriting packed-refs multiple times, which could
come at a significant performance penalty for repositories with large
packed-refs files.

Unfortunately, the current approach of updating packed-refs in one
transaction and updating the loose refs in individual transactions doesn't
work either.

So what are our options?

- delete each of the refs in a separate transaction and pay a (potentially
  significant) performance penalty in repositories with large packed-refs
  files when deleting many refs. I'll note that this scenario is similar to
  deleting a set of refs through a non-atomic push.
- switch to a single transaction and update refs.h:refs_delete_refs to use
  an all-or-nothing approach (the approach I've taken in my patch).
- improve the reference-transaction mechanism to support the
  'batch-of-transactions' mode more efficiently. If I remember correctly,
  something like that has been suggested before, but I'm not sure if it's
  actually been built or spiked. In this batch-of-transactions mode, git
  could try to prepare all refs, and only invoke the hook for the refs that
  could be successfully prepared. The hook should then be able to
  reject individual ref updates, and git would then apply only the
  non-rejected ref updates. While such a change would make many
  scenarios where multiple refs are being updated more efficient, it's also
  a much bigger change that's hard to make without breaking the current
  reference-transaction protocol.

Sticking to a transaction per ref and rewriting packed-refs multiple times
is the safer option. Deleting the refs in a single transaction is the more
performant option, but changes the behavior. A stay/stale lock file could
then make it impossible to remove a remote, or to prune /refs/remotes/
refs.

My suggestion would be to stick to a transaction per ref and pay the
same performance penalty as you'd get when deleting many refs through
a non-atomic push.

> > +test_expect_success 'hook aborts deleting loose ref in prepared state' '
> > +     test_when_finished "rm actual" &&
> > +     test_when_finished "git branch -d to-be-deleted" &&
> > +     git branch to-be-deleted $PRE_OID &&
> > +     test_hook reference-transaction <<-\EOF &&
> > +             echo "$*" >>actual
> > +             exit 1
> > +     EOF
> > +     cat >expect <<-EOF &&
> > +             aborted
> > +             prepared
> > +             aborted
> > +     EOF
>
> It's not really clear why we get the first "aborted" result here. I know
> that it is because we didn't queue up any refs to the packed backend,
> and thus we don't even try to prepare the transaction. But it's likely
> confusing to a reader and might thus warrant a comment. On the other
> hand this is going away anyway if and when my patch series lands again
> that stops calling the hook from the nested packed backend.

I can add a comment explaining why we get the 'aborted' callback
and also add a comment that that 'aborted' callback is expected to be
removed in an upcoming version.

> > +     test_must_fail git branch -d to-be-deleted &&
> > +     test_cmp expect actual &&
> > +     git rev-parse refs/heads/to-be-deleted
> > +'
> > +
> > +test_expect_success 'hook aborts deleting packed ref in prepared state' '
> > +     test_when_finished "rm actual" &&
> > +     test_when_finished "git branch -d to-be-deleted" &&
> > +     git branch to-be-deleted $PRE_OID &&
> > +     git pack-refs --all --prune &&
> > +     test_hook reference-transaction <<-\EOF &&
> > +             echo "$*" >>actual
> > +             exit 1
> > +     EOF
> > +     cat >expect <<-EOF &&
> > +             prepared
> > +             aborted
> > +     EOF
> > +     test_must_fail git branch -d to-be-deleted &&
> > +     test_cmp expect actual &&
> > +     git rev-parse refs/heads/to-be-deleted
> > +'
> > +
>
> From your description one more interesting case is when the packed-refs
> transaction is committed, but the loose-refs backend is aborted. It's a
> bit harder to test given that we have no way to indicate what backend
> the reftx hook is being invoked from though.

That is indeed the more interesting case, and exactly the case we saw
fail when the packed-refs reference-transactions callbacks had been
suppressed in 2.36.0-rc1 and -rc2. But as you said, they're pretty hard to
test. In Bitbucket's tests we now verify from the reference-transaction
callback that the ref-updates have not been committed (yet) when the
prepared or aborted callback is received, and that they _have_ been
committed when the committed callback is received. Perhaps a similar
approach could be used in git's reference-transaction tests for more
thorough testing.

> One thing that worries me is that these patches kind of set the current
> behaviour of driving the reftx hook via both packed and loose backend
> into stone. My patch series that got reverted is going to change that
> behaviour though so that we don't execute the hook from the packed
> backend, and consequentially we'd have to change all these tests again
> to match the new behaviour. This makes it a lot harder to argue though
> that we can safely switch to the new behaviour without breaking any
> assumptions when we even codified our current assumptions into tests.

The counter argument to that is that it's kind of scary if you could remove
 half of the reference-transaction callbacks without needing to update a
test. I'd rather have tests that verify current behavior that you need to
update when you intentionally change the behavior, then not have those
tests?

> Taking a step back I wonder whether my previous approach to just hide
> the hook for the packed backend was the right thing to do though. An
> alternative would be to instead expose additional information to the
> hook so that it can decide by itself whether it wants to execute the
> hook or not. This could e.g. trivially be done by exposing a new
> "GIT_REFS_BACKEND" environment variable to the reftx hook that gets set
> to either "packed-refs", "loose-refs" or "reftables" depending on which
> backend is currently in use. Equipped with this information a hook
> script can then easily ignore any updates to the packed-refs file by
> itself without having to change the way it is invoked right now and thus
> we wouldn't regress any currently existing hooks.

From the reference-transaction hook writer's perspective, the backend
involved is an implementation detail that the hook should not have to
care about. Getting separate callbacks for the loose and the packed
backends makes it a lot harder to write a good reference-transaction
hook, especially when the callbacks differ if a ref is packed or not.

IMO, there should really be a "files" backend transaction, that internally
takes care of locking individual refs and possibly "packed-refs" in case
of a deletion. In addition, not getting "artificial" packed callbacks also
saves us a few extra reference-transaction callbacks when deleting refs.
Even if those take only a few ms per invocation, when deleting hundreds
of refs, it's still something that we'd like to avoid if we can.

> >  test_done
> > diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> > index 4620f0ca7fa..8b09a99c2e8 100755
> > --- a/t/t5510-fetch.sh
> > +++ b/t/t5510-fetch.sh
> > @@ -169,10 +169,10 @@ test_expect_success REFFILES 'fetch --prune fails to delete branches' '
> >       git clone . prune-fail &&
> >       cd prune-fail &&
> >       git update-ref refs/remotes/origin/extrabranch main &&
> > -     : this will prevent --prune from locking packed-refs for deleting refs, but adding loose refs still succeeds  &&
> > -     >.git/packed-refs.new &&
> > +     : this will prevent --prune from locking refs/remotes/origin/extra for deletion &&
> > +     >.git/refs/remotes/origin/extrabranch.lock &&
> >
> > -     test_must_fail git fetch --prune origin
> > +     test_must_fail git fetch --prune origin > outputs 2> errors
>
> It would be nice to have an explanation why exactly this change is
> needed, and why it is fine that the visible behaviour changes here.

The  test was relying on the fact that the packed-refs file was locked when
git fetch --prune is called. My patch replaces that unconditional lock with
a transaction. The transaction only takes out the lock if packed-refs
actually needs to be updated, and since the ref being pruned only exists
as a loose ref, git fetch --prune failed to fail.

I've replaced the lock on packed-refs with a lock on the loose ref that
should be pruned.

Michael
