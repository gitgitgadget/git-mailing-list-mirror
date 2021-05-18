Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D496C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 12:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32CEE60FF2
	for <git@archiver.kernel.org>; Tue, 18 May 2021 12:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244867AbhERMO4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 08:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbhERMOz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 08:14:55 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39820C061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 05:13:37 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id c15so11256141ljr.7
        for <git@vger.kernel.org>; Tue, 18 May 2021 05:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rwugNvVhX2QSDSl8rBPRyiji80ffsy+PyzN2LU+P5XY=;
        b=bIgkShH7eNPl1ztlfI3KEuLjqqUoAtQMph9VXwzAvDqLvdzwD9evyVVD1g5qt2pt2B
         wHFiK8T4e3P5RcieHOEALTVxrZhulPAaE8mv1fK4PJicdFxqxAQfnUPKTivwOoGSRAcZ
         +ee+QrkRucZuxOl0oVhSrjVKM0gV3HSKED2LCQTGRNqroG/PULH+GgUvx3SRU91FVAfY
         RFkiLjkD/dDPj3Bx2mF6uI+zN11UcZqXA7Yysr0JLU1z7eIpUGaW2xLMKU2p0S55vElB
         oCoCcyU7KY5M3BnC3mkBgS45o9rGh/QkKIurdvwWhUPN7kA4RN8CXmrAxroE5Md1djHW
         6mFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=rwugNvVhX2QSDSl8rBPRyiji80ffsy+PyzN2LU+P5XY=;
        b=WKd+2eXoPmF32sICjb9yWZIHfDDEUY0n+yIRQ6dnpzj44M/sf0u61axYQyVSPQj8JR
         rF6QCV27NSyxUpxJYP9Db0WnO6lY7kx5sAab8qdVEQWCrk5D/RYAE3PF3xbly04UO1WM
         //d+bGMnMXcXs/5R+qYT29sKF9xrClQozOyFWZmIGJSn7ku5xdMMzR3u5/yyrw5V8uUI
         fszDKoYF7INuZHWRq2yCOQM3mTY3KGBkPI7N6owFA47zvLewR+JBl+Kud/2xYPXpRiXE
         gwmRt7XmhvKOyn26QTDGXUoO69d+FY+OJMInikba7BJ/3h2goh6c5dbvWMufnppZH3hl
         7k5A==
X-Gm-Message-State: AOAM532BExdC74fINF1bkOPahSDbs6Dodr4LSfQgtx6bNW0CGCLznV1f
        SIjR9UIWzmJ18Kz96GvkNoPcsJszcao=
X-Google-Smtp-Source: ABdhPJyuMP/pCegFv1xuvPHoUnVC+UdUPExab4ejrcnGyyrs0GgFd24dV7eSse+2tCG475MWchi+7w==
X-Received: by 2002:a2e:b54b:: with SMTP id a11mr2364258ljn.459.1621340015352;
        Tue, 18 May 2021 05:13:35 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id x32sm2255681lfu.235.2021.05.18.05.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 05:13:34 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v1 2/9] t4013: test "git -m --raw"
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210517155818.32224-1-sorganov@gmail.com>
        <20210517155818.32224-3-sorganov@gmail.com>
        <1a78e837-13a0-f9bb-1ee2-a54534af37b1@gmail.com>
Date:   Tue, 18 May 2021 15:13:33 +0300
In-Reply-To: <1a78e837-13a0-f9bb-1ee2-a54534af37b1@gmail.com> (Bagas Sanjaya's
        message of "Tue, 18 May 2021 10:27:39 +0700")
Message-ID: <87a6osck9e.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 17/05/21 22.58, Sergey Organov wrote:
>> This is to ensure we won't break different diff formats when we start
>> to imply "-p" by "-m".
>> 
>
> This patch, and patch 3, have the same commit message (and thus the logic),
> so these can be squashed.

Yep, but they have different subjects. Usually I need a serious reason
to squash otherwise independent changes, but if you guys prefer them
squashed, we'd need to come up with suitable squashed subject, and I'll
squash them no problem.

>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>   t/t4013-diff-various.sh          |  1 +
>>   t/t4013/diff.log_-m_--raw_master | 61 ++++++++++++++++++++++++++++++++
>>   2 files changed, 62 insertions(+)
>>   create mode 100644 t/t4013/diff.log_-m_--raw_master
>> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
>> index e9f67cd24351..1809355f9bb1 100755
>> --- a/t/t4013-diff-various.sh
>> +++ b/t/t4013-diff-various.sh
>> @@ -337,6 +337,7 @@ log -m -p --first-parent master
>>   log -m -p master
>>   log --cc -m -p master
>>   log -c -m -p master
>> +log -m --raw master
>>   log -SF master
>>   log -S F master
>>   log -SF -p master
>
> In near future, we will switch default branch created by `git init` to
> main. Had the test be prepared?

No idea, sorry. I'd personally rather change preparation stage of this
test file to explicitly create "master".

>
>> +:100644 100644 7289e35... 992913c... M	dir/sub
>> +:100644 100644 f4615da... 10a8a9f... M	file0
>> +:000000 100644 0000000... b1e6722... A	file1
>> +:100644 000000 01e79c3... 0000000... D	file2
>> +:100644 000000 7289e35... 0000000... D	file3
>> +
>> +commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
>> +Author: A U Thor <author@example.com>
>> +Date:   Mon Jun 26 00:03:00 2006 +0000
>> +
>> +    Side
>> +
>> +:100644 100644 35d242b... 7289e35... M	dir/sub
>> +:100644 100644 01e79c3... f4615da... M	file0
>> +:000000 100644 0000000... 7289e35... A	file3
>> +
>> +commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
>> +Author: A U Thor <author@example.com>
>> +Date:   Mon Jun 26 00:02:00 2006 +0000
>> +
>> +    Third
>> +
>> +:100644 100644 8422d40... cead32e... M	dir/sub
>> +:000000 100644 0000000... b1e6722... A	file1
>> +
>> +commit 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44
>> +Author: A U Thor <author@example.com>
>> +Date:   Mon Jun 26 00:01:00 2006 +0000
>> +
>> +    Second
>> +
>> +    This is the second commit.
>> +
>
> The rest of commits only have commit title, why do this second commit
> have also commit message body?

Probably for testing of messages bodies? Anyway, that's how these tests
are arranged, doesn't come with these particular patches.

BTW, in the original there are trailing whitespaces on otherwise empty
line between "Second" and "This is the seconds commit".

>
>> +:100644 100644 35d242b... 8422d40... M	dir/sub
>> +:100644 100644 01e79c3... b414108... M	file0
>> +:100644 000000 01e79c3... 0000000... D	file2
>> +
>> +commit 444ac553ac7612cc88969031b02b3767fb8a353a
>> +Author: A U Thor <author@example.com>
>> +Date:   Mon Jun 26 00:00:00 2006 +0000
>> +
>> +    Initial
>> +$
>> 
>
> Thanks.

Thanks,

-- Sergey Organov
