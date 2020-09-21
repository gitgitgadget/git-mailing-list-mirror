Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DBFC43465
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 13:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DDDB2084C
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 13:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7MEQ7Ee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgIUNgG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 09:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgIUNgF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 09:36:05 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ECAC061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 06:36:05 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id z23so17690667ejr.13
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 06:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=TpeU02oEQnlDBT0J2ZmnbyRHAjbbYYtzH9QTZP+7kdI=;
        b=E7MEQ7Eeq57dugtQIlVVAKp8mD/rnXgeQKTnRY39HZwDBfEp9N/XuIrgxuwIYQbl7T
         Nza42GQqCgvZ3Wqjkn/QeNA+jXB5YZlMP1voHF2gFVjkjbKL1EVFsFZ9TgadgU14hPQp
         pkNjHL0zTxqcOo7A/7XF+TeWZCexmwcfoud7qhtN+iP1rWcFs5JAnS5l8fG1KZWmO2QQ
         e4bNPPCDyCsWTg0ym6jHLK91gLAHWAdVLYYCPg8bC4zEvz8Dn/lMIff31DlhNbkuGK5v
         VDB+E9tAWHy9yTkAvut+n30pNXL5ax7KOCsBwnsMvaqIWEiw130T3M9dL87L/xbkckbn
         QGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=TpeU02oEQnlDBT0J2ZmnbyRHAjbbYYtzH9QTZP+7kdI=;
        b=eM4F19Hx7CAOLTv5nO+8tKrFpadhLwKQXEpKnqHA7G40l/83YSTRwAQ6dMgXT35xdv
         CGpJG6NhHksEKdHgHJ2YT9B05q6UN7A3ZrRAj3nDG0pTwMNfnmVr3gTkhHZE/6djZDue
         0iLYtHGGx4KrcgrXUsiSH3kz+6S+mbgHqGK+j5nEZGOBhRlJUsWuANLpWfDrZtJC/J4D
         8NHju9rIQRNyY07TqsxxN01BRT4/CebfsPkqwCF612Xa+Vqv2US3FU2QcSyc9GBI+9RG
         VSmp97U+b9mLQaHojTX/6U3h/xLCAVjqF+t0YqrvDDhFKEURoVxpyozo8VKRtAI5xn6d
         Ve7A==
X-Gm-Message-State: AOAM531Q3g7dlOIfSWawjmTg6TySIMkvhYQnJG8VeDH00fXiW9ZdJ/CT
        wvD5IAfovDZ/nAzukeE0iJc=
X-Google-Smtp-Source: ABdhPJwrl5pWPWx003ZQzG7SnzFthxj6Cp2CqBTF6ebW/igLe+HqAduVIC5cAxxeT/FjxTqSSSTRUg==
X-Received: by 2002:a17:906:724b:: with SMTP id n11mr50488904ejk.328.1600695364045;
        Mon, 21 Sep 2020 06:36:04 -0700 (PDT)
Received: from evledraar (dhcp-077-248-252-018.chello.nl. [77.248.252.18])
        by smtp.gmail.com with ESMTPSA id t4sm8889984ejj.6.2020.09.21.06.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 06:36:03 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v5 07/11] maintenance: take a lock on the objects directory
References: <pull.695.v4.git.1599224956.gitgitgadget@gmail.com> <pull.695.v5.git.1600366313.gitgitgadget@gmail.com> <1a0a3eebb825ac3eabfdd86f82ed7ef6abb454c5.1600366313.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <1a0a3eebb825ac3eabfdd86f82ed7ef6abb454c5.1600366313.git.gitgitgadget@gmail.com>
Date:   Mon, 21 Sep 2020 15:36:02 +0200
Message-ID: <87d02fi75p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 17 2020, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Performing maintenance on a Git repository involves writing data to the
> .git directory, which is not safe to do with multiple writers attempting
> the same operation. Ensure that only one 'git maintenance' process is
> running at a time by holding a file-based lock. Simply the presence of
> the .git/maintenance.lock file will prevent future maintenance. This
> lock is never committed, since it does not represent meaningful data.
> Instead, it is only a placeholder.
>
> If the lock file already exists, then no maintenance tasks are
> attempted. This will become very important later when we implement the
> 'prefetch' task, as this is our stop-gap from creating a recursive process
> loop between 'git fetch' and 'git maintenance run --auto'.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/gc.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 00fff59bdb..7ba9c6f7c9 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -798,6 +798,25 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts)
>  {
>  	int i, found_selected = 0;
>  	int result = 0;
> +	struct lock_file lk;
> +	struct repository *r = the_repository;
> +	char *lock_path = xstrfmt("%s/maintenance", r->objects->odb->path);
> +
> +	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0) {
> +		/*
> +		 * Another maintenance command is running.
> +		 *
> +		 * If --auto was provided, then it is likely due to a
> +		 * recursive process stack. Do not report an error in
> +		 * that case.
> +		 */
> +		if (!opts->auto_flag && !opts->quiet)
> +			warning(_("lock file '%s' exists, skipping maintenance"),
> +				lock_path);
> +		free(lock_path);
> +		return 0;
> +	}
> +	free(lock_path);
>  
>  	for (i = 0; !found_selected && i < TASK__COUNT; i++)
>  		found_selected = tasks[i].selected_order >= 0;

There's now two different lock strategies in builtin/gc.c, the existing
one introduced in 64a99eb476 ("gc: reject if another gc is running,
unless --force is given", 2013-08-08) where we write the hostname to the
gc.pid file, and then discard the lockfile depending on a heuristic of
whether or not it's the same etc., and this one.

With this as an entry point we'll entirely do away with the old one
since we don't use the "gc --auto" entry point.

All of that may or may not be desirable, but I think a description in
the docs & tests for how these lock files should interact would be
helpful. E.g. writing a different hostname in the gc lockfile and
setting the time on it with with "test-tool chmtime" will cause it to
plow ahead, but doing the same for "git maintenance" will stop it in its
tracks no matter the time or content.
