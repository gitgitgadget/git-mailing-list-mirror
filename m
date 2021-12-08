Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47069C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 08:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244701AbhLHISq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 03:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244669AbhLHISp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 03:18:45 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C2FC061574
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 00:15:13 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id x32so3984932ybi.12
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 00:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8s5hYXIxF6Fm0IwYyKvyWn2XY7Nvp8cgDp3vOne+GjU=;
        b=Xkv6BfHJir+ogKliSYhUNTJQfvyFK70R0pSQWL4kV86KUMRWnidsKmER3XEQQuKQZ0
         MlmFGA2yL98KoC7j56H92H29xAnYG+MpWZ8+I/jpdkg5E+rJWJHEkvfcBFYvZFObtJ3W
         TArpXQ36nGd6TIfwR/keepSWZtfCVhkiF6LhA/QnPce7gJfGQAnSYHRcV5NV55v3hKmr
         Vm5zfxRQEBfKdgtq6rgn6Ox5wPyNN7gNi1th8x8y7I8F+p7AHtdctWwxVKAjHha2YRUl
         pjWlXJkCyTCfUyVHQwLF8pkHNmopzj5HFM7c/OnlEh12c6E1+xg2yp2OctkIc/qfkVZ8
         ZXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8s5hYXIxF6Fm0IwYyKvyWn2XY7Nvp8cgDp3vOne+GjU=;
        b=jDDncxEvyEKT4Ucp+s68JKnVeEEPW/S+Ia3ye1KlhKt6RcJPfnDELhgtQDMbQoIk3a
         fluagYwHegc57fx211H7QFTegUyoRRMaCnB9cIyqUKLdBx3tdNA2Fk/bEXKFp15IbwME
         FDxNdhFv/R5s7Dl6zqApO/+Sd3QJKgrRtNJ3EsJAncETg5r2u8uCJKVGPyVMdqymtTlr
         aKGM029+ZX52HUg4wDCcxGUjAVK95fnvC7sdXghYJlggg2s2awbh1StXwwTveyRic7NS
         tEpEai3SMSdFAyguDbcyZoSKRTzAv5J5h0hNJRbepph3Q2nK2tR6hyUonBOJ6YCBApx6
         pdkg==
X-Gm-Message-State: AOAM530ogd1ZSebpmg1f27xfWBYoYzdSeQ+4Zy9VudppGH9d/CfzLtBI
        uX1REKL/Y6QzD2wRff58f2OGxGAuCWqpZWj9OVU=
X-Google-Smtp-Source: ABdhPJxykn/PbtSrDI2UCc5Onqn50CLe5sSTlWCfIA61gycNcIHsseLO8wYNC2sw5TozNHXXpzkdfGx7ugV77wGV4XQ=
X-Received: by 2002:a25:4dc4:: with SMTP id a187mr55981974ybb.631.1638951312638;
 Wed, 08 Dec 2021 00:15:12 -0800 (PST)
MIME-Version: 1.0
References: <259de62b26302c10f429d52bec42a8a954bc5ba3.1638886972.git.ps@pks.im>
In-Reply-To: <259de62b26302c10f429d52bec42a8a954bc5ba3.1638886972.git.ps@pks.im>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 8 Dec 2021 09:15:01 +0100
Message-ID: <CAP8UFD0Y-2aD6ywRFi49_emxzcLqrfyNpZ29fgsJ0FKc0njYqg@mail.gmail.com>
Subject: Re: [RFC] fetch: update refs in a single transaction
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 7, 2021 at 11:11 PM Patrick Steinhardt <ps@pks.im> wrote:
>
> When git-fetch(1) isn't called with the `--atomic` flag, then each
> reference will be updated in a separate transaction. As a result, even
> if we failed to update a subset of transactions, the remaining refs will
> be modified after the command has finished. While this pattern is
> reasonably efficient with the files backend where we'd lock and write
> each file separately anyway, the upcoming reftable backend could handle
> such an update a lot more efficiently if it was batched into a single
> transaction given that it could then create a single new reftable slice
> instead of creating one slice per updated ref. While this inefficiency
> can be easily mitigated by using the `--atomic` flag, this flag cannot
> be used in contexts where we want partial-update semantics.

