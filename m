Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD18DC433B4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 19:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 881BD611CC
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 19:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245041AbhDFTpn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 15:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhDFTpn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 15:45:43 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4763BC06174A
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 12:45:35 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id z15so16315525oic.8
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 12:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k2mR5OgLhf/xKpDGRkO3HwPP3CoT6V9+1Z7PX7ldjUE=;
        b=XTgpZutg/goYkI6lm7soceFBg0h2skliN0pHtHXMyS/lng2B1Ef2BkKW8Hfo+6WgUR
         YqC4g3iq5WoklOywvx63NXePR48Pv1SwMIdsmwLt/yV3VxPGRb2qTpq4NjX9r0urQZwv
         D4QC1omGMA6iHD6pzMJ6D9Ew3c2b9Fiug6dFAOplDqjan6YkWMJnGoJdxHoOsR6iSVmU
         sH29U5lkeJRhVUYUwwxI2qr1l3wKXPvCA1owFhxk7rvlvxPKXFMou5uEYg5z8typQsDh
         wR5P1cJkIS0JGuMQLf2IzLpDqy/BZKk/FC2jhuvuindDMTzI0XcmjaiYpuF6cFt8u2zl
         Olug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k2mR5OgLhf/xKpDGRkO3HwPP3CoT6V9+1Z7PX7ldjUE=;
        b=unjrh058KAfSZ1moBymCdaYuzUbKHTw812PlXti3HhGSGw63M+LewytXbzfxLtcnVL
         5cMkO5naCx2cVIKDX9kpw4k74VbkV0vuABbnuii4z4R6w+elg0CoIxS+GhKWeRSrACOj
         Ln1EGQ5xxhZ3sBysFEELhgcXTNrSGAPZgfVRcgq3talWylVaUSkP55RbOeAZpGQi+A7T
         LP1oKDf0xYj/5wDRpt9RefvZdMV+HM+eoSw853yWHnvMm3L9F7H04F8EUYh776ESDOuE
         5uBe3eIcIX4CRMSvCWdseXdUeqMc87GAcQ3D2oN7uc/oiSGeTZ/Pwn/4/hmktwBavDtL
         iebg==
X-Gm-Message-State: AOAM532snz7T9ONoWhyDj0p/akt0ORDmr7t/QT+rs+TbzQOHPm2uP/iM
        Pp9FF106Ryyb3yMx2yWmkaY=
X-Google-Smtp-Source: ABdhPJzGT/fJZ15/pg3bOPGniLVxEgPKkzrH3Znc6Y8SDyyIBZG5Jhpj7F7faXN69J4rSJ3Mqd1Bwg==
X-Received: by 2002:aca:f156:: with SMTP id p83mr4464175oih.91.1617738334508;
        Tue, 06 Apr 2021 12:45:34 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7d35:99dc:7770:379a? ([2600:1700:e72:80a0:7d35:99dc:7770:379a])
        by smtp.gmail.com with ESMTPSA id 24sm3783007oiq.11.2021.04.06.12.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 12:45:34 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] maintenance: allow custom refspecs during prefetch
To:     Tom Saeger <tom.saeger@oracle.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
 <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
 <9592224e3d428762c6f9b38a0bcc2cee5c3dff6c.1617734871.git.gitgitgadget@gmail.com>
 <20210406193637.x2xqkkyqbjabgzge@dhcp-10-154-113-61.vpn.oracle.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <35fa99cf-ba24-f13e-0607-f9acce2905cf@gmail.com>
Date:   Tue, 6 Apr 2021 15:45:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210406193637.x2xqkkyqbjabgzge@dhcp-10-154-113-61.vpn.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/6/2021 3:36 PM, Tom Saeger wrote:
>
> Junio brought up the point about configs which 'fetch' have no dst
> https://lore.kernel.org/git/c06a198a-2043-27a2-cab3-3471190754cc@gmail.com/

Thank you for reminding me about this. It was on the other thread,
and I forgot to go back to it as I was preparing this version.

>     [remote "submaintainer1"]
>         url = ... repository of submaintainer #1 ...
>         fetch = master
>         tagopt = --no-tags
> 
> 
> This patch fixes segfault for config like above.
> You might have ideas on a cleaner way to do this.
> I did add `child_process_clear`.

I will also add a test to ensure this scenario does not regress.
-Stolee
