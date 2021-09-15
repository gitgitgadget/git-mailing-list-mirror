Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B92C433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F5A660EE5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhIOQ4C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 12:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhIOQ4B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 12:56:01 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F94C061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 09:54:42 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id v2so5013887oie.6
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 09:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K5SYiSu8+fpCwZj5SdG1IBmqdYBfKdTi4qSxKJ9vGmI=;
        b=IVYpk684aJOEZzF7FlxSnw6HV/jsU2X8Vpb2RdoXELiJn8g9UhRnONM5aPF0LdSKHb
         ufGgmJjDSZfKHwkahF7QPo3Eywmwy6WL69v38CNXxmhiKi7xfVULpyUJkHqrVCCZIUFP
         sibVj+I+CERRKYoNmT23dcXMtur6qpwZHJSOmnBp8kYt6tsAs/UT9FFlq2MrM4lsgRgH
         U3wdXWKOWiwlnYutSAhw1emQZMSM+pX+6LrCqoyn1LLlL+lQ1+DTcjaobwaGW1X8aBsx
         Q6/VwkEaffsKtiKuki1zLn/5CAxiQaYamAZqynOR+mawquy4W60+CuJWtsndxtvQ9djk
         QJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K5SYiSu8+fpCwZj5SdG1IBmqdYBfKdTi4qSxKJ9vGmI=;
        b=iyn9SwB61GgHMGdMvFzML10k9lnZ4pCQOulXRfrQ1k4Z90/TQoc0pjFgKSRo7yA/0y
         oOQa2Fp4NJVm4f1PllE1vhACEV+U1UCmm1mtNCFrk3ua7M1wYA0CVi2iAqsAc9Z04in0
         llyruAKDBTMTMGz7y19/t47cj1Ea6xNqSbDi+n6Y/6GevI7fcGYlWwa/av75nG7Mwty2
         NVZ/7BtNPSduRtroZvBPa7VBQHmFhExlWTOywNH0p3nLRGCA9enLjOyCsqyD4UWntC3S
         QVzH45HJQkk3CQ1jOTJeXOnDZoY4cdQrCNi53sUQ2QdkHZ/vAFW/ulvl/iEyvjk1ch8F
         9ZXw==
X-Gm-Message-State: AOAM530kgNM4PfBMxs8k6rGTb4zix9w0elCbOR//srU/eygdPG3EKuAq
        uOm6lY7IRt4Pkj6dSiEMQKM=
X-Google-Smtp-Source: ABdhPJy6B8Ikfy1taoxqnZqKdc8iuomzX9RgPePRFRRvJayzYanGzIMD/fln4ddDWXe63MrrB+Rudw==
X-Received: by 2002:aca:f143:: with SMTP id p64mr460866oih.161.1631724881821;
        Wed, 15 Sep 2021 09:54:41 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:8cdb:119:9f7e:3e24? ([2600:1700:e72:80a0:8cdb:119:9f7e:3e24])
        by smtp.gmail.com with ESMTPSA id be5sm135311oib.10.2021.09.15.09.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 09:54:26 -0700 (PDT)
Subject: Re: [PATCH v2 14/14] advice: update message to suggest '--sparse'
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        matheus.bernardino@usp.br, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
 <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
 <f2abc387822378e02d0b221baf9a09ac91d44d7d.1631453010.git.gitgitgadget@gmail.com>
 <87pmtd5tkj.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <07454056-0123-876e-1a03-2b6b01497c1c@gmail.com>
Date:   Wed, 15 Sep 2021 12:54:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87pmtd5tkj.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/12/2021 5:58 PM, Ævar Arnfjörð Bjarmason wrote:
...
>>  	cat >sparse_error_header <<-EOF &&
>> -	The following pathspecs didn't match any eligible path, but they do match index
>> -	entries outside the current sparse checkout:
>> +	The following paths and/or pathspecs matched paths that exist outside of your
>> +	sparse-checkout definition, so will not be updated in the index:
>>  	EOF
>>  
>>  	cat >sparse_hint <<-EOF &&
>> -	hint: Disable or modify the sparsity rules if you intend to update such entries.
>> +	hint: Disable or modify the sparsity rules or use the --sparse option if you intend to update such entries.
>>  	hint: Disable this message with \"git config advice.updateSparsePath false\"
>>  	EOF
> 
> ...this used to line-wrap at 80 characters, but is now a bit beyond
> that.
> 
> Maybe instead make these two into bullet-points?

Do you mean something like this?

	hint: If you intend to update such entries, try one of the following:
	hint: * Use the --sparse option.
	hint: * Disable or modify the sparsity rules.

> Also the third "Disable" looks a bit jarring at first, it seems like a
> continuation of the first message, but it's just the standard "disable
> this message" we tend to print out.

With the bullet points, this is no longer a concern.

> This commentary pre-dates this commit, but just in general:
> 
> I think the advice system is best used where there's an initial
> non-optional message, and then the advice elaborates on what happened,
> how to fix it. A good example is the "short object ID %s is ambiguous"
> in object-name.c.
>
> But in this case both messages are rather long. I'd think better would
> be something like (and I didn't look very deeply at the involved code):
> 
>     error("pathspec '%s' matched only outside sparse checkout")
> 
> I.e. in e.g. cmd_rm() we loop through the pathspecs, and we error on the
> first one, so to a first approximation why do we need to for sparse emit
> ALL the pathspecs we didn't match? if we're going to error out anyway
> shouldn'w we just error out on the first one?

If we don't list the entire set, then users will need to use trial
and error to discover how to get out of a bad state.
 
> But going on, I'd think this would be better overall (pseudocode):
> 
>     error("pathspec '%s' matched only outside sparse checkout")
>     if (advice_enabled(ADVICE_UPDATE_SPARSE_PATH)) {
>         char *list_str;
>         list_of_bad_pathspecs = make_that_list(my_pathspec_string_list, &list_str);
>   
>       if (list_of_bad_pathspecs.nr > 1)
>             /* Emit a message that details what's wrong, but also has a
>              * list of all the other pathspecs we'd also die on if the user */
>       else
>           /* Ditto, but no list *?

I'm not a fan of this "here's an error message for the first thing, but
the advice gives all the details" approach.

> Maybe I'm missing something with the sparse implemention, but I'd think
> going above & beyond and listing all failures is a bit much in either
> case, i.e. for non-sparse we have:
> 
>     $ git rm 'file-i-do-not-have' 'directory-i-do-not-have/'
>     fatal: pathspec 'file-i-do-not-have' did not match any files
>     $
> 
> I'd think in general a user who's screwed up and typo'd both isn't going
> to be much harmed by us noting the first, maybe they'll get another
> error then.
> 
> But usually it's obvious (e.g. you just ran the command in the wrong
> directory), so if you have a large list of pathspecs getting a firehose
> of all the things that didn't match can be less helpful due to being
> overrly verbose.

The difference here is a die() versus an error(). It would probably
be better to convert the die() into an error() and report all failures
rather than have the sparse-checkout changes start short-circuiting
and providing less data.

Thanks,
-Stolee
