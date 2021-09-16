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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797C1C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 06:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C1A060F58
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 06:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbhIPGNl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 02:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbhIPGNk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 02:13:40 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB42C061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 23:12:20 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id j13so12480332edv.13
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 23:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=3ALnGahCVTYnKz16YoS3fYIdBMSaxnECqZycLNezwmQ=;
        b=c/L39hcOw5EUuBVJg1l1yUqbXaqQVGHnqu/qRF1W35awNfKXK7r74lsHovGLxloQnb
         c5P9OZUNJjnWjzzZC58grt3StWH6hnFPjfUFfTEGmL0DRH8dnHup3T1Mo5BNlfSAqoEh
         Vtiy4DNbSkSl7bFab/+LilF4w6d//ZxbTc3Woxi5Zpk5ocEeZDZujVmIEPPeTEAzIx+8
         7UCH2R+57uuOfGFJe44p4dsIGpNEYwmXHANzMb3N/FCTpGiqdddkG7mx5BYJVACSIUSp
         oyLaaaDiAKbJpEhR6ro4ssOZx5BY+MKs43+xmJNjZFg+BD1VwqxpBIPU4PUg3PSte0S4
         aOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=3ALnGahCVTYnKz16YoS3fYIdBMSaxnECqZycLNezwmQ=;
        b=LDK6uuU6cK0AZT1GvWOEAw22OO2QLeS+JfwoGWjmhWJ/iO2at9d8vzoUZ28rWl091z
         IK0j8p5ljjoO+f0aCkmf2+y/FOPLpSXRJuxLr5Q4GJAoml7qjc9OM+2CfFgHT0TgTV5/
         lyFNXcNKK0wAn054lPIa3Pk9+4iYteKkVtMPZBcmVGg1vyfdBLASy4alo/W1S/c7C7D5
         xIZ86lUYZGdiDUYZ2e8bBNtqZwdrGuXy3tPOxe5kHy8nWq00ENqK98H92QGCPNsYGE0z
         kUmo/W9eSVWKGx9uH6bHc6xsQWEOsu3eidiOKmiI/KHSLJLw3ql+dP4u2cFT3Uq6iqJG
         coDg==
X-Gm-Message-State: AOAM533yHSxt1lkELveQ8pIvFqdz5cujgShL3yY4siMQb6ULimuzW+d/
        /XmclpoP+o+Noz+oqCYf9YLyVSrAqNE=
X-Google-Smtp-Source: ABdhPJzmM2WMwHM6wkGKJ0T4g9XaPHJBgg+1mlM4UxTK3ayAhUgzn4DanW7P667Rv7UvIi9ZSPaZMA==
X-Received: by 2002:aa7:d490:: with SMTP id b16mr4716678edr.189.1631772738920;
        Wed, 15 Sep 2021 23:12:18 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gx4sm781029ejb.116.2021.09.15.23.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 23:12:18 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 6/7] run-command: create start_bg_command
