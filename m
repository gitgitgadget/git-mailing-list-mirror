Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFABC433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 17:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 671C361401
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 17:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbhKRRR2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 12:17:28 -0500
Received: from mail-am5eur03hn2214.outbound.protection.outlook.com ([52.100.11.214]:57077
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233975AbhKRRRX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 12:17:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPHPPpLpKlSTJPJPrrKVg/rqtW+auLDkB2cU4hVUbFLMDhMJ4S4hC5kclxrwzK4aL594Eft52McC/z41QQEio8yAEPYF7Ys6kUjlt+ovytFbInsRf/LtXGZUCXkDjrmeM5iyKw7OM7bShbZzpY4NOE2uApokSE7y0WgD4ugZ/ULR+ksazEz/K0lWSvlGJiPuqtf3oxWYPVV1N4G9WlnqMxTZEYk5CJEU6ZLIey56LS7R/bMXrrrV9K7eG1fSg11J0Ymg3s/p4wwAxsMrWfzLzayfOYqhHKQshArcDpC6vdWnJb191N+cgXgQUWlrsZrCS2/Km5YWzgLgNdBzqxEslA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdmJEC1frBsndK6TDbRzkQ5znmbbaJu+LLv28HieruI=;
 b=WhTC21fvBcVn7NCwsgdq9cg7rmE6XN65CBpTc6aeo6zneUMUAi3dprSh8DdxPPDVukPp5rWEeek77I5K2NySA4KqpqrCnOShUxrLBJMpf5ctkqJSmU2Ech87yocrAZz6M288+ejzOQuyTpu1Ng5X6gXNE6gVikLz+h2uyaJCw8eQOo4RiBC+fGCwDbLPC99W8kOgGrBlvVkhmhOdBy0wwudYambr7eaaSKzmoOHoAvR8+ZQn9AjVig952LotMWgEVuSdc/PyvcKbxUPVRDChWwr3oth2eKTd65GMlWK6Xkh8MxXzNVEdFVolbzlBbJ/ukZrVw7mpx8GzJfpYOUH+AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdmJEC1frBsndK6TDbRzkQ5znmbbaJu+LLv28HieruI=;
 b=sF5wp9+D7Se1lL1Lk88/Hz+lxSugEr6BVZl2+sgxO4tb7wEQdK/8kXJbFuSKnz3xaL3A76LDNRgLu1oHVr7h3jS1Fblu5bwNF94pEnq07eDnaMn1J7/SrUR9mssF37rX1Hp/qwfspg9eb9QgP2vXJ95TGQHb8+FTV0O72FZJfBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:157::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 18 Nov
 2021 17:14:20 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%5]) with mapi id 15.20.4713.020; Thu, 18 Nov 2021
 17:14:20 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v2 2/2] ssh signing: make sign/amend test more resilient
Date:   Thu, 18 Nov 2021 18:14:11 +0100
Message-Id: <20211118171411.147568-2-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211118171411.147568-1-fs@gigacodes.de>
References: <20211117162727.650857-1-fs@gigacodes.de>
 <20211118171411.147568-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::27) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2a02:908:178:20a0:d22:c58d:d0a4:a83a) by FR2P281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.10 via Frontend Transport; Thu, 18 Nov 2021 17:14:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c0ede7c-fc01-4484-1b10-08d9aab6dc13
