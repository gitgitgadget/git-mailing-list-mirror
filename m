Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1231CECAAD8
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 22:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiIUWVD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 18:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiIUWVB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 18:21:01 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-oln040092075021.outbound.protection.outlook.com [40.92.75.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB8632AB0
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 15:20:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ho0Xb0QyhtUtVKFztVT4uYazmOgyCFaYEnex1378lZQshMvY49UhxUrBnJGOi13Q6Fp7JNqf/9hsVwD4SxpMm3kP1qL4CnOd/WYELAGaxjvsC+B5S5kb3bXYCZ1Nh5MCkIk27uhMaxOccK8nXlJKA8c3rOBbyCOh0oxazYsjyI/5hu8PTqZgf/w1Fny8MhnWK5Sxk9s1IAJSBmIr4u5bBikSMZO1Zs749JklsozqdSmI0ElUIX3X4+FS4RK0nrfF/LepvPP2uzPcap7b2q4exO7ocK/4t5+c/G8660yx2hN6UGFZH+5Hbzehqg/7ZRF7jYF3Ycdy7FvgS3uQHbRL/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Nds8aoVmQD8PkrvUYycRl4kXN6FvA1eXsWCIMDSiVg=;
 b=haYuXsnwN6T3zsu6Uu76mUyQT/JrbZ/mR5QSJAga5w+QjNGxrekLYtgX2/Drgndi7F0UP0nqP7zYYN8t9z8nMOSgHK9sfPdSlVTqX5Fl6zb55X3IJsMIG6Qmx5sitBCA8/uXT7/S499s+mZT6kefbOpdbaSgXlXAZV3ZtPQgjPlAvwGwbYtnf14Axo31KDd8M8erUbwvMNdlW1U2eGQJ76+jLqFfxluQ/Klsa7BufFPjISxbeRFy8+2WrOD9JGOOr3cO9j0XLot+i40wmLcAfbeVLvKqK7sA3v+xLehTds4hWaF9jY+JGDidseALieUS7XKvPyVWB6tu/y2o2vu4fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Nds8aoVmQD8PkrvUYycRl4kXN6FvA1eXsWCIMDSiVg=;
 b=VY904gANoIPNRwTVNrV/yLV4qGdwhD3ZxLpyR7Cm18nZEW06kowS9rgQiKL08aKYsv70cKGmzoUYiV4mgNHI2qPnrEsBTYJcg1/Xy06ym7aTKUNP92wR0kBGXVLKyrupz26DJV3/k8K1YCDM5vywoBOc5LoK5ZOrCqHCIxT0GF0P5N7o/z8rLe1D+9GlzUZYvQDvrXi0P5OAgCcX7NscooLiAPxuA81nYBI36zxIC3XSi34rZzz3zZTRbtkpmZ7vxNleepBWXYHi4Kc0r0eUD3HW6WRpQYah/uwyb7mgNn7Df+w+6S0cVbByl52SgW3UvHBFEk2ZzCmSgA5EIIRsyw==
Received: from AS8PR03MB8689.eurprd03.prod.outlook.com (2603:10a6:20b:54e::12)
 by PAXPR03MB7917.eurprd03.prod.outlook.com (2603:10a6:102:214::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Wed, 21 Sep
 2022 22:20:57 +0000
Received: from AS8PR03MB8689.eurprd03.prod.outlook.com
 ([fe80::10:9a9a:64a9:612d]) by AS8PR03MB8689.eurprd03.prod.outlook.com
 ([fe80::10:9a9a:64a9:612d%4]) with mapi id 15.20.5632.021; Wed, 21 Sep 2022
 22:20:57 +0000
Message-ID: <AS8PR03MB86899B51BD151490CC16283FC04F9@AS8PR03MB8689.eurprd03.prod.outlook.com>
Date:   Wed, 21 Sep 2022 15:20:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH 5/8] credential: add WWW-Authenticate header to cred
 requests
To:     Derrick Stolee <derrickstolee@github.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
 <936545004b8b46cbe24d8069cfd95ae5b5f98593.1663097156.git.gitgitgadget@gmail.com>
 <69cbe403-48a2-ac5c-5743-5b7cae5ae523@github.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <69cbe403-48a2-ac5c-5743-5b7cae5ae523@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [ShTz0DyDPkvEIxMcvWPDpM29OE7TxtYE4MZcjHYs5891ig0I+huIQw8kPuf1KZ7/]
X-ClientProxiedBy: BYAPR06CA0028.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::41) To AS8PR03MB8689.eurprd03.prod.outlook.com
 (2603:10a6:20b:54e::12)
