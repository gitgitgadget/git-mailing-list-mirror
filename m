Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ACDC64EC4
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 13:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjBTNsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 08:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjBTNsF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 08:48:05 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2108.outbound.protection.outlook.com [40.92.103.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C9740C4
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 05:47:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofICv0EtMrN8tWqlfvA7G6gVs6y6vtRfqbgW1XBsE1QnYw89zCNjaNIBhBkZbsF6NG5QUYLa/kBoKFExsgvqGk9UW7Vz0+XRlrm+foWPE4bUKgnISdpQ4tgJ8mUl3EXFuOsjTzFqlUcRtroS27vXhUkhMWA1ELUGhftfjs8PRRQz1WlF4rjDPF3P3T/2PIUBxzYo+YrcGV+obKFRAOzrfgVfTfNrZJT4s05qfDrLLcxUEn2OKjk7rwpQeMm6evaJ8fEpDFOwTDmb4blcAtthn4odoaszL8BStRfF8K2sNEoZo3gOwskEejKx/P99ICRB1Ld24KwwoQQvvcH+eYQH7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzbrGT9UA7PMj9tILwiwZoHo9WX2Bp/ZGV3+UjNW778=;
 b=TamFoS3VpkGjHxyNnz5ktuw+MUb6ZLi9Ns1TAbOB4N74AgBa5zJRKnhLDCIkyQwhHaCMam54tXAhMnvJEpAquYLxQhcJV0korsHakKMbC1s7MGU9+tXEIwZ+LoNy1RoC8I2FJlYRJnnZO6MCaiZUWaoTH2XrjcjNp24Ui2FMFR/fS3HIBDT/Sq8nPlYsfhqjIyt8L5bma5n37hzT1grm8NwfwIvZnqBhWpnT5Yemd019X35rjVLBxVBPt5nGfrQAIEsZzQhhvsHwjQuHFPnMGuY7hbNtXDejW+PK3N/ref4qHBNcbeGjG/uEuNuTL1T9EwbsnnCsU72dbAKvoJSDbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzbrGT9UA7PMj9tILwiwZoHo9WX2Bp/ZGV3+UjNW778=;
 b=IFfSeCRYamlDH3+tyZ9Rbf2aZwsS9YIsluFCrg5ptlG3L8+T82zoMxWO8gBvlW84t+bL687IWYlBSHFGS2zzX+qrjzKnFgU6azNbtORbz41t/fiS/PxdOyi5S1y4qPnyCHDXZJbeVoWbYvUKYUn9BKISkLmNG2rXcXobwm5ELeh2p4mHFeQ3pNCC4iI3Ldkpd2bnd90CWxZifVYtsCMU1yrAISFUrP9sC39XHqLNl0lmx4zgwoIkG3OMdHC+c8thPVaymlRzBk51jx5yaMEPLSeyF+YjizEhbSGbggJk5PRnMrcSmU9nkz+Der0m+fNiUEJwpBWsycD0CiL0FfqoBw==
Received: from BM1PR01MB3139.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:6a::13)
 by PN0PR01MB6099.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:70::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.16; Mon, 20 Feb
 2023 13:47:48 +0000
Received: from BM1PR01MB3139.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::e5e:d4d4:dc64:b9db]) by BM1PR01MB3139.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::e5e:d4d4:dc64:b9db%7]) with mapi id 15.20.6134.015; Mon, 20 Feb 2023
 13:47:48 +0000
Message-ID: <BM1PR01MB3139195CCDB8C8D0C5BE8E11FAA49@BM1PR01MB3139.INDPRD01.PROD.OUTLOOK.COM>
Date:   Mon, 20 Feb 2023 19:17:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: How to find places where I can contribute?
To:     Christian Couder <christian.couder@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <BM1PR01MB3139C97DD4B99D3024847874FEA79@BM1PR01MB3139.INDPRD01.PROD.OUTLOOK.COM>
 <CAP8UFD2gtdeaJ=9_DSC4knHiyZk2TeVEq8H_XWA4sdNVEqdhUw@mail.gmail.com>
