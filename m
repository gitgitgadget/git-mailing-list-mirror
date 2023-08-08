Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747A2C41513
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 18:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjHHSxE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbjHHSwq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 14:52:46 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2BB156FA6
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 10:07:01 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d4f022c6c91so3023121276.2
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 10:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1691514420; x=1692119220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+yLZ9C5T8qG9emq+X6OnWJNhPTIlSxNmKuo6bLTduDk=;
        b=ULG/EXqAqCFlOQqUvb1bGu1FFIMJ+QKTxv7uNL4YECeSSRhgWZCDues0tBVnoW9ZhF
         UXV09OE0ly8oMuEZ+4Melbqt33tTW4h/5CrOEtDSmwRHWsKnVROYod3yExJSJCKZcSfA
         m3lRWKzAIZzM+CXWDEB8/FE2HpXsjnC6JjoroKlkQOqBBLZYVTpH4zGmCVbyZJtuw9Uo
         7754eKiWcClfMFOBJJe7hQ3AfqOLVri+wN5zXePdRtj8ycTl2viCvC0LfeD+pZ0+bSWo
         OGw7rZCgTmliqBSF977KY8tsQn4E16yXzIpzdxgj0VLnYteBLJBAZ40UO6GSX9NAwTJ8
         +SFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514420; x=1692119220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+yLZ9C5T8qG9emq+X6OnWJNhPTIlSxNmKuo6bLTduDk=;
        b=iO7Ex86wWt5ZyID+9SId/oUobf9orQYZSpVyTqQwsoLv+x7XGw18QrFOTTi5eNpUaO
         wf6C60lMoRkygJb6NAFatwVtxaB6q63x5itCV1QURoakCeBNaTC2FSmAo7/GZtL+nySt
         7K13Zp6ttKsv2SOa9pJCfkwv5zyFzyGNSXJ6v/GjTMD4OOcrTgPhqIKMq/TjpIDzEInw
         yyaHoVfkrXE6Rocu0n4276LVGjCcRT+WDZYG6pjnpyw2ZVcswI1AEPh5LwECX15hfukS
         ghAM5T/pJRqav8bSIBxvu8g9bMTSnYK7KS2rphwgiaJS43CNwbHQByUJFE574lQfYpd0
         YApg==
X-Gm-Message-State: AOJu0YzjjzuRb0omELrxklnveOxE/Q4bgs/qT45guBIFX9xahvMyvbcR
        cmanNhJvJUT4jxg7PvASeqOg
X-Google-Smtp-Source: AGHT+IG3iXBn2XNOMm1api/iej7zuLEoKSn+NiTBVRxwP25/bVcBXVymAfF5cUjUeJjTu0VTK3De3w==
X-Received: by 2002:a25:e0c2:0:b0:d04:f936:556 with SMTP id x185-20020a25e0c2000000b00d04f9360556mr232764ybg.36.1691514420376;
        Tue, 08 Aug 2023 10:07:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f1d2:c14b:5536:5192? ([2600:1700:e72:80a0:f1d2:c14b:5536:5192])
        by smtp.gmail.com with ESMTPSA id c16-20020a25f310000000b00c62e0df7ca8sm2801110ybs.24.2023.08.08.10.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 10:07:00 -0700 (PDT)
Message-ID: <d247ce48-e2ba-4915-8d96-1fa2f693909d@github.com>
Date:   Tue, 8 Aug 2023 13:06:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] maintenance: use random minute in systemd scheduler
To:     phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, lenaic@lhuard.fr
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
 <14e340b75faaa66980479f42fec14c457aea5c74.1691434300.git.gitgitgadget@gmail.com>
 <3e254d61-b74a-f419-1a03-dbc557a9fe86@gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <3e254d61-b74a-f419-1a03-dbc557a9fe86@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/8/2023 8:08 AM, Phillip Wood wrote:
> On 07/08/2023 19:51, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> The get_random_minute() method was created to allow maintenance
>> schedules to be fixed to a random minute of the hour. This randomness is
>> only intended to spread out the load from a number of clients, but each
>> client should have an hour between each maintenance cycle.
>>
>> Add this random minute to the systemd integration.
> 
> I think it makes sense to keep the random minute implementation the same across all the schedulers, but we could use RandomizedDelaySec (possibly combined with FixedRandomDelay) to randomize when the job is actually run.

That's an interesting suggestion, but I also think it is valuable to
have consistent gaps between maintenance activities on the client, but
RandomizedDelaySec would present the possibility of 60-3540 seconds between
"hourly" maintenance runs (if I understand the option correctly).

>> @@ -2299,13 +2299,20 @@ static char *xdg_config_home_systemd(const char *filename)
>>       return xdg_config_home_for("systemd/user", filename);
>>   }
>>   -static int systemd_timer_write_unit_templates(const char *exec_path)
>> +static int systemd_timer_write_unit_template(enum schedule_priority schedule,
> 
> As we're not writing template files any more I think we should rename this to systemd_timer_write_unit_file()

Good point. I have adjusted all the names in my next version.

>> +                         const char *exec_path,
>> +                         int minute)
>>   {
>>       char *filename;
>>       FILE *file;
>>       const char *unit;
>> +    char *schedule_pattern = NULL;
>> +    const char *frequency = get_frequency(schedule);
>> +    char *local_timer_name = xstrfmt("git-maintenance@%s.timer", frequency);
> 
> The "@" in the name signifies that it is a template unit which it isn't anymore so I think we want to change this to "git-maintenance-%s.timer"

I'll also take your SYSTEMD_UNIT_FORMAT macro suggestion to simplify things.
 
>> +    char *local_service_name = xstrfmt("git-maintenance@%s.service", frequency);
> 
> Same change to the name here. I wonder if we could still use a template service file but that would complicate the implementation as we'd need to write three timer files but only one service file.

Since we execute systemctl only passing the .timer filename, I think we'd
need to keep the '@' symbol in the name if we wanted to use .schedule
templates. Best to keep things simple and abandon templates completely.

>> [...]
>> @@ -2375,13 +2399,16 @@ static int systemd_timer_write_unit_templates(const char *exec_path)
>>       return 0;
>>     error:
>> +    free(schedule_pattern);
>> +    free(local_timer_name);
>>       free(filename);
>> -    systemd_timer_delete_unit_templates();
> 
> This looks like a change in behavior as previously we'd remove any files if there was an error rather than leaving behind a timer file without a corresponding unit file.

The callers take care of deleting the unit files, but there was one place
where a short-circuit could have avoided this deletion. I'll clean that up.

> Looking at maintenance_start() we call maintenance_register() which disables "gc --auto" before we get to this point so if we fail to write the files we'll end up disabling any form of gc in the repository.

Adding this to the list of cleanups at the end. Thanks.

I appreciate the careful review!

Thanks,
-Stolee

