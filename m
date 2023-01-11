Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B05C5479D
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 20:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbjAKUrY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 15:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjAKUrB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 15:47:01 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2020.outbound.protection.outlook.com [40.92.74.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1171F02C
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 12:46:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWWbrg7JRnFQf3raS5D4g/yb25ReLalXL7Ny5fGSHzyzUI4Q0lb8lsdqCnhligGIFhqW2bJv5DFC6Te6jtaAqhcqKlKw7xx5vyrhFKxE9//U5qnyrtYw5Kn2vetynKLm5/BfVG8DLSUxWNWhsiOLhiuvHYYZjHla1vYWA3by9HgyUGmPINSFog0Ypl924l9OXSTH0Ka5QNpWC1blRMe6QuF08et0ruJdsNRillBL25Mj/rpN8/CqOynYVJZZgXOT9DuZWSB9sX9zi4KwEusDWnFO1bjyaKemg7b2F33YkkSayX7v9srWGdtTQwFKjsim1xcwOoTbc95+GPm5xW+yig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1ehzpVui0jOhR5gsoZrnka7o7TUaWEGT9eN6MkPRWQ=;
 b=Qam/3GU8Nm/94yWoDUE/s46Gr+x8CPknUPZCGL7hHkIEtkfr4MBykEGB60R8pookxiN7+6TSrks1VmgyOMeogdbYt3NVZmASqjITjrzIPnePLkqT4bsK1EtuzGAlFyoX7bgEnvHy1ZC0zo/8oPJ6EbFD6p0xYMDVJZYr4qz0FnYdCuKZxWG/UY0vLQgv82xEMkiSxBN+XqDm4Qs5vA/kyNdCEJTrrf63fdLXcEqfISTPP/BKItDv9tmOrScgHy0bC8f2RMBZmXDBy/PY/ULjCUdGA3dunnMy/W2tZiMnt4k+I/F3NbV3Ip4h+tmoq1A6QKUtX/a7vnhWaja8wSVUlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1ehzpVui0jOhR5gsoZrnka7o7TUaWEGT9eN6MkPRWQ=;
 b=SK2DdaYwFAf2TF8wFFGsRg6Yr6XHl34AqVHLMhsCrH/qwIfDMoIRSAB0RR2Uzm5ptcr1AKWN2OJhLdCFjfC3AASrSISQm+OOvuigRgzg8MGql/X4nzEHfIVg8Jru50kq47bWGGA2I9bZqyRP+evSG6QjKyABV4UJAC5eWJ1ea3/e80VMElEeADb3Jhv/sepcV8mOnIUjoQb75+lvQfEKdRK9L9UQtQp6R3djeKBs0yRx5CqWqWi+dRtPhzARBIxq3Y/oSltO8OONe1Ea71md3Oho+IcT9zyscLrxFb1Cfrsi7MZftArELvZBwZU8OzUmNe9sGymhYTvCEPCZ5K7hMA==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by PA4PR03MB6880.eurprd03.prod.outlook.com (2603:10a6:102:e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 20:46:52 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519%8]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 20:46:52 +0000
Message-ID: <AS2PR03MB98150C33F9704D2CA10A2EF9C0FC9@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Wed, 11 Jan 2023 12:46:42 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v4 3/8] test-http-server: add stub HTTP server test helper
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
 <07a1845ea5693fc8d3716e7f97e65d467f34a40e.1670880984.git.gitgitgadget@gmail.com>
 <752da6b2-9c75-0f68-e507-cca02bf918ca@github.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <752da6b2-9c75-0f68-e507-cca02bf918ca@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [rYfqnN/SrxTV17Rkono4cKDnR5oZcyj9]
