Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDFFC00A5A
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 23:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjAQXX3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 18:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjAQXXL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 18:23:11 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2062.outbound.protection.outlook.com [40.92.90.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AA16D693
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 13:14:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2b8BQuNa6CN3Sn0yUVtpCI6dLNrL97VaxHNcL2aqWXAu5awX2HXxxuX30mNDZ1BgHjbWoc9Fzi3+jgm/EDY/zWnjrXR5+ZpDjiRCdeiEcWxKkpGkJBFtVlLfx5ME9c8hmAhLmXP7IxOmM/6q9OgiHxK1SPWQ0yztq0+8P17rHyB5EzrGAA8XUzm0gy3PTVIIdcSknccnF90CB5brC+ToHWFW1vtMHl9rkRbi7mpjrlV6phc3OtBqduPb39n9HcBmh6PYtFFjmbx0sktW5tD5+u1+ger6EMwC4j3XbVW/aggFgefH4zHR/D02XIYG+7r7xgwwlITIvVPFtv6Xmdl4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JwoThTFbs7vb5rbQ1CI41UA77Z0eOAXZkiPwLhfXZ4=;
 b=P9XAja2jRzJVVsWQm4jSIkiCyNk97JqQAfI7e86fnoSnO3dPvYovFhm1tMWyMISy16PezpSw5jIgM1/ecXqDFs0auVU3dgNVQ7JcK/uGdQ7hzxjonWHWE+Hh6Tfbwd2kHU5uSQ5vwLCFpuQbnpryUDWqp+5c/O+1VKNaHdSMXgIjeM3WvSEsNxv2gSpe/7xwpnxsI5EWmCi9/hackOI7jiL136iOgBFtLoIOiNxn6n2N9HREKBdHHE5ccKKMjO4yrp0WPvCxVZQpM+5fS3daQcknpI9sehE7kQTLxr3R3UU88fHIutBKu/Bx9xXCvHsYJOsIZh/7nSqxwZV0c5ObmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JwoThTFbs7vb5rbQ1CI41UA77Z0eOAXZkiPwLhfXZ4=;
 b=EkaCwYEfHg3MuxgiF7ccVF8yjKCoRVmMZqoHv0HnvM5B+wv/oIKwuGziLo9u7F0woThuUshF5C8ypvXR6DihPyoe3BWgUOPZle7DeZE5vwOKxzOAvMj3L+sjfWbUPzmhLFRPOFzzWJNNFNUP1h+x8Zaw++ZG4qbdrzwhZX1s2nvRkNAQ5Rz3c0gy1nIbkP756IBQ0qbMPx78cekT5aggu8aS42PK6Bcrdu4MYBxAnDp+bcshW+KyEPD0jQokHNe74KAvfzKPk9+TGG1ImZq7nLsfMgpAnwM4kPVhTgdb6owGcj7q8jvLAo9fapWSAUI07Ywfo3k0vCf5hNKvWSD8aQ==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by AS2PR03MB9696.eurprd03.prod.outlook.com (2603:10a6:20b:60c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 21:14:40 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519%8]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 21:14:40 +0000
Message-ID: <AS2PR03MB9815335902DC90737D178E7CC0C69@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Tue, 17 Jan 2023 13:14:32 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v5 02/10] daemon: libify child process handling functions
To:     Victoria Dye <vdye@github.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
 <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
 <bc972fc8d3d3a028d3d160aac354d2a13bad37ae.1673475190.git.gitgitgadget@gmail.com>
 <3a8d1b66-ed06-16a3-5459-9381faa69420@github.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <3a8d1b66-ed06-16a3-5459-9381faa69420@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [aoDhAC+Gb+Vr97z8LjUGlbHK909tW26R]
