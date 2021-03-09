Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB58C433E0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 11:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68EEE65259
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 11:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhCIL6m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 06:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhCIL6P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 06:58:15 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F50C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 03:58:14 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id u18so20268539ljd.3
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 03:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=njOjoNur246TFSj6u4JRcPoZ9GdXPhET/J7D4pAMsKo=;
        b=kqUCdG3mMBgwXUkZUhLYIdJFUTkWoWv0Uv2VCZjNxr1VEu6Fk2Cxmmrh4RRSE0Jtw5
         F+Hqwtl9vkUzbfme9sSCzUSFE3/YPCg4R2HZ2lGD4bDWqdSO4VuxxgKpzCShnQgSjGa7
         Q8KOVIRH7TnWBYGDkJcAFoY7S9GhULwjsKHHP8kuBr5GRI82hCQaoy0Cmzk4I4uj9SFL
         PzwbEuOk1aGmq8LygUTC7bp55SAoJxT//ujHr5XDcRn2DLrZPepu3ucNNK6GduWDvFAR
         bcXUNFsbt58nbkbMNCJfSD51w6hXDJwUh3w3BqUNSGuICvfzNH2scxj2VLKybVzLcPj0
         slMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=njOjoNur246TFSj6u4JRcPoZ9GdXPhET/J7D4pAMsKo=;
        b=LOMdYWHq/MXmBLLViWDQWmoJ47qpIijs6WZ7/+TklDnuhID/b4b+EoocoMjEOVi4fe
         30DpXYzZSoyvbQ5/6Ge45PAEYi2p+2ygvTLuy/E0K0tn1qAv+lV1H1OxP7wmBhqRVyYa
         aO2J8VjUirt2XBKAMxqq1V0w0hi/vU2qHGUJLyPu6D2c51kHQ71dsX9EU2C7041uk0i3
         NCZL7tkDVmQnbVMus7I9locBQpGxmrvjU9VLDHnyqAPairQhQ342bLx2MhcSKPw0AVGW
         R/YaJndZmI8goLBiF7V4o6auSFQtLgMdkZw5s3DiC5gZU45E7vnKeVSjPOlW7RQISzrf
         YJXQ==
X-Gm-Message-State: AOAM530bOrkeA1fso0rHIgAMrvB//Tm2wOedYrd+wbqd6VXYSnE2DMi4
        BdgBzo0m3Kzr5M9SWcIVeHkoUHQ1idRwArMM
X-Google-Smtp-Source: ABdhPJyNG6ZaC7fQyQ1Fs5Hi0znViW7EyDwEh44QtrILMocZQqJQZ9qTVmOJs7RZokIM7AT1gnfcew==
X-Received: by 2002:a2e:b0d4:: with SMTP id g20mr16829596ljl.127.1615291092847;
        Tue, 09 Mar 2021 03:58:12 -0800 (PST)
Received: from [10.10.40.23] ([198.20.116.72])
        by smtp.gmail.com with ESMTPSA id v22sm1747683lfr.277.2021.03.09.03.58.11
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 03:58:12 -0800 (PST)
To:     git@vger.kernel.org
From:   "Bagher Keshmiri (Gmail)" <bagherkeshmiri@gmail.com>
Subject: windows git invalid path error
Message-ID: <b524f3b3-b1d2-b8c3-7209-38d81c9cf646@gmail.com>
Date:   Tue, 9 Mar 2021 15:28:08 +0330
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hi
i need pull changes from my gitlab project to my laptop but when i run 
git pull show this error

  fatal: cannot create directory at 
'public/C:\wamp64\www\exp2p\storage\logs': Invalid argument

