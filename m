Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CD8C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 10:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244094AbhLVKNb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 05:13:31 -0500
Received: from mail-db8eur05on2042.outbound.protection.outlook.com ([40.107.20.42]:12641
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234441AbhLVKNa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 05:13:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRcHeftbE9SPEIf43/7s1tiNsuMXc8U5BamlC0C5eaa9aChhCAMMULVKJS0CU8SOadehKCHtHFaGVw8NvvwalkWg5SuFnba0gJsHOIzXyObxOla0fR9Qi8zqM9JsTDvRW3g+YibqtkAtDThGdQvRU7lChs6FCbEp4UO64f1pPnIMGwmDxfIJmpdLpX9HZh5iZ+XQwq7z6mSEyysRJSXeeOUqb56X81+h8EFOAZXNQxDduiw7epzMUGjqXk09E9ooULlHkgZXkT++jm7QxOMSX7WX3/5PFQ60MY6yaX6ixulY2Hz2FkFHUpaC3QZG1ijO8kWMUbjFJETYpCUNfemobw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJvXFjdnXD6TBJTB5GGD3em6QDPIpIEI6fmfRP/jL/c=;
 b=XfiLFRYP/5+msV0xdIZdxaLHUn+Ne/O3vU3Z3LmssUB2uvb2F7TiY0SemXBBPJzLI4Jd90EdsCGgmJ4xNd/2mwSwzLZoP/xBay58q8z4pOrMpAsBWY/JJwo4/bR73dIYXJiblULcPp79cstU5V571aKUeGJQBOgNc7ZCNaahkwkUTIjtCtCsSpEnkf4aNqdkKRFCuj4Z54YmxTzQ42LrkCFP26hXyUHsxEPuX3+jyOZVHtCBUG7HD0p7fqIN7Pr+cazdD3ibus4pMqb1rbjiXWOP77ELHG9d+p8RGOhDwfCYfULSXu/6nbScwnRhInKSV4Lkb6e2oXYVLi6Chyttxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJvXFjdnXD6TBJTB5GGD3em6QDPIpIEI6fmfRP/jL/c=;
 b=Da2l1BbBGJYv6rUgCeJNIHjZvNYeWWeAkBoWvByJmwLwPNMMwQd2/0JaSKGcBSmBO3FWGpW/Fp/TvV730DWAwxL+93NfCQTihOR9/ghiIWIcPe62f5VLhvRayzMsCimQBvg4qYFWyzp83eNvgSJ67WUGRd5svRCgVzR6TV/EwYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3817.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:42::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Wed, 22 Dec
 2021 10:13:27 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%6]) with mapi id 15.20.4823.018; Wed, 22 Dec 2021
 10:13:27 +0000
Date:   Wed, 22 Dec 2021 11:13:26 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: t7510-signed-commit.sh hangs on old gpg, regression in
 1bfb57f642d (was: [PATCH v8 9/9] ssh signing: test that gpg fails for
 unknown keys)
Message-ID: <20211222101326.fwl3wphr3ev6c7wt@fs>
References: <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
 <pull.1041.v8.git.git.1631304462.gitgitgadget@gmail.com>
 <07afb94ed8336d4ca9de7078d7a6c02b1db8a908.1631304462.git.gitgitgadget@gmail.com>
 <211222.86ilvhpbl0.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211222.86ilvhpbl0.gmgdl@evledraar.gmail.com>
