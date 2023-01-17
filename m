Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73750C38147
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 23:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjAQX1K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 18:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjAQX00 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 18:26:26 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2090.outbound.protection.outlook.com [40.92.48.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461BA39294
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 13:23:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJmpMr6efANhh7T6JjNhdpab/vxGashIm4A9fFFpz5eO4owwb0ZSyiyoKKHSw331cU+F/YYu9Z9mz7LG8dZEF3hkg6knJW4vIDkx1XceYMRBJu1OPv5Np0UvovnLeIwU4f8l/uACzVI/URqHDKD6PkT/N5HQDU4BhLyvwa2kz4qZLG/5aOfE7zZLY/DyPwOyI71tR3wORp8zSHlNmVykUP3Ozrq4QOFB4Rn7HhkZ3UUy+W6Wwj0+cqlGuSPlrisI0knC73FmdUlHl/YIOMRb6dmbYs0IV/icYFOTnD+sDRlelH5vRv0T3KB9E65itK+Lo+AGFfIres+Z1TLJsHux/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgS3RwfhXVqKYzPAt2dacGP5YWxag3HJJlnuqPx+tao=;
 b=Yt07XZG7CI68y6klGRz2jW0aA9mLD1j2CiTrJj5L4g5+aequyduykELi3hIRxV6ggMNY42RCqncZk3+i15MKPmFZEJ7kB06n+WWHdNsk4knCiA1uzN17qInNBa09qVKufIw5oPo5Pbxn2anm5o3O+9DPSoW+vNsWWxKKD/CUzIy4KkbE7e6ll7bm2xuyyLdgDTIsx0HQAc9AaUs/QhTQV+hg4ohhBGXxFRRqHC49+eXuaLZ86xBzUxMk+PTYijmR+WxOq7cI/Q3+mCtKHRHqHh10W1pdhuFbD6eWmdiuUo8OE5w3M2d6LsZaGTjNK0SXE9E7WmWLjiumSO1wHtS7qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgS3RwfhXVqKYzPAt2dacGP5YWxag3HJJlnuqPx+tao=;
 b=d52c+XGa87y2/InrmO4DfGjaPoerENgxe8Kcf5CigqaZggjomKsCOsyQgUvM/VB2xpDxyiLKYUBOO+Nkr3BomDgDyZGDkvM9oUwjNyPCnEvNQIHYUPqh5jUNbqLMXJjY9GF/cKfUpUE2oQlkQ9hI4fMC7ifWE6zuGaecjIi6wLL07VedbLCsmewJDNwTuhRxlX9JUyp4qwaJO20JSbFDBecLPQeziLB/27daLLM/mqPRoRgTcfN8oWjmftERcmrftuVMdG8jACw2wUULucjmVVWZCDqTyRtld7RlieMf5MA+XYYYLieBRJscCh8J8KWv7Sj+ogksY2+NfIPdj2P3og==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by GV1PR03MB8709.eurprd03.prod.outlook.com (2603:10a6:150:93::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 21:23:36 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519%8]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 21:23:36 +0000
Message-ID: <AS2PR03MB9815EC09D465E123F15BA4B3C0C69@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Tue, 17 Jan 2023 13:23:29 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v5 05/10] test-http-server: add HTTP error response
 function
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
 <6f66bf146b4d6e4044b3c6c2224795918191bc3f.1673475190.git.gitgitgadget@gmail.com>
 <0a5f4195-600f-d099-5879-bbd7629285b2@github.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <0a5f4195-600f-d099-5879-bbd7629285b2@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [wWK7mIrvGs4+Thu7Rg3bd4Dt6PjGJBMr]
