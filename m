Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77A0C433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 12:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD6E120829
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 12:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="utadz9Pk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgHLMv6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgHLMv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 08:51:58 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2669C06174A
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 05:51:57 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id t23so1341995qto.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 05:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GIlepAXsuu1Ui71W7ErV8DNVMwWrMja0CoXyR26pZRs=;
        b=utadz9PkaV3oXhFO38DtHi4OdyDBb7pQVkB1NpKqft6u0XEFHz4DB0yr2DTX3tq7Ru
         YG5Yo0l4x9AjsRton2FQ5mA5Jic8oSEgB1fTinFgIpjhiO/O9mLXf4C1UGUpFDo5ouix
         bUWp4vGj0H6y+CN6XV9Vt9b/OAyRue7ZOByfDBQrLp6wfvUvakQBdr51DIzFGxfj2JEW
         3+3ado2Nyk0lt1V7BqFabGf0D9NwfrR54F/FnQ+Msk7WS2GvFjBNyReHyo35OLp+umQZ
         MMIgEILa952xrd0zCrB8K1O2pI/vhrm3twJLqfTYbI2UE9Ox+WIlgH3WfXesPe/An/iv
         nz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GIlepAXsuu1Ui71W7ErV8DNVMwWrMja0CoXyR26pZRs=;
        b=mMab9HhdgCaTFwjl6vlGu8CTogOtEwQzR9Ij8GJyNUUfFvY8kf1LKFsfRvoW1WQR6J
         jNtpSyLMA4I80q34FirDWrwNwIw0V02k3s0+a54LbOXUU9qDPOVSDjX8GG0ENMis/zyZ
         Ri5i2JD3pBawkIOspD6vRiaavTW6xRbUtRIeRsqAL9DkpsxcOR335RLkLiizcEDVUP6+
         W6PBPVlXouoD9Y+H1FjqJx4mtq1L2vz3xai5l05eLSdLF2ujZzAGxP5JB/AOXR/tL3Lk
         0TFfrW9ut/bVJxLX5S7xyi907FhUL/ravgAo3+Kkpo6UPmki1NWCoQmWbaBhFJXsQ/IO
         lCpQ==
X-Gm-Message-State: AOAM531uEndxF58FvTEWnD+WmxRzw7V731Qq5zWcxVBTIZbn9zXuNKKr
        6lDhmoCdUtAJZcfS8diaCE4=
X-Google-Smtp-Source: ABdhPJy+KgmNV51kfMNSN6wIB8dBjONiQU3+O7qTpp/Y8j6c1gG30wpLcZIXf5oLg0mo0U1o7bkf4A==
X-Received: by 2002:ac8:428f:: with SMTP id o15mr5776987qtl.213.1597236715418;
        Wed, 12 Aug 2020 05:51:55 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:79ce:9d5a:1dc3:8f14? ([2600:1700:e72:80a0:79ce:9d5a:1dc3:8f14])
        by smtp.gmail.com with ESMTPSA id z14sm2175292qtn.92.2020.08.12.05.51.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 05:51:54 -0700 (PDT)
Subject: Re: [PATCH v2 0/7] Lazy fetch with subprocess
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <20200724223844.2723397-1-jonathantanmy@google.com>
 <cover.1597184948.git.jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9d969367-72ba-828b-ca75-29eb532cecee@gmail.com>
Date:   Wed, 12 Aug 2020 08:51:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <cover.1597184948.git.jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/11/2020 6:52 PM, Jonathan Tan wrote:
>  - A way to prevent a promisor-remote fetch from invoking another
>    promisor-remote fetch (use a file as a lock?)

In the VFS for Git world, the C# layer frequently needs to ask
Git for some information, but doesn't want to trigger a download
of a missing object. We use a config option when running our
command that disables the GVFS protocol for that command.

It's possible that a config option _or_ environment variable would
suffice instead of adding another file-based lock.

Thanks,
-Stolee
