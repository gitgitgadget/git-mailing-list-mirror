Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EB0C433E0
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 12:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91F3061606
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 12:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhBSMSd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 07:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhBSMSa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 07:18:30 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39D6C06178C
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 04:17:34 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 12so2831319oij.6
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 04:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=no/l+xdKbS7/Qy61GWcr2Mz2EiFJDP+GfRwv32OQ114=;
        b=sNOpXyyQpMbidHXcZNwORFdI0HotYZ26Af8keZVYLWT4xnUhY6hboTkaqWXSA0KRTd
         jqzh0zNg7/cbT6mH6boJY5U8T0pHP9PGvxb3qOnMCJ5nLzLy3rUPaqEY1EPCzN6hS/fY
         o/Vbuzo5OYc0vz6QX8pZwAxBGph3+eqoraBp2SFxunspjbM5aZCVluM+FLn3fPHwGsP4
         rf1I9FvmivOsEF5eNITyVUmB+ZmDIMkTjyguaSShzPRBbYuIRqWdnhcoV3P+dTySKWaj
         r/2LgrLrZQGt6VAGCITRMy3bJQb8FDZLB47BStr3fysLHdRVv12XvEzXt8lovW7uZPeA
         gYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=no/l+xdKbS7/Qy61GWcr2Mz2EiFJDP+GfRwv32OQ114=;
        b=cBX3g7HcYP0r2a4SmGmVjfTO718fJXiqZNHQ3x8gQyyO7aa2wq5h/gZJ4j2E3KvKQO
         kc3VSz95gF0bzuAEVYgovOou0KKKoq9fTyqe60T89goVHWb63D9S5aJH65L4mV4PTD/I
         IQTnyTy2fOSxDgonH0FP++8M0XKRu/bpKQ5XtmMOPCgoeYe6kn+rol/e1w4Mgmd7kfbV
         lm6wRE/sIKZR0HNPCsLhvPBrNC6tCeNXl3YsUE0+7P0kEOgtcEiQ7mjSdivWm9qRNT6A
         gaHtW2E50FEJpwzmULyP2ltSw5951Tf9jjKOh8oP+4TxbC3OG/QToft7wuNX2NCMvO1X
         BC8w==
X-Gm-Message-State: AOAM533JIuJbMigI679xme4Z+d1sYkVpXfMEp32hvm4NW13AnD2As1bB
        QH+5szfBeo1C7Ctd40Y8dUI=
X-Google-Smtp-Source: ABdhPJxn54UN2Ysv/NJSdRAzWqmqJMuzK57alXrX8YEw2uD6K4oKi102sJjaPk3ZPRITcZkdpV3J/A==
X-Received: by 2002:a05:6808:258:: with SMTP id m24mr6364911oie.132.1613737054306;
        Fri, 19 Feb 2021 04:17:34 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:8d41:9e8a:93a7:91b5? ([2600:1700:e72:80a0:8d41:9e8a:93a7:91b5])
        by smtp.gmail.com with UTF8SMTPSA id l18sm680256otr.62.2021.02.19.04.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Feb 2021 04:17:33 -0800 (PST)
Message-ID: <4ca2931f-3e3c-12d5-e12a-6c63699a98d7@gmail.com>
Date:   Fri, 19 Feb 2021 07:17:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v2 0/5] Speed up remove_redundant()
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        me@ttaylorr.com, peff@peff.net,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.852.git.1611851095.gitgitgadget@gmail.com>
 <pull.852.v2.git.1612183647.gitgitgadget@gmail.com>
 <7a1a8990-59e7-d538-d382-446fdc270810@gmail.com> <xmqq8s7lc61j.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq8s7lc61j.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/18/2021 6:25 PM, Junio C Hamano wrote:
> This topic seems to have been forgotten?  Is the only thing missing
> is an updated 2/5 or is there anything more that is needed?
 
I had forgotten about the comments on patch 2/5, sorry. That explains
why it hasn't merged yet...

I'll get right on it.

Thanks,
-Stolee
