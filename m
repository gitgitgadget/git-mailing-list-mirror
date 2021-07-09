Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91927C07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 13:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7168261370
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 13:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhGINnE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 09:43:04 -0400
Received: from mail-eopbgr660099.outbound.protection.outlook.com ([40.107.66.99]:18512
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231482AbhGINnD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 09:43:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Va1rnQh0mwzsiJ/hdU7r1XYWLaL6GYpRq9C9zbEkt6mByox6dr6DJmY2iguXKzoY5XNYw4AzvDZ5srFcgd7zoZwCA/3HzIzdYLZELTIMDCgGBwjGSnc0+yMBsAevYU9iIZfGXZspBVIZEokm8GJSPZXnKVw4R7zf0GMr1swO7qitwvFg3ULBSUFNyCwBIW5YWCEASw43yONbVFkd2vO02v9O/mcBMAnwAgPtaqwe18SOh4Tp/THohp0GhTYyX2+7ddfisjgSQPd9vqNNv78WDxUrPBGtD2hcdF4sIpdR4B9kpUzdywhLULWbP+ePHUQ8N4L4ye8NJk+5Ez2malSz/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BPEdEdwm3cI62KjANEpvJarOMAqyoDdOi/BI3MqUC8=;
 b=jVZy6ka4FyC3gZIXjW+5s0aTSEcTiYtNAFMHNT7DnGJzCOlXpLQ9R9bPC/P6tT89Tj+38AaCaRd1ixVzLSwDZpt3mrlP6TyQG1cciLlp+PkRrX3yI5e97l0PVJrGjFV6YFI+uN7Xp7jWrkz5ZmGVYHHD86rEngDZ9iTFaKgmvqQxQatR7pZOH4d1T3WojCXtOrL9ON4h+wnmKVwxNDAdzkool06aW7Jm7F2NrCVQqY2u/qMkZivUwz6iKgWztbUIdBNyYeXNC8EfOxI5sNSOod9lj6DA0aG6L5su5rEIOR1O4BzGUd360A95WMBPqZaH+oP/4/CTHG/T26+HbpffCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BPEdEdwm3cI62KjANEpvJarOMAqyoDdOi/BI3MqUC8=;
 b=HhRWoFvewIctuZHA7Tmvexl9e2rtc5sEEiogSSm3p37dL7wvG51TTy9tuYiRwhdf/eFERXMkhRx6qFVrFaqYP/9ciiamXIlkOA4bgWnZDyRqVp9zR6VKSEmrB7+t59yYWF2R8YG2KWUb0AbE/VFm6r74V+ACc5EREiylSL2/rMEdFdRnvqrprWqlk6Shv1nl1JqHU2AiWgZxc3pDdOpGkAbkewnx8pGRVoUaKrqYbmGLLPdcW67fF+FIaDcBm5GHmWG2VD2WJZWiadaZkZ4K7mZ83SsV+1tLwKHeeLZaQa5YXIXy6ZSqK7oSn/1LO/As8zQU3XvUSnSgj/ccwl+5+A==
Authentication-Results: xiplink.com; dkim=none (message not signed)
 header.d=none;xiplink.com; dmarc=none action=none header.from=xiplink.com;
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:30::29)
 by YQBPR0101MB1761.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Fri, 9 Jul
 2021 13:40:18 +0000
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::820:bc85:de03:da46]) by QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::820:bc85:de03:da46%7]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 13:40:18 +0000
Subject: Re: Troubles redirecting git output
To:     Baptiste Chocot <baptiste.chocot@gmail.com>, git@vger.kernel.org
References: <57ebeb1d-f467-6cbd-5ad9-a55cf04dde34@gmail.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
Organization: XipLink
Message-ID: <87f4a68e-3a74-eddf-c4ad-e6674d9f7994@xiplink.com>
Date:   Fri, 9 Jul 2021 09:40:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <57ebeb1d-f467-6cbd-5ad9-a55cf04dde34@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0180.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::23) To QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:30::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.222.18] (192.222.183.158) by YQBPR0101CA0180.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:f::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Fri, 9 Jul 2021 13:40:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00e912cd-2ce9-42a5-e4fb-08d942df1740
X-MS-TrafficTypeDiagnostic: YQBPR0101MB1761:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <YQBPR0101MB17612DEFD22124B7173A8F17D7189@YQBPR0101MB1761.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LAIAiLl+ja1ywm2Q7jUehHWfj19uoviTMdYM8lfMy4gLgZqBDNZeR46Oxc/FCKGv65v3i/EpfW0+jLQ17fj9voSZi38aP9pa41jfVJBhX5vEkOq/JjBEUeJWeFBRZpc7FvfxzlFHHoMojtLJY87H16uL1ZmccDIr64dkHL1Nxde8gcQiJ/579DzCXVtMHJKd49M9VOav4gYGoUOmq+oNTplQ3PxNqR09Tcmui/OzBKOtLt+EZHIo0eyOcjQnF3vFtaGFSePjXk8d0mNIn7VRzdrMnWpMAyMQIgs2pwm1UO17mQCmhOxm9Smci0DO7puOvxdz8I4R8RDAolHCFAy3CEwXHujPvvhqO5tgQPA0LW7or5ttSTmR56Go1hd/bMYVBZt4ch74AR5CU+qXzmhp9rM/tw6ikh2UeYikxatQwBH/hL3NQ7doyfS/pHYLpK8dpBMOf7QFFHQePJpDn1Qr0Ds16bkHPss1oW6Tt1jfEy36X/FGOf76iCdaGUpRqg5nFadXChlsRmI9TW4iK58ikCZEJfYH0+UGCEtlfC9ymy56i6+lihJ2WsDv3H/gUuQh3G2nmog37ggr1HCOcp091DAq7eF8wAmkAMbWwhAvyWQjs9Z6DWFe+0/GlcUMNprw9k1AH0SeRTo4YupxhHQcPpvmJYop1cc5drKLVllP3us9AU+MuzxIz8oxHn3b31+q4GQ6X1aj1a2qrobJuS0ppvLHKWkfTXzJ57fuefsdE18aOAM72c1WnxGFKVdiGFKKAfLl+VfbNTOKY6MvyIPKqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(376002)(39830400003)(366004)(83380400001)(26005)(52116002)(316002)(2616005)(956004)(86362001)(6486002)(31686004)(38350700002)(38100700002)(36756003)(478600001)(186003)(16576012)(8676002)(36916002)(5660300002)(2906002)(31696002)(66946007)(66476007)(3480700007)(66556008)(53546011)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXY3OHFGdXVwYWV1T0FmakQ0ZTY0QUlINVR4cVZFbEs2VUE1a1NSU05xMjVN?=
 =?utf-8?B?aXlkeVJ6K3NBbCtnb3oyL3FaRE5OeXJzZG9mR3ZNbHlnOENMblNMMGszR3J2?=
 =?utf-8?B?Mlp5WnBGM21NdWV1WkJRejAra012cGRZLzdBVSsrM09YVkg0cVJ6WFJlR3Ja?=
 =?utf-8?B?WnZtR2g4UUFuUW9MMWpHTjQxZTIrWXpuYnJjQUc0Y3BBaFplZ3kvOVJZMWNC?=
 =?utf-8?B?ZG5uL1V3dVgzSDhubXdsNU1Sb29sSWJtVzNUbEw5YlV0WjE1OHZManNPdzlO?=
 =?utf-8?B?THFlUDczSGkzMytsWkwxOTBURTNVZzg0TllHbEU2ZjZSc3hlc214LzNqSUV6?=
 =?utf-8?B?Zmw1c2hIYm9nTFlmZUI4cTFSN1JTNERwTjA1Yldtb1RGQlRMSUFZT2pUT2NN?=
 =?utf-8?B?Vi9RaXRLWkZhUGFueTg1VlVxUzd2bGYySFFSWWNhWEdoWTFrU0tGRFZ3Wkox?=
 =?utf-8?B?S2ZuQS9GQ2drUzFJenFUZzh2eFBTbS9aQUM1MHZ6bFYrQWtqZjU0cFQvZ29W?=
 =?utf-8?B?V2dQR2NzVDZBUEZhdEFkQy8zZXlPdkNydHhjREJsanVHMlFuU21zUUxrQTVT?=
 =?utf-8?B?dEhscnJGRmtEMW9ZOGRUbGpwb0s1MjVLVlVSUHNLSlcrZlJqN0xwb3lneGVn?=
 =?utf-8?B?RDhCdFJIcWFkUktUMlVVV2lid3ZjQkJVU0ErUTZnUmd4NnMyN1Q3VysrZDJl?=
 =?utf-8?B?RjVLVWpJZXhhZmVWYTNJRXVlWjA4VmJqWGxJMzlYUGpXNUF2b2tGMk9lLzk1?=
 =?utf-8?B?aUNFd2FzdkxreE1nVFFMMlNZWmhXMVlvNUs3dkUvVlVUSGtrKzZQMWRuY0Ja?=
 =?utf-8?B?Ym1sd1oxcUF3OHZnQjhZVjBVU3RXTjE3OG9na3FaN1lKNWlRUUtUL0RPaitN?=
 =?utf-8?B?c2ZmUkZWTWI5cXd0eHNkcGhNQnpiVFozdTN3d0VIeWw5NVUwcDBIWWkzV1dw?=
 =?utf-8?B?b2Fma2E2RXRnZWJEKy9YdHkxY2tUUXlnNVlVRzhFeFFJMDE2ZUNvUEYzVkRD?=
 =?utf-8?B?UDBiaHhwcDU2RFFGN0FrczNYOTBHRmJHSFE2OHd4RHh2SmQ0cHhTTlRGZG0w?=
 =?utf-8?B?Z3dHMDdjQkVlSnp0UWZTNGVHQkhrOUE2UGFBZDRUTTB4THJhWkgzbDYzVEpC?=
 =?utf-8?B?ek5wNFdwSVBNdktpL0N0bXdIVHBwQlFNcVJEVXNQNTcxNDNyNGdrekMvSnVq?=
 =?utf-8?B?L3p0VnlUOTBjbGR0WEtTbkl5QWNoUG9RbzRqcGkyaUtDZEpoU3RWVnlYb3Jn?=
 =?utf-8?B?VERUclRIWU5CT21oVVdVQXhuVUNzYkpDaHRCaE9LYk03dWpZREl2MzBRbi8x?=
 =?utf-8?B?ak8yQlFUWGVSMTJ4OU55VGp0eTVtbiszUXA4ckRBRGtMYUk2cHNDNXBFWDhs?=
 =?utf-8?B?eGpGck5ocDRwTXd6Sjl1NFM2ZExzaVJZZm1JU09qRThzdU9NUE1UM3dMbFZO?=
 =?utf-8?B?RzZYWVZURk05S0pmaXF1bDdoQktGM05qNWJjWmwrbGZhVUNtT1lwcllqdmJP?=
 =?utf-8?B?bnlndm8zSk5jZm5tVXRpWmk5UldWUWp4cUNVb3lGR241OFNEZFQzQjdlNVV4?=
 =?utf-8?Q?LDoptYyRKE2+aw4QUiYp7twkw=3D?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e912cd-2ce9-42a5-e4fb-08d942df1740
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2021 13:40:18.6034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YIbrZaJX3neH4AAoFsyjbIrXxEd4C3TAtPRjLuNfdbHF63LVUJk9N5TSti2y1dQrwnZUYKTx6MxszILN37Aug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB1761
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-07-09 7:59 a.m., Baptiste Chocot wrote:
> Hello guys, hope you're doing great.
> 
> I'm reaching out today because I cannot find a fix for my issue. I'm 
> using git 2.25.1 from the debian repo. I'm having difficulties to 
> redirect git stderr, here is an example:
> 
> ---
> $ git init
> Initialized empty lol/.git/
> $ git branch >&2 2>/dev/null

Try swapping the two redirections:
	git branch 2>/dev/null >&2

I believe that standard shell behaviour is to apply a redirection 
immediately when it appears while parsing the command.  I believe that 
although the man pages say "redirect" internally the code just 
*replaces* the old file descriptor, e.g. basically something equivalent to
	stdout = 2

So when you say

	git branch >&2 2>/dev/null

The shell sees

">&2" -- The shell redirects stdout to file descriptor 2.

"2>/dev/null" -- The shell opens /dev/null (as descriptor 3) and 
*replaces* descriptor 2 with the new descriptor.  But at this point, 
stdout is still being sent to the original descriptor 2.

When I redirect, I'm in the habit of setting stdout first, then set 
stderr to stdout. The numerical ordering helps me avoid this mistake:
	git branch >/dev/null 2>&1

		M.


> fatal: your current branch 'master' does not have any commits yet
> ---
> 
> Is this an expected behavior? I find it weird not to be able to silent 
> git. Are you aware of a workaround? I've been browsing a bit but did not 
> find an answer yet.
> 
> Thanks for your time!
> 
> Baptiste
> 