X-MS-TrafficTypeDiagnostic: PAXPR10MB4687:
X-Microsoft-Antispam-PRVS: <PAXPR10MB4687633F1908F44054D162A6B69B9@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:17;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xGAXGeFqjmlFrCBrE9vCKHRpgf7EtC+MT2N4SOKywrvpvXSQBSN5SDHrDSFW?=
 =?us-ascii?Q?rajByBmwp9V/cxCjFN3OL96SryIp2+sk6Yt7/47TKe/LclagNsyL7Ui8pir4?=
 =?us-ascii?Q?vuDirR/zIXyjPUeMX7VmLJCbNg7ICjqtv+MCXqEcsfAO8+PT3yf0cGHN0LWr?=
 =?us-ascii?Q?Qis07AwpBdG05MO04bqtAKs3yuMDQZVG8AnT3Zh1iTqARmzDJh4WsK0vMlkS?=
 =?us-ascii?Q?zuS+E7cv+nBA/CDIBmJvh6gYXURyY/tOSCsaZBZrjd7c0BTV1hnqZhpNCK95?=
 =?us-ascii?Q?pBSWcZq9czNNCGVh8qLkWOv8nU7NemCWhAGPXU7hEJrXeDomaFbMkYmBpAJg?=
 =?us-ascii?Q?2TPl7Q9GJfVG+Aase6lf8geLUwFjuq0A1bh2i9hYCgE8kPmgk9n8qIue0lYm?=
 =?us-ascii?Q?6u1cgO2KuUZMD9TzTIKo7g55IHtWGLQEjaNTPP2pYaCyEBSbL0CI0gOEaRef?=
 =?us-ascii?Q?RwRVURzh9hlrFB5a0vsK0TzdNze+vPjtOwkLcxv4ocpyq3jGDFExlqtbLgi7?=
 =?us-ascii?Q?ISmbYrNeRvTPHcL8c2GedAaciPcSaDUa3uyDSF8Hah8alYrt/yTu55U7uomH?=
 =?us-ascii?Q?QNREwZKlt9i26EdEwrYhNQ61u16yJUuzjtqoDFv8mFkHYyd0LVrG28Wz4x8Z?=
 =?us-ascii?Q?HiK+oDtm0Icjtg0u3SSmU3g8eqcJdUGkZpI7suQYD7O4ZiuCQqxUn6Pwi+X7?=
 =?us-ascii?Q?4c+8TCq1d1N3rWzQjJfnPRWtDMhvbsIFbH8cB1aozEB1130775q/R+6DtChq?=
 =?us-ascii?Q?Axr2sI7WVXWPRx9vbnb2U6VGkefMGR2ZW0h6wYp2atux6OUmwSPZY1Sg1bFx?=
 =?us-ascii?Q?bVnjSgc3hcOtV9X4qXOHrKfV254xh6q0YOZcTnEal1y0Cu+g6IfI6Uo2+Dem?=
 =?us-ascii?Q?a866j7gyTSUoFXZ0oF4BwZdcagCPg0z0Z2bxrQTDKKpyndh9NNweUHfBdRQd?=
 =?us-ascii?Q?W+CWDuHqCnNsE7WxLKrtk5+9o5IE3QS7nYT5PWXgY4VfVbtZNygwKpPmkDuF?=
 =?us-ascii?Q?OJyqAyY3AMlBUdHlRgFk0mwzSw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(39840400004)(346002)(376002)(396003)(136003)(366004)(52116002)(6496006)(508600001)(2906002)(1076003)(4326008)(5660300002)(6666004)(86362001)(107886003)(6916009)(8676002)(38100700002)(186003)(36756003)(66476007)(66556008)(8936002)(83380400001)(316002)(6486002)(66946007)(2616005)(54906003)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iA/IC9L1zBojYCBqNM9bWb/e0Pjem6VFifhU/6udIW7qjGVhA2dh2M307lva?=
 =?us-ascii?Q?FkcPLFydIFKHYYanb9x4i7ceghoZP3sYhEdg0Ka7bzFKWWkY66NKmlfJmYKm?=
 =?us-ascii?Q?kIHhgbrL2vk67bJTH691axIdwiyBmri805cnTdq7n19J2yZssr0hHH3BC9+s?=
 =?us-ascii?Q?j+tKG7TWXu19y988CA9DlOjYhZ3ga7e2n1LIvRi5FDBGH4qhGNY2dN1CPUr4?=
 =?us-ascii?Q?3wMWaYo3gIamnk4klyoKZcC0LA8q0/1O2eWO+0L2VbbEpdCQhAggZXAeoEsL?=
 =?us-ascii?Q?LkdRZ74FjvPDtpYlMJlh8Gb22n4VeK/am0NXP+bHfD5XfumEOVSS3XZpmYNu?=
 =?us-ascii?Q?CAvJvu4Z6Uh7GY0NvEJ8zR4CZrcLrJCxxfzJj/3Pm+O9tNcKFmyxgxLVbwgn?=
 =?us-ascii?Q?kUii7qqOMWIvFJt5TkHHrkqs8KqB2RuM9ENjGjRUridveAVPR+taZmPSTswu?=
 =?us-ascii?Q?7u2LjsrQNj5pP3jM+5xICMT4ubNv45dgs4IARN2Cixn3s4gST8Upo/1SjrMZ?=
 =?us-ascii?Q?yOaI2Y+4fybwFc0DZDsrp7bL1JXABn8ZpfyotHtrRkE8I2U86GA1b7EHiiwe?=
 =?us-ascii?Q?iuAPlU9G+VTy5Cm3Rm5pfVCCGWB8aDINgF4Sgy3W/cMvia65tVEhyn9EQSXp?=
 =?us-ascii?Q?IQ0nHtIaQ86iQWASyWXk53x3g4mco1L/hnpe6lrWaDvzwfNSfPEH1xDhib9P?=
 =?us-ascii?Q?+rZip4o1MB9YWulr31pW/dtqdVDJQzPSnkuR0vyqZaoQw6NVawthVQOdqtYy?=
 =?us-ascii?Q?Kq5zTyZAh4/vLsnVjR1Bkyi1UeqOLCyede6Z9FVnuUvsoDeb0pkmjQ09Ahs5?=
 =?us-ascii?Q?Sih6hj6uqFVxXE59ktGVO3sNWGzyhOykBsj1QnYyQCbv0odlRE1+HH04hY3g?=
 =?us-ascii?Q?wHD9gKY+zlxyj5TdC1IMlQvUQQP3RPpWCEFo+ZX9pb0z2UbpHSjaoFLwAXjK?=
 =?us-ascii?Q?1G8hodiz6h86b5m8lJpInUZxPzN2lOUvGDp5Ea3PGopH4ixqvd3uSbDO4LFW?=
 =?us-ascii?Q?WJSsPTaNLLSAU2o4ypHwrTKxQLk0+KdIGX92UXp0WchPMNxL4AsTgzzo6gLN?=
 =?us-ascii?Q?Hn1KMpVr6mImOSadRzyZXblU6hBW9YTDbigV7ZBzTA3pnB/sPPF7LR34emAh?=
 =?us-ascii?Q?EwILlIOeFPWY2RwFK5IFrNG2NPW4PV7l1rUu/pRUcgHfhrieqM130vE5QAnK?=
 =?us-ascii?Q?fa+JgTr/HgxoYemke0GbvBilXItv7eEf4TilB0BGjNzjGVBv7JTBsjZqAgSa?=
 =?us-ascii?Q?J5yCs2d2joftX2zFChCh3SntZaR30mMH3wc7OOa7w0dUjEOlpe5jfZg5epwD?=
 =?us-ascii?Q?zo4Y5WzP1jpAd/jjZsO6VvRtdM1ksLFB+3wbUJuUkV0dTBB2WfSmIK+MsLnl?=
 =?us-ascii?Q?dzg3UHbcE5UAgROjNnLqb3mfbPIjH971hcszc/nqOGxwIfKUl/idI/uDqD5g?=
 =?us-ascii?Q?ttSIxuDMhh2ByjohXivt9BaVNU3JDJi8CJwUl1fmpbLsLc9VsRY4moRniWNh?=
 =?us-ascii?Q?b8mQojxkrlLqSXEGFdKIroKf/yR1axkiUYMTlVCHhhz9/9tzs/Jbl/rgqh2j?=
 =?us-ascii?Q?9dy/OFxkfF5cAWq98BVhGVzfzvVc5S5YVo9tu7kN3wWTkwyYfBuBAbwqS0+m?=
 =?us-ascii?Q?iCETSh0P1jPcPi85QQXbDikhnqsUKGGcGVvquuzLIM8EigI6NAMWjte1AlXm?=
 =?us-ascii?Q?nOv+4vFPP53oN1uPk0oJ7RMjOCL0nPJKLyU0h6E/WHaYiO6jWpjSCIBqSsBl?=
 =?us-ascii?Q?64TgHh2lFQ=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0ede7c-fc01-4484-1b10-08d9aab6dc13
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 17:14:20.3660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: flBFuHzeJ6j33T3YPTSatPcq4QiuEuBHHoX2ah6U2xxDZ+MHfYor72Arw6UpEJmquNYbISc9N+tz4FSvTLqtuGQHhcV2W+S+S+IQi+u+Km4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4687
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test `amending already signed commit` is using git checkout to
select a specific commit to amend. In case an earlier test fails and
leaves behind a dirty index/worktree this test would fail as well.
Using `checkout -f` will avoid interference by most other tests.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 t/t7510-signed-commit.sh     | 2 +-
 t/t7528-signed-commit-ssh.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index d65a0171f2..9882b69ae2 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -228,7 +228,7 @@ test_expect_success GPG 'detect fudged signature with NUL' '
 '
 
 test_expect_success GPG 'amending already signed commit' '
-	git checkout fourth-signed^0 &&
+	git checkout -f fourth-signed^0 &&
 	git commit --amend -S --no-edit &&
 	git verify-commit HEAD &&
 	git show -s --show-signature HEAD >actual &&
diff --git a/t/t7528-signed-commit-ssh.sh b/t/t7528-signed-commit-ssh.sh
index 455eafa15c..0ec5a6d764 100755
--- a/t/t7528-signed-commit-ssh.sh
+++ b/t/t7528-signed-commit-ssh.sh
@@ -239,7 +239,7 @@ test_expect_success GPGSSH 'amending already signed commit' '
 	test_config gpg.format ssh &&
 	test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
-	git checkout fourth-signed^0 &&
+	git checkout -f fourth-signed^0 &&
 	git commit --amend -S --no-edit &&
 	git verify-commit HEAD &&
 	git show -s --show-signature HEAD >actual &&
-- 
2.31.1

