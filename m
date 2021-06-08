Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-28.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5955C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 20:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1FE061185
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 20:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhFHUv5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 16:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhFHUv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 16:51:57 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6DBC061574
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 13:49:50 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id e7so11354582plj.7
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 13:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XoLBjImqFMPw26EAbBUVIMH/cJInEMMEIVvHOMnOESs=;
        b=WkE7bmVPzLy5mq0RMxKexzac5IhOp4QgjD26jD7nSHS4moU/X8ekQdjlzIpeT+XeuG
         zwhWYpn4OVdV8MedXXE+94c2KcF6UFR7RzqCqcxv76Eh9SXi+DVwLyj+tXQajhTvz56G
         mk7nEkRJ4HpENxSkY4msvnBKXukzgLRtFYTlVWjnIDan6Y7El0UmhtyJ9UOkGOii4Hyi
         FwquzO3vnn+Uqa0z7zDvx+DVRiOlnRkboKH/GFoLJZXaA7LOID2i4Dfch2DOiKPFwfdu
         xEn1X+7TxT2e5tNk6hZHn/BIbF2boJ6svVnMN3peiJ+qo+ZnipHjU0XXCxjEtVAwgVzC
         6q0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XoLBjImqFMPw26EAbBUVIMH/cJInEMMEIVvHOMnOESs=;
        b=dYT1j+Vp45Gi9ueHZHQbTkhXG+mDM9Ijn5jrj/pQvRihQwevwx+O4Yh3k6Z04C2j17
         E075sAGGusoDZpZdPUD/3DUgwYSZYgzw0ykCG1HFKJw6Wqyj1n+jUlOtymKMHXrfz/i2
         hjb4ryP/gYjS7pzr2wSDstekGoe+ZOwySFkSO/iVbiIUlJj/4P4jHxUkChpMNcwzQn6c
         NKMHcUGGE1p/+nRVLXVpWfRvmPQiLHziwfTRICC3k19l0SADt8tJ9GYwP1UOR9ackkGB
         6FAjSZgVBhD5m/uzcTUdKsFYdghASlecfYni77iWkRuTcqcQqJnDQ6DMnjprdTdnx4iq
         r5HQ==
X-Gm-Message-State: AOAM5334VlnIQiLcBB1oB0amT89+k5YIY9TyPH45pCPtFAo7N7X0qoNN
        ELAaZ2aiZLJM0dxjpCcabDAx9ZiOiX14Xw==
X-Google-Smtp-Source: ABdhPJx/LWI88qevXTJtc9664Zowxyuzsqv2yGwDqOcmQdzgLuImVb5RekGsu82iSxXMaITNyddb9g==
X-Received: by 2002:a17:90a:be0b:: with SMTP id a11mr27336697pjs.197.1623185389687;
        Tue, 08 Jun 2021 13:49:49 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:f819:e238:f61a:a961])
        by smtp.gmail.com with ESMTPSA id 76sm11489676pfy.82.2021.06.08.13.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 13:49:48 -0700 (PDT)
Date:   Tue, 8 Jun 2021 13:49:44 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] MyFirstContribution: link #git-devel to Libera Chat
Message-ID: <YL/X6KBRZbPFz09t@google.com>
References: <20210608180624.72135-1-raykar.ath@gmail.com>
 <20210608190612.72807-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608190612.72807-1-raykar.ath@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 09, 2021 at 12:36:12AM +0530, Atharva Raykar wrote:
> 
> Many of the regulars on #git-devel are now on Libera Chat, to the extent
> that the community page now lists it as the IRC Channel[1]. This will
> help new contributors find the right place, if they choose to ask
> questions on `#git-devel`.
> 
> Relevant discussion on the IRC transition:
> https://lore.kernel.org/git/CAJoAoZ=e62sceNpcR5L5zjsj177uczTnXjcAg+BbOoOkeH8vXQ@mail.gmail.com/
> 
> [1] https://git-scm.com/community
> 
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Reviewed-by: Emily Shaffer <emilyshaffer@google.com>


Thanks Atharva! :)

 - Emily
> ---
> 
> I'm sending it again as my v2 had one line crossed 80 lines in my edit,
> which broke the local convention.
> 
>  Documentation/MyFirstContribution.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
> index af0a9da62e..015cf24631 100644
> --- a/Documentation/MyFirstContribution.txt
> +++ b/Documentation/MyFirstContribution.txt
> @@ -47,7 +47,7 @@ Veteran contributors who are especially interested in helping mentor newcomers
>  are present on the list. In order to avoid search indexers, group membership is
>  required to view messages; anyone can join and no approval is required.
>  
> -==== https://webchat.freenode.net/#git-devel[#git-devel] on Freenode
> +==== https://web.libera.chat/#git-devel[#git-devel] on Libera Chat
>  
>  This IRC channel is for conversations between Git contributors. If someone is
>  currently online and knows the answer to your question, you can receive help
> @@ -827,7 +827,7 @@ either examining recent pull requests where someone has been granted `/allow`
>  (https://github.com/gitgitgadget/git/pulls?utf8=%E2%9C%93&q=is%3Apr+is%3Aopen+%22%2Fallow%22[Search:
>  is:pr is:open "/allow"]), in which case both the author and the person who
>  granted the `/allow` can now `/allow` you, or by inquiring on the
> -https://webchat.freenode.net/#git-devel[#git-devel] IRC channel on Freenode
> +https://web.libera.chat/#git-devel[#git-devel] IRC channel on Libera Chat
>  linking your pull request and asking for someone to `/allow` you.
>  
>  If the CI fails, you can update your changes with `git rebase -i` and push your
> -- 
> 2.31.1
> 
