Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69417C433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 14:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2876E61157
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 14:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbhDZO5f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 10:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbhDZO5b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 10:57:31 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115A9C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 07:56:50 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 3so2553767qvp.6
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 07:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E5Pt6W8UWyFte+uOOytG+rsAE8dIMWNqkKu1kbo/fhI=;
        b=qYQllJ1lLvIOvReG7FPca2hGo3xjZhN/xi0xTct+EyZiB8LwasBj/i/BnIgW+g55bm
         w3nbiuiChWtz6s6EtTCKPLxGS0LPNIuXqYjKtvKw29puPxvtHC/u2hRocFZn37QT/FfG
         TYDKX38KoUY9HVKjmlRJSzPQ27wmxmn6SkmDsZYOyIh5RzdhP4k38A+b5NmJAZ6w/L+J
         8Bs8e+Oh5FSHfFWta+12Q++4T3QEMivGho0TQl7hllYsq2MEaNtrZvUnAASX77DFXD0e
         EvEThBYxAeKxi9yyMZF6yQKA11Do40hhAVw4l2Gjxybkn5gCI++n3dLdUo2qquKZYrpK
         /jbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E5Pt6W8UWyFte+uOOytG+rsAE8dIMWNqkKu1kbo/fhI=;
        b=Q9ImPvm9ryP9diYXw6zlpMjAEDFmcv9tDiu5OBw79sqSHYFNkUFyF3CmvL6TZpEPmR
         5iwAB0AvVW197fFv94EBpdr9uqlojQuA1awOenscW6vpIXDCuQNcl2/rNmmAvnZAis02
         9q2bDvE0NVi0SYw4RR/3uLIOcscGN4HP2RXGXE/lkLr1DzYMtO4CRJUkao91nMWzjCx6
         d7VT/rLy8vwnOJQV3ZH5AWlp/orQOIA4q0r9JnLSWR/o8YzIP1aXxuFhPrxS5LHER76o
         CnYXz7snY2JXdI0/ihHZlLj2M4so0V0gCzckv3sCpgGh3hZu2RkV9lF2c09xvzXIjJmw
         P4Dw==
X-Gm-Message-State: AOAM532qgbg+D3K1m7DEGKTCh3LPPvrbVNSNQuuWi1y/g1nCLTwCGx01
        qwi8tw7XhnaRP6FPQqBGyCw=
X-Google-Smtp-Source: ABdhPJwYL0x1Fnc7XqqTsh9LGzl3BmkBsDGHoRFztioLvhUWt6ir1zRY/dbqv1At3Eo0k5k4lklQXw==
X-Received: by 2002:ad4:4f2a:: with SMTP id fc10mr11467787qvb.51.1619449009202;
        Mon, 26 Apr 2021 07:56:49 -0700 (PDT)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:bc73:cea4:3f85:d407])
        by smtp.gmail.com with ESMTPSA id e28sm6055434qtg.24.2021.04.26.07.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 07:56:48 -0700 (PDT)
Subject: Re: [PATCH 04/23] fsmonitor: introduce `core.useBuiltinFSMonitor` to
 call the daemon via IPC
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <7082528d8f7c1afa33e1146e3d274e044735f6a1.1617291666.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f77457d0-925d-2ea1-4ad4-b3315532b37f@gmail.com>
Date:   Mon, 26 Apr 2021 10:56:47 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <7082528d8f7c1afa33e1146e3d274e044735f6a1.1617291666.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/21 11:40 AM, Johannes Schindelin via GitGitGadget wrote:> @@ -2515,6 +2515,11 @@ int git_config_get_max_percent_split_change(void)
>  
>  int repo_config_get_fsmonitor(struct repository *r)
>  {
> +	if (r->settings.use_builtin_fsmonitor > 0) {

Don't forget to run prepare_repo_settings(r) first.

> +		core_fsmonitor = "(built-in daemon)";
> +		return 1;
> +	}
> +

I found this odd, assigning a string to core_fsmonitor that
would definitely cause a problem trying to execute it as a
hook. I wondered the need for it at all, but found that
there are several places in the FS Monitor subsystem that use
core_fsmonitor as if it was a boolean, indicating whether or
not the feature is enabled at all.

A cleaner way to handle this would be to hide the data behind
a helper method, say "fsmonitor_enabled()" that could then
check a value on the repository (or index) and store the hook
value as a separate value that is only used by the hook-based
implementation.

It's probably a good idea to do that cleanup now, before we
find on accident that we missed a gap and start trying to run
this bogus string as a hook invocation.
> -static int query_fsmonitor(int version, const char *last_update, struct strbuf *query_result)
> +static int query_fsmonitor(int version, struct index_state *istate, struct strbuf *query_result)
>  {
> +	struct repository *r = istate->repo ? istate->repo : the_repository;
> +	const char *last_update = istate->fsmonitor_last_update;
>  	struct child_process cp = CHILD_PROCESS_INIT;
>  	int result;
>  
>  	if (!core_fsmonitor)
>  		return -1;

Here is an example of it being used as a boolean.

> +	if (r->settings.use_builtin_fsmonitor > 0) {
> +#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
> +		return fsmonitor_ipc__send_query(last_update, query_result);
> +#else
> +		/* Fake a trivial response. */
> +		warning(_("fsmonitor--daemon unavailable; falling back"));
> +		strbuf_add(query_result, "/", 2);
> +		return 0;
> +#endif

This seems like a case where the helper fsmonitor_ipc__is_supported()
could be used instead of compile-time macros.

(I think this is especially true when we consider the future of the
feature on Linux and the possibility of the same compiled code needing
to check run-time properties of the platform for compatibility.)

> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -58,6 +58,9 @@ void prepare_repo_settings(struct repository *r)
>  		r->settings.core_multi_pack_index = value;
>  	UPDATE_DEFAULT_BOOL(r->settings.core_multi_pack_index, 1);
>  
> +	if (!repo_config_get_bool(r, "core.usebuiltinfsmonitor", &value) && value)
> +		r->settings.use_builtin_fsmonitor = 1;
> +

Follows the patterns of repo settings. Good.

