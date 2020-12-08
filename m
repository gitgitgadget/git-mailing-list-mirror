Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13787C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 23:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE1E123A7B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 23:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbgLHXDA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 18:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730728AbgLHXC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 18:02:59 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4309C0613CF
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 15:02:19 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id c12so83955pfo.10
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 15:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=PDF8BO7HosjUn8NCRGd/DeLsxZrZ7Oytc7eJOHtNOBI=;
        b=Lo4X1aa8Wt5JDVkH3EdyJP/m441z2WJq5uX1YMiMTYR1Vvfcjj2EGtf54TdhJ4SPct
         8DcmjR6UO28fZj8MrfD462b23hLWGQX9R5IokG2rRQl8J9/g2695HpmuKCDFNDgiw9FC
         lTOcuQSqiuiX7q5GW5FirYU0uyFSEIYJgznM5OJJu3hFEUKifddqJzzjopsxlhPMbruI
         JN5R043PR49nWaRrTDSSj8BxpHvmiZxBJ5dMhuUu8yaYGH/KkQiSCxDbVbYgHfERM02/
         FDRA0QE7hXqWVQnNqJ9uNzP3fIk1oxh5SDjZyyEpv71yqPQo6nF0DHggXt/S9kzeRsHE
         uBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=PDF8BO7HosjUn8NCRGd/DeLsxZrZ7Oytc7eJOHtNOBI=;
        b=DgQ/TxpFRuDnFsD5qEDhjQYF7gG5PWtL+oWkcGndWJF0fiEBVHi5VTkqG8FSPXtJCC
         NYIS8m08SyAjVDBu/VP/4ikYGBgsLN+kgiMLN24bYxkLkc9t3cuDrlWlE54BZ5yzIBWh
         Hf5w4yR8EowgAzv2U6hP6i/kzv8VKpkd+ThgSHvL8Auzj/13DicC/Hevzw5p6keC4/FV
         whDXUOkYtQjSfgoCZtNhSHR4YQLxAJbCcSuWKCwjgqQ96aJLYT8K0Z6z1rI0K7wKiUEC
         yKPkYf9tp1vaPMCwAy70ahore8JChJvDyB9abf0JQFynROSyvrxIVaFie33pD1gFkoSS
         1U0A==
X-Gm-Message-State: AOAM5302RpySJXUTH/nPtb+0e6rD4y0rFjd3clloEVCqbRPsEee+nQu7
        nFmA0fKdj8KYHuC1hTg4bYtagA==
X-Google-Smtp-Source: ABdhPJwX1D+VV/Ef3LQ0Np71wjxaqGugkJiaTWM+QTTJgYrEGLtG7YN6EfNSb3atbVmc/P03i9c5uw==
X-Received: by 2002:a17:90b:4acc:: with SMTP id mh12mr25163pjb.54.1607468539180;
        Tue, 08 Dec 2020 15:02:19 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
        by smtp.gmail.com with ESMTPSA id f185sm201897pfa.213.2020.12.08.15.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 15:02:18 -0800 (PST)
Date:   Tue, 8 Dec 2020 15:02:13 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 10/17] hook: convert 'post-rewrite' hook to config
Message-ID: <20201208230213.GM36751@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20201205014945.1502660-1-emilyshaffer@google.com>
 <20201205014945.1502660-11-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201205014945.1502660-11-emilyshaffer@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020.12.04 17:49, Emily Shaffer wrote:
