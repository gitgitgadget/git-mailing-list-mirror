Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6FBC05027
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 22:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjATWFf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 17:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjATWFc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 17:05:32 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2107.outbound.protection.outlook.com [40.92.90.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AAB8BA89
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 14:05:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DygHwoBcigy8dxWCDra3ukbDWqw96bvdSy8k9ftjqSYv7bCtJh4WErBvjoZqLWJb6mwq4vAAijU+bVjo897fTnbWTD5Jjl8hYWp0/79MGWB52YXwNQ+p8D3PErIJBa/mtopORy+WJYeiFgR1ywgqd3WcSkhrMySqGRuew/sSHFVKcZjio2uk3xPImfKZpCfsgiIviQ/qGds0hrQWiaNZaPq4GltGjtM8o2xZcZMsqN2+6NM8EWc0hXkgRaqbQ6kBF8LJoShHPyGz0UkDW+eu0qrmPfewnwtL0Sx3NauFU5cRaNkm1FvPzor7gqMr+81sAZ6o7zX6gO7lDncomErhWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcNYywpCTM2MkW610swPYoffZemkFxqXOFijS8Kfiwg=;
 b=TcgKrggj7lBeBtLDaWvSWMt8znE58kL7VbaUJ6nbD13nkp+zsIGUOZZODh2DaqaC0sb4Iv1HVKmPQxu+Qhm6I9ft/TLMrVyK0g0767CMqNYa5h03yjI3DSOpqEoiNY+O5xkRkNQoJMLv89MTBuAX8B++iylxMpbGGTbi3l62w+QNsKJThafi0A2avabHwRPTUBuJC4Fa3NojpIv9LC1WlWxswav28AhAGKXUDXOnImW0lo23aVeonyrJYdPuwTvNymOMv600Sm3ScTP0CB6UFkAH4d+hISYp8yVJdf5NvI87ZTap+0oWN15AH4/PR9cgcgZ/Vp3yITLZth9FfZP1ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcNYywpCTM2MkW610swPYoffZemkFxqXOFijS8Kfiwg=;
 b=n0iA2n+mmI+15DDGJGyhqUyoYqWZcnTZ9NsakjO5Z45K1CtvJr2vw0RZ0eoSKxSxz5SzCVUg/FsMjFqN8A4oy1CQ6oh9run+OtHHuIDh7iFRjFf0AEczztXwNkI0Drk59s6gVK3uxLI0agCftcdkwO8CkoqRO39homgGwDFb5a6uVbO3I9ip5mbusMZF5X/WoYc6uqfBYdX2VPIQ4rFh0JNHNaLR1sEWMxT2OyX0q6FGaoBogo5goGz5a18vP7URZjt0Rx2DqQ6rbhh9bIzUh5jUkfTGcNxQWJjyFFky96HSD7dHY4dYP9ELZXiSUTuH48vvC6BTHsK3MG8DEqtnxQ==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by AM7PR03MB6676.eurprd03.prod.outlook.com (2603:10a6:20b:1b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 20 Jan
 2023 22:05:27 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519%8]) with mapi id 15.20.6002.025; Fri, 20 Jan 2023
 22:05:27 +0000
Message-ID: <AS2PR03MB9815D62E17111924A002A714C0C59@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Fri, 20 Jan 2023 14:05:20 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v6 05/12] test-http-server: add HTTP error response
 function
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>, Victoria Dye <vdye@github.com>
References: <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
 <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
 <79805f042b984bb8ca7c9aaf6a15f8101037c375.1674012618.git.gitgitgadget@gmail.com>
 <230118.86fsc8xffg.gmgdl@evledraar.gmail.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <230118.86fsc8xffg.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [zt5qLws1BDH0aXewi6msPgeik9nTLHQU]