X-Microsoft-Original-Message-ID: <e8da3094-555e-7dad-1c99-b9fcaebedaa2@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB8689:EE_|PAXPR03MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: a43c5abf-fdb3-4ce3-43f4-08da9c1f8e52
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W+B0unkBM19xN7Lpln5giIpZkYZijDPsoEkv4FycO5fiNDE+pDKBwg/Or+Uy54VI9mH5y8OkZmiE9BV2YR/+mW+MZk4yyz35kXXqu4p/S8lRDpCtFYzfSJTxLk8J4NY7bpOcih+xNzmhqbMVtIF5RlAgLc1n/odM2hftwJpCs+7Lfz+ExOovn6uOIOBC1ARbDVQcyhUYpyUu6Ex6b+L8E/4D1uCkm2cZQWl8rP3RSgVd36+pud/KPnja4jYbnWXUJSSfRHZj8oyqjlH9jphcp7Qentckq3JSZBeNu1ls0tlgOXlMWKkHrRiB5SbULQahxrgFYVTAhAgbFLqTqs6EkjXKSM3Syjj4t3JTU22RR/xum+dZrgwe56HMOArWMHp4xZcVF/KWFCLS5HRFnsreTfc9/e6qz2uWJBEZeC+Sm7FHUo8VJI3+GOj0qenxnsdqk2yUYyLCqtSwlfnuEe0tpRrOyrycAp5DX2D14Qaqx4LHacP54NJ+ZtTaqufSeaYqj0qE2qvOQYkY+v6vH52omittQvwxEc5MIed10MswsDKDIsflKurM+97Y6/Cssu+GrcB8SMAZas7ME1Qh2HkhyIX8uJAx33qLAY4ojKoKP4aV+fHq3SgM8ZeeweketNAQgrz0J1kXYoDIGe1cM6U7fdD2Wwe7t/CmbRPV1UsPy6I=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajVsWEVTUGtRaXJDWHAzY0tYVi9hRkxvU3hEMW0rS3U4WWp2Q2Q5anBtUEdl?=
 =?utf-8?B?OVVpcU9BLzAyT2FNT1A0Q251RHV0eXNudDlLaVlpcHFrSTdlcmpHZ3JaUFJx?=
 =?utf-8?B?NDMyWGg1RUlIZExRc0t0b3dCeHdVRTJiQ3RCZy9uUlA2THZldDVRT0F2Vm1X?=
 =?utf-8?B?WitBSzRPblZZZ0hDTkt2eEpnUlJOdG1BOXEvTlRTU0ovbnEyN1FKNkNCZmUw?=
 =?utf-8?B?eDZhRzdNUG9Ka1Y1dmlNZEZEUHlPZjd0SlNzQUhwSGpERzdndUNLRkZwUnNR?=
 =?utf-8?B?dEhZcmVGbjFhSW53Y0RqQ0ZUcjhJQWdOQlA4YmRreFpJN3Era3pPdENwUDNG?=
 =?utf-8?B?SURtNHh3cjJpMGRNMVdtT0xsNlpCNUw1ZnBIWUI2V3FlSEVPamVmQUlYOXFw?=
 =?utf-8?B?VzR1RHhReTF0Z2ZwQlJZSUxzY2dQdG9PTFJ5cVptUXJ4M0luU2h5V3A5cjBT?=
 =?utf-8?B?d3FMVDVyT3BOZTdTeTFWNWxCWUIyM2ZSZVFsL1MxaHVKb2h0TFo1cEIwalYw?=
 =?utf-8?B?bjJsTlNnR0FacGF2K3hmdldPZ1I4MjVEbTNuNktmb21teFN5bHZLYmZyNzJl?=
 =?utf-8?B?RlNWYTFKVENiV1M2TUNUMEtpVWNSRnQyWHdJN3hGTnZvbHlGYlBtbkNKbGNN?=
 =?utf-8?B?MGUzRkF3NFlPWHZaMWtrN05hdXhqVkpucUp5OEkzeXlrNWd2U3hkU0IycGJ1?=
 =?utf-8?B?dkJrNGdJa054djB6SW5LNGlXK0s2eERnTi9STFRpcXhPelJTSGxOYnJHUGhJ?=
 =?utf-8?B?QTBmeGpqZG5uS1pGV1ZFZ3Zpd1Q3S3Roc3NGUjBsL01LbzNkMkx2Y2gwOElr?=
 =?utf-8?B?ZkxUaGpHZUM1TlRPaFRycHl1b3hVVzFJUDlUK0RzWm1GZHRLdnI1M2tVamRE?=
 =?utf-8?B?UlVNVFM2anBORmVMdEJzN05HckVKa2NkenBaSWZST21INmIybFB5aFVVTDBL?=
 =?utf-8?B?Y3dNS2h6VUcraWQyYXBHdkFHaS94MHdTSTJtOUxMLzFHck9LZjJpamxVLzVn?=
 =?utf-8?B?NlpnYkg3NTlLaVVCeEtxTGQwdUhrYnNzekpaYjIwMjRkcTJ2ODA0endLMlFP?=
 =?utf-8?B?UnVuVzdNb3lMd1F4OHRBcDBacXlHRVhRZkFvUUZUYVhqOGc3TC9xQzJWNDVl?=
 =?utf-8?B?ZmZqNHFsdDdBbHNrTXFJZUF0YW9Ia04zaHdaM2xlU0VwU2xYUjhGTkJTRFlR?=
 =?utf-8?B?eWVqK2tnRk5SYjJUcWhRZTBXSVFDMjc5dm0rclpoek13blZNSCtVY2FPS09x?=
 =?utf-8?B?MkI2eWdQaDJvL3V0MlNHVjluUGNtNGIvdTdFMW1teGlWSW4zTlBJY3FudHJO?=
 =?utf-8?B?QjZubDcrU0tCbHlxZDBDSXhpZUNmMnphWWhjYTFEMy9aTnpQbG1MQnBYUU5Z?=
 =?utf-8?B?b096UktSVDF5MVNxMWVRdkIwUHU1eWEyYWNMV3dwZ1BiY1ZkRnQxR0tSMHFW?=
 =?utf-8?B?R1cwbHFSS3Mvb2xhOTltSTIyKzlJWGpYQktneDJLbFcwWkVkMnZQKzJ5NkZE?=
 =?utf-8?B?VmN3VzBwdFNsVGlSSkRjY2hWTUYxNVB2cDJtM25qU1d6VUkraGxSMzVtdlRu?=
 =?utf-8?B?b3BuSjExVXpFT2FZdDBNbWE1Y2tldlh1ejlHUG5jRUlDeTVjZFZqa2RzT3Fw?=
 =?utf-8?B?VkV4am1RK3lid1B3NU91TzhaT2NVei9ncG8vQmxiVjM3L09MVTEyRWRBdElB?=
 =?utf-8?B?U1pQUWVQaTMxVDJnbU9XdlJKRCtId2U4ZjhoMmdQZmNSdU5tRUtKR3pTYnBS?=
 =?utf-8?B?TXRNRDd1cFErRmYzWGQxd25DSWxsZXJOVE10RURCWXZ3a2NkTXBqQWxhckl6?=
 =?utf-8?B?Z3VhRHQ2b1FzaTJBYk5Ddz09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a43c5abf-fdb3-4ce3-43f4-08da9c1f8e52
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB8689.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 22:20:57.6383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7917
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-09-19 09:33, Derrick Stolee wrote:
> On 9/13/2022 3:25 PM, Matthew John Cheetham via GitGitGadget wrote:
>> From: Matthew John Cheetham <mjcheetham@outlook.com>
> 
>> In this case we send multiple `wwwauth[n]` properties where `n` is a
>> zero-indexed number, reflecting the order the WWW-Authenticate headers
>> appeared in the HTTP response.
>> @@ -151,6 +151,15 @@ Git understands the following attributes:
>>  	were read (e.g., `url=https://example.com` would behave as if
>>  	`protocol=https` and `host=example.com` had been provided). This
>>  	can help callers avoid parsing URLs themselves.
>> +
>> +`wwwauth[n]`::
>> +
>> +	When an HTTP response is received that includes one or more
>> +	'WWW-Authenticate' authentication headers, these can be passed to Git
>> +	(and subsequent credential helpers) with these attributes.
>> +	Each 'WWW-Authenticate' header value should be passed as a separate
>> +	attribute 'wwwauth[n]' where 'n' is the zero-indexed order the headers
>> +	appear in the HTTP response.
>>  +
>>  Note that specifying a protocol is mandatory and if the URL
>>  doesn't specify a hostname (e.g., "cert:///path/to/file") the
> 
> This "+" means that this paragraph should be connected to the previous
> one, so it seems that you've inserted your new value in the middle of
> the `url` key. You'll want to move yours to be after those two connected
> paragraphs. Your diff hunk should look like this:
> 
> --- >8 ---
> 
> diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
> index f18673017f..127ae29be3 100644
> --- a/Documentation/git-credential.txt
> +++ b/Documentation/git-credential.txt
> @@ -160,6 +160,15 @@ empty string.
>  Components which are missing from the URL (e.g., there is no
>  username in the example above) will be left unset.
>  
> +`wwwauth[n]`::
> +
> +	When an HTTP response is received that includes one or more
> +	'WWW-Authenticate' authentication headers, these can be passed to Git
> +	(and subsequent credential helpers) with these attributes.
> +	Each 'WWW-Authenticate' header value should be passed as a separate
> +	attribute 'wwwauth[n]' where 'n' is the zero-indexed order the headers
> +	appear in the HTTP response.
> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
> 
> 
> --- >8 ---

