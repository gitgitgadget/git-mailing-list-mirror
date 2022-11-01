Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F89C4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 23:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiKAX70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 19:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKAX7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 19:59:24 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2031.outbound.protection.outlook.com [40.92.91.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D04D2CF
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 16:59:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOtq2rtxZdQxTtvkvy/+nvyW1oyt7g0mX0kBpz9XapNIn1t1YFvS2I6oitSfXuH2rN/LGSpi/fW6asUxh3MbD+B3nxYxaIwdpydw1Ziuy89x4eJEYnjn6qHMYFqnDKz581dpv7xAXHeTMrNDESp8gCjC5yzNBPI0QPINfefqWX68fv0B5l2vT2T/0Yh2vP3iwpvJTYPQFd424D0IiLpaitq2RzY8YuQqU8Umca1pFnIgqXtvCCNXSZgbkYvuBjw+o0L7iRNcTXAAGmkEPXt+AvsX5+kBlf4rYdT6XSZtAExr1WBIpG5nO4nxymCgE5+cANA6M5I6yqABHEVBmgrgBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6oCb/2Ok1ylZ4IG17J2K4V7ZllBRVW7DTz1u14rsLdc=;
 b=OGf1lLhIQtv5t+aEEd1EtVUisfh3ruDI2Mthl1NHszhZ1Ui78KKsWky3BSRdfyKnktmBcDfoYt8qPKBZJMNrxRQ4vmtFkIajeOsDTUl68v2Eg20BCby0ssGDzb85dJT+FYfacR//oW+pfPQZpOnLzweCyWiy9dn7fCaxaKx/BszOL9aDxkuNVcEJx3QO6vdfB7h1+dOMZ+QkbdP3Y1ASWzSAtpP/lNy4g3ROQkevm0NfH23Vw9loQwPmkqSmDyK2oZncwRyXoghChg5ewnx3zTVz6TojQ7YR7h9a8s2DsAMKccqNLLQzxDqYZSyWEyYNh1bS24tPSbfWcpMQB8YXGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oCb/2Ok1ylZ4IG17J2K4V7ZllBRVW7DTz1u14rsLdc=;
 b=e7nj3MkdVI1n/7Pp+51RQPMNzxqwipPJGE8hFmTToU6+4y/M7vOTgPCCpknKsoXnJHgyBRps206+J90JDInYsMIk1g9FUnSOS0pI3tE0pKcqpMqo8kunOcW2NMLpIFleyYhbMhz4vQQ7aSMB2ISZPwkLodKLwRoGfgR0+uu5p9v1PZWdMF7gvkCRhCm4zGQ+FvLeCwPC3T+l4Xz+aF6YWqrPqO/wP+Md7iKhUszR/Ehm8Ppwtm4SU0KDhcOR4t4zF+3neZg6oNlrIlCQmRfCKKriarAuHjV5/980jUybmydJIgAISLjgwJ9MQiZCTahribidZtqHhed9yph+mS9aSg==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by PA4PR03MB6910.eurprd03.prod.outlook.com (2603:10a6:102:e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Tue, 1 Nov
 2022 23:59:19 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::a3b1:6b8c:97ce:8e66]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::a3b1:6b8c:97ce:8e66%3]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 23:59:19 +0000
Message-ID: <AS2PR03MB9815B1AA9C780D650BD88FA2C0369@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Tue, 1 Nov 2022 16:59:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH v2 6/6] t5556-http-auth: add test for HTTP auth hdr logic
To:     Derrick Stolee <derrickstolee@github.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
 <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
 <f3f13ed8c8238f396163dd0e6a3d6c948c2b879b.1666372083.git.gitgitgadget@gmail.com>
 <8593dd49-4d95-ed4f-b414-8170efc138d4@github.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <8593dd49-4d95-ed4f-b414-8170efc138d4@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [j8tuAgI1fNmAqkzR7qY0qZtKA5RYEwaHnpYDDkxAicZ/6e6X7M4ygL2WK2LPR3bT]
