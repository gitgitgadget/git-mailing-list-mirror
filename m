Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F09C22027B
	for <e@80x24.org>; Wed, 17 May 2017 02:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751861AbdEQCPq (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 22:15:46 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34000 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbdEQCPp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 22:15:45 -0400
Received: by mail-pf0-f194.google.com with SMTP id w69so21889299pfk.1
        for <git@vger.kernel.org>; Tue, 16 May 2017 19:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vF57gxLQSoJIo9Ybs+pN8ovwEY+RlxUOG3tG6AIM9uc=;
        b=fpXzcB2BBVocdTjKIha7nRxF9th69SbDg1sGm2J6GJUJxspecbTggxA9vwp04XBMPt
         SqnNWR+KdSGt/iiSE1SjKxLyZ5ewtcwZVBQXGLvEjh25ANtN2KvT3VkduGHGt2XQIvvY
         fLui8jSGQTbTS/k69MV4yPUXGvCMeO8cU2+HEdolzVggYHc12bj/bI8SgkLPQ6Bu9e4D
         I90sl8gdpEssLiueuq7S9DzI0X6OoWvFUung63gkvSDMVjkF2QbyqYLpjCoNEq6v0N8g
         fCNLvFdhwUz30/0pVVdszvYIsa0dsFML4+YIKYE0hJ2zlA5Uphm8JVeEMWwRvRWC3wx5
         DASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vF57gxLQSoJIo9Ybs+pN8ovwEY+RlxUOG3tG6AIM9uc=;
        b=GM0iIxTG8QBMi7Lub6flalnp88SVQOs9uK3vXFWFSF0x9IAk8d3LIIa4lPuSMot23E
         xK1S2pwQw+Kd0oXVKtpUQZNf8xU5P1YmAvyaXBTT06USJZoLzSyXxB831hJSIQpiG+mk
         nbeyuEjZ9kQv+m3Dd9M/iGKs549OoaOR/WApmjwCVszBADvMuPl0docYNNxz/YQxhGjR
         kQXgJOP6M+TA0UgqA1zgFfzbBEUuG9H47ZcUqKRGxV7K9qVKWjzXnmkuMm9rYUNZt0Bn
         WTbA9fi5h0GlybdbQOw8gY/6lWWm2PEY5mjN80mMelKa+IvY6OZJ/E1KkUGGxBfo4vVg
         lgfQ==
X-Gm-Message-State: AODbwcCM0MZkUYnq2GLtG4VI3RPTckOLqxbQkyqN93VIvKS2m4KA1czj
        13aiTPbjVvXzAg==
X-Received: by 10.84.224.70 with SMTP id a6mr1361306plt.38.1494987344753;
        Tue, 16 May 2017 19:15:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:78bf:56b6:7690:fdbd])
        by smtp.gmail.com with ESMTPSA id u26sm554721pfg.24.2017.05.16.19.15.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 19:15:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, j6t@kdbg.org, sbeller@google.com, e@80x24.org,
        jrnieder@gmail.com
Subject: Re: [PATCH v6 04/11] run-command: use the async-signal-safe execv instead of execvp
References: <20170418231805.61835-1-bmwill@google.com>
        <20170419231327.49895-1-bmwill@google.com>
        <20170419231327.49895-5-bmwill@google.com>
Date:   Wed, 17 May 2017 11:15:43 +0900
In-Reply-To: <20170419231327.49895-5-bmwill@google.com> (Brandon Williams's
        message of "Wed, 19 Apr 2017 16:13:20 -0700")
Message-ID: <xmqqfug4z0s0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> @@ -238,6 +238,12 @@ static void prepare_cmd(struct argv_array *out, const struct child_process *cmd)
>  	if (!cmd->argv[0])
>  		die("BUG: command is empty");
>  
> +	/*
> +	 * Add SHELL_PATH so in the event exec fails with ENOEXEC we can
> +	 * attempt to interpret the command with 'sh'.
> +	 */
> +	argv_array_push(out, SHELL_PATH);
> +
>  	if (cmd->git_cmd) {
>  		argv_array_push(out, "git");
>  		argv_array_pushv(out, cmd->argv);


So, given "cat-file", "-t", "HEAD" with cmd->git_cmd == TRUE, this
will now prepare ("/bin/sh", "git", "cat-file", "-t", "HEAD", NULL) in
the argv-array, and then ...

> @@ -246,6 +252,20 @@ static void prepare_cmd(struct argv_array *out, const struct child_process *cmd)
>  	} else {
>  		argv_array_pushv(out, cmd->argv);
>  	}
> +
> +	/*
> +	 * If there are no '/' characters in the command then perform a path
> +	 * lookup and use the resolved path as the command to exec.  If there
> +	 * are no '/' characters or if the command wasn't found in the path,
> +	 * have exec attempt to invoke the command directly.
> +	 */
> +	if (!strchr(out->argv[1], '/')) {
> +		char *program = locate_in_PATH(out->argv[1]);
> +		if (program) {
> +			free((char *)out->argv[1]);
> +			out->argv[1] = program;
> +		}
> +	}

... turn the first element from "git" to "/usr/bin/git", i.e.

	("/bin/sh", "/usr/bin/git", "cat-file", "-t", "HEAD", NULL)

which ...

>  #endif
>  
> @@ -445,7 +465,15 @@ int start_command(struct child_process *cmd)
>  			}
>  		}
>  
> -		sane_execvp(argv.argv[0], (char *const *) argv.argv);
> +		/*
> +		 * Attempt to exec using the command and arguments starting at
> +		 * argv.argv[1].  argv.argv[0] contains SHELL_PATH which will
> +		 * be used in the event exec failed with ENOEXEC at which point
> +		 * we will try to interpret the command using 'sh'.
> +		 */
> +		execv(argv.argv[1], (char *const *) argv.argv + 1);

... first is given without the leading "/bin/sh", as the end-user
intended (sort of), but if it fails

> +		if (errno == ENOEXEC)
> +			execv(argv.argv[0], (char *const *) argv.argv);

"/bin/sh" tries to run "/usr/bin/git" that was not executable (well,
the one in "usr/bin/" would have +x bit, but let's pretend that we
are trying to run one from bin-wrappers/ and somehow forgot +x bit)?

I think all of that is sensible, but there is one "huh?" I can't
figure out.  Typically we do "sh -c git cat-file -t HEAD" but this
lacks the "-c" (cf. the original prepare_shell_cmd()); why do we not
need it in this case?

Thanks.
