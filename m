Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E125C4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 11:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FDF0613D1
	for <git@archiver.kernel.org>; Fri, 28 May 2021 11:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbhE1Lmo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 07:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235737AbhE1Lmc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 07:42:32 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47C4C061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 04:40:57 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id i67so3740858qkc.4
        for <git@vger.kernel.org>; Fri, 28 May 2021 04:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=OQbvnU6s1t1vb13nhxPB3Honq1mGw3qe8yfJtztUu/g=;
        b=V9MRZXZsR0+GFsHVtNGdDcjQGkX6PCG5zHmE3Pll1z8eNKy88O2Ao9AybczRnsSwva
         qox1Nf2TvJVGAZ4+h9EBWi8SgUzOiomPorcDw/VUOB9AtuylWmu6yO7l1SSAuFNNgCWX
         UVp31sE/ySLtPEgvjRux04NTU+VvnjR5i+ss62rKDTPT+RsFclqTr5o4Lwk44rVoTDM7
         Xf3Vvox+CovlWVU2Yea5ds70fG8UHa6utm8FL1bDDBddXrlwQ1YEmAJQgBcDzeFqRGmt
         L8heyAQH+/6+woT//sHi7311LqoFR7iatBgieOAycguauK7Sx+vQZoe19pwxL1CyDIYP
         ph9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OQbvnU6s1t1vb13nhxPB3Honq1mGw3qe8yfJtztUu/g=;
        b=a3MJH4cQOpJTHWQo2+XYmALiJ5kDmdUoH15TdefPrvgiR0vIAct0cfKc558HShtMPD
         q4vbLM3CzOUr1d1vEICnWNIJQjBWmDokr9AY2QUA5bjrH3eimE8lz1B9xt+rZYSlVGPc
         dYJk6+pRjEFtaWCUHnhgDIHTFuGxhfByjQ2kCFQk4NRUj7LEO9ZZwnLLknUDM184sTwY
         k4oXHxzvzQ+46iHJjIyjzC0D22IedgPbSNv3YVSp3yHglgDIdxbtaY/YbvzLjt4K02aJ
         DdCwswtcx2KAexfsk5sf7fYZx/GC1BYkczF9ojM1ZMu4K7Z22L4ZXnaYTolf7hoJDF2l
         2jww==
X-Gm-Message-State: AOAM532am4+YOBvyKpkkFEq4GJiwUSDCytA02ZVx/L/XJsgH+LPE9Zv0
        fivJ44EV4bFc3wy6vp+0qyJcrUWCxoJ6NQ==
X-Google-Smtp-Source: ABdhPJyrCSgL5LXEdGguW5ML9ULyDq8VEykFaOjSvQmWQyw56kz22iI0I7/3Qv3Fi07brLor1bDaIw==
X-Received: by 2002:a05:620a:133b:: with SMTP id p27mr3340597qkj.354.1622202056606;
        Fri, 28 May 2021 04:40:56 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:f45c:45ae:1e9c:923a? ([2600:1700:e72:80a0:f45c:45ae:1e9c:923a])
        by smtp.gmail.com with ESMTPSA id x66sm3298475qkb.61.2021.05.28.04.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 04:40:56 -0700 (PDT)
Subject: Re: Fetching single tag in shallow clone almost unshallow the clone
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
References: <304633fd-e677-7956-6787-f60f195db9b5@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d641512e-657f-6dfc-adf4-1b1889439553@gmail.com>
Date:   Fri, 28 May 2021 07:40:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <304633fd-e677-7956-6787-f60f195db9b5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/28/2021 3:03 AM, Bagas Sanjaya wrote:> But when I fetch a single tag which the commit the tag refers to isn't already on the clone, Git fetched almost the entire history (thus almost unshallow the clone):
> 
> $ git fetch origin tag go1.16.1 --no-tags

You should add a --depth here, too. Git doesn't remember that you want
a certain depth, because that doesn't work in perpetuity.

You are hitting the issue I documented in my comparison between partial
and shallow clones [1]: The commit history for go1.16.1 goes "around"
your shallow boundary. See the image immediately above the "Comparing
Clone Options" section.

[1] https://github.blog/2020-12-21-get-up-to-speed-with-partial-clone-and-shallow-clone/#user-content-shallow-clones

Thanks,
-Stolee
