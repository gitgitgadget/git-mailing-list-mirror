Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C783C6FD1D
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 18:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjCQSal (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 14:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjCQSak (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 14:30:40 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEE94AFC2
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 11:30:38 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id m20-20020a9d6094000000b0069caf591747so3354860otj.2
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 11:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1679077838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iR0FY1mOJLtSy7W2PPIpgWJ9/BrcHDzlJ9NxuBQDejU=;
        b=RaQWgfn+O6878AtD//KBcslZRpQNX+rT1Gi3Y23t9UJg3+sJbNgosBWLeT5kVYI10I
         6thsX0hpdqTC4lwuii9LHPQeTG8U7uC7pI7CkODko/DMqNs6gzyt13/BP3gVNq4OWhzX
         GYwFe9lZuxKGbPjSMXWi4pfN6L/i4ClARBX853v6eyMgw6Mzi0zORmaSbPa14DwPq9K1
         iTTE1lW5MnyHDfLNdkCe0mPuEEfzIm+r+31HYpbAF8GDgQe28pm/kgJ319e2hqGmJJTc
         PJgdjX2pM5YQACr6EpL0ehLbZLsJwsUXEZ+b92S9hyiSVsq+UoVEdG9BJbxsCkrWij8T
         1+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679077838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iR0FY1mOJLtSy7W2PPIpgWJ9/BrcHDzlJ9NxuBQDejU=;
        b=umL7LIMbvZqJPVPvzJsQS6SOdZbQZwKeAcD9cduw0KDm9KLy0GQ0s0StOWmNDmvD2N
         r1THTi2bbO6EC7z3bvhYN1uafbgmRUxjdWLIM9fIEI1A7LNEZqE/C1zTh2byLoe+BeWl
         8Pc9XojzZwO5Q8wjU21Dnx/Xak8J8PpzH0iitAPZDR5nU/1fUc6L5eMnhSVSUBUBsuf9
         qfYyQrifabs+RIzDJ+ThMc/2/KwzFXdodV4LrbkoMQf1DZgV2Xg1MCnVqTDXfwD4kaWi
         QuCgyCqaA6myN8UtHKkbHZfzpXDB7DW4ULis0oLezgZaLWcD05nJe7kjEAEDYzDt3sEO
         c8LA==
X-Gm-Message-State: AO0yUKWfODJlm5qw4bzj4rNuB5EcJk1+wRD6p7ZZ3KktWWxxpdmawLXV
        m4lFR/GSSdREnaZNgK6KNFPn
X-Google-Smtp-Source: AK7set9Age68LggEiI7+yi9BesZpQQzDcyNY0Lw6R1QCW2KAv4ysnaMZ9ekKzeZ59Wj581LFkvm25A==
X-Received: by 2002:a05:6830:1385:b0:68e:da51:2cb2 with SMTP id d5-20020a056830138500b0068eda512cb2mr209799otq.37.1679077838044;
        Fri, 17 Mar 2023 11:30:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:b55b:7e6b:71e6:ade7? ([2600:1700:e72:80a0:b55b:7e6b:71e6:ade7])
        by smtp.gmail.com with ESMTPSA id q17-20020a9d7c91000000b006884c42a38asm1265697otn.41.2023.03.17.11.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 11:30:37 -0700 (PDT)
Message-ID: <d4ac5ab2-e5e5-e894-04e0-b99249dfeced@github.com>
Date:   Fri, 17 Mar 2023 14:30:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 3/8] commit-graph: combine generation computations
To:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20230315224958.169443-1-jonathantanmy@google.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20230315224958.169443-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/15/2023 6:49 PM, Jonathan Tan wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> +static void compute_reachable_generation_numbers_1(
>> +			struct compute_generation_info *info,
>> +			int generation_version)
>>  {
>>  	int i;
>>  	struct commit_list *list = NULL;
>>  
>> -	if (ctx->report_progress)
>> -		ctx->progress = start_delayed_progress(
>> -					_("Computing commit graph topological levels"),
>> -					ctx->commits.nr);
>> -	for (i = 0; i < ctx->commits.nr; i++) {
>> -		struct commit *c = ctx->commits.list[i];
>> -		uint32_t level;
>> +	for (i = 0; i < info->commits->nr; i++) {
>> +		struct commit *c = info->commits->list[i];
>> +		timestamp_t gen;
>> +		repo_parse_commit(info->r, c);
>> +		gen = info->get_generation(c, info->data);
>>  
>> -		repo_parse_commit(ctx->r, c);
>> -		level = *topo_level_slab_at(ctx->topo_levels, c);
>> +		display_progress(info->progress, info->progress_cnt + 1);
>>  
>> -		display_progress(ctx->progress, i + 1);
>> -		if (level != GENERATION_NUMBER_ZERO)
>> +		if (gen != GENERATION_NUMBER_ZERO && gen != GENERATION_NUMBER_INFINITY)
>>  			continue;
>>  
>>  		commit_list_insert(c, &list);
> 
> So this replaces a call to display_progress with another...
> 
>>  			if (all_parents_computed) {
>>  				pop_commit(&list);
>> -
>> -				if (max_level > GENERATION_NUMBER_V1_MAX - 1)
>> -					max_level = GENERATION_NUMBER_V1_MAX - 1;
>> -				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
>> +				gen = compute_generation_from_max(
>> +						current, max_gen,
>> +						generation_version);
>> +				info->set_generation(current, gen, info->data);
>>  			}
> 
> ...here is where set_generation is called...
> 
>> +static void set_topo_level(struct commit *c, timestamp_t t, void *data)
>> +{
>> +	struct write_commit_graph_context *ctx = data;
>> +	*topo_level_slab_at(ctx->topo_levels, c) = (uint32_t)t;
>> +	display_progress(ctx->progress, ctx->progress_cnt + 1);
>> +}
> 
> ...is this display_progress() redundant? (set_topo_level() is one of the
> possibilities that set_generation could be assigned to.) There already
> seems to be one at the top. Further supporting my query is the fact that
> in the hunk containing set_generation, there is no progress report on
> the LHS of the diff.

It turns out the progress is a bit redundant here, but not entirely in
the case of ensure_generations_valid() (if progress was enabled).

Let's break down the iteration, which has nested loops:

 1. for all commits in the initial list.
   2. perform DFS until generation can be computed. (while loop)

When writing a commit-graph file, that initial list is _every commit
in the commit-graph_, so having a display_progress() in the for loop
is sufficient to get the exact number.

In the case of ensure_generations_valid(), the number of assignments
in the while loop can be much larger than the initial input list.

However, ensure_generations_valid() does not use progress _and_ even
if it did, it would make sense to signal progress based on the number
of tips that need to be computed. I'll remove these progress counts
inside the mutators.

Thanks,
-Stolee
