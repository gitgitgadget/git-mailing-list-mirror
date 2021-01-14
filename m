Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4048FC433DB
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 12:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E97D423A55
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 12:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbhANMH5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 07:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbhANMH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 07:07:56 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83159C061575
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 04:07:10 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id e15so3270251qte.9
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 04:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E94k1gdXyIk8qt1PWolSZnCxt2t4rPuBbJHznct+2CI=;
        b=dW/frZzB3W+Kq+lZ2O4Im7lCDlXVA8j5dqBKNsHSU6vCQo+CKqPM2D6k3VtNCJD5Nt
         G6y8ghP/tDRCzrXAPgqTZcy5N28+o6OIrCdfooUKgugrcDjNu3A+b9UZymfUB1Z3+Nur
         Z3WZanP2GBhHBq9APY214GGRpMMHofR6MaOtCtN4DFWm0r9FflDiQN1lUMt04hDBcmH0
         ypwdO4kO31tKfp4V/7/pMafVMzgvi/e67O8Z3RBwiIAs+AP08WTmybJ8FQRJiQMYVXBl
         4bmd4xTcLnb6DYrXZDX00CdayCBVyUNTAsHNtQLN528YuazoxPD8IOb2De7O1MkgLYmF
         /YDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E94k1gdXyIk8qt1PWolSZnCxt2t4rPuBbJHznct+2CI=;
        b=iTx7pDPIw0V7neF6ktp63Ho8epWbagqdo8kuhqAdchqXcoqBo+6Oz/u5uPwCs7eJze
         QtUYRkoJwU7pkglHNW0Tw/h0hi6c1C/YOz6UXJjWx7uiQv6CRk7EkiUhNHKLwOt+JYYb
         DvjLLp2vTZdZft+EjW4p3PQSrZBmbC9nyQvqFFCVnUtelm1Hj7PTMtBKvZEwJzOkw8sw
         hAI5AqlFOWza/pZHl2uC88RrxTR7qFvKOSUXZSTUry1nS8Z/YASK1i00p1KJy7iVBRYx
         R3WUSzr96QIVkgJukrrq0ciNZ/DGVgxfA/3YmeatU23SaERmKPgDTn+On7mKQKtxpOMJ
         srLw==
X-Gm-Message-State: AOAM532nkEAfuOQ/xcONIk65FR1IJwSLeMS6WL/zpJexRKECEQaW1Phb
        996S+FfI/Qr94C1FP5uzmUw=
X-Google-Smtp-Source: ABdhPJxVpgxlwR9WpSKVmVwoez/UhcvsnHbGAKUAB9vcoSqai5J2h/4GnxJ1dsK8CXLMlFOwuyyfDQ==
X-Received: by 2002:aed:2ac1:: with SMTP id t59mr6663420qtd.165.1610626029688;
        Thu, 14 Jan 2021 04:07:09 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:81b0:4431:6d9:fc9e? ([2600:1700:e72:80a0:81b0:4431:6d9:fc9e])
        by smtp.gmail.com with UTF8SMTPSA id w127sm2739947qkb.133.2021.01.14.04.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 04:07:09 -0800 (PST)
Subject: Re: [PATCH v2 1/8] packfile: prepare for the existence of '*.rev'
 files
To:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, jrnieder@gmail.com,
        peff@peff.net
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1610576805.git.me@ttaylorr.com>
 <6742c15c84bafbcc1c06e2633de51dcda63e3314.1610576805.git.me@ttaylorr.com>
 <xmqqwnwgx9rm.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <10326ece-f433-4793-336e-a30786bf1f2f@gmail.com>
Date:   Thu, 14 Jan 2021 07:07:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <xmqqwnwgx9rm.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/14/2021 2:22 AM, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> 
>> +== pack-*.rev files have the format:
>> +
>> +  - A 4-byte magic number '0x52494458' ('RIDX').
>> +
>> +  - A 4-byte version identifier (= 1)
>> +
>> +  - A 4-byte hash function identifier (= 1 for SHA-1, 2 for SHA-256)
> 
> These two are presumably 4-byte-wide network byte order integers.
> We should spell it out.

In the past, we've included the sentence "All multi-byte numbers are
in network byte order." to clarify this. These two entries need to
specify that the "identifier" is actually an integer. Perhaps these
three values could be provided as:

+== pack-*.rev files have the format:
+
+  - A 4-byte identifier '0x52494458' ('RIDX').
+
+  - A 4-byte integer version (= 1)
+
+  - A 4-byte integer hash function version (= 1 for SHA-1, 2 for SHA-256)

>>  /*
>>   * load_pack_revindex populates the revindex's internal data-structures for the
>>   * given pack, returning zero on success and a negative value otherwise.
>> + *
>> + * If a '.rev' file is present, it is checked for consistency, mmap'd, and
>> + * pointers are assigned into it (instead of using the in-memory variant).
> 
> Hmph, I missed where it got checked for consistency, though.  If the
> file is corrupt and has say duplicated entries, we'd happily grab
> the data via get_be32(), for example.

Even if the consistency check is just verifying the trailing hash, that
seems like something that requires O(N) before performing a lookup. Perhaps
this was copied from somewhere else, or means something different?

Thanks,
-Stolee

