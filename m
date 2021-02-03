Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E06C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 11:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E528764E3F
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 11:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbhBCLbh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 06:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbhBCLbf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 06:31:35 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7804CC0613ED
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 03:30:55 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id n7so26329197oic.11
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 03:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=LV/BwMTZLsPLM14aEnuRoPQkI2YOFR0+cFGzcDVd/+w=;
        b=mstbxMEThICEqvlPNzrPMDwIPYO9/pamVLSKVKMxTqCPTuS/45y1k9Un7e48Au7OCf
         v9yXavoxIf7K42X09Bhk13tflSAUzkGJ6OljDGXZG6bbO2qr4I0yPx3i3iIH8FACNkvI
         LCqxHvh43D/+4E1lvYOfFid+jCiim0IMvbxC1fQBUjyI2r3P/tKJlgCWOH+5t/G1Fo1c
         cpfoqsQL1lxzTzg4yH2hCAeIDsWFf/9mI8pkTgxnYCx7amIBu2FeJx+YDGMyoM02nAC1
         4IApAPy7Unx6B80Iw+AGjyL5F/ebtzvOrtKIfPFLpAINJGQs0FXTPs/DRf//MeiMtjrF
         zKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LV/BwMTZLsPLM14aEnuRoPQkI2YOFR0+cFGzcDVd/+w=;
        b=O9Ep6hSaYoiyrhr8SkdPSJBOo8MRuKvvuaxF/q/EtTFoCj31JboLYOkUniLmT37dLf
         6UEQLMDfewGo74L/EQ8tpszJuAEWUkxfRZ0CyeVCP6h5TidclgqZor5UHRTsyc/vh74B
         pThNDx0h43Xuka4ADvWAAytK97lAV6mHtJoCq441YUQciK/jpc/3lbWubwQFoTIhh9I2
         iDyeu2dlIR/dwslHdbzBRj8lR1Y1niOSL2nTRI9jrFt58nxjsC6yo9FIcr4LOCJLaE7t
         uXYnYn2aCeiZCgitr6TflnNSPuOpy3JYdbvfaaYPrqQTYvLApcsHVTzv5+aWWguzPkmn
         6pkA==
X-Gm-Message-State: AOAM531ttGFmqGCLDXqMzpC28C7Ac1Iq5OGS64IP2nUOWJ2InHWAjmw2
        LLscyg+Eck71/fuOZpHXIU2+McJ9d7LCgQ==
X-Google-Smtp-Source: ABdhPJxeh9m5cukHOUZBPNLPQvfxRFciyTd/Wxo+EYztuPknnd7vQCMofdD3w2SpAQBiNV/dgberLg==
X-Received: by 2002:aca:5d04:: with SMTP id r4mr1718758oib.43.1612351854561;
        Wed, 03 Feb 2021 03:30:54 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:79cd:7444:bf97:c4d4? ([2600:1700:e72:80a0:79cd:7444:bf97:c4d4])
        by smtp.gmail.com with UTF8SMTPSA id r7sm396510oih.31.2021.02.03.03.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 03:30:53 -0800 (PST)
Message-ID: <ddd2ed7e-0206-1274-a6b1-1721cbb40575@gmail.com>
Date:   Wed, 3 Feb 2021 06:30:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: GIT , Visual Studio
Content-Language: en-US
To:     Murtaza Gandhi <murtaza.i.gandhi@gmail.com>, git@vger.kernel.org
References: <CAC9ZHmfj2tii729jixAQUuM1EZ3GD08Ei5XxxuL17aWzRXT2pQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAC9ZHmfj2tii729jixAQUuM1EZ3GD08Ei5XxxuL17aWzRXT2pQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/3/2021 1:23 AM, Murtaza Gandhi wrote:
> Hi,
> 
> I have newly joined a team.
> 
> I will be working on repository at dev.azure.com
> 
> I want sequence of commands
> 
> How to use git with Visual Studio 2019

Hi Murtaza,

This mailing list is intended for working on the core
Git command-line tool and helping with issues in that
product. Requests specifically for hosting providers
or IDEs should go somewhere more specific to those
locations.

However, you might want to start with [1].

[1] https://docs.microsoft.com/en-us/visualstudio/ide/git-with-visual-studio?view=vs-2019

If you have more questions, please consult the Azure
Repos or Visual Studio support channels.

Also, since you are joining a team that is already
using these tools, then perhaps you could ask your
team members for advice? They may even have links
ready for resources that helped them learn the tools.

Thanks,
-Stolee
