Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD23C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 14:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3097620726
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 14:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="poR4REGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfLIOMl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:12:41 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38089 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfLIOMl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 09:12:41 -0500
Received: by mail-yb1-f196.google.com with SMTP id l129so6133257ybf.5
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 06:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z9D9FlwK32gMIbnm5jFPnqBTWvsP2CLqB2TEk0Cf75I=;
        b=poR4REGsjiSTy/dn2yMnQx+0C+ls7RKFM/HgQuGFQGx1SQBJumBtEzugX5q+RCzlde
         O1WUuTrBHmDo8PDm6eX8hTiV5AoF/qA9xuyPaCoOTXJQ4GeQiRXmif/blYlK8vFu+RaT
         l1T698unpsxpJ/8AaaGKRhK3DK8uHUG4lhL4TUPfgO5wPo/zIWIcdWb0bA8INVv0iMrE
         KfLMk39ysCETb6Hnv/eemldvwoefB7HgoAsXXeJcZVLUUZqSH2x9xYEDr4GEZ8yynpWR
         QJs5+YkVQameCIfXEjUs3+s5GrWYt9cTTnSeiRIofGYU1JhkQKaMh1zwXlZdeE8n2jsB
         98aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z9D9FlwK32gMIbnm5jFPnqBTWvsP2CLqB2TEk0Cf75I=;
        b=CSDOOvLMZwg0z6NvUux44Uq3IEVLdwth8NqQuJeXEeqbk5PSn5Hbzx4Fk0/9IPX/VH
         2FP1VzptCwk5aQ3QgJ6Ncg3EUjARMUmQdA/KbtDz0bXmmRSwnnbO3KgPJyvmAlxHCSkB
         CqtAnb9VdubjWfcRXucVAHxKfWk8yFnKit5TyZvOtXbxTU0TPVYlW0Vas0OwxlEcvGbv
         m2GveQqf5w/i4Nov1C7DXpTmVui0HNBytuM8X8NwRHWj+MGJKnFX7tO3b2CSMgtH807M
         GUtMbaB+iNSj1xz6WhPrj6+W5x5e0CCPNEul76xu/iitE7gw1r2q4vX2us/lJK+behNV
         Zl7A==
X-Gm-Message-State: APjAAAVbS7Pes1qgnU9fv4zF8bAepmNk2ObvB97WkVDpDo6Qp8St3+/L
        PMBZNjGcLRwcilIBVR7rz/0=
X-Google-Smtp-Source: APXvYqyYNODtfKeHKG8hoUU3xDNd6MR4MOEkpXJ5Pu/GqOnj8hCfEXyJSEbhGaFohT1CNfFlKLLeGQ==
X-Received: by 2002:a25:824e:: with SMTP id d14mr6250617ybn.218.1575900759393;
        Mon, 09 Dec 2019 06:12:39 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id q185sm4583009ywh.61.2019.12.09.06.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 06:12:38 -0800 (PST)
Subject: Re: [PATCH 11/11] test-lib: clear watchman watches at test completion
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
 <47cecb4a83a3f726088ffba0b00679384c7349ae.1574374826.git.gitgitgadget@gmail.com>
 <20191122010645.GX23183@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <93325ecb-0bbe-e7fb-3b60-8fff81768f8f@gmail.com>
Date:   Mon, 9 Dec 2019 09:12:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20191122010645.GX23183@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/21/2019 8:06 PM, SZEDER Gábor wrote:

Thanks for this message. Sorry I'm so late getting back to it.

