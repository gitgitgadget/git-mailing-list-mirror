Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B1CC4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 07:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 419E4610D0
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 07:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbhG0H5z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 03:57:55 -0400
Received: from mail-eopbgr50075.outbound.protection.outlook.com ([40.107.5.75]:10244
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235838AbhG0H5x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 03:57:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRCZMIMMzltiGElLxI4FbXYewEoKFDJ7pkgQ/c6dvn9ZVRD3UrVBPfx+jl76IvsSRiCKl9goZNDAYdRCG+zSQbT3+yqUcJnKta2O7qvM6Wgwv3li+kkXluVWVUW3VIO/asfGEcJYHswn/Ca6blmX+FbnE0qMdYhh/h1pKWxiCIIEaJHtnjJhyeSBGvx8doV4Bg9IbpWX2GVIzo1OpkN3b2zuIb3lazdfxWs7Ck2y69KE2fDGwzBc6j+VQTYWmwOqIjEsdKnOnAEqfdDNfqE3Xg2SliIiD73DbZ3ETbs1XOeAV/ODjN6QgVUbVA8IK75YqmgDmY+lFMbNZ2TjJJJthg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyfmZH9TPu5sgLoiS/eSaCDJHq4kQbpCOp2lR9INd+w=;
 b=lzYwYCw3v3dpljdhbXumGxDdcW8LLSZPO59OE/jOAuPZXuGv9Zp6zTbQyn/3icrBhbyoUCan7mUVBjK884KU56Uxx5/mwC+wi0Tx7ndJztIapK2NkfvlWXHfXduv9jPXynozvmzeuTbM7PsUePc+HRLLVgCAhp+qatvNJkbX/rpHo7s+NIHBTJHi5TrZHzmH+/UT7VRJmB5HIWslnKsy+ZzAdl4tVwADhuxY/Ni46Q0JClze5+NgoFqOElbMEpu2Axu/9NDcj+6ShVcn88GgKu+zMlyPImPkttaccfrxmuIy20CdgTDnM+TDfPiWZ0qwjfn0XkEU/I7rDhLqQ3eg8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyfmZH9TPu5sgLoiS/eSaCDJHq4kQbpCOp2lR9INd+w=;
 b=dAyZKRjji4XvcRUu/tHDjTSR69ctiR1mLd+B/APCXRA1J9phNlpKB2ndkNKQmPHMcGm0buaQf4UofflAhvV0qyDqtTVOHVZ50dDm+v02Cn0jnQEsJrZTUojbTdsd+hxKabR49bKv0g4PR3zdnA+r1oodg2GmpPShN5rt8/Bo6Qo=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4653.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Tue, 27 Jul
 2021 07:57:50 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa%4]) with mapi id 15.20.4352.032; Tue, 27 Jul 2021
 07:57:50 +0000
Subject: Re: [PATCH v3 4/5] Use a better name for the function interpolating
 paths
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.66.v2.git.1625155388.gitgitgadget@gmail.com>
 <pull.66.v3.git.1627164413.gitgitgadget@gmail.com>
 <19fd9c3c803a300b586c76736301a7379c4c6226.1627164413.git.gitgitgadget@gmail.com>
 <xmqqh7gghgtd.fsf@gitster.g>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <99332fdf-24af-8938-2f55-b6e25ca12aad@gigacodes.de>
