Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000D1C77B73
	for <git@archiver.kernel.org>; Wed, 31 May 2023 04:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbjEaEO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 May 2023 00:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjEaEO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2023 00:14:26 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED37BE
        for <git@vger.kernel.org>; Tue, 30 May 2023 21:14:24 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2af2c7f2883so56408121fa.3
        for <git@vger.kernel.org>; Tue, 30 May 2023 21:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685506462; x=1688098462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3QArIQ51ZSmJuEOOlY/cqsMSGZ/DsJAOfmjlnYd/9U=;
        b=MPDf3x5frOG9vHtUc5fL4Z9oBjwPVj+WKDfkLvsZreI8LTzpzCRLpY+SWTP8BZLkIZ
         rcBLYr1/6oio+M8DiQIzrZLiQ8n+pNebUYIHpw8FAJ+QI6NP9zPiwrmtP1AkIydR89G5
         ++GPQzl2zRRHD2pF2Sy+AxkPY42O1X6lNkefEfeS40uVBqBNRab7QB19iVWqF+N/GLf2
         IEcE5jGsqPaFWHoaQa+LrqMd8mP5oZsOE4JQ6r80ShW8D54Ge+tK8YShRAFgqzEDqtSh
         cnpbYttWkQk2lerDnpCdi/nG32qwlZaE+rxMZTTh5voWzpts1iNhWQ4KAVW3IdxJf/YA
         KEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685506462; x=1688098462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3QArIQ51ZSmJuEOOlY/cqsMSGZ/DsJAOfmjlnYd/9U=;
        b=hFlvsq2B3v2hY+LbVy3XtXF0+1v2oBrMfEViST2guFG9IQYmYUhhPwmjwTn7Z+T2nn
         z/9gRxEgdNm2h8Z98MsqLY7zP6ZLxt4dB3JsIjW4LcT/MH/rj2+cXWQwMznwZltr0nSN
         TsvkI/r/wC2+A9+d4cK+ASaNFJzwuLw3XAAvRaIcjkbfjauQi6MOGI1AcT8tuLVlm1DY
         Ac7D0BI3CKMp0i6H0ABMfRcpW5pQjitcWUWkQKq6cqtBX6ePREVZFdrcLSmHCZWFb9de
         TzlspVWBVvCxky9kCBSM/wg/03ayOu2Hn3dia/otAggzF7iR37ngK2RP7mEt83ZgVJdB
         2o2Q==
X-Gm-Message-State: AC+VfDyUI8jlz96A2cHcZCf5t7HJ2Tu7BZGH79nR5rlr2edDK3cnLZz9
        JL+peXChsYkVGdAobQ/U8V0limOnUatOndLKRaw=
X-Google-Smtp-Source: ACHHUZ7B84dRvVrXyao5dtbgFelOzaOTo5aZ8HNfkH4W8/5hexuKnJ6GjMc2Hkk428UrF4lR1jPgV07SYptWeeZmWuM=
X-Received: by 2002:a2e:8302:0:b0:2b0:4c72:98fe with SMTP id
 a2-20020a2e8302000000b002b04c7298femr1842326ljh.45.1685506461900; Tue, 30 May
 2023 21:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <CACoUkn7TmZ=trtDKcQm0SG5qCqK=-+YxrDV-7xYnLH_XK7K7og@mail.gmail.com>
 <CACoUkn6F_=JR5SYBWL2sVDxDVAZbxcV5Ruif6wLba-_q_QNiZg@mail.gmail.com>
 <198eea19-fc40-de0c-8854-3cdc94925f32@gmail.com> <CACoUkn4TOGi7xojSatEowF0CcFJHJof+F5XR-QtPTL5iznZDKw@mail.gmail.com>
 <cc93b0ed-1167-a017-2138-181a490d26e2@gmail.com>
In-Reply-To: <cc93b0ed-1167-a017-2138-181a490d26e2@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 30 May 2023 21:14:09 -0700
Message-ID: <CABPp-BEAnB-6ogcohMWMmktr9SrwMtM0-dw1pypcJedcMMcsCg@mail.gmail.com>
Subject: Re: Automatically re-running commands during an interactive rebase or
 post commit
