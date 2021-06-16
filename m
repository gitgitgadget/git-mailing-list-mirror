Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65852C48BE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 13:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C3596102A
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 13:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbhFPNWy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 09:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbhFPNWx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 09:22:53 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB88C061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 06:20:47 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id r19so1501071qvw.5
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 06:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F8rQohKxDg0cBbTc1oQAXEZ9Vk+xh69omxEMzwXVIzQ=;
        b=sw6wX5erTdN622AL2oAwGeHya5JcooJbCIGLr80C820XGayhswJjdN0ajwmLftxesI
         hq+bbhPwxy/aTuLn+/ay1hvy/EJrTLyzWMZI2bjQpZK6yYRNFJl6H4IarpKQfvjN4WuF
         QBFrYbGgPmIir8RIZ/NUVR0YRtVkqL6nVzQJHm3WKdksq2M8kA3rrfnU1fnQUkI6H7Bd
         LzSO4Am5Holoo7T1gwANESZz4JrC9JrN0N3DNOl936Kh2EtLZIcMw0yjyDl5gO8Rfn4m
         kVgC1YpGwEKG5A8chPR+e3w3KDEd3qtHoC9WGsSh74NA2Pc6rIR4+3uKse+cqSJHAse9
         8gGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F8rQohKxDg0cBbTc1oQAXEZ9Vk+xh69omxEMzwXVIzQ=;
        b=Lc0PVPzjk5Q8NsVK1S7ZV29B+c9gYAhqJvRh2V1bCEQJC20RW3bq86G1mdae1w5f/p
         4x4w+H1B5IA8QY+pl9ul6U2H/s09JqL9zTH85nmGJ6kjbD+Lgyb1rE/JcLetc2a1KyxP
         x9uB23IOBbXgWZhU+AZg8bdXb6t+56ZGx7rYnjKylHT+meUsuFGLkH02i1jUL1JJ3N0G
         qpdjJwnrTO2OjfuXzm+4FXYOLwPdCgPfW9pF+2W/jdCo8uuG/ubj2G0qRvhUdeKMMu9Z
         4q6jDuvy+sTX61a2okcLkqScph/uwR+Ab/mVmRO8RsSimisskyKHJKomdfhMvEhqOOL2
         fOdw==
X-Gm-Message-State: AOAM533Ib61AEV4UP73qR2O4zHQz4QptU/unKM7Z2Vn/sd5877er9rZu
        Dx5yHq5s4TBz5oagXIIfeX4=
X-Google-Smtp-Source: ABdhPJydkf7kAz3yxR9i40WLS/xnjgn6m8Z8c2MUf2rpsNoMxWt8fRelpRsP7550XZG1Lz8DnspylA==
X-Received: by 2002:ad4:4f2d:: with SMTP id fc13mr7138qvb.0.1623849646613;
        Wed, 16 Jun 2021 06:20:46 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id 6sm1305637qky.27.2021.06.16.06.20.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 06:20:46 -0700 (PDT)
Subject: Re: [BUG] `git reset --hard` fails with `update = none` submodules
To:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Rose Kunkel <rose@rosekunkel.me>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
References: <CAKjYmsELpf9r3bAJj_JUHgVegw_7z2KzyuR_6FYYngpC1XmNeg@mail.gmail.com>
 <YMlLGwScowX8eXeJ@camp.crustytoothpaste.net>
 <CAKjYmsHD2MuTE+drebKichz_0wquPN8ZTLbiPkUCZJyLsSFh8Q@mail.gmail.com>
 <CAKjYmsEHWShuKEOFWnCyU1x5rM7kFrcaN78D7KhhUay8kCvA2g@mail.gmail.com>
 <YMlS+1F9IND7vxNI@camp.crustytoothpaste.net> <xmqqeed2sdwc.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <3b53846d-7611-521a-274c-473e00266529@gmail.com>
Date:   Wed, 16 Jun 2021 09:20:44 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqeed2sdwc.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Le 2021-06-15 à 23:10, Junio C Hamano a écrit :
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
>> On 2021-06-16 at 01:03:40, Rose Kunkel wrote:
>>> Potentially relevant: `git config --global --list` shows
>>> ```
>>> status.showstash=true
>>> status.submodulesummary=true
>>> submodule.recurse=true
>>
>> Thanks for this additional information.  This line is the critical
>> piece.  Now I get this:
>>
>>    $ git reset --hard
>>    fatal: not a git repository: ../../.git/modules/repos/agda
>>    fatal: could not reset submodule index
>>
>> Predictably, "git -c submodules.recurse=true reset --hard" also results
>> in the same thing.
>>
>> The --recurse-submodules option for git reset says this (emphasis mine):
>>
>>    When the working tree is updated, using --recurse-submodules will also
>>    recursively reset the working tree of all *active* submodules
>>    according to the commit recorded in the superproject, also setting the
>>    submodules' HEAD to be detached at that commit.
>>
>> On my system, .git/config has this:
>>
>>    [submodule]
>>            active = .
>>
>> So these submodules are active, but they probably should not be, since
>> we haven't checked anything out (or, for that matter, cloned any data)
>> and it wouldn't make sense to try to operate on them automatically with
>> submodules.recurse or --recurse-submodules.
>>
>> My gut tells me that we should probably mark submodules with update=none
>> set on a clone as inactive.  Of course, this is a tricky area that I'm
>> not super familiar with, so opinions or thoughts are welcome.
>>
>> If folks think this is a good way forward, I'll look into writing a
>> patch, probably tomorrow evening since it's starting to get late here.

This is probably a good fix. 'git clone --recurse-submodules' is really
too eager to write the 'submodule.active=.' config but it should be more careful;
the above is an example and [1] is another one.

I think it is a good way forward that having 'submodule.$name.update=none' in
'.gitmodules' means that 'git clone' would write 'submodule.$name.active=false'
to the local config. This way it would still be the case that 'submodule.$name.update'
itself only ever applies to 'git submodule update', which is what is documented [2].

A longer term plan could be to completely deprecate 'submodule.$name.update=none' and allow
'submodule.$name.active' in '.gitmodules'. Maybe anecdotal, but at least one user [3]
tried to do that and found out it does not work. Having 'active' allowed in '.gitmodules'
would (I think) cover all uses cases for 'update=none', which could then be deprecated,
but that would need a transition period. But this change is not necessarily needed; it
would just make the whole system more consistent IMO.

Cheers,

Philippe.
P.S. The current bug was reported last year [4] but I could not reproduce it at when I
replied. Adding '--force' to the 'git checkout other-branch' command in my reproducer
script does trigger the bug, though.


[1] https://lore.kernel.org/git/20200501005432.h62dnpkx7feb7rto@glandium.org/T/#u
[2] https://git-scm.com/docs/git-config#Documentation/git-config.txt-submoduleltnamegtupdate
[3] https://lore.kernel.org/git/HE1PR04MB2987A255BC327320D1DDFE6692F70@HE1PR04MB2987.eurprd04.prod.outlook.com/
[4] https://lore.kernel.org/git/CABVQXt5E-R22G62W-tQieA7XiZKZiOA8Hp2xewYhwwOS8wFh0Q@mail.gmail.com/
