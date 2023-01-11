Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C980C46467
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 21:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbjAKVkL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 16:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbjAKVkH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 16:40:07 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2080.outbound.protection.outlook.com [40.92.90.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275834102F
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 13:40:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIkWim35d9vBsQxjAhCnXgnpdG94Dw0VOOt6Q7rC21opqGHvDOpGAr1pEtnRxxDKMMSmBisBE0J/+oxXmEFYocldBFwVprPn1IyjLGgOS6/9tzFuIaTrHCxXpx4Zcgz2mSp5Tie8qcYTaHXHfLhsihxMgH6DQIDP78VpCec07Xtop2B5A27Qgzc39c+KGAEcF5H2lLJAS9n1Tz9l+8O7iGhPjSlj3ctyNvkYOzofH9dREOEZfQ6IUU5mLmmFAp28fOky5FHvonz58C+Qoas+/165kezBGv83xCHD9Y7rGx55bLqWLBcc24aLRe6sDDcMb5nR0hXipafRnx4g9waghg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URyprkJMMCnQrrVEK7rBknNtWovWQX5XsEXxkPYgP1g=;
 b=OIUFx3wFQOkp+crUQSYVQlLI7WAcNhDb/x4i/gPRa5tq6ZBMUrOVQquavvAsChr0kJnayqe929QVeEnZiQVB2kx0fifL+AOIE5+AKQFOKswqphTqqJ6i/MAkoqpQTgJendnsQT046i7BDDd4qpiloDT2UwvsxJHcgw7/M4ErMjyWRUhjD+PacE2kvm471mM0fmTF0R7ozYllFFZHrd+8zH5hp0whrR9fHp22gsxZbIxmDXyDZ7F5jdn7M2XOgEJrjLhAz9wQLy33Hxe7eKUwSvtaSI4BVErNLUWFX9Xh3hoY3UNqFQUAP4m2ukmjFxijq/ZbXVi2uP/kkXlqcR/rkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URyprkJMMCnQrrVEK7rBknNtWovWQX5XsEXxkPYgP1g=;
 b=WrBxmVh8N8iHZT9IYM4456h37BasUubWzrV6IaaY7kEp0t3xF6oVgPvcW4pRtE8Hb+GXd9vtDjoqtbmudaJtbnB42L7fAkBK6PupecRts8P2R31GKIpnN4C1FkbTtLLlxZSZaRwD6t49Hujz7kR9XWCl6Z8ru0RVZ06zt6WSrAPRXFXoQE7tu31qxSeeV50l3OQqozxwHIY/Yh55EsFdTfEkaCj7YeF6g6LPYa+IBrvCMaxJEhKVIDpD4K3AnZr8zV2tZgp8id2bJbNkX0yjCJObtjyosgeyMte6pJqSBInnMB2NHyFARl7RzM0pvmW4Lhg5XXLcJUJ00mVKuzwOsg==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by DB9PR03MB9640.eurprd03.prod.outlook.com (2603:10a6:10:45a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 21:40:03 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519%8]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 21:40:03 +0000
Message-ID: <AS2PR03MB9815A45BDA0DE776198B5042C0FC9@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Wed, 11 Jan 2023 13:39:56 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v4 5/8] test-http-server: add HTTP request parsing
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
 <5c4e36e23eecbb7841078939a982b7150e2f4ab8.1670880984.git.gitgitgadget@gmail.com>
 <e957d4f4-fa94-7a68-f378-38e6ed131244@github.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <e957d4f4-fa94-7a68-f378-38e6ed131244@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [Iuvghew6eNLs8v0HyA/axlb1rBGvF135]
