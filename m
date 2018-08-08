Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5314A1F405
	for <e@80x24.org>; Wed,  8 Aug 2018 19:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbeHHVXm (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:23:42 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:55377 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbeHHVXl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:23:41 -0400
Received: by mail-wm0-f44.google.com with SMTP id f21-v6so3803351wmc.5
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 12:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=iQwKYQyhJcHqVFnTRtFEjQAZrHXlvjgiygp4PHene+U=;
        b=mmu6xXdLpEvkFCMlvw72IjA9rRUFWzny6xQocVO0XhyJp/o/0abnrkEMF36rXKQHm1
         O8SsBiWwyPmwdPZe3huH6zdfoMzc/zwm/E0qZSTNjxWWXojbKVea4glpIe70Qqvb/eOG
         HF7/7VIn5tbVYfjtXSaSQgMkCy7mqoISdZhftzvOhSjMOl/vHWlIEnZsJx4HpEtsDqfs
         f2Ls9/NbqmKinSN67QmTihw7gWPAGulo5/kfUlg+q3d0QdTevcIWDNiVjlYB+IF2DU0I
         zEWtrC2DZJbgeDzEb8mNA5UR8nMBSoG0fYV+OUxm0y+FJn+YYPWZ02OlZocSGTqhkGQN
         tiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=iQwKYQyhJcHqVFnTRtFEjQAZrHXlvjgiygp4PHene+U=;
        b=qQpYQVBBszKTH3cDSfW8QPMBCt9ajqULyPW8XTFBLh88ZhxEHBJyMsd7ZMAMb/YZhn
         F9N17/d8deZ+toLfnxHCBgHHp19BI5zwOqnsZe1Snojl19Bp1SJWj5FFnGHOuHiypBoB
         fpA1UQD/6fYe/+fP6lK8XNo/E+2psBxx/GF9meIvApUp/gNvzONsFMXd/RTP0Ju5YFkK
         87VISllp8gXqzdZl5NmspXc7F7AKCynvL0COsHJPHTI/MHQyk/6mfKFNlwOZexmQTIKK
         qRxFkiSwSIX9WYbUHwq1NPQBrbobgpcwG+39kEmk8BTZ9n3EVKqWCdgHP3biTRYAVESD
         YFTQ==
X-Gm-Message-State: AOUpUlE/pZG0u/HSufRAIb4nf4h4jHcnA2jH/kNj6nhBoOspY8OsISTZ
        NbubQ0c3XDDM9u5ZaWdgFZg=
X-Google-Smtp-Source: AA+uWPyVXsJQMyATK/wHMaBhRMKvdu2kvoPsIox8O3MDe4IV9G8cvCBvJoN3T1lEpOn7idGm0PxXyA==
X-Received: by 2002:a1c:b213:: with SMTP id b19-v6mr2558937wmf.141.1533754957727;
        Wed, 08 Aug 2018 12:02:37 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y14-v6sm3896154wrq.45.2018.08.08.12.02.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 12:02:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        Johannes.Schindelin@gmx.de, sbeller@google.com,
        alban.gruin@gmail.com
Subject: Re: [PATCH 01/11] builtin rebase: support --onto
References: <20180808134830.19949-1-predatoramigo@gmail.com>
        <20180808134830.19949-2-predatoramigo@gmail.com>
Date:   Wed, 08 Aug 2018 12:02:36 -0700
In-Reply-To: <20180808134830.19949-2-predatoramigo@gmail.com> (Pratik Karki's
        message of "Wed, 8 Aug 2018 19:33:20 +0545")
Message-ID: <xmqq600kheb7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratik Karki <predatoramigo@gmail.com> writes:

> The `--onto` option is important, as it allows to rebase a range of
> commits onto a different base commit (which gave the command its odd
> name: "rebase").

Is there anything unimportant?  A rhetorical question, of course.

The quite casual and natural use of "to rebase" as a verb in the
first sentence contradicts with what the parenthetical "its odd
name" comment says.  Perhaps drop everything after "(which..."?

i.e.

	The `--onto` option allows to rebase a range of commits onto
	a different base commit.  Port the support for the option to
	the C re-implementation.

> This commit introduces options parsing so that different options can
> be added in future commits.

We usually do not say "This commit does X", or (worse) "I do X in
this commit".  Instead, order the codebase to be like so, e.g.
"Support command line options by adding a call to parse_options();
later commits will add more options by building on top." or
something like that.

> @@ -318,13 +334,22 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			BUG("sane_execvp() returned???");
>  	}
>  
> -	if (argc != 2)
> -		die(_("Usage: %s <base>"), argv[0]);
> +	if (argc == 2 && !strcmp(argv[1], "-h"))
> +		usage_with_options(builtin_rebase_usage,
> +				   builtin_rebase_options);
> +
>  	prefix = setup_git_directory();
>  	trace_repo_setup(prefix);
>  	setup_work_tree();
>
>  	git_config(git_default_config, NULL);
> +	argc = parse_options(argc, argv, prefix,
> +			     builtin_rebase_options,
> +			     builtin_rebase_usage, 0);
> +
> +	if (argc > 2)
> +		usage_with_options(builtin_rebase_usage,
> +				   builtin_rebase_options);

OK.  This correctly calls the parser after repository setup.

>  	switch (options.type) {
>  	case REBASE_MERGE:
> @@ -343,10 +368,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	if (!options.root) {
> -		if (argc < 2)
> +		if (argc < 1)
>  			die("TODO: handle @{upstream}");
>  		else {
> -			options.upstream_name = argv[1];
> +			options.upstream_name = argv[0];
>  			argc--;
>  			argv++;
>  			if (!strcmp(options.upstream_name, "-"))
> @@ -377,7 +402,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	 * orig_head -- commit object name of tip of the branch before rebasing
>  	 * head_name -- refs/heads/<that-branch> or "detached HEAD"
>  	 */
> -	if (argc > 1)
> +	if (argc > 0)
>  		 die("TODO: handle switch_to");
>  	else {
>  		/* Do not need to switch branches, we are already on it. */
