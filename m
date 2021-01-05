Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656CCC433E0
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 23:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B6A822E00
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 23:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbhAEXVR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 18:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbhAEXVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 18:21:16 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6A3C061796
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 15:20:36 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c133so979685wme.4
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 15:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KA+w1NPekIGNJKdwaBYeosdvKdU2S8Azbd9f174MzEo=;
        b=K/Q/ne8TnpIntdbYmMv7iodWlw2l+XuU01NWlGKtZr/1rigoNWuCQ5b30dzE7SDDi+
         Kdc3Q+RiJE/H92oYE9mwraCxywnLgWbRlxJoNcirs+QYGOLskh+HtI5aDFPtokjlKT5b
         HjW1KnssTdY10Ki+PPy4wJNM7AOg3tF6SoasCPv66MmfUstTzJ0yhaKFBrHiMdyoFiW4
         35LCw694toGFEVBZRTDM7C96SLpiBfTjoxSVdqWAib7H8lX1tM3WqsWMlJRhJZg/gQ2K
         6u+rxoEnvSj3LYslxrB1FO4Nwf44FhOGgB7mUcdQ5Ot84G0ubFDBhdjsOC6AjG7f2TU2
         h+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KA+w1NPekIGNJKdwaBYeosdvKdU2S8Azbd9f174MzEo=;
        b=ScaHylm55xDNll9Ya8b/g6U26mqGIx7Uu1s7ZB4c+IsDm2p6U/W+gMeEr/BRBFOn8i
         jcuFFLMcALkNuJjU/kxpYRNFqJw+n+SUcFzSnNcTKAtvSllfrBaHkYV6C8YnZLoYRhp3
         lC/D/jfJIKsADeQ8msZFq3C4ge74eWtByTZW7fCbCBfvezmbOz8JSIYNXulrynREqmJI
         krjZ3SBhlLjcY+ObAtast/xAsE0X1W51FZ/ZGSvDb8bjiI0QXUoxa2YcfOL4djVPcJzr
         1ZY96TYEVAMByEtLB41kjMfdxvommLSrXMkWHoAL4NrksuPF31mMSH1m7kKFG60sMTdv
         7klg==
X-Gm-Message-State: AOAM530MWGyOgnh+2lta4oaZdm2SopC8cCDV1kfHrfkftwldo033VZhG
        pIiMf6CvyDcPc6Z8odC88og=
X-Google-Smtp-Source: ABdhPJwUw13EyifBFWYk7TKl0R3iXIdMqqqOwNnwxzCCCuv8rz1pPOrpg/flTTYKlnS4RSsrmMTPkA==
X-Received: by 2002:a7b:c306:: with SMTP id k6mr1186416wmj.52.1609888835206;
        Tue, 05 Jan 2021 15:20:35 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-654-1-420-166.w2-6.abo.wanadoo.fr. [2.6.83.166])
        by smtp.gmail.com with ESMTPSA id t10sm707108wrp.39.2021.01.05.15.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 15:20:34 -0800 (PST)
