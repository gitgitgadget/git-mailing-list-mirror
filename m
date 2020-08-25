Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1332EC433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 12:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E112820706
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 12:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbARa/P0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgHYMpx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgHYMpw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 08:45:52 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86ED2C061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 05:45:52 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id r8so734723ota.6
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 05:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rwsjZm5ldAFvJ2QwQKuo8GUN3JcCFCTTXAQDssLNFW8=;
        b=LbARa/P0yhe61dTYv3XKdSSgo3UD9EFg8iv1ABCyFXWz8EvKVVWh+CNWVYiJkDOXE0
         ueto3OUKh6UgGwSzumjZNji+VDINw+uNtgReaclkZB5AHkDfTTQIDa7w4zh6cONsoH7P
         OfDp6K+8buYFanZ8XgCQJIiMbGdL7zWe4WNtvsyh/Vb5tZqt5eWtv791GmPUu7tRDxyN
         fvoJv5/nzw4A+8KvUbTz9n3sachBGJIPwK7q1R//2Z0TpS4xcg9+0bHzxcHtG7IN3vu6
         4okooW40LE8S2Vv/bx9bI/ixQiBhoKXwYuNybo62HqTHXZN4ypv9bUMepPOBnZa11DCB
         /2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rwsjZm5ldAFvJ2QwQKuo8GUN3JcCFCTTXAQDssLNFW8=;
        b=j4QFrSZ9Dzn3EgO8/dId2F/dbGjNU9gNUO9uhkO59/fCVLTsiJTz56+IEeWKSlgh3O
         wpKzlPLYi/CmxvMXcJ/pFWWAE33Clg7Z4iqzy4OMCDIOnCzq2WlPaMjIQiJ/3gPPZwUP
         NN53ar84IJvVa5j6Jhru/if9nHboXFf0fJfgnTByHFZs0ViYg3lC7ikVXO6cK2e6w8L/
         5a8YHIByTcKDHTSZWzdqiheZhhXTi4kaY685G8sTtO0o17vYPi8WHMeaiUB411dQf+Rj
         eG1BRZrwnWMXiZWzurzbketcAou6p6pP72IQ75017255e4jfsR5i+460HOW9CLDCikHM
         BwOA==
X-Gm-Message-State: AOAM530wCMGClwrVLbRO9bbMmolTCaJoYpuOJ+FY1JrLvDWCk2jsOzZp
        nId5BD3uBfbS8GG9gg547QxcoIh5gq137A==
X-Google-Smtp-Source: ABdhPJy+/l8WvQzi2qKjsqRA//oBP+17fMTBVUK1MnebmZMYH5cpu64N48oIwygKhK9UZZtJGNUE5g==
X-Received: by 2002:a9d:3c6:: with SMTP id f64mr6900811otf.364.1598359551837;
        Tue, 25 Aug 2020 05:45:51 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:600d:49d2:12ae:f5e7? ([2600:1700:e72:80a0:600d:49d2:12ae:f5e7])
        by smtp.gmail.com with ESMTPSA id f20sm2626416otq.80.2020.08.25.05.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 05:45:51 -0700 (PDT)
Subject: Re: [PATCH] builtin/repack.c: invalidate MIDX only when necessary
To:     Son Luong Ngoc <sluongng@gmail.com>, Taylor Blau <me@ttaylorr.com>
Cc:     git <git@vger.kernel.org>, dstolee@microsoft.com
References: <ef9186a8df0d712c2ecccbe62cb43a7abadb9c96.1598320716.git.me@ttaylorr.com>
 <CB6B70D3-5FC6-43FE-8460-33F6CFC123E6@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4caa4d87-d5f8-6f34-025c-0f23506a19fb@gmail.com>
Date:   Tue, 25 Aug 2020 08:45:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <CB6B70D3-5FC6-43FE-8460-33F6CFC123E6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/25/2020 3:55 AM, Son Luong Ngoc wrote:
> Hi Taylor,
> 
> Thanks for working on this.
> 
>> On Aug 25, 2020, at 04:01, Taylor Blau <me@ttaylorr.com> wrote:
>>
>> In 525e18c04b (midx: clear midx on repack, 2018-07-12), 'git repack'
>> learned to remove a multi-pack-index file if it added or removed a pack
>> from the object store.
>>
>> This mechanism is a little over-eager, since it is only necessary to
>> drop a MIDX if 'git repack' removes a pack that the MIDX references.
>> Adding a pack outside of the MIDX does not require invalidating the
>> MIDX, and likewise for removing a pack the MIDX does not know about.
> 
> I wonder if its worth to trigger write_midx_file() to update the midx instead of
> just removing MIDX?

It would be reasonable to have 'git repack' run write_midx_file() after updating
the pack-files, but it still needs to delete the existing multi-pack-index after
deleting a referenced pack, as the current multi-pack-index will be incorrect,
leading to possibly invalid data during the write. 'git multi-pack-index expire'
carefully handles deleting pack-files that have become redundant.

It may be possible to change the behavior of write_midx_file() to check for the
state of each referenced pack-file, but it would then need to re-scan the
pack-indexes to rebuild the set of objects and which pack-files contain them.

> That is already the direction we are taking in the 'maintenance' patch series
> whenever the multi-pack-index file was deemed invalid.

The 'maintenance' builtin definitely adds new MIDX-aware maintenance tasks.
By performing a repack using the multi-pack-index as the starting point, we
can get around these issues.

One thing I've noticed by talking with Taylor about this change is that
'git repack' is a bit like 'git gc' in that it does a LOT of things and it
can be hard to understand exactly when certain sub-tasks are run or not.
There are likely some interesting operations that could be separated into
maintenance tasks. For example, 'git repack -d' is very similar to
'git maintenance run --task=loose-objects'.

> Or perhaps, we can check for 'core.multiPackIndex' value (which recently is 
> 'true' by default) and determine whether we should remove the MIDX or rewrite
> it?

We currently rewrite it during 'git repack' when GIT_TEST_MULTI_PACK_INDEX=1
to maximize how often we have a multi-pack-index in the test suite. It would
be simple to update that to also check a config option. I don't think adding
that behavior to 'core.multiPackIndex' is a good direction, though.

Thanks,
-Stolee
