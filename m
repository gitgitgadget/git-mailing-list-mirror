Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA6AC4361A
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 15:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABB29206A4
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 15:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgLCPLb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 10:11:31 -0500
Received: from mail-vi1eur05on2100.outbound.protection.outlook.com ([40.107.21.100]:63201
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726805AbgLCPL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 10:11:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYiMdmr7Pg7BgrfY2MWcy0sXs4Op2m97fMiy64Zi8ibQWFqGGZ+HZfXibdP3kxFzMYsLVV5bmgowKZmAPs/pSzvUg9TDvCZqcSI/0sCxu57KAjESpW+Oi3ISmLq8Z5Jf3ISxAh82w58mrbBwkyTnkGfRpsJZYj6chM1ziRROGxBmTIPeBfla0Pz8h+RgyGL99HEDF9zvTBSwv27sz1L4CqnbXo3i6HWs03KJc5ffRrkdAloDL7isGcNrhOW5H59Ky6P+fDyMi++TlqEODwgXlFQsfo33Qobdzl0BJUYFo4+ILxohss8qYgogbGWEprMhKun6+EXqe1Su7XHD0cWI+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuMx3VxF//qfe/qMqUjUPDQ4rJWvo4mDNLbNyJghz6w=;
 b=H4DViWK7AFk4w/BSNkDo4k+g5u/Hj6Uc9lwY5aPKpup4+sJdrJCWtszkSYogkF6VCsu1/OpXd7olarEiCL5JwjA4j9QPld80F39dCvWwEs4tX58QNZSvZA/zG0oLq65PSQh+fawF7xTsty50FRFDdj6nXrvj1SHZpwkVNrOs6USJVMmUtyn5cMz73ILKsWuduPw0aEq5Qmxb2r+bkscKfrR6vhnh9zk35IhmTdTp2pJy4uqXsCeFeX/2LMktCBwfuIdpJuTuVXOgfwWe/6HENxeAdIllf/QRi25aUsjwKBYVLPMlSkJ4eFGBlHLpXrKA9jYYiKmYYoM6huBUn1Y8ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuMx3VxF//qfe/qMqUjUPDQ4rJWvo4mDNLbNyJghz6w=;
 b=lCvgTgIYu0DL+hDiGlxPJsRVme8iPMbAw9DNNMa5omMtrpQB0z8VuDOca87TJkGefEY1492pe8xDhhkR8U8Qg8ELSyML4Uu2lcGt15UkYPAajVd9JQsSDa9vpV/rcdTB2FK8zxUzr1iWWhZelJYVxYQd839WWys0k/6u6NZx378=
Authentication-Results: nokia.com; dkim=none (message not signed)
 header.d=none;nokia.com; dmarc=none action=none header.from=nokia.com;
Received: from DBAPR07MB7030.eurprd07.prod.outlook.com (2603:10a6:10:19e::21)
 by DB7PR07MB5945.eurprd07.prod.outlook.com (2603:10a6:10:7d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.5; Thu, 3 Dec
 2020 15:10:41 +0000
Received: from DBAPR07MB7030.eurprd07.prod.outlook.com
 ([fe80::fdb3:2e1c:5565:9860]) by DBAPR07MB7030.eurprd07.prod.outlook.com
 ([fe80::fdb3:2e1c:5565:9860%6]) with mapi id 15.20.3632.018; Thu, 3 Dec 2020
 15:10:41 +0000
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
 <168be31c-f913-4bda-cf05-adcc07c51ec8@nokia.com>
 <CAN0XMOLdz3bk+wehy-+0_XGLX6722jb71vvzNPXrryeeFuxd0w@mail.gmail.com>
From:   =?UTF-8?Q?Peter_K=c3=a4stle?= <peter.kaestle@nokia.com>
Message-ID: <5869c005-468b-8686-3022-3fa18f28f96e@nokia.com>
Date:   Thu, 3 Dec 2020 16:10:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <CAN0XMOLdz3bk+wehy-+0_XGLX6722jb71vvzNPXrryeeFuxd0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.228.32.167]
X-ClientProxiedBy: CH2PR17CA0024.namprd17.prod.outlook.com
 (2603:10b6:610:53::34) To DBAPR07MB7030.eurprd07.prod.outlook.com
 (2603:10a6:10:19e::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.30.9.7] (131.228.32.167) by CH2PR17CA0024.namprd17.prod.outlook.com (2603:10b6:610:53::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Thu, 3 Dec 2020 15:10:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2c6c3ed8-19cb-48ce-301f-08d8979d995c
X-MS-TrafficTypeDiagnostic: DB7PR07MB5945:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR07MB59458EBAF86604A6C120F567EEF20@DB7PR07MB5945.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l0k/D3ikdjLyc0xxRo51W2zCVP9D3jF6n+qnA/mJnmLreiJZ2CFRMFVS8tluBLbmp6kI9GqEslo2EMSktqEGoHk7T8R+PN2zmmo6IYuJx0qsw18bPmqFrhzroRKnzvbmWnk49HbhpkCeOo7je7ajLqvNqSeGyLzOM/nik7CI45m1gx7oWt953i4zHux9mOGGdezSFyBZklOHb9Om9vaTVVeGwBZ41e+m/YlTk/dzFyq4+HjLqRZmKFiumZ4UJjokImhNW578YphoHRAfU3JC8ae+lE9b4bPPyEckZNZjMxBdU2NUh34wDlbINijVkjHG68yU8yukLwJVTkf17SU5r/F2OHqmcmJxBvHYRsqpqOxY1eK644PtZWHt6OwHPIxX9L1gGy6cbV0KakL0swdyauM2MIH1jIVE6DIWa69Y5Tw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR07MB7030.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(16576012)(8936002)(86362001)(2616005)(956004)(83380400001)(31696002)(6666004)(52116002)(54906003)(478600001)(31686004)(2906002)(6916009)(26005)(8676002)(316002)(5660300002)(4326008)(6486002)(186003)(66946007)(16526019)(53546011)(66556008)(66476007)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VDhqU0VhcVN6OXJtUVBjbkdseXQxZUxodjhCcDh5RTl2ckl2cnBtZEpUanMy?=
 =?utf-8?B?eEJQS1NVdzlyNjBFaVMzTDBlQ3JKM2M5R1U0SHpRdWFBVEYxRVp1bjVybmlj?=
 =?utf-8?B?eFV5MWdsU3RPbUMvVEdZQzF2VE1BNnhYTGZpU2dqVkcvdDdWMXVlMlA2a0hi?=
 =?utf-8?B?WkFBRUY4SU5jYkxzT0lzVVk4SVZrT3Z0TjNZRkowaHovTUE4SngwdjVqWEEy?=
 =?utf-8?B?OTh0SUlMcUdVQXpGVXVmejJxazZ4bnQrcVprZTk1VW5VMThCWlhTam8wUGtm?=
 =?utf-8?B?WGc2Ky9rL09hZDJrNUxObVVHd1B2WTlab1JBQWFJVk1oSURUc1h5Z1N1bm1o?=
 =?utf-8?B?alpuN2o2ZnRPTzdPRWtUdDdwTXI1VmxjNUZ6aHpBS2NDelU5R2FBd3IwSHJP?=
 =?utf-8?B?NUtXVU9OMlBxeFNZYVBnTk8waHVWUjU0NG9lN0hSb1c1R25sQ3NIb2xSOU1m?=
 =?utf-8?B?UkNwZlR0WHNTbGlueFJTS3J5VCtpUTJZTXBJUmF1TGQwUXlDUDVXdWgzZVps?=
 =?utf-8?B?a2ZoaTVFOWNHUmg4TUcwbWFBNTk1TGFiQnNYRXVIcDIyRWtVTFNZZ2FTaTV3?=
 =?utf-8?B?TVk2UFFic2tQNk9lakF2VEZodnlMKzRmL2NXZU4wT3JJaUR4QWEwRktsR0Yr?=
 =?utf-8?B?VFRjUDBSNm1OaFFCZmljQ2JpVXZTbEV5ZE82OVJKdWlSOXZ2VDk2NE96OS82?=
 =?utf-8?B?eW5ibkhTQkppQnB3TCs3WmNJTVp2dVNaS2N1Zzc0WU5aMzdYUDFSSWZWbjNX?=
 =?utf-8?B?Zm5EV1RxWHRZdCsyYitxQmRuSjgyTjJiMDgzTU1IZGFDYXpJSHhwWE5kcndl?=
 =?utf-8?B?UUpvVll3ZmF3c1loRWtmTTlrbFdiWk5pVDJyeXFDV2JSK2ZKaHFxa0xXSjV5?=
 =?utf-8?B?dDZSR0RiV3pWbHg3Wk9DaGticDdvMHFVRXN5bkFOUHcvd0RrTE43ZDh2c09l?=
 =?utf-8?B?NWtzUXhxajk5R0xyVzJwUUV5dzRWblZZN0dGdG9KdUFybUdlOEpVUUlhMGN2?=
 =?utf-8?B?MSswUW41RVRxQVowSzlaUkxYaU1WNVFXV3Z6ZzNrYzJzZlZ1MHhzODhORVFt?=
 =?utf-8?B?LzZiNzM4RGs1TnhmdWw1Y1hDRE1SZEhBVjVibCtwdkVvNnJNTDhoaVZ2SVRS?=
 =?utf-8?B?T254bVphQlluZUt1KzY1QWJmUTY2UDJmZC9yVzJOTk9xUEJQeHZUVzBJdE5Y?=
 =?utf-8?B?OEVRa2tEN2g2WkRsUUtQSjJmR1ZVNVhMMU1rN3pDdGt0VUFpZ0RhYUhxNW9a?=
 =?utf-8?B?WFFuRGt4Y2pzb3lEb1ZuaEdyVEo2eGxwQXhMeG1DQlc3eW1MWEFGUVZDNGhv?=
 =?utf-8?Q?nbM7eiEK9he6cCdhO5xKCwY6tT5evdShZH?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthSource: DBAPR07MB7030.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2020 15:10:41.0435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6c3ed8-19cb-48ce-301f-08d8979d995c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s7Hj4k9gFdRcnGq+YyF/fThVv1IIi4yk20PppPF3NqchGGK8ThoHSsYWy0oYE4HewQ4PHg02xImjYwFZ+PAYyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR07MB5945
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ralf,

On 03.12.20 13:30, Ralf Thielow wrote:
> It can be reproduced with the following sequence of commands:
> 
> git init sub
> cd sub
> touch file
> git add file
> git commit -m "add file"
> cd ..
> git init main
> cd main
> git submodule add ../sub
> git submodule init
> git submodule update --checkout
> git submodule deinit -f sub/
> git fetch --recurse-submodules

With git from master state the "git fetch --recurse-submodules" results 
in an infinite recurse call.

I translated your sequence into a bash script, which can then be easily 
converted into a test case for git.  Problematic was the infinite 
recurse loop of the git fetch command, which I solved by grep'ing for 
the second recursion output and abort using -m1.
Could you please confirm, that you see "passed" for the good git 
versions and "failed" for the bad ones?


#!/bin/bash

testcase () {
         rm -Rf main sub &&

         git init main &&
         git init sub &&

         touch sub/file &&
         git -C sub add file &&
         git -C sub commit -m "add file" &&
         git -C sub rev-parse HEAD >expect &&

         git -C main submodule add ../sub &&
         git -C main submodule init &&
         git -C main submodule update --checkout &&

         git -C main submodule deinit -f sub &&
         ! git -C main fetch --recurse-submodules |&
                 grep -v -m1 "Fetching submodule sub$" &&
         git -C main submodule status |
                 sed -e "s/^-//" -e "s/ sub$//" >actual &&
         cmp expect actual
}

if testcase
then
         echo "passed"
else
         echo "failed"
fi


-- 
--peter;
