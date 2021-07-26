Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC398C432BE
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 14:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACDE26069E
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 14:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbhGZN4O (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 09:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbhGZN4N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 09:56:13 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF29C061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 07:36:41 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id u10so11107671oiw.4
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 07:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xU64xRLDjN4b7uz5wjaNNw7knIcxchzdrfcf7xb/8S4=;
        b=ZQ0ircvUPRgQ7XQpGZHQWcFSWOgPf36lrPD2whNlZjEgYXzHWn55Bg42FqisL2VvrF
         MgHTPvmLaGMGvbhpDc8sCPah7iuhb+jyUoaV1uQli7//LYAjkEkBM/BwLXLmhguH4GyV
         6ppTV0N8Ys3nEla1NSCq+9ZWb3XyFNHh7fr3l8KG9O4Q0epSjIGFrvTFGmV1Q1VZRugw
         FbHrbiypfMIt8TQInxsaZ0KF/m7uM1TRof/ogXCJKvD+R8nGMCyBN0afdepEprqM19UV
         7N0b+5UtI2yZctqt9O5P+xnJ2kQX/srNeEzMzbQz5/wJngeJ7brnzwt7B78Mwr629E5w
         aMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xU64xRLDjN4b7uz5wjaNNw7knIcxchzdrfcf7xb/8S4=;
        b=Rk5FyCmy+S8PYm3JLZ8qhjfO7wbbOBnupcrTNhq8plm1mSGIsT7tNUcqThX+F6c0WD
         3nUlxAvQWaj2XcyoqMaQWcwaRo9HNhXiUi9lujX5Th1daDvOrPRk6G6qDH2L3NmQiHfj
         OMXJJOsL+AaiQalaXt4sime13/CGdUj4sygQRz//+/STSeWv5Vd/S2G04C6vh0gcc0je
         MZjlu2nb4bXB6de3Y5wz/9CFuAYy1HA6YwR/yKiOKxUImXKa9XiVLilM98g3AeJs3tTm
         QdS4yYDWabm2ylVd4sd9Gen0m/n+4wTOoxpW+5LD+Q+qmHxzmktqjNN+sSnUN3C+NTvO
         or9Q==
X-Gm-Message-State: AOAM531x3jHE1N7ouancNIPpRRAxxOuMGxa5LzsXvbLjVnqrv6IGPzyP
        frkSZRFMDMmtLsXss6JLYxc=
X-Google-Smtp-Source: ABdhPJxdhWA6ioXChmSTvvnKKTs/x0mMRfNppYHK+Z3PXpc0O6dHnTGEyqkGK9z5jxmchLaQUJOEww==
X-Received: by 2002:a05:6808:1523:: with SMTP id u35mr11360565oiw.132.1627310200844;
        Mon, 26 Jul 2021 07:36:40 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:8509:d58a:ff00:9b31? ([2600:1700:e72:80a0:8509:d58a:ff00:9b31])
        by smtp.gmail.com with ESMTPSA id c64sm5015oif.30.2021.07.26.07.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 07:36:40 -0700 (PDT)
Subject: Re: [PATCH 3/7] merge-ort: add pool_alloc, pool_calloc, and
 pool_strndup wrappers
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
References: <pull.990.git.1627044897.gitgitgadget@gmail.com>
 <e30b8c8fea110b2475d00a4b37eb62a4883999c4.1627044897.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bc24ea9c-178c-bcc9-2097-2271df93ae76@gmail.com>
Date:   Mon, 26 Jul 2021 10:36:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <e30b8c8fea110b2475d00a4b37eb62a4883999c4.1627044897.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/23/2021 8:54 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> We need functions which will either call
>     xmalloc, xcalloc, xstrndup
> or
>     mem_pool_alloc, mem_pool_calloc, mem_pool_strndup
> depending on whether we have a non-NULL memory pool.  Add these
> functions; the next commit will make use of these.

I briefly considered that this should just be the way the
mem_pool_* methods work. It does rely on the caller knowing
to free() the allocated memory when their pool is NULL, so
perhaps such a universal change might be too much. What do
you think?

Thanks,
-Stolee
