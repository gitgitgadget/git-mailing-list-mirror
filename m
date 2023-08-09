Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC93C001B0
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 10:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjHIKAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 06:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjHIKAs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 06:00:48 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7CA1FDF
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 03:00:47 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe4b45a336so39652645e9.1
        for <git@vger.kernel.org>; Wed, 09 Aug 2023 03:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691575246; x=1692180046;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HLwvEjV9mp5uez5xQvbUo99eCaRNk9e/uwDkyaeaNVA=;
        b=ZslhoBL+rcJI9Xsk0r8+FgtM5pAo4XUFPOIT9yCJTiLJ1lY5UNJHSNIupLY3XqO+VB
         M5n3D0x9Fm01LOSBm8TnhehS/AWeQLtpbW6j9g1EeP2VEjlA+MeIu/QgiGGzgrp5tNJM
         xRytFcCjX6fylKcvAxriVRV+ug3R7EmoMraaZOTaQdB9q849sJSeHxX7lhf6momzrbk2
         WyIzIA1IbkolD+HlXBtorfXL3iKu/qY/Be8hoLKnmCFwU4uf/SH8B9mb8yIWr4NBMR7p
         t0K4o2yGlEvphUAhwQUHoNB4kcSpxZ3YUzbv7Leqr8LrM19vh4UZ0qwlKiZ6wct0FVfG
         PfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691575246; x=1692180046;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HLwvEjV9mp5uez5xQvbUo99eCaRNk9e/uwDkyaeaNVA=;
        b=Zlj8O5aK6EAMetZZIRoDNo2cKkiXwHE0DZ9cN7cW7OZKmesITRfI7XYGbkNcUHLTGN
         vx5WSiHdCfSZEuAQ85iP8MFLW7dQbxfiJ0BZqcVoRTTonW2Hc/JdWOyvhtNRd8FmA38g
         3BPiNEjJB/3MRTqok7RE2KT2zCEC191VCsFIridpTVxztHj+HgL5gLNzcm9ai6u24L+v
         u11kRQz01CqT5pqUr2t1KTms5hhb6/shVbbQBaQIkhHBWwz7+m8Arq+MxzwQLJnRBVpn
         h+dS+SfZpya3uUvlkW0N+HoWHZrLXLa+ar714nDvhE0cY0cKGGdiIlY47JN39WpBQyXX
         cyMA==
X-Gm-Message-State: AOJu0YwH55oNxWw+DTrVhogqi+ib9BVDdtV/Ge7+vaTcS/vdPrqACa3w
        asttvHYCQwvJm5/fSrZFCTc=
X-Google-Smtp-Source: AGHT+IHYjB50Ie8vmyyPRyAe9gx9EzvIb8USjv9/ZlKVEsF5s+VSddRlWt/IXcDzMQSZySdz3GuOGw==
X-Received: by 2002:a5d:5545:0:b0:317:e542:80a8 with SMTP id g5-20020a5d5545000000b00317e54280a8mr1598119wrw.15.1691575245516;
        Wed, 09 Aug 2023 03:00:45 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id j9-20020a5d4489000000b0031411b7087dsm16426692wrq.20.2023.08.09.03.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 03:00:45 -0700 (PDT)
Message-ID: <6f469118-8a7e-0b8d-33e3-c9ef486a262f@gmail.com>
Date:   Wed, 9 Aug 2023 11:00:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 6/6] maintenance: use random minute in systemd scheduler
Reply-To: phillip.wood@dunelm.org.uk
To:     Derrick Stolee <derrickstolee@github.com>,
        phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, lenaic@lhuard.fr
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
 <14e340b75faaa66980479f42fec14c457aea5c74.1691434300.git.gitgitgadget@gmail.com>
 <3e254d61-b74a-f419-1a03-dbc557a9fe86@gmail.com>
 <d247ce48-e2ba-4915-8d96-1fa2f693909d@github.com>
 <2e9b32a8-8905-4a1f-a75b-ca747ae95b96@github.com>
