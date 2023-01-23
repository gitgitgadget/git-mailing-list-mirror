Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB4AC05027
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 23:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjAWXK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 18:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjAWXKY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 18:10:24 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5B493
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 15:10:24 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id o13so13146974pjg.2
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 15:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UqNl3XYPy79VokpnvBdUdZ/vzeGFL7FW0h5vq6q9Sd4=;
        b=QAuRw27MZ70vCSh4eK1VgboTm963ZyOLmvEtNzKyZojO2N6BT2fMLGntGiMy0JvASq
         zZA4o+eNi5RlfAhNNopFRxFXwyDyaFZX8R4lZS9OB2l9doO+qArdVDHbPgpbrHi3o6ta
         wZjGzzoeQnzZVx/L9VZvwWrU/w8e3MSra+6JLU+yWV+p7Cu5+bsAfvMmhGW3FM5DxXiE
         qz6C60xg2+5xlCGOQE7ss3jgm3QVS/XvVGfY7YowvvoBMrC12toH261pDZbxsJhjZh5V
         hpd5bDye6HfMaLcCnO0blemR/bwCCmziTgMy71Ln8aGbgrCCtZQq7JBNrS81VVHbZTSn
         Ep6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UqNl3XYPy79VokpnvBdUdZ/vzeGFL7FW0h5vq6q9Sd4=;
        b=hfqg0Ndiq74MgMAg0bKl0kWzanxgO16LuW7xwGyYhjFkY4VJaGiOPkXC8FdOga1WZO
         ft6DChEYWL5MSe0y/etHlMg5v2+xnXMylfZ+V4VsXxf21StJKObenZdvUDoASPoK9Akq
         FbVAAjZuJkWLe7T5OOe/32jcfUuwWOOx1uNx4qjXYoQYJe0SlqiSpdOOrvjfR8psvYIP
         yaH4uzrAgGaEwtjrmlE9gAQJktjpZpKiQfdTPTWHHiOxaRijrY7UkzFYd6ls5uxNZac0
         +MYUouYjlQnHvYGlj8Jw/6kVwIfgYIS7NMf2gHBKz0J5gPay744fJGh+KGzHAQ+7UWUq
         88+w==
X-Gm-Message-State: AO0yUKV6P7+Gvbw0Hz6FBcpH/g9eRJtbk1h1RsG/MpFFGt9Y336O2UqU
        C5HX1eqeqEl/eQ5d+e8ZPZc=
X-Google-Smtp-Source: AK7set/P//NLNa7cj3vtXxnUykuf63bcGRazWIt+dCt+FjGtjbJUBA/GAeRV10t4y1nUSfRwop6EQw==
X-Received: by 2002:a17:903:1103:b0:196:1462:3276 with SMTP id n3-20020a170903110300b0019614623276mr38857plh.46.1674515423520;
        Mon, 23 Jan 2023 15:10:23 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id bg12-20020a1709028e8c00b00194955b7898sm216105plb.237.2023.01.23.15.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 15:10:23 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>
Subject: Re: [PATCH 3/5] hook API: support passing stdin to hooks, convert
 am's 'post-rewrite'
References: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com>
        <patch-3.5-c6b9b69c516-20230123T170551Z-avarab@gmail.com>
Date:   Mon, 23 Jan 2023 15:10:22 -0800
In-Reply-To: <patch-3.5-c6b9b69c516-20230123T170551Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 23 Jan
 2023 18:15:07 +0100")
Message-ID: <xmqq3580lue9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> diff --git a/hook.c b/hook.c
> index a4fa1031f28..86c6dc1fe70 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -53,8 +53,14 @@ static int pick_next_hook(struct child_process *cp,
>  	if (!hook_path)
>  		return 0;
>  
> -	cp->no_stdin = 1;
>  	strvec_pushv(&cp->env, hook_cb->options->env.v);
> +	/* reopen the file for stdin; run_command closes it. */
> +	if (hook_cb->options->path_to_stdin) {
> +		cp->no_stdin = 0;
> +		cp->in = xopen(hook_cb->options->path_to_stdin, O_RDONLY);
> +	} else {
> +		cp->no_stdin = 1;
> +	}

Do we need this else clause?  I thought that we've made sure
no_stdin is the default.  Is it just being explicit?

> diff --git a/hook.h b/hook.h
> index 4258b13da0d..19ab9a5806e 100644
> --- a/hook.h
> +++ b/hook.h
> @@ -30,6 +30,11 @@ struct run_hooks_opt
>  	 * was invoked.
>  	 */
>  	int *invoked_hook;
> +
> +	/**
> +	 * Path to file which should be piped to stdin for each hook.
> +	 */
> +	const char *path_to_stdin;
>  };
>  
>  #define RUN_HOOKS_OPT_INIT { \
