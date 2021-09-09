Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FE8C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 06:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 082976108B
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 06:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352376AbhIIGMw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 02:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352367AbhIIGMu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 02:12:50 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F13C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 23:11:41 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id bb10so395033plb.2
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 23:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GaCVRhlR47vuZpkLslU5mHoAjvdMnc4Np8NrJqHma6I=;
        b=fcL4EMzC4Sqb1IMFGhd/yURnGcnQMM/y4fb0hVS99MhBFVX1wfKtUwRQCUGu6znTrq
         gSBw9I9Bnf3ihxC5Q58CoZDGANH2I3tLXCphuKmhpotjFAWTObzUJ/5t/DaVvRtEAFgM
         ZgoGg7VsL5MOdYahWdqtKIapV6qkKC99hQG7/OBMcsMN/UK0Lr9sJNnVs3MJjyVSvYSg
         8JHuL5gNPKf4k0RMjn7bdqfnc2yGV6Clsd46dSIM4wcFUF7wihjjpZ83ibK9R3LM3tJF
         ZnrzneejYNJQ1SWto+hsBhk/mwTxdjW0urzDTCR2laU9DAosCAodRY9B8BKgxnCx9a5V
         KlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GaCVRhlR47vuZpkLslU5mHoAjvdMnc4Np8NrJqHma6I=;
        b=tstLuZsBS9Q3B6w5HoGTkmEYByn/AuUUvl5yIrMBKS+tKibD8PtDY9TUhLyWBPAmkv
         Q22zMQuZ7PcW+mm9eV4pnxx0bca4KJNYY4ADC0baZ2WBTVQ5hNcagidSOd4FsXyXGg4A
         Dh1W2dkrATC18jZ/ZViyl5HXdbT2uIIjHxqLzSguANx1peuKFxTLow212nTVEK8syBJz
         /a0u+AbqiAAzMjctRNs6cMHNF85o4anFDnMOwl+D0Y5KHh/FEL0rY1n+vwOX1lLcUbZl
         B7ubQDmRcbuO31EH+2/D8+tqP1q2boP5xJIq4u4WQ9g4DUSWbeqglOdm7TRNDKq7D1B6
         AbMQ==
X-Gm-Message-State: AOAM531edDJG4c7J/YnSvBTVw92fcvr/JgNwgh84PpEtlnlpcHEYnvwu
        ZIEqMTceoctRG50sDwvzerw=
X-Google-Smtp-Source: ABdhPJyx9jKRMgF4ncqMBFNLe44Rxa/bnp1l7D+ePt1Gyt9ipdvKI99+bJH6c6W+aEWD/nREMell7w==
X-Received: by 2002:a17:902:d2c8:b0:13a:54b2:81c9 with SMTP id n8-20020a170902d2c800b0013a54b281c9mr1409898plc.21.1631167900773;
        Wed, 08 Sep 2021 23:11:40 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-69.three.co.id. [180.214.233.69])
        by smtp.gmail.com with ESMTPSA id d22sm894718pgi.73.2021.09.08.23.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 23:11:40 -0700 (PDT)
Subject: Re: [PATCH v3 07/15] scalar: implement 'scalar list'
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
 <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
 <d291d3723a6bb8e1d4f871b5279063c3e0a3fd79.1631129086.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <bf098e5d-3223-5d72-d0a9-b19c5b958132@gmail.com>
Date:   Thu, 9 Sep 2021 13:11:36 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <d291d3723a6bb8e1d4f871b5279063c3e0a3fd79.1631129086.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/09/21 02.24, Derrick Stolee via GitGitGadget wrote:
> +List
> +~~~~
> +
> +list::
> +	List enlistments that are currently registered by Scalar. This
> +	subcommand does not need to be run inside an enlistment.
> +

Looks OK.

-- 
An old man doll... just what I always wanted! - Clara
