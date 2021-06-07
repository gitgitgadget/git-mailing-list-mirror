Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0427BC47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 15:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD82261164
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 15:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhFGP35 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 11:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhFGP34 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 11:29:56 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB8BC061766
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 08:28:05 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id f70so1833150qke.13
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 08:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jUMyzgRNIx/nhAu8MdVpP2ZluwcYLgjlRA06HAwXqoI=;
        b=am1UIu9t59OfxQstCko3Tw2puLfntbycVZHmeWb4KuyS3Rab7dBJhebDt1hxTALuhm
         g9GPKGgwvd+1PZ3H4CTaU1ukHM19FrTKEvLSPvAQcwDBsOxPiSytUFAD+Rq5m9baHH4i
         R2REV85HG7c5V8ZNNvuwR/Tb95v3xDHZHpA5tTtLgeNMBoaxcRlnO5ETSxNEY5RjRTqx
         LNEtfJCiTptLnHiBmi6MJHuVMm4ogdgKG4dA9HmXIniPohBczIH2Q9quW7B+SKrd2GGU
         54oT/du/wY/kiMpBrg+BaoLpSHar869q/YdvJrwMiFLPdB1s8xqyYZNnR5nqeZVF1IOC
         oWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jUMyzgRNIx/nhAu8MdVpP2ZluwcYLgjlRA06HAwXqoI=;
        b=C4SDXraVS1fZH3+vuDx0jrNZKdlCVQVoP6co/3ppjn/5a2UZ1B3LRIRuOipXxc3jAw
         8KY4KIREZbeUfucxg54UFgytX280Ej0GQASXHgrvbxjHcR1z3ckaZTunGzhAriEaqruy
         dVPiCpQBX/nvrvbE6YhqDCIv7KkEVfoOmzHVLURqgWcgIzeGuswmm4odcvt6Wtm32uyn
         XeGZ6nDnWwi2aJEa/AY60Z3HybSV8dkx0UV5Q/a9khc7ZgYdeOxrC15yQMpjX6itm31w
         tevf8ZnB6fA11CuPgN8K+MOLEDxiPO9apirqxeISybkLXA3AtnFPjFuY8def6J4qk8yL
         u92Q==
X-Gm-Message-State: AOAM5322OA78a55hDityBS1yLyauGLHeS6RXbZ3kn5Lodu7Xi/QrmhlK
        S+Xm/DHjw81yb13PiL4JydQ=
X-Google-Smtp-Source: ABdhPJyURx1eKeHsZ8JLy1ZJ0ef0envTT5WMns9rUMRA+TsQqv8u34zqo/ht0n6hcHyGymc9WAmA0g==
X-Received: by 2002:a37:b7c1:: with SMTP id h184mr17154633qkf.65.1623079684436;
        Mon, 07 Jun 2021 08:28:04 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:58fa:fc7:3955:c1d5? ([2600:1700:e72:80a0:58fa:fc7:3955:c1d5])
        by smtp.gmail.com with ESMTPSA id b2sm8225228qke.63.2021.06.07.08.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 08:28:04 -0700 (PDT)
Subject: Re: [PATCH 1/2] read-cache.c: don't guard calls to progress.c API
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <cover-0.2-0000000000-20210607T144206Z-avarab@gmail.com>
 <patch-1.2-1680109655-20210607T144206Z-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <51e00403-dcab-c57f-b77a-de01a61a60eb@gmail.com>
Date:   Mon, 7 Jun 2021 11:28:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <patch-1.2-1680109655-20210607T144206Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/7/2021 10:43 AM, Ævar Arnfjörð Bjarmason wrote:
> Don't guard the calls to the progress.c API with "if (progress)". The
> API itself will check this. This doesn't change any behavior, but
> makes this code consistent with the rest of the codebase.

Since stop_progress() closes a trace2 region, this actually
does make a change in behavior, I think. In a good way.

Thanks,
-Stolee
