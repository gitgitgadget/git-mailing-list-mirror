Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B509C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 02:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F2F2606A5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 02:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbhINCoc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 22:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236205AbhINCoa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 22:44:30 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BFDC061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 19:43:14 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id f21so4949857plb.4
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 19:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/qFM+D+V5gqZiAt1zb0a0t9OuSAUEfJVlwWerW9V7fA=;
        b=l+o9hw5/oQ4y1UFr6UE+5ip2WLHJjHogsHZSq2s9RrAfd37nwG6B0nVKd5rGS64kyC
         z6+rxn2PAoH1HhJMgI6ydUiJfcRHYfeNeMAoH+NfX4GFdTOhTxNMobVKHKqQejnNNSQv
         9HWPhgC93YRe/VG09Ke0Ub4VdeoxUH1O5La77hkkVFVzanU8nAf3jZHtYUj2C0nM12z6
         SsT+QV2G+pmSVJtiwE7e62s118uyH/Uoiv6qW/v3FyNwKrWT2db3H9YfN8S7yp6hBO/M
         rUOeXYsfdRy8ksmdmBYKwti4EIAyAVkWMckzTBFmzqNlkuCwsssDGukWvYzFJCXhJVPF
         F3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/qFM+D+V5gqZiAt1zb0a0t9OuSAUEfJVlwWerW9V7fA=;
        b=h7Ilo1yStA7+7XSjM/z1u07KpcKh7iRv/MXcOIKIy+NbKcwrBcRv3WyyovVJARhgNQ
         OfR62g7tEAznfuRomBH6OMBebNtIrct/OkJ0kU8MJ8CsbIhLgEcU60wX2xTmYpN9QqJh
         O133evzKwOem+RgArGVnF32VvTjHAF2Vmcam4Zk22Xd7EZH3q8w8aldXrpkqaiF8uemk
         Zo0TtUNS4dtNoc9D79w1wxvADCHQy4H/fyCybrQ4CnhOOrbvJqBeVRntf9F0woleI45W
         Si9alElzSBAh/cV24BVR7u/YJcuc06zwzQ+1JLy6wwMf5VkNryc4k8qNW6qrDk+xyIgY
         5Olw==
X-Gm-Message-State: AOAM532lisPFtKEZU30zgNnQQf6CbwfRXzfHXoSjUWa5Oi/9i3lCAs5o
        VRkfrOrMkGw6gqoq0pHgI5w=
X-Google-Smtp-Source: ABdhPJxwNnV28qsQQ+E+rZNQo3UVitpgRZI1smnuUe3b3NSXrS1fxCLM8Lv3IYlo44hdIRch7Vxzog==
X-Received: by 2002:a17:90a:2dc7:: with SMTP id q7mr2894107pjm.231.1631587394005;
        Mon, 13 Sep 2021 19:43:14 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-6.three.co.id. [116.206.28.6])
        by smtp.gmail.com with ESMTPSA id j123sm8805460pgc.77.2021.09.13.19.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 19:43:13 -0700 (PDT)
Subject: Re: [PATCH] MyFirstContribution: Document --range-diff option when
 writing v2
To:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
Cc:     emilyshaffer@google.com
References: <20210913194816.51182-1-chooglen@google.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <02e15e8d-6923-9f21-8eeb-592eb0c9588b@gmail.com>
Date:   Tue, 14 Sep 2021 09:43:09 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210913194816.51182-1-chooglen@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/09/21 02.48, Glen Choo wrote:
> In the "Sending V2" section, readers are directed to create v2 patches
> without using --range-diff. However, it is custom to include a range
> diff against the v1 patches as a reviewer aid.
> 
> Update the "Sending V2" section to include the --range-diff option. Also
> include some explanation for -v2 and --range-diff to help the reader
> understand the importance.

I think plain "Changes since v1 [link]" is sufficient if you can 
describe such changes well without resorting to range-diff.

-- 
An old man doll... just what I always wanted! - Clara