X-ClientProxiedBy: BYAPR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:74::17) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <2b89450a-034c-76d8-7324-18f6e9c4e3f1@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|PA4PR03MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: 27573f12-4cdd-4d8f-b63c-08dabc6516da
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NGs0bC809FGOXevoDcimrDZD2KYOdGOXKuenSBQTPZV8ti4E2orOGhBZQUeVsEAPUfpX75nNjQpbT8wn5yXiFCqHvd5YvuZ8EJiLBfKMZPXSQq4Uga8nSsDRIJmR7tyX2mOOV/0IKk946uYY/gsF609+GrFRHN4IlqF7+h4AW6sc6lJPQmQRLRTOVQOco/lxapeZ+sw8bohceQD//Rf8x6ss8fZkHypTbWMT05y/4n5LE02IJQjTGsJ9IfuOgnThFLtq9bY3/ux+EAwWro0YhiesovkCGJmmhoSzT9IXClqPaES9uj2PY+6H+TcuyVg8g9V3dFdrAaIFTFdhobuNi0WecKaPEQ4yh55/+lVZJmSqRdSYVAM+4O0k34zYhlcI8vx0LYPI/Aj+XnlGrgo/f9b/9kFvgZZn7oRTWGV+cGr02ecUiOIkq4YyQIuvAj2kcctRrOoycQEb+w2sHsXI9d00vYqZHgiJJJyVYIOJIaFe3JFJsli89+7iT0vofYnFHbjZpHt8XDKM8RLs4J+NoVrXS4MFqtDOQtM1WcArzrymK1a376vqhHLvtFcilL94HSCpQys+IiSKqL58S7BTAzohZJRE/Fun7CeyfvAlWByKBrrk4bOuuLEEi9zYr+VpFHDcWP6jCvTU3hQapaH72J1VMpC43fags0LPGpAg1AKu2c203QSQTjnT4RVLMMFa
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2hBeDJsNnhEQ3RoUWwxcVdiS2Q0cDk5dWtwcU0yUkxCanlyZFdCRVNyN1Q2?=
 =?utf-8?B?OUwxWHVwQk10K01waHo4L2ZpTGpXOWtkbFZpY2ZuYWFVT25sTmI5cWE0akVv?=
 =?utf-8?B?eU81NmdFaWkrcHVlc0hqMHV4eTU4SnNXT1QwV3BuSE5XN0NHaDVyL1JBV1o4?=
 =?utf-8?B?YWJZWXZ4cnR5eTE4NWQvb3dTTjdSMVlqYnBRbVZQSENGaTAybGlKS0R6aG93?=
 =?utf-8?B?ajkrSm90OEdQM3JWc2FPekFlZGJDaGg1VVV2WXlCQUtkVndlQXdsRTlzMlVo?=
 =?utf-8?B?N3VIcjRsN1hBUFFxSkk5V0lGV0c3UHNaSmFQdFlxUG03czRXMVdkWlFZby9P?=
 =?utf-8?B?aHpGc3dlSjRMTFVzRHE1K29rSGVselJ3MlZmK2J6cDk3U3dGOVNpeC9ISWIz?=
 =?utf-8?B?Y2doVExRV00ybk0wQ1ZndUtXdWZVL1ZmWDNRdlA0UmhaajlLaGJLQ0hHU2Ew?=
 =?utf-8?B?WHpuODJaby9DQUdpZldTejBpeTEzQU4xM3JnK0R0YXRjRXR0cmYzSjFWaGpL?=
 =?utf-8?B?eXN0Q1VhRmpvaHNOMlp1ZjVKa1pUaFgvVWpLc1cyZmpyUW9VNEw2RElweDlo?=
 =?utf-8?B?NnZhL1JtVEVWVExlUjlrNzFFWjFlVXlIYnNDL25lanZ3RGE3bnZvcE41WEN0?=
 =?utf-8?B?K2UySU5VUUgwQzE5SHB1YnNIY2JuT2E0R2pRNEpSZm5iSTlsMHFFM2RtSnBO?=
 =?utf-8?B?OFZVOFBVRnRYekxYSzE5SC9qZkx3SGQxcWkwNzlOTGlpTWNzWTgzR1gxVktT?=
 =?utf-8?B?Rk5ZbUNzem9OQTNGWG5TTGwxYy8vNnZ1Qmh3STZVSVBQM3JCSU82M2c5SjhV?=
 =?utf-8?B?QzNlTjBUVVVXTlRuZjJyVlY5OUhUYUxwZkZ5ZGp2S003V1Y5L0RKRDFLaG95?=
 =?utf-8?B?RXBjKzdTUzd1MjZ1NHdBNHd2T3NxaG5YSmlPM0NDUEFmWjhkYWhTQTRrN29t?=
 =?utf-8?B?dWxSTmNtZHZCMCs0cjdXM1lyczNHZWEydlBGakxENWdhSzZ6M1YzSGJTMTNR?=
 =?utf-8?B?ZDNuTHBjcllsRHpxdmhHWXBuUjFlYyt2Y3lXeE9JcGJ3Zzg1aDk5czRJZUF5?=
 =?utf-8?B?ZDFWOVZJNHE4blRmMEM1ZzBCQjl0M3BoNFNsUkxKRTM4SW9RTDJHQ2VQb3p0?=
 =?utf-8?B?bVVaOTZnNFVIdklFTTV0ZFZQZGloM2RJQkltd0FOUkx5YXREZHJiSTlpTk9r?=
 =?utf-8?B?YlB6UVRuUjcyMzd3ZEozOHhFaWZwVE5HMlRxZDFpa1RBVXUvc29DWGduaDJ4?=
 =?utf-8?B?NXNVdlQ2emJXVnpoWm11QjY3NTZvVWoyZktaQWl5ck5aZUQvQU54eDh1amtY?=
 =?utf-8?B?ZWN1eEFGdUdQRkM5YnlWbmloNDZLUS9IMEFuakFtdHdhUThBaDB1NFRMWCtO?=
 =?utf-8?B?VGV1NWticXl2WllYdFVEZzk5elJ6R0dCcndsOSs1UzRocHVkcmtWeE1hNU41?=
 =?utf-8?B?bFhNamw0SHZZNkpRcHFpeDlreXN4bk1na3FCTGRjaGhQN0Y1U2VqK0FCQmhS?=
 =?utf-8?B?UlY1NWp2TC9BR1hTNXcxUjVwUjUwTU5ockQ4UHgyQU5OVlpNRG5jTklRYnNV?=
 =?utf-8?B?cjE1a2NCWEFhSFNlWmVlWm11d1VmNnhsVldNYm5lUGt4MGl6ZWlWWEt1bVUr?=
 =?utf-8?B?MldIQVJpdC9OUk9MM1htNzB4Rmc2cE5uSkFseEYvWkxEQTVUL1cyWjNxSTVk?=
 =?utf-8?B?dW9zVmM4UGdGcTZmOVNjQXF1V1c1RUhyYUtZM1doY3FWWmRtRnVUOHJOenRy?=
 =?utf-8?B?N2svMzBSR0dIbk5kMjVQYlI3STFsSjFGR0V1Mk9WK0xFYW0rRlZtb1Fma3Fy?=
 =?utf-8?B?MEpYaDlSSGR5cUVkWFRzUT09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27573f12-4cdd-4d8f-b63c-08dabc6516da
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 23:59:19.4714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB6910
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-10-28 08:08, Derrick Stolee wrote:
> On 10/21/22 1:08 PM, Matthew John Cheetham via GitGitGadget wrote:
>> From: Matthew John Cheetham <mjcheetham@outlook.com>
> 
>> @@ -1500,6 +1500,8 @@ else
>>  	endif
>>  	BASIC_CFLAGS += $(CURL_CFLAGS)
>>  
>> +	TEST_PROGRAMS_NEED_X += test-http-server
>> +
>>  	REMOTE_CURL_PRIMARY = git-remote-http$X
>>  	REMOTE_CURL_ALIASES = git-remote-https$X git-remote-ftp$X git-remote-ftps$X
>>  	REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
> 
> This hunk is in the "else" block of "ifdef NO_CURL",
> so this makes sense for why TEST_PROGRAMS_NEED_X is
> augmented here, away from other instances.
> 
>> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
>> index 787738e6fa3..45251695ce0 100644
>> --- a/contrib/buildsystems/CMakeLists.txt
>> +++ b/contrib/buildsystems/CMakeLists.txt
>> @@ -989,6 +989,19 @@ set(wrapper_scripts
>>  set(wrapper_test_scripts
>>  	test-fake-ssh test-tool)
>>  
>> +if(CURL_FOUND)
>> +       list(APPEND wrapper_test_scripts test-http-server)
>> +
>> +       add_executable(test-http-server ${CMAKE_SOURCE_DIR}/t/helper/test-http-server.c)
>> +       target_link_libraries(test-http-server common-main)
>> +
>> +       if(MSVC)
>> +               set_target_properties(test-http-server
>> +                                       PROPERTIES RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/t/helper)
>> +               set_target_properties(test-http-server
>> +                                       PROPERTIES RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/t/helper)
>> +       endif()
>> +endif()
> 
> And this file has the pattern of many "if(CURL_FOUND)"
> blocks with isolated purposes, so it makes sense to
> have this be an isolated change instead of grouped with
> a different case.
> 
>> diff --git a/t/helper/.gitignore b/t/helper/.gitignore
>> index 8c2ddcce95f..1a94ab6eed5 100644
>> --- a/t/helper/.gitignore
>> +++ b/t/helper/.gitignore
>> @@ -1,2 +1,3 @@
>>  /test-tool
>>  /test-fake-ssh
>> +test-http-server
> 
> Should this start with a "/" like the other entries?

That it probably should! Will update.

>> diff --git a/t/helper/test-credential-helper-replay.sh b/t/helper/test-credential-helper-replay.sh
>> new file mode 100755
>> index 00000000000..03e5e63dad6
>> --- /dev/null
>> +++ b/t/helper/test-credential-helper-replay.sh
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
> 
> Should this be a helper method within another script, such
> as t/lib-credential.sh or t/lib-httpd.sh? The read over
> stdin will still work, as in this example:
> 
> read_chunk() {
> 	while read line; do
> 		case "$line" in
> 		--) break ;;
> 		*) echo "$line" ;;
> 		esac
> 	done
> }

