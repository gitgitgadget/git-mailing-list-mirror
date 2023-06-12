Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28195C88CB2
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 23:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbjFLXM1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 19:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjFLXM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 19:12:26 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2033.outbound.protection.outlook.com [40.92.74.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511B9E65
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 16:12:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+aWyZaOqhv1Dr4NZK9pPudxQ+4HrDleHg+vdn4cv51cIpQSeJHoz+2cp8J/2Ttgau9lFxAJsklDMjTe4N6/9rNgKsDmUlcKDX9IRYS1cA7bQlzG0NUHq2wOffuLrPsVFPQ7pgIizqLyIyoSmoL8/9xrOMUj+sqaj6gmdoqJyCXsZSjv9Bzo5LjpR0r/5BqHUEdvDbfzcdbp78ei9tjILfp4/D/0qAQOYKUhmdH1f3ed6K3HNLRXDJj7QrUM2hwFGYMW9OOLcwgvWa0GZgjtEzgraL70AK+r41HKfDeCUAh0YpbJLT3t0iV3MYEPhmog0VprJJ31WrvQRygbtlqPiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xB55PFGoGpGJDpgC96V28DKbKETHepz/ipf0OXTEOsk=;
 b=YwGWT4nZuSEYHzZXFOHFz4a+LuklrMK1hZ7vXz6Bp3crOavm8iFD+L6vozgLs6NoSVN6vuRaMN0Mp8UueZIaS0zhxPS/HeYZgQeLinzB+Drv3DckRVYEE0VV87jB9FKax+AIZBKiPTPEPJ7Wn5vmhoTTHJ0K224PVEwOkDDbTtS2h4PHp3cSS4+nJ5qE3Md433070OwW8Ewf9XvThjABpk0ZPMcQiVtjIAPcvcT+Hsd12Sl6sZE9qnwZohBbJM64UomSIhlMiwHs3Xbt3bzsT6fnrNJ0tebwoeI6Jym6xx+jxhEyKBFbYB2QMHuN96sGuAoltqoaL+hZZ+SZDNh8ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xB55PFGoGpGJDpgC96V28DKbKETHepz/ipf0OXTEOsk=;
 b=k0Vh7NfOqkKNJqT2vfsR/Y/bmuFltD4Zf3C8bbbxkAn4FDRtuuyha/t6vCUmB6DVKdnG7um+FvdSpu1LaJ27JCxEArH1OB3SXBoRnaM7vNG9n+NhqLzoxMSuXzw+M548l8BxSn+piyBtNU21Y8Z9+R3HRZHeNIZKpO5uYFD6TRcpYws8//gWMiw0OeAfzbCNiPJCXw3Zdif9p++wXP/zAWr4/BCeY/1li0sr1KGofOYgqkDSI+xS5TVSzMuKux6JI2AER4vLpMspg2RADuvKaOGgIrRR1EwDA+Q/gsPmwqUzTehto+HOvT7ZQSkCJPfOSMQQk51ceNCySIc0LLorNQ==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by PAVPR03MB9653.eurprd03.prod.outlook.com (2603:10a6:102:319::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 23:12:21 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::9df1:f20e:d351:f94d]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::9df1:f20e:d351:f94d%4]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 23:12:21 +0000
Message-ID: <AS2PR03MB981571E7A85446AC0E1CCE0CC054A@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Mon, 12 Jun 2023 16:12:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] [RFC] http: reauthenticate on 401 Unauthorized
To:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     M Hickford <mirth.hickford@gmail.com>
References: <pull.1521.git.git.1686474351611.gitgitgadget@gmail.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <pull.1521.git.git.1686474351611.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [b2M4DcoVkmYjnIejemFrVCmsbu8AvTNYiCs+9tjnq4Z7s4D/8xXZY1+x9A1Mx3NX6EMOdt3PnM0=]
X-ClientProxiedBy: SJ0PR03CA0257.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::22) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <c8ff87de-f045-07ea-6bda-cd0ffa033a70@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|PAVPR03MB9653:EE_
X-MS-Office365-Filtering-Correlation-Id: f0f660f2-517c-433f-4c23-08db6b9a7922
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C1PzjMOzx3yzOf5sKe3Nw32YQfPieOSM8/etqkIdbR+O6vKAn0SC0HhBNPlhyaCpP2oVUik6XvY1tcrUbHI/rrPqwIBcJRlgcEh1w5q0G4iv8rmJK+Lc9g/EK3AO05u2n2edK/AD0m/pqgkq1M5TXcMLktmUNdC+W0stvrlAf+k5SckWY64CtNfbMWvO5dL8kL7zLjhjKhkGncobzfbs+GM6t0YRrgNcHhrgurgBBs8rycDOaJPzrZ11jDICAx8cTC/t+3yjEGxy0rJAVYuWrn+WMAJ+Y8Oyij4oPtRSsY2Kylpej7Od5QBwVdKn8FJXqzXhU0f5CnMxtUUHZXPKE9+Q7CajAS44wvE7QiGvCrCqoAMI2HAnfqk/U9/qeS7fGtV3rtdmpCWr1/aC+JkR2MEw/F4yV7QynKX+ZbtONgx08Ztac3Ys49tJibzxj2XMedyvZtz+RaMz6VHHAyE9V1IYPdLE+45jFTq88ZaCfx8G6JKteoBIgJQnsKJ9cKcuhhK/16DskIceyC9UwbC675lCwMbFa1OXFg02AA8uFC46jRq7cRAl6sJznphvqkmEVvFjytATpWnaz46W2U/zSJR4lu/aeLl+q7l2eSHlgv1mNEVwMfsSGNFgW/ezauQEQN2SnGmpQTFnVfqNTBAkDQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWZ5anNIVGlVR3JXbFFKUlNFWnB5aVgyOXlZYWNBZnU3cEN6bEU2alBNZFJF?=
 =?utf-8?B?U010MjhqYkQ0N1dGTTJFTTJtcUpMek9IMVNBem1oVW5uMm5NMXlLYVR3ek5O?=
 =?utf-8?B?d3dOOTBybHV3ck1wM1lqZUZCTTkwMThJdU1HV09IQ256RnJrbFZoV3Ixa0pk?=
 =?utf-8?B?bEtJQ29vOVdnSDFJOU9xNXEyVXJqQ3htL1RBaE52TjR0c0ZabGxXRFcweTNi?=
 =?utf-8?B?b292Vmw5cisxOG01K2dYbnJNYlgzZFUrUHNwQUpYWlcvcHF2SUlBdjdPaWVR?=
 =?utf-8?B?eHFCZ3lOcGRWWUdGeXJ5SVpBOW9ZY1RrbDhuRXVYazYvdkhKQnNXazhRelVw?=
 =?utf-8?B?VTFhNW52Z1huL0ZqNUhoK1Rqb05RdkMzRkwwZ1J1c3JrNWprU3JpSk9RbWNJ?=
 =?utf-8?B?RktTVjArKytkb29lMWF0WUJLMUQrWjhrRWxYUHNTcHhZUUZHREJnVXRXK0pv?=
 =?utf-8?B?TnVrM05uTFUxMlpEbVFRSmZtaFFXMEtVUWZVeFpwTDRpZTFrQkR5SlE4Visr?=
 =?utf-8?B?bnRnTldkVEYzejZwSGFpbE54dDNVMVpNQ1JTVjA4SWhEbU9PRWt4SDNZSlZo?=
 =?utf-8?B?R0UreW1GWVQyNnhFOVhVQVBwdU1oNXJqVWJQNlowMU1vSGY2Y2V0dHdTeFlU?=
 =?utf-8?B?RGcva3cwbkpDNDB3REcrVG9Ia2w0bWRrQ0haRU56djVnSXVCZFQ2aTFrRStN?=
 =?utf-8?B?b3oyMzZMc1puVzByZkx3ZlFoM1lxOUVBeG1xQ2JBZjVIc2hRWUd0M29QcjYv?=
 =?utf-8?B?eXV6b1N1R09WUWJaS24vUEdmRWpkVnFJam9ZaDZhOERHUzNlVy82b0RCQldB?=
 =?utf-8?B?Qlp3b3d2ZHpmWUVMcHoxZm1EK2x2V3N0azZxMDdmaFZmbGxhQWNucENvWnJa?=
 =?utf-8?B?U0YrUi9rbVdGVEZFaERjeHQ2S3VIUUl2V3I1aFpSbkY4MVBFdk92YTBucHlI?=
 =?utf-8?B?bjJvZTZSOVFCeTN1SEF0ZUcxazFWWHlKY3NwRGREdjl6dGRCa1pmei9NeUVu?=
 =?utf-8?B?ektJU1ZYbFBNbE5YSSs1MWVvdVZzNXZPN0xHakRDMXBrTWd2dnJyZzY4elVQ?=
 =?utf-8?B?a2pCdUh6bGxaTTdJTWNrZ2tDdmxzN0xTUENoTWsxMm9Sb0VxNDdNVksxSjZP?=
 =?utf-8?B?cXNham96ZHlJMHIxemtBWFV0QTFjVXVCUlE5b1RCdE5uWkRGU01QWGFMck1i?=
 =?utf-8?B?NXBsbUtEWFdONUdqbVhkZ3Zmd3JPWmhXNUlIcGNwMG4rK1RzU0ZIdnVwd1dT?=
 =?utf-8?B?MHhRL05zSkxNWWRIVkUrS2tkcmgyWk5FWnAwUXJpVFlURXR4bDBFUm1UM2JX?=
 =?utf-8?B?SXBRZmdnWEhwQlcyQldEdEZXakc4Y0dETWFSSU90TDE0YW0vYnBFbjd0dVRi?=
 =?utf-8?B?d2tTZDRhcmlzZUsvczM2SWdMdVZaeGdESXRZS2dtRDl4dzJzU2hldnpKdVBa?=
 =?utf-8?B?aW5JTDNKMU1pUElVRndrbWs3NytBQVpHVTV0NHBYcWlJOENDeXFxSmpPRW5l?=
 =?utf-8?B?b010RXNYWWk3QmVKTEFJY2l3WlZVeVEzVWt1RUxHTk5SL1Y3ZjljYmt6dzht?=
 =?utf-8?B?UzZjMEM0RU10ZTM5bGZiT1NHTUh6YWtONDRCdU9XTW5zVDZvekJZYTF0Vm02?=
 =?utf-8?B?Q25kUWRrRzhpOUhCVlVwU3FhZVFCZHpKcHZHZXhQN2FhS3djRnhRMHpMVkRG?=
 =?utf-8?B?cHlqVlUycTFwSTBzZ0p5NTlTL1loNVowSHFrRTgrdmZTbTlrOVZoRkJrYmQr?=
 =?utf-8?Q?7cvDG4+TOc7sx9vajU=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f660f2-517c-433f-4c23-08db6b9a7922
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 23:12:21.1524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB9653
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-06-11 02:05, M Hickford via GitGitGadget wrote:

> From: M Hickford <mirth.hickford@gmail.com>
> 
> A credential helper may return a bad credential if the user's password
> has changed or a personal access token has expired. The user gets
> an HTTP 401 Unauthorized error. The user invariably retries the command.
> 
> To spare the user from retrying the command, in case of HTTP 401
> Unauthorized, call `credential fill` again and reauthenticate. This will
> succeed if a helper generates a fresh credential or the user enters a
> valid password.

Adding a retry mechanism is something I'd love to see! I've had some
thoughts on this for a while, so apologies for a bit of a brain dump..

> Keep current behaviour of asking user for username and password at
> most once. Sanity check that second credential differs from first before
> trying it.
> 
> Alternatives considered: add a string 'source' field to credential
> struct that records which helper (or getpass) populated credential.

I think having some affinity/knowledge of which helper was called is very
helpful and important. In this RFC you only permit one retry attempt,
which could be something that the helper itself may wish to specify
(including zero retries).

When I was working on the WWW-Authenticate series, one thing I'd played
about with was having helpers respond in the `get` response some hints
or features that modify how Git would subsequently call the *same* helper
with `erase` or `store`, including retry.

Example:

  protocol=https
  host=example.com
  username=test
  password=secret-value
  can_retry=1

'Storage'-only helpers would not be able to service a 2nd `get` request
after the first `get`, since the subsequent `erase` would delete the bad
credential, so always retrying for all helpers can also be wasteful in a 
different way. Retries would definately be useful for credential-
generating helpers however.

