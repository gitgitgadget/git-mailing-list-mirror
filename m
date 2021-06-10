Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3D7C48BD1
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 19:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CACE461407
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 19:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhFJTzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 15:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhFJTzn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 15:55:43 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2705BC061574
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 12:53:46 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id u20so835345qtx.1
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 12:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0XFNC4OKhkVfhkMFUigu3Pcrn5Q42Ky56mgaqMByJF4=;
        b=bEfbTgn3djIw/qgZDOI6gMngTkeiqm1R/3OOhlD7EdTaLiJLvfieOrRFPdcDAIU+qx
         VCjNXGFGJagI16QQir4x2IJITUKmsF9fx+NObQte9fDnfA4gDuTRnH3lluXfumldoDRj
         cLST0u9JZIxNoWIl+Dmllafp23DXalAycUedQL4brJkhvLlsFF0QBKwpuHwI2U5+yn3R
         xYrkua17uFoUWQlKC7xz4+DZ78cJEaMdJE3r8yzR+tGwKvfeYvv535FF7VPnAJeTjPb8
         4FnzkYL6YK9uGEmWFdFehcvsWTzABcTvgZ0oLqSHjHWXb/UCuGevpqhPiiFpITGIHQbo
         Lywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0XFNC4OKhkVfhkMFUigu3Pcrn5Q42Ky56mgaqMByJF4=;
        b=mwgEoL8Zv8jsZ46r6c7xOniGfNaZvVBj5CaU+caUKeab5uVR7zD+Qtc9SkyyD9ithI
         T8X7EyE4/Qew6Nres+uuIuNevAzbEVaFWezdMs9BKVAH6/HULK8XR3EBuEn+M54yC1hT
         HLiAykQBezZfr9vTRY080qO69bchIX0lHCR/2s7oe4vb4Vhu/vRW/Fk9TcT22ezEKcjs
         wuiAgcS/sQFYQ29nUpRFA1kmOXDO7MD3Uf2GLHqcBcOqteO9UfCxF/rw07Xvz4skzv75
         I7qN9GUQWK7yvH7KeEPEN71ASCFhhS13C/H8w+nV745Edfy/VjVKQU9meIDhExde+BVf
         D7LQ==
X-Gm-Message-State: AOAM530DqJ+TBgwnAqBUsZpCqp/yfZoQc+QyuRh+WdPG8IzBuwruk3B/
        97R6Xnt/EyRRiBuwOOz/4D0=
X-Google-Smtp-Source: ABdhPJxCtbcgKbgsA2CvRslhhEHXJEKC1AWwyFc4kdBNMu56PNyXOeXG0bVMm3y3a6zHcZBjQNcgww==
X-Received: by 2002:ac8:5c8c:: with SMTP id r12mr455121qta.265.1623354825247;
        Thu, 10 Jun 2021 12:53:45 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:8dd3:e726:fe78:a0d9? ([2600:1700:e72:80a0:8dd3:e726:fe78:a0d9])
        by smtp.gmail.com with ESMTPSA id z127sm2969348qkb.98.2021.06.10.12.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 12:53:44 -0700 (PDT)
Subject: Re: [PATCH 3/4] *: fix typos
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, jrnieder@gmail.com,
        emilyshaffer@google.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <c40ad4a058a75d57adc97b8252ad0f57600b8d86.1623085069.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2106101029490.57@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7f21cd15-5149-fe50-64ce-7b596dcd9bc8@gmail.com>
Date:   Thu, 10 Jun 2021 15:53:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2106101029490.57@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/10/2021 4:36 AM, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 7 Jun 2021, Derrick Stolee via GitGitGadget wrote:
> 
>> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
>> index 5c47ac4465cb..7039b5c6028d 100755
>> --- a/t/t9300-fast-import.sh
>> +++ b/t/t9300-fast-import.sh
>> @@ -1538,7 +1538,7 @@ test_expect_success 'O: comments are all skipped' '
>>  	commit refs/heads/O1
>>  	# -- ignore all of this text
>>  	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
>> -	# $GIT_COMMITTER_NAME has inserted here for his benefit.
>> +	# $GIT_COMMITTER_NAME has inserted here for this benefit.
> 
> What is this even supposed to mean? I fail to parse that sentence in both
> original and modified forms.

I missed that there appears to be a second typo, s/has/was/, giving

	# $GIT_COMMITTER_NAME was inserted here for this benefit

implying that the environment variable exists to allow changing the
committer info during this process.
 
> Looking at 401d53fa350 (Teach fast-import to ignore lines starting with
> '#', 2007-08-01), where the comment was added, I deduce from the commit
> message that the personal pronoun _was_ actually intended.
> 
> So maybe a better way to express the original intent would be this:
> 
> 	# comment added by $GIT_COMMITTER_NAME; fast-import should ignore it

I think the first comment "# -- ignore all of this text" satisfies
that need, so maybe we just delete this typo line?

Thanks,
-Stolee
