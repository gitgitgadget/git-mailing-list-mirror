Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6876C433FE
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 15:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E550D20754
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 15:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgLCPee (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 10:34:34 -0500
Received: from mail-eopbgr60120.outbound.protection.outlook.com ([40.107.6.120]:39266
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726610AbgLCPee (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 10:34:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZmgfZeABSROPsX3YQrMipT0lFs8qb/qak6vF5pwS3IRRHPySbvcEOKR4JsNTVTpeSr0HgXwXyD7Lwu2d75WLeKpWzDQja7/eSrLdw80AZMPsxikfgoT/ea51wx2w1EhhGlViAJgcqXkpwK4GF8lW4YDh67ziYWPri1u9XJ/Dx7bCh564/wtHqoZ9x7y6GFwHl7SBNScCJi+UpVnWcFgb3vUYanBEkyWtB5S4CmRUv8XFSmCQOK98bqLv7q1yqlLMs3hzAyv+y/3Upyt+YaupJOjvFEW779bQmT3j2aRyIOhqjZO0yOdbEHPUx696MSTiDDn1Yo7pyIfCG74vGdESw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8vNLqc+2Ct7jppZW7MZgJKBcEgKvZd+DYMxjbf9a4M=;
 b=eh9cYYIZ3NX4Au8+JKL+/JaJ4xpHF0b3x8HXwtqs52t2uYFqa46UmfderEIA7ifmIPF0Y3MG7qN7A/4kvhOTYzSL50CPJNrraiO5rYoDhLG6nHboZSilqJecg17Hwv2tcTBw3BY2cpNSjUPj9WDyGl8DaHzqP/qqP3PEUBo/0VZJRbZkRbCmY/9pq0xzzBs8A8dEOkIyAo6+z07ZOzaD3As50RgciWLnz67bG6EcSWTUW+VOrCNn8VAAcXdScN+KCo/QQqnHrPU+kZsI3RinTULuNCm+5zg54t5hY6+Uj2EeCxpxCIzUj0ISnVODRsWu2HuK3fplQuElqiz0QmBbVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8vNLqc+2Ct7jppZW7MZgJKBcEgKvZd+DYMxjbf9a4M=;
 b=edE2sIW81C6ZE486/12w2RBbGOyWKbMMw2iU4wPYUba5VR/vYZitnDInO4puqbdEzZ2E8qDR3Ik0qyBy5hSULFo039zEvTzik1+Kc+pKuRsRKEdjLQvzOuwpgLun6F2pSd9XgtsHakQtnbQfN+qWevDgzKomknwmGxnxwOeTStc=
Authentication-Results: nokia.com; dkim=none (message not signed)
 header.d=none;nokia.com; dmarc=none action=none header.from=nokia.com;
Received: from DBAPR07MB7030.eurprd07.prod.outlook.com (2603:10a6:10:19e::21)
 by DB7PR07MB3884.eurprd07.prod.outlook.com (2603:10a6:5:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.6; Thu, 3 Dec
 2020 15:33:45 +0000
Received: from DBAPR07MB7030.eurprd07.prod.outlook.com
 ([fe80::fdb3:2e1c:5565:9860]) by DBAPR07MB7030.eurprd07.prod.outlook.com
 ([fe80::fdb3:2e1c:5565:9860%6]) with mapi id 15.20.3632.018; Thu, 3 Dec 2020
 15:33:45 +0000
Subject: Re: BUG in fetching non-checked out submodule
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Git mailing list <git@vger.kernel.org>
References: <CAN0XMOLiS_8JZKF_wW70BvRRxkDHyUoa=Z3ODtB_Bd6f5Y=7JQ@mail.gmail.com>
 <CC0FA973-E37A-4BD3-B5A2-1436DD8DF16F@gmail.com>
 <xmqqzh2vkdu8.fsf@gitster.c.googlers.com>
 <04968f5c-c8bd-c57e-d646-7c9f7691e1a8@nokia.com>
 <CADtb9DxTgEWfOF7jDGGt3eQSCaaqeiyJfS4V-e0SyPenE2SXWA@mail.gmail.com>
From:   =?UTF-8?Q?Peter_K=c3=a4stle?= <peter.kaestle@nokia.com>
Message-ID: <0b6a34a0-428e-5fc4-307d-1217b112659c@nokia.com>
Date:   Thu, 3 Dec 2020 16:33:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <CADtb9DxTgEWfOF7jDGGt3eQSCaaqeiyJfS4V-e0SyPenE2SXWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.228.32.169]
X-ClientProxiedBy: HE1PR0301CA0011.eurprd03.prod.outlook.com
 (2603:10a6:3:76::21) To DBAPR07MB7030.eurprd07.prod.outlook.com
 (2603:10a6:10:19e::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.30.9.9] (131.228.32.169) by HE1PR0301CA0011.eurprd03.prod.outlook.com (2603:10a6:3:76::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Thu, 3 Dec 2020 15:33:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3dfd3a6d-31c4-44d1-c00f-08d897a0d23a
X-MS-TrafficTypeDiagnostic: DB7PR07MB3884:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR07MB38840E05B233559B3CA9A6CBEEF20@DB7PR07MB3884.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aSk8a6jh+6t0GU7tQJaGLDoLDADhi8RHKaZvtsSH9UrLgvmpknOjFNo6tTBTAcEhWHy9sTkPhIDCuHeQIYNx/GfdRBJFLxjesQbCrBODZtIzZGOV54xem3AciEmr7pCd8bF+GC/SCIYlr0MTsYvKlJQSlGLTyVTnyle7EPRBb6jiTNesZsOke9A5RBUaXIGJHL5nTzySmcBTrCe2DXPLGhdYI28tC/qHKjgHkYmakudshCLZyuhpC/9WNLT8F2VuRzr2GGf3cb3ULWFy7Jz/nVFKreIaualK6LbJKL2Y5mmv37KyR5VAs1/yoBQ7OUW/cTZItzjhK9DOz6kWwSJkWSjyIlB08X9kxJCwlSGSNaqlNXdyqOH7WTd9mswRaUxp+5//HGhB8Uznlmz7uopqhIvccy0HdZE4wvINyyFasCFZZTXu63oFDFZYYdZ3GKJ5wIDjl6AJbZ7Zc9KJHQUI0ccVpaKT9KH8FWXqVJWdqcg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR07MB7030.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(478600001)(4326008)(66476007)(66946007)(31686004)(36756003)(16576012)(66556008)(6486002)(6666004)(52116002)(316002)(5660300002)(956004)(2616005)(186003)(16526019)(26005)(2906002)(966005)(4001150100001)(8936002)(86362001)(83380400001)(6916009)(8676002)(31696002)(54906003)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UlhBTlZ1bWIxdUx1Nys3eEZiNjRESnhTeE44ZFlXZmFucFo1OTNpcG1DVldH?=
 =?utf-8?B?SnpldWtDTDdKRGI5WXRFZi9uZnNFTjhnUGF6YmVzZnA2elkvRnJXL1FJVmJL?=
 =?utf-8?B?UlMvWHBMY1hsRHpoc05Nem5vSzdmT3UrTDlJUDI0UDlrUUx4L0p1MkRCdnJo?=
 =?utf-8?B?SUJyaUlyTm1kcE13NVVFUlBLRXJCaExpazN2bVg4QTd5bUh6RTZ0TlptTHZj?=
 =?utf-8?B?Vzg4Zmhhc0lCUktHaDRGclo2ZVN2Qzd1VzZDWDFNbHpZZ002U1U4UkpHRnBl?=
 =?utf-8?B?a09Relk3a0k5Yis0OG5qUEw4YXRZeFNpTTFFS0l2TklWdFo5MWZ6ai9TM0ZU?=
 =?utf-8?B?OHQ0VXZBYnVJU1ppUjU1R0hXd2I5N3BLY3lUazNRRXZYaVpDOHg3YUh0VXgr?=
 =?utf-8?B?aWRrUGJpNWNIVjIyb1gvVkg3NlJWSm02Z0dYNGNWOXpveDBqYmRWU05uQ3Fl?=
 =?utf-8?B?OFlQWmtEeEVpYjV1UlBPU04zZ2xiTVRlMWJDSCtSVkJFa1FKOURpK2tTcEFW?=
 =?utf-8?B?NTVPTzE4aTJOQlV5Q3JuK2RLbEJoOS9xWS96dUFuVndVS3E3UlZpL1BucTBa?=
 =?utf-8?B?R2ttbzlJVEhYOWMrWW9vMjlLRkd6cWNmbWFSTC9lTHZuMm05bERtZVdYSnFu?=
 =?utf-8?B?Ukh2UjIrbHRacHhrZjZnanVBOXcvakpVLzB1RHpXek8wWk9QVCtsZjdrRXRp?=
 =?utf-8?B?OWE3RU1tYitWRXIzcHFScVEzOW5ZUnpYa2xFY2NaNWVwcDdiTGE5ZmlLTUpU?=
 =?utf-8?B?OGR2Qmp6VjRDUERRaFpQeGZYOUk0ZkNURFp3QkZHMkNoek94MndSdStVN0Nz?=
 =?utf-8?B?WHY0YVZqd296RHRWbk8yRXAxMzFhK1pWOXdqdU40RUdBbkZ0QVY0Qyt6bTlV?=
 =?utf-8?B?bHMySUNyOXZjdTcza0RmbnJ0eXdpZDNwbmFPVkNSSEhldk1DUmR2K2J6a094?=
 =?utf-8?B?V1BZN2x2OGZiTEFNb0RqT1c4MTBQSDh2S1BUNGpxUU5sbXdnZnlvOUlPU2ky?=
 =?utf-8?B?VG1MTFRDTEhkRWd3RDdkb3lRVWNBZjZ2MjJUMUg1UHRlaXk4dE1uZ1F0blgw?=
 =?utf-8?B?T1IxZEtRbmNSYmU4Q2VNYXlJdnlLUlkyajcwaXBlU2Zkc1dMSEluYjlzb05i?=
 =?utf-8?B?K2NoYTJBWFVncU5Ha3l1dlJ2V2srSGRBbDFTcTd4Z0kyaERISHhIZnVjSGMw?=
 =?utf-8?B?L1pvTXBvY2hmbzBMY05rRzdISGp3TENKTDVoTnVKWlNWVG1sWktGU0d0UDkw?=
 =?utf-8?B?S3JsdEFMeTY1cHdUQlp5S1B6NSszYWdRWEswbDhmZFhMSzhpdGhQb3NSd2RL?=
 =?utf-8?Q?jNA9JQXPCgZYN9UUjmtf1wjJ/t9ep5+yMX?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthSource: DBAPR07MB7030.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2020 15:33:44.9307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dfd3a6d-31c4-44d1-c00f-08d897a0d23a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +XfEgXNQ+yICdTXsG8FBEN2P01SbeE85wYhz0Bzc+M+xfGGcTmWV4kttNDwp4Hh8gT1RL7AKHzxWX3RMSeQ0Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR07MB3884
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe,

On 03.12.20 16:25, Philippe Blain wrote:
>> On 03.12.20 00:06, Junio C Hamano wrote:
>>> Philippe Blain <levraiphilippeblain@gmail.com> writes:
>>>
>>>> Thanks for bisecting it. That commit wanted to fix a different bug
>>>> related to nested submodules, and the route taken was simply
>>>> reverting an earlier commit (a62387b (submodule.c: fetch in
>>>> submodules git directory instead of in worktree, 2018-11-28).
>>>>
>>>> As you discovered, it breaks other scenarios.
>>>>
>>>>>
>>>>> $ git version
>>>>> git version 2.29.2.435.g72ffeb997e
>>>>>
>>>>> $ git config --get submodule.recurse
>>>>> true
>>>
>>> I think the current situation is probably worse.
>>>
>>> As a short-term fix, we should revert 1b7ac4e6d4 until we can come
>>> up with a real fix, probably.
>>
>> Junio: This is why I originally intended to commit the test case for the
>> testsuite separated from the revert and wanted to start a discussion
>> about the actual real fix for the issue:
>> https://public-inbox.org/git/1604413399-63090-1-git-send-email-peter.kaestle@nokia.com/
>>
>> My proposal would be to revert 1b7ac4e6d4 and isolate the test case
>> "test_expect_success 'setup nested submodule fetch test' '" make it
>> "test_expect_failure" and apply it instead, until we come up with a real
>> solution.
> 
> 
> I think I have the real solution. I did some debugging and I think it
> is quite easy:
> In 'get_next_submodule', 'get_submodule_repo_for(spf->r, task->sub)'
> fails to get a repo pointer for the submodule repository, since it is
> not initialized. That
> is normal. Then we go in the "else" branch, and hit this code:
> 
> /*
> * An empty directory is normal,
> * the submodule is not initialized
> */
> if (S_ISGITLINK(ce->ce_mode) &&
> !is_empty_dir(ce->name)) {
> 
> 'is_empty_dir' receives ce->name, but the current working directory is the
> Git directory of 'middle', so clearly is_empty_dir returns false, as
> 
> /path/to/git/t/trash
> directory.t5526-fetch-submodules/B/.git/modules/middle/inner
> 
> is a non-existent path. The path that we should send is the worktree
> of inner, ie.
> the concatenation of spf->r->worktree and ce->name. This would give
> 
> /path/to/git/t/trash directory.t5526-fetch-submodules/B/middle/inner,
> 
> which is an empty directory since the inner submodule is not initialized,
> and we would not get the "Could not access submodule inner" error
> that you wanted to solve.


On quick glance this sounds plausible, but to fully understand it I need 
to put some effort in reading this code again.  I hope to do so 
tomorrow.  We can then compile a new set of patches including this real 
fix and Ralf's and my test case.

Thanks for digging into it.

-- 
kind regards
--peter;