This script file is used as a credential helper that is invoked by Git.
We specify that Git should use this credential helper in the tests using
the -c option:

  CREDENTIAL_HELPER="$GIT_BUILD_DIR/t/helper/test-credential-helper-replay.sh" \
	  && export CREDENTIAL_HELPER
..
   git -c credential.helper="$CREDENTIAL_HELPER" ls-remote $ORIGIN_URL &&


Would extracting a read_chunk() function to one of the lib-* test scripts
be worth it given we already need another entry script anyway?

What other scripts would be calling read_chunk()?


>> diff --git a/t/helper/test-http-server.c b/t/helper/test-http-server.c
> 
>> @@ -0,0 +1,1134 @@
>> +#include "config.h"
>> +#include "run-command.h"
>> +#include "strbuf.h"
>> +#include "string-list.h"
>> +#include "trace2.h"
>> +#include "version.h"
>> +#include "dir.h"
>> +#include "date.h"
>> +
>> +#define TR2_CAT "test-http-server"
>> +
>> +static const char *pid_file;
>> +static int verbose;
>> +static int reuseaddr;
>> +
>> +static const char test_http_auth_usage[] =
>> +"http-server [--verbose]\n"
>> +"           [--timeout=<n>] [--init-timeout=<n>] [--max-connections=<n>]\n"
>> +"           [--reuseaddr] [--pid-file=<file>]\n"
>> +"           [--listen=<host_or_ipaddr>]* [--port=<n>]\n"
>> +"           [--anonymous-allowed]\n"
>> +"           [--auth=<scheme>[:<params>] [--auth-token=<scheme>:<token>]]*\n"
>> +;
> 
> These are a lot of options to implement all at once. They are probably
> simple enough, but depending on the implementation and tests, it might
> be helpful to split this patch into smaller ones that introduce these
> options along with the tests that exercise each. That will help
> verify that they are being tested properly instead of needing to track
> back and forth across the patch for each one.

