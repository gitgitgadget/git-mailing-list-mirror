Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700A9C33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 19:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305A524658
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 19:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="EBBUIGXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgANTeI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:34:08 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:56302 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANTeH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 14:34:07 -0500
Received: by mail-pj1-f68.google.com with SMTP id d5so6131911pjz.5
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 11:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pBUkhFWYJtceRjj0EaSxvqsXx+djmRLSW1yTsBQpYx8=;
        b=EBBUIGXL4eO7ckIeUmXldklsEhSb/ygYpPTGEJ6QhHgN0iIxg6GNg9ZVqtgm88Z8d7
         oarTOLiOzszujCJ9ULA8v1aCauRw7If4ynRtPU5Zyq/ruOYd/oDgN8bMFi0FcQ3Y6G2g
         KO27PhdkUE5FgGIol52eRY3LDkEzX0jVrmnjLCENDL3ZZ/SnaTHIfj920oXNRD2LoXnG
         A136hazl9B+ggC17qVXjNpcaM4pe7+G5RrkO+Yy+ELcszFnT96XJczEedIwA2j9sC3Vv
         jKGY4ICIbnryMdD3GYjMA6kG33HAivYWe3g5/zZmOSwKOYSUyULOKSrXtFm+6l7o8Yh8
         tjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pBUkhFWYJtceRjj0EaSxvqsXx+djmRLSW1yTsBQpYx8=;
        b=Qqz6JziUGM5RTqYAWfrm5CezR2YZBKDM7ryXjDUnWRFDYHrmYc/Q28gr1vArk+pNqD
         X0ndW0XVM8bDZdYbg2Fr1yJaLq6GEva+L9PPicSlJZXvpSaGMM3mn1W4BDOep64wWzxu
         AkCb8rhO3nN8v7Mo7+2dy2DF4UO229qoRkYQAy7mPYwF89HiSaRosadKWheE9hjICdCK
         U/+bAzTigzoRnQoMTUJFs/UKrQHQLdSwimwXppivfN3azj6NqKT7xSzB3zgvk8ExCXFR
         KzPKJUM68q10/rOwYV8R+U2a9ZrP6Tx0hPAgSy4f/nZQ2gIXq72XKaWDJBEN+aidD+3k
         d8tw==
X-Gm-Message-State: APjAAAWroovU5MLEXmrAjx5FKnfi1NtEvovYYhWLklrlP2gdSmghnSDs
        DcK5NrLPg6TpMHxxlQwgmk+IsA==
X-Google-Smtp-Source: APXvYqxso0+zZJU6WXAvzLAq1uYc/YAZfUQ/ZEVb6y85GXXoIbb/NruvESyZJr7jxvMlKK0CTE+qAQ==
X-Received: by 2002:a17:90a:8685:: with SMTP id p5mr31110742pjn.92.1579030446895;
        Tue, 14 Jan 2020 11:34:06 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:142b:64f6:3f95:951f])
        by smtp.gmail.com with ESMTPSA id b21sm20362245pfp.0.2020.01.14.11.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 11:34:06 -0800 (PST)
Date:   Tue, 14 Jan 2020 11:34:05 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        newren@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 0/8] Harden the sparse-checkout builtin
Message-ID: <20200114193405.GA8674@syl.local>
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.513.git.1579029962.gitgitgadget@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Tue, Jan 14, 2020 at 07:25:54PM +0000, Derrick Stolee via GitGitGadget wrote:
> This series is based on ds/sparse-list-in-cone-mode.
>
> This series attempts to clean up some rough edges in the sparse-checkout
> feature, especially around the cone mode.
>
> Unfortunately, after the v2.25.0 release, we noticed an issue with the "git
> clone --sparse" option when using a URL instead of a local path. This is
> fixed and properly tested here.

I haven't had a chance to look at the other patches (besides the one
that I have already reviewed on- and off-list), so take my comments here
with a grain of salt.

It's too bad that 'git clone --sparse' isn't working with URLs in
v2.25.0, but it happens, and I don't think that this is a grave-enough
issue to warrant a new release. At least, since '--sparse' is new in
v2.25.0, we're not breaking existing workflows that have already relied
on it.

And, since sparse-checkout is still relatively niche (at, least for now
;-)), I think that this not handling cloning from URLs is fine until
v2.26.0.

Of course, if there's ever another need for v2.25.1, I don't think that
this would *hurt* to release then, which is to say that we definitely
should have these patches in a release, soon, but I don't think that
there's a terrible sense of urgency in the meantime.

> Also, let's improve Git's response to these more complicated scenarios:
>
>  1. Running "git sparse-checkout init" in a worktree would complain because
>     the "info" dir doesn't exist.
>  2. Tracked paths that include "*" and "" in their filenames.
>  3. If a user edits the sparse-checkout file to have non-cone pattern, such
>     as "*" anywhere or "" in the wrong place, then we should respond
>     appropriately. That is: warn that the patterns are not cone-mode, then
>     revert to the old logic.
>
> Thanks, -Stolee
>
> Derrick Stolee (8):
>   t1091: use check_files to reduce boilerplate
>   sparse-checkout: create leading directories
>   clone: fix --sparse option with URLs
>   sparse-checkout: cone mode does not recognize "**"
>   sparse-checkout: detect short patterns
>   sparse-checkout: warn on incorrect '*' in patterns
>   sparse-checkout: properly match escaped characters
>   sparse-checkout: write escaped patterns in cone mode
>
>  builtin/clone.c                    |   2 +-
>  builtin/sparse-checkout.c          |  52 ++++-
>  dir.c                              |  69 ++++++-
>  dir.h                              |   1 +
>  t/t1091-sparse-checkout-builtin.sh | 320 ++++++++++++++++-------------
>  5 files changed, 296 insertions(+), 148 deletions(-)
>
>
> base-commit: 4fd683b6a35eabd23dd5183da7f654a1e1f00325
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-513%2Fderrickstolee%2Fsparse-harden-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-513/derrickstolee/sparse-harden-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/513
> --
> gitgitgadget
Thanks,
Taylor