X-ClientProxiedBy: BYAPR06CA0032.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::45) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <e690cf29-0627-776d-7d42-0f1381612c6c@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|PA4PR03MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: 430f9cfd-3a49-4e48-a536-08daf414f7a3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2rn5dAiXvtPEJ/4TScgOVY+gxoeMYf+VCVUmH6opNK2OuE4qOppfnumOUJG/NauwVafA6NYQoPK+XY0C3BtNOC/oXIUxLCJBdVpOtaX2qn6P0EVbMkL1Cvnkqzug6iXHDDOkVhZO64STfBwC4p9ip5hTuBjvEzY4EasSco99Dpbx1YkOyA1VvA5vIYH4ucFITZCZBEqORLBRDcztyYifWRLI5JNNEzC6ZBNJA2jkIGdczpFQBjVelH0k1Gl1dRdTGv9y1sHatM7MqbtKu+ouHLgLoems2rjf7/zVnk6o5j+SFQqBpugZwwmivIE0dpFIIGOMy8x5hEWRchTYYkEXszVboXEQJi+COKRtTvR4sRn6rug/0226nMnRjvqD9wO4tI/OtjZCBkgsMRmMc1yPozCCZZQU7bl8ho7cPVMxS0vzok1e8O8CpEca3iJszCv0T+m5LRD75edsdsialI0lJYTEtqKkpnE0APRtiS+Bcl32QoC1i/HwJLBbLhHwKYk6Ey+m3DlBZNqzDKTENd/8Jh8xP72vdcpc7uAE2QeaMt0HVrOflCFKTGmuKmIHMz4jno8vW/FrO9VJIATu4vzOb7EqwYK3sBYPLF/GjspZXV9u//XWZ27UQ1ojB1fvYon93UL0Z8tPQALtG0oVuRFLSQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlJYM1JDN1hXcUw0SDFrYSswWCtrNWJ4SEI0ZHZtM2UramdENVppMTV2ak9E?=
 =?utf-8?B?RllWZHJ0ekNYWTNtMk9oM2o3RUE1LzFNV1lQekluUGd0eENOSVVQeGpPK2pC?=
 =?utf-8?B?djc0Rm1kb3JGdUp2Sjh1a2F6cTBwTG40VlJSZGk5S0JnSnptRHJmM2I5cjJq?=
 =?utf-8?B?aXN1Wk1KdXBRbXlaRG4xZzV0TEhGNkJkQ2dmMHlkM01FZEZBQXlQeG1VL0dX?=
 =?utf-8?B?QlVsNUJpT2RFTlF1TlZuTTY1MTExSURvL0dETTgvNm9DRU10bTR1cmNZS0lw?=
 =?utf-8?B?UEFNb1NIT2tWaGVnSzczMkVySkFRdVFrWWhwVXRjSzNyYWlEVzN1ZDlSdkNt?=
 =?utf-8?B?MHRCbWhoMkU4UTZxL3lXRmJzYTRVSzRsNVd6MUpxWTRENklQTG1aTTVLRG80?=
 =?utf-8?B?bVhyNjN5RU9SVVE1Z0tUV09scWR4Uk1IYjFCaVFKNC8veXVzY0RrUkNUNk50?=
 =?utf-8?B?ekhJTTMrQzlsaUlBQkd2T011eTRqQkxPMGZOKy9oUXRZSnZtcEx2eWRhNmJV?=
 =?utf-8?B?bW5PYTBiNy9jWHh4Z08za3FTQkxhVzBRR0pocG5mRVBYalNpNEMwcUtWR1E4?=
 =?utf-8?B?eDU5ZjdxOW5md1lNZkYvcHhZUnJ1dmdidVZ3K05tRmUyMVUzVWNtTlJIZUQy?=
 =?utf-8?B?MFFFTmJmVVM1ckVodUxPbEFzU2JGR3kyRVZpTkpQV2FnYVVuZm9NSWJ2U0Rq?=
 =?utf-8?B?cHRTdW9hemUxVUxIbERKV0ptaVRYNVF6RWlxVkRXbGZvOHNaZDEyV2IzZWNK?=
 =?utf-8?B?RC9abUFOLy8wVDYwS2prZDY2U1hiMVIwWEpVc213a2JPK0tvZHhuRmlmdUNY?=
 =?utf-8?B?dFNsek5CV2JKMHhZaHFKMEdjS3Z4NzJWb29KOWVUY0NFYmc5c3kzaDdRd1VX?=
 =?utf-8?B?UkpYbzg3dzI0UmxLd1VDSkZBVXZlVFNXREMyOE90cDBoZy9HYnNFTktVeWZ3?=
 =?utf-8?B?cENOM0ZLL3pBaXhsS1VRUzhBdWRuc0FxRWtzaGNOMStQejlTdzI1YkRXWXVl?=
 =?utf-8?B?WXlackdya2ZWLzJFY25QUXhBZ0gzUTB2eWVmYmJ0VjdlV1JTT0ZvWEEvMkVV?=
 =?utf-8?B?cG15eWhjVGhoOU1kL2ozRHBOTFFlbXRhSGFqeFR6MS93NTJDL1J3NXplamN6?=
 =?utf-8?B?QU5halJtZURhMVVjNDRVS0I1YnUvU0phSVlveER2NmwzSDQ3aFMwMTdjbFNH?=
 =?utf-8?B?b2M2WEVuc3JDZ2wrVG14MzErT3Y1bUY5S1ExR3VHUVlpNUloRWVKcisvZk1r?=
 =?utf-8?B?djNLTmtJc3laS0RsTTlCWnFpUFJqQ1RrZXNBUFlvTmM4VWlFdjBNalkzQ2My?=
 =?utf-8?B?R3hrcDd5UWVxMDRzZnpNelpyNnhGVVVkcHczWEIrUXdUZWtQdWJGOUdzVHFR?=
 =?utf-8?B?RE1iTkhjeHk2S0tyeFNMbVBsU3hrVWN4VDJsZ1RoMm1rWG9XdmVTdTl4dEJ2?=
 =?utf-8?B?OEZ5N3RZa3ZUQWIzRUtoQVFlcStWdmJHalFyYWZVZkEzdUFLdnN1dUxLV2RE?=
 =?utf-8?B?K0FNbE52SUFOYnFHb1JHQkc1TGJ3UXlldHE3cW9McVNNT0xJMjlKOTVzbWZW?=
 =?utf-8?B?QmYzc0Frb01CbENNWHZrU0pOQXlBbWxFellvQWtFYTlKbDlmUWRpL252dDlT?=
 =?utf-8?B?Q2doN09WOGNDaitMNjdmYlBwWkpCTlk4M0l5UXFETW5DSGt2NDVrWjYyd3BM?=
 =?utf-8?B?WFpXK245Yi95b0Naa2xxbGhDRjRyMjlEUGRDY2lEc0V0SFJmdmtLNFV3PT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 430f9cfd-3a49-4e48-a536-08daf414f7a3
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 20:46:52.4754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB6880
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-12-14 15:16, Victoria Dye wrote:

> Matthew John Cheetham via GitGitGadget wrote:
>> From: Matthew John Cheetham <mjcheetham@outlook.com>
>>
>> Introduce a mini HTTP server helper that in the future will be enhanced
>> to provide a frontend for the git-http-backend, with support for
>> arbitrary authentication schemes.
> 
> I really like this approach, particularly because it opens up the
> possibility of writing more fine-grained tests in other contexts (e.g.,
> testing how a bundle-uri client handles different kinds of erroneous server
> responses by intercepting and customizing those responses).

Having a mini server we can play around with makes it easier to simulate a
'bad' server, rather than use a real one like Apache and try and coerce it
in to doing 'bad' things.

>>
>> Right now, test-http-server is a pared-down copy of the git-daemon that
>> always returns a 501 Not Implemented response to all callers.
>>
>> Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
>> ---
>>  Makefile                            |   2 +
>>  contrib/buildsystems/CMakeLists.txt |  13 +
>>  t/helper/.gitignore                 |   1 +
>>  t/helper/test-http-server.c         | 685 ++++++++++++++++++++++++++++
>>  4 files changed, 701 insertions(+)
>>  create mode 100644 t/helper/test-http-server.c
>>
>> diff --git a/Makefile b/Makefile
>> index b258fdbed86..1eb795bbfd4 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1611,6 +1611,8 @@ else
>>  	endif
>>  	BASIC_CFLAGS += $(CURL_CFLAGS)
>>  
>> +	TEST_PROGRAMS_NEED_X += test-http-server
> 
> This works because all usage of 'TEST_PROGRAMS_NEED_X' are either lazily
> evaluated (in the case of 'TEST_PROGRAMS') or are assigned later in the
> 'Makefile' than the addition here (in the case of 'test_bindir_programs'). 
> 
> On a related note, I think it would be helpful to mention 'test-http-server'
> in the "=== Optional library: libcurl ===" section of the documentation at
> the top of the Makefile, to clarify that it (like 'git-http-fetch' and
> 'git-http-push') are not built.