X-ClientProxiedBy: FR3P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::8) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1e55e93-556e-48a6-4187-08d9c533b206
X-MS-TrafficTypeDiagnostic: PR3PR10MB3817:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB38176BB5D2D99313D59FC488B67D9@PR3PR10MB3817.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vFNbQ116rAuluNmLACVFXpyp5OtTj0sGXpaNne9vZ51gB2gOGmHbHx06OSjYEhMw+c2zQvgbptVymLG7ZJPpvfSYaMLwEip2diXcljlKtd+EvHGdG5cNgGQzMs2K//hsfXkfAQYH9Q+Nlhfds2WpfmnoHHzVcs9pqLyRpfScehDxnGnnNtXc6warJDRcS3vLkUiVLP7/ccdDc6005k58vy1PSC6C1YWnLSYNK9eHhStmf8rPBrMyGogp3wn+XkXsm/xmc0Nv683+MvS4L+vZAUa4rvL/stShBhR5k2BReuX+vlOrIiPAIkr0OxRvkycun7pKXk7CKVvDNjnQyY5gsSeLe+84Sja/c0pXZr4wsenLcHzKJuLjuIV0ybRuuSl0RYWbHRxzwl+ESXPAbZcMI/8XrcX4DYoiSmeTZzSHry5S33UsCeW9Z1dDEXwNcQAr7Vp3YaC1SY3+yvuHhNf85irf0DmJ+8RjnfaiH44/GHYIHRhGSz2kxP5rs2qXi1C2qZ2CfquIcsv5Q2bEx2YTBWJXmXA9jDGgIv1Q3IwHi8m/ilp30yGJ7YTa0d4K12Z6HvGva4Oq3i2QWXM08XtXKqSs/W5cGry81YILQz3cOryG8F5bg1v7V5v+LHzJvIoopMXaGlwmf9pnOYK7HBi3sWNOn8UXYjO5TdxzZhIFf0uVHs5aJJaTswQwimHx2ao53CsjMq6JtXMhGPitmKq5pDh43g2qDll5MW08vw1pHojkVQ8HYCKNGa6zl0sw7nDCnkRvTlUQJcv8EJeunC+tmPrTefHsMG4zbQXENfJGvbc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(4636009)(396003)(39840400004)(136003)(366004)(376002)(346002)(6512007)(66946007)(8936002)(6916009)(38100700002)(33716001)(66556008)(316002)(6486002)(54906003)(2906002)(66476007)(8676002)(9686003)(86362001)(66574015)(186003)(53546011)(4326008)(83380400001)(7416002)(508600001)(1076003)(5660300002)(6506007)(2004002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEdKeTQ0WnNXT2RmTTk4T3ZuOGhRbFBGQy91WHhwTFlHb09SeXJVTG5sRytC?=
 =?utf-8?B?YXZzdmVmTDBtNTgyOWlsNjh1bkloQS82UTFndFRjcHNHN2tWdHkzcHYxQkdO?=
 =?utf-8?B?Qzl5QTkya2U0elB6d1VpUjN5U0JrbWNLVUR3ZXdqcWJKZEdYTjhqRlErU0V5?=
 =?utf-8?B?eklpOEEzQlNWLzZBeEVicjRVN0NPVkFJVGxaQmlEQURCUE5MWTNTTjk2YWJr?=
 =?utf-8?B?M2dvNEdtWlNDTUg5V1Mrb09ZN3h5UTYzdTJzKzVmS3cwWVB5Z0MwUW9Nc0I1?=
 =?utf-8?B?WjFuNWdFQnllbFN6WmQzLzl0Njlmb3VnWEM1V0o3V2VzREEyS3hKeVRaOXZn?=
 =?utf-8?B?cmtzdnZuK2orZTd4M1FXMmYwdzZGQmtTbWJIQ2JqWVFFc0g1UXN4VytqTEts?=
 =?utf-8?B?WHRJTEMvTHMwTWswZ0FVL1UxdUwzUWJGbFl0VzdGdHdhVzVkMkZMc3UwYlpu?=
 =?utf-8?B?WERZOEVBbDQwQnp0ZkVwZ2htTkg0eTZWZjJ5VFNSN2U4Ym9SU255WTRwOFYv?=
 =?utf-8?B?dkhsTnordHZNWWp4TWh3ZkJBc3pNOUtFcTNrNndaejBoWFAweG5VaVBMNXls?=
 =?utf-8?B?MnBhclVadHNWL3ZUU1NLVVhOSzh0Y3hRb3QvT3RPSDZ0L1RNS29zNE04TWw2?=
 =?utf-8?B?MnVicFpKVTZpRU1CUjdNQTBNVGkrdEk1UzZMZGFXU0QzUmVjeTREK1ZhUnVq?=
 =?utf-8?B?RndLRDk1T3pxaXBsM2RTZk5QOEh2OCs2ek1WZTBnMUFRV0ZrTXVRU0tQMUlO?=
 =?utf-8?B?KzRnSks0cStIMUpKbmlTOXpSU1pIMEFWcHV6bExpZHViU2UvcE94MGpJcVBr?=
 =?utf-8?B?Mk1sMXRMc2NoVVd2RFR6SFB4dWRBakNrVzZxUXl6UEIyck96Ymd4WnhuM0xj?=
 =?utf-8?B?VExBQlhicllsZ29Yc2E4anF2ODdodHQ4TGdoYU5paytkUDZSUzVuOW9QNmho?=
 =?utf-8?B?c1BPdUs4RjEvZ3FlN24vSittYUZwWjFZTlBkUU5hS1VhRHpJeWVhdVU2MnF3?=
 =?utf-8?B?Q3pHRnZtOWZzNDgxbVBsS2llTC9UNHhJS3pKQStCT2pWYXhVdFdydlRPaG9R?=
 =?utf-8?B?SnArU3l5aHl2TXQ4VFB3cGcrUUluTDBla1hhMHNDSUxGN2dFK0ZZQ0RidU82?=
 =?utf-8?B?TVh0eEQ3cjRUSFJaUW9kcjFEbWtzMnJuWmN4akYxZGl1N0had0FReE5LT0M1?=
 =?utf-8?B?LzVMVm5QcGxocFVrdHBROXRsUWVEVE9kQjYyOTRKTzhTdi9lT0tHRGxTU3JY?=
 =?utf-8?B?d3JFdTR5azhXN3FCc1RoUFI0QVlKQkdYMGtGckpSTjFtSTVJcmpiUTg0L3dt?=
 =?utf-8?B?THVWek9SdTVObUJWemVORnVsU0hHbVZXd1dMUERDcGdaZyttcXJGdHBCNmk1?=
 =?utf-8?B?V09QV2c2bUxWSlg5SW1WRHV3NzE2QXAzbCtpaGJGZXBHcTBodWdjOXIzWElx?=
 =?utf-8?B?U0ZYL3lPbWRPZkZ4c3dpUkNNNEVmSWVhTFowc0VtRXdjNDNRTmZhK3huL0w0?=
 =?utf-8?B?RDFKRjUzWHVVdGJnY2NMZ0ljcFNWSmtPNDh1RjQ0ZUpacmFMVTlGcTBZdzhQ?=
 =?utf-8?B?Vy91REQxb2hCNTRVZEJqLytjdHIwWE1lOCtZdi9NOWVSUlYrR3BQSC95VkJs?=
 =?utf-8?B?Y0dnTndsVUVRVCtDOEhMR3BYM01mUFlncU5PWW9HMVZsanJYNS9jaWVDSEd3?=
 =?utf-8?B?QTRaVzlza2IzUElGb0VYSkw2UEF5R29FYU9LNUZkcDRxTDMzQ091dG1hdmpi?=
 =?utf-8?B?dlJ6UEpwS0ViY3djczJCQTByRkZGR0JIR05Sa1JHZ3RuWmM1UjFxU1ZxZnNL?=
 =?utf-8?B?UGpieHlOb2RIN0pFVitKV3BmK2ZRRnhzV2ViZXdoakFtT002U3lORXhtblhR?=
 =?utf-8?B?SUJrbjNucVFpdSs1Qk1MZmJNMVpRZWJtRVFZRjhXbWtIVSt6SzB0QXJiMzgx?=
 =?utf-8?B?ekJCSkdWeTNWRzJzc0sxV21nZldQN0M3RExJR0N5K0k2UXh4bkhnZDZyd0p1?=
 =?utf-8?B?ckpqUWpyS0taMDkzMExMOGxpVlhkQkZnZ2FoY1FjN3lBUlUwMFlQYnNaN2cr?=
 =?utf-8?B?djg2eGRTM3daOGRwYWVjQy9DRVhMaGx2QW1oaEFpU2p4V0NpSHFtUlR0WTNk?=
 =?utf-8?B?UHRVeis5NkVtSE5BaXdWbWhBMVorcm9GZXpyU09TVDJsRzRmVFJZRGlYa0dH?=
 =?utf-8?B?M0JUTUdyQXFoQWUvcVB6aUliQktVZUwrV0o1NjZBc3VUUVk5MzBoM0dma0dL?=
 =?utf-8?B?NUVKUWpLc1RWVVdvZm4xZkNrQmpLZGNSVnYwYkI1M2Fwd21PSGZ3a2lGTndM?=
 =?utf-8?B?NDhWQlNjT0cyR3FnVzZtZU1SOWJ2YVVTS2NUS2p1blVoNWhBRXBtZz09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e55e93-556e-48a6-4187-08d9c533b206
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 10:13:27.2268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dC+IzJHfYFnRH06h6VLraktzsDHY91PVkSincKE2g/lObAYcc7DRoiDS57kkcIL7zlteDzvR0ESb+pIDyb3tmW1Y+d55qiV7/Xx2iHoxHTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3817
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22.12.2021 04:18, Ævar Arnfjörð Bjarmason wrote:
>
>On Fri, Sep 10 2021, Fabian Stelzer via GitGitGadget wrote:
>
>> From: Fabian Stelzer <fs@gigacodes.de>
>>
>> Test that verify-commit/tag will fail when a gpg key is completely
>> unknown. To do this we have to generate a key, use it for a signature
>> and delete it from our keyring aferwards completely.
>>
>> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
>> +
>> +	cat >keydetails <<-\EOF &&
>> +	Key-Type: RSA
>> +	Key-Length: 2048
>> +	Subkey-Type: RSA
>> +	Subkey-Length: 2048
>> +	Name-Real: Unknown User
>> +	Name-Email: unknown@git.com
>> +	Expire-Date: 0
>> +	%no-ask-passphrase
>> +	%no-protection
>> +	EOF
>> +	gpg --batch --gen-key keydetails &&
>>
>The t7510-signed-commit.sh script hangs on startup with this change, and
>with -vx we show:
>
>    [...]
>    ++ git tag twelfth-signed-alt 17f06d503ee50df92746c17f6cced6feb5940cf5
>    ++ cat
>    ++ gpg --batch --gen-key keydetails
>    gpg: skipping control `%no-protection' ()
>
>This is on a CentOS 7.9 box on the GCC Farm:
>
>    [avar@gcc135 t]$ uname -a ; gpg --version
>    Linux gcc135.osuosl.org 4.18.0-80.7.2.el7.ppc64le #1 SMP Thu Sep 12 15:45:05 UTC 2019 ppc64le ppc64le ppc64le GNU/Linux
>    gpg (GnuPG) 2.0.22
>    libgcrypt 1.5.3
>    Copyright (C) 2013 Free Software Foundation, Inc.
>    License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
>    This is free software: you are free to change and redistribute it.
>    There is NO WARRANTY, to the extent permitted by law.
>
>    Home: ~/.gnupg
>    Supported algorithms:
>    Pubkey: RSA, ?, ?, ELG, DSA
>    Cipher: IDEA, 3DES, CAST5, BLOWFISH, AES, AES192, AES256, TWOFISH,
>            CAMELLIA128, CAMELLIA192, CAMELLIA256
>    Hash: MD5, SHA1, RIPEMD160, SHA256, SHA384, SHA512, SHA224
>    Compression: Uncompressed, ZIP, ZLIB, BZIP2

Hm. I have an identical centos 7.9 installation (same versions/features) and 
the key is generated without issues. Does the VM maybe have not enough 
entropy for generating a gpg key?
Otherwise we could of course pre-generate the key and commit it. I'm usually 
not a fan of this since over time it can become unclear how it was generated 
or if the committed version still matches what would be generated today.
But of course I don't want to slow down CI with rsa key generation stuff :/
If missing entropy is the problem, then maybe CI could benefit from 
something like haveged in general (other tests might want more entropy too).