X-ClientProxiedBy: MW4PR04CA0211.namprd04.prod.outlook.com
 (2603:10b6:303:87::6) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <0622d088-bc5e-f847-fc1e-6e76186c7112@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|AM7PR03MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: 17bcf230-c35d-46a3-6307-08dafb326fcd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uRnX4jVgp8W9EV2Pb47XRz30jc8mVWZ4nH35g83vWh347zh+bNrz9RO3HVd8Ouvw4ZEteZBHmK96kEnhZbDf/r26cpTZ9DYpG/wLVNuvhUWZua77vDvYL4QORV6CDcHA+F/eThusddCNnIFdhvwfavIzPMsMfOk0VnPjKTtFtE7s0EEmoLAO9S8qc2MGzLYD6gKlyTfL80pozMATPIg9gNpVKn8OljFIzc3Pt1ZWO7OBgPRU28kdlcLrPVLOJ3rgCwS9l2ka2KcnD2xRrQUyPTMCYVclJO01tzB1ZrP/2YlzwS/3o4PfDfP9yFWcf8yX15ZDrf3m9rliJEP6vwZfuRJe2dAEOM8vOx3z1GdOf/KAUSXKqNISKUT89GI3BI1gBK9BuKpfGu4ff8vrvWeQhn7iEx7vxA7N3H/lK2f8cityNGmm3zEUwrIe+tsSP11BUwCuxRvmLEHHLBlcV1qlO9x0BFe0aPFs9KB4K7070+ixGuEZFrYjpxh5mQtDf3NLnqgBQZXMDTscRcb0Q4R512GUzIC8FxGert0zwk0ARTbqUi52cT0GYbhk1eNXVWAQllmQ3/TdbOq6wFKGm+cammkJeQvLzzGnmyzuu8jOft3rI8pY9+iqjTk1egd/q/0L/QMB3HwZl159QrWqzMou7Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnlidkV6U3RHZ3A3ZktsazlrNmlNdDl2VHoyN2NudnpNKytHOG9uQlFIMGw0?=
 =?utf-8?B?MVVPNHZxUEp2UzVYNjVoZVQrczRnUUkrZXhlT0xVdXFNeHhBVUEzdkt2UnVX?=
 =?utf-8?B?dytGSm0xMmNOSXFaZzdtc0ZxTlNTdXFZMzB5VjN2dEY4eUNHcGxNVGdhZEJx?=
 =?utf-8?B?M0dnejJJTFBIWDVVSEVrSERSbXhCajFDdUx4NHVoMWgzQUh6L04xazQ4eXNO?=
 =?utf-8?B?SHVoajNUYTlkSmFEaWpSK25FS1F0aVN2TUNST1dlN3R5M01HNmNVQWIySFdH?=
 =?utf-8?B?ek90dkZiU3c3VkNGWWpZV2tUYUMwMHBrRERvTFJMeEtidThNMnBYMEtzcWdX?=
 =?utf-8?B?elIyZld1dDEzcjVYTEVoWXRMSkllWEdHK2lYc2laMFlDRHByamZyRjE2V2ls?=
 =?utf-8?B?VHUwdDBCQ21sZTI3SUJEdHNIcTd4WVFoL1BuWFIrZ2dKbDFXWk15Q1FsK2xj?=
 =?utf-8?B?SUptbGxtRXJtVzhtdGVTZ2xiMGlpdmJNWTV5N2NFZ3pra0ovZlpibi90NFh6?=
 =?utf-8?B?c3o5OEFFdmNHckJOazFmUlRMS0F5OW10MjdEclM2WUw5TVBrMWhpSzBZak9j?=
 =?utf-8?B?SWZXRU5wNE1OWmo3b2grMXBCamNCN28yeS93MkFvcXlTaDdOZXpXVVRxYlhm?=
 =?utf-8?B?d2xGb2hCazdRTGE0RUU1dzlzenZoUXZ0R1VtNERFN3ZBaEliZGc4b1d4c0lu?=
 =?utf-8?B?MUNta1NzV3BmRlJONFZtTnltbXRybVhyQ1cvaXlpSCsrZ0pFN3hTZVlMYkcw?=
 =?utf-8?B?WDZNRUl6NEZlRlpLU0h5VFVhZlh4YkR5OXpqRXRmalRTTWM4K2xFZFdEN01N?=
 =?utf-8?B?UFVUNW1PL2FEQ003Y2FCZlpuaGdGMklSSUV0dERHdFUxcnFlSjFINzhRdjFF?=
 =?utf-8?B?cTJFV2FaWFpiUUQ0Q0xxbFV1U0dXMGlKMFZhNjlHa3NJbmNPdmlCM2RMTHY0?=
 =?utf-8?B?dDZhS2VGR3pId3JYQ3JyeTJUOUZZclorUjBwZitzenBlSWpiRURKZjFHWWIx?=
 =?utf-8?B?SlFMYVRRWXJkWWM3WFh5OThzWDViOTV2MzA4NFZjY0ZlenVpam9LdWVNT2VN?=
 =?utf-8?B?eS93YmZMcDRqR3FwS3lmU245aGdJY2NVZWZRWjJmK3M4WWsraWk4VFVpWVpG?=
 =?utf-8?B?bU0vSkhRM1RjOThjSFZmbWo4L3dMVm4wSWRQSE1KVDNmbmFEdXY5VVdBRzdy?=
 =?utf-8?B?eTY2ZFd3V1kwNFg1cWl3UFFiN0x6V2VvNXA1bUc3bWJBZ0RyN1F5cDlpV1g4?=
 =?utf-8?B?OGFOb3d6S2ErSjhzOVNFRStLTUtSdzJFM2tHbFI5SmVKbjFaeUcySTdGc0lN?=
 =?utf-8?B?REg2SnFINE1ZVW9CNUxwa21WTlppM1Bra0lHcDZNZTlzaG5LQzh4M2FPbk9i?=
 =?utf-8?B?eU5RbnRuVm1iQW5Rc2RvVm5iWEZkYzAxWEtrUXZFQjZDNG82S1I4azJkaWhZ?=
 =?utf-8?B?TXVSLzJhcFpBWWZiR1hRQTVsaUUvMVE4S3pLeGhDdjR1ME55M252ZnV1dXRi?=
 =?utf-8?B?Sjh3UThvY0NkeE9UTmduZkMwcVJOa3ZmYm9ZcFN3WlgxbUlDL1hiaitYaEhD?=
 =?utf-8?B?cHdzZkNhMENoQjgycEcyNU5QOGlXRlExMndIaHZrR1F5eWVzcXNlbHR2UHV2?=
 =?utf-8?B?N0dSTlhjZU9LQVZjUnpyOWIrRkxGU2R2UWR5L2p5WmtrVHBiVjRoRjloZTF2?=
 =?utf-8?B?eE1xWDBzKzVWSVVHdHpvWmlKdFhpYStWZXMzTDVSZ3lsYkM5ZzVjeEJ3PT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17bcf230-c35d-46a3-6307-08dafb326fcd
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 22:05:27.4027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6676
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-01-18 03:07, Ævar Arnfjörð Bjarmason wrote:

> 
> On Wed, Jan 18 2023, Matthew John Cheetham via GitGitGadget wrote:
> 
>> From: Matthew John Cheetham <mjcheetham@outlook.com>
>>
>> Introduce a function to the test-http-server test helper to write more
>> full and valid HTTP error responses, including all the standard response
>> headers like `Server` and `Date`.
>>
>> Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
>> ---
>>  t/helper/test-http-server.c | 58 +++++++++++++++++++++++++++++++++----
>>  1 file changed, 53 insertions(+), 5 deletions(-)
>>
>> diff --git a/t/helper/test-http-server.c b/t/helper/test-http-server.c
>> index 11071b1dd89..6cdac223a55 100644
>> --- a/t/helper/test-http-server.c
>> +++ b/t/helper/test-http-server.c
>> @@ -83,9 +83,59 @@ enum worker_result {
>>  	WR_HANGUP   = 1<<1,
>>  };
> 
> ...okey, this is the commit that makes use of WR_HANGUP. Whatever else
> we do, let's then squash that addition into this change.
> 
>> +static enum worker_result send_http_error(
>> +	int fd,
>> +	int http_code, const char *http_code_name,
>> +	int retry_after_seconds, struct string_list *response_headers,
>> +	enum worker_result wr_in)
> 
> In general in this series you are mis-indenting argument lists. Our
> usual style is to wrap at 79 characters, then to align (with tabs and
> spaces) with the "(".
> 
> So in this case:
> 
> static enum worker_result send_http_error(int fd, int http_code,
> 					  const char *http_code_name,
> 					  int retry_after_seconds,
> 					  struct string_list *response_headers,
> 					  enum worker_result wr_in)
> 
>> +{
>> +	struct strbuf response_header = STRBUF_INIT;
>> +	struct strbuf response_content = STRBUF_INIT;
>> +	struct string_list_item *h;
>> +	enum worker_result wr;
>> +
>> +	strbuf_addf(&response_content, "Error: %d %s\r\n",
>> +		    http_code, http_code_name);
> 
> 
> Ditto here, where "http_code" should go on the preceding line...
> 
>> +	if (retry_after_seconds > 0)
>> +		strbuf_addf(&response_content, "Retry-After: %d\r\n",
>> +			    retry_after_seconds);
>> +
>> +	strbuf_addf  (&response_header, "HTTP/1.1 %d %s\r\n", http_code, http_code_name);
> 
> ...and here there's a lack of such wrapping...
> 
>> +	strbuf_addstr(&response_header, "Cache-Control: private\r\n");
>> +	strbuf_addstr(&response_header,	"Content-Type: text/plain\r\n");
>> +	strbuf_addf  (&response_header,	"Content-Length: %d\r\n", (int)response_content.len);
>> +	if (retry_after_seconds > 0)
>> +		strbuf_addf(&response_header, "Retry-After: %d\r\n", retry_after_seconds);
>> +	strbuf_addf(  &response_header,	"Server: test-http-server/%s\r\n", git_version_string);
>> +	strbuf_addf(  &response_header, "Date: %s\r\n", show_date(time(NULL), 0, DATE_MODE(RFC2822)));
> 
> ...here you're adding strange whitespace at the start of an argument list...
> 
>> +	if (response_headers)
>> +		for_each_string_list_item(h, response_headers)
>> +			strbuf_addf(&response_header, "%s\r\n", h->string);
>> +	strbuf_addstr(&response_header, "\r\n");

Argh! Thanks again for catching these. I shall address them.

> To comment on the code a bit, this whole thing would be more readable
> IMO if your own headers were also a "struct string_list". Yes we'd waste
> a bit more memory, but in this case that's fine..
> 
> I.e. don't add the "\r\n" every time, just:
> 
> 	string_list_append(&headers, "Cache-Control: private");
> 
> etc.
> 
> Then at the end you'd do e.g.:
> 
> 	add_headers(&buf, &headers);
> 	if (response_headers)
> 		add_headers(&buf, response_headers);
> 
> Where the add_headers() is a trivial "static" helper which does that
> for_each_string_list_item() loop above.

In reality this only helps simplify the code in the case of a simple static
header like "Cache-Control: private". There's no `string_list_appendf` or
similar where I need to append a header that contains dynamic information
(date, content length, etc).

Building the `strbuf` directly, and specifying the CRLF seems a lot easier IMO.

>>  	while (1) {
>> -		if (write_in_full(STDOUT_FILENO, response, strlen(response)) < 0) {
>> -			logerror("unable to write response");
>> -			wr = WR_IO_ERROR;
>> -		}
>> +		wr = send_http_error(STDOUT_FILENO, 501, "Not Implemented", -1,
>> +				     NULL, WR_OK | WR_HANGUP);
> 
> This *does* use correct wrapping & indenation for a continuing argument
> list.


Thanks,
Matthew