X-ClientProxiedBy: BYAPR06CA0072.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::49) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <6ec249a8-afbc-6ab2-e886-ba8bf7568931@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|GV1PR03MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e9d4961-5421-442c-14a0-08daf8d117fa
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vxOPkjiJhB8N4y2s5Ar2ByxB+EM0ARZLZnanCpGv0WnMCxx614MFuCoOOCl5xzZqlAQUQWpZ3yi2ZiRfoqDsQhOPLIk1vbEvLzCn4qn1WPRszkWWdk7dOdV3O5RKqQjAGA7CyS697HBaPsEPeu+4CeM7JN9EYt3lDt4MxnVz6i8UZGrj/IF6Wo/yTh/kO/KX/37qzgEhgsZ2mkt3TN+WrOxbg2hthyX3oCikdII56d8kDcIUKi2tpQj9mJgJIwCrzXPmB3pLgacKThWjzx2flApRB9eGYDxQrL7dyD3yOhgLazf7SQ8G+hGRXTdBzoH3966U8QHAGMfvkPYj8JVYQB1cGBxF+pAYGs2O7pjP5714Jpx1VH0vFjFKHf/z7n0/X6ukPMr5Zt5blXVzA/Y/TYMy8RXsEfXqpw4RhD2kaVvk0qkDPwz2XDKr6yODRy/VbrSzhXYeBbWrNnVM+tTH2bd7qqMA7H/+24m/R+SD4FfdIrJmM6vE7ZbWOexFRPXhZuEAXXlORYPUsDrh2jA3BkphB+NhFgmXGHc/6qMDSOpA/KHZ5H2JLUacA8NVuzjSjNSrBrD5kfb1Yzp90fY6vWKDWJCZb8nZrvTckbB4JB59+++Pxkp7EJVoZ6Tbzi0BIyNylzG/dEPakAC7CBOZqSJto+CGYH6J9etOvIuCmAk3zdpPUkUzmJf1PunvBQYu
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ni9qN3JhaWhCT25WVzVYa25lQnc5dUs2N0VaT0NiZFVqbWRLOUFTNWlNOGFx?=
 =?utf-8?B?ZDNESkV3enFRWEU3SkNKUUJwV2lINGtDZ0tMeW9TbFdJZ21GNFAzbWxYaHdu?=
 =?utf-8?B?YjhKRENETmQ3OWFGU29XVzZ4dVZLTUhib0s0d2tKSEJVSTlQNjYwbTN1bDJa?=
 =?utf-8?B?ME5qb1I5Vk5hRUtqeEd1aEVaNVNDaHhXMnlqMWR1c1kvUjhROEJMeGpDTlBj?=
 =?utf-8?B?eHRSS25XVWxLeTZHeXhHRzhTWiszUk1UbWIxU1Z6aS9aVlowUFlhYlh1cVFP?=
 =?utf-8?B?aWVYT09oeFVLbnRBbXdkRW5paG5LaHJ5SGZmREJMOWp1UVpDY3JIZXQvR3Qv?=
 =?utf-8?B?TE54ZEdyQWVtZnZyc3d5YlAxdnZySU9hRE9pdGdLOEsyV3JrY1hOdDJ0Vk45?=
 =?utf-8?B?NUVBeFBiVFNKRnRtMGQrajBaRTA4STN2Nk0rMlQzcnV0SGZudFpZNXEyYStr?=
 =?utf-8?B?LzBvWTB1eU9HVVA5NmtzcWNSSzlwME9qeER2bHpzT1R0c2hMdVBKd20weWM3?=
 =?utf-8?B?bVd3cHVVMU8wZmdhU1Vyc2x0WDcwQVI2NzNBb0kwQzR2a3dsNFVWTU9QTnRK?=
 =?utf-8?B?bWpRZ3JiUG4yMThrVzNwQ0ZuL3Rma1lYTG5uVVdJaTUraS9veXp1bTViOGdJ?=
 =?utf-8?B?VW5FUEFzeFg1Q3hYNGJVTXFMOXhEL3BrYWRBZkRld3l3YkREbDVqZlZaM09G?=
 =?utf-8?B?WW9Yclc0ZjdiOFB1WXBTa1Y2VlJCTVlBYkJsNHZBN2g2K092MFV0OGR0alQr?=
 =?utf-8?B?MFVJcXU3WnNneDBFam9veUpIVlRzZThRNVBiYXZBN0hQcHRqUUwvUmowRnZW?=
 =?utf-8?B?ZFJtR2tBbFJhdFFNWkp4a3RTTlhEbSs2eHFUd0xNRUpNWUhoMVJsUEhqNjQr?=
 =?utf-8?B?UUlsVDJsL3NlWVlhdlVlVlRySEEyNCtTeDlsV21jU1dtbXpBKy9IeEx2WkZz?=
 =?utf-8?B?M3VKZHJ0UEIzZ0Y3emRzTDkwY0ZuTndGMnlra0NhL2NNRk9yNFhmeTA4b2hF?=
 =?utf-8?B?V0tsQ1YzSWhRenVYZEhUb2FnSUdISklmMVl6clBVYVM0L1k1SXdreWdydEYx?=
 =?utf-8?B?R3dHZHEyeTBWRWJnaXRRN3pPNUJGSGdDQ0tsRTBucS8rMk9wbU5zcUJGbXJT?=
 =?utf-8?B?MmlXTDhWejhvL3dTeERyMXA0ZlNYdDJCczFSMjN6N1VuaUdhNkJmUVVrR2Fj?=
 =?utf-8?B?WlZTQVRZTytsMXhCYm1EY1djMGpGM1hyb2lOWWt4QW9nUGdRMllzVlNwN0Vh?=
 =?utf-8?B?TUVVbHNqMi9FdGpwYUs5WEJGZXA3U2V6c3M5UHlvT3gwakdRV1p4b3F5ak43?=
 =?utf-8?B?VWFzN3RvTWxRam11V1g3VXo1YUE2QnNJSVZUMkRJdmFLM3VsZmQ5YnhzazRl?=
 =?utf-8?B?Z1MxTEFtOGhncHRBQXdub3pDT0pLOWF0VFU3OUxoWW8yeXE3SHFFQXlXd3R3?=
 =?utf-8?B?Mk8ybm5FM0lLUHRleXVXRTIwSlk0L0RnYlJham13RFlKM0k5eWdNb1VsZ3Qz?=
 =?utf-8?B?dE9EZGdmOVF3QmF0YzVSZUhzU2tndG12NkNkZEdydVR3bkh0RW80dXQza1Yx?=
 =?utf-8?B?RmZPdXFWc2ZDL0VBaWZncjkyVVhCS0NjcW9RZnhJRlJvc1F2ck1Va3d0ZHBu?=
 =?utf-8?B?Smx0NUcrczM5bkJCMC8zVzRBRW5JaEpycGZEUXZIVWJYb3lwdGJxc3RMQ0tl?=
 =?utf-8?B?T0tPejRXM0tlT09FMTZkeHRYMmsyR25iUVZhOGdGRHlmQWlwSDYrRXdRPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9d4961-5421-442c-14a0-08daf8d117fa
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 21:23:36.5465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB8709
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-01-12 12:35, Victoria Dye wrote:

