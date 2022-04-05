Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1F9C35276
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 09:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350107AbiDEJym (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 05:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344367AbiDEJTf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 05:19:35 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80139.outbound.protection.outlook.com [40.107.8.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65651316
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 02:08:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTd3yT4j4/JdQ9J4MGnW7q46qbu3Lc0w/nTTaPe8bGCZKsCvjZ9ZOQm51chu3HEhwJC6AKHK4cgjdYH5ydh6gIQ2M/P0kLTCorrPPEjNC2FLYbbkDn7me73OOH+C9F28SZ08fZKDouaYOFbNX8DDbYHjg963Nl1rg+rz5mNBcdO9IoGk9fxdApUXrv0ZP77F3o8ZXrEuM6zAUsYAZjSMlTTbqut8NDUVc9Bx9GIh1VYhKGYCc/1pUFxHYrfztFyl5y324uLZfeYeYJmG4HuUY2V29Ka1Tc2qhk9ztxsJQxoOgNJ/hqKAeopDXODgvbsTXjY13LPZoifxh3bHN4KCpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fvcy/6y7n/PLdmRqq6WVdE1RPHg1WZnP6+rq1s1MbSk=;
 b=WksLSJ63kQqdhaXwRdDCd/lkY1so8eZdEh5Ngq/MiDyldOV3ulNgx8wQ5YZ11cqIrX4b53S+xArvgTGS2MTvzQRRMWQofl5A1I6Ptq8V7R+/okitsY9UE4Rc1/T6TYGUcEM7RZVx4xe+pGqn7elS2SH8sK2pDY+Vzz6dIKHp+lN78QouwBPqXUwVByfs4GahPAtAdkLvvgaImDjb7RdM3svJYmcAJpHu1CJdnlN6OtJnJtaaRYGUhrpjFrTR0yMo0h10NIrd7KNoA1wgXkmsqPCJSj5mKTJpDcBYgYbAuw7jEoNqJR37/VYaTCBrWrRb/yUbHpfiH++mWvYyKnT4RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fvcy/6y7n/PLdmRqq6WVdE1RPHg1WZnP6+rq1s1MbSk=;
 b=KLmJt/GI7cUMsMw2X94NZZ2TwGZc3dAXHId0p9l5XqZ+DGMsaytGz0XFeTqvwy1v6LveVMBobcEGJkk/W6NiXQi4Mnz61a+PE9zx3FK8oYy4ktf+bXCGnV9WHiGL4EJEscaqMJqWDGjPH0MSDEw147J7HVZea4dqi8TsMwt3f+I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::22)
 by DB6PR1001MB1463.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 09:08:02 +0000
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9c95:6717:4f50:ded6]) by DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9c95:6717:4f50:ded6%5]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 09:08:02 +0000
Message-ID: <420575be-1e0d-2c3b-ca5e-f9084688dcbb@prevas.dk>
Date:   Tue, 5 Apr 2022 11:08:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Wong <e@80x24.org>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: ignored signals are not reset on execve
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0601CA0025.eurprd06.prod.outlook.com
 (2603:10a6:203:68::11) To DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:34a::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 741ebe81-e8c1-4fd7-98b8-08da16e3c9b0
