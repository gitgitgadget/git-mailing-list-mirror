Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBFBC43461
	for <git@archiver.kernel.org>; Mon, 10 May 2021 12:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99CE961574
	for <git@archiver.kernel.org>; Mon, 10 May 2021 12:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239699AbhEJMwJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 08:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244464AbhEJL7J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 07:59:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F398C061763
        for <git@vger.kernel.org>; Mon, 10 May 2021 04:56:48 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id j26so14692382edf.9
        for <git@vger.kernel.org>; Mon, 10 May 2021 04:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=wZlFa1w58DAyJw1K9PfEpDxtkGXpeOs53lDOrFQMRS0=;
        b=Vl6DinC4iWDFxjSxqh2bkW/4CeLc6czBRvQGGGzPctYMpb3QMxRiKDYQ2wMCUuNSXZ
         j5rMtKcwFcM3H3ZMwaS3e3GyV547jzS17Bki0NSeiIz1jjYFtws0FSoBO55lJbkZJxRn
         1Fz8sgwU4C5xo+hFdxPSUGKttVuOgeVb+PSIsjdeGrcTBxmR3GZs8VTxgXu2dEp8+n4F
         +P5GETYSyra7RalV81UNaIoHZvMOlHCkgSiYru1z+6v3DvcS6ypW/0BTbZe2nin8UF1F
         HSVJi1PeicNzxZ9gCUfxpIDNhCmjb5RCVdmDbC3qK+n5vBz9tcq2pM+Z5UdvQl11laZW
         pCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=wZlFa1w58DAyJw1K9PfEpDxtkGXpeOs53lDOrFQMRS0=;
        b=V07kJh6aEPUFzpAK3d4eNOw6GOvFNh7m+gO94LNh6Ti9mD/UKeI2pmD5cRDLeHNqye
         +WJ6xZhAzzs/Kbyr27L60Jj9WckI06rx7DvI+zFaE63YLn+99yc6iRHKV3EOEdj7JMFn
         1rmSmQgdWpeD1lyMCzBPK99VzGxonaZ/jiu/WpXPEk3+WDEXIfHE0WY1erBA6PTfrBpp
         jLu9bepDYvo2t/9ybgdXN9e3okEGizq7Pe9UpPaI/qMEJ5HhTzixHtJwppzNxkttGEvK
         FuBz1sh5SlNsNirjkaAEdeANBY1yxrDJp6RR6S0eTkuwbqbjlnWbIIPhlFETQfuXJbVW
         qX9A==
X-Gm-Message-State: AOAM531szLYwWuxZaVO4Xg1JlNiAlo1y5vbuqzxPY98jWPV2v9slCsPV
        2yMwSywGwkV6JE/w7Y4fUyQ=
X-Google-Smtp-Source: ABdhPJxKkmW/L3NMamPrdFfqDFTZ17tBD9WDDucniRmfPzc7QXFcpE+Z7AhjIFgnM10ACTqoIx5DxQ==
X-Received: by 2002:a05:6402:3553:: with SMTP id f19mr28379060edd.167.1620647806826;
        Mon, 10 May 2021 04:56:46 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id c25sm11264883edt.43.2021.05.10.04.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 04:56:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     lilinchao@oschina.cn
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH] builtin/gc: warn when core.commitGraph is disabled
Date:   Mon, 10 May 2021 13:55:53 +0200
References: <510425b8b17411eb93770026b95c99cc@oschina.cn>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <510425b8b17411eb93770026b95c99cc@oschina.cn>
Message-ID: <87tunau7ia.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 10 2021, lilinchao@oschina.cn wrote:

> From: Li Linchao <lilinchao@oschina.cn>
>
> Throw warning message when core.commitGraph is disabled in commit-graph
> maintenance task.

Won't this cause the gc.log issue noted in
https://lore.kernel.org/git/87r1l27rae.fsf@evledraar.gmail.com/

More importantly, I don't think this UX makes sense. We said we didn't
want it, so why warn about it?

Maybe there are good reasons to, but this commit message / patch doesn't
make the case for it...


> Signed-off-by: Li Linchao <lilinchao@oschina.cn>
> ---
>  builtin/gc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 98a803196b..90684ca3b3 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -861,8 +861,10 @@ static int run_write_commit_graph(struct maintenance_run_opts *opts)
>  static int maintenance_task_commit_graph(struct maintenance_run_opts *opts)
>  {
>  	prepare_repo_settings(the_repository);
> -	if (!the_repository->settings.core_commit_graph)
> +	if (!the_repository->settings.core_commit_graph) {
> +		warning(_("skipping commit-graph task because core.commitGraph is disabled"));
>  		return 0;
> +	}
>  
>  	close_object_store(the_repository->objects);
>  	if (run_write_commit_graph(opts)) {

