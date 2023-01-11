Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D6BC46467
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 21:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbjAKVps (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 16:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbjAKVpp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 16:45:45 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2088.outbound.protection.outlook.com [40.92.90.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D86A1EC56
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 13:45:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mafvjdrF3f7BwOOY1VIMODELJIci1KQy98enQQUfwIqn7p1jn5XUE+18yXrC6JEQUhtcETsKzbZf8dEnfutmNhEpmow0b0dmZKur0WKKYUwKdoCyr+LFbKNkdAe4msExstDvMzGa0jmOuE2NYs6JTQXKBCJ5erDu/URyqNDnaVy/f8sDICQ605fVt/XtwMqdpOxSPtSlHNxBJTaRNuZs5SdICYFALXZvEQqg+hhQ3jYssYZ/oVA2tIX5k4miiUoX5pNQUdT/xrlfyrVkSXZVZstBdaaPJm8epJWkJqK1Xx8QPYYLtiRv0mvG5LU/QDZGF1rJY+ALW48TQ4hBo16Qlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZIr/9HQMV5hqdgGIoCsQV+bwpE9C+jTATePmVf7mxg=;
 b=R+altYBBVTRJxufi8gIsHp9+WEWLXri7MKbwmK2RcLJHtFvrigC5f0Ik9dttaHT/YoZWTYr+Ms1x5PMWwmSXSBelU6k1iHiUSd3pQZhedAowC4aPkVMn2lFOpgwh2f9gDDQh2mrX/46lfcx2fl0AUEM/IOc/fkpyuxJtJvkEjpAYmlDszIgIpf1D/F5o/33XSLdeP24sqQKIVJvX5LrL/jcryPLBtXc5Y7ErAH1uwW8YdC9Z1DqaKvy7FHb26Xa8vH3rmqMuPNdpQ1Y5ZyNqwaB4nTmAl2ep4L+KEJ+cvSN0Vnxebrgxze6ChjtyKkd83pRjNwt3HQpftkLTAxRFtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZIr/9HQMV5hqdgGIoCsQV+bwpE9C+jTATePmVf7mxg=;
 b=EbO7n0acrN1M82e+RGh9jP3od427mDW5HeUMhFhQ0b1y+Z1w3pZ/Th5pCbNSjVgGZTyAnYjnRnLKE4Lk+kQTHXPTxWbpZtWFWT2DmolH4eWbr2zlyGR7IunXsTSqVrNwEqsHDpnIstZel/RqO795GLqoNKl9hWd2JqiqOKqwu53Xbhs9VB4AUpKqoRxnVXR4qYZtRnTy32WDhkz6DmqWcckpZsjzgTkc0oOtTQuwbhOrH2c7DGe/shGaeoPfJexzmOB37zUUrHXo21bC0BNdUvxC6XIyIfb2s9rB9wrarwpATYWqwIxHOnWQj7yz/j7YOYksKiyOb4zuM07p9uE7LA==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by DB9PR03MB9640.eurprd03.prod.outlook.com (2603:10a6:10:45a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 21:45:40 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519%8]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 21:45:40 +0000
Message-ID: <AS2PR03MB9815D6B888AD0E0E12C1C679C0FC9@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Wed, 11 Jan 2023 13:45:32 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v4 6/8] test-http-server: pass Git requests to
 http-backend
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
 <0a0f4fd10c8b29f327c35dadc7b17881f22b253a.1670880984.git.gitgitgadget@gmail.com>
 <f99c381c-1d30-7c95-6158-cecd5321dafd@github.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <f99c381c-1d30-7c95-6158-cecd5321dafd@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [rxtdQXOAyuCUjKbW6FKgXFbJQ4QfgRiK]
X-ClientProxiedBy: SJ0PR03CA0223.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::18) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <1af4ecb8-f13c-5baf-4c6e-7e2439a72476@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|DB9PR03MB9640:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ffceb6-e294-46cb-f611-08daf41d2e17
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RJ72gOWdfmgWIyZ5CaLAi2b+eY3yHf6/AwyQmFxsmyl4zQ1ajU4BtCCtLltv5AXn86s6atRPB4rsdU5Sr2POlqbuK9A21V6m2Ewn18CleQDT5gYEm0t0YcVVJojZGnRzasC1siLAaTWmEJanlUxRkMaen2B7o/d8d2uXw+HOoHtcb4mooutBC12Jlhof8icW+FfCixgIcXHky+rWe1MjHL2tkV7RtxEQ7ePU0Vincied/GdhRP7YcCQVV/Znw0v0FOOuDfgPNw21q9+eVbSMonAvY9Ivo5ausZeSa8p+F+VocTDJLAW3AIIJKvKEU1eGUCELZgFfeILuG+ln7RTdBvi46s7B86nPmIa6l6WBXFqxl30e8cNJNUkCeipeGoBvjProd/p4Fx6a7hQ6L8Jfs358ZQlYuE88Kaqf+byBLjr8jtiZqybJm102mhLNBdgL9HW/LKXVj7mZSKmZUrIRfLGI14Snc3fhxJxjNL9TdeUlNKEYbRBkvxYWiQNChEl4Hw6/pntsIh3xJXbzObnjWuvve54ueOKWon5a+i3THkt/XwxzgxueYjrYyGW/xApZ/GGdiHAFfwsAvBogyaGaEQJsOmzFekUQFzxHFM5tvm+mrGtuXbE/JLO+SH2EMqZFCy9V7JOPzq3uuj/9gfyRLQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVRpc09ienptdFROWHdBY3k2a2VyckVuNm5yZUtPVnRxeENqbzkvK0JvV1FV?=
 =?utf-8?B?YVdKa0tTck1SQnpacXR3R3RzUWdSNXlTSWFLRlRFc3VFZ20zYnpobUtPMmlo?=
 =?utf-8?B?bmhjcXYydXRNbVJCbnhSTE54aGcwdkNIMUFIR0NWcWdxWGtSQkVwT01KN0lX?=
 =?utf-8?B?NlUwVmFpK0EzR3NoY1lnSDFtMkJTbHd5ME9oM0U1eUhvTFdQeGsvQi9YVW1L?=
 =?utf-8?B?TFRDaGc0dWxaZmM5RHZpOW9pc2RzMGtJN1hhRXdFaXhKRHF4c0F3RDVyUjM3?=
 =?utf-8?B?UWozcHlrMVFNWGhnb0picDZ3MzErRnJlaGdWYWIzL2pIUFduM1NXbGY5dFFr?=
 =?utf-8?B?TzRHN3NySDBUMnRkK1ozMyt3cFoyemZXckpQQzVVK3RHM1pVZHY4MmlhZllV?=
 =?utf-8?B?NzhQbG0rbTltL0tmV3hBa29TVTMwbUJ5ZyszdG5qcWR2bVU5c1U1eGh0enhW?=
 =?utf-8?B?TmRjQjFWaEtYT1NodGprdy90Sy9JUWh0ZDkrWXhueGsyUzBxVXh6d2dySitI?=
 =?utf-8?B?N0RUZmVVMkdqcW5GRjhXMG5uVzlUREU0K2diM1lDZzRVWnpYaHZwU2tHRElv?=
 =?utf-8?B?eXhFWU43V09nZkRZRTNmbFBINHJhQzhFVENKSnJmV2tYRmNQbzdRQzFyZ1I1?=
 =?utf-8?B?d1l5cVA1RWExNTk2ek83d25neE9TN21kWkk2Vk5qNTFDbFdUcURYNkRSTE14?=
 =?utf-8?B?MWt2TmVqaFhUbkduckRjYlk2NEtvUVpDV0FkaDVia1JZZE4vY0VUWVFzMlhs?=
 =?utf-8?B?NnJEOWljOHdmM1pqVFJXNHFHSVlRZHlIRGRJUXoyMzdINkxiMFlrTDJseWhj?=
 =?utf-8?B?RC93dS81SExYaTU4NFB2NUpvSlNXdkwzdytlQVBUQ240M1BZUlhmQTJsK0Rr?=
 =?utf-8?B?VG5iZytWNDAxWGpib011TGRQRjh2MVJRWExjRzJpNmNiQytZdG13eFRpTE1H?=
 =?utf-8?B?R1ZvVjBVendFVmdXYy9XTkJKd2hpbGtMRzY5WFVlZmZGc09DamE5dk4yeTVW?=
 =?utf-8?B?K2VvZnBqQUpicHFPV3pPNWx3RHZJeTVrU2trYVI5RXlMb1ppdGVQNXlnVW9w?=
 =?utf-8?B?Y1IvZFhuWW05TGRpTktWeXZXbElqeU9uR0t2azlTWFVySng2QytVRnk4MGhC?=
 =?utf-8?B?WFZPSGJ4WnNCbVp2ZXJReW1pcnpsQW9GKzhHbmF5SXZGblNwZG9hMTZwcmxT?=
 =?utf-8?B?dmtUaTZFZkhpVGowM2dtNWh5d0VVdFZaRDlRUUtmaDNGVEdWb05UL1QzKzNn?=
 =?utf-8?B?OE9ldzl3dnUxcE5jWWxCRDIrdTVaSGNWcHkzZERYbUJNZk8wOURyTDQ0L09u?=
 =?utf-8?B?akdwQzVnMm1Uak5ISlRpTzBlcGdDbFBHWFlCd3JTS29LQUQzQk1WdzlIZU1p?=
 =?utf-8?B?VEJTMGtyWWtLbW4rcHVkTUNvYlZncUVHNzM5M2JEbEd6Vy9zRUFBdkYzN0tt?=
 =?utf-8?B?cldib3RYNkxYYm41S0ZhNzRwcTZLbHM0VGFqYkFyTXNLUUdMdEw2R3FqSlJS?=
 =?utf-8?B?N1B1dnFrL2N3RXBydlIza1RQcWFkMjVkTGEyT1ZuU0E3RU16U0YyMlBkbjJq?=
 =?utf-8?B?bHhjU0pZek5HVXViekYzeDhMVnhMUDQ1S2VNdU1DQjBiV3pLbzNBallkT1F3?=
 =?utf-8?B?SUY0bTVsQm4xd2xMWi9CRHZHMnFXQXRxTG5KSHJwelhtaHViZ05kZ0djUHpG?=
 =?utf-8?B?MFQ0VTV0WjVxRnZiYy9yOUpLM0ppWGJmaE1pV2RPb2ZhK2ZnYjRMTnZnPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ffceb6-e294-46cb-f611-08daf41d2e17
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 21:45:39.8867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB9640
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2022-12-14 15:20, Victoria Dye wrote:

> Matthew John Cheetham via GitGitGadget wrote:
>> From: Matthew John Cheetham <mjcheetham@outlook.com>
>>
>> Teach the test-http-sever test helper to forward Git requests to the
>> `git-http-backend`.
>>
>> Introduce a new test script t5556-http-auth.sh that spins up the test
>> HTTP server and attempts an `ls-remote` on the served repository,
>> without any authentication.
>>
>> Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
>> ---
>>  t/helper/test-http-server.c |  56 +++++++++++++++++++
>>  t/t5556-http-auth.sh        | 105 ++++++++++++++++++++++++++++++++++++
>>  2 files changed, 161 insertions(+)
>>  create mode 100755 t/t5556-http-auth.sh
>>
>> diff --git a/t/helper/test-http-server.c b/t/helper/test-http-server.c
>> index 7bde678e264..9f1d6b58067 100644
>> --- a/t/helper/test-http-server.c
>> +++ b/t/helper/test-http-server.c
>> @@ -305,8 +305,64 @@ done:
>>  	return result;
>>  }
>>  
>> +static int is_git_request(struct req *req)
>> +{
>> +	static regex_t *smart_http_regex;
>> +	static int initialized;
>> +
>> +	if (!initialized) {
>> +		smart_http_regex = xmalloc(sizeof(*smart_http_regex));
>> +		if (regcomp(smart_http_regex, "^/(HEAD|info/refs|"
>> +			    "objects/info/[^/]+|git-(upload|receive)-pack)$",
>> +			    REG_EXTENDED)) {
> 
> Could you explain the reasoning behind this regex (e.g., in a comment)? What
> sorts of valid/invalid requests does it represent? Is that the full set of
> requests that are "valid" to Git, or is it a test-specific subset?

Explanatory comment will be added in next iteration. These are the valid Git
endpoints for the dumb and smart HTTP protocols as specified in the tech docs.

>> +			warning("could not compile smart HTTP regex");
>> +			smart_http_regex = NULL;
>> +		}
>> +		initialized = 1;
>> +	}
>> +
>> +	return smart_http_regex &&
>> +		!regexec(smart_http_regex, req->uri_path.buf, 0, NULL, 0);
>> +}
>> +
>> +static enum worker_result do__git(struct req *req, const char *user)
>> +{
>> +	const char *ok = "HTTP/1.1 200 OK\r\n";
>> +	struct child_process cp = CHILD_PROCESS_INIT;
>> +	int res;
>> +
>> +	if (write(1, ok, strlen(ok)) < 0)
>> +		return error(_("could not send '%s'"), ok);
> 
> Is it correct to hardcode the response status to '200 OK'? Even when
> 'http-backend' exits with an error?

We always respond with a 200 OK response even if the http-backend process exits
with an error. This helper is intended only to be used to exercise the HTTP
auth handling in the Git client, and specifically around authentication (not
handled by http-backend).

If we wanted to respond with a more 'valid' HTTP response status then we'd need
to buffer the output of http-backend, wait for and grok the exit status of the
process, then write the HTTP status line followed by the http-backend output.
This is outside of the scope of this test helper's use at time of writing.

Important auth responses (401) we are handling prior to getting to this point.

The above will also be summarised in a comment on the next roll.

>> +
>> +	if (user)
>> +		strvec_pushf(&cp.env, "REMOTE_USER=%s", user);
> 
> I'm guessing that 'user' isn't used until a later patch? I think it might be
> better to not introduce that arg at all until it's needed (it'll put the
> usage of 'user' in context with how its value is determined), rather than
> hardcode it to 'NULL' for now.

