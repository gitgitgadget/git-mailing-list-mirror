Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83882C33C9E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 20:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5C02072E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 20:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbBOlRL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgAQUBQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 15:01:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35187 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgAQUBP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 15:01:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so23854925wro.2
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 12:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tWxE/F2c/tATyvVZ6VPOlVjLKJcpuSgencuxZtQ6WQc=;
        b=hbBOlRL9en6El7onYA4/XXRfnz4uyPUcMHZwsaHX448tVYOc8y2ctdWLdQqa5sPwS5
         /OIGrvYFKVVdISeTlQOiwqiBSC/4ctUv4bs+wzxB26LUYuRq1ufbifI98pjV5yti7Lnp
         JGcRRSJzkplgdtNhPbu83bxBH3UYTx4AOZQ1BBpTG+hndeYmdQvEa1i7FrDqTQhgZt5G
         MVgX0NShhUDfQIgRn4+GLDra3rIUkPY9YLbWjyMwq5acMOyudv9gZN6M5ltqa/iPQSTY
         QKEuNlWjYT7HWEe9823sabut6ZcxBp4mmtz1mHPEfKuWnrnGMqZn4vJ49ZR2pJvDCdTL
         kbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tWxE/F2c/tATyvVZ6VPOlVjLKJcpuSgencuxZtQ6WQc=;
        b=UavjlWaGB/Fk8PWUk4Ty4q3qLNgCYlm5ZqS+E8MC58f6F+cIyGpsVRenKhSS/BXFWv
         bcsOzT/30Ng9ToF5ZfLgmLWTwqChUKwWObhaHXPPhmDn5Ipw6NUtMNyIhFA2XcGZBGdq
         i21XjHgAyhANPT/XLUtYyVodi/+qnl4ux22BYWFgkvERFN9Xe6NszZLS3J+XQs7hSi0e
         VkUN56WF0oGg1Pk9HDL9TVPzo/Ydqm3TwI7GlMM2F3TefKzokI5R/COSfZvF0BhlvDEx
         NRR2y2pIAgU3gVV4zBQcu5UyVJ9M8Nei/5lQwVdNh27LnIqIH83zlEojYWC0YKxLdVXb
         Nd2g==
X-Gm-Message-State: APjAAAXfvYINktyQhCs0TD47X/3T+t0dZpWX5SzZm2FuUKM0LUufxi1O
        UPLTHnp54dbbqy8kqmcRBN+aiDy3
X-Google-Smtp-Source: APXvYqwOgfbhjKNtDiaK/vYnIpLrDfg3XW/BWAGUb4NJosnlSXtGzrWhlnmGETL3VK/Umr+w3yEZhw==
X-Received: by 2002:adf:fd43:: with SMTP id h3mr4893474wrs.169.1579291273403;
        Fri, 17 Jan 2020 12:01:13 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-19-5.as13285.net. [92.22.19.5])
        by smtp.gmail.com with ESMTPSA id i11sm36291432wrs.10.2020.01.17.12.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 12:01:12 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] commit: replace rebase/sequence booleans with single
 pick_state enum
To:     Ben Curtis via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Ben Curtis <nospam@nowsci.com>, Derrick Stolee <stolee@gmail.com>
References: <pull.531.git.1579268705473.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <17b57e7f-7f3c-abab-1da6-d2e5c9ff893d@gmail.com>
Date:   Fri, 17 Jan 2020 20:01:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <pull.531.git.1579268705473.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben

On 17/01/2020 13:45, Ben Curtis via GitGitGadget wrote:
> From: Ben Curtis <nospam@nowsci.com>
> 
> In 116a408,

