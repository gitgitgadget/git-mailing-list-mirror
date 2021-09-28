Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC179C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 10:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1E286113E
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 10:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240164AbhI1KWi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 06:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240148AbhI1KWh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 06:22:37 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2D7C061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 03:20:58 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id z184-20020a1c7ec1000000b003065f0bc631so1807690wmc.0
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 03:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lMAwqKRqK4ek/w+9XBBokuxnIdkTlJcUGkhsRryv4x0=;
        b=bXEO292c0tTw6laEpaRstTTwrNLxvb4m4+vuQfhexhRqBw/y3SgqoPnoDYx4GpqFRb
         9saVBP2z3xBmBfRtS3pb6GmZ+ow8+JlBgMf1YyMMu4RZmRSzeoLfXPOBD5xZpkAlL4bY
         6Ooj3gcv38LJSGnFqrODMqY8ATui2HG8khpHESWxaTqtHPpH3mDKGd2h+Lz1BfDlHkJj
         sCvbIvmKTTdrtvIP5r37ZJ/Gls6CWBh91h4aTQfm2bfoQb9cowBnF3IDrelnNO0Q6NwI
         RaV7jU7XuP0rkz+olmPePuASfMtbPS1tgg0An9Y9bUKoiEd9YeZ5Jf+f4izxWkCQwyRT
         4hCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lMAwqKRqK4ek/w+9XBBokuxnIdkTlJcUGkhsRryv4x0=;
        b=sOyVDKRb88DFDdplp1/1czT25Q8NJ64c1JzZxU9EDNd+BaeYpSncZhX9Wg3wLxBbFr
         uys3pDsNBB1adcZudKHpiPG3LpLvOkqJpG4xy+gL/PT+rJAmx0t0zh3MuLmHwMHTEEhM
         L2CQKD05zxNsVDzQPknu7PsxOlQ1oUAUF087CieT0L/939LvZ+0LaPmmaez9SySRhHAI
         6F2dvLkFEarAAOzUFYyrJAyZ0sc2HSWTnOIqHpta1GLXVm3KReLs92/GMeDD01VG92YJ
         2b+F2nL3DT4giqQauCC6L7jC2WZSKs890C3teFZlvskVc3ZkHhIcwWei7RbeQYhOnBPe
         EhVA==
X-Gm-Message-State: AOAM5317b1eBmGoeZ8Aj0b7hrAxUVcP7Kg+gyEgjHf7NreENsZEasXIE
        K4rCq09jA6IuVVO0NJZ0D2A=
X-Google-Smtp-Source: ABdhPJw67j2aMYGsm0Bf+YS08EbEPqfNDP6QoBwhfOv0i52kS968yNpwstkOsD0zw/cDVUAcW/GVew==
X-Received: by 2002:a1c:1d89:: with SMTP id d131mr537452wmd.10.1632824456948;
        Tue, 28 Sep 2021 03:20:56 -0700 (PDT)
Received: from [192.168.1.201] (178.2.7.51.dyn.plus.net. [51.7.2.178])
        by smtp.googlemail.com with ESMTPSA id o5sm7960677wrf.85.2021.09.28.03.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 03:20:56 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] rebase: fix todo-list rereading
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1034.git.1631108472.gitgitgadget@gmail.com>
 <pull.1034.v2.git.1632410782.gitgitgadget@gmail.com>
 <0d89c506192a84822a3fbd6c76befac187129ad4.1632410782.git.gitgitgadget@gmail.com>
 <xmqqilyqvtmh.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <bed00cb7-2204-668c-dca5-4bc883e80bab@gmail.com>
Date:   Tue, 28 Sep 2021 11:20:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqilyqvtmh.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/09/2021 17:13, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> .... Instead of relying on stat
>> data this patch simply reads the possibly edited todo list and
>> compares it to the original with memcmp(). This is much faster than
>> reparsing the todo list each time.
> 
> Nice.  Is that an egg of Columbus or what ;-)
> 
>> +	if (strbuf_read_file_or_whine(&buf, get_todo_path(opts)) < 0)
>> +		return -1;
>> +	offset = get_item_line_offset(todo_list, todo_list->current + 1);
>> +	if (buf.len != todo_list->buf.len - offset ||
>> +	    memcmp(buf.buf, todo_list->buf.buf + offset, buf.len)) {
>>   		/* Reread the todo file if it has changed. */
>>   		todo_list_release(todo_list);
>>   		if (read_populate_todo(r, todo_list, opts))
> 
> As we already have the contents of hte file in the buffer, we could
> further refactor the code around read_populate_todo() to tell it not
> to reopen and reread the rebase-todo file (which risks toctou race),
> but that is OK for now, I would think.

I did wonder about doing that but decided to punt it for now, I don't 
think the race is a concern - if another process is writing to the todo 
list while rebase is picking commits it is asking for trouble already. I 
suspect doing this will be easier once git-rebase--preserve-merges.sh is 
gone from master.

>> @@ -4271,6 +4267,7 @@ static int reread_todo_if_changed(struct repository *r,
>>   		/* `current` will be incremented on return */
>>   		todo_list->current = -1;
>>   	}
>> +	strbuf_release(&buf);
>>   
>>   	return 0;
>>   }
>> diff --git a/sequencer.h b/sequencer.h
>> index d57d8ea23d7..cdeb0c6be47 100644
>> --- a/sequencer.h
>> +++ b/sequencer.h
>> @@ -116,7 +116,6 @@ struct todo_list {
>>   	struct todo_item *items;
>>   	int nr, alloc, current;
>>   	int done_nr, total_nr;
>> -	struct stat_data stat;
> 
> Good riddance ;-)

Hear, hear!

> Will queue.  Thanks.
> 

