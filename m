Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8B9C433E0
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 08:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B447D22A85
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 08:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbhAKH7s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 02:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbhAKH7s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 02:59:48 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6EFC061786
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 23:59:07 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id n16so10355410wmc.0
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 23:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mmo13H6ZHpxFDD9joBx4FYgAG9BhCvvy1VMBFoCxaZY=;
        b=BDD5CWeEpezO1d8lPfqont0pvPycB3FiYdR0VSGT4pjs35YN9EUfP4ert1gjYu1B9S
         LwvHfiYp0JGjLIcbccrQLlpKIrbwjFzK7ajVOT2Ncx03JBO8LO7nHPTnDNkv5inTE73c
         r1m3iky0651tbrIpvJRc9PYNSAAfB/taqBTS6kIEovn2zZNsdTNgtvcSVZ1XtOSbWdfu
         Zemr5LdCOmvS8ib9VqAhzs6DXizBF9mHMBVyouhQS1YZEGC7Ess+Dz3bqPYUl3yWHOJL
         7brVA4gZ4JS/MOa+Z10Mjoku+Q3+Kf8EDGludWwoM4BhWa1ezacY698PXy9nyBVerBZM
         Cq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mmo13H6ZHpxFDD9joBx4FYgAG9BhCvvy1VMBFoCxaZY=;
        b=QMj7iAxU0kfMCUva7T6VjnAft1qiDXBsFB4Q+WKnAPmr+ODHhUYsjcvkHEZSe0nAJ6
         SVBrxOcP5ZSsDFE/0F79tMVrBj5ndaUhuiItkHJBMPdQ/iRT7ev5i78aKtBNyW6eYuvA
         RPlnfBiarEv5mxjKLx5c3+9X8F0yIkiYO6y9TbcxJMRWw+bbkZ+1ffqN79yDB+InXP3k
         lj+u7c/Zj0XW3XhtO1LgKGfjrehMLQ+JKPziFeSNHfmFmclkzYHO/jxvkt+1mFNDZvrW
         6/y/C1FHNybrnGJcLas4Ai67ChbDydhHZkTkwsLIquJ/rb9auoh6bi2xNEyVkoD3FGXj
         IQ5Q==
X-Gm-Message-State: AOAM53247LsE5vStx+xQQ9gRf6xZg5PdDtI0XdcM5FKzxwf46zLboxHn
        ekHuKeOWliDgn0M4eawqUIlWSpmY6u67
X-Google-Smtp-Source: ABdhPJzbqvBI8ZExMogFaL7XA+OanaCWKnxXmlz8t2NW0fAsSIubMR2u/JeAdVltG2tszZKqCYdVIg==
X-Received: by 2002:a1c:8085:: with SMTP id b127mr13157771wmd.16.1610351946617;
        Sun, 10 Jan 2021 23:59:06 -0800 (PST)
Received: from sync (90.ip-167-114-239.eu. [167.114.239.90])
        by smtp.gmail.com with ESMTPSA id n11sm26142410wra.9.2021.01.10.23.59.05
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Jan 2021 23:59:06 -0800 (PST)
Date:   Mon, 11 Jan 2021 07:59:05 +0000
From:   Arnaud Morin <arnaud.morin@gmail.com>
To:     git@vger.kernel.org
Subject: Re: rev-list with multiple commits sharing same patch-id
Message-ID: <20210111075905.GA32482@sync>
References: <20210109162440.GM31701@sync>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109162440.GM31701@sync>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, forgot to mention 2 things:
- I am using latest stable git version (2.30)
- I my previous mail, my git diff was against branch B:
$ git diff B
(empty)

Thanks

-- 
Arnaud Morin

On 09.01.21 - 16:24, Arnaud Morin wrote:
> Hey all,
> 
> I am struggling with a rev-list command, hope someone can give me a
> clue on what is going on.
> 
> I have 2 branches:
> $ git branch
>   B
> * master
> 
> Currently on master, there is not diff against B:
> $ git diff
> (empty)
> 
> The commits in B are cherry-picked from master.
> Here is the graph:
> $ git log --graph --oneline --all
> * ae2e3c4 (origin/B, B) remove line2 and add line4 (bis)
> * a7a0339 remove line4
> * caa4aad restore line2
> * d7dc596 remove line2 add line4
> * 44bcfd4 add line3
> * e372641 b
> | * dbf86d8 (HEAD -> master, origin/master) remove line2 and add line4 (bis)
> | * 4017282 remove line4
> | * 0f2a449 restore line2
> | * 8969d3f remove line2 add line4
> | * e73b420 add line3
> | * fe5a75a b
> |/  
> * 6192505 a
> * b4089e1 init
> 
> 
> However, when using git rev-list to perform a symmetric difference, git
> is giving me a commit ID:
> $ git rev-list --left-right --cherry-pick B...master
> >dbf86d8aafc897a25a3093139b4237a62395041e
> 
> Note that this commit is not empty
> $ git show dbf86d8aafc897a25a3093139b4237a62395041e --stat
> commit dbf86d8aafc897a25a3093139b4237a62395041e (origin/master, master)
> Author: Arnaud Morin <hidden@mail>
> Date:   Sat Jan 9 10:30:10 2021 +0100
> 
>     remove line2 and add line4 (bis)
> 
>  a | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> 
> So, from git rev-list perspective, there is a diff.
> 
> After digging a little bit, the thing is that this commit is having the
> following patch-id:
> $ git show dbf86d8aafc897a25a3093139b4237a62395041e | git patch-id
> 20f4ace68e80a751b07d78a27c94e83d6c5314bc dbf86d8aafc897a25a3093139b4237a62395041e
> 
> Which is also already existing in an other commit:
> $ for c in $(git rev-list HEAD) ; do git show $c |git patch-id |grep 20f4ace68e80a751b07d78a27c94e83d6c5314bc; done
> 20f4ace68e80a751b07d78a27c94e83d6c5314bc dbf86d8aafc897a25a3093139b4237a62395041e
> 20f4ace68e80a751b07d78a27c94e83d6c5314bc 8969d3fa9159730fd3b23199873bfb26e3d20027
> 
> So, is it normal that rev-list is not able to figure out that a commit
> is existing in both branch when 2 commits share the same patch-id?
> 
> Is there any way to prevent rev-list from showing this commit?
> 
> Thanks for your help.
> 
> 
> PS. I have uploaded my test repo here:
> https://gitlab.com/arnaudmorin/git-rev-list
> 
> 
> -- 
> Arnaud Morin
> 
