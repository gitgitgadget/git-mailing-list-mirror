Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2100320248
	for <e@80x24.org>; Mon,  8 Apr 2019 05:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfDHFvX (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 01:51:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35819 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfDHFvX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 01:51:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id y197so13249265wmd.0
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 22:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8Nd15DhYUNGwfOdYKD0sdyh57lnkmVlo+wp2xcC50WY=;
        b=PW6HoHL8uD3rPZ1zaJHhT94NEcHecqVeqFhVCZ5VWjwLdDDglLNluTxtjELv14Ib8d
         YgJZ1YLNghLHgsz6y1pVg+BhAcuLUB0XrIHTFLo4/Gr4Hou4YiNUbVvucCwffOnZ04yQ
         yBRiz6HRHIy14Apm9W2zoJzQ1X6obCshL/1LbsZgM/fP+NM+cgN3WD5md1HCfe++ClmZ
         ipfu7QXFUFCp73ea8Bm9+dfK3Z4bmnNLIHaYDbZxx0qzQbtDMHNlCj1DNrxuA6ZTqEQQ
         7EC6SVeb9TftS0CR2CbKeSm0R59zgZL2C1+trj3OFn814IXUj2XXogcxdlghZH9g+oUn
         4QoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8Nd15DhYUNGwfOdYKD0sdyh57lnkmVlo+wp2xcC50WY=;
        b=SXQ0lOpvDzwM1+xXHm6hvsdPw44XLF0rHGNLrQcegzn+6w0FPEFVlcooXZ41HMfrr7
         8mVwAIRW1Zkr649tkSLV7Zd6CatZR0a3KSsrsWsx9fWl9DYnBiC/XHgnVo28SQ/W97hf
         c9jEB8kSkG6ZNF380P9b2GFo24LLzgizQONZef1hZS/9aYGUYmq7BuljZEaNpkrlBZdN
         2ihASDRyVQhuuKfJUxSRAcCVeIdMSiYYQHyrg1rRyCPJvLXErcexxNxbYzyRUX69R34x
         bwck/GZuUJPRW1HRRbHNyA+vfEVoVtABNW4YK4RR85Hq4+csM1Fq9TqETxbe/B30Nz2m
         YvPQ==
X-Gm-Message-State: APjAAAV7CudtspGB/Ru3XJdgS3apOlMVZDiGKoqAQg7GLQ560ceUFRCX
        0Tb5AYPnLKHh411XbAdY/zs=
X-Google-Smtp-Source: APXvYqwp2ODQFKtnlLzBSl5mVW5s9cwHVtsTKuBGdDG080AvUNm7gogUj4mM05zoVxO2bCmBCXbjHA==
X-Received: by 2002:a7b:c3c9:: with SMTP id t9mr15531666wmj.131.1554702681794;
        Sun, 07 Apr 2019 22:51:21 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id w130sm13627647wma.36.2019.04.07.22.51.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 22:51:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] diff: batch fetching of missing blobs
References: <20190326220906.111879-1-jonathantanmy@google.com>
        <cover.1553895166.git.jonathantanmy@google.com>
        <44de02e584f449481e6fb00cf35d74adf0192e9d.1553895166.git.jonathantanmy@google.com>
        <20190404024710.GO32732@szeder.dev>
        <nycvar.QRO.7.76.6.1904051528130.41@tvgsbejvaqbjf.bet>
        <CAP8UFD1qK61MtJ-XeMuwY4W2V0CdHeZQC9rQap1M+nEeaLmBJQ@mail.gmail.com>
        <xmqqy34lb4vb.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 08 Apr 2019 14:51:20 +0900
In-Reply-To: <xmqqy34lb4vb.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 08 Apr 2019 11:36:08 +0900")
Message-ID: <xmqqmul19h9j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Christian Couder <christian.couder@gmail.com> writes:
>
>> Thanks for investigating! Yeah, that's part of the problem.
>>
>> The fix I would suggest is:
>>
>> diff --git a/diff.c b/diff.c
>> index f685ab10b5..a2b1241f83 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -26,6 +26,7 @@
>>  #include "parse-options.h"
>>  #include "help.h"
>>  #include "fetch-object.h"
>> +#include "promisor-remote.h"
>
> Thanks.

Together with "if we are forbidding the direct access to the
repository_format_partial_clone variable and the fetch_objects()
funciton, make it clear that is what is being done in the
multi-promisor topic", I think a patch that adds this header should
also remove inclusion of "fetch-object.h".

