Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2230C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 14:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC59F60E74
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 14:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhJFODQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 10:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238226AbhJFODP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 10:03:15 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661D3C061749
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 07:01:22 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id s15so9174813wrv.11
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 07:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N3cslW84CyM68ivmphUrrwd7oxpuYRdBxhesyFeQHt4=;
        b=ec3vMF8YHsrgG2PF4YS/JwICvS0pdht4l5WFQogutzzLd0xmKA5JRM06D2iFmr3o8k
         El2LpjepHfqz/T95flbPiaqaAMfQNQpaucGw3ov8X57ytOUXqUFWaJyhGSKgbi1rN8A9
         7YuAmKuRsPOvupz9JcHIoDkcvNmg1SPh2F+ngoKoNqGTM1CSmY9ChBMJtyN2x/69cKHX
         EzIqQc2I9AtwVTGUsVY7OD1XAqcxIr1zTJx2POVC7+SddRI4NA55N8ATRLShMPCUEZM7
         1SpIcKzRBPX0z4ha+smAiNx1NZZb5Y0pheXA64+Lb7o7TVfhkY6ncLPQeLQwz//ooJEp
         ydBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N3cslW84CyM68ivmphUrrwd7oxpuYRdBxhesyFeQHt4=;
        b=eS+B73iYAeZyYjCcvn+SE9bubLQAUn/5j08P9cT4SmyP1i+Kkx+vft4AYKbeTcsQxN
         uCkuifXBUilyh2fo7TSv2jv9uBV8aCdd0bwdDNttWfUpXS4XUD8d5yaOUqxAfw4q8xs1
         I9QauV9u7kPMsP0+SnsY9LfTYiVeeEf5q1xNH+ANnN3ZV2kIcQNPlgNDaIDEdq9aNuAM
         6hqzpe2SIo8OpQYrvnNLWGbjSOmOhUCYEUV4NIYHqjNSu1h9y6o0eLryryR9hivBFBJ8
         GVCmajlb6INN5CDrP1B5BqE1MZ6GLkWJTQZ8cstNLZec71EiKgLcs1svCcp+oFKmBkm/
         oHjQ==
X-Gm-Message-State: AOAM532+ZhlIf9ATXRRpvbLUyZTWl+a5wDRska6+fy+Lz7PwG6rV/OBk
        GAUJj3VwiCLbCmfx/31F5VA=
X-Google-Smtp-Source: ABdhPJyQp1cdpWcjXGYipXRSqut90D6P19LvdUrvNgEsSbSFZaTdtH3pxF3IUIt3V8kUe9GTefa+kg==
X-Received: by 2002:a1c:43c3:: with SMTP id q186mr9856443wma.143.1633528880983;
        Wed, 06 Oct 2021 07:01:20 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id k188sm5501193wme.44.2021.10.06.07.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 07:01:20 -0700 (PDT)
Message-ID: <cfd6f82d-01c3-d6be-a535-76255e599c89@gmail.com>
Date:   Wed, 6 Oct 2021 15:01:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] [RFC] sparse index: fix use-after-free bug in
 cache_tree_verify()
Content-Language: en-GB-large
To:     Derrick Stolee <stolee@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, vdye@github.com
References: <pull.1053.git.1633512591608.gitgitgadget@gmail.com>
 <2b1f0e56-5bb4-7f41-5a1e-d8a21096084a@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <2b1f0e56-5bb4-7f41-5a1e-d8a21096084a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 06/10/2021 12:20, Derrick Stolee wrote:
> On 10/6/2021 5:29 AM, Phillip Wood via GitGitGadget wrote:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> In a sparse index it is possible for the tree that is being verified
>> to be freed while it is being verified. This happens when
>> index_name_pos() looks up a entry that is missing from the index and
>> that would be a descendant of a sparse entry. That triggers a call to
>> ensure_full_index() which frees the cache tree that is being verified.
>> Carrying on trying to verify the tree after this results in a
>> use-after-free bug. Instead restart the verification if a sparse index
>> is converted to a full index. This bug is triggered by a call to
>> reset_head() in "git rebase --apply". Thanks to René Scharfe for his
>> help analyzing the problem.
> 
> Thank you for identifying an interesting case! I hadn't thought to
> change the mode from --merge to --apply.

Thanks, I can't really take much credit for that though - Junio pointed 
out that my patch converting the merge based rebase to use the same 
checkout code as the apply based rebase broke a test in seen and René 
diagnosed the problem.

