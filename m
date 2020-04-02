Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DF4C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 09:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F06206D3
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 09:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrkteV7e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387680AbgDBJZe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 05:25:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43695 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgDBJZe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 05:25:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id 91so1360509wri.10
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 02:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MKTasFj4RTpuxoi1WtIvXmAPnPpLps33h+xZwUy7HLs=;
        b=HrkteV7eKx9X0LB4PnDtZB3CN2jsW4R9/f2wEVAtkOuEAfOEE929bPm3lLolit/mX0
         tXXcjxbQ0aelvX20nN2Yr22XiDDyZxA7W8BG+GqEqr1Ay3td1ja6S/sTKoDNHmQS7l8v
         bVnzddDHpG51T8ym3I/tqFZUaxrx1psvD6C2v7dTz/AfgNYZ4G9i+GwqGBNFtEtSLaaN
         UIpgvy0Q5DJyu5/Y6SP5Ihav0YdwtqlLjRM0ee0taP+/Rllr/VRCV0JHkmCVv238+vMr
         8dcV9BZVnknzqVdTBqmtNNZYtigg2KKIX8uIf1avR2Uom6bCw7VIA9LdOyS3ar2nP56e
         Ynog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MKTasFj4RTpuxoi1WtIvXmAPnPpLps33h+xZwUy7HLs=;
        b=Sd9Dnsa0e2qVIITU/n1RVgWnIiNzMrdF+14T7vZcM5ubNuslJ07qCb8HzRv29PLIan
         7vC8q3yeZfSsY5c51eU9EvdkCIyu8KvIFksh4fGq5sMZoZDssKGzRIRxPeHRx+TriCqn
         eroq0Mjj/mKgo1TLws61cs64XHPmW8Y8OqLe0gY7A2snTOEAni4fpH3Jd1V81c9yvjDE
         pDB5DKSaci5xuYoModnzkCVDyUnzBxfe1V3tC/W5f9uzx7Bzw7FCsSkWOuOpJUXWK358
         JWk36SPbQ4JmA7+06D8OQdqx1w+He/I/Z/rjdQtTD+9elndctutrjvZzWP5OAm7b9ymD
         50vQ==
X-Gm-Message-State: AGi0PuZ6mPbRCdQOuYHsEewrxSxcnGTjPQ19MORudLWHoKCTl7x+sffU
        5aZswzou6b6XreHl8+YTAaw=
X-Google-Smtp-Source: APiQypJdiJV/JU1tkctzrhYn46gBxhemdG5myoXHM+IxXzWzLP0tMhS48W8maqzYkkUeIgw3tW0Anw==
X-Received: by 2002:adf:f04c:: with SMTP id t12mr2502049wro.227.1585819531490;
        Thu, 02 Apr 2020 02:25:31 -0700 (PDT)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id j68sm6830882wrj.32.2020.04.02.02.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 02:25:30 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer: honor GIT_REFLOG_ACTION
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     jrnieder@gmail.com, elbrus@debian.org,
        ijackson@chiark.greenend.org.uk, phillip.wood@dunelm.org.uk,
        alban.gruin@gmail.com, Johannes.Schindelin@gmx.de,
        Elijah Newren <newren@gmail.com>
References: <pull.746.git.git.1585773096145.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <b187cb5f-a6c8-2908-e3fd-e1210e6970e0@gmail.com>
Date:   Thu, 2 Apr 2020 10:25:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <pull.746.git.git.1585773096145.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

Thanks for fixing this