X-ClientProxiedBy: BYAPR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::28) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <729bd6d5-828c-68ae-d2b1-a5313041ee4c@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|DB9PR03MB9640:EE_
X-MS-Office365-Filtering-Correlation-Id: 05e76a33-da58-45b9-7ec5-08daf41c65ba
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zxPNkz4DRwtncGycLP5zZDzRE+Rqe0j5I61aNmnyS2tTv8gwkYu0FDTTy7Tr8x/Uwr/xP6WnqGdwfZxOQCAGcBJFbhnJfYXEeySmfoMD/dhoz+yTBSwjcpX8lFA0IFL3RNZTIod9pthX5Psx0+ZyKWeR7PULMBx/+OJS4OtT0vM+sIFWhBqoNeJWYcbbRY3qMyJHqtjMuQZ3Dz/xSIXOFERVQqJ5ljb77thQFdSbraNrRoV2G5x/9O0VbvTa42+Dbhv08z/ZY/sDeMK61/q+MzlCBloQym9b+QVmvcKI/tRzGwB7kPC+WY2xNsQktqohAScb4xfW7iEiwsrnHO9jjr47KkMMMqCEBRpT0KYi5yfvWtH/t2rfTS2/bpl0OLPUbNe3MVg3YN4qFOKoMPESwgfSwY2qQve0ZfSHZZ7VWEi+7pw5OW8jHcHtWYJpeerYz5jqrSs9Sq00WCfenqhVBeq9aKJCaxefa0CTNNT8SSlwsegkAMv2f19+KcEjMe3ZkrNSwzVfq/KBVro/hOFUgHyaqMvOBdef9Uu6I8O7ktJptNgMdR4TPM4kYFCFm646uKyt5uQpKovNAFTM7hO781z2CsQhP2smLQ1XpzUaG7zfqjMS4sVDQ2TEUhmWA7XbTgG7+uUrrHOEjHL0W0ZniyjxnFNCVFJxO+kQ+3Zootxn7r7X3fB1xJtkMmygZYsM
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MS9HYVIxSmo1WWdYc3FISkRIZ1FlUWQ0bUFzV3VKMW4yVWRUKzRZK0tCSS9E?=
 =?utf-8?B?NHFiZnBBc25PQmMzTHNiWm56RDMyL1hSRlZoMzVSZkh6V2JUelRaRUxZei94?=
 =?utf-8?B?NlcwbDhzeUQ0ZmNPa0lFc0pHSGp5OHVyZmp1blB0MXVWYS94dWxSYXBvRlJI?=
 =?utf-8?B?bm5rM3NrNWw4RlI2T2hHQW5aT1hPazJxdWQ5bEFtU2p6a0J0RjFnVGdQaThL?=
 =?utf-8?B?QXBkZXp4RVgycFc0OW03WFNPSnF5aWwwWXpIcXVpTjVCbndGNkZDbUZNRDNv?=
 =?utf-8?B?OTBPQWJCdVRQY283dTJVNFBXRndGQ2Y4cmpyV3paaWNUa3ZFWWc3RXJzY1dN?=
 =?utf-8?B?STBVSU0xWmN5M3dyYWVaUHJmSElUaFJCUUUvelAwN0t6MUNvZlpqMExkWkJM?=
 =?utf-8?B?MnNYN1FHUjVNa3BERkpnelh0RkZENUNIQTZTQlpOTmZHTy9iT0VwL3pJM0lF?=
 =?utf-8?B?YUFZbnNZSXk3K0owUERScDFQd1ZPK0R5czhvckZNQ2pmOC8zdlRHa2YzcnJ4?=
 =?utf-8?B?ZWxSdFlmWTNuaWFNS3RwUjJZeGw1OHVURDk0TXM2OWFhOU56OWEwNHBJQUNL?=
 =?utf-8?B?TE5pdWgxWDRuWWlEN1FWTnMvTTVidE1zTndzSlF3QlhFcktGNU9ybXl6bW1T?=
 =?utf-8?B?QUU2ZU9PckpnWHVqYUY3cFJqVlVleHlYS1Y5empqdDV6UHAxVU5nT3gxVytD?=
 =?utf-8?B?dGRvZFhrbnkxdTdUR1paWHg1aGVWYWRyVVM5RlJOQTVPZGR2UHlxRCthMEtp?=
 =?utf-8?B?NGpKL09GVytpK25tMm5zcTNzcWt4eHgrV3d2d3R0bmorbVV0RlhtWjk4M3JR?=
 =?utf-8?B?dUtTM3RGcjZhdGtBei9hQ2NGM1JMdGRLa1lBdndFRzByU2N4Z2xWeEJIem5F?=
 =?utf-8?B?LzhUODJMUUp6R1YrRWxEb3BsL1pkTHhiMjdpZ0t4aTJkSHQzU0NaeWVBMzhS?=
 =?utf-8?B?YnY2MXV3ZXMwcCtOSmpvR2RtRHNNVzRkUHNPQ3dOdHFwMG9FWlc1R0NhUmds?=
 =?utf-8?B?Z1lRT2x3SmtkejU4S0YzS0xlWGJTbGRWdDJOVFoyWEdHenc0OGt4Njl3bmJY?=
 =?utf-8?B?UC8zR0FpdzBBLzhncEs2aWorUnZrNlVDZWN0MDlkV29tQUwzcXVqSnZRVUc1?=
 =?utf-8?B?SDVYOXVQZWFMWDhBRWtvMm5GN2JPbi9aZHBzSHhpT01XemN4cFBVMTAzOGJY?=
 =?utf-8?B?NFJQcG1td0tZaXhxdkxyYW1HK2cvaG5iMDErQWRWd05QL1oxUzdpQmpIYWJn?=
 =?utf-8?B?VHAra3g4aGtYRm1yK3ErRTVXd05FUkdpWVk3OWFLVktqNlpaeXhFeXgxOUZF?=
 =?utf-8?B?OHRYNXV2NkRNMktNNFJtN3RSNjVabk5Sd2haWkxYaVpkanBISFA1TkVZNGtx?=
 =?utf-8?B?T09xREJiRlBCdUUxYUhGZ1huMmt4NkhyTUs0R0tQUkJBRXdlUFdYNHVyUjVF?=
 =?utf-8?B?aTc0eU9HK0pSOFhyTFhtYmVVTmhFYU1acERta1l2N2lXa3UwWUYzSFZ0M1V5?=
 =?utf-8?B?SHV4R1FBbG1oVGZNN0VUY01UQ2Y4M2w2Y0tXR1IzTEdUNlB3ekFUQnl2ZEZF?=
 =?utf-8?B?Zjl4ZmR0SkYzaTRZZXZNeVdQbit0OEhxYndBb3U3NEE3Vi9GNXFtbSs0Rytt?=
 =?utf-8?B?NGlJUWhwRE1zeFV1ZmJGaWROeUt1S1VPQWdkM1dmR2IwQm9YaXA3WCt2amM3?=
 =?utf-8?B?dnR0SStKWEI0NUIvdUtSRmZPWURDcXdTdlk5Uk1iQnFwUXM4MzdQbkRRPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e76a33-da58-45b9-7ec5-08daf41c65ba
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 21:40:03.4813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB9640
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-12-14 15:18, Victoria Dye wrote:

