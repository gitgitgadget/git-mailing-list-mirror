Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9481BC636C8
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82D41613DB
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhGORay (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 13:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhGORav (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 13:30:51 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7E3C06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 10:27:58 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id x16-20020a4aea100000b0290263aab95660so756792ood.13
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 10:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J0beVQPQXy6f2RYjne5SWUE9ypNgckb1zCkLWuZ2CO8=;
        b=gV4ZoQNNg23QJ8Eh5jMBK99DJgduWpFp5I+o9jDpvaRx3tdbn2fZEwMMbl2u4RG3Qd
         XuKVvbwOmSKmW5WV6vePJTzCCc8Ao0eUVCR+HJk73964tzQU1R/7V6V+DIF1YRy5Jmg/
         96SMhBbfukZRZAOaymrqu6IeNp/LfqOGHhVmAC9i5cghQcad8g1D3x3dAkbTp6YSuOp3
         zdIuFjGQQyZFQQdSm3khuB0tciJWycCVxMJHQsoxs29SYCqCVt4d09Xbre0OZI3JqVQ2
         M/6kJTjVWxSuZPg/t3rE6apy0trkxqd2Q1x3vaygUqofYVESYCP4ZkwhK+OsB50rxSTa
         o3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J0beVQPQXy6f2RYjne5SWUE9ypNgckb1zCkLWuZ2CO8=;
        b=VyH5SoWguu3fQdUzHJX0gaGDItFJwEcPUPdD+puzEkMchhs1rt5Q1Z4vooQqGh94lL
         So9aYIoVm3ITMiFMKS2EWG6tjvqFyLAkkkPONlhslvMIgin+cu2ctFcJrl1e0Z8gUnry
         e0X6gZPGtyUA02Us8GSAfUp0pgzjd/k3l8gJE+akuO50pq4aBT+G7ZMDsVSiZeWlBgdr
         yBox/fR+3ZC+JHM3lu+zCThXJFSi90qcZKdpF7QPFXiDcGTm9ck08Rwc26uwr1vldwcp
         KI8p8jJDZjlFY1IIxlf5qY341F9DkJj/s8OcaLO8cH9UBuBXZccRr9Orwvjceu68mJeK
         j4AA==
X-Gm-Message-State: AOAM532tk/tUcssSZBzW0H+m5Q393zhQ9UjRdE1fRz/IK3V+Plr9R/hs
        JcYxDJZRpT6APVKZKGyZD7aqP6FyJBfZ/A==
X-Google-Smtp-Source: ABdhPJxiQEAqmkDjmgLyD2nzUbPb5L/G4DGa4C4Dupe1kJvNrW5JSPcUs5yUcjrD0WTH32BfASVh0g==
X-Received: by 2002:a4a:6558:: with SMTP id z24mr4320685oog.41.1626370077203;
        Thu, 15 Jul 2021 10:27:57 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:b51d:31f1:a0d6:7fc2? ([2600:1700:e72:80a0:b51d:31f1:a0d6:7fc2])
        by smtp.gmail.com with ESMTPSA id d3sm1362390oia.36.2021.07.15.10.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 10:27:56 -0700 (PDT)
Subject: Re: [PATCH] CodingGuidelines: recommend gender-neutral description
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
References: <xmqqmtqpzosf.fsf@gitster.g>
 <2c7f188a-6ebe-b116-8299-86ca3732d79a@gmail.com>
 <87czrl0wob.fsf@evledraar.gmail.com> <xmqqk0lrtuh4.fsf_-_@gitster.g>
 <CAPig+cT24=jy65C1cQ4WarakJHKm4F8_78nDm=jWOnHxfhtcRw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2bdd27b7-cbe1-6952-eca0-f6fcecdaec8c@gmail.com>
Date:   Thu, 15 Jul 2021 13:27:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cT24=jy65C1cQ4WarakJHKm4F8_78nDm=jWOnHxfhtcRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/15/2021 12:35 PM, Eric Sunshine wrote:
> On Thu, Jul 15, 2021 at 12:25 PM Junio C Hamano <gitster@pobox.com> wrote:
>> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
>> @@ -541,6 +541,49 @@ Writing Documentation:
>> +      A contributor asks their upstream to pull from them.
>> +
>> +    Note that this sounds ungrammatical and unnatural to those who
>> +    learned English as a second language in some parts of the world.
> 
> It also sounds ungrammatical and unnatural to this native English speaker.

A way to adapt this idea more generally would be to pull a phrase
from my commit message in v3:

  Note that this sounds ungrammatical and unnatural to readers
  who learned English in a way that dictated "they" as always plural.

Learning English as a second language is one example of how one could
find it ungrammatical. We could call it out explicitly:

  Note that this sounds ungrammatical and unnatural to readers
  who learned English in a way that dictated "they" as always plural,
  especially those who learned English as a second language.

Thanks,
-Stolee
