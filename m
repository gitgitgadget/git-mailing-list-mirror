Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C943EC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 12:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2EF360FE6
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 12:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240116AbhHTMNb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 08:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238179AbhHTMNa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 08:13:30 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C27DC061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 05:12:53 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id x5so7241616qtq.13
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 05:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UIGPGXpV7UfXEHmAv7nUWJ2ihvk8z1nc4WBDeQx0aC8=;
        b=lysR9wa50vEkYLVBn6p+CxxyGbCFB1413i/WKq9H8tnu0cDqCjAjxfVr6TFtAdHEfE
         gV4pnSvVJXWH7qCnv99u9RcrSSSNBtBDjfPTlABdV4hsOj8u+VjcX/9cQ7hUgZVhNVNM
         Q5CvqF/z+UN/JZ2w4YGTSPj9hkzKQcP83dwA3UXcIKyJq7vCodM8ZHy5DrvOBZ4F00on
         YhhSeOxoibmp8qZqo8qv29gpKUWFqoTEP1xENq2phNxATctUOD83PD6Lz2XuTvTi/nK7
         B1VBSdSG/JOH8t+c4+OnhDMhWldD7RH3/rokvHz4C3pbUqck726vPiZ4+1K17KPaASmY
         Mnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UIGPGXpV7UfXEHmAv7nUWJ2ihvk8z1nc4WBDeQx0aC8=;
        b=XaL1WiesY2w56+5h8kQ2PimnFHhB0oUwmhxTzWbqW0a3b3F8dn1cNFHEwTP6J2dYs2
         n3+K81bPtPZHyLPAafO5Pe/YOZoqOgbIYus4zIMIbGZAMSwv330p/rfFwXC7HdBQc9Ps
         H+kGe1PHrPB38768XTW53BKehNGed/op6Fexhb4+n4bWfC5FFcsgJgDhVeGcHWWrMgd0
         /IqPOQvxiGS04u0nEABddYD5+x1bmctMDe7k4G8yplf/un6ZK8/x8N6zqyKk+QXHawn/
         yQAvQtv6KeG3NIrdR1id7fD3EqXKIUKpU+ehiO210CiFs3IhHFtUAtugi6bVIw2kSUZk
         zxjA==
X-Gm-Message-State: AOAM531ZYjp6eY1X0G6qlYN+3HkZ8tI5e89wNErPScDtkhPFW15Nqhi5
        XjmgQ4DRtvh15aNzakxfCxs=
X-Google-Smtp-Source: ABdhPJxKfyq1BqEJRUHHJ4GznonTXEF88TjW/e68F7kfvYqDvvLVGqsfn97EyWtDOV+CtzYvvuzcyg==
X-Received: by 2002:ac8:a0a:: with SMTP id b10mr17332658qti.164.1629461572249;
        Fri, 20 Aug 2021 05:12:52 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id j185sm3210699qkf.28.2021.08.20.05.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 05:12:51 -0700 (PDT)
Subject: Re: [PATCH 0/2] test-lib-functions.sh: keep user's HOME, TERM and
 SHELL for 'test_pause' and 'debug'
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Carlo Arenas <carenas@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1022.git.1629393395.gitgitgadget@gmail.com>
 <CAPig+cT2FfaYBbsRMy7vxXkvsxn4BcFTn4bGJjgvJKznXg1OYg@mail.gmail.com>
 <CABPp-BFKEoHTgdSnUO86zSPYR0mLHv-vUB+Z-SoTtYQbUY4H=Q@mail.gmail.com>
 <CAPig+cRk-BB79+pO83A6Qov9W75_91gzaHY4Le1MYKDUWagugg@mail.gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <53752b7d-c294-9507-a7f0-af2aee491251@gmail.com>
Date:   Fri, 20 Aug 2021 08:12:50 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cRk-BB79+pO83A6Qov9W75_91gzaHY4Le1MYKDUWagugg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

Le 2021-08-19 à 16:11, Eric Sunshine a écrit :
> On Thu, Aug 19, 2021 at 4:03 PM Elijah Newren <newren@gmail.com> wrote:
>> On Thu, Aug 19, 2021 at 11:10 AM Eric Sunshine <sunshine@sunshineco.com> wrote:

>>> In such a
>>> scenario, HOME must be pointing at the test's home directory, not at
>>> my real home directory.
>>
>> I agree, but I worry that it's not just HOME.  I'd think the point of
>> test_pause is to let you interact with the repository state while
>> getting the same results that the test framework would, and I think
>> some tests could be affected by TERM and SHELL too (e.g. perhaps the
>> recent issues with COLUMNS).  Granted, I suspect far fewer tests would
>> be affected by those, but I'm not sure I like the idea of inability to
>> reproduce the same issues.
> 
> Oh, indeed. I didn't mean to imply that HOME is the only problematic
> one; they all are since, as you say, they can impact correctness and
> reproducibility of the tests themselves. I called out HOME specially
> because of the potential danger involved with pointing it at the
> user's real home directory since it could very well lead to clobbering
> of precious files and other settings belonging to the user.
> 

Thanks everyone for sharing their input and concerns. I understand that the behaviour
change might not be wanted all the time, or by everyone.

I also did not think about the implications of changing $HOME that could lead to the
test framework overwriting stuff in my home. I checked the tests and there are only
a handful of them that seem to reference HOME, but still, for those tests it would be
undesirable to reset HOME.

In light of this I'm thinking of simply adding flags to 'test_pause' and 'debug' to signal
that one wants to use their original TERM, HOME and SHELL, with appropriate  caveats in
the description of the functions:

test_pause     # original behaviour
test_pause -t  # use USER_TERM
test_pause -s  # use SHELL instead of TEST_SHELL_PATH
test_pause -h  # use USER_HOME

and combinations of these three.

For 'debug', Carlo's idea of just symlinking/copying gdbinit and/or llldbinit to the test
HOME might be easier, and would cover the majority of developers, I think. As for TERM,
we could do 'debug -t' as above, or use USER_TERM always...

I'll explore these ideas before sending v2.

Thanks,

Philippe.
