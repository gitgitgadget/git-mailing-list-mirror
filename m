Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7799FC2D0C3
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 21:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A65D20740
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 21:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfL0VnH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 16:43:07 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53543 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfL0VnG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 16:43:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id m24so9142081wmc.3
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 13:43:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ANylWCn42YTJzU7F2il/1Cte7AluJcLOPT9fuaUci4=;
        b=X0MUSp3pcPwQhWXcKeuiez6TyHAzmpbj/LGzTYMH8zBij2wJRwd783JdAsVPdbOfDN
         jbl8r1tDdWFGjoOEZne5e7uA94ZeKTmLMNAsnY+8wzIOsqicGuFg4dzqmNsvIJpqk6OG
         G1iFccmFTZjgvWCKFJvoXFsklWPMkuRmm4MEwmYLw4dreUDlh6gGmsc3UhprZIByOen5
         HiTCJmUf4/T2Ml6JqRYPFN42c111ziyvv6penapx9D9dvkzuINA/Ft7/6FRV9d07ZVfJ
         5mcZKxhreNHfRLay52KMO6noUpItBZkCoMEBRH9KW+gWEQWMMMDTUgn2gmmCcN0JG24G
         lSjQ==
X-Gm-Message-State: APjAAAXhGGUHWAb0l5Wg8LRVLmFY0Q2tIP3GYKZpxoRfZQN1jPT2pfBX
        E0lEm0za6Ut5f91jbrT8PlTmJ7fFSHtspqbHfrw=
X-Google-Smtp-Source: APXvYqxKxD7U3/TavxyD1SzvpQmvOUphbiMKkWNeFOuKywuh5CwuUQkqrJhvRyQ63QNxz4WhI//OmktldwMYC+mndbI=
X-Received: by 2002:a05:600c:2503:: with SMTP id d3mr20166220wma.84.1577482984900;
 Fri, 27 Dec 2019 13:43:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577454401.git.liu.denton@gmail.com> <4fe247c09df89ebe908f366ee7c2a4ec1c209d86.1577454401.git.liu.denton@gmail.com>
In-Reply-To: <4fe247c09df89ebe908f366ee7c2a4ec1c209d86.1577454401.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 27 Dec 2019 16:42:53 -0500
Message-ID: <CAPig+cQmO2W7kcqWZwrSsC7-vkk_UVcC5NktY+0dddcyaegr6Q@mail.gmail.com>
Subject: Re: [PATCH 05/16] t2018: don't lose return code of git commands
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 27, 2019 at 8:48 AM Denton Liu <liu.denton@gmail.com> wrote:
> We had some git commands wrapped in non-assignment command substitutions
> which would result in their return codes to be lost. Rewrite these
> instances so that their return codes are now checked.

Try writing your commit messages in imperative mood:

    Fix invocations of Git commands so their exit codes are not lost
    within command substitutions...

or something. Same comment about several other commit messages in this series.

More below...

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
> @@ -23,7 +23,8 @@ do_checkout () {
>         # if <sha> is not specified, use HEAD.
> -       exp_sha=${2:-$(git rev-parse --verify HEAD)} &&
> +       head=$(git rev-parse --verify HEAD) &&
> +       exp_sha=${2:-$head} &&

Are you sure this transformation is needed? In my tests, the exit code
of the Git command is not lost.
