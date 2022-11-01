Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E16DC43217
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 23:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiKAXKv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 19:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiKAXKW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 19:10:22 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2050.outbound.protection.outlook.com [40.92.58.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E290620984
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 16:08:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmGYmvm/ruuqNCSu9g84invTbrR8vXaN19tWbGeHpZK7SKjgcQBBUOeqS+Ya9OXkkC6V641SCV5D0F05p/mHq/xKuvlBHZtie51QmU8ngxxSbdWaa0zCxFHLPXx0ZCTBQc5n+2VfPAgDGDO3jXfhoq3AKonNiAN+ct5IvVYrGduwvzymMjkhsY9WgVcGPxl50K04dxBIuPxcToVADdffa0qxMRQMjOGfQ6vgIVvsc7RRbcG2W7daHAIoB6ml7dLRCtqQIyySwqkUCVtMFNAVuEhU4qXXLJ0g6/vj9zm/+PI7eOvcbhk1CKxKrvo8voscdthmiyPGRte87/xQlIuedg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzxpuQpA1aAb7WOnZ72p2eFdV7N6I3Bt5nJ1QhHB9Os=;
 b=gQzT355DTOEy/4q5x3pezlydQ6rc1uWdMopdbVNcBV6jISinpUtIY5vYSvpXRtP1r1pkkb+YAY1cwp1KECHlMWP6o9Og2tF9w2Ej0zTD6lhjDyNRpMOt1yU8eChNWPpossVtK6UXFMcFmc/ePDouMVaqoyqpJYKZS9NlPOCc3xCEPf58KNq5C8VKlqgJvBE8CwF6CmlRbpgPRpuXQBO8sRBLm60toAhsp8c4CBA/8MGDBSseIaGm21p03or2mYfdnyY5PF3x4LVFKERa4fd18144rtu+K6xvdzGppS2Rg3vc+DwtPjKht77g98e0ACqrntDsUXZ9KK6K1oECChuSIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzxpuQpA1aAb7WOnZ72p2eFdV7N6I3Bt5nJ1QhHB9Os=;
 b=IhGP8fLrzXBd9tk2IyKIYVCEBulRJXf9n5Zn4YU5k5fvUtiN7pUiUvHCZX4rG19t1bHvSjSjNqJFOgr7fp9f5VW3cGmblfS6NiC5RP1SZx5JheXqJJe0ewOeAkvlHsmu/LnlAMsT2y0vdiWBgJ+wWTSgSPdJgH1P/EGpBKH8qvYU4ruaEGtZVBijURvs0+ckdMrjD9l+kE9n4VnFAzYxzQY2i7E7pb/vh3R/evjj2STAn5c7JPcx1uaJy3gc76xqYYhZwbl/Ku9IItft79WQecE4LFzxh8snsPF1WiQr1OQp3UMWHYmrp0mSAVJbzuu2UCW+XO0FRJmiH2++U1uOpw==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by DU2PR03MB8122.eurprd03.prod.outlook.com (2603:10a6:10:2f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 1 Nov
 2022 23:08:02 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::a3b1:6b8c:97ce:8e66]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::a3b1:6b8c:97ce:8e66%3]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 23:08:02 +0000
Message-ID: <AS2PR03MB9815C34D7DB3C96CF1D0CC54C0369@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Tue, 1 Nov 2022 16:07:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH v2 2/6] credential: add WWW-Authenticate header to cred
 requests
To:     Jeff Hostetler <git@jeffhostetler.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
 <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
 <0838d992744a4b06523be6df0edb046ebba033ee.1666372083.git.gitgitgadget@gmail.com>
 <08de9e0e-af08-2bc3-6693-7bf2b798f20a@jeffhostetler.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <08de9e0e-af08-2bc3-6693-7bf2b798f20a@jeffhostetler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [SSSyROqYOEOaY57Q5iW5wEo+2ZPpTLauJCeVss7+9yrvT7HLUqpC81xrD49gvR+o]
