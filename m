Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C4CC433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 10:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ED9D2246B
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 10:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgLWKDu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 05:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgLWKDu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 05:03:50 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F713C0613D3
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 02:03:09 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id h16so15663263edt.7
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 02:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=lc2gUTYX2sMemjP3GR8ONGDSSe6pWFySzXVfdVsVCME=;
        b=A1hPNMKn7PH9RMd31Bj2Ifrf/vQCljYUzb504T5pWVWkSVUCaL4CkYsRwKCPUp+0Dr
         X86Jrpmf08RuKq/piw5Zk7Qabcf+xpaSJrpn+AN5dIV38PdOcJ3e72Qbr4F5/+vYXtCC
         2xFAGrCoFcmTqfM8ZAvVXPljjRLFFjVeYB1lakIT06KMdkppEH2woQb12N+jdE4k7lth
         J0EdrLwSfaPNsaFbvRB/NeRSFoEAyb2m5vLD3N34nveJaUShyC6yndLif2CyCiENPsym
         4UU9JhqVBRBNESc5wWDqOS2DAiVT3IZrwB1v7devi/OeoSBLFpXphhbhXsBh7mRKBQ0q
         Fndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=lc2gUTYX2sMemjP3GR8ONGDSSe6pWFySzXVfdVsVCME=;
        b=QUZ9VD+0p/xn+CYeJihvsLZEibKQap6V8cDV5kmxr4bkAUhV7ryXNYMXKAKrFcbTXc
         eOdn+pmqgQDYOnluEm44lcyY0tfr4k0tjJyXweRXQCWDFD4xwaSKlnbI/m49q3rJJuTX
         OXlJAXcaRrb/VGm2ZASNRo6CEi0exH4OUy4Yom47cV3/kRAMUgCRf1rDOGxJag3wsrwv
         5cH2CKe7WmeuVkLDf49+UZDLfwn+wU1N01BsUf1R9IVWp8Kf4sL288zpj1rkppmLtAAo
         9QXHwb3lP+g98Qghukh0H0nFYG5dapEirM674V2jcIC5FG9b+2qjWMFbD4Oyhz0u7hfs
         a4OQ==
X-Gm-Message-State: AOAM533egghxFSQqq+il5DYm9lFCd1elM3zdNQpaaR8L1VGf7ihe/AFU
        Po5rucEBW49WoP1v9LoZIzQ=
X-Google-Smtp-Source: ABdhPJwb1wvA8SmYpeAqAuF7WZRkhtJ7dxuo2Xx0hlI21Xm9zRoTbdctiXaR2VNPyhvs1OH4AhnvwQ==
X-Received: by 2002:aa7:db59:: with SMTP id n25mr23166421edt.203.1608717786939;
        Wed, 23 Dec 2020 02:03:06 -0800 (PST)
Received: from cpm12071.fritz.box ([79.140.114.102])
        by smtp.gmail.com with ESMTPSA id f17sm30412246edv.5.2020.12.23.02.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 02:03:06 -0800 (PST)
References: <20201221162743.96056-1-mirucam@gmail.com>
 <20201221162743.96056-3-mirucam@gmail.com>
 <gohp6klfdpbca4.fsf@cpm12071.fritz.box>
 <xmqq4kkdfgln.fsf@gitster.c.googlers.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Miriam Rubio <mirucam@gmail.com>, git@vger.kernel.org,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v2 2/7] bisect--helper: reimplement `bisect_replay`
 shell function in C
In-reply-to: <xmqq4kkdfgln.fsf@gitster.c.googlers.com>
Message-ID: <gohp6k35zw6drc.fsf@cpm12071.fritz.box>
Date:   Wed, 23 Dec 2020 11:03:04 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano writes:

> Rafael Silva <rafaeloliveira.cs@gmail.com> writes:
>
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> index b887413d8d..fb15587af8 100644
>> --- a/builtin/bisect--helper.c
>> +++ b/builtin/bisect--helper.c
>> @@ -988,11 +988,8 @@ static int process_replay_file(FILE *fp, struct bisect_terms *terms)
>>         struct strbuf word = STRBUF_INIT;
>>         int res = 0;
>>
>> -       while (strbuf_getline(&line, fp) != EOF) {
>> +       while (!res && strbuf_getline(&line, fp) != EOF)
>>                 res = process_line(terms, &line, &word);
>> -               if (res)
>> -                       break;
>> -       }
>
> I do not mind shorter and crisper code, but I somehow find that the
> original more cleanly expresses the intent.
>
> "We'll grab input lines one by one until the input runs out" and "we
> stop when we see a line that process_line() likes" are conditions
> that the loop may stop at two logically distinct levels.  You can
> conflate them into a single boolean, making it "unless we found a
> line the process_line() liked in the previous round, grab the next
> line but stop when we ran out the input", and it may make the result
> shorter, but it may be easier to follow by normal readers if we kept
> them separate, like the original does.

That's a good point (and nice explanation, by the way). Before I was
thinking more on the line "while we do not found a good line from
process_line() and we do not finish processing the file, let's go to
the next line" which lead me to proposed changes for shorten the code.

However, after your explanation, I can see now and agree the original
does seems easier to follow and we can as it is.

-- 
Thanks
Rafael