Upon closer inspection I noticed we don't actuall depend on libcurl here.
In my next iteration I've reworked the test helper to share some code with
daemon.c and changed where we add `test-http-server` in the Makefiles to
be the same as `test-fake-ssh`.

>> +
>>  	REMOTE_CURL_PRIMARY = git-remote-http$X
>>  	REMOTE_CURL_ALIASES = git-remote-https$X git-remote-ftp$X git-remote-ftps$X
>>  	REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
>> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
>> index 2f6e0197ffa..e9b9bfbb437 100644
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
>>  
>>  foreach(script ${wrapper_scripts})
>>  	file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
>> diff --git a/t/helper/.gitignore b/t/helper/.gitignore
>> index 8c2ddcce95f..9aa9c752997 100644
>> --- a/t/helper/.gitignore
>> +++ b/t/helper/.gitignore
>> @@ -1,2 +1,3 @@
>>  /test-tool
>>  /test-fake-ssh
>> +/test-http-server
>> diff --git a/t/helper/test-http-server.c b/t/helper/test-http-server.c
>> new file mode 100644
>> index 00000000000..18f1f741305
>> --- /dev/null
>> +++ b/t/helper/test-http-server.c
> 
> A lot of the functions in this file are modified versions of ones in
> 'daemon.c'. It would help reviewers/future readers to mention that in the
> commit message. 

I appreciate the thorough effort here in understanding what those daemon.c
functions do. Hopefully the next iteration will help other reviewers as I'm
going to be extracting the identical functions to share them between daemon.c
and test-http-server.c.

