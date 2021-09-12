Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6555FC433EF
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 15:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 388DD61056
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 15:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbhILPIo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 11:08:44 -0400
Received: from mail-eopbgr10056.outbound.protection.outlook.com ([40.107.1.56]:59271
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229653AbhILPIn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 11:08:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHYMbewBLOY3QlnX0aYvcQNNK5hXViOAUJMbv8mQjwiRODM1FGSDxQXm+H+u0f7Q/QdcnKzHHcKi00qBI4n7YIt/wrTT0imVu2/7Um37KGSqQjbraBOhftnAAjL+1Yn1ETPuS5ZkDhNs6APJe0ymAseJIBqhu5uFmGLTLxz4VyS+buRMJ8TC8gfcw3VTj8gDM/R3aYpWjQdey1/oJMlVNhUna91styyt1OMJDqO/7G0U4EIqlB//xCEVYzcForRyhNoMu2rxz+PH8DaR56PN3jwWPA9Nquxj6hrSBw9STh18gaREAb0YDeLdbgXmsFvl5lMKCOLgCzR2IUuv1XdLCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+B/FcyOnZMhcJ8NzgClggku9xYoPLF7IVG3KMtLQmBo=;
 b=bJMRb60g4Nrdhemvft9ygMYRK8dGTjoGr6cYQDPrl1ScI8Fx/YY33YYawtl9dyS2bCFkG+xcf9LoUhibDMQ71jGPRuy7OuWeHLS0l/5IvFTUdRAap+fifyMdQgziHFM3M4n/q/L40cPqVin3Z1KeSdz+aGPKmcNP6wQSmYlE63CIHeVpiPq3n/OtHY+rHE9KUWn4gpUY3aoYlfgw5PTuzoWGIFkpKpjwD9DKqW6Sq+eja3G/7+i5TYsCYAjuAwgqH11tMAz3Oy1G2HM/X9oTm5fnp7X/fgJ8ZoW7WO52Ajb9k7Hr3J7tjnPzkPl+6axkRZvCtSXgPKHyYCCOkwy+Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+B/FcyOnZMhcJ8NzgClggku9xYoPLF7IVG3KMtLQmBo=;
 b=WQEy05H3ggwP5Ybj5sQxInRhfdVnVMUK6YPF2exNNVNMTkPX1N7IYGNCoa1+5MWlZhQYfI/0qPoiqKy/tEJMj+e554uZmvue2l4b3iCB3k7H9Y2uCk6xIH8uKvUMJwtwHY7JQq2FpZz3n5hqV+4RJeXeo9lo/LaWZtQUsxq9Y4A=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4858.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:1de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Sun, 12 Sep
 2021 15:07:27 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4500.018; Sun, 12 Sep 2021
 15:07:27 +0000
Subject: Re: Question about timezones in commit & tag dates
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>
References: <b39aab0a-bf53-9e33-59a7-d4f1a06e72a7@gigacodes.de>
 <87fsu997wn.fsf@evledraar.gmail.com>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <b121acdf-354f-c896-d2f6-b221ea2443c1@gigacodes.de>
Date:   Sun, 12 Sep 2021 17:07:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <87fsu997wn.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3P191CA0035.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:55::10) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:178:20a0:d22:c58d:d0a4:a83a] (2a02:908:178:20a0:d22:c58d:d0a4:a83a) by PR3P191CA0035.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:55::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16 via Frontend Transport; Sun, 12 Sep 2021 15:07:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdd497a1-787c-419a-8d5d-08d975ff087c
X-MS-TrafficTypeDiagnostic: PAXPR10MB4858:
X-Microsoft-Antispam-PRVS: <PAXPR10MB48589426D05DD1ED528F4E91B6D89@PAXPR10MB4858.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4lLMZtkyqsnptldYDVXw2Ypbig6+IxkSGA6RiHTTyo6gvP3n2MEQ74ro0y8XLuAPWqxe46eBOuTCpNk210ZeXAzk8uKCouoQsmx5AqpBYlPmHw+AWnlTMqfXg22F/pMupZavLNev1xLf3ed3vmRdIq6qNtAq/H4ujqlhaayztdYeiWJtdIZyV58glAuzphhSi1lxHaaqk9CsIPGtj2rj9IqbSgXckW4oYItJdrPyBCyAh9/VXvYkd9NZI1QQfN9BmrBRRJJdkxf/LpvizrjPvYp8zTx/Te0A4hpJK+yJCTOEQnWQ3fmOznNI7LOOkAYPcJW26TuOsbIjTW+cu+vECNt3sSiMfbP3ol1WuopxZWDm5SgryxVkb6jl3okeQMLeqhEBcV+YEWUnaCdXC9o92oYJcn09jZd2IkX/W80u6x1obZltA8Bg09Bgha3nYmut+padW0frFHo2R3sDaGC/dANxAoePawFZUz5Ls9uV93GdxwhUUvr1BOI5U/i2KMQ81o4pcyElhys5Lp7UlSy9Kcf0P16XWQC/OfBXZTcQG6eLF3XCMnwWztERdo2W/O1LwFJOvJzI3HdWUK0IFe3lV96QewpryhpmKx2fv+3ImtR3sB1p5xOtdX4c040ZU3Lqe5L25pVZRjIw2AoHFmogDiLuV52NAQQIhccXLTPn4tXh6JEp0Mj02Kfw1H7881ArqTWqQaZiwXxGslqo++N+ZS09W3QHlxeYgJX4Qbd0+As=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(376002)(39830400003)(396003)(478600001)(8676002)(6916009)(36756003)(31686004)(8936002)(5660300002)(2616005)(86362001)(4326008)(53546011)(38100700002)(66574015)(316002)(83380400001)(66556008)(186003)(6666004)(66476007)(52116002)(66946007)(31696002)(6486002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWs2Z21ueXBDTFJUMzloU013UVJkdjZEZ3hZeit5U29kY3hFRDlVQ1g3UnNs?=
 =?utf-8?B?VkZ2N2U0U3FLYWw5cEx4Y08zV29PRzh0TEdMckEzbDg2bEZkbUJRWktHNEJ5?=
 =?utf-8?B?RkdLSGVUVTI5eXIvR3dSWGN3RFVaZ2FkWnBSOEVnVlIyV1Y2NGk3SGpMTkd5?=
 =?utf-8?B?bVlRcC95aUZlbWNOSGpHdXZkZ0p5dE42SHl0bEM3cnhaaHJlUFpidHZuNzNj?=
 =?utf-8?B?RVhjTEVyQ2s3T2FlRTRiZ2VteEU3bW1hUEsvRUZ1eGF3YU9aUThUZ2RyNVQ0?=
 =?utf-8?B?OHpib2x0NGRoMUFuRUlXaFVQMHhINXhHNmNvd3cybzdyaXc3ZFNXQ1YzMVcv?=
 =?utf-8?B?cy8wZkpGNVFCM2tFdUdaNXhhSU40UFNVQ0QzVmVHUnJUTVIrUWdlZUdQZkhT?=
 =?utf-8?B?UDRZVitpWnBkcVY3cllPaHl2aXlRc29XZXo2SlNEMDMwVjJXbVpBWTBIRWp1?=
 =?utf-8?B?UE1zckE5RUtjRjZkMjNVK2hRdWlnY25qYU05UE5pU1JqK29RZ0RWMkhCWHFQ?=
 =?utf-8?B?RnhLWGlzdWRkblgvTnl5dSt5YlIrUTFuMVp1NHBTdXk0N2JBazc0aEM4Tlh2?=
 =?utf-8?B?YVNmZ0dSa3VlN1FnYXZNbnlNK0U1Tk9GV2dOc2ZsSDJMVVdCa1F3TmpGY01a?=
 =?utf-8?B?Q2x4NzdYZnBsNU91Vlo4QW1kMTZwamNYUTRTcFlUcGU4bGdWTCtyY0txN3Bi?=
 =?utf-8?B?TzFnakhYdzhEcGFRMUVZU2xxOGVjZ282YzFoTHo4UUhXSytxZ1dZMTVPU1pQ?=
 =?utf-8?B?aWtKaG1DMHFYTVkrZFc3dWVBN2ZET244VUdoVTJDY1d1V2ZoSjA4eVB3WC8x?=
 =?utf-8?B?cWhURGI1eDhoR2VnaEhnVkppclI4czZ2YUkyUzJRbG5jbFAzUGtpVEdFWW9X?=
 =?utf-8?B?SWFIQ2xNNTNmL0NvRmVMdmR6WWpvYVpTb3QwWUF5NGZTTEpjSkZDdUtiWHU1?=
 =?utf-8?B?K0xxa0h3T3BXRlo2dWhSTkduTVJ2YWlnRGVmYmpqMVZYVzBIOVpWQTFmanJh?=
 =?utf-8?B?dHlyV3VENUZUZmhzalU3c1NzU2tYSUxySStNQjJiSUpYUlhuZE9WWjBLZUxZ?=
 =?utf-8?B?cXZEcGtaSno4cUswRW04TE1lUk5wbzRiWWtYRldZdSt6UzdacG82UzllSlA0?=
 =?utf-8?B?TjBJMjBsSUt0QTBHbm84eHpmd1JPMHFJUU1NV2FQQnlON2dGaUlocVdJRS8y?=
 =?utf-8?B?TEJIcGpZZUV4RFN6ZklGQVNOelFuTGRoWXJ4cyt3MWdMRC9FTlJpVFpmclBw?=
 =?utf-8?B?Ly8rT3BPVDFhMjFBRDRPMGVJa3M3VDE3WTlCWmFRSUlBQ1lnNU1hbC9taWVU?=
 =?utf-8?B?MWNxNys5MzZVaUFsRXA3MUI2eEEvWkdSRE9qd24xdHpXdUVvOEJ5ZXJKQTdz?=
 =?utf-8?B?MDVUVTRoWURia0VPVFFPWXdyQnZCeXZhQzlSMEhlMTlBSUZvbFNEYitjNCtu?=
 =?utf-8?B?azZWT3FMWmJUVys5eDFwbWRMZCtiRTE0QTEyUFJsYjBOM0FuZUlVY3JHRUR6?=
 =?utf-8?B?WDF2WFBMTDRydEVTczF4a3lCTnpyOVIvT2FkdU5rdXE2Y2xRSjFwcXBYSkU3?=
 =?utf-8?B?Nys5enVFcTY2MTdZK3JXWXUxQVZydUtGMWZQL0lRVHhUZHo5MS9TVHovR210?=
 =?utf-8?B?OC9acm1ReU53ZFl3WEFOY1BLR2JuZ29hYmorUXB4TlFTZGk5aFg1NGMzUU16?=
 =?utf-8?B?OHI1K3R5V3dPaHlaL0liQUpxalVGNitxMWNWazNtOGFSL0VEcTYzTENPenZm?=
 =?utf-8?B?QllUNk96Z1VIcy9ESHFzdmZTc2xtRVFDRldPUzc3eURxV2dHaFc5ZUpKL1k4?=
 =?utf-8?B?NE1nWVZpRmNGaGJjaEUxNW9DZU9aVnY1Z3hXVzJ6UEIxT2tOMUtxUkErM25G?=
 =?utf-8?Q?ZaQMDSWRRhc4A?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd497a1-787c-419a-8d5d-08d975ff087c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2021 15:07:27.0002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3SCVuCrYx3tGm8PaJAIz9teavIpadELcDqyU01ymdiNotPrwSozcuCLgOoRh0sWkrhauojk45QhLsoXeRJHjr+N32Q+1Wv4F3rt7FjCoLh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4858
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12.09.21 16:21, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sun, Sep 12 2021, Fabian Stelzer wrote:
> 
>> Hi,
>> while working on correct key rollover and verifying signatures for past
>> commits for the ssh signing topic i am trying to understand how Git
>> deals with timestamps for commits & tags.
>> For ssh signing the user will manage expiration times within their
>> allowedSigners file. Those timestamps do not carry a timezone and i
>> would assume a user (or automatic generation of this file) will assume
>> the systems timezone for them.
>> Therefore i wanted to pass the commit & tags timestamps adjusted to the
>> system timezone to make sure key rollover will have no gaps or failed
>> verification's especially when commit and system timezone differ greatly
>> and might roll over to another day.
>>
>> However the commit & tags structs only seem to carry the objects
>> timestamp as is, simply ignoring any timezone information. For the ssh
>> feature i can easily enough parse the ident line again from the object
>> header. But while looking at the usage of the existing date fields i can
>> see that objects are sometimes sorted on and compared by these dates.
>> When commands provide cut off times (--since) i think they might include
>> or exclude commits erroneously when they were made in a different
>> timezone around the cutoff date. ("log --since" indeed gives me some
>> unexpected results when mixing multiple timezones. Based on some simple
>> testing i think it just stops output when a commit falls outside of this
>> window, even though there might be one before it wich is within)
>>
>> Is my understanding of this correct and this the expected behaviour?
>> I think generally for git this does not matter much. But in certain
>> situations this is problematic.
>>
>> I would have assumed that git would either add the timezone as well or
>> adjust the commit timestamp upon populating the date field in the commit
>> struct to UTC but i could not find anything like it.
> 
> Timezones are ultimately display information that's confusing to humans,
> but not machines. Machines just need to deal with epochs, or when a
> human supplies them a date convert a formatted date + timezone pair to
> an epoch.
> 
> So in the key expiry case, I'd expect that any such system would say
> issue keys right now, now as in time(NULL), and we'd set those keys to
> expire after some time, say 1 day, so time(NULL) + 60 * 60 * 24;
> 
> If you're in UTC that might yield a very satisfying (to humans, a
> machine won't care) expiry time. I.e. you'll get keys issued say at
> midnight, and expiring midnight the following day.
> 
> What you're saying sounds to me like you're conflating the two
> things.

You are correct. I somehow thought the stored timestamp would be in the
specified timezone when it is not. The timezone is only used as
reference for display.

> Anyway, maybe I've misunderstood you. I just don't see how something
> like key expiry would need to concern itself with anything but
> epochs. If you conflate timezones with that and say "here's a key, it
> expires at mindight" surely you'll have some keys last mere seconds,
> others 10 hours etc.
> 

The ssh allowedSigners file specifies key expiry in a "%Y%m%d%H%M%S"
format without any timezone information. So i have to assume the systems
timezone is used.
But correcting my misconception of the stored commit timestamp i can
simply present it in the systems timezone for ssh to compare it with the
specified expiry date.

Thanks for your help!
