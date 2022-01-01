Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99501C433EF
	for <git@archiver.kernel.org>; Sat,  1 Jan 2022 20:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbiAAUI3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Jan 2022 15:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbiAAUI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jan 2022 15:08:29 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9578EC061574
        for <git@vger.kernel.org>; Sat,  1 Jan 2022 12:08:28 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d9so61994037wrb.0
        for <git@vger.kernel.org>; Sat, 01 Jan 2022 12:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NatSMa+Rl4wXNshQlc5k4Z+Dzdv5KKwW7jrVHeThuKA=;
        b=hjD180Id99Go2Tzy1UXaboPCtCd8NMpDXCvqah5VjTfGCYw1rN4cLt52hakwUK6/mt
         3KCUIEBep0+9p68EmkeehQqBbXRfEnRU/PO1IuQHIyG2cuxfOQgyt/X695Yh8VqEUoH5
         dwAuFqYp/Ij0sMQE7lVRpYgJ1yhgoi06YtuFminLlLCP+4b6ubtryPKgjpv/dc8BAye4
         FVlAexaXsYbydSKFBlFzZsVPvn5RtHQwjSCqbMFZLLw4xi+XdC8PVuLypc+aItlQGVWp
         mYhgcVKmSMy1oNRT9P9y2fw+WbIagNWY2piKD8wFlUAt2oaUdg4UXRG/iFyXR/GVL+A8
         qeng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NatSMa+Rl4wXNshQlc5k4Z+Dzdv5KKwW7jrVHeThuKA=;
        b=OW7ZjCwROTODYSc5g9AS80S4Ysk4uKRJhZ+hv3FobjU1t9buY3Dfm+AoB7SFoZD9ee
         spJwIaIKteAkOw9JsOmwidMuerJLqnqdO8yAktm21ISiGAsDWs2E9bHcXcurNNSXtBHe
         EZDVJWTOysn0JRkxpuZyr4F2bhX4O1wIbGmiSzrpWi6VgXihrk6OdMqGUT3Mb8Rk8AoQ
         oDxiQOajN8sAPOIwCHL8c7Eb3KDYRnAvZdqfn9BeI8/7ofOoC6g498nDiwPpPYdw0nDg
         MvExbfAflO/I7mR8LkC7wdL5MAN/bUzfzLDKFMlKU3TbHvuu1BoDSU3pFomFWdEnEOVl
         lAvQ==
X-Gm-Message-State: AOAM530DC4JHDL/QVwKwGshVf6wBc4zfdKoyGmxZdOPA39v1s+ykpv5g
        6CUL6Dr6u6kBYWbb8nvofVc=
X-Google-Smtp-Source: ABdhPJwt50Mh5WK8fJcLTP8Rpv4ZJ+foSh0+fI637f74sddg7oxW4fZ6pIXd+OJ25/rVcW4ovQEUoQ==
X-Received: by 2002:a5d:6803:: with SMTP id w3mr10397726wru.673.1641067706880;
        Sat, 01 Jan 2022 12:08:26 -0800 (PST)
Received: from gmail.com (62-47-8-46.adsl.highway.telekom.at. [62.47.8.46])
        by smtp.gmail.com with ESMTPSA id p18sm1088307wmq.23.2022.01.01.12.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jan 2022 12:08:26 -0800 (PST)
Date:   Sat, 1 Jan 2022 21:08:24 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 4/8] merge-tree: implement real merges
Message-ID: <20220101200824.isvinnb2zmobhfqq@gmail.com>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
 <9fc71f4511b163bec53616d82e8fe5214facf060.1640927044.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fc71f4511b163bec53616d82e8fe5214facf060.1640927044.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 31, 2021 at 05:04:00AM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> This adds the ability to perform real merges rather than just trivial
> merges (meaning handling three way content merges, recursive ancestor
> consolidation, renames, proper directory/file conflict handling, and so
> forth).  However, unlike `git merge`, the working tree and index are
> left alone and no branch is updated.
> 
> The only output is:
>   - the toplevel resulting tree printed on stdout
>   - exit status of 0 (clean) or 1 (conflicts present)
> 
> This output is mean to be used by some higher level script, perhaps in a
> sequence of steps like this:
> 
>    NEWTREE=$(git merge-tree --real $BRANCH1 $BRANCH2)
>    test $? -eq 0 || die "There were conflicts..."
>    NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 $BRANCH2)
>    git update-ref $BRANCH1 $NEWCOMMIT
> 
> Note that higher level scripts may also want to access the
> conflict/warning messages normally output during a merge, or have quick
> access to a list of files with conflicts.  That is not available in this
> preliminary implementation, but subsequent commits will add that
> ability.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Documentation/git-merge-tree.txt | 28 +++++++----
>  builtin/merge-tree.c             | 55 +++++++++++++++++++++-
>  t/t4301-merge-tree-real.sh       | 81 ++++++++++++++++++++++++++++++++
>  3 files changed, 153 insertions(+), 11 deletions(-)
>  create mode 100755 t/t4301-merge-tree-real.sh
> 
> diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
> index 58731c19422..5823938937f 100644
> --- a/Documentation/git-merge-tree.txt
> +++ b/Documentation/git-merge-tree.txt
> @@ -3,26 +3,34 @@ git-merge-tree(1)
>  
>  NAME
>  ----
> -git-merge-tree - Show three-way merge without touching index
> +git-merge-tree - Perform merge without touching index or working tree
>  
>  
>  SYNOPSIS
>  --------
>  [verse]
> +'git merge-tree' --real <branch1> <branch2>
>  'git merge-tree' <base-tree> <branch1> <branch2>

This is really exciting. It could replace the merge-machinery of git-revise
(which is a "fast rebase" tool).
I think for cherry-pick/rebase we need to specify a custom merge base,
would that suit the new form?
