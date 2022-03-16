Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D30AC433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 11:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355438AbiCPLv1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 07:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355419AbiCPLvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 07:51:25 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE175C356
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 04:50:12 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id s42so3792257pfg.0
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 04:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=A2AI9G48tooHM+Sg4h2QpwwCm8GVn209wIxrbUdw2Ik=;
        b=CBnuTJwUX5QUrc2ANoJ6blGWhFsonjxIfLCq40kgQHwtPH2fIF7RXzWvdY4h194ab9
         7OIlc3Qq49gPtvNXeOd5+qQLkx/3Zy3p5ScXGjzwJSyWgpeD7XNY5RETnF/Yr/w5OgSv
         hfOxjLaGLY7hMLhh3ovucF5ddomQmPEA1G0996GYB8+3GvEyOjOtf56lHqlkdwMlNmyW
         IfLM3hF55Ig9PqGkJ+fwoACL2GgFj8cB+WD6Q9Dj4VIV8S6r8n8o3bdtJOqc+IjGGAqB
         7YIKb+kqRDes2JLlCXcACwrGXVK+GAIn1c/m32dLmqPEb7aCseJ5Lr9AKm6XQ6uXKwtx
         RrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A2AI9G48tooHM+Sg4h2QpwwCm8GVn209wIxrbUdw2Ik=;
        b=e1NcZBT+aRdhiYQXiIPdCKcO4ex9OE6lAtcrJ5cixPibCf4KF1fQVFvPxmcC5a6yyk
         4qZNNyZhAKIANXuz58qXS1Q5KV3utcr0s6MQnLP0wlNCu0i+VVcY5I/UHVWb7ViqLJJV
         ln8B6h68IQB5H600bTjo82oRPV8MHHwl9Cf7Ox2y91n1RjSqBeoRgKmTZWgcC6JekvTY
         uF6IolV0eviZ5WPxCoDgAwXABK6ti4rfdgf4y1f3oWlwnDI5nBa32yp0AaEyrg4DwKid
         kW28mf9sAwxQny6lr8LGaHnM7vTSwsFUOY3Cox83NNZCQivk/ffh8Av6yTyu+PPfr2Ug
         DVyw==
X-Gm-Message-State: AOAM531lNQQIsP574E/y3SxDtF7vtYrwrRP1iP7aBSavrHvt+uZrTWG+
        ihBi0Cguw8So5T6D4+lsi+k=
X-Google-Smtp-Source: ABdhPJxWrRZ4FVpaSVZPYzxTbZRXmDmDi2RrQnatwEUJZsbSLPbxxSVhB+QRvAAEloOAJ9VFWIh2bA==
X-Received: by 2002:a63:1003:0:b0:378:7d70:2ec5 with SMTP id f3-20020a631003000000b003787d702ec5mr27643962pgl.351.1647431411772;
        Wed, 16 Mar 2022 04:50:11 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-65.three.co.id. [180.214.232.65])
        by smtp.gmail.com with ESMTPSA id mt3-20020a17090b230300b001c633aca1e1sm6540690pjb.18.2022.03.16.04.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 04:50:11 -0700 (PDT)
Message-ID: <65998787-15e4-fac4-1343-65df60e971d0@gmail.com>
Date:   Wed, 16 Mar 2022 18:50:06 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/7] core.fsyncmethod: batched disk flushes for
 loose-objects
Content-Language: en-US
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, "Neeraj K. Singh" <neerajsi@microsoft.com>
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
 <d38f20b4430bada1d0dccc1e600e6f0b098f3767.1647379859.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <d38f20b4430bada1d0dccc1e600e6f0b098f3767.1647379859.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/03/22 04.30, Neeraj Singh via GitGitGadget wrote:
> On a filesystem with a singular journal that is updated during name
> operations (e.g. create, link, rename, etc), such as NTFS, HFS+, or XFS
> we would expect the fsync to trigger a journal writeout so that this
> sequence is enough to ensure that the user's data is durable by the time
> the git command returns.
> 

But what about ext4? Will fsync-ing trigger writing journal?

-- 
An old man doll... just what I always wanted! - Clara