> Matthew John Cheetham via GitGitGadget wrote:
>> +/*
>> + * Read the HTTP request up to the start of the optional message-body.
>> + * We do this byte-by-byte because we have keep-alive turned on and
>> + * cannot rely on an EOF.
>> + *
>> + * https://tools.ietf.org/html/rfc7230
>> + *
>> + * We cannot call die() here because our caller needs to properly
>> + * respond to the client and/or close the socket before this
>> + * child exits so that the client doesn't get a connection reset
>> + * by peer error.
>> + */
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
> 
> This "line 0" parsing looks good, and aligns with the RFC you linked
> (specifically section 3.1.1 [1]).
> 
> [1] https://www.rfc-editor.org/rfc/rfc7230#section-3.1.1
> 
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
>> +		/* store common request headers separately */
>> +		if (skip_prefix(hp, "Content-Type: ", &hv)) {
>> +			req->content_type = hv;
>> +		} else if (skip_prefix(hp, "Content-Length: ", &hv)) {
>> +			req->content_length = strtol(hv, &hp, 10);
>> +		}
> 
> The "separately" is somewhat confusing - you unconditionally add 'hp' to
> 'req->header_list', so the "Content-Type" and "Content-Length" headers are
> included there as well. If that's the desired behavior, a comment like "Also
> store common headers as 'req' fields" might be clearer.