To be able to issue these retries, wouldn't it make sense for Git to
consult the same helper that responded in the case of multiple configured
helpers? Likewise if one helper responds early in the chain and returns a
bad credential, do we want to call `erase` on all helpers in the chain
(including ones that were never given a chance to respond)?

One more thought about adding a retry mechanism.. if a non-trivial helper
has a set of possibly valid credentials (say, for multiple accounts or
contexts) for the same host, today we'd have to ask the user to pick one
to use. If we had the ability to retry we could use our best-guess and if
this was incorrect only then prompt the user to select an account/context.
BUT.. since we'd get an erase in the middle (`get` -> `erase` -> `get`)
how would we know to ignore this request?

Are we in the 1st or 2nd `get` call?

For this we'd need to allow helpers to somehow re-establish state between
`get` and `erase/store` calls. We could achieve this multiple ways.
One option could be adding some unique request ID that Git provides to
helpers, to allow them to save state and 'connect-the-dots'.
Another would be to allow helpers to encode state that Git should echo
back between calls. The latter would too require helper affinity however.

If Git learned such a retry feature, this should also be advertised to
the helpers in the first `get` call to they know the possible  change in
behaviour, or can opt-in to using the such mechanisms. Something like:

  _supported_options=retry foo bar
  protocol=https
  host=example.com
  wwwauth[]=Basic realm="example.com"
  wwwauth[]=Bearer authorize_uri=https://id.example.com/oauth scopes="a, b"


