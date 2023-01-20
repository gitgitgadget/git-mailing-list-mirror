Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA740C25B50
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 22:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjATWFl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 17:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjATWFk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 17:05:40 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2037.outbound.protection.outlook.com [40.92.89.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9433494C98
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 14:05:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhwgWUPSkKHl7UdqiahDYBiI2cTqD+Q2o67dsHLEPlL0FSoIPZybeloh01pmmdX87I8vYhkA8nt1OlhpXgc3/0INKi+QuRd2+ljGPCQfTRwe2zdXfpNaOVpruFu7KqYgij0zogdT9EUIRlvQ0S6e1Wf8XqVkyXi6HNXxVvW4EK8XNOVtf5Vh5q9kHRo65F02MRVDVdJmkahm55RaSdmt2KsE4wHc+OP8Fd7CxC0bMRbM1juZwtm29a6veqa3+VYUutbQoc3HtawMTe3czSZwk4XDBOXzHMH1Lc5UfjKgRskaNP/psBnUqPlA5HyYjLQIMvC8PW8kw8ASWvh48iW84Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzzbZEimMshCqFfSlbLKGUwHMgXKNZHi+vQBGs0pUDc=;
 b=VIQiRsWXFM6iMgigWImowmRkPTe7OaET2vEQP0zY5tWZ8dvmTAb8EvhaOVzguKmTMpHGbFNxRuu5NDu5170Xz643/BS4r+pN+QaLk/abtQQwjxBknwmDzlaEiD+XXOeZozL8bBHmUCpz/raEnaPkOKvEIk/rbXcHpCsmbPbwBWvFvM6s5OR279qko7627W+c9GgDo55FpOw7N5wIROfG56+Ka+U1vDpLFG26YPTZAKfEfQs60RY+90L2frNEYp7W1VNzXeVBvYX+kpjCPsHgd67ZAAokwWwpYdxxcDDUCbjezfDPopFL6RHS2R0tCkbGnECMPDSeA6ennWx/oYEBsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzzbZEimMshCqFfSlbLKGUwHMgXKNZHi+vQBGs0pUDc=;
 b=kdfeVNX3v6n/V+RiV1mbtIWmeG0jOkxfrbugdg760/GafjOqNAujL/dPRSCoYCM/tJF35leQfu2BacgnIf4Q6il+4VbaKkY4NHbBXDBx4upVZT9fxepjoVZUj1y2KEg2jNtLpjRG+zA5kxVhhrIC15wYQVR6Tr5Y7TgfQrDF9/3Mv0/wbaIKf8NauCC3bxvi0pJxFQALOtpOnXKoslAHc7CJm0lotafgV1BCgHCWi1ukRay/FGFLlLau3IRPRHm6lR3ioOuTtW/aIAZTwEZEESQQHqYfSCpxCDx6NvMPJ9i058QQSg48S/Hqhg0d2av2jkoF+dWrKsRVrfZhruOn1g==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by AM7PR03MB6676.eurprd03.prod.outlook.com (2603:10a6:20b:1b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 20 Jan
 2023 22:05:35 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519%8]) with mapi id 15.20.6002.025; Fri, 20 Jan 2023
 22:05:35 +0000
Message-ID: <AS2PR03MB98154B064352CEDF76E2924FC0C59@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Fri, 20 Jan 2023 14:05:28 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v6 06/12] test-http-server: add HTTP request parsing
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
 <252098db219574527c587bc601565eab81b40c2c.1674012618.git.gitgitgadget@gmail.com>
 <230118.86bkmwxf6e.gmgdl@evledraar.gmail.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <230118.86bkmwxf6e.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [P1nLgRvFcBlDan0NuLUmSXzbJvqLL3I1]
