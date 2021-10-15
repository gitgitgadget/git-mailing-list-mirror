Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DF0C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EF3661181
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241263AbhJOQ2D (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 12:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241292AbhJOQ15 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 12:27:57 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBD0C061769
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 09:25:43 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id t11so6699922plq.11
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 09:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gcRrF+XONew4FUq7XSUImAixR9ykJvqgiMHEhZJn3aM=;
        b=Gpm7HYDSnN9QgRXMh0Tx7Qw/xdX9bg9p6W6xrBwP4wJUwrjxkIlKU9WbLi6T02S7Td
         wQams1eIFE6cd8STpNYDVNjUSMawecYYHiX6rkJw2RvozOhFi7sAxiiUUJ6wVwDo0try
         YhZlo1Li8fVifzeutzI2mxhRat5ezsmhMv/26xgTM/ibe9WPTRA1ykm9ytaf0Fy9caVq
         PHPxhhKHdiYNgku74wBoFeUuOQOcNXC39HfEkYeGKIPAtCmHUVeIDg9BW3ujHFqpGAWu
         vBQB9g/KKl238CKnuGGvVeSsv643LFCTWt6cD/dWdH+Sd+e5fmSKQ14NbNGwjQrZuITI
         1D9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gcRrF+XONew4FUq7XSUImAixR9ykJvqgiMHEhZJn3aM=;
        b=Ub9D0qGCKAqPyrna1BcYL+ijBwgsFLbSfWp1nFzbU40gwfQ0bNg6LvX6hMtlFK5BOj
         kCMBlRg/acYT06V1lNZQ25vyFhcg2DhhYjhR7Ap64cL3LI4hHbXSNKw0pBzNUFcwDemT
         Fy17vL8tGSQeCzOmH9yh064K5evssdZ7IGgwWRobuuxKk4BNK9Dsci6lT5kwjkOotPem
         JJyUkgztDm79SeU0ahzTxIlOXVQBd6AvRf3gb3g5zKwS/UxXVzPGrugZG/3qGxln0flg
         6q7EfzJkEV7IGeRP1AzgjQrY+L2wXa+vpegG9m4p/ueJIU0DNkA8DXGJaPezlGQPyDJ/
         Ekcw==
X-Gm-Message-State: AOAM531DyvPZY03C9sGBfK55lPfudHQfnIQA0U4gFjEP9wPsMJf1RB/G
        tFNIqjQvTGQka7ATtnOVUN4Ajg==
X-Google-Smtp-Source: ABdhPJxHNNxuxZS48IOFwjJH4fTar55dlQhDoqO0Ejlsu1ZOW5kByLl60wNu7IemrXOGlAuGQy9TfA==
X-Received: by 2002:a17:902:7246:b0:138:a6ed:66cc with SMTP id c6-20020a170902724600b00138a6ed66ccmr12328202pll.22.1634315142554;
        Fri, 15 Oct 2021 09:25:42 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cc2f:afb0:ab09:f218])
        by smtp.gmail.com with ESMTPSA id c27sm5455611pgb.89.2021.10.15.09.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 09:25:42 -0700 (PDT)
Date:   Fri, 15 Oct 2021 09:25:37 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 04/13] am: convert applypatch to use hook.h
Message-ID: <YWmrgdFqxOQkjgD7@google.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
 <patch-v2-04.13-0e34eb54054-20211015T093918Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-04.13-0e34eb54054-20211015T093918Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 12, 2021 at 03:30:29PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> Teach pre-applypatch, post-applypatch, and applypatch-msg to use the
> hook.h library instead of the run-command.h library.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Reviewed-by: Emily Shaffer <emilyshaffer@google.com>

> ---
>  builtin/am.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/am.c b/builtin/am.c
> index 3527945a467..2cfe6451b6f 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -446,9 +446,11 @@ static void am_destroy(const struct am_state *state)
>  static int run_applypatch_msg_hook(struct am_state *state)
>  {
>  	int ret;
> +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
>  
>  	assert(state->msg);
> -	ret = run_hook_le(NULL, "applypatch-msg", am_path(state, "final-commit"), NULL);
> +	strvec_push(&opt.args, am_path(state, "final-commit"));
> +	ret = run_hooks_oneshot("applypatch-msg", &opt);
>  
>  	if (!ret) {
>  		FREE_AND_NULL(state->msg);
> @@ -1609,7 +1611,7 @@ static void do_commit(const struct am_state *state)
>  	const char *reflog_msg, *author, *committer = NULL;
>  	struct strbuf sb = STRBUF_INIT;
>  
> -	if (run_hook_le(NULL, "pre-applypatch", NULL))
> +	if (run_hooks_oneshot("pre-applypatch", NULL))
>  		exit(1);
>  
>  	if (write_cache_as_tree(&tree, 0, NULL))
> @@ -1661,7 +1663,7 @@ static void do_commit(const struct am_state *state)
>  		fclose(fp);
>  	}
>  
> -	run_hook_le(NULL, "post-applypatch", NULL);
> +	run_hooks_oneshot("post-applypatch", NULL);
>  
>  	strbuf_release(&sb);
>  }
> -- 
> 2.33.0.1567.g7b23ce7ed9e
> 