Date:   Thu, 16 Sep 2021 07:56:52 +0200
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <f97038a563d889d740a7e968fcbdfaadb41e2008.1631738177.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <f97038a563d889d740a7e968fcbdfaadb41e2008.1631738177.git.gitgitgadget@gmail.com>
Message-ID: <87r1dpgibi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 15 2021, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Create a variation of `run_command()` and `start_command()` to launch a command
> into the background and optionally wait for it to become "ready" before returning.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  run-command.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  run-command.h |  48 ++++++++++++++++++++
>  2 files changed, 171 insertions(+)
>
> diff --git a/run-command.c b/run-command.c
> index 3e4e082e94d..fe75fd08f74 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1901,3 +1901,126 @@ void prepare_other_repo_env(struct strvec *env_array, const char *new_git_dir)
>  	}
>  	strvec_pushf(env_array, "%s=%s", GIT_DIR_ENVIRONMENT, new_git_dir);
>  }
> +
> +enum start_bg_result start_bg_command(struct child_process *cmd,
> +				      start_bg_wait_cb *wait_cb,
> +				      void *cb_data,
> +				      unsigned int timeout_sec)
> +{
> +	enum start_bg_result sbgr = SBGR_ERROR;
> +	int ret;
> +	int wait_status;
> +	pid_t pid_seen;
> +	time_t time_limit;
> +
> +	/*
> +	 * Silently disallow child cleanup -- even if requested.
> +	 * The child process should persist in the background
> +	 * and possibly/probably after this process exits.  That
> +	 * is, don't kill the child during our atexit routine.
> +	 */
> +	cmd->clean_on_exit = 0;

Since we have no existing users, can we change this to:

if (cmd->clean_on_exit)
    BUG("start_bg_command() doesn't support non-zero clean_on_exit");

Just silently discarding what the caller asked for seems like the wrong
thing to do, why the silence?

> +
> +	ret = start_command(cmd);
> +	if (ret) {
> +		/*
> +		 * We assume that if `start_command()` fails, we
> +		 * either get a complete `trace2_child_start() /
> +		 * trace2_child_exit()` pair or it fails before the
> +		 * `trace2_child_start()` is emitted, so we do not
> +		 * need to worry about it here.
> +		 *
> +		 * We also assume that `start_command()` does not add
> +		 * us to the cleanup list.  And that it calls
> +		 * calls `child_process_clear()`.
> +		 */

These all look like sensible things to assume, but I think commentary /
writing on this would be much better just documenting that the
start_command() API does this in its comment in run-command.h, or
perhaps the comment starting with "The functions: child_process_init".

> +		sbgr = SBGR_ERROR;
> +		goto done;
> +	}
> +
> +	time(&time_limit);
> +	time_limit += timeout_sec;
> +
> +wait:
> +	pid_seen = waitpid(cmd->pid, &wait_status, WNOHANG);
> +
> +	if (pid_seen == 0) {
> +		/*
> +		 * The child is currently running.  Ask the callback
> +		 * if the child is ready to do work or whether we
> +		 * should keep waiting for it to boot up.
> +		 */
> +		ret = (*wait_cb)(cb_data, cmd);
> +		if (!ret) {
> +			/*
> +			 * The child is running and "ready".
> +			 *
> +			 * NEEDSWORK: As we prepare to orphan (release to
> +			 * the background) this child, it is not appropriate
> +			 * to emit a `trace2_child_exit()` event.  Should we
> +			 * create a new event for this case?
> +			 */
> +			sbgr = SBGR_READY;
> +			goto done;

Per api-trace2.txt:

    `"child_exit"`::
            This event is generated after the current process has returned
            from the waitpid() and collected the exit information from the
            child.

My (perhaps wrong) reading of that is that yes, we should do that, after
all if we've released the child are we otherwise going to hear from them
again in any way trace2 could log with a child_exit later?

Ditto the "commentary better elsewhere" whatever the result of this
discussion is, let's add a note to api-trace2.txt about how detached
children are handled by child_exit events.

> [...]
> +			 * NEEDSWORK: Like the "ready" case, should we
> +			 * log a custom child-something Trace2 event here?
> +			 */
> +			sbgr = SBGR_TIMEOUT;
> +			goto done;

[...]

> +		} else {
> +			/*
> +			 * The cb gave up on this child.
> +			 *
> +			 * NEEDSWORK: Like above, should we log a custom
> +			 * Trace2 child-something event here?
> +			 */
> +			sbgr = SBGR_CB_ERROR;
> +			goto done;

*ditto*

> +		}
> +	}
> +
> +	if (pid_seen == cmd->pid) {
> +		int child_code = -1;
> +
> +		/*
> +		 * The child started, but exited or was terminated
> +		 * before becoming "ready".
> +		 *
> +		 * We try to match the behavior of `wait_or_whine()`
> +		 * and convert the child's status to a return code for
> +		 * tracing purposes and emit the `trace2_child_exit()`
> +		 * event.
> +		 */
> +		if (WIFEXITED(wait_status))
> +			child_code = WEXITSTATUS(wait_status);
> +		else if (WIFSIGNALED(wait_status))
> +			child_code = WTERMSIG(wait_status) + 128;
> +		trace2_child_exit(cmd, child_code);

Although with the above: Perhaps I've missed some subtleties...

> [...]
> diff --git a/run-command.h b/run-command.h
> index af1296769f9..58065197d1b 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -496,4 +496,52 @@ int run_processes_parallel_tr2(int n, get_next_task_fn, start_failure_fn,
>   */
>  void prepare_other_repo_env(struct strvec *env_array, const char *new_git_dir);
>  
> +/**
> + * Possible return values for `start_bg_command()`.
> + */
> +enum start_bg_result {
> +	/* child process is "ready" */
> +	SBGR_READY = 0,

Clarity nit, whenever I see an explicit enum assignment I start hunting
for things that depend on the specific value, as we sometimes do, but
there appears to be nothing...

> +	/* child process could not be started */
> +	SBGR_ERROR,
> +
> +	/* callback error when testing for "ready" */
> +	SBGR_CB_ERROR,
> +
> +	/* timeout expired waiting for child to become "ready" */
> +	SBGR_TIMEOUT,
> +
> +	/* child process exited or was signalled before becomming "ready" */
> +	SBGR_DIED,

...I'd think if we were tweaking the value we'd want to put all the
error values at < 0, but I'm fine with this pattern of them being
positive, it encourages users to use switch/case & compiler checks, and
since it's all new users...

> + * This is a combination of `start_command()` and `finish_command()`, but

Doc nit: I think with whatever syntax standard we use for /** comments
that we prefer functions like_this() not quoted `like_this()`, that
being for values like `123` or whatever. But I'm just going by a quick
grep there & what Emacs is highlighting.
