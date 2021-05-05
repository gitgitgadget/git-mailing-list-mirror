Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40088C433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 09:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF4DF61029
	for <git@archiver.kernel.org>; Wed,  5 May 2021 09:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhEEJfb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 05:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbhEEJf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 05:35:29 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB9AC061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 02:34:32 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z6so1069817wrm.4
        for <git@vger.kernel.org>; Wed, 05 May 2021 02:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mOu2z9LoeJaWoQhFOFlC2qGN6GKt50CNPePgy1lpi2c=;
        b=qlCk5BtmfVRX34kYXEoh40Hx7gpBz+GSjgoNJNDHUYo1+EYmFLZv6oDWtKR73oVq5l
         xweKBdl9xx4k4DKlGLrbDQ8wefihbXOBbeJKrz28tUyB9N7sT+551m5fN457NlwUdteb
         Z4EQlWxYAWQ4VjQ6gDeTCaoZIBa5LO+QsVXxVeoDHQdHgvvRedNzrJykf1X62ek0n5qp
         qLcwkmTKbMGzLfHcFv0nQwKCzHbh/9U/ixiJ0JnWoFqbSw0+5Gfp7tSJ6nVxXx+fZlJg
         zMeUWNvkBv30+TTYlKE26LwCMNonZv6wHCUSMnGvZpb0OGtMI+FJgJmW7QS3eVKf6LRO
         TgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mOu2z9LoeJaWoQhFOFlC2qGN6GKt50CNPePgy1lpi2c=;
        b=mwQhWTzzR6V1auFscsow2qYgssfow40rtkRtx2/UnoK2g7zoMKup/C65K5SrdlutjE
         AkOSLdg7SEW/ys3PCZodcnTO9oDGQjmimBLJmpskmmllpULMOzqpgiB0iRHqs2YgQJT1
         7YtPLNQA08a8tcmHOqOH7vSRCgey4p3v8dOHTGonMbyR9rwoMokAdF/QMaFYm45iGXFn
         N9e5H7R5V1H66QCvmbo/JJFQozira9Kmx1B8HMLMEvKhFk3/0rTSFCRmW7E4Z6X7tctl
         V7uWtaP0tRpllUEToScQ7+pokL5rSmpRvw6lc2IhJ+7LiJybVi9kghGK2b8gy+VffnW9
         iVsA==
X-Gm-Message-State: AOAM53312A2G6EsFj6bZ9goGC/GZtQzIOJgGvDy3jeuBy5u2FxxR2ysl
        rJGv19aC9ZDU5ShrE0B0xPI=
X-Google-Smtp-Source: ABdhPJwczQ0tbxpNeBefzlYqKW3nxm+CPODvDskD6EEmINORuleZSq/dVEKJNh3KaDUXE9/bQyStrQ==
X-Received: by 2002:adf:e8ce:: with SMTP id k14mr18755449wrn.362.1620207271157;
        Wed, 05 May 2021 02:34:31 -0700 (PDT)
Received: from [192.168.1.240] (61.22.198.146.dyn.plus.net. [146.198.22.61])
        by smtp.gmail.com with ESMTPSA id l14sm5044099wmq.4.2021.05.05.02.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 02:34:30 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] patience diff: remove unnecessary string comparisons
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.948.git.1620120345.gitgitgadget@gmail.com>
 <a339d1cf9b9ffd6365fca3efda8fb7e10346dda4.1620120345.git.gitgitgadget@gmail.com>
 <xmqqpmy658e1.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <87001425-8043-4c66-dbc2-637f05a7229f@gmail.com>
Date:   Wed, 5 May 2021 10:34:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <xmqqpmy658e1.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/05/2021 01:31, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> xdl_prepare_env() calls xdl_classify_record() which arranges for the
>> hashes of non-matching lines to be different so lines can be tested
>> for equality by comparing just their hashes.
> 
> Hmph, that is a bit different from what I read from the comment in
> the post context of the first hunk, though.
> 
> 	/*
> 	 * After xdl_prepare_env() (or more precisely, due to
> 	 * xdl_classify_record()), the "ha" member of the records (AKA lines)
> 	 * is _not_ the hash anymore, but a linearized version of it.  In
> 	 * other words, the "ha" member is guaranteed to start with 0 and
> 	 * the second record's ha can only be 0 or 1, etc.
> 	 *
> 	 * So we multiply ha by 2 in the hope that the hashing was
> 	 * "unique enough".
> 	 */
> 
> The words "home" and "enough" hints to me that the "ha" member is
> not hash, but "lineralized version of it" (whatever it means) does
> not guarantee that two records with the same "ha" are identical, or
> does it?

By "hashes" I meant "the value of record->ha". That comment is a bit 
confusing. I think "linearized version of it" is referring to 
xdl_classify_record() assigning a unique integer to each unique input 
line starting from zero and increasing by one for each unique input line 
(the function is fairly easy to follow). I assume "unique enough" is 
referring to the line below the comment which takes the modulus of 
record->ha and record->ha is not evenly distributed over the whole 
integer range but bunched at the lower end.

The Myers implementation calls xdl_classify_record() and then only ever 
compares record->ha, it does not call xdl_recmatch() while computing the 
diff.

> Well, I should just go read xdl_classify_record() to see what it
> really does, but if it eliminates collisions, then the patch is a
> clear and obvious improvement.

Thanks

Phillip


> Thanks.
> 
>> diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
>> index 20699a6f6054..db2d53e89cb0 100644
>> --- a/xdiff/xpatience.c
>> +++ b/xdiff/xpatience.c
>> @@ -90,7 +90,7 @@ static void insert_record(xpparam_t const *xpp, int line, struct hashmap *map,
>>   {
>>   	xrecord_t **records = pass == 1 ?
>>   		map->env->xdf1.recs : map->env->xdf2.recs;
>> -	xrecord_t *record = records[line - 1], *other;
>> +	xrecord_t *record = records[line - 1];
>>   	/*
>>   	 * After xdl_prepare_env() (or more precisely, due to
>>   	 * xdl_classify_record()), the "ha" member of the records (AKA lines)
>> @@ -104,11 +104,7 @@ static void insert_record(xpparam_t const *xpp, int line, struct hashmap *map,
>>   	int index = (int)((record->ha << 1) % map->alloc);
>>   
>>   	while (map->entries[index].line1) {
>> -		other = map->env->xdf1.recs[map->entries[index].line1 - 1];
>> -		if (map->entries[index].hash != record->ha ||
>> -				!xdl_recmatch(record->ptr, record->size,
>> -					other->ptr, other->size,
>> -					map->xpp->flags)) {
>> +		if (map->entries[index].hash != record->ha) {
>>   			if (++index >= map->alloc)
>>   				index = 0;
>>   			continue;
>> @@ -253,8 +249,7 @@ static int match(struct hashmap *map, int line1, int line2)
>>   {
>>   	xrecord_t *record1 = map->env->xdf1.recs[line1 - 1];
>>   	xrecord_t *record2 = map->env->xdf2.recs[line2 - 1];
>> -	return xdl_recmatch(record1->ptr, record1->size,
>> -		record2->ptr, record2->size, map->xpp->flags);
>> +	return record1->ha == record2->ha;
>>   }
>>   
>>   static int patience_diff(mmfile_t *file1, mmfile_t *file2,
