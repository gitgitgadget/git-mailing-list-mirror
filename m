Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8D6C07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 13:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DAC66128A
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 13:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhGINds (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 09:33:48 -0400
Received: from mail-eopbgr80083.outbound.protection.outlook.com ([40.107.8.83]:64640
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229532AbhGINds (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 09:33:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMda7qqBiUCrfJ8TYEszjbZ9embWdqugrLViVW6TxejY68vMxE9lIfrguAonTe5XSbrsumnpSTYO3wrhqng9z9vOuqbaY7W1JtaQS3g54PqdUgeNSxOkeqigLGXHUmhMEXKCtMhWKlsEgnOlLtKYIq6DAwo1/Nbh/qy49cLetZdbOkfvdGgoqWpFIlzvLApevmP8fWx/w/ut061FEZ292/++wq1gPSvhMWaEJzpbvWspnhr5ebzxECg8IZrmAhddAplRrRWf4d5ge+EqPZKNYxUsmLVsB5Q2UF0ALJOt4g/SX9k4stjzNVV9ErcvRcbRHvmowVdWqonKrEK9w5y0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HK7T4/aYM3ID8wRaV9lQH3eeh5qkWGgBgzZkSaiHaHk=;
 b=UIaBR5b3KAYHaYAntdJtmuXZ8eKyfGRG8iek1wGVgSZc9TSFLOJ+pFGmCBBQFMO5E2IFBPytcFXcIMrMqQMaXnQ4d9cXgfkF7J+UKAPaC8cTY29QRfslN1ZKf19ZLj/6DfEiA16xI0WUO2oHC7BS50lZjQ9ZZ2ieXq9soXvgyoEC45sNqCEVgwtZByTbVx6j3RxNCtmYL54PS263JeBehuqsvjcB/kbRCeTGUfULDrkQ+vUlKDuB9AclGzG8tYkEBgdsolNQxlLJrEa2qv3weKyRhbzr7ilM8ahrhEz9/EBxH9aHhdaq/RN8ipIY/K0+yGHT98lq92mzRsQUOpEVnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HK7T4/aYM3ID8wRaV9lQH3eeh5qkWGgBgzZkSaiHaHk=;
 b=Ww3Hc0xw6Yd9l5QnpYxNiy3Vw0hm2mF3eLKy2SaHJpU9+ERpoEBp2daLwzdmHvaI9PGonnnNH1kzZVnsfACMrxo8q7qXixD6Jjx2poWfL7t6bHCZZ4roeTAbcudmXZ3WtpwQXjZhukt3qsD83dXGociGHCjU3URlZiNiG3YtZWw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3900.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19; Fri, 9 Jul
 2021 13:31:02 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa%3]) with mapi id 15.20.4287.033; Fri, 9 Jul 2021
 13:31:02 +0000
To:     git@vger.kernel.org
From:   Fabian Stelzer <fs@gigacodes.de>
Subject: unit tests / cirrus ci fails
Message-ID: <a7aca5f5-3a5e-b13c-ccae-3e515c774420@gigacodes.de>
Date:   Fri, 9 Jul 2021 15:31:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM8P189CA0027.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::32) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:176:e980:2d4e:7e07:50bd:bf92] (2a02:908:176:e980:2d4e:7e07:50bd:bf92) by AM8P189CA0027.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Fri, 9 Jul 2021 13:31:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32bf1f87-f8ef-4fae-114f-08d942ddcbc5
X-MS-TrafficTypeDiagnostic: PR3PR10MB3900:
X-Microsoft-Antispam-PRVS: <PR3PR10MB3900B4E3AB8580149A672C57B6189@PR3PR10MB3900.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jX60W0LWcy/eQZjWCbJVD3NTNEUG/EP96VK23BsM8KScd3ItgZu9nUEPtj0z6BkKdacTto2M447ZcT63Q6FGlbro6zoIL7Gqp3RPgD8dkPUR9r16XKLfD1kKpu6vlh57nKucVWGnDDxf8P78K3M7Jr3VqF+YSr3he/DmE6axOcrXQgOrOi7uyR77ujDv05foQ+FLIvU1baFQT7WLWDMls/Yi+nzLtWFILKRORwhw+9oZxMJa/ljbrU0CVX/69oAXssa/QJHh0o8faOnAIN8FNBVs663sQFyC7vR5WyBZBf0BdwYbtQqir80drkpkYKl8LWtJYhGcTACepsnJvGU71uGA9tv6n4yAG+SRyBx57u7ludNTFYn3E3R27l4aO5UBJZroy7oju9Dhr43aiDBhTbMx605XSXXnsM2afXaXD9Ro9x0kzfjNuxBLuwx+nLN451aXF/Yp5NZc6yGhHt266Kf3ZaowsLO9Ipa+fFhsam4FzwY2CUMDkTIE0ooBn7CkAbCNgi6jDd2CnCQlk989O/AWV3F4ME+WI7bpVMGnuFO22lBppTYp7WSVSnyM9zCpHSQRfPBZ6pIqEIbfIz3zoIHZk4e3DMHs21z68I72cS5yN09nAYBqGvX40Z6PjW5X4VgNIBUbOtL1eS/H0xFQfvTV0qHAJcM/H5pZO2xpq/seIhkC0S/nkC5nFsd4NBmE19g5W4NmxFXofeWVx3fyJ2ONaXNsu3Q2/NNXegr+m72nse+KqehN3JIMV8Dr/UpkBErQGkxieDQYsAY30cW4tHpUCezahCMnk6qn7rErjgGClwdFEVYwhKAgx3BEyvca
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(136003)(39830400003)(346002)(31686004)(4744005)(186003)(6916009)(966005)(2616005)(316002)(36756003)(83380400001)(52116002)(478600001)(8676002)(6486002)(38100700002)(66476007)(86362001)(66556008)(66946007)(2906002)(31696002)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ui9SSi9QWi9hQndkMlI2ZENxUzgvZGVOTDI1azlqMmZFUnFwUDY5Q25seGxs?=
 =?utf-8?B?V3NGbGVWR3BOdWRwK3ZYRFF3MTV2eGxtWDZCMlNUNEROQWRFRXg2TWJSZlFT?=
 =?utf-8?B?cWZ0OVFNM05IamJHOWYvVWxoR05LMnV4aVZUOEJUKzQ0Zm1lblIyUGVQVU4v?=
 =?utf-8?B?bGJCWjJtZGNFd0t1R1M3MmpVSDFNWGtWYm1VeDNCR0c3VitiTjhXMHJkNWRP?=
 =?utf-8?B?UDZDNHhpQ2ltTGxET1puWU9SY1hpMFNYMVJRZ1B6N0dLd212czFPNXMwcVQx?=
 =?utf-8?B?K0NnQTdMaWRJdU84dXJtSEIxYUxyU09TRFVUMDRReU8vb1JnK216OUg5M3cv?=
 =?utf-8?B?ZUZDUi92dGw1V1djcUlnVlhubWhLSGRxZkNCUWpDd0xCK094d1BRMVdvbFl5?=
 =?utf-8?B?NzczZ0hkMzRIVG83cDZjTXNrVzZDTlRndzFNNFRDQndKN3J4Uy9yYkR2Znkv?=
 =?utf-8?B?dlJSR0pzNjJhNEViS0hnd0RHNGxMb2l1emdadnZVQ1lZZFVhcjlaT0hiRTYw?=
 =?utf-8?B?Ym9oTktOdTNieDBaRU91QmtDc1MrK1krem5GMVpod2xjUDFyRFFEOTRCUTh5?=
 =?utf-8?B?eXh5bTF5YXhGUDJDV0ttcHhwb0d1TUlCM1JXRDZNYThkZ0IzdldnSGNZZHJ5?=
 =?utf-8?B?eE1vWnluQkxrZWlGZktyaEtFNEZjU2haUVh1KzNrY3RMWVBmamVkelhaM0R3?=
 =?utf-8?B?WGZmRUJkN0V4SG9mRThrUFB3d2FEVjZJUFVpV21PSHNmNE1MMlBDYXkwa1RG?=
 =?utf-8?B?b1RnN1JjYWFycDYrYjU3SDcvcVNDRkxIdVMzZ2NaR0hkZkw2cnFrcVpEejQr?=
 =?utf-8?B?NzVUYjN1NUl4Yzc0bXJOUHVvK3QycUFVdjRTLzVZWlM2M1NpTkk1MGpDMEVt?=
 =?utf-8?B?d2NrMkkrTmxvNlU5TkwvV25Lb2dFR09UUGFlUW4xZWxvUllBSHRUTzZzemp6?=
 =?utf-8?B?NE03WlF4cTRSbG9uYkdrQ09iYnVJMXRVTldYMXNNOWg2L0M0RnY1SWRMNlJL?=
 =?utf-8?B?NSswbFo2YzhhRENVR2czSm84cmpJaVpIU1EzOUxBUjI4eldTWnFzUnYvL2ZB?=
 =?utf-8?B?UkVyL0YvZUU5YnJhcnV0N2hDSG5UQVUvMDV3TXVpWTQyUXdtc3FLbGE0ZEh4?=
 =?utf-8?B?QUhOaHBPbmk2KzgxcEJyUWpza1ZlUC8zdVpwbndaczY1THlUdlViMXVrRG10?=
 =?utf-8?B?bUtRVjMzSkhONGs0U2lyWFg2UzhsNUpQQ2tpeUR4anRGWmQxZXFSeU1sYWRX?=
 =?utf-8?B?R0d5YlNjZXM2Q0k1YUc4RU5LZE1tSTVHOGVvVXdBUC9QTWtBYzlBN0U5S1Nk?=
 =?utf-8?B?ZkpZRXpTbVhjNDMyaDFrQmdmMkRoUHFYZ2hWeFBFc0todDFUdG1GeExZRzRU?=
 =?utf-8?B?ZmtVZk9YNlJ0R1RJZlU4S0xUWEx4NGZCVWJEcVdwUEs0ckhHUkJ5YzVvcVR6?=
 =?utf-8?B?bm84QVF5aWkwRmViQWVFUU1jbmNEb2FXL1M3TjU5WkFHUEZuMzZDdmExTnRF?=
 =?utf-8?B?a0dQMmZ3TUszUHBobDRUOGYwSUdMSzZMNEZLTUVOUjdSY1F1OUh1U3VkdFZw?=
 =?utf-8?B?bFVRZnFKNEJzbUd4L2dSZVNnaXpqZDhkQ2VKMGF5ZkYrcWVtLzZSRTNNTG9U?=
 =?utf-8?B?Q3JmWkxLZU9mR1NwWVhXNTBqbVBsZjVycVY3MmY0dnl0RmxLQWtWRWZsdTRB?=
 =?utf-8?B?N1dtSUl1ektXVlVYSEpsaUtWSS9mY2RxMm5kV3JMSXk3ME9udGtmUFBOZmJK?=
 =?utf-8?B?b1U0bUNBdWp6YTNCNUpybTFGN09HclRNdWV0NGxZMDlFMXY5QWhlZGkwb3BU?=
 =?utf-8?B?cmdzRWcyeGMvaW1ZWDFNZ21aVmd1cWVhY0JWWXFkeUxLcHNVT040TE42L3VS?=
 =?utf-8?Q?Dhr1pDKUE1pqe?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 32bf1f87-f8ef-4fae-114f-08d942ddcbc5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2021 13:31:02.4855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rpz2d/OGzKIAJIpk+CdCSpBfSUEyYeuztIFNaVMj1ICGhV2gGfLh62Of66FgCpaOSIgZ+0vA3RMEKbkfDaQ+gGHztdffTnGC78GBqqyXiG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3900
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
i'm having a issue with a failing test on my pull request.
https://github.com/git/git/pull/1041/checks?check_run_id=3028222798

I have added a bunch of new tests and they fail on the freebsd12 test 
that's run via gitgitgadget.
Is there any way to enable verbose / debug output on these or a simple 
way to run tests manually in the same environment?

I had no issues with the full test suite on fedora / centos linux except 
for "t0500-progress-display.sh"
which seems to be a different issue. this test fails in master as well 
on my fedora34 but works just fine on centos8.

Kind regards,
Fabian Stelzer

