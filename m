Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F60C64ED6
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 17:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjB0RT2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 12:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjB0RT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 12:19:26 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04olkn2073.outbound.protection.outlook.com [40.92.73.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04566EB0
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 09:19:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PynF9JTY9LgUcyGLS6ylV/PdUyG1Fkh258hVbfRPj8V0eb3CLnGb8prC04rr+5ufd9j8a7AFXFn+MA7vGvlczfttPSuiuWdFlzG2vhtn1gTTjHda2mxg9cwrWHUrexynYamYhXl+i1v6O/tEb/R3r3JxG2o42PdIgQDasWujbVhAy9SLtGrvMH6IZ+CFTE7MRTCP3ZcBsUQCNUmbRGseFZd2RGwG6Bul7yxvuNiECD++9VK3pv9Ty41iVp+aQupsf0gFGnY23TgOu+nFRNash3h4nKbO9lIwB4CgvmU4XUNpYDr3XssxfJH5AIa7XLVeeP4xrG8dtE8nVA0Xw4SEww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPHIzUqEyqlvpKC7udnjTTIMIBu9tfGnc1PBlNEMT5Q=;
 b=nS0wogRmOxaSqqKFvCmr30JSDSLoe5lznxUMOy6GO8SJrcqIfqoUF6XUIf2jIRnr9WI7MIVWDcrU0OVL5iCN+1gXgL284Tp1ToNso4CohXJKG7isKdrhPl3Fr4beZtxClsVtcwLHP1+ZJIjnR6wYy8ARE/RLO6N7Hv1Cfn0etE/KpzuCx4rnzFzwmUrtxWQ9rE+/CmRrnOkmNQ8yXkShAJdLTkfSHNkjaGrvXeL0qqhe8ZY/V8piDphnamyy+DNDxmCQtz7zmVJvMe2KW/F0joO68moHjB9achhTMzNWNu6GQPo14leo9J6F7Vxgmk+yYdEZgauJhwrhz4A5lUUY/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPHIzUqEyqlvpKC7udnjTTIMIBu9tfGnc1PBlNEMT5Q=;
 b=uTWnUiAxgTf2MWDCQBxZYQMK73b3PH1DLjdj3lvc1pH0ErCG3mdBBoF0K4NZCW6KVvldoDAcN5bFJrJLkPA5gER3x99q+wfKXc+jAuWz4JaHzUxXR74PWdmoyYg7jL7B9tcgnxHc5bnwXisxn5++OiI6xT0nt/T8QKsOTlSe7QNpiVGKRLjgiN6T2VYW40LtEZVhy+wPhFJxubmLNi8I4nLmIQF1xVDx/wsqS6HsIO0vvYCwB8PuMi/zdFCCDCqkWtH8TL4JVYi6jQxNQwFkf6038Mx7kwE3xV1qhqrq27/kciQKh/W20Lmy2+hxe0nQj9ZGpvyKcVjzEg12+kxjIg==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by AM9PR03MB7728.eurprd03.prod.outlook.com (2603:10a6:20b:3dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 17:19:22 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::7674:1fe5:785:a469]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::7674:1fe5:785:a469%7]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 17:19:22 +0000