X-ClientProxiedBy: BY3PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:a03:254::23) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <d917471b-9a63-3b96-513c-4114fbf9532e@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|AS2PR03MB9696:EE_
X-MS-Office365-Filtering-Correlation-Id: c136ccf4-622f-4b14-4b24-08daf8cfd863
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j3FZN4XJGjzGmCvGVCz/m5YAgV66/EpXwoHvL0RpwAWcYJ7U9r3nbf65giD8D0EHzBUjk7C96GxvCMLWSVS42sRHjAdBQo7y8XbMz7HiCuh8rz3Tmmb9jv7e1sjU6IxAGaGjev/WJPpziB5CWJky7pBYrY6tTZP5v4W2kMNrgnB6z1RWH+IllGCzE34UoJt4INIWmPIWYGZHoYtCHQ+h5leBYfBcJ/NsXmQcWeBpO4fHYcykFbcWZgJe1IwDu/1slDnQVmLgGT5CrdVH+u+bHREiruc3mc2khPGNWLrSvowQuO1im6oLmkli3sQsD0wJMrL/yNBLhCe9bso/LnNlieO5XgXPhiPtq9pJ6onXvBbRaGTSzyukSk34rXtiMYE59h2nP0dqVa+6ylqZa3kHDDRPhn+3JSUe7U/pc8wxF4eMwCXjaaMdZA2zuKzFH7d9eiq9XSsoSIOsfPM8iXfYhi9/OZb2w3XX4X9GGVgd+q9i3QjSaA6ND0hvHvnQ1P4rIG+KBlSbML8zRhynP/9dBgzJdAqBDnKAiEr9ZskfwbzTszi2MP7c+fRHo1MvgEt5Ad1dhm86+94SnaWThUeOJyYQgwXzX+J8iY/oLU3ByFSbMJTtKDsGos78idRSodVtTBKgWkLZ6NRaPLzSuF13NA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVNKT3RTbWdNL1BTTnlHVVdLNC9WTDRSbmgyMWIxVktuVkg2SHZ1MUtOaWZQ?=
 =?utf-8?B?WHptVkVEMTBVZkdHL2Y1Z29Gb3I0ZmJzRjloSm4zRE10WGxvS2dxME1mK2w5?=
 =?utf-8?B?TDFQb2liUS9SYk9YYmFBeXJUSkFyS0orTngyUlRCdG9rdnFMYmp1RjdUM2sx?=
 =?utf-8?B?V25adUtUZGF2T1ozNGh0ZlpoUDV6emJYOEdFalpoS0ppa2tCOXkrbm96dDRY?=
 =?utf-8?B?N0gwdVVwSEhjc09mcFB0MjlwYzB1UGdidWV1N3dwVUhhRUJIeGx4eFRaSnBW?=
 =?utf-8?B?NUVNVlZGQkNCWDc3Rk5aYUxQZGQ2cFplTkw3VU9LZHFmc2F1cUxhRzNTS2lt?=
 =?utf-8?B?WWVBdlpBZ0Fiekd1UERmcUN5VkZ3YnFZZ21uOWhuVnhhQ2JsdGtvQlIyZkV3?=
 =?utf-8?B?UGFBMVJLckVqbWp4VmxCNm5qM1h5TWtCcGtDQjFKY0ZwRWo5enRIUTBHRmtY?=
 =?utf-8?B?ODZWRmlGMnQ4MDlOMWNMVzVQaVVYSGN2elJKU3pINEk2RGRKbk5yRkI0ZFNi?=
 =?utf-8?B?WEtPVUdDVEd5VWZXVTdHdU9qQldzc0JIYURjQWIxTk9PZVo0UDlzQlluSWF4?=
 =?utf-8?B?V3RrNXJ1S0VBd1hXU1dvT1lvNFdpcVhmQU12OG96Sk1IWHJKUDZXRjVPeUtT?=
 =?utf-8?B?MXJNbnV2Z09qMXZRU3FDQ29RRmFPbFk0ZVQ4OUZYdjdPcjU3cXR3ZzAyQ25o?=
 =?utf-8?B?TjRPNXZMcFZ4aGZRSVFXN3dONEMxTWtZdU84VUxDOExIMzQrWUpPMmc0UkFT?=
 =?utf-8?B?ODY2UGI4bUQwdDJPdGxTNHZtSFV3K1Z3WitmdkkxUS9DNjZmVWg2QWVMUE41?=
 =?utf-8?B?WGZXTWJDNFFKYi8yNmRMY3kvbG1zMm90bEJPbFgzMVdzS1ArbVB6azhVSlpQ?=
 =?utf-8?B?Qmp5QU9jaW95eUc3cm0zRFNyK3Y1WVJXSk5zelR1STFWRE1VeG1RUVlZUXNE?=
 =?utf-8?B?Uk90MnkrTWlxZ1BVUjVVMXQzSWtQS1ZsNjNCOVhLeGw2NVVML0lpVGJ6dUhN?=
 =?utf-8?B?Q0lOeWkrN1A4RzcvNHpRUjF3QXZ2V2Y4ZnhLalBsOXMrdXZ6NDM4cEpQSDVM?=
 =?utf-8?B?ekpCa2hZQ1gzTThaSnZqaVJGMUhBTFlJVk5SOHlWTHlDWWhkampWODZXb25V?=
 =?utf-8?B?YXVUcS84TVhXbkFCMklUSGdYdTRITDVuckRHQ09ITzFzYTFHaEp6VmoxMU44?=
 =?utf-8?B?aVNLb0Nyd2ZmY1IxcXlKMUQweDBDQjZaNUVyNmMxb24zTlJia1BZQUxLcXpR?=
 =?utf-8?B?RmQ5Wjl5RmZsQWgvellrYkhoVFFUZGxFLzgxeGE1bnpPbWFBR0ViQ2ZHNExG?=
 =?utf-8?B?YXA1bmpGdjdFWTM3WllKR21rOGt1N3hWeGJEOEtiYkNQdlU5c2Zmd1IydXRH?=
 =?utf-8?B?cnpQMmRLMXR3aHF4VHBhOEp4d0dGSnZQQm1lSTUxVFd6UkRUaXJrUkNmZCto?=
 =?utf-8?B?OUFTb2UwdkE2NGdsdFUzOFNjOWdyU0UzZ1pLazlnN21Bd0FkdVdRejlURFhw?=
 =?utf-8?B?a1ArMGIwZ09xelc5bHJOZFRLWCt2dW5rOWhtbU4wWTF6RmFLVWNjTHYraTg3?=
 =?utf-8?B?VWxGcWVzL1dBb2FjOUx5S0d4REwxb01tQUd1UGhCa2tSdW5vNUJoMHEvWXhU?=
 =?utf-8?B?ODB6NWIxQnNTSnVEblVKL2RaSlpPeEtCZkVPSXlVYnkweUJnRWxwTHhNTDJZ?=
 =?utf-8?B?dVJPSy84VDVXK3doUHNoTmQ4VnVnNUpzNjUrNE56MlpIdm1vU01KczZBPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c136ccf4-622f-4b14-4b24-08daf8cfd863
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 21:14:40.3964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9696
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-01-12 11:35, Victoria Dye wrote:

> Matthew John Cheetham via GitGitGadget wrote:
>> From: Matthew John Cheetham <mjcheetham@outlook.com>
>>
>> Extract functions and structures for managing child processes started
>> from the parent daemon-like process from `daemon.c` to the new shared
>> `daemon-utils.{c,h}` files.
> 
> As with patch 1, it looks like the main changes here are changing global
> references to function arguments. Specifically, those variables are
> 'firstborn', 'live_children', and 'loginfo':
> 
>> -static void add_child(struct child_process *cld, struct sockaddr *addr, socklen_t addrlen)
>> +void add_child(struct child_process *cld, struct sockaddr *addr, socklen_t addrlen,
>> +	       struct child *firstborn , unsigned int *live_children)
> 
>> -static void kill_some_child(void)
>> +void kill_some_child(struct child *firstborn)
> 
>> -static void check_dead_children(void)
>> +void check_dead_children(struct child *firstborn, unsigned int *live_children,
>> +			 log_fn loginfo)
> 
> Those values are provided by the callers in 'daemon.c'. The major change
> here is that 'live_children' is passed as a pointer, since its value is
> updated by  difference is passing 'live_children' as a pointer, since its
> value is updated by 'check_dead_children()' and 'add_child()':
> 
>> @@ -879,9 +797,9 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
>>  	struct child_process cld = CHILD_PROCESS_INIT;
>>  
>>  	if (max_connections && live_children >= max_connections) {
>> -		kill_some_child();
>> +		kill_some_child(firstborn);
>>  		sleep(1);  /* give it some time to die */
>> -		check_dead_children();
>> +		check_dead_children(firstborn, &live_children, loginfo);
>>  		if (live_children >= max_connections) {
>>  			close(incoming);
>>  			logerror("Too many children, dropping connection");
>> @@ -914,7 +832,7 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
>>  	if (start_command(&cld))
>>  		logerror("unable to fork");
>>  	else
>> -		add_child(&cld, addr, addrlen);
>> +		add_child(&cld, addr, addrlen, firstborn, &live_children);
>>  }
>>  
>>  static void child_handler(int signo)
>> @@ -944,7 +862,7 @@ static int service_loop(struct socketlist *socklist)
>>  	for (;;) {
>>  		int i;
>>  
>> -		check_dead_children();
>> +		check_dead_children(firstborn, &live_children, loginfo);
>>  
>>  		if (poll(pfd, socklist->nr, -1) < 0) {
>>  			if (errno != EINTR) {
> 
> However, I think that change to 'live_children' may have caused a bug. In
> 'check_dead_children()', you decrement the 'live_children' *pointer*. That
> changes its address, not its value:
> 
>> +void check_dead_children(struct child *firstborn, unsigned int *live_children,
>> +			 log_fn loginfo)
>> +{
> ...
>> +			live_children--;
> ...
>> +}
> 
> Same thing in 'add_child()':
> 
>> +void add_child(struct child_process *cld, struct sockaddr *addr, socklen_t addrlen,
>> +	       struct child *firstborn , unsigned int *live_children)
>> +{
> ...
>> +	live_children++;
> ...
>> +}
> 
> These should be changed to '(*live_children)--' and '(*live_children)++',
> respectively.

Ah! You are correct; my bad. Will correct this in v6.

> There's also one minor functional change in 'check_dead_children()', where
> an 'if (loginfo)' check is added guarding the call to 'loginfo()':
> 
>> +void check_dead_children(struct child *firstborn, unsigned int *live_children,
>> +			 log_fn loginfo)
>> +{
> ...
>> +			if (loginfo) {
>> +				const char *dead = "";
>> +				if (status)
>> +					dead = " (with error)";
>> +				loginfo("[%"PRIuMAX"] Disconnected%s",
>> +					(uintmax_t)pid, dead);
>> +			}
> ...
>> +}
> 
> I'm guessing this is done because a caller later in the series won't provide
> a 'loginfo', but if that's the case, it would help to note that in this
> patch's commit message.

Will call this out in the commit message in v6.

> The one other thing I noticed is that you removed the function documentation
> for 'kill_some_child()':
> 
>> -/*
>> - * This gets called if the number of connections grows
>> - * past "max_connections".
>> - *
>> - * We kill the newest connection from a duplicate IP.
>> - */
> 
> Is there a reason why you removed it? Otherwise, it should be added back in
> - probably in 'daemon-utils.h'?

I removed it initially as it was referencing things like `max_connections`
which no longer existed in the context of `daemon-utils.{c,h}`.

Next iteration I can restore the spirit of the comment, that this should be
called when the maximimum number of connections has been reached, in order
to kill the newest connection from a duplicate IP.

> Everything else here looks good.

Thanks,
Matthew
