Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBD5C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 15:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbhLMPnb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 10:43:31 -0500
Received: from mail-db8eur05on2049.outbound.protection.outlook.com ([40.107.20.49]:53273
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232268AbhLMPnb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 10:43:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuTpCT59PoePKWI3BJsO9Sj5bBefbA5dJktCjhdqUywdIlzV8DQ0ObgFXggQ38tO7s3uT/7AZGrqzB5rOPE2iOqXjfl2MDdBlT+rHeaGmsDoybhzIRGOP9oBYmDpDjDrnfsDO5MKx8qcca14j2x51+KjanlhM1dojgI16QAm3kArRwFcCRI0I/we4in7XEhB3P/Q1L5WDSuGk7dN7NG2MucvvsPhisEKOKdQlSD/inuAzh4pXMQx+rqlqJcX1b+GF0k+GmU+7hOZhpeoHQjSxha+6imyu1223ObzmHLx7Yyzq0nMKeYVVA1U/HpL2RnLBCDggd/JLVqynHScLvnVoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRBphluViK13+U4MkWzBPIgYv8EwLjVAsp9shXdbr3Y=;
 b=ZgoiFJz3yTfe4EuobsEjmpxsmhtiLWKHyE88RRl+ncXuPSJPcmGDZx9GuZb1QqZvHf5v2UOPR0YLPLYmHfZrJ73MCdqL1jGjSbktqGnfyy4qwW7DL0PMm0HNEgBFmwsAknRlg+M64cZhYyMHUpjLjHe97dgCtne9JQeB70airVDYZP7aFSMKWNPbetksoUBqsHK+cYQyfQGOkzrgFRjCkhKoeuCoMFIY6xEILrcVbn56qZAFLlTQt+FRkVXLjfA1tSCXEZ6vTLvpvZ3vmO+vqr835Nd+4PAxepkydc6MuOEWYtx/daGx7Fbda2c5pSOF8s29vxBJDHbKelKKlMBsGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRBphluViK13+U4MkWzBPIgYv8EwLjVAsp9shXdbr3Y=;
 b=fR7KlIDv70ntEeBgGgSZ/bhrDYpDzOsDktwkUax5Nlg3AU0MbrvtkJjn1uIM+zZcW5eHjg9gM/AZIC/1J+1x8c4Kk7Nh/chyL22Oor57YznYUDwFkXbJaec7/1CV/yYsn++0A/Pg5s/XIs/SEUFpQGfEUMRgDr1VrgicV8tUyMM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4400.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 15:43:29 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.028; Mon, 13 Dec 2021
 15:43:28 +0000
Date:   Mon, 13 Dec 2021 16:43:27 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 05/15] t/Makefile: optimize chainlint self-test
Message-ID: <20211213154327.pmhopjbdlkz7dgjh@fs>
References: <20211213063059.19424-1-sunshine@sunshineco.com>
 <20211213063059.19424-6-sunshine@sunshineco.com>
 <20211213102224.y5psbojmivlxe5px@fs>
 <CAPig+cSKn6wdPKc=b8Xjqy5D=bVdu6FQtYKJuwN2VoV7pEEgHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cSKn6wdPKc=b8Xjqy5D=bVdu6FQtYKJuwN2VoV7pEEgHw@mail.gmail.com>
X-ClientProxiedBy: AM5PR0701CA0006.eurprd07.prod.outlook.com
 (2603:10a6:203:51::16) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:3e55:2984:f78e:8b18) by AM5PR0701CA0006.eurprd07.prod.outlook.com (2603:10a6:203:51::16) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Mon, 13 Dec 2021 15:43:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0694a999-99d8-4acd-1bfe-08d9be4f4f00
