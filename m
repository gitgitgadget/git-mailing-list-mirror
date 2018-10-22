Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D2F11F454
	for <e@80x24.org>; Mon, 22 Oct 2018 14:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeJVW6y (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 18:58:54 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37353 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbeJVW6y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 18:58:54 -0400
Received: by mail-qt1-f193.google.com with SMTP id d14-v6so46524563qto.4
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 07:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UHmZHA2i8ULcaW1gr4QH1QPyuxrE3K4nEPinwxhrP/A=;
        b=cjfG3G1odDhSEGU6eW4IUaNT7yCLlfbNHgLqRaC0wQyio4oV1J9shNRIC7EikqC3v5
         +/lDslTKyFpRZzH+WlB2suO/fWVhPmwBOibgI64xu2PVJXOkoCCuLfxWvA1o3Zkbksg2
         MuG4b7Rk8fgnvQuWAC3NZODATGR/OjAM5vCBOxVU1I9IB/Mqu9HSmSc3gcrkW0MvOMZw
         Zs4beI0kcGTGxxEFvSImUcIDqN+ISqt+NaxHZRFy5ut7x5URUrXthlfzxjqwc69OM8fR
         0UO22dL4apt/fRLN6pv65jcf5s4g+4jqGgO2ftRvNZDGY8aZsBAAYXntCDJswR5SKp6L
         Vm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UHmZHA2i8ULcaW1gr4QH1QPyuxrE3K4nEPinwxhrP/A=;
        b=QQtGAS4rYWbJPGW3iVg8Q6QaQy+OBZrEVq6R/St8VadWT7FBgIFslIQ3+uUSjrjfYR
         iXKXhnbX7JTa/afZV8QAuB+QLiEJ42d7ZEdXDOVZoueZ4Bgjh03WiuqLUxA0nLJA9u/H
         xKmyMYtzW7fFU69mVrGroBNOFKLo1HX7YQeZDgvyTxF8iye6SlqcInemYH6aWRKjWtSK
         N/Pq1twmHjA5Wo3s7a0WfzsH0bRAHvv8bX6iJTeRPgIdDOr8nDMO7NY7mub8pXZubVhW
         hGWAH8cMCO1QTZjHvPQA/869FsFKzjEEqXZT3Iqx6+VghZFOU8zmX3JH6FAj0WFgVF1d
         zMEw==
X-Gm-Message-State: ABuFfojbYoi9/AIKaZiwQXo16836CtpwtQEgZ+sZ8zGM6dQVkHnavLl0
        WnaD8wet0Dm2fGrnStnzipI=
X-Google-Smtp-Source: ACcGV60+N4QG3z5u4/euQ7tqnllUDXSEYp1nd1L2Q+QuvcjLzXzw9Gi1MAi5/iOm6X4KwLzbV0a2Wg==
X-Received: by 2002:a0c:9de7:: with SMTP id p39mr45067209qvf.82.1540219202936;
        Mon, 22 Oct 2018 07:40:02 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id l28-v6sm1460871qkj.33.2018.10.22.07.40.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 07:40:01 -0700 (PDT)
Subject: Re: [PATCH v8 7/7] read-cache: load cache entries on worker threads
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <20181010155938.20996-8-peartben@gmail.com>
 <20181019161118.GA8100@sigill.intra.peff.net>
 <xmqqsh0yybg7.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <72c8938c-7ffa-a384-55dc-09d90d9cf7f8@gmail.com>
Date:   Mon, 22 Oct 2018 10:40:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqsh0yybg7.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/21/2018 10:14 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> On Wed, Oct 10, 2018 at 11:59:38AM -0400, Ben Peart wrote:
>>
>>> +static unsigned long load_cache_entries_threaded(struct index_state *istate, const char *mmap, size_t mmap_size,
>>> +			unsigned long src_offset, int nr_threads, struct index_entry_offset_table *ieot)
>>
>> The src_offset parameter isn't used in this function.
>>
>> In early versions of the series, it was used to feed the p->start_offset
>> field of each load_cache_entries_thread_data. But after the switch to
>> ieot, we don't, and instead feed p->ieot_start. But we always begin that
>> at 0.
>>
>> Is that right (and we can drop the parameter), or should this logic:
>>
>>> +	offset = ieot_start = 0;
>>> +	ieot_blocks = DIV_ROUND_UP(ieot->nr, nr_threads);
>>> +	for (i = 0; i < nr_threads; i++) {
>>> [...]
>>
>> be starting at src_offset instead of 0?
> 
> I think "offset" has nothing to do with the offset into the mmapped
> region of memory.  It is an integer index into a (virtual) array
> that is a concatenation of ieot->entries[].entries[], and it is
> correct to count from zero.  The value taken from that array using
> the index is used to compute the offset into the mmapped region.
> 
> Unlike load_all_cache_entries() called from the other side of the
> same if() statement in the same caller, this does not depend on the
> fact that the first index entry in the mmapped region appears
> immediately after the index-file header.  It goes from the offsets
> into the file that are recorded in the entry offset table that is an
> index extension, so the sizeof(*hdr) that initializes src_offset is
> not used by the codepath.
> 
> The number of bytes consumed, i.e. its return value from the
> function, is not really used, either, as the caller does not use
> src_offset for anything other than updating it with "+=" and passing
> it to this function (which does not use it) when it calls this
> function (i.e. when ieot extension exists--and by definition when
> that extension exists extension_offset is not 0, so we do not make
> the final load_index_extensions() call in the caller that uses
> src_offset).
> 

Thanks for discovering/analyzing this.  You're right, I missed removing 
this when we switched from a single offset to an array of offsets via 
the IEOT.  I'll send a patch to fix both issues shortly.
