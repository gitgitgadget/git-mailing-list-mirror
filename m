Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70DDC46467
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 20:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjAKUh2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 15:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjAKUh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 15:37:26 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2105.outbound.protection.outlook.com [40.92.75.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01435C74F
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 12:37:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auJ7UdSqtid6H4D8o0BmrPSUAAvuj4AIv0VRugpVTe8IDHk9MC74q1KXt/tSdx4/x+Npv6PE95yiMPu4KCDvZ2eQgOAsUfeBuYKc+xpgXgutMYPLvn95YO+CV5g67y33G7qrKIZRLInzWdSi+wYPMDJhcoZjPx3ijxhhM4SJ/8hRNUaNG0Xq1ZA0F8kI5KKLdsG5MWxOicrSEa81PyAaxeLMvxjLgPCVdTs49EX698Powi1MzF2+aKrnjAmVwMAr8RDacb0VIDwPCPGryMRZ5xB+nT/HW3/oSe+ILyE6LEUgKnfYfDVCRRSCO1glrTmWNEUbbL/200+3SwReH4yrsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwlcNSrMFsFGazE3fEuMgCkcoY22Qz95Cv8JPRobxNA=;
 b=kn9vCvAv635xnXDZ1JOmya7e54Zm/N3S69YsqmFKUhhk27Kx5gEbmd3rHDG22OmRCNHYBc6TezZQ6++sbqL3jlJsWp7TB7AqQlKmXZ2+aHnA1kBzSLbWgsB+8Pw9lXbITrGzkm+yvsuGR6RnHCMEOVPVGvNT4kxa7PJ8bbX+i/z17ffRwu9+Y98W1BCPz+UvZwkEmUmfMA9AcXk85HGCc0vcG27+Y6lPOEcoP42eZ6wKO+a3EA4EW/HTbYrJCEE4I7AznoEAyXf16SxXd1RXc0hGV51sL7xwJQz2yHVEeD2a/AQtChtFMalLnE5r6iOjv5CgWm4NKYgvIhW0Vpys2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwlcNSrMFsFGazE3fEuMgCkcoY22Qz95Cv8JPRobxNA=;
 b=uQWoc8iVFYBXr7ng87/z9gb7VJFbUrIzHgf/noCB132l6eQvrRgDg2whm0VojPS30R5O4FenyMMmEYRQ5LZJaYrRt/WBSwph62ZWc8UkgG3kMQfo63XgIyn3K8r+IIxSdZ3JalsvfELOi75NdsqjsaHfEQ0J4Qz3n8OfFaLxPG2VoV5Kp0Y2wxNOJrZQVkGgoYCDPi/xlY2DjrClaA1nl0EmS/lSX3uh6GcyoZaAgTwlm/6lssgAVnNLaeIogVviAx6g2IvJdkfhMdHPsTywLJN7Nq6nFbOOI0wv+e4OrtNKiL904r4NVxWVZuw8d3R6w6SKX+MmdshTf1X0j8QLig==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by AM7PR03MB6280.eurprd03.prod.outlook.com (2603:10a6:20b:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 11 Jan
 2023 20:37:21 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519%8]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 20:37:21 +0000
Message-ID: <AS2PR03MB9815AE0DC94C53B59E13C3C9C0FC9@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Wed, 11 Jan 2023 12:37:14 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v4 2/8] credential: add WWW-Authenticate header to cred
 requests
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
 <d02875dda7c0939a0de59a47fa9eb3a73ebd29a4.1670880984.git.gitgitgadget@gmail.com>
 <35352a10-3fc0-365f-11af-b821d114c409@github.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <35352a10-3fc0-365f-11af-b821d114c409@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [8rNv9QguxKle0IXLDMGUyKjLUCeFTAg5]
