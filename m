Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7922CC001DB
	for <git@archiver.kernel.org>; Fri,  4 Aug 2023 05:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjHDF2r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Aug 2023 01:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjHDF1l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2023 01:27:41 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2013.outbound.protection.outlook.com [40.92.48.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0011BF
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 22:27:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Slr8PLcHSMJAreXsAB1UHVeX65wpcE1eOyh5mNGBLUjnJbuctig7zfrhAIl1nOhUOR080QLURcSyzLFYa9Z2dXd5qlbDdiLC8OoDBGX7nMXX0wXk642uHgAKKJVTAXXVJXuS32VjJPUpe9k7xTeexkxx1RRJnKvP5KxTQLiqsfBiQq4ObpRuHpnAnYP/nzqAoIW/tiwN1N+tnARz9Prs2sn902pARWF4KGVbMHofK7u3riH2NW1i1p4cF3Yb57TFX1QmGCMkZpAOMp8QgFrRe8/97egTXdGcf/pkCt15x9PFMjI4lakI7C6wKkzilKDZfSfDvLJMHJIQGLSmDawEHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QT/lQEq234TrpQ7Wxu/jLSu8aYHMbTdJYb1jRnLpK9M=;
 b=lLk3Mv1RR0QVD5FZEInefMGaapmfdDqBCKbPzGwEaWNw/QlddQADs3JcLsYP6itYX62NFmd/OjWmvKmWhqhi4VSvFlGh83Bzdsldhr+BEiXp5yItcphVrVQFdHETp2f9KybfHh2KBu+jCagUlHbXBDyIxpgi3UxbdSpcHzdrE9jV2cX7mDrCa3v6W6O9CiECmtReMS3DhZQkj9RQqEvjOi9HNgu9Hr3b2/WSYZRCoLUesnvlqcG9NC+3qoK5+9NlYPQLNoKuuW+gMW9tunNYvPv+e+4tdLp51bQ+yxwM7EVw84OY2MtsrFE05ej3yjAQRQuoIq/B74U6fxvoEqHZlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS1P250MB0701.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:48e::11)
 by AS8P250MB0250.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:37d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 05:27:30 +0000
