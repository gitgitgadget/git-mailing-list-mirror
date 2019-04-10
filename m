Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46E8720248
	for <e@80x24.org>; Wed, 10 Apr 2019 13:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732295AbfDJN4X (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 09:56:23 -0400
Received: from siwi.pair.com ([209.68.5.199]:12179 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732232AbfDJN4W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 09:56:22 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 0B0043F40EB;
        Wed, 10 Apr 2019 09:56:21 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:8502:dd25:1011:b187] (unknown [IPv6:2001:4898:8010:0:6e38:dd25:1011:b187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id AC12E3F4094;
        Wed, 10 Apr 2019 09:56:20 -0400 (EDT)
Subject: Re: [PATCH] test-lib: whitelist GIT_TR2_* in the environment
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20190330075119.13156-1-avarab@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <37d2e724-8abe-962a-54f9-46cf67f2a3ce@jeffhostetler.com>
Date:   Wed, 10 Apr 2019 09:56:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190330075119.13156-1-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/30/2019 3:51 AM, Ævar Arnfjörð Bjarmason wrote:
> Add GIT_TR2_* to the whitelist of environment variables that we don't
> clear when running the test suite.
> 
> This allows us to use the test suite to produce trace2 test data,
> which is handy to e.g. write consumers that collate the trace data
> itself.
> 
> One caveat here is that we produce trace output for not *just* the
> tests, but also e.g. from this line in test-lib.sh:
> 
>      # It appears that people try to run tests without building...
>      "${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git$X" >/dev/null
>      [...]
> 
> I consider this not just OK but a feature. Let's log *all* the git
> commands we're going to execute, not just those within
> test_expect_*().
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   t/test-lib.sh | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 562c57e685..f6318c54c9 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -379,6 +379,7 @@ unset VISUAL EMAIL LANGUAGE COLUMNS $("$PERL_PATH" -e '
>   	my @env = keys %ENV;
>   	my $ok = join("|", qw(
>   		TRACE
> +		TR2_
>   		DEBUG
>   		TEST
>   		.*_TEST
> 

I could go either way on this one.  It would be nice to have
telemetry for all of the commands run by the suite (and especially
for perf tests) for our developer analysis purposes.  But if your
settings have you route that data to a DB, your DBA might not be
happy with you....

Jeff