I plan to split this patch in to several in a v3.

>> +
>> +/* Timeout, and initial timeout */
>> +static unsigned int timeout;
>> +static unsigned int init_timeout;
>> +
>> +static void logreport(const char *label, const char *err, va_list params)
>> +{
>> +	struct strbuf msg = STRBUF_INIT;
>> +
>> +	strbuf_addf(&msg, "[%"PRIuMAX"] %s: ", (uintmax_t)getpid(), label);
>> +	strbuf_vaddf(&msg, err, params);
>> +	strbuf_addch(&msg, '\n');
>> +
>> +	fwrite(msg.buf, sizeof(char), msg.len, stderr);
>> +	fflush(stderr);
>> +
>> +	strbuf_release(&msg);
>> +}
>> +
>> +__attribute__((format (printf, 1, 2)))
>> +static void logerror(const char *err, ...)
>> +{
>> +	va_list params;
>> +	va_start(params, err);
>> +	logreport("error", err, params);
>> +	va_end(params);
>> +}
>> +
>> +__attribute__((format (printf, 1, 2)))
>> +static void loginfo(const char *err, ...)
>> +{
>> +	va_list params;
>> +	if (!verbose)
>> +		return;
>> +	va_start(params, err);
>> +	logreport("info", err, params);
>> +	va_end(params);
>> +}
> 
> I wonder how much of this we need or is just a nice thing. I would
> err on the side of making things as simple as possible, but being
> able to debug this test server may be important based on your
> experience.

These are useful to debug failures. Plus they also come from my copy
from daemon.c, so didn't want to touch/delete too much from that
starting point.

>> +static void set_keep_alive(int sockfd)
>> +{
>> +	int ka = 1;
>> +
>> +	if (setsockopt(sockfd, SOL_SOCKET, SO_KEEPALIVE, &ka, sizeof(ka)) < 0) {
>> +		if (errno != ENOTSOCK)
>> +			logerror("unable to set SO_KEEPALIVE on socket: %s",
>> +				strerror(errno));
>> +	}
>> +}
>> +
>> +//////////////////////////////////////////////////////////////////
>> +// The code in this section is used by "worker" instances to service
>> +// a single connection from a client.  The worker talks to the client
>> +// on 0 and 1.
>> +//////////////////////////////////////////////////////////////////
> 
> Use /* */ style comments. You can repeat the asterisks to get a
> similar visual block.

Yep!

