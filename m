Return-Path: <SRS0=ERGy=7M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D36C433DF
	for <git@archiver.kernel.org>; Sat, 30 May 2020 14:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C58E20723
	for <git@archiver.kernel.org>; Sat, 30 May 2020 14:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ta9DAkPa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgE3OOw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 May 2020 10:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgE3OOv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 May 2020 10:14:51 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDDFC03E969
        for <git@vger.kernel.org>; Sat, 30 May 2020 07:14:51 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 5so2738408pjd.0
        for <git@vger.kernel.org>; Sat, 30 May 2020 07:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p+CImnV+jvaukc26bhOMMzKVJXj8nscds2guYmrdr6M=;
        b=ta9DAkPaRI3A1ai+ruCiePU7PPRxpVIAC7CvToEdZhGVFwLErPE+YnB+rUTxtL6qsA
         +txPyJnsV0/N0Dt209l5ofD6b9Y871Kuzwh1jdILm3WfHGm7aAQLIa59O06ELziWPoyA
         Wq+XFXNOO2s/XcptBGsEHN76tnPcNSyud1Zrldvx9bfS2j5QlF4SUw3zZOnE8tlCu6Uo
         4rFOH4zsiyunXkb05a4q8pOYggrxQ88keFsDF3sTaPvwqsbFIKPTHf41LBUux/eHUGM9
         xrV1PFo8BSu9XTMT3/FQg1H5cWM1J3Pl8X1hrXIOR0hfCMrnOSHy2vDzVz5vjfUFhQrq
         fChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p+CImnV+jvaukc26bhOMMzKVJXj8nscds2guYmrdr6M=;
        b=pi946trtTMgF3SbMA8Rm9CW/4R0I39Pf+uL30Us5gdpj/cQ/3uWzhIk+eHjYjJcrv0
         HO7pFEd4oxjwb3/cqOqZeipbboK6P0n/zHLjFYzdYFm8zILnfj7jwlU7govnC417G5Hu
         3aMFz7Ml+iaKLIV8ZhdtaZJRkbAzDPPggFnH3yVObEHkKeZDmJi7xHroNaCdwjZTb/lf
         mOHa2fPtOfdslSEIOiL1VyBcVD5xY4Q7l3BbPpZdbinMhOTCUq14AFAf/xKElbYB+qex
         Fc/V0CLP2WkiZwVblO+awaqvi1I+up2lUhkeY0Apv4JPAYKSi4jDcdpt6ilj5w6D6Lo1
         M5cw==
X-Gm-Message-State: AOAM5306oGXZFJiMn1xGv4MqMNsdCz1q3jPGiLGIIglH9X87xzttObJf
        zN0ANBftOpAwUjQvFvHaH4Y=
X-Google-Smtp-Source: ABdhPJw3ca42PtuXn8P/njwy4oL3dYvze/wYuASVoVkZ5JNDE0Jbe/0pveb9ydvfr1hb8q6Tfygkow==
X-Received: by 2002:a17:902:6a84:: with SMTP id n4mr11616633plk.3.1590848090944;
        Sat, 30 May 2020 07:14:50 -0700 (PDT)
Received: from localhost ([2402:800:6374:cd6f:3908:64aa:a24d:1be1])
        by smtp.gmail.com with ESMTPSA id n19sm989476pfa.216.2020.05.30.07.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2020 07:14:50 -0700 (PDT)
Date:   Sat, 30 May 2020 21:14:48 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Sibi Siddharthan <sibisiv.siddharthan@gmail.com>
Subject: Re: [PATCH v3 8/8] ci: modification of main.yml to use cmake for
 vs-build job
Message-ID: <20200530141448.GD2151@danh.dev>
References: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
 <pull.614.v3.git.1590759624.gitgitgadget@gmail.com>
 <bb329d16ce0999e198addf83d56f75762c830e1f.1590759624.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb329d16ce0999e198addf83d56f75762c830e1f.1590759624.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-29 13:40:24+0000, Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com> wrote:
> To check for ICONV_OMITS_BOM libiconv.dll needs to be in the working
> directory of script or path. So we copy the dlls before we configure.

If ICONV_OMITS_BOM is such a troublemaker for CMake,
I'm fine with not supporting it at all.

It seems like noone except me have interest in ICONV_OMITS_BOM.

> @@ -302,4 +308,4 @@ jobs:
>      steps:
>      - uses: actions/checkout@v1
>      - run: ci/install-dependencies.sh
> -    - run: ci/test-documentation.sh
> +    - run: ci/test-documentation.sh
> \ No newline at end of file

Please fix your editor ;)

-- 
Danh
