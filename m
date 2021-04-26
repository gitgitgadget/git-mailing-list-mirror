Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742D2C433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 15:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3426A61175
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 15:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbhDZPsG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 11:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbhDZPsD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 11:48:03 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAABC061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 08:47:20 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id o5so56936793qkb.0
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 08:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zytslgzHzXo5d9fM/7LGqnVweJhnYJKi3GpYRHtlHRk=;
        b=Hofqr6r8a0CU2ZpxaGBkfdwEJHfHtiRHhDjudvuylTwwbvx2H7htzUvoN+22QoN3zF
         DCZE7ewk8Fvm0t2+j8Tku55UNFbVuqkeFhO0M813TH67zAFZuYctx27xumv4Tm4iWtNC
         +Ba5WSZBu+hBmRhE8amMyWJvcqIYWTZbyZLsAWUdulot3aFYxsBJQaLtU3/3y5GEu6Ka
         Bn57r+uP7hdS72oOEaYq6U4Rs8BzsCp80aHeMgOP0YYe4git7RHElZWiFIfM6tKwOK+2
         Ny/x3hJ0uTQu4XFx0pZ6k+Htae8Xt9U7p+vGBryI2t0UPOMFkEaTZFzuff0982yn5U7K
         xXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zytslgzHzXo5d9fM/7LGqnVweJhnYJKi3GpYRHtlHRk=;
        b=tlu4kKpEvVKaVFbGTFNtYYqNzlQ2nBDhEuPXgiv9FpdC4wYXfmuZnUOAyDiZTnzB5M
         DHbOHJo4kV7vgrCFpvczuyGk10wYyj+VCBwDRkilSRUG03GLMg4mKTjdA0fQjJnN6mVK
         U3Xagjtv9RshjmKEGANbCT00Cyqxii4loxT5582vNrTIOXb9K/MlUuKynefIHYw+hVDC
         zk+HH3duD5/ishg+V1m7hPBMd5Xw9nd2EUEvm3hbEbM9EdXJPWMe6vNrG40e5F7yFnXm
         wgQ6zCZ2sAxlJ2u3Z3XoQNpMAd3hb0YZOrgGIYvlxPFHP3FNInhPzdvdF5SG4qU2gySe
         wY6g==
X-Gm-Message-State: AOAM530NG98Q91b1L8ifdu5cXFDQHfT3IbmbwkXG9YPpgYGj2WpB02Xs
        uBO0Dc3R659a+90HRES5DOM=
X-Google-Smtp-Source: ABdhPJwDNKFHvouKT3SgqtotncOYi3dugo5FerjlnoL/bWq5d+rPolwRkekQfLMGYKxhT/C0VwVRQw==
X-Received: by 2002:a37:a988:: with SMTP id s130mr18354241qke.67.1619452039475;
        Mon, 26 Apr 2021 08:47:19 -0700 (PDT)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:cdf6:999f:6779:61eb])
        by smtp.gmail.com with ESMTPSA id 26sm11824637qtd.73.2021.04.26.08.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 08:47:18 -0700 (PDT)
Subject: Re: [PATCH 09/23] fsmonitor--daemon: implement daemon command options
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <2b291d805d59b54203d939e048bb568782d5e17b.1617291666.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <91a0fc4b-505a-fa2b-c797-5e420e836642@gmail.com>
Date:   Mon, 26 Apr 2021 11:47:18 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <2b291d805d59b54203d939e048bb568782d5e17b.1617291666.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/21 11:40 AM, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
...
> +	/* Prepare to (recursively) watch the <worktree-root> directory. */
> +	strbuf_init(&state.path_worktree_watch, 0);
> +	strbuf_addstr(&state.path_worktree_watch, absolute_path(get_git_work_tree()));
> +	state.nr_paths_watching = 1;

Yes, let's watch the working directory.

> +	/*
> +	 * If ".git" is not a directory, then <gitdir> is not inside the
> +	 * cone of <worktree-root>, so set up a second watch for it.
> +	 */
> +	strbuf_init(&state.path_gitdir_watch, 0);
> +	strbuf_addbuf(&state.path_gitdir_watch, &state.path_worktree_watch);
> +	strbuf_addstr(&state.path_gitdir_watch, "/.git");
> +	if (!is_directory(state.path_gitdir_watch.buf)) {
> +		strbuf_reset(&state.path_gitdir_watch);
> +		strbuf_addstr(&state.path_gitdir_watch, absolute_path(get_git_dir()));
> +		state.nr_paths_watching = 2;
> +	}

But why watch the .git directory, especially for a worktree (or
submodule I guess)? What benefit do we get from events within the
.git directory? I'm expecting any event within the .git directory
should be silently ignored.

> +
>  static int is_ipc_daemon_listening(void)
>  {
>  	return fsmonitor_ipc__get_state() == IPC_STATE__LISTENING;
>  }
>  
> +static int try_to_run_foreground_daemon(void)
> +{
> +	/*
> +	 * Technically, we don't need to probe for an existing daemon
> +	 * process, since we could just call `fsmonitor_run_daemon()`
> +	 * and let it fail if the pipe/socket is busy.
> +	 *
> +	 * However, this method gives us a nicer error message for a
> +	 * common error case.
> +	 */
> +	if (is_ipc_daemon_listening())
> +		die("fsmonitor--daemon is already running.");
Here, it seems like we only care about IPC_STATE_LISTENING, while
earlier I mentioned that I ended up in IPC_STATE__NOT_LISTENING,
and my manually running of the daemon helped.

> +	return !!fsmonitor_run_daemon();
> +}

You are ignoring the IPC_STATE__NOT_LISTENING and creating a new
process, which is good. I'm just wondering why that state exists
and what is the proper way to handle it?

> +
> +#ifndef GIT_WINDOWS_NATIVE

You are already creating a platform-specific mechanism for the
filesystem watcher. Shouldn't the implementation of this method
be part of that file in compat/fsmonitor/?

I guess the biggest reason is that macOS and Linux share this
implementation, so maybe this is the cleanest approach.

> +
> +/*
> + * This is adapted from `wait_or_whine()`.  Watch the child process and
> + * let it get started and begin listening for requests on the socket
> + * before reporting our success.
> + */
> +static int wait_for_background_startup(pid_t pid_child)
> +{
> +	int status;
> +	pid_t pid_seen;
> +	enum ipc_active_state s;
> +	time_t time_limit, now;
> +
> +	time(&time_limit);
> +	time_limit += fsmonitor__start_timeout_sec;
> +
> +	for (;;) {
> +		pid_seen = waitpid(pid_child, &status, WNOHANG);
> +
> +		if (pid_seen == -1)
> +			return error_errno(_("waitpid failed"));
> +
> +		else if (pid_seen == 0) {

There is some non-standard whitespace throughout this
if/else if/else:
...> +			continue;
> +		}
> +
> +		else if (pid_seen == pid_child) {
...
> +			return error(_("fsmonitor--daemon failed to start"));
> +		}
> +
> +		else
> +			return error(_("waitpid is confused"));

The rest of the glue in this patch looks good.

Thanks,
-Stolee
