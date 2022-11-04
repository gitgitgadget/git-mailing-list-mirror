Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D018AC4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 04:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiKDErO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 00:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiKDErM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 00:47:12 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206D3275F6
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 21:47:11 -0700 (PDT)
Date:   Fri, 04 Nov 2022 04:47:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail2; t=1667537228; x=1667796428;
        bh=11LUb6epBlclHhZjmBxQktldXNIm8eoxVXjM65qJPZM=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=xH6+zCcIMwwiaBVf3LqsGLRCmX/Ar4LVCLp7PJOg0QNoLLQbupIqOZH97+lf1mFzr
         LGHbcn1D3b3JT4JQb4yZnQgLiSmk4faFqmMOw1OLw05DB49QviOzAYtdae/dNm8zUM
         eEGDd3U2TSQdnYBKadwVxIh6C0zG0b3GxFo9Tc+0Xru5RsIybo/V59i0l6W8DIzzvA
         eY7s4VeV4j1bYdIvSwkQrg3kwNXavxX/I8nnfkHb2MR89udRF/3BfbVi+AZb9s5kEu
         r9DP+EH5qrlqaCr9EtGXhvJzFjFoYOrWhIXAL2eyZbJ5KErILb3bMipj+TVg1Up7iH
         76gMN3YidM4ag==
To:     Eric Sunshine <sunshine@sunshineco.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4] worktree: Support `--orphan` when creating new worktrees
Message-ID: <20221104044653.c4qa32ojwculq6bl@phi>
In-Reply-To: <CAPig+cQV7Udz4mn2V7P8ZsVoFiCRMJwNiG23GL6NAOxM4iuzmw@mail.gmail.com>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <CAPig+cQV7Udz4mn2V7P8ZsVoFiCRMJwNiG23GL6NAOxM4iuzmw@mail.gmail.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/11/04 12:33AM, Eric Sunshine wrote:
>
> I'm pretty sure that we don't want to go the route of using
> heavyweight and heavily-featured `git checkout` as a substitute for
> lightweight `git reset --hard`. In fact, worktree functionality
> started life as a special checkout mode invoked by `git checkout
> --to`. A good deal of work[2][3][4] went into extracting that
> functionality to a standalone `git worktree add` command, and
> eventually ridding `git worktree add` of its unfortunate dependency
> upon `git checkout` as a backend[5][6][7], and ridding `git checkout`
> of its ugly intimate specialized knowledge of a newly-crafted
> worktree.
>
> The key motivation for rejecting `git checkout` as backend and
> migrating to `git reset --hard` came from Junio[8][9], and I trust
> that his observations are still pertinent.
>
> So, rather than swapping out `git reset --hard` in favor of `git
> checkout`, we probably want to stick with the already-established
> approach of adding the necessary machinery to `git worktree add`
> itself (or by refactoring `git checkout` machinery to be reusable),
> just as we did for other `git worktree` options which have `git
> checkout` counterparts, such as --track[10], --guess-remote[11],
> --[no]-checkout[12], --quiet[13], etc.

I agree. I appreciate you sharing the history as it makes sense now why
it is this way in particular.

I think I found an alternative which was mentioned over in another reply [1=
]
(running `git symbolic-ref` after running `git reset`) and I'm going to try
implementing that for v2 and hope it doesn't introduce any complications.

