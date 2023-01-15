Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D0CC677F1
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 02:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjAOCGi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 21:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjAOCGf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 21:06:35 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0104059E4
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 18:06:34 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id c6so27082911pls.4
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 18:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ASXR3/UI5vcf0ZQvydgNG/KK16jJBfPsd487HJESXpA=;
        b=HBpBiAdRoliOZSASy9vw1QD+1uMUXbUVBoW4OeOuAlDSvddf2KZgSohbtQ83jDX7If
         xVgEqSCzDLgl7/nolqEtMIeC3Q2eLSz2La5fCcasmfGNwmyATgH1MWmLu8rlO67TQRZz
         0wcjpz9mMjT10YYdUpREnD85NS1SQaIkukchMPn/ndupu9HjBsY5cLATOcOfysl9pfw3
         cDzvFkdPIJGAnFMABybDWp2ptCkKkrRhcRqkI93audYZYZqkXskhI9W17cHRoFafGEVt
         zcv+O12XSQuRZhYRN+Gh814K2dfLL9gFjJnr19os/Ko9qSO/vgH4Fe3O1miQo3CbZFCI
         EgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ASXR3/UI5vcf0ZQvydgNG/KK16jJBfPsd487HJESXpA=;
        b=3XQ9QvtZOkZ+zxPeHCrrtZQXbrsJgSXBH8OiEJDExLagPMK65sfnozs1v/0O4subgG
         2qcCdfEcG0r1RoNWIW0EGT0K02jwr27g6e1Q6wgzCwgEoHR884VB9s1nWMhN474n5vWe
         NhMwZmIipWd1y9lrEIBuDMyTUvkWuf+L8Te82c2eNggLcIBQf4GpHQlNZQsBsi4qJBid
         G92g6aqRr1/p7oPedXC+6Q3PPKCeI8NbHaCnmdQfSAKovMNYLTi2djq9xJ9Z9RTJQ7ti
         4c8GFQqNibxCsTUhbw5G1cwZkSNXwyZkGyRgTIxPw2cNqtSGVR51Kh3Q5xmb3ThF/M8W
         uHnQ==
X-Gm-Message-State: AFqh2kpzsLkVmdl7HV9Qsppn67WijSfSGUlPKwRwlM5kva57abJ1eWHZ
        8DsaiYnHFUBGqvGWP+Rwmoc=
X-Google-Smtp-Source: AMrXdXs26GPsBfB+9PepZ1TJtj7UXacKSyU5+/oSdQubQzhRL61BvT1Bkdm5p6AWFr+ixN6fgY6/dQ==
X-Received: by 2002:a17:90b:8d7:b0:229:22c9:7418 with SMTP id ds23-20020a17090b08d700b0022922c97418mr8280610pjb.14.1673748393249;
        Sat, 14 Jan 2023 18:06:33 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id ha18-20020a17090af3d200b00219eefe47c7sm14427866pjb.47.2023.01.14.18.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 18:06:32 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] env-helper: move this built-in to to "test-tool
 env-helper"
References: <Y71qiCs+oAS2OegH@coredump.intra.peff.net>
        <patch-1.1-e662c570f1d-20230112T155226Z-avarab@gmail.com>
        <744c8abe-6065-872d-8c9f-a1b1ab682d52@gmail.com>
Date:   Sat, 14 Jan 2023 18:06:31 -0800
In-Reply-To: <744c8abe-6065-872d-8c9f-a1b1ab682d52@gmail.com> (Andrei Rybak's
        message of "Sat, 14 Jan 2023 18:43:45 +0100")
Message-ID: <xmqq358clffc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

>> --- a/Makefile
>> +++ b/Makefile
>> @@ -799,6 +799,7 @@ TEST_BUILTINS_OBJS += test-dump-fsmonitor.o
>>   TEST_BUILTINS_OBJS += test-dump-split-index.o
>>   TEST_BUILTINS_OBJS += test-dump-untracked-cache.o
>>   TEST_BUILTINS_OBJS += test-example-decorate.o
>> +TEST_BUILTINS_OBJS += test-env-helper.o
>
> The .o files are sorted alphabetically in TEST_BUILTINS_OBJS, so
> test-env-helper.o should be above test-example-decorate.o

I'll locally tweak to correct this, to prevent this patch from
making it worse, but the ordering of other entries are already
broken at other places (e.g. around test-rot13-filter.o).  Somebody
may want to send in a clean-up patch, or alternatively we may not
care too deeply and doing nothing about it ;-).

Thanks.
