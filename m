Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F7FC433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 10:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E510D61969
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 10:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhC2KTK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 06:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbhC2KSx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 06:18:53 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CA5C061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 03:18:52 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e18so12264457wrt.6
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 03:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FaAaqOtF0t8KZIBoXzL8piRkTPdGYXi7ITaxDGo1aWM=;
        b=NjIjTsk3WCa0bVsKgfBwCMMad2hIxN2EBCs8JHomy10oOgTnt9TdFjlyC2yKCfwaZK
         WTiQ5D8Tv/kbot72stWe7jhipYxrV8RZrPN6hrVGRS0Z3NguTvbujnnpkDezXdnygatF
         kmJVzDRjE/16hZLSdvMqOnaCQk8fMiFwCMTfeyNfWbnoo4qfXhMeOLN6Bew1BB3D1kJD
         2Nqfp5MPbM7kK98eoBeZ/1r/Eb5joy4yvTrLxDwNLsoFogXKB3yGkxsjpcrl757olwr9
         gSAhBiBXllACJ6XpE92iGx6je9sNAt7NMasym5vfP1bBTcyo1p1xtbQk94zZp/JoABWS
         f9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FaAaqOtF0t8KZIBoXzL8piRkTPdGYXi7ITaxDGo1aWM=;
        b=hNLItr4CrIT7gt5SmPAP9Yu1LCBwg99sSDnicB+qT+fDnBzvrEAd/0UC+KcRCZwl3h
         Fu3rULjuzXGS5HzmtBfKgV7E+uptJZMtiUe+7V1b+QpvjLgJ7arepRVUGi+Iqy0uZw5M
         GGhPEcjz4xIo5nonNlAArRZSyiF4x0ymSlIQTduOP5xJ/osZnCVOCD49MJokD+oHEB4C
         fnATUBM2md1247/MCnWhNCCXnBLszA+n/SHAu1V2ZiR3xXzrcEqpWZEYiEyMpVCS1h+T
         SgddWt8iqSQYUOHYKlu0YUb0TeIHuMthO92v2kWzwtPBLsoE/pCopZkxfkD/n5mwyanl
         Lk6Q==
X-Gm-Message-State: AOAM530TcMSok6HIrYhW+rrrlAqdtIRGGVvG8wAbiW6ZJ7rNtswFGHQx
        8ei/N6SSkxbIqOC+B7lo6IM=
X-Google-Smtp-Source: ABdhPJyc1bR/QaN2zRHeP+QFanYjMV8swNIBvgaVYR8Rzs3Bs7/58cJBhBt4avEENxjFddCdRSPTBw==
X-Received: by 2002:a5d:4e83:: with SMTP id e3mr27955453wru.82.1617013131062;
        Mon, 29 Mar 2021 03:18:51 -0700 (PDT)
Received: from [192.168.1.201] (243.20.198.146.dyn.plus.net. [146.198.20.243])
        by smtp.googlemail.com with ESMTPSA id p12sm27846878wrx.28.2021.03.29.03.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 03:18:50 -0700 (PDT)
Subject: Re: [GSOC][PATCH] userdiff: add support for Scheme
To:     Atharva Raykar <raykar.ath@gmail.com>, Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20210327173938.59391-1-raykar.ath@gmail.com>
 <3def82fd-71a7-3ad9-0fa2-48598bfd3313@kdbg.org>
 <5BA00FC6-9810-49AB-8DE2-D4F4010E2F82@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <09678471-b2a2-8504-2293-e2b34a3a96e8@gmail.com>
Date:   Mon, 29 Mar 2021 11:18:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <5BA00FC6-9810-49AB-8DE2-D4F4010E2F82@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Atharva

On 28/03/2021 13:23, Atharva Raykar wrote:
> On 28-Mar-2021, at 05:16, Johannes Sixt <j6t@kdbg.org> wrote:
 > [...]
>>> diff --git a/t/t4018/scheme-local-define b/t/t4018/scheme-local-define
>>> new file mode 100644
>>> index 0000000000..90e75dcce8
>>> --- /dev/null
>>> +++ b/t/t4018/scheme-local-define
>>> @@ -0,0 +1,4 @@
>>> +(define (higher-order)
>>> +  (define local-function RIGHT
>>
>> ... this one, which is also indented and *is* marked as RIGHT.
> 
> In this test case, I was explicitly testing for an indented '(define'
> whereas in the former, I was testing for the top-level '(define-syntax',
> which happened to have an internal define (which will inevitably show up
> in a lot of scheme code).

It would be nice to include indented define forms but including them 
means that any change to the body of a function is attributed to the 
last internal definition rather than the actual function. For example

(define (f arg)
   (define (g x)
     (+ 1 x))

   (some-func ...)
   ;;any change here will have '(define (g x)' in the hunk header, not 
'(define (f arg)'

I don't think this can be avoided as we rely on regexs rather than 
parsing the source so it is probably best to only match toplevel defines.

Best Wishes

Phillip

> 
>>> +    (lambda (x)
>>> +     (car "this is" "ChangeMe"))))
>>> \ No newline at end of file
>>
>>> diff --git a/userdiff.c b/userdiff.c
>>> index 3f81a2261c..c51a8c98ba 100644
>>> --- a/userdiff.c
>>> +++ b/userdiff.c
>>> @@ -191,6 +191,14 @@ PATTERNS("rust",
>>> 	 "[a-zA-Z_][a-zA-Z0-9_]*"
>>> 	 "|[0-9][0-9_a-fA-Fiosuxz]*(\\.([0-9]*[eE][+-]?)?[0-9_fF]*)?"
>>> 	 "|[-+*\\/<>%&^|=!:]=|<<=?|>>=?|&&|\\|\\||->|=>|\\.{2}=|\\.{3}|::"),
>>> +PATTERNS("scheme",
>>> +         "^[\t ]*(\\(define-?.*)$",
>>
>> This "optional hyphen followed by anything" in the regex is strange.
>> Wouldn't that also capture a line that looks like, e.g.,
>>
>>     (defined-foo bar)
>>
>> Perhaps we want "define[- \t].*" in the regex?
> 
> Yes, this is what I intended to do, thanks for correcting it.
> 

