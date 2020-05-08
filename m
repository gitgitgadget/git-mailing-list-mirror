Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0525C38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 12:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C98CD215A4
	for <git@archiver.kernel.org>; Fri,  8 May 2020 12:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bg/DbSB3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgEHMTs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 08:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726627AbgEHMTs (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 May 2020 08:19:48 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCC9C05BD43
        for <git@vger.kernel.org>; Fri,  8 May 2020 05:19:48 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id c3so1262452otp.8
        for <git@vger.kernel.org>; Fri, 08 May 2020 05:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sMciUk4kzzwdcyTqXFvmMA11abMSavY8eHh0VgSnnfM=;
        b=Bg/DbSB3MbYHF2FWxOuvwWUWGZjjkcwjNYAHSGzwrGrDQVME6PwIp3uEO9gsV/4g8f
         u+Y6dnWODvkjG+4El8qU3xHuzf6tiY7IWMnghCtt40Mfz+E5dw9ICpQX9CoYq7cnUqHs
         PY9h+fX2TmDn7J0seHyOHztLlgLnn4e4nxkEI9+cw2DfruF4BmzfUOu38ZVhkFMdlLWG
         P6abfIqq90U38w2OtkeU737fKOGJoa8634Dl56JX01HZRe8Z3k5E208JF7wDm3yYP+8e
         VHohUJR0SvMbc2Qi215qNa1jrncw0zgECFUU8F04LirucPpgqdqbOcLEWOGE9U9tVdNi
         1d8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sMciUk4kzzwdcyTqXFvmMA11abMSavY8eHh0VgSnnfM=;
        b=iBk0WxBW9pOWslonAJj4t7kbSAY3Ds1QdPHJhcb1K58DlVaImruIb1Mkk6znXPyqKn
         3NRwqboaj/1QKw3DUccd7JoUtLcqkHvNI4kkO3KzKdKcoS3BJygc0bqedeSYcKuDPBsq
         PWB1eXcVTYbPaMVWuanNzQCv1VghavTZPSGuBxZurQ3R0/lZTNGHHjVVxtt6UdAE0Ih4
         HZh0e5xlL94+6X9bpL1wwbKtXaOx9KNwLwWvV7zAEcf4AtE+BNRb+yiVMAu2MmB6tcQc
         uiMbv1g5uLAJX1JiRuzpQdNK0UFkwC4Ht+85Jlj0kCgzDa6k9Xc2JoIRW70ZVrxKXp/r
         nrjg==
X-Gm-Message-State: AGi0Pub3/u3n2g02qPO4HxNq3pFtUTT+FrfU9NPhK9gLtA2ixRjVQGZ0
        Bq7m1oqh2nb1aMjMc8IyRuY=
X-Google-Smtp-Source: APiQypITtFjIIHakPP5hC8+4CdCqBmbwJvA0LE6FA9zbN7+XTwjEcIvYFV7aS3KepkfgAo3xvTpQRQ==
X-Received: by 2002:a05:6830:1058:: with SMTP id b24mr1950923otp.16.1588940387673;
        Fri, 08 May 2020 05:19:47 -0700 (PDT)
Received: from [192.168.1.76] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id g10sm420983oou.31.2020.05.08.05.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 05:19:47 -0700 (PDT)
Subject: Re: [PATCH 01/10] unpack-trees: avoid array out-of-bounds error
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmaill.com, peff@peff.net,
        me@ttaylorr.com, jrnieder@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.627.git.1588857462.gitgitgadget@gmail.com>
 <5bfe3f3fc8a99b3d4fdd4286da17cd935090c614.1588857462.git.gitgitgadget@gmail.com>
 <xmqqk11n2xf3.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <63dce1f7-3dbd-1540-c6e5-547962555f57@gmail.com>
Date:   Fri, 8 May 2020 08:19:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <xmqqk11n2xf3.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/7/2020 6:27 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> diff --git a/unpack-trees.c b/unpack-trees.c
>> index 9a3ccd9d083..4f880f2da90 100644
>> --- a/unpack-trees.c
>> +++ b/unpack-trees.c
>> @@ -563,10 +563,11 @@ static int warn_conflicted_path(struct index_state *istate,
>>  	add_rejected_path(o, WARNING_SPARSE_UNMERGED_FILE, conflicting_path);
>>  
>>  	/* Find out how many higher stage entries at same path */
>> -	while (++count < istate->cache_nr &&
>> +	while (i + ++count < istate->cache_nr &&
>>  	       !strcmp(conflicting_path,
>>  		       istate->cache[i+count]->name))
>>  		/* do nothing */;
> 
> Eek.  Yes, it is obvious that the original is wrong once you point
> it out.  But "i + ++count" looks like a line noise, and funny way
> that lines are wrapped in the original does not help X-<.
> 
> We may want to fix the style and the grammar while we are at it,
> perhaps like the attached.
> 
> In any case, thanks for a fix.
> 
>  unpack-trees.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 6bbf58d28e..c38938d96c 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -562,11 +562,11 @@ static int warn_conflicted_path(struct index_state *istate,
>  
>  	add_rejected_path(o, WARNING_SPARSE_UNMERGED_FILE, conflicting_path);
>  
> -	/* Find out how many higher stage entries at same path */
> -	while (++count < istate->cache_nr &&
> -	       !strcmp(conflicting_path,
> -		       istate->cache[i+count]->name))
> -		/* do nothing */;
> +	/* Find out how many higher stage entries are at same path */
> +	while ((++count) + i < istate->cache_nr &&
> +	       !strcmp(conflicting_path, istate->cache[count + i]->name))
> +		; /* do nothing */
> +

This looks much better, thanks!

As I mentioned in the cover letter, this is worth taking on its own. Could
you queue the collaborative patch? I'll eject it from the next version of
this series. 

Thanks,
-Stolee
