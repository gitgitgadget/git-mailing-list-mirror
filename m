Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06893C33CA2
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 11:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB2732072E
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 11:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcEe6sRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbgAJLYW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 06:24:22 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35135 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbgAJLYV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jan 2020 06:24:21 -0500
Received: by mail-oi1-f193.google.com with SMTP id k4so1581030oik.2
        for <git@vger.kernel.org>; Fri, 10 Jan 2020 03:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KBlxdIGWnzut3gppaUDLvgXgXZbFnJ13QgS/Z4vjdTU=;
        b=DcEe6sRf8ORDBprNRNOvtaxJJbe/5cribnwLDwt5AIGKJe3uUdrM7z2OniuE7LqJps
         93ZFq15hLQBCJvASjmx+ezFJ0ydRCQ7tUXS3yyFT3u2KM2GH88qekl+iJnxEAexSxfdw
         VvOjJW5GSPP0KNG6trcPbptMpsaNMamUICK8O8nU2PYNka4E/QJdMyGAzv9iu4nLblXT
         LK8NowrYSFSKoxW0DMCgWw2txBYcR/OcL5OHY9l8UF4uruBeSfBy9WFjoINU0pIm6Xmg
         Px2dIrNRlnQaFqfCvpN+lmvwLbNgTO1w6xxcEsy3V2DkZTQcnRbiVovd61Fy3ECNv/SQ
         diqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KBlxdIGWnzut3gppaUDLvgXgXZbFnJ13QgS/Z4vjdTU=;
        b=t1MUruXAa952E+MUSq5fJkV7MxkGncXb0SVgqbc7vqQZW8nS1gRxvfhs1z3Mn+1hzY
         A65zE0rKLDYGD04ahgzLWceNwg0clpCSnOMwDuwmyZF+/lb947o1C2QJj7uk0fjvUjv9
         MvUtuxeYc8l29jC8fCogNtC129nGgwsICHMNBXDmJHrzVDdEglN/XGOwhdw+Uajay0Se
         N4G1V7jaYe+i+SiwNtveyOw3bt+qycBY7zgymOUyZG4iWlU91bAG8acrnsQ/x2pBGfEq
         gOzg0XXTKIuRUd0V+o0CVIJlAZjjASq+SxW1ufSPwmAvuOnDwi+W7XI/MEKsDW7QHqSo
         hJDQ==
X-Gm-Message-State: APjAAAVE7lj1awdp+/ZS05oweMVDSUg1lKNzc/QArK79XZvIbro167Y7
        u+L6+7D0etVdNjEACfDBSbxK+2pFBn0=
X-Google-Smtp-Source: APXvYqyxUt7OgY79a03D8p7TGyFZofyyrCK1ecCaPNXqbRt3RtdJY0ZSkKMz26lgc7+FIu6EJYDghA==
X-Received: by 2002:aca:b984:: with SMTP id j126mr1830789oif.174.1578655461109;
        Fri, 10 Jan 2020 03:24:21 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 4sm717155otu.0.2020.01.10.03.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 03:24:20 -0800 (PST)
Subject: Re: [PATCH] unpack-trees: correctly compute result count
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.net,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.520.git.1578621570180.gitgitgadget@gmail.com>
 <20200110103729.GA470836@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d9a465bf-843b-2a8f-66c0-73fb706dbfc0@gmail.com>
Date:   Fri, 10 Jan 2020 06:24:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20200110103729.GA470836@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/10/2020 5:37 AM, Jeff King wrote:
> On Fri, Jan 10, 2020 at 01:59:30AM +0000, Derrick Stolee via GitGitGadget wrote:
>>
>>     As for making it into the release, I don't know. The change is small, it
>>     has a very limited scope, but this flaw is also not really hurting
>>     anything in a major way.
> 
> I could go either way.
> 
> This counts as something small and obvious enough that I'd consider
> slipping it in at the last minute if it were fixing a bad bug. But given
> how minor the bug is, being conservative makes sense to me, if only
> because it's good to exercise our release discipline muscles. :)

Perhaps this should be an example for future release windows.

Thanks,
-Stolee