Good point!

>> +
>> +	strvec_pushf(&cp.env, "REQUEST_METHOD=%s", req->method);
>> +	strvec_pushf(&cp.env, "PATH_TRANSLATED=%s",
>> +			req->uri_path.buf);
>> +	strvec_push(&cp.env, "SERVER_PROTOCOL=HTTP/1.1");
>> +	if (req->query_args.len)
>> +		strvec_pushf(&cp.env, "QUERY_STRING=%s",
>> +				req->query_args.buf);
>> +	if (req->content_type)
>> +		strvec_pushf(&cp.env, "CONTENT_TYPE=%s",
>> +				req->content_type);
>> +	if (req->content_length >= 0)
>> +		strvec_pushf(&cp.env, "CONTENT_LENGTH=%" PRIdMAX,
>> +				(intmax_t)req->content_length);
>> +	cp.git_cmd = 1;
>> +	strvec_push(&cp.args, "http-backend");
>> +	res = run_command(&cp);
> 
> I'm not super familiar with 'http-backend' but as long as it 1) uses the
> content passed into the environment to parse the request, and 2) writes the
> response to stdout, I think this is right.
> 
>> +	close(1);
>> +	close(0);
>> +	return !!res;
>> +}
>> +
>>  static enum worker_result dispatch(struct req *req)
>>  {
>> +	if (is_git_request(req))
>> +		return do__git(req, NULL);
>> +
>>  	return send_http_error(1, 501, "Not Implemented", -1, NULL,
>>  			       WR_OK | WR_HANGUP);
>>  }
>> diff --git a/t/t5556-http-auth.sh b/t/t5556-http-auth.sh
>> new file mode 100755
>> index 00000000000..78da151f122
>> --- /dev/null
>> +++ b/t/t5556-http-auth.sh
>> @@ -0,0 +1,105 @@
>> +#!/bin/sh
>> +
>> +test_description='test http auth header and credential helper interop'
>> +
>> +. ./test-lib.sh
>> +
>> +test_set_port GIT_TEST_HTTP_PROTOCOL_PORT
>> +
>> +# Setup a repository
>> +#
>> +REPO_DIR="$(pwd)"/repo
> 
> nit: '$TEST_OUTPUT_DIRECTORY' instead of '$(pwd)' is more consistent with
> what I see in other tests. 