That commit is no longer in pu, it has been replaced by 430b75f720 
("commit: give correct advice for empty commit during a rebase", 
2019-12-06). There is now a preparatory commit 8d57f75749 ("commit: use 
enum value for multiple cherry-picks", 2019-12-06) which replaces the 
booleans with an enum. I need to reroll the series 
(pw/advise-rebase-skip) that contains them, if you've got any comments 
please let me know.

Best Wishes

Phillip

  the boolean `rebase_in_progress` was introduced by dscho to
> handle instances when cherry-pick and rebase were occuring at the same time.
> This created a situation where two independent booleans were being used
> to define the state of git at a point in time.
> 
> Under his recommendation to follow guidance from Junio, specifically
> `https://public-inbox.org/git/xmqqr234i2q0.fsf@gitster-ct.c.googlers.com/`,
> it was decided that an `enum` that defines the state of git would be a
> more effective path forward.
> 
> Tasks completed:
>    - Remove multiple booleans `rebase_in_progress` and `sequencer_in_use` and
> replaced with a single `pick_state` enum that determines if, when
> cherry-picking, we are in a rebase, multi-pick, or single-pick state
>    - Converted double `if` statement to `if/else if` prioritizing `REBASE` to
> continue to disallow cherry pick in rebase.
> 
> Signed-off-by: Ben Curtis <nospam@nowsci.com>
> ---
>      commit: replaced rebase/sequence booleans with single pick_state enum
>      
>      Addresses https://github.com/gitgitgadget/git/issues/426
>      
>      Previous discussions from @dscho and Junio led to the decision to merge
>      two independent booleans into a single enum to track the state of git
>      during a cherry-pick leading to this PR/patch.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-531%2FFmstrat%2Fjs%2Fadvise-rebase-skip-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-531/Fmstrat/js/advise-rebase-skip-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/531
> 
>   builtin/commit.c | 24 +++++++++++++++---------
>   1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 2beae13620..84f7e69cb1 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -125,7 +125,11 @@ static enum commit_msg_cleanup_mode cleanup_mode;
>   static const char *cleanup_arg;
>   
>   static enum commit_whence whence;
> -static int sequencer_in_use, rebase_in_progress;
> +static enum {
> +	SINGLE_PICK,
> +	MULTI_PICK,
> +	REBASE
> +} pick_state;
>   static int use_editor = 1, include_status = 1;
>   static int have_option_m;
>   static struct strbuf message = STRBUF_INIT;
> @@ -184,10 +188,12 @@ static void determine_whence(struct wt_status *s)
>   		whence = FROM_MERGE;
>   	else if (file_exists(git_path_cherry_pick_head(the_repository))) {
>   		whence = FROM_CHERRY_PICK;
> -		if (file_exists(git_path_seq_dir()))
> -			sequencer_in_use = 1;
>   		if (file_exists(git_path_rebase_merge_dir()))
> -			rebase_in_progress = 1;
> +			pick_state = REBASE;
> +		else if (file_exists(git_path_seq_dir()))
> +			pick_state = MULTI_PICK;
> +		else
> +			pick_state = SINGLE_PICK;
>   	}
>   	else
>   		whence = FROM_COMMIT;
> @@ -459,7 +465,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
>   		if (whence == FROM_MERGE)
>   			die(_("cannot do a partial commit during a merge."));
>   		else if (whence == FROM_CHERRY_PICK) {
> -			if (rebase_in_progress && !sequencer_in_use)
> +			if (pick_state == REBASE)
>   				die(_("cannot do a partial commit during a rebase."));
>   			die(_("cannot do a partial commit during a cherry-pick."));
>   		}
> @@ -958,9 +964,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>   			fputs(_(empty_amend_advice), stderr);
>   		else if (whence == FROM_CHERRY_PICK) {
>   			fputs(_(empty_cherry_pick_advice), stderr);
> -			if (sequencer_in_use)
> +			if (pick_state == MULTI_PICK)
>   				fputs(_(empty_cherry_pick_advice_multi), stderr);
> -			else if (rebase_in_progress)
> +			else if (pick_state == REBASE)
>   				fputs(_(empty_rebase_advice), stderr);
>   			else
>   				fputs(_(empty_cherry_pick_advice_single), stderr);
> @@ -1167,7 +1173,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
>   		if (whence == FROM_MERGE)
>   			die(_("You are in the middle of a merge -- cannot amend."));
>   		else if (whence == FROM_CHERRY_PICK) {
> -			if (rebase_in_progress && !sequencer_in_use)
> +			if (pick_state == REBASE)
>   				die(_("You are in the middle of a rebase -- cannot amend."));
>   			die(_("You are in the middle of a cherry-pick -- cannot amend."));
>   		}
> @@ -1643,7 +1649,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>   		if (!reflog_msg)
>   			reflog_msg = (whence != FROM_CHERRY_PICK)
>   					? "commit"
> -					: rebase_in_progress && !sequencer_in_use
> +					: pick_state == REBASE
>   					? "commit (rebase)"
>   					: "commit (cherry-pick)";
>   		commit_list_insert(current_head, &parents);
> 
> base-commit: 116a408b6ffcb2496ebf10dfce1364a42e8f0b32
> 
