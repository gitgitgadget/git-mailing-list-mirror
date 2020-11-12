Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651C2C2D0A3
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 13:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06D0A20A8B
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 13:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fk6W2zPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgKLN4t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 08:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbgKLN4s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 08:56:48 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1E1C0613D1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 05:56:48 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id u127so6440698oib.6
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 05:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1HpbupDAjVrRix1jq4Rgfc0FffW+QggWtByC8qWhUh4=;
        b=Fk6W2zPbHYA9oMFDbvLrZibLzH2362M4WB3kdOm2QWbg8RqtO219jnVxCKEyv0MFTs
         8KgC8lbEY4Fi5hLA+RhhYuOACIMw66E7vUpFey9W6/CbJ0/2g6eMfaPl3cHg2vV1w8aO
         hPr0wPBZAx6yrjUahzbNNM/NTO6ToXWRHGzoFwDbeebOfArTI3E0oqaxl1wNJ+B0vzUH
         D1R2ytitV8NwUDDlW0Su06cFjZkBHjQfQPAeqOJvIyor4Adw65Ynw7zzr8ckkS0m018g
         yOTXg58LWrM28kB5a6yvdrrJEEjp1jYgYGSKzIKgmleoQXBk0N3HRTSPhrH2SUuYTnqB
         hKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1HpbupDAjVrRix1jq4Rgfc0FffW+QggWtByC8qWhUh4=;
        b=d5q21OqDPckmW5qP0fqbIrYyV+lb+YlKzWqqYZnuP09GZl/7eKRsj9mlQtMdhsFOUR
         i3Ul88C+v1EFSeobN3hqmcdYH6Vu7gkWUlrOE8udDdyEOeyGVe1daEDZU49rNcRKMKnJ
         oJMjHR+aEahMNsToLQj80PsgMYJepuLqsRyXIwioxFjmo32Y2oqWh8+7P28wnRA3fauP
         YqRbLUzuWc+UwHhCtoo6yPO+bySnufOxOOaPWrD8aRymXQZfdTFneWE3e3HFD8NeBiPc
         Ouhl5EEmUqdLAwic5gqyG44eGUu+eGcV5zlGfRxY+24oIfMevWi/79QJpsDl3VYYjPja
         0wkw==
X-Gm-Message-State: AOAM533JP+f5KmEFOaI/jKD1H4YRQ4WkFP5l8qfBuxy5j9cSKdVAoW+r
        XBrNpnoqaBvF/tbdOQc9rWg=
X-Google-Smtp-Source: ABdhPJxh+TOyGySy21yqKQAvgUMQQva+kU61Z5zS8XoWIRZLVWmW/q79LIbYL02zEi+YRN5CUxJEeQ==
X-Received: by 2002:aca:3246:: with SMTP id y67mr5675395oiy.159.1605189407670;
        Thu, 12 Nov 2020 05:56:47 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:30c9:afaa:d787:e592? ([2600:1700:e72:80a0:30c9:afaa:d787:e592])
        by smtp.gmail.com with UTF8SMTPSA id k20sm1274766ooh.47.2020.11.12.05.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 05:56:47 -0800 (PST)
Subject: Re: [PATCH v2 4/4] maintenance: use Windows scheduled tasks
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.776.git.1604412196.gitgitgadget@gmail.com>
 <pull.776.v2.git.1604520368.gitgitgadget@gmail.com>
 <84eb44de31f04b2a94f57ee11d70be81f5bbeee2.1604520368.git.gitgitgadget@gmail.com>
 <CAPig+cRRQc=RNd=zGFvi2yiLD6PoLLBJQtFxkZ+QaVVA9MP1DA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d46826a5-0c30-3d71-26a0-f579d997c3a0@gmail.com>
Date:   Thu, 12 Nov 2020 08:56:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cRRQc=RNd=zGFvi2yiLD6PoLLBJQtFxkZ+QaVVA9MP1DA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/11/2020 3:59 AM, Eric Sunshine wrote:
> On Wed, Nov 4, 2020 at 3:06 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> Git's background maintenance uses cron by default, but this is not
>> available on Windows. Instead, integrate with Task Scheduler.
>> [...]
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>> diff --git a/builtin/gc.c b/builtin/gc.c
>> @@ -1698,6 +1698,187 @@ static int platform_update_schedule(int run_maintenance, int fd)
>> +static int schedule_task(const char *exec_path, enum schedule_priority schedule)
>> +{
>> +       xmlpath =  xstrfmt("%s/schedule-%s.xml",
>> +                          the_repository->objects->odb->path,
>> +                          frequency);
> 
> Am I reading correctly that it is writing this throwaway XML file into
> the Git object directory? Would writing to a temporary directory make
> more sense? (Not worth a re-roll.)

A temp directory is a good idea.

>> +       xmlfp = fopen(xmlpath, "w");
>> +       if (!xmlfp)
>> +               die(_("failed to open '%s'"), xmlpath);
> 
> Could use xfopen() as mentioned previously.
> 
>> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
>> @@ -442,6 +442,36 @@ test_expect_success MACOS_MAINTENANCE 'start and stop macOS maintenance' '
>> +test_expect_success MINGW 'start and stop Windows maintenance' '
>> +       for frequency in hourly daily weekly
>> +       do
>> +               printf "/create /tn Git Maintenance (%s) /f /xml .git/objects/schedule-%s.xml\n" \
>> +                       $frequency $frequency
> 
> Nit: You lost the `|| return 1` which was present in the previous
> version. True, it's very unlikely that `printf` could fail, but having
> the `|| return 1` there makes it easier for the reader's eye to glide
> over the code without having to worry about whether it is handling
> error conditions correctly, thus reduces cognitive load.
>
>> +       done >expect &&
> 
> Rather than a loop, you could just use:
> 
>     printf "/create ... (%s) /f /xml ...schedule-%s.xml\n" \
>         hourly hourly daily daily weekly weekly >expect &&
> 
> though it's subjective as to whether that is an improvement.

It's sufficient, and avoids issues with deep tabbing and
chaining "|| return 1"".

Thanks,
-Stolee

