Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AC2C433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 20:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6040764E38
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 20:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbhBBUqu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 15:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbhBBUqD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 15:46:03 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DD2C06174A
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 12:45:22 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id y14so12971485ljn.8
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 12:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sview-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zg6cz2H9VuAyWLKlebcG9qjUibnKoulPSqWiDQtXF24=;
        b=VeuiEYPTcbfbSsLWbvuvryhRg1jGQNTIjaiEFKSn0SQWv2AqqRFj5kVuDCJvjMgbdW
         biVAgUKCT8hviVhR0lG5pShXvh7dFBYNBNYzFzy1VVPFO3ZHePIvLvL6wjxS1Uw5aX9+
         B4ZjrxQI1G/2k0TgKWLSbyG65hxXB+TYEzv3KqgJgipiSdUFWBhAJ2jFHpC+942rKr+T
         myON9GyvaFFby+Up/D6wIi5dcT7CaXk7NKJchvhKGD3GM5iMF4yU+4p9bG3gmF3c2zks
         7fJ8JCWppjc/5asjDhYjnAdnuBW8U4dMu9cQztiKT1SgdyLo3hsUzQPR+twZJMkl/bND
         0Zug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zg6cz2H9VuAyWLKlebcG9qjUibnKoulPSqWiDQtXF24=;
        b=MTTKxUzVv8d4oueZk90zde+UFqXXlS2PZwEhGPeQZZQHRlE3EMzmr8rzajRvTaejNd
         emdDh5b7iap3gQlnMWNV8kDgEa4eTG3P6geRjRxjfFU67T0GMvJYcNggEa97zjmZ3Gxi
         ujhHV4czQkaHHYb55YcipvlQDGb94OVorXKyqAWrIPDTOz10RjZKvzNdkclY6MReFTmQ
         TSbXdKYn9O1M51GxNw1qKv3OvNfB2+KlgI1HHuPVfPWcvLd47YjGEQsgTGs5bQK1cXXc
         3oATg6eecF8aJjcdJxeJdY7TGvLPlTdLSx8hm6PSec6wBIE3gHeCSNfEytsoq9dqhf1M
         n9FQ==
X-Gm-Message-State: AOAM531dJ6eHUPAGQtKLa4LqeZNOrrbMRjD+xomYiUH2M+2d5jq+rO8a
        HMVcjXKQVvhS2ozvlhD5D2hbNI8N5FB3R57Q
X-Google-Smtp-Source: ABdhPJw+BMyDFT2xwRBmLEHNOQGI7/VPaB5f8Nlx3suX1qiDA6cu1WkBfdf6H+cWHko3wfd7LHlX6g==
X-Received: by 2002:a2e:720d:: with SMTP id n13mr14841797ljc.220.1612298721118;
        Tue, 02 Feb 2021 12:45:21 -0800 (PST)
Received: from [10.73.4.226] (nnov.opencascade.com. [95.79.112.20])
        by smtp.gmail.com with ESMTPSA id v84sm2564lfa.178.2021.02.02.12.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 12:45:20 -0800 (PST)
Subject: Re: [PATCH] git-gui: fix blurry icon on macos taskbar
To:     Pratyush Yadav <me@yadavpratyush.com>,
        Kirill Gavrilov via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.941.git.git.1609937443534.gitgitgadget@gmail.com>
 <20210114182030.rnbvypttrknshclh@yadavpratyush.com>
From:   Kirill Gavrilov <kirill@sview.ru>
Message-ID: <154c779f-8d37-f4e7-c063-40fd05220b6a@sview.ru>
Date:   Tue, 2 Feb 2021 23:45:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210114182030.rnbvypttrknshclh@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Pratyush,

> Ping. Do you plan to re-roll this patch with only a single PNG?
I have prepared a patch that uses a single PNG image and also checked it 
on Linux.
And then I've realized that PNG loader has been added to Tcl 8.6, so 
that version checks will be required for compatibility with older Tcl.

At the same time, macOS is shipped with an old Tcl 8.5 and binary 
installer for git from "git-osx-installer" project used system Tcl...
And system Tcl has been broken with macOS Big Sur 11.1 update (it worked 
with macOS Big Sur 11.0) - that's why I've tested my patch with custom 
built Tcl 8.6.

Best regards,
Kirill

