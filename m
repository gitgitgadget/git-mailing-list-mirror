Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51CAC433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 11:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355375AbiCPLql (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 07:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347821AbiCPLqk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 07:46:40 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F178C62A34
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 04:45:26 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id e3so1920180pjm.5
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 04:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9UaEkGZmcY8YZ1ZLUXK1ldirOYqqHD+OPsw+Relyycs=;
        b=RZA6ES/tIy8NCuatvWBxNFREYZYMZfAZGue3sC23N4lQttqfdlKwfujP5V1t9q5Ryj
         2XPKYPQMYwqCFIVPy8y4dftKo+h4dww//PXfFTwKseCST0lqFYbjRgtNHQU/UoZ6Tx1n
         QQv8i558FEttieEs0JlB4MqY5J2LbdL1ISqq18JuQi4mNvZfvfYE1b9FVeEHIE45AisE
         YBw7FYg1tl5Az+t4lXjVwCVxhnjyFVVs20XUSAFHt0hJP08k3XRqXGiJifgI7dl5N2f6
         5NQwHp/6S6h0920s0FogQehrq5C1HyO/ytfUeQJSognBmuXOqZtzt0lQzaqfpfmiH8Nt
         IBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9UaEkGZmcY8YZ1ZLUXK1ldirOYqqHD+OPsw+Relyycs=;
        b=DrfUAXeohRuoyPnXd5YrAptoR8POu46W+pI3VduLI7p+pHd0tef8ZNjOIVOKhynw/U
         lAPNX8Z/JxT0aMmC+uLzzP2ggpjneniIThcC0zh/iVVJ4pIpZanME0keZrFgYMZIlLTD
         oG5ylHeqEUyR58NwJpcRo8x734/nzMd78hc9dqTnExtOaKKHPV/OKPrwrXeYNCR5J92Z
         j5t57kWn+YHF+rdYsErNo1HLiTZtz3uf02JBaiPpOw0FS757PxQ05zDYHY3Wnbrezddu
         E64PpFf9onPOsPhYYAzxd20W0Cc+2B599sBL0MCKhPuT3eaFdOcosv6ReaH/YxJWM+jw
         z53A==
X-Gm-Message-State: AOAM532X2iv0OWtKOVTm5NkorAm9dVljYWcGAHroe5q5rmNpbyGHx+LR
        xd9tG08vu3DEecdHjdgG2mafLwCL3jaSdA==
X-Google-Smtp-Source: ABdhPJykyJuhHfYlOlQbj15KjJ1wcqoxH639s6zqu5l6uF/wPg2Y9A8zfjHURu0O1bnYL+OkKimDOA==
X-Received: by 2002:a17:902:7b95:b0:153:34e6:7e38 with SMTP id w21-20020a1709027b9500b0015334e67e38mr25018085pll.62.1647431126447;
        Wed, 16 Mar 2022 04:45:26 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-65.three.co.id. [180.214.232.65])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a1a4500b001c54dc9061esm2280776pjl.51.2022.03.16.04.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 04:45:25 -0700 (PDT)
Message-ID: <f2913941-7475-c28e-22b2-8acea041b5bb@gmail.com>
Date:   Wed, 16 Mar 2022 18:45:20 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] if a file has been staged we don't want to list it
Content-Language: en-US
To:     David Cantrell via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     David Cantrell <david@cantrell.org.uk>
References: <pull.1227.git.git.1647032857097.gitgitgadget@gmail.com>
 <pull.1227.v2.git.git.1647305547.gitgitgadget@gmail.com>
 <16aa4d0b2e4fdf4d807723a9aeb64ca7efb43233.1647305547.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <16aa4d0b2e4fdf4d807723a9aeb64ca7efb43233.1647305547.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/03/22 07.52, David Cantrell via GitGitGadget wrote:
> From: David Cantrell <david@cantrell.org.uk>
> 
> The previous use of --committable would include files that
> had been `git add`ed, but for which a simple `git restore filename`
> doesn't work. --modifed only lists those whose modifications have
> not been staged.
> 

The patch title you wrote descriptive mood instead of imperative
one. It should have been "don't list staged files".

-- 
An old man doll... just what I always wanted! - Clara
