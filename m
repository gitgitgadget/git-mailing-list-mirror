Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC946C678D4
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 21:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCAVXl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Mar 2023 16:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCAVXj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2023 16:23:39 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4E22A980
        for <git@vger.kernel.org>; Wed,  1 Mar 2023 13:23:38 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id r4so9232290ila.2
        for <git@vger.kernel.org>; Wed, 01 Mar 2023 13:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1677705817;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wb33epPlc2TKBKu/GemBNA+iMPgjmL/saRebIAoceSM=;
        b=QXe9yqCxADpxn8u9kIMic+t6464SPnN7Mp9fdAlp5ZwrrW/0Rqg0aOiMuHa6jy+zRH
         zCoIK5gbyvAQ8VX/mE+IykQ5V4CJLn6XbsMdJhafkhsxJPKK9c5vC7rrJRW8SrpsPjRS
         ux53ONLkui1c2VLDoPf+lc9HQw5tuDNOpIeVDHW/S97bVk2cyn2+Z1u1xok2NRJMWKyU
         tjrwYe4r9cznmNZi85q2u3r6vDNIyEQJZMxbH3HKV+DhoXqpmxd/+i2XK9LxYsRSoZ5P
         oVVBsLseNkhxpkGAiEIt3lz6N0/3PAqfKq49R0auq+lNKJGpctoAyMu1x36tpnYD9kBv
         ibhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677705817;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wb33epPlc2TKBKu/GemBNA+iMPgjmL/saRebIAoceSM=;
        b=r37jZlq1kOycEosslej0fsl/Ky+kqqLOiwcj87aR6qb5epR0GuqvHnRmjOTLZBkBI1
         utqR9Qod5rHcN6zzY0tagYWgFGDmfInT8aZx+kCY9rTkMINHSHk3L42fRWpWqdp4MHgo
         pi3M4q4lCrfAE5rc3lSYIeQ236rKLdNZ71odS2RBjGDNbmhBDbHTYcA1n0PXA/FO3kG3
         QVif/SX/zMI7P6c9YucSDvl3iPzyTmnF/6zw0nZ3Tk64OkztDstrBmLXeQOZSXA9yOJT
         Sz5AA/wPLqtP5ZDJFfgq2tJAtHPZkCcv8jQCfdfT061dcuUYBgYMv9ar+kwBP0napb2s
         DfdA==
X-Gm-Message-State: AO0yUKVxC6YTLw2YCRXhJIXWl6VcjfWc7vGcbg7ojebN4pBrSJcwnJbq
        uXBH/9xUDp5gJC/hsSaznmkhSqXrt3S589PEDj3a0AvdlX96cd7nK+B+MxssrtEcQcWSNMGPZqh
        32mpygE7qhJzMbHhiDkeECARKzO+HP91p7sXXY1qdBGH3hPO6xdqQwqmHtrZd0shq8WAQ4g==
X-Google-Smtp-Source: AK7set+9sM0tlujrH5zvFfFU3DX3tgi1m1pFl7ZpjRBlNZ7iRq1ukUURtFxCMR1HW+o8O1ohAEPfmg==
X-Received: by 2002:a05:6e02:1c42:b0:316:e453:5372 with SMTP id d2-20020a056e021c4200b00316e4535372mr8746115ilg.1.1677705817126;
        Wed, 01 Mar 2023 13:23:37 -0800 (PST)
Received: from [10.0.0.153] (c-68-47-28-129.hsd1.mn.comcast.net. [68.47.28.129])
        by smtp.gmail.com with ESMTPSA id k13-20020a928e4d000000b00316e54a8287sm3818230ilh.14.2023.03.01.13.23.36
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 13:23:36 -0800 (PST)
Message-ID: <566534d3-9691-1dc3-dc32-cf2d589b478c@github.com>
Date:   Wed, 1 Mar 2023 15:23:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Content-Language: en-US
To:     git@vger.kernel.org
From:   Keanen Wold <keanenwold@github.com>
Subject: Git for Windows 2.40-rc1 time frame
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello team,
With the tagging of Git 2.40 rc1 this week, we are planning to have
Git for Windows build ready by the end of this week (3/3).

Thank you for your partnership,
Keanen and Johannes
