Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C9EC04A6A
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 16:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjHHQji (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 12:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbjHHQi6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 12:38:58 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2F83A4E1
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 08:54:10 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6bd066b0fd4so586335a34.2
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 08:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1691510045; x=1692114845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y85ZAZ2FDpwy7pap6Ngi7xsLGvu87UytqwjVgogx1YI=;
        b=gB65eVzcQTzJ2uSiJ/h/ykCucKQcg++lLYZPXO86u8obObVMOSV8Rm/2liwIufK9tA
         gZGo9arPSAyd0UqO2PemqlwC8y564uYg4Wqyep8vl7aY2dZpghEiWQR1SX8KScPge/UR
         JsC1wXj7xu7vdO/TfmyqGJmtozAmBrHbZuUto/asozPNQ2jtNtKYgs5tI0jmT+JApXcT
         yMmv2T0KwWahoAoXlaYE2tt6w8ppUNQjbYwolba/vFFG5wAnr6bmUVzOcpC0dPgFEEue
         EeoFQnCS3gANj5qd4QhjupVi5ZODLufLIrd14y9x8125FokQrpQEXbUXIhEaCmaKe1Ur
         0YQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510045; x=1692114845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y85ZAZ2FDpwy7pap6Ngi7xsLGvu87UytqwjVgogx1YI=;
        b=dScEdqYTgo6Vgcc8yHTd6paK6Qu7mwcg0FLHQZdwkZDJOg3FeVTHmIr+clyO+sFSTy
         slaEUoy4epCtrARvPup2TjQQ3bZYXYgu/tu7pmpm6t4hkZt5VO0x5Ep6fzx2/CZK6EhN
         /VLoTHNvdt66tRQAQ/0u8AVfCPmP0IUGFj24bL5dRXD26imxl7uoVXXuUia5RccpwKQy
         RsI1dKkxOMn+ZiPWdLa7jSyiTyCgSAkA3G3KNhBnQGq460VRj01Pg07C805mDQFYCnQG
         M6B9nDvRMSCbCVQakDcDZQT+lG+qkBSQRz5RiHFDyMj/BKl+Vq89ok0A1meDv7dHptQJ
         PQiw==
X-Gm-Message-State: AOJu0YxfeRmahptjOQrsgYAdzSeiVJ7d/N/89oSooT/WHhdW+bo4Egz+
        BLAmTZOUBGMXXrUuG9T8jW/f26/VTStBcQ5CpQ==
X-Google-Smtp-Source: AGHT+IE6ENT6NVJKIkv7cGBJP1iUAVfgZ0qW+W2Qu0Tb1GdmuUPtXlUZjJ1uIXjzU5FHropN1OTSUg==
X-Received: by 2002:aca:1314:0:b0:3a4:6691:9340 with SMTP id e20-20020aca1314000000b003a466919340mr11529458oii.41.1691502583963;
        Tue, 08 Aug 2023 06:49:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f1d2:c14b:5536:5192? ([2600:1700:e72:80a0:f1d2:c14b:5536:5192])
        by smtp.gmail.com with ESMTPSA id bk2-20020a0568081a0200b003a7a34a4ed8sm1535104oib.33.2023.08.08.06.49.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 06:49:43 -0700 (PDT)
Message-ID: <2db943c3-2ec2-4b7e-a161-a7c9b3f04d36@github.com>
Date:   Tue, 8 Aug 2023 09:49:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] maintenance: use random minute in systemd scheduler
To:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, lenaic@lhuard.fr
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
 <14e340b75faaa66980479f42fec14c457aea5c74.1691434300.git.gitgitgadget@gmail.com>
 <ZNFinmsgDI7Upw60@nand.local>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ZNFinmsgDI7Upw60@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/7/2023 5:31 PM, Taylor Blau wrote:
> On Mon, Aug 07, 2023 at 06:51:40PM +0000, Derrick Stolee via GitGitGadget wrote:

>> Modify the template with a custom schedule in the 'OnCalendar' setting.
>> This schedule has some interesting differences from cron-like patterns,
>> but is relatively easy to figure out from context. The one that might be
>> confusing is that '*-*-*' is a date-based pattern, but this must be
>> omitted when using 'Mon' to signal that we care about the day of the
>> week. Monday is used since that matches the day used for the 'weekly'
>> schedule used previously.
> 
> I think the launchd version (which uses "0" for the day of the week)
> runs on Sunday, if I remember correctly. I don't think that these two
> necessarily need to run on the same day of the week when configured to
> run weekly.
> 
> But I figured I'd raise the question in case you did mean for them to
> both run on either Sunday or Monday.

I don't intend to change the day that is run as part of this change.

I think all other schedulers run on Sunday, but systemd running on Monday
is a particular detail of its "weekly" schedule.

>> -static int systemd_timer_write_unit_templates(const char *exec_path)
>> +static int systemd_timer_write_unit_template(enum schedule_priority schedule,
>> +					     const char *exec_path,
>> +					     int minute)
>>  {
>>  	char *filename;
>>  	FILE *file;
>>  	const char *unit;
>> +	char *schedule_pattern = NULL;
> 
> You should be able to drop the NULL initialization, since you assign
> this value unconditionally in the switch statement below (or BUG() on an
> unknown schedule type).

Unfortunately, GCC complained about a possibly-unassigned value when I
left this unset during development, so this actually is necessary for
that compiler.

Thanks,
-Stolee
