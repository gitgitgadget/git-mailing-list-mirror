Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F033C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 21:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbiLLVy3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 16:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbiLLVyA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 16:54:00 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2023.outbound.protection.outlook.com [40.92.74.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A039B1ADB4
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:53:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5LCHsM8AKB3tyEztthetZAnmCBP0TwfGxW7nyavAIDn8Vu4Q465wJ9SD0RB7IMDqKRO6+6qOgPZeUHTqv2CqOrqVIkN04m1mpaJv8tr47wKZRXcueIfka6FLVed+U6ozhdLdGB31EgAZprNUmh9bvAJp040qByG30kH+Eiz4DDh5T73wKI/26KSVfgiOklJeFR9KVqA2yLmJwSszLbE4obDOdGKDkctt7Yre97H5K+pIb04TEoMdHwOTvL6BOruDuq1VFvl7JTsPh2BooNy+CS0tb3eAvUv0j2O9B6JLrNAkB7WiDdl2Y7tbLGEW5DWZrTr4nNLWyhqq5DNVQPnYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dA7C6mUmRiVshvGOagmZhO9eCYfdiTKrPuCI7ugg9fI=;
 b=HQc1kU/VZXlw2o2Kku3a5iER8yi2MWoeNaKkJ6MrNsHR6eXhsLapKKOE/G1MDtIqRMttSXxbWw59SYPA/pXRFawc1e85TC66NFFKi63CzHEcBd6WsntaVPMDldHybWU5XN/Iygh85EQthRVzH5jCfY86fznf7wRxbKifM6SrTyGrgJ+cSq4gLh62hhnryVteW5vuyZBUGIzFCOPlrHaHz/Zdh+GDV1y3ouwxdmjfeTce2xp7PmiMFuSn5NynXw7RnZd/lmb9yJjyN1o0Je+zpBUQYqeBW0Rbkj8OVjF0XClHp9KboQMxNaIf9i9V9DmDLhGm/4mRRbK8/K/Nt5ryww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dA7C6mUmRiVshvGOagmZhO9eCYfdiTKrPuCI7ugg9fI=;
 b=V9tOnvGe50mnfCo/Qqk92RUb+O390B3HoJV6IpKipa5MN43k3ZNGRxPiPYIgRVatm6aYaRrTAu6Yy0GwnagVkj3jCn3xdtCgENO9capzABdDjOji9gzELAvvQFxwZFxFcFAMok1VkNf2KxY21q8OLCsahdtgNaYmIO/Yo8Zagf5D1ceOw9H/HmxPM8k+2sOcC/UaMlItAULiHVJrI3E9fW6DRQOsF5gse3dkEtKrjs73h6gfNYn5Hr7NNtOPuqCUAOcFQNmulUVvtrGqKLlXsURd6fRW9cOZHuR+pFaMZhKVOhyYHJqqnkcLpHHkqm39A4IBUwMJVVRGkpHNwo9pIw==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by DB4PR03MB9555.eurprd03.prod.outlook.com (2603:10a6:10:3f4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Mon, 12 Dec
 2022 21:53:19 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::e829:a187:754:6a85]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::e829:a187:754:6a85%3]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 21:53:19 +0000
Message-ID: <AS2PR03MB981510046E40F6E943A9B981C0E29@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Mon, 12 Dec 2022 13:53:10 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v3 05/11] http: set specific auth scheme depending on
 credential
To:     Glen Choo <chooglen@google.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
 <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
 <2f38427aa8db188060d153d8ece9503e1b604e91.1667426970.git.gitgitgadget@gmail.com>
 <kl6lzgcz3ddq.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <kl6lzgcz3ddq.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [VNcnLA3EvxYpYhVrqaGf3JlRr4ykP/hoH7srLzsiNHsflIY48uyorRYKeH95JUmu]
