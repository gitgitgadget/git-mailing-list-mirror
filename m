Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0ACEB64D8
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 16:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjFVQuN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 12:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjFVQuL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 12:50:11 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54011D3
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 09:50:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxkBehb6q7X7c2a+X+Rg/WLBeq+b7OviBe59wFlGfe37EbAsBQXMqi+TCVbpm4zJmcrgE2m1webzAlRTSOTC5WkczhgXXUJtOoxw+aAlb2C917VEBDtC7YM5YayD0Cqv0hWNFIvpocXtBPWcvlA/APMt3ivFsaP+yeEFvqnAxrEwSOd+Euj15Dkmv4DZuEWZ5asnQZe3S82WmyZmozQ0LtekG+x0erWaLCpBDxu00X99pSrZ2SfK2PaaVa8V82aNJj3yyLGM5WXMctugXcMbZ3ye87IlVjxYTuYVGmTM/V5CasALCvULXIswFFGwVmlLuIiZOHCOmnEn8bJ7PLrPrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgHBXQpOccd9rW36GmZGqNzEPFOgDVezOzrP+blyrDA=;
 b=dpMA5OeUP+TcmVWEJRPepgco9CpHOpE3f85D8Sm4nVVdple7V+HB3u51C81g7ghH1/DqY56WOH/7v5HssH+CqvIkfJr8TtQKJ7s18rK3NvJofwdc4IX4t+/0mLxRxkYubUOa5hxx2wSqapUcK69g6PQSAKQU0DVtgeN333GczrIpse2XwqiamJAjSQWTUhSoK0lXJA/qJKbY24EfkwMAH8y7ixMjC++BmoJzy80n2DPtskzBqTZpSq4yT/RIek/eY0IDTS+YbByTtklo9hAmUclfmHmCTSnmK95CGcctBdjgHuQF7Z2VFqnmCf2uA44DsLD7wGUWqDSlEzYjnnxwNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cedaron.com; dmarc=pass action=none header.from=cedaron.com;
 dkim=pass header.d=cedaron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cedaron.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgHBXQpOccd9rW36GmZGqNzEPFOgDVezOzrP+blyrDA=;
 b=JIEXqSASd5VW+PFzzUsgQXXqv7DXcAbzPi90FvYX1qEk1UXFcPA4PjRqebXQkWcAk8FaWV8FNf5p0sNhUyepj0dFKAD+LOaE6nwprcH6svO0cI+o1Vyv7qFH+l5mcoRTHEdxPvvLkDH1spVq6deL68chxGBexd4OiygNevDvfA6Ep5MDFptrJJnxaULRhDAkrqpa3XoMMFBgdqcOAUam+8eqT8NLnr7oJJECxf7LM0TDSGd1LQfJL0wBirvSyPwssgKKQsU4H9R7ATKgLrw+cYAZWyw6yOJXUtYoUUm7CoFscaD/kcNHiwHOdH/yS0YGtsxtOJpMbjEVK/BAKwABnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cedaron.com;
