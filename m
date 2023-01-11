Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B46C46467
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 22:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbjAKWAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 17:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbjAKWAo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 17:00:44 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2050.outbound.protection.outlook.com [40.92.58.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099E642E11
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 14:00:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7BlEo+pJSLH3E0vPDsHD8Jnyo+0sNThruqcVA0VpuTnIIcTpvSzVpeh459rgK2OMxD6lyejfA0eLaHyhWgCReEpHGyd2trTLK+ukWiPJfvxdexUjEW6vAsY/81nZVzHdh/HAGftDOgjCEYmS1PaW2fq+r7la8XrcCjMa1UoPcVkx1IwMbFYW77BqsgCMQp46+YmTbqae05Lu5544wCD+IFsmPH4KFOc9LMfO2H3xZPTgoUR+5lqw9++4KQYxlaXrus/7WgWj3x6n5InXQRYzKebMCtI+m1iP6drD6f2BS82boHnctDB9v0RfnoqgCflM85JfCtddOVjkgZb050MMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6m/8OYLh1FmeQh+OqXV1yh56QTctjea3rdcxbsB+GfA=;
 b=kcOXo842hqw6A9ZJMJA5Ilvzm9Kw3rrnhgjmezICZrCWGDRqeK72WUMDI6qXd1+LMJrtbM9PriUMFSfYGlwVlBZmYp1diSC6HIjACmRUMabycPosmlW1o9QH5pzL4CZLK97jxmKC73fBH9MlBDcdNQC6o4lHzlbaATyFS3/gjX1R8GmapIxpYfzVotE556YP9LIye7UtfnYW9tyK/trLlDZZ7TsmZaon/UaYmg2xvXN9I8HvTwRO+UUHZuV6m14cFWu1nGYSYu5zycZnuw6rTzpIySs17x/+F0Rma8yMMcMkj1Ds89Wbu+4FcINsyBUqO0TcHL1dnPE6+OogOxIPkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6m/8OYLh1FmeQh+OqXV1yh56QTctjea3rdcxbsB+GfA=;
 b=moqgdZ+7+vhsLj1CwbEVJdtOJoVrs7lhI0a5gNInISh6B1ew5ea7UnBKL6HX2nTGt+50D6K2zUKzCnMrmyGUS7N1D7p4NAoF9QVIsv9N3luz4zeBEpGdyponMz2WrWEjMkSOLupH7NsHIrEyOonVyb9N6MbpZmHKr2rIGdk0RttPRPtKJ3rDmqJy8hx/I+UKAQi/J3XT9wzhGHUQMPSYUkHFylVXgcslI8qXMfLGC4SXh3q0IRHIi55c1W4dqzq/BQUIlGDs1CbJcGTtRcgkLpEIwhaqlAJXxnkizXS0DWCWicy+IUaUnSCiChE7qPpcAIQ7b9PZ4rsbFXMqZi//fw==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by AM9PR03MB7868.eurprd03.prod.outlook.com (2603:10a6:20b:433::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Wed, 11 Jan
 2023 22:00:40 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519%8]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 22:00:40 +0000
Message-ID: <AS2PR03MB981593EB3382F9738D2CA3D7C0FC9@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Wed, 11 Jan 2023 14:00:32 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v4 7/8] test-http-server: add simple authentication
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
 <794256754c1f7d32e438dfb19a05444d423989aa.1670880984.git.gitgitgadget@gmail.com>
 <2a5d6586-3d2c-8af4-12be-a5a106f966b5@github.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <2a5d6586-3d2c-8af4-12be-a5a106f966b5@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [lQPMafcNbcEzFloTcKmFjkKvqIeKuqGQ]