X-ClientProxiedBy: BY3PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::13) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <29c1d85a-a68f-2c10-989c-75cd2ce2d1b1@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|AM7PR03MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: e24078a9-c2ef-463d-442d-08daf413a398
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QXkBDNCSAcJUEsYSPqFPEVznZ3AQ6RAq3Bv6E68L/JdgGjUsed50cnLX8ENmZIRA5RwT1c/XB8zq0mu9U+1PHHraV9QA14VcgMN74moSDSNYAF2J5Un63XQsR5JacyYMRnKM5i3VsmbDfi6wwgW2YgnydIwFC9b1ZbFXoV4OjgjK+GNWD6jhnWIuXW6uYTv/u4Pu0zZf/Bte4fTEjHstzG6WaxAE3aPjenhO0ZL1mQ13eE2psFaD+K9qyCymlbfFukW2NbbJz/QvDQesdz0Dg8zyRaD29X/5LyqciK7HzRvD1JUHj2svZWBvt/qlJ/+EVCA8bFO8vQpgVOB5sTNfxoaO4vR2jl7/oIVCBdKzBllyaBC38TK7w365g6CxR+I17mWnMeim3sZZfTD9QUR1qqFJx3yQXeTR6y+a657O9pMGaKtels4hJJNGmn4ftMDzvtgUWvQOZMahUys729RWZTbaI3ML4bXi7R94fvfFS/S+bwBfb/QR95yrauloSevlWYC/XxG6Bh06eRqXvRvIuRHnls7TeGUJ3scs5FuzIxSQVvTXwLaSOLfNms68MQan0aU3otElDxtece8hJvR8STFt/WpVp9siD+SZFhflbT+YyZmh6wbltwc11PrQ/kbrKxOgfBuCEdstBftgNpMZPw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RG9DTitWcklRUTdXSHplSHJ4WGprcjd4djN2UjZrUjhMZzRuQ3FVdXBMT1J0?=
 =?utf-8?B?S1lwbnJOVHRmeTZxWkpmWU5yMStQZWhMK2hBdU9tMllsbmErNWMxN09DUHQ5?=
 =?utf-8?B?MmhBOXZZVG9hd0N1RlF6VW8rK29sVjBaZzdqeHlYL2VCQkZKdXBlbmUyWnk3?=
 =?utf-8?B?eVpWdDBWakN6NXViNndRbVoxYUpPT1huU2pCeUNtVWFiR0lpY0ZUVUtDR1Ni?=
 =?utf-8?B?cDNxZWk3c2owbThwU2FxWDJLNEZmVDgyTGhnT3QzWUora2VmbkJ3ZHFvbk5m?=
 =?utf-8?B?RE1IRkFoZVVCVUEvcEtRaTZWQlAxRTFURStublJKenFGbWZmRk1IeG4yMUp5?=
 =?utf-8?B?azdlUnJBRGE0RHhlRk9Xd3RuZit5MkF3SDFYMk0wT0dkS2x4UWVKOXduaDdh?=
 =?utf-8?B?S2xqeTMxSnFNb0FUMjZNT09JUkQ3eEQ4RlZOak05WVQ3Z2JTTTRrVzBnT2Nm?=
 =?utf-8?B?dXprVWp0Szg1bkNabmVwRTF5LzZBaHpQYnNhMDZUZDdhd2VXWDZwd0duZXhj?=
 =?utf-8?B?bWxtYUZabXZQVjNwempzWXQ0dmpXUzREdjlXMDFlbldEeFRYQTNJMnpoaHFi?=
 =?utf-8?B?UFc0TFZYNkxWWk5DOCtaaENaQ1lzWXczalFGd1d5SmJGR1gvL1dPUjl5Rnda?=
 =?utf-8?B?UHpBSVZDY21DUmR6cWNSSm9TRTBWdW85dXRsSVhaUjczaGZyR1Y2Smh2eXda?=
 =?utf-8?B?UmJoVlB3Njl1Q21FWnJrNmkyZThVVms2Rjd2bHdhb0RDZVRvNFRFZ0o0Nmhp?=
 =?utf-8?B?ZmN1enB6MlJWUjVWNzRBYmNGOHUrQnlQN3VsRFo0LzRzalRwMVdnVUwvN3JD?=
 =?utf-8?B?Y3VUcjd1UXpseGY2bmZMSTBjZjAyNUdJL0lJa0FobjFJTTJyQ0xVdE9WeE1y?=
 =?utf-8?B?TEgvVUUyZWlJZmNyOE56eDUwNlZOZzRPdmI5c3JQcnp2bzNTN1hjYThhM2NE?=
 =?utf-8?B?OTMyazlyOGIwVHBJbHkzeVJIbVVxZU9zYUs4RlVWSnQzcDMvUFRoQitKeGNH?=
 =?utf-8?B?dzBubkpLZFprbFd3b25wSW8vZVJKRnhLTlk5V0ZRNitZYXlRRlhseHFFdkty?=
 =?utf-8?B?N09NMTZHQVlpZ3NjdU1WT0NVRFFNdk15cEduUlJIQWVuSmN0V1BxbW9OYm5h?=
 =?utf-8?B?YTBmbmNMdnpwaGlmRWZHU3NYejlucHhIQzRsYTVrK2NMTzE1UGhuTldTRms2?=
 =?utf-8?B?VnNJcHVzdi9WUUN2WVZJR0FrbEdLeEZzMU1kbzlVWUtNRDd5QTlESTJJSnhk?=
 =?utf-8?B?NC9vcUFyVFE1YldCRmJZTDI5d0NwVGtFWWgvOGtaMWg4M2pUV1BsS3hPRzVm?=
 =?utf-8?B?Rk9laUVjQ0VpczlON1Z4MTY5YUtMcHg2cUZRb0grK1h3aHpnOFhEaGtGekVn?=
 =?utf-8?B?RWFoc0FrSnRRY29SeDBMSGptcTh5SlBGL1dSR2dTdkpQL1NOMWxtUkszZlJH?=
 =?utf-8?B?Q1FId0xPNStKK00vTFZueUdWajhhR001cnh6ei93cC9HdktNaGVaMEh5YmVU?=
 =?utf-8?B?aEZMR0ZnTlZMdzdWdXJwVGVYSE5YVmFMSEQ4MDJlcVFUbVdyV0lVY05wZE9j?=
 =?utf-8?B?cWFiZUZRcG9pU01LdmZPMWhWdXRHVktTMUhjNzF0Mjk1Kyt6U2tpUjg0RkNX?=
 =?utf-8?B?OEFid0krUnI1eHFwdUlLbkRPWksvcDAvS1UyQzl1UWh3ZXZaWGRQejkwUTVt?=
 =?utf-8?B?WFBxNG1CTy9BT2hOM0NCMnptS2o5MnFwa2ZuT1dJWWIycnQyL3VPbGZRPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e24078a9-c2ef-463d-442d-08daf413a398
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 20:37:21.8217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6280
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-12-14 15:15, Victoria Dye wrote:

> Matthew John Cheetham via GitGitGadget wrote:
>> From: Matthew John Cheetham <mjcheetham@outlook.com>
>>
>> Add the value of the WWW-Authenticate response header to credential
>> requests. Credential helpers that understand and support HTTP
>> authentication and authorization can use this standard header (RFC 2616
>> Section 14.47 [1]) to generate valid credentials.
>>
>> WWW-Authenticate headers can contain information pertaining to the
>> authority, authentication mechanism, or extra parameters/scopes that are
>> required.
>>
>> The current I/O format for credential helpers only allows for unique
>> names for properties/attributes, so in order to transmit multiple header
>> values (with a specific order) we introduce a new convention whereby a
>> C-style array syntax is used in the property name to denote multiple
>> ordered values for the same property.
>>
>> In this case we send multiple `wwwauth[]` properties where the order
>> that the repeated attributes appear in the conversation reflects the
>> order that the WWW-Authenticate headers appeared in the HTTP response.
>>
>> [1] https://datatracker.ietf.org/doc/html/rfc2616#section-14.47
> 
> ...
> 
>> +Attributes with keys that end with C-style array brackets `[]` can have
>> +multiple values. Each instance of a multi-valued attribute forms an
>> +ordered list of values - the order of the repeated attributes defines
>> +the order of the values. An empty multi-valued attribute (`key[]=\n`)
>> +acts to clear any previous entries and reset the list.
>> +
> 
> The commit message & documentation changes (here and the 'www-auth[]'
> definition below) are concise, easy-to-understand explanations of what
> you're doing here with the 'www-authenticate' header values.
> 
>>  
>> @@ -160,6 +166,16 @@ empty string.
>>  Components which are missing from the URL (e.g., there is no
>>  username in the example above) will be left unset.
>>  
>> +`wwwauth[]`::
>> +
>> +	When an HTTP response is received by Git that includes one or more
>> +	'WWW-Authenticate' authentication headers, these will be passed by Git
>> +	to credential helpers.
>> +	Each 'WWW-Authenticate' header value is passed as a multi-valued
>> +	attribute 'wwwauth[]', where the order of the attributes is the same as
>> +	they appear in the HTTP response. This attribute is 'one-way' from Git
>> +	to pass additional information to credential helpers.
> 
> nit: if you're trying to get a paragraph break between "...to credential
> helpers." and "Each 'WWW-Authenticate' header value", you need to add an
> explicit break:
> 
> -------- 8< --------
> 
> diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
> index bf0de0e940..50759153ef 100644
> --- a/Documentation/git-credential.txt
> +++ b/Documentation/git-credential.txt
> @@ -171,10 +171,11 @@ username in the example above) will be left unset.
>  	When an HTTP response is received by Git that includes one or more
>  	'WWW-Authenticate' authentication headers, these will be passed by Git
>  	to credential helpers.
> -	Each 'WWW-Authenticate' header value is passed as a multi-valued
> -	attribute 'wwwauth[]', where the order of the attributes is the same as
> -	they appear in the HTTP response. This attribute is 'one-way' from Git
> -	to pass additional information to credential helpers.
> ++
> +Each 'WWW-Authenticate' header value is passed as a multi-valued
> +attribute 'wwwauth[]', where the order of the attributes is the same as
> +they appear in the HTTP response. This attribute is 'one-way' from Git
> +to pass additional information to credential helpers.
>  
>  Unrecognised attributes are silently discarded.
>  
> -------- >8 --------
> 
> You can test to see how the docs look by running 'make doc' from the
> repository root and looking at the generated 'git-credential.html' (note
> that, if you've installed Git dependencies with Homebrew, you might need to
> specify 'XML_CATALOG_FILES=$(brew --prefix)/etc/xml/catalog' to get it to
> work).

