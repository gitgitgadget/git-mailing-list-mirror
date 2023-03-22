Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA07C6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 20:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjCVUGq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 16:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjCVUGM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 16:06:12 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFD25BC85
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 13:01:08 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id cy23so77601003edb.12
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 13:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679515252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNUudqR1ETIXGHKo+cDaOtv2zT1cZ/ad4eIVd57mRiI=;
        b=SxFtNDEmROrvZNE1GjkmbOR2HuJ/3Qrbey2L8LXS1TUZK/YGnE9EM8kQdR0/fSxHSg
         0V8MHEo0d7P/QlAbwd9kjsGvkCTV0/3nLGsewq5qbDI88L5HS7VnfZ2mvk7Ni4J29qvu
         sl1e/+APKkwL3LFUzjFGqmd4Zrv71A5u7hScWdx8SjFZ1zuZpLHwmUUxGdFjuL2oUFHO
         Bs2riq0yfrbCxHjBzZ7FGpoAtPO2KR+vnizms5QVl3QhLTNdaetOkuK/7QzgFW+Rcz8R
         RnU2v3tqxe6KQxut9nZw+N//O766VYx/s5z3wkvjxktzfey8zQN4pRBfqjs6S2lsVF2N
         bjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679515252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aNUudqR1ETIXGHKo+cDaOtv2zT1cZ/ad4eIVd57mRiI=;
        b=Iyo23G4vTjKfFmNetqf2bfR6zyeTRoiKPx8VakG0VbdbdB02ZfOyUoUSfQxsqAit1m
         WsBFgcP04Kf/9tKrUM8meeA/lu/eoqQMpNWNCDSCp6TiLQHTnWEnStYc9dZLKnoznY5m
         kv+D8OJnQXL6HOsMu5BVfxFK9qURq1UWdSs/kdRExRkB/lN5TKWd7rtnC2bCKSNw0LAP
         d9MKYZQIREn9dqO2c70/yuZ0sZ85z5nLJlFWg7IXk7jTgTPycXJihClGv0JRe0Ep3hZV
         dtjkExz/Un8K2+52EZsKvBAy9h3YLrlTXqsNju6QrPopCNAOPH8QEzxtAgsbF4CbY7B6
         FZNw==
X-Gm-Message-State: AO0yUKUeycnZxY/FzwyqDzep9t/7qBuhU/AKx+luL8fkI/zq00OymnKQ
        kgbHeCvhxxj+vezbhhGecnqiPiL+xbtHXed7VlNqFpL59vs=
X-Google-Smtp-Source: AK7set9+XlwWc8cPK4xmr4cS8C3nJNGIikxGes3O9RN12DZeA8cWHbdL2WWZgDiut88+RXmuxLM6O+lbVexCeXXrZmI=
X-Received: by 2002:a17:907:2c41:b0:8b2:8876:cdd4 with SMTP id
 hf1-20020a1709072c4100b008b28876cdd4mr3767806ejc.7.1679515251680; Wed, 22 Mar
 2023 13:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAMbUV8F8y62n5ud3AoWQak8J==Zrn7kzwTE7jCveVJEpfcqncg@mail.gmail.com>
In-Reply-To: <CAMbUV8F8y62n5ud3AoWQak8J==Zrn7kzwTE7jCveVJEpfcqncg@mail.gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Wed, 22 Mar 2023 13:00:40 -0700
Message-ID: <CAPx1GvftGM2kpVL9JWWXrjyTRWs+6OxteoJDq9dgeOjuidUGwg@mail.gmail.com>
Subject: Re: Destructive pre-commit behaviour and "--all"
To:     =?UTF-8?Q?Jan_R=C3=BCegg?= <rggjan@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2023 at 3:35=E2=80=AFAM Jan R=C3=BCegg <rggjan@gmail.com> w=
rote:
> Why doesn't "git commit --all" keep the files added to the staging
> area, so "git commit --all" would have the same behaviour as "git add
> --all && git commit"?

It's not completely clear to me what behavior you *want* here,
but I can answer the "why doesn't" question.

Remember that `git commit` can be aborted (in several ways).  If
it *is* aborted, whatever it did must be rolled back.  This means
that `git commit -a`, which is otherwise a lot like `git add -u &&
git commit`, is fundamentally different from a successful `git add
-u` followed by a `git commit`.  In particular, if the `git
commit` *is* aborted, the `git commit -a` command *must not* leave
the updated files in the index.  The `git commit` without `-a` did
not update any files in the index, so it does not have to "roll
back" the index update.

To achieve this, `git commit -a` doesn't actually update *the*
index at all.  Instead, it prepares a *new* index and updates
that new index.  It then proceeds to do the committing, using
the new index, rather than the main index, as if it were *the*
index.  If all goes well so that the commit is done, the code
then swaps in the *new* index for *the* index.  If the commit
is aborted, the code simply *deletes* the new index, leaving
*the* index unchanged.

This is fundamentally different from "update *the* index, then
start committing, then either roll back *the* index or leave it in
place": there's a secondary temporary index involved here.

Things get even more complicated if you use `git commit --only`
(vs `git commit --include`) as in this case there are *three*
indices simultaneously active ("the" index, "proposed index for
commit", and "proposed index if commit succeeds").  All three
must be managed carefully and correctly.

It is unwise to invoke `git add` in a pre-commit hook precisely
because there may be two or three indices, and `git add` cannot
affect all of them correctly.

Note that Git could be designed differently (with real databases
that have roll-forward and roll-back options), but that's a much
bigger change.  The process described here is merely how Git works
now, which explains the constraints on using `git add` in pre-
commit hooks.

Chris
