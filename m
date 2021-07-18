Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93455C636C8
	for <git@archiver.kernel.org>; Sun, 18 Jul 2021 17:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65A6E61179
	for <git@archiver.kernel.org>; Sun, 18 Jul 2021 17:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhGRRnC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Jul 2021 13:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhGRRnC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jul 2021 13:43:02 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456AFC061762
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 10:40:04 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y4so14067954pfi.9
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 10:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5GLpcpeJY0m/Pjy+jlcmbLKMlBqAaRXhAKJMghGQEDs=;
        b=kfh5W9khKntEJnrlQMUeR1QFKXfDHHRG4DTi4g44ylKUb1EgS9HerHH0f33Kmnmn7g
         X34EsTmpykMrrCQfWCYKscOHpsjpm5ox+BII1puoDnEM9PGbkbxUP87uPCctazoOQZ0E
         RitGZ226cTNDrunLcBTw4JwAOPtNUOzIcYCbe5YqoBN8vSLjG55UbRJ4eh8ooohUcLpc
         npgxz8H62vl8QT09PZtrtRZfrCwq2agyeSNxf1pckE9D2ik2yvPSPRHxbHmsN8hEp0mQ
         lIxctdyLKAmYC43E0yw45nfvmTLWBy20sV75HLuPesmCut/FIq+0ms76x1b1CuRsw126
         9ksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5GLpcpeJY0m/Pjy+jlcmbLKMlBqAaRXhAKJMghGQEDs=;
        b=rH5jxICmrzKJ3WJmHpI/XoRcOdtjNwNchHOuAdPW0B1EWlUieUbKKzNF10Q+vUrcNB
         mqDdHYWPRZsG9bZJ7RSOSa6erjxOvHwKeH23XP/jtvkks7qPX9cvEFsDEfH7ULqmu4bu
         zha1Mt/+ApX7OVQj3MAAPm7moavm7h1M2Zygdjy/WkROEuvl8ISdF3BJql1TPKJCp0FF
         lkYLJLDoxJy3vhHL4FyjsVDgpXcMlxSHmY+jdGnY1Eish+3nEgHlH+tEQLFcH5hpN/vw
         G/wVuSffqtndAY679VhaKkY0WAaqfRwxuxVDse9MLZ0xBFbvBYXJfS+tp0/OiwfvTlxe
         Nuxw==
X-Gm-Message-State: AOAM5320rqXATZode6kov+zCVbqrL39sQ0ot7BjgaeBu5iiXsXmYh4jl
        dm/5YZEryzvb70gdhk5cV7Q=
X-Google-Smtp-Source: ABdhPJwxS05QgDgqzuxifjRrv9UqGY9vHsHLjXU84A8GwMJuvzuski/4af+73JdEcTVB4DMoy9KWwQ==
X-Received: by 2002:aa7:90c9:0:b029:307:49ca:dedd with SMTP id k9-20020aa790c90000b029030749cadeddmr22080250pfk.9.1626630003848;
        Sun, 18 Jul 2021 10:40:03 -0700 (PDT)
Received: from [192.168.193.232] ([106.195.40.25])
        by smtp.gmail.com with ESMTPSA id w22sm16625475pfu.50.2021.07.18.10.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jul 2021 10:40:03 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=5bGSoC=5d_My_Git_Dev_Blog_=e2=80=93_Week_8?=
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
References: <CD6968A1-179D-4B77-91C1-4EECB1B69951@gmail.com>
 <f5b12a75-bdaf-fe5c-ffc2-7b4c8cdfddd6@gmail.com>
 <D3F13902-A7DD-4186-8444-45FD9260CBC8@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <623770cb-d692-f61f-180a-33145caea97a@gmail.com>
Date:   Sun, 18 Jul 2021 23:09:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <D3F13902-A7DD-4186-8444-45FD9260CBC8@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Atharva,

On 13/07/21 2:16 pm, Atharva Raykar wrote:
> 
> I was seeing if it was possible to at least save another spawn for calling
> init when '--init' is provided for an update. The current implementation
> does not spawn a separate process for this, so I was hoping I don't add
> more overhead in the conversion, but it's looking hard to avoid at the
> moment.
> 

I'm having some difficulties understanding this. I tried to take a look
at the existing code[2][3] in 'git-submodule.sh', I could only see that
if '--init' is passed to update, it calls the 'cmd_update' shell function
which in turn does invoke 'git submodule--helper init'. OTOH, if '--recursive'
is passed 'cmd_update' itself is called recursively called after setting
the 'prefix' and 'wt_prefix' shell variables.

So, I'm not sure how you mean to say that a sub-process was not spawned
when '--init' is passed. Could you clarify this a little?

>> [1]: https://public-inbox.org/git/20180205235508.216277-1-sbeller@google.com/
>>

[2]: https://github.com/git/git/blob/abb21c7263616f01c5e950861a29279ab21cb02f/git-submodule.sh#L530-L533

[3]: https://github.com/git/git/blob/abb21c7263616f01c5e950861a29279ab21cb02f/git-submodule.sh#L651-L673

-- 
Sivaraam