Received: from AS1P250MB0701.EURP250.PROD.OUTLOOK.COM
 ([fe80::83b1:b193:10fd:4b5]) by AS1P250MB0701.EURP250.PROD.OUTLOOK.COM
 ([fe80::83b1:b193:10fd:4b5%3]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 05:27:30 +0000
Date:   Fri, 4 Aug 2023 07:27:28 +0200 (CEST)
From:   =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?ISO-8859-15?Q?Matthias_A=DFhauer_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Louis Strous <Louis.Strous@intellimagic.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
Subject: Re: [PATCH v2 1/3] run-command: conditionally define
 locate_in_PATH()
In-Reply-To: <xmqqo7jn3073.fsf@gitster.g>
Message-ID: <AS1P250MB0701991FBCA2E37BD5238497A509A@AS1P250MB0701.EURP250.PROD.OUTLOOK.COM>
References: <pull.1560.git.1691058498.gitgitgadget@gmail.com>        <pull.1560.v2.git.1691122124.gitgitgadget@gmail.com>        <dc9c0812d203a4eb777659bb54fda60022bf9650.1691122124.git.gitgitgadget@gmail.com> <xmqqo7jn3073.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TMN:  [xo1BM/YCd3HxHdlzbWy5pi2XMja94yiU]
X-ClientProxiedBy: FR2P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::14) To AS1P250MB0701.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:48e::11)
X-Microsoft-Original-Message-ID: <8eb48e2f-51e8-e164-e48f-cc2cb9c55e1d@live.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1P250MB0701:EE_|AS8P250MB0250:EE_
X-MS-Office365-Filtering-Correlation-Id: 26419050-3d6d-46fa-8cd3-08db94ab7f47
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 74yCxoMuHzppfXPzxBnIuHLUTlsO+lmCZvV8/7NNUzsD+XxVFrEmGdCCVPjQxvQE1inEP7l5ifBoiuTfyjEpUFbxtlDwLVkpZF2hjcv3NArfam2easR1H+tzgsXFU2wNcH3wp0QQF2SN2UBcGtxTEJrfYo80U0mLfXlRaQueRkradE5lm59FmYEaKo/dlSG165W8ZC87PujAPO6XkoczXqHHdo69iRPZQDoslVo3mye8kpUFoYEkJdHWTqmdyiGClmDNhGD9ZEj10zpW2NuKX9F+O3MqSUNlkar7boXV2p4kTXA2fQ6nFEK81UEqb9ZxBa543qFdu6sI1wu4pixGoDR2bzTe6M+SESOub7BZRsVhAcZmS0SqCVuvfrdkJ3gux6nqNaoO+gIGTKm6LkHgVSUM5ppA+pSAK4yDM4EQ9MXl60YMXo4+DSiZwSVcBCFgEMDU1xGyraTPrHZDm7iCWse7wK44Ch7qJ+cv/jrDOF8vXxuVyiHw0Dxra0biMwh3iYf0BuN3rq5oLe0fO+geGOPVmciFQOfsWZ9F5yCDdR4JexM3XxMSHrV9DkYkQstfXIVb6NzC08bGkA8jscFysEiRYDwX0y1SC7znWlxyTF5iV12j7fZDcT0OnD8cXU3z
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEZpOUlLSVc2ZVVKWm1OeVBwY3pDSm5sWkIzUHVPMWpsV3FCYjJ4ejNLRjB1?=
 =?utf-8?B?bk9WVTVNTnVzZkw4V1pjdGFGK3R5V0JSb3NNNWtBV3RaVFhxK01XekQvQVh3?=
 =?utf-8?B?NzV3N1laZExpZEdzM2VlR2EwRzBZb1p2VDZyRUdmLzRnSHRZTUp4UXlZY3Jm?=
 =?utf-8?B?SnBTbHU2Tmo4REEyeWNvMWQrVFYzQVRvN0FWQ01VOWV0eVJJdmZ2dVZqMlJ6?=
 =?utf-8?B?akU0U3owdlVjRis2bXJLU2llcTFmVktWWUdaL3liMUE5ZGNHL1lhTmo4ODFG?=
 =?utf-8?B?R2hRMHVvM3pHVHQxUU12Z0ZiYmZZUWJSbzlZNDk1S2ZLOWtLSlB3czNRamU0?=
 =?utf-8?B?dy8vbkRUbVZjaGlUVzB4ZVZnZEV2VVJHODZDR2pRTERleWFuUWNmN3dzVllN?=
 =?utf-8?B?SVY4d01BdlFuaUhaRzRzVzY3U2pua1V2OEo1TWJEekxWekg0OEdoT204eUVD?=
 =?utf-8?B?cDNDR0NOa2x1S2diUUpuSi9FT0IwTTFuYllaUXl6djF0YnFQVU0rUHNLRTU4?=
 =?utf-8?B?c0gvNUdsWEdOZUtsa0hNZG5BTWI4d1VIK01XOEZsRnBHUE5iL3ZTNkhjMzdy?=
 =?utf-8?B?Wmd3emg4eE4xU3ZibmNZL0Q4RWVGV1Qxa3cxbzBLeGlnb0xMdCszemJ5bm5t?=
 =?utf-8?B?a3p1RjBQSk53TmFOdktFMDl5eWVQcDFFSHNWVzhSN2lqTjlLNEVnc2RzaFFY?=
 =?utf-8?B?Q2dnOUZSSHowYWMrdG5KSEV6QS9TKzMvOHBkS0R0YVBHSVRjaFhlUDRvdGtB?=
 =?utf-8?B?dGdJRlhtYkRDaTBEa2EzOHRtVDZLcmFCdjVLOFRKN2VMcjF1OE4rM0xGWG9j?=
 =?utf-8?B?ZjJwazdod3FQZ2J0VHRjRmUzSUxUQ0VZR2pndXVvZFZIMFZvRE1PY2tOdEVO?=
 =?utf-8?B?cFlBLzMrZVBlSWJFRi9teGE0S2szZkhoUGQwY3ZlSTJnbWlNTWJIbHVtSEVL?=
 =?utf-8?B?WEhIejRZWFVPSkZkREQ4c0xXeEptWjl1cVpna05YbS90NGs2VkZFUnJwZnkx?=
 =?utf-8?B?QnBjSGh3M1dvY1B1QVZiL0hQd2N2T1g4SmVaRWNCSlc4dDdjZlZLNkY5Nm5h?=
 =?utf-8?B?U2FxSElOckpxQTJHdFVSNHBCRG83WUpldlloWUZ1QjJudEFrWjZ1K1J2M3Ew?=
 =?utf-8?B?Zkt5eFlYaFJ1YUp6Y1ZmcWRTUy82d0lXSHExeFpEWTVHdWtJaHJrdDlSaVhP?=
 =?utf-8?B?MWY3RGc2Qm9lK0toYzNEaU85NGFZWWR1MDdvRGQwSUdoL09kY0Y2Qno2TTdL?=
 =?utf-8?B?WXE5M01Tb2pUS0h1L3lIUWtxcjU5WVJzV2xQKzRjSzdlZ3I0MUJWdUc3WWxz?=
 =?utf-8?B?V2JuY0xEZFVNcXpaazdOMEUzZk9JZ2t3NTdGQUQ4N2Uwc3NLSDdKL09IVUda?=
 =?utf-8?B?cDJmbWJpcDFwN3pZYStzNW9DRHRlY21pUlJIQzZOekRhd1FMWTFOam8zWnZI?=
 =?utf-8?B?RXN5REFQOUFCeGZjV1BtSEw5cVRZZE53cXdpLzNLdHZBTkRqbGpWTW1VTmtH?=
 =?utf-8?B?VVhQdm9LTkJzaVRCZVVKWVluU0FyUE43TjV6MGV0LzF1bkJKVkFuQ3c5Yzd6?=
 =?utf-8?B?Q2FNbE9zakdHUlFtd3ZZYjA1cEFOTjZ1a3FtaGNNVmxDVGFsUUdIaitHZ2ZM?=
 =?utf-8?B?cjZTcTJRWmpTOWw5SDRFSlhrVHA3clE9PQ==?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e3d53.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 26419050-3d6d-46fa-8cd3-08db94ab7f47
