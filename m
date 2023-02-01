Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245FBC05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 20:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjBAUC2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 15:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjBAUC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 15:02:27 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02olkn2021.outbound.protection.outlook.com [40.92.50.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0161A7A88
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 12:02:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrjfPiq2NNkJtifEX7ta2+Q5yJQyC144sO6AJX9h1XQUic9U0L8o5D4RoCo8Umg4bsqMxGO2bsUsEk4tRcw/GQSRmN2KLKGVg4GjpzU/iHRazsKEiEF3oK+Sa5isdAX6JCm7Tl3z6KdDxqQPGbHG9lThS4eNrR7yjUyckbTjodHEFSi4yaDQQGqqUUgKXWEPxQvLXQkZ7LHUbjxuh3sXFbogUMH2jps6GUP0XsO8iGWWY8o3lwKqyInAIuQr3/TRi8fiS7XoLInLjpMkM8ltHFtC/4jeRGZXWC33c0Uy+KfId/LMafhmAv5RxGNG/P2viXTCx0SbUlYYskeaFZsZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkPgHxEqwSTz2wIBhUMEkT3/uJ0CESlWJQza7GjyUbQ=;
 b=SDdIeyrC1+Nvvg/eMSeVrrgIrk5NpvnU14HAykVXO0+SnqPnzk7r4hHsBXnG2K7OapWE2mVTDI2Gl0L2Pdi4avYFbEnH5sQ/OGtWjhn/SiUd7Msn30p76HeI/i/b1M1flaESSOKym9f7DF2rPvehwwRWZzSL+XjapAsHqn4Te8pi9+Qw8l0QvN1awa24IU5/T2XZUEeCEbflTcIYn6Pd+iQ8lb4HwhTvB3/y1JND6f7vmNCuio6iw+zIDuIW0P5If9v7U/Hx0bWPI90OAKTJU/rcae9ZKz1DnM9fyx5GL2GT6jTrVNG5hOa6h03YNxA9yRrYqc1gCmA0oiRf0+LCUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkPgHxEqwSTz2wIBhUMEkT3/uJ0CESlWJQza7GjyUbQ=;
 b=nmrBpZ7OYjIr5UFA0LkbD+pbQkF62qGMoxpG+PQqzN0tytknJWzrkUjKAaR6PBcNMATLI9yQIQdgfXG1+Pp95RptWLuXog5ph+fMjD8Dz4ksqceyJCuSSk31SRqnI4g/+J6/01gAcO3uiPaZ1zfb+HDl0JiKCX5wUdFdYOdhIrs2Z6EsLtZk/whEK3cjdr23gqDqezDzlZ6Yyn90Mc7tt/rXLxbcrb2gtEI4i5Z+d/5Gt3noJLjF3G7UufQ0yKHuWFS2wii6MJCS22QcEXF7nNcPu5QmnYZrlVmPrH66xMK48P6QAU9irMOjXMqxL5xDS+5U1skBIlB1CKJPj5REbA==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by AS2PR03MB9442.eurprd03.prod.outlook.com (2603:10a6:20b:59d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Wed, 1 Feb
 2023 20:02:24 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::5c97:f035:18a5:ec57]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::5c97:f035:18a5:ec57%4]) with mapi id 15.20.6064.025; Wed, 1 Feb 2023
 20:02:24 +0000
Message-ID: <AS2PR03MB9815DDCB7B107E7FD37EC972C0D19@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Wed, 1 Feb 2023 12:02:16 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2] credential: new attribute password_expiry_utc
To:     Jeff King <peff@peff.net>,
        M Hickford via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
References: <pull.1443.git.git.1674914650588.gitgitgadget@gmail.com>
 <pull.1443.v2.git.git.1675244392025.gitgitgadget@gmail.com>
 <Y9pWxHfgPtgCKO+B@coredump.intra.peff.net>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <Y9pWxHfgPtgCKO+B@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [C/W+4ect7uZJk/DV8173h2nz7RbrV2Qm]