> Signed-off-by: M Hickford <mirth.hickford@gmail.com>
> ---
>     [RFC] http: reauthenticate on 401 Unauthorized
>     
>     cc. Jeff King peff@peff.net
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1521%2Fhickford%2Freauth-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1521/hickford/reauth-v1
> Pull-Request: https://github.com/git/git/pull/1521
> 
>  credential.c                |  1 +
>  credential.h                |  4 +++-
>  http.c                      | 30 +++++++++++++++++++++++++++---
>  t/t5551-http-fetch-smart.sh | 10 ++--------
>  t/t5563-simple-http-auth.sh |  3 +++
>  5 files changed, 36 insertions(+), 12 deletions(-)
> 
> diff --git a/credential.c b/credential.c
> index 023b59d5711..00fea51800c 100644
> --- a/credential.c
> +++ b/credential.c
> @@ -379,6 +379,7 @@ void credential_fill(struct credential *c)
>  			    c->helpers.items[i].string);
>  	}
>  
> +	c->getpass = 1;
>  	credential_getpass(c);
>  	if (!c->username && !c->password)
>  		die("unable to get password from user");
> diff --git a/credential.h b/credential.h
> index b8e2936d1dc..c176b05981a 100644
> --- a/credential.h
> +++ b/credential.h
> @@ -134,7 +134,9 @@ struct credential {
>  		 configured:1,
>  		 quit:1,
>  		 use_http_path:1,
> -		 username_from_proto:1;
> +		 username_from_proto:1,
> +		 /* Whether the user has been prompted for username or password. */
> +		 getpass:1;
>  
>  	char *username;
>  	char *password;
> diff --git a/http.c b/http.c
> index bb58bb3e6a3..d2897c4d9d1 100644
> --- a/http.c
> +++ b/http.c
> @@ -1732,7 +1732,11 @@ static int handle_curl_result(struct slot_results *results)
>  	else if (results->http_code == 401) {
>  		if (http_auth.username && http_auth.password) {
>  			credential_reject(&http_auth);
> -			return HTTP_NOAUTH;
> +			if (http_auth.getpass) {
> +				/* Previously prompted user, don't prompt again. */
> +				return HTTP_NOAUTH;
> +			}
> +			return HTTP_REAUTH;
>  		} else {
>  			http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
>  			if (results->auth_avail) {
> @@ -2125,6 +2129,9 @@ static int http_request_reauth(const char *url,
>  			       struct http_get_options *options)
>  {
>  	int ret = http_request(url, result, target, options);
> +	int reauth = 0;
> +	char* first_username;
> +	char* first_password;
>  
>  	if (ret != HTTP_OK && ret != HTTP_REAUTH)
>  		return ret;
> @@ -2140,6 +2147,9 @@ static int http_request_reauth(const char *url,
>  	if (ret != HTTP_REAUTH)
>  		return ret;
>  
> +	credential_fill(&http_auth);
> +
> +reauth:
>  	/*
>  	 * The previous request may have put cruft into our output stream; we
>  	 * should clear it out before making our next request.
> @@ -2163,9 +2173,23 @@ static int http_request_reauth(const char *url,
>  		BUG("Unknown http_request target");
>  	}
>  
> -	credential_fill(&http_auth);
> +	first_username = xstrdup(http_auth.username);
> +	first_password = xstrdup(http_auth.password);
> +	ret = http_request(url, result, target, options);
> +	if (ret == HTTP_REAUTH && reauth++ == 0) {
> +		credential_fill(&http_auth);
> +		/* Sanity check that second credential differs from first. */
> +		if (strcmp(first_username, http_auth.username)
> +		|| strcmp(first_password, http_auth.password)) {
> +			free(first_username);
> +			free(first_password);
> +			goto reauth;
> +		}
> +	}
>  
> -	return http_request(url, result, target, options);
> +	free(first_username);
> +	free(first_password);
> +	return ret;
>  }

Does updating only `http_request_reauth` cover all our bases here?
I know there are several other code paths that do not use the `http_get_*`
functions but still invoke `credential_fill` and `run_slot` / `run_one_slot`
(which then calls `handle_curl_result`).

For example:

- the `imap-send` command
- callers of `post_rpc`
- callers of `http_init` when the `proactive_auth` arg is true

>  int http_get_strbuf(const char *url,
> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index 21b7767cbd3..be2e76133c1 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -589,14 +589,8 @@ test_expect_success 'http auth forgets bogus credentials' '
>  		echo "password=bogus"
>  	} | git credential approve &&
>  
> -	# we expect this to use the bogus values and fail, never even
> -	# prompting the user...
> -	set_askpass user@host pass@host &&
> -	test_must_fail git ls-remote "$HTTPD_URL/auth/smart/repo.git" >/dev/null &&
> -	expect_askpass none &&
> -
> -	# ...but now we should have forgotten the bad value, causing
> -	# us to prompt the user again.
> +	# we expect this to use the bogus values and fail, forget the bad value,
> +	# then reauthenticate, prompting the user
>  	set_askpass user@host pass@host &&
>  	git ls-remote "$HTTPD_URL/auth/smart/repo.git" >/dev/null &&
>  	expect_askpass both user@host
> diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
> index ab8a721ccc7..1e7e426bc65 100755
> --- a/t/t5563-simple-http-auth.sh
> +++ b/t/t5563-simple-http-auth.sh
> @@ -111,6 +111,9 @@ test_expect_success 'access using basic auth invalid credentials' '
>  	protocol=http
>  	host=$HTTPD_DEST
>  	wwwauth[]=Basic realm="example.com"
> +	protocol=http
> +	host=$HTTPD_DEST
> +	wwwauth[]=Basic realm="example.com"
>  	EOF
>  
>  	expect_credential_query erase <<-EOF
> 
> base-commit: fe86abd7511a9a6862d5706c6fa1d9b57a63ba09

Thanks,
Matthew
