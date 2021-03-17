Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4295C4332B
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 11:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A49564F75
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 11:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhCQLCL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 07:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbhCQLBv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 07:01:51 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB59C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 04:01:40 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so3022189pjc.2
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 04:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MDMB0YIr59wDFgXeTymwWYZIYusJTr1pXR+hbNE1O+w=;
        b=Y8Wz/9rCpeRfJWPaobJDLF3CQheJtXkCtieEHSrpHvOmh/LwZ1Umd7ca5vzxDUMiz4
         jrXf9hssRirqQ6ANdWVkUC8TyvhEwBQkZAEVYk0NLpooz1FP3O+JPiPpZfniE8t0e8TL
         /P/uVtGvxM8YqCxRxXwMSUbau7JGaKS8gor1byeJyc2bFqu0LlsuIxPI6SCri8J1HO5W
         +WGfGl6vKeit4xGpptDK8tlD3xUO7j4wKkYVgLLVR0hEsebaj9Ce/pYFs5/y5JFAcqiu
         8l3E996iZ4jUDyFLdLKZjQK6Vw1qV0Wq+ifIA3LjR/lrO1tHMxxOUnOhGf1owiDZPG5u
         ZXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MDMB0YIr59wDFgXeTymwWYZIYusJTr1pXR+hbNE1O+w=;
        b=Y/jLg08MjrOOE9YS4848osUBfW6mfF6YNoma24D0PPtfBijN1dgmRyHZtMAUpDJkbT
         w9WaI0tAIahB9CxUHcGpd2T6ozX3xMYAnL/cEHxv2ieeuGQVhHgP9Vg2UkcRW6V+Yv+H
         veTHJpcRP46iq2C+o3mGpjeJsWYMEQSc+DLPmGCgmu0MQTGNw5d8/awof4c5kvbWcfOt
         gZRmznh1tHxJOSG3j9RfZZxutwUyl1qyTipkCXXj5TgvSOPlChEew6YqQCBfpnN8BN0J
         uYqGNyMluuGxTnd2tb9CN2CuUsK2UjDQra4m/sDe942Y1phkvwx9j722vnNDHfzPKjfw
         Ewlw==
X-Gm-Message-State: AOAM531QugjIeNUBP/MYCChsr/MAcu7Tmq7bx/VsHhis9RoNxRKgo+O/
        dyiJM78QWtRVYFnodJjDd4TCX7HK/fuxxPGq
X-Google-Smtp-Source: ABdhPJw0Qx7iGeZ8cjIsYEwfH+Wn7AXRpJ2DSt7w6UIKxpeZSRxFn3nqGzvQHQgshs1iBodPiVba7Q==
X-Received: by 2002:a17:90a:1696:: with SMTP id o22mr3959913pja.0.1615978899885;
        Wed, 17 Mar 2021 04:01:39 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-82.three.co.id. [180.214.232.82])
        by smtp.gmail.com with ESMTPSA id gk12sm2392839pjb.44.2021.03.17.04.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 04:01:38 -0700 (PDT)
Subject: Re: [PATCH 0/7] Sort lists and add static-analysis
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <cover.1615856156.git.liu.denton@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <f720a673-e477-3c77-a722-a780ff73a461@gmail.com>
Date:   Wed, 17 Mar 2021 18:01:33 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <cover.1615856156.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/03/21 07.56, Denton Liu wrote:
> As a follow-up to [0], sort some file lists and create a static-analysis
> check to ensure that those lists don't ever become un-sorted.
> 
> [0]: https://lore.kernel.org/git/nycvar.QRO.7.76.6.2010081156350.50@tvgsbejvaqbjf.bet/

Remark for future patches that touch these file lists: please try to keep the ASCII
sort order when adding something.

But anyways, grazie Denton.

> Denton Liu (7):
>    Makefile: mark 'check-builtins' as a .PHONY target
>    Makefile: ASCII-sort LIB_OBJS
>    builtin.h: ASCII-sort list of functions
>    test-tool.h: ASCII-sort list of functions
>    Makefile: add 'check-sort' target
>    ci/run-static-analysis.sh: make check-builtins
>    ci/run-static-analysis.sh: make check-sort
> 
>   Makefile                  | 30 ++++++++++++++++++++++++++++--
>   builtin.h                 | 22 +++++++++++-----------
>   check-sort.perl           | 31 +++++++++++++++++++++++++++++++
>   ci/run-static-analysis.sh |  2 +-
>   t/helper/test-tool.h      |  6 +++---
>   5 files changed, 74 insertions(+), 17 deletions(-)
>   create mode 100755 check-sort.perl
> 

-- 
An old man doll... just what I always wanted! - Clara