>> +
>> +enum worker_result {
>> +	/*
>> +	 * Operation successful.
>> +	 * Caller *might* keep the socket open and allow keep-alive.
>> +	 */
>> +	WR_OK       = 0,
>> +	/*
>> +	 * Various errors while processing the request and/or the response.
>> +	 * Close the socket and clean up.
>> +	 * Exit child-process with non-zero status.
>> +	 */
>> +	WR_IO_ERROR = 1<<0,
>> +	/*
>> +	 * Close the socket and clean up.  Does not imply an error.
>> +	 */
>> +	WR_HANGUP   = 1<<1,
> 
> nit: add a whitespace line between an item and the next
> item's comment.

Sure

>> +
>> +	WR_STOP_THE_MUSIC = (WR_IO_ERROR | WR_HANGUP),
>> +};
> 
> (I read, but have no comments on the http-server boilerplate.)
> 
>> +
>> +enum auth_result {
>> +	AUTH_UNKNOWN = 0,
>> +	AUTH_DENY = 1,
>> +	AUTH_ALLOW = 2,
>> +};
>> +
>> +struct auth_module {
>> +	const char *scheme;
>> +	const char *challenge_params;
> 
> Later, I notice that you set challenge_params using an
> xstrdup() so this shouldn't be const and you should
> free it in any freeing code.

One question on this suggestion.. where would be appropriate to
free said char*? We need them for the lifetime of the process,
and they never grown in number beyond initial allocation from
parsing command line args.

I could move to stack alloc these in `cmd_main` and instead pass
a pointer to the `auth_modules` and count down through every
serve/handle etc function, rather than rely on them being global?

Thoughts or preferences?

>> +	struct string_list *tokens;
>> +};
>> +
>> +static int allow_anonymous;
>> +static struct auth_module **auth_modules = NULL;
>> +static size_t auth_modules_nr = 0;
>> +static size_t auth_modules_alloc = 0;
> 
> So, we are setting up a number of potential auth modules,
> each of which has a scheme to match a request to the module,
> and a list of tokens that would be considered worthy of the
> AUTH_ALLOW result. Otherwise, if the scheme matches but no
> token matches, we get AUTH_DENY. Finally, if no scheme matches
> we get AUTH_UNKNOWN.
> 
> This concept might be worth a comment here around the data
> structures before we get into how that is implemented.
> 
>> +static struct auth_module *get_auth_module(struct strbuf *scheme)
>> +{
>> +	int i;
>> +	struct auth_module *mod;
>> +	for (i = 0; i < auth_modules_nr; i++) {
>> +		mod = auth_modules[i];
>> +		if (!strcasecmp(mod->scheme, scheme->buf))
>> +			return mod;
>> +	}
>> +
>> +	return NULL;
>> +}
> 
> Matching the input scheme against the list of modules.
> 
> Only complaint: there is no reason that 'scheme' needs t
> be a strbuf, but could be a 'const char *' here.

True.

>> +static void add_auth_module(struct auth_module *mod)
>> +{
>> +	ALLOC_GROW(auth_modules, auth_modules_nr + 1, auth_modules_alloc);
>> +	auth_modules[auth_modules_nr++] = mod;
>> +}
> 
> nit: this could be located earlier, next to the list
> definition, or delayed until it is needed. That would
> allow get_auth_module() to be closer to its first use.

Not sure I follow.. are you saying I should move `add_auth_module`
to earlier in the file?