X-ClientProxiedBy: SJ0PR03CA0357.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::32) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <956dc4a7-31e6-646d-475c-dacb5ed48967@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|AS2PR03MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: eba3b4d1-7a26-4718-89cf-08db048f3baf
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C3Wq3mev1zK/Q8G4VL8tZc+lhbs5UoMRgKIN1eHE9YVpDgvgz1ChqKdLFvBrdEeihlDlfPeR1p4jmFot+PedYfnHzCB5LqNRFPDWe3RJGMUtYOvLEA2lX9UytE0KJowOeCvrv3Rsz68UfARIAWX3GuozXA4Ap1ZD8ykmxGb/SCzJg1DsEzv8a4ubodp3n2BL64gUdL0xGLabphDL98SLIOjsujwP8JKIBhi43+rWtPsotbpRpk/RS3+fv0JZAUI+Nn/Z7ZKJSRCTFBE7h9H5VwsVEG5D/KslVBmAhYxECm1W6EaYKgmn4h3HF4pLQNYcTCjdpFZZ5ta02e4BFuAfJl3vezaqxSsPPanSz+2Y1ojdiyDocZDu3Ep64ewfaYm68gmV2aqmvw7sjMj4LKNmvZmLBDLAzKMwxgrdjH2vwckrU1VrGDvepbm2bZ0K03tZbfUSF+HI2n8VW6AAb/0TG4m7JcJqOltr7HBG9aw6MezxriYowAJeRLISsJXvKlxe+QzUSCR3jmZ376K95+F+RJssUs09083Caw5RUmCXBLDky0R+xZCxo6ksTKMvp0X8n+tGKgXxoFkPHz1MKW7NUb4Zmh90LXuLNl0wpSCaaUdFcRS7AmO13QgG6ATKmabL19gpChH45SzczuIbRauWfg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHVCMUZFaTNlUDh5dmN4V0xPWW9hYS9OS1pnUDZWNHNORzIyb25ubDA4SnpQ?=
 =?utf-8?B?TGNsU0ZlQ3lqMXkvUVEvTUtiSGl2UFUvRk9obmpmWVg1VTVXZW1nRW9DUUYw?=
 =?utf-8?B?QXI2eVd4K2Z3ZXlYOHFPREZFL1ZEMDMyUVFmdGlYWXdDcGtjOVRzci9tUjJT?=
 =?utf-8?B?b1IvejhBdGhvdm84dzd3R3htaGVYQWFvUjZRT1NPMUpsNXdxaVdQYmN0Wkxl?=
 =?utf-8?B?Q1pFYUp2cE54QUNaU04wV2ZpS3lydXBLdDdJdlBkQUxLN0tQb3EzSVl1T1RZ?=
 =?utf-8?B?M3FUUmowSXdLTWZJUjUzWTZqODY3Nm1nZG1QMXVaeGo3bWhFWDE0aDZrdC9v?=
 =?utf-8?B?NnV4am04SDZLQXlHWnZHODN0S1Q1MnJXNUZ1aFcreE0vRkNOSCt6UWFhTDZL?=
 =?utf-8?B?SmpuVUhhbkw0aTNCVzd0QWpiVjZiSDVDWUhWUldaS3g2YUFYcmdOUDBNZ0Fs?=
 =?utf-8?B?VG44WXpYUm54SGRmTnhoT1p4a0szTUlHYnp0YWh0NENIQlE0RjRzZnRrRTU4?=
 =?utf-8?B?c21iR2RwYmhXSS9ZTW5VcU5MWlpCWFhDdHNIWWlGS1IzRW5lKzYyNVhyd2R6?=
 =?utf-8?B?TGREdE5iaXhvVzg4VEFrTE9TdzlrWXRVNXVORVhlQk8rY3NoanFXbDlYRVk4?=
 =?utf-8?B?YzVmZDQ5cUdDeHpDMUt2dEYrYXNnM05XT0U2TFRtYStheHNENkNES1R5Q3p0?=
 =?utf-8?B?RElxeHRkTFpCTUFpdkpVdDFPUTRaZnIyVGZrN3o1U1FCbGFJMXdLWlpSaUtG?=
 =?utf-8?B?UUJhWWVYZHhDMDRwMUZvdUVQOVQzUDdoWXM2ejNHRE9MSWh3QkNpYWZVeGxi?=
 =?utf-8?B?ZE52WXdrVjdQYXIwelhuWUZ0aDhIa3VpMDdLa3I4OTdIQ3dvRFVlR29LMWFD?=
 =?utf-8?B?RVlaWWxVWnlhR3EvNHZoU0pTRXJrRkFBbkc2cEkyMDJWK1ljQzZ6dVREMHgx?=
 =?utf-8?B?b3BGakxwZDFick5vdWtadm5kM2dlVEhBeXRNVUcyRkMrdXZsQ0E4ZVdISlRU?=
 =?utf-8?B?NGNFNGFiMXRXb1F3T3duYjFKRjdJdmgxWFB4Y3Nlc3dKckdJTkhEZEtMcUNq?=
 =?utf-8?B?UXlaeENyMU9pZVJoSmtkaFJZUjdOU2VhZUU3YlgrK1dKczdEN3RVNTFzOTV0?=
 =?utf-8?B?cEdwTGhoZll6MlpNV1p6NTZZNVRkditYWlhpWERLZ0JVUWo1N1RHOEVGZEhP?=
 =?utf-8?B?dGtxY0sxYVZ2Q0E2V3Y1R1J5bS9DSHRIRG52dmZhMzhockhwU1BTRlJ2bGhT?=
 =?utf-8?B?Mk4xSlVray9xOE84dzM5VFYxV1RPSnBnN2JUTENGMjNxd1d6R3B1eUw5dXpC?=
 =?utf-8?B?SXpudkdNendlQ2FxaGhJNGs3NlRGSy9jY3JwREJyemYxLzNHRGRkeTNybi9N?=
 =?utf-8?B?OVNicTFsY3VWS0Y2dDdydDdtWEVZaHNqWTdPSENadnlYYlc4NGRDaFFkNUJC?=
 =?utf-8?B?L3dkREhTcWNVOHFxYXNrZzM4MkJKMkFHQytLMzBoS1hVRFdnTnd1cUZtTWEv?=
 =?utf-8?B?cWJCclllNy9SUCttSm03bDNwbk1McDB1WFFKL0lKYWdiV1RIZGpCZ1hSbVdQ?=
 =?utf-8?B?b29JS1dwdzcxVjU4ODh1N29zMWpSS1NBN1F4N2RHQVl3dXBwSWdGb2pRQlZF?=
 =?utf-8?B?YWR4SzNObllCNzdsT0NRcXVhVEFBaVpSTlV3aXdwZ3BYKzVRV2F3THU3NHdE?=
 =?utf-8?B?UEQvbUZUZldwUGxFOS82Z2MzRVNPR081UkJxQW9IY3ROanpteGZFKzF3PT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba3b4d1-7a26-4718-89cf-08db048f3baf
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 20:02:24.2810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9442
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-02-01 04:10, Jeff King wrote:

> On Wed, Feb 01, 2023 at 09:39:51AM +0000, M Hickford via GitGitGadget wrote:
> 
>> +`password_expiry_utc`::
>> +
>> +	If password is a personal access token or OAuth access token, it may have an
>> +	expiry date. When getting credentials from a helper, `git credential fill`
>> +	ignores the password attribute if the expiry date has passed. Storage
>> +	helpers should store this attribute if possible. Helpers should not
>> +	implement expiry logic themselves. Represented as Unix time UTC, seconds
>> +	since 1970.
> 
> This "should not" seems weird to me. The logic you have here throws out
> entries that have expired when they pass through Git. But wouldn't
> helpers which store things want to know about and act on the expiration,
> too?
> 
> For example, if Git learns about a credential that expires in 60
> seconds and passes it to credential-cache which is configured
> --timeout=300, wouldn't it want to set its internal ttl on the
> credential to 60, rather than 300?
> 
> I think your plan here is that Git would then reject the credential if a
> request is made at time now+65. But the cache is holding onto it much
> longer than necessary.
> 
> Likewise, wouldn't anything that stores credentials at least want to be
> able to store and regurgitate the expiration? For instance, even
> credential-store would want to do this. I'm OK if it doesn't, and we can
> consider it a quality-of-implementation issue and see if anybody cares
> enough to implement it. But I'd think most "real" helpers would want to
> do so.
> 
> So it seems like helpers really do need to support this "expiration"
> notion. And it's actually Git itself which doesn't need to care about
> it, assuming the helpers are doing something sensible (though it is OK
> if Git _also_ throws away expired credentials to support helpers which
> don't).

I have often wondered about how, and if, Git should handle expiring credentials
where the expiration is known. In my opinion I think Git should be doing
*less* decision making with credentials and authentication in general, and leave
that up to credential helpers.

The original design of credential helpers from what I can see (and Peff can
correct me here of course!) is that they were really only thought about as
storage-style helpers. Helpers are consulted for a known credential, and told
about bad (erase) or good (store) credentials, all without any context about
the request or remote responses.

If no credential helper can respond then Git itself prompts for a user/pass; so
Git, or rather the user, is the 'generator'.

Of course that's not to say that credential generating helpers don't exist or
are wrong - Git Credential Manager being of course one example rather close to
home for me! However the current model, even with generating helpers, is still
that Git will try and make the request given the details included in the helper
response.

It doesn't make sense that a generating helper that knows about expiration would
instead choose to respond with an expired credential rather than just try and
generate a new credential.

Now in the case of a simple storage helper without such logic, after returning
an expired credential should Git not be calling 'erase' back to the same helper
to inform it that it has a stale credential and should be deleted?
This would also require some affinity between calls to get/erase/store.


>> diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
>> index f3c89831d4a..338058be7f9 100644
>> --- a/builtin/credential-cache--daemon.c
>> +++ b/builtin/credential-cache--daemon.c
>> @@ -127,6 +127,9 @@ static void serve_one_client(FILE *in, FILE *out)
>>  		if (e) {
>>  			fprintf(out, "username=%s\n", e->item.username);
>>  			fprintf(out, "password=%s\n", e->item.password);
>> +			if (e->item.password_expiry_utc != TIME_MAX)
>> +				fprintf(out, "password_expiry_utc=%"PRItime"\n",
>> +					e->item.password_expiry_utc);
>>  		}
> 
> Is there a particular reason to use TIME_MAX as the sentinel value here,
> and not just "0"? It's not that big a deal either way, but it's more
> usual in our code base to use "0" if there's no reason not to (and it
> seems like nothing should be expiring in 1970 these days).
> 
>> @@ -195,15 +196,20 @@ static void credential_getpass(struct credential *c)
>>  	if (!c->username)
>>  		c->username = credential_ask_one("Username", c,
>>  						 PROMPT_ASKPASS|PROMPT_ECHO);
>> -	if (!c->password)
>> +	if (!c->password || c->password_expiry_utc < time(NULL)) {
> 
> This is comparing a timestamp_t to a time_t, which may mix
> signed/unsigned. I can't offhand think of anything that would go too
> wrong there before 2038, so it's probably OK, but I wanted to call it
> out.
> 
>> @@ -225,6 +231,7 @@ int credential_read(struct credential *c, FILE *fp)
>>  		} else if (!strcmp(key, "password")) {
>>  			free(c->password);
>>  			c->password = xstrdup(value);
>> +			password_updated = 1;
>>  		} else if (!strcmp(key, "protocol")) {
>>  			free(c->protocol);
>>  			c->protocol = xstrdup(value);
>> @@ -234,6 +241,11 @@ int credential_read(struct credential *c, FILE *fp)
>>  		} else if (!strcmp(key, "path")) {
>>  			free(c->path);
>>  			c->path = xstrdup(value);
>> +		} else if (!strcmp(key, "password_expiry_utc")) {
>> +			this_password_expiry = parse_timestamp(value, NULL, 10);
>> +			if (this_password_expiry == 0 || errno) {
>> +				this_password_expiry = TIME_MAX;
>> +			}
>>  		} else if (!strcmp(key, "url")) {
>>  			credential_from_url(c, value);
>>  		} else if (!strcmp(key, "quit")) {
>> @@ -246,6 +258,9 @@ int credential_read(struct credential *c, FILE *fp)
>>  		 */
>>  	}
>>  
>> +	if (password_updated)
>> +		c->password_expiry_utc = this_password_expiry;
> 
> Do we need this logic? It seems weird that a helper would output an
> expiration but not a password in the first place. I guess ignoring the
> expiration is probably a reasonable outcome, but I wonder if a helper
> would ever want to just add an expiration to the data coming from
> another helper.
> 
> I.e., could we just read the value directly into c->password_expiry_utc
> as we do with other fields?
> 
> -Peff
