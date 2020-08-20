Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991A3C433DF
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 15:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 747502086A
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 15:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnC4Khzu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgHTPXk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 11:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgHTPXi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 11:23:38 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C92CC061385
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 08:23:38 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o21so1951999wmc.0
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 08:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N8UinIZVRSNTQWDyFUnCpb4rbkZi77qU63SkULH6bZk=;
        b=AnC4Khzu/aFbOwOGYUNeDanYsP7B7Y1rLGrGWBPKBEHcOk9Qe0VEoiqPVMELzQoCoo
         1ee+c+8nn71tGUqcmllaO9mUxv+iCNQw+sj0YiLCOWq6sf9t8edIoP+nLUc3FU69LjyW
         uGKWm6hM9NHzV4VzrNJSfqFN7cH7tGba18jU4XwPtLSIVruvNT1DcW28AbW8BkTx69eS
         0WzvKuQHVKv9zC79fzWv8U38rcdo00pIE/aSy0xzcsOytinm31Fggps62Jghl3QUrEci
         lNMZXDMMIOXFpzpCY9zg+2OstVpFdmN8CgeB0idTMwYznsd8NSBmH6ZTOs7JIQNaj6pT
         cJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=N8UinIZVRSNTQWDyFUnCpb4rbkZi77qU63SkULH6bZk=;
        b=MY1L4nspqHEaoCiIM6R8m2GyMp5HmagXoyBIlNY49/+OVHsZZs2HcSof5RGE+TqdCA
         Y+AmgFl6h81BiBh7d1YNn8d/9zjxt2mMNnTHmbIMafQO3dbMzuBXeXkScLuAJ/N7fCBk
         Mh4FumP9JQx+A/RiebMeDvnsiGhIp4zp6Iu68/zOQgsjvZEu+fxFYTruaLrXj3EUkM3y
         W4aHeTxE9NTZ/dmze84sAv2PA75zJ492LRjcPC1I74+RO/rMQ5YWLJuuL+uhgerf+tkR
         0nhLxbgTi4/0GCNc3o6+LTSnxeI4gQE9HhLQTmEo0JBUjjqdvgMJjedoFdZEhFLLyvkw
         eLOw==
X-Gm-Message-State: AOAM5309VQg9GIr+mDeXphIUOyuYPuNSUapooNrbAHIV7zRb7Ta1av8v
        VUzIgH8VJSifnKGX5nkkY2Y=
X-Google-Smtp-Source: ABdhPJzFM3P9MLpiTy0HzjorlyW+UtEm0iuPFUH+dgEsOBAUHoTBB1T6LKNqk1/xg6JtAyu+53na+A==
X-Received: by 2002:a7b:cf29:: with SMTP id m9mr3994847wmg.88.1597937015738;
        Thu, 20 Aug 2020 08:23:35 -0700 (PDT)
Received: from [192.168.1.240] (192.252.189.80.dyn.plus.net. [80.189.252.192])
        by smtp.gmail.com with ESMTPSA id q2sm4782291wro.8.2020.08.20.08.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 08:23:35 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v8 2/5] am: stop exporting GIT_COMMITTER_DATE
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200817174004.92455-1-phillip.wood123@gmail.com>
 <20200817174004.92455-3-phillip.wood123@gmail.com>
 <xmqqtux113z6.fsf@gitster.c.googlers.com>
 <2ad142e6-5f2c-7e05-c8d3-ab6efcfc7058@gmail.com>
 <xmqqr1s2vdkq.fsf@gitster.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <8f43c23e-8472-385a-eba7-cafd24505e84@gmail.com>
Date:   Thu, 20 Aug 2020 16:23:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqr1s2vdkq.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/08/2020 16:51, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> For am and the sequencer fmt_ident() is in a function which is called
>> from a loop and it is convenient not to have to worry about passing an
>> strbuf around or allocating and freeing it on each function call
> 
> That's strbuf on caller's stack, right?  The actual string pointed
> by the strbuf's buf pointer will be needed and on the heap with or
> without the clean-up on top of the patch we are discussing, so I do
> not think alloc/free would be in the picture when considering the
> pros-and-cons.

At the moment we use the same allocation for the whole program (ignoring 
reallocation if the string grows). If we were to add an strbuf as a 
local variable in the function that gets called by the commit picking 
loop we either need to make it static and accept the leak or alloc and 
free the string each time the function is called. Either way I'd be 
amazed if it has any effect on the performance given we're performing a 
merge with each loop iteration.

>> The callers in ident (fmt_name(), git_author_info() and
>> git_committer_info()) return the string so they would need their own
>> strbuf or have to be changed so the caller passed one in. There are
>> quite a few callers of those functions and they seem to either
>> immediately call split_ident_line() or duplicate the returned string
>> (mostly the latter).
>>
>> So it would be a bit of work to do it but not an enormous amount
>> (assuming we don't change the signature of git_author_info() etc in
>> ident.c, although given the pattern of callers it might be worth doing
>> that if they are mostly duplicating the returned string anyway)
> 
> I'd say that is more than "while at it" clean-up.  It would be
> easier to review and slightly easier to do if done before this patch
> introduces rotating strbuf, but ...
> 
>> I'm going to be off line for 10-14 days from the beginning of next week,
>> I could take a look at it after that, or we could leave it for a future
>> improvement - what do you think?
> 
> ... I can be talked into punting it for later, at least for now.

I'm tempted to say leave it for now but if this isn't in next by the 
time I'm back online I'll look at rerolling.

Best Wishes

Phillip
> 
> Thanks.
> 
