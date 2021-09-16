Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86434C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 04:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C5C4611CA
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 04:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbhIPEy3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 00:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhIPEy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 00:54:28 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A243EC061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 21:53:08 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id b200so6356751iof.13
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 21:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9Adw2/02+4ZCBAvIMnClErjy6sT+QamAPbAjEPXZRyM=;
        b=SGioFkrmHZsLHUrJkOf4zaib0B+QJhgI4nh0TE7NYO2egnJfdCaqC3xXVv05Fr20VE
         NbTmxhD0yCCOkTz3L/malKVVNKMcsGl0HaPndx14YGCS7N9cP8zSz8joPipN7V573ptB
         DD/3CbmECs3NanRHvkNgyIS1id/o3J3DbggMR9SBTBeUKJ6rq8BRQ3F3Sn9wv7GsUhzf
         l+ypApQzpUNHjfcSEpoOCC5nhbUF4a9uo33nX3xQYuSDsUfBELaNPdDwLiZNhxhbTLy4
         L/daJkmMOG5PP01W/T+VqI1GyCsqIjJm9KMG5cPm4CuiYUxUOYRpJWYyZr0yLiXuuHX4
         TAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Adw2/02+4ZCBAvIMnClErjy6sT+QamAPbAjEPXZRyM=;
        b=h0awDCyQxzG5nRngpSJ5g8aTMB5Ot8sZFNtKeSWPCkDUbyqNGtFxwW69qJw3McbZkE
         gxvtGYeyOo/I5e5YHzvSV+Tnit3fuw1NVLbMc5DpOwYI7bPANtYbg6qkL81rODstD42R
         TztNHrMlv5elp6yO4nZqOCN0Dpv1kAv+XxTC0ElnD0CFIrZrZX0jzkHPsS5PX0i2Wr7u
         EEXbxXi0cLLN/kzRewh1PRB8GRDzEZUrblTFpicKz6KIJOTwdLj0EFa762XmYxhy9D1i
         Zxjd+BdKmUCQEENMvNAGS3HAB34KFuIBZIczU2nJ8xaFqS9w1MTvQbYMKj3Az78cfrlg
         Z+cQ==
X-Gm-Message-State: AOAM530kFxgGVJCVTi+H9GAkGX4XgcFDt4M3Zwb1MF/hqVKn00OLlfAX
        LPiGHtmaZywZq9Kex1O1Cj1X6Q==
X-Google-Smtp-Source: ABdhPJyWzpcrib+8iDHHYb4BSFBtJMAQVPgMANft1FfG/Zj/hy0TqSK3kJE/sMnhy8C70qDFeQUzxQ==
X-Received: by 2002:a05:6602:2219:: with SMTP id n25mr2822625ion.185.1631767987997;
        Wed, 15 Sep 2021 21:53:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y11sm1026423iol.49.2021.09.15.21.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 21:53:07 -0700 (PDT)
Date:   Thu, 16 Sep 2021 00:53:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 6/7] run-command: create start_bg_command
Message-ID: <YULNs166fGOfVUVy@nand.local>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <f97038a563d889d740a7e968fcbdfaadb41e2008.1631738177.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f97038a563d889d740a7e968fcbdfaadb41e2008.1631738177.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 15, 2021 at 08:36:16PM +0000, Jeff Hostetler via GitGitGadget wrote:
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
> +		sbgr = SBGR_ERROR;
> +		goto done;
> +	}
> +
> +	time(&time_limit);
> +	time_limit += timeout_sec;

This jumped out to me as unsafe, since POSIX guarantees time_t to be an
integral value holding a number of seconds (so += timeout_sec is safe
there), but it isn't in the C standard.

But we have lots of other examples of adding a number of seconds
directly the value filled in by time(2), so I think this is fine.

> +
> +wait:
> +	pid_seen = waitpid(cmd->pid, &wait_status, WNOHANG);
> +
> +	if (pid_seen == 0) {

Small nit, probably better to write this as if (!pid_seen), but not
worth a reroll alone.

> +		/*
> +		 * The child is currently running.  Ask the callback
> +		 * if the child is ready to do work or whether we
> +		 * should keep waiting for it to boot up.
> +		 */

This comment is simple and informative, thank you!

> +		ret = (*wait_cb)(cb_data, cmd);
> +		if (!ret) {
> +			/*
> +			 * The child is running and "ready".
> +			 *
> +			 * NEEDSWORK: As we prepare to orphan (release to
> +			 * the background) this child, it is not appropriate
> +			 * to emit a `trace2_child_exit()` event.  Should we
> +			 * create a new event for this case?

Probably. Maybe trace2_child_orphaned() or trace2_child_background()?

> +			 */
> +			sbgr = SBGR_READY;
> +			goto done;
> +		} else if (ret > 0) {
> +			time_t now;
> +
> +			time(&now);
> +			if (now < time_limit)
> +				goto wait;
> +
> +			/*
> +			 * Our timeout has expired.  We don't try to
> +			 * kill the child, but rather let it continue
> +			 * (hopefully) trying to startup.
> +			 *
> +			 * NEEDSWORK: Like the "ready" case, should we
> +			 * log a custom child-something Trace2 event here?
> +			 */
> +			sbgr = SBGR_TIMEOUT;
> +			goto done;
> +		} else {
> +			/*
> +			 * The cb gave up on this child.
> +			 *
> +			 * NEEDSWORK: Like above, should we log a custom
> +			 * Trace2 child-something event here?
> +			 */
> +			sbgr = SBGR_CB_ERROR;
> +			goto done;
> +		}

OK, so assuming that the child is running, then we ask wait_cb what to
do. Returning zero from the callback means to background it, a positive
value means to give it more time, and negative means to cause an error.
And those match the documentation below, good.

> +	if (pid_seen == cmd->pid) {

This could be an "else if", no?

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

Do we care about emitting the same error (when it was signaled with
something other than SIGINT/SIGQUIT/SIGPIPE) as is reported by
wait_or_whine()?

If we want that error here, too, we could probably share the same code
here from here and in wait_or_whine(). I would probably write something
like:

    static int handle_awaited_status(int status, int *code)
    {
      if (WIFSIGNALED(status)) {
        *code = WTERMSIG(status);
        if (*code != SIGINT && *code != SIGQUIT && *code != SIGPIPE)
               error("%s died of signal %d", argv0, *code);
        /*
         * This return value is chosen so that code & 0xff
         * mimics the exit code that a POSIX shell would report for
         * a program that died from this signal.
         */
        *code += 128;
        return 1;
      } else if (WIFEXITED(status)) {
        *code = WEXITSTATUS(status);
        return 1;
      }
      return 0;
    }

so that we could call it in wait_or_whine() like:

    } else if (!handle_awaited_status(status, &code)) {
      error("waitpid is confused (%s)", argv0);
    }

and similarly here in this new function. Alternatively, if we don't want
that error, then it may help future readers to add a short comment
explaining why not.

> +/**
> + * Callback used by `start_bg_command()` to ask whether the
> + * child process is ready or needs more time to become ready.
> + *
> + * Returns 1 is child needs more time (subject to the requested timeout).
> + * Returns 0 if child is ready.
> + * Returns -1 on any error and cause `start_bg_command()` to also error out.
> + */
> +typedef int(start_bg_wait_cb)(void *cb_data,
> +			      const struct child_process *cmd);

Nitpicking, but typically I would assume that the "extra" void pointer
is the last argument in a callback. It definitely does not matter,
though.

Thanks,
Taylor
