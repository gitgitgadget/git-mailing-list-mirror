Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF903202A2
	for <e@80x24.org>; Mon, 23 Oct 2017 12:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932286AbdJWMgX (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 08:36:23 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:55689 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932190AbdJWMgW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 08:36:22 -0400
Received: by mail-qk0-f196.google.com with SMTP id x82so21688596qkb.12
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 05:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=axINMi5Rii86xdZIs2wIFwgWEylUzJTL0UDqfhUpAmE=;
        b=GM3KIa4WoZG1v/R6acxNScrOia6qk+k9TALJWlXZbhPNqklha3Vt9mH90rDkdVuypx
         JiLiWAH1t0RjoEAXk3/GpidaQwvZaA6BbU+qrtDVOsyvxQaNivktnqs78ZZxvjx4DPah
         X69wvk1ImB4krhvi00Faa0HYU4HOEXVGUl5M5wpA6MCzs3HCaE4XH6zdT5b9TIuYj7zW
         lqEMQTzEcfo81BDz0HR4KaYDVQ3fL/GyJcJaWtTdVyuN3v+5SD8wEZxQ/0P+75FDsKo6
         AFKUJ911Kz8BmiE/O9LZk+/9MzkbvwudIPrfiau14BexPmGKb+ok/8FHnqXK8trUgTJl
         oLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=axINMi5Rii86xdZIs2wIFwgWEylUzJTL0UDqfhUpAmE=;
        b=KA9sOw9w4Y1x8Nf+BCBpbTJMqshabrNZy1/8inVUAY9DunkyeoA7vZSHLR4PV34hCE
         EhNDR8Kwgikw/nlohHQOi6BbIrAK3NFeYv41uZAvfiwd6Vzm9csRIJRlgOOzld+7vQoo
         WiImt2DeYvPoEovbdLOXKaQHgVaqZN1QZ1KioZV9kzbbxz6GgbXtpxuREkBm56MnW2gm
         TThTO33X5TXsz8iXFME1lHWesJ61ydG0GUqz+Juji7oT3rCe0d10tYdfiS//6jQzwgLD
         /m255QsIqXB+fu78eryjewegw2e63NE/xE7RE7Vc8rtfcr2HyXOwVpmcjAQ6dwLARdaW
         9V1w==
X-Gm-Message-State: AMCzsaUD+OYXE5LbB1+X48xmtCuJ3Lv6RxnOqJc53E5RlQkSIMbailpK
        VtHiSY1UTIAXUlv+IxMTgX8uXb1W
X-Google-Smtp-Source: ABhQp+T5/cTgU7/ZfY9Y6vqDWoZmknNP7nwC59TtpEy933VdghdNsa2/mCFAFEAl1Q+0HLgb8O7elg==
X-Received: by 10.55.24.73 with SMTP id j70mr16786330qkh.310.1508762181438;
        Mon, 23 Oct 2017 05:36:21 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id p41sm4747166qkp.94.2017.10.23.05.36.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Oct 2017 05:36:20 -0700 (PDT)
Subject: Re: [PATCH 4/4] fsmonitor: Delay updating state until after split
 index is merged
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Cc:     Alex Vandiver <alexmv@dropbox.com>, git@vger.kernel.org
References: <20171020011136.14170-1-alexmv@dropbox.com>
 <05670bb6e3c6378119b1649144c80dd6d72bfe29.1508461850.git.alexmv@dropbox.com>
 <alpine.DEB.2.21.1.1710201503380.40514@virtualbox>
 <20171021033534.pgjtyiwlhvheuueo@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1710231157030.6482@virtualbox>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <541ed27f-3219-fe0a-beb6-99ecb4ed36da@gmail.com>
Date:   Mon, 23 Oct 2017 08:36:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1710231157030.6482@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/23/2017 5:57 AM, Johannes Schindelin wrote:
> Hi Peff,
> 
> On Fri, 20 Oct 2017, Jeff King wrote:
> 
>> On Fri, Oct 20, 2017 at 03:16:20PM +0200, Johannes Schindelin wrote:
>>
>>>>   void tweak_fsmonitor(struct index_state *istate)
>>>>   {
>>>> +	int i;
>>>> +
>>>> +	if (istate->fsmonitor_dirty) {
>>>> +		/* Mark all entries valid */
>>>> +		trace_printf_key(&trace_fsmonitor, "fsmonitor is enabled; cache is %d", istate->cache_nr);
>>>
>>> Sadly, a call to trace_printf_key() is not really a noop when tracing is
>>> disabled. The call to trace_printf_key() hands off to trace_vprintf_fl(),
>>> which in turn calls prepare_trace_line() which asks trace_want() whether
>>> we need to trace, which finally calls get_trace_fd(). This last function
>>> initializes a trace key if needed, and this entire call stack takes time.
>>
>> It seems like we could pretty easily turn noop traces into a trivial
>> conditional, like:
>>
>> diff --git a/trace.h b/trace.h
>> index 179b249c59..c46b92cbde 100644
>> --- a/trace.h
>> +++ b/trace.h
>> @@ -80,8 +80,11 @@ extern void trace_performance_since(uint64_t start, const char *format, ...);
>>   #define trace_printf(...) \
>>   	trace_printf_key_fl(TRACE_CONTEXT, __LINE__, NULL, __VA_ARGS__)
>>   
>> -#define trace_printf_key(key, ...) \
>> -	trace_printf_key_fl(TRACE_CONTEXT, __LINE__, key, __VA_ARGS__)
>> +#define trace_printf_key(key, ...) do { \
>> +	if (!key->initialized || key->fd) \
>> +		trace_printf_key_fl(TRACE_CONTEXT, __LINE__, key, __VA_ARGS__) \
>> +} while(0)
>> +
>>   
>>   #define trace_argv_printf(argv, ...) \
>>   	trace_argv_printf_fl(TRACE_CONTEXT, __LINE__, argv, __VA_ARGS__)
>>
>>
>> (OK, that's got an OR, but if we are really pinching instructions we
>> could obviously store a single "I've been initialized and am disabled"
>> flag).
> 
> I'd really like that.
> 
>> I don't have an opinion one way or the other on these particular
>> messages, but in general I'd like to see _more_ tracing in Git, not
>> less. I've often traced Git with a debugger or other tools like perf,
>> but there's real value in the author of code annotating high-level
>> logical events.
> 
> Yes, I like that idea, too: to add more tracing.
> 
> Thanks,
> Dscho
> 

Two big thumbs up.

I find turning on tracking very informative as I can better see the flow 
of execution and sometimes am surprised by what I discover. :)

I've often added additional tracing while working on a feature only to 
remove it before submitting the patch because of the performance 
overhead.  Being able to leave that in would be very helpful.
