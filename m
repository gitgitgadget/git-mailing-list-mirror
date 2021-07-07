Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DCBC07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 16:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2695061CC9
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 16:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhGGRAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 13:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbhGGRAP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 13:00:15 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CD8C061574
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 09:57:33 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y4so2726826pfi.9
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 09:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ObL6y2aVaHNROVn3Z9s4Z/u8FWAoZwCMcjmY2WBixoA=;
        b=I9FqIH44PD8SJyOI5zx7uP+7N6Ka4IlaSx+j2IfIhUnmebOqENzpToKrG13pC3uate
         2VEwTE76l4dNf5sT5hsFxhj2nJ8CowMRx/47FfencHXtUum+ttLAKvagF5szQwfXP1SH
         /BmXThIv8qLOv5Iiscv7Jot9+mGcyXv0JnOHGst5akMYz6TPL0vfaGZTocT67ra1DBir
         t7M6KX0WaGLYWijDVbia01/A+eNmdq0ndqemC+F2WnG89embPIJzyH8gBsHVemhaiAkp
         901s2fJgjfHGGPRAwxkwNe0GSJJR8QbPbzKJuRHfN4+F0cBHJS7icvGO7j6QzTWXr8lo
         /s7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ObL6y2aVaHNROVn3Z9s4Z/u8FWAoZwCMcjmY2WBixoA=;
        b=KUL9AIK8hWbW8i181nBt2n4lMoF6ZiT/EiKjKUfEzbMl/bCyuTUfd/yRrnt62tUVJc
         dAtw5sRDksP94nQ1gArPktgCTQgJzCjwZajJcoxrBqdWyCXWAHeuufEUlA7QuaSyXUVf
         wk1qiCZShmW70hpejxZQO9o++g4r3z6boaziGSDEnRZ4tKFPEIWOtST44moTrSjt7+8Y
         NkTgsnnCo3mLVnyndLIVji/y4dpqq7laeN5cCs8HG64TcrFBW40+Radd0APoVnxgp79c
         jtbQEQiz4vI6HahPCpI2ZN5M+Bl64NqonQQnVHCen1JNQODJI5DM8naoG08y/qoN6L2f
         rrzg==
X-Gm-Message-State: AOAM532FmB5C8cznG+Bb7pmpTCp5ZrU2WSoFg6PV8M2L7lb9jZDp1YC1
        wOKEioJZA8a0ppjWxRgt3Co=
X-Google-Smtp-Source: ABdhPJw1yWWc6oXUgFxyaph0FedCHDKfohcdR1vVzoWYVbLTBiqmJ4TOUIWPHQlFQ1sWXxNOt8K26w==
X-Received: by 2002:a05:6a00:80b:b029:324:2bf0:d775 with SMTP id m11-20020a056a00080bb02903242bf0d775mr7535821pfk.21.1625677052942;
        Wed, 07 Jul 2021 09:57:32 -0700 (PDT)
Received: from localhost ([2402:800:63b8:9039:443b:57cf:40b5:f8d1])
        by smtp.gmail.com with ESMTPSA id f20sm13754104pfv.47.2021.07.07.09.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 09:57:32 -0700 (PDT)
Date:   Wed, 7 Jul 2021 23:57:30 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Hu Jialun <hujialun@comp.nus.edu.sg>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 1/2] commit: reorganise duplicate commit prompt strings
Message-ID: <YOXc+mT01vptY9Nx@danh.dev>
References: <20210706022438.580374-1-hujialun@comp.nus.edu.sg>
 <20210707162308.2438170-1-hujialun@comp.nus.edu.sg>
 <20210707162308.2438170-2-hujialun@comp.nus.edu.sg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707162308.2438170-2-hujialun@comp.nus.edu.sg>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jialun,

On 2021-07-08 00:23:07+0800, Hu Jialun <hujialun@comp.nus.edu.sg> wrote:
> While the prefilled commit prompt is mostly the same for different
> cleanup modes, those are separately repeated, which violates the DRY
> principle and hinders maintainability.
> 
> Unify and reorder identical substrings to improve.
> 
> Signed-off-by: Hu Jialun <hujialun@comp.nus.edu.sg>
> ---
>  builtin/commit.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 190d215d43..815b408002 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -910,21 +910,24 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		}
>  
>  		fprintf(s->fp, "\n");
> -		if (cleanup_mode == COMMIT_MSG_CLEANUP_ALL)
> -			status_printf(s, GIT_COLOR_NORMAL,
> -				_("Please enter the commit message for your changes."
> -				  " Lines starting\nwith '%c' will be ignored, and an empty"
> -				  " message aborts the commit.\n"), comment_line_char);
> +		const char *msg_enter_prompt = _("Please enter the commit message for your changes.");
> +		const char *keep_char_prompt = _("Lines starting with '%c' will be kept;"
> +						 " you may remove them yourself if you want to.");
> +		const char *ignore_char_prompt = _("Lines starting with '%c' will be ignored.");
> +		const char *empty_msg_abort_prompt = _("An empty message aborts the commit.");

In Git project, it's enforced to have -Wdeclaration-after-statement,
IOW, move all declaration before statement.



> +		if (cleanup_mode == COMMIT_MSG_CLEANUP_ALL) {
> +			status_printf_ln(s, GIT_COLOR_NORMAL, msg_enter_prompt);

builtin/commit.c:919:4: error: format not a string literal and no format arguments [-Werror=format-security]
  919 |    status_printf_ln(s, GIT_COLOR_NORMAL, msg_enter_prompt);

msg_enter_prompt will come from translator and may have '%' inside it.

We can solve it by inserting "%s" there.

However, I think we shouldn't take this route, because splitting likes this
will make a translation lego. I can't speak for Junio, but from my
observation, it's preferred to have 3 variables for 3 full-text, and
we will pick the suitable text in each if-leg.

> +			status_printf_ln(s, GIT_COLOR_NORMAL, ignore_char_prompt, comment_line_char);
> +			status_printf_ln(s, GIT_COLOR_NORMAL, empty_msg_abort_prompt);
> +		}
>  		else if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS) {
>  			if (whence == FROM_COMMIT && !merge_contains_scissors)
>  				wt_status_add_cut_line(s->fp);
> -		} else /* COMMIT_MSG_CLEANUP_SPACE, that is. */
> -			status_printf(s, GIT_COLOR_NORMAL,
> -				_("Please enter the commit message for your changes."
> -				  " Lines starting\n"
> -				  "with '%c' will be kept; you may remove them"
> -				  " yourself if you want to.\n"
> -				  "An empty message aborts the commit.\n"), comment_line_char);
> +		} else { /* COMMIT_MSG_CLEANUP_SPACE, that is. */
> +			status_printf_ln(s, GIT_COLOR_NORMAL, msg_enter_prompt);
> +			status_printf_ln(s, GIT_COLOR_NORMAL, keep_char_prompt, comment_line_char);
> +			status_printf_ln(s, GIT_COLOR_NORMAL, empty_msg_abort_prompt);
> +		}

After changing those texts, the tests should be updated, too.
It's a customary service for the next developer, who needs to bisect
this project to have all test-cases pass on each changes.

With this change, t7500.50 and t7502.37 runs into failures.
Please fix them here, instead of next change.
>  
>  		/*
>  		 * These should never fail because they come from our own
> -- 
> 2.32.0
> 

-- 
Danh
