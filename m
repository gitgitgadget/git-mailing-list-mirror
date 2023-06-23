Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC477EB64D7
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 21:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjFWVlz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 17:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjFWVlw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 17:41:52 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB9C10C
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 14:41:51 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b53aa1f3ffso6524405ad.1
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 14:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687556511; x=1690148511;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8rWWZ9Pe9BG1FUWK5QK7M0yRciPN5RIkXmf6fQcW1RA=;
        b=SbW7C4gJzXY6hlECv2+oeH696S8gEMmW2DBkqqKAnmMLSzddMf4dT12Tqej2bPm2Uv
         Zmk+a1/fTc2bHSOL/sQGBmOsFQnYfaO/CJn4/4enOtaElurqfdTIn8k8b6hBY6vSlswZ
         87WBN8Htbz0NZc/pr9y3KOu6OuUznnrjc+isKSdEkhJlGGY6m9nedjrPrt0UdS7lzK7T
         Go6Z5c5BqRqDfxXvnrALRzdQJKekUon7uCitv+ZiQ4ZlqmNsItSYpYW1y8FrS/E+Cm3Y
         NqjIWGFiXOm71ygjy4PXq2//ekmfZcldNCM6tmeN7e0/3OfxxVp2Jw5mt1dLt5bH1tae
         3tGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687556511; x=1690148511;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8rWWZ9Pe9BG1FUWK5QK7M0yRciPN5RIkXmf6fQcW1RA=;
        b=OvcP2uZrPBd1qs9MI90DxisLzOqrX7p0dM4k5C2gWEd8fiSy4QuKqfChagJY57oqbR
         eOToIgkAOuASIhdzl3sAOFnvfDIfSuNKHZtph4/RZfiH4mtE7ZTGzifwvlT4ZKrPb4mf
         0xaNQDOXfnGvppVBrhSvjKAlucDGP1w5YiO4MBrt2HkezKr8IzSS0XkUBJvhHJJpuO/w
         LFFeA/ckEufHvGei+gh/Tnp36oNIpQB/yyZWHuHnMEbNCDUcEIxNs6XlisaiP4Rc2RpJ
         8praOix1hfKHIztWk2bg0JXRd6GXJikzeDsW2aLXm7LfpJ09MmQjkr71MJ1YJNtgUjDy
         0OZg==
X-Gm-Message-State: AC+VfDw1ExfZhJJCCp54g4nbIybNtEliseJL0Zg+VDcvD8uLCb2OXkzY
        cnUPCTSYkzZHOyfgx6QFtJvN0VYB50gkzg==
X-Google-Smtp-Source: ACHHUZ7Ab3wBbXsJ6GP6UHZP/b909kvEEHEWvz6Z3TtlYhyO6tlG4TXh2qomuhaRyv9BetCZ5qMwlJswmDtoJA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:902:e412:b0:1b7:c803:4818 with SMTP
 id m18-20020a170902e41200b001b7c8034818mr56432ple.0.1687556511139; Fri, 23
 Jun 2023 14:41:51 -0700 (PDT)
Date:   Fri, 23 Jun 2023 14:41:49 -0700
In-Reply-To: <20230623203544.3255750-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20230623203544.3255750-1-jonathantanmy@google.com>
Message-ID: <kl6ledm1svoi.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 07/12] config.c: pass ctx with CLI config
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> @@ -2465,16 +2488,10 @@ static int configset_add_value(struct config_reader *reader,
>>  	l_item->e = e;
>>  	l_item->value_index = e->value_list.nr - 1;
>>  
>> -	if (!reader->source)
>> -		BUG("configset_add_value has no source");
>>  	if (reader->source->name) {
>> -		kvi_from_source(reader->source, current_config_scope(), kv_info);
>> +		kvi_from_source(reader->source, kvi_p->scope, kv_info);
>>  	} else {
>> -		/* for values read from `git_config_from_parameters()` */
>> -		kv_info->filename = NULL;
>> -		kv_info->linenr = -1;
>> -		kv_info->origin_type = CONFIG_ORIGIN_CMDLINE;
>> -		kv_info->scope = reader->parsing_scope;
>> +		kvi_from_param(kv_info);
>>  	}
>>  	si->util = kv_info;
>>  
>
> Any reason to remove the "if (!reader->source)" guard? I don't think
> this patch does anything to ensure that reader is present. We can
> probably remove this once "reader" is removed.

Hm you're right, this shouldn't be removed here. I think this a leftover
from an ancient version where I dropped references to "reader".