Thanks for catching!

>> diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
>> index 497b9b9d927..fe118d76f98 100644
>> --- a/t/lib-httpd/apache.conf
>> +++ b/t/lib-httpd/apache.conf
>> @@ -235,6 +235,19 @@ SSLEngine On
>>  	Require valid-user
>>  </LocationMatch>
>>  
>> +# Advertise two additional auth methods above "Basic".
>> +# Neither of them actually work but serve test cases showing these
>> +# additional auth headers are consumed correctly.
>> +<Location /auth-wwwauth/>
>> +	AuthType Basic
>> +	AuthName "git-auth"
>> +	AuthUserFile passwd
>> +	Require valid-user
>> +	SetEnvIf Authorization "^\S+" authz
>> +	Header always add WWW-Authenticate "Bearer authority=https://login.example.com" env=!authz
>> +	Header always add WWW-Authenticate "FooAuth foo=bar baz=1" env=!authz
>> +</Location>
>> +
> 
> This is cool that you've figured out how to make our Apache tests
> add these headers! Maybe we won't need that extra test helper like
> I thought (unless we want to confirm the second request sends the
> right information).

This will exercise the new header parsing and passing the info to the helper
but will indeed not test the response. I feel like a test helper would be
beneficial still.. what I've done here doesn't feel 100% clean or complete.

