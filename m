Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07EDC433DF
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 12:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81D982072F
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 12:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWvfGWPs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgFHMfk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgFHMfk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 08:35:40 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC02C08C5C2
        for <git@vger.kernel.org>; Mon,  8 Jun 2020 05:35:38 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id s13so13449668otd.7
        for <git@vger.kernel.org>; Mon, 08 Jun 2020 05:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L73tLsoNOC2JtZ+RSdNjU7hecAH3j0BjOWOPNMjeDGA=;
        b=oWvfGWPs2M3XZg6LGOwSnpN6JnX+PV45LalySLglA25mDbX6w5EjyGOrHxPWsRUlrP
         uT3HggQcfKqzo4SI+b/DdwR570ap7XKOr4n+u0uN6YY5B7xNOQYcqc9qVzwWhhPWPuZU
         VLoCQFXMvt9MSVskrWTvG0akn0WA1iS20RCBozg33X/KPcZlvuGCBvCmKKheNQTbAWgk
         npJDnvtZewQ4ZvsFls53OdVdbFve7sERUIa4Mhji9da0LTL3io/tCUmu6QNt0nlKetrI
         qOx192b/AH2B+AxgSTQE41EyGx1mKta9kbwxHXA3i8DDWUvuzQg4q71x44kHmed/Bsbf
         37hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L73tLsoNOC2JtZ+RSdNjU7hecAH3j0BjOWOPNMjeDGA=;
        b=SqopSBqHoR5Evrfg9dvjsg+o8r8+0w2ifBf5BSOs9uMCzZg60VSQlWabLmutQdRsLB
         FbI/UuUqKq0HcZMtkLCfZe29AtA/bPQ68DwJRPI6Oz9Nl3pINqt5Wj+6HIaj1MT+ZbXS
         qiPFpZEJWCGqh3/l5Ge7jWLgdXEAQBq7By2Cy7zle2liZjAAzHcHb1lGhZv+rqNzVbrh
         8MUQ6NxKuWWBMDycHFy4AOcqYPPTr5zwJ/AM/OkeyggLIs1+NscXB3A/8qEL7x7X6WCj
         6ZYk3JMMVyu4biowdK5x/zQO+I3fAu4CXL6IcsT9YULU+llz7s8XJW4JwR/HASEigoiH
         dWbg==
X-Gm-Message-State: AOAM531XWFxGt0jjOG6XuEskeJna3EV4N03Rfsu/CA3gO8F1ab15H7Aj
        IWqG10r/B4Vp37vGKNgbc71gE4YFYi4=
X-Google-Smtp-Source: ABdhPJxpYMjtX+ZyqK+OEGzoaW0hJNO71ImhWzSwebJSspm6lO0JT5o402rTpTdvcsFez6ocfwWqeA==
X-Received: by 2002:a05:6830:1441:: with SMTP id w1mr16731303otp.372.1591619737164;
        Mon, 08 Jun 2020 05:35:37 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id y16sm2368575oot.11.2020.06.08.05.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 05:35:36 -0700 (PDT)
Subject: Re: [GSOC Patch v2 2/4] commit: move members graph_pos, generation to
 a slab
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org, jnareb@gmail.com
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
 <20200607193237.699335-1-abhishekkumar8222@gmail.com>
 <20200607193237.699335-3-abhishekkumar8222@gmail.com>
 <20200608082636.GC8232@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c9333a2d-a0d7-0fe4-e485-7d28b703506a@gmail.com>
Date:   Mon, 8 Jun 2020 08:35:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <20200608082636.GC8232@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/8/2020 4:26 AM, SZEDER Gábor wrote:
> On Mon, Jun 08, 2020 at 01:02:35AM +0530, Abhishek Kumar wrote:
>> diff --git a/commit-graph.c b/commit-graph.c
>> index 7d887a6a2c..f7cca4def4 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
> 
>> @@ -1302,8 +1302,8 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
>>  					ctx->commits.nr);
>>  	for (i = 0; i < ctx->commits.nr; i++) {
>>  		display_progress(ctx->progress, i + 1);
>> -		if (ctx->commits.list[i]->generation != GENERATION_NUMBER_INFINITY &&
>> -		    ctx->commits.list[i]->generation != GENERATION_NUMBER_ZERO)
>> +		if (commit_graph_generation(ctx->commits.list[i]) != GENERATION_NUMBER_INFINITY &&
>> +		    commit_graph_generation(ctx->commits.list[i]) != GENERATION_NUMBER_ZERO)
>>  			continue;
>>  
>>  		commit_list_insert(ctx->commits.list[i], &list);
>> @@ -1314,22 +1314,22 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
>>  			uint32_t max_generation = 0;
>>  
>>  			for (parent = current->parents; parent; parent = parent->next) {
>> -				if (parent->item->generation == GENERATION_NUMBER_INFINITY ||
>> -				    parent->item->generation == GENERATION_NUMBER_ZERO) {
>> +				if (commit_graph_generation(parent->item) == GENERATION_NUMBER_INFINITY ||
>> +				    commit_graph_generation(parent->item) == GENERATION_NUMBER_ZERO) {
>>  					all_parents_computed = 0;
>>  					commit_list_insert(parent->item, &list);
>>  					break;
>> -				} else if (parent->item->generation > max_generation) {
>> -					max_generation = parent->item->generation;
>> +				} else if (commit_graph_generation(parent->item) > max_generation) {
>> +					max_generation = commit_graph_generation(parent->item);
>>  				}
>>  			}
>>  
>>  			if (all_parents_computed) {
>> -				current->generation = max_generation + 1;
>> +				commit_graph_data_at(current)->generation = max_generation + 1;
>>  				pop_commit(&list);
>>  
>> -				if (current->generation > GENERATION_NUMBER_MAX)
>> -					current->generation = GENERATION_NUMBER_MAX;
>> +				if (commit_graph_generation(current) > GENERATION_NUMBER_MAX)
>> +					commit_graph_data_at(current)->generation = GENERATION_NUMBER_MAX;
>>  			}
>>  		}
>>  	}
> 
> Something about these conversions is not right, as they send
> compute_generation_numbers() into an endless loop, and
> 't5318-commit-graph.sh' hangs because of this.

Abhishek responded off-list, but it's worth having the discussion
here, too.

While the next patch fixes the bug introduced here, we strive to
have every patch compile and pass all tests on all platforms. It
can be hard to verify that last "all platforms" condition, but
we can run (most) tests on each of our patches using the following:

$ git rebase -x "make -j12 DEVELOPER=1 && (cd t && prove -j8 t[0-8]*.sh)" <base>

Thanks, Szeder, for finding this issue in the patch.

Looking at this patch and patch 3, I think you should just squash that patch
into this one, since the code you are removing in patch 3 was added by this
one. Add a paragraph in your commit message that details why we need to use
commit_graph_data_at() directly in write_graph_chunk_data() and
compute_generation_numbers().

Thanks,
-Stolee