X-MS-Exchange-CrossTenant-AuthSource: AS1P250MB0701.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 05:27:30.5496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P250MB0250
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Thu, 3 Aug 2023, Junio C Hamano wrote:

> "Matthias Aßhauer via GitGitGadget"  <gitgitgadget@gmail.com>
> writes:
>
>> From: =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>
>>
>> This commit doesn't change any behaviour by itself, but allows us to easily
>> define compat replacements for locate_in_PATH(). It prepares us for the next
>> commit that adds a native Windows implementation of locate_in_PATH().
>>
>> Signed-off-by: Matthias Aßhauer <mha1993@live.de>
>> ---
>>  run-command.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/run-command.c b/run-command.c
>> index 60c94198664..85fc1507288 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -170,6 +170,7 @@ int is_executable(const char *name)
>>  	return st.st_mode & S_IXUSR;
>>  }
>>
>> +#ifndef locate_in_PATH
>>  /*
>>   * Search $PATH for a command.  This emulates the path search that
>>   * execvp would perform, without actually executing the command so it
>
> Micronit.  The comment should be shared across different platform
> implementations of this interface, so "#ifndef" would want to come
> immediately after this comment, not before, I would think.

I can see the first part applying to all implementations, but the last 
part about it not working on windows is specific to this implementation.

I guess we could split the comment, if we wanted to make that clear.

> It does not affect the correctness, of course ;-)
>
>> @@ -218,6 +219,7 @@ static char *locate_in_PATH(const char *file)
>>  	strbuf_release(&buf);
>>  	return NULL;
>>  }
>> +#endif
>>
>>  int exists_in_PATH(const char *command)
>>  {
>
