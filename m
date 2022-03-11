Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E124BC433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 01:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240895AbiCKBkf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 20:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbiCKBke (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 20:40:34 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719FD1A2758
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 17:39:32 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id x5so9143622edd.11
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 17:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=hG8ptM+A8BiloePTSaPO51M6vXs5/cU0/MoXoKZbMjM=;
        b=BpoLyegfRs2wDEle5eLKIcYIFhA0X1omonICqpapsFZuTCab7JnZ9kIA0JU3VIjGEp
         CUaU7GghlfgiU3qbrsX52MtfAd1g71Rw9wV345lDMXbLutL8RdKurcDx1JGx4PDE4h4v
         8HiFKLezCqGoJV06j/HLwo4byafCBWArB/YFVgMcNdjoVRSqgMS17+deDNPxbR8RfrTW
         7rSO1qRJzh9quYU2pRB4jgE49bjqbX3SHFVCaaXz1KpUJQCXgjEt1yfngZOVWMRXyE2B
         +6QJ9v6dK0utYMPKZU/oLcCtF08dmz0to3ozWEujXdAxfNbHnRzX5NHSclLfhmtSLyHB
         I1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=hG8ptM+A8BiloePTSaPO51M6vXs5/cU0/MoXoKZbMjM=;
        b=xCfEh9kwEGjnycmcAA89TOWbXXxGEkSysfNhW6hJ0pYQ4kvo+bhpGEUC8lA70FNNO2
         CUKOrvPJhad9lm0ZV+sLOeWcIZ2zaL0HngC+03me7/jueVhd/sm9TvYj9dArcbz5vs07
         /DBXa7vqdJ6oek5D5RBQPt9SxU+tyswMlyRZqKJ1IRwWpvFSXjTHnicUT9Iapz6btddV
         Ui83VgPIjumH3+rfdUI2qwG4wmfw4RmxE3oO5yQ3w74mOdocV53YptotaBiKqvVEI9Hb
         dVQEP7X522XzE1AHHqiUFjojH4/TqdzupSFNTHGer3jc9FPkmQgt69RnQKprfTKMl+w8
         4Axg==
X-Gm-Message-State: AOAM532j/WAQjYzg26S/Jzon6qgWDGe9Ukehz0H0pEOQLuWpi6AAsKcv
        KVmn/KmzEx2uKunWGaR7cew=
X-Google-Smtp-Source: ABdhPJy+p39+NeTvvR6RDLYniNZTqhGu3DpMwfePpGQQij6LPu4GSb5mztoiJawwiStbbIcb6x4oxA==
X-Received: by 2002:a05:6402:1bc8:b0:416:2375:f815 with SMTP id ch8-20020a0564021bc800b004162375f815mr6945818edb.130.1646962770710;
        Thu, 10 Mar 2022 17:39:30 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id sb31-20020a1709076d9f00b006ceb969822esm2378154ejc.76.2022.03.10.17.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 17:39:30 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nSUFc-000qS0-Pn;
        Fri, 11 Mar 2022 02:39:28 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 04/27] fsmonitor-settings: bare repos are
 incompatible with FSMonitor
Date:   Fri, 11 Mar 2022 02:31:00 +0100
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
 <8c4f90ae4fd5d9fbac9acb9307ee82ceffc7df08.1646777727.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <8c4f90ae4fd5d9fbac9acb9307ee82ceffc7df08.1646777727.git.gitgitgadget@gmail.com>
Message-ID: <220311.86k0d1i7xr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 08 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> [...]
> +	prepare_repo_settings(the_repository);
> +	fsm_settings__set_ipc(the_repository);
> +
> +	if (fsm_settings__get_mode(the_repository) == FSMONITOR_MODE_INCOMPATIBLE) {
> +		const char *msg = fsm_settings__get_reason_msg(the_repository);
> +
> +		return error("%s '%s'", msg ? msg : "???", xgetcwd());
> +	}
> +
>  	if (!strcmp(subcmd, "start"))
>  		return !!try_to_start_background_daemon();
>  
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index d335f1ac72a..8f460e7195f 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -1237,6 +1237,13 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  
>  	if (fsmonitor > 0) {
>  		enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
> +
> +		if (fsm_mode == FSMONITOR_MODE_INCOMPATIBLE) {
> +			const char *msg = fsm_settings__get_reason_msg(r);
> +
> +			return error("%s '%s'", msg ? msg : "???", xgetcwd());
> +		}
> +
>  		if (fsm_mode == FSMONITOR_MODE_DISABLED) {
>  			advise(_("core.fsmonitor is unset; "
>  				 "set it if you really want to "

Can w assert somewhere earlier that ->mode can't be
FSMONITOR_MODE_INCOMPATIBLE at the same time that ->reason ==
FSMONITOR_REASON_OK, should that ever happen?

Then we can get rid of the "???" case here.

The "%s '%s'" here should really be marked for translation, but just
"some reason '$path'" is a pretty confusing message. This will emit
e.g.:

    "bare repos are incompatible with fsmonitor '/some/path/to/repo'"

Since we always hand these to error maybe have the helper do e.g.:

    error(_("bare repository '%s' is incompatible with fsmonitor"), path);

I find the second-guessing in fsmonitor-settings.c really hard to
follow, i.e. how seemingly every function has some "not loaded yet? load
it" instead of a more typical "init it", "use it", "free it"
pattern. Including stuff like this:
	
	enum fsmonitor_mode fsm_settings__get_mode(struct repository *r)
	{
	        if (!r)
	                r = the_repository;

But anyway, seeing as we do try really hard to load the_repository (or a
repository) can't we use the_repository->gitdir etc. here instead of
xgetcwd(), or the_repository->worktree when non-bare?
