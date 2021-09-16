Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF929C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 05:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88BE160E90
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 05:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbhIPFIS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 01:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbhIPFIR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 01:08:17 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF21C061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 22:06:57 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id n24so6394217ion.10
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 22:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jGg5nNrf7EiYtLQaDJxAXAfwrXI2JWoeDTnpDJmm0I8=;
        b=V9svdCwjHBZZ6ZvsrM8IJ3EfRmM6HjG3jt+wURgXnPRjhJqQnMLnW4/RI5BvU7ivJ8
         giaD6BpmkqPB7xccNuwq+IwiALMc+qlKc2mAoL8ksQTBv4pF0APlONGRkJNGTIPFD6DQ
         R5641aJ8/hYu8DtW3EBDTCJuMxok2NeM+zTsOWEeoybH4DrxY1B+Pdh0xxrT1GaaVl8A
         IKArE0HFYBd/o5OXRXstcjffyFscDPPo1OmocSw9uIVmdE5312A6qLWfP77RUTFT5+3G
         VyEIpi0EsVeTQY1uOFW6THIRKtpXfYBfgQk27T3o7TvUhUykLLS4v47PQFPKLORB+Lbw
         acrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jGg5nNrf7EiYtLQaDJxAXAfwrXI2JWoeDTnpDJmm0I8=;
        b=xgz1JAMi/hLN9W/JJE8P30RrZ/O30HEmA9dYaLvwQFMvlKTA2rYOCE0BfmKnpBfROd
         //BidCc57oSq50CNyDL8MequD4X3OxWYfkrNaAeWoFAuJVCWSvEMT3GEYIuy5An4pdVh
         IqDbN+beHspoxMEuOkuSyOwuVuV/WcdS6Ygi4z2aQqT+WtCP3qWqOl9ITFIOLcVdrTbQ
         pODgN1bd6s/jD8OLU2SyDMEqCpRePTYde3Gh4WHwb06ilpC24jl6NIwYZmb39iQwUTEv
         KF0UY7/dJ3MPUJf5iiJXt+yz5uDoW3GoZwnrAb0Pcz7w3Y9a5ySBeoWk4fvTA+99LHk4
         c6rQ==
X-Gm-Message-State: AOAM530xsZQ5m5rC0EP+8TISzcvZA6ymFRe1uRMyAcUqs6BxFYjO2PSd
        PcVeS0hShItDbUkfAHAAKsJWp0B7YupsubLk
X-Google-Smtp-Source: ABdhPJwihFjfoV44piS5ktO0Pjptg85xAjpdf3uUEcNaxV+HMB6DHr1mLK+ZgFOVBRd4JymiWf+zMA==
X-Received: by 2002:a6b:e90c:: with SMTP id u12mr2804567iof.95.1631768817267;
        Wed, 15 Sep 2021 22:06:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w18sm1107312ilg.13.2021.09.15.22.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 22:06:57 -0700 (PDT)
Date:   Thu, 16 Sep 2021 01:06:56 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 7/7] t/helper/simple-ipc: convert test-simple-ipc to use
 start_bg_command
Message-ID: <YULQ8DJFKlrOml8Z@nand.local>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <57f29feaadb4a732892cd193b2a1d3c838f09421.1631738177.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57f29feaadb4a732892cd193b2a1d3c838f09421.1631738177.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 15, 2021 at 08:36:17PM +0000, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Convert test helper to use `start_bg_command()` when spawning a server
> daemon in the background rather than blocks of platform-specific code.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  t/helper/test-simple-ipc.c | 193 ++++++++-----------------------------
>  1 file changed, 40 insertions(+), 153 deletions(-)
>
> diff --git a/t/helper/test-simple-ipc.c b/t/helper/test-simple-ipc.c
> index 91345180750..59a950f3b00 100644
> --- a/t/helper/test-simple-ipc.c
> +++ b/t/helper/test-simple-ipc.c
> @@ -9,6 +9,7 @@
>  #include "parse-options.h"
>  #include "thread-utils.h"
>  #include "strvec.h"
> +#include "run-command.h"
>
>  #ifndef SUPPORTS_SIMPLE_IPC
>  int cmd__simple_ipc(int argc, const char **argv)
> @@ -274,178 +275,64 @@ static int daemon__run_server(void)
>  	return ret;
>  }
>
> -#ifndef GIT_WINDOWS_NATIVE
> -/*
> - * This is adapted from `daemonize()`.  Use `fork()` to directly create and
> - * run the daemon in a child process.
> - */
> -static int spawn_server(pid_t *pid)
> -{
> -	struct ipc_server_opts opts = {
> -		.nr_threads = cl_args.nr_threads,
> -	};
> +static start_bg_wait_cb bg_wait_cb;

This whole patch is delightful to read, as the new implementation is so
much cleaner as a result of the earlier work in this series.

Am I correct in assuming that this is to encourage a compiler error if
bg_wait_cb does not satisfy the type of start_bg_wait_cb? If so, then I
think we are already getting that by trying to pass bg_wait_cb to
start_bg_command().

E.g., applying this (intentionally broken) diff on top:

--- 8< ---

diff --git a/t/helper/test-simple-ipc.c b/t/helper/test-simple-ipc.c
index 59a950f3b0..3aed787206 100644
--- a/t/helper/test-simple-ipc.c
+++ b/t/helper/test-simple-ipc.c
@@ -275,9 +275,7 @@ static int daemon__run_server(void)
 	return ret;
 }

-static start_bg_wait_cb bg_wait_cb;
-
-static int bg_wait_cb(void *cb_data, const struct child_process *cp)
+static int bg_wait_cb(const void *cb_data, const struct child_process *cp)
 {
 	int s = ipc_get_active_state(cl_args.path);

--- >8 ---

and then compiling still warns of a mismatched type when calling
start_bg_command().

> -	*pid = fork();
> -
> -	switch (*pid) {
> -	case 0:
> -		if (setsid() == -1)
> -			error_errno(_("setsid failed"));
> -		close(0);
> -		close(1);
> -		close(2);
> -		sanitize_stdfds();
> +static int bg_wait_cb(void *cb_data, const struct child_process *cp)
> +{
> +	int s = ipc_get_active_state(cl_args.path);
>
> -		return ipc_server_run(cl_args.path, &opts, test_app_cb,
> -				      (void*)&my_app_data);
> +	switch (s) {
> +	case IPC_STATE__LISTENING:
> +		/* child is "ready" */
> +		return 0;
>
> -	case -1:
> -		return error_errno(_("could not spawn daemon in the background"));
> +	case IPC_STATE__NOT_LISTENING:
> +	case IPC_STATE__PATH_NOT_FOUND:
> +		/* give child more time */
> +		return 1;
>
>  	default:

I'm always a little hesitant to have default cases when switch over enum
types, since it suppresses the warning when there's a new value of that
type. But we already have a similar default in client__probe_server().

> -		else if (pid_seen == pid_child) {
> -			/*
> -			 * The new child daemon process shutdown while
> -			 * it was starting up, so it is not listening
> -			 * on the socket.
> -			 *
> -			 * Try to ping the socket in the odd chance
> -			 * that another daemon started (or was already
> -			 * running) while our child was starting.
> -			 *
> -			 * Again, we don't care who services the socket.
> -			 */
> -			s = ipc_get_active_state(cl_args.path);
> -			if (s == IPC_STATE__LISTENING)
> -				return 0;
> +	default:

Ditto.

Thanks,
Taylor
