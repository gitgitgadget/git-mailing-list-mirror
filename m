Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C01C433B4
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 05:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8F19610CE
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 05:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhDBFpu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 01:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhDBFpt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 01:45:49 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E8EC0613E6
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 22:45:49 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t20so2059202plr.13
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 22:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=N19CacjDo7+o85AcU4dWwGhTtm/WYE2B7am+sXqgGJ4=;
        b=ORsjHuGfI976RreoOxyOZiITsIo5AyO3vI4ztD5LJG8+hh+5Ywvpk3WLSU1Jk6hb9B
         otBEFgrRpBUR3HUyoctZBSXkFp2yliOB/ubx6qQT9ucJtvWMXh0IG+PAgy2fa7flB35z
         EDlrSPYtVUxOu6nJ3uijt1dGjMPS+2ViZtsH2sHX/481yCT3uCqM4UxVZCp4iu8S2e5Q
         vlFvodcNhhM9RMFjU3UfczEcfdS2qjP2ctUkyBXuvsFRI/zbDPlCWS7byOxneqFPejK7
         EKqTYykxtTjETvzyJwPdxYHeAlH1N1K64g1MjPvRm/4B2bnPjz3AnH9FxkUU19HU78fc
         VcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=N19CacjDo7+o85AcU4dWwGhTtm/WYE2B7am+sXqgGJ4=;
        b=HNDcQ7Cf3awana5OmG1ulybNzcUQqw5sbMI7nBADiTB1NJXgHNiPgabYB67rlWUbE/
         ADE8KTVrEjZPe02SWOPyF/HAxcLByKdwe4GFrEaUFQpW7zqyZWBjBomhAt/P4eG3Di3B
         jdITuXAsgVIg9syQOqv95iCG9MtG0L8V1EgYRY3e+JWEq4QUGSq7v2a9sZnS6SQbp8iW
         MIKgSHT+uFWTuUNW5mGvsPEFKhouH9PeaiQ1WydWiwQzwfG70bPdw3iryO2uvMKN5i2e
         x91YL6ZMCM/ZvaZLAQiAOnFXuwnpXbGrXsUpFEIKC16vqiDvOtYG0/iG50xazTbQNpk+
         12Xg==
X-Gm-Message-State: AOAM532B5uJ3sI2Vz87dKvxUDNh88eXPQ14LMx2kLLJTpnZRg6gF2o0d
        roc18jCSEIbjN0BefNFY/BxyA7S3G6GBaQ==
X-Google-Smtp-Source: ABdhPJyzmyr9++alXFD2chOqlTZELQ3O55tb6nSlS0kQd45yadPJx70Vc4tpVGWrShKKLIEuJV0lKg==
X-Received: by 2002:a17:902:d64a:b029:e6:30a6:64e3 with SMTP id y10-20020a170902d64ab02900e630a664e3mr11459850plh.28.1617342348777;
        Thu, 01 Apr 2021 22:45:48 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-29.three.co.id. [116.206.28.29])
        by smtp.gmail.com with ESMTPSA id x3sm6821395pfn.181.2021.04.01.22.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 22:45:48 -0700 (PDT)
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Reviewed-by given by celebrities (no subject matter expertise on Git
 development)
Message-ID: <345a7b27-8ee4-4b64-0340-40b002a25d1f@gmail.com>
Date:   Fri, 2 Apr 2021 12:45:45 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alright so let's imagine this situation.

Supposed that all developers here take a break from Git ML
(except Junio the maintainer of Git). Many celebrities (public figures
like singers and actors) are instead reviewing patches here (with no
subject matter expertise on Git, let alone programming languages and
software development in general). Almost all patches reviewed by them
are given Reviewed-by trailer from them.

The situation above is roughly similar to some TV programs when
celebrities comment on interesting and unique moments happened
all around the world, with little or no subject matter expertise
regarding the subject being commented.

Junio, what will you do in such situation above (celebrities reviewing
patches and giving Reviewed-by despite of lack of subject matter
expertise)?

-- 
An old man doll... just what I always wanted! - Clara
