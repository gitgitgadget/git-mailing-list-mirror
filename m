Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39EFC5479D
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 22:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbjAKWFF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 17:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbjAKWE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 17:04:57 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2030.outbound.protection.outlook.com [40.92.91.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE81942E34
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 14:04:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHATULx4XUNd0JFSn3No2AbdnvQWTgZ8m1i8cP3ZTXyFrwNrhmDznFs6opUZZJzvSqTpqRUI+4rGPany6dx3cpVIpeVMjOrDJbX/W1QK90FnkblK8v04MKC0pf30DfP4gjWTv7lcG400tN4VwoV8QVfYiR3KgC8IIXG0PmcfStEfuoW1SkeDH5QyiwAApz0qd23/glwCvvZGdDRJ5siv3Xz0JUgGls8wB6c6ej2b9Rkj/3gxs6Zf/ZEaar9Z8r9naMT4nP9buURbNHfM16SJffLHxAi6j+vtqkEs+1NBHJc0hfrChCpLUta9Wyc8u3QH5uh9eroIRQLEzJkkYs6kxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9601bNSrrYJ0KdLfF4kI8yOzyp+eQln7GiFn7sBsKmo=;
 b=jRUneRjRCRoci6of9kTIK8csVHJeNGgTJ1cbjry15/F7RL0B8ggfxKibpY1Yeee9YjsjW4VK5hLScOH4I0bU9N9DBjnzCor65fjHBfoADIc7NjQ9WfumFr5MKGudH5W/M+IARnRpCW8kkrDRkKdhnFv2pPKb6AzbLg++DyltY6SIXss75uq98djCizfgYo5Zxz9v2bVfv5uFPS7Hy921svxPj/EbuU5gA3R0b55IbWKhE10bHdRLrNW6ssOS1wIvIBvKCzorlrdF8qgXXfxO1hJtgTcFtbm695oEsy+BveCxHqqQ35uIgBLrIN9y3VHoTPEAqlbGyvm1ys3TCHyAeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9601bNSrrYJ0KdLfF4kI8yOzyp+eQln7GiFn7sBsKmo=;
 b=F5kou77FyElk4TgZy+E+eavyCGckzTdZ+ZVyDy5tFOUoCGR387IVF+VriQj9caojHPMxF60F9j3dMw1dapywqKVt740oMYo+rv2ksr/Le5qR3W8QC0f6V/+JKchiagKZutzQVy2HcNzwMxxZbsBQwNecv9q6rxMz1aHezm5jJdw3gpZUXYns9wSlcoFoDnSZyqCAHoPg6rNrCaweGbyrCrdxSHp4MY8XcxFoAxn9ZqGciy9bFWbT0VHRieKT62VUC1uW+Z1Jw1XDRl6mDUDq+1vgrrwgMD9bk8jrbQhHSID3b/cl1Qti8Y+QsPu2GX7SNKHmoaNZWyfcWdxFYi5q0g==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by AM9PR03MB7868.eurprd03.prod.outlook.com (2603:10a6:20b:433::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Wed, 11 Jan
 2023 22:04:53 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519%8]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 22:04:53 +0000
Message-ID: <AS2PR03MB981512D8EF6775A9D6D9DEB6C0FC9@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Wed, 11 Jan 2023 14:04:46 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v4 8/8] t5556: add HTTP authentication tests
To:     Victoria Dye <vdye@github.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
 <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
 <8ecf63835229676677e3f7e33f634eb5d3a568b7.1670880984.git.gitgitgadget@gmail.com>
 <1dc44716-2550-47de-e666-9972b102905d@github.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <1dc44716-2550-47de-e666-9972b102905d@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [ljCzXAXW/W9+RazLRWVmdCtMhaptKZaY]