So it seems to me that there are 3 possible behaviors/modes:

  - "atomic": a single transaction with all or nothing semantics,
currently implemented with --atomic
  - "partial-update": a single transaction with partial-update
semantics, the new behavior this patch is implementing
  - "non-atomic": many transactions (one per ref?), currently the
default when --atomic isn't passed

Yeah, "partial-update" seems better than "non-atomic" when the
reftable backend is used. But what happens  when "partial-update" is
used with the files backend?

> Convert git-fetch(1) to always use a single reference transaction,
> regardless of whether it is called with `--atomic` or not. The only
> remaining difference between both modes is that with `--atomic` set,
> we'd abort the transaciton in case at least one reference cannot be
> updated.

Nit: I would say "as soon as one reference cannot be updated"

> Note that this slightly changes semantics of git-fetch(1): if we hit any
> unexpected errors like the reference update racing with another process,
> then we'll now fail to update any references, too.

So that's one difference between the "partial-update" and the
"non-atomic" modes, but what you say doesn't really make me confident
that it's the only one.

Also are there people who are in cases where a lot of reference
updates are racing, and where it's important that in such cases at
least some ref updates succeed?

If yes, then maybe the 3 modes could be kept and options for
"partial-update" and "non-atomic" could be added. "partial-update"
could be the default in case the reftable backend is used, while
"non-atomic" would still be the default when the files backend is
used.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/fetch.c | 78 ++++++++++++++++---------------------------------
>  1 file changed, 25 insertions(+), 53 deletions(-)
>
> Hi,
>
> until now, we have been quite lenient with creating lots of reference
> transactions even though they could've been bundled together into a
> single transaction. After all, it didn't have much of a downside in most
> contexts with the files backend: we'd have to lock each loose ref
> separately anyway. I'd like to get some feedback on changing our stance
> here, due to multiple reasons:
>
>     - The upcoming reftable backend will be more efficient if we use a
>       single transaction to bundle together multiple ref updates given
>       that it only needs to write one new slice instead of one per
>       update.
>
>     - Syncing refs to disk can be batched more efficiently if we bundle
>       ref updates. See my initial patch series to implement fsync-ing
>       refs [1] and Peff's benchmarks [2] demonstrating that fetches may
>       become a lot slower.

Maybe it's explained in the pointers, but is this in the case of the
files backend or the reftable backend or both?

>     - The reference-transaction hook can be used more efficiently given
>       that it would only need to execute twice, instead of twice per
>       updated ref.

Yeah, so that could be a regression for people who expect it to run
twice per updated ref.

>       It also has a more global view of what's happening.
>       While this is a concern of mine, it's a non-reason in the context
>       of the Git project given that we really ought not to change
>       semantics only to appease this hook.

Not sure I understand what you are saying here.

> With these reasons in mind, I'm wondering whether we want to accept
> refactorings which convert existing code to use batched reference
> transactions. While the potential performance improvements are a rather
> obvious upside, the downside is that it would definitely change the
> failure mode in many cases.

Another downside is that it changes how and when reference-transaction
hooks are called.

> The example I have here with git-fetch(1) would mean that if we were to
> race with any other process or if any other unexpected error occurs
> which leads us to die, then we'll not commit any change to disk. This
> can be seen as an improvement in consistency, but it can also be seen as
> a change which breaks current semantics of trying to do as much work as
> possible.

I like the idea, but it seems a bit safer to me to have 3 different
modes, so that people can test them in real life first for some time.
Then we might later be more confident with changing the default for
some backends. I might be worrying too much though, as very few people
probably use reference-transaction hooks.
