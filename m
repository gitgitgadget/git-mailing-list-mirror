Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599C7C433EF
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 13:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbiCQNui (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 09:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbiCQNuc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 09:50:32 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E234DE7295
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 06:49:14 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w25so6612038edi.11
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 06:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=TgVneEs8A1VkxosBNqj2d3sSz18Nnakbv3vmSKERHqA=;
        b=lbsvnyo6MZ7GG+k271qGn59UvpTJ2BNKHhvb62Rb3jLaP5N0QFeZautyaFj2yvrZg2
         1mYEMRYonFdlf+l0ag1Cohkljh8CMqgJgvbnOIryP83nwTwLZF7WB6fRNhjR1VTeXeno
         2x7mJvbRf3jz0EsRlRWVSn5jvXrwfzPtGfaSWXVHlrXgJg7jgTRGoMJ0Mt18rK05KITl
         gw8wbtqHjXbZOw33a3O8Qtvnz7sEKYiIYJDYgS9wWCy6btidrHGctsZWTMu0VS4lOo5+
         BvF9FqsPZ09NLRKntG0mCmPYrNfqvnxrtkXSWyBpnZxmAaGzalWdn9gLHY+zI41gnN7z
         uMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=TgVneEs8A1VkxosBNqj2d3sSz18Nnakbv3vmSKERHqA=;
        b=qoFp1G+740puCdGemR9tZv38ATU39CXqWMkE8riIntG15iardgJn6GRoASbw4SPTp5
         WTO/Wu3vdZ4U9QGDb/31Vj6aM8CEiZWg3GarIBYAMwRAJuJVVj6XcwMaSyFnBJfd5MLU
         y6GhrD5p1BaK54jYOOd9yK3zhKh34bZ61SWNl9NAgiYxUmnyGK+EmG6LY3DNtMaRwa+Z
         h/B+I4uzvKieYHvNnyfUYXMBgsBoJv/hVrNw3Y9EfUd8ZrpOlxNONpg/Icn2hQiowfmH
         av8sUpY8lmz+Y09X+osWLTzjDsgNbknebgZFNQb3l6IifijDXNlNaIpJf6O71pA9Mor6
         lyUg==
X-Gm-Message-State: AOAM533RKIakuS536WARf1WttadBZ7mtTMXptr2r/M7W251veHAo9gUz
        /m+/ybIrWVe4MKpzbvnvrIEEO4ASyV9JXg==
X-Google-Smtp-Source: ABdhPJxT5hR/YdGqjoAY9hxebaxTJRKZG9EmJxRjXIKM7uZQWW+gVyfB/pr4M1r1W9nDBxa/gjmT6g==
X-Received: by 2002:a05:6402:2714:b0:416:4bcf:89a9 with SMTP id y20-20020a056402271400b004164bcf89a9mr4631472edd.226.1647524952557;
        Thu, 17 Mar 2022 06:49:12 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bx5-20020a0564020b4500b00418fca53406sm776238edb.27.2022.03.17.06.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 06:49:12 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nUqV5-0023Eo-FO;
        Thu, 17 Mar 2022 14:49:11 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 2/2] rebase: set REF_HEAD_DETACH in
 checkout_up_to_date()
Date:   Thu, 17 Mar 2022 14:42:53 +0100
References: <pull.1226.v2.git.git.1647019492.gitgitgadget@gmail.com>
 <pull.1226.v3.git.git.1647487001.gitgitgadget@gmail.com>
 <bd1c9537ffc503707690ed173b9e6e808d58ce5d.1647487001.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <bd1c9537ffc503707690ed173b9e6e808d58ce5d.1647487001.git.gitgitgadget@gmail.com>
Message-ID: <220317.86r170d6zs.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 17 2022, John Cai via GitGitGadget wrote:

> From: John Cai <johncai86@gmail.com>
>
> Fixes a bug whereby rebase updates the deferenced reference HEAD points
> to instead of HEAD directly.
>
> If HEAD is on main and if the following is a fast-forward operation,
>
> git rebase $(git rev-parse main) $(git rev-parse topic)
>
> Instead of HEAD being set to $(git rev-parse topic), rebase erroneously
> dereferences HEAD and sets main to $(git rev-parse topic). See [1] for
> the original bug report.
>
> The callstack from checkout_up_to_date() is the following:
>
> cmd_rebase() -> checkout_up_to_date() -> reset_head() -> update_refs()
>  -> update_ref()
>
> When <branch> is not a valid branch but a sha, rebase sets the head_name

..but an OID...

> of rebase_options to NULL. This value gets passed down this call chain
> through the branch member of reset_head_opts also getting set to NULL
> all the way to update_refs(). update_refs() checks ropts.branch to
> decide whether or not to switch brancheds. If ropts.branch is NULL, it

