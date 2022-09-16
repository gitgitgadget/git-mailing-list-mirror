Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACDDECAAD8
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 18:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiIPSHK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 14:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiIPSHI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 14:07:08 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on0723.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe15::723])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1747B6D4E
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 11:07:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0WvxJVzImhpveaFveVOnT/zLdrbtH7HZW5dk8oog+Mug9vY4GFKjB24oDamjxXn48hIq/hbCDmuTS8fzShyvMgVd6gOAusPSYbaTc/jWdbIoYtEDgBQIwbXmW7mF5AwvphYKseYocGSjudpIMddv7jF4cXOb1nnDyP0i7KEWMfoYc8QrgAhlYG8n5Iuixz0whVCc0IbWvzMRkXdd/cr2F60WjyUQ7E7tRzPrsyeuY42X3Z7ZNN0Qy98ap5WR5Qm053mUIAcnbnhReJq0r8Fh4KbXfG3YJWwE1dQhA9v+FxAlh2zK25+hhus+QtBdpuNfRU/LyrIJ7hkzRHfKIUj5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aN5ykYWo9JQnAAKm8RGImhLf0zAodKxMPOKFU8nDcy4=;
 b=TEmZCUn1BXGoqMyUtdFcBQV5rQWqAanMWhwaM7eeDZx1P1rYzIgDU5Ue7ykelVQt89U2yT302i+Rd9vmjSS7lcYJtJhERFqS9Im250aN03hI9BDpbLAWePg+0Xn6RcXIdH+mPie1oRgqeUtcm+uvm+fJNCw0u8FTFx3ZDDj39EDUa1Fxd8XGFCN+w9JWanEe/JpUZeHe5IVLDb7RisFNEqrrZxsRAdsABNz+xIyrdpBdf2XQQ1lW5kp9hNlLgm2WxWqm1S9AaFMao2N5AI9qaodUVSeHAM3wg7JKvL2dPtrb4hfa8kiF0se6HGX9+jlGDyYxTZwjemCr3asKmo+LAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adalogics.com; dmarc=pass action=none
 header.from=adalogics.com; dkim=pass header.d=adalogics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ADALogics2.onmicrosoft.com; s=selector2-ADALogics2-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aN5ykYWo9JQnAAKm8RGImhLf0zAodKxMPOKFU8nDcy4=;
 b=Ux9cONZB1uNTk12w5qYzSVC8/kPw5Iwr3fPVoct2kdtSnryj3KmMk2MVKNkDGOH9tdgW+IIGNwU1hLFF+33JGFyyX29A64ekCRYWbUSEmteaulS/W3LGG5WMmrNMbVB0PidVEMUZiLwLSrdSFT2Z64u8beVVKIFi/i+waTFtVO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adalogics.com;
Received: from LO6P123MB6615.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2b3::6)
 by LO6P123MB6855.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:303::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 18:07:02 +0000
Received: from LO6P123MB6615.GBRP123.PROD.OUTLOOK.COM
 ([fe80::64f3:4ca2:ba01:3688]) by LO6P123MB6615.GBRP123.PROD.OUTLOOK.COM
 ([fe80::64f3:4ca2:ba01:3688%4]) with mapi id 15.20.5612.022; Fri, 16 Sep 2022
 18:07:02 +0000
Message-ID: <81aa1467-9771-6ada-06ec-824dcdafdf68@adalogics.com>
Date:   Fri, 16 Sep 2022 19:07:00 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH v2] fuzz: add basic fuzz testing for git command
To:     Junio C Hamano <gitster@pobox.com>,
        Arthur Chan via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Arthur Chan <arthur.chan@adalogics.com>
References: <pull.1351.git.1663078962231.gitgitgadget@gmail.com>
 <pull.1351.v2.git.1663349383852.gitgitgadget@gmail.com>
 <xmqqedwbi5kw.fsf@gitster.g>
