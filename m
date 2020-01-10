Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649A2C282DD
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 23:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FED2072E
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 23:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vc3Nn/Kt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgAJXOj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 18:14:39 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32907 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbgAJXOj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jan 2020 18:14:39 -0500
Received: by mail-pl1-f196.google.com with SMTP id ay11so1418125plb.0
        for <git@vger.kernel.org>; Fri, 10 Jan 2020 15:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=akyyWmPBquZ/n5ky3zqck/8RzT+3ZbvP81HPhqdTTbc=;
        b=Vc3Nn/KtBDPldSm/BklWWLR7SwUOe1ujVXXRDMhd4E4tBVtGoVuW30Zj5j7UVTmzY0
         rXb1feGAKaPahimfYT261Xyea2qNATMKFGBJPvEPjBVmX9F81ZFMZA1VpYhOzcwdzwWI
         4m5dxIzdriMmwzZGTWTdZPGOlKCUzyL5QgP1uTb5ohEgABo8osSNB7LfFSrBBMi6XGIV
         aXX8XP4x/+cGcIgB0hRJpv+bvB4/iopwLcFAnsJvLZW9/AT5Kpu24uaSQNKmFBeLItX4
         Z8p0R8+XRVTl+NRLt4hrhq3T+6QA+VCVlb/FZv+4XPHQJy+pYdwBwJsxJ6TBQqeih5xF
         Rz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=akyyWmPBquZ/n5ky3zqck/8RzT+3ZbvP81HPhqdTTbc=;
        b=JV9vdyhuyBSF+1elLg9Itn2JJNeCaj5zvoFPi9nnKbk2Do1K5eUXfbpBqwnMbeD1kU
         YH/WpibqaRs3fbOSnTczUplx5FK2w38gUqqUyoZM6VsNolQNOSuXtcqq1RnNkB1Jehy0
         3C+s20KTgJiCOYApmXBdOohIQmQrBKeJgVuYmC1kR0dAnavZm7Uv4f4JbQUgSvjreSQC
         K1I/KjZU5Kzgp1V9Yw1SQKIFuSzsb1E5v9AKXjm0SkmzlBIGlDf/ZNBSm76hNnz71EEq
         8R0hZZ3uia1f2X+4ekiILBwoZcytyTaTxVx0sKQhAZHspru6hYnpwPTEjTbV/DgDRfAt
         WC9w==
X-Gm-Message-State: APjAAAUikAKXHpX7Mpvd/gM4HLjXeisbtGcSahpVQoLliPxtV9qsu4zv
        vqR6bm3GISaBPuBEOLH5u0I=
X-Google-Smtp-Source: APXvYqwrvYOVme1j2eXeF/v5OgWh088erTJ7FzEzQeNoFq7H5hWhX7Lopp65nqs/deX2wxTG/cL+rg==
X-Received: by 2002:a17:90a:cf11:: with SMTP id h17mr7939914pju.103.1578698078745;
        Fri, 10 Jan 2020 15:14:38 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id u2sm3898765pgc.19.2020.01.10.15.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 15:14:37 -0800 (PST)
Date:   Fri, 10 Jan 2020 15:14:36 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        phillip.wood@dunelm.org.uk, liu.denton@gmail.com,
        gitster@pobox.com, plroskin@gmail.com, alban.gruin@gmail.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 15/15] rebase: change the default backend from "am" to
 "merge"
Message-ID: <20200110231436.GA24315@google.com>
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
 <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
 <044853fd612ee8cf6928bb7c4ebb1eacaa172aa3.1577217299.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <044853fd612ee8cf6928bb7c4ebb1eacaa172aa3.1577217299.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Elijah Newren via GitGitGadget wrote:

> The am-backend drops information and thus limits what we can do:
>
>   * lack of full tree information from the original commits means we
>     cannot do directory rename detection and warn users that they might
>     want to move some of their new files that they placed in old
>     directories to prevent their becoming orphaned.[1]
>   * reduction in context from only having a few lines beyond those
>     changed means that when context lines are non-unique we can apply
>     patches incorrectly.[2]
>   * lack of access to original commits means that conflict marker
>     annotation has less information available.
>
> Also, the merge/interactive backend have far more abilities, appear to
> currently have a slight performance advantage[3] and have room for more
> optimizations than the am backend[4] (and work is underway to take
> advantage of some of those possibilities).
>
> [1] https://lore.kernel.org/git/xmqqh8jeh1id.fsf@gitster-ct.c.googlers.com/
> [2] https://lore.kernel.org/git/CABPp-BGiu2nVMQY_t-rnFR5GQUz_ipyEE8oDocKeO+h+t4Mn4A@mail.gmail.com/
> [3] https://public-inbox.org/git/CABPp-BF=ev03WgODk6TMQmuNoatg2kiEe5DR__gJ0OTVqHSnfQ@mail.gmail.com/
> [4] https://lore.kernel.org/git/CABPp-BGh7yW69QwxQb13K0HM38NKmQif3A6C6UULEKYnkEJ5vA@mail.gmail.com/
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Documentation/git-rebase.txt           |  2 +-
>  builtin/rebase.c                       |  4 ++--
>  t/t5520-pull.sh                        | 10 ++++++----
>  t/t9106-git-svn-commit-diff-clobber.sh |  3 ++-
>  4 files changed, 11 insertions(+), 8 deletions(-)

Thanks for writing this.  We finally rolled this out to our internal
population at $DAYJOB and ran into a couple of issues:

 1. "git rebase --am" does not invoke the post-commit hook, but "git
    rebase --merge" does.  Is this behavior change intended?

    Noticed because jiri[1] installs a post-commit hook that warns
    about commits on detached HEAD, so this change makes rebases more
    noisy in repositories that were set up using jiri.

 2. GIT_REFLOG_ACTION contains "rebase -i" even though the rebase is
    not interactive.

 3. In circumstances I haven't pinned down yet, we get the error
    message "invalid date format: @@2592000 +0000":

	$ git rebase --committer-date-is-author-date --onto branch_K branch_L~1 branch_L
	$ git checkout --theirs file
	$ git add file
	$ git rebase --continue
	fatal: invalid date format: @@2592000 +0000
	error: could not commit staged changes.

    This isn't reproducible without --committer-date-is-author-date.
    More context (the test where it happens) is in [2].

 4. I suspect the exit status in the "you need to resolve conflicts"
    case has changed.  With rebase --am, [3] would automatically
    invoke rebase --abort when conflicts are present, but with rebase
    --merge it does not.

Known?

Thanks,
Jonathan

[1] https://fuchsia.googlesource.com/jiri/+/60436c301224231cb99be41ce937dfc223bee272/project/manifest.go#1347
[2] https://source.chromium.org/chromium/chromium/tools/depot_tools/+/master:tests/git_common_test.py;l=721;drc=6b52dc21e166c46707b4c8eb26c74c70d4f9977e;bpv=1;bpt=0
[3] https://fuchsia.googlesource.com/jiri/+/60436c301224231cb99be41ce937dfc223bee272/project/project.go#1664
