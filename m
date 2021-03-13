Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB2EC433E0
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 13:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 272F564EF6
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 13:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhCMNll (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 08:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhCMNlK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 08:41:10 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF45C061574
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 05:41:10 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id w8so6524010pjf.4
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 05:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=zRFnJ3NSkYr1MPI8c1vaGZg3w+4Yw8jQoUSvzBitnzI=;
        b=L+meD9mrJSDZ75tVkJZapU3Tim0z4nWSNVryEXUNlbns/tfqARPEvqwbENQsUfcuWG
         q48t4tE06+syrD3id5BUECW+pHKJWCIX83p5XhAEcGC3dhe47cWbM4XJlV3FzuiuSmPR
         jN3chorxIfGWLSJ4XKhlEVqY2Cx/oFThkV0rWsxUL1q3UBFX0e5Im0rdV3r5+90f6ZZj
         8eVHM7jRUvHnOyYCqghlb5E9ODbAo2WKjr5P06HWFityzCEPeS9z22xadUTXSpwmQmUB
         Xzx1Fv0xi35KF4h+kWYybN7L3wu3iz3Vl5Ymdjaic+Jx11A6lrhtkY3hA+YSs+yDTDOn
         +VoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=zRFnJ3NSkYr1MPI8c1vaGZg3w+4Yw8jQoUSvzBitnzI=;
        b=i9AYNZZ1tEGFKZRGwnVitPTtPds10wN+yWH26RRmBILBt8QSqvaQ0W8N2kt+5fCMZj
         4fMz/i+Z1tLFpaj37JwI7pSTdGjSbpTwa+sbCgrMnjuTkXQpvmmMNZjlQTvcJHtLEEoC
         HDm2K08/uj8j7S9n/3siSN+67ZWpzKotcHQp6foFM7j5BurlyZx1SrR+M11onzCf9fao
         AhrOthkDHmq8ap9PI9Fni94Ah6KLIAb/ePia5d+6X4R1MSxNiBgXlIkhR1U6qdIfUk+H
         7f5046d+3EAVo6wJtSjhzeAMZyux8Y/qrFbvK9nszfwwSpMQhTlbqpqffw638uplryp9
         W0xw==
X-Gm-Message-State: AOAM530c2/wIRSMHBN78K98RDSwlViXQxX3y3lgtQKAtFdsXtSrHEx0w
        IgcECPMnb9Sul/cel6TJppaP+hjwBF5ZqQ==
X-Google-Smtp-Source: ABdhPJzjj5K0hqgEc5PoWv+l51HSV0mqedACQO6pHMjeb/qumbakFCj3+agtIt+aCOnbtAnN0lsbbA==
X-Received: by 2002:a17:90b:3551:: with SMTP id lt17mr3719401pjb.89.1615642869749;
        Sat, 13 Mar 2021 05:41:09 -0800 (PST)
Received: from [192.168.43.80] (subs28-116-206-12-32.three.co.id. [116.206.12.32])
        by smtp.gmail.com with ESMTPSA id p184sm8434695pgp.13.2021.03.13.05.41.08
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Mar 2021 05:41:09 -0800 (PST)
To:     git@vger.kernel.org
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: No cross-compiling instructions on INSTALL
Message-ID: <f3166e9e-0616-948a-2236-7f169976d035@gmail.com>
Date:   Sat, 13 Mar 2021 20:41:06 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm just skimming through INSTALL, and I didn't find any mention to
cross-compiling Git. I think it would be nice to add such instructions to
INSTALL, or to separate INSTALL_CROSS.

The idea of cross-compiling is to compile Git targeting different architecture
and/or OS than build machine (for example, compiling for ARM on x86(_64).

Note that for cross-compiling we need a cross-compiler targeting the desired
target, and for binary compatibility with rest of target system, we need
versions of compiler, libc, and binutils match the ones on the target.

Thanks.
  
-- 
An old man doll... just what I always wanted! - Clara
