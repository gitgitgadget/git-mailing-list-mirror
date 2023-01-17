Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99972C38142
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 23:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjAQXfO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 18:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjAQXe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 18:34:27 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2065.outbound.protection.outlook.com [40.92.89.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A413E3801F
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 13:19:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBdPM8BEEdmVX3Z7+giMGsf18Jkw0zlXTH1g1JcsHGOoDPa+fMx6SjuEe/gwsI7/dDQyDmaZzvVMFnhGn7Rt09fUwy3rjpa7FYn06IZVY7Mt4nvJlebKjE6qkDkibRfJ/luIlKuvctvtj4FtqyeEe0E2aiobSELKwf3Xs7zbXf1dhmD9iVKOaSLePXA9J6Iv3nwLAW5w12Ixt8/173FkzUijsvdeehSeOP1xbDnysYxB0i1ZkV+8LGjxxFPHkI5HA+nu1Zv6bPpwzos8/iNZceCWQi7quyjmLaY17srMtC6G6g2G5MDAsAHKFheh4fpv1FsOcML+Zsrcg+bn0EZBHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWBOMe3efTDSrSK9kJNQNShDZyvgW41m/RkAH7F0G7o=;
 b=H1cz+ifid1ZEHY4BBW5l4/4x24fR/bEEpJAV0gXev7NT4t0PovrQ7ksnGIkMhSlDQz+dhrtE36ApVYV+Tyvk459b8DQUWPtjjcvyeuSk1aQnp+tXkd+cvko4tceAoSfdLnDWDO/R4yavnh6ubokU2QsVZoY81juOC3DOOoiQoK/jIwUKGrWfttUdN/fNINlhLxDRZ/iFaFVAR/N6LQyj3y94tinLib/kFcLrbLf1Mbk4/yJYOJzQUCJRmaCnRtGmwVkep1jli9Zxj5dezR2aYurlZjIzFBuYoPZ6Fch2s+ri+TCJSoiTHIawRe/65KV/cv/whD9BcwWFonk+w1w/Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWBOMe3efTDSrSK9kJNQNShDZyvgW41m/RkAH7F0G7o=;
 b=mipp2YoQBQRvya21JDjp7zst7hZiyYqnDyisiKJjH5ScLa2UB0XhcJbJsnqE9ovrMKHwx7IBE2tjmwGyl+L7Moligf7ssScMmOwUdQj6iyK25tseLBMW21qmn4YcyqShaLLjZtjPcFOcDHGYJGc7akaRJ5P/2Mjd5yoWxKUPwcjveINT8mUg2WRfvFWzCK2MLAW59vR2PhG28XCCAI8pXxUWAt7vbNP0Unw2aFUCciKBlVyOK1axMHQvKvWqesh98q/73CfCmBkgmi6MV/q3hV+VAAyFE9ZhkQWXMkZ4ws2c2IXVUvtirIHq6Z2fmqraSM/P42hWaHVfhAvVqDzdIQ==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by AS2PR03MB9696.eurprd03.prod.outlook.com (2603:10a6:20b:60c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 21:19:01 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519%8]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 21:19:01 +0000
Message-ID: <AS2PR03MB9815C6A25546FD8CAD4D0CD6C0C69@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Tue, 17 Jan 2023 13:18:55 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v5 10/10] credential: add WWW-Authenticate header to cred
 requests
To:     Derrick Stolee <derrickstolee@github.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
 <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
 <af66d2d2ede2a502f32d74c86f302598c68d1476.1673475190.git.gitgitgadget@gmail.com>
 <98940e93-c4c5-01ec-54b2-b6015f488ad0@github.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <98940e93-c4c5-01ec-54b2-b6015f488ad0@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [ANVUXqm+kwRwmFwhFlm7I14rEanNsTpJ]