Subject: Re: [PATCH v6 06/13] merge-index: don't fork if the requested program
 is `git-merge-one-file'
To:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <20201116102158.8365-1-alban.gruin@gmail.com>
 <20201124115315.13311-1-alban.gruin@gmail.com>
 <20201124115315.13311-7-alban.gruin@gmail.com>
 <44c9189d-9d2f-c437-d0d6-9529708d2c99@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Message-ID: <411b68ad-dee5-5a19-ae94-c2b6a249161a@gmail.com>
Date:   Wed, 6 Jan 2021 00:20:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <44c9189d-9d2f-c437-d0d6-9529708d2c99@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 05/01/2021 à 17:11, Derrick Stolee a écrit :
> On 11/24/2020 6:53 AM, Alban Gruin wrote:
>> +
>>  	pgm = argv[i++];
>> +	setup_work_tree();
>> +
>> +	if (!strcmp(pgm, "git-merge-one-file")) {
> 
> This stood out to me as possibly fragile. What if we call the
> non-dashed form "git merge-one-file"? Shouldn't we be doing so?
> 
> Or, is this something that is handled higher in the builtin
> machinery to take the non-dashed version and change it to the
> dashed version for historical reasons?
> 

We had the same discussion with Phillip, who pointed out this previous
discussion about this topic:
https://lore.kernel.org/git/xmqqblv5kr9u.fsf@gitster-ct.c.googlers.com/

So, it's probably OK to do that.

>> +		merge_action = merge_one_file_func;
>> +		hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
>> +	} else {
>> +		merge_action = merge_one_file_spawn;
>> +		data = (void *)pgm;
>> +	}
>> +
> 
> ...
> 
>> +	if (merge_action == merge_one_file_func) {
> 
> nit: This made me think it would be better to check the 'lock'
> itself to see if it was initialized or not. Perhaps
> 
> 	if (lock.tempfile) {
> 
> would be the appropriate way to check this?
> 
> For now, this is equivalent behavior, but it might be helpful if
> we add more cases that take the lock in the future.
> 
>> +		if (err) {
>> +			rollback_lock_file(&lock);
>> +			return err;
>> +		}
>> +
>> +		return write_locked_index(&the_index, &lock, COMMIT_LOCK);
>>  	}
>>  	return err;
> 
> nit: this could be simplified. In total, I recommend:
> 
> 	if (lock.tempfile) {
> 		if (err)
> 			rollback_lock_file(&lock);
> 		else
> 			return write_locked_index(&the_index, &lock, COMMIT_LOCK);
> 	}
> 	return err;
> 

Sure, looks better than mine.  :)

> 
>>  }
>> diff --git a/merge-strategies.c b/merge-strategies.c
>> index 6f27e66dfe..542cefcf3d 100644
>> --- a/merge-strategies.c
>> +++ b/merge-strategies.c
>> @@ -178,6 +178,18 @@ int merge_three_way(struct repository *r,
>>  	return 0;
>>  }
>>  
>> +int merge_one_file_func(struct repository *r,
>> +			const struct object_id *orig_blob,
>> +			const struct object_id *our_blob,
>> +			const struct object_id *their_blob, const char *path,
>> +			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
>> +			void *data)
>> +{
>> +	return merge_three_way(r,
>> +			       orig_blob, our_blob, their_blob, path,
>> +			       orig_mode, our_mode, their_mode);
>> +}
>> +
> 
> Again, I don't recommend making this callback in the library. Instead, keep
> it in the builtin and then use merge_three_way() which is in the library.
> 

This is not possible with this callback, as it will be used later by
merge_strategies_resolve() and indirectly by merge_strategies_octopus().

>>  int merge_one_file_spawn(struct repository *r,
>>  			 const struct object_id *orig_blob,
>>  			 const struct object_id *our_blob,
>> @@ -261,17 +273,22 @@ int merge_all_index(struct repository *r, int oneshot, int quiet,
>>  		    merge_fn fn, void *data)
>>  {
>>  	int err = 0, ret;
>> -	unsigned int i;
>> +	unsigned int i, prev_nr;
>>  
>>  	for (i = 0; i < r->index->cache_nr; i++) {
>>  		const struct cache_entry *ce = r->index->cache[i];
>>  		if (!ce_stage(ce))
>>  			continue;
>>  
>> +		prev_nr = r->index->cache_nr;
>>  		ret = merge_entry(r, quiet || oneshot, i, ce->name, &err, fn, data);
>> -		if (ret > 0)
>> -			i += ret - 1;
>> -		else if (ret == -1)
>> +		if (ret > 0) {
>> +			/* Don't bother handling an index that has
>> +			   grown, since merge_one_file_func() can't grow
>> +			   it, and merge_one_file_spawn() can't change
>> +			   it. */
> 
> multi-line comment style is as follows:
> 
> 	/*
> 	 * Don't bother handling an index that has
> 	 * grown, since merge_one_file_func() can't grow
> 	 * it, and merge_one_file_spawn() can't change it.
> 	 */
> 
> Thanks,
> -Stolee
> 