X-ClientProxiedBy: MW4PR04CA0231.namprd04.prod.outlook.com
 (2603:10b6:303:87::26) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <94027734-f0f5-7962-aa1c-f243b5000677@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|AM7PR03MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: 476f4e1a-3d09-4e01-1da4-08dafb3274b9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 37DIyZTrbUhyQwU70YyaKT4aZyqxzbktKzlxavWkwuc//h/PwZz7xvKQYcVx6YFt2UDi94lAaFG8yFkGE0Wfn9xZJqu0w2qKtVeS/LXD6EQxNwSzuOrfzWmc3YoyVK3UtodQxAFaWaeVzaySibUq31acfKa+C9QRqg+1ruVeE+K2+xxRvOdjiBiN9cNJybJHofgG5NTr+Iex/S0ncYOqy4pPfq/kc06s2HUXQfbm6yW3ALBWp6BKx7tZJDLa8vRp4a4Vf0m2mJlscc0kUaRUARCzlEh6e+dQnllTle8xOB8sOhy85M4qXdAxdCgIlaIqW9mugqM0h2w84hiTo94iEeG5PlkIUMJBLn8gQTr2rcdxLOo+pKBdLafmBz4Pzv3KVxuTT3YiLVwL72P2ZrtUrCTalsbzQP4Erg3NLoUYsnSIgenZ42QdQMZ9xUKCahJ8IeN2AhkvufrcoWwTy1pPy3BsWDupIm1Up0sR9hLRs7ClM/CQ3QKBOy+KBQZZqColyRn+6hIul6zGoDPkCFlMqGcSexJEVwOS/w5nyg3LkVzgo/IFphfawIamDE+g7oNkggv0x0bD0F3e2U/dlyeCpCQiHH0w3ImwhZv2rkobw/5BQDr3o8gwfcohIsveCyQQnyUqm+Vxv3hJCWg0lF2bCqjKbmIOuT2XJfvs2iwLewFaH78YdStzWW/gXqBbuWO0
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dElCUGcxVmRuaXhWc3lDQ2VZNUk2dFBGejNORHd4ZGdyMUVMaEFpeEFDNWt6?=
 =?utf-8?B?b1dhUkQwVkdCT0s5TUR5ZWg1cWRMTnJVWEFnSnFWZjJLTEU5OUpCeEN5RXRo?=
 =?utf-8?B?bUl0MVBqOTVVWVh2ZS9zN1J0RnVxOWx6ZTNrdTNUYWw5a1FHSzZzbkpyMHJ6?=
 =?utf-8?B?OHdqUlBXeTNIUnF3dHZsUU1XR1FkUXJSRjNzUXkzWTlabDhWako4a1BSVnBD?=
 =?utf-8?B?ME5VOTVnWitRcnJBSHF2eVRualJRSWRDdDZ3SnVQUjl3Sjh2UEt0bnlxSk9Y?=
 =?utf-8?B?bmlKK1ZCU2VRc2lHRU1vQU1NVDdFOXRJemlhZkJYcEd1Q3BodkVIalowZHJh?=
 =?utf-8?B?VGNVOE94aVRoQmpaZXErcml3V1daRFYzcWhPUTJuOVFDSnFscUhsWDI3QzBh?=
 =?utf-8?B?VWI3UUE0WXhLeHVEZXVuN25nSXhVMUhBNkRWeUJjMTYvZldiWlJhZXdybUg0?=
 =?utf-8?B?d0RkTjR4MWxJWXZQVlhyc0ZKYzNMdmdaMEpTTDZPWFR2MDkxbW9PdjNPQ0Fj?=
 =?utf-8?B?cTA2cHFrWnYrVHpJdWErdnM5T3k5NGdLL3FicmhRMEhJTVZ0Y2ozUkkwaG90?=
 =?utf-8?B?YjRBMVJMTFREMUQ3aEdteFYycjRmVVNwM3ZVOEo1TlEzTzE5UllwM3BtaXdD?=
 =?utf-8?B?elk1cmNGbWVvaytHRW5ocmZjMEVHaWhCRGxMaDYwVTNhS1plNHN6aDJxRlls?=
 =?utf-8?B?ZjFrcmloeERKY2xnWWlVMTI2Yi9oNlhWRmtNcjFDMmNKWlFhajQ3KzF3TFEr?=
 =?utf-8?B?dlkzRytzQ1BMNnYxZ2h2QytzcjM3T3BYcG9JUlh6Vkw5MnNaU0pPSVFXajlH?=
 =?utf-8?B?UTRGUlNTV3ZLemMybzV4YzhZL2ZiUGZZTXZJQlhwcGRubUk3NFdGK005VlhT?=
 =?utf-8?B?cGZQVnN4VFlnL3BHZEJ3VGYzZzVDcDYxaXFINFFEdklpZ0VBN3NPSFBJTUxh?=
 =?utf-8?B?RUFxbU5qOElVazh4SWJiOGdKR1NXd253bEVkaldpQlBzVzloK1ovb0c2b3Bi?=
 =?utf-8?B?Q3Q4ZTNaRUVmQjd1Y25FMm90ZzV4RS9lZnF2Ujl5bFVJZUhxSFZZWTRjdjV2?=
 =?utf-8?B?RmUvV1FUclc3dVZxNml6V2hDKys3blM1MTlMQjdXanFNNlYzaHdZaCtsVlRo?=
 =?utf-8?B?SDZHMm9EdHBzYWplZWpEVVpHWE5MZkVERVd2TDJERmxsVzJPSSszajVKTXc0?=
 =?utf-8?B?bDhKWkRGbk9UT3hMVmJET2RqSXVnYlJwS2RteVlXR0lIRnluek9CWWZibHhH?=
 =?utf-8?B?SXhSTHJxMlNzZCtaYlhHRkJ0S2NlTExtc2o4S0k2RTM0cXJ0SzlVZFgyWCtx?=
 =?utf-8?B?bmZSR1BRK2dHWHZyUGtZV3FGZHZ0QjVFMitaSHhxbmJqSFlTd3YxOHJYbWhw?=
 =?utf-8?B?YmFzTnpRek5FamZFQmQrZU1kd0VpRWJGdTJ1cUpKNXBpSVJuUFlqR0NJa1hL?=
 =?utf-8?B?L0cyclkzVytteGRRR1RHc040ZERoM3U3SFloV3RSYkZoQlYxUFI4UXFXeU8r?=
 =?utf-8?B?SFNML21BR1JpOG5lMEVEaWpZZUhuK2tNVGw3WmVkN2JodDl4RXNYdXBOZmR0?=
 =?utf-8?B?N2pIYmJHcGUra1ZmKy84Vmd4aGRIRURmaHNPcUt6Ti8zaEt1YjBlOUJyUUVP?=
 =?utf-8?B?Y1pRdHFZVU9ZYkJ2SkNMUnAreGJZditEY2YzR0lPMXMzdSs1dElmUU1jRGlG?=
 =?utf-8?B?eFlIKzF3ekYrK3BoMjlGMjVaaHc5SHFSZ1pxbzdIM0VLelNnY2M4bUN3PT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 476f4e1a-3d09-4e01-1da4-08dafb3274b9
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 22:05:35.6572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6676
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-01-18 03:14, Ævar Arnfjörð Bjarmason wrote:

