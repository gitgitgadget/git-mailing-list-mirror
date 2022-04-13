Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA040C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 05:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbiDMF2f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 01:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiDMF2b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 01:28:31 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D821402D
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 22:26:10 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id q3so1032627plg.3
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 22:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rinP4XoY5Dl2jsDW23WIcV9qAhIJLtB1YqcZlOs4vu8=;
        b=oaLCtRZKlsB0bcWam1khaApKeXqoyhlglY4agaTocVKYSu56mK6KwGuixecb3WJlS2
         V+VfvWbGVZWFfLFpZsxRfVG1eyGioYDZX5s/gPBtf3/EhP2icz85Ua8j6JabFej3uiqq
         HHY8c8t/TIeqcebKQqZn3K5QX8z5Hnd0XcCv5SuGRgK7L3hXyZK+sq69IUlbdy4x7GVP
         AxdYtvqouxlHweuP74lv2QY8GuC8lPPGup7lX1uG/CkrwbqdH9kyYB8CTmiPpE9G8sls
         qVUMZ9J0mJWzRcqMd3Ph9BBf8g3E4yKQH/eRKT5Lzl4h6dV8BDVWE1SU1mi08AMdt33Z
         6WcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rinP4XoY5Dl2jsDW23WIcV9qAhIJLtB1YqcZlOs4vu8=;
        b=CIyEodBhZUIvFttXxIvsYnGg8p8RtX79b8oj7ccosaP9ylszl3YYYqR2kxhu7agr4l
         zFrL6ojGllM+MDQgGTy/NSIFGR8U8YZmR3+xDUwRXhlTiKcXQuKsno0/2eB9qv5so307
         tecyyNAPNX0ZuzSNjvhNpz3todiRh8CSmK6065ac0yrHtgtPBq+n6i7xW9wJ8Rh2ryiT
         IVj5bV8y8p4O0FtBEz5aiXW+xn/EmK/0uSjORWUp3M2fS3TAR2ulqXQwdAM1BbF+mcFP
         rQ7ZjgTBFYEMN8WRzf45UgXL6/Ed8OiFkPP71tM1FvvslbUtXvO5vJJ5HBsdN9a445pB
         xBzw==
X-Gm-Message-State: AOAM530+LH+ugsxEMO662ICGMWP7BheKrOUB+HxgdWS6wqxPbp1pYu7d
        cBVGfU0PisKyuUvg2SW8ZGs=
X-Google-Smtp-Source: ABdhPJy8CzHmAhERU+gXLRs+CQP+iDAWPQXMDms39tjn5ihR6L0Iyh1QREplx+wswGoV8Yb8Hxcd2Q==
X-Received: by 2002:a17:902:c451:b0:158:7729:f240 with SMTP id m17-20020a170902c45100b001587729f240mr10169689plm.17.1649827570297;
        Tue, 12 Apr 2022 22:26:10 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:1f54:1578:a9b9:677d])
        by smtp.gmail.com with ESMTPSA id d14-20020a656b8e000000b0039cc54c9e89sm4177925pgw.12.2022.04.12.22.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 22:26:09 -0700 (PDT)
Date:   Tue, 12 Apr 2022 22:26:07 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Too-loose checks for applying safe.directory rules?
Message-ID: <YlZe766xu9mHWNdy@google.com>
References: <YlZJGbcNzSp5yNN1@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlZJGbcNzSp5yNN1@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+cc: git@vger, git-security -> bcc)
Hi,

Taylor Blau wrote:

> Hi all,
>
> I was skimming the Hacker News comments on my blog post covering the
> latest pair of CVEs, and this[1] comment stuck out to me.
>
> Looking at 8959555cee (setup_git_directory(): add an owner check for the
> top-level directory, 2022-03-02), I wonder why the `safe_directory_cb()`
> callback doesn't bother to check that `key` is `safe.directory`.
>
> Indeed, our checks seem too loose here. Initializing a repository as
> root:
>
>     $ su
>     # git init repo
>
> Then trying to run "git status" inside of that repo as my normal user
> gives the expected error:
>
>     $ git status
>     fatal: unsafe repository ('/home/repo' is owned by someone else)
>     To add an exception for this directory, call:
>
>       git config --global --add safe.directory /home/repo
>
> But doing the following:
>
>     $ git config --global --add foo.bar /home/repo
>
> tricks Git into thinking that _any_ value which looks like a path in the
> "early config" scope can be interpreted as if the key were
> safe.directory, even when it is not:
>
>     $ git status
>     On branch master
>
>     No commits yet
>
>     nothing to commit (create/copy files and use "git add" to track)
>
> The author of [1] sent a PR to the git/git repo on GitHub [2], so I
> don't think there's any value in doing another coordinated release here.

Thanks, Taylor.  I'm taking the liberty of moving to the main Git list.

> We should certainly fix this before 2.36 is released, but should
> probably apply those patches down to the suite of minor versions
> released today, too.
>
> It's entirely possible I'm holding it wrong and/or missing something
> here, and I'd be happy to be wrong here.
>
> Thanks,
> Taylor
>
> [1]: https://news.ycombinator.com/item?id=31010604
> [2]: https://github.com/git/git/pull/1235

Thanks,
Jonathan
