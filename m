Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87274C07E95
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 08:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68A4F61357
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 08:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238546AbhGPJAB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 05:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237433AbhGPJAA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 05:00:00 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8031C06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 01:57:04 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id qb4so14012229ejc.11
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 01:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=GYJQ+XD4kiZdK9s9cNP5vVSWkP7OubBWvL28vnTxwbs=;
        b=Yj+Eng1ZuocuM1jZyE2ir9IY+yGMc+e5WwNIiKSdiEZjXjYKvYCwzfrxN+14ZRwoD9
         B33quC9l5RGNr7E+N5aIxALTTjH0Ot1KRSql7+jbDxe2b/d/bjCVDXGXcWCp6jHYeaFG
         ppp8VAC3qu5z4B4CyVGZZVv/G+UuUS+Dsbabz7ujVsTqxTqYflhwn9EKu/4iyVlFEhLC
         KK1C+pYYI6tf4Qv6KTOFNpbymNUMAD3Q0ka5rto1HNEbqE+JzHj8Aoo+ZfMt6j1ibpd0
         BjY0i9EXmPeUnAcbLNU4yrqsmnLx4pE1ksY5fYr2BA/Jzh7HNu4c+U/nSoXdvJCNmU2v
         kmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=GYJQ+XD4kiZdK9s9cNP5vVSWkP7OubBWvL28vnTxwbs=;
        b=VOecbVW73F53az8oTVLEQQTatXogg6gTiuNggRrgUiC+SoBVIUoAHrhoRYlELMM9zR
         HGRKv2RRqPzH3AxIEtYCr7SzhiBn/bcrtrFXDPfwR89+5g5o+0p8o84U1ikIzvtQQE1Q
         9FzrA0T9tIPHyBLqYL+tkQv5lMknqH8LHWlpUG5Wh6C8ILg83JFcJ8FiViZ2/GGmpwVl
         oBKtU1VKzeUbtCenosQg8ngN9CKVTejfiIGVXigUyCGI8W7lhwXzSse4S60Yb3krGP5q
         srGY6tK5cXN6DWCMqfBGXKQrAex3KRfYD5NwCpcXY+796QOPrW4SL+EDjcLQwZU4iKAU
         i/Dw==
X-Gm-Message-State: AOAM531GZQOPAdM9rIlZCPoYbXrrx6vQfYqI59LMJoWXgbU54b7KLe3K
        79YqrN+1L7x3qPFTrWa1Rtw=
X-Google-Smtp-Source: ABdhPJxmxjtxyxfg0vsAyb1Xdn8H5ZpoyNcXzFFHi1ACroVTdE40AT1T+GVwUXyPBvsXpcb4bk0ZlQ==
X-Received: by 2002:a17:907:3f9e:: with SMTP id hr30mr10628293ejc.361.1626425823257;
        Fri, 16 Jul 2021 01:57:03 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id y17sm2682249ejd.16.2021.07.16.01.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 01:57:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/9] hook: introduce "git hook list"
Date:   Fri, 16 Jul 2021 10:52:27 +0200
References: <20210715232603.3415111-1-emilyshaffer@google.com>
 <20210715232603.3415111-4-emilyshaffer@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210715232603.3415111-4-emilyshaffer@google.com>
Message-ID: <87o8b2y6u1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 15 2021, Emily Shaffer wrote:

>  static const char * const builtin_hook_usage[] = {
>  	N_("git hook <command> [...]"),
> +	N_("git hook list <hookname>"),
>  	N_("git hook run [<args>] <hook-name> [-- <hook-args>]"),
>  	NULL

Uses <hook-name> already, let's use that too. I can't remember if it's
something I changed myself, or if your original version used both and I
picked one for consistency, or...

Anyway, I can re-roll the base topic or whatever, but let's have the end
result use one or the other.

> +	if (argc < 1) {
> +		usage_msg_opt(_("You must specify a hook event name to list."),
> +			      builtin_hook_usage, list_options);
> +	}

{} braces not needed.


> +	if (!strcmp(argv[0], "list"))
> +		return list(argc, argv, prefix);
>  	if (!strcmp(argv[0], "run"))

This should be "else if" now.

(Doesn't matter for code execution, just IMO readability, but I'll leave
that to you ... :)

>  		return run(argc, argv, prefix);
>  	else
> diff --git a/hook.c b/hook.c
> index 935751fa6c..19138a8290 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -104,22 +104,20 @@ int hook_exists(const char *name)
>  struct list_head* hook_list(const char* hookname)
>  {
>  	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
> +	const char *hook_path = find_hook(hookname);
> +
>  
>  	INIT_LIST_HEAD(hook_head);
>  
>  	if (!hookname)
>  		return NULL;
>  
> -	if (have_git_dir()) {
> -		const char *hook_path = find_hook(hookname);
> -
> -		/* Add the hook from the hookdir */
> -		if (hook_path) {
> -			struct hook *to_add = xmalloc(sizeof(*to_add));
> -			to_add->hook_path = hook_path;
> -			to_add->feed_pipe_cb_data = NULL;
> -			list_add_tail(&to_add->list, hook_head);
> -		}
> +	/* Add the hook from the hookdir */
> +	if (hook_path) {
> +		struct hook *to_add = xmalloc(sizeof(*to_add));
> +		to_add->hook_path = hook_path;
> +		to_add->feed_pipe_cb_data = NULL;
> +		list_add_tail(&to_add->list, hook_head);

Maybe we should have a INIT for "struct hook" too? This also needlessly
leaves behind an un-free'd hook struct in a way that it wouldn't if we
just had this on the stack, no?