To:     phillip.wood@dunelm.org.uk
Cc:     Paul Jolly <paul@myitcv.io>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 29, 2023 at 12:48=E2=80=AFPM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
> On 29/05/2023 20:08, Paul Jolly wrote:
[...]
> > I have a custom merge strategy working, insofar as I've written a
> > script that is being called. The script simply wraps "git merge-ort"
> > as you suggest.
> >
> > But I can't seem to work out how to actually run 'git merge-ort'! I've
> > tried 'git merge -s "$@"' in my wrapper script, but doing so my custom
> > strategy behaves differently to if I use no strategy, which seems to
> > suggest I'm doing something wrong.

Don't call `git merge` from your custom merge strategy.  That's just
asking for trouble; we should probably modify the code to throw huge
errors if people attempt that.

Use lower-level primitives, such as `git merge-tree`, `git
merge-file`, `git read-tree`, `git update-index`, `git merge-index`,
`git merge-one-file`, etc.  Bias towards the first two of those.

> > Do you have any suggestions/pointers?
>
> Sorry, I'd assumed there was a merge-ort command in the same way as
> there is a merge-recursive command but it does not exist. I think the
> best you can do is run "git merge-recursive" rather than "git merge-ort"
> in your script. I've cc'd Elijah in case he has a better suggestion.

In short, I'd say use `git merge-tree` instead of `git
merge-recursive`, but the long story about the latter command is:

First of all, we _currently_ have a bunch of executables & scripts,
one per merge strategy:
  * git-merge-octopus
  * git-merge-resolve
  * git-merge-recursive
  * git-merge-ours
But, in this set, git-merge-recursive is builtin and isn't called as
an external program, so that's not a reason I think it should exist,
and we certainly shouldn't add another for `ort` based on this
rationale.  (The others may also be replaced with builtins; there were
even patches in that direction, though they weren't followed up on.)

Second of all, we've had multiple ways to expose users to "doing a merge":
  * git-merge
  * git-merge-recursive
  * git-merge-tree
The first is the one most users are familiar with, `git merge`.  So,
about the others...  Traditionally, git-merge-tree was a virtually
useless implementation that fell way short of the good idea to 'make a
merge without touching the worktree or index'.  In contrast,
git-merge-recursive was in between git-merge-tree and git-merge in
terms of how low level it was.  It still required updating the working
tree and index, which limited what could be built on top of it, but
unlike git-merge-tree it at least provided useful functionality in
that it could do-all-parts-of-the-merge-except-commit-and-update-branch.
While not optimal, that was enough that git-merge-recursive got used
in some places (such as one of the rebase backends once upon a time).
Nowadays, though, git-merge-tree is the correct low-level primitive --
it can do a merge without updating branches, creating a commit, or
updating the worktree or index.  That means that git-merge-recursive
isn't really useful from this angle either; everything can be built on
top of something a little lower level.

The two angles above were the reasons that git-merge-recursive
existed, but neither is useful nowadays, so git-merge-recursive is
basically a historical relic (which we are keeping for backward
compatibility purposes, not for any intrinsic value I can see).  I
don't want to add another useless historical relic, in the form of
`git-merge-ort`.

But there's a third reason to not provide `git-merge-ort` as well: The
plan has always been to use `ort` as a drop-in replacement for
`recursive` and make _all_ calls within the code unconditionally
translate requests for `recursive` to call the `ort` code instead.  I
just haven't gotten around to finishing those plans yet.  (In fact,
there are only two places in the code that still call the recursive
backend by default -- git-merge-recursive and git-am, both of which
I've been meaning to fix up).  So, making a `git-merge-ort` would make
it really weird in the future in that we'd have both
`git-merge-recursive` and `git-merge-ort` calling the same thing.

Anyway, if you want a low-level do-a-merge thing, use `git merge-tree`.