Content-Language: en-US
In-Reply-To: <2e9b32a8-8905-4a1f-a75b-ca747ae95b96@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/08/2023 18:14, Derrick Stolee wrote:
> On 8/8/2023 1:06 PM, Derrick Stolee wrote:
>> On 8/8/2023 8:08 AM, Phillip Wood wrote:
>>> On 07/08/2023 19:51, Derrick Stolee via GitGitGadget wrote:
> 
>>>> +    char *local_timer_name = xstrfmt("git-maintenance@%s.timer", frequency);
>>>
>>> The "@" in the name signifies that it is a template unit which it isn't anymore so I think we want to change this to "git-maintenance-%s.timer"
>>
>> I'll also take your SYSTEMD_UNIT_FORMAT macro suggestion to simplify things.
> 
> As I was checking things, it turns out that we _should_ keep the '@' symbol
> if only to make sure that our new schedule overwrites the old schedule.

Oh, so if the user already has scheduled maintenance set up then running 
"git maintenance start" adds a new set of timers. I'd not though about that.

> The alternative is that we manually try to delete the old schedule, but that
> feels like an inefficient way to do it, leaving some cruft around long-term.

This patch still changes the names of the files we write. Currently we write

	$XDG_CONFIG_HOME/systemd/user/git-maintenance@.service
	$XDG_CONFIG_HOME/systemd/user/git-maintenance@.timer

and this patch changes that to

	$XDG_CONFIG_HOME/systemd/user/git-maintenance@hourly.service
	$XDG_CONFIG_HOME/systemd/user/git-maintenance@daily.service
	$XDG_CONFIG_HOME/systemd/user/git-maintenance@weekly.service
	$XDG_CONFIG_HOME/systemd/user/git-maintenance@hourly.timer
	$XDG_CONFIG_HOME/systemd/user/git-maintenance@daily.timer
	$XDG_CONFIG_HOME/systemd/user/git-maintenance@weekly.timer

If the user has already enabled maintenance then

	$XDG_CONFIG_HOME/systemd/user/timers.target.wants/git-maintenance@hourly.timer
	$XDG_CONFIG_HOME/systemd/user/timers.target.wants/git-maintenance@daily.timer
	$XDG_CONFIG_HOME/systemd/user/timers.target.wants/git-maintenance@weekly.timer

will exist and are all symlinks pointing to

	$XDG_CONFIG_HOME/systemd/user/git-maintenance@.timer

After this patch if the user runs "git maintenance start" again then 
systemctl will update the symlinks tot point to the matching unit files 
rather than the old template file. That means the user will pick up the 
new schedule but we leave behind the original files that are unused.

> For completeness, here is what I did to check:
> 
> $ systemctl --user list-timers
> NEXT                        LEFT        LAST                        PASSED       UNIT                         ACTIVATES
> Tue 2023-08-08 13:13:00 EDT 6s left     n/a                         n/a          git-maintenance-hourly.timer git-maintenance-hourly.service
> Tue 2023-08-08 13:50:00 EDT 37min left  Tue 2023-08-08 12:50:10 EDT 22min ago    git-maintenance@hourly.timer git-maintenance@hourly.service
> Wed 2023-08-09 00:13:00 EDT 11h left    n/a                         n/a          git-maintenance-daily.timer  git-maintenance-daily.service
> Wed 2023-08-09 00:50:00 EDT 11h left    Tue 2023-08-08 09:35:31 EDT 3h 37min ago git-maintenance@daily.timer  git-maintenance@daily.service
> Mon 2023-08-14 00:13:00 EDT 5 days left n/a                         n/a          git-maintenance-weekly.timer git-maintenance-weekly.service
> Mon 2023-08-14 00:50:00 EDT 5 days left Mon 2023-08-07 10:28:10 EDT 1 day 2h ago git-maintenance@weekly.timer git-maintenance@weekly.service
> 
> Do you have an alternative idea how to handle that?

I think we should stick with the names as you have them. It might be 
worth keeping the service file as a template so we only write the new 
timer files and have a reason to use the "@" naming scheme. We could 
update systemd_timer_setup_units() to delete git-maintenance@.timer if 
we successfully enable the new timer unit files.

Sorry for the confusion, I should have thought about the user running 
"git maintenance start" for a second time.

Best Wishes

Phillip
