Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEA6C433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 17:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E3CC610E8
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 17:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242141AbhJORUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 13:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242140AbhJORUw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 13:20:52 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B865C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 10:18:46 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id lk8-20020a17090b33c800b001a0a284fcc2so9806805pjb.2
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 10:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=j0W/RobuR+68Obp66zPtrChSMo3ZIBXLL7gIKrGBYe8=;
        b=gvst4tcQpBLZgbaWFFADwrPDcNuOlBNoEfDA8Vw4VwehcTf2VCpln/YeUrPDWQrANg
         NUwkVwKllcsMlGeIOohphARUm+E+zfX5f/m4wacB50NRhXeqYocbbn3d/8gTBLO4BRf5
         LrptpcSgQpS1gJNmZT9TUKZy5W2WeyTssH3q0SoRwM+bVUNkqKYkvj3BPy/qQ0vyxn0M
         hjCLA2eerAuHX7iI1GBvjM6q0dNTo3A/gqkM+zGWuRjE2t5KAkPtyg5n7kXZObRmb3P7
         Dy7Ag573ENOwbKYp2ncaV/XqCkJ7PWXmaO1jUqO6bhnRjfcu2CUc1veWtMaUO3tBInXU
         mKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=j0W/RobuR+68Obp66zPtrChSMo3ZIBXLL7gIKrGBYe8=;
        b=Tgn85XH+eIqL/G6LpcuBYq+6JqA4qg14vppnh1B7HGVcnyDXVBmBCHQVbHiNbru5vo
         hkIrfcaQfA9dIwc9p33k9fzn4zZWvX0uDQTmORRyp4zrz/uyRz3oh2ktLSTcVs6jbFbK
         mbEJ+AYhFYSCKqt3a2qNO5JLCiXg9f6KIOAIukivjBbG18oZ4BIVj0nrHy0dY6lxQmJ4
         FXBAryCr5nCwoiCEPlbV4g9T90s0brz805dc7V8nfD3Tg3hiikIsBh/vHnQF8FWMo4jO
         VsaG89myiZj0eUsg2srbcNxe6yZZBLFezAmU3Dm4BG1kozQ8nCK3y9NZ/FtdIL8KAocP
         /h1A==
X-Gm-Message-State: AOAM531DWj0hvPJFodb9qkrvVGjafPAyEn7X8kgjGGrq9zLxHA/8pBzP
        5b8lHYJYNtPwhndrMKJOPy93eA==
X-Google-Smtp-Source: ABdhPJz5gI71aDJncbPzjEeakOtuC0fjMsJhsZlef/p4T4nRGRP2RdPymPyxtcQ8ZL1ljo7xm2NsQg==
X-Received: by 2002:a17:902:e282:b0:13f:62b1:9a06 with SMTP id o2-20020a170902e28200b0013f62b19a06mr12164262plc.1.1634318325374;
        Fri, 15 Oct 2021 10:18:45 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cc2f:afb0:ab09:f218])
        by smtp.gmail.com with ESMTPSA id j20sm5104361pgb.2.2021.10.15.10.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 10:18:44 -0700 (PDT)
Date:   Fri, 15 Oct 2021 10:18:38 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 13/13] run-command: remove old run_hook_{le,ve}() hook
 API
Message-ID: <YWm37gqAyxyc5X07@google.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
 <patch-v2-13.13-289d5a2d849-20211015T093918Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-13.13-289d5a2d849-20211015T093918Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 15, 2021 at 11:43:41AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> The new hook.h library has replaced all run-command.h hook-related
> functionality. So let's delete this dead code.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>

Thanks.

> ---
>  run-command.c | 32 --------------------------------
>  run-command.h | 16 ----------------
>  2 files changed, 48 deletions(-)
> 
> diff --git a/run-command.c b/run-command.c
> index d92e670c8ed..8a21ff525f3 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1323,38 +1323,6 @@ int async_with_fork(void)
>  #endif
>  }
>  
> -static int run_hook_ve(const char *const *env, const char *name, va_list args)
> -{
> -	struct child_process hook = CHILD_PROCESS_INIT;
> -	const char *p;
> -
> -	p = find_hook(name);
> -	if (!p)
> -		return 0;
> -
> -	strvec_push(&hook.args, p);
> -	while ((p = va_arg(args, const char *)))
> -		strvec_push(&hook.args, p);
> -	hook.env = env;
> -	hook.no_stdin = 1;
> -	hook.stdout_to_stderr = 1;
> -	hook.trace2_hook_name = name;
> -
> -	return run_command(&hook);
> -}
> -
> -int run_hook_le(const char *const *env, const char *name, ...)
> -{
> -	va_list args;
> -	int ret;
> -
> -	va_start(args, name);
> -	ret = run_hook_ve(env, name, args);
> -	va_end(args);
> -
> -	return ret;
> -}
> -
>  struct io_pump {
>  	/* initialized by caller */
>  	int fd;
> diff --git a/run-command.h b/run-command.h
> index 3fa7454cf8a..59e1fbff64c 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -224,22 +224,6 @@ int finish_command_in_signal(struct child_process *);
>   */
>  int run_command(struct child_process *);
>  
> -/**
> - * Run a hook.
> - * The first argument is a pathname to an index file, or NULL
> - * if the hook uses the default index file or no index is needed.
> - * The second argument is the name of the hook.
> - * The further arguments correspond to the hook arguments.
> - * The last argument has to be NULL to terminate the arguments list.
> - * If the hook does not exist or is not executable, the return
> - * value will be zero.
> - * If it is executable, the hook will be executed and the exit
> - * status of the hook is returned.
> - * On execution, .stdout_to_stderr and .no_stdin will be set.
> - */
> -LAST_ARG_MUST_BE_NULL
> -int run_hook_le(const char *const *env, const char *name, ...);
> -
>  /*
>   * Trigger an auto-gc
>   */
> -- 
> 2.33.1.1338.g20da966911a
> 
