Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB62F202A2
	for <e@80x24.org>; Fri, 20 Oct 2017 21:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752631AbdJTVrx (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 17:47:53 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:51414 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752418AbdJTVrw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 17:47:52 -0400
Received: by mail-qk0-f169.google.com with SMTP id 17so15974649qkq.8
        for <git@vger.kernel.org>; Fri, 20 Oct 2017 14:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SA4lBqTYpllcq06hK3FZ6om3ng5NJ0yHOXNN3AF5WSs=;
        b=Ah6JMtXqV1aSYEd2YKqE5TD+vPSuD3/k2xlR7Ux8oZqVoPv51DZ1bPKzLnd4vCWxZ7
         WOJwzRZnk1vXTJefvyXyDQU7w3hcU3kYuZnhZsvg1P7mNfqxioaxEOLDk69jm1swPBEh
         8Y4wVnPbE5I/Z0jlaSn0Dgj8BBRMrGqfKVrZOU5GIuUKGMkHt0dhkKb8mYCmhpretsCY
         8LUiW/xMG3Lf1iZrD5lzcgQf7wy9glCzzGwVYi6yOo3IrxwgXsNsCkjTYFYty7pUttKD
         LpXSgCUBXr0v5s69y/1YA4UpxVp2GGZrX7FlEg1uITXIcXXOu0BiQarAVCfeR3T4O47b
         J+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SA4lBqTYpllcq06hK3FZ6om3ng5NJ0yHOXNN3AF5WSs=;
        b=aLSCCL8Di0srMKPPmWqZt0bwuof30foC6bcsd++PelAZn2VmPCWZ1KW0dSJMRw7NML
         bkAGmt29I1A2WeanNvjmkY5c6aKfhsl9/nC+h4qcq9BqfDKQxiaIiOC3LKL68DS9/aFn
         xFEc/awkKQ/6Pe2oQPyQ9QO1JelAUPN8ODa9enPYUGXh7VLmG9LBrQx3ZxhsE8edI1IZ
         LtqtquQ0bsXwxGMk9mLhiJb+z0Z9n348FE6LNPo75bwtdvsjLA86FdqlV5j65nIhYmmL
         YhWSxeDvPz5DLyknB2fCCkT6dcGgg5uacUcjT4s6o83kEL5sGImrEEs2iKhpUha+ZIBj
         7k/w==
X-Gm-Message-State: AMCzsaU7N9ARAjYUiQY//c6U8i+8oVOU1Sbwdt97IAVM48WjY5akx1si
        XTWYlDhHQ83aWharMCcUBHflN4EQ
X-Google-Smtp-Source: ABhQp+TJB+mPA1O6aawBb15TY1sYxbRyXDcDe4f2Ge3dcvffYRbTQ12+s50CjneYQmwI9It+rlxLwQ==
X-Received: by 10.55.54.206 with SMTP id d197mr8597766qka.257.1508536071176;
        Fri, 20 Oct 2017 14:47:51 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id d1sm1226451qka.78.2017.10.20.14.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Oct 2017 14:47:50 -0700 (PDT)
Subject: Re: [PATCH 4/4] fsmonitor: Delay updating state until after split
 index is merged
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alex Vandiver <alexmv@dropbox.com>
Cc:     git@vger.kernel.org
References: <20171020011136.14170-1-alexmv@dropbox.com>
 <05670bb6e3c6378119b1649144c80dd6d72bfe29.1508461850.git.alexmv@dropbox.com>
 <alpine.DEB.2.21.1.1710201503380.40514@virtualbox>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <7c6bfaef-d05a-4c06-5a53-4f7811c81aec@gmail.com>
Date:   Fri, 20 Oct 2017 17:47:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1710201503380.40514@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/20/2017 9:16 AM, Johannes Schindelin wrote:
> Hi Alex,
> 
> On Thu, 19 Oct 2017, Alex Vandiver wrote:
> 
>>   extern struct index_state the_index;
>> diff --git a/fsmonitor.c b/fsmonitor.c
>> index 7c1540c05..4c2668f57 100644
>> --- a/fsmonitor.c
>> +++ b/fsmonitor.c
>> @@ -49,20 +49,7 @@ int read_fsmonitor_extension(struct index_state *istate, const void *data,
>>   		ewah_free(fsmonitor_dirty);
>>   		return error("failed to parse ewah bitmap reading fsmonitor index extension");
>>   	}
>> -
>> -	if (git_config_get_fsmonitor()) {
>> -		/* Mark all entries valid */
>> -		for (i = 0; i < istate->cache_nr; i++)
>> -			istate->cache[i]->ce_flags |= CE_FSMONITOR_VALID;
>> -
>> -		/* Mark all previously saved entries as dirty */
>> -		ewah_each_bit(fsmonitor_dirty, fsmonitor_ewah_callback, istate);
>> -
>> -		/* Now mark the untracked cache for fsmonitor usage */
>> -		if (istate->untracked)
>> -			istate->untracked->use_fsmonitor = 1;
>> -	}
>> -	ewah_free(fsmonitor_dirty);
>> +	istate->fsmonitor_dirty = fsmonitor_dirty;
> 
>  From the diff, it is not immediately clear that fsmonitor_dirty is not
> leaked in any code path.
> 
> Could you clarify this in the commit message, please?
> 
>> @@ -238,6 +225,29 @@ void remove_fsmonitor(struct index_state *istate)
>>   
>>   void tweak_fsmonitor(struct index_state *istate)
>>   {
>> +	int i;
>> +

Here we should test git_config_get_fsmonitor() (see the logic where you 
moved this from) as there is no reason to set up the fsmonitor state if 
we're about to remove the extension.  Save the results and use them in 
the case statement below.

>> +	if (istate->fsmonitor_dirty) {
>> +		/* Mark all entries valid */
>> +		trace_printf_key(&trace_fsmonitor, "fsmonitor is enabled; cache is %d", istate->cache_nr);
> 
> Sadly, a call to trace_printf_key() is not really a noop when tracing is
> disabled. The call to trace_printf_key() hands off to trace_vprintf_fl(),
> which in turn calls prepare_trace_line() which asks trace_want() whether
> we need to trace, which finally calls get_trace_fd(). This last function
> initializes a trace key if needed, and this entire call stack takes time.
> 
> In this case, where we trace whether fsmonitor is enabled essentially once
> during the life cycle of the current Git command invocation, it may be
> okay, but later we perform a trace for every single ie_match_stat() call,
> which I think should be guarded to avoid unnecessary code churn in
> performance critical code paths (O(N) is pretty good until the constant
> factor becomes large).
> 
>> +		for (i = 0; i < istate->cache_nr; i++) {
>> +			istate->cache[i]->ce_flags |= CE_FSMONITOR_VALID;
>> +		}
>> +		trace_printf_key(&trace_fsmonitor, "marked all as valid");
>> +
>> +		/* Mark all previously saved entries as dirty */
>> +		trace_printf_key(&trace_fsmonitor, "setting each bit on %p", istate->fsmonitor_dirty);
>> +		ewah_each_bit(istate->fsmonitor_dirty, fsmonitor_ewah_callback, istate);
>> +
>> +		/* Now mark the untracked cache for fsmonitor usage */
>> +		trace_printf_key(&trace_fsmonitor, "setting untracked state");
>> +		if (istate->untracked)
>> +			istate->untracked->use_fsmonitor = 1;
>> +		ewah_free(istate->fsmonitor_dirty);
> 
> At this point, please set istate->fsmonitor_dirty = NULL, as it is not
> immediately obvious from this patch (or from the postimage of this diff)
> that the array is not used later on.
> 
>> +	} else {
>> +		trace_printf_key(&trace_fsmonitor, "fsmonitor not enabled");
>> +	}
>> +

I'd remove the trace statement above as it isn't always accurate. 
fsmonitor could be enabled but just hasn't written/read the extension yet.

>>   	switch (git_config_get_fsmonitor()) {
>>   	case -1: /* keep: do nothing */
>>   		break;
>> diff --git a/read-cache.c b/read-cache.c
>> index c18e5e623..3b5cd00a2 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -330,6 +330,10 @@ int ie_match_stat(struct index_state *istate,
>>   		return 0;
>>   	if (!ignore_fsmonitor && (ce->ce_flags & CE_FSMONITOR_VALID))
>>   		return 0;
>> +	if (ce->ce_flags & CE_FSMONITOR_VALID)
>> +		trace_printf_key(&trace_fsmonitor, "fsmon marked valid for %s", ce->name);
>> +	if (ignore_fsmonitor)
>> +		trace_printf_key(&trace_fsmonitor, "Ignoring fsmonitor for %s", ce->name);
> 
> This is the code path I am fairly certain should not be penalized if
> tracing is disabled.
> 

Definitely agree with the need to remove this tracing as it will get 
called a lot and we don't want to pay the perf penalty.

> Ciao,
> Johannes
> 

Thank you for detecting the issue with split index and even better, 
sending patches to fix it!
