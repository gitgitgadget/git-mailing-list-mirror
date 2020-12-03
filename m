Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824ECC71155
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 08:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3826820C56
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 08:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388302AbgLCIVZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 03:21:25 -0500
Received: from mail-eopbgr20095.outbound.protection.outlook.com ([40.107.2.95]:16452
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388286AbgLCIVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 03:21:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBUMe08krzNxcxGQ7esWQ4U3CAn3B8lBLLU3pl8FYMGV2b2ZrOgcHRROMZrWnJCpRXMSyOWMl6oAO/vi9LMDoK0q3z+nqiYEdww6B2R/C9648Rf0neh8OQB1XZAjMVk1zjAZuTie8BA0rFGwk38TiA9qX8bjXRoPELi8H7BZSLcR1Kz4ZlpZeX4nEgc5PP+rk8ZxT91NhQ7c51X48+D31X04xhhXzsZWcn89RLk+yZeEW6/1wdp1HkOAU8wgFufcVCA+0MxDsod5JcOT2YHVgd4eixC3nZcqJTRFMA7rhpIsYzk32XWQx4cuwSn+9d5JS1Gstd3Xttf2I0cK/7capw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqRnZ7OdVhRaGi3lrBmFxYD4ExqnIPNcENKLRz0uUS4=;
 b=laxmc18KRIeNFMAgxebnc58RgwllvxGJsEfQpnvm2gBy+T8W7Gmo1KJAXmLO5w/r/hA2sf98MLExcNao6+9LJqCEWK88BHuxgPMtYLdsQuaQ4pPPeJPW8SHxF9eFlR8n82/gcL2Bv3L5D537ejiKyFMQGUeHHfHV9GV4JgZCC8fLvOb3su9decS6IA4sXSSr9hbSrltN+LmTFvkxNdQ8UTyp47dplJPl8dKbycaiCZFGZqd5a+/vUaVnJOQ8KZVOngj2QMIorRmPTr33QUK5SNbE29VuvBbZCLHiGtbl8uetA7TE2i1qteMDI1G+sSX68vXmlnyeWGH8Jg/GQGkjvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqRnZ7OdVhRaGi3lrBmFxYD4ExqnIPNcENKLRz0uUS4=;
 b=TEYb7WpFYofoyAS9eWwiriBIRwmP9o6kVrwJwR1Rc9hAiYVUHhBgAfuCbphq6a1VQeON3EZFhHOTDKXWUcSdtT4mpmW0lL3jP5aO9mQMasQpRr/PUOHRDAcH2shjx4Xhj1YZsc0EDVZPWqheyd6AkROx10yhjKspdR94wU59+zM=
Authentication-Results: nokia.com; dkim=none (message not signed)
 header.d=none;nokia.com; dmarc=none action=none header.from=nokia.com;
Received: from DBAPR07MB7030.eurprd07.prod.outlook.com (2603:10a6:10:19e::21)
 by DB6PR07MB3398.eurprd07.prod.outlook.com (2603:10a6:6:21::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.16; Thu, 3 Dec
 2020 08:20:35 +0000
Received: from DBAPR07MB7030.eurprd07.prod.outlook.com
 ([fe80::fdb3:2e1c:5565:9860]) by DBAPR07MB7030.eurprd07.prod.outlook.com
 ([fe80::fdb3:2e1c:5565:9860%6]) with mapi id 15.20.3632.018; Thu, 3 Dec 2020
 08:20:35 +0000
Subject: Re: BUG in fetching non-checked out submodule
To:     Ralf Thielow <ralf.thielow@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <CAN0XMOLiS_8JZKF_wW70BvRRxkDHyUoa=Z3ODtB_Bd6f5Y=7JQ@mail.gmail.com>
 <CC0FA973-E37A-4BD3-B5A2-1436DD8DF16F@gmail.com>
 <CAN0XMOKEG9HLuzf9ZRXyUs_uHTXagyCdghtP98rLVoPj_75UYQ@mail.gmail.com>
From:   =?UTF-8?Q?Peter_K=c3=a4stle?= <peter.kaestle@nokia.com>
Message-ID: <034d340f-ae62-2c22-3c6c-c9b14e0de662@nokia.com>
Date:   Thu, 3 Dec 2020 09:20:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <CAN0XMOKEG9HLuzf9ZRXyUs_uHTXagyCdghtP98rLVoPj_75UYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.228.32.168]
X-ClientProxiedBy: HE1PR0202CA0044.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::30) To DBAPR07MB7030.eurprd07.prod.outlook.com
 (2603:10a6:10:19e::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.30.9.8] (131.228.32.168) by HE1PR0202CA0044.eurprd02.prod.outlook.com (2603:10a6:3:e4::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Thu, 3 Dec 2020 08:20:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c115abbe-975c-490d-7049-08d897644f5c
X-MS-TrafficTypeDiagnostic: DB6PR07MB3398:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR07MB3398ABF486A574D063D2D12DEEF20@DB6PR07MB3398.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: btMSMi1JEJjZwxTCEh1uksUKq0tIQhD5mURJoQO/v7OyCYvYnZwMrRjwDNPm8eZCNRtgxzsYnPUxyiPUOZYTKQJ95TTPhxW36D/ghjz+3sCk6jvKgMucNmTkJNb1GhsDt76fjsSpep6rt/wNJi8eC486FVW/SWkg7+rkyTxtVa+th3Yx6GEjBSH4ybu9ExmOCIr1YQyRJ5CnXQMk6YAZX1i63uuqCN0AMcUG2sTYVISMuNaTkoR53VH8XGISuTre5+d7ohWoL5O2diVvaCdi1YF5Eub8ZqcabrCAWHrEkdeDYVd3H5NaEnOh8XzGHC/a+PdiIooMTN9m74TcguC7errTmStWF5DsIFJ0aZuKxO6Dt3AGRFNLokBrsrjqHF7akIY1Lrcrt8z5v/tD6QOJ/LvuYpJL2KKj1ZBaBBPXiqg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR07MB7030.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(6666004)(83380400001)(26005)(186003)(2906002)(316002)(36756003)(52116002)(31686004)(8936002)(16526019)(53546011)(8676002)(54906003)(16576012)(956004)(86362001)(4326008)(110136005)(6486002)(31696002)(478600001)(66946007)(2616005)(66476007)(5660300002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cDlOS2FWR3dIVEVOeitaQWNDanhCdVQxWndqOWJUNVl1alhxNUorTWt0TFZa?=
 =?utf-8?B?Qjk4VGdXVkRWL2N4c01FMXRwangyRWdrTGh6VXRqVjY2TFpIZXBiWFEraFBi?=
 =?utf-8?B?STFkTGRhUmdNcENKR2tKOHlaa1hNVEtuWURXSHA1R1dMN3BpTW9MbFZOa2Qz?=
 =?utf-8?B?SzliSDZRU1dFbk45R3BJelJjMEhNNmsrWXlYc1dCOFNCb0luSFpxZFhxZml5?=
 =?utf-8?B?WHB4N3Y3enE3dy83ZW10NUxjMWJQVEp6eTF6a2FEcU1tWjUwK3M0ZWV0NzhG?=
 =?utf-8?B?cFlvOXBKQ2lSL25NZEU3U0swTVBzREVtSXFxQUZqWjFoclVWWnZ5MC95bS9l?=
 =?utf-8?B?WDhXamprOHRmTVFqTHJWeWw2SnovS3M1cHpraG5MTHV3eHRyU1JuNkZLNlVI?=
 =?utf-8?B?S2gxb3BaY3RZTE9kRWF6Y2h2MzQ1WFYwUnBFa1JoQjJRSkM2YStJd3c0OVR1?=
 =?utf-8?B?NVlzQk9oc2VGU0NKTHNQNGxkdXpyMkUvQk1JL0kzamdpbVVkNmtSTEFmUzFk?=
 =?utf-8?B?dHdUTWs3M0tBc1pwTUN6NDUwZ2RuTCtOKzB1Uk85Zk9lc29iK1VSaDF5ZkR0?=
 =?utf-8?B?Y1VVZjNVTW1hTFBjem9WSzZIdUs1amJmLytKSDlDOTZJSTJGNXlSUEFGQkU1?=
 =?utf-8?B?cHU4dFphVjhnQW13WXhLQXZlNjRZRkxMekpaY3FQdTFSMi9aNnhxdituMUo5?=
 =?utf-8?B?TnlRNElYVTNMRm9OKy9NdEhvMjNoNVNzdUI1MTVqeG5mUGErcnpiaVI1Y1pP?=
 =?utf-8?B?S252Q2ZjYXUxL3JraU5NUHRyNis2dEN3bHJiS0luQkZTeEJTckV2M29NaTcy?=
 =?utf-8?B?a3l6bFJzcEI2TE5GR0p6MHQzMEpTclBra3d3ZjhxMG9kNjFTd0dCaVhZQ2xu?=
 =?utf-8?B?Yk1pS0h3TjUvMDJJN3FtL3FoUHFUL3ExdXRUNXRuU214OE04bTUxNFBPS0RD?=
 =?utf-8?B?WmdWc2w0djR3R2t1ajRadDBEcXpMbVZLTDN5b08vU2JrbFpReC8vd2tYOG8z?=
 =?utf-8?B?czVsL29XY2xlSENQZWc1VkZqRkV4SzRTaU0vUWtaNGFUbVpadUNZYVJsWDF1?=
 =?utf-8?B?S3Z1MDBiNXd5YmpHcWFaZEczL1ZyZStJMkdtb1A1aGRzS3M1M0t0dGlXVWE5?=
 =?utf-8?B?RFJ0eGtFK3l6anlXNkk1aTJjRUxHaTU1Q2RTa0pMK2x1R1dmR21KZFFaRFVu?=
 =?utf-8?B?OUUrZGJBTU15cGhDajFJa0I0akRQcFB6YnREZTY3d3F2ZzA0bVMzcXJTODhn?=
 =?utf-8?B?elNDcXRNL3FqTWUwQzQ4VCtrOFNsTStTbmMxQ3hPWEtkVWVLYjAyMW5MWGoy?=
 =?utf-8?Q?UtWAKi5XOm/9Wfk7qMhdvZeaXEbNKNteL7?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthSource: DBAPR07MB7030.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2020 08:20:35.5712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-Network-Message-Id: c115abbe-975c-490d-7049-08d897644f5c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: roUDO59qt9IX5Ft3X4APwj2BaOVqL7U6bpih7T4XeJZX8dGd4ZEb/Kra6SvEx8IGVRtItoY0PVWqoMYvdNq5xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR07MB3398
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ralf,

On 03.12.20 08:45, Ralf Thielow wrote:
> Am Mi., 2. Dez. 2020 um 18:20 Uhr schrieb Philippe Blain
> <levraiphilippeblain@gmail.com>:
>>
>> Ok, you don't add '--init' but the submodule gets checked out,
>> so it looks like you have 'submodule.active' set to a pathspec
>> that matches 'sha1collisiondetection'. Did you clone the git repo
>> with '--recurse-submodules', which would add '.' as the value of
>> 'submodule.active' ? Or maybe you manually configured that value
>> in your global gitconfig ?
> 
> Sry, I did not mention that I started with the submodule already
> initialized and checked out. IIRC I deinitialized the submodule with
> 'git submodule deinit -f sha1collisiondetection/' and ran 'git fetch'
> to see if it happens on the git repo, too, since I encountered the
> issue on another repo first.
> 
> I can see the same misbehaviour when I run
> $ git -c submodule.recurse=false fetch --recurse-submodules
> too, so I think it doesn't have necessarily something to do with
> the 'submodule.recursive' config, but with 'recurse submodules'
> in general.
This is interesting.  There are several testcases using 
"--recurse-submodules".  Have you tried, whether any of these trigger?

-- 
kind regards
--peter;


