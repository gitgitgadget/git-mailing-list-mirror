Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF19C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 00:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 870A6619E8
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 00:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344137AbhKPA3I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 19:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343609AbhKOTpc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 14:45:32 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AB3C06121E
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 11:40:26 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id w1so76947409edd.10
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 11:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=IYxWosaxkaIKfCWygBpV+J0kJhfwRrq2bvfvZ7CHHak=;
        b=l13EQginPxtbDhnxgJtZyZzjBvb/j92mHxX40bz+Q8/1UEd+T1tMiJkrViXzIbFwWy
         NktCdLENH/jhAX5GhyFA+HcinNk1szD99sExeEUl3u3AYfvS91hFFIjB39Re2/oQ5gvt
         GVsAXXv88DxG7QE8sGoKJXU8uX1QLSzftBzrqlc7QGTaYHi1C1CMRlViqydRLI8VUCpW
         UjZZBgHJ6MzC/KjlTNKM2kPw+MtBhoXeLlvqUUeV6POhYdjRkh+O0qlLMYe2McfY56pQ
         u6hvZ9LVLBN0uMV3BbxUdqB6nxOMA8VbVRajETg3Lldz+a82T+r0kcjTdt7yZznKHjSE
         mThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=IYxWosaxkaIKfCWygBpV+J0kJhfwRrq2bvfvZ7CHHak=;
        b=g8CKtXPHEgosb2gXFJX0HZk/wAnvAael92+kMpZIeodw+FMieRBLCRqHc5CUc2i7yW
         hh9alfKOgZGi4A9XiJWGIY3oaehMfvyrmHJGvxJm7+vn/QVx8RN3hYUIN1RPGd/w2kun
         WS72+HIjBbWnXQ5mZJTooEIGPLmkVyzREqtoyNY2Dz3gadpM3Y6lDX7GF+vWcIbIf38L
         B439msgFXk3i3HFEH/mFFa7D80p21OQJrxRW/KnIk3BbkTod+iYsP/oj+PD6yxymBXV+
         Q6p7V3Z6iLKhNcMDmT1xoNE7bh38wSSuXAJWVN6NiM8Ut5VTGLfQhyEkRie9TtrM4bqU
         skSw==
X-Gm-Message-State: AOAM5331whPAxgTYuYXKwl0Md0VKtcz78lvNfOu2gGVv5vhrzeVo39P7
        yBL6LqORrkZVBVZqDB6eSQ4LBpqLFZ0=
X-Google-Smtp-Source: ABdhPJws/oLxvhc8zJwARs9jd5gAn0mKSA3L7fEPKj2D2Q4fPbXVD16dr24ptUMVn3fbzZIbfCZxiA==
X-Received: by 2002:a17:907:2d21:: with SMTP id gs33mr1778606ejc.549.1637005225417;
        Mon, 15 Nov 2021 11:40:25 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k16sm6680247edq.77.2021.11.15.11.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 11:40:25 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mmhq4-001CYk-9x;
        Mon, 15 Nov 2021 20:40:24 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/refs-errno-cleanup + hn/reftable (was: What's cooking in git.git
 (Nov 2021, #04; Sun, 14))
Date:   Mon, 15 Nov 2021 20:37:57 +0100
References: <xmqqv90tfhh2.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqqv90tfhh2.fsf@gitster.g>
Message-ID: <211115.86sfvxqkbb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 15 2021, Junio C Hamano wrote:

> * ab/refs-errno-cleanup (2021-10-16) 21 commits
>   (merged to 'next' on 2021-10-29 at 3f57147176)
>  + refs API: post-migration API renaming [2/2]
>  + refs API: post-migration API renaming [1/2]
>  + refs API: don't expose "errno" in run_transaction_hook()
>  + refs API: make expand_ref() & repo_dwim_log() not set errno
>  + refs API: make resolve_ref_unsafe() not set errno
>  + refs API: make refs_ref_exists() not set errno
>  + refs API: make refs_resolve_refdup() not set errno
>  + refs tests: ignore ignore errno in test-ref-store helper
>  + refs API: ignore errno in worktree.c's find_shared_symref()
>  + refs API: ignore errno in worktree.c's add_head_info()
>  + refs API: make files_copy_or_rename_ref() et al not set errno
>  + refs API: make loose_fill_ref_dir() not set errno
>  + refs API: make resolve_gitlink_ref() not set errno
>  + refs API: remove refs_read_ref_full() wrapper
>  + refs/files: remove "name exist?" check in lock_ref_oid_basic()
>  + reflog tests: add --updateref tests
>  + refs API: make refs_rename_ref_available() static
>  + refs API: make parse_loose_ref_contents() not set errno
>  + refs API: make refs_read_raw_ref() not set errno
>  + refs API: add a version of refs_resolve_ref_unsafe() with "errno"
>  + branch tests: test for errno propagating on failing read
>
> The "remainder" of hn/refs-errno-cleanup topic.
>
> Will cook in 'next'.
>
> [...]
>
> * hn/reftable (2021-10-08) 19 commits
>  - Add "test-tool dump-reftable" command.
>  - reftable: add dump utility
>  - reftable: implement stack, a mutable database of reftable files.
>  - reftable: implement refname validation
>  - reftable: add merged table view
>  - reftable: add a heap-based priority queue for reftable records
>  - reftable: reftable file level tests
>  - reftable: read reftable files
>  - reftable: generic interface to tables
>  - reftable: write reftable files
>  - reftable: a generic binary tree implementation
>  - reftable: reading/writing blocks
>  - Provide zlib's uncompress2 from compat/zlib-compat.c
>  - reftable: (de)serialization for the polymorphic record type.
>  - reftable: add blocksource, an abstraction for random access reads
>  - reftable: utility functions
>  - reftable: add error related functionality
>  - reftable: add LICENSE
>  - hash.h: provide constants for the hash IDs
>
>  The "reftable" backend for the refs API, without integrating into
>  the refs subsystem.
>
>  Will merge to 'next'?

I think hn/reftable is very much ready for "next", and it would be good
to get a strong start at the greater "reftable" topic this cycle, which
ab/refs-errno-cleanup is also a part of.

As noted in a recent thread[1] I've got pending patches on top of it
that go further in closing the gap between hn/reftable and eventual full
in-tree integration.

1. https://lore.kernel.org/git/211111.86k0hevjhs.gmgdl@evledraar.gmail.com/
