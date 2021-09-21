Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051F2C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 23:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C74A36115A
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 23:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhIUXqB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 19:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhIUXqA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 19:46:00 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66245C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 16:44:31 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id v24so2832310eda.3
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 16:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=QzC+OFiuMCAxAmGiZdYeY5I6FhNJPRyuNZM4i7YDpDI=;
        b=SlW/2xeNiYEDUNybdAzTTCSfkdLflT59BXxZvoUjRGyiRrUI2rsSEKDPgtzQW4S+pP
         qjZf6lnPigrkbkCnr7JzdJwpFN37t0gc6hpChi+6n4COW5L/qZmy06HHLhVyT/VtNDGu
         7R99G/8SyxI94W9OOCJryostZCwd0MITNrFXLRVfU1+tYj4OttZIZjVBzfMqCLkFpDD5
         zlHBBlcF6PjPjyqbz8dpYg0l//ZngJNso/mNuIodK1K5O4ni/Mf0wsfjIsPU8LUHgs9u
         rMlSW613INsrO88d5+yrDF6kA3wNY8eQ1VEYft7nMnUMn3EIjwGrBW8Rn3ST1nj6Qt4N
         Rj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=QzC+OFiuMCAxAmGiZdYeY5I6FhNJPRyuNZM4i7YDpDI=;
        b=Vsu9HzEkeBc2Rpl4FotVHfFF20WS8Tjmd544vVt1e9xnrEomoVQXzuNLdTnv3wL0XY
         t2Z9mUd+1uy/jcwvV0yZ1ht0c9MALYytygD59F3lWSEuO++y5ytspmrKRdoghaRbpv5Y
         XOSLUmfykS4e2/bpl3H3NEy3EW/9XGaE1C3qfYs1dhgvTvzaxc9i71+hx0Na7C4mthK/
         Z8IZvdXItjF/oTr2yzUqb8YPPr/jd5yzuPoWoOUgER67/xyh9ZAGDrefkH46PVhJhcpV
         Wr5ngP9Z6HWNKpTj/GRXebljBHDO4H/ruOurl9lzbu+eZMwZ6J4sRUmK+yeGT1On2pyu
         sHtw==
X-Gm-Message-State: AOAM531KLFHm5JVsaztyOX9hNPRrCn/l5/Kr7e1HJTCfnp6gaEVBYta9
        ITOTh3PIVavN/V28sShl8LKO9Dvn2f9tpQ==
X-Google-Smtp-Source: ABdhPJwUby9eOje0RXNzSKrcOCxztsUabzHAJqfjK7fOCXcBhoIJMBmixq/C4CQKVhZnsxI3fbhgDA==
X-Received: by 2002:a17:906:781:: with SMTP id l1mr38421522ejc.289.1632267869712;
        Tue, 21 Sep 2021 16:44:29 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bm26sm168382ejb.16.2021.09.21.16.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 16:44:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH v4 3/6] core.fsyncobjectfiles: add windows support for
 batch mode
Date:   Wed, 22 Sep 2021 01:42:52 +0200
References: <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
 <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com>
 <a5b3e21b76208fba130e3313a3e70df45ab392af.1632176111.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <a5b3e21b76208fba130e3313a3e70df45ab392af.1632176111.git.gitgitgadget@gmail.com>
Message-ID: <87ilyt8per.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 20 2021, Neeraj Singh via GitGitGadget wrote:

> +int win32_fsync_no_flush(int fd)
> +{
> +       IO_STATUS_BLOCK io_status;
> +
> +#define FLUSH_FLAGS_FILE_DATA_ONLY 1
> +
> +       DECLARE_PROC_ADDR(ntdll.dll, NTSTATUS, NtFlushBuffersFileEx,
> +			 HANDLE FileHandle, ULONG Flags, PVOID Parameters, ULONG ParameterSize,
> +			 PIO_STATUS_BLOCK IoStatusBlock);
> +
> +       if (!INIT_PROC_ADDR(NtFlushBuffersFileEx)) {
> +		errno = ENOSYS;
> +		return -1;
> +       }
> +
> +       /* See https://docs.microsoft.com/en-us/windows-hardware/drivers/ddi/ntifs/nf-ntifs-ntflushbuffersfileex */
> +       memset(&io_status, 0, sizeof(io_status));

See just an informative link to the API docs, or is the comemnt on the
memset() in particular. This comment seems like it's just doing a
Google/Bing search for you, so maybe better without it?
