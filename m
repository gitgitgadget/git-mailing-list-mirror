Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC78C43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 01:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764D72077B
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 01:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZ5PyZ3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfLJBnl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 20:43:41 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:35892 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfLJBnk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 20:43:40 -0500
Received: by mail-yb1-f196.google.com with SMTP id i72so729715ybg.3
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 17:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+PUXtxd8JUR02unoTDd2kzTtKhEL9nWRpTA4BF8zYRM=;
        b=LZ5PyZ3ZXbRgVMhpT30KR5djLbpaI5ztf8docJFIHpOhEo48zo7FYsN2U+2LzuaF2F
         /GwRA7MRURvk1mMWxfRVGnr5LDKO3UO03I2RWcRinefQP/Rv+E6Y3BYiogN62HqCtkvk
         l5gglMtdJq5jmFJkbhE/rII9AVBAQVi4ySz43kjf/XYURtq1o/UevMJBHFtUcie6bLjR
         SPPG5+tQ9PJB1W5XbiEF6HZfJL/T3LflhHZD36dKvkbGG9h5cMzBl85xrknWJBHao35/
         lwCpMiF8ivBDDi2aYAkkL5qyvYuukUI1BI7rFPiz6Nn7D//YhXB5jy4bqjfD7MT45NqS
         mIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+PUXtxd8JUR02unoTDd2kzTtKhEL9nWRpTA4BF8zYRM=;
        b=Wradtp/VaxQg4a4q7pX8XA1pxsgzKbVTfnzm5+El39btjzk4NByEyubcsyqI0+X/sv
         +dW1YEeb/gF3i/iTFqwdMviXKPleW2tDxR+WRhGVVPY0ZJErCDTou/trvpdoBYkCRg2l
         dsWNmY/c/w/7BPl+HFV57yPAUFJ0wPQ/MvDtSsEelz1hC4yxWiNme57MwRZM7nxqM8Ja
         hxAqJiHIfiyiq5y7S6ECY4iHWKLJyF4AVpACNMZIh3mWxk1fBbhaeRakcGe5cX3sJ8DV
         fS2APOALmpQg9JSpQ42kgBSwFzg22P9dUQQP9Wlli8y+eenMDQG7ng3VvN0IV/Ku8U3o
         sI/g==
X-Gm-Message-State: APjAAAUyXl/YIZXZdydmVnTnH6hDO4mTB1iSDIdNa4Y7R/sCUfor64CJ
        bRWuVWPkmxOcZ7iUg7Q8Scw=
X-Google-Smtp-Source: APXvYqxrex+lD7hwB91CRFXKWtiecNIORPjNwCMmLTBwwWjyV6gLCEGWVZPSEGVzLeX2PRA0MXP2VQ==
X-Received: by 2002:a25:9d0a:: with SMTP id i10mr21822114ybp.381.1575942219259;
        Mon, 09 Dec 2019 17:43:39 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id v64sm806383ywb.97.2019.12.09.17.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 17:43:38 -0800 (PST)
Subject: Re: [PATCH 11/11] test-lib: clear watchman watches at test completion
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
 <47cecb4a83a3f726088ffba0b00679384c7349ae.1574374826.git.gitgitgadget@gmail.com>
 <20191122010645.GX23183@szeder.dev>
 <93325ecb-0bbe-e7fb-3b60-8fff81768f8f@gmail.com>
 <20191209234016.GA6527@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <76b75c14-96ec-f8a5-a367-fb9b97a1c477@gmail.com>
