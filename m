Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B55FC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 20:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046812068E
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 20:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YK5Veo+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfLIURR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:17:17 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:37501 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfLIURP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 15:17:15 -0500
Received: by mail-oi1-f169.google.com with SMTP id x195so7600984oix.4
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 12:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ucK68VQu71jQfeoxS7dUtE1Gw8jggTKGZw26PzL9RJY=;
        b=YK5Veo+OBd58Pb79b9BEUwzTUik/Uy2CsA2K8j0ILqcDY9QEf+a5Lbhx8+uoLNZmJb
         bKW2vyKmhF0/BG1EUmSox9g8j2IwNp+RSWCga+tfvxtsVJU/v6XFTBSPLwW1TxECwXlz
         IF64COCTaHbCQZBC9BUQnYBG/wWn7LIlpNtZrRzjb5HBdS6MK5WwPOfwPjSoly+a65HK
         fcq137H2I1XA7jkAoJa2oyXhc0BjxEx5L3aPwLiIRflCjUlJxgDKyXqijVaD673LZKev
         P5r0LEO9U0PqMHBLgiXNUa8Kqj+sHm1mNoADNS44Mec2XaAB0XlGDR+4KzGHFs1DgTdS
         dMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ucK68VQu71jQfeoxS7dUtE1Gw8jggTKGZw26PzL9RJY=;
        b=RRARHqlt7dDQjgORAj6RUMmCTXBDmCmpQWWgHuZJ59xhB3e4K/y5yRAq9r1Pz8q3/0
         wNltMbH84eGPDZtmws3hXkX06c0ovFQmo4T8nb90YlJsYga1HRB/IeLTPLn24wmGVLms
         Of2fHRnYaKQ9XxA+o3O3qLZ2nvau5tqXvZDB71hOLHKSUqaaZQ/Jxn9gmwmKToo2IX5U
         mfA8xjxYmSyvtH1rK7MvmylEIUp0Z2ROZ6h1m/G14WkWDcIN5LXUcelCyiuQP5so0PyW
         7WKJb2qQegv7OY98SMkjQDoEsn6h3nnf7i2BWcanNO+8u+Jbgn2x/2s5w3AsGp0Q9ueq
         4uzg==
X-Gm-Message-State: APjAAAXcGSrTMXMvnCOCEZSKTz7OFGmDsRZXu0nFW/8gx+H1xQL9xWjL
        H6zn/ycL4oWj1s5eaIJjlXU=
X-Google-Smtp-Source: APXvYqxJqQ17XxmldJUhViGowdfbQ0E/x39jIhzFsVKL0150Vd+upiM+ARBP+eqX4qmSZ3qn95CjnA==
X-Received: by 2002:a54:4e8d:: with SMTP id c13mr831235oiy.27.1575922634939;
        Mon, 09 Dec 2019 12:17:14 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id l128sm408360oif.55.2019.12.09.12.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 12:17:14 -0800 (PST)
Subject: Re: Git Test Coverage Report (Mon. Dec 9)
From:   Derrick Stolee <stolee@gmail.com>
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <903fcdea-6f08-caf5-77a4-2e82b8585edf@gmail.com>
 <e47b77b4-7b7a-3d59-9e24-934528c5e297@web.de>
 <CAPig+cTrAsn64S0Qm7PdJVFhsquVA3+ugwngLpo1S4yUjMcrGA@mail.gmail.com>
 <58a3e2c4-4c5a-e276-f74e-128438f2ab40@gmail.com>
 <a9c2c409-778c-48e2-e6d5-229eab45a707@web.de>
 <676dc5c1-5823-ac83-878b-995f3793bfb8@gmail.com>
Message-ID: <944d66f0-7745-b70f-bec8-1d3610e7b8d0@gmail.com>
Date:   Mon, 9 Dec 2019 15:17:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <676dc5c1-5823-ac83-878b-995f3793bfb8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/9/2019 1:23 PM, Derrick Stolee wrote:
> On 12/9/2019 1:10 PM, René Scharfe wrote:
>> Am 09.12.19 um 18:44 schrieb Derrick Stolee:
>>> On 12/9/2019 12:19 PM, Eric Sunshine wrote:
>>>> On Mon, Dec 9, 2019 at 12:11 PM René Scharfe <l.s.r@web.de> wrote:
>>>>> Am 09.12.19 um 16:36 schrieb Derrick Stolee:
>>>>>> René Scharfe  0bb313a5 xdiff: unignore changes in function context
>>>>>> xdiff/xemit.c
>>>>>> 0bb313a5 223)        xchp->i1 + xchp->chg1 <= s1 &&
>>>>>> 0bb313a5 224)        xchp->i2 + xchp->chg2 <= s2)
>>>>>> 0bb313a5 225) xchp = xchp->next;
>>>>>
>>>>> Hmm, line 223 *is* exercised by t4015.85.
>>>>
>>>> This, along with Dscho's[1] review of an earlier coverage report,
>>>> makes one wonder if there is some off-by-one error in the reporting
>>>> logic, such that it is reporting the wrong lines as not covered.
>>>
>>> This is definitely possible. I'll see if I can locate the bug in
>>> my report-generation code.
>>>
>>> However, line 222 is here [1]
>>>
>>> 	while (xchp != xch &&
>>>
>>> So if this is always false, then the rest of the while condition
>>> will not be tested, nor will the body (line 225: xchp = xchp->next;).
>>
>> 0bb313a5 also added lines 228 and 229, which are not in the report, so
>> xchp != xch must be true at least once (it is, in t4015.85).
>>
>> 222)				while (xchp != xch &&
>> 223)				       xchp->i1 + xchp->chg1 <= s1 &&
>> 224)				       xchp->i2 + xchp->chg2 <= s2)
>> 225)					xchp = xchp->next;
>> 226)
>> 227)				/* If so, show it after all. */
>> 228)				if (xchp != xch) {
>> 229)					xch = xchp;
> 
> Thanks for pointing out that context.
> 
> My guess is that gcov is marking the line as uncovered because the &&
> operator is on that line. I'm testing [1] by breaking style conventions
> and using the following:
> 
> 				while (xchp != xch
> 				       && xchp->i1 + xchp->chg1 <= s1
> 				       && xchp->i2 + xchp->chg2 <= s2)
> 					xchp = xchp->next;
> 
> [1] https://dev.azure.com/git/git/_build/results?buildId=1453

Confirmed:

target	fork/test-gcov
base	e0522318ac56aeb88f14e72ba2db25912e9972de


Uncovered code in 'target' not in 'base'
--------------------------------------------------------

xdiff/xemit.c
ddd5ad00 224)        && xchp->i2 + xchp->chg2 <= s2)

Commits introducing uncovered code:
Derrick Stolee	ddd5ad00 TEST: switch position of &&


For future reference: having the "&&" at the end of the
line will mark the line as uncovered if the right-hand
side of the && is uncovered. The same holds for other
short-circuit operators.

Thanks,
-Stolee