>>      In a sparse index it is possible for the tree that is being verified to
>>      be freed while it is being verified. This is an RFC as I'm not familiar
>>      with the cache tree code. I'm confused as to why this bug is triggered
>>      by the sequence
>>      
>>      unpack_trees()
>>      prime_cache_tree()
>>      write_locked_index()
>>      
>>      but not
>>      
>>      unpack_trees()
>>      write_locked_index()
>>      
>>      
>>      as unpack_trees() appears to update the cache tree with
>>      
>>      if (!cache_tree_fully_valid(o->result.cache_tree))
>>                  cache_tree_update(&o->result,
>>                            WRITE_TREE_SILENT |
>>                            WRITE_TREE_REPAIR);
>>      
>>      
>>      and I don't understand why the cache tree from prime_cache_tree()
>>      results in different behavior. It concerns me that this fix is hiding
>>      another bug.
> 
> prime_cache_tree() appears to clear the cache tree and start from scratch
> from a tree object instead of using the index.
> 
> In particular, prime_cache_tree_rec() does not stop at the sparse-checkout
> cone, so the cache tree is the full size at that point.
> 
> When the verify_one() method reaches these nodes that are outside of the
> cone, index_name_pos() triggers the index expansion in a way that the
> cache-tree that is restricted to the sparse-checkout cone does not.
> 
> Hopefully that helps clear up _why_ this happens.

It does thanks - we end up with a full cache tree but a sparse index

> There is a remaining issue that "git rebase --apply" will be a lot slower
> than "git rebase --merge" because of this construction of a cache-tree
> that is much larger than necessary.
> 
> I will make note of this as a potential improvement for the future.

I think I'm going to remove the call to prime_cache_tree(). Correct me 
if I'm wrong but as I understand it unpack_trees() updates the cache 
tree so the call to prime_cache_tree() is not needed (I think it was 
copied from builtin/rebase.c which does need to call prime_cache_tree() 
if it has updated a few paths rather than the whole top-level tree). In 
any case I've just noticed that one of Victoria's patches[1] looks like 
it fixes prime_cache_tree() with a sparse index.

[1] 
https://lore.kernel.org/git/78cd85d8dcc790251ce8235e649902cf6adf091a.1633440057.git.gitgitgadget@gmail.com/

>> -static void verify_one(struct repository *r,
>> -		       struct index_state *istate,
>> -		       struct cache_tree *it,
>> -		       struct strbuf *path)
>> +static int verify_one(struct repository *r,
>> +		      struct index_state *istate,
>> +		      struct cache_tree *it,
>> +		      struct strbuf *path)
>>   {
>>   	int i, pos, len = path->len;
>>   	struct strbuf tree_buf = STRBUF_INIT;
>> @@ -837,21 +837,30 @@ static void verify_one(struct repository *r,
>>   
>>   	for (i = 0; i < it->subtree_nr; i++) {
>>   		strbuf_addf(path, "%s/", it->down[i]->name);
>> -		verify_one(r, istate, it->down[i]->cache_tree, path);
>> +		if (verify_one(r, istate, it->down[i]->cache_tree, path))
>> +			return 1;
>>   		strbuf_setlen(path, len);
>>   	}
>>   
>>   	if (it->entry_count < 0 ||
>>   	    /* no verification on tests (t7003) that replace trees */
>>   	    lookup_replace_object(r, &it->oid) != &it->oid)
>> -		return;
>> +		return 0;
>>   
>>   	if (path->len) {
>> +		/*
>> +		 * If the index is sparse index_name_pos() may trigger
>> +		 * ensure_full_index() which will free the tree that is being
>> +		 * verified.
>> +		 */
>> +		int is_sparse = istate->sparse_index;
>>   		pos = index_name_pos(istate, path->buf, path->len);
>> +		if (is_sparse && !istate->sparse_index)
>> +			return 1;
> 
> I think this guard is good to have, even if we fix prime_cache_tree() to
> avoid triggering expansion here in most cases.
> 
>>   		if (pos >= 0) {
>>   			verify_one_sparse(r, istate, it, path, pos);
>> -			return;
>> +			return 0;
>>   		}
>>   
>>   		pos = -pos - 1;
>> @@ -899,6 +908,7 @@ static void verify_one(struct repository *r,
>>   		    oid_to_hex(&new_oid), oid_to_hex(&it->oid));
>>   	strbuf_setlen(path, len);
>>   	strbuf_release(&tree_buf);
>> +	return 0;
>>   }
>>   
>>   void cache_tree_verify(struct repository *r, struct index_state *istate)
>> @@ -907,6 +917,9 @@ void cache_tree_verify(struct repository *r, struct index_state *istate)
>>   
>>   	if (!istate->cache_tree)
>>   		return;
>> -	verify_one(r, istate, istate->cache_tree, &path);
>> +	if (verify_one(r, istate, istate->cache_tree, &path)) {
>> +		strbuf_reset(&path);
>> +		verify_one(r, istate, istate->cache_tree, &path);
>> +	}
> 
> And this limits us to doing at most two passes. Good.

In theory ensure_full_index() will only ever be called once but I wanted 
to make sure we could not get into an infinite loop.

>>   test_expect_success 'merge, cherry-pick, and rebase' '
>>   	init_repos &&
>>   
>> -	for OPERATION in "merge -m merge" cherry-pick rebase
>> +	for OPERATION in "merge -m merge" cherry-pick "rebase --apply" "rebase --merge"
> 
> Thank you for the additional test!

Thanks for your explanation and looking at the patch

Best Wishes

Phillip

> Thanks,
> -Stolee
> 