X-ClientProxiedBy: BY5PR17CA0025.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::38) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <5ea224bc-a524-42c9-e8f2-43f12e107412@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|DB4PR03MB9555:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b0d7fc-c1b4-4539-766e-08dadc8b46b5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kVzu02K8KWs1VJmyDXVjZRud5MA1rix/WzUujvRW0Fuck01ylD4JBYs1Jc96vBs4NmhlBkiWjuYCT5cILwFSjbhFI+iBY+dCMTGjidJxBXBhqK6DE1uP6QW6gU/PverkVTaVdi//06lU9i3xa7XO5mo+p0dcN2fBgrw60KjmUlgBB7SLsPtVhR6xiAbmN+Vjqo7lelEr/6UtUD4+IfY2TMM5xGT6CvYULw4JRTUUf77MxeQ2XNTxMkUTKa2fUEdFEAdoMlafP/aHW1tqsQJtrlNQvVGlxYlfjMkZH+wFs/fPDZZWr9Nmmho6IUfm3hpp7mtnJBKibfIN44BAPHJlzolzgxZw6Mr4xNn1ct7gwmDUC+rHNhMn1FjeTd//JOGtCpFxDMGJuLgWliHS5HFZLI5VdtINDptVMvanm2r/ICu0sJCvxfrovhOHhqLR2082WUb6WHBZE6viZmDR/mQj4a9k7LTyoOJv2azNt2UmfFq0yXXofioPf/TiCzWF8q9Ayx2k8s4EGORlYJzCneXoo5wpjKOqjc+Z1C2a8YzJ923hD3CbBg9hhVJC4bJJFa6zM+y50cmWolANsQQ6eLwn33j4bCCfTyQv1XE0kZk4EtU0iSZVI6Mcnr09SAmUJO6WiVIM5TtECxHAKJvxnT8kUw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTkyZTNPUlRIVXdOMHdZS3BhNUFtZWdESDNpbWFQRmJxR0liQTVGYVg4cnNW?=
 =?utf-8?B?TGcwcDlxaXE1R0hvcFBJTk1jMWN1Tlk1TjBqeGZKV2tZejlLRHRWdCtDdEIv?=
 =?utf-8?B?WlUrNWNqbVVNSXBoWW5RZHJhZjhMSTI3bmExdDcxSm9hMytkQS9BVnphU3Bn?=
 =?utf-8?B?Z01RS2hGSVpZbmxKdVQ1a0RSc1RDVXRIVnNEemQrSEppc2ZwbjZXTU11TVdj?=
 =?utf-8?B?aUV5ZGRHZVdBam5jd29zbXBucTV0ajZQOUE0Tzg1ZGF4NlJrWG5CN3pmQ1N1?=
 =?utf-8?B?azJadUF2YlhNRllvYjU2b1ZtTVVoNEhMWTJOVStJcnZYYTFJV3pDbDdzNUtX?=
 =?utf-8?B?bVlkWHpMaFM3dG9pNU5lSllQTGRpMTJvY1RlZ1NZeHA1VnlVTi93TmRBK2dQ?=
 =?utf-8?B?TkhRWmdMM2NTWVdpQ3lvRXNkc2owdVQ1SnFNZm44VUpSbi9ybFV4cmlyMzJF?=
 =?utf-8?B?VDBrS1NzT2VUK0d6RnZ2cnJEdGJaQUQwZDhWQmZzWVcxOEhtMjBqWW5xQUJy?=
 =?utf-8?B?c3c1RE84OGNEZktEYyswbzZOY2JwbDh1T2t2Uk5pRUpwTVN6NDlqSkJ5VGR5?=
 =?utf-8?B?aURZUXViUVRIZU81TlBTRnVsTEV0WWl0ZEt0enpYZkpQOWNGN1BQeHcvc3Qx?=
 =?utf-8?B?dGJ5SmVVcTh3T2pLNGszYmF3bGdqN3NmL0pzaFBSbVpESjNXNnN1c0tYUjBB?=
 =?utf-8?B?NnZMV2Q0Mjh2M2tGMDd3QURONEpoSDN3dzg4YlRNcnZlOHdKOStVVjRJcTJU?=
 =?utf-8?B?WFpjODJIY1ptVUZNbnZtdHQwSlhvUTkwTTBtK1JxU3JXU292NUkyWHhYNFlv?=
 =?utf-8?B?OUx3bjN0TWo4a2NzRkxhR0xMMlF5cUU1MW91ZFRJQUxrWFhFSVVScG9wMGpD?=
 =?utf-8?B?ODg4bXlQcTRDcUE2NHI4bVUxblNDMWJGaEhsbWhLZWdGQ013Rkk3OGNwZ1lQ?=
 =?utf-8?B?d0UzUHhGdndNNk1MV3BFdklZSStjcEpvbnZocWU1bWdUQmJCRlF1TzBnZyt2?=
 =?utf-8?B?Rzcyb1RQeW1kRnJBcE5hb0R2Mis3bW01dDNha1lnSDVhaVBkRTA0Uk5GcHhJ?=
 =?utf-8?B?SDRrY2lhQ01mK2JtT1hJMjZhZVlHZWVHQTVRNWZLcjBIVGNvUnY3MTg3MVQ5?=
 =?utf-8?B?WGZMVkZtVVRpR0RkcWw3bWxCenlpM3F3b2FIcG1KdFdUU1p1b1M0RGdOeTRR?=
 =?utf-8?B?a3FjVmY0S0ZtendwN1VCanB6WUpXU2kwTW1HRkxFenVFZmJEL1pHVTdVZ1lh?=
 =?utf-8?B?ZDI3b3RHcjlEVHV0Mm5Camd6TnJBNXhWcXJWUGk0T2JxU2U2elpGbDJRTk9o?=
 =?utf-8?B?TmRjMzlDYkU3a0NiR05DWHVRbmExVE02aWx3WlkyMkN2NnJHL052RHo1WDZk?=
 =?utf-8?B?cU03WWxRbDh6bnVOQXpTRU4vTmdxWjFYdGEzSlhpWlFaSDh4Y1NpaldIQVQz?=
 =?utf-8?B?K2tWNFBIQjJ5eTh6VlN6VWlsRGFCR0Q5am5wOEZHSm5TYWlpTE83WlhyKzJq?=
 =?utf-8?B?RU4vcjFXN2N5aDNoQXlURDNIK0F2UWlIWERKcWdOOG1oVDVJSUpncThxMW84?=
 =?utf-8?B?enl5Y1c0cTlzYXhhYi9YRDJDSnRNTUhoSEZYSFdhTFVLRWlWNnNZaTNiK2lQ?=
 =?utf-8?B?a2E5Nlowd3RlbTBDbU5pbUZmc3BwYmtSTE1EbVlnYmxldWVrQzZZMExNLzkw?=
 =?utf-8?B?c21YK3dBa2dzbU5GZmpCZzF4ZnIvZ3dudWhERXN1aGo2VDh5MUF4eWxvL0Fz?=
 =?utf-8?B?RnpUcTIwc0hSaTA0QWxLdUtmWlBGdUQyVnFCWjhia1FzRXVHMlRrbjE3MG5u?=
 =?utf-8?B?b05RTkUxTzVnRzVyMXFjdz09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b0d7fc-c1b4-4539-766e-08dadc8b46b5
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 21:53:19.2327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR03MB9555
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-11-09 15:40, Glen Choo wrote:
> "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
>> From: Matthew John Cheetham <mjcheetham@outlook.com>
>>
>> Introduce a new credential field `authtype` that can be used by
>> credential helpers to indicate the type of the credential or
>> authentication mechanism to use for a request.
>>
>> Modify http.c to now specify the correct authentication scheme or
>> credential type when authenticating the curl handle. If the new
>> `authtype` field in the credential structure is `NULL` or "Basic" then
>> use the existing username/password options. If the field is "Bearer"
>> then use the OAuth bearer token curl option. Otherwise, the `authtype`
>> field is the authentication scheme and the `password` field is the
>> raw, unencoded value.
>>
>> Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
>> ---
>>  Documentation/git-credential.txt | 12 ++++++++++++
>>  credential.c                     |  5 +++++
>>  credential.h                     |  1 +
>>  git-curl-compat.h                | 10 ++++++++++
>>  http.c                           | 24 +++++++++++++++++++++---
>>  5 files changed, 49 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
>> index 791a57dddfb..9069bfb2d50 100644
>> --- a/Documentation/git-credential.txt
>> +++ b/Documentation/git-credential.txt
>> @@ -175,6 +175,18 @@ username in the example above) will be left unset.
>>  	attribute 'wwwauth[]', where the order of the attributes is the same as
>>  	they appear in the HTTP response.
>>  
>> +`authtype`::
>> +
>> +	Indicates the type of authentication scheme that should be used by Git.
>> +	Credential helpers may reply to a request from Git with this attribute,
>> +	such that subsequent authenticated requests include the correct
>> +	`Authorization` header.
>> +	If this attribute is not present, the default value is "Basic".
>> +	Known values include "Basic", "Digest", and "Bearer".
>> +	If an unknown value is provided, this is taken as the authentication
>> +	scheme for the `Authorization` header, and the `password` field is
>> +	used as the raw unencoded authorization parameters of the same header.
>> +
> 
> [...]
> 
>> @@ -525,8 +526,25 @@ static void init_curl_http_auth(struct active_request_slot *slot)
>>  
>>  	credential_fill(&http_auth);
>>  
>> -	curl_easy_setopt(slot->curl, CURLOPT_USERNAME, http_auth.username);
>> -	curl_easy_setopt(slot->curl, CURLOPT_PASSWORD, http_auth.password);
>> +	if (!http_auth.authtype || !strcasecmp(http_auth.authtype, "basic")
>> +				|| !strcasecmp(http_auth.authtype, "digest")) {
>> +		curl_easy_setopt(slot->curl, CURLOPT_USERNAME,
>> +			http_auth.username);
>> +		curl_easy_setopt(slot->curl, CURLOPT_PASSWORD,
>> +			http_auth.password);
>> +#ifdef GIT_CURL_HAVE_CURLAUTH_BEARER
>> +	} else if (!strcasecmp(http_auth.authtype, "bearer")) {
>> +		curl_easy_setopt(slot->curl, CURLOPT_HTTPAUTH, CURLAUTH_BEARER);
>> +		curl_easy_setopt(slot->curl, CURLOPT_XOAUTH2_BEARER,
>> +			http_auth.password);
>> +#endif
>> +	} else {
>> +		struct strbuf auth = STRBUF_INIT;
>> +		strbuf_addf(&auth, "Authorization: %s %s",
>> +			http_auth.authtype, http_auth.password);
>> +		slot->headers = curl_slist_append(slot->headers, auth.buf);
>> +		strbuf_release(&auth);
>> +	}
> 
> As expected, a "Bearer" authtype doesn't require passing a username to
> curl, but as you noted in the cover letter, credential helpers were
> designed with username-password authentication in mind, which raises the
> question of what a credential helper should do with "Bearer"
> credentials.
> 
> e.g. it is not clear to me where the "username" comes from in the tests, e.g.
> 
>   +test_expect_success 'http auth www-auth headers to credential helper basic valid' '
>   +	test_when_finished "per_test_cleanup" &&
>   +	# base64("alice:secret-passwd")
>   +	USERPASS64=YWxpY2U6c2VjcmV0LXBhc3N3ZA== &&
>   +	export USERPASS64 &&
>   +
>   +	start_http_server \
>   +		--auth=bearer:authority=\"id.example.com\"\ q=1\ p=0 \
>   +		--auth=basic:realm=\"example.com\" \
>   +		--auth-token=basic:$USERPASS64 &&
>   +
>   +	cat >get-expected.cred <<-EOF &&
>   +	protocol=http
>   +	host=$HOST_PORT
>   +	wwwauth[]=bearer authority="id.example.com" q=1 p=0
>   +	wwwauth[]=basic realm="example.com"
>   +	EOF
>   +
>   +	cat >store-expected.cred <<-EOF &&
>   +	protocol=http
>   +	host=$HOST_PORT
>   +	username=alice
>   +	password=secret-passwd
>   +	authtype=basic
>   +	EOF
>   +
>   +	cat >get-response.cred <<-EOF &&
>   +	protocol=http
>   +	host=$HOST_PORT
>   +	username=alice
>   +	password=secret-passwd
>   +	authtype=basic
>   +	EOF
>   +
>   +	git -c credential.helper="$CREDENTIAL_HELPER" ls-remote $ORIGIN_URL &&
>   +
>   +	test_cmp get-expected.cred get-actual.cred &&
>   +	test_cmp store-expected.cred store-actual.cred
>   +'
> 
> I'm not sure how we plan to handle this. Some approaches I can see are:
> 
> - We require that credential helpers set a reasonable value for
>   "username". Presumably most credential helpers generating bearer
>   tokens have some idea of user identity, so this might be reasonable,
>   though it is wasteful, since we never use it in a meaningul way, e.g.
>   I don't think Git asks the credential helper for "username=alice" and
>   the credential helper decides to return the 'alice' credential instead
>   of the 'bob' credential (but I could be mistaken).
> 
> - We require that credential helpers set _some_ value for "username",
>   even if it is bogus. If so, we should communicate this explicitly.
> 
> - It is okay for "username" to be missing. This seems like the most
>   elegant approach for credential helpers. I'm not sure if we're there
>   yet with this series, e.g. http.c::handle_curl_result() reads:
> 
>     else if (results->http_code == 401) {
>       if (http_auth.username && http_auth.password) {
>         credential_reject(&http_auth);
>         return HTTP_NOAUTH;
> 
>   which seems to assume both a username _and_ password. If the username
>   is missing, we presumably don't send "erase", which might be a problem
>   for revoked access tokens (though presumably not an issue for OIDC id
>   tokens).
You are correct here that a missing username here may cause some unexpected
issues, and there should be more test coverage here.

My recent v4 iteration has actually dropped the `authtype` patches here,
and I'll pick these back up along with these concerns in a future series.
Splitting this in to a future series is probably a good idea as I feel
there's going to need to be several cleanup patches adjacent to the core
new-feature patch, so I wouldn't want to polute this series :)

Thanks!
Matthew