> diff --git a/sequencer.c b/sequencer.c
> index 5a98fd2fbc..4befd862ff 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -35,6 +35,7 @@
>  #include "rebase-interactive.h"
>  #include "reset.h"
>  #include "hook.h"
> +#include "string-list.h"
>  
>  #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>  
> @@ -1143,33 +1144,23 @@ int update_head_with_reflog(const struct commit *old_head,
>  static int run_rewrite_hook(const struct object_id *oldoid,
>  			    const struct object_id *newoid)
>  {
> -	struct child_process proc = CHILD_PROCESS_INIT;
> -	const char *argv[3];
> +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_ASYNC;
> +	struct strbuf tmp = STRBUF_INIT;
>  	int code;
> -	struct strbuf sb = STRBUF_INIT;
>  
> -	argv[0] = find_hook("post-rewrite");
> -	if (!argv[0])
> -		return 0;
> +	strvec_push(&opt.args, "amend");
>  
> -	argv[1] = "amend";
> -	argv[2] = NULL;
> -
> -	proc.argv = argv;
> -	proc.in = -1;
> -	proc.stdout_to_stderr = 1;
> -	proc.trace2_hook_name = "post-rewrite";
> -
> -	code = start_command(&proc);
> -	if (code)
> -		return code;
> -	strbuf_addf(&sb, "%s %s\n", oid_to_hex(oldoid), oid_to_hex(newoid));
> -	sigchain_push(SIGPIPE, SIG_IGN);

Here and in a few other later patches, we're removing some signal
handling that doesn't seem to be replicated in the run_hooks()
implementation. Can you add a note to the commit message about why this
is OK?

> -	write_in_full(proc.in, sb.buf, sb.len);
> -	close(proc.in);
> -	strbuf_release(&sb);
> -	sigchain_pop(SIGPIPE);
> -	return finish_command(&proc);
> +	strbuf_addf(&tmp,
> +		    "%s %s",
> +		    oid_to_hex(oldoid),
> +		    oid_to_hex(newoid));
> +	string_list_append(&opt.str_stdin, tmp.buf);
> +
> +	code = run_hooks("post-rewrite", &opt);
> +
> +	run_hooks_opt_clear(&opt);
> +	strbuf_release(&tmp);
> +	return code;
>  }
>  
>  void commit_post_rewrite(struct repository *r,
> @@ -4317,30 +4308,21 @@ static int pick_commits(struct repository *r,
>  		flush_rewritten_pending();
>  		if (!stat(rebase_path_rewritten_list(), &st) &&
>  				st.st_size > 0) {
> -			struct child_process child = CHILD_PROCESS_INIT;
> -			const char *post_rewrite_hook =
> -				find_hook("post-rewrite");
> -
> -			child.in = open(rebase_path_rewritten_list(), O_RDONLY);
> -			child.git_cmd = 1;
> -			strvec_push(&child.args, "notes");
> -			strvec_push(&child.args, "copy");
> -			strvec_push(&child.args, "--for-rewrite=rebase");
> +			struct child_process notes_cp = CHILD_PROCESS_INIT;
> +			struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT_ASYNC;
> +
> +			notes_cp.in = open(rebase_path_rewritten_list(), O_RDONLY);
> +			notes_cp.git_cmd = 1;
> +			strvec_push(&notes_cp.args, "notes");
> +			strvec_push(&notes_cp.args, "copy");
> +			strvec_push(&notes_cp.args, "--for-rewrite=rebase");
>  			/* we don't care if this copying failed */
> -			run_command(&child);
> -
> -			if (post_rewrite_hook) {
> -				struct child_process hook = CHILD_PROCESS_INIT;
> -
> -				hook.in = open(rebase_path_rewritten_list(),
> -					O_RDONLY);
> -				hook.stdout_to_stderr = 1;
> -				hook.trace2_hook_name = "post-rewrite";
> -				strvec_push(&hook.args, post_rewrite_hook);
> -				strvec_push(&hook.args, "rebase");
> -				/* we don't care if this hook failed */
> -				run_command(&hook);
> -			}
> +			run_command(&notes_cp);
> +
> +			hook_opt.path_to_stdin = rebase_path_rewritten_list();
> +			strvec_push(&hook_opt.args, "rebase");
> +			run_hooks("post-rewrite", &hook_opt);
> +			run_hooks_opt_clear(&hook_opt);
>  		}
>  		apply_autostash(rebase_path_autostash());
>  
> -- 
> 2.28.0.rc0.142.g3c755180ce-goog
> 
