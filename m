Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657D7C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 23:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3880320787
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 23:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i57W+oac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733283AbgDAXdX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 19:33:23 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42124 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732503AbgDAXdX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 19:33:23 -0400
Received: by mail-oi1-f195.google.com with SMTP id e4so1164320oig.9
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 16:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WyEqg2p9Q4CKJi1lx9TMdncQlkC0dB46rfVPkrcUaCk=;
        b=i57W+oac9srdX2nqzl5FcyxXUQ7V0WgwGgQM2nL1RdRRO02kSHMWRfOZFN5GhZ9iyW
         3TvSUztrAPGI6CSPnoxflgQ4LEwOmFOf1Uxt302Go2faFhroFqQWLZ7chr4iAl3mzPcY
         zY/lTFzAcRmVuWD0MA6yzMZJvEWiATmAkIoYqRIEcjvQS1mxGdg/D452HKy6P+rbq5uK
         QrDyy4SbRXMwUpUJLOw6TzmiWh44bVGhLRMjNC8DR9+ol/JCRSWlngxpm22eXtgyGUV9
         lHc0XJPndo9/boEtoSZzeWr3NHFMlOlBFsqarw2FiqbTguh8xzxnBo5sV02s871YERKj
         WcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WyEqg2p9Q4CKJi1lx9TMdncQlkC0dB46rfVPkrcUaCk=;
        b=p6YsQgPd3Gk4/BPx0I+e/JwukKNWecE8XmCZWqw8RLB73HdW5nztBXKKrEWZcgpLQS
         jo+x8Asz3AGhJzl/CdFxkR+18GIrqKmJtSx+Qw7zbXdzK0cV7TtIGyPDOgmZlgRsSUyc
         jktu5uB5phYHIyTpLhvzn4DfGXkbancjXq3T+wRcTrPfhkcrPV8uKKST2I7APIGQFL0q
         cb4+3D+ZBaXHdozuOXs5fj6InW6e2wo/N2/IQRdgqYu+OX90HvKK7NDTVJuWc4ol8Ict
         IjojA4FW1/CJA6FsEZBcy0dQdP5FXwKie8Uj2olxqiq0IHEpCejFrptVPvDCU3OzI5on
         V+MQ==
X-Gm-Message-State: AGi0PubBhLQ+CmP+0ZhkcnoaJKzGHPWpIVXxr5MS9xW6hPlRu0kgz2yn
        BJ/RgZI5b35Gn9PUu6S3QBc=
X-Google-Smtp-Source: APiQypLncLK7lq/wKtsZgWlcGdDRHD7h/fyFyC75r7Ua5mEHQ6kreFxhMqY97iPjDen9PCWruBbDyA==
X-Received: by 2002:aca:210c:: with SMTP id 12mr334611oiz.0.1585784002115;
        Wed, 01 Apr 2020 16:33:22 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id v15sm826708ook.37.2020.04.01.16.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 16:33:21 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] commit-graph: fix buggy --expire-time option
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>,
        Kevin.Willford@microsoft.com
References: <pull.596.git.1585764695643.gitgitgadget@gmail.com>
 <pull.596.v2.git.1585774844.gitgitgadget@gmail.com>
 <xmqqbloa6hmw.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <acf4b640-f66c-beed-adb9-30bc912d8723@gmail.com>
Date:   Wed, 1 Apr 2020 19:33:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <xmqqbloa6hmw.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/2020 5:05 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>  * Added a file that should be kept on the other side of the expire time to
>>    protect against off-by-one errors and future date errors.
> 
> Thanks for being extra careful.  It is always a pleasure to read
> patches from you ;-)

I appreciate that! Credit for this suggestion goes to Kevin Willford.

-Stolee

