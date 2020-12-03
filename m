Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D9AC64E7B
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 07:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CEB320C56
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 07:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387402AbgLCHzp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 02:55:45 -0500
Received: from mail-db8eur05on2107.outbound.protection.outlook.com ([40.107.20.107]:51474
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728177AbgLCHzo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 02:55:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHu2KVB9u6LqzjYpEDC6cPlFteOAzbWy9v+PuhYlKQknX3hSQEdN/lo58zjRY/e7WTrEbtDqXiRFuVQvYRXvoAuxPhPdUy9Tkr502LdK5VuL2bd4SXUJK2fFT7Y29HLO/Wcv+gFEkEg5GYGhglsBt2/ItKm7dANfFTJP/d+/03kRe6QqhfgYGH64U/Nvb6LyxytAoP8hl3IHKIg2YNBvKlC/75v69SDGSDNrTayMfGAKEBitEt6K2IfGBhrbTp54B89cwfrXFKSFZuCs5GQxS8iizZPk5PW5PrnnR8U99t3ff72e29XK/d4ld/C6xcfReYNa8BVX5jKKmCqwjyvmGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJTs6GdIk0huTsxcKCips+MJRMnaQu2m2iBd9Bnt2CY=;
 b=N2I+aSxU2BISbnPfGn945vhEojm2azUklNy7DnWK48B9jxnxEGAB07TmMDyOBvd3RWrn3iUIFd0z3nJ/2zx+CWPh/cAa37yQ2frrF6/nyHXFzcUEUi465WYdJw/u1aYpMhMLl/RzOytysm7QJuand1nhheXNFRX7rsyoZNXrgqo0QKPPhNGkwfOXpm6yaWNcUG7ab5CrihTPAH3McfeqXBse4ykl9hId781slN348RKGkW4FQ9Tj4vlPRfcj+keWfNSwHxszwdpYHgYPNGMWelIKIXrk5BDtXs2nzJw9xVTL77719FLdK0VRE8QRG0uBjZIZinQ1p8veG4V8xqoM3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJTs6GdIk0huTsxcKCips+MJRMnaQu2m2iBd9Bnt2CY=;
 b=kQtsf2WHSJqm07SNl5DnNz1gxJPAlSerr50MoUrQErt2CoJ22E+NpTwncKbncBSPS+VhfE9Gnb+WGAky3e/R6iWUwdiAS5zHSmmaUzGej8B4ltRTF80Tn0bKZ4hASAjMBgViK9Ic667psZ5GgfCOLF6Vdh3SeG7KouhMMhRmyrE=
Authentication-Results: nokia.com; dkim=none (message not signed)
 header.d=none;nokia.com; dmarc=none action=none header.from=nokia.com;
Received: from DBAPR07MB7030.eurprd07.prod.outlook.com (2603:10a6:10:19e::21)
 by DB7PR07MB5178.eurprd07.prod.outlook.com (2603:10a6:10:60::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.15; Thu, 3 Dec
 2020 07:54:56 +0000
Received: from DBAPR07MB7030.eurprd07.prod.outlook.com
 ([fe80::fdb3:2e1c:5565:9860]) by DBAPR07MB7030.eurprd07.prod.outlook.com
 ([fe80::fdb3:2e1c:5565:9860%6]) with mapi id 15.20.3632.018; Thu, 3 Dec 2020
 07:54:55 +0000
Subject: Re: BUG in fetching non-checked out submodule
To:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
References: <CAN0XMOLiS_8JZKF_wW70BvRRxkDHyUoa=Z3ODtB_Bd6f5Y=7JQ@mail.gmail.com>
 <CC0FA973-E37A-4BD3-B5A2-1436DD8DF16F@gmail.com>
 <xmqqzh2vkdu8.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Peter_K=c3=a4stle?= <peter.kaestle@nokia.com>
Message-ID: <04968f5c-c8bd-c57e-d646-7c9f7691e1a8@nokia.com>
Date:   Thu, 3 Dec 2020 08:54:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <xmqqzh2vkdu8.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.228.32.168]
X-ClientProxiedBy: HE1PR0901CA0062.eurprd09.prod.outlook.com
 (2603:10a6:3:45::30) To DBAPR07MB7030.eurprd07.prod.outlook.com
 (2603:10a6:10:19e::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.30.9.8] (131.228.32.168) by HE1PR0901CA0062.eurprd09.prod.outlook.com (2603:10a6:3:45::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Thu, 3 Dec 2020 07:54:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dc9d66e4-4bb9-46c4-44de-08d89760b9a0
X-MS-TrafficTypeDiagnostic: DB7PR07MB5178:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR07MB5178B19BDD72295F9AAA7BA6EEF20@DB7PR07MB5178.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F4RmjwpBkTd5lZquPyvAHPr0Yy8XBk74Y56Q+XeDw8c0uWwOYSoPGgaoS0vXxC2X9IUiKB9eBP1dp/mKuxLfzGJPJ0H3jgwG8K7hZhh1YEFe38v8RciZpGtufw1I7mF7+BQW9J0iYiCpEyhbmkCqQHlvTtBwuYWF9S4a6XtTHRtvRIES0rUr/ERo45Lo6DNmTpAbi4oCcChwdJSjYX6Ckm4cgQOy/l+dMy3UF2msnDS1et8djVTh4mELueDQnZaJi9eYLhz2x/B/eb+ylLg6ceQNbv6OdR/CUBrpKsscTMBQAUGPCug/flMOJ7o8Zfm7z2/rgxpqZTGSzymA1lcbW2u1cHrIRsKmOED4LlT1Vn6EK0VI5rOub7LmzVJ9DDcTsx3CZv2c35IyqKRMcGbA7qvxBaKtUWOtCkoBy9iPOwsnnGgXv5vh1h4gYAtKg1l7SEOmv4Rlk2eNJjXBtepr6zi0x/wfAG+TT2g1/YusSo4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR07MB7030.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(16576012)(86362001)(8676002)(110136005)(31686004)(66946007)(4326008)(8936002)(66556008)(316002)(36756003)(31696002)(83380400001)(66476007)(5660300002)(6486002)(186003)(26005)(52116002)(6666004)(4001150100001)(2906002)(2616005)(53546011)(956004)(16526019)(478600001)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TFNlSEhTdExuelFtMXRZejhvS2tuUzVhdStDZGlSa0U1NlRsTEhQMFNnWEVu?=
 =?utf-8?B?K0ZjUitWTUZHYVdQT1NZMFU2dDI2Qk1LRTFFTDFoVC9YOGZWdU4wMTBnblFT?=
 =?utf-8?B?cGJGL2xFcFExTVNPU0Z4eHpqK2xYMUJlcjZXMFZtNkxGaStGOXJMZFY0ZlFl?=
 =?utf-8?B?VVk4STBpeUhYaDk2NjhoNjhOVFJabkhOb3VaZ3g2cnUwOUxrejdPL0grWG14?=
 =?utf-8?B?d2NRbnpvZE85UzVsRTNGNURFVFlkdjBsQ3ZnZ0gxcFNuQjduaXpSS0lVTkxL?=
 =?utf-8?B?YUFtR1ZyWE1wUDJ4RWROYnNJQmJTYU9pMm1NbTdOUjYvNHpoVXA4cldWV3Vs?=
 =?utf-8?B?Y2pPbjllUERJRjhyeDRUeTZTM0gvdUNUUlRZL3VvQnNIckQwSlI3TGhpNFpE?=
 =?utf-8?B?cEM2R3AvQzlLVmhBNW84clQzTDBuaHJQcWlWemtmbjdTV0lzZ1czeFBDTzNk?=
 =?utf-8?B?aVVEbFM0S1NIR3E0dXFxcHNIenBCMjdWZ3FXbDdydVk3eGoyUkhXaTFDblNa?=
 =?utf-8?B?bUxiOTRVbHNOV0syL3Z2N2ZVS0JlK3pGZk50VnEvY25xSitzL05pUTlZMnhk?=
 =?utf-8?B?Q244cGFPcWlHcU93cEFJaGR3K1h1dkFPRThJTml1Z1pXc29LWEF0OUVxVDlH?=
 =?utf-8?B?aVc5cVI4MHhSOElCblpVOVJVYVFCSm9WUUVkSE03Z0NHR3VZSkM2cTMxa05N?=
 =?utf-8?B?bHFtTTcrVHVZNVlKVWIyekVOSTdzYi9PbFNhUXF6cC9iUFVkUEsrczdPUXFm?=
 =?utf-8?B?RlVTNlY1ZDJBMnJIZjBCeS8wb2FhT1VwbjZ5L09hSWlnRmQ5d2RsMGJYcG1K?=
 =?utf-8?B?dnVkaWVNN0JWLy83Vmt4TDR4K21XcEVPTDFrWk9DaEFTQWtQREZTdndHMDZq?=
 =?utf-8?B?R2YvakFDdW01UmtnUlQwS1dJQjRCMzNtRnFjbDNsR0FrbVhwZUZwZ2c1alMv?=
 =?utf-8?B?UUdlUXhYWCtqU21rMDl5NzQxSGt0UU1kSmtmV0o3eCtlOW5rZHk0QU9sYytC?=
 =?utf-8?B?Y2llMzY5MXNtc3YwWmxFUFNIRzcyRi9wZk1MQ0lOTHhCdU9CNmRiVkRlV0Vx?=
 =?utf-8?B?T1pXRG5DWG9HaHBobzAyQUV5WXIxL2RtWlc5SlhtQ1p0MmEzNkFXYk9PaEt2?=
 =?utf-8?B?c3NzSVpyd3c1REYvWlFkNjdnNE5iZGFSWDdEVzNxcUMzUXRFNWlhMWR0aUFU?=
 =?utf-8?B?OTJiNFBwOHlXTzNyVmd3azBLOW16VS9wUlZ5RVY3SDN1ZHNlQzdhMnlzd2VU?=
 =?utf-8?B?cHA0M25USE85V09TR2RCOGNYYzZnVVZqRDZseFpBY0RqUEFhYUNqUTBPK1Fp?=
 =?utf-8?Q?E9fnJ1JROjHk0D9befvmMyBEaMCkhzwYOt?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthSource: DBAPR07MB7030.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2020 07:54:55.9211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9d66e4-4bb9-46c4-44de-08d89760b9a0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNukcbQ6ZGQ1VAwlVLp7WFvGri6ImyT7IroKna2R0v1qRgqHHs3t6XVOlCLt9QHY4usM0vzJK+l95bkONcOABQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR07MB5178
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 03.12.20 00:06, Junio C Hamano wrote:
> Philippe Blain <levraiphilippeblain@gmail.com> writes:
> 
>> Thanks for bisecting it. That commit wanted to fix a different bug
>> related to nested submodules, and the route taken was simply
>> reverting an earlier commit (a62387b (submodule.c: fetch in
>> submodules git directory instead of in worktree, 2018-11-28).
>>
>> As you discovered, it breaks other scenarios.
>>
>>>
>>> $ git version
>>> git version 2.29.2.435.g72ffeb997e
>>>
>>> $ git config --get submodule.recurse
>>> true
> 
> I think the current situation is probably worse.
> 
> As a short-term fix, we should revert 1b7ac4e6d4 until we can come
> up with a real fix, probably.

Junio: This is why I originally intended to commit the test case for the 
testsuite separated from the revert and wanted to start a discussion 
about the actual real fix for the issue:
https://public-inbox.org/git/1604413399-63090-1-git-send-email-peter.kaestle@nokia.com/

My proposal would be to revert 1b7ac4e6d4 and isolate the test case 
"test_expect_success 'setup nested submodule fetch test' '" make it 
"test_expect_failure" and apply it instead, until we come up with a real 
solution.

>> Yeah, I think the test suite could make more efforts
>> to run more tests with that setting turned 'on', but
>> it would require significants efforts since it changes
>> the behaviour of several commands.
> 
> I am not sure if the question is about amount of efforts.
> 
> A configuration variable is there to change the behaviour of
> commands, so a test of a command that has been running happily and
> producing a set of expected outcome with a configuration unset
> should break the expectation when the configuration is set ---
> otherwise there is no point in having a configuration variable.
> 
>> Meta question: is there an easy way to run the whole test
>> suite with specific config options turned on ?
> 
> Hence, I do not think it even makes sense to have such an "easy
> way".  If the "fetch" command, for example, is expected to change
> behaviour depending on the value of submodule.recurse, a test
> written for the case where the variable is not set should produce
> different outcome when the variable is set.
> 
> What we need may be a better test coverage.  submodule.recurse is a
> later addition, and all tests written earlier do test how the commands
> behave without the configuration being set.  If one wants to change
> the behaviour of these commands when the configuration is set, new
> tests to specify what the expected behaviour need to be added.

Can we start a new test suite for tests on which this variable is set? 
The case of Ralf can be used as first test case.

Ralf: could you please send a command sequence, which recreates the 
required repository setup from scratch and is able to trigger your 
observation?  Then we can convert this into a test case.

Thanks.

-- 
best regards
--peter;
