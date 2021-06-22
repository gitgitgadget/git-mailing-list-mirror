Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A96EC2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 18:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 010F661002
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 18:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbhFVSKT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 14:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbhFVSKO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 14:10:14 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB8CC08ED4B
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 11:02:08 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id x22so9305917pll.11
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 11:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=42G1iA9n5RMPuhyf9UL7hdKP5A49Dvi79LhDULIMnec=;
        b=m4s6nqVkD3gfN+rS/XoVNq7xDqmWl2ZOFEGdcMlBWDoa0MOmCI3kcXuy81Iq/z+oCC
         /X0c3OvlUeS+YjWkoEDAcOwZb0mEEfExEtZhYB29Y7GlGZv2A92m9hsV9x9c4n0tANH5
         K+1ttN8yDwenMzFXeA8RVMztPYjRLNOaXaKfHRqexFJi/sMJEV/CdzEaA/OGQ3RCTpvc
         t6/JqAEGaORyb2msaEBMC3+2eB384hkaKi5HnLCe/euz9BIeQeKWom386NYKJu+rRlBA
         hu+Dt+TNVi1cE/CbZLMihfMv5EoNQ2A6CnWEc/184FtVZ4J3Y8O9a5f6CletchuDHBpE
         +uKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=42G1iA9n5RMPuhyf9UL7hdKP5A49Dvi79LhDULIMnec=;
        b=KvZ80iLaXP0mJP/p1Xrw8APyhqvstoOyF1LbdYsZOBOZxMvuCu20/iJN8eeGJ1kszf
         ayEtcq+p3DenwM+Yas6xijJUmsPAuttd6Oejmvht7koYpDUMrKONGUfwE3RETWkcvZvV
         MD3oEaCv8ZZdHrKHxs196tez6Ly1hMWn8SCMtEDlZHP11y4a2E4VlSDG2JwlWb+fOkoB
         u8j9dQ64dhOH1qRZppe73nsc8HM87ktWSm/d6r7hPqEpo6tt3vWDPgZmL7shON9slelb
         7soSXi7vLH4gSDGiUe40TtgBsD8bJBZphEJV0wD0Nd9GG5nJykR2j0dIXfbETkunCQ6S
         T2DA==
X-Gm-Message-State: AOAM531RyVblBwiA3RFfI2TCqKR/H5nHugFVX53EUThpbt2EErHWvpQW
        DoIzC3xVgiIGEa+i9vPHKxc=
X-Google-Smtp-Source: ABdhPJzxLSKWJWHYTIhac+kFTGT75i3Z2bblKD6i+WWjLKxGuyUomE2GUk+9gXUGlkMAJmHsMz1QoQ==
X-Received: by 2002:a17:902:d101:b029:121:9fa2:969e with SMTP id w1-20020a170902d101b02901219fa2969emr21495870plw.23.1624384928377;
        Tue, 22 Jun 2021 11:02:08 -0700 (PDT)
Received: from [192.168.208.38] ([183.82.190.58])
        by smtp.gmail.com with ESMTPSA id c22sm17554pfv.121.2021.06.22.11.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 11:02:07 -0700 (PDT)
Subject: Re: [PATCH 1/2] submodule--helper: remove an unreachable call to
 usage_with_options
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
References: <20210621190837.9487-1-kaartic.sivaraam@gmail.com>
 <20210621190837.9487-2-kaartic.sivaraam@gmail.com>
 <CAPig+cT66BT7fCfHBJM25D1SBVKAwRpSh+SAaR8YmqZX+7epvA@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <7c1522ab-26b8-66b2-46e2-7b974c763b3b@gmail.com>
Date:   Tue, 22 Jun 2021 23:32:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAPig+cT66BT7fCfHBJM25D1SBVKAwRpSh+SAaR8YmqZX+7epvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/06/21 1:28 am, Eric Sunshine wrote:
> On Mon, Jun 21, 2021 at 3:09 PM Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
>> The code path in question calls `error` in a particular case.
>> But, `error` never returns as it exits directly. This makes
>> the call to `usage_with_options` that follows the `error` call
>> unreachable.
> 
> error() returns -1; you will commonly see:
> 
>      if (check_something())
>          return error(...);
>

You're right. I guess I was drowsy when I was looking at this
part for the code. The passing tests didn't help either.

>> So, remove the unreachable `usage_with_options` call.
>>
>> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
>> ---
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> @@ -1637,8 +1637,6 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
>>          if (all && argc) {
>>                  error("pathspec and --all are incompatible");
>> -               usage_with_options(git_submodule_helper_usage,
>> -                                  module_deinit_options);
>>          }
> 
> usage_with_options(), on the other hand, exits directly.
> 

Got it. Will drop this patch and re-roll.

Thanks,
Sivaraam
