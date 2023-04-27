Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41E0C77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 23:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344340AbjD0XJm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 19:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344053AbjD0XJk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 19:09:40 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5AF2D55
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 16:09:39 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-2f917585b26so8328408f8f.0
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 16:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682636978; x=1685228978;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/iIv+JGAYTwU4AQ/dL0c+NwLJGwv9fYAmAA4CdqXsQ8=;
        b=RTignbwpa1iXEs+gjjIWozy3S6ATgtMryDl6qZBr4igoa/8I8hDbJV0p360eim1igI
         OGTP6D80vidjyFUl//ZyR93sfkpoqkXwqtYs9hhSHOip3MJ7QLqcp7YhvkiXPURb6fCu
         TPZji/iKpiRFN6wzLljnjuIzSxji+TYEfkxtVG1WbXhrJ0zmBetk10CqHKI+4MwWmmWx
         iaHKA9SnKDPBj+ZcH5dVMDx/x7DzmdVpgojCa+t9girEh6HkAR+mMbHBcXeCTecnKGWv
         ii0pOKy7y7mFCQAuYcdBMqTRmC2umDU8NKtHaNHRKZhar5DED7NJlFkLDa4fXQ0ZC2QD
         CSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682636978; x=1685228978;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/iIv+JGAYTwU4AQ/dL0c+NwLJGwv9fYAmAA4CdqXsQ8=;
        b=Xz/h1Lt4MnLYRWicmr9auQb1v1uPEbsWq4wVH7MhWLshUTftSfVKwKwN3oXq4O0xhA
         6ggE5RQfhpxDFdDXKkVbWpLiW2OgYMguyq5KH1RzVlve5JYgjL6uctvDv+PRodqQ6J17
         cjHL8AZt2Ba/guQgR0IzAxcnHAiQ2jaiQsQZdFGFfyC0deXGObGLsVRcXjtPNkaNHAxb
         nlSohH8OlQOoSuYDM/ci/o4gLNEFqea8bfA3IzZg5RfDfE4zZ5B4sxtlJ4oEYQ67PqR5
         5rjHJvOY+uyYpJ0jVOF+BZR5D5gEcOOZZVoN4GXCSHAct+FbqmT0uKVw0ZbxDYLqpM0O
         mQjA==
X-Gm-Message-State: AC+VfDz7JzCGC0l9kYZ5AzXuCK0U0XRQIYPNpClx5e/pNiAwtmUGWzz3
        kiiKIa+ghT2RArDNexEUi9Y=
X-Google-Smtp-Source: ACHHUZ5d6PKhZT96jUbbg/tnrhbQs9mD0lR85dlFpGq5Pb/hfI3SJkLFWLtb3BhEwCXWd1qDkKVfHA==
X-Received: by 2002:adf:f6cb:0:b0:303:4b87:71ab with SMTP id y11-20020adff6cb000000b003034b8771abmr2517353wrp.5.1682636977663;
        Thu, 27 Apr 2023 16:09:37 -0700 (PDT)
Received: from [192.168.2.52] (60.red-88-14-214.dynamicip.rima-tde.net. [88.14.214.60])
        by smtp.gmail.com with ESMTPSA id b2-20020adff902000000b00304aba2cfcbsm3232589wrr.7.2023.04.27.16.09.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 16:09:37 -0700 (PDT)
Subject: Re: [PATCH 3/3] checkout: warn when unreachable commits after using
 --orphan
To:     Andrei Rybak <rybak.a.v@gmail.com>, Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <f702476a-543a-da9b-ccd9-4431c80471e1@gmail.com>
 <417ae16c-9ba7-1e6d-c8d7-5b20a188b4fe@gmail.com>
 <033bd734-9c32-e5a2-3f5c-c851e4e3bc5d@gmail.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <a746089f-945e-df64-d261-61a212f79c7b@gmail.com>
Date:   Fri, 28 Apr 2023 01:09:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <033bd734-9c32-e5a2-3f5c-c851e4e3bc5d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/4/23 2:28, Andrei Rybak wrote:
> On 23/04/2023 00:19, Rubén Justo wrote:
>> diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
>> index 2eab6474f8..6762a9a572 100755
>> --- a/t/t2020-checkout-detach.sh
>> +++ b/t/t2020-checkout-detach.sh
>> @@ -124,6 +124,15 @@ test_expect_success 'checkout warns on orphan commits: output' '
>>       check_orphan_warning stderr "2 commits"
>>   '
>>   +test_expect_success 'checkout --orphan warns on orphan commits' '
>> +    git checkout "$orphan2" &&
>> +    git checkout --orphan orphan 2>stderr
>> +'
>> +
>> +test_expect_success 'checkout --orphan warns on orphan commits: output' '
>> +    check_orphan_warning stderr "2 commits"
>> +'
> 
> These two tests could be a single test.
> 
>     test_expect_success 'checkout --orphan warns on orphan commits' '
>         git checkout "$orphan2" &&
>         git checkout --orphan orphan 2>stderr &&
>         check_orphan_warning stderr "2 commits"
> 

OK
    '
> 
> Validating output like this in a separate step is an artifact of
> the old way of checking localized strings.  Tests were split into
> two in f06f08b78c ("i18n: mark checkout plural warning for
> translation", 2011-04-10) and then prerequisite C_LOCALE_OUTPUT
> was removed in f2c8c8007c ("i18n: use test_i18ngrep in t2020,
> t2204, t3030, and t3200", 2011-04-12).  Usage of test_i18ngrep
> was then removed in 1108cea7f8 ("tests: remove most uses of
> test_i18ncmp", 2021-02-11).

Thank you!
