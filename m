Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94B3C433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 09:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5915600EF
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 09:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhC3JKZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 05:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbhC3JJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 05:09:58 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AC6C061762
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 02:09:57 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ap14so10566675ejc.0
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 02:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=3qHmcIizjYbmEFE3Jt1yTsuuhoL7BCvJsQ8roG0ICGY=;
        b=ZX0eQTTMa6Jv48NpjX7NT0vDmmaM+xxu2UsPJSFR5ZM7bwK5R7FMGCm/kJYqt4GQOu
         RifSxZill3v+pDR2ly+ScZYlmwZJyxrQ3zhsH8H1hOg/pCGpm4b+EVpc9V5nD++Qoutm
         hZTS4FZD8lwC8QcshMfIHhZVBgE/YxSjsYfJ5/kMawH+WW5N2WWYU3bnhPP1zpACxyK3
         oHXJQhN8I5GPqf0fTULmN4F2utzRuUpk5TZ/eiTHOhdWtVxynP6y+WR47tCgTfCZ/9eO
         u7zEql2pVdGmRpKfsFh/eSZA26sRWJ+LscCnffZQZuE8oEcoj5njI1N533ShU0VO4u4k
         eEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=3qHmcIizjYbmEFE3Jt1yTsuuhoL7BCvJsQ8roG0ICGY=;
        b=tZfVTQdCLqiJ0a/+8Da0h11LZYUOgjUQTw7vvcEyJuU7RkhG567bPgE5JdoWlf9oEe
         uwwWxRU4GXKUGk+qAZbznbcJkx7dRxtdx+Bds9CMXj6hiWaTtpQ8xFnYnP5An3ncIMJe
         FXPjNZJI8vtcNxKWIgu1Z1on/boszeSyMiIpVaTBBvH/fYsdkYQmqU72LNNdlemzcKTF
         2vpRNQFpVAAVZTyqWCTa0ODJGTI11rbjCswRyOg0H8aFWVLIxnGb3EenBZlZqQWJGUbW
         Ga33NnCsJMeCnVDXf7IlwoCHWxo9iPuYoUB7/c7VWEgzFoWyh4U0/GltVRyijmXoA7tL
         y8IA==
X-Gm-Message-State: AOAM533SnyeXVoW3G0wduRBbl92HKeIMDwVQrG13GwMDhG7+AxfwikoA
        9cYGdvc0YmDLuyOubkC30UXMJepDMNlL0w==
X-Google-Smtp-Source: ABdhPJy+TRGQI19e0NR9WU1g8b9SBm9zUDxUvKnHMAIHIJDy3EGe63IXwdpOtaSm7mYbAdvGCPt87w==
X-Received: by 2002:a17:906:5e01:: with SMTP id n1mr32565124eju.359.1617095396539;
        Tue, 30 Mar 2021 02:09:56 -0700 (PDT)
Received: from ?IPv6:2001:983:12ec:1:f427:5f39:991a:7e4e? ([2001:983:12ec:1:f427:5f39:991a:7e4e])
        by smtp.gmail.com with ESMTPSA id h8sm10446181ede.25.2021.03.30.02.09.55
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 02:09:56 -0700 (PDT)
To:     git@vger.kernel.org
From:   Erik Claij <klimclay@gmail.com>
Subject: git submodule problem
Message-ID: <dab7128d-5ea7-5d7c-1ae1-1d71be316326@gmail.com>
Date:   Tue, 30 Mar 2021 11:09:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear git,

Changing branch with

     git checkout --recurse-submodules <branch>

does not work when the branch does contain a new submodule.

Cloning a repo without submodules in master but submodules in the 
<branch> will reproduce this problem.

Error

     fatal: not a git repository: 
../../.git/modules/module/esp32_peripherals
     fatal: could not reset submodule index

The alternative way does work

     git checkout <branch>
     git submodule update --init --recurse
     git clean -ffd

Best,

Erik Claij

