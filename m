Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60C6C48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 04:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F2461351
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 04:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhFPE6d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 00:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhFPE6W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 00:58:22 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E24CC061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 21:56:16 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u18so517445plc.0
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 21:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=R0+kIsjpqvLOw58Y2+YJDV+dbPMJSWbyJq7cA/zuWP0=;
        b=BI9PXrgAfBvu5yIfA/a1cUfXh0VLH8IIQ/yXGZPU/ofswsQYUkcmyDIUnLMdoFRZmb
         03KYEUxQ4eaqGe2+wakANFlilPa9C7eimLHCv772q021vzcoJgFTRTQIIajK4q5Ry9UW
         HfbB/aMI7pqH8uRzUWzEunPMkmMfyXGDLDICY4lORim+b1LpaPVOWjRbkugUEjRmMhNz
         9Ul7+6rQCKRfdaMYJTismgcYfNWU9wog8fsW7yZLBSXHqjQZFkY4cw9rRL7vpyJsXNUe
         x86ocXXXxjKiyBb3pXFJPcdCEW8ivTYUR8TMMIOTl5HCAZERL9hkYlDgYLc0EF/1ftAF
         zQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=R0+kIsjpqvLOw58Y2+YJDV+dbPMJSWbyJq7cA/zuWP0=;
        b=ev9B6tcNloqQZklFA7glxAhEci7p5pjReqC4PVnae/U4iUVcf2eyW7RRMvpxwq4WKx
         61/kSLXYJuUXUmXqCt65RVKKbRhpG8bHL5dn7JsLm7JtuLd7gh8GBpDuz3nlXt1LTtzO
         9GT5pBeBu5FlTqbk4pM+2YGi4VJtxI6GGT1Su/QlexDoMN81nQ+B/b2DluICVisxP0pd
         ZOb/bN4IE3s5/1SEn6f+ejqKAHz+DteUgbU6+7Vy6Q9U8Pjs60VS3pItz7LF6gpaDm1P
         QQeQuy7m6feGVbaVqsg/1ciVfJgke3qwc1svSGKJO0golWHRwNmD167KXdNROD3zP8/o
         uasA==
X-Gm-Message-State: AOAM53287OUTxNGAYlaNLL6vvz4lxVOKmxujS61dv0VQHBOMs+Dw9ph/
        Yjp0D4KTUSlIGhZySeKEbboc17xZU05H9g==
X-Google-Smtp-Source: ABdhPJxSAJpg1y4lCHhvp4Cv6GfOFPlp+7pATRs9MCqNMyQR0ao8FZjlYkbb/wG4LZZay6xry0uXpA==
X-Received: by 2002:a17:90a:9282:: with SMTP id n2mr2314695pjo.204.1623819375509;
        Tue, 15 Jun 2021 21:56:15 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-70.three.co.id. [180.214.233.70])
        by smtp.gmail.com with ESMTPSA id p11sm697975pfo.126.2021.06.15.21.56.14
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 21:56:15 -0700 (PDT)
To:     Git Users <git@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Simulating network throttling
Message-ID: <65b4040c-2a9c-7d49-43ce-dad7d5a9c62d@gmail.com>
Date:   Wed, 16 Jun 2021 11:55:49 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I would like to test my Git repository in case the network is throttled 
(that is the network speed is reduced from its full speed). For example, 
I would like to test git clone under maximum download speed of 9.6 KB/s 
(GPRS speed).

I know how to test for throttling in browser, but since Git is 
command-line application, is there any way to simulate network throttling?

-- 
An old man doll... just what I always wanted! - Clara
