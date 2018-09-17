Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 046431F404
	for <e@80x24.org>; Mon, 17 Sep 2018 18:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbeIRAUo (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 20:20:44 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33574 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbeIRAUo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 20:20:44 -0400
Received: by mail-qk1-f193.google.com with SMTP id z78-v6so9607002qka.0
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 11:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ku883y+6N9665PdFZbQw0B526gI9ivm1B2gsgN52ctM=;
        b=rasKmBizu8jON4wp/8vePBLxfzDgGVqtCOAs0pkpFBkzZlziYtYT20dArER9j9BjYV
         AobxGhQ3etL5WzV11e2zt8mLiB0atwGkyMp9Rj+qnZZdvjmVNIXCOuzUTCkoeVIFXLQJ
         vvvdACyyN9KaZw33PNoX3siFcGbundCV4SjNYY2qEqQyxguSMHmcRqd2xK6nP+BNagRb
         ewX+/8l7CAj8avmlAuCvdsD1JoX3gLrO4ltQAh39CtG9NY3DjaJ2V/Ht+HRlu5cFr/Pv
         GF5oeI1yiRSz4naaGqwjtwzHpNJW7s9VKfLd2K1TO28ZD8RyeR88neILrIe2S1VxXtER
         +Wzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ku883y+6N9665PdFZbQw0B526gI9ivm1B2gsgN52ctM=;
        b=cGU2Ckqs04rzTYV/92aTW4IBloQzzdtYK2dacLo27CmO6/aE9wAkuEHWUqWYKFnbCi
         ZWhIEN5FPJuOPU+co8G6SM1dMnLuEOFNMhpHUy6bUml1lIm9Wyz4ascFm0JEstfB6xue
         0ZmhyzdmAj8MMdmpxVev+PjbBM7X9JNFlmedQjH+CoIOvE2VaDRAobBkeBo3QIc2BICc
         jefzxjbrS1HH2VXuhA6rBBxolR9Fe1tBfFHeHztWEcLVFXCiqcKcsgzN9IOONAtiI/fC
         11lwej96wmTJcN61kU2l+P0Rl+nlDCawJOdU3RAQ16XoLtMpaorHpaBYyL0SB8zakq96
         ArGw==
X-Gm-Message-State: APzg51B72qqWqZCpySSK4p3IuO79n98gv6Pc4fyZBLAe2N2JXTneKZMJ
        s9HmTb3L6Y8BL4S9d/jzeb0=
X-Google-Smtp-Source: ANB0VdZWeBAFDiY0ks1nvsqbGg7KAp70BQ9fcEiUwQtkuGi+vNHp4n6iB1LSulqKmiWhhiW302AbxQ==
X-Received: by 2002:ae9:df81:: with SMTP id t123-v6mr18347790qkf.55.1537210326952;
        Mon, 17 Sep 2018 11:52:06 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id j5-v6sm9303727qtb.34.2018.09.17.11.52.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 11:52:06 -0700 (PDT)
Subject: Re: [PATCH v5 3/5] read-cache: load cache entries on worker threads
To:     Duy Nguyen <pclouds@gmail.com>, Ben Peart <benpeart@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180912161832.55324-1-benpeart@microsoft.com>
 <20180912161832.55324-4-benpeart@microsoft.com>
 <CACsJy8CUsOLy_OWdJbx5TqyzPJ5eZ0QcrJniQ82nAiwwtk9iyA@mail.gmail.com>
 <20180915110951.GA17817@duynguyen.home>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <f8f021ce-5a3d-a5f3-ef47-e9cc94460b24@gmail.com>
Date:   Mon, 17 Sep 2018 14:52:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180915110951.GA17817@duynguyen.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/15/2018 7:09 AM, Duy Nguyen wrote:
> On Sat, Sep 15, 2018 at 01:07:46PM +0200, Duy Nguyen wrote:
>> 12:50:00.084237 read-cache.c:1721       start loading index
>> 12:50:00.119941 read-cache.c:1943       performance: 0.034778758 s: loaded all extensions (1667075 bytes)
>> 12:50:00.185352 read-cache.c:2029       performance: 0.100152079 s: loaded 367110 entries
>> 12:50:00.189683 read-cache.c:2126       performance: 0.104566615 s: finished scanning all entries
>> 12:50:00.217900 read-cache.c:2029       performance: 0.082309193 s: loaded 367110 entries
>> 12:50:00.259969 read-cache.c:2029       performance: 0.070257130 s: loaded 367108 entries
>> 12:50:00.263662 read-cache.c:2278       performance: 0.179344458 s: read cache .git/index
> 
> The previous mail wraps these lines and make it a bit hard to read. Corrected now.
> 
> --
> Duy
> 

Interesting!  Clearly the data shape makes a big difference here as I 
had run a similar test but in my case, the extensions thread actually 
finished last (and it's cost is what drove me to move that onto a 
separate thread that starts first).

Purpose	    			First	Last	Duration
load_index_extensions_thread	719.40	968.50	249.10
load_cache_entries_thread	718.89	738.65	19.76
load_cache_entries_thread	730.39	753.83	23.43
load_cache_entries_thread	741.23	751.23	10.00
load_cache_entries_thread	751.93	780.88	28.95
load_cache_entries_thread	763.60	791.31	27.72
load_cache_entries_thread	773.46	783.46	10.00
load_cache_entries_thread	783.96	794.28	10.32
load_cache_entries_thread	795.61	805.52	9.91
load_cache_entries_thread	805.99	827.21	21.22
load_cache_entries_thread	816.85	826.85	10.00
load_cache_entries_thread	827.03	837.96	10.93

In my tests, the scanning thread clearly delayed the later ce threads 
but given the extension was so slow, it didn't impact the overall time 
nearly as much as your case.

I completely agree that the optimal solution would be to go back to my 
original patch/design.  It eliminates the overhead of the scanning 
thread entirely and allows all threads to start at the same time. This 
would ensure the best performance whether the extensions were the 
longest thread or the cache entry threads took the longest.

I ran out of time and energy last year so dropped it to work on other 
tasks.  I appreciate your offer of help. Perhaps between the two of us 
we could successfully get it through the mailing list this time. :-) 
Let me go back and see what it would take to combine the current EOIE 
patch with the older IEOT patch.

I'm also intrigued with your observation that over committing the cpu 
actually results in time savings.  I hadn't tested that.  It looks like 
that could have a positive impact on the overall time and warrant a 
change to the default nr_threads logic.
