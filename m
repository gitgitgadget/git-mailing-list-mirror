Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10EDC7619D
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 01:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70BB621D56
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 01:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M/3JDeTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgBTBmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 20:42:11 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35587 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbgBTBmL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 20:42:11 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so884566plt.2
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 17:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X5htZ525TArT7/+vCb6ntnFCI15zfWH8esbylofn+Is=;
        b=M/3JDeTdTORdNBgVzdiA4d5/Tb9hief20FZRHCjmC8HsKcObP7MOLVhHZhX6gBJDyK
         elv56DVbkyR1MYycByW0U4TWhzQfEP+iawk7+o4QtdCaVSCPfMeE0UptHMITq5lvcyIq
         S4LWJaOg2VDFe5el8IiJPeyTMH/xgLGiqMa5NYwctV/0DWJGch866NeiyzzcxZm+FJGx
         1rMss82EJbWH7nRtxZeVaYbGGTBCeZfa9hdJmNhzLJHP/b2EXXTVIUHkVNjRrzhrhVX2
         8NXXLLmXHKqG9xClP1E92jXjpV+xcDVvmjXLXkv3CA3+VAl3dSvoPGoZhcLpG0Vbo2xM
         GAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X5htZ525TArT7/+vCb6ntnFCI15zfWH8esbylofn+Is=;
        b=e095pKwlYrnm7izil1f87Lf7dqHWaWemK7f7/L72+0j55+AgZC0aIkRboh4BtOsh7h
         zvFvMfJvlEWRJ3v19mQloL3YOcCLVnhd3pju1alZf/W5a9gp2Bcy1aytzxCro+SLGc/C
         M69ILexJBtYPcRVf6n0Wz3d3c+pZzyikEurIS4iATFvCiXsYgqfQw9vapbEFBcq6dZfX
         03/e/b5iGaNXaAhDQKRccpSyQl3Qbq9kx/6CgJqLvju+2Ts7mJ+hCMuCBdvZVMr963FM
         wlkQHtVYIr96LfhJBjk0fygfdqtXSekFVGwdOYXcyOyla+6b4P1+HGMeVwhEl7JLev8v
         egmw==
X-Gm-Message-State: APjAAAVKwPBa7XxadxhGEYq6iSxFaJ8TVj3+CHY53kFKtiDOzS3RSEAE
        S5PTySjmHfbApvFLM4fzfZH5BrZ76mQ=
X-Google-Smtp-Source: APXvYqwQDK7KgZbmECZKGN3Tx/ynSUr7MXuZxWT9hUKfWVDbhQUmdgc1W+40Ha3Xvq2qk9v0GKztfQ==
X-Received: by 2002:a17:90a:c214:: with SMTP id e20mr693974pjt.98.1582162930331;
        Wed, 19 Feb 2020 17:42:10 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id y10sm877382pfq.110.2020.02.19.17.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 17:42:09 -0800 (PST)
Date:   Wed, 19 Feb 2020 17:42:05 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v3 2/2] advice: extract vadvise() from advise()
Message-ID: <20200220014205.GB2447@google.com>
References: <pull.548.v2.git.1581889150.gitgitgadget@gmail.com>
 <pull.548.v3.git.1582144442.gitgitgadget@gmail.com>
 <a2a145c705e2751d4ced9cc71e62d5c560adb6e6.1582144442.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2a145c705e2751d4ced9cc71e62d5c560adb6e6.1582144442.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 19, 2020 at 08:34:01PM +0000, Heba Waly via GitGitGadget wrote:
> From: Heba Waly <heba.waly@gmail.com>
> 
> extract a version of advise() that uses an explict 'va_list' parameter.
> Call it from advise() and advise_if_enabled() for a functionally
> equivalent version.

Hm, I'd put this patch before the advise_if_enabled() one, so that each
commit makes sense by itself (rather than adding a bunch of code last
patch only to remove it in this patch).

> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Heba Waly <heba.waly@gmail.com>
> ---
> -	for (cp = buf.buf; *cp; cp = np) {
> -		np = strchrnul(cp, '\n');
> -		fprintf(stderr,	_("%shint: %.*s%s\n"),
> -			advise_get_color(ADVICE_COLOR_HINT),
> -			(int)(np - cp), cp,
> -			advise_get_color(ADVICE_COLOR_RESET));
> -		if (*np)
> -			np++;
> -	}

I see - this hunk that I commented on in the other review is actually
duplicated from advise(). Hm, I still think it'd be useful to put this
functionality into strbuf, but I guess since it's not new code you're
adding there's not a lot of need to sweat about it.

 - Emily
