Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C59BC4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 22:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25ABD23D20
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 22:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388726AbgLIWlp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 17:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388674AbgLIWld (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 17:41:33 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0277EC0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 14:40:52 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id o11so3060076ote.4
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 14:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XkiWGEBOWBHozJGUmoT10bQd579Mztj0iynS4HJMtz8=;
        b=PMobxqgVpcN2U6uzHIosJJqNpRulRYfFTpAdm4wxUTDE2wriXCcHDLvbh7kdh4J6EB
         PxoPimmaQlRy5vevk5XjhalPm7xx3IynHUDGKbYPdm7MNqI+vKjS69nX9BPEpxpmtg3O
         MEYtBbU6+Ix9/aDMvFmgVLDqBQDqbIxpdmJzEqXlBhSSzDcpwPcUOju4bM3PUOFjHypM
         LSb46kOCPm/F0ptmPo9fa4iN3wUcA/aQdxld7OkY5x4Hob0xOVwjk4+0Q4bEsuV38cYZ
         AoyXa8E1yc/BMnoF5olRJEH7zlQ9Ue32Qb6F2kB3qZ+GguK7F7ppVpor4XikM2vhdwLJ
         A8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XkiWGEBOWBHozJGUmoT10bQd579Mztj0iynS4HJMtz8=;
        b=UkXYdqY7m0NJqeoUxm+lIVa758dzRlUYIayjxPWztXpzzk4bloDI0P64XdiLk4EzeD
         6l0mkiMuXmMVRuXqyQDCQ0sg1/88CAarXIht8NKL57nLxblXPY6O+R94iloWJVJFugSf
         zmN7mxct4KLUVcLHjxS9Y1e+iku605F18ANo0Lfr/8iZbz9Dw/DY1c7uRm35VjPpUnT6
         WCT1uSXes8/LiYnaaYAQXKOQS0NnGG/AiJpETKMPkUgr0OX7kZVFPymvNYPrZQNIRdOJ
         N/tQJe9xAZe5eifu5H++5pVa6+wcARA0pyg63OKgVpbU0TfGCzK3kJAiXv+mYaxOAcFj
         +pjw==
X-Gm-Message-State: AOAM531pzbacf5A6fxDBSGBpR6MMfTpIYcUC28n8xEL15+JWdr6+fvQV
        wTy3Po+jrbH+1qU9WnpmsoLz+A==
X-Google-Smtp-Source: ABdhPJzRoG/MZsZXCH3ZHI+9dZsR5gf5H2Bzva6JliF8NZj5Z82AnOuOilbaw68qtWwtWN5VgzpjTg==
X-Received: by 2002:a9d:7411:: with SMTP id n17mr3680920otk.262.1607553652323;
        Wed, 09 Dec 2020 14:40:52 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id y18sm616919ooj.20.2020.12.09.14.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 14:40:51 -0800 (PST)
Date:   Wed, 9 Dec 2020 17:40:49 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 6/7] diffcore-rename: simplify and accelerate
 register_rename_src()
Message-ID: <X9FScb3pzY0EBLvS@nand.local>
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
 <306a48820dd3c338d2b9e2288e5a3e1c7c89f36e.1607223276.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <306a48820dd3c338d2b9e2288e5a3e1c7c89f36e.1607223276.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 06, 2020 at 02:54:35AM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
>
> reigster_rename_src() took pains to create an array in rename_src which
> was sorted by pathname of the contained diff_filepair.  However, the
> fact that this array was sorted was not needed anywhere, and thus
> represented wasted time.  Simply append to the end of the array, which
> in a usecase of note saved 45% of diffcore_rename() setup time for me.
>
> Technically, there is one difference in the end result for the code.  IF

s/IF/If ?

> the caller of diffcore-rename provides a set of pairs with a duplicate
> filename in the sources (an erroneous input condition), the old code
> would simply ignore the duplicate (without warning or error).  The new
> code will simply swallow it and thus allow multiple pairings for the
> "same" source file.  Checking for this error condition is expensive
> (basically undoing the optimization) and the only existing callers
> already avoid passing such an invalid input.  If someone really wants to
> add some error checking here on this input condition, I believe they
> should add a separate function which can be called before
> diffcore_rename(), and then other callers that don't need additional
> checks because of their design (such as merge-ort) can avoid the extra
> overhead.

It seems like this is currently impossible to trigger, making any extra
(expensive) checking of it worthless, no?

> Also, note that I dropped the return type on the function since it was
> unconditionally discarded anyway.
>
> This patch is being submitted in a different order than its original
> development, but in a large rebase of many commits with lots of renames
> and with several optimizations to inexact rename detection,
> diffcore_rename() setup time was a sizeable chunk of overall runtime.
> This patch dropped execution time of rebasing 35 commits with lots of
> renames by 2% overall.

Neat!

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  diffcore-rename.c | 30 +++---------------------------
>  1 file changed, 3 insertions(+), 27 deletions(-)
>
> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index 3d637ba4645..816d2fbac44 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -76,36 +76,12 @@ static struct diff_rename_src {
> [...]

This looks obviously correct.

Thanks,
Taylor