X-MS-TrafficTypeDiagnostic: DB6PR1001MB1463:EE_
X-Microsoft-Antispam-PRVS: <DB6PR1001MB1463348A5EBCBF48E3EF21D393E49@DB6PR1001MB1463.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RA81tpHSRcF/D+BF5l0DZfUgRgRzY5OZfNpsAzVge3zsEC7Q7lLtZPGkRGBO6wZw5Ra4bIT6xUu0GnZxdlXCBrAKXv3FfdXrOEvNfxfqMGEZGgjsstLObYk1IQURKiVMncTgPyexFlXSbU5t7JD6g8qwDXWPrzHGLPEQvgMDW4I/1gNO4ttSZJTIyaUWbh9VWcXea4qXoc3CbldwWgirtJUG9bpMha79oVHT4vkYERNwa9vhObWFY2QiaVfZAYKv2mPrDrdiSu3JBY5ds8IQq/u1GVaqvzSRqzkUIoq1lV4Fi1YYWj1EpkHFUmv3l4AUqyfo86E4PE02DK/kfxaUgFzrw98vJEiwyujcdhNOoH7CiOhBA4Ww38azed6f6f8JpdoyRitg/wxB1ex9+45ALoX2Y3MTuyHoiJc/AeDmVbiZ8D/m7hBM5MPb23mtGVBBe5ZeRsq2vIM22Gky9NS/2Sh9nZ4/H+oYg5kiaCcmzte+gug9PTlJGrDDPeM8XG3wp5lfMgTbXBpx3LRjWg0gHot/ntttI7UpIqHyFhsLXQ/2fdmyXbJErXV4NTM2WKVV1t1hA7BIAzHb2L/Y2cXjU5s3ja6NAgrWJYpbvojuQ8z5NTYvrBr5WdxiQH5v1KmA1r7b2994H9wyZFeIL0cCCdunuyzPEnv5JKr3/PpJMNdxHiGhb+RMFIWEbVm7bFc6Ftj/Lc9Dn0TuPNRRsK8x/mBnscQUvLr+y6/PG8jG3qxZ8CMazGquq8rfla9q2puxo88LL7vMCEf12WqjXosHJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(31696002)(38350700002)(86362001)(52116002)(44832011)(5660300002)(4744005)(6512007)(6506007)(186003)(26005)(8936002)(4326008)(8676002)(66476007)(66556008)(8976002)(6486002)(66946007)(316002)(508600001)(6916009)(83380400001)(2616005)(36756003)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWJkNEpVcTNRVmdXZWVoc0hydzlrQUlCMmJVemtYTGFPN2VYRmt4Qlg2WDdY?=
 =?utf-8?B?YkovQ1lLVjlZT2c3cGYvTWNUSWttZ2ZiajRYTCtNUnFKaUJ6MmZwQWh6a1Fk?=
 =?utf-8?B?eXdXQTZxWXdXaXVQeU1zVGMxY3hRam5nQkdZR2lYVTNxaEViY1FGZ0o4QUZ2?=
 =?utf-8?B?V3ZBenFDR1EvSDh4QnllekJaZ1F5RXdobHozYW5WdVgrc1ZsbmZRSzZMN1F3?=
 =?utf-8?B?WjRBbHlDeXVzU21FM0N5ODk1T2hITTBnUDZHZGhCRURmQ0ZQWFNxbG01cTh1?=
 =?utf-8?B?YWJQYnJOZExsSWY4dVI5QzhqMXhhTUdjQlRzSERXMWRla0NOTmtlVU40NURU?=
 =?utf-8?B?QTZZYmw5azJDeFY2UGhEVDZodHQzdmVpSnhtWlVqZWdkYS8wL3FWYXNxZUZo?=
 =?utf-8?B?MU91cXlrdkt0c200c1psVDRlNWVFL2VBallvbVY3SXU5c2FUSW1yZ2VyRnkw?=
 =?utf-8?B?Sk9Ta2xBT2l6QWJKVjBOQktST05tb1RGVm95SUFmbXh1R2hnLzE4bGprNDRt?=
 =?utf-8?B?bmRCbncvNkdlaTV2em43OHQzTVE3KzkrSXNTMy9kZFJmOXFZY09OQnRZZW5Z?=
 =?utf-8?B?Smxsc0gxMkFZZGQ2OWFnK1UzZXVRbklQVW9YbFZES3RES2YvUmhzVWtUOEVu?=
 =?utf-8?B?bk9XMW5lUUk1bkxqWGVLRTdHdjZrWDRsbjRNdUYxYjI5dkpWWC93RndaaFJF?=
 =?utf-8?B?eldBekZ1S0ZtVjBnUmQvLzl1OGVpa2RkZUtNaVpkK2ZyeEJMOW5laEQ2TWp4?=
 =?utf-8?B?YkJjM0ltQzZVZjBGSlM0UzNiVjFhOXgzL1lwWFVPejVJQ3l6S0VMUVkrZ3FN?=
 =?utf-8?B?WWIydHI4T0FlaTFST0JtQlNxc3VtcFZRNjR5Q0wzY21GRlI1SExNaFNEdkVK?=
 =?utf-8?B?eVZUc3FpVjFhZW4wREx1N3JienM2dkxIMytDbjJPRzBLejFDdUg4N1RtSFdZ?=
 =?utf-8?B?TUplOXpDbTJ0TU1pVXpUUXhCUjlJOHQyU1ZKL1Rsajc4ekVlQUxPaGgzeTAz?=
 =?utf-8?B?cXN1Rk51bEpkQmxUZTRhc2tRdE0xRjl3Mk5IV1JJQ0JiMSswT0UxWDFJL3Fa?=
 =?utf-8?B?d1pxcnVNaEpZVzhldjRzejFiWU9TeksvTTdaY1JpZjR0MU5hd2tjWFNQNjBI?=
 =?utf-8?B?L1RCaHVpUUdkOUNLTHVIRFF0SWtudzIzOGtidE8xd0dFdDlXSlhiRTd4ay9q?=
 =?utf-8?B?enZad0s0cks3ZTJHeHptTzRmNEZzOGQwem0vWmFqUzZBMjhtR2t2Z01GSTI2?=
 =?utf-8?B?T2NOUlZZV3VGZmJZUGNoUzB5RUxwS21zalBoSXRiaEliampXTkl1SWRMcks1?=
 =?utf-8?B?amxQcHlaNURkY2FxTGlnS3l0N0Y1dVR3OGRERFpLQnZWbHh5OXluOVRMczd0?=
 =?utf-8?B?bC9mWU9oQjh6czVXaVY1M1V4bkRoS01wMTVGZlBzcDNJaVpKMWIvejNDbmc2?=
 =?utf-8?B?cE1RY3JCUm0xaUJIWm80OHNhTGFZWkRNUG95TG5reEZud0tmY3VYUEExM0xa?=
 =?utf-8?B?SjUvaCtHOTVJTXB1TU8vSSt4TjI0Vk1MUUxsN1ZqWFd5MFd0ak5ISUk5dTZs?=
 =?utf-8?B?bkUzVmREUWlqcHdoZVE3Q0lnV2dSc0ZNMEtidldGc0Z5MG95QVBNYkJXUGJ0?=
 =?utf-8?B?SUFsUFdJN3ZPaVc0dG1KRlROREdyQW11OWFEVWxmZU9ZaG4vaDhYVVdHcTJV?=
 =?utf-8?B?YzlEdDU2K0UwWTFjSW5jaVRBRVJqL0NUZWhaMFV2UElmNWRmSEFvbHdrZ0Q0?=
 =?utf-8?B?amFDamhibjNaRGJuVUtadWFyWWdWdEtreXFpWlZlMjJBKzJKamFYaWZqQnhT?=
 =?utf-8?B?Yk1EVFpVQVVEaXJxeEpGMjJsUmJhNldSQVkyanB6bE5WakpKbUtaamVScmxK?=
 =?utf-8?B?SWlJZEpUdjZjSHBRQi9zMHllYkw3OFFnUm1NY0UwVDVWY1hXRXpCQzc0QXdK?=
 =?utf-8?B?OWpEdkpHTzZWZi9STkRCaTMwejA5d0tmTHhyK3dWS3dhaytyTHlTT2dycHpq?=
 =?utf-8?B?bWpnaWFwUm84N1BFTW4yU1J4OHE4THllNGJjcEVaTWczelZyUzBxYzJBam0w?=
 =?utf-8?B?b1JSeUVyVEdCS012N3lKQ3lMSGhRN2NmT3lhRzZZQVY4NlpTck5scWNwV0pK?=
 =?utf-8?B?VHdkdzkyWEY5bVdlcnFtcGpaM0VkL0JHcVZLU2sxNDVOS1NVckVqQ25rVjhJ?=
 =?utf-8?B?dURIVlNpWXdvU2F1ZjdWMnJ0bmdDRVgwOHU3UGQxeVZ5VElNaEVkbERSU3Na?=
 =?utf-8?B?c0Z3TzRoc1pDNjFSWUVCQ2NKeXdSNHpnYVJFYU9BUHpCV2lBbWk2R2NxUnFj?=
 =?utf-8?B?UFNVM2FEeXRlelg1T3RCNWh2eEN5UHJYOEZSNW85WCtkNWdnTWU1TFRWd2xJ?=
 =?utf-8?Q?vhgks459REmEs9P8=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 741ebe81-e8c1-4fd7-98b8-08da16e3c9b0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 09:08:02.5714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vTUC954dEbEtjTYzHF4XLyjmYlNjNbBsi/MtUVG9Y8sQPbE7t7WzIDND9i/TpZA6QV35jrTMUO0IBd9fzm91aGBngoxXh3cf2BEfReMERTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1463
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

run-command.c has

		for (sig = 1; sig < NSIG; sig++) {
			/* ignored signals get reset to SIG_DFL on execve */
			if (signal(sig, SIG_DFL) == SIG_IGN)
				signal(sig, SIG_IGN);
		}

introduced by commit 45afb1ca9c28 (run-command: block signals between
fork and execve).

However, 'man 7 signal' says

       A child created via fork(2) inherits a copy of its parent's
signal dispositions.  During an execve(2),  the  dispositions  of
       handled signals are reset to the default; the dispositions of
ignored signals are left unchanged.

So at least the comment is wrong, and the child is actually run with
those signals ignored. Whether that's the intent I cannot say, but I
doubt it; programs generally don't expect to be run with any signals
ignored.

Rasmus
