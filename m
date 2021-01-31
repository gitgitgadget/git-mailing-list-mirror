Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C03C433DB
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 03:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 441AE64E0A
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 03:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhAaDVF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 22:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhAaDVF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 22:21:05 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F021C061573
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 19:20:25 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id w4so8915780pgc.7
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 19:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=PzTyPfyNP39EZRwL1cImx7DjwrDKdL3JhUKDbDdTYVw=;
        b=DRiFntxr2i4/bgfiurMFyPdGyp74YSvYJFzjEbRGIiF9dlshS9neheNLnaCmijZSST
         w1CUuSQgrY7RJxuk0UciGRnrbspGKY0O31p3a83+0RHBNItc0wO83Cq4l1n1bb81YHgx
         09+Siou1bEGNPqEi/zb4D3KUVcL9tAkZ/eWCsHpnioeGkLQRt9KiTIZZR+MTTR/wRjsM
         Z27tZD/yGG8XnCMXeLZ2qb2rmDPWQOAwZj9KsegntnJ6pRBXNGJqUy0XbssKYbNSSyNr
         BQrAqAdfBNselHm+5J9+M3SA+GpdbGM5Vx3VMcIqJHR3uYgCfmdTXpx7S0KvFoq4swdR
         1jhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PzTyPfyNP39EZRwL1cImx7DjwrDKdL3JhUKDbDdTYVw=;
        b=FQxMWt1J/su4eRnJEHPqJSc4LpedzAuEqgrROzbQffh/0XhVOM4vMbeHIYpLBCgBEh
         zLtL+wL2bLb9LyY67ahn5ETWbhojM579Tn288XSQhJhuQl/CdqPAQDsfe+4r9KLBlBY8
         VvEyH84Iegrjekiol8qdRB3rffo5WP/+MIiSeWXWjR6YMROMRXtFDT5mLM/GwV89kFgS
         8Jo9eA950LrfKhhgD1cth4hJzbE5y5SqtNd667IvhmIal1/UJCvK+KcOmsNRAsc9OjHV
         KMbtJ6t6bS3Dr/SPzMn/xrak9OrbRZhRxIGcPrO0gk32LpKuyo5+ulvlg3IFqfddkCgq
         CY1A==
X-Gm-Message-State: AOAM533I2EOiI8XNKxkpkZrH2eH/8ZuqY2t9v7Q3VM/utqvu28hFXuMA
        ZfYiyMYSRuoUUrIL33xXM6GwT5LLRrXDI0qFVsNG
X-Google-Smtp-Source: ABdhPJz9LW/2gaaX8TxnRiCHxZKV12hwV7C/beBnJJ5QBHx5mMyGIgPDxJdz/iRdl4iowWcvqlKjYfwbZ8M/GdQvhrXW
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:5789:: with SMTP id
 g9mr876141pji.1.1612063224320; Sat, 30 Jan 2021 19:20:24 -0800 (PST)
Date:   Sat, 30 Jan 2021 19:20:22 -0800
In-Reply-To: <20201222000220.1491091-5-emilyshaffer@google.com>
Message-Id: <20210131032022.1018820-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201222000220.1491091-5-emilyshaffer@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: Re: [PATCH v7 04/17] hook: include hookdir hook in list
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Historically, hooks are declared by placing an executable into
> $GIT_DIR/hooks/$HOOKNAME (or $HOOKDIR/$HOOKNAME). Although hooks taken
> from the config are more featureful than hooks placed in the $HOOKDIR,
> those hooks should not stop working for users who already have them.

Maybe explicitly add that we're listing them in the list with a "hookdir:"
prefix.

> Legacy hooks should be run directly, not in shell. We know that they are
> a path to an executable, not a oneliner script - and running them
> directly takes care of path quoting concerns for us for free.

Not sure what this paragraph is doing here.

> diff --git a/builtin/hook.c b/builtin/hook.c
> index 4d36de52f8..a0013ae4d7 100644
> --- a/builtin/hook.c
> +++ b/builtin/hook.c
> @@ -16,6 +16,7 @@ static int list(int argc, const char **argv, const char *prefix)
>  	struct list_head *head, *pos;
>  	struct hook *item;
>  	struct strbuf hookname = STRBUF_INIT;
> +	struct strbuf hookdir_annotation = STRBUF_INIT;

Right now this is never set? Maybe hold off on adding this until we set
something.

> @@ -110,6 +113,18 @@ struct list_head* hook_list(const struct strbuf* hookname)
>  
>  	git_config(hook_config_lookup, (void*)&cb_data);
>  
> +	if (have_git_dir())
> +		legacy_hook_path = find_hook(hookname->buf);
> +
> +	/* Unconditionally add legacy hook, but annotate it. */
> +	if (legacy_hook_path) {
> +		struct hook *legacy_hook;
> +
> +		append_or_move_hook(hook_head, absolute_path(legacy_hook_path));

Both find_hook() and absolute_path() use static buffers to hold their
return values, which makes me a bit nervous. Perhaps put them all under
the same "if (have_git_dir())" so that it's clearer that we're not
supposed to insert code arbitrarily between their invocation and their
usage.

> diff --git a/hook.h b/hook.h
> index 8ffc4f14b6..5750634c83 100644
> --- a/hook.h
> +++ b/hook.h
> @@ -12,6 +12,7 @@ struct hook
>  	enum config_scope origin;
>  	/* The literal command to run. */
>  	struct strbuf command;
> +	int from_hookdir;

unsigned from_hookdir : 1?

The tests look good.
