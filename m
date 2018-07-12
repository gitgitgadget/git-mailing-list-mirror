Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B5EB1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 18:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbeGLS0c (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 14:26:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35733 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbeGLS0c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 14:26:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id a3-v6so13404852wrt.2
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 11:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tWO5bFJRxuMezWUL6HFY5ItBLoqug4wnp/Y9l3ic+1k=;
        b=Y9cOpUDOrOzaqyawy3yNm+OOjuqkbs46NsajUTLFE4zesQr28HptmPxLe5fozh0jPR
         sSzq+1gchtwCS311CuIS+gswvywIntolX+YqCvG4xqC3w0K2ij8X6mtj8WoF9hm6bMpz
         9tc1Acol/J5gTTzo0H6ckdxdy7jMj19l1eV938oBM5qQkN1bK30gvgDaCnfHsktGDS0s
         Kh7UKDQGDRDV+4SzXJMwwozPillcbe1B1HUldg8ZkpcoD7OS5PfjyF1FHednNX9Hni/h
         cyBjWtqG2w1hXZPmz0Uyf4e6a9AMxyL6HAwdlY86jS+bhXDpVYoFW9KYycIzv6AG5bkH
         sK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tWO5bFJRxuMezWUL6HFY5ItBLoqug4wnp/Y9l3ic+1k=;
        b=eQvIPvLl3cI8L5JegNV0csLJ9wfcgwKmyN5WcglCgnDzO8JUwQTpTe51emqa2l8P/l
         pWuDuQAOWGyQkJDF/LQHZ7aXcbfSPnGocAoxmeIKJQjW8JjAMsQ+UuCmJdFl9tN0SbZr
         3qbhmZaFyF3URvT/v0hvAwmfIa9UXLwBeUAxGomYMp7faFzXnG244rtjSPkwXQMz8Jjf
         ZbSky2xuv3V5iNgIYVUP+7XPvor5SlTTeuNj0DLJwhCWYl8DMPHGW2xbG0hvAltUDKBY
         nwCIyE9qtXLg/o7uAhPWHju1+cTvXnW4UeYTdDoapdxTCiKxMXoe5vD1KlRwJ+CzpmGY
         Kc8A==
X-Gm-Message-State: AOUpUlFMKFj8AtRtt8hao8wZIZmadxuWxch7k5WTlSLSqXR8GNfoxmHE
        bpS9dihi4J5xU3y7sYf/jFMaUz+S
X-Google-Smtp-Source: AAOMgpfVaefhmoDs8pmvToky8pUUOljBv5LINjEQKDhV1vCSDxqFkfEVClTsNdejgKj6ZnpwC8oZlA==
X-Received: by 2002:adf:b2a7:: with SMTP id g36-v6mr2483495wrd.218.1531419349065;
        Thu, 12 Jul 2018 11:15:49 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 127-v6sm6914558wmd.18.2018.07.12.11.15.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 11:15:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v3 12/13] rebase -i: implement the logic to initialize the variable $revision in C
References: <20180702105717.26386-1-alban.gruin@gmail.com>
        <20180710121557.6698-1-alban.gruin@gmail.com>
        <20180710121557.6698-13-alban.gruin@gmail.com>
Date:   Thu, 12 Jul 2018 11:15:47 -0700
In-Reply-To: <20180710121557.6698-13-alban.gruin@gmail.com> (Alban Gruin's
        message of "Tue, 10 Jul 2018 14:15:56 +0200")
Message-ID: <xmqqo9fcxquk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> @@ -50,6 +71,13 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  			    N_("prepare the branch to be rebased"), PREPARE_BRANCH),
>  		OPT_CMDMODE(0, "complete-action", &command,
>  			    N_("complete the action"), COMPLETE_ACTION),
> +		OPT_STRING(0, "onto", &onto, N_("onto"), N_("onto")),
> +		OPT_STRING(0, "restrict-revision", &restrict_revisions,
> +			   N_("restrict-revision"), N_("restrict revision")),
> +		OPT_STRING(0, "squash-onto", &squash_onto, N_("squash-onto"),
> +			   N_("squash onto")),
> +		OPT_STRING(0, "upstream", &upstream, N_("upstream"),
> +			   N_("the upstream commit")),
>  		OPT_END()
>  	};
>  
> @@ -77,8 +105,30 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  		return !!sequencer_continue(&opts);
>  	if (command == ABORT && argc == 1)
>  		return !!sequencer_remove_state(&opts);
> -	if (command == MAKE_SCRIPT && argc > 1)
> -		return !!sequencer_make_script(stdout, argc, argv, flags);
> +	if (command == MAKE_SCRIPT && (argc == 1 || argc == 2)) {

Sorry but I am confused.  The call to rebase--helper --make-script
in git-rebase--interactive.sh we see below has only dashed options
(like --upstream, --onto, --squash-onto, --restrict-revision) and
the option parameters given to these options.

What are the remaining 1 or 2 arguments we are processing here?

Well, actually argc==1 means there is nothing else, so I am asking
about the case where argc==2.

> +		char *revisions = NULL;
> +		struct argv_array make_script_args = ARGV_ARRAY_INIT;
> +
> +		if (!upstream && squash_onto)
> +			write_file(path_squash_onto(), "%s\n", squash_onto);
> +
> +		ret = get_revision_ranges(upstream, onto, &head_hash, &revisions);
> +		if (ret)
> +			return ret;
> +
> +		argv_array_pushl(&make_script_args, "", revisions, NULL);
> +		if (argc == 2)
> +			argv_array_push(&make_script_args, restrict_revisions);
> +
> +		ret = !!sequencer_make_script(stdout,
> +					      make_script_args.argc, make_script_args.argv,
> +					      flags);

Exactly the same comment on !! as an earlier step applies here.

> +		free(revisions);
> +		argv_array_clear(&make_script_args);

If I am reading the body of this if() block correctly, I think it
does everything init_revisions_and_shortrevisions shell function
does, i.e. compute $revisions for both cases with or without
upstream and write squash-onto state if needed, so that we can call
the sequencer_make_script() helper with necessary $revisions arg
without being passed from the command line of --make-script helper.

But the hunk below tells me that you are still calling
init_revisions_and_shortrevisions shell function before we are
called.  Why?  IOW, why isn't this step removing that shell function
*and* the call to it, now its logic is fully implemented in the body
of this if() block?

> +		return ret;
> +	}
>  	if (command == CHECK_TODO_LIST && argc == 1)
>  		return !!check_todo_list();
>  	if (command == REARRANGE_SQUASH && argc == 1)

Thanks.

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 0d66c0f8b..4ca47aed1 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -92,7 +92,9 @@ git_rebase__interactive () {
>  	git rebase--helper --make-script ${keep_empty:+--keep-empty} \
>  		${rebase_merges:+--rebase-merges} \
>  		${rebase_cousins:+--rebase-cousins} \
> -		$revisions ${restrict_revision+^$restrict_revision} >"$todo" ||
> +		${upstream:+--upstream "$upstream"} ${onto:+--onto "$onto"} \
> +		${squash_onto:+--squash-onto "$squash_onto"} \
> +		${restrict_revision:+--restrict-revision ^"$restrict_revision"} >"$todo" ||
>  	die "$(gettext "Could not generate todo list")"
>  
>  	exec git rebase--helper --complete-action "$shortrevisions" "$onto_name" \
