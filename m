Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986B3C433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 21:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbiJZVVg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 17:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJZVVf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 17:21:35 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80AD127BF7
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 14:21:34 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id l28so11025693qtv.4
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 14:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0HdX+rNpk2PEu8St306+wOutaTyqlfDvcRpm3HSKyM=;
        b=q4WsZMrCUTvj//Cz1tER24MK7gJrQwEpFbw0fzExRmuuJV+nBXnTeUwN+74fkAGxkV
         mxe/6tiDr1oHrYdAkntJ5GVchPUoKuNGVjyF77lPnsvEnHnv3lrDP0Q9mcwB50+6rx8w
         hcYNLzxqT4HJ8mMXpMgnskILJS49jhvO7v38mq8klJFDbBbqnawThE6GwajuivyQQOr2
         Jj1RWQMkkPwQVahRFberICzgFQpNfR9nhcToCVvEsVkqS4rwBt8rtarOnCRr9/xNvF+n
         ohqxzJpe47OhU+Q0+4E/R187I+PES9vWw3iJupq8ZZu/92xluuo8Ts4pYcBo+TTS6Nl+
         26pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X0HdX+rNpk2PEu8St306+wOutaTyqlfDvcRpm3HSKyM=;
        b=yyswRW0N789C8zgTyqeOKeBcgSBPoUUqAxDjRwGHx5EqYHPccm4gr0QaXCi/IUxcQW
         KYAw5RclNiaGSiKDZ7VDEJT+DWUPtY+Q/McUIRaFA1xgTABVMI6G2NxGI9IrGx0/bTNr
         GayOC9EoNOVZdRzxX/Hlccv7UE3YMWCjFUGtulFiY5/sb2dSX0OKKdyNCuHH0e+FtCE5
         CB+Auc0PngfR7YtMMABMZAroRzwudV/2pTqTKrIEex8g7XQpOKZxCiiPriF6qlD9YrYu
         c64ptKqnbd84GzOdNrqNMd+Bv/SS+qZCLnr0Y3+iq+71KAd2G5PuwSfh732lk2W3L/n8
         N+yA==
X-Gm-Message-State: ACrzQf1u8bFg57kZDJRFp3phfz28m9TQqfNqKLbGbRLJOq1jMH9Wd1P2
        hsGPS28F0/p9D4lHLAkeKDMTwR4Lh1v1iw==
X-Google-Smtp-Source: AMsMyM6ki/cyuxLDGtwqPXm6/O99KaATtW1H2pPGEMtoILZqpDwybP0PdncogF7PfXyJAj0FozwhUg==
X-Received: by 2002:ac8:7d01:0:b0:39c:ebdf:490c with SMTP id g1-20020ac87d01000000b0039cebdf490cmr39126200qtb.179.1666819293794;
        Wed, 26 Oct 2022 14:21:33 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id n17-20020a05620a295100b006ce1bfbd603sm4587646qkp.124.2022.10.26.14.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 14:21:33 -0700 (PDT)
Subject: Re: [PATCH 1/9] test-lib-functions: mark 'test_commit' variables as
 'local'
To:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Luke Shumaker <lukeshu@datawire.io>,
        Thomas Koutcher <thomas.koutcher@online.fr>,
        James Limbouris <james@digitalmatter.com>
References: <pull.1390.git.1666365219.gitgitgadget@gmail.com>
 <832e910aadc47309392feed69927c2e8693cbfc5.1666365220.git.gitgitgadget@gmail.com>
 <xmqq8rl8kht3.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <3a41e02f-c1fb-64ed-377b-4e4168f2adae@gmail.com>
Date:   Wed, 26 Oct 2022 17:21:31 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqq8rl8kht3.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2022-10-21 à 17:06, Junio C Hamano a écrit :
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>
>> Some variables in 'test_commit' have names that are common enough that
>> it is very likely that test authors might use them in a test. If they do
>> so and use 'test_commit' between setting such a variable and using it,
>> the variable value from 'test_commit' will leak back into the test and
>> most likely break it.
>>
>> Prevent that by marking all variables in 'test_commit' as 'local'. This
>> allow a subsequent commit to use a 'tag' variable.
> 
> This is the right thing to do, if done onn day 1 of the project, and
> it is the right thing to do for the longer term health of the
> project.  But it is a bit scary thing to do in the middle.
> 
> I wonder if there is an easy way to detect that a set of callers of
> test_commit are relying on the fact that calling test_commit without
> passing --author option cleared their $author variable (similarly
> for other variables that are cleared or set to a known value as a
> side effect of calling test_commit).  If their correctness depends
> on $author becoming empty after calling the script today, they will
> get broken by this change.
> 
> While it is OK to argue that they deserve it, we would have to be
> finding and fixing them ourselves after all.

Isn't the fact that the test suite passes with this change enough for us
to be confident that nothing is broken by it ?

In any case, I did a quick manual grep of each of the variables and could not
find a test that uses these names, so I think we are safe.

Thanks,
Philippe.
