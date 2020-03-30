Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24539C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 18:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC1D20780
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 18:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a+CyXxij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgC3SHs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:07:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45421 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbgC3SHs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 14:07:48 -0400
Received: by mail-pl1-f196.google.com with SMTP id t4so1083632plq.12
        for <git@vger.kernel.org>; Mon, 30 Mar 2020 11:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W3JfbMmweGKYZZa6U+ObE2BTM12+S35moeo/2Rsj36c=;
        b=a+CyXxijly9jPzFxNSFj+7AbcVl96EFl+A3xcC1Jlf5kdvl84IkCNilp7fONgW4uqu
         zdkJA4juLHcKVrYUhF4BE+uw6JW+YcyQMZ/AUPvrFjJ5UBsms17PKkrEZJ46rszU2EId
         3G6dQixfxzjKstuUtdtP+lMvCQwgPTVcH5sfDwTxi9U0j4rNYm0n0+2wqgzsZx2uZBKZ
         1bPZmYxHAC/K6ad0960+6q+MQHtb1W9oOoFpTNL8bhgRnXah+ApviwWEwFCBJpvaIMlq
         4QqnDuL9Bk2FiqyoNPPED/Eny9AliCaspDpFRNwp1mzpC8tfyiDbCTxwF7V8ePI/zuwL
         kL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W3JfbMmweGKYZZa6U+ObE2BTM12+S35moeo/2Rsj36c=;
        b=aSbwQ9uR1M7gGE5kvzeZagZCbC7aDRubumIWhUWKFccfy33QX4jUDdguAGZ95+llJj
         FG/9UL7rpgjmb7nXsHq3bRvKJ9U2uhdC/vERCA7GjoU1iBcshW7T1O53DOCLfWy61I+n
         /wcjfM4ZiDGvMV6Nredb25zdNSD0LGoMpMnO2/KfVzvt0IIZldOmX2j+pYfYml09zaD3
         X6VRdjPR3nYp4ti45J6xu7FMe6e4TQHQdiFKpwCt3V77C6wvEzquXo73ssUSNR/FcHKN
         3z/tkjfFkUQRa+ryVV3UZL2EJiMyi7/rN3tMUn34WKoT4wBPJINCxgUR66Y2rno/Fsvf
         IO0A==
X-Gm-Message-State: AGi0PuYffp0zcubpJ+ojkPdwnXbSCFAqhQHrudiZ0jibWa2rBX4qPYzy
        R7BMES/vynIRvxYUeKhFSJlFUQ==
X-Google-Smtp-Source: APiQypJOhT7N7/TTd+NEbxk39GrzUkgz9KVRtCLt6N8Q06yibSJxY6hxKTThaVhgk/9z1FSK4yPiIw==
X-Received: by 2002:a17:90b:3556:: with SMTP id lt22mr639357pjb.138.1585591667193;
        Mon, 30 Mar 2020 11:07:47 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id b9sm10123872pgi.75.2020.03.30.11.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 11:07:46 -0700 (PDT)
Date:   Mon, 30 Mar 2020 11:07:42 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] MyFirstObjectWalk: remove unnecessary conditional
 statement
Message-ID: <20200330180742.GB37946@google.com>
References: <pull.589.git.1585408753519.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.589.git.1585408753519.gitgitgadget@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 28, 2020 at 03:19:13PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> In the given example, `commit` cannot be `NULL` (because this is the
> loop condition: if it was `NULL`, the loop body would not be entered at
> all). It took this developer a moment or two to see that this is
> therefore dead code.

Nice catch. Thanks.

> 
> Let's remove it, to avoid puzzling future readers.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>

> ---
>     MyFirstObjectWalk: remove unnecessary conditional statement
>     
>     Our introductory documentation made me scratch my head because our
>     example contains dead code. I'd like to remove it lest we confuse future
>     contributors.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-589%2Fdscho%2Fgit-walken-head-scratcher-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-589/dscho/git-walken-head-scratcher-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/589
> 
>  Documentation/MyFirstObjectWalk.txt | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
> index aa828dfdc44..c3f2d1a831e 100644
> --- a/Documentation/MyFirstObjectWalk.txt
> +++ b/Documentation/MyFirstObjectWalk.txt
> @@ -357,9 +357,6 @@ static void walken_commit_walk(struct rev_info *rev)
>  	...
>  
>  	while ((commit = get_revision(rev))) {
> -		if (!commit)
> -			continue;
> -
>  		strbuf_reset(&prettybuf);
>  		pp_commit_easy(CMIT_FMT_ONELINE, commit, &prettybuf);
>  		puts(prettybuf.buf);
> 
> base-commit: 3bab5d56259722843359702bc27111475437ad2a
> -- 
> gitgitgadget