brancheds -> branches.

And maybe a new paragraph before "update_refs()"? I.e. "\n\nThen
update_refs() checks..." ?

> calls update_ref() to update HEAD. At this point however, from rebase's
> point of view, we want a detached HEAD. But, since checkout_up_to_date()
> does not set the RESET_HEAD_DETACH flag, the update_ref() call will
> deference HEAD and update the branch its pointing to, which in the above
> example is main.
>
> The correct behavior is that git rebase should update HEAD to $(git
> rev-parse topic) without dereferencing it.
>
> Fix this bug by adding the RESET_HEAD_DETACH flag in checkout_up_to_date
> if <branch> is not a valid branch. so that once reset_head() calls
> update_refs(), it calls update_ref() with REF_NO_DEREF which updates
> HEAD directly intead of deferencing it and updating the branch that HEAD
> points to.

But on the "tell" v.s. show... (more below)...
>
> Also add a test to ensure this behavior.
>
> 1. https://lore.kernel.org/git/xmqqsfrpbepd.fsf@gitster.g/
>
> Reported-by: Michael McClimon <michael@mcclimon.org>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  builtin/rebase.c  | 5 ++++-
>  t/t3400-rebase.sh | 9 +++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index b29ad2b65e7..5ae7fa2a169 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -827,8 +827,11 @@ static int checkout_up_to_date(struct rebase_options *options)
>  		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
>  		    options->switch_to);
>  	ropts.oid = &options->orig_head;
> -	ropts.branch = options->head_name;
>  	ropts.flags = RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
> +	if (options->head_name)
> +		ropts.branch = options->head_name;
> +	else
> +		ropts.flags |=  RESET_HEAD_DETACH;
>  	ropts.head_msg = buf.buf;
>  	if (reset_head(the_repository, &ropts) < 0)
>  		ret = error(_("could not switch to %s"), options->switch_to);

In this case a smaller change of:

    if (!ropts.branch)
		ropts.flags |=  RESET_HEAD_DETACH;

will do the same.

I wonder if just converting it to a designated initializer while we're
at it (or a pre-cleanup commit) would be better, i.e.:

	
	diff --git a/builtin/rebase.c b/builtin/rebase.c
	index 5ae7fa2a169..bf4fd4d2920 100644
	--- a/builtin/rebase.c
	+++ b/builtin/rebase.c
	@@ -820,18 +820,18 @@ static int rebase_config(const char *var, const char *value, void *data)
	 static int checkout_up_to_date(struct rebase_options *options)
	 {
	 	struct strbuf buf = STRBUF_INIT;
	-	struct reset_head_opts ropts = { 0 };
	+	struct reset_head_opts ropts = {
	+		.oid = &options->orig_head,
	+		.branch = options->head_name,
	+		.flags = (RESET_HEAD_RUN_POST_CHECKOUT_HOOK |
	+			  (options->head_name ? 0 : RESET_HEAD_DETACH)),
	+	};
	 	int ret = 0;
	 
	 	strbuf_addf(&buf, "%s: checkout %s",
	 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
	 		    options->switch_to);
	-	ropts.oid = &options->orig_head;
	-	ropts.flags = RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
	-	if (options->head_name)
	-		ropts.branch = options->head_name;
	-	else
	-		ropts.flags |=  RESET_HEAD_DETACH;
	+
	 	ropts.head_msg = buf.buf;
	 	if (reset_head(the_repository, &ropts) < 0)
	 		ret = error(_("could not switch to %s"), options->switch_to);

But in any case the functionality will be the same, so this is just
bikeshedding.
	
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 0643d015255..d5a8ee39fc4 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -394,6 +394,15 @@ test_expect_success 'switch to branch not checked out' '
>  	git rebase main other
>  '
>  
> +test_expect_success 'switch to non-branch detaches HEAD' '
> +	git checkout main &&
> +	old_main=$(git rev-parse HEAD) &&
> +	git rebase First Second^0 &&
> +	test_cmp_rev HEAD Second &&
> +	test_cmp_rev main $old_main &&
> +	test_must_fail git symbolic-ref HEAD
> +'
> +
>  test_expect_success 'refuse to switch to branch checked out elsewhere' '
>  	git checkout main &&
>  	git worktree add wt &&

I think it's *much* easier to review these sorts of changes where
there's a preceding commit that positively asserts what we do now, and
we'll then in the "fix" commit change the behavior.

So more "show" v.s. "tell".

I.e. in this case do the "test_cmp_rev" to the "wrong" tip with a TODO
comment or whatever, then in the fix just adjust it, then it's clear
what we had before/after.
