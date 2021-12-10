Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AA7C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 09:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239754AbhLJKBg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 05:01:36 -0500
Received: from mail-eopbgr130044.outbound.protection.outlook.com ([40.107.13.44]:5185
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239752AbhLJKBf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 05:01:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrHmE6zQSyyqmcBL+gqAKvntbG86iuJ2wE2WPKKn6jwJohyNL0PPFA/hQOjWgZoqDDiWHoXyHE7ofIgCC/ssR1k88EJ9+TPU8IBXr6xIib4+bcoXWH9dKdUBFaH4OKDYgvsMsC7p5XXVkLtW/fX1Tp3SPgv+e/l6bQJ8dBue2KV1pt1ZyvW1bdB9GSShLWCu3+lnP18LU1c7zdARvXnhppvwqjXCatKhj2Tf+JHxeaWSJxYORA5eweZbwW4RytSsNJq0OlFtw03trQOydJihuTfr0YlsSXMQ4ZqmJQtwrVoBFwml2Vko3aIrB2XkOXpeKWr+yG7p4m59kOynpP4X9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=faJrSz9tawfA70dAUY84PbrFqfAEJgbh2LN8kHat0Rs=;
 b=NbhOIu+O+qA98FzD5CHINVCW6NNv1nYOHW1Mr7DmqJnugTcDugf2F16i8764dBu0f6urYd1SUKnzBtn7A9WuPuXpCfB4JoQOVlGh1I/v4hF/eWLhQ3lsraEy/wjPMSD3yb9htPmm/lUeiu9NXGoFs0tXBcWspyZiaSJuUhLxRX/bLMDexK3WIuXhkeYd0xk1eepet7lJVmfhw5PYmOrh1aHe8nqGdjGohbcGcHmPnNhItoRAyNL8kPUgKKz5szvi4ZBDw67buxxbYJjHZ0AJt+YK7qv3evsY9J/st4bdr/5FDhNbIytCRoltVR7oT+iEJdBQANxWn2ZbTcn+n0ALtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faJrSz9tawfA70dAUY84PbrFqfAEJgbh2LN8kHat0Rs=;
 b=PhacUH0pP6DLDsgXMlBcGuUCW40EG3eXnbjsl3Q4i0WXJ3bqNiaJIhTOIyhlsDYlqdc1mMKqT63O+BbZ1KaRMN669GjdJ5LpwMvnGUIkI95IFS3DS1u3FKEauDDglesDmjMFPIcT4/BclJ2ZCVeoFS8caJSznYWCNpYCzgSA0j4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4192.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Fri, 10 Dec
 2021 09:57:59 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Fri, 10 Dec 2021
 09:57:59 +0000
Date:   Fri, 10 Dec 2021 10:57:57 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 00/19] tests: fix broken &&-chains & abort loops on error
Message-ID: <20211210095757.gu7w4n2rqulx2dvg@fs>
References: <20211209051115.52629-1-sunshine@sunshineco.com>
 <CABPp-BFM5ZbFAzVfvDE3=zm6Q4LN2fWthPP8WH5kbgVPSxomtA@mail.gmail.com>
 <CAPig+cRD_DzisMo-8ZuT4NzESEe4i2vPk_1Y-_JTeV9rbdwkLg@mail.gmail.com>
 <YbMgL6A+/12GTeuf@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <YbMgL6A+/12GTeuf@coredump.intra.peff.net>