> On Thu, Nov 21, 2019 at 10:20:26PM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  t/test-lib-functions.sh | 15 +++++++++++++++
>>  t/test-lib.sh           |  2 ++
>>  2 files changed, 17 insertions(+)
>>
>> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
>> index e0b3f28d3a..03573caf42 100644
>> --- a/t/test-lib-functions.sh
>> +++ b/t/test-lib-functions.sh
>> @@ -1475,3 +1475,18 @@ test_set_port () {
>>  	port=$(($port + ${GIT_TEST_STRESS_JOB_NR:-0}))
>>  	eval $var=$port
>>  }
>> +
>> +test_clear_watchman () {
>> +	if test $GIT_TEST_FSMONITOR -ne ""
> 
> In the rare cases when this function is invoked (see below) this
> condition triggers an error from the shell running test script:
> 
>   - when the variable is not set, because of the lack of quotes around
>     the variable name:
> 
>       $ ./t5570-git-daemon.sh 
>       [....]
>       ok 21 - hostname interpolation works after LF-stripping
>       ./t5570-git-daemon.sh: 1482: test: -ne: unexpected operator
>       # passed all 21 test(s)
>       1..21
> 
>   - when the variable is set, because the '-ne' operator does integer
>     comparison:
> 
>       $ GIT_TEST_FSMONITOR="$PWD"/t7519/fsmonitor-none ./t5570-git-daemon.sh
>       [...]
>       ok 21 - hostname interpolation works after LF-stripping
>       ./t5570-git-daemon.sh: 1482: test: Illegal number: /home/szeder/src/git/t/t7519/fsmonitor-none
>       # failed 1 among 21 test(s)
>       1..21
> 
> Please use 'if test -n "$GIT_TEST_FSMONITOR"' instead.

Thanks for the pointers.

>> +	then
>> +		watchman watch-list |
> 
> Then with the above fixed, trying to run 'watchman' triggers another
> error if it's not installed:
> 
>   $ GIT_TEST_FSMONITOR="$PWD"/t7519/fsmonitor-none ./t5570-git-daemon.sh 
>   [...]
>   ok 21 - hostname interpolation works after LF-stripping
>   ./t5570-git-daemon.sh: 1484: ./t5570-git-daemon.sh: watchman: not found
>   # failed 1 among 21 test(s)
> 
> I think we need an additional condition to run this only if
> 't7519/fsmonitor-watchman' is used in the tests.

The intention is to enable a test-suite-wide run using GIT_TEST_FSMONITOR,
and that can only use watchman (currently). Barring wanting to unset the
variable if it was set on purpose in a test script, the other options do
not actually return correct values to make use of the feature.

>> +			grep "$TRASH_DIRECTORY" |
>> +			sed "s/\t\"//g" |
>> +			sed "s/\",//g" >repo-list
>> +
>> +		for repo in $(cat repo-list)
>> +		do
>> +			watchman watch-del "$repo"
>> +		done
>> +	fi
>> +}
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 30b07e310f..067a432ea5 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -1072,6 +1072,8 @@ test_atexit_handler () {
>>  	# sure that the registered cleanup commands are run only once.
>>  	test : != "$test_atexit_cleanup" || return 0
>>  
>> +	test_clear_watchman
> 
> I'm not sure where to put this call, but this is definitely not the
> right place for it.  See that 'return 0' above in the context?  That's
> where the test_atexit_handler function returns early when no atexit
> handler commands are set, i.e. in all test scripts that don't involve
> some kind of daemons, thus this call is not invoked in the majority of
> test scripts.

Ah, I misunderstood the point of test_atexit_handler.

> Simply moving this call before that early return is not good, because
> then it would be invoked twice.
> 
> An option would be to register this call as an atexit command
> somewhere late in 'test-lib.sh' (around where GIT_TEST_GETTEXT_POISON
> is restored, perhaps).  That way it would be invoked most of the time,
> and it would be invoked only once, but I'm not sure how it would work
> out with test scripts that unset GIT_TEST_FSMONITOR somewhere in the
> middle for the remainder of the test script.  However, register the
> atexit command only if GIT_TEST_FSMONITOR is set (to something
> watchman-specific), so it won't be invoked at all if
> GIT_TEST_FSMONITOR is not set, and thus it won't generate additional
> test output and trace.
> 
> I don't have a better idea.

Shouldn't it be sufficient to add it into test_done? If the test fails,
then we could leave watches open, but that's no worse than we had without
this test_clear_watchman method.

Thanks,
-Stolee