X-ClientProxiedBy: BY5PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::36) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <c6e9bb3e-6a40-02b8-522b-1508b383d3d7@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|DU2PR03MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be9af89-f935-4b9e-1ec5-08dabc5dece5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tGPUrj8sW3MrlOQZ/4jl0EuBpQ9Axy2IPV9qr+JdQMeu5w2ob30Y6JvEukwN3PQ3KI23PHbfjcQvbCA5W1aqPLTCN5406ctGS6AzqWeQJu41XJiR6GnxsPA3ZhYdiZf7Lor3EyuM7/uxHEHMW4cxYVHdpUfxPf90IVVV3wfXoATYqCOnnfjD//Zqps33S2AlhdIaF2mfpno8u+j9f9+/QSruvNGf9t1+rHqUSaLv5zSZN5FpW98MD1QuJVRrQZUD+L2z4oesjLDq0wWzN4uqxcefBbX9Uy3Il91pF1EbzuT4Uv04ZnXRxbikqB+BuML3NVodv8fxoevlhDq0lmdnwopMpxBpLomEY2wC5lEKvGL574wm4qb6eQm6/z/jKXVQlR8E3o9/L6UK8pqUYrZ9JmFs8GVAUxohXeB+QWiD9RR5wNliMOUR6Q+o1ch2MCxH5wPH53d2S3Ii7NAqsqJ/nkhA8VMXXGUI1Eg9lgELtF2IYcp/rrOCYK067yPY0b8LSLOYyYFGQDYEwA/dHHiv2MZy0lGtWSCGOE3RNobzeOr7hZ4b4+W6U4MDYQWY3hYl1bwv5ChByEPGIDUBjMZgufWl6nsUBGGaO0czpM47IQRByL1HgYU62cbxZZrBRO/z3grZNiLrcJEDSg/mofBOSvaLwCUxb1k4bT9FX68J3yqTnCT5nk/8FR1p6JS+lc82
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0dxVVJiR0k3NllBR0NOYnNUU2ROSWpNR1B3blhMUFkxcDROVEQ0ZDV5aVpG?=
 =?utf-8?B?Q2U4UUhNUjF6dGxqUHAzS3k2L0pGOWZxanJsY0ptRCsrUzU2NmJCZ01uaU1G?=
 =?utf-8?B?U1k4a2NseW93RG9Gb0ZkMkdnS0tLY2p6TmsvL0tDbGRNWkVKL1NVUjI5b1pH?=
 =?utf-8?B?UHp5MG1TcVRhblVSRDZRa2cxZmhBb3RBSDlYVVhYVEovbnVCaE80dXdPZ3Ez?=
 =?utf-8?B?UUg1cUhkZkJnS2ZHeGxjekx4MFYyVFZFSU55RVV4TXNRVUh6WElWalpJQjVz?=
 =?utf-8?B?TG1BMjVsbm1BR1BJTWxKOENGczNUeG5KWVZ3cDZQa3F0QUl4dVFidXc1WUJR?=
 =?utf-8?B?ZG5uSFltMUtiM3hwMGhCck9wbFFLY2w0a0h1dHJoY09pREJNbU0xNVhjT21Y?=
 =?utf-8?B?Q2ZxK2M1TkhQcFh5MmVHQ3dmZytzL1MwUGZybHhNeUR3OVF4UktmOVFCblZl?=
 =?utf-8?B?RkkxSGJwcm9MbVU1ajk3OTZLNTVkeU56emV0V3lDNStEbjYzVVNaSFNzWVU1?=
 =?utf-8?B?NE55TWE2alFNeGwrNXBtN3Z1S2hzS1c0cFhua2Z5aXNWdDArL2p1eWIrRlFN?=
 =?utf-8?B?aHhkSGpvOGc2ZGlsanJha1hoNWRiNU9rSnlVcDIzK3RJQW0rR3ZRKzRnaUpi?=
 =?utf-8?B?ZmNaMjhNczNpckxtNVBLRnlvUEZZZVZzT0dlcVdMaEFza3BMQWowMVBLMGNU?=
 =?utf-8?B?L08xOGJhSmFpYWlkMHZtTkRYd3B3aDJtQ3pZL0xleFo1Q1h5TlVJMHVMbUEy?=
 =?utf-8?B?emhGZFdrWUdWR1htYmF0TkU0eXJBQkNIVGNud2ZxQ09nZllxU3ZINUE3YXIz?=
 =?utf-8?B?VmZmLzdQUkVRUEt1VGMxNUlWd2N6cW9ZdDBkbDA1YkxXVWxKM1Ayemd1WWJq?=
 =?utf-8?B?YTV3TEd1SXJNZHhuek1OOXd2UXc1MEdxNk9TVzVDcURRSk5XMkJ1NjhuOHVY?=
 =?utf-8?B?cjdmRWg5cVRJMDkxNjk4bStKU2YzbndTdU5PalZudnN6RzBFcWRKK3lUZytZ?=
 =?utf-8?B?RGNYQ0JwZmJQY2hmY3dsVWdrNThIeFFDeFJIaXdpenJuV0hoTytxSFFUMEdC?=
 =?utf-8?B?aEh0ZmhYMGwwYXZkb2JjQVJXaDVlRFo0bHhSR1pTZkd3dDFSSERiL1RKWmhJ?=
 =?utf-8?B?QWlhaG5JUDByVEZqZFlRYzdqczZSVE9kYVAvUW1FTTdON1U4ZWFwUHgxMjRO?=
 =?utf-8?B?RkFGVTVMaDVLdlk5Q25Ga0d6cjRPNXR3VktJRXJ5Y1ZiQnMwaFQwNjJSbEJn?=
 =?utf-8?B?cjNxQjY1VnROVnpYMGtKZ3BCMzVzWUt3aWlybDZNdXpLckVJejZaWE44cjFF?=
 =?utf-8?B?a1hjUzNZbllGZHNPZVM3eFNjTUhMdkI3dUl2TWtWV3o5dzlTY0VXTkkzdnVm?=
 =?utf-8?B?aGRlajFUUnRSb1dJd1FaTXl6ditrbGdZQTBQNnNlNVNwRUtIcEY5ZkhYc05C?=
 =?utf-8?B?Z3VVMXlGQzBUSFFKU09RSjJPWVU4cG0wYXpJNk9sWk12MWo3ejhXV3BvNS9y?=
 =?utf-8?B?VVpqTDU2OEY2aThhczRIQm84V09ITnlSSUxSSmgzL1J0YStaRFZEVkdEekJ1?=
 =?utf-8?B?V011SE4zTmZYazRXeEE4ZjJTUjJkUVBHTVRIbUJPZXZBY0ZwdWU4NVdHK0VG?=
 =?utf-8?B?WmphV0M0QXl6Tld6VGZ3S2kzQjVZTWJ5N0JmUUNwM2Nia0xHcmVsT0dwSDNu?=
 =?utf-8?B?bGE4Tm9LM3NDSWdwVTUvbjl3Tkp2NUlqSWYvc01XNmRKUDk5R0NTbE16ODNV?=
 =?utf-8?B?dTJkSGZUSTdrWnJIUklxRm5GdW1WdzY0VmdsQ3Z5dW8vakoyQlZ6ZTQ2U2NQ?=
 =?utf-8?B?bGIyL0l6YitxQittMUJPZz09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be9af89-f935-4b9e-1ec5-08dabc5dece5
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 23:08:02.7672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR03MB8122
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-10-28 11:22, Jeff Hostetler wrote:
> On 10/21/22 1:07 PM, Matthew John Cheetham via GitGitGadget wrote:
>> From: Matthew John Cheetham <mjcheetham@outlook.com>
>>
>> Add the value of the WWW-Authenticate response header to credential
>> requests. Credential helpers that understand and support HTTP
>> authentication and authorization can use this standard header (RFC 2616
>> Section 14.47 [1]) to generate valid credentials.
>>
>> WWW-Authenticate headers can contain information pertaining to the
>> authority, authentication mechanism, or extra parameters/scopes that are
>> required.
>>
>> The current I/O format for credential helpers only allows for unique
>> names for properties/attributes, so in order to transmit multiple header
>> values (with a specific order) we introduce a new convention whereby a
>> C-style array syntax is used in the property name to denote multiple
>> ordered values for the same property.
>>
>> In this case we send multiple `wwwauth[n]` properties where `n` is a
>> zero-indexed number, reflecting the order the WWW-Authenticate headers
>> appeared in the HTTP response.
> 
> Here (and maybe in the cover letter) you mention `wwwauth[n]` and `n`...
>> +`wwwauth[]`::
>> +
>> +    When an HTTP response is received that includes one or more
>> +    'WWW-Authenticate' authentication headers, these can be passed to Git
>> +    (and subsequent credential helpers) with these attributes.
>> +    Each 'WWW-Authenticate' header value should be passed as a separate
>> +    attribute 'wwwauth[]' where the order of the attributes is the same
>> +    as they appear in the HTTP response.
> 
> ...but here you don't include the `n`.
> 
> [...]
>> +static void credential_write_strvec(FILE *fp, const char *key,
>> +                    const struct strvec *vec)
>> +{
>> +    int i = 0;
>> +    const char *full_key = xstrfmt("%s[]", key);
> 
> ...nor here.
> 
Ah. This is an oversight in my v2 rebasing! Will fix in v3.

Thanks,
Matthew