Will clarify this comment in next roll. You are correct, we *also* store these
common headers on `struct req`.

>> +	}
>> +
>> +	/*
>> +	 * We do not attempt to read the <message-body>, if it exists.
>> +	 * We let our caller read/chunk it in as appropriate.
>> +	 */
>> +
>> +done:
>> +	string_list_clear(&start_line_fields, 0);
>> +
>> +	/*
>> +	 * This is useful for debugging the request, but very noisy.
>> +	 */
>> +	if (trace2_is_enabled()) {
> 
> 'trace2_printf()' is gated internally by 'trace2_enabled' anyway, so I don't
> think this 'if()' is necessary. You could add a 'DEBUG_HTTP_SERVER'
> preprocessor directive (like 'DEBUG_CACHE_TREE' in 'cache-tree.c') if you
> wanted to prevent these printouts unless a developer sets it to '1'.

The overarching `trace2_is_enabled()` call is to avoid any possible repeated
evaluation within `trace2_printf` for potentially multiple request headers.

>> +		struct string_list_item *item;
>> +		trace2_printf("%s: %s", TR2_CAT, req->start_line.buf);
>> +		trace2_printf("%s: hver: %s", TR2_CAT, req->http_version);
>> +		trace2_printf("%s: hmth: %s", TR2_CAT, req->method);
>> +		trace2_printf("%s: path: %s", TR2_CAT, req->uri_path.buf);
>> +		trace2_printf("%s: qury: %s", TR2_CAT, req->query_args.buf);
>> +		if (req->content_length >= 0)
>> +			trace2_printf("%s: clen: %d", TR2_CAT, req->content_length);
>> +		if (req->content_type)
>> +			trace2_printf("%s: ctyp: %s", TR2_CAT, req->content_type);
>> +		for_each_string_list_item(item, &req->header_list)
>> +			trace2_printf("%s: hdrs: %s", TR2_CAT, item->string);
>> +	}
>> +
>> +	return result;
>> +}
>> +
>> +static enum worker_result dispatch(struct req *req)
>> +{
>> +	return send_http_error(1, 501, "Not Implemented", -1, NULL,
>> +			       WR_OK | WR_HANGUP);
> 
> Although the request is now being read & parsed, the response creation code
> is still a hardcoded "Not Implemented". This means that the now-parsed 'req'
> is be temporarily unused, but I think that's reasonable (since it allows for
> breaking up the implementation of 'test-http-server' into multiple, less
> overwhelming patches).
> 
>> +}
>> +
>>  static enum worker_result worker(void)
>>  {
>> +	struct req req = REQ__INIT;
>>  	char *client_addr = getenv("REMOTE_ADDR");
>>  	char *client_port = getenv("REMOTE_PORT");
>>  	enum worker_result wr = WR_OK;
>> @@ -160,8 +324,16 @@ static enum worker_result worker(void)
>>  	set_keep_alive(0);
>>  
>>  	while (1) {
>> -		wr = send_http_error(1, 501, "Not Implemented", -1, NULL,
>> -			WR_OK | WR_HANGUP);
>> +		req__release(&req);
>> +
>> +		alarm(init_timeout ? init_timeout : timeout);
>> +		wr = req__read(&req, 0);
>> +		alarm(0);
> 
> I know 'init_timeout' and 'timeout' were pulled from 'daemon.c', but what's
> the difference between them/why do they both exist? It looks like
> 'init_timeout' just acts as a permanent override to the value of 'timeout'.

Good catch. This split made sense in daemon.c whereby the `--timeout` are would
be passed to the `git-upload-pack` command, and `--init-timeout` is used as the
timeout value for the daemon server itself.

In the test HTTP server we don't need the differentiation so I'll just use the
simpler `--timeout` arg.

>> +
>> +		if (wr & WR_STOP_THE_MUSIC)
>> +			break;
>> +
>> +		wr = dispatch(&req);
>>  		if (wr & WR_STOP_THE_MUSIC)
>>  			break;
>>  	}
> 

Thanks,
Matthew
