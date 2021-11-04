Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2E7C433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 22:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 214836112E
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 22:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhKDWjP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 18:39:15 -0400
Received: from mail-eopbgr60080.outbound.protection.outlook.com ([40.107.6.80]:21473
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229587AbhKDWjO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 18:39:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0cjeJr4u5q0tW2bKpqlrt93gP/RkMtt3X9oa5a8Y0k/mll0x0l9IDmIfyDs3lq+BwmWDOsptADbZdPjOZcK7CuYcu6h8LESbn/X2t0xWLFv6vCz+TFE2ppw/wDlTp6aewAIY6kHomqRkbdGKkGKsAhfIuHplrb41u2lgyWfuzurgs2I/j8Sq5IPj5EE7bWbM80j5uGAsCyXgxkCYczwJv0omgG2pCWnmctyJ3AvDNHphQ4jywJYar405usYQW4rVWAiEIKBAaGLd8UhP0hM507fIVjd2svicSk5a5b5Kj0p8ZTUeQYUfA+eMMALmSJOBzGHTwXy2qs+gDt2DpAk+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0d64ZC9scQUSAh2RWjv89xDsCM3WGjB/Jsidkuk9c+A=;
 b=nsE1K5xZPDoQ41YMYpHaRrmbUvoeQXSpHbcdWlc+VjOHEdxYEOj78wO6Hho7WO2tEbESOnZdL3MJz3NbH5Nd4ZOoiI3b8FxT6vSfLT8RxDqKjDSR3KQRakmi++8HiGKzdcu2I6kofrAk/estJQUSZYA97gW0tGzRwZ8v0hwwRv0oI3ttN6SToNQMBIWy/Vq91w/1g+qk5fFSpFoz8yO0DTO06BeqOdDtN2gn1moaXURs04+NXrRWLhEF04kBEoKoPNrv+ysJOqrD/Zbw64yzKmBmrsb8mn+uEzWbDOLF8OYDk9zl/TlXVlMHt01CRWdcK2SeVjwwrGTXJsNYJXoSYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0d64ZC9scQUSAh2RWjv89xDsCM3WGjB/Jsidkuk9c+A=;
 b=m8IVN2qo+Gbw/uIF1yW4cGJN8E7aAEHqel9QJCSeVYGDaMuzDyzTxFkIqvquy3dyjT8Y84h7xz3Sv0P4cgC5SYxVFUWsBQd7dCbqbS29V1D3qh/4wu0XIEXg5JNDwwK5RaoAesQ7hqVrn2GqueFzWn/DO+KAcFr57q243lSpzB0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4750.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:dc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17; Thu, 4 Nov
 2021 22:36:34 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%4]) with mapi id 15.20.4669.011; Thu, 4 Nov 2021
 22:36:34 +0000
Date:   Thu, 4 Nov 2021 23:36:33 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org
Subject: Re: [PATCH] t/lib-git.sh: fix ACL-related permissions failure
Message-ID: <20211104223633.5j556ggfga43myz5@fs>
References: <20211104192533.2520-1-adam@dinwoodie.org>
 <xmqq7ddn3dlt.fsf@gitster.g>
 <xmqqzgqj1yff.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqzgqj1yff.fsf@gitster.g>
