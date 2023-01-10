Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1F8C67871
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 10:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237981AbjAJKyy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 05:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237833AbjAJKyn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 05:54:43 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3C16A0E8
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 02:54:28 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id o7-20020a17090a0a0700b00226c9b82c3aso12980034pjo.3
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 02:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c640ise82ULnVdQIVYp6xtme74FKx+Hhsgd7mWbsu8I=;
        b=YqbC4oNGhn9F8KCpyHkyzz+XPn107bPGaTuhpGpmfoG4PKY5vveCcJec7MoGCz0rEB
         Rpk0mEimRYFfNf8FYxr68Wmu4bWZV4gT5O68o+UNIbmbiJq2Bb08H0RLB8FWPUBbEu/3
         FNJXpINsBRYuhJLK1bK/L6wMIYhSXq03a3y/RF7KLjjzp0YNkCHXCEh9TwEiOUqUmQ5+
         cQahp0vfPcbSLJle5DXLLSm2jkkEauIpfutdFr8Mf4IIbUzCnN6Z3YT7Cr7jF6UL+8aA
         0Ksy33SZ2mfL1NtoAFA+ecgI/zOFcNmU6UxwEE+xmakN+nVDzHCk+fcT/KR+WGxSuB65
         H1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c640ise82ULnVdQIVYp6xtme74FKx+Hhsgd7mWbsu8I=;
        b=RbRc1k6/1k/ORbMvsGV5s+G84LPmmCkFfrHrYoCZCkTquSlEp/ZBxvaX9IAaxEh4cs
         fTh7zkYpSAvogt83EHNNWcVe/j1++lesLFuqXqp949Y5Qaa19OIZEuAlSc+rJQfJzXDY
         39PJhvELtmB8yB1CBzTvbzm1fpU/Ev0oguTkRnL+jsh+FVkblwS/IJOfHC0CBVa9KjZu
         /IttSsDu0sHrU0ytE/V5P4tMqvNWJ7DlcnTp5WsMZAcGs4SbZdcTiLfi9cuvygnhV9Zk
         D36BYA8eDylnHb+O0zvpR23Cs3UWYu5uNYG8MSYZmRBVV4tJm4MUk4uFMMaaV13xSrFd
         CHtA==
X-Gm-Message-State: AFqh2kq1h+HQSzBPdmc/BKPKxdY3EBwBRjfyT3fZK+ytk/cwRpmG/43/
        wiI+/38Msbr5DZ8/TPezlx6qaC5BidRcD2UTv9ebZwpfsw6fdg==
X-Google-Smtp-Source: AMrXdXsAgDrV42t6JVefO2gAYVhz9BLPuJ8w20zN6toXTSgngU2UwXOtErx8plIuYXV6yVLvbRhz241SMQT+/AI/6K8=
X-Received: by 2002:a17:902:9b93:b0:192:a63d:4fb6 with SMTP id
 y19-20020a1709029b9300b00192a63d4fb6mr3074805plp.116.1673348068366; Tue, 10
 Jan 2023 02:54:28 -0800 (PST)
MIME-Version: 1.0
References: <CALDp=1EVmQE2NZAd7ccAT0z=R=2S8FvyJzsPNrDeXwdJkEW3Lg@mail.gmail.com>
In-Reply-To: <CALDp=1EVmQE2NZAd7ccAT0z=R=2S8FvyJzsPNrDeXwdJkEW3Lg@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 10 Jan 2023 11:54:16 +0100
Message-ID: <CAN0heSprKD35P-D7GTVQ20eRsj0AriYEA7iCDnrA9GuiwX0snw@mail.gmail.com>
Subject: Re: Bugreport: Prefix - is ignored when sorting (on committerdate)
To:     =?UTF-8?Q?Fredrik_=C3=96berg?= <fredrik@bakskuru.se>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hej Fredrik,

On Tue, 10 Jan 2023 at 10:50, Fredrik =C3=96berg <fredrik@bakskuru.se> wrot=
e:
> - Create a new repository
> - Add a new file to the repository and commit
> - Create a tag
> $ git tag -a TagOne -m ""
> - Update the file and commit the change
> - Create a tag
> $ git tag -a TagTwo -m ""
> - List tags by committerdate:
> $ git tag -l --sort=3Dcommitterdate
> (oldest tag is listed first)
> - List tags by reversed committerdate:
> $ git tag -l --sort=3D-committerdate
> (oldest tag it still listed first)

> Anything else you want to add:
> The correct behaviour (reversing sort-order by using the minus-prefix)
> has been verified in
> version 2.11.0, 2.11.1, 2.14.2, 2.19.1, 2.19.2, 2.23.0 on CentOS 7.4
> version 2.31.1 and 2.35.1 on CentOS 7.4 contains the error
> version 2.34.1.windows.1 contains the error

This bisects to 7c5045fc18 ("ref-filter: apply fallback refname sort
only after all user sorts", 2020-05-03). I've cc-ed the author. That
commit does change the behavior for the kind of test repo you describe.

That said, you're using "committerdate" here. If you use "taggerdate"
(or "creatordate") I think you'll get the output you expect, even for
newer Git versions. Does that help?

Since you just have two commits in the reproducer, there's a strong
correlation between tag names and the timestamps involved. You actually
end up sorting by refname: because there is no committerdate for these
tags, the refnames are compared as a fallback. While the old code then
applied the reversal ('-') to *that*, the new code first fails to find
any difference, so doesn't have anything to reverse, then falls back to
comparing the refnames, at which point it doesn't consider reversing the
result.

All of this is based on my understanding. I could obviously be wrong.

I suppose it could be argued that the '-' should be applied to the
fallback as well, e.g., to uphold some sort of "using '-' should give
the same result as piping the whole thing through tac" (i.e., respecting
`s->reverse` in `compare_refs()`, if you're following along in
7c5045fc18). With multiple sort keys, some with '-' and some
without, we'd grab the '-' from the first key. It seems like that could
make sense, actually.

I might post such a patch, but as noted above, I think what you really
want to use is "taggerdate". I hope that helps.

Martin