Message-ID: <AS2PR03MB98156E464D1FCEDA59348504C0AF9@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Mon, 27 Feb 2023 09:19:15 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: mc/credential-helper-www-authenticate (Re: What's cooking in
 git.git (Feb 2023, #04; Wed, 22))
To:     Jeff King <peff@peff.net>, Victoria Dye <vdye@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqbkllaxd7.fsf@gitster.g>
 <3ab86863-fa15-a5c5-08c8-73ad775e04c8@github.com>
 <Y/c2dQTohGsN+3Me@coredump.intra.peff.net>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <Y/c2dQTohGsN+3Me@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [+3CbFM6S4k9LtLXnRNE9JMfaKoOmzHZLJngrfWRcLV+eRAe1yAAzBKX7PTO2B8sB]
X-ClientProxiedBy: BYAPR06CA0033.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::46) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <dd5278da-4967-78cc-ff00-56f78c24611f@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|AM9PR03MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: b14a7fb1-79f5-48b6-0504-08db18e6c466
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VlEygVTwNCNsUcFa/eFMp/7b8dlOh0iuLChIYEzu/qUPujthlBieWqvcx/7ba8KmYaSpTN++/0OPGAbdwkepcxlIp12xitFbMkXgGZ0ftl0QQDxq3pX13h5s71XAHU9MlZyQyOZ58qY6UMsCHk2nCm+BT2efJGzXyrb0VAJfwIlYxzUcsnZPb7uoUTy+EFp4rwbI+cc/6o7nJiqzHbv/cme6mypT73apCSMwSbV9TQZXgdc3iELUYwDeVxMNU+pCLoDRcVQWOPitzbYy+JzvRXrOSSUOnImbmYmhllbPphwtUEFSLl0ADQ/f/5uNCobjW6o35MRcBOpXp2jQloMj/SCRfZ8p55MHRqXYC5DVgzc+GCRf+hu2/6EvjDnWrXtCEjWfztp+xDuUdipWxk7s27xwdEPtVAF4YcsG2duUBm4PSNFS/jrU3eLmHpA10I7VtcG4eS5Ic/pgCv1uczLGyCo4HKe7L2QaaayATzE01nF2PhIWjo6W37Fpah08A6kxKrWu6C6pJ3D1P+K22w9bu7zCLzmcbkZ74sPn8Ex4IXC1qS1XaQTIgXhKB+icNiuAhw7ABo1ZfrMZMhCW9PWzj9qFTxYYONwoxEenavz6m866xfEVJQg47xF3Ew+E/rXOFdEIA3a3Z9rWgHpsvIILAg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1FYSGwxVGZCeHMxUzYzeDIwa010Rmdlai81MmEvMUZVcnJxWnAvbnZqVm9K?=
 =?utf-8?B?UGUrMnRqc21GYjQwOXZwY3lQUDVmLzVnYTZ5YXJPeHo5ZmpJdGllSklGNm1q?=
 =?utf-8?B?Umt0UDIyWENnbWt5ZGlVeUE3Z3dxVFc4VWRST1I1L3JrbFFZKytVYjRqVisv?=
 =?utf-8?B?d1FVZkdXVmtPbE5EZEJzUDlDaUNxME5iYmJmc3FPdGkvVlNSVGNMbjBTWTJI?=
 =?utf-8?B?ZDR0TFYzWGFGaElTY1VudERsTVdsQVpsN3ZvSnk2dmdaSjBBMWlzaThDQmRF?=
 =?utf-8?B?ZXVmdjI3VklSRkdpc1FUbmxPTGpNVkY0SEdDTzV3QWk5QVoyRkU3UDFOVTNZ?=
 =?utf-8?B?TFFCcWQ2ODlnc29hNDVWNXkzR0RjWklzZVR0OU9OTjF4RXZNdmN3WmFNVktl?=
 =?utf-8?B?MEpyckJhNitiWlRYTlBiaDVSbFFJV0hvMkZIYVlJR2NIZFBFY1R6dHFLcmls?=
 =?utf-8?B?MzBJckhqMHlPL2RXb0RqOFZkV09hNUtaYnFUakxTN3UxOUJkZUE1Wktqb2k4?=
 =?utf-8?B?aDFlUlNoWGJ4eFNEMWx4a0dKMkJlTm96QVhGZXRDSUNRT0N3Mmt5NXRZa3NY?=
 =?utf-8?B?aHVtcHBHM0QvZ2pIWERDT0g5blBmc0tkZ1MvdXFIb3RDZFlJWW9TVWNZY3Ix?=
 =?utf-8?B?OTBpb3J2R0lsMXludFlVRitFVXZIL1loOWt4aWZxWVdwd2VObUlXM2JBRTJz?=
 =?utf-8?B?YVhFVXoraHhZK3Z1QmJ2KzRyRnFtWW5IS1ZycS9NWmh6bVJaYUpjNm9Ib1Ax?=
 =?utf-8?B?eS9NbUhONG12RElWTm05b1k0YkMvdzJ0WStIZEtHb0tHajdrdElxZWNNY24r?=
 =?utf-8?B?T01xZ3R0TmZxYzA5V29rVWwzeGpsaW1za09Dd2dPeUZPcmRrQUFEeVBHTWtx?=
 =?utf-8?B?bmxKN3hsdXhScHZuVjdlMm1jTFpWZkpOU1NPUXI1cHN5NUlJU3FhRm1GQjlM?=
 =?utf-8?B?REFSZWhKSWR1ckwvVTBZT21LeXppbzlCU3U0V1JDWUZjUGwwb3pPb1JRdUow?=
 =?utf-8?B?WnhDQ2FMdVpacmcrdTgwYjRweFVvdHRJTyszZXlvcUprT0F4NnRqQWF4RFY0?=
 =?utf-8?B?a3o4R0E1TEJlSEk4Tm91N2JsS3pZQjRaV2xFaU42enBkMFB2cXZRMnBoa1VT?=
 =?utf-8?B?NGpReURyYktRa1kxajh2NkJyZitTRWJvNXVJcndzZkhXeEN4OUUvU1FSckpO?=
 =?utf-8?B?NVBkeFYzNllyNlBVdmh5b0I1TlR2bDlpWDFlc1lmZEFIeno4UlBvOEpiWnpI?=
 =?utf-8?B?UDh1N0RkTGdDbXJJUEJLMHAraGZCVS8zSzZXbWloYkl5Rm00elZHaUR2REd0?=
 =?utf-8?B?YVNtWHlpeWllVzVzZ29aazdnM09XT0NkMUk0NXVveUhlYXFPMDg4MVNrREpv?=
 =?utf-8?B?UkM5eXc0Wk9oSmhmNUdxUmVtbkEvMGt0RUZiZkRJM2g5YXh6d0FscGNwdVpy?=
 =?utf-8?B?RlNaNUo2eHo4cTZ1Uy81ZFNUY2xYQ28weUV5WWRPWXJoZFhJMXo2YjloMkFB?=
 =?utf-8?B?c0RjUG5GRWg5RXVINVBTV2RkNHFvTERyOHJtaXE4bUNmOEUxZjd6a1Y0M0xr?=
 =?utf-8?B?MVpxQUtxZWxYZ2I0eEJPbFZZVUgzOStOR3B1SkdQdXZHOHo5MDgxTTRMYTlk?=
 =?utf-8?B?Y1ZCZk9NZFpjcGJ1ZHZMR0xsS3N0V3dOZlhpeDdBd3RLUGFTUlc2dXArTmUz?=
 =?utf-8?B?QmJYRUhXM1YzVHprWkdYM2FtQjEyUUEzQzhlV0dtN2R0MHVuc0xXbGI0a0R4?=
 =?utf-8?B?M3kydXZGOFBIbjhNMGZKNmF3QVRWNUxRUkdBT0ZYVE5lcU5mcU1ES3htUTdJ?=
 =?utf-8?B?UWxEUWFVR0lrOFVEYWhDUT09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b14a7fb1-79f5-48b6-0504-08db18e6c466
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 17:19:22.4466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7728
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-02-23 01:48, Jeff King wrote:

> On Wed, Feb 22, 2023 at 09:51:28PM -0800, Victoria Dye wrote:
> 
>> Junio C Hamano wrote:
>>> * mc/credential-helper-www-authenticate (2023-02-16) 3 commits
>>>  - credential: add WWW-Authenticate header to cred requests
>>>  - http: read HTTP WWW-Authenticate response headers
>>>  - t5563: add tests for basic and anoymous HTTP access
>>>
>>>  Allow information carried on the WWW-AUthenticate header to be
>>>  passed to the credential helpers.
>>>
>>>  Will merge to 'next'?
>>>  source: <pull.1352.v10.git.1676586881.gitgitgadget@gmail.com>
>>
>> Aside from some relatively minor touch-ups, this has been fairly stable
>> since v8. I'm happy with it at this point, but I'm also curious to hear
>> Peff's thoughts (since it was his review that prompted the switch to Apache
>> for the test helper, among other changes).
> 
> I just gave v10 a careful read. It looks quite nice to me, though there
> were a few tiny nits that I think are worth a re-roll (the most
> important being the strcasecmp buffer over-read).

Thanks for the thorough review all :)

> -Peff
