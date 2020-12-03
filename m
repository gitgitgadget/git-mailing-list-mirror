Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB0AC63777
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 09:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 792B421527
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 09:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgLCJoc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 04:44:32 -0500
Received: from mail-vi1eur05on2098.outbound.protection.outlook.com ([40.107.21.98]:23662
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388316AbgLCJob (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 04:44:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRl5iLHOcTdVadik6FcvVpxWuaY5TQlc9D5sGl9AVvVSPnpyhrbDYtp4TnfKHJ4G2b2vaV+92AgYBegJIUfsydcat5mp5v8LdoDQ0zaHJb9Ui9JxbqsyFu1jdEzw4xItV2Lkw6GsFvZMs/JQZZrWbk8OiqXDtCtmYFogvplusZjq1TLlEaZbbYZkI0rJm1zQFP26Zce9GIq2NAmZsPp5z9Z1qTin/5PQUsMD0//m2c2ZZMOj8eCl9UVvWX1XGpWPtopMj+z0ugNverF/unkTBIQEkmT5T8Z/m5o5UGOKiGy2hACfji/B/4nEZr7toAbcumg+IZecjAp4AICFMXV8kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IHVZ37nnnYgvA+clpOu12wlzseQRSHcV88cD/OCTn0=;
 b=jX0wQiK7o5yywyXXU2vDX/RMbqbLGX2qL/czn//p6mQF29eYFbE4k9d+yz/NrBlYbHr2hkNCMbvOyDxfT+vPL834qwd5KcxZmfNS12dckgbFY9aWK84HbJNJTu4Ig0uBDEZ8iFzGMhjDkaotveqoLFF0+2+BWg/wyizcZGMponTZefd/yEDfcwXwcfc6shYFgmPUON8CX54x6y47d72+AO9/GciqWw/NKhjAg4LurnRAqZKKrlBz0Rm9fgC/jEpmXbmLQkFE1vFOdbW94VgOH1dZxb9oljUQEX+m9ubHYTT9VyNC0lcZO2tP3ETko6FkhVBj640FjVwlaIvZkWNsaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IHVZ37nnnYgvA+clpOu12wlzseQRSHcV88cD/OCTn0=;
 b=cgV3ZFUmopHQZs5L0pxP2v8DlKVPXgk9I0nxJnaGVzFBgV25yYn5ELsGMd2s1MBGxgTCmLMA0MHqdwB7UIiy3gUxNCiwnUUhZQvZuCDvSKZP8zjSizahPZlFbywPCeOMhG3DqxTv+iSuqGTOUTGA7z29VGKcbFYuEjDkw48rRTo=
Authentication-Results: nokia.com; dkim=none (message not signed)
 header.d=none;nokia.com; dmarc=none action=none header.from=nokia.com;
Received: from DBAPR07MB7030.eurprd07.prod.outlook.com (2603:10a6:10:19e::21)
 by DBAPR07MB6981.eurprd07.prod.outlook.com (2603:10a6:10:17e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.6; Thu, 3 Dec
 2020 09:43:43 +0000
Received: from DBAPR07MB7030.eurprd07.prod.outlook.com
 ([fe80::fdb3:2e1c:5565:9860]) by DBAPR07MB7030.eurprd07.prod.outlook.com
 ([fe80::fdb3:2e1c:5565:9860%6]) with mapi id 15.20.3632.018; Thu, 3 Dec 2020
 09:43:43 +0000
Subject: Re: BUG in fetching non-checked out submodule
To:     Ralf Thielow <ralf.thielow@gmail.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <CAN0XMOLiS_8JZKF_wW70BvRRxkDHyUoa=Z3ODtB_Bd6f5Y=7JQ@mail.gmail.com>
 <CC0FA973-E37A-4BD3-B5A2-1436DD8DF16F@gmail.com>
 <CAN0XMOKEG9HLuzf9ZRXyUs_uHTXagyCdghtP98rLVoPj_75UYQ@mail.gmail.com>
 <034d340f-ae62-2c22-3c6c-c9b14e0de662@nokia.com>
 <CAN0XMOLHM0mFvXcdiXJS_yD59rSTuyJpp9N9MLvcZ5LCC1-yZA@mail.gmail.com>
From:   =?UTF-8?Q?Peter_K=c3=a4stle?= <peter.kaestle@nokia.com>
Message-ID: <168be31c-f913-4bda-cf05-adcc07c51ec8@nokia.com>
Date:   Thu, 3 Dec 2020 10:43:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <CAN0XMOLHM0mFvXcdiXJS_yD59rSTuyJpp9N9MLvcZ5LCC1-yZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [131.228.32.169]
X-ClientProxiedBy: HE1PR05CA0342.eurprd05.prod.outlook.com
 (2603:10a6:7:92::37) To DBAPR07MB7030.eurprd07.prod.outlook.com
 (2603:10a6:10:19e::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.30.9.9] (131.228.32.169) by HE1PR05CA0342.eurprd05.prod.outlook.com (2603:10a6:7:92::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Thu, 3 Dec 2020 09:43:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7a278892-f0f1-4f8d-3957-08d8976fec70
X-MS-TrafficTypeDiagnostic: DBAPR07MB6981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR07MB6981EB149405D007AABB41A2EEF20@DBAPR07MB6981.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sHZ+CVabfHZyUc/YJH0lztCLwYUpJz7DoQy89SUwWJCCHNQkWfy0Dv1TRAwsQvAEtft6V3vIscuvrBwXYt7PaSaqdTOKaDmwaFYb/XID75G5A1Astx3sfUlWjymXDOQQNLlu30A+eiXWWFKV/gZ3HcmRReNXfq6wXx3s7PL3mddyI8kzcRMM7sKprk8RuASsQMReMdZ4eFOlf/wb9rW+u1YvNQYKpTWMxktr0xLrP1inohDs1JwqtiaLuvAlsJruJznTJlGZvHyYYNBbbMbhw2gGgf2ORpsezTJrMkZPJ3rQDIM/XiR92goA87PgXL53W9uI6LJwMV21T4UApOcm5XQklrBkUforLnGvLcUyYw6IzI9Gkq8p+GbOinMUrjhzXpmrGDMkX4+w0PVPHJHs0K/ylZVXEcLiE7RioDnnFHE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR07MB7030.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(2906002)(186003)(5660300002)(8936002)(54906003)(16526019)(4744005)(26005)(6486002)(8676002)(16576012)(53546011)(86362001)(31686004)(66946007)(36756003)(6916009)(316002)(31696002)(66556008)(66476007)(478600001)(66574015)(2616005)(6666004)(4326008)(52116002)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RGIzY3RCcFFzUmZpNy9UcURlcnJRdkphZVlNYXVpOXZxK3U4SDR0ZEppaFJj?=
 =?utf-8?B?RCsyTGQ3bXkyRVVBaFRzVjZjWVd5Wlp5c2JuYWovbXhjWjhFTU81emoyTlJC?=
 =?utf-8?B?MzI0V21saWFFK1RVbjRMNDE3cDR0dHFHVE1kMDBmb1F3YkFOY1B0NjRsUlBK?=
 =?utf-8?B?OGluRWpzUEIvNktZVFFrS0FpRXYwUmw3SzNHbmhDcktRRGE2SG1JSDZ2R0pw?=
 =?utf-8?B?KzQ0NUt4VzRwSlgrSHRCN3pTcDZFVzZHQUtrc21pTkZ3eHdQWlNUNERZZnNv?=
 =?utf-8?B?dVp4aUoxVzhWMnZqdGpEY0UyNmlKdUNSNm91K0tUbHRjalQvY1ZxNndLbUdt?=
 =?utf-8?B?UVNxZ3M5Q1dXdnByZjhwZW85SEYzSDFCWEpmbE9oU2tLL0JVazhFOFNzb0JJ?=
 =?utf-8?B?a29qR1ArdjhXaWJ5QUJ3amdGZkUyUmVVeW1zNTdaalNQTHl1YXd3Q3lBZW02?=
 =?utf-8?B?bUNKcVFRV1RxT21Bc3JxVWZKTmJBKzl1cE1CTk9qRitpZHBGNEN1b3c3MEFq?=
 =?utf-8?B?NlNZV2FpZW5UODRPc1ZsaVRVNXdhWldtd1NNWDN5dStUblY0VXVnU011RElh?=
 =?utf-8?B?NHpzSFRpOU90VFZXeGRXQ3JGczAvY2w1U2Y3SG0zUnczNFNNclJDRURoTVB3?=
 =?utf-8?B?UFJjK2RHSURLQ0VjRHZTam8xNFV4N0h1NDlHVi9YTEFTQ2tEZTNFZkNiL2Zj?=
 =?utf-8?B?QTFXTk9BQlRGS3Y2Nk9YV0l2d05kOEdDL2J2a2h5V2ZvSFRTdU12T1ZTNFgr?=
 =?utf-8?B?UkJ3QW1CQlptZ1VKaFM2bG91VjRzeXJFaVVqcFNaQjhGWWZRWWtkS2lNRHRz?=
 =?utf-8?B?eE02amQ1QmRHbGFDK0NWalYyNUVHT1ArTm9JVWJ0c2N5QU5HZExsbHcrK2lV?=
 =?utf-8?B?QzNjdzVOWXl0bGd6NG1nYzFUOFpxUXEzWEpuZjROdGdMV0MvTnI3VGtQU1pj?=
 =?utf-8?B?aW9GWVZpZ0VvNXJmNlBFQlV4U0NDeU5EQ29oTWU5YXhNTEh1K3R1d09tY01I?=
 =?utf-8?B?SzdnMnpaclo5OUdjTVlxc2xoVkZsL3piNGlPandJNzZ2NlIxUEtuUTVjSVkr?=
 =?utf-8?B?Y28wVm1WNWU4enlpR3pKRVNQTDRYeU1SK3NBRHFrNXhUWnJ2SVVPU0s3eUFC?=
 =?utf-8?B?amZMUmJLcDdFWkFVTTcrakxHRjE4dHVKc01HUzJNWlhIVkZlK0Nldk14VVox?=
 =?utf-8?B?M3NLekhNZlZBdk9CV0NPa21FS0dhSDBOeCtvRm9JNGEwOGtLQVlBVTBzYTJE?=
 =?utf-8?B?Y2orY3NTeW5yc3hiS0hlcXNOMG1wNUlHbXhPdWROL2Z4Q1hiL2JNMy9FcUk0?=
 =?utf-8?Q?DswCHfMCkDr7w3suO5LRt8eQTuPP8JcKrM?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthSource: DBAPR07MB7030.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2020 09:43:43.5731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a278892-f0f1-4f8d-3957-08d8976fec70
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/iJHIUmyjhTxs0hY0MCEGBzdo+WaA9MzxERxGqXrhpZ9KP3hAxrTB0ljLSJXHVTfaYJV2tBnYuyfXhC+DSZbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6981
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ralf,
On 03.12.20 10:38, Ralf Thielow wrote:
> Hi Peter,
> 
> Am Do., 3. Dez. 2020 um 09:20 Uhr schrieb Peter Kästle
> <peter.kaestle@nokia.com>:
>>> I can see the same misbehaviour when I run
>>> $ git -c submodule.recurse=false fetch --recurse-submodules
>>> too, so I think it doesn't have necessarily something to do with
>>> the 'submodule.recursive' config, but with 'recurse submodules'
>>> in general.
>> This is interesting.  There are several testcases using
>> "--recurse-submodules".  Have you tried, whether any of these trigger?
>>
> 
> The test suite passes.

This is what I experienced.  Thus it is important to get your case into 
the test suite.  Could you please send us a command sequence how to 
create your repository structure from scratch, so that a test case can 
be created?  - Of course, if you want, you can also create a test case 
on your own.

-- 
kind regards
--peter;