> Matthew John Cheetham via GitGitGadget wrote:
>> From: Matthew John Cheetham <mjcheetham@outlook.com>
>>
>> Introduce a function to the test-http-server test helper to write more
>> full and valid HTTP error responses, including all the standard response
>> headers like `Server` and `Date`.
> 
> It took me a second to figure out, but this patch combines the content of
> patches 4, 5, and 6 from the last iteration. After squashing those three
> patches from v4 together locally, the range-diff is actually pretty simple
> (see below). 
> 
> Out of curiosity, why did you combine those patches? I don't feel strongly
> about changing it, but the smaller, incremental patches in the previous
> version were a bit easier to review.

This is my mistake. I didn't intend to do this, and agree splitting them is
easier to grok. I will restore this! My apologies! :-(

> In any case, this version addresses my feedback from [1], [2], and [3] - the
> explanatory comments are particularly helpful. Thanks!
> 
> [1] https://lore.kernel.org/git/7b7d1059-cecf-744d-6927-b41963b9e5a8@github.com/
> [2] https://lore.kernel.org/git/e957d4f4-fa94-7a68-f378-38e6ed131244@github.com/
> [3] https://lore.kernel.org/git/f99c381c-1d30-7c95-6158-cecd5321dafd@github.com/
> 
> Range diff v4 (patches 4-6, squashed) vs. v5 (this patch)
> 
> 4:  127827637e !  5:  6f66bf146b test-http-server: add HTTP error response function
>     @@ Commit message
>      
>       ## t/helper/test-http-server.c ##
>      @@ t/helper/test-http-server.c: enum worker_result {
>     - 	WR_STOP_THE_MUSIC = (WR_IO_ERROR | WR_HANGUP),
>     + 	WR_HANGUP   = 1<<1,
>       };
>       
>      +/*
>     @@ t/helper/test-http-server.c: enum worker_result {
>      +		hp = strbuf_detach(&h, NULL);
>      +		string_list_append(&req->header_list, hp);
>      +
>     -+		/* store common request headers separately */
>     ++		/* also store common request headers as struct req members */
>      +		if (skip_prefix(hp, "Content-Type: ", &hv)) {
>      +			req->content_type = hv;
>      +		} else if (skip_prefix(hp, "Content-Length: ", &hv)) {
>     @@ t/helper/test-http-server.c: enum worker_result {
>      +
>      +	if (!initialized) {
>      +		smart_http_regex = xmalloc(sizeof(*smart_http_regex));
>     ++		/*
>     ++		 * This regular expression matches all dumb and smart HTTP
>     ++		 * requests that are currently in use, and defined in
>     ++		 * Documentation/gitprotocol-http.txt.
>     ++		 *
>     ++		 */
>      +		if (regcomp(smart_http_regex, "^/(HEAD|info/refs|"
>      +			    "objects/info/[^/]+|git-(upload|receive)-pack)$",
>      +			    REG_EXTENDED)) {
>     @@ t/helper/test-http-server.c: enum worker_result {
>      +		!regexec(smart_http_regex, req->uri_path.buf, 0, NULL, 0);
>      +}
>      +
>     -+static enum worker_result do__git(struct req *req, const char *user)
>     ++static enum worker_result do__git(struct req *req)
>      +{
>      +	const char *ok = "HTTP/1.1 200 OK\r\n";
>      +	struct child_process cp = CHILD_PROCESS_INIT;
>      +	int res;
>      +
>     -+	if (write(1, ok, strlen(ok)) < 0)
>     ++	/*
>     ++	 * Note that we always respond with a 200 OK response even if the
>     ++	 * http-backend process exits with an error. This helper is intended
>     ++	 * only to be used to exercise the HTTP auth handling in the Git client,
>     ++	 * and specifically around authentication (not handled by http-backend).
>     ++	 *
>     ++	 * If we wanted to respond with a more 'valid' HTTP response status then
>     ++	 * we'd need to buffer the output of http-backend, wait for and grok the
>     ++	 * exit status of the process, then write the HTTP status line followed
>     ++	 * by the http-backend output. This is outside of the scope of this test
>     ++	 * helper's use at time of writing.
>     ++	 *
>     ++	 * The important auth responses (401) we are handling prior to getting
>     ++	 * to this point.
>     ++	 */
>     ++	if (write(STDOUT_FILENO, ok, strlen(ok)) < 0)
>      +		return error(_("could not send '%s'"), ok);
>      +
>     -+	if (user)
>     -+		strvec_pushf(&cp.env, "REMOTE_USER=%s", user);
>     -+
>      +	strvec_pushf(&cp.env, "REQUEST_METHOD=%s", req->method);
>      +	strvec_pushf(&cp.env, "PATH_TRANSLATED=%s",
>      +			req->uri_path.buf);
>     @@ t/helper/test-http-server.c: enum worker_result {
>      +	cp.git_cmd = 1;
>      +	strvec_push(&cp.args, "http-backend");
>      +	res = run_command(&cp);
>     -+	close(1);
>     -+	close(0);
>     ++	close(STDOUT_FILENO);
>     ++	close(STDIN_FILENO);
>      +	return !!res;
>      +}
>      +
>      +static enum worker_result dispatch(struct req *req)
>      +{
>      +	if (is_git_request(req))
>     -+		return do__git(req, NULL);
>     ++		return do__git(req);
>      +
>     -+	return send_http_error(1, 501, "Not Implemented", -1, NULL,
>     ++	return send_http_error(STDOUT_FILENO, 501, "Not Implemented", -1, NULL,
>      +			       WR_OK | WR_HANGUP);
>      +}
>      +
>     @@ t/helper/test-http-server.c: enum worker_result {
>       	char *client_port = getenv("REMOTE_PORT");
>       	enum worker_result wr = WR_OK;
>      @@ t/helper/test-http-server.c: static enum worker_result worker(void)
>     - 	set_keep_alive(0);
>     + 	set_keep_alive(0, logerror);
>       
>       	while (1) {
>     --		if (write_in_full(1, response, strlen(response)) < 0) {
>     +-		if (write_in_full(STDOUT_FILENO, response, strlen(response)) < 0) {
>      -			logerror("unable to write response");
>      -			wr = WR_IO_ERROR;
>      -		}
>      +		req__release(&req);
>      +
>     -+		alarm(init_timeout ? init_timeout : timeout);
>     ++		alarm(timeout);
>      +		wr = req__read(&req, 0);
>      +		alarm(0);
>      +
>     -+		if (wr & WR_STOP_THE_MUSIC)
>     ++		if (wr != WR_OK)
>      +			break;
>       
>      +		wr = dispatch(&req);
>     - 		if (wr & WR_STOP_THE_MUSIC)
>     + 		if (wr != WR_OK)
>       			break;
>       	}
>      
>     @@ t/t5556-http-auth.sh (new)
>      +
>      +test_description='test http auth header and credential helper interop'
>      +
>     ++TEST_NO_CREATE_REPO=1
>      +. ./test-lib.sh
>      +
>      +test_set_port GIT_TEST_HTTP_PROTOCOL_PORT
>      +
>      +# Setup a repository
>      +#
>     -+REPO_DIR="$(pwd)"/repo
>     ++REPO_DIR="$TRASH_DIRECTORY"/repo
>      +
>      +# Setup some lookback URLs where test-http-server will be listening.
>      +# We will spawn it directly inside the repo directory, so we avoid
>     @@ t/t5556-http-auth.sh (new)
>      +# The server will shutdown if/when we delete it (this is easier than
>      +# killing it by PID).
>      +#
>     -+PID_FILE="$(pwd)"/pid-file.pid
>     -+SERVER_LOG="$(pwd)"/OUT.server.log
>     ++PID_FILE="$TRASH_DIRECTORY"/pid-file.pid
>     ++SERVER_LOG="$TRASH_DIRECTORY"/OUT.server.log
>      +
>      +PATH="$GIT_BUILD_DIR/t/helper/:$PATH" && export PATH
>      +
>     @@ t/t5556-http-auth.sh (new)
>      +
>      +test_expect_success 'http auth anonymous no challenge' '
>      +	test_when_finished "per_test_cleanup" &&
>     -+	start_http_server --allow-anonymous &&
>     ++	start_http_server &&
>      +
>      +	# Attempt to read from a protected repository
>      +	git ls-remote $ORIGIN_URL
> 