X-ClientProxiedBy: BY3PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::27) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <bdd7b703-9fc5-142c-a479-2850ec5433d1@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|AM9PR03MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a2bcba-ddf9-47b1-f1d0-08daf41f46d0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WGh+d5IEObRiePoEpKlHh9SpLOgqc8ObiMRVPkiNb52hjxo7lDKj+F6o74q7Bi/GgUunuh4MCf/au27OVBo6qDZSiUx3azA6lYzXvdRqujR8da/haa5Cfk+zyQ642kFX6uVxFWkaO9OuWZBxAMLJ49yWWftk4seWkvipV+QtRasHDpYTRvrk/6VVIPmdvQ7nu/385FAQA3RhWYHUbYVly+J0BAPSwLrlgPvmAMvBc5WUqxJWcy7W5798/WnMixc2yoYa75raAydmQNFWB/heHKgWLQmxmMRyk0JBu8k1KjsPGaUAVU+9U42NVGvK3XRWCs91sdBvXXFx8l8TbwbITqK4yrlqhPm6bJZC7pw9oacxEIBFCQtrtUieKxMKs33ILJZ5Hh8kAwhSkBgPdG4t51xR8dn0kWQqHVuvlqZOEbPu75e46G3O57TYlvdSD69ccG/Ucf61NsB9HhGI5zfegmF2LTgnSuyMaxt3Ua7ipgQQygyKNbLJC9K8ZRJwKihR1Afu3Yb35v5UjmZ5/HisNZ6Yxo0EmjPUduSeH+NEuo4JNLLKV6r/JHk+5xz0C1O66L1HuhyJWBrqAfGpgTb5Yx2PtWOgIXJpwgj0nqoH6U4VQUBmyDXDZ+dVSYiWsFAdUajT/mwll7cdsxW5njdn2Pykzxcy4+4mAlsX/eEywYM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGFnS2NBZDBSVG9vZkRFWThCMSt2QzZCalRuVnZYQ0l3ekxMZFNKdzcrUXUy?=
 =?utf-8?B?WXg1VzZGaW9qdGVnQ0N6OXBYOC9PMGJSd2dFd2tLZDdheTVVVEFBcHlaSUd0?=
 =?utf-8?B?WEdpYjVsdDdsaW9td2ZoNkVKSG5XRlkzSXFsRUlpUE01d0E3R2JzSjBLZjBw?=
 =?utf-8?B?bFFLN0lLcExOVFhrejNiSXE5Uk5wdUh4eWJBT2xFaENvRjE3MllOeHlqOTBE?=
 =?utf-8?B?UGdpVXc3eG53RExmMTlKV0FOcG96d1AyR3Zodng2azREVUo4NzJUb0toOCtw?=
 =?utf-8?B?cTcwS3NyQ3gvdEJYdTFSR3NOSmNiMjJQY2NxallleGh3enNRYkpHNlplZFoz?=
 =?utf-8?B?VXpHR1hLVERaamx4b2xTTWQvMEhwTy8zVjVlL0RJNDZ4c0gzb25NMGl1UzMx?=
 =?utf-8?B?Wlkwd3FnYUVWejRmR2NacjZDS28wSFptV0o4U0J0RlhncEwyTGVJbjZjMmJF?=
 =?utf-8?B?SUFZYThZVTNLSVpaTGIzQzF5NzFpUDZMNWFOMmZjYVVhVmtLYnROa0JlK3FM?=
 =?utf-8?B?cmM0SFM3ZEZVSmc0OGZibFkxazVPYS9KK2lZZnB1bGxBbUtTOVN0Vzh4anYr?=
 =?utf-8?B?Zm4zUnBrRlFzb1UxSVkwcmNCR2ZTY2xVclg3dEhzVGFzTWdlZ3VtS1pPK0V2?=
 =?utf-8?B?VVk1QnBORXdzNWRBVjNoczlJRUoyZG9ueHN2VXgwVnFPZklxUHR4TDJWV05M?=
 =?utf-8?B?ZW5zNzhGbWVpYkdpVUJTUkd3Y1pnaDVTdUMrNnI4TWMrTFZGLzRkcnY4Q0NN?=
 =?utf-8?B?b3FUUVJWc2N6ZEMyZUFWSThpdmFidmFMWCt3eC9QNHdIQ2k5aU9OSzNRR3Mv?=
 =?utf-8?B?K0VPMWx6WjNUbk9sL1FIcVA4YjY5OUlScW4raWo4QTlQTlFOWjNLTFFaY3VS?=
 =?utf-8?B?bC9jZVV6R216WkZZMlMyVEVZUmNEQW9CdGhMeDE0QkllckpMUlpkdGduWFkv?=
 =?utf-8?B?M3NCV0tFMW81dmtMajBxSFZ3dHZaWlJ3VmQrR09nQzFma2FQOVllOFdXNXN6?=
 =?utf-8?B?VlRJWWZNL25BTEdCbnRFMTBYYWQvaVNJUjNWTjRDT2srVmpkVjVLQngvbHEz?=
 =?utf-8?B?RGx4QVBzT0I2d1JmWHpyQWJBVE9CYktYaUh0Ym81NjNWS3pMSVljZ0hkbjlr?=
 =?utf-8?B?RnpweDJGZ1dBRnJUZWo3VzZEcGs5Vks0VU96NUcrdUhHL05MQTFUVHpNcjNs?=
 =?utf-8?B?MjRUWXJNSVBzcDJ6WXhnVUhIeU9TcjdXUFlwend4SnQzeVBRaWRZSERaVjZh?=
 =?utf-8?B?WGlHYjNobTg0YVMvNmlYZnYyRlBqaUtPVWdBTWlpRHc3T2lRa0JiY1hmMmRs?=
 =?utf-8?B?elpCNDcvcGgzVWVqclNnemV6VGVGbUJEU0lHK2pNQmZ3VzVnTHd3aXc0L1Ar?=
 =?utf-8?B?bTNtSHRjdjVnODZEMDBTMlpUVmlLTXkrNTZnTHBXb0MzT0VKTTByVS9DL0lv?=
 =?utf-8?B?OSttQlA2dWp4SGc4bEdOSzl5ckN1eCs5cGE1L09Hd1VIVGsvRW5oQ3pjZStM?=
 =?utf-8?B?MmQ1Zmh1c0ljbGFiM0U4VnloWVYvWWpnU00xNE4xaDNWN0lmMFFuY2VjZXZC?=
 =?utf-8?B?RlJRblA0dWE0bkFUSm14Q2VZK3EzaHRiWUhOWC9ycnZJcGFuTE1HeXE2K2xh?=
 =?utf-8?B?NXdKU1ZRWm1udFczcTkrRDhsV2hXenNVZk1hRjVib0xTSTN1eko5VEdsZi8y?=
 =?utf-8?B?ZUlSVGJISlJ3TkdKQVZWUVRhSmRZOVV5TjJNU21xQmFBVVlYZmU5Y3hRPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a2bcba-ddf9-47b1-f1d0-08daf41f46d0
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 22:00:40.1077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7868
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-12-14 15:23, Victoria Dye wrote:

> Matthew John Cheetham via GitGitGadget wrote:
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
>> +	/*
>> +	 * Check all auth modules and try to validate the request.
>> +	 * The first module that matches a valid token approves the request.
>> +	 * If no module is found, or if there is no valid token, then 401 error.
>> +	 * Otherwise, only permit the request if anonymous auth is enabled.
>> +	 */
>> +	for_each_string_list_item(hdr, &req->header_list) {
>> +		if (skip_iprefix(hdr->string, "Authorization: ", &v)) {
> 
> Is only one "Authorization:" header allowed? If so, adding a 'break;' at the
> end of this if-statement would make that clearer. If not, what's the
> expected allow/deny behavior if e.g. one header is ALLOW'd by one auth
> module, and another header is DENY'd by a different auth module?

Yes, only one Authorization header *should* be passed.. but the RFCs are not very
explicit about that. The test server supports multiple, but will `ALLOW` or `DENY`
based on the first matching auth scheme (module).

> 
>> +			split = strbuf_split_str(v, ' ', 2);
>> +			if (!split[0] || !split[1]) continue;
>> +
>> +			/* trim trailing space ' ' */
>> +			strbuf_setlen(split[0], split[0]->len - 1);
>> +
>> +			mod = get_auth_module(split[0]->buf);
>> +			if (mod) {
>> +				result = AUTH_DENY;
>> +
>> +				for_each_string_list_item(token, mod->tokens) {
>> +					if (!strcmp(split[1]->buf, token->string)) {
>> +						result = AUTH_ALLOW;
>> +						break;
>> +					}
>> +				}
>> +
>> +				goto done;
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
>> +
>> +	case AUTH_UNKNOWN:
>> +		if (result != AUTH_DENY && allow_anonymous)
>> +			break;
> 
> I think this just needs to be 'if (allow_anonymous)' - we already know
> 'result' is 'AUTH_UNKNOWN' once we reach this block.

Note that `AUTH_DENY` falls-through to the `AUTH_UNKNOWN` case.
The only time we *DON'T* want to output the auth challenge response headers is
when there was no challenge provided (`AUTH_UNKNOWN`) *and* we are permitting
anonymous users.

  result      | allow_anoymous | Output Challenge?
---------------------------------------------------
 AUTH_DENY    |       1        |       Yes
 AUTH_DENY    |       0        |       Yes
 AUTH_UNKNOWN |       1        |       No
 AUTH_UNKNOWN |       0        |       Yes

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
>> +	}
>> +
>> +	strbuf_list_free(split);
>> +	string_list_clear(&hdrs, 0);
>> +
>> +	return result == AUTH_ALLOW ||
>> +	      (result == AUTH_UNKNOWN && allow_anonymous);
> 
> So if a user is explicitly denied, even with 'allow_anonymous', this fails?
> Is there a test case that uses that behavior and/or is that standard auth
> behavior? Otherwise, it'd be simpler to skip the 'is_authed()' check (in
> 'dispatch()') altogether if 'allow_anonymous' is enabled.

If the user is being denied by a module we should always deny access.

Admittedly, for this simple authentication scenario it's kind of silly to deny
a user who is trying to identify themselves, but permit an anoymous user.
However, if this was an authorization failure then denying a user based on their
token may be totally valid. Right now, we're only concerned about authentication
and not authorization, so I could move this check to `dispatch()` if you feel
strongly about it.

>> +}
>> +
>>  static enum worker_result dispatch(struct req *req)
>>  {
>> +	enum worker_result wr = WR_OK;
>> +	const char *user = NULL;
>> +
>> +	if (!is_authed(req, &user, &wr))
>> +		return wr;
>> +
>>  	if (is_git_request(req))
>> -		return do__git(req, NULL);
>> +		return do__git(req, user);
>>  
>>  	return send_http_error(1, 501, "Not Implemented", -1, NULL,
>>  			       WR_OK | WR_HANGUP);
>> @@ -854,6 +982,7 @@ int cmd_main(int argc, const char **argv)
>>  	struct string_list listen_addr = STRING_LIST_INIT_NODUP;
>>  	int worker_mode = 0;
>>  	int i;
>> +	struct auth_module *mod = NULL;
>>  
>>  	trace2_cmd_name("test-http-server");
>>  	setup_git_directory_gently(NULL);
>> @@ -906,6 +1035,63 @@ int cmd_main(int argc, const char **argv)
>>  			pid_file = v;
>>  			continue;
>>  		}
>> +		if (skip_prefix(arg, "--allow-anonymous", &v)) {
>> +			allow_anonymous = 1;
>> +			continue;
>> +		}
>> +		if (skip_prefix(arg, "--auth=", &v)) {
> ...
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
>> +			/* trim trailing ':' */
>> +			strbuf_setlen(p[0], p[0]->len - 1);
>> +
>> +			mod = get_auth_module(p[0]->buf);
>> +			if (!mod) {
>> +				error("auth scheme not defined '%s'\n", p[0]->buf);
>> +				usage(test_http_auth_usage);
>> +			}
> 
> Does this mean that '--auth' needs to be specified before '--auth-token' to
> avoid the "auth scheme not defined" error? If so, this could be made less
> fragile by just setting the string value of the arg in this 'if()' block,
> then processing the value after the option-parsing loop.

Yes, `--auth` needs to come first and 'setup' the module and challenge.

>> +
>> +			string_list_append(mod->tokens, p[1]->buf);
>> +			strbuf_list_free(p);
>> +			continue;
>> +		}
>>  
>>  		fprintf(stderr, "error: unknown argument '%s'\n", arg);
>>  		usage(test_http_auth_usage);
> 
> I think a test (in this patch) showing how the auth headers are handled by
> this HTTP server would be really helpful in demonstrating/exercising the
> intended behavior. 
> 

Thanks,
Matthew