Thanks! Yes, I was intending there to be a line break. Thanks for the tip;
will be addressed in the next iteration.

>> +
>>  Unrecognised attributes are silently discarded.
>>  
>>  GIT
>> diff --git a/credential.c b/credential.c
>> index 897b4679333..8a3ad6c0ae2 100644
>> --- a/credential.c
>> +++ b/credential.c
>> @@ -263,6 +263,17 @@ static void credential_write_item(FILE *fp, const char *key, const char *value,
>>  	fprintf(fp, "%s=%s\n", key, value);
>>  }
>>  
>> +static void credential_write_strvec(FILE *fp, const char *key,
>> +				    const struct strvec *vec)
>> +{
>> +	int i = 0;
>> +	const char *full_key = xstrfmt("%s[]", key);
>> +	for (; i < vec->nr; i++) {
>> +		credential_write_item(fp, full_key, vec->v[i], 0);
>> +	}
>> +	free((void*)full_key);
>> +}
>> +
>>  void credential_write(const struct credential *c, FILE *fp)
>>  {
>>  	credential_write_item(fp, "protocol", c->protocol, 1);
>> @@ -270,6 +281,7 @@ void credential_write(const struct credential *c, FILE *fp)
>>  	credential_write_item(fp, "path", c->path, 0);
>>  	credential_write_item(fp, "username", c->username, 0);
>>  	credential_write_item(fp, "password", c->password, 0);
>> +	credential_write_strvec(fp, "wwwauth", &c->wwwauth_headers);
> 
> This implementation looks good to me.
> 
>>  }
>>  
>>  static int run_credential_helper(struct credential *c,
> 

Thanks,
Matthew
