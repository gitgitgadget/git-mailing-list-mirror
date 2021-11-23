Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638C7C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 20:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhKWUcG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 15:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbhKWUcF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 15:32:05 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520CEC061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 12:28:57 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so3045483pjb.5
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 12:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iSYEpu9kdb6JvuMAoWZ3BoJ8C4R6ZZLej13iUlni4EU=;
        b=hCKfttVdNL9YCrKm9OGRuJOYzZL3x0YYHUReM+z2j4JzeuKg74xDSoQKCa4X/NDVXG
         Cux4PRLPgm48uks7SwKdLnOlM6BHj6r737UFmklSkpaDJYpqb76VDBzaLBSvsJC7CaCm
         7fde1XXh8CTUPZtumfgyow60TbJENZzYG+xx2GRep95Pnbbadfvcv3FxPD4mQi8/xu1q
         yVyPzgCTUTsa2JqsM4+mIZpPMxNvxoGKi150EKLsrVPkhgSTqSseybLJ0/QaDtRXWuGP
         RmT0W73EP9Vn6h+HssgDv6nmVDgUDPqHZEJ+PnPLqwkSIK7unvJj/1p0gjYVfO/Af2jn
         Yh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iSYEpu9kdb6JvuMAoWZ3BoJ8C4R6ZZLej13iUlni4EU=;
        b=CWXntUd2nCTmjKstZcroig+WFxEQQY4g92qr7aJkdgRgyFcJZewmApEc5hU2uAsC+t
         uBu3hwOBjQnLvBwXSoUtxUhr5YBPnupgrbL16TQhaPCY4etNWOOyKSF5bjnKKXHllmaf
         TFk87+5tq1Q/vu+ej7hQ/tvH/wTKZgdAIjXTI29kNetBVLgO1OZ3cDdc6FX7iEZ26SfA
         tlZb1xCdCQRyhviqUobMXZWV7I9yEiRbTVhPjymx/fsLoMzqm+FYqzK2uRV90R//oExG
         xcqDVtYmkLMdND5j3Djcv7DJV7FAWxlS9v4UeoXzfZNYxRco4rFOGgalVRZGXhGJmq8f
         ehPw==
X-Gm-Message-State: AOAM532K0y4pvjR4G3n9scrcodNgxuJ8l82DVYrts2dZt9io5+csN3+P
        oDPdufHLg+eVRjZAgwuyqPB3YqP2Ood3EQ==
X-Google-Smtp-Source: ABdhPJxIj8bvw6mRsAIxq+3Eyckd3hhhIrG0YEal1W8nL3TkQzVgxAZspqvE9N3iqWsjH0NIfQ6nKw==
X-Received: by 2002:a17:902:bd88:b0:143:d318:76e6 with SMTP id q8-20020a170902bd8800b00143d31876e6mr10874072pls.66.1637699336513;
        Tue, 23 Nov 2021 12:28:56 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:89f5:ea70:7aea:ec19])
        by smtp.gmail.com with ESMTPSA id np1sm2133439pjb.22.2021.11.23.12.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 12:28:55 -0800 (PST)
Date:   Tue, 23 Nov 2021 12:28:51 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, albertcui@google.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        avarab@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        jrnieder@gmail.com, jacob.keller@gmail.com, raykar.ath@gmail.com,
        stolee@gmail.com
Subject: Re: [PATCH v6 0/5] teach submodules to know they're submodules
Message-ID: <YZ1PA3YBdOfg0/cf@google.com>
References: <20211117005701.371808-1-emilyshaffer@google.com>
 <20211117232846.2596110-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211117232846.2596110-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 17, 2021 at 03:28:46PM -0800, Jonathan Tan wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> > For the original cover letter, see
> > https://lore.kernel.org/git/20210611225428.1208973-1-emilyshaffer%40google.com.
> 
> Also for reference, v4 and v5 (as a reply to v4) can be found here:
> https://lore.kernel.org/git/20211014203416.2802639-1-emilyshaffer@google.com/
> 
> > Since v5:
> > 
> > A couple things. Firstly, a semantics change *back* to the semantics of
> > v3 - we map from gitdir to gitdir, *not* from common dir to common dir,
> > so that theoretically a submodule with multiple worktrees in multiple
> > superproject worktrees will be able to figure out which worktree of the
> > superproject it's in. (Realistically, that's not really possible right
> > now, but I'd like to change that soon.)
> 
> Makes sense. Also, thanks for the tests covering what happens when this
> is run from worktrees.
> 
> > Secondly, a rewording of comments and commit messages to indicate that
> > this isn't a cache of some expensive operation, but rather intended to
> > be the source of truth for all submodules. I also added a fifth commit
> > rewriting `git rev-parse --show-superproject-working-tree` to
> > demonstrate what that means in practice - but from a practical
> > standpoint, I'm a little worried about that fifth patch. More details in
> > the patch 5 description.
> 
> OK - this is not the "this variable being missing is OK" idea that I had
> [1], but we want to be able to depend on it to some extent. (And it is
> not a cache either - we are not planning to perform an operation to
> obtain the superproject gitdir if the cache is missing, but we are just
> going to assume that there is no superproject.)
> 
> To that end, the 5th patch is misleading - it is behaving exactly like a
> cache. I think it's better to drop it.

Yeah, I think you are right.

> 
> What would make sense to me (and seems to be in the spirit of this patch
> set) is to describe this as something that Git commands can rely on to
> determine if the current repo is a submodule, for performance reasons.
> So maybe Git commands/parameters that directly reference the submodule
> concept like "--show-superproject-working-tree" will work hard to find
> the superproject (by searching the filesystem), but those that do not
> (e.g. "git status") can make assumptions.

Oh interesting, I like the idea of that distinction. Thanks for the
suggestion.

I wonder, though, how best to delineate. I'd almost rather say like I
suggested to Ævar
(https://lore.kernel.org/git/YZ1KLNwsxx7IR1%2B5%40google.com), that we
can treat "--show-superproject-working-tree" as a "legacy" option people
are already using, and treat anything added from now on as "if it
doesn't think it is a submodule, you should 'git submodule update' in
the superproject". That relies on us being able to reliably keep the
value of submodule.superprojectGitDir correct, but I think the
gitdir->gitdir linking helps with that (as opposed to earlier
iterations).
> 
> Making this variable a source of truth wouldn't work, I think, because
> the source of truth is whether this repo appears in a .gitmodules file
> (and that hasn't changed).

Interestingly, '--show-superproject-working-tree' doesn't check the
.gitmodules file at all. It checks whether the project found in the
filesystem above it knows about an object named path/to/superproject/
which is a gitlink - that is, it asks the index, not .gitmodules, as far
as I understand it. So if the only existing alternative to
submodule.superprojectGitDir isn't treating .gitmodules as source of
truth, then what does that mean?

> 
> To this end, I'll comment on the changes I'd like to see on the
> individual patches too.
> 
> [1] https://lore.kernel.org/git/20210727174650.2462099-1-jonathantanmy@google.com/
