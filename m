Return-Path: <SRS0=BZy3=CN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD6DC433E2
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 12:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87D192137B
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 12:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAiFDQRB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbgIDMTm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 08:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbgIDMTj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 08:19:39 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FA2C061244
        for <git@vger.kernel.org>; Fri,  4 Sep 2020 05:19:38 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n133so6003637qkn.11
        for <git@vger.kernel.org>; Fri, 04 Sep 2020 05:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wuf/zwckl8PXFIkDCljlsO/RXjdCYc+nWbjDyadcpBM=;
        b=dAiFDQRBfEo3KHigeRBskQsaX1VBGt1GeJUlNK91SnnMqR93Lkk5Mel3lxQr869qjw
         t1e1PMJmOLbpuwrIs1PGN38ZqGLfG+qOA+SgKQElB99dvynoTwes4zgElRbK8qgUBHHB
         bMAIl/HFg/pBoyTbcueGFKZ3Dg6BeRs63Upe0GJhqr8rbmXleUyhachNco/izheBx4xl
         qvWNSX95oqhOlbktXP1/Tt8Bu+uLfqlxmuF3aw0mWQI5xJokctIoB2MaJjuOFyxsKjPJ
         ydlRxuq50oKTTtZgoH9S82dtrZ9h9wevN3mGUpHvPsA7cFt/rMiH6gVWeHRbNDJ2r5JV
         Gc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wuf/zwckl8PXFIkDCljlsO/RXjdCYc+nWbjDyadcpBM=;
        b=oPcjbeiWguxu+qUpgHTVHO0Wm1v19ycxD5BFarhVaNUHIaqKC75xi1vCooO/vnt9Ms
         DLrkwDeqxX0w6JPeogiJiWxOwo3QxXueHMYyZOpQA48UCoDxN2jpcMfDnbDlGI3vKqNK
         rFCoAr/EEJdr09Ah03OkxbXGtrQmaO9vJtn/1DcMWKxoDMrqUKhiTDsDKOlibHp+K/jo
         9oRteYixwnnnJSq7A8N1VEYrv31GdJ47YedYCwI+/5jOQO02zwDyQ0h3nal0jHp3mw87
         9VZTZa0cdkqXKr+pUDnstKOclQ4BDZE4fsA0UYjdxdOGmGOwaeg77sgY1AthWiZHCQWs
         exFw==
X-Gm-Message-State: AOAM531giAdMT9QNKNDSfjgZRqDG4nMnhx9xodSjxD03jL7MRhDyd419
        T5ZfDtZ5dK5h0StpU0gO37sI3DdiTlM36g==
X-Google-Smtp-Source: ABdhPJxvxJWhfrNL8BlV87VavpIvrYo22TUjhvW9hP/heINAX/mVyAluVdASM4ex5vuYIEhnR8x5Jg==
X-Received: by 2002:a05:620a:13f9:: with SMTP id h25mr7234267qkl.283.1599221976631;
        Fri, 04 Sep 2020 05:19:36 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:5990:be8:9229:d426? ([2600:1700:e72:80a0:5990:be8:9229:d426])
        by smtp.gmail.com with ESMTPSA id x26sm4271048qtr.78.2020.09.04.05.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 05:19:36 -0700 (PDT)
Subject: Re: [PATCH 1/2] revision: use repository from rev_info when parsing
 commits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Forney <mforney@mforney.org>, git@vger.kernel.org
References: <20200623205659.14297-1-mforney@mforney.org>
 <88d8b24c-a0ae-bbbf-dd1f-5adb7a36ee95@gmail.com>
 <xmqqzh667ca4.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <181e95c7-8b43-e548-7fc9-36fca140645d@gmail.com>
Date:   Fri, 4 Sep 2020 08:19:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
In-Reply-To: <xmqqzh667ca4.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/3/2020 5:58 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> On 6/23/2020 4:56 PM, Michael Forney wrote:
>>> This is needed when repo_init_revisions() is called with a repository
>>> that is not the_repository to ensure appropriate repository is used
>>> in repo_parse_commit_internal(). If the wrong repository is used,
>>> a fatal error is the commit-graph machinery occurs:
>>>
>>>   fatal: invalid commit position. commit-graph is likely corrupt
>>>
>>> Since revision.c was the only user of the parse_commit_gently
>>> compatibility define, remove it from commit.h.
>>
>> Is this demonstrable in a test case, to prevent regressions?
> 
> It appears that Michael tried and failed.  Even if we do not
> currently have a caller that asks these functions in revision.c to
> work on a repository that is not the primary one (i.e. in a
> submodule), in which case these patches may not be fixing any bug
> that can be triggered in the current code, it is quite obvious that
> these functions misbehave once a caller starts asking them to work
> on a repository other than the primary one.
> 
> So, given that ... 
> 
>>
>> I counted 9 copies of parse_commit[_gently]() in my version
>> of revision.c, so it looks like you caught them all.
> 
> ... we should be able to proceed with the code as-is, I guess
Yes, I think this is an improvement regardless.

Thanks, for the reminder.

-Stolee
