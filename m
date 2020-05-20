Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E15EC433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 16:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 758DB2065F
	for <git@archiver.kernel.org>; Wed, 20 May 2020 16:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDG9+mfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgETQiy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 12:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgETQiy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 12:38:54 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F096AC061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 09:38:53 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k7so1546873pjs.5
        for <git@vger.kernel.org>; Wed, 20 May 2020 09:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=dbmyRaX0B3lETX0AuaZ50PFMd4qRE35Pjb62ZYcNrZc=;
        b=GDG9+mfpcZCd5NBp64DAenjucsRu3KY90gQp8WM+0uWmDO7ow41MCiPjh5czNwPfVW
         lwV1ibzdhMVdkmqNkMEXwMf4MtB6VoFjYUse7cUIxzq6p1tyfNxLcS1JRLKqFUGGd1lA
         cIWhVLdlHgPL8DyFCA8zc9LQSrfXDnUXZJXnYkPMoYS/4jKTOlbU/SmVZx/sgeXBn644
         rgJbk+dCD/Ao9wn9WIjEci2h8TMOky1yisqA6wiaL8aMlH0W8qCgnLzPisI6+d98ZxDu
         AwfY7WlUtWjRRRbH3Cd5QLMwCmlYno7RsMzRvBVPCWRWLj661WXsHg5HHUyBLm+roG6s
         hEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=dbmyRaX0B3lETX0AuaZ50PFMd4qRE35Pjb62ZYcNrZc=;
        b=Obbf5icKENsSlEWH/YaDHjH+TqnGOuCV50toSyaA9RrPfvtu38L+5ucP7I9F+B45Bs
         cx7oLfPIkVf4b2YbGTRAK4pZton8Rxqz9BZi+Cpul6Km1oWyVx8Ir/JdgHjjrcssVAo+
         zfx16gWXhY1foUv4/rtXYXYhM9E5XZ7hVC9/+ucj0DqTYPFvct8ljES4MtE3Z36XOSqw
         F9xxvT8k+L8VWmKfgfyt0XKnNLtiTCZcebB4USWPU+uOsM2LhbezuOdzlJPx6kYjQkHI
         4MvfOsQ/RjVxorIAnZPC+8mgq2A4cwCEeOa1/PHM8slpzf990WHmoOxxmwVG6d3xLtzb
         1vDA==
X-Gm-Message-State: AOAM531iwADg4a5wgoMwFJkoCMHC3y/R9LAFErypbeC2AimrjcnPqNeU
        +5Yt8MnPQQZJWFKTVeO5unn2l4JvR/8=
X-Google-Smtp-Source: ABdhPJxiKERqS/ZWgHks4Z97B7mJtpTQXuBemh+xI6wpDMSCDfntVTtNnCQAVCAL9owD3PfaSc9WUQ==
X-Received: by 2002:a17:90b:1288:: with SMTP id fw8mr6304373pjb.160.1589992732938;
        Wed, 20 May 2020 09:38:52 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:316:d87b:8116:b1b3:f6a2:1f84])
        by smtp.gmail.com with ESMTPSA id m7sm2788660pfk.36.2020.05.20.09.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 09:38:51 -0700 (PDT)
Date:   Wed, 20 May 2020 22:07:22 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jnareb@gmail.com
Subject: [GSoC] Blog post on reachability queries
Message-ID: <20200520163653.GA76552@Abhishek-Arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings everyone!

I am working on implementing Generation Number v2. I have written an
article about reachability queries, which I feel is necessary background
for understanding the project.

Here's the summary of article:
> Reachability refers to the ability to get from one vertex to another
> within a graph.
>
> Reachability queries are an interesting problem, improving performance
> for many graph operations. Better and more sophisticated solutions are
> being created as the size of working graphs keeps increasing.
>
> Reachability for the undirected graph can be found in linear
> preprocessing and constant query time with disjoint set unions. The
> answer isn't as evident for a directed graph because of differing
> performance on positive and negative queries, nature and size of graph
> and other factors. Topological Levels, Post Order DFS Intervals and
> Contraction Hierachies are some of the building blocks for such
> algorithms.

In a later article, I will talk about the specifics of generation number
for Git. In particular, how Git uses reachability queries, the need for
Generation Number v2 i.e., _Correted Commit Date With Strictly Monotonic
Offset_ and other interesting tidbits I come across.

You can find the article here:

https://abhishekkumar2718.github.io/programming/2020/05/20/reachability-queries.html

I appreciate any suggestions or feedback.

Thanks
Abhishek
