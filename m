Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43829C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2626961029
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhHQRBM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 13:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhHQRBM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 13:01:12 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37D5C061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:00:38 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id m21so5942760qkm.13
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7F3cVN0Qxzhu2kkvBN034LBLwFFdP0RXME4DFiNL+FY=;
        b=JsqD91m3kRA3uk8OknTLta1uROxbmWOHdDE7JFMvJdOAnuKnZEr+wMQiwCujAA8n2W
         muXfBHkgYKCjDN2wGp3j3ynf6wGNXTdRzUfflRNQjeWCXWe+JDX81QR3HSdZjJlsaGu7
         8SoJNWQzyq1mC5LhN/pxT8/ZNQ9EFKimezLVloHRjGx1NDn12I4Slit3po1o54XmmlUq
         BTy+/aXwo2o3yfHp0QRHcqGigRe6bOO8zYzvjUkJToQLDoygronfYSu8AaE8XcCi207m
         dnuOEbWNbofgFKCUgaqhUOJLYLHGObxwRtwfgNeIhnDG9Cg9DxstOiQGr9oltSJjT3TL
         60xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7F3cVN0Qxzhu2kkvBN034LBLwFFdP0RXME4DFiNL+FY=;
        b=CsNgSqe/yS9z7dxyx8kuHGf9sYKmzkdxGQ/7tuEht/G6CunLZP3pPdp+e65dqGL4rX
         zp0DtrrkSpSuzPzMYl8Eh0rBnJRCdt7Ms0Bx+WA26kH3OnvX95PwchAEys/orS1b0Xte
         1pZcZkHF5BrgMpnJYmycZPFIkkaHOucSJ4hCxc+JsYz3aAY3ml0tONomqJloiSqV7W6d
         Afh1U45xpwruaF1am18f5tZO7zPzqqxx4glRQPVz1pBJHzdtdVIvKOcYRl1RPT0dfr1q
         ae5j648aOM2b9xUtaZvEmpr5cLoaZvQwyS/+yDJc65meNvTUebwkSyIafcvVjUYv7lfc
         JzQw==
X-Gm-Message-State: AOAM531husD/MtbhHymzkmKKjlxIZQmjninBxXjzmYzole8djfGU4Fq/
        67Ene0xQ2vg+rJ4w+8lYPMQy7zIFVmA=
X-Google-Smtp-Source: ABdhPJxxiqOG1HhA3scT1Io0GQp/L/iF8e8jk1ptc1K1MQjP6yKSa+e54xx1QCtmlRI7ypfDNvc0kQ==
X-Received: by 2002:a05:620a:2849:: with SMTP id h9mr4724976qkp.69.1629219637665;
        Tue, 17 Aug 2021 10:00:37 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id s69sm1761313qka.102.2021.08.17.10.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 10:00:37 -0700 (PDT)
Subject: Re: What's cooking in git.git (Aug 2021, #06; Mon, 16)
To:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
References: <xmqqv945ng61.fsf@gitster.g>
 <92511bbe-5ef3-cfef-0a0b-30fbda2df201@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <12bc51e2-21c5-d401-4189-8cb20b529245@gmail.com>
Date:   Tue, 17 Aug 2021 13:00:36 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <92511bbe-5ef3-cfef-0a0b-30fbda2df201@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio and Phillip,

Le 2021-08-17 à 06:20, Phillip Wood a écrit :
> On 17/08/2021 00:06, Junio C Hamano wrote:
>>
>> * pw/rebase-skip-final-fix (2021-08-13) 3 commits
>>   - rebase --continue: remove .git/MERGE_MSG
>>   - rebase --apply: restore some tests
>>   - t3403: fix commit authorship
>>
>>   Checking out all the paths from HEAD during the last conflicted
>>   step in "git rebase" and continuing would cause the step to be
>>   skipped (which is expected), but leaves MERGE_HEAD file behind in

This should be MERGE_MSG, no ?

>>   $GIT_DIR and confuses the next "git commit", which has been
>>   corrected.
>>
>>   Will merge to 'next'.
> 

Philippe.