X-ClientProxiedBy: AM5PR0402CA0001.eurprd04.prod.outlook.com
 (2603:10a6:203:90::11) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2a02:908:178:20a0:d22:c58d:d0a4:a83a) by AM5PR0402CA0001.eurprd04.prod.outlook.com (2603:10a6:203:90::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 22:36:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8869cd2-386e-4c3d-2f81-08d99fe38e65
X-MS-TrafficTypeDiagnostic: PAXPR10MB4750:
X-Microsoft-Antispam-PRVS: <PAXPR10MB47500E1B9065863830B3BA55B68D9@PAXPR10MB4750.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4rRqql8ezppHKr6fEVxpTh6fgnDabgqeS2SLajRUdpbO2EMKtxgNPigeeQv7GRwfLNdxaHYBT1W0zkB0sIdRgJpq9GJgWLDf+sAsSIodCH07y1xVZQWfa9M+4yu58jbMGrIJdW9rl0vBoH3Ly4OgGsXkacEW7oLiuKx0HrqDqgbWlKDZKZSDq0AxW5T0ItGah9GQoKAjl4IhguaPUYQt3v1zI9AbOyEg8UxP6iHY9gSQ6UvVbne1kBhHq0McyIzRhauTSiHkmMkVwLmTQkEHkZZX5gbr0buBrEOruAYsmaF9/rYIIwVQ/4wXUXU3gBZ48XMHEhgb0j7wAdZ/ZeFXSi7UMLzJaiBue0+sHTHMQxQBmD2VO4Kli7jqkquAWW5IEnpEDtPo+rMdh6Up+XhW/r45pM8xl9jhE3jWHJsHD+EwwCgUsXh2ATQaLl51chF4Y1H26Zs2gBBKY6AHRRk2aPdn1J7ONOIMqN/1rPy/MtCixFkie7vYM9JVg52bVyXjuqTd8DZPjBZ/Mt6r9KT9utIrAWDJrsiciTh/2JeRhr00DZ4uwGofmIAx0Z3pDpXEmhv62WMpFSSj0wiOQYy+b5ozagLKeJq5yGd9Rv4PhLQPplDU+GxNDSIrQiOHWmdY8QnyK+0EBOUB4NjoIhlQZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(39840400004)(346002)(396003)(376002)(366004)(136003)(66476007)(33716001)(6486002)(66556008)(9686003)(2906002)(1076003)(8676002)(6916009)(316002)(83380400001)(5660300002)(8936002)(53546011)(52116002)(4326008)(6496006)(38100700002)(66946007)(508600001)(86362001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2ZBdk8xQjY0WnBMek53UlJMK2o4aGp3cUs4d0pBTXl0aDhHQjJiZEdMVTVH?=
 =?utf-8?B?UWtOMlFRcDVWMVRzODNnZ3BCY0dnMndNSVJsalpxeHUxM0FtYVRnYzJJMjYw?=
 =?utf-8?B?MlB1U2Z2MVdFWklFWGFoUDJGSkJaRjhqbHlhZmUzanR4bkN3Z1NsS3dMZ09J?=
 =?utf-8?B?V2ppNldqL2RpcUdGNkJQRGZja0lrVzcyZkl4NHJPQ2h1YjJqKzBpOVV5NVBZ?=
 =?utf-8?B?ZzhEdTVHVEFQS2tVbDhZYXd6SmdGMnA2Y3FHMkkrZmpQT1dDTGtVdmYyek15?=
 =?utf-8?B?VXNnR0JPT20zTlBkSlNYaHZ2cERReSttWm10eWJtMmRkWk9pdDFIRmVCYkZL?=
 =?utf-8?B?aXhyeUtCcnNjK1Z3KzRUVzhMNXYzY2N6WnZPaEd3UW5ydERPVE1PSWZoNnpZ?=
 =?utf-8?B?eTlHS2FEYVpWSzRSTzBjTzRNSGxWTnVDenN2QUYwSEZqdGFpOW4rUFJ4Q3RW?=
 =?utf-8?B?dTVhMnE2ZWFsUU5oOFdGZFVIMWt2a2Y0cVE0WWZYc0w0c2ZVWlA3cFJCZSt4?=
 =?utf-8?B?TEdZZk1BbzZva3NMTGl5WjBGbmlNaFNIWXhDSitIOVIxbC83MGFZUlp2TndP?=
 =?utf-8?B?ZkVkRS9YLzdrS08zMXJXTTVZQWV5ak1oL1BVUlhwZE5Mb2IyUXA4OVlyeDJr?=
 =?utf-8?B?SFEvWnZzeW5wSS9MN2hTbXJXN3RwWDhYWU5zb0pHZEE3K0g1d0ZQSG5BUG14?=
 =?utf-8?B?V0hmTTRzdU9pKzBWTHZzSTNFVUZMVzRNcmk3ZlI5bnVqU0k0cC9hSmxjWUJ1?=
 =?utf-8?B?QjdLMjZNUlhpQi9xWVd1TzJBZ3EwVzFjSFh2bjZNN2NrcjYzYWp3T2ZjNHFX?=
 =?utf-8?B?T1ZvMi9qeXdqVlNvRTl6dFJtN1hRRm95cnZOK1lXbmhPVjBLTWg2VTNDVTVQ?=
 =?utf-8?B?dXY4azJMWXZLd3ZDeFpoZEVhbXFHU2hHc0Y5R005clBDNk5QZ21CUHUzajhv?=
 =?utf-8?B?TkNCclBBN3F5eTlWUkFrRjluYTNLUzV4c21way9ZZUhEM0diV1VaRittRWZj?=
 =?utf-8?B?OUNJWlNocDRCY0I2RTdJRjhUWFpQTlN4MHdvVkpnQnN4OEg2TnBTNEw2NVNN?=
 =?utf-8?B?NlgxanZRUnFJSzdOUGRqamRtNXhzeVcxOU9zdGRyQXczaDROeXlUL0VZWVk4?=
 =?utf-8?B?VE1Sdmt3TVM1bmtkTHYySEJJdUp1ZXhaeUFyNXV2SEtSQ0N4cW5LbHl6RWp5?=
 =?utf-8?B?dFM3YkJ2UHk4VHphVTRnUVBIUUxNOWpDNkwxaXBzNnhrcm80N015WS9jMlB5?=
 =?utf-8?B?M1MxQ3NhSll1YVdESWFJTWlzOWNSMzVWVDF4TnFIZm5NTWVJRkVKZGppVEJh?=
 =?utf-8?B?RjduQ1lSL01KL3B4NWRSaW50MGdVcUhiOStFZFBGMU9rUUVpYTVURERreEFS?=
 =?utf-8?B?ZU8rS20wOVNxdGc4UTVJV2cxZ25TeWkwYUpTWm1iaklsd0QyNGU2d1Bac2E1?=
 =?utf-8?B?TlNVNHljcmdCd1p1VFI2aWE1akhnOTRJN1l6N1FFcTEzWHlwazdpOE5tMVFU?=
 =?utf-8?B?M0RpV2Q1cXFwKzBMdFk0WEordGNlL2s4MXVkdUVuN2ExTFBYSi8vZkkzNlhF?=
 =?utf-8?B?NnMwOXFUUm9kS2luMzhMRHlvR28waUg3TDNCM0xRYlRwSGlHdytCeTJVNXlK?=
 =?utf-8?B?dWorYm0zb1AwTGdrbzJuVXdieSt0WjVGa08vTFVYcW9CZ1JRZkRVOTI0TXgx?=
 =?utf-8?B?dGZsdllUcVl4aWVPblNDdmMrcnZFUU5reFhWU3lzejVENU5JU0E0VlczL0dY?=
 =?utf-8?B?UTJyRkVmbktTakNWd2hTUzRYLzkxdWtmQUc2VHlLbmJBQTJCMG9ubTVKRXhh?=
 =?utf-8?B?bCtQWU50b1ZhOVM0RTREOWcrN0V0bVdCd2VwaWF1VzZvY2pLaXl5MC9jU0Fi?=
 =?utf-8?B?L1kyNGpoOXBHVTU4ckxEV1FlV2VXelRTbEVtMWlmTTQrOW1iR0Q1aWJiNkh0?=
 =?utf-8?B?MDFoK3ovU2k5cjN6WHByaFYvejRMRy9Ddjd0MnBYRTJIQVluV2ZLMHh6OXJX?=
 =?utf-8?B?eUx2VHNBTStmOTd2YTRYVWRvdmNONGVOL0ovWjZxcUlmV2dmbjNWaThtS2Uz?=
 =?utf-8?B?VkdvQlgvTFYzTnV1Nm9OTUpPdnJnVnFqcDlEUFB1aFI5SUJGYlQxaG1wZWQx?=
 =?utf-8?B?aVIxTlFXNUNkcEJqeU1GcG9QU3ZrQi9ZY0pRQzNHUS9hd05uNHRsWlZSUFdy?=
 =?utf-8?B?K25DT0ZoY2NpRFFGeGE4NjcwYkVxL3k4WTV2NW4rb3dpSkltM0crS25WY3VR?=
 =?utf-8?B?K0pELzNCZTJjcVlwOW1QVWNET0psbWpuMXB3UWVRekM4Sm9qQ2tmcDNpRVEz?=
 =?utf-8?B?T3RpUmE3UGZBSW5nbk83eDFWZ012MEg2YW1FRk04S3NncTZiVnpnZz09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b8869cd2-386e-4c3d-2f81-08d99fe38e65
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 22:36:34.6338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uh07JyGvsgrKNHx3tiPuXO0DTlYk1mbmAHrmLXD0yVDjgvBYP93KgfJ/9T3Adbu4Dk9MjdeO6jQY0sZO8z8NckVGVlAKJRja1+2TLcjc39U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4750
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04.11.2021 13:03, Junio C Hamano wrote:
>Junio C Hamano <gitster@pobox.com> writes:
>
>>> This change is required in particular to avoid tests relating to SSH
>>> signing failing in Cygwin.
>>
>> ... I am not quite sure how this explains "tests relating to ssh
>> signing failing on Cygwin".  After all, this piece of code is
>> lazy_prereq, which means that ssh-keygen in this block that fails
>> (due to a less restrictive permissions) would merely mean that tests
>> that are protected with GPGSSH prerequisite will be skipped without
>> causing test failures.  After all that is the whole point of
>> computing prereq on the fly.
>
>The reason why I wondered about the above is that it can be an
>indication of another breakage, namely, that we may have tests that
>require a working ssh-keygen but are by mistake not protected with
>GPGSSH prerequisite.
>
>The test_lazy_prereq block you touched may refrain from setting the
>prerequisite on your system (due to the faulty test here that you
>touched), but if we had such unprotected tests, we still will run
>ssh signing tests and they would fail, due to the lack of the
>prerequisite.
>
>And fixing the prereq block alone will hide that other breakage, at
>least on your system.  Hence my question.
>
>Thanks.

The problem is that the ssh-keygen in the layz_prereq will succeed but
might create a private key with world readable permissions. Only the
remaining tests using this key will then fail with a "your private key
permissions are too restrictive" like error. If we would like to make
sure in the prereq that the keys actually work fine we would need to do
a signing operation with them in it.

Something like the following call would be enough:
echo "test" | ssh-keygen -Y sign -f $GPGSSHKEY_PRIMARY -n "git" 

Not sure if we want to go that far though. The setfacl seems fine to me
otherwise.
