Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D219DC00A5A
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 23:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjAQXFt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 18:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjAQXET (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 18:04:19 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2016.outbound.protection.outlook.com [40.92.48.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63010166EC
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 13:37:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogTicsi7hpA9Qv6HW12IUzgyJfK5eU7wbUbH/HIrC8vE9/ngoBe9PGeItWkaNWf+r6iSmr1BiHULS1Aj545EtnF2sSPPV0+vu7WldfCFDzwrAu+ajMSeg4Quel+58/qfAhUFKDM/RRgJS4bTP0zrRJ71ujUQ/oji5NO4JPs0dRM6UflDzt9OG4s6TGBWzzd7kZmBqXfUoO7bd8NTmy7F6ldyttqx4GmYgKqVAYRmtEy48+ETj518yYObNoUmDOd/GmeHVRVTXiD/dhNmTKR5DlQ3KPZy5IpWE3KeVI/VG/BAWICBfj16ad5WEmGHLp3Hvl8epOMog35YPT18TatUHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9Z439uvrRKVsYSMCr27JG8iL9Vcgs5vQSn1m+0w1sY=;
 b=kv2QBAr8ObryOlb7qloxcmB/szKNjd9mC6wNPbG1HYoD80yDmPBzJSZmnogaOwVMLnX0yHyq3UWBmMsvUNqkMk3D+Pd4yMwaSZJndQlUmI220ycWPxkL49rglirFt/9aHXRvXA/lrQyHOdBTniizP1S2wMYqAKoyj9QC/wkRZEToWV+sfPLYQzn/ARq6RemKvMvsGq7OAJrrk19aYS9MHFJF2VdX6kuBlI++zJvzrI1JVyyyOUeWCoT+Z6BGIG5BWe2AzZaC1QgOajS8zBYVrb9l6/0yui5IDPwu626bEciyu8tuUVStsEjdq6ZqVNwM+ska0IdvugpCtZQJ8lQGZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9Z439uvrRKVsYSMCr27JG8iL9Vcgs5vQSn1m+0w1sY=;
 b=UirpqAKAkHEykuny0KhQy8DIq2yB/JljcMvowJ394yvqRujUJMf3q+IEO1/uufkN1lPaVohvPOs2r4RE+fN2MRvKk6w66UN3ozeL7fdxehWgSKEb37QBO/p45vnFgTt+IW/tfsjx1WveUKbJYA24AH9gZzwBWoJsFVeDe9OUryYoHfvbNkTjKZHXBEFoBTLq7gS+kzMt+2QL+f9jlu0ZUuqrx8fEUeYoQ9ntNEzgN0Me2vt3k60He7JfuJQ5R9D3CMO0nksXHDyfow5JeKjCpyP48JFKDJudKzk24XBwhonYREUKj9bAJ2XgWWjDIDyWgDVGqTmWOFMRnhJiYhsPxw==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by PAXPR03MB8083.eurprd03.prod.outlook.com (2603:10a6:102:220::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 17 Jan
 2023 21:35:46 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519%8]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 21:35:46 +0000
Message-ID: <AS2PR03MB981518197F0DC6413F07ED5CC0C69@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Tue, 17 Jan 2023 13:35:39 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v5 10/10] credential: add WWW-Authenticate header to cred
 requests
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
 <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
 <af66d2d2ede2a502f32d74c86f302598c68d1476.1673475190.git.gitgitgadget@gmail.com>
 <230112.86sfgg2kuj.gmgdl@evledraar.gmail.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <230112.86sfgg2kuj.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [pxSBPniMi4jV+9wua1nxN0+aeJdbEHz/]
X-ClientProxiedBy: BY3PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:a03:255::6) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <2d0aab24-610c-56be-4e98-f945d7cb55ba@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|PAXPR03MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: 7267a161-3d97-4d86-ef46-08daf8d2cb43
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: adZHxujLIGBH49gaV7GOqUi7LenIVodxhbrXKF4jwpe2HSQpjb5vR3+ipPTrMSJHMnlVCmi/V6FwMheyZCRUwsOOtDmO/5BUyTAucCn+ZetpjH0UutSCMc0Kiz8LW+OqGowQKTC9OmVA/wjqG0YUfRM2Tvaqqta1bFWFt0hNiFY8WwB8y1ktLEwyVKbLghwtIf2FdaeGlqSH8Ekxy5CWHheYotBa/ZZbMv9GfgtC4KZhsjNvn3oqSDCDIqBkIsQrK9ZhUqH1X87T4vg3Y/7foeNOKntyhwjDxDR/t8i5qHZzfpOZLla1nMLTNrzM5pVo9f0NBh5BdZWZ9zYuA4vsM3d2BxbfsxNeFkjfqxGc4M6yCCv3eUhbKwyM6QB0F5XraUcJ4Ihaqq2Ywkb1uwcTyauS94eQzGno+IlEl0ZtXWGDOQyVUU0tMW7s5g4H/uWl7VWLPe618/uJUFVf8bB8zpFMfnFy5IGXUY6CFYISJpuNEVCu614wlDZ92LNsVl2/aL0iY/N/Gxt+3JTMkYS7+PKzQo5Hb0S2+j+tPmu4X2Fx/40MefV1Ky731lDm6w+FdLW46Ld+uSXRfEjMUdCVejpunH6mmLWl+AFgoDpSgAY+4jTzQnTcIzoyOhkFmCngx4J2DjNFyGG7Jid6u7KqBA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2xjQ0F6dkNtWTgzUTFNMzVZNzg2SEpoSy9nUnk1ZjQxQ3hWdFlaeTg4R2JF?=
 =?utf-8?B?YlZ2QW1mRWR4MEkrc2x4SXNDOHIzNFJEWUZuRVFkWTlNbXZWNlFzbnVPQSs5?=
 =?utf-8?B?TzZ0Y2pOSDYvT1lBTE1meEQ3cmtLQWtQb3huU0J1dTBYMkVwdW9peTk2aVA3?=
 =?utf-8?B?L21YTmR4SUNmam40aHFjdlRtSFQ3T0VWVVB6a2xZOFkwY3FoNWpacmxzYis3?=
 =?utf-8?B?MFN5TVpWZXpucUZqMTZCL005bmJvNWxEcWtaM3dmSXNMbS9VNm1MWnNObHRE?=
 =?utf-8?B?UzNudW9VZjBBcmsrUVBoWXlZREExS2U0WFFjb2d6ZDJRSVFEeGRyVlBEdjVi?=
 =?utf-8?B?VVpzQ1dsYjFRb2E1ZFZHVFk4OGxPL2twREVKdE1qU0RLanN4RlNzWVExTXlM?=
 =?utf-8?B?WXRiOUVZZ3ZwS1A3T1N5bHdvRFJwL3BvL2lsTnhQdFRzdFlDZjVyZEpmNHMz?=
 =?utf-8?B?NDlKbTNzSUZ1QW14SVExQXV6VndXMUJlTEFNd3ZjdlpILzJPaElIakJBNWVV?=
 =?utf-8?B?YjhIUkdYZnBZTDdZZDFHc0JkS3NoY2t0WDdVOTRrQ2ZwdGZiVUJEMmZGKzho?=
 =?utf-8?B?RFZiOE52V0JOSGtrQkxXd0pocE1hUXpIZHFhL2lWQk9kVWVGNVdSejU2c2c1?=
 =?utf-8?B?MXlEbHI3WlRHNEhpZGYydjFFZjVUQ2RvTTVMT1Nqd1RFVFp4ZUhqaFlRWWVS?=
 =?utf-8?B?S3grYVVwSEk1L1pnWHM1OHBJYXFXSkl6Vkt1UUxNU012KytVWXhXNFRLaUlu?=
 =?utf-8?B?aTBwU2VpQUxzZ05xR2JDam1JTThGR3NvVnNLZkdQWEQ0c3Yxa2l5VlF6clNt?=
 =?utf-8?B?ak9Tem5BcW9sSy9yTWpmazFkWFFQUXozZ3RhVFVadkNHcUh5eVpTTTZOaGYz?=
 =?utf-8?B?bXlCdVpORHdxUlBxdnJ3TW5sZlB3QURUbjNMOHI0NzUyK0dWTlMxR3B0TFkx?=
 =?utf-8?B?ZHJSNHBFRUI2THlUc3NSdFdGeC8wUlNXZmh6NUFIWHFZaWNMVDZadlV2V1FG?=
 =?utf-8?B?TGY3RkQrVm9mMjNRUnBMQVoyNXhETzRUcnd3WlJLbmJ0L01JbGFnUzNxT2Vv?=
 =?utf-8?B?bzdwWHIwQnZEV3M2MXp1Q0NWVmVZZ0FGenB4Y21rOE1zdHlJRUVyVDhzNWZL?=
 =?utf-8?B?bXM3QkM4cVJMOGNjUHFlZHhVSDduc09GbklwZW9jMk1Xait5TFhHdnJNVzJD?=
 =?utf-8?B?RHVUaGJIY2JxVWc2cS9kb2hSQkdJR1R5RTVBbk9qV3hnNFV5UE84TnpNanlY?=
 =?utf-8?B?amhPQjhjQTBHR2xoeEI2SjNHbDA0bENaaHdtZVNuYnp6VlZUM1YzbDlEN2pU?=
 =?utf-8?B?K2xSVzdXL2s2RG0yV0g0Vk1RNWZLRHRDd202dHM3TkdHM0pyaHk5SmdlUlhj?=
 =?utf-8?B?QjFhMEdVL3gzeFRXcFRQaGdzakFDK3FZb1RWRVF6RGdqTHBGa2NQVDVRclBB?=
 =?utf-8?B?T2xUdkszamRqNTZSbUlBOFRic3JEL2JUdEtTamZ6VnB1UnovYnlnaVN6YXUw?=
 =?utf-8?B?Njh4M1MzS09XNUZCTXVBWSt4V2xwb3dXTk9PTUFYWVl3WHc1WE9XV2pGSEt5?=
 =?utf-8?B?dXBFZ3NLMHdzaFNXdXlacmViQXF1WnJjNFNZTGJaMTdVUGg0bEhQc2Q5dFNq?=
 =?utf-8?B?TWgxQ3hucWFPcGtUV1BQVy9mRmJNZmNHZ2ZxOWQrRnRHSDVUczVMS3IvZm1n?=
 =?utf-8?B?KzNqQVI4bDZIcS9DWVpNTjdNMk1TaG5iNERTV2s4UVh1OG1COHo1UWp3PT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7267a161-3d97-4d86-ef46-08daf8d2cb43
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 21:35:46.8394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB8083
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-01-12 00:48, Ævar Arnfjörð Bjarmason wrote:

