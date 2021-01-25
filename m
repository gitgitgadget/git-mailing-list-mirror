Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6427AC433DB
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 20:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36302221ED
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 20:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbhAZE7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 23:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbhAYNEz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 08:04:55 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A535C061574
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 05:04:14 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id j25so9240190oii.0
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 05:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9/w2kW28TggElXb/YmtIQsabgA5kI9g9cYcIEjxB1nU=;
        b=maPuh1A1y+BWnJV/FGpXBnmbPuSRdI7ZPxPsk58+PqxwDn/xUSOrQYinjkwJ1H+EsQ
         nDOhGEzbAVjAc6ov4ux2oxhKVqVIkc9bOWeQausPwuiaK6M/cXX4FIfpFzGuibE/Usc8
         pCKhC5vGq7QyVD018Jz0lIq9larky/+gd6xTMDjsXBhEbd4Pdf1JHfjZMypoCAYBdESZ
         d+8kimHeR4bSytBfxAKAq6p8RG35uhhW9NMycsFIY0It2BlzMRHXnLJx7I6UC+vJEy+o
         sHrMYO0zdXNoaedVQIp5+4ndApg9qlS963wJZT3vfiuh+cOhs5o9cFE21cMd1lSYTsJC
         xvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9/w2kW28TggElXb/YmtIQsabgA5kI9g9cYcIEjxB1nU=;
        b=Q9sdIOyDt3jtqCAmEnYy1V/25UcwunmjFF1KgUPfzHnwJi0sB4gKNRWMv/pK0nF4Q9
         RUGsJIzoe8Thqh0h1CAXJfsZQU8STd+lVtidmCWtoVhSXfrfdg63SkN+MdjdZAOkToFT
         yb4isQyrYLLaUk7FymoXIjtk85SQ3jmpojlWJKj3TyVvA6lttu/reRI2DpmqqbZiwbZ0
         6HxjuZBk832qZzmpSm85VxB/elweSC9jE8lNOsa+3ZECKDksYKx0TBp7LleX0Dx9H4du
         rTAX5MmBuQFKTf9JQiFoyxPLMP5giazQhEjZQ8DeTVEM8jrRKgiJdxkRFB9wmcAOJ86O
         vvqg==
X-Gm-Message-State: AOAM531yqiRxLCmjJbaEcRh3O1mpSh6I9c3PpvoyBWS6InV5xETLm5he
        vfiqonS7VXtEcrqxVogDNbs=
X-Google-Smtp-Source: ABdhPJyQjgxNdxtzUck/7sPjvQYK5Xm3t27UIcpsu8X2ilBLvtcO5Y+Q+wZM1+pdtCgvv8+rYdA15Q==
X-Received: by 2002:a54:4f0f:: with SMTP id e15mr18966oiy.63.1611579853751;
        Mon, 25 Jan 2021 05:04:13 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:9db7:2575:fc11:6430? ([2600:1700:e72:80a0:9db7:2575:fc11:6430])
        by smtp.gmail.com with UTF8SMTPSA id t16sm3059062otc.30.2021.01.25.05.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 05:04:12 -0800 (PST)
Subject: Re: [PATCH v3 00/14] Remove more index compatibility macros
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
 <pull.830.v3.git.1610136177.gitgitgadget@gmail.com>
 <xmqq1retclzr.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a6906459-3a93-ecad-c460-b6c763819389@gmail.com>
Date:   Mon, 25 Jan 2021 08:04:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <xmqq1retclzr.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/10/2021 2:03 AM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> UPDATE: this is now based on ag/merge-strategies-in-c to avoid conflicts in
>> 'seen'. The changes in builtin/rm.c still conflict with
>> mt/rm-sparse-checkout, but that branch seems to be waiting for a clearer
>> plan on some corner cases. I thought about ejecting it, but 'rm' still uses
>> ce_match_stat(), so just dropping the patch gives less of a final stake at
>> the end of the series. (I'm still open to it, if necessary.)
> 
> I haven't read this latest iteration myself yet beyond the cover
> letter, but tonight's 'seen' has this queued near its tip.  I expect
> it would either stay there or occasionally ejected, until the base
> topic solidifies a bit more.

Junio,

Please drop this series for now. I'll be introducing a new series soon
that will collide with it and this is a lower priority.

I'll probably come back to revisit removing these macros, but I'll do
so one builtin at a time when others are not modifying them at the
same time.

Thanks,
-Stolee
