Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8286FC64ED8
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 19:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBWTkW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 14:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjBWTkV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 14:40:21 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C713459E7A
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 11:40:18 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id e9so9287640plh.2
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 11:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tnOo2Hi25//nqgejJw2vxlGboilIfgcHOUNUCrsvuGQ=;
        b=QKyJGA7+aDvWvB9wqcFN65ii6vwxkwf+lmxcIpqEkY7INUIb/ZguhrFV0cAmK2D6tR
         tpR34Pq4+qeZ00pf54edqk22IpYfNxEFJKT1QxXObRQ3TIjsn5uro2QNMJspnha1zkKz
         rSbTVM95m4NnotlTYbJ5qaGqQyM2APCDVmeKJGILyQjXrz++L/m/I51kkuqhCw1Bg9Jt
         nBhS0XD37/53YMzBBuvG2edAIfzLAWCLXVlV8nDIaPsMiHuK+9nvkBr7nvQ+JSMwe3LK
         xYIFgQOugBKVJU3J2VFck/EtjTzQe9JRqI18Jl8l7FEA54J5q20WWgWMDvdjrXipUINi
         DbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tnOo2Hi25//nqgejJw2vxlGboilIfgcHOUNUCrsvuGQ=;
        b=gij07L451mG+Pt9xZNYTeAuzckKDLDtr357xLTEPE/m8F+dvUaJSm38nxLpHUXyqiU
         J6JfO+ucpG5ftjMgafOHDcUFPSvBGVkTEtVcypBRvSUEVzM12P2NkWAj1QkduxxPuISm
         gZLum6U2r6++p61DrWZlkHtzdNW+lenCbIbqz8KMuVKFemvL7ZhR8UsEzH347qz57PX8
         KBzSQds3othUCjuKrbUGOpu7A2ex7Gp+568WIue8GR+JfDRHAme11v04sO4xSnElKA0p
         S/j+U8+u2Jomin0GIqsQCmOR9d0RUAZSdowQAqbsxkRlSnbkzEklib9xCJKcPTNJBZn9
         mLYA==
X-Gm-Message-State: AO0yUKUN8ueR4gH5PSL/CTL6zyGWvhGVtZHC++V8SEchRMQMQUDvUl4r
        mH/y8ZPEvhEdf9F3lcICvUQ=
X-Google-Smtp-Source: AK7set8kWrk6rI2OVfjSlmXQkpL3PKg/vkjg/CxvG0T61LDDGIUw+4T32S2F3CHbgD87SMQC3iVY/g==
X-Received: by 2002:a17:90b:1808:b0:236:6dea:8795 with SMTP id lw8-20020a17090b180800b002366dea8795mr12785797pjb.14.1677181218102;
        Thu, 23 Feb 2023 11:40:18 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id x2-20020a17090a9dc200b0023493354f37sm79149pjv.26.2023.02.23.11.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 11:40:17 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 05/16] alloc.h: move ALLOC_GROW() functions from cache.h
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
        <ec6f2518b9dddbaaaf101b0f87a2db377fef3c6b.1677139522.git.gitgitgadget@gmail.com>
        <536338b8-2189-04f3-7ed6-dbe640c73c9f@github.com>
Date:   Thu, 23 Feb 2023 11:40:17 -0800
In-Reply-To: <536338b8-2189-04f3-7ed6-dbe640c73c9f@github.com> (Derrick
        Stolee's message of "Thu, 23 Feb 2023 09:06:06 -0500")
Message-ID: <xmqqsfew6uhq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 2/23/2023 3:05 AM, Elijah Newren via GitGitGadget wrote:
>> From: Elijah Newren <newren@gmail.com>
>> 
>> This allows us to replace includes of cache.h with includes
>> of the much smaller alloc.h in many places.
>
>> diff --git a/add-patch.c b/add-patch.c
>> index a86a92e1646..7fe6b66d866 100644
>> --- a/add-patch.c
>> +++ b/add-patch.c
>> @@ -1,5 +1,7 @@
>>  #include "cache.h"
>>  #include "add-interactive.h"
>> +#include "alloc.h"
>> +#include "gettext.h"
>
> I see here that you are not dropping cache.h, but are also adding
> gettext.h, too? Did you mean to replace cache.h with git-compat-util.h
> here, or will I see that change happen in a future patch?

Thanks for reading very carefully.

>> diff --git a/attr.c b/attr.c
>> index 1053dfcd4b6..657ee52229e 100644
>> --- a/attr.c
>> +++ b/attr.c
>> @@ -7,6 +7,7 @@
>>   */
>>  
>>  #include "cache.h"
>> +#include "alloc.h"
>
> (Here's another example. Makes it more likely that this is on
> purpose in preparation for a full swap in the future. I'll
> stop mentioning this when I see it.)
>
> I also manually verified that the macros are an exact move
> from cache.h to alloc.h.
>
> Thanks,
> -Stolee