From:   Arthur Chan <arthur.chan@adalogics.com>
In-Reply-To: <xmqqedwbi5kw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO2P265CA0222.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::18) To LO6P123MB6615.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2b3::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO6P123MB6615:EE_|LO6P123MB6855:EE_
X-MS-Office365-Filtering-Correlation-Id: 38662a13-e239-490d-8053-08da980e4165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sQSdW0JdGfd4QwopQ5AxMKuWltMMhxFL59jWKZv6SUd7Pksi3B+lErgAVSd8SeaUvoxeL/ydrrOR9io24sjBiQbBkLSCt++bl6Cl/ZPRhuHeifJ3rU70skVspoZ15NSoWqZBi4xCYcc4GNzaE6b9ejmENWV9WSxKZWl6CxsEzGda/+J0qF1NN+jLkB6qzX9X9kykxiySh6b1G7JkKRJwWasC4zC5o00ItV9qR/uZ22Ztr1ilOW/MP2g2wdJH4JDGvsi1hCDfRTaaBvUL8yhgKZQLZgbyieIQAKf3Vuyn4Rf8EZAIKsgqQQqG+WQV0msz/OZWdNfCsRiHHNWwD9vbk1oKB281Ik0R0kcREcfHfq3hIMjnYFeBZ5HZnBURrQ97yOZXOBFEfo9JsUMU+lckcdXRfmy+GU4kZkQDEaY7tsRvLx/ii2f1XgdZ6crcLBWJe0Bxbo+H3tJsNjYstcGqafDZprFL2PVrgE3AJsbyJpkuv++ZySCRn/+xyz1Rv/JEA++vAofhYAey5uhGGE0vGkQlxdmXK3jHDikobgiOPGCzXT+RziAuCoMgEvXfVPx9RSAIMGA3wNQszJONkVQd8QSxvIJssvpqvjz8isqpMID1m4wXLluEWN6kRuG3WR9abB9SMINapB3rvKGyGoYF0GyfJvYj0o+jIIG1HktSqpPpmue81wkTeEw6P1X38YjhaXAoczBTfQM9jW2Njxz7N0+o6VTbB5oXljt3hDyrduNenqE7QlYBsr21IcMxsI4s1p/082046t/mwHA5oYImN2e1YYrwKb4OrGJDb9L/cb8xH4yOfljglkb5uKJ2gSZuYuJgO1c7Ib4S7Smr+28CgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO6P123MB6615.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(39830400003)(396003)(376002)(346002)(366004)(451199015)(5660300002)(6486002)(8936002)(110136005)(31696002)(26005)(36756003)(2906002)(44832011)(86362001)(6512007)(186003)(316002)(478600001)(2616005)(66946007)(38100700002)(66556008)(66476007)(8676002)(4326008)(38350700002)(54906003)(6506007)(107886003)(31686004)(41300700001)(53546011)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bi80TGtNTVhiUld1SG9YSHVCV0xOYVhPeG9aRnVGdmhySUdRMm5RbHExTkxS?=
 =?utf-8?B?R0p5WjhmVS9QWWtBaFNoZkhMUDN4L3loSExlVCtTRXlXY3l3YTh4eGdXNUxB?=
 =?utf-8?B?ZERXazQwdS8vQkhacXErVVA4VWsydHhqenRyUGw0dDc1K016cEw4RU8wSU03?=
 =?utf-8?B?REw3THMxZmtQY3F2cE04L055cVFLYWFKektwdXV3Y0Z3aDc3aE1PTjJiUDhh?=
 =?utf-8?B?QnBJSHIwVHFpQ3BBaWg2NkpqRU1IcTBtWnRWcE14aFRpNDlZdUJCcmkzbmkx?=
 =?utf-8?B?bHVRa2xNRU43SVNYeDZtdTN2QkQzVjRGUEV6d2JzQlAxcVJRM3NtcUpKVmNW?=
 =?utf-8?B?dU4xM3JqSUNyQm5KT0MwTm9EdlkvR21icWN6emtraGplOXdJamtUK0x4MWRR?=
 =?utf-8?B?SWJjM2hmWXJObTdaSjV5Z3RJL0ZYT25OZ1RjN2JIRW1HVm84cS8yNW9ZN1NI?=
 =?utf-8?B?K1AyUzVKZHljM1FROEhRVXFZbmFRYStxSjhoTjcyMHdlK2VLeGpOK2xTZFdq?=
 =?utf-8?B?Nmw5VU40VW5xMFZtR3ZBeUxsUDI2SzA4eENpWno1L1prRkZlN1FSc0lsN0U2?=
 =?utf-8?B?ZEZRVWJVdjBkUVRDRW5rU0czdjVhTmh3ZDBRKzZtaDJxOUhzdVpRbWw3dmpy?=
 =?utf-8?B?SnlYc2daRE5CMVVGOXhOOEp3ZFdUcExsVTlzRWVNcFNhNkZ5OHBnYUhQSStH?=
 =?utf-8?B?UW92U3dxc0ZodFJaTVJmQVZKa3BuWEdTVVhibU1WQjU2enF2R003VWRqdFZU?=
 =?utf-8?B?OHVmQ2FjQUNqTGxYZHJROXFBajVSRzZ4aXUrR3dnTVR5ZEsyd1pXQU5UWGRM?=
 =?utf-8?B?S3VGSm04c0s1N1pkeVFUMmsvMkdkcitURkc3WlVmSW92RjFUbVV6WHVZSy90?=
 =?utf-8?B?S3k1cXI4TlNXVGRsS3ZiOTVmN0N4RjZLUnR1YVppSFFWUTBEOFV2ckZaSVUw?=
 =?utf-8?B?Y2VuZVcwdXZrSlF5b3JWV2F3aGlSc1ZjbFFUcXp2QmpPdWQ0M1ZMK2Z2d0RJ?=
 =?utf-8?B?VkE1aTJvcEpjNzc1T1pNdHpET0RoR3FTVCtVNUZaald3SVdLSllmTForZnJG?=
 =?utf-8?B?Nm1LU2t3bjltczlVbGp6SUVnT1Yzc2dLWHZ1WUVXWGNJSW9sMm5oSGtUdWxs?=
 =?utf-8?B?ODZPallad0FNbXgyUHdaMU9UcERoRFBYUVE4QkFLekRTVU1WWTArM1picWY3?=
 =?utf-8?B?TFJUWXV4ODhKNmt4bmNVY3h2bXBSdlFkVmYwTkRnaTNKcDBjcXFBV084WXRS?=
 =?utf-8?B?VXJ6NStwcE1HUUY3MU1JRmRCR2hrYzY4YlhTUjhsNzNuTGJjbnY4RHEzTVFK?=
 =?utf-8?B?TkZEN0VaeUQzZXpFeHVhbFRtd2VDcytreCtMTUN4UkZsSW9Gbm1PQ2Q0REtr?=
 =?utf-8?B?VHNQTFByRVQrbHB3WGZUUHo0ZUJWT2haazlDaXNjRzROM0Ezc05iNHcwMFBK?=
 =?utf-8?B?Q3pSa3Bwc3kzOFNxN1F4R244RHNEWHAxMEhjalVvbmNtTDB2Q2JwVVNtUEhX?=
 =?utf-8?B?Z1Q4QkRGZnYxYzVuRXVxR1Z2OU5NODYxSXVzRFhjTTU5TlcvLzBla1o2RGNr?=
 =?utf-8?B?UVJnb0kvSk9CeGRLRHNXNXRCQjd6TEc0aXBHdzczMmY5U0NFS29EUFVSZzFX?=
 =?utf-8?B?cDgvRmFzdTFmejlmeVVtbGtGOURUdFdiVGhxZjlpYXliWWVYblFtZFRQSDZC?=
 =?utf-8?B?ZVJZNlVZZU0rTzc5L1J0ZTIyWkw2R0FrV21MN1U2RlpKS3Fjb0x0RHR2OWFL?=
 =?utf-8?B?NzZZdmx0SE5hbDc5MzZwY0l0RVVjb3JMQVlPaUxtTUVEVlZPcnAvVnhibG5Y?=
 =?utf-8?B?TUJzZXpvN25ZSkc1T0JxRTEycDZRTW9FKzFYN3lzMS9uS3MxdnVUdUpDTTBi?=
 =?utf-8?B?Wm4wMjQ0M2ZHNHZ1YVo2ZUgveFJCb040S280andpSmUyWXdMNXRRTTRHYUZK?=
 =?utf-8?B?MW1hSkdMSlBjeFBxdjhDNFNsZ2tLYTR3M1JBU1NIdkNwRE9ZZVo2NklzQVZa?=
 =?utf-8?B?VTl4ZmplSnpJY0dHMk9NZVY3aUVhbEtYOVgwNExiNUdTWW5mZEZ1NVo3Ry9V?=
 =?utf-8?B?OEhQSjZ6NnhYZFJWbG1UTmJtc2hWOUVNOWp6bFBHeFE3Q00rUytlVUpPK0Uv?=
 =?utf-8?B?Sm5vS1dMb3Bmc2greWZrOU5mME5BbmtPRWNtSGY5SVFNWGZaRWdoQ0t3dVVn?=
 =?utf-8?B?SWc9PQ==?=
