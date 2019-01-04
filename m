Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8214E1F6A9
	for <e@80x24.org>; Fri,  4 Jan 2019 18:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfADSkY (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 13:40:24 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54912 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfADSkY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 13:40:24 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so1951207wmh.4
        for <git@vger.kernel.org>; Fri, 04 Jan 2019 10:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sbJA1wpXMx2xngL3uJxdsOx9ayhCJ4ydHB8ZH7GQ6bQ=;
        b=XvrE+uTWdHBUmmYADf8zs3ym76B/IS3fHLlRRbafC9gsyzkRLgcEUdcNmNGMdS2C/7
         0MLiiSnw+WZaWicoevN9hMrs5AsYTMBf6w17PRTmpQu7QrjOx9Zk4GGcNvSN0Y7lfJZs
         JsUdjZYLFioJsms4rwmFr/jAQhBL6RkOCKf3bcmPHrlf1R2/apLT/dmrY2CMbjulglG/
         36vXJ7S5QSZaZ7mbEAvPHcDtKH4aC521jeh06yfecy9NqZhE5HHGX7gfb9wYMsQaFuzY
         qz4fvav64U4wyvTMt+SRxVzjrMzSrGuIVyWksBp+RAAYBZKQvz2bHYaB276NrfT4aiO5
         iTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sbJA1wpXMx2xngL3uJxdsOx9ayhCJ4ydHB8ZH7GQ6bQ=;
        b=jpPgi9krYqUYcylw0zFJEzmD/hmgGHvGgZ2zYOJlnGflPF4R65hOgHm8n1Sc2CVCFJ
         p+Seuz7AUSwav4gifNOzhAeNlzZGG+RLlAgl9k/DaP+Ijmj+xbdGScj9CypJqHKCD9Kv
         4lfZQcAAZ1BQfKcAR/Mm6X6+L7rVHTxF4IBZMG8OxXuvh3+ndgfmusccnNtFfVznoI8k
         ZS1UvmxsPK1fz/Z90zK215NBcCasw8CiySAiBLp3cEwodREOnT3P0nk+9Kn+AYZVjB53
         d8lzinCNJiPAdqRjf5xsv+iebYWGsPsDf+VmPCLzpbehFtG4GdDt99ntNMuqNL6qKr0r
         rPbw==
X-Gm-Message-State: AJcUukfRpFynw7rTDs5Sia+vf9als9M6tJ8FlpczaaCT7GFvoJsndGQ0
        r02XIquTI/q8xleK1wONcVc=
X-Google-Smtp-Source: ALg8bN5abjABjFh2iZQ/7akmu2dLBTgZ1IhZ3w5OJCEbsbxKwyri1AuTuKtXne5lnJY30DqLyGBuyA==
X-Received: by 2002:a1c:5984:: with SMTP id n126mr2061255wmb.62.1546627220870;
        Fri, 04 Jan 2019 10:40:20 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o81sm3055895wmd.10.2019.01.04.10.40.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 10:40:20 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Orgad Shaneh <orgads@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/4] rebase: teach `reset_head()` to optionally skip the worktree
References: <pull.24.git.gitgitgadget@gmail.com>
        <21939140e00d96cf6f76e4c994638fecd3a95639.1545398254.git.gitgitgadget@gmail.com>
        <xmqqpntcclot.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 04 Jan 2019 10:40:20 -0800
In-Reply-To: <xmqqpntcclot.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 04 Jan 2019 10:38:42 -0800")
Message-ID: <xmqq7efkclm3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> This is what the legacy (scripted) rebase does in
>> `move_to_original_branch`, and we will need this functionality in the
>> next commit.
>
> The move-to-original-branch helper does:
>
>     - point $head_name to the commit pointed at by HEAD
>     - point HEAD symref to $head_name
>
> without touching the index or the working tree files.  It's not
> exactly "reset --soft" but more like "switch-branch --soft" ;-)
>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>>  builtin/rebase.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>> index 768bea0da8..303175fdf1 100644
>> --- a/builtin/rebase.c
>> +++ b/builtin/rebase.c
>> @@ -337,6 +337,7 @@ static void add_var(struct strbuf *buf, const char *name, const char *value)
>>  
>>  #define RESET_HEAD_DETACH (1<<0)
>>  #define RESET_HEAD_HARD (1<<1)
>> +#define RESET_HEAD_REFS_ONLY (1<<2)
>
> In the future codebase in 'pu', we have 1<<2 already taken by
> another topic, so I'll tell my rerere database that the bit
> assignment needs to be adjusted.
>
>>  static int reset_head(struct object_id *oid, const char *action,
>>  		      const char *switch_to_branch, unsigned flags,
>> @@ -344,6 +345,7 @@ static int reset_head(struct object_id *oid, const char *action,
>>  {
>>  	unsigned detach_head = flags & RESET_HEAD_DETACH;
>>  	unsigned reset_hard = flags & RESET_HEAD_HARD;
>> +	unsigned refs_only = flags & RESET_HEAD_REFS_ONLY;
>>  	struct object_id head_oid;
>>  	struct tree_desc desc[2] = { { NULL }, { NULL } };
>>  	struct lock_file lock = LOCK_INIT;
>> @@ -359,7 +361,7 @@ static int reset_head(struct object_id *oid, const char *action,
>>  	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
>>  		BUG("Not a fully qualified branch: '%s'", switch_to_branch);
>>  
>> -	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0) {
>> +	if (!refs_only && hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0) {
>>  		ret = -1;
>>  		goto leave_reset_head;
>>  	}
>
> Not touching the index, so no need to lock the index.  Makes sense.
>
>> @@ -372,6 +374,9 @@ static int reset_head(struct object_id *oid, const char *action,
>>  	if (!oid)
>>  		oid = &head_oid;
>>  
>> +	if (flags & RESET_HEAD_REFS_ONLY)
>> +		goto reset_head_refs;
>> +
>
> Why not "refs_only" that we already prepared above???  Are we
> munging that secondary variable before control comes here?
>
> In any case, not touching the index nor the working tree, so no need
> to call into the unpack_trees machinery.  Makes sense.
>
>>  	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
>>  	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
>>  	unpack_tree_opts.head_idx = 1;
>> @@ -412,6 +417,7 @@ static int reset_head(struct object_id *oid, const char *action,
>>  		goto leave_reset_head;
>>  	}
>>  
>> +reset_head_refs:
>>  	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
>
> And the control continues from the point we update the reflog.
> Makes sense.
>
>>  	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : "rebase");
>>  	prefix_len = msg.len;
>
> This helper is touched by two other topics in flight, and that was
> one of the reason why it took a bit longer than usual for me to
> merge this topic.  Please sanity-check the result of the conflict
> resolution at the tip of 'pu' branch.

The topics are os/rebase-runs-post-checkout-hook and nd/backup-log
IIRC.
