Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C21C433FE
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 02:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbiBACD3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 21:03:29 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59095 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbiBACCy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 21:02:54 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 226011675F3;
        Mon, 31 Jan 2022 21:02:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=iSL4Y8VYZRFMjrOlKFqjngah1hObF1AzbQs8vHUb4BE=; b=ks7C
        mAf2RIDl1tCiXwhj5bH2DJHrbOdzpHLpvcmUwUMHdgz+ubNVCXDTcJqzBQ78Y4WY
        8AJQcY1eRTWfb9nsho918DCFkW1fwtZBh21ul90gaEQt63MmfuNWOd8tAIdMeP/b
        WisYWJrxVeFlR9tbCwWk8/5A1PKzLNarlYkDkBw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 19C421675F2;
        Mon, 31 Jan 2022 21:02:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 89A401675F1;
        Mon, 31 Jan 2022 21:02:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] refs.h: make all flags arguments unsigned
References: <pull.1210.git.git.1643660136530.gitgitgadget@gmail.com>
Date:   Mon, 31 Jan 2022 18:02:50 -0800
Message-ID: <xmqqa6fbgx85.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0FDB169E-8303-11EC-8C9D-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> As discussed in
> https://lore.kernel.org/git/xmqqbkzrkevo.fsf@gitster.g/ , we don't
> want to treat the sign bit specially, so make all flags in refs.h
> unsigned.

It may be true that we do not want to, but are we sure there is no
code that already uses some cleverness to make the topmost bit
special by e.g. doing ugly things like "if (flags < 0)" ;-)?

IOW, what we want or do not want does not matter as much as what the
code paths that use these declarations want to do (and we need to fix
them before we can do this conversion).

I haven't had energy to vet the entire codebase for all flag words
and that is why I've never produced a patch like this one myself.

Thanks for carefully vetting after creating this (presumably
mechanically prepared) patch---producing is the easy part, but
making sure it does not break unexpectedly is much harder.

Somebody other than the author needs to double check the result,
though.

Thanks.

>  bisect.c                    |  4 +--
>  builtin/bisect--helper.c    |  7 ++---
>  builtin/branch.c            |  4 +--
>  builtin/checkout.c          |  9 ++++---
>  builtin/describe.c          |  3 ++-
>  builtin/fetch.c             | 10 +++----
>  builtin/fsck.c              |  4 +--
>  builtin/gc.c                |  5 ++--
>  builtin/name-rev.c          |  3 ++-
>  builtin/pack-objects.c      | 11 ++++----
>  builtin/rebase.c            |  5 ++--
>  builtin/receive-pack.c      |  4 +--
>  builtin/reflog.c            |  5 ++--
>  builtin/remote.c            | 13 ++++++----
>  builtin/repack.c            |  4 +--
>  builtin/replace.c           |  4 +--
>  builtin/rev-parse.c         |  6 +++--
>  builtin/show-branch.c       |  6 ++---
>  builtin/show-ref.c          |  4 +--
>  builtin/stash.c             |  2 +-
>  builtin/submodule--helper.c |  4 +--
>  builtin/symbolic-ref.c      |  2 +-
>  bundle.c                    |  2 +-
>  commit-graph.c              |  5 ++--
>  config.c                    |  2 +-
>  delta-islands.c             |  2 +-
>  fetch-pack.c                |  7 ++---
>  help.c                      |  2 +-
>  http-backend.c              |  4 +--
>  log-tree.c                  |  4 +--
>  ls-refs.c                   |  4 +--
>  midx.c                      |  5 ++--
>  negotiator/default.c        |  2 +-
>  negotiator/skipping.c       |  2 +-
>  notes.c                     |  5 ++--
>  object-name.c               |  2 +-
>  reachable.c                 |  2 +-
>  ref-filter.c                |  3 ++-
>  refs.c                      | 52 ++++++++++++++++++-------------------
>  refs.h                      | 38 ++++++++++++---------------
>  refs/files-backend.c        | 17 ++++++------
>  remote.c                    | 10 +++----
>  replace-object.c            |  7 +++--
>  revision.c                  |  8 +++---
>  server-info.c               |  2 +-
>  shallow.c                   |  4 +--
>  submodule.c                 |  4 +--
>  t/helper/test-ref-store.c   |  4 +--
>  transport-helper.c          |  2 +-
>  transport.c                 |  2 +-
>  upload-pack.c               |  8 +++---
>  walker.c                    |  2 +-
>  worktree.c                  |  6 ++---
>  53 files changed, 171 insertions(+), 167 deletions(-)
