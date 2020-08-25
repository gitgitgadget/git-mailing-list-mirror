Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6564C433E3
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB7E2076C
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nelhage.com header.i=@nelhage.com header.b="V+Iyyoh1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgHYSiT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgHYSiS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 14:38:18 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85182C061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:38:17 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id a1so6887013vsp.4
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nelhage.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=YIPtapUgBpGbYN9TXhOzzhwq1YNXPZ8YljVw0iXBUlM=;
        b=V+Iyyoh1XTH2bYdyvCosetUUeaRZMQIlPdOHCEJ9srYZsaVuZG45lYXhFgWt/W9Q88
         ILrHURWqlpmgk16dDN6RsKhSZceSZWU4OPVCmRiafP93Drs0f+2AkOFoMXWIxsC4OuTg
         5MCOm7Q1GV/P1Gl0Q1LS40BfQhjt0V89oM5yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=YIPtapUgBpGbYN9TXhOzzhwq1YNXPZ8YljVw0iXBUlM=;
        b=B6HGvXz9f559nx3Flhsil4KnmuKZ5QfVCiHDTijoBr2sBFxRB+qeHewCYTQLZWU9c6
         TAS7ovEfG2WH9tcIVKeMwQn14FleeEzNuY/HGjmqrZugLWUTv3NxDRJQK/XOxfwegtzU
         eHlkSkE8ihI9+3FHEExiwP9NmMsnALE7px+WbKoRuc7ob/tnhLq1ikR0sXQsqkwpLZbq
         cW2D5+ms7l8YODOGsI0CmLtB5lW5at+lQVYeBSrsfCCVTjDNyIQp0N+B6eAyH2vrxu/c
         S++tKJdk+JRxx7Z2a58ys6BzrHykTLX5MRN9qSxJnBoKWYzEt2lOn+CGSU8WTAa1BIgL
         bYsQ==
X-Gm-Message-State: AOAM530mtrF84QMPm8v6aC7cAaKjbfCQvIFJa/osrnhjO9LFwMTQ7jn1
        lD37NzlQL8FJ8VbkUDoh951TTOd3G4TMnd59EdG7oEHigSz9GRPB
X-Google-Smtp-Source: ABdhPJxSuASfVbclqcN4GtVQ9y60nYVzj4ueMBvPzmbXzMwnOhs+WK8X84eZFjXXDn2m1WJK0ygYb23V3tDBH0GSnVg=
X-Received: by 2002:a67:ed06:: with SMTP id l6mr6914057vsp.216.1598380695224;
 Tue, 25 Aug 2020 11:38:15 -0700 (PDT)
MIME-Version: 1.0
From:   Nelson Elhage <nelhage@nelhage.com>
Date:   Tue, 25 Aug 2020 11:38:04 -0700
Message-ID: <CAPSG9dZV2EPpVKkOMcjv5z+NF7rUu=V-ZkZNx47rCv122HsiKg@mail.gmail.com>
Subject: git clone --shallow-since can result in inconsistent shallow clones
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

I ran

  git clone --shallow-since="1548454011" "https://github.com/abseil/abseil-cpp"

to produce a shallow clone of abseil-cpp.git, with the aim of going
deep enough to grab commit `5e0dcf72c64fae912184d2e0de87195fe8f0a425`,
which I know to have a commit date of `1548454011`.

What did you expect to happen? (Expected behavior)

- I expected the command to produce a valid shallow git clone.
- I further expected the repository to include commit
  5e0dcf72c64fae912184d2e0de87195fe8f0a425, which has a commit date <=
  the provided `--shallow`, as do all of its descendants up to the
  `master` branch

What happened instead? (Actual behavior)

- The clone command produced an inconsistent shallow clone. In the
repository I see:

    $ cat .git/shallow
    5e0dcf72c64fae912184d2e0de87195fe8f0a425
    89ea0c5ff34aaa5855cfc7aa41f323b8a0ef0ede

But commit `5e0dcf72c64fae912184d2e0de87195fe8f0a425` is missing. An
attempt to `git fetch --unshallow` errors out, because the server
sends an `unshallow 5e0dcf72c64fae912184d2e0de87195fe8f0a425`, which
we are unable to execute since we're missing that object.

That object is also the specific one I mentioned above that I wanted.

What's different between what you expected and what actually happened?

Anything else you want to add:

The problem here is triggered by passing a `shallow-since` that lies
*between* the first and and second parents of a merge commit that
itself is on the first-parent spine. If we examine the relevant
portion of `abseil-cpp.git`'s history, we find:

    $ git --no-pager log --format='%h %ct' --graph
89ea0c5ff34aaa5855cfc7aa41f323b8a0ef0ede~6..89ea0c5ff34aaa5855cfc7aa41f323b8a0ef0ede
    *   89ea0c5 1548698816      # WANT
    |\
    | * 7ec3270 1548194022      # WANT
    * | 5e0dcf7 1548454011      # WANT
    * | 0dffca4 1548346230      # DON'T WANT
    * | 6b4201f 1548261751      # DON'T WANT
    |/
    * 0b1e6d4 1547838308        # DON'T WANT
    * efccc50 1547753737        # DON'T WANT

I've annotated the commits with WANT or DON'T WONT based on whether or
not their commit time is included by the `--shallow-since` filter.

What is happening, I believe, is that we are marking 89ea0c5 as
shallow, since its first parent is unwanted. However, marking it
shallow causes pack generation to ignore _all_ of its parents,
including 7ec3270, which we _do_ want. This results in the
inconsistent state where we mark `5e0dcf7` as shallow (and send the
`shallow` line), but don't send the actual object.

It's unfortunately a bit unclear to me what _should_ happen here. We
really want a way to mark `89ea0c5` as "partially-shallow", and send
its second parent, but not its first parent, but shallowness is a
property of an entire commit, not of a specific commit/parent
relationship. However, it'd be nice if we at least ended up with a
consistent state, instead of with a repository with invalid `shallow`
marks.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.28.0.461.g40977abb40
cpu: x86_64
built from commit: 40977abb4059c11004726852a79df64f4553944d
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.4.0-42-generic #46-Ubuntu SMP Fri Jul 10 00:24:02 UTC 2020 x86_64
compiler info: gnuc: 9.3
libc info: glibc: 2.31
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

- Nelson Elhage