X-ClientProxiedBy: BYAPR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::22) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <85123da9-0799-6520-6b69-39668545c91c@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|AS2PR03MB9696:EE_
X-MS-Office365-Filtering-Correlation-Id: 58f88958-9347-433c-8b1d-08daf8d07435
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0KjJYLaK+6oHd5/j8LoLys4cGtzH2KMS2KbJOlfGB+UMx2kdTv8Cud+r5lLvI220PIeH3ZCekOER7oB6jsM7DA2UsqkPYdmpjqiyll3clKlNPo5ktBRHeggg47bW6Czk0H9LX1+k28aSmIaLav72OE85O+wf0vdgKPjIUnryyA0zAFR8WSUeQZUQTky8c/h0pacyA4STlvHKAkcu9fjqNaJVRz9zmBec6mzxL0jNggO633cChzqR6bIsjXrON52/3w0Ui/Elji+Dx0jDoer5r7T/6yKFZ3CNC628fbVIf3bhHNPZkdhW8979rYtGkk0DSm3tSs0EDSvI0dd26HQBlBTLVjMiqwNrZaVCVtWUrJ0sc2WjkvIEDAzZZ0Muh/edDCchG1QtK+vyXZA3UepiPgtwqp8pVr6XRfhfWmf/vztnf1PlR7RUwr1dk6OwxoMBf0wnXDoSF/GFRGAMPuyysce2ux+PFqSfZ/GULyKJ4E1V9V57C6TYtnZBFgr2ZAvr+kVloykLcBmEBqdS2t9fW38jJM1aFEWPX0YAuKYh4iSwyqmbcMWY4cxv6kjjDb05gJ4R2FCjTzgStbh8Og5EdDDVgGQZ2G1g0+OjwDty5i88/rmTIJFGrjS3+d+8fjxDcYz8n8xEC1kKjTZADZ4How==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFNHRUZ5TDJKaVNMS0N1Tll1bzdweTh2YVJnMEdCR0REWU5JazgwVm1EdHgw?=
 =?utf-8?B?TDVOcUJOcEVVT1pTQ0EwNXJINlVUenE5QWZjU1pZaUkzRGx3M3Z2MldYYVFx?=
 =?utf-8?B?N2FBYjdreUpFT3kxaUQ3amI0TnNNM29ZdVN5blRFcUVxaEdJcTVpRndXcU5Z?=
 =?utf-8?B?NmFnb3VycGo4UUF6MjRGV3RXVElvM3VUZnFmZW1KVy80N2FCTE84WjE5OElF?=
 =?utf-8?B?OVZqNXhHaFh4ZW5MK2dXbm05ZG93WUkybFRGNTAyaU5ZS25jOHUrYklzZFdk?=
 =?utf-8?B?THE1NEtLb3JSekRoODBlZ0tUaEFzNFl6YmRvYVVFZk9oYUZMK3hDTmJlZjZx?=
 =?utf-8?B?Q0xLaS9haU1BWVc4K0JoMHJYT1ZLNEZzdkQ2RmROUHFvMUwzQkFyT0dWUFpm?=
 =?utf-8?B?Zm9LWG0zV1VyRVRRVVdlVk5jaGJhZnNtR0JkaVE0dTc1QUw4R0s2SXd5Vm5k?=
 =?utf-8?B?VitJUGhRSVZNdWsvZWhpd2p4dnAzWGFxNyttYVNzSFIrL3YyWGpJSWJ3Nkx4?=
 =?utf-8?B?ak9kM2hHdUZuS1Z3Z2tXZU9wRGhtblF6akhBTUZuQW5JS1JCdXZKVSt3Z3Zo?=
 =?utf-8?B?S3JWRnZLL0tsOFF4N2VZWHZNNGtvUjgvZkVZRkx5K0JXZjMrdWVPb0pGVExr?=
 =?utf-8?B?Wkd1bjFaM3Z6Y1FSeVp2SjRWRDdZRkFZWndDTU44TkdoaDZjMmtzMHd2cTdh?=
 =?utf-8?B?TUw0ZVdGRVFRMkJQY1Z0YklvbDNTN2RMOG1QSEVWNnU4SSs3cFRNcEVBdDBD?=
 =?utf-8?B?cmsxK09vejJLdnBWczlXS1NNNDBRUnJRdzhHOUVGVmcxbzZsc2hCMjZUaDln?=
 =?utf-8?B?WGNnZkNDWmVKQmRVMzBxbWE2bzREVUlpSlVZb0dhNSsrdEM1MTZrbU55ZDZO?=
 =?utf-8?B?Yy93bXJRVmpDL04rUTFzWjZWUklCSW5MNkNZbGRvK25KZHE4N3VXT1FhM3Fw?=
 =?utf-8?B?OGZTVEU1Z1dxN3ZaV1F1Y1hzWGlVdnZzQXZ3V1doN3grVS9PdjhDcWxsM0tm?=
 =?utf-8?B?blR2djRJNGwzYjhpampGMkNNVUtNS3pUUXJ0TkE4L3huOVNWczJmb2JpWWVV?=
 =?utf-8?B?akFRdmgvSjZ0d3QrZzYzRHc4anNMNllvOG1wWUVUazE1UDhkR3I4Z3djaFdQ?=
 =?utf-8?B?T3JPa1dmM1NLWnQwMUpQWmFxNHZJenRaSU5ISFBOQzRzeE52V0Qxd1lCdWl0?=
 =?utf-8?B?R2w5a0JuOSs0amcydWNaN2pERzNPaUY5N2tRU2pCSFpZajNRQ2JVc21mbVA3?=
 =?utf-8?B?MjdEMGpsM0NEaTRRdFVHMHl1TytzbVNERzZZWUlGMU9ySm1Lc1p4Wk5HWWRV?=
 =?utf-8?B?M3BLbHRhODRpb0hkSUp0bVB5RGx1VFZBSlcvUXJCREdmTGQwVEVsTHdrSmZB?=
 =?utf-8?B?VkxmMVkvT2czMGpoUGRGZEdIQU1Ya0pXY3k0S0YrMmFKR3pmZjBtZEtBYnk1?=
 =?utf-8?B?bkpFU2Vkb25LOHdiNzl0ck1INFFFZzNtbnQrVG1oUzlWUHZvbGp4Y2hGWmJU?=
 =?utf-8?B?QUpoMXUyQWcxQUlhSEJVcDNqM2ZrQ3JTT2NCWEUrUVB4dWYrZlhHdG5CMjFo?=
 =?utf-8?B?ODcvVGU2QXBVTUhFdzFiYlFRTjJRTXMzcWVRU3MyUkw3Y09VcEhmdDl2aXQz?=
 =?utf-8?B?ZDUvVjBqRTNrd2VteWpJNXJ0MHBlUlhxMzh1eWZYWXFMeFp2OVd1SmFicnZy?=
 =?utf-8?B?NlJIMnFBOUw2UXFPUEVjUzc0MHVTUEV3bmlzSDZLNUFMUGJHV2lTTHZnPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f88958-9347-433c-8b1d-08daf8d07435
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 21:19:01.7586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9696
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-01-12 12:41, Derrick Stolee wrote:

> On 1/11/2023 5:13 PM, Matthew John Cheetham via GitGitGadget wrote:
> 
>> +static void credential_write_strvec(FILE *fp, const char *key,
>> +				    const struct strvec *vec)
>> +{
>> +	int i = 0;
>> +	const char *full_key = xstrfmt("%s[]", key);
>> +	for (; i < vec->nr; i++) {
> 
> style nit: use "int i;" and "for (i = 0; ..."

Thanks for pointing this out; I missed that C99 style for-loops
were allowed now. As Ævar pointed out, this should also be `size_t`
and not `int`.

>>  test_expect_success 'http auth anonymous no challenge' '
>>  	test_when_finished "per_test_cleanup" &&
>> -	start_http_server &&
>> +
>> +	cat >auth.config <<-EOF &&
>> +	[auth]
>> +	    allowAnonymous = true
>> +	EOF
>> +
>> +	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
> 
> I see that you added auth.allowAnonymous and --auth-config options
> in Patch 6, so perhaps this test change could move to that patch.

Good point; will update on reroll.

> Thanks,
> -Stolee