> 
> On Wed, Jan 11 2023, Matthew John Cheetham via GitGitGadget wrote:
> 
>> From: Matthew John Cheetham <mjcheetham@outlook.com>
>> [...]
>> +static void credential_write_strvec(FILE *fp, const char *key,
>> +				    const struct strvec *vec)
>> +{
>> +	int i = 0;
>> +	const char *full_key = xstrfmt("%s[]", key);
>> +	for (; i < vec->nr; i++) {
>> +		credential_write_item(fp, full_key, vec->v[i], 0);
> 
> Style: Don't mismatch types if there's no good reason. Use "size_t i" here, also let's do:
> 
> 	for (size_t i = 0; ....
> 
> I.e. no reason to declare it earlier.
> 
>> +	}
>> +	free((void*)full_key);
> 
> Just don't add a "const" to that "full_key" and skip the cast with
> free() here.

Both good points! Thanks - will take this onboard in next iteration.

>> +++ b/t/helper/test-credential-helper-replay.sh
> 
> I see to my surprise that we have one existing *.sh helper in that
> directory, but in any case...
> 
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
> 
> It looks like you're re-inventing "sed" here, isn't this whole loop just
> 
> 	sed -n -e '/^$/q' -n 'p'

True; `sed -n -e '/^$/q' -e 'p'` is equivalent here.

> And then you can skip the "rm" before, as you could just clobber the
> thing.
> 
>> +if test "$cmd" = "get"; then
>> +	cat $catfile
>> +fi
>> diff --git a/t/t5556-http-auth.sh b/t/t5556-http-auth.sh
>> index 65105a5a6a9..a8dbee6ca40 100755
>> --- a/t/t5556-http-auth.sh
>> +++ b/t/t5556-http-auth.sh
>> @@ -27,6 +27,8 @@ PID_FILE="$TRASH_DIRECTORY"/pid-file.pid
>>  SERVER_LOG="$TRASH_DIRECTORY"/OUT.server.log
>>  
>>  PATH="$GIT_BUILD_DIR/t/helper/:$PATH" && export PATH
>> +CREDENTIAL_HELPER="$GIT_BUILD_DIR/t/helper/test-credential-helper-replay.sh" \
>> +	&& export CREDENTIAL_HELPER
> 
> ...(continued from above): Let's just use write_script() here or
> whatever, i.e. no reason to make this a global script, it's just used in
> this one test, so it can set it up.

In the next iteration I will move to using write_script; thanks!

>>  test_expect_success 'setup repos' '
>>  	test_create_repo "$REPO_DIR" &&
>> @@ -92,15 +94,279 @@ start_http_server () {
>>  
>>  per_test_cleanup () {
>>  	stop_http_server &&
>> -	rm -f OUT.*
>> +	rm -f OUT.* &&
>> +	rm -f *.cred &&
>> +	rm -f auth.config
>>  }
>>  
>>  test_expect_success 'http auth anonymous no challenge' '
>>  	test_when_finished "per_test_cleanup" &&
>> -	start_http_server &&
>> +
>> +	cat >auth.config <<-EOF &&
>> +	[auth]
>> +	    allowAnonymous = true
> 
> Mixed tab/space. Use "\t" not 4x " " (ditto below).

Sure!