Date:   Mon, 9 Dec 2019 20:43:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20191209234016.GA6527@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/9/2019 6:40 PM, SZEDER Gábor wrote:
> On Mon, Dec 09, 2019 at 09:12:37AM -0500, Derrick Stolee wrote:
>>>> +		watchman watch-list |
>>>
>>> Then with the above fixed, trying to run 'watchman' triggers another
>>> error if it's not installed:
>>>
>>>   $ GIT_TEST_FSMONITOR="$PWD"/t7519/fsmonitor-none ./t5570-git-daemon.sh 
>>>   [...]
>>>   ok 21 - hostname interpolation works after LF-stripping
>>>   ./t5570-git-daemon.sh: 1484: ./t5570-git-daemon.sh: watchman: not found
>>>   # failed 1 among 21 test(s)
>>>
>>> I think we need an additional condition to run this only if
>>> 't7519/fsmonitor-watchman' is used in the tests.
>>
>> The intention is to enable a test-suite-wide run using GIT_TEST_FSMONITOR,
>> and that can only use watchman (currently).
> 
> I've just run 'GIT_TEST_FSMONITOR=$(pwd)/t7519/fsmonitor-all make',
> and it only failed one test in 't0090-cache-tree.sh', but the fix is
> already in 'pu' in 61eea521fe (fsmonitor: do not compare bitmap size
> with size of split index, 2019-11-13).
> 
> 
>>>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>>>> index 30b07e310f..067a432ea5 100644
>>>> --- a/t/test-lib.sh
>>>> +++ b/t/test-lib.sh
>>>> @@ -1072,6 +1072,8 @@ test_atexit_handler () {
>>>>  	# sure that the registered cleanup commands are run only once.
>>>>  	test : != "$test_atexit_cleanup" || return 0
>>>>  
>>>> +	test_clear_watchman
>>>
>>> I'm not sure where to put this call, but this is definitely not the
>>> right place for it.  See that 'return 0' above in the context?  That's
>>> where the test_atexit_handler function returns early when no atexit
>>> handler commands are set, i.e. in all test scripts that don't involve
>>> some kind of daemons, thus this call is not invoked in the majority of
>>> test scripts.
>>
>> Ah, I misunderstood the point of test_atexit_handler.
>>
>>> Simply moving this call before that early return is not good, because
>>> then it would be invoked twice.
>>>
>>> An option would be to register this call as an atexit command
>>> somewhere late in 'test-lib.sh' (around where GIT_TEST_GETTEXT_POISON
>>> is restored, perhaps).  That way it would be invoked most of the time,
>>> and it would be invoked only once, but I'm not sure how it would work
>>> out with test scripts that unset GIT_TEST_FSMONITOR somewhere in the
>>> middle for the remainder of the test script.  However, register the
>>> atexit command only if GIT_TEST_FSMONITOR is set (to something
>>> watchman-specific), so it won't be invoked at all if
>>> GIT_TEST_FSMONITOR is not set, and thus it won't generate additional
>>> test output and trace.
>>>
>>> I don't have a better idea.
>>
>> Shouldn't it be sufficient to add it into test_done? If the test fails,
>> then we could leave watches open, but that's no worse than we had without
>> this test_clear_watchman method.
> 
> I don't know enough about watchman to have an informed opinion.
> 
> I think the answer mainly depends on what we want to achive and what
> happens when a test script run with GIT_TEST_FSMONITOR exits without
> invoking 'test_done' is re-executed (e.g. after a test case fails with
> '--immediate' or when the user hits ctrl-c or closes the terminal
> window mid-test).
> 
> As far as I understand the commit message of v2 of this patch [1], we
> mainly want two things:
> 
>   - Avoid overloading watchman's watch queue.  For this it might
>     indeed be sufficient to clear watches in 'test_done', because most
>     test scripts tend to succeed most of the time.
> 
>   - Make GIT_TEST_FSMONITOR work reliably on Windows.  For this, I'm
>     afraid it's not enough in general, because a failure with
>     '--immediate' or after a ctrl-c we won't run 'test_done', so we
>     won't clear the watches, and watchman will keep the fd to the
>     trash dir open, and, consequently, will interfere with subsequent
>     executions of the same test script as it can't delete the still
>     existing trash dir left over from the previous run.

You are right. Running an individual test and ending it early would
lead to these leaked handles. This assumes someone is aware of the
GIT_TEST_FSMONITOR environment variable, so they are at least
interacting with the feature directly to some extent.

>     It could still be sufficient for fsmonitor-enabled CI builds,
>     though, because there we don't re-run tests, don't hit ctrl-c, and
>     (at least on Azure Pipelines) don't use '--immediate', and the
>     whole VM/container/whatever is thrown away at end anyway.

This is the hope. It would be nice to get to that point.

> 
>     On Linux/Unix-y systems it probably doesn't matter much, because
>     they can delete open directories, but I wonder what happens with a
>     watch when the directory it is supposed observe gets deleted.  If
>     the watch is removed in this case, great; if it isn't, then...
>     well, then what happens with it?  Will it be overwritten with the
>     next test run, or will there be duplicate watches for the same
>     dir?

When a directory is deleted from under Watchman on Linux, the watch
is removed...eventually. I'm not sure at exactly what point that happens.
At the very least, Watchman will receive and process the signals for all
of the paths being removed inside the directory. Running 'watch-del'
removes that overhead.

Thanks,
-Stolee
