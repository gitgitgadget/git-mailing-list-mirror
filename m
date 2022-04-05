Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDD9C433FE
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 21:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383592AbiDEVp0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389515AbiDEPV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 11:21:29 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C78D1CD7
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 06:36:38 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w21so19386272wra.2
        for <git@vger.kernel.org>; Tue, 05 Apr 2022 06:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RZOi9t1b0n14Yugr3XwApSwlD1qVKv85gwjuWZcAGr8=;
        b=WHB0uJCJC9KbmYJHUBG5AwiqOBdiP1FCtESur2FFzMMlp1Yxi2RPTIR8D/GXG1YVFZ
         7y8obFYhNJQu0/SFI0v6BnuB8ttfue6qHkQ96ngvPuYg4YMan40IGnrZR774HR4bhnDo
         6+v0ugLC0u5kuhp0vYB5vuwOHI1hE0zziFfmlxpRq1p+XgZG01yHuggRk6r30CppSXE1
         p59VZ6ueIPgd/s282ndqfib49LoSwPqzIwwi2GRXHY1lSysFafoSEhUJd2gVqJ6NGaNE
         YrVO8bvqcZ7/PEy3CiGvfZMGLd4jB7aox4SRu/wo5RLnjxhY69+ULUn/OmEiX/L0EVv3
         8uHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RZOi9t1b0n14Yugr3XwApSwlD1qVKv85gwjuWZcAGr8=;
        b=hTCuMzxMDNNYmFaLsrPzqMY1PnyWAgE/Hygs8PmWWn+upF9Y8Cef7qPSnVWIdNEvfv
         oeub1otilqBp+7afu4KQGc+kk40/LEFqoeYurPtyhneUKpFpgMnD0lEay0Y/OmgwZtxb
         tWRSK6AvEh01sotjNAqF3QrzsfzI8tx0v8JbhjR5w807hilJ0jmHZo/CbT8GpKo5pBzH
         I5XxE5vmZ1KLtZqZx4Zc4rkHN0VSnpTV00zU3eM99I+GWs13bohsauY7KIiTkofOPSYU
         TRwZVjfDaMU7SBUfCowtsbNJZIQhTWaJ0me1109IbgxIdD1KpEf922RSA95EZxa8xi9B
         cW8w==
X-Gm-Message-State: AOAM5325+R/DgIY8MqhNvgube22XRxva2/bT8cxTak/yETi5d70+S5ND
        2EFf5HRl7nM0cip4WGWC1hA=
X-Google-Smtp-Source: ABdhPJyD4OB6CQlKy2g4xF5PFCxuco9bMNlpXgFD3iOvYL9ZR885emiYJ6SUjwdl6KK3MCuIH9p3ZA==
X-Received: by 2002:a5d:4a82:0:b0:206:a38:51d6 with SMTP id o2-20020a5d4a82000000b002060a3851d6mr2781828wrq.384.1649165796593;
        Tue, 05 Apr 2022 06:36:36 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.224])
        by smtp.gmail.com with ESMTPSA id q66-20020a1c4345000000b0038e69dd940esm2149685wma.29.2022.04.05.06.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 06:36:36 -0700 (PDT)
Message-ID: <57c85e88-93af-acbe-f1ee-22c28dbec602@gmail.com>
Date:   Tue, 5 Apr 2022 14:36:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Making the tests ~2.5x faster (was: [PATCH v3] test-lib.sh: Use
 GLIBC_TUNABLES instead of MALLOC_CHECK_ on glibc >= 2.34)
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, Eric Sunshine <ericsunshine@gmail.com>
References: <20220304133702.26706-1-gitter.spiros@gmail.com>
 <975e203d-6bd3-f5ea-c21b-3e7518a04bb9@gmail.com>
 <220405.86k0c3lt2l.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220405.86k0c3lt2l.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/04/2022 11:03, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Apr 04 2022, Phillip Wood wrote:
> 
>> On 04/03/2022 13:37, Elia Pinto wrote:
>>> In glibc >= 2.34 MALLOC_CHECK_ and MALLOC_PERTURB_ environment
>>> variables have been replaced by GLIBC_TUNABLES.  Also the new
>>> glibc requires that you preload a library called libc_malloc_debug.so
>>> to get these features.
>>> Using the ordinary glibc system variable detect if this is glibc >=
>>> 2.34 and
>>> use GLIBC_TUNABLES and the new library.
>>> This patch was inspired by a Richard W.M. Jones ndbkit patch
>>> Helped-by: Junio C Hamano <gitster@pobox.com>
>>> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
>>> ---
>>> This is the third version of the patch.
>>> Compared to the second version[1], the code is further simplified,
>>> eliminating a case statement and modifying a string statement.
>>> [1] https://www.spinics.net/lists/git/msg433917.html
>>>    t/test-lib.sh | 16 ++++++++++++++++
>>>    1 file changed, 16 insertions(+)
>>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>>> index 9af5fb7674..4d10646015 100644
>>> --- a/t/test-lib.sh
>>> +++ b/t/test-lib.sh
>>> @@ -550,9 +550,25 @@ else
>>>    	setup_malloc_check () {
>>>    		MALLOC_CHECK_=3	MALLOC_PERTURB_=165
>>>    		export MALLOC_CHECK_ MALLOC_PERTURB_
>>> +		if _GLIBC_VERSION=$(getconf GNU_LIBC_VERSION 2>/dev/null) &&
>>> +		_GLIBC_VERSION=${_GLIBC_VERSION#"glibc "} &&
>>> +		expr 2.34 \<= "$_GLIBC_VERSION" >/dev/null
>>> +		then
>>> +			g=
>>> +			LD_PRELOAD="libc_malloc_debug.so.0"
>>
>> When compiling with "SANITIZE = address,leak" this use of LD_PRELOAD
>> makes the tests fail with
>>
>> ==9750==ASan runtime does not come first in initial library list; you
>> should either link runtime to your application or manually preload it
>> with LD_PRELOAD.
>>
>> because libc_malloc_debug.so is being loaded before libasan.so. If I
>> set TEST_NO_MALLOC_CHECK=1 when I run the tests then ASAN does not
>> complain but it would be nicer if I did not have to do that. I'm
>> confused as to why the CI leak tests are running fine - am I missing
>> something with my setup?
> 
> Perhaps they have an older glibc? They're on Ubunt, and e.g. my Debian
> version is on 2.33.

Good point, I'd not realized quite how new glibc 2.34 was

> But more generally, I'd somehow managed to not notice for all my time in
> hacking on git (including on SANITIZE=leak, another tracing mode!) that
> this check was being enabled *by default*, which could have saved me
> some time waiting for tests...:
> 	
> 	$ git hyperfine -L rev HEAD~0 -L off yes, -s 'make CFLAGS=-O3' '(cd t && TEST_NO_MALLOC_CHECK={off} ./t3070-wildmatch.sh)' --warmup 1 -r 3
> 	Benchmark 1: (cd t && TEST_NO_MALLOC_CHECK=yes ./t3070-wildmatch.sh)' in 'HEAD~0
> 	  Time (mean ± σ):      4.191 s ±  0.012 s    [User: 3.600 s, System: 0.746 s]
> 	  Range (min … max):    4.181 s …  4.204 s    3 runs
> 	
> 	Benchmark 2: (cd t && TEST_NO_MALLOC_CHECK= ./t3070-wildmatch.sh)' in 'HEAD~0
> 	  Time (mean ± σ):      5.945 s ±  0.101 s    [User: 4.989 s, System: 1.146 s]
> 	  Range (min … max):    5.878 s …  6.062 s    3 runs
> 	
> 	Summary
> 	  '(cd t && TEST_NO_MALLOC_CHECK=yes ./t3070-wildmatch.sh)' in 'HEAD~0' ran
> 	    1.42 ± 0.02 times faster than '(cd t && TEST_NO_MALLOC_CHECK= ./t3070-wildmatch.sh)' in 'HEAD~0'
> 
> I.e. I get that it's catching actual issues, but I was also doing runs
> with SANITIZE=address, which I believe are going to catch a superset of
> issues that this check does, so...

I assumed SANITIZE=address would catch a superset of issues as well but 
I haven't actually checked the glibc tunables documentation. We disable 
MALLOC_PERTURB_ when running under valgrind so perhaps we should do the 
same when compiling with SANITIZE=address.

I just noticed that setup_malloc_check() is called by 
test_expect_success() and test_when_finished() so it really should be 
caching the result of the check rather than forking getconf and expr 
each time it is called. Overwriting LD_PRELOAD is not very friendly 
either, it would be better if it appended the debug library if the 
variable is already set.

> Whatever we do with this narrow patch it would be a really nice
> improvement if the test-lib.sh could fold all of these
> "instrumentations" behind a single flag, and that both it and "make
> test" would make it clear that you're testing in a slower "tracing" or
> "instrumentation" mode.
> 
> Ditto things like chain lint and the bin-wrappers, e.g.:

I sometimes wish there was a way to only chain lint the tests that have 
changed since the last run.

>      $ git hyperfine -L rev HEAD~0 -L off yes, -L cl 0,1 -L nbw --no-bin-wrappers, -s 'make CFLAGS=-O3' '(cd t && GIT_TEST_CHAIN_LINT={cl} TEST_NO_MALLOC_CHECK={off} ./t3070-wildmatch.sh {nbw})' -r 1
>      [...]	
> 	Summary
> 	  '(cd t && GIT_TEST_CHAIN_LINT=0 TEST_NO_MALLOC_CHECK=yes ./t3070-wildmatch.sh --no-bin-wrappers)' in 'HEAD~0' ran
> 	    1.23 times faster than '(cd t && GIT_TEST_CHAIN_LINT=0 TEST_NO_MALLOC_CHECK=yes ./t3070-wildmatch.sh )' in 'HEAD~0'
> 	    1.30 times faster than '(cd t && GIT_TEST_CHAIN_LINT=1 TEST_NO_MALLOC_CHECK=yes ./t3070-wildmatch.sh --no-bin-wrappers)' in 'HEAD~0'
> 	    1.54 times faster than '(cd t && GIT_TEST_CHAIN_LINT=1 TEST_NO_MALLOC_CHECK=yes ./t3070-wildmatch.sh )' in 'HEAD~0'
> 	    1.63 times faster than '(cd t && GIT_TEST_CHAIN_LINT=0 TEST_NO_MALLOC_CHECK= ./t3070-wildmatch.sh --no-bin-wrappers)' in 'HEAD~0'
> 	    1.87 times faster than '(cd t && GIT_TEST_CHAIN_LINT=0 TEST_NO_MALLOC_CHECK= ./t3070-wildmatch.sh )' in 'HEAD~0'
> 	    1.92 times faster than '(cd t && GIT_TEST_CHAIN_LINT=1 TEST_NO_MALLOC_CHECK= ./t3070-wildmatch.sh --no-bin-wrappers)' in 'HEAD~0'
> 	    2.24 times faster than '(cd t && GIT_TEST_CHAIN_LINT=1 TEST_NO_MALLOC_CHECK= ./t3070-wildmatch.sh )' in 'HEAD~0'
> 
> I.e. between this, chain lint and bin wrappers we're coming up on our
> tests running almost 3x as slow as they otherwise could *by default*.
> 
> But right now knowing which things you need to chase around to turn off
> if you're just looking to test the semantics of your code without all
> this instrumentation is a matter of archane knowledge, I'm not even sure
> I remembered all the major ones (I didn't know about this one until
> today).

That is quite a difference in run time - I wonder how much scope there 
is for optimizing some of these features like the chain-lint vs 
disabling them completely.

Best Wishes

Phillip