>> +test_expect_success 'http auth sends www-auth headers to credential helper' '
>> +	write_script git-credential-tee <<-\EOF &&
>> +		cmd=$1
>> +		teefile=credential-$cmd
>> +		if [ -f "$teefile" ]; then
> 
> I think we prefer using "test" over the braces (and linebreak
> before then) like this:
> 
> 		if test -n "$teefile"
> 		then
> 
>> +			rm $teefile
>> +		fi
> 
> Alternatively, you could always run "rm -f $teefile" for
> simplicity.
I like simple :-)

>> +		(
>> +			while read line;
>> +			do
>> +				if [ -z "$line" ]; then
>> +					exit 0
>> +				fi
>> +				echo "$line" >> $teefile
>> +				echo $line
>> +			done
>> +		) | git credential-store $cmd
> 
> Since I'm not sure, I'll ask the question: do we need the sub-shell
> here, or could we pipe directly off of the "done"? Like this:
> 
> 		while read line;
> 		do
> 			if [ -z "$line" ]; then
> 				exit 0
> 			fi
> 			echo "$line" >> $teefile
> 			echo $line
> 		done | git credential-store $cmd

That we can.. I will update in next iteration.

>> +	EOF
> 
> 
>> +	cat >expected-get <<-EOF &&
>> +	protocol=http
>> +	host=127.0.0.1:5551
>> +	wwwauth[0]=Bearer authority=https://login.example.com
>> +	wwwauth[1]=FooAuth foo=bar baz=1
>> +	wwwauth[2]=Basic realm="git-auth"
>> +	EOF
>> +
>> +	cat >expected-store <<-EOF &&
>> +	protocol=http
>> +	host=127.0.0.1:5551
>> +	username=user@host
>> +	password=pass@host
>> +	EOF
>> +
>> +	rm -f .git-credentials &&
>> +	test_config credential.helper tee &&
>> +	set_askpass user@host pass@host &&
>> +	(
>> +		PATH="$PWD:$PATH" &&
>> +		git ls-remote "$HTTPD_URL/auth-wwwauth/smart/repo.git"
>> +	) &&
>> +	expect_askpass both user@host &&
>> +	test_cmp expected-get credential-get &&
>> +	test_cmp expected-store credential-store
> 
> Elegant check for both calls.
> 
> Thanks,
> -Stolee

Thanks,
Matthew
