Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB1DC4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 18:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbiLBSQb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 13:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbiLBSQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 13:16:28 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E583E8E1A
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 10:16:22 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id o13so13412070ejm.1
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 10:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IAUuOnfxnBrquJ9Kyink9J0c2vHNxRpAqxmI3clHCR0=;
        b=gp2Xr9c65o+dwgR4DDkEmA3tsPJFLuXkUl/9sL9sRrIiy3aVB057vM9cmuQ4yc+JdL
         DTEX3nLtB8oZOK6cQjPgOKHabq1gc4SAL2GoEQ6JCf+1FLXDJv1dRo2HhIXmgg7DtGL+
         2wGsWCeX6DQIDWcxPxbkPQVOoyOH682ESyWBscLPAKuI6UhgEw2ULqagQF0pY6IvdtZO
         u2rhC20aGjZ9rUHnw3LC5faDHdu9V/cSXqHCFlrK7BSQp0vLuW9Ynj6cg9I4mgk/QVzI
         OgkAkkp/VqF3V96jlYXtHUYpNDhaDqm+RZZGA0qDAQGa1mZNZpu9P+vgV0YHGdgJ8KqG
         mvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAUuOnfxnBrquJ9Kyink9J0c2vHNxRpAqxmI3clHCR0=;
        b=uq1FnWiagDo65MvKR6R4XfoS1FVpyglu3zcxkImMOpp+4pX7JhX/OstegMfbnpdip4
         ooDT+1pblY/FsOSABi88N092TvvQsYaBI2sKrKp9SGqiLtKgRq5FBxx8pbN8qyJQCrYy
         ehDyZmG1QLremTNINFsYnXFLYuZVuu7CZsYHKHZxRF+6hVFxizYEbL/TEqMyYmhtsHYt
         +flvJuMvyiIV8lGecs+L5HyeDpwLE3OQ79zfTLgeYKZF6BG20LZwkWq61HwE8EFX8NnR
         SndiGeiiIufjdgnwz6+C+gty9oMbtmi1ONBt5f2752j/21pDeIwg5x1VqNPlcTUiHh9A
         0IBQ==
X-Gm-Message-State: ANoB5pl6HsCs5LJRIN/G2d5U4a6TcfcfwZOhFeRIi7sU6IKtjWnd2FaO
        Gu5jtSlZPb9qJg9+MmjB69xf0grzuxg0BQ==
X-Google-Smtp-Source: AA0mqf5qBJmm1zlxU889YLhN989j19GIXI+3JLhGQCGKJQK7GHputxv3jC2Qx3ifjbFv6DyWligGGA==
X-Received: by 2002:a17:907:8b06:b0:7c0:8e3a:9a54 with SMTP id sz6-20020a1709078b0600b007c08e3a9a54mr14354518ejc.619.1670004980548;
        Fri, 02 Dec 2022 10:16:20 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id ky20-20020a170907779400b007c0ac4e6b6esm2447366ejc.143.2022.12.02.10.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 10:16:19 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p1AaB-002nxp-00;
        Fri, 02 Dec 2022 19:16:19 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Rose via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Seija <doremylover123@gmail.com>
Subject: Re: [PATCH] maintenance: compare output of pthread functions for
 inequality with 0
Date:   Fri, 02 Dec 2022 19:10:57 +0100
References: <pull.1389.git.git.1670000578395.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <pull.1389.git.git.1670000578395.gitgitgadget@gmail.com>
Message-ID: <221202.86k039fz7x.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 02 2022, Rose via GitGitGadget wrote:

> From: Seija <doremylover123@gmail.com>
>
> The documentation for pthread_create and pthread_sigmask state that:
>
> "On success, pthread_create() returns 0;
> on error, it returns an error number"
>
> As such, we ought to check for an error
> by seeing if the output is not 0.
>
> Checking for "less than" is a mistake
> as the error code numbers can be greater than 0.
>
> Signed-off-by: Seija <doremylover123@gmail.com>
> ---
>     maintenance: compare output of pthread functions for inequality with 0
>     
>     The documentation for pthread_create and pthread_sigmask state that "On
>     success, pthread_create() returns 0; on error, it returns an error
>     number, and the contents of *thread are undefined."
>     
>     As such, we ought to check for an error by seeing if the output is not
>     0, rather than being less than 0, since nothing stops these functions
>     from returning a positive number.
>     
>     Signed-off by: Seija doremylover123@gmail.com
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1389%2FAtariDreams%2Faddress-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1389/AtariDreams/address-v1
> Pull-Request: https://github.com/git/git/pull/1389
>
>  builtin/fsmonitor--daemon.c | 4 ++--
>  run-command.c               | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
> index 6f30a4f93a7..52a08bb3b57 100644
> --- a/builtin/fsmonitor--daemon.c
> +++ b/builtin/fsmonitor--daemon.c
> @@ -1209,7 +1209,7 @@ static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
>  	 * events.
>  	 */
>  	if (pthread_create(&state->listener_thread, NULL,
> -			   fsm_listen__thread_proc, state) < 0) {
> +			   fsm_listen__thread_proc, state)) {
>  		ipc_server_stop_async(state->ipc_server_data);
>  		err = error(_("could not start fsmonitor listener thread"));
>  		goto cleanup;
> @@ -1220,7 +1220,7 @@ static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
>  	 * Start the health thread to watch over our process.
>  	 */
>  	if (pthread_create(&state->health_thread, NULL,
> -			   fsm_health__thread_proc, state) < 0) {
> +			   fsm_health__thread_proc, state)) {
>  		ipc_server_stop_async(state->ipc_server_data);
>  		err = error(_("could not start fsmonitor health thread"));
>  		goto cleanup;
> diff --git a/run-command.c b/run-command.c
> index 48b9ba6d6f0..756f1839aab 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1019,7 +1019,7 @@ static void *run_thread(void *data)
>  		sigset_t mask;
>  		sigemptyset(&mask);
>  		sigaddset(&mask, SIGPIPE);
> -		if (pthread_sigmask(SIG_BLOCK, &mask, NULL) < 0) {
> +		if (pthread_sigmask(SIG_BLOCK, &mask, NULL)) {
>  			ret = error("unable to block SIGPIPE in async thread");
>  			return (void *)ret;
>  		}
>
> base-commit: 805265fcf7a737664a8321aaf4a0587b78435184

This looks good to me, and skimming through the rest of the
pthread_create() it seems the rest of the code in-tree is correct.

But (and especially if you're interested) we really should follow-up
here and fix the "error()" etc. part of this. After this we have cases
in-tree where we on failure:

 * Call die_errno() (good)
 * Call die(), error() etc., but with a manual strerror() argument,
   these should just use the *_errno() helper.
 * Don't report on the errno at all, e.g. in this case shown here.

It seems to me that all of these should be using die_errno(),
error_errno() etc.

Or maybe it's the other way around, and we should not rely on the global
"errno", but always capture the return value, and give that to
strerror() (or set "errno = ret", and call {die,error,warning}_errno()).

In any case, some low-hanging #leftoverbits there...

