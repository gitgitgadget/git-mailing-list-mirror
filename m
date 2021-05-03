Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0D2C433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 13:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7690B61363
	for <git@archiver.kernel.org>; Mon,  3 May 2021 13:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbhECOAf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 10:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbhECOAf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 10:00:35 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BD4C06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 06:59:41 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id e7so6360179edu.10
        for <git@vger.kernel.org>; Mon, 03 May 2021 06:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=SKLoextwve/jJh7Up2INM0DjWaC3j82SjYHWhPK2cKo=;
        b=ftuhPhCactmeU0uPf/gi4XNvYcJAY2Fn7fa1JTjb8ra3GEgLqCzEP8Omwe1xVd71dV
         yiOdUOfO06FAKHui95qNM59VfRjGgyxvoeSbpERixecfalfva9YjpYYw+8h/BTObrGqD
         lXDNOsH0UMtJAOFyj34R+WaD+F2XMm72oPgaP3VgFl6F4j5AfcdEiPIH5ETTpCy29WYo
         BkgWaIdipKRy7k+4RHepXGqDCDSceSr1wn158EGH0/kxWm4djqdQLoAgOB07JDO/VHpY
         dacZc8SSKEYQ4KWwUuI2sdfiCg6eOB7ArU5xRCjKxHVvx726VvUI4f2okDwUmBB9JA8o
         cA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=SKLoextwve/jJh7Up2INM0DjWaC3j82SjYHWhPK2cKo=;
        b=tRuhMRx1RDtWluFKAkxvdJ7AtxeuBvWx0Qn2n3YXXsW/AY6pg3J6HZHYhBAD1B6PA5
         kuPq0QDspgVb6oYyidVJqgs61a2EIqXqv8RdmmQkBRcGArmOTihSQZFuVrvleeQSODFB
         5s8Y+4fIa2KT4VohTufOKkx9QPyOjc/bNilIEnb+MhBUAROkrz+dbo+VZI9vofYnVYJz
         NHvE880zEcFrOavRa3GLXASRBzTGEMT1JFTufaRjWFeEmy1iNsyN8UmhKif0fCS2nLqE
         rN7hQOPQEwlbA1K7jhELTYk4uH8uu2bPkxKyp3JQ0E1yQj8A1gvL2stQnEQ3mkIZWFma
         /fsg==
X-Gm-Message-State: AOAM532gh77FfsRhvE1UqSnXi4mZIDDVON8ohh7P1z1kN+a/xwseLYnc
        0J35LPe9ZxsmJk0ljli7SY0=
X-Google-Smtp-Source: ABdhPJxse/LKYD4JslYRoBewsPJp97AfytH1thkLtWhHaNc8CClCPmZcYdTxV1C+fxfiaBpH5L5jtQ==
X-Received: by 2002:aa7:d3c2:: with SMTP id o2mr19887610edr.111.1620050379357;
        Mon, 03 May 2021 06:59:39 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n10sm11072054ejg.124.2021.05.03.06.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 06:59:38 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] fsmonitor: only enable it in non-bare repositories
Date:   Mon, 03 May 2021 15:58:48 +0200
References: <pull.942.git.1619682362363.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <pull.942.git.1619682362363.gitgitgadget@gmail.com>
Message-ID: <87mttbx6ie.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 29 2021, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The entire point of the FSMonitor is to monitor the worktree changes in
> a more efficient manner than `lstat()`ing all worktree files every time
> we refresh the index.
>
> But if there is no worktree, FSMonitor has nothing to monitor.
>
> So let's ignore if an FSMonitor is configured (e.g. in `~/.gitconfig`)
> and we're running in a repository without worktree.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     fsmonitor: only enable it in non-bare repositories
>     
>     Since I released Git for Windows v2.31.0, with brief interruption of two
>     weeks, I enabled the built-in FSMonitor via my user config, and today
>     was the first time I did anything in a bare repository. I was somewhat
>     surprised that FSMonitor gave me trouble there, as the FSMonitor does
>     not even make sense there...
>     
>     This patch applies on top of jh/rfc-builtin-fsmonitor (not because it
>     fixes a problem in the built-in FSMonitor, the bug existed for a long,
>     long time before those patches, but because it would otherwise cause
>     merge conflicts with that patch series).
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-942%2Fdscho%2Fbare-repositories-need-no-fsmonitor-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-942/dscho/bare-repositories-need-no-fsmonitor-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/942
>
>  config.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/config.c b/config.c
> index 53e7dedc60de..fc5e744d81ca 100644
> --- a/config.c
> +++ b/config.c
> @@ -2515,6 +2515,12 @@ int git_config_get_max_percent_split_change(void)
>  
>  int repo_config_get_fsmonitor(struct repository *r)
>  {
> +	if (!r->worktree) {
> +		/* FSMonitor makes no sense in bare repositories */
> +		core_fsmonitor = 0;
> +		return 1;
> +	}
> +
>  	if (r->settings.use_builtin_fsmonitor > 0) {
>  		core_fsmonitor = "(built-in daemon)";
>  		return 1;
>
> base-commit: 14d50074ff19e68e7a8d718b22d138882087bbc9

This is surely a correct fix for now, but wouldn't it in the future also
be useful to run it in bare repositories e.g. to be able cache lookups
for non-existing loose objects?