X-ClientProxiedBy: BYAPR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::38) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <3eada1ec-e725-10a3-8c62-eb013e2ff2da@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|AM9PR03MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: fc0d3bba-5518-4c1d-9311-08daf41fde04
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p7g3S7YR/jl3tUUssslYF+z05rjsi0sgzXzCtBwoEIZoDODHhyMlk+nyuqrv/7da7tq84L4EK+6uUqiINpj3k4f13YqfErGhxe+3CuS3zv7cUBndho8gB00HcLv7lGws4K9thNqA4y7PV3wYOtXdInOZAyUJ5SGHrd/Bxo+8RyRRr59s5zYSrv4sCCTBcsw8m3YELMA/WM9rj6hw1s5318W/8cyzVhBE8J8J/pf6uGiywvNc1ygK+5SPBAMOTfSVkfk0+t83WGt7OqtoFVfj+AwsIZAS6YiY3eBiRvbVRCfUClHZ9OBGRhAxoaFT0ZRoUEFOUToAfG1cXVnMQYHOWFlkYJiWKxksUsCLPF9kXjYXtY1d64zwosnbu73FklDMy6eqyNH4CWH0pndBbB/OlusrrOzW0tykoB9oN1uVrtNSF3B9FLQxEmLrNVNN58FsZuTDxWJqnS4urcxkrffDvU35jOciwMGhXJIUWZr2fNCAUsTQy1P81cI5LhE/cQyFb1FdBCkxngwthYhlLKEBi5RwoHLBdwT3CFicNDtT7dM6BWXnSruEWVj3POFASOZe1y6EecXa+slQzIRRfQI97KznzeAhT7rMVqmOXItwvJs/E9Qdp51emB0HNB/ueidosKvwEaE1WvMcREJDh6bQ/R96s0UaV/vSqt/CicHuhrw=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUhTc0dTRnp2eEl5YzBHQnFJeG84WFkzdkpwNUtKR2NNRW9XZGFDeGxsMEta?=
 =?utf-8?B?QUNCajFXUnpTbVRQN1hUQkEvdzl4eURpWjhCOU55ZXlraExLMGg4ckRqVHIw?=
 =?utf-8?B?V0VBaEg5bmtYRXYxUXdtUTgveHpNL0JZeHBXbG8xWTBBejhkVDY4MnpGMDYw?=
 =?utf-8?B?WHNtSm9teWxHYlBTTkdkcVpMenkyeXNSQ3REVStvWkhjNEY2SllFcUZXT2RZ?=
 =?utf-8?B?UXIwZWZzMUNHOEp0ZWo1SHZjeDVUUnJ1QmphYk1hN2grVWJYRGg2YnJXUWl4?=
 =?utf-8?B?NVVCSGFuSDFwYloyV1o5K2VZWW9RWmZBalhlWnRVSENxY0EvelZNRW5IeEpx?=
 =?utf-8?B?V0p6ZHhXWTdzY3NqNlRrRmpHUEZFMnV2SjNtNXcxbXRJRUw0SDhMcUNSYWhn?=
 =?utf-8?B?OWVLRDZuNHV1Wm1LNGJJTTNZVElUaXJkbnh5SDArV2RuaEJ6cUNMSkxoWDhI?=
 =?utf-8?B?d3ZTZ1hHOEVsazBXQlRKb09TeHc5L3lGM3YyYlJnTnZoYlI1RDJETXZkTUpV?=
 =?utf-8?B?djBKcGs2QkVsQ2RIRHlBMjhlVlByVHhieWViZVY5MXR4Zm9wU3RCZExibGZa?=
 =?utf-8?B?dXJqcFppaEhiNlRyeXR6MUhrYXk2MGtMQjczUXE5Zm5rSkFISmwwd1NhNVNM?=
 =?utf-8?B?bjZLYUZHbUg4SDE1MmpadHhkVU8zeHpVa2hkRjF0RnUxbGdyWVpxWXhNbUt4?=
 =?utf-8?B?cjFJRiszY2lTWVZlK0JpL3A0elBPQzErdHI5TGpUMW0rTVAzUXlobFgyaEFy?=
 =?utf-8?B?MHBPZzJQYVpkR0dYSFlvb3ptYUFYelFKUEx4c0ZzZmE3cVlkTkhYVEY0R2NU?=
 =?utf-8?B?TmlnV2RvdE9VNURkczZNWm1kQ2FUL0YwWDArd0pUVUNvNldrZ2Q0WkNhNUQr?=
 =?utf-8?B?MDV5Qkx1enVUaGpJRXppV3RZZW1RM2drUkJ5U3A0ZGJQZFU4RWtIMDIrZVFr?=
 =?utf-8?B?aFN1WDZQMXZNVG1rOGZlSzloQnp4Tk1uRVF1QTBtRS9lOGVoRmE1MVNkZjB0?=
 =?utf-8?B?TEVuVkxwUHowOFpSRkRMTERSZC9PUTl6MUUvRFBScWd4RUkyYklxa2k3dVdl?=
 =?utf-8?B?UUtqbWVhV0N3NVdMNFcrODJSMmpsTlZTNHV2OUpxd2d6elBJRk9JTnhQYWlS?=
 =?utf-8?B?OEJMMUVadDlTMjkvVy84VGlWU3ZDeVhuWHNzQk5FcEpFamdRYlRrZmZZQ3pE?=
 =?utf-8?B?NmZGMHMxRHFUUXErTXRKcGtqbUNBdm1XSDIrcEhBYzEzQmIxTndVU0hYVDZa?=
 =?utf-8?B?bXU3dWFkT0t0S2hraWlhQXhZVW1UdzZDZVVwS2ZubEpMOEtUalBXbjZDZUlZ?=
 =?utf-8?B?aTBpRnVuTCtWbEorb0VNTGVmNEZhS3p6bWZ4dzdmT1RRY0JtK0c1dy9MTE9y?=
 =?utf-8?B?Z3EvTFBia3FOK3FEOFk1d0pXMTZQejkvci85ZHdmTkJqU2s0Vi9INEtjVnFv?=
 =?utf-8?B?N1B6RHZjTHJ4ZTR4S3lMTGRxbllCaFhYNkVYRGZOVlE5aC9lRFZpYnBMTU5z?=
 =?utf-8?B?ZVc2S1Z6SXlkREh6ckZrN0RkSHp1Z1krL2l2VUZaVnZVSGtFaHJXTXkwNHZt?=
 =?utf-8?B?eWVESXBjVy9hTDE4ZVZjV2MwdGJUTVVZd1JVWmxyVW1KVWdsUWZOMVA0NlFD?=
 =?utf-8?B?cGxGVUdZWGhDVjU4ckd2ZmRnaUlvMElPeDJZdU9XQjJxR3lQMUd1c2VQVEg1?=
 =?utf-8?B?ZUVQeFhNOHlmbEh4L2M3RlZBWlpNZUJOMDFGUHRiN0VCaWZic2tNU1J3PT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0d3bba-5518-4c1d-9311-08daf41fde04
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 22:04:53.6883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7868
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-12-14 15:48, Victoria Dye wrote:

> Matthew John Cheetham via GitGitGadget wrote:
>> From: Matthew John Cheetham <mjcheetham@outlook.com>
>>
>> Add a series of tests to exercise the HTTP authentication header parsing
>> and the interop with credential helpers. Credential helpers will receive
>> WWW-Authenticate information in credential requests.
> 
> A general comment about this series - the way you have the patches organized
> means that the "feature" content you're trying to integrate (the first two
> patches) is contextually separated from these tests. For people that
> learn/understand code via examples in tests, this makes it really difficult
> to understand what's going on. To avoid that, I think you could rearrange
> the patches pretty easily:
> 
> 1. test-http-server: add stub HTTP server test helper (prev. patch 3)
>   - t5556 could be introduced here with the basic "anonymous" test in patch
>     6, but marked 'test_expect_failure'.
> 2. test-http-server: add HTTP error response function (prev. patch 4)
> 3. test-http-server: add HTTP request parsing (prev. patch 5)
> 4. test-http-server: pass Git requests to http-backend (prev. patch 6)
> 5. test-http-server: add simple authentication (prev. patch 7)
> 6. http: read HTTP WWW-Authenticate response headers (prev. patch 1)
> 7. credential: add WWW-Authenticate header to cred requests (prev patch 2)
>   - Some/all of the tests from the current patch (patch 8) could be squashed
>     into this one so that the tests exist directly alongside the new
>     functionality they're testing.


I think that order make sense - I'll rearrange for my next iteration.
Thanks!