>> +static int is_authed(struct req *req, const char **user, enum worker_result *wr)
>> +{
>> +	enum auth_result result = AUTH_UNKNOWN;
>> +	struct string_list hdrs = STRING_LIST_INIT_NODUP;
>> +	struct auth_module *mod;
>> +
>> +	struct string_list_item *hdr;
>> +	struct string_list_item *token;
>> +	const char *v;
>> +	struct strbuf **split = NULL;
>> +	int i;
>> +	char *challenge;
>> +
>> +	/* ask all auth modules to validate the request */
>> +	for_each_string_list_item(hdr, &req->header_list) {
>> +		if (skip_iprefix(hdr->string, "Authorization: ", &v)) {
>> +			split = strbuf_split_str(v, ' ', 2);
>> +			if (!split[0] || !split[1]) continue;
> 
> For each valid request header...
> 
>> +			// trim trailing space ' '
>> +			strbuf_setlen(split[0], split[0]->len - 1);
>> +
>> +			mod = get_auth_module(split[0]);
>> +			if (mod) {
> 
> ...get an appropriate module, if it exists...
> 
>> +
>> +				for_each_string_list_item(token, mod->tokens) {
>> +					if (!strcmp(split[1]->buf, token->string)) {
>> +						result = AUTH_ALLOW;
>> +						goto done;
>> +					}
>> +				}
>> +
>> +				if (result != AUTH_UNKNOWN)
>> +					goto done;
> 
> ...and report if we find a valid token.
> 
> Here, it seems I was wrong in my expectation of AUTH_DENY:
> if a matching module exists but no token exists in that
> module, then we keep searching other modules. 

AUTH_DENY denies a request immediately and stops searching other modules.
AUTH_ALLOW approves the request and stops looking at other modules.
AUTH_UNKNOWN means this module didn't match or 'decide' to reject, so keep
looking/asking other modules.

After reading you review, I think it may be better to change this to
more closely match your expectations (and how typical servers behave):

Return AUTH_ALLOW if we find a matching valid token for the module.
If we match a module and do NOT find a token, then return AUTH_DENY.
Otherwise return AUTH_UNKNOWN - this means the user provided some auth
mechanism we don't understand, or no auth at all.

>> +			}
>> +		}
>> +	}
>> +
>> +done:
>> +	switch (result) {
>> +	case AUTH_ALLOW:
>> +		trace2_printf("%s: auth '%s' ALLOW", TR2_CAT, mod->scheme);
>> +		*user = "VALID_TEST_USER";
>> +		*wr = WR_OK;
>> +		break;
>> +
>> +	case AUTH_DENY:
>> +		trace2_printf("%s: auth '%s' DENY", TR2_CAT, mod->scheme);
>> +		/* fall-through */
> 
> I'm not sure that I see a case where this is possible. Maybe
> we should have a 'result = AUTH_DENY' at the start of the
> "if (mod)" block, followed by a 'goto done' in all cases
> instead of "if (result != AUTH_UNKNOWN)"?

In this version, you're correct.. AUTH_DENY is never returned.
This tri-state response from an auth module is an oversight from an earlier
local version - sorry for the confusion here, and thanks for catching!
I will update in a v3 to match sane expectations.

>> +	case AUTH_UNKNOWN:
>> +		if (allow_anonymous)
>> +			break;
> 
> If we do not require auth, then we want to continue if there
> is no matching authentication.
> 
>> +		for (i = 0; i < auth_modules_nr; i++) {
>> +			mod = auth_modules[i];
>> +			if (mod->challenge_params)
>> +				challenge = xstrfmt("WWW-Authenticate: %s %s",
>> +						    mod->scheme,
>> +						    mod->challenge_params);
>> +			else
>> +				challenge = xstrfmt("WWW-Authenticate: %s",
>> +						    mod->scheme);
>> +			string_list_append(&hdrs, challenge);
>> +		}
>> +		*wr = send_http_error(1, 401, "Unauthorized", -1, &hdrs, *wr);
> 
> However, here is the critical piece about how servers will
> start to act with the new WWW-Authenticate header usage in
> the Git credential helper interface. This will be critical
> in the testing for Git to retry the credential helper while
> passing these authentications schemes from the installed
> modules.
> 
>> +	}
>> +
>> +	strbuf_list_free(split);
>> +	string_list_clear(&hdrs, 0);
>> +
>> +	return result == AUTH_ALLOW ||
>> +	      (result == AUTH_UNKNOWN && allow_anonymous);
> 
> Did it work? Or did it not need to work? I'm interested to
> investigate the case that the client sent an authentication
> header that matches a module but doesn't match any tokens,
> but we allow anonymous access, anyway. Is that a 400? Or
> is that a 401?

It should probably be a 401 as the credentials are understood, but
are just 'bad'.

>> +static enum worker_result dispatch(struct req *req)
>> +{
>> +	enum worker_result wr = WR_OK;
>> +	const char *user = NULL;
>> +
>> +	if (!is_authed(req, &user, &wr))
>> +		return wr;
> 
> If we are not authed, send the 401 response.
> 
>> +	if (is_git_request(req))
>> +		return do__git(req, user);
> 
> If we are authed, then pass through to the Git response.
> 
>> +	return send_http_error(1, 501, "Not Implemented", -1, NULL,
>> +			       WR_OK | WR_HANGUP);
> 
> If the Git request fails, we don't care. This is a test.
> Just pass a 500-level error and the client will barf,
> letting us know that something went wrong.

Correct assessment!

>> +static void kill_some_child(void)
> 
>> +static void check_dead_children(void)
> 
> These technically sound methods have unfortunate names.
> Using something like "connection" over "child" might
> alleviate some of the horror. (I initially wanted to
> suggest "subprocess" but you compare live_children to
> max_connections in the next method, so connection seemed
> appropriate.)

These are copied exactly from git-daemon, so I'd rather
avoid the churn in renaming things.

>> +static struct strvec cld_argv = STRVEC_INIT;
>> +static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
>> +{
>> +	struct child_process cld = CHILD_PROCESS_INIT;
>> +
>> +	if (max_connections && live_children >= max_connections) {
>> +		kill_some_child();
>> +		sleep(1);  /* give it some time to die */
>> +		check_dead_children();
>> +		if (live_children >= max_connections) {
>> +			close(incoming);
>> +			logerror("Too many children, dropping connection");
>> +			return;
>> +		}
>> +	}
> 
> Do we anticipate exercising concurrent requests in our
> tests? Perhaps it's not worth putting a cap on the
> connection count so we can keep the test helpers simple.

Probably not, but again.. 100% of the boilerplate here came from
the prior art in daemon.c, so didn't want to touch any of it!
I'm happy to start deleting things however if needed?

>> +	if (addr->sa_family == AF_INET) {
>> +		char buf[128] = "";
>> +		struct sockaddr_in *sin_addr = (void *) addr;
>> +		inet_ntop(addr->sa_family, &sin_addr->sin_addr, buf, sizeof(buf));
>> +		strvec_pushf(&cld.env, "REMOTE_ADDR=%s", buf);
>> +		strvec_pushf(&cld.env, "REMOTE_PORT=%d",
>> +				 ntohs(sin_addr->sin_port));
>> +#ifndef NO_IPV6
>> +	} else if (addr->sa_family == AF_INET6) {
>> +		char buf[128] = "";
>> +		struct sockaddr_in6 *sin6_addr = (void *) addr;
>> +		inet_ntop(AF_INET6, &sin6_addr->sin6_addr, buf, sizeof(buf));
>> +		strvec_pushf(&cld.env, "REMOTE_ADDR=[%s]", buf);
>> +		strvec_pushf(&cld.env, "REMOTE_PORT=%d",
>> +				 ntohs(sin6_addr->sin6_port));
>> +#endif
>> +	}
>> +
>> +	strvec_pushv(&cld.args, cld_argv.v);
>> +	cld.in = incoming;
>> +	cld.out = dup(incoming);
>> +
>> +	if (cld.out < 0)
>> +		logerror("could not dup() `incoming`");
>> +	else if (start_command(&cld))
>> +		logerror("unable to fork");
>> +	else
>> +		add_child(&cld, addr, addrlen);
>> +}
>> +
> 
> I scanned the socket creation code, but my eyes were
> glazing over. I'm definitely in the camp of "if it works,
> that's enough for our tests." If we start to rely on this
> test harness in more places, we can improve any shortcomings
> as they arise.
> 
>> +//////////////////////////////////////////////////////////////////
>> +// This section is executed by both the primary instance and all
>> +// worker instances.  So, yes, each child-process re-parses the
>> +// command line argument and re-discovers how it should behave.
>> +//////////////////////////////////////////////////////////////////
>> +
>> +int cmd_main(int argc, const char **argv)
>> +{
>> +	int listen_port = 0;
>> +	struct string_list listen_addr = STRING_LIST_INIT_NODUP;
>> +	int worker_mode = 0;
>> +	int i;
>> +	struct auth_module *mod = NULL;
>> +
>> +	trace2_cmd_name("test-http-server");
>> +	setup_git_directory_gently(NULL);
>> +
>> +	for (i = 1; i < argc; i++) {
>> +		const char *arg = argv[i];
>> +		const char *v;
>> +
>> +		if (skip_prefix(arg, "--listen=", &v)) {
>> +			string_list_append(&listen_addr, xstrdup_tolower(v));
>> +			continue;
>> +		}
>> +		if (skip_prefix(arg, "--port=", &v)) {
>> +			char *end;
>> +			unsigned long n;
>> +			n = strtoul(v, &end, 0);
>> +			if (*v && !*end) {
>> +				listen_port = n;
>> +				continue;
>> +			}
>> +		}
>> +		if (!strcmp(arg, "--worker")) {
>> +			worker_mode = 1;
>> +			trace2_cmd_mode("worker");
>> +			continue;
>> +		}
>> +		if (!strcmp(arg, "--verbose")) {
>> +			verbose = 1;
>> +			continue;
>> +		}
>> +		if (skip_prefix(arg, "--timeout=", &v)) {
>> +			timeout = atoi(v);
>> +			continue;
>> +		}
>> +		if (skip_prefix(arg, "--init-timeout=", &v)) {
>> +			init_timeout = atoi(v);
>> +			continue;
>> +		}
>> +		if (skip_prefix(arg, "--max-connections=", &v)) {
>> +			max_connections = atoi(v);
>> +			if (max_connections < 0)
>> +				max_connections = 0; /* unlimited */
>> +			continue;
>> +		}
>> +		if (!strcmp(arg, "--reuseaddr")) {
>> +			reuseaddr = 1;
>> +			continue;
>> +		}
>> +		if (skip_prefix(arg, "--pid-file=", &v)) {
>> +			pid_file = v;
>> +			continue;
>> +		}
> 
> ok, most of these arguments are actually about the per-connection
> subprocesses.
> 
>> +		if (skip_prefix(arg, "--allow-anonymous", &v)) {
>> +			allow_anonymous = 1;
>> +			continue;
>> +		}
> 
> Here is how we choose to allo anonymous access.
> 
>> +		if (skip_prefix(arg, "--auth=", &v)) {
>> +			struct strbuf **p = strbuf_split_str(v, ':', 2);
>> +
>> +			if (!p[0]) {
>> +				error("invalid argument '%s'", v);
>> +				usage(test_http_auth_usage);
>> +			}
>> +
>> +			// trim trailing ':'
>> +			if (p[1])
>> +				strbuf_setlen(p[0], p[0]->len - 1);
>> +
>> +			if (get_auth_module(p[0])) {
>> +				error("duplicate auth scheme '%s'\n", p[0]->buf);
>> +				usage(test_http_auth_usage);
>> +			}
>> +
>> +			mod = xmalloc(sizeof(struct auth_module));
>> +			mod->scheme = xstrdup(p[0]->buf);
>> +			mod->challenge_params = p[1] ? xstrdup(p[1]->buf) : NULL;
> 
> Here, you xstrdup() into a 'const char *', but you are really
> passing ownership so it shouldn't be conts.
Ok

> 
>> +			mod->tokens = xmalloc(sizeof(struct string_list));
> 
> nit: this could also be "CALLOC_ARRAY(mod->tokens, 1);"
Sure!
>> +			string_list_init_dup(mod->tokens);
>> +
>> +			add_auth_module(mod);
>> +
>> +			strbuf_list_free(p);
>> +			continue;
> 
> Ok, we gain the auth schemes from the command line.
> 
>> +		}
>> +		if (skip_prefix(arg, "--auth-token=", &v)) {
>> +			struct strbuf **p = strbuf_split_str(v, ':', 2);
>> +			if (!p[0]) {
>> +				error("invalid argument '%s'", v);
>> +				usage(test_http_auth_usage);
>> +			}
>> +
>> +			if (!p[1]) {
>> +				error("missing token value '%s'\n", v);
>> +				usage(test_http_auth_usage);
>> +			}
>> +
>> +			// trim trailing ':'
> 
> Use /* */ (Aside: I'm surprised we don't have a build option in
> DEVELOPER=1 that catches the use of these comments.)
Me too! Appologies here.
>> +			strbuf_setlen(p[0], p[0]->len - 1);
>> +
>> +			mod = get_auth_module(p[0]);
>> +			if (!mod) {
>> +				error("auth scheme not defined '%s'\n", p[0]->buf);
>> +				usage(test_http_auth_usage);
>> +			}
>> +
>> +			string_list_append(mod->tokens, p[1]->buf);
>> +			strbuf_list_free(p);
>> +			continue;
>> +		}
> 
> And the token lists. It is important that the scheme is added
> before any token is added.
> 
>> +		fprintf(stderr, "error: unknown argument '%s'\n", arg);
>> +		usage(test_http_auth_usage);
>> +	}
>> +
>> +	/* avoid splitting a message in the middle */
>> +	setvbuf(stderr, NULL, _IOFBF, 4096);
>> +
>> +	if (listen_port == 0)
>> +		listen_port = DEFAULT_GIT_PORT;
>> +
>> +	/*
>> +	 * If no --listen=<addr> args are given, the setup_named_sock()
>> +	 * code will use receive a NULL address and set INADDR_ANY.
>> +	 * This exposes both internal and external interfaces on the
>> +	 * port.
>> +	 *
>> +	 * Disallow that and default to the internal-use-only loopback
>> +	 * address.
>> +	 */
>> +	if (!listen_addr.nr)
>> +		string_list_append(&listen_addr, "127.0.0.1");
>> +
>> +	/*
>> +	 * worker_mode is set in our own child process instances
>> +	 * (that are bound to a connected socket from a client).
>> +	 */
>> +	if (worker_mode)
>> +		return worker();
>> +
>> +	/*
>> +	 * `cld_argv` is a bit of a clever hack. The top-level instance
>> +	 * of test-http-server does the normal bind/listen/accept stuff.
>> +	 * For each incoming socket, the top-level process spawns
>> +	 * a child instance of test-http-server *WITH* the additional
>> +	 * `--worker` argument. This causes the child to set `worker_mode`
>> +	 * and immediately call `worker()` using the connected socket (and
>> +	 * without the usual need for fork() or threads).
>> +	 *
>> +	 * The magic here is made possible because `cld_argv` is static
>> +	 * and handle() (called by service_loop()) knows about it.
>> +	 */
>> +	strvec_push(&cld_argv, argv[0]);
>> +	strvec_push(&cld_argv, "--worker");
>> +	for (i = 1; i < argc; ++i)
>> +		strvec_push(&cld_argv, argv[i]);
>> +
>> +	/*
>> +	 * Setup primary instance to listen for connections.
>> +	 */
>> +	return serve(&listen_addr, listen_port);
>> +}
> 
> And complete the thing with some boilerplate.
> 
> This was a lot to read, and the interesting bits are all mixed in
> with the http server code, which is less interesting to what we
> are trying to accomplish. It would be beneficial to split this
> into one or two patches before we actually introduce the tests.
> 
> The most important thing that I think would be helpful is to
> isolate all the authentication behavior into its own patch so
> we can see how those connections from the command-line arguments
> affect the behavior of the server responses.
> 
> I think ideally we would have the following split:
> 
>  1. All server boilerblate. All requests 500 not-implemented.
> 
>  2. Add Git fall-through with no authentication. Add the tests
>     that are intended to allow anonymous auth.
> 
>  3. Add authentication data structures read from command-line,
>     but not processed at all in the logic.
> 
>  4. Act on the authentication data structures to alter the
>     requests. Add the tests that use these authentication
>     schemes.
> 
> I could easily see a case for combining 1&2 as well as 3&4,
> for slightly larger but more completely-testable changes at
> every step.
I agree, and my appologies for not splitting these out.
I'll follow up with a split that should make more sense.
> From what I read, I don't think there is much to change in
> the end result of the code, but it definitely was hard to read
> the important things when surrounded by many lines of
> boilerplate.
> 
>> diff --git a/t/t5556-http-auth.sh b/t/t5556-http-auth.sh
> 
> I'm going to pause here and come back to the test script in
> a separate reply.
> 
> Thanks,
> -Stolee
Thanks,
Matthew
