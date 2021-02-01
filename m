Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23108C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 06:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A790364E2B
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 06:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhBAGxs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 01:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbhBAGwg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 01:52:36 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3D2C061574
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 22:51:55 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id l7so9868319pjy.0
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 22:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=omap3adMUrzwPoFNiA5dWmpHDtCQdqNGXkm5uNaTGCA=;
        b=fzeFPtgZGrCjeGQR0qjUkh9wYunaqIckT5fu5cmKsrVkniM9w8LDH9JTCpWqnp3P/O
         qRbCtp74pk61+nP0Lo4GaTXkkK+EPlNiIcekifco810p3pEqA1PDz23RBBS+R+13a+Om
         8wl6kSek2RtuN2+1IA9TDK4mgHuShrN8PTnOniv+KiOj4jD7Ab6TQJ61Qwx/7t3Y40Qq
         D7j6MLnjrLQ+Hbsy5v5GshnUrR3CQK92mEah7gy5jLPgQ4Onqa1hPi0eUve9s66BWc+v
         2WGNjJbISkdFbT1Bnl4FFqt9Hfz4GdXWWPK+N4cmgXdxRslqFVQ2QhzZwU4mIwcTqfmr
         3ufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=omap3adMUrzwPoFNiA5dWmpHDtCQdqNGXkm5uNaTGCA=;
        b=ZZfzSCVSEpko0e2CZcV8ySnOZwMwboGp44sGV7PXKaG1Z3TMvBoHlEieJfN9IEtWxl
         3kWmB/hfT7HYQcrsu7hf5Cr3l9sgnw7Rj+5gRItxWZKSEUu7ceSfQ7wLI7skPWwQmKWE
         ok+lARrveqp+9mjz0eyVut82fOLZcuIchK9NgqQ9Pvkqm0iozLVjrWTCkADFw9F3LDuq
         E1jV+dMx6Fm0TAxp+M+coFrkJr+vfIoJe9vqj8xDRSbwqIL8WF9/74b/eRIZvgfDp6lG
         TmvmqPRPbebgULeWtTMb308ZNhT7o/VHkSwwcp+6gaAyhOsgVjfDExyFSyYE+8Eyz0vJ
         RlnQ==
X-Gm-Message-State: AOAM533iu3wlQKuUYt7fTnLbGJwrwpU2X9KMBWPsY6uzE43q7bdh00L4
        A+gr/Mf77OdTLvyPxMb0uChCt4HnZegyaNW244hg
X-Google-Smtp-Source: ABdhPJxwuRN29a0rDl++2mii4TCMhZOLdokdbzK1u3/sAhbJ3h1LimEWRxHb5qEg2WV3aMgKLIflsXgI4vHoFkbHnoH2
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:8c98:b029:e1:5a00:537c with
 SMTP id t24-20020a1709028c98b02900e15a00537cmr4084926plo.79.1612162315425;
 Sun, 31 Jan 2021 22:51:55 -0800 (PST)
Date:   Sun, 31 Jan 2021 22:51:53 -0800
In-Reply-To: <20201222000220.1491091-15-emilyshaffer@google.com>
Message-Id: <20210201065153.1322296-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201222000220.1491091-15-emilyshaffer@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: Re: [PATCH v7 14/17] run-command: add stdin callback for parallelization
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> If a user of the run_processes_parallel() API wants to pipe a large
> amount of information to stdin of each parallel command, that
> information could exceed the buffer of the pipe allocated for that
> process's stdin.  Generally this is solved by repeatedly writing to
> child_process.in between calls to start_command() and finish_command();
> run_processes_parallel() did not provide users an opportunity to access
> child_process at that time.

[snip]

> diff --git a/run-command.h b/run-command.h
> index 6472b38bde..e058c0e2c8 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -436,6 +436,20 @@ typedef int (*start_failure_fn)(struct strbuf *out,
>  				void *pp_cb,
>  				void *pp_task_cb);
>  
> +/**
> + * This callback is called repeatedly on every child process who requests
> + * start_command() to create a pipe by setting child_process.in < 0.
> + *
> + * pp_cb is the callback cookie as passed into run_processes_parallel, and
> + * pp_task_cb is the callback cookie as passed into get_next_task_fn.
> + * The contents of 'send' will be read into the pipe and passed to the pipe.
> + *
> + * Return nonzero to close the pipe.
> + */
> +typedef int (*feed_pipe_fn)(struct strbuf *pipe,
> +			    void *pp_cb,
> +			    void *pp_task_cb);
> +

As you mention above in the commit message, I think the clearest API to
support what we need is to just have a callback (that has access to
child_process) that is executed between process start and finish.

As it is, I think this callback is too specific in that it takes a
struct strbuf. I think that this struct strbuf will just end up being
unnecessary copying much of the time, when the user could have just
written to the fd directly.