Received: from BYAPR20MB2758.namprd20.prod.outlook.com (2603:10b6:a03:fb::15)
 by DS7PR20MB4646.namprd20.prod.outlook.com (2603:10b6:8:75::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 16:50:05 +0000
Received: from BYAPR20MB2758.namprd20.prod.outlook.com
 ([fe80::90c:ffc6:cad4:993]) by BYAPR20MB2758.namprd20.prod.outlook.com
 ([fe80::90c:ffc6:cad4:993%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 16:50:04 +0000
Message-ID: <6e1b9ce4-e86d-fe30-e5de-27a3be57eefd@cedaron.com>
Date:   Thu, 22 Jun 2023 09:50:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To:     git@vger.kernel.org
From:   Joshua Hudson <jhudson@cedaron.com>
Subject: Design issue in git merge driver interface
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0006.namprd08.prod.outlook.com
 (2603:10b6:a03:100::19) To BYAPR20MB2758.namprd20.prod.outlook.com
 (2603:10b6:a03:fb::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR20MB2758:EE_|DS7PR20MB4646:EE_
X-MS-Office365-Filtering-Correlation-Id: 94b5853f-d10f-4720-1afb-08db7340ba69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ce6b26xBrXclHS0+aSaNO/VQ9qTxb0XbRCTKrY3PMFhV7koL8x/3yj4IKhXrV4D+SBnroUtlmcqq6X1frzi5B6MEWiUdMMjdRLWoZP4HL0NkIz09OK4J08LUjW0zV3PVwR6ZBDI79GUL0zbiMPVZcjdFqKvKSwRPQrhrVT2UDObBqJrt9t3FFsn1MKRYbWEUI9qjQcvxpof6SPaYfda5V/ev56z5+uFZE/4jBWXZYIikk8PYQ34ZWpWoSTzRMTFAq35o2Fl/NcSG+6k6tCVN6IJtqxUnKSrXnqc7hdbhLPCX29GnjyAs37xREoHwOeG4+rOCFsonH1/uR0/KZcgdrDpYPhvuA0/s2iw/y5/7MJ9hd85J7+drQv6jzg2bs97ZpRe8jinhCD9MEAfsWyRAAoxZTM9JMS4LqHpR7ugTe5iRDPQunQwVuz6SwPsdb45mff6WnzHqQreGPETgUNTiJwXY7zDZrwfVTqYP3OZ7kRTJgjLi5yFDm+v9a63rMiS+AHVKQzi/WXA/btlB/Vv8bxSL2Qjz00oodu0kw6CdXIEr6HUOfVlk/XYZA7yJMhUz0lsfdO9cwbWnu4HIVgOzy2Mv+Ujat809Hpx2pacHhv993vyohZmnbw/QKUnmegIXvzcbCLqh1EF/PGg8WpDTHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR20MB2758.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(366004)(346002)(39830400003)(451199021)(2906002)(4744005)(8676002)(8936002)(316002)(41300700001)(31686004)(5660300002)(66476007)(66946007)(66556008)(6666004)(6486002)(478600001)(36756003)(31696002)(38100700002)(6512007)(6916009)(186003)(2616005)(83380400001)(86362001)(26005)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODgwWERsR3pUc3FTYUZIL0hkMk5uMjBIOUgyT0tNWUVxL01IV2c1d1hQanJN?=
 =?utf-8?B?Q05ISGVVQmQvb3dRakJLd3ZTUkhsYi8wLzhJdDduY2FZZkJuU1cweWwzd0Jw?=
 =?utf-8?B?enZyQXVaKzZoU3laRlJkbFJ6WE00d1Zxbno0eXhPVkgvYjlYa1h2RWVmYXhn?=
 =?utf-8?B?NitWYStqVjhkczBKYkI2WDRDWU5xZnUydVRXREIxMVZFdkRpRUFzZlREdkhk?=
 =?utf-8?B?bXJpQXgzR0JHRUtRemxzYkNOMDBjS2paeGFqSjVFdTF6RjJkWE5xUFY0SGph?=
 =?utf-8?B?djN6U0dBeGRUQWdKeUNmSlI2NzhNSzN3ZHZLRWxFWTNKOEwxejJVY0dSY1hq?=
 =?utf-8?B?NUZBMzlrOE53cld1d0J6ZWVuTlFCbUlMRHgvTTFIRnFzNWVtS0o4TVJ5YUZh?=
 =?utf-8?B?SG9lbWdBbDZaT2ZyVGl2MWI2enRlNjFFS1VWeTQxMzhEdWV2Tnh0V0JvOEJu?=
 =?utf-8?B?TWpOMnc3VGliaGtxcGU4cmVBZFFIcVpDS2VCRVd3TDV6Q3JtemNiY1AwUGRV?=
 =?utf-8?B?UWdQd3RySFdpVTNLY2ZzYlpvY25XSll5MkczZDZQREw1Mmdkb2JqaVVhZms4?=
 =?utf-8?B?WXhqNUR2ZUVUREVtSjVMRjBmdWc0ajQ2b0tXZkFTc1NMeE5Xd2hValJFZHlR?=
 =?utf-8?B?OVBQdHZCNDNaM3o5NUlRTWgzSUJxRHhwa1BXVWw3T2YrSGMyRFBjb3pKRVUx?=
 =?utf-8?B?Y3RDZVRDWkhybG9TN3VGUHFEa05ua0FHU1luTmJ6RG4vTVBlTzBtNmFMMGxt?=
 =?utf-8?B?eXh1UkJ4M1hseCtMYWd2Sjg0bno4YkZ1aGRTd1I0dU9XUG5GYnVFMXNSRmVC?=
 =?utf-8?B?bXBUcXFoVTVzbUZEZlV6dU5aajZFaHNIMmVTa3E1VW1ETy85Wk1uYXU2b0pj?=
 =?utf-8?B?c0tHR0VzM09vYUE1aE5YSkVocDdRaEdhQ05XMWF1VzZLU1M3Y05vUTZxTzlz?=
 =?utf-8?B?eStiWVpXQUlJMHBzQk85WkN6MXpXZFo5eW5hZlhiUGU4VUtBOTVZNkxScEx5?=
 =?utf-8?B?aFZ4YjhuRmFGN28vY3VGTE0yRkNYdTJQZ3BFYlVxUnRHWVVFZ2ZkNXRRNW9K?=
 =?utf-8?B?VWQxYTQ1Znk1cUtZRUVDYTBuZ2htRUZrTjVvdTFIRUo5TmV1YktvUURCdGhK?=
 =?utf-8?B?VFpzSUR4bzhQNXNLNXJieVRZZVdMQWxIeUNXbmNZS1hNV2RaV2JQOXMwVGhF?=
 =?utf-8?B?N0p0dFIxeCtNS01idDZGLzZrcXRkUkVnVTIya2ZzNGVDYzY0ZXdYNzZrUXdL?=
 =?utf-8?B?azhVRzFnUDd1NTkzTUN4SnJ1WE0zZU8zQXZnTEtaUlBjMGQraDlwVktZOTJt?=
 =?utf-8?B?c1hYSHZkeC9aOWdDalNlVVoxa3JkSktXSXY1Y3NvK09UQ2V5QnpKYUdEK1FW?=
 =?utf-8?B?ajRxSzZwSVlyTm9xL3ZUTStxOUFUQlExTEp6cjZDR01vdkJvSm5SZVE1SUUz?=
 =?utf-8?B?S2tObUVsb2FRYW5aY3JVZjZLSUNVWXowRTJjTzJGVjJuTW50MUdJS0FNdkRY?=
 =?utf-8?B?MEhaZlFmekYvdGhKL3dnQWxNMHMzcFJ0ak4rK2cxK3hyWTJxVXVTTlZpdHVH?=
 =?utf-8?B?cGFod2wrV1JCSkduSDAvSzh1ZkEzUW9NUjRFcXV1MzZvZ21MaFNPYWU1MkpZ?=
 =?utf-8?B?aEtjMlZsOWtWc1hkcDZJQkVUS3dGQUFRZFNRdWdaOXZGeWhIbXBkL2RXbU9x?=
 =?utf-8?B?V0pSTUtYWEV3QytGQWZoTUVaRXcxY29rajlsVHc3aVBOWjgvYWQxeHZ1S2tn?=
 =?utf-8?B?a0xzbW9rOHhkdCtCS1NrMGxzTzRONUZObGRvanJyZFpFUG0yN2JDQzJzakFY?=
 =?utf-8?B?dFl1UGxsTU9HSFcvL1Jseit1aGlmeEJ4WTZxWFU4VTlzUFBBNlVQUWdXMk14?=
 =?utf-8?B?QU9DMGNpaWUvN3VIbWdtK2VOOFAwWEl3b29JYUhiUllWMVRubUpIUklFY3kv?=
 =?utf-8?B?REpML0dnUHluT1JMYXFQQ2Njd3FadENGWWc3Q1M3U0xFRUh4b3dSOGd1eHVP?=
 =?utf-8?B?NlFuUERwdE5Ddm1BYkQ4MWowc1hBbSt3MnA2eHgydkhwOHVaVzl4VVRjaUpC?=
 =?utf-8?B?MXdJaVJLRC9pTmNkbXNRMWdoT2UrL2J4bEtkdXM0OVNFMnQvTzYzVjhYMWI0?=
 =?utf-8?Q?QsTrMTRH0KUAUIdrwv93LxuhU?=
X-OriginatorOrg: cedaron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b5853f-d10f-4720-1afb-08db7340ba69
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2758.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 16:50:04.7392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a1e0d90e-c09b-4bb6-9534-4bb03188f5a0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yMGsns6AX8kahJepg0Vys8NBJOejzkl6njhmrex1bsXhdKsWy/i3R7exDTir5/wMvVeOD6TG/tTnHNGvf9gABA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB4646
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We had a major incident here involving bad merges. It was traced to a 
problem with a custom merge driver.

On studying why the merge driver failed, we found it was in an 
unrunnable state (the logical equivalent of calling abort()) and could 
not mark files as conflicted. Since the users were using a graphical 
frontend the error messages disappeared into the bitbucket.

I've come to the definite conclusion that treating the file as 
conflicted was wrong and the merge needed to bail out in the middle as 
though git merge itself bombed. But there doesn't seem to be any way in 
the protocol to actually do it.

Looking at the merge driver found that some things cannot be handled, 
such as OOM condition. The fault has to propagate upwards, unwinding as 
it goes.

