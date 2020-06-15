Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37F3C433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 02:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92D7F20775
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 02:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXdaOnWF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgFOCy7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 22:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbgFOCy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 22:54:59 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FE8C061A0E
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 19:54:57 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id n11so14450416qkn.8
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 19:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=CpN60PkghnXIfkUJL0jrmSnA3dRpyhyrlxL3/64QmSw=;
        b=ZXdaOnWFsZN3H8gUdlZGZJMHSoN9xvrt8Rhrxka/q8O5XKXBmFwdYeWBEd9mMDRC5u
         R4QmFPU0BihiS7oZekfCj5wPBqUc7/e89kuCN/oBv4dnt26fq8q/SNbaZ0TTxYFfqQWc
         wfxin8WIZBWZkIbCEDj6R5LdAb4bL1eCQNr7MSWENfk5SpGW9PC5a4BUqF1EzjdTSeHm
         R9KLR1BUafbsaUhXgCV6n6PTx/GYxFOJfN6IoLpvUZRkInYZNKFJWr/WKQlFoBOG/q+Z
         3i9O0VR+UAuxQlU7pdTmHgQs4wHDRk4TUBncDtnvxxWSyMODeZzS3neP3lww6xtGjXhC
         hlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=CpN60PkghnXIfkUJL0jrmSnA3dRpyhyrlxL3/64QmSw=;
        b=kW5Lp8Ks/ZV6IXddw/2juPVWPZgd47QFezuG4IB2dQfdiiudEz/uP2fNRsB1J1BW2K
         t8VoAWr00129vr0gMyO9BtVY80ATV6A8ZA87LSA6UmRMqgtrVDr+QQiNSBcDREO372JM
         LaMYTtMqCKOWAKIUz0hBodQxNr0kOUVezQH5yevKf8v7c3pB6D6OOdpOUbNEraaPx3uH
         o38AUoVWRejy4hXfz2yhRmGms694ujgPRU4Tg11O4BaJLWPe1nX/ZDMVpeyldqS6/8Pt
         EZbAxWPJxe4ZvTqfmAc3C//g1HM39z45bIBHza/oo8WKFebbGWWJxLL8e7IOfbobPvI9
         x6mQ==
X-Gm-Message-State: AOAM5313vWOavxZ9kMfTbSuzd6EuaiccWQez6jFpmuasKYZHC2gBOO4P
        qQjSEa4FOrbYI32x9MTuYxUkJeGrFdA=
X-Google-Smtp-Source: ABdhPJyrLtEGXhP4TxMmyRf9s1uN0i3UrAFptlAbwtiE0fO0RVkNeG1iCUhQQeBY6ZWLLeSNfamDHg==
X-Received: by 2002:ae9:ef0e:: with SMTP id d14mr13383238qkg.416.1592189696118;
        Sun, 14 Jun 2020 19:54:56 -0700 (PDT)
Received: from [10.0.10.179] ([170.79.184.212])
        by smtp.gmail.com with ESMTPSA id o33sm11113739qtj.44.2020.06.14.19.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2020 19:54:55 -0700 (PDT)
To:     me@ttaylorr.com
Cc:     don@goodman-wilson.com, git@vger.kernel.org,
        sandals@crustytoothpaste.net, sergio.a.vianna@gmail.com,
        simon@bocoup.com
References: <20200615021659.GA67624@syl.local>
Subject: Re: Rename offensive terminology (master)
From:   =?UTF-8?Q?S=c3=a9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>
Message-ID: <8cba07dd-838e-6e36-9d7e-e619fd306838@gmail.com>
Date:   Sun, 14 Jun 2020 23:54:52 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200615021659.GA67624@syl.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

And how many people care about this meaning? 1, 2, a dozen? You all keep 
forgetting this will disrupt the workflow of THE WHOLE WORLD. Why don't 
you run a poll? See how popular this would be. See what would be the 
odds of a fork happening. This is NOT EASY. Also, is still pretty 
telling the vast majority of people here are white, rich and american 
but love to speak for the poor, oppressed and blacks.

