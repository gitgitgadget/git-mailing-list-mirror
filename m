Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA409C433E0
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 23:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC74220825
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 23:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9v1ujy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgFMX5B (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 19:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgFMX5A (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 19:57:00 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752FDC03E96F
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 16:56:59 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id f18so12574765qkh.1
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 16:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=MCWgztMISq8fDS0A8rZ1TThgz6S3sYm8S9gmXqAuhH0=;
        b=k9v1ujy6yGDEJ1FOrtSTRI+iSsVuZPsfB2Lm93WUBG7sePJrONBZfKOaYw1KF+YoQm
         4sA1oSbbYwOxD2T5NG9zjjV9WxAHUjyoXwfWn0X8bN5skB4oivG74mh0EFxH1W6td4Ql
         0eTpVHWhyFx8S0VhffBKebeLKOSX25Vyt3lTyEp63VFBbZ2TfO/UuiVIYNurpM1GZRAG
         r8gzxiiHcsjCImCgNSfA8PRn0aYbrBgiDcGG4aVbAaQOZTf4JgEX6GHUvSpO6u4IUfRa
         s3fFZpHIa7Yg+a5DH4wBrHS325LXqpA0ibXIucrQm+vzMPDWFKZi8QPPfl7hATICwBuJ
         k35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MCWgztMISq8fDS0A8rZ1TThgz6S3sYm8S9gmXqAuhH0=;
        b=ecj+Zrnyxc3G/8g8GzDOYOdDpxG1ncP+wtxq651gK9ZyLOofknvu/bMXwj4sjLyNCN
         d8BAHX0dcvtxxYkOBeq8fW28KYmdA4t7byhvc8oD5U/y6AIQ4QY9l6pBxuoJ7pamh4eK
         SSbANeqPNwFCZSrNawDST/zUBSVUi0VqwXeyRThQhmCo0D2tjCi2BP3olD85lJc3Zis4
         I1OfLDaokmQL2D5ddFnKehp2l/K5+Pkjuf4fDYC/9UWmCztACElAmfByHoSWeZ3onxg+
         HzwdiivwVrCTPJIatfUbYmvcOcmNMPcuox0DkieHeXG0y8AFZ6vX9auHQHlcfT+RiXkB
         ZtXQ==
X-Gm-Message-State: AOAM533F1BAHo6XSJlAGYR4FbfrPRD1btu1CA65uagjCRRHqP2rGlsYV
        e871z5/JUHpCq9vfXTdBvwkH7Ls8KsY=
X-Google-Smtp-Source: ABdhPJx0mSrvV7Z9lSFGaL2TWl7jlslhTSZzwHvHhpjQ6QxznodKs8vkzceNAY1cg+nmtA6gcNFZvg==
X-Received: by 2002:a37:4852:: with SMTP id v79mr9112536qka.132.1592092618221;
        Sat, 13 Jun 2020 16:56:58 -0700 (PDT)
Received: from [10.0.10.179] ([170.79.184.212])
        by smtp.gmail.com with ESMTPSA id 130sm7416749qko.113.2020.06.13.16.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2020 16:56:57 -0700 (PDT)
To:     sandals@crustytoothpaste.net
Cc:     git@vger.kernel.org, simon@bocoup.com
References: <20200505231641.GH6530@camp.crustytoothpaste.net>
Subject: Re: Rename offensive terminology (master)
From:   =?UTF-8?Q?S=c3=a9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>
Message-ID: <ae1d72d3-ecfb-f2be-5a68-486c159f0931@gmail.com>
Date:   Sat, 13 Jun 2020 20:56:55 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200505231641.GH6530@camp.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There will always someone that will take offense to literally anything. 
It's absurd to try and sanitize everything with fear that someone, 
somewhere, someday will just get offended by something.