>>
>> Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
>> ---
>>  t/helper/test-credential-helper-replay.sh |  14 +++
>>  t/t5556-http-auth.sh                      | 120 +++++++++++++++++++++-
>>  2 files changed, 133 insertions(+), 1 deletion(-)
>>  create mode 100755 t/helper/test-credential-helper-replay.sh
>>
>> diff --git a/t/helper/test-credential-helper-replay.sh b/t/helper/test-credential-helper-replay.sh
>> new file mode 100755
>> index 00000000000..03e5e63dad6
>> --- /dev/null
>> +++ b/t/helper/test-credential-helper-replay.sh
> 
> I'm not sure a 't/helper' file is the right place for this - it's a pretty
> simple shell script, but it defines a lot of information (namely 'teefile',
> 'catfile') that is otherwise unexplained in 't5556'. 
> 
> What about something like 'lib-rebase.sh' and its 'set_fake_editor()'? You
> could create a similar test lib ('lib-credential-helper.sh') and wrapper
> function (' that writes out a custom credential helper. Something like
> 'set_fake_credential_helper()' could also take 'teefile' and 'catfile' as
> arguments, making their names more transparent to 't5556'.

The `lib-rebase.sh` script sets the fake editor by setting an environment
variable (from what I can see). Credential helpers can only be set via config
or command-line arg. Would it be easier to move writing of the test credential
helper script to the t5556 test script setup?

>> @@ -0,0 +1,14 @@
>> +cmd=$1
>> +teefile=$cmd-actual.cred
>> +catfile=$cmd-response.cred
>> +rm -f $teefile
>> +while read line;
>> +do
>> +	if test -z "$line"; then
>> +		break;
>> +	fi
>> +	echo "$line" >> $teefile
>> +done
>> +if test "$cmd" = "get"; then
>> +	cat $catfile
>> +fi
>> diff --git a/t/t5556-http-auth.sh b/t/t5556-http-auth.sh
>> index 78da151f122..541fa32bd77 100755
>> --- a/t/t5556-http-auth.sh
>> +++ b/t/t5556-http-auth.sh
>> @@ -26,6 +26,8 @@ PID_FILE="$(pwd)"/pid-file.pid
>>  SERVER_LOG="$(pwd)"/OUT.server.log
>>  
>>  PATH="$GIT_BUILD_DIR/t/helper/:$PATH" && export PATH
>> +CREDENTIAL_HELPER="$GIT_BUILD_DIR/t/helper/test-credential-helper-replay.sh" \
>> +	&& export CREDENTIAL_HELPER
> 
> I see - this is how you connect the "test" credential helper to the HTTP
> server and header parsing (as implemented in patches 1 & 2), so that the
> results can be compared for correctness.
> 
> nit: you can just 'export CREDENTIAL_HELPER="..."', rather than breaking it
> into two lines. You also shouldn't need to 'export' at all - the value will
> be set in the context of the test.

I tried this originally, but got errors from one of the environments in CI that
this was not portable.

>>  
>>  test_expect_success 'setup repos' '
>>  	test_create_repo "$REPO_DIR" &&
>> @@ -91,7 +93,8 @@ start_http_server () {
>>  
>>  per_test_cleanup () {
>>  	stop_http_server &&
>> -	rm -f OUT.*
>> +	rm -f OUT.* &&
>> +	rm -f *.cred
>>  }
>>  
>>  test_expect_success 'http auth anonymous no challenge' '
>> @@ -102,4 +105,119 @@ test_expect_success 'http auth anonymous no challenge' '
>>  	git ls-remote $ORIGIN_URL
>>  '
>>  
>> +test_expect_success 'http auth www-auth headers to credential helper basic valid' '
> 
> ...
> 
>> +test_expect_success 'http auth www-auth headers to credential helper custom schemes' '
> 
> ...
> 
>> +test_expect_success 'http auth www-auth headers to credential helper invalid' '
> 
> These tests all look good. That said, is there any way to test more
> bizarre/edge cases (headers too long to fit on one line, headers that end
> with a long string of whitespace, etc.)?
> 

Thanks,
Matthew