Date:   Tue, 27 Jul 2021 09:57:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <xmqqh7gghgtd.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PR3P191CA0030.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:54::35) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8] (2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8) by PR3P191CA0030.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:54::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.31 via Frontend Transport; Tue, 27 Jul 2021 07:57:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bafc6543-e73b-4937-8bf8-08d950d43b18
X-MS-TrafficTypeDiagnostic: PAXPR10MB4653:
X-Microsoft-Antispam-PRVS: <PAXPR10MB465348EA00C3C7EE8CD51D01B6E99@PAXPR10MB4653.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lssYLoEmU6Ys5b02Vf2MNrgagYl0mI0DyKw5K46kAnASHEKBaqLiwKBKF/h2EPoOK18EnaS+EvDKUfexzkm6CT2SJvAOBI1b6aP6VtApVM1QRY/trFBwy92bRo9Qd5ceUNgT5CZ+M4H0Dx6JY3W8s9NuUu0OlFsac+d4eRPQJFnz94gWkQfZva+nQaxPVWSyNa8Dx3wr3CAYN6Ru9I+sEtedhMPBZzpNMLEjlrbB0MQBOVF3Yf7WQhJIYai/P2I8w6T0OwxVdGobh1ax0lolMQmaHqwVHBqXtAdDsCUTREOsuWATu6g9Vy16HKlRUi/MDN9aULa0LENwn9+siyEMWNWKlDhx5qEtE56j9h0Wp7Yasm/6ekbjaw+Zn9weVQCjriE4DQAEJo1WudTUfa4R0+OIbekg5DAJpCp+NSeajx5NYEfxNWlthlz/gK9u+UjcWC7L7Zqq4G21BZxSH0FCcOzj951o4Pqkdq6eIvwDwhtv9ngsAfFLVjeVDCn8wFqduE6hExVd0ot3SPaiDUlEkNoHAiK/7s4LDOxRs2oaz1fjFknswSmr/DZfcPrirVYF65m1sck1+SgXQall3walsTM/XYUSspSW0ePlDTj6ZWxAJZ6RO/nRv0OPG9GE4ubhxRW/wY9zh3F/LCgH3K2F/TPbLq8QpSy+K1Aipj44qoMR06ccJ9+F+5iIaOux33BxTyN1iHWuSLJsaB+0QLhmyjQgolXErfds3oPZTjWoPoemgfEOFvn/RFJqSvMoCARm36H0Tq1LC7NGNCTXm6tSTq04MWNbkmHKZi3WZvjViR2dZmqtbwbI1Pj6u8eeSWr/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(39830400003)(366004)(376002)(136003)(346002)(66556008)(66476007)(66946007)(966005)(31686004)(6916009)(5660300002)(478600001)(2906002)(6486002)(316002)(53546011)(2616005)(52116002)(66574015)(8676002)(36756003)(186003)(86362001)(31696002)(38100700002)(8936002)(4326008)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bW1TZFpuRkNJNFRKM1JOVlA4cncrNzBUbGdJQ0xIWWdPZ01ncW1PR3VsaFM1?=
 =?utf-8?B?S2RRUklZRC9Yc2V4TkQ1T1FqOWdONUZqTTZEWkUxTFBjKy9oMHhXcGlEZSsr?=
 =?utf-8?B?WGRZaGJieisra0M5WmZUa1l4bnVXcHQzNEkyYSs2RXFJUjlXNU16M0NIRTJJ?=
 =?utf-8?B?NWY4M2xhQzQrbTRieEY1Qk4wSW5yK2RFczJ6SElhRFJKMHZ1QVN1VU1OY3Y4?=
 =?utf-8?B?OWluRXEwQ3A3R1IwOUZ2SFpyWi8wd0ZrZy9OS3NFQzBDWTQvVFY5bExFY01u?=
 =?utf-8?B?NVQ0T0xrQ3R1UFdLOWtOQ2RHQUNxcnQrcTZ1dHZjaU11TXpacktscWZwTU5a?=
 =?utf-8?B?alYxUTZJeE9hNXd5QXF1OERpcEdjUVdGOUUyZlM1MVcxSXc2R1FGNEx1K1B0?=
 =?utf-8?B?d08yQTNiOG43S2VubjFzTUFoMnF3ME9xWExINFE3WlByT1pxejdwNklrM3p5?=
 =?utf-8?B?amd4Q1Uxa04xR1Z3RytvMEJpNDY1d1BEOTdKRVp1RzFvd2czMWk2RTlGYjd4?=
 =?utf-8?B?Ry9XRmJmaXZDUEIyYU1URVlDekU5UjhnQkZkcVJ3ZU1EY3lKbGRUM0pLc1pU?=
 =?utf-8?B?dUVlTTdyRVpLMVNXYTJrNXVHVGlGdGRTd0NYazU5NjhabGtWamxLT3dLNC9n?=
 =?utf-8?B?TDZ4cGtkcld1T1ZuK2pCUFNiT3RHZWNGYXB0VFdLeGFZRHNYVjlpTnNmNnNr?=
 =?utf-8?B?c2xKVUpMUlc0TTFMVHZzQWFwVk9kRVlWcGxIOUZDdzY5NktjUVVFblQrZmtP?=
 =?utf-8?B?VXJFWXczUndweWw4ZS8zM0c0aEJMOUovelNKS0xjaWNKQWF3cWFVT21rekhh?=
 =?utf-8?B?TUJ6WmdxamQ1cytsSkN3emN2V0l0TUN4Ykg1VUk0dkkyL3BUd2dvT0ZnQkg0?=
 =?utf-8?B?WmRrbHRJWDRITXV6K203d0Q1dU1USlAxOFZHMCtheTRMQWVHZVMzMnJDaktn?=
 =?utf-8?B?WEwxQ2FMUTBPNlNtMlJsNTEwaXpuMW5xaUE0dW1qYit3YkVnWk1UeW4wK1JU?=
 =?utf-8?B?dEp6SmFVQ3c2R0QxQ3NybUczVzBoSVozWHN3Rm5XNVZFODJ5RXMvSGtiSWlr?=
 =?utf-8?B?anM2SjNuUmtxL2JRY3NDRloxVVpQN0RXVjQ1WDlWTUp3eUtZdlU3L2RhY1N3?=
 =?utf-8?B?d3JBKzZ4OWdtTTVrRDBZUHVYejh4UVBVRHFZUGZ0V3FlVXhVcE9VYUV4MTQz?=
 =?utf-8?B?NW4zaER4QTNjeUliWm9EMUxpa3hDQjlOQzBja29ieUtiUU1uUUhqSTE4czFY?=
 =?utf-8?B?eHgyU0hQc0FhRHFuRWdvMktwSyt0UUZzS05sUHZQcmovYm9tR053UWtnTERa?=
 =?utf-8?B?T2dUM0dpcGZOM1VjOUs5RUszQldJYTZsQ2FIMU0yUXZqL2dNWFhadTlpTG5D?=
 =?utf-8?B?SHRUd0FweThGTXRwM25VeGVPV1o3T1BleHBZQTdtZm1lb2NOUzVWZDFJdENX?=
 =?utf-8?B?K0JyaWZJL0Ntbk9ucjJPbHdYbTJyQmwrSHk3blg1akNhaXpWME9CWCtpKzRN?=
 =?utf-8?B?d2hDNXllQm1UaGp4SUIxUlc4Q3NsWGpyVjEvdDZOUWh0dFgveVdJZ2ZFelF2?=
 =?utf-8?B?dEF4b0YxVWk3NFJuTXFkSW5rRWNNZlkwOGJjQlowQUgxUXB6OEF6bS9XQjc0?=
 =?utf-8?B?WDZHQkd3QVVzcjBJdHY0K1FxYWMyYytpUVJZS0xUOUt2UTJraTRKcGFaeWpQ?=
 =?utf-8?B?a2pDWU93dGdhdjFvL2NsYjNhYXJoRmtuSkVpdXc3QnhnM212YVNJbElIaUx3?=
 =?utf-8?B?N21lUkRuY0s5Yld3THJVejVRN1A1b3Mwek8yZXFEOC9XUHBzWDJUQ1pJOE1C?=
 =?utf-8?B?cEV4RFMxODBYWXZ1VWROK28zWWIyVnlQZ3BPR3NIck9pTUY2U0FSc0dJbWhE?=
 =?utf-8?Q?8pt0ti+pbUpoD?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bafc6543-e73b-4937-8bf8-08d950d43b18
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 07:57:50.5733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Amo2ffir8tDC8Ff2S6bnKHGhKLfrBFVUhzoo1TI8W6bF4Z+MmUQuHPtMTnBMH6xbVfC8hrwLXnYbzo9RkOKomPDzv8mBgJz7B7CqcCat3sk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4653
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27.07.21 00:05, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> It is not immediately clear what `expand_user_path()` means, so let's
>> rename it to `interpolate_path()`. This also opens the path for
>> interpolating more than just a home directory.
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>> ...
>> diff --git a/cache.h b/cache.h
>> index ba04ff8bd36..87e4cbe9c5f 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -1246,7 +1246,7 @@ typedef int create_file_fn(const char *path, void *cb);
>>   int raceproof_create_file(const char *path, create_file_fn fn, void *cb);
>>   
>>   int mkdir_in_gitdir(const char *path);
>> -char *expand_user_path(const char *path, int real_home);
>> +char *interpolate_path(const char *path, int real_home);
> This of course breaks any topic in flight that adds more places to
> use expand_user_path().
>
> I think Fabian's "ssh signing" is not as ready as this topic, and it
> can afford to wait by rebasing on top of this topic.  By the time
> "ssh signing" gets into testable shape (right now, it does not pass
> tests when merged to 'seen'), hopefully the "expand install-prefix"
> topic may already be in 'next' if not in 'master'.
I think the test problem is not due to my patch.
Like Ævar wrote it's "hn/reftable probably interacting with my 
ab/refs-files-cleanup" [1]
The failed tests i can see in [2] are either t0031-reftable.sh or a 
compile failure referencing reftable as well.
If i merge the ssh code into the current seen branch everything works 
fine for me. Let me know if you have any other results / CI runs that 
might help.

[1] https://lore.kernel.org/git/87a6mevkrx.fsf@evledraar.gmail.com/
[2] https://github.com/git/git/actions/runs/1053603028
>
> In the meantime, I am adding this band-aid at the tip of this topic
> to help these two topics play together better.
>
> Thanks.
>
>
> diff --git a/cache.h b/cache.h
> index 87e4cbe9c5..679a27e17c 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1247,6 +1247,8 @@ int raceproof_create_file(const char *path, create_file_fn fn, void *cb);
>   
>   int mkdir_in_gitdir(const char *path);
>   char *interpolate_path(const char *path, int real_home);
> +/* NEEDSWORK: remove this synonym once in-flight topics have migrated */
> +#define expand_user_path interpolate_path
>   const char *enter_repo(const char *path, int strict);
>   static inline int is_absolute_path(const char *path)
>   {
