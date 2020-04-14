Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E6DC2BA19
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 13:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01A8020768
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 13:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glXM//+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732733AbgDNNmP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbgDNNmK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 09:42:10 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE969C061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 06:42:09 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id m2so12819617otr.1
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 06:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/cp/F9NaufjiEOJrV9/lS/HaDQVGgi5/OLHmay1WT34=;
        b=glXM//+6nMrKjr6rncyDpAj5VHiAoF7a1w8U8uVL4v6DbLZIaNOgVFy6+T8yEJO0k3
         DXGX/7a2Oo/LKZmkRetlHFMMNQbc7ZUq+Di5pyIFCiRSfOpAHWxaRvLwHD07INEPCWEy
         r5qWXaEJx4ENP6e2QTzzdH5pw3eo2p5d1oIgLFMD/37FWnNFxN4t2kugDrzryXSnO0pr
         y0YGMZefSZETQdFQX3xlagnvJZT7SKXzB4gTjrrHXgdN8BSXvd8fISbNwa5A3Qn7z73L
         2bY+2jldVPnpqNpqZ9zzMn7qX+3BCSfDJOnSTnMa8NtCIM6lthZBk4OvYHvXkIB6fMIO
         f1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/cp/F9NaufjiEOJrV9/lS/HaDQVGgi5/OLHmay1WT34=;
        b=bPYDD8vbC4M58JHiyP5WoYZFDSTWXnGyVZ7rUyqzlUYK2+8+Srn4RovGvkLbo7ZywM
         n1aklRT+5WgQu+wnTwtVmPfHAu7zSxeQXB3xz6xZnmDL80730jnKUw2ZQPCqqGxikyB8
         9Er5J1NIAJKxQj3DIav049INnWEFJQWqDnWDHVPq/o/OfeSbzuEeZ6oQTavK6xhmUPsW
         AJVFNmw/3+p6dB8bI1T5NEqweyfI7Nm5TFDWrwXgldxpSRSNm0EIR0uHSR9O5ed4FL/3
         RWPqlfjg5/Ul+iiQd6L8WIvYZn6gfF7moBwzJJJ9GtPg1/zQdR/K43pVqTwNLigXCuG+
         5aOA==
X-Gm-Message-State: AGi0PuZKbsblPdjNj9fE0U8mm2iYlpQuR2mZJtGWV+NBrrkyznk6+ehr
        ZK+kwy7vd/UsoF88EuOALN0=
X-Google-Smtp-Source: APiQypLSU27/Q1rzMRyi6KgIziurYn8MVbkxIScSE7+7zHa9mlJoCIK3XOv32BYFJpMV5zoiLK6YRQ==
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr12503401oto.265.1586871728860;
        Tue, 14 Apr 2020 06:42:08 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id k13sm4345518oou.27.2020.04.14.06.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 06:42:08 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] clone: document partial clone section
To:     Teng Long via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Teng Long <dyroneteng@gmail.com>
References: <pull.745.git.git.1585792946341.gitgitgadget@gmail.com>
 <pull.745.v2.git.git.1586791560.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <90b62982-2e91-9846-e6c1-fc25016456b8@gmail.com>
Date:   Tue, 14 Apr 2020 09:42:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <pull.745.v2.git.git.1586791560.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/13/2020 11:25 AM, Teng Long via GitGitGadget wrote:
> Derrick Stolee (2):
>   partial-clone: set default filter with --partial
>   clone: document --partial and --filter options

I believe these two commits got submitted by accident, as they were in my branch before and then were removed based on feedback from the list [1].

Dyrone: before sending your next version, please eject these two commits. You can do this with "git rebase --onto HEAD~3 HEAD~1 <branchname>".

Thanks,
-Stolee

[1] https://lore.kernel.org/git/pull.586.v2.git.1584906606469.gitgitgadget@gmail.com/
