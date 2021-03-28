Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE0CC433E0
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 12:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E755B6196F
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 12:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhC1MXv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 08:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhC1MXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 08:23:25 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B553CC061762
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 05:23:25 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso6392838pji.3
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 05:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sWZCN1uwpKrTscfKaqiMcqvADJShyK+CjX2aPto1FzQ=;
        b=oiXuXmIHqIwIuweStbwIfV5RcmQZOMXMcuDjc0Mlue0CMkePmaae3lK0HPbYQ83RQy
         U35XnX1ANLEX2NiFDNoLP50AVUvMc7h1Vhv51DlEq9C2bnBRpkp6cdveK9XLaNGncehB
         Q0pVkoTQ9t0rh/0UXS5hXB15pSGRDzS6cndR8CbuyOXk3kE4BaH6OdBAlwYG6n/84zZl
         Y/aFGCKjRR/NZYVsA6OQP811IQTA9apmIMmqJnTz5LVDFz+oNmSvsYqFUF8ezswg9eTd
         g0HAYIeCjjzD4n24v2oksQnHII6CUiPFD642GDBM4t8Nb5Ezjg4CsTm4gcRrSCPKISZG
         kk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sWZCN1uwpKrTscfKaqiMcqvADJShyK+CjX2aPto1FzQ=;
        b=ChMdbxlc+JDfUxo7c8N8W9gWs76diakFqY8nPckJnxwRHD+SLkYfVJ/9aYnXJzk6xC
         PnpamQLR4jaixVoKad3On007wO5phNk2B4rBFxyf47tRkru1/4MXSGU3PjDvr6B5GENa
         yc4BjAyOrOu9uKkkbda7TwrtchDZ7tx+GkX1YFOffBo/T13qHzrc+y3CvZEa5DdYPzS6
         hjZvEQMAPE8muLbg8OCFpYDDDayH4qb6SgpwktVSct9h6qUR05FGRTLZAe2cc1kmg4Q+
         rrqngYGzNJVQf9HIwEpsfcyDPEPWjoZUQV++30F6WnZE1XHhIzPGYzaZVbPJcBuKNU9U
         /i0Q==
X-Gm-Message-State: AOAM531H5TwEO+xvsFWmI5u05gNx5NglCMFc7G/T4OyiL2pO2SEkRjt2
        gby5W4v9/s7MC4TuQYbvYP4=
X-Google-Smtp-Source: ABdhPJw7rRitoMEdHp5fPbaXtmBJkoA8a2uNwAd9vR2JlaJsLzWfP97UnyarcBBz3PMib6dzIQdpUg==
X-Received: by 2002:a17:90b:100e:: with SMTP id gm14mr22236667pjb.217.1616934205123;
        Sun, 28 Mar 2021 05:23:25 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.121.20])
        by smtp.gmail.com with ESMTPSA id s76sm14822067pfc.110.2021.03.28.05.23.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Mar 2021 05:23:24 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [GSOC][PATCH] userdiff: add support for Scheme
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <3def82fd-71a7-3ad9-0fa2-48598bfd3313@kdbg.org>
Date:   Sun, 28 Mar 2021 17:53:21 +0530
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: 7bit
Message-Id: <5BA00FC6-9810-49AB-8DE2-D4F4010E2F82@gmail.com>
References: <20210327173938.59391-1-raykar.ath@gmail.com>
 <3def82fd-71a7-3ad9-0fa2-48598bfd3313@kdbg.org>
To:     Johannes Sixt <j6t@kdbg.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28-Mar-2021, at 05:16, Johannes Sixt <j6t@kdbg.org> wrote:
>> diff --git a/t/t4018/scheme-define-syntax b/t/t4018/scheme-define-syntax
>> new file mode 100644
>> index 0000000000..603b99cea4
>> --- /dev/null
>> +++ b/t/t4018/scheme-define-syntax
>> @@ -0,0 +1,8 @@
>> +(define-syntax define-test-suite RIGHT
>> +  (syntax-rules ()
>> +    ((_ suite-name (name test) ChangeMe ...)
>> +     (define suite-name
> 
> This test is suspicious. Notice the "ChangeMe" above? That is sufficient
> to let the test case succeed. The "ChangeMe" in the last line below
> should be the only one.

Thanks for pointing this out. The second "ChangeMe" was not supposed to be
there.

What I wanted to test was the hunk header showing the line for
'(define-syntax ...' and not the internal '(define ...' below it. Thus the
ChangeMe should be located above the internal define so that the hunk header
would show define-syntax and not the local define.

> But then there is this indented '(define' that is not marked as RIGHT,
> and I wonder how is it different from...
> 
>> +       (let ((tests
>> +              `((name . ,test) ...)))
>> +         (lambda ()
>> +           (ChangeMe 'suite-name tests)))))))
>> \ No newline at end of file
>> diff --git a/t/t4018/scheme-local-define b/t/t4018/scheme-local-define
>> new file mode 100644
>> index 0000000000..90e75dcce8
>> --- /dev/null
>> +++ b/t/t4018/scheme-local-define
>> @@ -0,0 +1,4 @@
>> +(define (higher-order)
>> +  (define local-function RIGHT
> 
> ... this one, which is also indented and *is* marked as RIGHT.

In this test case, I was explicitly testing for an indented '(define'
whereas in the former, I was testing for the top-level '(define-syntax',
which happened to have an internal define (which will inevitably show up
in a lot of scheme code).

>> +    (lambda (x)
>> +     (car "this is" "ChangeMe"))))
>> \ No newline at end of file
> 
>> diff --git a/userdiff.c b/userdiff.c
>> index 3f81a2261c..c51a8c98ba 100644
>> --- a/userdiff.c
>> +++ b/userdiff.c
>> @@ -191,6 +191,14 @@ PATTERNS("rust",
>> 	 "[a-zA-Z_][a-zA-Z0-9_]*"
>> 	 "|[0-9][0-9_a-fA-Fiosuxz]*(\\.([0-9]*[eE][+-]?)?[0-9_fF]*)?"
>> 	 "|[-+*\\/<>%&^|=!:]=|<<=?|>>=?|&&|\\|\\||->|=>|\\.{2}=|\\.{3}|::"),
>> +PATTERNS("scheme",
>> +         "^[\t ]*(\\(define-?.*)$",
> 
> This "optional hyphen followed by anything" in the regex is strange.
> Wouldn't that also capture a line that looks like, e.g.,
> 
>    (defined-foo bar)
> 
> Perhaps we want "define[- \t].*" in the regex?

Yes, this is what I intended to do, thanks for correcting it.