X-MS-TrafficTypeDiagnostic: PA4PR10MB4400:EE_
X-Microsoft-Antispam-PRVS: <PA4PR10MB4400733FA79C41E79248D3E3B6749@PA4PR10MB4400.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wRhi3Y4e62iATNx6jZTK+PL3WzxfZF9kbrXjs8dpBP2Af3fkvyb0GjWRe07asqi5aCLIEvq1wUUDH4CIR8vZEdDFf49K4YDBeTL9Exggzl6KctA8dJM6GBqYZulOLp/ZS4zNVEsk9DNGRFrJjy/HdyyHu5rSiR783bSRMAcZEaVQpUhRilnFqnw0NgAuQxidiNBG+XRBZj3oJ+hNsN+/JrzPD+UB2/y4UlpFOUDtEq6n6BKFhVFSqHoyR5JPd9iuHMN2h3+HQUG0XUBWLIPcJNtvnJzKp7+/K/gqi14SiWINxES6uS9oP9l95vc5jCBJ8FJyM9Al3RXsqVtr96eAUWSatNKAtO+LiXwX+Z/sS9Llf/IHXNTF2L1rM3aiThXDqPg3j4MHhYkPTzm6ZJ4zWJ0+VTmXEMX4P3Z8jLQ51MtPnyxNUUZNswx8U32kIZ0nkET6V0pPDYdd07Z3pnosznUI5jGLfe5Kr48G9s2bpCEpM/yUlQ6Ar6EvOzRTTytGPH3pwAxERsbWrY5AU7XwZlP2VzpQMKk1W6X8RiKcU/SPh4ME4AeuLEdD6IhgYjDgo5+rtNcmA7xSE1y4OH3jFf1NNHOnVY61bHRd3pKfiD9tc+T6vQsr/Vi8dsI32mOGugyAdkGjE/5P49LwF7NYDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(136003)(376002)(39840400004)(396003)(346002)(316002)(5660300002)(6496006)(6916009)(8676002)(2906002)(4326008)(54906003)(8936002)(1076003)(66556008)(66476007)(508600001)(66946007)(86362001)(38100700002)(33716001)(6486002)(9686003)(53546011)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFhXMzRVYUpGU21BMXFCS1JHQmNSa0hGQmhnSWY4SkpPQ0RCbnB3Vm9DZEtJ?=
 =?utf-8?B?Y3REa0dZMEVlUm5KeVRHcXIrTWl4NkVITExQbm1WMHg1cHEzNHYwbVJDbHBS?=
 =?utf-8?B?YUVhVC9WUEsydDhBL0grN1pNK0lRbmMxTG5qdnFvcy9TeXJrbnZ4eEhHemk3?=
 =?utf-8?B?Q1BuYi9hbklDK1RpVjZsK1JGa0VoalJyODJlenpNWEF4aVUycGxZaWRvZTNI?=
 =?utf-8?B?Um5sa3RxN21CeVo0TGtVV3VlTlhzbG53UkM1MVlKZ3JCaWxWTk9KQjFOSk9M?=
 =?utf-8?B?a20vaFR4aFdsTFV2NnI3WmNxcTZpRGNJQy93dHdpSG9CeTh6aHlJTXNGWWtm?=
 =?utf-8?B?SFVyemxKZEVuTGFORTljV0V0aC9EbnV0RWlXb281cUxoQ0g4dXBWWFVPSDJT?=
 =?utf-8?B?MlNnYTZRL2V4dEpNY0JUWXZvRWhZS0xKNSs1ZHdLK2ErMnZIU0hoWm5lMmFP?=
 =?utf-8?B?c3F0UW1ua1R1OE83VGs5WDZLbkJ4bjRxK3RuYm8zeVJJckNRUEVUWWx4MFRV?=
 =?utf-8?B?T2s1UzN4K25GNC9kb1Y0TC96emgveDBzZW55Y1JaZGtIS1dtWXBCUVpnd1l4?=
 =?utf-8?B?bnRnanF3Y1dySzFyODgvTEpvSkNnN0N5bG9rU1ZKSjhLS2dGcmE5VlgyaDFJ?=
 =?utf-8?B?UDlGTCt2cHNWSXovbHFmZHdZRHRMeW5zQVpBMVpCdDMvUWJMQldZTEszK3hq?=
 =?utf-8?B?L2FkQzkyNnFlMVJlQlpiQy9qdjkyQUNYMWE0Y1hVU1U3L2p5ZEk3R1h5NnhC?=
 =?utf-8?B?QXcxeGpKUjNiNlR4VlJROEhNVWJFY2hmcXJiQnlCZDVNTDlVTXJTUmxoSXdq?=
 =?utf-8?B?WEU0dkcvZmhEa0h6K0tnL0R5UGVHMkNXMnVKNCtBTEJhVFQ3WlUxYmY5YWta?=
 =?utf-8?B?bS9mVmVEN3RjRG1tZEgzRklyRXVSRThwTFJLNmZoTkVIbUFEQjEwNitnL0hx?=
 =?utf-8?B?b3lpY0RPSlhDTUJMc2N3NGZQRWxPWCtPcUNjZjdSTmxZZDdrbWxIbklkcThZ?=
 =?utf-8?B?NFVyaG5IWUVCWFk1MC8zN1FGZjlUNnFSdkhWUEJTWEJUdTJYZHZ2V2xzZDUr?=
 =?utf-8?B?aWpOYlNhSzQ0Wmk5OXRGRXdFcEl6ai94YkNXcUN4VXVJdUdIa2pnaUkvTmpI?=
 =?utf-8?B?RXNEMjE5TWRLM2xlQ3d4dFBwZUVBNDFXcWxWaFEvMncrWm9GYVRJN3dwS2th?=
 =?utf-8?B?eUEwTHduQVpXRlZ1QVlTK2ozT1pQOVdwMzU5cEI1a3l1YWZrU2grMnFRUEtE?=
 =?utf-8?B?SVQzc2xPWlVvOVdXS21sOW5BeGtNSlgvUWV0U2NqK1A1emRpRnlOcXdnS3N0?=
 =?utf-8?B?NFFuK2M4V1M0N2d3QWh1b2RHQ2RDcEh1ZVRlZjZVdURkSTNYMTJPMUdUUU9m?=
 =?utf-8?B?T1NPcE5LNlh2WDQ0QjdDbUZCOVBNNWs3dTM3SXhjSGFENXFtODUyK0pRUzU1?=
 =?utf-8?B?aXRrZVc0MHNNVGs2blE2dGFHZmo2a0wrU0E2OFVEVUg4RnBiNnd4bHorMTh4?=
 =?utf-8?B?QnBUL1drTUduZ1lvaWM0Yyt1UFZKNjBoWWNvWk1uMitFMTdXM3VBQXdsNGNh?=
 =?utf-8?B?SnRwcTdCNmkyd1ptaDdheXA5U3QyM3E5QWx2eUFMMVlkZWdNeEV4Nnh1cGEx?=
 =?utf-8?B?aE03VDBOdHE0d1NGRURqaFk1UGtyOXM1UTlUQVZqVnVtRXhPaElpTjE2SkMy?=
 =?utf-8?B?MGUwMytab1NXa3NXNEdSdnloL2FzRjd0YmZ1TEJMWHdHOEtYYjU2bzJpM3Y2?=
 =?utf-8?B?ZVV3d21VNnBGQWpZZk1SM1Zvb0ZnQ2VkZlVDQSswQ2I3cHY2dldqMk15VHp2?=
 =?utf-8?B?MjhDVmFjQTMzWjhmQUxjWWF0b0xtVmpzSzNrdnIzZGpTUEVabTB5NmxoOVhE?=
 =?utf-8?B?dExZZmNVYjdxZDVENVVZVjVVanNJS3BzR1JuYXZ4VXhnZDNpV3gya01lR09h?=
 =?utf-8?B?WjNXZDJyZWY5Rno4R0JHYmxwd0NMSjNGTENMYnNmdW95Y3czOFVsY2poQnZl?=
 =?utf-8?B?MTEyYjJDWVh2aHQ2ZFViRmNnbktQNzJrbFFubTIyeWZHVXBGVHdLZXBBYlg5?=
 =?utf-8?B?WlVEbVYxeXpNaUdLNytoQlBOR28vT29GNFhKR2praVl1SFVOdGxFOXdwaVpF?=
 =?utf-8?B?djlibE5YTEpTcG5CZXVzMHVnVHhUekRaWHdENGhTY1JwRG5ZNDRiMXIxTTdz?=
 =?utf-8?B?L1QrL0wyV0RLMzhLcXpsdTZhSDBTSlpXZkFYZEU0ME5MYzN1WVNIajJEQlRl?=
 =?utf-8?B?cXVPTXNoa3BQMENMOHMrUmNkTmF2NnppbStqYXNpWXd0L2hQSktMNDlyUVdh?=
 =?utf-8?B?V2hCVExYWGNXUW13enJUTDFJYzVBSlVtcGg5Y2dCa0JKTUZxeTBVdGt3NGRM?=
 =?utf-8?Q?DHP5aP2No7pshcFA=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0694a999-99d8-4acd-1bfe-08d9be4f4f00
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 15:43:28.7891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VXYeWcsJYM/op66JYbavuWPaTmVRxCULvgCs+7CKynRfQGlL4BDVw+tCiNOZCtslH+DkFv31tr7gkqEmsDC97J2eKv30wVbjjt932AXzr3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4400
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13.12.2021 09:27, Eric Sunshine wrote:
>On Mon, Dec 13, 2021 at 5:22 AM Fabian Stelzer <fs@gigacodes.de> wrote:
>> On 13.12.2021 01:30, Eric Sunshine wrote:
>> > check-chainlint:
>> >+      sed -e '/^# LINT: /d' $(patsubst %,chainlint/%.test,$(CHAINLINTTESTS)) >'$(CHAINLINTTMP_SQ)'/tests && \
>> >+      cat $(patsubst %,chainlint/%.expect,$(CHAINLINTTESTS)) >'$(CHAINLINTTMP_SQ)'/expect && \
>> >+      $(CHAINLINT) '$(CHAINLINTTMP_SQ)'/tests >'$(CHAINLINTTMP_SQ)'/actual && \
>> >+      diff -u '$(CHAINLINTTMP_SQ)'/expect '$(CHAINLINTTMP_SQ)'/actual
>>
>> If I read this right you are relying on the order of the .test & .expect
>> files to match. I did something similar in a test prereq which resulted in a
>> bug when setting the test_output_dir to something residing in /dev/shm,
>> since the order of files in /dev/shm is reversed (at least on some
>> platforms). Even though this should work as is I could see this leading to a
>> similar bug in the future.
>
>It's not seen in the patch context, but earlier in the file we have:
>
>    CHAINLINTTESTS = $(sort $(...,$(wildcard chainlint/*.test)))
>
>which provides stability via `sort`, thus ensures that the order of
>the ".test" and ".expect" match.
>
>I think that addresses your concern (unless I misunderstand your observation).

Yes, thats what i meant. I didn't realize $CHAINLINTTESTS is already the 
sorted glob. Thanks for clarifying.

Personally i find the initial for loop variant to be the most readable.  
Ævars makefile targets could be very nice too, but especially:

+$(BUILT_CHAINLINTTESTS): | .build/chainlint
+$(BUILT_CHAINLINTTESTS): .build/%.actual: %
+       $(CHAINLINT) <$< | \
+	 sed -e '/^# LINT: /d' >$@ && \
+       diff -u $(basename $<).expect $@

i find very hard to grasp :/
I have no idea what is going on here: `<$< |` ?
