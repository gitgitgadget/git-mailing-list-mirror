Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D469C4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 11:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbiK2Ld2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 06:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbiK2LdI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 06:33:08 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96914666F
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 03:33:00 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o12so4550692pjo.4
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 03:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nS/HtHUnOFTi6az614AVk+pj/fiCcdFVM3ZSX6Lt/wE=;
        b=N3/5sU1b1VPCzRCdSv/0z+oeUtQqMBkbR+0dgHsbvcq8dzC8zNIO8reJaPnufzq/ql
         9YMKvXbJvw5HChvVnNEaOFflLt7zEZGJAqDqIfbZhMXD0FMJQsjFgQt7bqHmGmwmsxdo
         hM7OSfIFXHDBG2omxGsHC/SCsalhHiBGK434nMQt13CDR2h+3KnXpZksRPb2xJHFseei
         T6irbLrZAyvLaWp3HwkgakWMgCkngYMZh6l3QJ6XvKdyRVETT8EmqilDMIyITXY76PJ/
         JS1kpISO2vfMn212ghvpIElOUK0sDebEly/nlGTlOQ45IObdC+kaxpILpRRZRrzy74VQ
         NQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nS/HtHUnOFTi6az614AVk+pj/fiCcdFVM3ZSX6Lt/wE=;
        b=QVxz3cfuiL0CX8FlawITNt3Oz80hZeWea2mg8VwdFgFXvx5uuliylirsERdMYtMYcd
         M1euD+w1odSL9QxrHjT0ZbNPs3H32oLVaQijZgj3NzaeJbXzTCDuIX1pQxzlRD9HKDLI
         UZpuDWAnRtB+lt+wEpLljNg1Wi2eMc7UBDzSZeSMLzdJO/TNuGUGCpYGu7br8N+5D2ga
         JGgzq0Zy+6JVBlMA3Qw6XyEs2caA2J/0IfLnRJf9hijMQVZVQVOj0C599g5RHtyzzZ4a
         CSRd1HwpyfUet3U/RnYQX+W++RhwamDyGzrpB/CcDIhWRom1b2hu2j72q/KJeNtcoZg+
         8wQg==
X-Gm-Message-State: ANoB5pn3Sq4E24H+y+FDl+BIZZzDcXvoqDvHwfEuBMGd311EoNwUVCyd
        4Q9LRtfLnp93rBkmX7I0xQ+ffOQXXQR6yg==
X-Google-Smtp-Source: AA0mqf7bMPBECK3MT3NIvLEzzBt26DMzXb8zwZCJ5aoYkvX3p2oALP7BzlLcyVSMDdiudmTRojqjXQ==
X-Received: by 2002:a17:90a:b018:b0:214:247a:1932 with SMTP id x24-20020a17090ab01800b00214247a1932mr59646949pjq.187.1669721579928;
        Tue, 29 Nov 2022 03:32:59 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 199-20020a6216d0000000b0056d7cc80ea4sm9721738pfw.110.2022.11.29.03.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 03:32:58 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Ping Yin <pkufranky@gmail.com>,
        mailinggit list <git@vger.kernel.org>
Subject: Re: [bug] git diff --word-diff gives wrong result for utf-8 chinese
References: <CACSwcnQfTOYHxSJQqc+viiqkCqt=WZieuCw70PqOdvo88XdeOQ@mail.gmail.com>
        <221129.867czejabi.gmgdl@evledraar.gmail.com>
Date:   Tue, 29 Nov 2022 20:32:58 +0900
In-Reply-To: <221129.867czejabi.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 29 Nov 2022 11:52:38 +0100")
Message-ID: <xmqqlenu2dxx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> or (if chinese can not be displayed correctly)
>>
>> -  <E4><B8><BA>1
>> +  <E4><B8><BA>2
>>
>> Actual result of "git diff --color-words"
>>
>> <E4><B8>[-<BA>1-]{+<BA>2+}
>> ...
> I think we could provide new ways to do per-language diffs, right now
> you can use --word-diff-regex, but it would be handy to e.g. have a
> built-in collection of those (or other non-regex boundary algorithms)
> for Chinese etc.

I think you are thinking it with unnecessaarily complexity.  

The only thing that needs noticing in the above example, I think is,
that the three-byte sequence E4-B8-BA in the example is supposed to
be a single unicode character, and the actual result depicted can
happen only if we (incorrectly) chomp that single character in the
middle.

No matter what language we are using, we shouldn't do that.

I suspect that "--word-diff" internal is not even aware what a
character is, but if you assume UTF-8 (precomposed), then you should
be able to tell where the character boundary is by only looking at
the high-bit patterns to avoid producing such an output.
