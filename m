Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22A3C4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 08:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6793F23A5E
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 08:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgLHIsO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 03:48:14 -0500
Received: from mail-eopbgr140114.outbound.protection.outlook.com ([40.107.14.114]:4998
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727882AbgLHIsO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 03:48:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XS17Zm5jP8qtf6Gf0urTlQSag6C17OcTT+s/ct74CJ2nzOlZ9/+3XlnM9qoI3FqvSdXTTQnP5pwi8JC8rWz1nVGuiW0ddTC3JGQc/jXptOm2sjvfW7su3ipAT/01mTIh2+6KIg+oIe5qdg3lN/XKAv1uQwyE2++NcATUvR1FsP78l2D8mPLWnb0705F1208Nc7NTTd9QsBJrd8nfboHhlX0O/YRhqrt+sIaoNP2aDECCmheC7TcPITYEyTRPQekVMpL75d/UnEO1FIywFZUM9H1tjzL8nVJ6kgMT9M7D2p82xy3kFnHJINLHH6jEX5vSL32ywls8cmXeYabuwcPd+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pv/9htxZfV+iapPI0djcxYHzX3+zC0StzWCWQvlUr9I=;
 b=Iwp07tSD3ZBK2mMVfLZvTlDUPhLTePkKKeCP95/VyLIFXRq6kXLFN2iXueihfL+5RHQqPe+MKGBKN/plvVutYVXHIJ0k6mMkZW5XlVHQ/3ud1xipgro1CFQSFwEROP/5fKHq6Qam4xS7+TRUExwzE4CR+D/xQNwkq9CMb65K+yf1YPYrkc9u/8r80DIEInNbpFa9HGLAHbb64WtrdBpS11ABRXdCVtV5djpgJS03f/tel26PCyOXJJm4Zj7q2gCm4hj5N5HxT6vfZPFgp449bkjKGEGsvAt/LVDoaPHHwBcVnL3OYYttCXHmnps0/KDgsMctoaaitpD0sTgHx03WMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pv/9htxZfV+iapPI0djcxYHzX3+zC0StzWCWQvlUr9I=;
 b=j6Tdom+AAknw4uojhO4ocV7osPUxJ8PufQ1GLA+07GgydC4GApXu+IdvwS6SrZcXzUFGg1Ei4CO/VAzj2QRYjD6mvT/E87VN1a6+qib0d7PmfR+7WoZr5xxbUT0h7SDtz4nsQOSpqgjNb8aIeu3PF6Ki8bXtylbX8ObUh+9t2Ko=
Authentication-Results: nokia.com; dkim=none (message not signed)
 header.d=none;nokia.com; dmarc=none action=none header.from=nokia.com;
Received: from DBAPR07MB7030.eurprd07.prod.outlook.com (2603:10a6:10:19e::21)
 by DB7PR07MB5417.eurprd07.prod.outlook.com (2603:10a6:10:7a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.11; Tue, 8 Dec
 2020 08:47:25 +0000
Received: from DBAPR07MB7030.eurprd07.prod.outlook.com
 ([fe80::fc22:a9ab:215:7d1e]) by DBAPR07MB7030.eurprd07.prod.outlook.com
 ([fe80::fc22:a9ab:215:7d1e%6]) with mapi id 15.20.3654.011; Tue, 8 Dec 2020
 08:47:25 +0000
Subject: Re: [PATCH v2] submodules: fix of regression on fetching of non-init
 subsub-repo
To:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.us>,
        Ralf Thielow <ralf.thielow@gmail.com>
References: <CAPig+cQ8VC2q4nuzgM9QxmddH4cMezbZdRZDxX1PqfW6XKcC_A@mail.gmail.com>
 <1607348819-61355-1-git-send-email-peter.kaestle@nokia.com>
 <613FAD04-0D5A-4DE0-8FE8-0C5C5619B7BC@gmail.com>
 <xmqqpn3l9zce.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Peter_K=c3=a4stle?= <peter.kaestle@nokia.com>
Message-ID: <539b840a-51e7-5105-061b-64a7bfdee06a@nokia.com>
Date:   Tue, 8 Dec 2020 09:46:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <xmqqpn3l9zce.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.228.32.167]
X-ClientProxiedBy: CH0PR04CA0087.namprd04.prod.outlook.com
 (2603:10b6:610:74::32) To DBAPR07MB7030.eurprd07.prod.outlook.com
 (2603:10a6:10:19e::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.30.9.7] (131.228.32.167) by CH0PR04CA0087.namprd04.prod.outlook.com (2603:10b6:610:74::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18 via Frontend Transport; Tue, 8 Dec 2020 08:47:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4e22a2f7-28bc-454d-dfa2-08d89b55e2d1
X-MS-TrafficTypeDiagnostic: DB7PR07MB5417:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR07MB5417F9F9CA2342C71EB52A3FEECD0@DB7PR07MB5417.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5RNM31HTcH3c3odCWQNRqX02dO1ZeS9x65np5z02CICffF5hAt4ZL08FGP8+XYZKHooLgOpHVq1g+wXSm9CMVSa0tukE/XqhdJb+Qdhc1HBKFoHb2C84YEstMIFSsc02gSegBOx0AxMdh9SeoNjSRNzBjc0bJ+qRsEKEI+pjY0764U9SGiAbL9v0JWt7zQWnAyQeqI0tzmExrgjCnba6Jvm/qkgnocgsNHWddxmhurJ6M5KGlECAEVmkgDpcivfPnmwO7Lcr6iJmDV2fSOpQilLw2iefq+/QI+g9qMoUPzTkVRl+L3gX0ZszIDQRBSV0mVroY7hbqbI5iy15ggWky6YCnt1rI3xf8v/TDcBqnBdiFEX3AvmMfJaid8080FfQc+iCdvZDHqC9B5Ykv/sMgGVtpDfnyAAvnVs87j9S/2zrkzgYTeYDFw2QZ4FK7TX6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR07MB7030.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(346002)(8936002)(26005)(508600001)(6666004)(956004)(66946007)(66556008)(66476007)(31696002)(110136005)(54906003)(52116002)(34490700003)(4326008)(86362001)(6486002)(4744005)(2906002)(2616005)(5660300002)(16526019)(31686004)(186003)(53546011)(16576012)(36756003)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d3V4ZUdRNkJWUnp2NEhsQVh6SlNxOGxGMUwvV0NsRHpxRVNUUXBMUktIb0tm?=
 =?utf-8?B?SFVsL1JSOFFGYmtUcU5IOWx1RkJ0K1B2UThhNjhGS3M4VEdrdFFNU3FYY25G?=
 =?utf-8?B?SE0wRzdXNGNGMGVFV3FHYnEwR1orRHdaV2hid3VUT0FhcVI4YVZveWVmSVVU?=
 =?utf-8?B?UEROWGhtREdlQ2dUdmU1MTZkRzhmUjhWUnJrOXZoV0NPa21WcjVyNW42V1Zh?=
 =?utf-8?B?bkk0d0lQNTZ5QlB0NG1FYkhPckI3Tkh0OHpadzZYQXM3enp6M3luK2lyMTdz?=
 =?utf-8?B?UkRjWThhLzgxWGVnT1hEcGxxMk14ek1aYWxRSDdWZ2ZyK2poazFmb3FMcVBR?=
 =?utf-8?B?c3J1NW5vTTE0WG1yK1RzOTU3ZzBFclFnV3R0L0dGZ0c1a2NiUG9ndHpnSWNN?=
 =?utf-8?B?KzNvQ2tRbE5USitZcXlVYVZEdkZGSGN4NjdYSFdMb2N5bnM5clhBRHlrNW1Z?=
 =?utf-8?B?REIxZ0RGZ1FxNlN6MEdoc3YxT2IvRHR3Wks4NG9oeVp3VWhoS2kwOXRvN3BZ?=
 =?utf-8?B?dVFZbmUyUEpjVnJXSWZlMElydThiNXJVdXFsaWtVMlcyY29VVy81WHRmd0Nn?=
 =?utf-8?B?SFRtclRuMldCVytpMHdiRWlka2l5NVkzZ2JobStPR0Q2UHVTQWtKWHlCVDZL?=
 =?utf-8?B?MG1TbWdvZmIwTmdmMWNwYSs1UDBhaWhOc1VIZURxWlVEdnEwYmMzU1o2RWpK?=
 =?utf-8?B?SkdNd2hEVmtmcVV6aTROUFZsMk5YSHRxSnFodzRxbUplSVkxQlUvWkxramxF?=
 =?utf-8?B?N0pET2RrRmVjQy8zZkR3Tis2WU9zcUg2OWFIaGxUbEh3N3dTbmFzenJUSGRI?=
 =?utf-8?B?ZU9ZdUFObG04OVhqRW1QUFBqdVBndVFCcS90d0lzdDZVNUpKQy9VaG1xbGx2?=
 =?utf-8?B?YzFlUms3akNOak91RVAzQ0hmNDd4Sm1aMnJiUFVVV3k1R2htb2RuRGptMkdS?=
 =?utf-8?B?YTcySWZXclFIYjErZTdRYUo5ZU9OS2lISEdmRGlSV0djSlkrK3RaWlVlMEZp?=
 =?utf-8?B?MVdYazJoNHZSZ2ZWUXJVcXpqRWt0SW5TcGt6Uk1uaWorRHRKR2c5WHVPWWFT?=
 =?utf-8?B?eHBOTHdWVXFsdjgzOXRzMFBtOVR1bUNTbWxEYTlLMXNzZ2xZSkRXZnJKMUor?=
 =?utf-8?B?elhGdmptOXRCczRQcy9BbmxpM1J3WnhJbEo4UEk4UTc5eWw2TnBRSGYyQWl0?=
 =?utf-8?B?Zm81NEs1ZWtRTjFGNG1XNFVzSDlHTWZIaDBiVWRrQ2hQWHpXem1qdUV5d0p2?=
 =?utf-8?B?bDlGRDFzQVI4U0UxcGpadG5KZXhHVW5TNkduMlBueXFTVVc4Y0R1bUc2RkhE?=
 =?utf-8?Q?mT2RD9w0V2fcgk30j9tYW0oyiPwV59kI1w?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthSource: DBAPR07MB7030.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 08:47:25.1919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e22a2f7-28bc-454d-dfa2-08d89b55e2d1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5cQH1qJOjStCQq+/k21UWDiGqgpy/oa/ms/JViMJlEF2dxNtk9r6gjos8nEBM0O3fiCkoqr/XzW1hXK3t0wvbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR07MB5417
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 07.12.20 20:43, Junio C Hamano wrote:
> Philippe Blain <levraiphilippeblain@gmail.com> writes:
>> Thanks for working on that, and sorry for not having the time to comment before
>> you sent v2.
> 
> Thanks, all.
> 
> It's not like we corral everybody to a single place on a single day
> to work on a single thing.  Reviews ov v2 by reviewers who have not
> seen v1 is totally expected and very much appreciated.
> 

Thank you very much for all your comments, they're much appreciated.  I 
prefer spending more time on it now for getting it right, than to take 
another revert-rethink-refactor round.
It will take me some time today to work on them.

-- 
kind regards
--peter;


