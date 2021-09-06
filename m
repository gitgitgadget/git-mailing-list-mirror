Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26121C433EF
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 06:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 093D260F12
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 06:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239462AbhIFGUL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 02:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239458AbhIFGUK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 02:20:10 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7080FC06175F
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 23:19:06 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id x19so4835418pfu.4
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 23:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6n6aLk4S95PP2cHBUtjde/ElDFKHT7PQCv/XwW7mTl4=;
        b=SBEdeJjFA9E8C0yXDxSACCubz/+/GP/55xhZQSJf4OlEg7Pv+yBbbGZkZmm4t5HKG9
         HT26cEY/gREOEY6okawOXBZFf1LDGmwNiFSJL5mDB3yKyam1eb3ytEu0WqLY4ExPJoaf
         5jLV9Kjvl7dnmZKg8PtUzvvOPFMWKQM+oxJJXmr4v1Pb0WhA0rd36hJQ06edWpuLqLgp
         1a2FyWzDU0O/zxeSdyFsLQYaDxBS+u36XYGrmRkkabvH2wcwjNZI+oubkEiLRBTYLEc9
         k8NV2aBKUWoA6x5LspPvKdHr16CXE3clB+BNS/bu0LAPNou3BpH5izVTSi26wVYBkDWw
         Fs7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6n6aLk4S95PP2cHBUtjde/ElDFKHT7PQCv/XwW7mTl4=;
        b=fCwrRf1ITiNiNyr3yIUSdXu8V8oUQNhgT0lcliz8vCZgYSPwjkQEZYghblxLjFYwg2
         GZH6uWcVXyq+sC5ePHMHlnI0FvLvStIkMHs5gboq5CVCSND1KM9LFveUhystU2GtCHeu
         R+XWteIBACDIBa2lvQ2jnuacCxYYnkGzCcy04JPQa0IZ0xbkFYrU41T5vj7w9IXroS6H
         9fqkJG+7j7gYhfqiChLuuf78sBkW52YrnY4jpmNPMItFo/MuRU+M9NOS2l6ATo2i2NRp
         zyxvPWHuOaVeXFD0sOk2mvHXpoNYu0D3zpQMDEBGgiykqg5tzg4nWJmPJ2mixQZllah7
         CHWA==
X-Gm-Message-State: AOAM533nyrNBOgnNS1svbf9pzoJpbjHK19pnTmX82X+5AUI0tTlp6SUj
        LOWS4IE1LdDfbI+9Zdxf1dTkVc87hYjyYQ==
X-Google-Smtp-Source: ABdhPJzaFT5wh1jIv9fL8qsGLQaxyPGwjY+Ey6blOzpeBP2/7Q9skcUMWRgvdu0WvQr3elBBGel/0A==
X-Received: by 2002:aa7:984b:0:b0:404:fd28:1aca with SMTP id n11-20020aa7984b000000b00404fd281acamr10369648pfq.34.1630909145911;
        Sun, 05 Sep 2021 23:19:05 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-68.three.co.id. [180.214.233.68])
        by smtp.gmail.com with ESMTPSA id a26sm7831946pgm.87.2021.09.05.23.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Sep 2021 23:19:05 -0700 (PDT)
Subject: Re: [PATCH 0/4] Compile-time extensions for list-object-filter
To:     Andrew Olsen via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Andrew Olsen <andrew232@gmail.com>
References: <pull.1031.git.1630885899.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <066e186a-ffa5-3548-1b7d-a769bbd296f2@gmail.com>
Date:   Mon, 6 Sep 2021 13:18:59 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <pull.1031.git.1630885899.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/09/21 06.51, Andrew Olsen via GitGitGadget wrote:
> Adds an extension: option to list-object-filters, these are implemented by
> static libraries that must be compiled into Git. The Makefile argument
> FILTER_EXTENSIONS makes it easier to compile these extensions into a custom
> build of Git. When no custom filter-extensions are supplied, Git works as
> normal.

I don't see why this series is useful (use cases?).

-- 
An old man doll... just what I always wanted! - Clara