X-OriginatorOrg: Adalogics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38662a13-e239-490d-8053-08da980e4165
X-MS-Exchange-CrossTenant-AuthSource: LO6P123MB6615.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 18:07:02.1274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4a262c48-49eb-487e-893b-c5902e6682ae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czPovdWnJGvuKMlx1LuUaWsFgWMsiWtaGSxGiKkdBMzgJCmaUUfr0pXiSrQjaNF7QF9W83+OGUSSyi/N1RueWSCvJJe7nRtev6LciJIo6vM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB6855
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 16/9/2022 6:37 pm, Junio C Hamano wrote:
> "Arthur Chan via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Arthur Chan <arthur.chan@adalogics.com>
>>
>> fuzz-cmd-base.c / fuzz-cmd-base.h provides base functions for
>> fuzzing on git command which are compatible with libFuzzer
>> (and possibly other fuzzing engines).
>> fuzz-cmd-status.c provides first git command fuzzing target
>> as a demonstration of the approach.
> As I said in my review on the previous round, please make the
> "cleaning up of existing stuff" and "addition of new stuff" into two
> separate patches, the latter building on top of the former.  That
> will make it easier to review the former (as there shouldn't be
> anything that would add or change the way how the moved stuff
> interacts with the rest of the world) and also the latter (as the
> scope of the second patch would be much smaller and more focused).
>
> Thanks.

Thanks. Sorry for the misunderstanding on my side. I will go ahead and
create a PR for moving of fuzzing before submitting another on for new
fuzzers. Thanks very much for your kind suggestions and time.

Cheers.

ADA Logics Ltd is registered in England. No: 11624074.
Registered office: 266 Banbury Road, Post Box 292,
OX2 7DL, Oxford, Oxfordshire , United Kingdom
