Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD653C38142
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 23:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjAQXfI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 18:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjAQXee (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 18:34:34 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2070.outbound.protection.outlook.com [40.92.48.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3462317CE6
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 13:21:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXu8ADHR4m0CAm16r1jRxxvGFFGTxSGC+Oe2o4nJ61yYBz+BYDb5ieSZNzjyA4/5PJUtqLNF3rkcthZjEglVIEpQPP+Cnxy8HAZNkv1JDmAdJBzT+2rZlJAIKSh3sdy+6xvDShboqXJwmlioOHAJksnFChlZbRNl+g5kTqGik2HIguMfJ8uy7t17k2NnknFaWmcgWE0vqR0AzYUJkTnAKRLdh9FvpWfgpbISwEnnI+R3Ub8tSp1DawTcJjsYjrK0VxwiN3nafd1G+IFFNjXr5+Go2hPctt9yMGdct+zj7DLT7X90UylnUgHtjXP+8EUotvBZfClrxa7WlAxtEij7UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZlTZ8VOH9Nxv8h5tBwNottXWszMxwWadU80rq6lMI4=;
 b=ZFQyjgRW1tEZG6L/S7ag0cdszrMFbMeIrE27UKRRofYaI9Hg/wU1KGUVDHZyHj/4BdP29C7LquooibbZvegZ8G8nnNAHAaFggFK4IuznxumDWlt1y0wbkSJ2B4cPe9Fagu/GUy0RymXQ7TL3YOvyv7QfsPikQBR2S6HM1upXI8aPFlhsRY6CRr0bLj8jTW3EcKkc7xRDGsO66ZIvTKPezKbPXLc/u9gyVRbZ4GGL0swZzNk7/BOT/O3I6RN3hXvyRrZmvzGh1d/HCtqB6BG66t77S9YukmEk8duQd7xLrFyHJZ7/BWaWST4D66OOKg9XAo933x+eYI5vSH34E8yKMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZlTZ8VOH9Nxv8h5tBwNottXWszMxwWadU80rq6lMI4=;
 b=megNs6h4uCehH9R88URfthwLOV3rA3woEWz/QlSBGUPvRVEBGT4cyAazSw+aJPMT41fwBB2uQYvr9F8mWaOmWAldF7DLX+SGph5BqJEWEGM/VMGYzwFrNEFdMEHNj4hsWK5vHoYCDlSe4Ap1PpKOxaSJ3MuXQqp+bT7ipfrQozDqJnhIhP8VIzVGPeXLjtlKtZUsCsIm6TaZYuCaxAwH+e8ee1Za9UtBd2o0+wmVSnJzNQnsRF2CKS7OiUFFIw7Amwro5YUaZ5nIRctZMc11h9vN0bwH2Db5bI4SiK/7XAN6UnyLqaGEXt1aUhdDpCTv6beiEV406wnq1sZCVMSEAQ==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by GV1PR03MB8709.eurprd03.prod.outlook.com (2603:10a6:150:93::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 21:21:36 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519%8]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 21:21:35 +0000
Message-ID: <AS2PR03MB981566FB36C357D009B64D4FC0C69@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Tue, 17 Jan 2023 13:21:29 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v5 06/10] test-http-server: add simple authentication
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
 <c3c3d17a688963acc180e3bb7bbb4deb32a94304.1673475190.git.gitgitgadget@gmail.com>
 <2a0b5f3f-7ab2-bc9e-76ac-93a52b4d32d0@github.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <2a0b5f3f-7ab2-bc9e-76ac-93a52b4d32d0@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [N8khxv4Lh/p0nRGI7i8YgQwDViP+BrRE]
X-ClientProxiedBy: BYAPR02CA0057.namprd02.prod.outlook.com
 (2603:10b6:a03:54::34) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <a2d4b5b9-2b28-8cf9-2613-3d6d15881e96@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|GV1PR03MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: 1812cf65-ec08-4998-a86e-08daf8d0cff5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vV1w+SVkpAtf4um5uTE1JFOO/C9HmAOCW8gMCdB/kMurRC31PQ+sm440IckYwb2Mc2WPkZcJIUns27nOMbKxKtTa8qK500XUZxiXeVlgixmAhNQQ85sYHv21dJ7pIK34QG1zGWupAtO+U6tu/VdvEcEQ54BtzWBNAD5xPS5/93raCAf2xY/TDHyktyVXB5zikiu/PqcOjIbDxUJ6xP+Z36r/phdE/4etl5g+R2u1drcRLMpMTOVQTWT38vdRQuW3CYBEaGnQw9bop6iTswpS46lWbQaIYYL951PQZbrSdU71dGh/n3ix8/1AskF7W3zf1LgWIEItjp1WOggppLIxf8u8gdl1JdtU1MAlfKoC4+sTFqgnOC3nNNycCIu/WzYGC+6EEPFOsgHyaaEneRD7l4J2wrS+LvF67Ut34WCkuQXwm7eG2aauuLP69MM7CMyOGCwQlxWeFtXVuwdIfAIhy3KvC1CKluQ2T4lzSUL4u4as+lUaQOQB6dwqQzeH9FuFwH9O9XI4SA/J6WIvQuNly6qE2JMMvZ0k0d8+bwdh3OO/Tp6CtcuI9ESEne64Fa/OQgRLvfm22rVAl+AVYyN5X5uYPyKlKeHz7ENIMWaikrf1kopJZWKAxxHCDcwlwjoc2USz1pWIivc3TTK5oCe9ag==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFduaXNSZ0pWV25lUENOSEh6QlZBSGhuRjJCdEkzdXgwanZzRDZtZEt0OEds?=
 =?utf-8?B?a0NEUHlUNStvN0xZaGZuVG1RdlZNSHZnbXNNRHZXQ24xMC9mUnFtbnhCaGRl?=
 =?utf-8?B?cHhnTTZnOXp3cUhpRlBHcnQvdXd1c0o2THlMZkZmc3piUUVWNW0zQ2JXa2FQ?=
 =?utf-8?B?THl0OTNwU0pIaWtEc1VIN2l0alQ5d3JtNGNlRDRhV1N2cC8yNktZV0xkT1FP?=
 =?utf-8?B?WXBWRFJhbWxxc1h0dEUwdXJWYnVadmNEWFpDajloVTV2TGZwUkNhdGw5Qk5C?=
 =?utf-8?B?RFNwSHBzVEo3bnZJL3UzZWtwMTAvY3p5OTA0R215UVBtWmVSRHllWjV0dC9B?=
 =?utf-8?B?SFZNRkZMajVzNlBsOHU4VlFtdGF1S1AzV2F3bSt6cnJqWm9VZm45b1FIWHd5?=
 =?utf-8?B?cU1pYWhhb2tlZWdVa2RpeDZPOEtDa2NZazVCUTdWNS9FRk1LemRweDZzbktH?=
 =?utf-8?B?YWtNT0p6Y1U2bzZyeGNZa1VBWHpJZlJTRGdad3Q5R2RiSHMrMG9IZm10b0lC?=
 =?utf-8?B?empqTm55VHorQzN2R3pTMEZQZnFNZks4a085S3NBc3VtSi9qZ2xHL2tZUkt3?=
 =?utf-8?B?T25GemdLTDRaVzhnazJiUGtveEM0SFpNY2F2SkNNbnZ5b0E3KzkwUml3Vlly?=
 =?utf-8?B?eHE2aVllcUtpVTZoVmZ6dnlvQ0k2ZjFPanJqS0c3S3NWOGxNcHhHWk5jUjA5?=
 =?utf-8?B?eTRPT2x6WlE2RjR1bURLNVVhdXRkNzRRbWxkNVgzNnArNTIwT1JhczFWakkx?=
 =?utf-8?B?UHZYbzhHVC9aRGFySVpXT2g3V0JheWNpaUVrb0tvSEFRRldFdWRzdlBNbU5D?=
 =?utf-8?B?S1F1ejlnTnU3VE1hWGJkYWZDWktoZStqRjBOcS9Td3ppWWhDR2poOGV0VGJu?=
 =?utf-8?B?Y0JwTUgzSTN0ZW42RUZBQ0RjTUgySjRQTzFlTCtHam5Wb2Y4dnRYbmc1VHB2?=
 =?utf-8?B?YXRoYm9ZUnlFVXYrL1kwSDJKemRRUk1yOWI5Z1VOaTM2cXRuSzlOaDRCd2x5?=
 =?utf-8?B?QlhrTjE2endvOVpmQWl4WUNrUVNicG9GUUFPbXVqUlBESkpMYnNtQ2JQckpo?=
 =?utf-8?B?ZHVWZ0Y3ODdQeC9DeGR6VTFoUnFFNFJMbEVlcExBYm5wZ3dGbUZRQmsrRXRl?=
 =?utf-8?B?WTRxS2pnSHlKaVdGbWwyZHFaVDEvQVBrOEhZNTk3ZkEvK2JEMW4yWjBSSW1m?=
 =?utf-8?B?LzQ1WnpVL0t6R1BPeTVJMVFhVEQ5MTVzTTNQcVhSYk9UcXNYZzlPamw5Y0xH?=
 =?utf-8?B?T2hwbSttNXNTNFZHbXR1SmEvLzdsVkhlNkJPTjhSaGN6dUhPRGhoNW5YQ00r?=
 =?utf-8?B?WUNoR0FWNU40b2UwZUM0MTg4SXpKWlM0QnZkSGswcHgxWU9Bb0hlNFJ3Mnds?=
 =?utf-8?B?SUs4ajBsOWtxTHBBNEFxRVdHM29Ua2J2VGlQQitDeVg4Q1FPYlBhcWxEWGF2?=
 =?utf-8?B?UHNZK083cGRaSWtkY1Uwd1BZOHZlV2xxU2FoNUNnVzZENmFReE1WQ1EzeExJ?=
 =?utf-8?B?ZVR6WDhrUm9CbDVJZFQwTFNrTy9JdUJQRlR5YTZXQjhEWUhXQ1pyejJLRXBi?=
 =?utf-8?B?ZHh4WXhjaFRuODhGaXdMMHh0WVV3aTRyK05HK2U4Q29jWWwzTkI5Y2Rpd0U3?=
 =?utf-8?B?SUt6cDhLL0FmSGtqYzZXKy9IcVRzZFBlV1JONnlaOENsdkpoV295NFZIVkVy?=
 =?utf-8?B?NEtBaFowRytyOERMVDlSdGwzN3JTb0ROMW01UXh6MUJPUm93S3RyNytBPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1812cf65-ec08-4998-a86e-08daf8d0cff5
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 21:21:35.6747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB8709
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-01-13 10:10, Victoria Dye wrote:

> Matthew John Cheetham via GitGitGadget wrote:
>> +static int read_auth_config(const char *name, const char *val, void *data)
>> +{
>> +	int ret = 0;
>> +	char *scheme = NULL;
>> +	char *token = NULL;
>> +	char *challenge = NULL;
>> +	struct auth_module *mod = NULL;
>> +
>> +	if (!strcmp(name, "auth.challenge")) {
>> +		if (split_auth_param(val, &scheme, &challenge, 0)) {
>> +			ret = error("invalid auth challenge '%s'", val);
>> +			goto cleanup;
>> +		}
>> +
>> +		mod = create_auth_module(scheme, challenge);
>> +		if (add_auth_module(mod)) {
>> +			ret = error("failed to add auth module '%s'", val);
>> +			goto cleanup;
>> +		}
>> +	}
>> +	if (!strcmp(name, "auth.token")) {
>> +		if (split_auth_param(val, &scheme, &token, 1)) {
>> +			ret = error("invalid auth token '%s'", val);
>> +			goto cleanup;
>> +		}
>> +
>> +		mod = get_auth_module(scheme);
>> +		if (!mod) {
>> +			ret = error("auth scheme not defined '%s'\n", scheme);
>> +			goto cleanup;
>> +		}
>> +
>> +		string_list_append(mod->tokens, token);
>> +	}
> 
> I don't think this addresses the implicit option ordering requirement noted
> in [3]; instead of needing '--auth' before '--auth-token', this now needs
> 'auth.challenge' before 'auth.token' in the config file. While I'd prefer it
> if this could be rearranged so that the auth setup happens after all config
> parsing (so the order doesn't matter), if you want to leave it as-is please
> add a comment somewhere in this file explaining that requirement and/or add
> a note to the "auth scheme not defined" error message.  
> 
> [3] https://lore.kernel.org/git/2a5d6586-3d2c-8af4-12be-a5a106f966b5@github.com/
> 
>> +	if (!strcmp(name, "auth.allowanonymous")) {
>> +		allow_anonymous = git_config_bool(name, val);
>> +	}
>> +	if (!strcmp(name, "auth.extraheader")) {
>> +		strvec_push(&extra_headers, val);
>> +	}
> 
> Is it worth printing a warning if the option found isn't any of the above?
> Something like "ignoring <config option>". This is a test helper, so
> user-friendliness isn't quite as important as it is for builtins, but the
> warning might be helpful to developers trying to use it in the future.

I tried this suggestion of adding a warning, but it felt wrong. You are correct
in the first instance that it should really "just work" when specified in any
order. Watch for the next iteration where I'll make it such you can specify them
in any order :-)

Thanks,
Matthew
