Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71E5C433F5
	for <git@archiver.kernel.org>; Sat,  8 Jan 2022 02:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbiAHC4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 21:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiAHC4D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 21:56:03 -0500
X-Greylist: delayed 574 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 07 Jan 2022 18:56:03 PST
Received: from tilde.club (ipv6two.tilde.club [IPv6:2607:5300:61:c67::196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71572C061574
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 18:56:03 -0800 (PST)
Received: from tilde.club (unknown [185.220.101.171])
        by tilde.club (Postfix) with ESMTPSA id 03F3E222546FE;
        Sat,  8 Jan 2022 02:46:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 tilde.club 03F3E222546FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tilde.club; s=mail;
        t=1641609974; bh=lWLfY8GTKAkJvec327Dgem++e1L1UBLm8njEksvYyzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LQQepT8xhhWDdVhsTtjfNTmDdVcc28bzJ/M9hzrHOytbfWCWvPMrmAh0lX8LGN3zm
         l6NGsZUR3dPNslNzjy3VDa8URDYoajVxjPbwV7a7LHdYtBBoe6lUgKydA3WvvZ6QAA
         GgHn2zJZTRlrwmGV9Po7R6VZ/YEWXsfJ+7qyALiE=
Date:   Sat, 8 Jan 2022 02:45:59 +0000
From:   Gwyneth Morgan <gwymor@tilde.club>
To:     Keith Thompson <Keith.S.Thompson@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug: With diff.noprefix=true, `git format-patch` creates a patch
 that `git am` rejects
Message-ID: <Ydj6aYySwK5qP/uo@tilde.club>
References: <CAAHpriMPdahH2xbrrQbeCJPYpLhr6tuvT6xsG3nACmskKF1v2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAHpriMPdahH2xbrrQbeCJPYpLhr6tuvT6xsG3nACmskKF1v2w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-01-07 16:36:27-0800, Keith Thompson wrote:
> The details: I had this in my $HOME/.gitconfig:
> 
> [diff]
>         noprefix = true
> 
> This caused `git format-patch` *not* to generate the `a/` and `b/`
> prefixes in the patch file.  Setting "noprefix = false" works around
> the problem.
> 
> Here are the first few lines of the resulting patch file:
> ===
> cat 0001-Fix-documented-argv-and-envp-params-for-posix_spawn.patch,000
> >From f4a41189d86bc208a90e754387294b9c4c11cdfc Mon Sep 17 00:00:00 2001
> From: Keith Thompson <Keith.S.Thompson@gmail.com>
> Date: Wed, 5 Jan 2022 13:30:16 -0800
> Subject: [PATCH] Fix documented argv and envp params for posix_spawn
> 
> ---
>  newlib/libc/posix/posix_spawn.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git newlib/libc/posix/posix_spawn.c newlib/libc/posix/posix_spawn.c
> index 005471fde..85bfa6477 100644
> --- newlib/libc/posix/posix_spawn.c
> +++ newlib/libc/posix/posix_spawn.c
> ===
> 
> Feeding this patch to `git am` caused it to strip the `newlib/`
> prefix from the file name.  There doesn't seem to be a way to coax
> `git format-patch` to ignore the current diff.noprefix setting,
> or `git am` to tolerate the missing prefixes.

The -p<num> flag controls how many segments `git am` or `git apply`
removes. The default is -p1. `git am -p0` should apply the patch
correctly.
