Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA4BC433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 10:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F6BD611F2
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 10:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237460AbhIQKqI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 06:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhIQKqH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 06:46:07 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95127C061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 03:44:45 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id e16so8852189pfc.6
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 03:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=7DatpEFYqOAh7+6hqRCgt+DtGtxNaxUlu1fyi/iAXYQ=;
        b=ncwjytOAwlsC4T1NDEx9x7uWIDbWyvMcxKozcv552vV0XI3Ju6Pc3Oc5PX3Q3PdP5d
         iLRjynEu9+NvyWb0UzpThGsCFJ2A33oyZwj1UYr6H27XFlSSO9AdiMQ5Za1adSKrgXSp
         /VidBBrbOWa5KmiqmZ/RbGskIZ0L6U8Obh3VmNeUOvKcC0gnS+BHBGRN0VrW6O7lprpY
         mLa+C8XTzl2p0OGQrbatpFDKhuwQcrzIRfYe2S4xPxvpp51xRPNZLiSbg+QMZbp140b4
         9DNrK5PlOWGu5Mr9cTQUXCWexM8y/14xb2NjXkKq/fmte30caYNSX2pOsc5ZGDhK9C6Q
         NiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=7DatpEFYqOAh7+6hqRCgt+DtGtxNaxUlu1fyi/iAXYQ=;
        b=EY8BtzcQgdcYIXHRG4yoKOi+ecsE2r/rkNIHMVQvly7mNyV9AXsQykR2eUXH5g6PTD
         U6XY7aucWH3RcdHvFbxfTjyPMfxD+/aAgzxkCkbsPDLFU2vEUfnQGPtrZin0rY+vxf/W
         3UHEu6o6fD0aBq/qgirPcfRVMYxhEeiWjrdE8a63lyOrkAir0KsvejIMCjVAMunb/Lgz
         5RhtWOdaQ3aTBihQLUfSB1B5LLJA+tLG3MTdv2+mJWDjWDygLHyCi7H/QQbVnMpidvwz
         8zdUAKOqB1EWv6c9UVZNuGeHCwGDepv/Nxzkug+7XyOJeHHG0qFvqcKUTfG3AaCV9zCz
         Xn0g==
X-Gm-Message-State: AOAM5319lvTuqCJ37OlnF1TCfBmpeeLqKUFwP1DMRPfnyinNI8nn4a9U
        E2gvEADLF10oDV35tv4eEjRcPnSrt7+Ai28F
X-Google-Smtp-Source: ABdhPJzCmJg+iEK9/THqMuaI7ZvreHLuBdEVNbsYp13yW28Vm0KSO6+E2dLwXQMBjhCRs0qplX9dXg==
X-Received: by 2002:a62:2703:0:b0:42b:5319:cbbc with SMTP id n3-20020a622703000000b0042b5319cbbcmr10284138pfn.66.1631875484859;
        Fri, 17 Sep 2021 03:44:44 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-88.three.co.id. [180.214.232.88])
        by smtp.gmail.com with ESMTPSA id m64sm6166143pga.55.2021.09.17.03.44.43
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 03:44:44 -0700 (PDT)
To:     Git Users <git@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [QUESTION] How to add new configuration variable
Message-ID: <9f3cc3f0-36db-f7e5-de1d-2c8c9f246884@gmail.com>
Date:   Fri, 17 Sep 2021 17:44:42 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Supposed that I'm writing git-foobar script ("git-foobar.sh"), which 
takes configuration variable "foobar.something" (string type).

How can I add that configuration variable so that it can be used by the 
script?

-- 
An old man doll... just what I always wanted! - Clara