X-ClientProxiedBy: AM6PR01CA0066.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::43) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:3e55:2984:f78e:8b18) by AM6PR01CA0066.eurprd01.prod.exchangelabs.com (2603:10a6:20b:e0::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14 via Frontend Transport; Fri, 10 Dec 2021 09:57:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20b87259-2061-4a12-42b0-08d9bbc38bda
X-MS-TrafficTypeDiagnostic: PR3PR10MB4192:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB4192E7B4D69FB737E3026081B6719@PR3PR10MB4192.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q9cvmMvn5TpZ0tOSduYy/ld9zOePmdInbKnG/gmybI5hPtqwdE6gOXBcOm0ASCO7+U5m1bX6+JLlrPLgtsHr1YdVHntIICau09ZeiXL1DH9NeC2OZ0LaVtimjrdkjVeQRQZCPRdwoHhcd7NcuXLrxiO20TPY5dMzawvJfo655li+VeikZZbRGItQRDXmJw1ksCzn9kaX/RUtEqS9qIf3fZ/WhN/HUtR0wrMRv6X4q9CvkhDPjYaIGDY+t8EkiJUC7OIttowEeMxpuUbRpfI2+WVvvT7AJnkkuBg3lsbOlIlmMDXaTkp6fY6DaLZklPrQzKmVT14ix9BVx5ot8UbXO4J408bQFv8ZR25QTC132wh/GC9TqeMkZ/+QWa1IA+BbJ2eH2EVAc2GgYUqXWFXnCqldCp8X/mL0/qbZPjXj9QRokmsQjXVFuGP2GerYvvN/8P89n3QSoqpCs+Ky6jiMgyn/Pk/QHIME9Wp5+bx9+P+7jdMmnvxM6D/zyC78l7iRDfS2VEHSjXpb3HF6UmFoNDrm1fOhYFzY00ktEYjiPtnfN+te/FEL32cIKCydpKIyRfXxvqIbyjGrja9zCm+CPlgXuj5K9cL/hDFGu8CDDHkRsmFQp00hlAKPO4VzALlru4vGE3GMhYe2c5J/mQv66w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(376002)(346002)(396003)(39840400004)(136003)(366004)(508600001)(38100700002)(86362001)(6496006)(186003)(5660300002)(53546011)(9686003)(83380400001)(1076003)(316002)(54906003)(33716001)(6486002)(4326008)(66556008)(66476007)(6916009)(8676002)(8936002)(66946007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWcwN1IvQ28vTHRFY1cwQklqZzc5S1ByRUNQQkdlUFMydkNzRmZpNzZYbDFD?=
 =?utf-8?B?VDFERVA5emJ1YXEvVjV5UFV0WThDU25JRi85V1JrdXNydDY5YS8rZnVyYWd6?=
 =?utf-8?B?MkZlQS9XMENMZkRCNWZNOEdIM1hJdXdpRjBobkY5WGxMT0w2QXlqVlZnaTdE?=
 =?utf-8?B?MmVmQ2NyczM1MGZNcEdDWEFvc0YyT0pjK2taS2xRV0FUNVc1eXYyMkFqbXZz?=
 =?utf-8?B?ZlBTT0w5b2RvZXE3ZU1PU0hMdzcxMUhqVUc0NlYvZmZZUXZEVG9kcWhlT1cw?=
 =?utf-8?B?ZDArRnYzZ1V0NkRVYlczbEVKT2puaXlyZXJxRzVDVXNOMWJ0aTU2d3dNeG9T?=
 =?utf-8?B?L0M2YytXZEVVdWROSDBnT1ROOEt5ZDgxbFhTWFNsZzdkeEtrUVN3amtTQlZ1?=
 =?utf-8?B?bmxDS09Lb0FmNkhJazRpWWRYbG0wd21sd0tVc3lvSDd3REQ3YU9QbmlNVHl6?=
 =?utf-8?B?SVFQZ3VWWENPUHVKYjFZaEw4Zy9TazNWNXhoMXJ1V2N4NFljNzl5MzBIaUIr?=
 =?utf-8?B?K2lWa3dEOEIwVzFqWGhhWi9zNzlCMG5nZkhGdjJXMlNpWU9GcVFOUXhnaEJX?=
 =?utf-8?B?LzRSL0l6MVZ4M0p1NzJKaUJicm9RdW5PNUVFOWR3RzRVZjhSeEVhMkpCVGpk?=
 =?utf-8?B?TUFOYkUvT2w2UVptTEZGSzg2aWFLdXdjMThFUUI2RjdvUjMyL2QvYjdhZUp4?=
 =?utf-8?B?eFpXTjF4ZktaQVBTNGtSN2xBOVB3dit2U3grT0o0RW5MWXlqb1B5L3RwMENI?=
 =?utf-8?B?ZjRDcU5Bcm5wenNsK2FPNzdkUUMvTng2aC9DNEpMUXFaOXkyZnMzVkl4MHlx?=
 =?utf-8?B?L3lRVHphT2RKMWNvYmxrQ2hEWXNIcjRwUm90THBlZFF0bWMvZUFyZnpPb1or?=
 =?utf-8?B?RlV2a21IQis3VDdhL1NDb2lyT3BKUlg4eExYSGt3dlllVzNuNFBhWWlGdVFO?=
 =?utf-8?B?Q0dOS0g1U2ZTTVRrUUUveHkzRlV4c2gwaDA2SktYZzE5TWZ4QUVpZEEwVGhn?=
 =?utf-8?B?ZDN3V2NteVRWT2NPK2tiOHlIYkxaMlM0UHQzOGYybTFHTVI1bXlndmxDQjRT?=
 =?utf-8?B?UDFvZjJaczhxaE05TVFVMUxLVGNEbENFVVR2Nmc3bTZCZEwxVGNiN1hKMlB5?=
 =?utf-8?B?SG9kZlB0S2NsL2M2SW5nLzcxQS8wSktJcmVlOEI1Nm9xS0Q2V2NIalVvblVK?=
 =?utf-8?B?Zk43YU1pWGxhYjNiNkFPcVYzYnJmaDBYdlpQM0V6ZjVqY1lnekdpTUI3MVJm?=
 =?utf-8?B?TWkwRkhqS29XdUV6ekNhZkZkUDFnb0xvdlVYR0tLRjdCbVlINEdxQlF2S3I4?=
 =?utf-8?B?NGt5ZnJ2UW1UOWM3aDFSOEtDeW15cTltQmJvdU5ENGx3MGJENUJnYnBHbmpr?=
 =?utf-8?B?bGpuT0NpSCtGVytYT3lmRHFWa2VxQzVseDRNSjJ1V25BWHN3R3B6M0FqOTZv?=
 =?utf-8?B?VkpPbituSzI1eU5DeGMzcURzVHJBMjgwRGE2a3NVaTQwSk9tWTJOU29ydzBh?=
 =?utf-8?B?cGZQRCtIb2s1N2VOZTZ0bE0xS0p0SE4yU2QrUzVRZVBVM2ZCMFgzK2JTQllQ?=
 =?utf-8?B?empidVFsaVBmK0NXSzFCMnlRTDNSZWJwYkdSb1E4Zm1ZY292YURheHVsR0gz?=
 =?utf-8?B?SHpXWUd5VjNKa1RTWlFVVkJFTU9HL1pSUnB3WkhYRk5tRWlOY1FRTGR6ZnNS?=
 =?utf-8?B?NG9SeXFEWk9tSUtSOFVJMUJUVkR3MmpPQVlrSUpOZld1Z0x6WXl4R1c1cWw3?=
 =?utf-8?B?QzhnNjdFb3UwWnlRdk9UYzFmRkFocm85clZCNGM5TzB6K2JHbDlGSFFwWWxk?=
 =?utf-8?B?UjFJZk5talk4RGsvcnRBK1M2UkxhQllaalA5NmNjOW01SWRFMGVjZm5xblBU?=
 =?utf-8?B?TDBLOUNMd21zdktlN255TjhkTllzdWFHK1h0aDFsSm9rN0Y2YkdHVmJNTml1?=
 =?utf-8?B?RzAray96ajRyVFl3RUtjWjV6YUtidnM3bm96ZUVVWkZQd00yaC9HekJJZjV2?=
 =?utf-8?B?em10M3ZITUJFZ3d2elpJTEJYdThvL04vR3BITndKRSs2WUhSNzJXTEQ3NXZr?=
 =?utf-8?B?Szl4MTloZ0FyRzMycFdINEl5aHhjNU9kZU9ZL2p6RUVvUzlUNzlYeTRWdnRE?=
 =?utf-8?B?VENlZVc0MExWb2hZZ2NDUVVFTk1LeUlwSHJwWEF6bWkyNWRDb1liN1NaY1Bm?=
 =?utf-8?B?cXZ2Y2FKbGdsQlNWVDVxdkU4ZUU5MkxiYUdxTGlzUndQWHdmSStqL1oyQ1Ex?=
 =?utf-8?B?TXh0SFA2eDRYcEFZTVVBS0lpdWxlMVJ1YjQ4ckxHbi80RUZaQ1AreDhEa3BN?=
 =?utf-8?B?cGp6bjNBaXhEQWdyVDIwRktXS21LZ3JHSEthUys1M1ovL2NRVDR5N1FTZEtF?=
 =?utf-8?Q?+tA8uty5QJJVztiI=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b87259-2061-4a12-42b0-08d9bbc38bda
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 09:57:58.9816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2UIKLCdUQMcHQqaEJckVAl29lJPkMEg5U6JoJRvI4Euo/QG2Q18eybgrRQnXJbnmKKlh8hLsPjYMivT2kcKb5LxsbnfzUB7jkaUBeimeaKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4192
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10.12.2021 04:38, Jeff King wrote:
>On Thu, Dec 09, 2021 at 02:17:32PM -0500, Eric Sunshine wrote:
>
>> > I have to admit to starting to skim once I got to the last four
>> > patches, since they were a bit longer and all the same type of change.
>>
>> Understandable. Those bulk-change patches tend to be mind-numbing to
>> review, though `git diff --color-words` helps out somewhat (at least
>> by making it easier to skim the changes).
>
>I likewise think I may have phased in and out of consciousness on those
>last four.
>
>> > You did an excellent job of explaining the changes and presented them
>> > in a logical fashion.  The few things I thought I caught, you've
>> > already answered were already correct.  I do think making the second
>> > commit message be a bit clearer about the importance of the ordering
>> > would be helpful.  Anyway:
>> >
>> > Reviewed-by: Elijah Newren <newren@gmail.com>
>>
>> Thanks. I'll wait a couple days and resend with a clarified commit
>> message for the second patch unless, perhaps, Junio would accept a
>> resend of just that patch so I don't have to spam the list again.
>
>These looked good to me. I left a few comments, but nothing that I think
>would trigger a re-roll.
>

Very nice work and good explanations. I learned a few new things :)

Thanks
