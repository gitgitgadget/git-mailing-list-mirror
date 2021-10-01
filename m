Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801DAC433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61CF461361
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352899AbhJAJIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 05:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352895AbhJAJIp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 05:08:45 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4547CC061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 02:07:01 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id v10so32556039edj.10
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 02:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=soXOPKHwq9d4GpSGtJLEGEFaPaDgAiDrXZ2Www+Ayv0=;
        b=g4kMo+4/o5UqoKi727I7RoihIuEF5P26/gboNmSFIu+OVG7Db+Wec1luiCMunjglor
         sqzUikzc1gc9D1YAseDWyA/zsDdJJZyTTrpBnDeuEhJXnVhOR1NvQ/nMVBk5lHZkXTCd
         JxsmzF7ipqor/LUYTk6t78ZUKvOwP91LgQaa2FMcOCAdCDWu6YOQnWvbBJOSGG9yvSOc
         Dqg2zuAvsIrz6CWHCiPrfAxdC2koOdUc01C6yJCRtoGY1ZpO4mRYo4CzzQwP96Y4is6M
         n4ZUSDyiCZ1K4iszAnqhcz9+7P98GW4WJZjw/DUjMtifv8lUZohzi8QUSlqeRwCylvIz
         Xd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=soXOPKHwq9d4GpSGtJLEGEFaPaDgAiDrXZ2Www+Ayv0=;
        b=br2avRm5AzJ3ByxHhgTzSJp99NAbKp08alerXoeqirnlYuI0kvzQ/WtkpQlVnTLUPm
         tzwNe9FEDfPHlVhd4Fh0fBkWB3QZzz5+nYydckZByppmxtWOP/z/bSjOJ4HFknW2YPmd
         DeSg5gg/LFOwooXKxjtiKurrhThNpyP6DEUK2PrsZUz1+VPMwGiD8lRNpcMcZL5Rqsgx
         6DMirUSUhBXWWjMtRuWRJgCEEEr6dUWLTXYW5P0OIFHYT15FUrVK9wD0HBqc18fOZ/vU
         kk/O7Hn6IaliqqbVq2FMM0O7Vm70D0R1NFqG8Jl+dbLnq23wL8TqpwUCuULZtrWHZ5fr
         myjQ==
X-Gm-Message-State: AOAM533bOpOhl+972f+x/tuSOojRnl+xPQnCtjRS/IzsjtcYEiaDvSjj
        jIoYfZX/j059t5KuHDYNo4A=
X-Google-Smtp-Source: ABdhPJzgLMSm1noSoXH2RvlpMXQZE7v0xmPrLO9KaUjjAOTTt25MYS8nALMwL+WCIGXTr0zX+og6Dw==
X-Received: by 2002:a50:bf02:: with SMTP id f2mr13043296edk.226.1633079219674;
        Fri, 01 Oct 2021 02:06:59 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 6sm2688996ejx.82.2021.10.01.02.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 02:06:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v9 01/17] fsck tests: add test for fsck-ing an unknown type
Date:   Fri, 01 Oct 2021 11:05:35 +0200
References: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
 <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
 <patch-v9-01.17-520732612f7-20210930T133300Z-avarab@gmail.com>
 <78bab348-ba3a-7a27-e32e-6b75f91178db@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <78bab348-ba3a-7a27-e32e-6b75f91178db@gmail.com>
Message-ID: <87bl49ru4t.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 30 2021, Andrei Rybak wrote:

> On 30/09/2021 15:37, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Fix a blindspot in the fsck tests by checking what we do when we
>> encounter an unknown "garbage" type produced with hash-object's
>> --literally option.
>> This behavior needs to be improved, which'll be done in subsequent
>> patches, but for now let's test for the current behavior.
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>   t/t1450-fsck.sh | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
>> index 5071ac63a5b..969bfbbdd8f 100755
>> --- a/t/t1450-fsck.sh
>> +++ b/t/t1450-fsck.sh
>> @@ -865,4 +865,21 @@ test_expect_success 'detect corrupt index file in f=
sck' '
>>   	test_i18ngrep "bad index file" errors
>>   '
>>   +test_expect_success 'fsck hard errors on an invalid object type'
>> '
>> +	git init --bare garbage-type &&
>> +	(
>> +		cd garbage-type &&
>> +
>> +		empty=3D$(git hash-object --stdin -w -t blob </dev/null) &&
>> +		garbage=3D$(git hash-object --stdin -w -t garbage --literally </dev/n=
ull) &&
>
> Patch 01/17 introduces two unused variables: "garbage" and "empty".
> However, patch 16/17 introduces grep checks for "garbage_blob" and
> "empty_blob". Aside from that, 't/test-lib.sh' already defines
> $EMPTY_BLOB.

Will fix in the v10 re-roll.

I think this is from an earlier version where I used the $empty, FWIW
you do need it (or to write it) even with $EMPTY_BLOB since that's just
the OID, but doesn't give you the object. You can write the /dev/null
input and then use $EMPTY_BLOB, but I thought using the output of
hash-object was less confusing.

But in any case it isn't needed herea as you point out, we just need to
write the garbage object, we don't need either variable. Thanks!
