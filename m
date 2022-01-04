Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5A9C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 12:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbiADMzj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 07:55:39 -0500
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:21876
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229543AbiADMzi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 07:55:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atgpburBrHo5m4ZE4VLPXYhvK/5A7XBT5WZp3KRMC6sqjY1UC9eaq27zlqhOcYkiKlKuSTnBYCiwPCYNTE+6YqnX7qqc9pDvAntI4S+pHzu8cm9nruCZ2gtkiw/eUCq2IAHHT4wXF8fjOWjmSKqZtrFQAIyIxBqdkI3Yv1VZE8oBiABBS6KlZttR7uSZ93eGLHvncer3egoKMmN0yNCHpNvYkBlUcgDtmHwVvWtyy1eufG9FfP+omGkdYJqwJpB0SWyBJ2iz3mqiCidyLugVVUk+M/IfD1l+wvzFcgs2ibSR7CkdIFlLcQizYUCTh4yxiDFznMS997dY2PiilTV4sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZuun6pz/5yqsRLTXPjJgmRD/T+7xJANcVkukxEWPTY=;
 b=hbmnbjz6REpjkoIfS5aMtZpNUkxORuHUj+vmNl/drNR7uyyPDGA49Yjl3G5ioO0EXiTc6U/6RRWm3Td/7sYF4+cbaW88R7GU5hAyUV+9FDRsp9JGRxtzrfdXMf1TWqhZqV6IVbHP3TvnjdzIU2clDEojWpRu+DAOXqfQI+JuBBUJG6Sre2a8jXJkwo9qioJtZseyjr0NNvnEYsXZmx/F8B972KEieoGeUf91L6++TcajRqzZrPvXouR8m5ldzfpjvA3kaIGmbmFTaK+/oSz+QgqiatiC3VawePQ2ZlwX8fz5UxSLAm8PZD15V7EuN5b9M14i3bpuztviJit+lGqFxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZuun6pz/5yqsRLTXPjJgmRD/T+7xJANcVkukxEWPTY=;
 b=be9Tz3dkL0/2mb/eOl2EixRULhXA9rsUHKsysuruNxBqxYMv2u5EcOOGYw7MNaWEoRSMogIvh10sLVLp28D7yhn0ipQ8PiSetLsjLyh5THWVEFLynQ/ZsWcBSGc9pFHnCRZVG4j2xJW0wpDLTzH1WA+UlgIygBH4AIunW68T6d0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4127.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 12:55:35 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%6]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 12:55:35 +0000
Date:   Tue, 4 Jan 2022 13:55:34 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Pedro Martelletto <pedro@yubico.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] gpg-interface: trim CR from ssh-keygen
Message-ID: <20220104125534.wznwbkyxfcmyfqhb@fs>
References: <pull.1090.git.1638538276608.gitgitgadget@gmail.com>
 <20220103095337.600536-1-fs@gigacodes.de>
 <CAPig+cS6h6o2_dJAZC1M1Ace29bN2mhPgaEtTWtj3oXfcHq9cA@mail.gmail.com>
 <xmqqee5oieb2.fsf@gitster.g>
 <CAPig+cTM3wZz4NXjxYeBuFv0CVNS-T+pBFeVkfMQ-25pL1kBzw@mail.gmail.com>
 <xmqqmtkcguvm.fsf@gitster.g>
 <CAPig+cR93GyN53JoZbaiROrNtzGjiet7eTPQOk-26G+mB0KaCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPig+cR93GyN53JoZbaiROrNtzGjiet7eTPQOk-26G+mB0KaCA@mail.gmail.com>
