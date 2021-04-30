Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FA0C433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 13:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9463861434
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 13:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhD3N4Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 09:56:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57476 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhD3N4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 09:56:16 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 013C7C52A9;
        Fri, 30 Apr 2021 09:55:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=miVaoSUJPZDP1BMlQNaF0FUpzVM3Tf7IHQr9cFQvfTI=; b=SvcI
        osyO0eiirjqFCDcWcu4GeP6slolonxIy3iYax3/aIBJyaRjINGlRxBzAZZRIZIzp
        6c5JkgAxuf8DTUhng9PkktuGrhK/EwvX0sMQkvbbNvBZEr1dPn53yX0CEMvh91J5
        +X5b0ndpuJDARDVxcMHAFkqjZVoBYKxbrmhZoZg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED8D1C52A8;
        Fri, 30 Apr 2021 09:55:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 72E39C52A6;
        Fri, 30 Apr 2021 09:55:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] fsmonitor: only enable it in non-bare repositories
References: <pull.942.git.1619682362363.gitgitgadget@gmail.com>
Date:   Fri, 30 Apr 2021 22:55:26 +0900
Message-ID: <xmqq8s4zdghd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7F02544-A9BB-11EB-90CD-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

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

Use NULL instead of integer 0 to mollify SP.


> +		return 1;
> +	}
> +
>  	if (r->settings.use_builtin_fsmonitor > 0) {
>  		core_fsmonitor = "(built-in daemon)";
>  		return 1;
>
> base-commit: 14d50074ff19e68e7a8d718b22d138882087bbc9
