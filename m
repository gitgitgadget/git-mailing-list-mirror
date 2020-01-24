Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582B8C2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 14:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2189820838
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 14:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsyPunUB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbgAXOzt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:55:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36228 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729567AbgAXOzs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 09:55:48 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so1986382wma.1
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 06:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XO3LeTkg2Z10Tna5BNQ6RdWXBgoqoJHEHyCSSCU534k=;
        b=EsyPunUB+xaAH1vRbiUn8IzKk4nfAlnEch/PDD4QstwHqLE7bT278Aqb9YoWTGzgRa
         qL0SGeIVrp1lxYPdj/hLXGzI3BJ9rOcxyacmIzLhcC/4lvMR3csLYr38APzUV7BzyIJT
         wCreOq/QpP2vEzRuDeT4HsdizX2P/9O/uDtQcmQxNDR3Kkf1mSuY4iKwNgIqS9XD7b4E
         ra+wFGuGaaI7c7P8rTJ0OYrRdwrWwb7lSRD8X3WBTU4hBJKQKl7QsMBgYb78MiN74yrR
         I6CW67pCgCM4HNs9w6106dGOlInOM7WInpNzwaNj0d0/SW7FmDXdyILJ9ry4l55AKL19
         UPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XO3LeTkg2Z10Tna5BNQ6RdWXBgoqoJHEHyCSSCU534k=;
        b=lT2JW3jaZxL4byLJHbJBlm56u0YSFhH9nBYt2834cFVsI1JdYxVA/H08dwkSVM8KK4
         rjkHKXpozw+stm0aLSOrGPGaffyShiKkzVGJzkncsMMifn5uhCUZs1UXv+uWpMBBffJu
         7rw8jkxrbcB76nl1hmxZORc07+DkglLbh5DQfR7VIJ3zEkTjhOpqjFJAbx4vMksHbJvG
         bC02Xv1en6bfYHrG1NF8g5XsNdI47kvBtBcsmtZ6TCXRamqJNIQujPQ0NvLwuYVfRSPw
         kYol6i19KfPaDy/017WmZk/zozjbWAMlNWVrdk7RMFkHlUOCT7jil92sSRTsOzzq/EbF
         9+Tg==
X-Gm-Message-State: APjAAAVhbww4NpleSC5Q2RI+yqNoSuCGx8LFdJKIs5JBYIQaGQsCNpz2
        Lvuwn5Gw+iS7zeGjPgNAZ9Q=
X-Google-Smtp-Source: APXvYqxtfMCM6R3CALmWh7ssaVLaR08mJnWBj9P6gV99GKlo32fXTdDnlczPBvZqFa/Qp2VWqnjhQw==
X-Received: by 2002:a1c:6a06:: with SMTP id f6mr3846390wmc.137.1579877746051;
        Fri, 24 Jan 2020 06:55:46 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-551-1-75-233.w92-146.abo.wanadoo.fr. [92.146.226.233])
        by smtp.gmail.com with ESMTPSA id e12sm7672755wrn.56.2020.01.24.06.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 06:55:45 -0800 (PST)
Subject: Re: [PATCH v2] rebase -i: stop checking out the tip of the branch to
 rebase
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20200121191857.23047-1-alban.gruin@gmail.com>
 <20200124144545.12984-1-alban.gruin@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <9221098c-cba4-5db5-5870-bf6af721c448@gmail.com>
Date:   Fri, 24 Jan 2020 15:55:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20200124144545.12984-1-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 24/01/2020 à 15:45, Alban Gruin a écrit :
> One of the first things done when using a sequencer-based
> rebase (ie. `rebase -i', `rebase -r', or `rebase -m') is to make a todo
> list.  This requires knowledge of the commit range to rebase.  To get
> the oid of the last commit of the range, the tip of the branch to rebase
> is checked out with prepare_branch_to_be_rebased(), then the oid of the
> head is read.  After this, the tip of the branch is not even modified.
> 
> On big repositories, it's a performance penalty: with `rebase -i', the
> user may have to wait before editing the todo list while git is
> extracting the branch silently, and "quiet" rebases will be slower than
> `am'.
> 
> Since we already have the oid of the tip of the branch in
> `opts->orig_head', it's useless to switch to this commit.
> 
> This removes the call to prepare_branch_to_be_rebased() in
> do_interactive_rebase(), and adds a `orig_head' parameter to
> get_revision_ranges().  prepare_branch_to_be_rebased() is removed as it
> is no longer used.
> 
> This introduces a visible change: as we do not switch on the tip of the
> branch to rebase, no reflog entry is created at the beginning of the
> rebase for it.
> 
> Unscientific performance measurements, performed on linux.git, are as
> follow:
> 
>   Before this patch:
> 
>     $ time git rebase -m --onto v4.18 463fa44eec2fef50~ 463fa44eec2fef50
> 
>     real    0m8,940s
>     user    0m6,830s
>     sys     0m2,121s
> 
>   After this patch:
> 
>     $ time git rebase -m --onto v4.18 463fa44eec2fef50~ 463fa44eec2fef50
> 
>     real    0m1,834s
>     user    0m0,916s
>     sys     0m0,206s
> 
> Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
> 

Forget this patch, I forgot to clearly say that the `am' backend is not
affected.

