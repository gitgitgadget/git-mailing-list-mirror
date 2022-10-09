Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D76C433FE
	for <git@archiver.kernel.org>; Sun,  9 Oct 2022 23:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbiJIXkF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Oct 2022 19:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbiJIXjc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2022 19:39:32 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8FE564C4
        for <git@vger.kernel.org>; Sun,  9 Oct 2022 16:12:07 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n9so323710wms.1
        for <git@vger.kernel.org>; Sun, 09 Oct 2022 16:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fo0A0qohgppalFg2rczazidkRBlnB2hvgARrzROdV0U=;
        b=e/kTUFE0/uneNwBRQXhOdXoPXKZCXzvL58WbGglBOgu+VwzRHGys3PSHfVv97AEPpn
         Bmo7ld9RCBllkWequF9IQ4f5lEpGDPAWZyvUeyTplsAb7iRU4sAG3UGEeAGTesKasxch
         +qPLvNJbB/cGr0x/YMjTi/SM3NzchtksVESMO7KnNFSddE/gq6u7lY2PjLEUNYYp3Yu8
         ej6yw3dyPFuT/GgOwPlWLFVwUwvhjbkOF7ya+8Lb7seEd5aQoFEQ6msLPJblcC+YWm5r
         2k+n6MGcZl/UoYLynn1RTok14fhMIKmwBqOD8tpfYtmBHZA109wBoU/JqvbmBXJmlOI9
         0uYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fo0A0qohgppalFg2rczazidkRBlnB2hvgARrzROdV0U=;
        b=YaL5E/08BsV3/2XViprHUYFkR+/qj2Z4z3yYqoY6gu0xAdYKrHDXDFzSQkgGKH6er/
         msnrr5tx1avU3MslMt4DuV72+rDoKvP6lT9g2DgHAk1ihWXXZUP6a3FntMLba6YWhNKF
         7QnBzcam6QA8Br4wD8pmpp+DdgdZ1JGvuxRZeyg9/jrn1NVtK5ylNkS7uUe4ZdwgiSsF
         irJVD4fBdybjJeozC3QTaEqbPcVjZnEAB3aG2qYFQPiawaEEPwthRc/SnO94rYhsOBdQ
         uDtaoilVFugb7q+LVEVlB2E3SZHVI1uMbeWMjH5LMg0S/em85BP3D87N//9ZxVRsHZ28
         upYQ==
X-Gm-Message-State: ACrzQf1UUoA+uE68C1rwspIucL+6cn8rmh6AMfMQZCADwizYuqRARu7a
        ICBYbi3kk8QcuFQoPmHSpGBMjaeKx6BBCw==
X-Google-Smtp-Source: AMsMyM63HeItMTTRRHtkE1zWHn5pigfgUBEUhiuFpxKC84evyXAOp2fHwyFr9vqt1lF8tx/8xThoPw==
X-Received: by 2002:a05:600c:1d1a:b0:3c5:d7ca:18fb with SMTP id l26-20020a05600c1d1a00b003c5d7ca18fbmr3297961wms.136.1665354478623;
        Sun, 09 Oct 2022 15:27:58 -0700 (PDT)
Received: from [192.168.2.52] (138.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.138])
        by smtp.gmail.com with ESMTPSA id c190-20020a1c35c7000000b003b492338f45sm8888172wma.39.2022.10.09.15.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Oct 2022 15:27:58 -0700 (PDT)
Subject: Re: [PATCH v4] branch: support for shortcuts like @{-1}, completed
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
 <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
 <7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com>
 <2e164aea-7dd8-5018-474a-01643553ea49@gmail.com>
 <CAPig+cSX9jSPc_fJc0tuiER1-AqnbFGOk0r1tXEkv9gycVH-CA@mail.gmail.com>
 <f24837e9-7873-c34c-bd78-8ae3be0fc97a@gmail.com>
 <CAPig+cSn29Fq4ywC9zXoJYRVG8KUEhHuDdwEUSioFMUVs+S-ow@mail.gmail.com>
 <a7aca891-dd37-7e5e-61fc-8012fec18ae9@gmail.com>
 <CAPig+cRxy5C+CqUOzmhe16j+hssxsygha3huVga8tLJ+imM4Hw@mail.gmail.com>
 <32e4f8cf-696c-317d-236b-0f64c1398a01@gmail.com>
 <CAPig+cSdQsK7xVBb=ooOfP-hq1zavSV++iorLoni6o6etoLjzQ@mail.gmail.com>
 <xmqq5ygs7pxg.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <afec5288-7551-ff42-6dd8-899b5116394f@gmail.com>
Date:   Mon, 10 Oct 2022 00:27:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqq5ygs7pxg.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For me, the most value here is in the expressiveness, writing and reading
a simple test.

    git config branch.desc-branch.description >actual &&
    test_cmp actual "Branch description\n\n"

vs

    git config branch.desc-branch.description >actual &&
    printf "Branch description\n\n" >expect &&
    test_cmp expect actual

vs

    printf "Branch description\n\n" >expect &&
...
    git config branch.desc-branch.description >actual &&
    test_cmp expect actual

vs (oops)

    printf "Branch description\n\n" >expect &&
...
    git config branch.desc-branch.description >actual &&
    printf "New branch description\n\n" >expect_ &&
    test_cmp expect actual


Less lines, less files and less error prone are a plus.


On 9/10/22 8:46, Eric Sunshine wrote:
> My knee-jerk reaction is that the form which takes a string as
> argument would hardly be used, thus an unnecessary complication. The

A quick overview over a not much elaborated search:

git grep -B 3 'test_cmp expect' | grep '\(echo\|cat\).*expect'

gives many results that imo should be beneficial of this expressiveness.


> form which accepts stdin could even be retrofitted onto the existing
> test_cmp, thus you don't even need to invent a new function name. A

Nice.  Maybe even the printf form with a "test ! -f", some risky though.


> different approach would be to introduce a function `test_stdout`
> which both accepts a command to run, as well as the "expected" text on
> stdin with which to compare the output of the command; i.e. a
> combination of the existing `test_stdout_line_count` in
> t/test-lib-functions.sh and your proposed function above.

Sounds good to me but maybe this goes in the direction of "inducing
bad usages", and the tests to cover starts to be not so simple...


On 9/10/22 21:33, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
>> That said, I'm not yet seeing all that much added value in such a
>> function; at most, it seems to save only a single line of code, and
>> it's not as if the code it's replacing was doing anything complicated
>> or hard to grok.
> 
> I share the sentiment.  Leaving the result that was used in comparison
> in file(s) also helps debugging.
> 

And if this is fulfilled with a drop a file on failure? That resolves the
'-' in the diff output result too.


Thank you.
