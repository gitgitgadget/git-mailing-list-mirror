Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28B9C433E0
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 18:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89CFA206DD
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 18:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHhJxoHg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgFZSHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgFZSHP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 14:07:15 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFB8C03E979
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 11:07:14 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so10317683wrs.11
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 11:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IG568bZ/AY0FOmVCqtXQmm2D9s2DiupjSdynJgAV4wg=;
        b=GHhJxoHg/2c7zrZeSLyv6AKWjl16koJIj4WnVLTmbWI7kb22I/nD1XBT7ISpPEQGpc
         vbMAOfF/ZVYE5ZsqdhzKDuLfadypIhQFzwZ7H13TIi+CCpSxBJPhz7/SskHAGu3Rudu8
         NsA3AorlNoaSrMXbHLdl8Y8eL2dzKCRqCnzfHEZzMgzALxTRCDQkpdcurVh1hXkMxxnE
         D9BfLefe7nMNAO4XWdY4Z/js64/aGkZBS9ukZHHvw8GXPrlgKqLgwiqmiq3d11HJw8OC
         cftxD9VfzX28NvsnNWN6tD7gMlu/D5851ek/LGHPvvpTz1Glj1rMbhqwRCxAWO6kPzQV
         AqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IG568bZ/AY0FOmVCqtXQmm2D9s2DiupjSdynJgAV4wg=;
        b=Uv6r8WF/2ZFT9Ddwl5gX9InQu9b17FvCWLq7d7pfUBQ4vRMHI35KZGJe8nM431arCl
         OY57dDdcTq72dqveSU8z9mSa4mA1+BCKjRa+CYOH0WQEBrJFqutWlkdM7TIJndcTpwRz
         uyMh55FhiOUBPGRBa+2/9v8MtCm3CUqTEVjGy0AqwO+PEmJzK3FSYXJmNW8j9nFFof4p
         Oedyg0vx+kBuaFo65qm9uX6nh3SbXMXd32vy9MlpKGEPSIDnDKvYcouE/mSZIcmhC8+3
         a4jqsX9HNNULz8kezjstSwUa4h7f8cv2ByMhWIVlPPgIv8vnsthjaFQtka4HYaKtNUMw
         uoqA==
X-Gm-Message-State: AOAM532WeZmkHk4MWZHR8IJBGCbW0Y7uxMfE86c0Cx60eZe3+gu6/SYJ
        BFwxugkNwvHMZgh8tXpEDigphNK0
X-Google-Smtp-Source: ABdhPJxVMX+3RvZDnMPK3CbkQ0mBqVtA+1ycD1DkB54QjLfM4wwfMQku6iGbXsKSVY6nor04zIg01Q==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr4933863wrm.82.1593194833268;
        Fri, 26 Jun 2020 11:07:13 -0700 (PDT)
Received: from [192.168.1.201] (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.googlemail.com with ESMTPSA id c17sm15984893wmd.10.2020.06.26.11.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 11:07:12 -0700 (PDT)
Subject: Re: [PATCH v5 5/5] rebase: add --reset-author-date
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200626095528.117524-1-phillip.wood123@gmail.com>
 <20200626095528.117524-6-phillip.wood123@gmail.com>
 <xmqqbll5hjit.fsf@gitster.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <f0e71021-6aa0-5c7c-4ba5-2b2a892fcad0@gmail.com>
Date:   Fri, 26 Jun 2020 19:07:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <xmqqbll5hjit.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 26/06/2020 17:35, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> From: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
>>
>> The previous commit introduced --ignore-date flag to rebase -i, but the
>> name is rather vague as it does not say whether the author date or the
>> committer date is ignored. Add an alias to convey the precise purpose.
>>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
> 
> Hmph, did I?

Yes, you added a fixup d82dfa7f5b ("rebase -i: finishing touches to
--reset-author-date", 2019-11-21) which I squashed into this patch

> 
>> +		OPT_BOOL(0, "reset-author-date", &options.ignore_date,
>> +			 N_("ignore author date and use current date")),
>> +		OPT_HIDDEN_BOOL(0, "ignore-date", &options.ignore_date,
>> +				N_("synonym of --reset-author-date")),
> 
> It is merely hidden but still supported.
> 
>> diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
>> index 0ede2b8900..5b8963272a 100755
>> --- a/t/t3436-rebase-more-options.sh
>> +++ b/t/t3436-rebase-more-options.sh
>> @@ -117,53 +117,61 @@ test_ctime_is_ignored () {
>>  	! grep -v +0000 authortime
>>  }
>>  
>> -test_expect_success '--ignore-date works with apply backend' '
>> +test_expect_success '--reset-author-date works with apply backend' '
>>  	git commit --amend --date="$GIT_AUTHOR_DATE" &&
>> -	git rebase --apply --ignore-date HEAD^ &&
>> +	git rebase --apply --reset-author-date HEAD^ &&
>>  	test_ctime_is_ignored -1
>>  '
> 
> Are there still some tests that check "--ignore-date"?  We probably
> should have them, if we are not removing the support.

This patch converts the existing --ignore-date tests to use
--reset-author-date and adds a single new test at the end to check
--ignore-date

Best Wishes

Phillip

> 
> Thanks.  The entire series looked reasonable to me.
> 