> 
> On Wed, Jan 18 2023, Matthew John Cheetham via GitGitGadget wrote:
> 
>> From: Matthew John Cheetham <mjcheetham@outlook.com>
>>
>> Add ability to parse HTTP requests to the test-http-server test helper.
>>
>> Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
>> ---
>>  t/helper/test-http-server.c | 175 +++++++++++++++++++++++++++++++++++-
>>  1 file changed, 173 insertions(+), 2 deletions(-)
>>
>> diff --git a/t/helper/test-http-server.c b/t/helper/test-http-server.c
>> index 6cdac223a55..36f4a54fe6d 100644
>> --- a/t/helper/test-http-server.c
>> +++ b/t/helper/test-http-server.c
>> @@ -83,6 +83,42 @@ enum worker_result {
>>  	WR_HANGUP   = 1<<1,
>>  };
>>  
>> +/*
>> + * Fields from a parsed HTTP request.
>> + */
>> +struct req {
>> +	struct strbuf start_line;
>> +
>> +	const char *method;
>> +	const char *http_version;
>> +
>> +	struct strbuf uri_path;
>> +	struct strbuf query_args;
>> +
>> +	struct string_list header_list;
>> +	const char *content_type;
>> +	ssize_t content_length;
>> +};
>> +
>> +#define REQ__INIT { \
>> +	.start_line = STRBUF_INIT, \
>> +	.uri_path = STRBUF_INIT, \
>> +	.query_args = STRBUF_INIT, \
>> +	.header_list = STRING_LIST_INIT_NODUP, \
>> +	.content_type = NULL, \
>> +	.content_length = -1 \
>> +	}
> 
> Style nit: Don't indent the trailing "}", and add a "," after the last
> "content_length" item.
> 
> We omit the comma by convention when there really should not be another
> item, such as when we have a "NULL" terminator, here though we might add
> a struct element at the end, so...

Sure.

