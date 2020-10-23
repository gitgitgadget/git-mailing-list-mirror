Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC49BC4363A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 17:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54E6A20EDD
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 17:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dw6UHPuW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461602AbgJWRc4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 13:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461541AbgJWRc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 13:32:56 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2138AC0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 10:32:54 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j7so2914986wrt.9
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 10:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3k+q4zb652o8tirgYjP5kSwj+KlVf3mVWsGoQnJiIgQ=;
        b=dw6UHPuWaMT4yQcysO3FcuiQl/4ShCLaPXMz2q4no37H1/c9jWmxFlEVrQ7/T5wPHP
         Yqpwlh5Afv3fsdC6Nxamzfbc3mrt7I+HsoNGS0VlquX6McSF2BHHr/j21qtf6fu8LhzM
         rHPibIAP25JytMJIG//HzbBu/35bjJg+REf0meyjIK34EYPyVzwJjKpf9P49Re9uLdTi
         KpkxI6njk2Fj/lI1CtJJZbOOpnXqxROjQOJuqeCr5uJ5ptoVF+60PDmkneWIjEzt4IO0
         SDloJcF8Yl1grPWw8fkoMF7IJgv1i8uDbr3cZr+MsG3sOjdQ8tDC/j4PzaxvG/xS6dZe
         W19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3k+q4zb652o8tirgYjP5kSwj+KlVf3mVWsGoQnJiIgQ=;
        b=rOFGMLnyvZCc9LOw0DucfvC8qnKsUYWOG8n+1SYW92VpSV1rT8dDhs4eIMKii2pt4W
         H2bWfZGBHQUPfx46F7ZBJs/DSrL4A2yPe2XT2ro7SN45RWJ8D2AjAgMgx6t4Z5IjweRo
         IAnfZNfdGs0BWTY7lK0EvV9h5OhSifEpymGaxXv0YJhavVryaj6k0r+GGZdDhhkVMb51
         912uzDrrI7x8VIbSndSbaAaPo8a+LtfsnlvZzFnFG84jGXGaH8wqCqoTWA3hdo4kJHhg
         DWXCdDddxSsL2pCc6SrcPu8ddivj5z2uCT17dTISFZFcG+5qqMPYn0p++jY7/QKcykvr
         yHxg==
X-Gm-Message-State: AOAM533IgKSUnOWNzRxNTmU4iCvtPtuS9BYbAfSAoZwLkz0JPvkcyU4b
        25mXc9rw2h+IrDNi3xSH9wMQCZE3dB8=
X-Google-Smtp-Source: ABdhPJwd9/hmGrb4q2bPOJBzQsGkRtT5LYa4fsoPkh4MDpR12Jsh6hb7ga9JZoDei/9QAsiTcWBXiw==
X-Received: by 2002:adf:df03:: with SMTP id y3mr3730200wrl.70.1603474372588;
        Fri, 23 Oct 2020 10:32:52 -0700 (PDT)
Received: from [192.168.1.201] (13.45.90.146.dyn.plus.net. [146.90.45.13])
        by smtp.googlemail.com with ESMTPSA id 1sm4923597wre.61.2020.10.23.10.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 10:32:52 -0700 (PDT)
Subject: Re: committer-date-is-author-date flag removes email in "Commit"
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     VenomVendor <info@venomvendor.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
References: <e08df0d5792ab70a9158be32cfa28696@venomvendor.com>
 <20201023070747.GA2198273@coredump.intra.peff.net>
 <xmqqmu0dhsoz.fsf@gitster.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <58e83ad2-14a2-5ace-c1fd-8224625a0f97@gmail.com>
Date:   Fri, 23 Oct 2020 18:32:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqmu0dhsoz.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/10/2020 16:23, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> On Fri, Oct 23, 2020 at 11:18:51AM +0530, VenomVendor wrote:
>>
>>> What did you do before the bug happened? (Steps to reproduce your issue)
>>> * Create empty repo using `git init`
>>> * Make few commits, at least two
>>> * execute `git log --format=fuller`
>>> * Notice the log, with "Author", "AuthorDate", "Commit", "CommitDate"
>>> * Note, "Commit"
>>> * execute `git rebase --committer-date-is-author-date HEAD~1`
>>> * execute `git log --format=fuller`
>>> * Note, email from "Commit" is empty <>
>>
>> Thanks for a clear report. I was able to easily reproduce the problem.
>> There are actually two related bugs here, and they're both regressions
>> in v2.29.0.
>>
>>    [1/3]: t3436: check --committer-date-is-author-date result more carefully
>>    [2/3]: am: fix broken email with --committer-date-is-author-date
>>    [3/3]: rebase: fix broken email with --committer-date-is-author-date
> 
> Thanks for taking quick care of this.  It counts as an embarrasing
> brown-paper-bag bug; it is a bit surprising that nobody noticed it
> while the original change was discussed.

It is indeed embarrassing. That change only appeared in the last round 
of patches and unfortunately I think most people had stopped looking 
them it by then as their comments had been addressed in previous rounds.

> I wonder if we even needed to do the original change to begin with
> (stopping to export means not giving information to the hooks), but
> that is a separate matter.

I think the main motivation was to stop polluting the environment of 
exec commands

Best Wishes

Phillip

> Will take a look and queue.  Thanks.
> 
>>
>>   builtin/am.c                   | 4 ++--
>>   sequencer.c                    | 2 +-
>>   t/t3436-rebase-more-options.sh | 4 ++--
>>   3 files changed, 5 insertions(+), 5 deletions(-)
>>
>> -Peff