Content-Language: en-US
From:   Divyanshu Agrawal <agrawal-d@outlook.com>
In-Reply-To: <CAP8UFD2gtdeaJ=9_DSC4knHiyZk2TeVEq8H_XWA4sdNVEqdhUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [fXHaJ8usqH9Q92LlqW0AissUvtXtHUO9GO/vdkk36JMjjkrBL0li8UD8t4LxRfv3]
X-ClientProxiedBy: BM1PR01CA0159.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::29) To BM1PR01MB3139.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:6a::13)
X-Microsoft-Original-Message-ID: <ae837509-cd6e-ba08-1c5f-8910f80a703c@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BM1PR01MB3139:EE_|PN0PR01MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: e642e6d4-f082-4a16-4293-08db13490d50
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dIaZ4u6pK711fmBkmkDaIynyk+T3KeC1rzhnBGD3V3NztXdtextcfre33VJaWx4XxV6jGMsp7cB3A5qnMwUzpkCkreeypcmBV1Dxkx2KsvwUwbFc6RY5+xGzAhntgGXeCIF6b6YZ+W0ee7Hw554rmgBX8ITGI0uPSloiyKKmQitQW9fwCCioKVYagrXfuLom+lqBw7Y1YKCKIDh4QfirHblnOTd/hzCFHL+4ConMhFqilPgE8V3XnK2NqqkKJkzq3DNtqVhiFUBFh0HlXbQCd8xSMlRN+EGhKgedCOLLIDFQzsx6dAIcbuA5EzhWfQkEpOSLrJTNMEaBarl+twlIATODX3CFbNl7gzMRxQR5PgoWhR0rXydbrTAne4CDQMeU0rXJNuCOugGd5k92hq1fEiqspPW3cbn9wtEPdmQuMZUJoTPn+IkPVg43q7ol0VWMSP82SLMKr0w2cdAi/CKb4sUzbP1qTPD2ZRpC4iuwoORj8g/j5JKfXfWbTXi5G9zjFf9huRwWUt+7PKVPg5hfd1xvAU797b8OCVG0S5XqJsTcfx4+JvUqv/P7kXbYE8h1J/XPaa5dKIX5W9wavh9lt8ctKZPvKruJ+LN+r3rFLKBlalHXQx01OXGl71snbTqZ7pEY4+JrKpOF5n0cK8O3nw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHgyWWVRWml5Ni8vYmN4cDBtdndtR2ltTHBKTlBqRFMvMjJJTW9tV1pITmhm?=
 =?utf-8?B?clBCTE9hdTZlNU1YWUxYd1lzNFU5N2FXdy94WENuYTE4TzJRR1poTXUzSTB0?=
 =?utf-8?B?M0pCeUtrVGtJN3piemQyQTBYZ2pXbU4rR0lMcWJVZHlRa0FVVklhaFgwekRw?=
 =?utf-8?B?RzZEbHVMNWZ0OU5SQmFOUkQ2TGpwUnZLU0k2OGVpcXd3c0M3eDFVZmhxZTFS?=
 =?utf-8?B?K09DVGx1ck1mOGFKVlBXR0orRlZZYSt0R1g4VjdQb1J3VFpEWTFGRE1SNzFt?=
 =?utf-8?B?Q2VLNVU0R2lnVUh4OVJlYnlJZlJxVnhKcTRhU1dHdlBjUkhFbDhRWFBGY3U1?=
 =?utf-8?B?R0ZyeEJ3ZGxtTzdOUkdxbUY5eTcyZ3pXZUsyUlBwOFFaMWFJV3VmOWtHQWZX?=
 =?utf-8?B?UklUelpEYlZwaWZMQXJPT2drcGJZZjBGVFhOVStQUVZOSEhvcjErZm9CWG5L?=
 =?utf-8?B?djQ3ZFR6MTNHcmc5ZUR4b3JYVnNyeDRDbmVTYklITHRsenlWOUFmK0FrRitM?=
 =?utf-8?B?aDNSSHBUSTNmaTdYcUNrU1d6RktXT3I3Vldsc3lPcDIwQXg1UUJXZmp0bVc3?=
 =?utf-8?B?ZTJ3OG0vSlBZVWg2b1hBeTl5dU1rb1RRU3BiUldnZHdMMmEyRkVMWFZJSUR3?=
 =?utf-8?B?UDNJYjQ3Tll3S2M4SEdTNDFQZi9nc0lrNStlYUNHYzk3SG5sOGhSNHI0VmxJ?=
 =?utf-8?B?aUVYcmNMWTVnS25PaSt3VHAzVStjejJsZFVibUxiQ1pjRUQ5STdwaHQxZ0Q4?=
 =?utf-8?B?VFJkSlZUdUdRMDJqOTJYenBmekIwMWt0bVJyR1V4TUJBcEpNYXQ5SGUwQStj?=
 =?utf-8?B?WlNpaEIrQkk4aFgyWDBUOHQzb0pMaU5WZ3RRVGFyc2Mzdk9UdjBmRDh5ei9G?=
 =?utf-8?B?MXVVbmNaQ1FYMWJTMTh6R24wZVRuRWdkbE1XSGdXTGIweG5YdzdTUEloVkhS?=
 =?utf-8?B?Z2tDODdMNkJZMXp3WGVpQzFEZFRIa24rRFFSSnBkMWlwMmhwSDJ5VGV3VjZP?=
 =?utf-8?B?R3plVW5FRE5CclFjV2hFMERIK0JIOWlIcXNkcDJFM3duZW43cEtYdlBuVGsy?=
 =?utf-8?B?ZHdRcnQ5ZGExOVlMZXFITnJJT2NvdEZTU290cVJNOExvRlJycko4MmttbTZu?=
 =?utf-8?B?eFI3S21GanNqWENxUE0yRDJJNWFIKzJNK2pkTUJqMGxpZ25BaFZlTmFiQVNk?=
 =?utf-8?B?eHJtUFVBNE1FMjNaRlhLTy80YUNpNnJJa01jcHk4ZUpLbVFOVFVFRFRwc1RV?=
 =?utf-8?B?eE8wdTF4aVBqMTVObG56MnVlTUNwaGw2VUdJd2N2THhJVFlPTEZCRHl6akxR?=
 =?utf-8?B?bTdjQXVST0FVTGtqbG05bWN2TjREMnhJZUQwa0Q4aEY5YmtMZkZJYkl1VjV4?=
 =?utf-8?B?Mk5KaGxYbEY2ZXkzdFRyN25lcmVKL2J6bXJuSjhhcXo0dGpxYWh1dCtZZzYw?=
 =?utf-8?B?VEQzMzFtbDViSXViRUM2S01UYk01UXBjNVE3N0RqaHU2THQxUUZRWnM3MzRx?=
 =?utf-8?B?Q1VYcWNKM2NQRHhnbFJnVG9UZWtFZUYzaU9GbENsQWc2RVNjQ0tXMTVGRGFx?=
 =?utf-8?B?WTUwSlZZSkM3MllsS0ZEd2NQeVo5alU2d3ZmbmFQdWY0RkVQOHlZeGQrTEZE?=
 =?utf-8?B?TTRaeWVSTzV6OUo2b2Z3ZnhlLzBQOHJUZFRzWFUzRTJ2eHhZb2JWd1M4anhJ?=
 =?utf-8?B?RmQyZkN0WjhHTWV6bFFhK1ZZUFc4NXR1eHdGbzJRUHdiaU9mY0dxZlRCRFM1?=
 =?utf-8?B?am9icFBDQlhkd0pLbHZNTFhxUzN1QmZQeUJvSDJzZHVXTGFSSHJMRmxDeVRT?=
 =?utf-8?Q?OAzm0Fy/VD5Y3MlQJLOCQ0sdk2jSUpYz4WdkM=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e642e6d4-f082-4a16-4293-08db13490d50
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB3139.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 13:47:48.2773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB6099
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Christian, for the pointers to the documentation. This will help 
me get
started.

- Divyanshu