>> +static enum worker_result req__read(struct req *req, int fd)
>> +{
>> +	struct strbuf h = STRBUF_INIT;
>> +	struct string_list start_line_fields = STRING_LIST_INIT_DUP;
>> +	int nr_start_line_fields;
>> +	const char *uri_target;
>> +	const char *query;
>> +	char *hp;
>> +	const char *hv;
>> +
>> +	enum worker_result result = WR_OK;
>> +
>> +	/*
>> +	 * Read line 0 of the request and split it into component parts:
>> +	 *
>> +	 *    <method> SP <uri-target> SP <HTTP-version> CRLF
>> +	 *
>> +	 */
>> +	if (strbuf_getwholeline_fd(&req->start_line, fd, '\n') == EOF) {
>> +		result = WR_OK | WR_HANGUP;
>> +		goto done;
>> +	}
>> +
>> +	strbuf_trim_trailing_newline(&req->start_line);
>> +
>> +	nr_start_line_fields = string_list_split(&start_line_fields,
>> +						 req->start_line.buf,
>> +						 ' ', -1);
>> +	if (nr_start_line_fields != 3) {
>> +		logerror("could not parse request start-line '%s'",
>> +			 req->start_line.buf);
>> +		result = WR_IO_ERROR;
>> +		goto done;
>> +	}
>> +
>> +	req->method = xstrdup(start_line_fields.items[0].string);
>> +	req->http_version = xstrdup(start_line_fields.items[2].string);
>> +
>> +	uri_target = start_line_fields.items[1].string;
>> +
>> +	if (strcmp(req->http_version, "HTTP/1.1")) {
>> +		logerror("unsupported version '%s' (expecting HTTP/1.1)",
>> +			 req->http_version);
>> +		result = WR_IO_ERROR;
>> +		goto done;
>> +	}
>> +
>> +	query = strchr(uri_target, '?');
>> +
>> +	if (query) {
>> +		strbuf_add(&req->uri_path, uri_target, (query - uri_target));
>> +		strbuf_trim_trailing_dir_sep(&req->uri_path);
>> +		strbuf_addstr(&req->query_args, query + 1);
>> +	} else {
>> +		strbuf_addstr(&req->uri_path, uri_target);
>> +		strbuf_trim_trailing_dir_sep(&req->uri_path);
>> +	}
>> +
>> +	/*
>> +	 * Read the set of HTTP headers into a string-list.
>> +	 */
>> +	while (1) {
>> +		if (strbuf_getwholeline_fd(&h, fd, '\n') == EOF)
>> +			goto done;
>> +		strbuf_trim_trailing_newline(&h);
>> +
>> +		if (!h.len)
>> +			goto done; /* a blank line ends the header */
>> +
>> +		hp = strbuf_detach(&h, NULL);
>> +		string_list_append(&req->header_list, hp);
>> +
>> +		/* also store common request headers as struct req members */
>> +		if (skip_prefix(hp, "Content-Type: ", &hv)) {
>> +			req->content_type = hv;
>> +		} else if (skip_prefix(hp, "Content-Length: ", &hv)) {
>> +			req->content_length = strtol(hv, &hp, 10);
> 
> In POSIX the "ssize_t" is not a "this is the unsigned size_t", but can
> be a much smaller integer type (although in practice it tends to be the
> signed version of "size_t".
> 
> But this seems like a potential overflow trap as a result, but sometimes
> we need to live with "ssize_t".
> 
> However, in this case it seems like we don't, as it seems the only
> reason you init'd this to -1 and then...
> 
>> +	if (trace2_is_enabled()) {
>> +		struct string_list_item *item;
>> +		trace2_printf("%s: %s", TR2_CAT, req->start_line.buf);
>> +		trace2_printf("%s: hver: %s", TR2_CAT, req->http_version);
>> +		trace2_printf("%s: hmth: %s", TR2_CAT, req->method);
>> +		trace2_printf("%s: path: %s", TR2_CAT, req->uri_path.buf);
>> +		trace2_printf("%s: qury: %s", TR2_CAT, req->query_args.buf);
>> +		if (req->content_length >= 0)
>> +			trace2_printf("%s: clen: %d", TR2_CAT, req->content_length);
> 
> ...use that ">= 0" is to keep the state of "did I assign to this above?
> 
> So firstly, shouldn't we error or something on a "Content-Length: 0",
> and aside from that wouldn't we just have a "int have_content_length =
> 0" in this function that we'd then flip to 1?

It seems like the perfect type for such a non-zero-or-error size value; from
POSIX specifications[1]:

> ...
> size_t
>	Used for sizes of objects.
> ssize_t
>	Used for a count of bytes or an error indication.
> ...

But you're probably right here that `ssize_t` isn't that suitable in practice
due to the comically low minimum size of the `SSIZE_MAX` (2^15 I believe).

RFC 9110 §8.6 [2] addresses the `Content-Length` HTTP header and says that its
value should be non-negative, but also have no upper bound; we're gonna have to
set at least some practical limit.

Libcurl handles this by writing it's own parsing function that's good up to
a max 64-bit integer value [3][4].

Given this is for a test helper and only going to be receiving data from tests,
I propose just using something like `uintmax_t` and storing a bit with
`unsigned has_content_length:1;` to show if we actually got a header in the
request or not.

Thanks,
Matthew

[1] https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_types.h.html
[2] https://www.rfc-editor.org/rfc/rfc9110.html#section-8.6
[3] https://github.com/curl/curl/blob/6113dec2a829d4ab766428ccca9535b7a5efd012/lib/http.c#L3348-L3349
[4] https://github.com/curl/curl/blob/6113dec2a829d4ab766428ccca9535b7a5efd012/lib/strtoofft.c#L214-L218