On 01/04/2020 21:31, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> There is a lot of code to honor GIT_REFLOG_ACTION throughout git,
> including some in sequencer.c; unfortunately, reflog_message() and its
> callers ignored it.  Instruct reflog_message() to check the existing
> environment variable, and use it when present as an override to
> action_name().
> 
> Also restructure pick_commits() to only temporarily modify
> GIT_REFLOG_ACTION for a short duration and then restore the old value,
> so that when we do this setting within a loop we do not keep adding "
> (pick)" substrings and end up with a reflog message of the form
>      rebase (pick) (pick) (pick) (finish): returning to refs/heads/master
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>      sequencer: honor GIT_REFLOG_ACTION
>      
>      I'm not the best with getenv/setenv. The xstrdup() wrapping is
>      apparently necessary on mac and bsd. The xstrdup seems like it leaves us
>      with a memory leak, but since setenv(3) says to not alter or free it, I
>      think it's right. Anyone have any alternative suggestions?
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-746%2Fnewren%2Fhonor-reflog-action-in-sequencer-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-746/newren/honor-reflog-action-in-sequencer-v1
> Pull-Request: https://github.com/git/git/pull/746
> 
>   sequencer.c               |  9 +++++++--
>   t/t3406-rebase-message.sh | 16 ++++++++--------
>   2 files changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index e528225e787..5837fdaabbe 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3708,10 +3708,11 @@ static const char *reflog_message(struct replay_opts *opts,
>   {
>   	va_list ap;
>   	static struct strbuf buf = STRBUF_INIT;
> +	char *reflog_action = getenv("GIT_REFLOG_ACTION");

Minor nit - you're using a string here rather that the pre-processor 
constant that is used below

>   	va_start(ap, fmt);
>   	strbuf_reset(&buf);
> -	strbuf_addstr(&buf, action_name(opts));
> +	strbuf_addstr(&buf, reflog_action ? reflog_action : action_name(opts));
>   	if (sub_action)
>   		strbuf_addf(&buf, " (%s)", sub_action);
>   	if (fmt) {
> @@ -3799,8 +3800,10 @@ static int pick_commits(struct repository *r,
>   			struct replay_opts *opts)
>   {
>   	int res = 0, reschedule = 0;
> +	char *prev_reflog_action;
>   
>   	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
> +	prev_reflog_action = xstrdup(getenv(GIT_REFLOG_ACTION));

I'm confused as to why saving the environment variable immediately after 
setting it works but the test shows it does - why doesn't this clobber 
the value of GIT_REFLOG_ACTION set by the user?

Best Wishes

Phillip

>   	if (opts->allow_ff)
>   		assert(!(opts->signoff || opts->no_commit ||
>   				opts->record_origin || opts->edit));
> @@ -3845,12 +3848,14 @@ static int pick_commits(struct repository *r,
>   		}
>   		if (item->command <= TODO_SQUASH) {
>   			if (is_rebase_i(opts))
> -				setenv("GIT_REFLOG_ACTION", reflog_message(opts,
> +				setenv(GIT_REFLOG_ACTION, reflog_message(opts,
>   					command_to_string(item->command), NULL),
>   					1);
>   			res = do_pick_commit(r, item->command, item->commit,
>   					     opts, is_final_fixup(todo_list),
>   					     &check_todo);
> +			if (is_rebase_i(opts))
> +				setenv(GIT_REFLOG_ACTION, prev_reflog_action, 1);
>   			if (is_rebase_i(opts) && res < 0) {
>   				/* Reschedule */
>   				advise(_(rescheduled_advice),
> diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
> index 61b76f33019..927a4f4a4e4 100755
> --- a/t/t3406-rebase-message.sh
> +++ b/t/t3406-rebase-message.sh
> @@ -89,22 +89,22 @@ test_expect_success 'GIT_REFLOG_ACTION' '
>   	git checkout -b reflog-topic start &&
>   	test_commit reflog-to-rebase &&
>   
> -	git rebase --apply reflog-onto &&
> +	git rebase reflog-onto &&
>   	git log -g --format=%gs -3 >actual &&
>   	cat >expect <<-\EOF &&
> -	rebase finished: returning to refs/heads/reflog-topic
> -	rebase: reflog-to-rebase
> -	rebase: checkout reflog-onto
> +	rebase (finish): returning to refs/heads/reflog-topic
> +	rebase (pick): reflog-to-rebase
> +	rebase (start): checkout reflog-onto
>   	EOF
>   	test_cmp expect actual &&
>   
>   	git checkout -b reflog-prefix reflog-to-rebase &&
> -	GIT_REFLOG_ACTION=change-the-reflog git rebase --apply reflog-onto &&
> +	GIT_REFLOG_ACTION=change-the-reflog git rebase reflog-onto &&
>   	git log -g --format=%gs -3 >actual &&
>   	cat >expect <<-\EOF &&
> -	rebase finished: returning to refs/heads/reflog-prefix
> -	change-the-reflog: reflog-to-rebase
> -	change-the-reflog: checkout reflog-onto
> +	change-the-reflog (finish): returning to refs/heads/reflog-prefix
> +	change-the-reflog (pick): reflog-to-rebase
> +	change-the-reflog (start): checkout reflog-onto
>   	EOF
>   	test_cmp expect actual
>   '
> 
> base-commit: 274b9cc25322d9ee79aa8e6d4e86f0ffe5ced925
> 
