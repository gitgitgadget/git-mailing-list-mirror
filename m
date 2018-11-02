Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3559C1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 16:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeKCBWC (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 21:22:02 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42212 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbeKCBWC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 21:22:02 -0400
Received: by mail-qk1-f193.google.com with SMTP id u68so3853732qkg.9
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 09:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fiS645iYQuiGfWbg4qVD9PnNDXz7dWApJnEgtfdTwdI=;
        b=vfVQ6iOrpv0IjPM+tCILoT8UyvmI941wrbF4YhjyZ21QNJFE1hMsOOYuUByoCEGogS
         itPlA/mR4LtYBLXI2tAx4nK6WKACwxW3cwJwVfMwdC7NzQ6ZhpUZn2TQLi6DLDL41KzH
         RzIV43ljYyO72iITjIZsjUCvEuCHD+KLDjD2jUopkE2ofEGdEFN6L84CMBPoA3GKSMZ9
         YeNgbfXj9GlJo5uPaYBGYOGgCZbXKR1jUzOmGtvLiueBnqfFqsME6cmf7XC1sw0MREe2
         Tp63rvxXrF/LR4LOgjqh1Aam40tO0uZwtIhfT5u+P5qsWcet4hOnflmJoN6ZZPd6hljc
         KLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fiS645iYQuiGfWbg4qVD9PnNDXz7dWApJnEgtfdTwdI=;
        b=AfHsV0R/wKz4snBWS4oY8Fo+gZFvitZHLLyLL47bgiZBygmJkPRobv2Z9NN3a2pN/E
         2QJwjCErezHHo10jJ1wqTfbceT/2CTUEkuO6ZDpU7taeL+gBLIlwzT7XSW7DCfNOP8eG
         9SqT6u5z7PWBLiWHKVJr/xqheEUiI+osxWdQE0nQ54ZXl11oTXBebykldi3QJGkD4pPf
         ROLQqyOxxFJVj+tt8tiHkq/iPyTf3xI98lwydwpueMJZiVSWvXtNfQq1sgXVplq5V/kU
         Q6ouH7ewybBLQnrQYdmwlRluZJoigrdtrkacXbcAIYhOIRxDgHfPUGza3p/fdifpAV3p
         UjDg==
X-Gm-Message-State: AGRZ1gL/x7rH7LoZOkc72YV+jcU1r4u5x1qcVvst1Kj2h1i1z7IEi0aP
        fnSpR821rZXx6qrGJ6/2I3XyBck6
X-Google-Smtp-Source: AJdET5eKc/5dMgBDUgxxFxelglO98Cye2xqGuyiVjTElSl72Lfx35rTRhr/kDLZCeuYeQMWaJlB71A==
X-Received: by 2002:a0c:e486:: with SMTP id n6mr11734586qvl.210.1541175263853;
        Fri, 02 Nov 2018 09:14:23 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id 67-v6sm10093656qtf.72.2018.11.02.09.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 09:14:23 -0700 (PDT)
Subject: Re: [PATCH v1] add: speed up cmd_add() by utilizing
 read_cache_preload()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     benpeart@microsoft.com, git@vger.kernel.org
References: <20181102133050.10756-1-peartben@gmail.com>
 <xmqqy3abo64r.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <3dc46005-016f-e1c3-32ae-2797317aed08@gmail.com>
Date:   Fri, 2 Nov 2018 12:14:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqy3abo64r.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/2/2018 11:23 AM, Junio C Hamano wrote:
> Ben Peart <peartben@gmail.com> writes:
> 
>> From: Ben Peart <benpeart@microsoft.com>
>>
>> During an "add", a call is made to run_diff_files() which calls
>> check_remove() for each index-entry.  The preload_index() code
>> distributes some of the costs across multiple threads.
> 
> Nice.  I peeked around and noticed that we already do this in
> builtin_diff_index() before running run_diff_index() when !cached,
> and builtin_diff_files(), of course.
> 

Thanks for double checking!

>> Because the files checked are restricted to pathspec, adding individual
>> files makes no measurable impact but on a Windows repo with ~200K files,
>> 'git add .' drops from 6.3 seconds to 3.3 seconds for a 47% savings.
> 
> ;-)
> 
>> diff --git a/builtin/add.c b/builtin/add.c
>> index ad49806ebf..f65c172299 100644
>> --- a/builtin/add.c
>> +++ b/builtin/add.c
>> @@ -445,11 +445,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>>   		return 0;
>>   	}
>>   
>> -	if (read_cache() < 0)
>> -		die(_("index file corrupt"));
>> -
>> -	die_in_unpopulated_submodule(&the_index, prefix);
>> -
>>   	/*
>>   	 * Check the "pathspec '%s' did not match any files" block
>>   	 * below before enabling new magic.
> 
> It is not explained why this is not a mere s/read_cache/&_preload/
> in the log message.  I can see it is because you wanted to make the
> pathspec available to preload to further cut down the preloaded
> paths, and I do not think it has any unintended (negatie) side
> effect to parse the pathspec before populating the in-core index,
> but that would have been a good thing to mention in the proposed log
> message.
> 

That is correct.  parse_pathspec() was after read_cache() because it 
_used_ to use the index to determine whether a pathspec is in a 
submodule.  That was fixed by Brandon in Aug 2017 when he cleaned up all 
submodule config code so it is safe to move read_cache_preload() after 
the call to parse_pathspec().

How about this for a revised commit message?



During an "add", a call is made to run_diff_files() which calls
check_remove() for each index-entry.  The preload_index() code 
distributes some of the costs across multiple threads.

Limit read_cache_preload() to pathspec, so that it doesn't process more 
entries than are needed and end up slowing things down instead of 
speeding them up.

Because the files checked are restricted to pathspec, adding individual
files makes no measurable impact but on a Windows repo with ~200K files,
'git add .' drops from 6.3 seconds to 3.3 seconds for a 47% savings.



>> @@ -459,6 +454,10 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>>   		       PATHSPEC_SYMLINK_LEADING_PATH,
>>   		       prefix, argv);
>>   
>> +	if (read_cache_preload(&pathspec) < 0)
>> +		die(_("index file corrupt"));
>> +
>> +	die_in_unpopulated_submodule(&the_index, prefix);
>>   	die_path_inside_submodule(&the_index, &pathspec);
>>   
>>   	if (add_new_files) {
>>
>> base-commit: 4ede3d42dfb57f9a41ac96a1f216c62eb7566cc2
