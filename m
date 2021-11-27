Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B309BC433EF
	for <git@archiver.kernel.org>; Sat, 27 Nov 2021 10:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350782AbhK0KoY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Nov 2021 05:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbhK0KmX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Nov 2021 05:42:23 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1088C06173E
        for <git@vger.kernel.org>; Sat, 27 Nov 2021 02:39:08 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id w1so49334859edc.6
        for <git@vger.kernel.org>; Sat, 27 Nov 2021 02:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=99FFA0UIA8QQiIG+w6JxmnLRyIpTJWxjVhFlqRXVb4c=;
        b=FijXsP/VRwjCPw8BjsY1Dk1I86I9QR4bPFu/UvXw6ugz9BVAzm5CCfwGkwwZEZgL7S
         wWYcWhrCacQMeVXJTLrMAYPsDkMbRHgge5j7Wj58uSumgSsWIk2AYqo9Nw2i6quM6Ifd
         sF9gVxeBIZguKC8v7qTD07lJ+aSe2Rz3FvDtkh9z0v74ukp1l8vWwOQPUpbiaESTkfSM
         Pavu9sVduZImNX50kbQyeGLp72avy4ac2fEZ7XP8YM7bbfqxf1gJciFtN65yHweJpbuq
         Wza77/VEPTsxBG+xioVaF3BkS+GBY6sD+i+bdsuaOkNAD7G+dj39TRWuylsvKENHpPGT
         fc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=99FFA0UIA8QQiIG+w6JxmnLRyIpTJWxjVhFlqRXVb4c=;
        b=SCvnmNJglUp8+1wCd7QmhSTDlITEDt1Nv+nz7ns2/xwtHVLDvoX6y/4IQCgxHpTK1U
         8/bSWMvHAlqxxuSUfFf4UQbmb+ieRKbJfCJ+6OlhiOZaeOQEV5uLfenllsrkcvk3DThl
         qVN8To7ZJL2Lo0wzEIkb38lLb1l3ofMj/HCLSWAAy/2mqomZMMr3n3Jo19GN31WiLeUy
         YM31J0fXAz7Ub4rvnS77xsrEs0SiA0yPwN9eUDfWxrHvBoOrLCfgmJHwZTCJIYt247xb
         Zdhz+OjizAV8u0racZIdwbRnAlv/UqbEzAi0DMU1bVEw8rmxvkrbLb1gwJCqirj4Yjn7
         DJJg==
X-Gm-Message-State: AOAM531ulRfU23Ale6oR7B6z38q5Fx//DvS2u1ANDtsujZcGm/OLl03G
        r+tpbLMnGCn+vOGCGP10nIrludPSBhk=
X-Google-Smtp-Source: ABdhPJxykdIyQZibiTLmOqoH0b7OIqLiPwo4nk4pBKe83Q8UZ0GgF9bzUDZvuBMDLEO+NFMS5zOL2g==
X-Received: by 2002:a05:6402:42c6:: with SMTP id i6mr56964078edc.223.1638009547069;
        Sat, 27 Nov 2021 02:39:07 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id nb4sm4447467ejc.21.2021.11.27.02.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 02:39:06 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mqv6n-000UyZ-Pt;
        Sat, 27 Nov 2021 11:39:05 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 02/11] setup: introduce startup_info->original_cwd
Date:   Sat, 27 Nov 2021 11:35:08 +0100
References: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
 <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
 <200ddece05d3d0599b16897ff9533cdfb3324b0c.1637966463.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <200ddece05d3d0599b16897ff9533cdfb3324b0c.1637966463.git.gitgitgadget@gmail.com>
Message-ID: <211127.86zgpphohi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 26 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> [...]
> +	/*
> +	 * Get our worktree; we only protect the current working directory
> +	 * if it's in the worktree.
> +	 */
> +	worktree = get_git_work_tree();
> +	if (!worktree)
> +		goto no_prevention_needed;
> +
> +	offset = dir_inside_of(startup_info->original_cwd, worktree);
> +	if (offset >= 0) {

Nit: Easier to read as:

    offset = [...]
    if (offset < 0)
    	return;

I.e. the reader can skip that whole "offset >= 0" block and anything
after if it <0, which also reduces the indentation. We run into the
"return' below.

> +		/*
> +		 * If startup_info->original_cwd == worktree, that is already
> +		 * protected and we don't need original_cwd as a secondary
> +		 * protection measure.
> +		 */
> +		if (!*(startup_info->original_cwd + offset))
> +			goto no_prevention_needed;
> +
> +		/*
> +		 * original_cwd was inside worktree; precompose it just as
> +		 * we do prefix so that built up paths will match
> +		 */
> +		startup_info->original_cwd = \

TIL you can use backslashes like that in C outside of macros, but it's
not needed here, better without?

> +			precompose_string_if_needed(startup_info->original_cwd
> +						    + offset);
> +	}
> +	return;

