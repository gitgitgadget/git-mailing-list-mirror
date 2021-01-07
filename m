Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFA6C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 11:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4445623125
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 11:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbhAGLUa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 06:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbhAGLU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 06:20:29 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3229AC0612F5
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 03:19:49 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id 2so3979920qtt.10
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 03:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V+7oywPkI5wsCOf6LhMCWvCA1EX6fMFJHCr5XajzOns=;
        b=Qt+6vEa6KkoxW0yjZY0AL3o6O88vu/wNkmPqjhlpeTbo/Mln/vBPN2byqKTU7s0ods
         G9TSa1QyXii1ZkIUoyCQmBpITZnInzhV/0jnCKTSMysrNcZ0nR94bhJzVeSVc/Qxqf/m
         38cI22SzYuach0bZbLzbSrEvLsV8A/O+O97csnzIUBgOY3NJDkmLL15prg/hoedSekAA
         Tbnreeg7s4W1kVZW1JmonwriyJk7AIL5/ppnodGtXe3hgd/gdoAoFDpNEm3MnWOusHLv
         gIWTKcX1fUYK7zbtW9P1m/1He/Anh4kB1FF3XvhreZ9jGijOhcu8OVC+KYFhgF4HdcNx
         JwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V+7oywPkI5wsCOf6LhMCWvCA1EX6fMFJHCr5XajzOns=;
        b=Z8RPGiGxyWJGQaOHvIB0TxfJiassVz4XpzX+ZAXyNwrh1+SJdzHpc7S2IEeo42xukH
         UOt7dEbohbT5SFPb7tfIrkrHvgeChkty0fQ0+UhTfT3LMYhyjjV3YqM45vkw+XBKhzOQ
         DffZjckfkKAlRRwWnNZowpwoCw6HgfvzUx77gih5+vn/1nbOiFR3JLwi1bGTAmgDFdqt
         mkbi8iu+S8QImtNX35Dy5V/ZI+oa8oD3Ft45k60Asapx9bmJqKaSI3+WhIKjimAVHK8n
         FYJzXuR5x9knUMQPCAKbv3Tl0Q9B1iZg0evt9A6fai9hcHa14gqgp43SyiR+PfzAnfvc
         r7aA==
X-Gm-Message-State: AOAM531YBAuhWi0/vBNmwFj4NwdEHpdwOrNAdpVKbTVt7f6Tlfz+Q+SX
        YC/ftUl2r7m6ok2nPvENCrg=
X-Google-Smtp-Source: ABdhPJzCBxMmyGp8iT1vn3qqhRY1dTLzqVcWI5oXGS9iC12HcNtNfwnlYBLQdKj23QSslKBXtn45ug==
X-Received: by 2002:ac8:7654:: with SMTP id i20mr7703186qtr.291.1610018388253;
        Thu, 07 Jan 2021 03:19:48 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id 133sm2898278qkd.94.2021.01.07.03.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 03:19:47 -0800 (PST)
Subject: Re: [PATCH v2 14/14] update-index: remove static globals from
 callbacks
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= =?UTF-8?Q?_Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
 <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
 <2b171a142b36b114d5ff526073fe3fd9517a4d32.1609821783.git.gitgitgadget@gmail.com>
 <CAPig+cTfHsd7WMvcX1_433WVOG+y4FceUACBx_4UfnjJTgVY6g@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <73f51832-583a-27e8-65fa-86eb0ebac4cf@gmail.com>
Date:   Thu, 7 Jan 2021 06:19:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cTfHsd7WMvcX1_433WVOG+y4FceUACBx_4UfnjJTgVY6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/7/2021 12:09 AM, Eric Sunshine wrote:
> On Mon, Jan 4, 2021 at 11:43 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> @@ -1098,8 +1103,13 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>> -       istate = repo->index;
>> +       cd.repo = repo;
>> +       cd.istate = istate = repo->index;
> 
> Will there ever be a case in which `cd.istate` will be different from
> `cd.repo->index`? If not, then we could get by with having only
> `cd.repo`; callers requiring access to `istate` can fetch it from
> `cd.repo`. If, on the other hand, `cd.istate` can be different from
> `cd.repo->istate` -- or if that might become a possibility in the
> future -- then having `cd.istate` makes sense. Not a big deal, though.
> Just generally curious about it.
 
I don't believe that 'istate' and 'repo->index' will ever be
different in this file. This includes the members of the
callback_data struct, but also the method parameters throughout.

Mostly, this could be seen as an artifact of how we got here:

1. References to the_index or other compatibility macros were
   converted to use the static global 'istate'.

2. References to the static global 'istate' were replaced with
   method parameters for everything except these callbacks.

3. These callbacks were updated to use 'cd.istate' instead of
   the (now defunct) static global 'istate'.

It could be possible to replace all references to 'istate' with
'repo->index' but the patches get slightly more messy. I also
think the code looks messier, but you do make a good point that
there is no concrete reason to separate the two.

Thanks,
-Stolee