> Notes:
>     Changes since v1:
>     
>      - The first version of the commit message talked specifically about
>        `rebase -i', but this problem is common to all sequencer-based
>        rebases.  The first paragraph has been reworded to clear up the
>        confusion.
>     
>      - Included benchmarks in the commit message, as suggested by Elijah
>        Newren.
>     
>     The code did not change.
> 
>  builtin/rebase.c | 18 +++++-------------
>  sequencer.c      | 14 --------------
>  sequencer.h      |  3 ---
>  3 files changed, 5 insertions(+), 30 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 8081741f8a..6154ad8fa5 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -246,21 +246,17 @@ static int edit_todo_file(unsigned flags)
>  }
>  
>  static int get_revision_ranges(struct commit *upstream, struct commit *onto,
> -			       const char **head_hash,
> +			       struct object_id *orig_head, const char **head_hash,
>  			       char **revisions, char **shortrevisions)
>  {
>  	struct commit *base_rev = upstream ? upstream : onto;
>  	const char *shorthead;
> -	struct object_id orig_head;
> -
> -	if (get_oid("HEAD", &orig_head))
> -		return error(_("no HEAD?"));
>  
> -	*head_hash = find_unique_abbrev(&orig_head, GIT_MAX_HEXSZ);
> +	*head_hash = find_unique_abbrev(orig_head, GIT_MAX_HEXSZ);
>  	*revisions = xstrfmt("%s...%s", oid_to_hex(&base_rev->object.oid),
>  						   *head_hash);
>  
> -	shorthead = find_unique_abbrev(&orig_head, DEFAULT_ABBREV);
> +	shorthead = find_unique_abbrev(orig_head, DEFAULT_ABBREV);
>  
>  	if (upstream) {
>  		const char *shortrev;
> @@ -314,12 +310,8 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
>  	struct replay_opts replay = get_replay_opts(opts);
>  	struct string_list commands = STRING_LIST_INIT_DUP;
>  
> -	if (prepare_branch_to_be_rebased(the_repository, &replay,
> -					 opts->switch_to))
> -		return -1;
> -
> -	if (get_revision_ranges(opts->upstream, opts->onto, &head_hash,
> -				&revisions, &shortrevisions))
> +	if (get_revision_ranges(opts->upstream, opts->onto, &opts->orig_head,
> +				&head_hash, &revisions, &shortrevisions))
>  		return -1;
>  
>  	if (init_basic_state(&replay,
> diff --git a/sequencer.c b/sequencer.c
> index b9dbf1adb0..4dc245d7ec 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3715,20 +3715,6 @@ static int run_git_checkout(struct repository *r, struct replay_opts *opts,
>  	return ret;
>  }
>  
> -int prepare_branch_to_be_rebased(struct repository *r, struct replay_opts *opts,
> -				 const char *commit)
> -{
> -	const char *action;
> -
> -	if (commit && *commit) {
> -		action = reflog_message(opts, "start", "checkout %s", commit);
> -		if (run_git_checkout(r, opts, commit, action))
> -			return error(_("could not checkout %s"), commit);
> -	}
> -
> -	return 0;
> -}
> -
>  static int checkout_onto(struct repository *r, struct replay_opts *opts,
>  			 const char *onto_name, const struct object_id *onto,
>  			 const char *orig_head)
> diff --git a/sequencer.h b/sequencer.h
> index 9f9ae291e3..74f1e2673e 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -190,9 +190,6 @@ void commit_post_rewrite(struct repository *r,
>  			 const struct commit *current_head,
>  			 const struct object_id *new_head);
>  
> -int prepare_branch_to_be_rebased(struct repository *r, struct replay_opts *opts,
> -				 const char *commit);
> -
>  #define SUMMARY_INITIAL_COMMIT   (1 << 0)
>  #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
>  void print_commit_summary(struct repository *repo,
> 

