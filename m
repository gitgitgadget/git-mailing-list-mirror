Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EDFC433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 13:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 134BC207B7
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 13:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhA0NuL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 08:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbhA0Nt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 08:49:58 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBB9C0613D6
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 05:49:18 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id l27so1678086qki.9
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 05:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4HbG/e9bXb3gaKgOIZ9wfxzQ+R8+GGyFunVkltN5HI8=;
        b=Af9htSLy1e9949ER7yA326Zb75PJPYnU3CZy5FiZ1c58ARVdFDY2gzAvBz4XVB9Aqd
         OqnhgjpMrYRZcOF4uzZ4UAXc1TZqEbKUBt1czoHJgbLy5gjgSafFVs29STnA8YQ+8vkr
         ge+anJXwd8gxaSt61370D4KUuqTa04Yz3zr3F0y5WVdZiJKHJBeW+sYlFIF4Nj6KLoVC
         xUabjgHhP7my0M4XETAPeDskxh8IeOqGBKasm6N7ULpJUfme3HSkulmMJmX9hkhcJhzC
         LFASRW1Df/YeHBtxiCkO2PbJ8tDwqBhHNM2qeEGtptQfbFIij6qooMnp+fMJxFoLO6Yg
         POKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4HbG/e9bXb3gaKgOIZ9wfxzQ+R8+GGyFunVkltN5HI8=;
        b=t+x2VMoMj+zcLRmeJpHqdkb9blOTx2d+5NiorNxC+8Cp7YR5+YhU3lDv97PoydGUAC
         T6JWxlG58p9RRuE4bt3j5bNZ67SVGq0IAKZvOU18PJB7w2/hLvMpU1aw9lmyYWktk5Fx
         2my2qK/lBPzMWyn60BIRGeEnWNT1o0Yr67TW8+ev/UiFs+Prxdqw5ET+6jfP6V0FfBHk
         J9rnzomb9zyeq5YsfNLZjP2mf9qQRG0rIYnBqP4YxIkmUJ7Pr6Hdxe42MFAIrQjLtUr6
         l14z2/ec1aqcr+hK6VJ82EkDZ+eW+VboFoV1M1PLo38gf6oPpR3EWjJuvFqCAM2H5jKV
         Mlig==
X-Gm-Message-State: AOAM531w8a8xYMWBKIHgkBw8wr5IJamocrhnaqq746+7Yv4N9cm2odh0
        CjaQSQpwJf+QhREchYwYjlI=
X-Google-Smtp-Source: ABdhPJzq234OGx8dGzrUrkp1YEfgInMdvZt8EQ/b5dY1vtK07Nsk5yjq2z/4lklD1F1L5HO1C9ymMg==
X-Received: by 2002:a37:83c2:: with SMTP id f185mr10081006qkd.206.1611755357871;
        Wed, 27 Jan 2021 05:49:17 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:2d7b:5e80:11e5:d0fa? ([2600:1700:e72:80a0:2d7b:5e80:11e5:d0fa])
        by smtp.gmail.com with UTF8SMTPSA id j7sm1202112qtb.87.2021.01.27.05.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 05:49:17 -0800 (PST)
Subject: Re: [PATCH 02/17] chunk-format: create chunk format write API
To:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, l.s.r@web.de,
        szeder.dev@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
 <9bd273f8c94fdb0c3adf8aedef3480ff5f4232b8.1611676886.git.gitgitgadget@gmail.com>
 <YBDTKqiCEkWmxEFr@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c1cd1184-a254-7e39-5432-ecaf6e20ff90@gmail.com>
Date:   Wed, 27 Jan 2021 08:49:16 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <YBDTKqiCEkWmxEFr@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/26/2021 9:42 PM, Taylor Blau wrote:
> On Tue, Jan 26, 2021 at 04:01:11PM +0000, Derrick Stolee via GitGitGadget wrote:
>> +/*
>> + * When writing a chunk-based file format, collect the chunks in
>> + * an array of chunk_info structs. The size stores the _expected_
>> + * amount of data that will be written by write_fn.
>> + */
>> +struct chunk_info {
>> +	uint32_t id;
>> +	uint64_t size;
> 
> Hmm. Would we not want an off_t to indicate the size here?
> 
> I wondered briefly if we even needed a size field at all, since calling
> write_fn would tell us the number of bytes written. But I suppose you
> want to know ahead of time so that you can write the file in one pass
> (beginning with the table of contents, which certainly needs to know the
> size).

Is off_t 64-bits on a 32-bit machine? This is intentionally typed
to be "64 bits no matter what" because it correlates with the file
format's size for the chunk offsets.

>> +		if (cf->f->total + cf->f->offset != start_offset + cf->chunks[i].size)
> 
> I don't think this is a practical concern, but a malicious caller could
> overflow this by passing a bogus "size" parameter. Maybe:
> 
>     uint64_t end_offset = ...;
> 
>     if (end_offset - start_offset != cf->chunks[i].size)
>       BUG(...)

Sure.

Thanks,
-Stolee