> My comments are mostly going to be around the similarities/differences from
> 'daemon.c', hopefully to understand how 'test-http-server' is meant to be
> used.
> 
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
> 
> This looks like the 'LOG_DESTINATION_STDERR' case of 'logreport()' in
> 'daemon.c', but adds a "label" to represent the priority. Makes sense; these
> logs will be helpful to have in stderr when running tests, and the priority
> will be captured as well.
> 
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
> These two functions replace the "priority" int with the "label" string, but
> otherwise capture the same information.
> 
>> +
>> +static void set_keep_alive(int sockfd)
> 
> This function is identical to its 'daemon.c' counterpart; its usage in
> 'test-http-server.c' doesn't indicate any need to differ.
> 
>> +
>> +/*
>> + * The code in this section is used by "worker" instances to service
>> + * a single connection from a client.  The worker talks to the client
>> + * on 0 and 1.
>> + */
>> +
>> +enum worker_result {
>> +	/*
>> +	 * Operation successful.
>> +	 * Caller *might* keep the socket open and allow keep-alive.
>> +	 */
>> +	WR_OK       = 0,
>> +
>> +	/*
>> +	 * Various errors while processing the request and/or the response.
>> +	 * Close the socket and clean up.
>> +	 * Exit child-process with non-zero status.
>> +	 */
>> +	WR_IO_ERROR = 1<<0,
>> +
>> +	/*
>> +	 * Close the socket and clean up.  Does not imply an error.
>> +	 */
>> +	WR_HANGUP   = 1<<1,
>> +
>> +	WR_STOP_THE_MUSIC = (WR_IO_ERROR | WR_HANGUP),
> 
> As much as I love the name, I'm not sure having this value defined makes
> much sense as its own "state". AFAICT, 'WR_IO_ERROR' means "error AND exit",
> but 'WR_HANGUP' just means "exit", so the latter is a superset of the
> former. Even if you interpret 'WR_HANGUP' as "*no* error and exit", that
> makes it and 'WR_IO_ERROR' mutually exclusive, so the "combined" state
> doesn't represent anything "real".

Fair point. Will remove this extra value in next iteration.

>> +};
>> +
>> +static enum worker_result worker(void)
>> +{
>> +	const char *response = "HTTP/1.1 501 Not Implemented\r\n";
> 
> Here's the hardcoded 501 error, as mentioned in the commit message.
> 
>> +	char *client_addr = getenv("REMOTE_ADDR");
>> +	char *client_port = getenv("REMOTE_PORT");
>> +	enum worker_result wr = WR_OK;
>> +
>> +	if (client_addr)
>> +		loginfo("Connection from %s:%s", client_addr, client_port);
>> +
>> +	set_keep_alive(0);
>> +
>> +	while (1) {
>> +		if (write_in_full(1, response, strlen(response)) < 0) {
>> +			logerror("unable to write response");
>> +			wr = WR_IO_ERROR;
>> +		}
> 
> This tries to write the response out to stdout (optional nit: you could use
> 'STDOUT_FILENO' instead of '1' to make this clearer), and sets 'WR_IO_ERROR'
> if it fails. 

Good point; will use `STDOUT_FILENO` in all applicable places in next iteration.

>> +
>> +		if (wr & WR_STOP_THE_MUSIC)
>> +			break;
> 
> This will trigger if 'wr' is 'WR_HANGUP' *or* 'WR_IO_ERROR'. Is that
> intentional? If it is, I think 'wr != 'WR_OK' might make that more obvious?
> 
>> +	}
>> +
>> +	close(0);
>> +	close(1);
>> +
>> +	return !!(wr & WR_IO_ERROR);
> 
> Then finish by closing out 'stdin' and 'stdout', and returning '0' for "no
> error", '1' for "error".
> 
>> +}
>> +
>> +/*
>> + * This section contains the listener and child-process management
>> + * code used by the primary instance to accept incoming connections
>> + * and dispatch them to async child process "worker" instances.
>> + */
>> +
>> +static int addrcmp(const struct sockaddr_storage *s1,
> 
> 
> Identical to 'daemon.c'.
> 
>> +static void add_child(struct child_process *cld, struct sockaddr *addr, socklen_t addrlen)
>> +{
>> +	struct child *newborn, **cradle;
>> +
>> +	newborn = xcalloc(1, sizeof(*newborn));
>> +	live_children++;
>> +	memcpy(&newborn->cld, cld, sizeof(*cld));
>> +	memcpy(&newborn->address, addr, addrlen);
>> +	for (cradle = &firstborn; *cradle; cradle = &(*cradle)->next)
>> +		if (!addrcmp(&(*cradle)->address, &newborn->address))
>> +			break;
>> +	newborn->next = *cradle;
>> +	*cradle = newborn;
>> +}
> 
> This is mostly the same as 'daemon.c', but uses 'xcalloc()' instead of
> 'CALLOC_ARRAY()'. The latter is an alias for the former, so this is fine.
> 
>> +static void kill_some_child(void)
> 
> ...
> 
>> +static void check_dead_children(void)
> Both of these are identical to 'daemon.c'.
> 
>> +
>> +static struct strvec cld_argv = STRVEC_INIT;
>> +static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
> 
> This matches 'daemon.c' except for the addition of:
> 
>> +	if (cld.out < 0)
>> +		logerror("could not dup() `incoming`");
> 
> The extra context provided by this message could be helpful in debugging. If
> nothing else, it doesn't hurt.
> 
>> +	else if (start_command(&cld))
>> +		logerror("unable to fork");
>> +	else
>> +		add_child(&cld, addr, addrlen);
>> +}
>> +
>> +static void child_handler(int signo)
> 
> ...
> 
>> +static int set_reuse_addr(int sockfd)
> 
> ...
> 
>> +static const char *ip2str(int family, struct sockaddr *sin, socklen_t len)
> 
> ...
> 
>> +#ifndef NO_IPV6
>> +
>> +static int setup_named_sock(char *listen_addr, int listen_port, struct socketlist *socklist)
> ...
> 
>> +#else /* NO_IPV6 */
>> +
>> +static int setup_named_sock(char *listen_addr, int listen_port, struct socketlist *socklist)
> 
> All of these functions match 'daemon.c' (save for some whitespace fixups).
> 
>> +
>> +static void socksetup(struct string_list *listen_addr, int listen_port, struct socketlist *socklist)
>> +{
>> +	if (!listen_addr->nr)
>> +		setup_named_sock("127.0.0.1", listen_port, socklist);
> 
> This is the only difference in this function from 'daemon.c' (there, the
> first arg is 'NULL', which ends up mapping to 'INADDR_ANY'). Why the change
> in default?

Next iteration will share implementation with daemon.c.

>> +	else {
>> +		int i, socknum;
>> +		for (i = 0; i < listen_addr->nr; i++) {
>> +			socknum = setup_named_sock(listen_addr->items[i].string,
>> +						   listen_port, socklist);
>> +
>> +			if (socknum == 0)
>> +				logerror("unable to allocate any listen sockets for host %s on port %u",
>> +					 listen_addr->items[i].string, listen_port);
>> +		}
>> +	}
>> +}
>> +
>> +static int service_loop(struct socketlist *socklist)
> 
> This function differs from 'daemon.c' by using removal of the 'pid_file' to
> force a graceful shutdown of the server.
> 
>> +{
>> +	struct pollfd *pfd;
>> +	int i;
>> +
>> +	CALLOC_ARRAY(pfd, socklist->nr);
>> +
>> +	for (i = 0; i < socklist->nr; i++) {
>> +		pfd[i].fd = socklist->list[i];
>> +		pfd[i].events = POLLIN;
>> +	}
>> +
>> +	signal(SIGCHLD, child_handler);
>> +
>> +	for (;;) {
>> +		int i;
>> +		int nr_ready;
>> +		int timeout = (pid_file ? 100 : -1);
>> +
>> +		check_dead_children();
>> +
>> +		nr_ready = poll(pfd, socklist->nr, timeout);
> 
> Setting a timeout here (if 'pid_file' is present) allows us to operate in a
> mode where the removal of a 'pid_file' indicates that the server should shut
> down.
> 
>> +		if (nr_ready < 0) {
> 
> 'nr_ready < 0' indicates an error [1]; handle the same way as 'daemon.c'.
> 
> [1] https://man7.org/linux/man-pages/man2/poll.2.html
> 
>> +			if (errno != EINTR) {
>> +				logerror("Poll failed, resuming: %s",
>> +				      strerror(errno));
>> +				sleep(1);
>> +			}
>> +			continue;
>> +		}
>> +		else if (nr_ready == 0) {
> 
> 'nr_ready == 0' indicates a polling timeout (see [1] above)...
> 
>> +			/*
>> +			 * If we have a pid_file, then we watch it.
>> +			 * If someone deletes it, we shutdown the service.
>> +			 * The shell scripts in the test suite will use this.
>> +			 */
>> +			if (!pid_file || file_exists(pid_file))
>> +				continue;
>> +			goto shutdown;
> 
> ...and that timeout exists so that we can check whether the 'pid_file' still
> exists and, if so, shut down gracefully.
> 
>> +		}
>> +
> 
> Otherwise, 'nr_ready > 1', so handle the polled events.
> 
>> +		for (i = 0; i < socklist->nr; i++) {
>> +			if (pfd[i].revents & POLLIN) {
>> +				union {
>> +					struct sockaddr sa;
>> +					struct sockaddr_in sai;
>> +#ifndef NO_IPV6
>> +					struct sockaddr_in6 sai6;
>> +#endif
>> +				} ss;
>> +				socklen_t sslen = sizeof(ss);
>> +				int incoming = accept(pfd[i].fd, &ss.sa, &sslen);
>> +				if (incoming < 0) {
>> +					switch (errno) {
>> +					case EAGAIN:
>> +					case EINTR:
>> +					case ECONNABORTED:
>> +						continue;
>> +					default:
>> +						die_errno("accept returned");
>> +					}
>> +				}
>> +				handle(incoming, &ss.sa, sslen);
>> +			}
>> +		}
>> +	}
>> +
>> +shutdown:
>> +	loginfo("Starting graceful shutdown (pid-file gone)");
>> +	for (i = 0; i < socklist->nr; i++)
>> +		close(socklist->list[i]);
>> +
>> +	return 0;
> 
> This addition logs the shutdown and closes out sockets. Looks good!
> 
>> +}
>> +
>> +static int serve(struct string_list *listen_addr, int listen_port)
>> +{
>> +	struct socketlist socklist = { NULL, 0, 0 };
>> +
>> +	socksetup(listen_addr, listen_port, &socklist);
>> +	if (socklist.nr == 0)
>> +		die("unable to allocate any listen sockets on port %u",
>> +		    listen_port);
>> +
>> +	loginfo("Ready to rumble");
> 
> I thought this was a leftover debug printout, but it turns out that
> 'serve()' in 'daemon.c' has the same message. :) 

