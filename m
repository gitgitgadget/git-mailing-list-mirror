Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8E7C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 17:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCB33603E7
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 17:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236955AbhHJR6s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 13:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235561AbhHJR4j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 13:56:39 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B30BC028C1A
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 10:36:10 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id q2so22167161plr.11
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 10:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YLA+bwn8IlHsoe/i1U+/nztfP7R68UwetmmizCLCijQ=;
        b=MFHqEykrhFEniv7SnwrFuFlxUGxPIcMsPXFijbKBkI48jned6Y3+Rnsa7Ho/dUv0gs
         Mbr3+TR5lopO5N/wBQsWwkVGC6mDHEzbTuzAMXLmQfNi5EBA2jLVdqTvZFqeopbae+1G
         nQeSQtJySZNoJfGFUD++J7Amyy/BiTPONqpmlxPVMEOFHfwQAZLRzl8+9CkN4FHqlSlh
         5JmAasY8yOFDGS3zrjUwkw52sRxIe2q1H9vcm28Tk5vGoq/PGHH8npmLPytkOK4SoR2y
         jgFvDdcgWX2dKf9+N8X2WPu4Ihrhk8FaeU1tK+NsnanNz19dNyaNxTNty57ylcAF5Wwk
         kmjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YLA+bwn8IlHsoe/i1U+/nztfP7R68UwetmmizCLCijQ=;
        b=sQZkrnHaLVuKPlgYTnRqYPm18Bl64edID2EfibAKbRb1eizCFBxE3/PTWPYv4SqZW8
         hkgOBzZYziidwGpuGgcjJDjFWHG5wn9t2f9J3YVZrl7uwgH2QNBuVUrfMERQ+Y9OruAO
         ++Ur3fJFuZAMKs8uT/n+setKJJCrrMFQ0/M17stLIo098GyLR8feF/M4XgzJjvc5OIJz
         poWifPgmLssbWe2j3/DYEBPzjxzmTlYA426Z7rMpFz5FZ5tJxxDqDcn5PzgIlpeaPpvu
         MlXk550bc0BhJsDHca9Oh77BeRA09Fo2idNbWqAIeiEl8fcwjxmadxQBshfakRB7YBjY
         RKWA==
X-Gm-Message-State: AOAM530bIykHIBYE1QyIrky6kYLJOdk1NUMrc6rv4Gtf5vG9pXHLW6rh
        9mWGiMrp/XtNrmBjfpJPVNA=
X-Google-Smtp-Source: ABdhPJyplYTg/A83Wu0/bLsUiePWqG+gJBxBaAwzCWlZvWu4Mx26jiuRIHIxP/0OYq4EBbML19xqVQ==
X-Received: by 2002:a17:90a:44:: with SMTP id 4mr31490791pjb.130.1628616969836;
        Tue, 10 Aug 2021 10:36:09 -0700 (PDT)
Received: from [192.168.208.38] ([49.205.80.154])
        by smtp.gmail.com with ESMTPSA id d17sm24252414pfn.110.2021.08.10.10.36.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 10:36:09 -0700 (PDT)
Subject: Re: [GSoC] [PATCH v4 1/8] submodule--helper: add options for
 compute_submodule_clone_url()
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, avarab@gmail.com,
        christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        pc44800@gmail.com, periperidip@gmail.com,
        rafaeloliveira.cs@gmail.com, sunshine@sunshineco.com
References: <20210806120147.73349-1-raykar.ath@gmail.com>
 <20210807071613.99610-1-raykar.ath@gmail.com>
 <20210807071613.99610-2-raykar.ath@gmail.com>
 <0752736f-11d5-103b-653f-a4bbe6436304@gmail.com>
 <187083ab-a2e3-0933-5bff-9b409b2946ea@gmail.com> <m27dgvaxfj.fsf@gmail.com>
 <m2wnov9f8s.fsf@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <7b19892d-9171-bc72-1f96-8df88f8d57a5@gmail.com>
Date:   Tue, 10 Aug 2021 23:06:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <m2wnov9f8s.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/08/21 2:17 pm, Atharva Raykar wrote:
> 
> Atharva Raykar <raykar.ath@gmail.com> writes:
> 
>> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
>>
>>> On 08/08/21 11:11 pm, Kaartic Sivaraam wrote:
>>>> On 07/08/21 12:46 pm, Atharva Raykar wrote:
>>>> [...]
>>>>   	char *remote = get_default_remote();
>>>> @@ -598,10 +598,14 @@ static char *compute_submodule_clone_url(const char *rel_url)
>>>>    	strbuf_addf(&remotesb, "remote.%s.url", remote);
>>>>   	if (git_config_get_string(remotesb.buf, &remoteurl)) {
>>>> -		warning(_("could not look up configuration '%s'. Assuming this repository is its own authoritative upstream."), remotesb.buf);
>>>> +		if (!quiet)
>>>> +			warning(_("could not look up configuration '%s'. "
>>>> +				  "Assuming this repository is its own "
>>>> +				  "authoritative upstream."),
>>>> +				remotesb.buf);
>>>>   		remoteurl = xgetcwd();
>>>>   	}
>>>> -	relurl = relative_url(remoteurl, rel_url, NULL);
>>>> +	relurl = relative_url(remoteurl, rel_url, up_path);
>>>
>>> After reading 2/8 of the series, I just noticed that 'remoteurl' is always
>>> initialized in 'resolve_realtive_url'. It is either initialized to the return
>>> value of 'xgetcwd' or retains its assigned value of 'NULL'. But it looks
>>> like that's not the case here. 'remoteurl' could be used uninitialized
>>> when the above if block does not get executed which in turn could result in
>>> weird behaviour in case 'remoteurl' gets a value of anything other than 'NULL'
>>> at runtime.
>>>
>>> This again has nothing to do with the change done in this patch. Regardless, it
>>> looks like something worth correcting. Thus, I thought of pointing it out.
>>>
>>
>> Right. I agree it should be corrected.
> 
> Actually on having another look, I'm not sure if we need to assign NULL
> to 'remoteurl' at all.
> 
> The 'if (git_config_get_string(...))' on success will allocate
> 'remoteurl'. If it fails, it will be given the return value of
> 'xgetcwd()'. There is nothing in the config API docs that suggest a
> success mode for the git_config_get_*() functions that will assign
> nothing to the buffer we give it. Therefore, by the time we get to the
> variable's first use in the 'relative_url()' function, we are guaranteed
> to have a well-defined value.
> 

Ah ha! That explains why we haven't got any reports about weird behaviours
when using the likes of `git submodule init` so far ;-)

Thanks for digging this and sorry about the false flag!

> It seems to me that the original 'resolve_relative_url()' had an
> unnecessary NULL initialization.
> 

Makes sense. I guess I feel into the trap of blindly trusting that the original
code was written correctly x-<

-- 
Sivaraam