I don't see this? In fact I see more usages of `$(pwd)` than your suggestion.

> Also, if you're creating a repo in its own subdirectory ('repo'), you can
> set 'TEST_NO_CREATE_REPO=1' before importing './test-lib' to avoid creating
> a repo at the root level of the test output dir - it can help avoid
> potential weird/unexpected behavior as a result of being in a repo inside of
> another repo.

However.. after setting `TEST_NO_CREATE_REPO=1` I was getting CI failures
around a missing PWD, so my next iteration uses the `$TRASH_DIRECTORY` variable
explicitly in paths instead :-)

>> +
>> +# Setup some lookback URLs where test-http-server will be listening.
>> +# We will spawn it directly inside the repo directory, so we avoid
>> +# any need to configure directory mappings etc - we only serve this
>> +# repository from the root '/' of the server.
>> +#
>> +HOST_PORT=127.0.0.1:$GIT_TEST_HTTP_PROTOCOL_PORT
>> +ORIGIN_URL=http://$HOST_PORT/
>> +
>> +# The pid-file is created by test-http-server when it starts.
>> +# The server will shutdown if/when we delete it (this is easier than
>> +# killing it by PID).
>> +#
>> +PID_FILE="$(pwd)"/pid-file.pid
>> +SERVER_LOG="$(pwd)"/OUT.server.log
>> +
>> +PATH="$GIT_BUILD_DIR/t/helper/:$PATH" && export PATH
>> +
>> +test_expect_success 'setup repos' '
>> +	test_create_repo "$REPO_DIR" &&
>> +	git -C "$REPO_DIR" branch -M main
>> +'
>> +
>> +stop_http_server () {
>> +	if ! test -f "$PID_FILE"
>> +	then
>> +		return 0
>> +	fi
>> +	#
>> +	# The server will shutdown automatically when we delete the pid-file.
>> +	#
>> +	rm -f "$PID_FILE"
>> +	#
>> +	# Give it a few seconds to shutdown (mainly to completely release the
>> +	# port before the next test start another instance and it attempts to
>> +	# bind to it).
>> +	#
>> +	for k in 0 1 2 3 4
>> +	do
>> +		if grep -q "Starting graceful shutdown" "$SERVER_LOG"
>> +		then
>> +			return 0
>> +		fi
>> +		sleep 1
>> +	done
>> +
>> +	echo "stop_http_server: timeout waiting for server shutdown"
>> +	return 1
>> +}
>> +
>> +start_http_server () {
>> +	#
>> +	# Launch our server into the background in repo_dir.
>> +	#
>> +	(
>> +		cd "$REPO_DIR"
>> +		test-http-server --verbose \
>> +			--listen=127.0.0.1 \
>> +			--port=$GIT_TEST_HTTP_PROTOCOL_PORT \
>> +			--reuseaddr \
>> +			--pid-file="$PID_FILE" \
>> +			"$@" \
>> +			2>"$SERVER_LOG" &
>> +	)
>> +	#
>> +	# Give it a few seconds to get started.
>> +	#
>> +	for k in 0 1 2 3 4
>> +	do
>> +		if test -f "$PID_FILE"
>> +		then
>> +			return 0
>> +		fi
>> +		sleep 1
>> +	done
>> +
>> +	echo "start_http_server: timeout waiting for server startup"
>> +	return 1
>> +}
> 
> These start/stop functions look good to me!
> 
>> +
>> +per_test_cleanup () {
>> +	stop_http_server &&
>> +	rm -f OUT.*
>> +}
>> +
>> +test_expect_success 'http auth anonymous no challenge' '
>> +	test_when_finished "per_test_cleanup" &&
>> +	start_http_server --allow-anonymous &&
> 
> The '--allow-anonymous' option isn't added until patch 7 [1], so the test
> will fail in this patch. I think the easiest way to solve that is to remove
> it here (although I think it's fine to leave the title "anonymous no
> challenge", though), then add it in patch 7. 
> 
> [1] https://lore.kernel.org/git/794256754c1f7d32e438dfb19a05444d423989aa.1670880984.git.gitgitgadget@gmail.com/

Good catch! Will fix.

>> +
>> +	# Attempt to read from a protected repository
>> +	git ls-remote $ORIGIN_URL
>> +'
>> +
>> +test_done
> 

Thanks,
Matthew
