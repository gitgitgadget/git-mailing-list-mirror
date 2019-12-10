Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28F7C43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 13:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8162320652
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 13:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/zMRV9q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfLJN53 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:57:29 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38370 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfLJN53 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 08:57:29 -0500
Received: by mail-oi1-f193.google.com with SMTP id b8so9845741oiy.5
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 05:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k3g+4pGoOGb9IwFOko78LK42AJ2edX3BUiV5wG1QHYs=;
        b=b/zMRV9qQbtQxVrvWVNX609Qi9zL10BdDjSeMgCKBvUem0bLSmQ5RQobsyFTdcFZ7/
         1bcioOGQYrVjdvI6B00nfu/RoGVzNTCOCVOK7hTsUbjJeRsXhba5sORZiGBI0HpxGTiP
         OnVeJuLdXLppDOpe/dbPqNWMV0TbaZ5OnSyzF6X/HUoHJ6EC/XIgf6YIBAjtHLOLYers
         cWA6SEMpE8OU5Vb0FvUTXYpxa74ihCjBrK69WG7vMQZg3pj49gepnY8bSh81bu11jtA5
         ww5PVJxNnTtPMpXs6GYXYJVk3Kvim19GB8t6C11MqocH8lDE/FtoZ4alksjP5gNqRbEU
         Lj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k3g+4pGoOGb9IwFOko78LK42AJ2edX3BUiV5wG1QHYs=;
        b=dPNAkmmJ6qwnTrpaDPzAgu1KZEJ/GqpOBkPpA1yS4OL8mh3iDTZwckYrqjRiJTeqRr
         QE0nUQesQlucNNd1Hg9JQkpJcv8KITQE9eU3XL0reSOe+Qn/ejss547/auW9fCvFtlS7
         cuC5EZQAaXmgHuPL+fVDl82XWkVKWTsvshuDrmp5bEaMPiSn72XzsG0ob02ocK24uY+h
         ActJiUaWPmRhpGhB8+WrakMp/uX5r2KwJBlSrLZbGYCSmLgO2y5PzJlYb6dedtCMjGc4
         nQb6ttIwV9CiexrEWaNVGYPNT2siNMG1oPim+hKoOCAtfgshaoFc1iz70cKCCw55HUbi
         Jqww==
X-Gm-Message-State: APjAAAVz1nY4weccDciy61kTBri25qeES9HXOPJOItKhTZL1rdV1mnAy
        j4HBJayLo1nTudo0QBdvSyg=
X-Google-Smtp-Source: APXvYqwROoURzG9D0TD1glReXQxSo29eWfSF70Ma30gYibwQfeur2WDfy//iqPBJdlqFelQqUHgYPg==
X-Received: by 2002:aca:fdd7:: with SMTP id b206mr3828585oii.35.1575986248176;
        Tue, 10 Dec 2019 05:57:28 -0800 (PST)
Received: from [192.168.1.76] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id d59sm1411382otb.50.2019.12.10.05.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 05:57:27 -0800 (PST)
Subject: Re: [PATCH v2 5/8] tests: disable fsmonitor in submodule tests
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ukshah2@illinois.edu,
        Kevin.Willford@microsoft.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
 <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>
 <a5b0bf6ac7cd28fa47e26ab481f781d74c656f6a.1575907804.git.gitgitgadget@gmail.com>
 <20191210101351.GE6527@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1fa28a9c-2a4d-fbcb-653b-99a567dbc7da@gmail.com>
Date:   Tue, 10 Dec 2019 08:57:25 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20191210101351.GE6527@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10/2019 5:13 AM, SZEDER Gábor wrote:
> On Mon, Dec 09, 2019 at 04:10:01PM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The fsmonitor feature allows an external tool such as watchman to
>> monitor the working directory. The direct test
>> t7619-status-fsmonitor.sh provides some coverage, but it would be
>> better to run the entire test suite with watchman enabled. This
>> would provide more confidence that the feature is working as
>> intended.
>>
>> The fsmonitor feature struggles with submodules. Disable the
>> GIT_TEST_FSMONITOR environment variable before running tests with
>> a lot of submodule interactions.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  t/t3404-rebase-interactive.sh                | 1 +
>>  t/t3600-rm.sh                                | 1 +
>>  t/t4060-diff-submodule-option-diff-format.sh | 3 +++
>>  t/t5526-fetch-submodules.sh                  | 2 ++
>>  t/t7402-submodule-rebase.sh                  | 3 +++
>>  t/t7406-submodule-update.sh                  | 2 ++
>>  t/t7506-status-submodule.sh                  | 3 +++
>>  t/t7508-status.sh                            | 3 +++
>>  8 files changed, 18 insertions(+)
>>
>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
>> index 461dd539ff..9dc7d1aefb 100755
>> --- a/t/t3404-rebase-interactive.sh
>> +++ b/t/t3404-rebase-interactive.sh
>> @@ -697,6 +697,7 @@ test_expect_success 'do "noop" when there is nothing to cherry-pick' '
>>  '
>>  
>>  test_expect_success 'submodule rebase setup' '
>> +	GIT_TEST_FSMONITOR="" &&
> 
> This disables GIT_TEST_FSMONITOR for the remainder of the test script,
> but there are still a lot of non-submodule-specific tests to run.
...
>> diff --git a/t/t7508-status.sh b/t/t7508-status.sh
>> index 4e676cdce8..bf0487632d 100755
>> --- a/t/t7508-status.sh
>> +++ b/t/t7508-status.sh
>> @@ -846,6 +846,9 @@ test_expect_success 'status refreshes the index' '
>>  	test_cmp expect output
>>  '
>>  
>> +# fsmonitor does not work well with submodules
>> +GIT_TEST_FSMONITOR=""
>> +
> 
> Likewise.

Would it make sense to wrap the tests in a subshell without
increasing the tabbing inside the subshell? I can comment
the beginning of the subshell that we are disabling the
variable for a specific list of tests and the subshell can
be removed after the proper fixes make it work.

Thanks,
-Stolee
