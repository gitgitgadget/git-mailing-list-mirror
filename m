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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42DCC33CB6
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 14:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7320020842
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 14:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfIEdzqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgAQO3k (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:29:40 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34657 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgAQO3k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 09:29:40 -0500
Received: by mail-qt1-f194.google.com with SMTP id 5so21902218qtz.1
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 06:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ExmHHU13rrgIXzSLceB2HuR0yXpg2QelNbBSxk1F/yY=;
        b=FfIEdzqA+t7pEadB5O+fsfBjo6u1NKsgFLudrSrCyBVPO7cKDVBOw22jXqseLS2abB
         CxtZbU17FCQDb6yc/LfTnLdaD7+UZwqa2NX0eJXGTBwWAj4vyu3yGslOypdD7OtT/KK3
         fBIFPK5OWVCiEUOb/yoqtFu6AZE4u6t2DeMPa4vOILQu7R9bNzg8RshPQARBaBln8XHD
         vdDoDkVoEXPcrkn3CrAgrLYQkmcdTxHWgdY/Y97ADW6zAv6Lxz+QuRZVmiFRg1p1vs4O
         mF2T1ZUOrahX246rmQiyiIwCAehKBA2/uScQmtYK2aj7iZOIS12KaL7KkmqYrKkRa8QM
         FnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ExmHHU13rrgIXzSLceB2HuR0yXpg2QelNbBSxk1F/yY=;
        b=Un5B/CIRkPXQoGo0fyInVGFkMkg3Hvu8Sr7BMjK8m6Su2K58YrjgrPrv5EdKgYDZid
         9dzl8cdRQ2GdY0NFmWZ+05aKZ4YOZYe14el5MTmQLobUTYegrgCn/Pi8lK+eG6lkj6lk
         WG3m0euDVoW3tjMgV9QaR3ePXp2s+tYuaWL0bBFyhvSt5ae0kPB3ihdsbYme4qYt5RVt
         GCjm3ip7jZrspcYrntmPES7dgU4qBMRYP1jucICyvIo5LD2gsnI9yriIsrx7CFtIkvTp
         rk6xTP9z+0Hz40tT4nvon1OtGwWlMd+Xc3LFMWZewS1OnfJ7vLbKZG+vuR4dZzfbht6T
         oQhQ==
X-Gm-Message-State: APjAAAURlwlxgbhQd4LJr0SH/eQY76yozV5/HtXaHWHXFrzeutPyDVTG
        KGVjrheZ02vEf7AL+UGXQctb14IGm/0=
X-Google-Smtp-Source: APXvYqwhfPKQmHTLpl1YPRTJ6Sv0BhwoXRsQkhBkFGnkTH4BO0sOtS0AwkcV2bwG8xVpHmRhNlqOwQ==
X-Received: by 2002:ac8:6697:: with SMTP id d23mr8022385qtp.350.1579271378962;
        Fri, 17 Jan 2020 06:29:38 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:64d0:3701:c4c7:2368? ([2001:4898:a800:1010:1606:3701:c4c7:2368])
        by smtp.gmail.com with ESMTPSA id q20sm13063677qtl.82.2020.01.17.06.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 06:29:38 -0800 (PST)
Subject: Re: [PATCH] commit: replace rebase/sequence booleans with single
 pick_state enum
To:     Ben Curtis via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Ben Curtis <nospam@nowsci.com>
References: <pull.531.git.1579268705473.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <551af3c3-4633-3dba-4999-1c1a63e5703a@gmail.com>
Date:   Fri, 17 Jan 2020 09:29:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <pull.531.git.1579268705473.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/17/2020 8:45 AM, Ben Curtis via GitGitGadget wrote:
> From: Ben Curtis <nospam@nowsci.com>
> 
> In 116a408, the boolean `rebase_in_progress` was introduced by dscho to

In 116a408 (commit: give correct advice for empty commit during a rebase,
2019-10-22), ...

> handle instances when cherry-pick and rebase were occuring at the same time.

s/occuring/occurring

> This created a situation where two independent booleans were being used
> to define the state of git at a point in time.
> 
> Under his recommendation to follow guidance from Junio, specifically
> `https://public-inbox.org/git/xmqqr234i2q0.fsf@gitster-ct.c.googlers.com/`,

Use lore.kernel.org and use "[1]" like a citation.

[1] https://lore.kernel.org/git/xmqqr234i2q0.fsf@gitster-ct.c.googlers.com/

> it was decided that an `enum` that defines the state of git would be a
> more effective path forward.
> 
> Tasks completed:

Everything in the message is about what you did and why. It's good that
you prefaced the "what" with so much "why", but now you can just describe
the "what" using paragraphs. The "Tasks completed:" line is superfluous.

>   - Remove multiple booleans `rebase_in_progress` and `sequencer_in_use` and
> replaced with a single `pick_state` enum that determines if, when
> cherry-picking, we are in a rebase, multi-pick, or single-pick state
>   - Converted double `if` statement to `if/else if` prioritizing `REBASE` to
> continue to disallow cherry pick in rebase.>
> 
> Signed-off-by: Ben Curtis <nospam@nowsci.com>
> ---
>     commit: replaced rebase/sequence booleans with single pick_state enum
>     
>     Addresses https://github.com/gitgitgadget/git/issues/426
>     
>     Previous discussions from @dscho and Junio led to the decision to merge
>     two independent booleans into a single enum to track the state of git 
>     during a cherry-pick leading to this PR/patch.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-531%2FFmstrat%2Fjs%2Fadvise-rebase-skip-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-531/Fmstrat/js/advise-rebase-skip-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/531
> 
>  builtin/commit.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 2beae13620..84f7e69cb1 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -125,7 +125,11 @@ static enum commit_msg_cleanup_mode cleanup_mode;
>  static const char *cleanup_arg;
>  
>  static enum commit_whence whence;
> -static int sequencer_in_use, rebase_in_progress;
> +static enum {
> +	SINGLE_PICK,
> +	MULTI_PICK,
> +	REBASE
> +} pick_state;
>  static int use_editor = 1, include_status = 1;
>  static int have_option_m;
>  static struct strbuf message = STRBUF_INIT;
> @@ -184,10 +188,12 @@ static void determine_whence(struct wt_status *s)
>  		whence = FROM_MERGE;
>  	else if (file_exists(git_path_cherry_pick_head(the_repository))) {
>  		whence = FROM_CHERRY_PICK;
> -		if (file_exists(git_path_seq_dir()))
> -			sequencer_in_use = 1;
>  		if (file_exists(git_path_rebase_merge_dir()))
> -			rebase_in_progress = 1;
> +			pick_state = REBASE;
> +		else if (file_exists(git_path_seq_dir()))
> +			pick_state = MULTI_PICK;
> +		else
> +			pick_state = SINGLE_PICK;

Since before the "if"s were not exclusive, would rebase_in_progress = 1
also include sequencer_in_use = 1? That would explain why you needed to
rearrange the cases here. (Based on later checks, it seems that these
cases are indeed independent.)

> -			if (rebase_in_progress && !sequencer_in_use)
> +			if (pick_state == REBASE)

This old error condition makes it appear that you _could_ be in the state
where rebase_in_progress = 1 and sequencer_in_use = 0, showing that one
does not imply the other.

> -			if (sequencer_in_use)
> +			if (pick_state == MULTI_PICK)
>  				fputs(_(empty_cherry_pick_advice_multi), stderr);
> -			else if (rebase_in_progress)
> +			else if (pick_state == REBASE)
>  				fputs(_(empty_rebase_advice), stderr);
>  			else
>  				fputs(_(empty_cherry_pick_advice_single), stderr);

Since we are using an enum, should we rearrange these cases into a switch (pick_state)?

Thanks,
-Stolee

