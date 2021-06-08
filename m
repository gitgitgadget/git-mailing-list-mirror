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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09F5C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 17:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8421C6136D
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 17:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbhFHR0S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 13:26:18 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:40721 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbhFHR0R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 13:26:17 -0400
Received: by mail-pg1-f172.google.com with SMTP id j12so17054656pgh.7
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 10:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uoLeKidaSD4g6/DrEw/k1gxcQCxr6aArHk/wMJuNhO4=;
        b=f1lDvI51kp2QEOfCtkbh5h2R2U6BI+JMql+OUgWeR1yIcYjrEdxLjnvzgjAQycdna0
         oYkPyMbgNAaDruE+1k9l6sD45z3WT5838dg25AP36KAQ40SM348PIRRqz9f4S1tbHC93
         wQ6kU9KAGOuKb1L6EnSZEjVJp67wbicL5yP1tZZqhRMuVTFwqaG6H0g0d2UUS0EdHe7r
         Y0tBRNO9AsQ7Qg58nt5volWMsBucw08TuJIrO+gMUOW9Pt1Ag3NX9OKeg0d7DRFEH7T/
         XBl19IuufpcS7qk/mIKbYFtGAhZkcm3MQEqBPZ17mDlU3bwVL/FD081EY5spFmZtgjz8
         b1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uoLeKidaSD4g6/DrEw/k1gxcQCxr6aArHk/wMJuNhO4=;
        b=Ruk0TL/8csIpkSCrOb5H4LT0ArO8RPxUJYpT5+vsPL4RCJ9sbfvdOtUVII+b+B/sWQ
         pDcQHHjq1dE0d1JDLrcEZjnlwsa9VlcWIs4r3rj+AoMhqGGOOYQPDJwLrYNu+Jypbt5n
         TQzoEXwvpPA5139pWc/rPq37ZCHGas90+/A4qdTxrhMZzLz9lkal2RIGErrMu2AmXdQ0
         zSxUVsmzY9I4r7WOIHoXEiHhqEriTUrBeYf0wfoyyNzCURg9w/sc6P0uzvBbQ5F7b3lW
         GERNpYLwxgWtxh2H3N3M5NxUSdILfZZLVzsTy+3u6pHVDdVDX/qsXgQ9A61sNLGUjJ6m
         Il6g==
X-Gm-Message-State: AOAM532ftZqvjDi03Xo/6rPnngj2zdjFmrZ9Cm4/g64zPX3XKDU1Ovl8
        2SKy/b49+7ed4ePUQquUsC0flw==
X-Google-Smtp-Source: ABdhPJyfAo1J83a3lvclasSoPOOw0MfOlglNIrTYJkU1VmcLXTmpAidHWRgEjDTFPIUTSmbv9ZK9mA==
X-Received: by 2002:a05:6a00:1913:b029:2ec:8f20:4ea with SMTP id y19-20020a056a001913b02902ec8f2004eamr981608pfi.3.1623172987566;
        Tue, 08 Jun 2021 10:23:07 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:f819:e238:f61a:a961])
        by smtp.gmail.com with ESMTPSA id o3sm4399869pfd.41.2021.06.08.10.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:23:06 -0700 (PDT)
Date:   Tue, 8 Jun 2021 10:23:00 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] MyFirstContribution: link #git-devel to Libera Chat
Message-ID: <YL+ndHSLowy/qyZV@google.com>
References: <20210608135114.71104-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608135114.71104-1-raykar.ath@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 08, 2021 at 07:21:14PM +0530, Atharva Raykar wrote:
> 
> It's pretty safe to say that most of the regulars on #git-devel are now
> on Libera Chat. This will help new contributors find the right place, if
> they choose to ask questions on `#git-devel`.
> 
> Since there seems to be no way to directly link Libera's web chat to
> `#git-devel` directly,

I just typed "web.libera.chat/#git-devel" and it worked perfectly fine.

> I have put a generic link over the text 'Libera
> Chat'. Users will have to manually type `#git-devel` in the webchat
> interface, but that should be obvious enough to not be worth mentioning.

Generally, this is a bad approach to take for absolute-beginner
documents like this one. Even if it "should" be obvious, why not just
say it? Some skills - like how to examine the compiler errors from your
C compiler and fix your code accordingly - are a necessary prerequisite
to be useful on the Git project; other skills - like how to use IRC -
are not, and we can teach them, especially in a guide like this :)

But anyway it's moot, as direct link does seem to work.

> 
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> ---
> 
> My heuristic for determining "most of the regulars are on Libera Chat" is the
> fact that the last biweekly standup happened there.
> 
>  Documentation/MyFirstContribution.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
> index af0a9da62e..cd9e2069d4 100644
> --- a/Documentation/MyFirstContribution.txt
> +++ b/Documentation/MyFirstContribution.txt
> @@ -47,7 +47,7 @@ Veteran contributors who are especially interested in helping mentor newcomers
>  are present on the list. In order to avoid search indexers, group membership is
>  required to view messages; anyone can join and no approval is required.
>  
> -==== https://webchat.freenode.net/#git-devel[#git-devel] on Freenode
> +==== #git-devel on https://web.libera.chat[Libera Chat]

The prior link was a direct link to the #git-devel channel, so that
newbies don't need to figure out how to join the channel they want from
the main webchat landing page. It looks like Libera also supports this
functionality. So please link to 'https://web.libera.chat/#git-devel'
instead.

> @@ -826,9 +826,9 @@ NOTE: You can typically find someone who can `/allow` you on GitGitGadget by
>  either examining recent pull requests where someone has been granted `/allow`
>  (https://github.com/gitgitgadget/git/pulls?utf8=%E2%9C%93&q=is%3Apr+is%3Aopen+%22%2Fallow%22[Search:
>  is:pr is:open "/allow"]), in which case both the author and the person who
> -granted the `/allow` can now `/allow` you, or by inquiring on the
> -https://webchat.freenode.net/#git-devel[#git-devel] IRC channel on Freenode
> -linking your pull request and asking for someone to `/allow` you.
> +granted the `/allow` can now `/allow` you, or by inquiring on the #git-devel IRC
> +channel on https://web.libera.chat[Libera Chat] linking your pull request and
> +asking for someone to `/allow` you.

Same as above.


Thanks very much for sending the patch. I haven't had time to address it
myself.

 - Emily