X-ClientProxiedBy: FR3P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::17) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d851fe0e-39c6-4851-2cf9-08d9cf817ff2
X-MS-TrafficTypeDiagnostic: PR3PR10MB4127:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB41279BECD414DF6BAF658D3DB64A9@PR3PR10MB4127.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hzcFCEXko5/U6MgQQ8X6OyihdgIzqijNJXtf9BcYY5zq4+23ySx1uP5hC7H4dccyAaJ+JTKOTx0OGx1IyFY0tcabXxonCksA7Nmt38rKCxcXCqgSzN9ZObhaZRGqEbFS+13F49Qe/SSkz9j0TvBwSrc/XudIMJm49Ituytgw5qpbGOFK4MQZBWKWjd6OsSxBQtfT09KDCcsHg9j8E+DCJilbStxCghnj6T8L8UUZBjpcTabmzcw8dX/9JpONpUSMzxFkSvrm9C2TxIHK3wsCiAsuxrjm6XSJkZBJ5d2JTQqqgMM+SvUaau8zC742lyr/jBF7mgJLTJy/OtfqVnChO+tccyHaXJEwLLDXeYdRx3ZmxgbQgkTAHTT0jWGJljjrMzmF0CagSqXuGXIkIEvtvj9s8HGSTyC4g/mxyf6jEZqOeQkxRTf01dLZubA0P5eA1naE18mxO9Sj4Pm/lr90j49u/DSGsUOPIera1YCWoy+nMEejYrvUd4kAO1qUjlKQ0aKpNhqt7e6uwUEfIBMEsmHplUW8QY2ZQURmG1cfaKdoKb6KUK7uWXw5uC8O7d5KuHNNx+mrn5zLbpktkJPcqbh8MEEckBMy3NDg1+GERFkXm9AyrTj+XJUM9ZFTidcHXLYMYkA0l8Hl4XfT9GiKpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(4636009)(39840400004)(136003)(376002)(366004)(396003)(346002)(8936002)(66556008)(186003)(508600001)(6506007)(6512007)(66946007)(4326008)(8676002)(86362001)(66476007)(6916009)(316002)(3716004)(53546011)(9686003)(38100700002)(1076003)(6486002)(26005)(83380400001)(54906003)(5660300002)(2906002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0QxWUhMQThUenR5dlh2bE5XdC9XdHYzNm9YWTNrZU1rcEhvQ3p6djgyclhD?=
 =?utf-8?B?ZHIrUms4YlcvS2tkNmc2c0Zmek9nQjRLNTMxUkQ4WTRybitlZlhlTzFLWFBM?=
 =?utf-8?B?eGwrVXdxbGhsaStTZHVCaDY3NUdiZHZZWFZldTN2ZTRpUlhpMlFOeElISFVu?=
 =?utf-8?B?Q1VJRHlCV1ZzMEFaTUo4ZHR1MElKdUl0N0o0WlA0QXdEVFluWVFkZzJ1L0NF?=
 =?utf-8?B?TndlcmtqOENpVlBjdEV6WlhFa1dLanlKLzR0SXpnQzR0bzJNc3RjbGJYMFRu?=
 =?utf-8?B?WGtnUFdzTjV6V2s3TjdnL3l5L2ljaDNCak5KeTBwVjZlV3o1eVFrMHkrVzRY?=
 =?utf-8?B?THJod045SmNhR1FsU2JrSjFXVW1veU5lSlYxenFwZkR4Q2dMcDBUWDIzeGRk?=
 =?utf-8?B?WWVvQStCUzByeFR1MTB3NmtsbDdCamRUYWtZZllOVEtvRGFUdE5XL0hHV1lr?=
 =?utf-8?B?R3FXRzFlNjBBQlErMjB6WVQxUWNXQkpCbE5iK2xHdjlqeXdlb0U1Rmh5TmYz?=
 =?utf-8?B?Q1NuMURjWEJ1U3Jqb0ZNQnc0R21hVmw2NkdoYjlxUm5USHcxUlFER1NqMldB?=
 =?utf-8?B?cXpISWFMQmVmOVhwK2w1LzdPTUhZbFlwOFdXdzhmVG90TFpNbmErOTlici9q?=
 =?utf-8?B?SG5tOC9DRXVmNjB0TlQ0UDNmRkxTNTNVRG01eEhRVG4rR1lWUnNORm1IcFBY?=
 =?utf-8?B?VkxWa3R1WEg2dC9LSmsweFEwcjRhb0pQWHdSNFdjekN0ZFBzNGtFTnFQTEJ5?=
 =?utf-8?B?VzF1R3FsU0kwUzY2dzZ4emhGSVk1cXBWc20waHJobEl4eUFmUkxIWWpDdUF3?=
 =?utf-8?B?NU96NmxCQzQ4TjdsbnQrMW9KNGZnWlozWU8yK1lhc0lqbVliUkZaWVY3N0J5?=
 =?utf-8?B?RVVXNTFkYVB4YWpEMHA4ZVBXbnFpbmpqUUxaOENrUGJZOHBic3FkVlhmUm1V?=
 =?utf-8?B?ekNzb1BLR2NqWFB0WldxcEVETWJTUHNES0F3cXJ1VUxRcHZXb2w0N2cyS05S?=
 =?utf-8?B?UW9UVjFsL21UMG5YWmJ5T1hWckc4cXdZUUhIdC9CTWU1NXM2TThsNzJiWHRU?=
 =?utf-8?B?bjBxekozQUxwam41UndISzJQNlJoQmd1ODlselZqTi9PZ3hNcUEwVmxSNUJh?=
 =?utf-8?B?M255SVJaak9rMEFUeC9IelM1dWNJTDJWMnlVT3ZqL0dNQ251amU1RWovSGFW?=
 =?utf-8?B?TGpPODU3TEhTQ0Y5MU9qTVQ1RkdTN0NTcER4N1BqS0VVSHVMcFZkSFRIU0hs?=
 =?utf-8?B?aW9hM25LQ0k4UnhhZVdNbFFiRWg3alV6KzZieGEycDVqbThQZThQZTY1OEZJ?=
 =?utf-8?B?L3NSaWowRTRCbUkzd25oVmVKakFaWnVOcUNLS2xLOHdIVld0aFN4b1RiVUUr?=
 =?utf-8?B?cGVrdHl0SkFWbEk3NEU1L0l1cE1oclAwdVdJVjlWNTNsRXZ1UHlpQUZKOTVl?=
 =?utf-8?B?WHJvcEpncUJEQW8rY091dzRJUStNQnlJUEMrVmU3aEJzazR1L3Yydy9BaVUy?=
 =?utf-8?B?eEZadXR0Uk9DTS95QlpmWjBZWlFkeHZaMCtBV2ZPeDFuMU1Wd2plSUZsaWNH?=
 =?utf-8?B?azhIZElmVXRIUzYzanQ5SjJCKzg2a0hQdlZPK2tiVmpHWGJqWmdvMFZGOERl?=
 =?utf-8?B?YkdjdCt2dEtIMzJFUmFzQjJ5cTU3clJUN2JYb1BDMWFaYUI5aTFKdDBMRXAy?=
 =?utf-8?B?WXFsbmJVN3B4NXlqbU0zMFQ0S2F0ZUpCWTl6ZGZrb3RzcGgrQ0lGUm9iUG1B?=
 =?utf-8?B?L0krSFdwTmlMY1RJZGx3dTkxV1RPaDBFWGFvK0U4ZjR0djZocko1dEFRLy9V?=
 =?utf-8?B?YW1tRWFDOERuMkJ0SGNramh6dlJKZ3dOM1lJM1BHVUVCOHFFWTQ4ekk0U3Br?=
 =?utf-8?B?T2ZFZUZCVUtpa1RidlJSQWNtMTYvb0ZKd3d6T3NZd3J1NXR1MmJ4cE90SmE4?=
 =?utf-8?B?RHFMZ0tUUUxBQkxZRlB4RExUUFhHMWU4dFdWT1hpdWhETDBzQXpGWG9WNmth?=
 =?utf-8?B?OVYwenpNcWFhRm1lNThDSE9iaXVsUWgwb0lHaW81NzBseVpMMUpweWNCeDk4?=
 =?utf-8?B?Mnc2OFlKaXQyTHRZSVU5YklGTVFIazJIUEtreGNxdlBPTFN3K1c0djdVNHZK?=
 =?utf-8?B?QVdFRDRFdklnaDV3enRLTGN5WTdBOUE0TG1TVVZucmdVcEZPTCtWV0FvQ0ht?=
 =?utf-8?B?dUluRlN4SWFTem45TEtYTkhTRFI4ZTNtUVpSNlR6RnFSR2diRmRNSnViU29T?=
 =?utf-8?Q?VPeTJiIbUfWFJKv+Z2FNhOKZhmtmhsCK6wYrtZ7w9k=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d851fe0e-39c6-4851-2cf9-08d9cf817ff2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 12:55:35.6300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KcxmSiUxDfF+9Q2XdwbiOScuEyHGRaw+ucwONXD4MlmYHV7MnrEUpkfVj4FdKoWsbrztmAORhQP4A+TyVfFpyFpDt2bljVNIOwPzDRqfZXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4127
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03.01.2022 22:06, Eric Sunshine wrote:
>On Mon, Jan 3, 2022 at 8:19 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>> > On Mon, Jan 3, 2022 at 6:34 PM Junio C Hamano <gitster@pobox.com> wrote:
>> >> Eric Sunshine <sunshine@sunshineco.com> writes:
>> >> > On Mon, Jan 3, 2022 at 9:24 AM Fabian Stelzer <fs@gigacodes.de> wrote:
>> >> >> -                       trust_size = strcspn(line, "\n");
>> >> >> +                       trust_size = strcspn(line, "\n"); /* truncate at LF */
>> >> >> +                       if (trust_size && trust_size != strlen(line) &&
>> >> >> +                           line[trust_size - 1] == '\r')
>> >> >> +                               trust_size--; /* the LF was part of CRLF at the end */
>> >> >
>> >> > I may be misunderstanding, but isn't the strlen() unnecessary?
>> >> >
>> >> >     if (trust_size && line[trust_size] &&
>> >> >         line[trust_size - 1] == '\r')
>> >> >             trust_size--;
>> >>
>> >> That changes behaviour when "line" has more than one lines in it.
>> >> strcspn() finds the first LF, and the posted patch ignores CRLF not
>> >> at the end of line[].  Your variant feels more correct if the
>> >> objective is to find the end of the first line (regardless of the
>> >> choice of the end-of-line convention, either LF or CRLF) and omit
>> >> the line terminator.
>> >
>> > Okay, that makes sense if that's the intention of the patch. Perhaps
>> > the commit message should mention that `line` might contain multiple
>> > lines and that it's only interested in the very last LF (unless it's
>> > already obvious to everyone else, even though it wasn't to me).
>>
>> I do not think that is the case.  strcspn(line, "\n") will stop at
>> the first one, so unless it is guaranteed that "line" has only one
>> line in it, the patch as posted is not correct.  Your variant
>> without strlen() feels more correct, as I said.
>
>Okay, sorry for my unclear thinking. The existing code (before this
>patch) does indeed seem to be interested only in the first line of
>`line`, in which case I agree that the patch's use of strlen() does
>not appear to be correct if `line` could ever contain more than one
>line.

I guess we need a bit more context for this patch to make sense:

for (line = ssh_principals_out.buf; *line;
      line = strchrnul(line + 1, '\n')) {
	while (*line == '\n')
		line++;
	if (!*line)
		break;

	trust_size = strcspn(line, "\n"); /* truncate at LF */
	if (trust_size && trust_size != strlen(line) &&
	    line[trust_size - 1] == '\r')
		trust_size--; /* the LF was part of CRLF at the end */
	principal = xmemdupz(line, trust_size);

ssh_principals_out contains the result of the find-principals call which 
contains one found principal per line (normally LF, CRLF in some cygwin 
setup).

A principal can contain CR as a valid character. This is problematic if CR 
is the last char of the principal since we have no way of knowing then if we 
are in cygwin with CRLF line endings or another platform using LF and the CR 
is the last character of the principal.
Lets leave this rather weird edge case aside for now.

So what we want to do is split the buffer by line, no matter which line 
endings are used, and copy the principal without any line ending characters.

The `trust_size != strlen(line)` check was supposed to guard against `line` 
having no LF at all and ending with a CR. I think a
`line[trust_size + 1] != '\0'` would work as well.

But since this whole thing is already hard enough to follow i guess it's 
better we simply remove it instead of adding checks for the unlikely case we 
encounter a broken ssh-keygen. Especially since the effect would only be a 
failed signature validation.
We could even remove the `if (trust_size)` condition since this only happens 
when `line` begins with LF which is already skipped over a few lines before.  
But it's probably better to leave this in just in case the code changes.

Generally I think this is a common enough problem that there should be a 
function to split a strbuf by line no matter if LF or CRLF is used. Similar 
to strbuf_getline() but to read from a strbuf or maybe even handle this 
within pipe_command() when filling the strbuf. Maybe git even has better 
code to handle this but i haven't found it yet?