Indeed! This made me chuckle when I first saw it..

>> +
>> +	/*
>> +	 * Wait to create the pid-file until we've setup the sockets
>> +	 * and are open for business.
>> +	 */
>> +	if (pid_file)
>> +		write_file(pid_file, "%"PRIuMAX, (uintmax_t) getpid());
>> +
>> +	return service_loop(&socklist);
>> +}
>> +
>> +/*
>> + * This section is executed by both the primary instance and all
>> + * worker instances.  So, yes, each child-process re-parses the
>> + * command line argument and re-discovers how it should behave.
>> + */
>> +
>> +int cmd_main(int argc, const char **argv)
>> +{
>> +	int listen_port = 0;
>> +	struct string_list listen_addr = STRING_LIST_INIT_NODUP;
>> +	int worker_mode = 0;
>> +	int i;
>> +
>> +	trace2_cmd_name("test-http-server");
>> +	setup_git_directory_gently(NULL);
> 
> Since this isn't part of 'test-tool', it needs to do its own trace2 setup,
> but it seems to be missing some of the relevant function calls. Could you
> include 'trace2_cmd_list_config()' and 'trace2_cmd_list_env_vars()' as well? 

Sure!

>> +
>> +	for (i = 1; i < argc; i++) {
> 
> Can this loop be replaced with 'parse_options()' and the appropriate 'struct
> option[]'? Newer test helpers ('test-bundle-uri', 'test-cache-tree',
> 'test-getcwd') have been using it, and it generally seems much easier to
> work with/more flexible than a custom 'if()' block (handling option
> negation, interpreting both '--option=<value>' and '--option value' syntax
> etc.).
> 
> That said, it looks this was mostly pulled from 'daemon.c' (which might
> predate 'parse_options()'), so I'd also understand if you want to keep it as
> similar to that as possible. Up to you!

For now I think I'll keep it the same style as daemon.c.

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
> 
> The rest of the function is "new", but is well-documented and appears to
> work as intended.
> 
>> +}
> 
> One last note/suggestion - while a lot of the functions in
> 'test-http-server.c' are modified from those in 'daemon.c', there are a fair
> number of identical functions as well. Would it be possible to libify some
> of 'daemon.c's functions (mainly by creating a 'daemon.h' and making the
> functions non-static) so that they don't need to be copied?
> 

Watch for my next iteration for this!

Thanks,
Matthew

