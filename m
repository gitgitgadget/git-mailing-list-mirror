Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36866C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 15:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DB31611CC
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 15:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbhKSPKV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 10:10:21 -0500
Received: from mail-db8eur05hn2222.outbound.protection.outlook.com ([52.100.20.222]:64609
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233891AbhKSPKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 10:10:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUYrwn4q1HWg0sGtCYuCDMk6I2pdVD8T9eKL/yKMcnL9DJMtHPsGb1Ix+DuUAgUj5w0o31NHxpOXpVxLQnCiOGn5LUICFTfgx565KX6HV20qHa7Vf/y7FEFP53MBAux3Sjh7yrgPZ2PO+WaX4v8tVpfJvT2hmceMgmXJCObo7tCL6DH3mVrOo+jwRD35AujrDfO8h0yF2PHO8MlycNNpvMd5CM3g5yXtLnu9ukz0lhrMXHu+zJZX8NB+6ve2SF7tGODURSd5m+AZlXyXv3DHfs7/5/7ArJbKLkAwKIYoEP6C19geIz2PeUgc5nRNC9hwLO+4qeqLZOVO6IIDwhdi5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdmJEC1frBsndK6TDbRzkQ5znmbbaJu+LLv28HieruI=;
 b=VHuA8q9Kq7jwD9K937i4xOa6PV+Yic0/yICpqncf/WM9DMo7a50CSGbhKrvh8xT6ZBpN67QBgFPni618zMwKNALYMzm0Ba0H+ZzlF+qCNZqRXxtwXw4wy+Rzuy+ZgmlyyP8RVgTnEpT6wPtQ0hM1IZxJYQr911bEkWgySTwRCJBZ0Hu4GqQmghRl2x0qR2/VTnOxRmmf9KodNiJTGd6yz4BC0WBEU7gpXjgMkyggJiEIxiLuCe3h8oHiCZ2XQjRHgYJLagkSowyQ0DASWXZvvt5VCl8Jmjx1SZWhweUpSbqSlU2I49ibCkLiuQvuwOzdN+3lKZiJuCrNjAgIzoLnCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdmJEC1frBsndK6TDbRzkQ5znmbbaJu+LLv28HieruI=;
 b=eer4kPh/dUJUD3knpFaTR/mLqhr1lOStiEH10SJlANfiElR1BM9Eifbolp0aHu6DyUJxddWUspKFNCeAxHeEx6l5fiC2RI6xETdg5OG0bIdBXMvChNWxzPiOFmApDMgvMpI/vHpWLzPeXiPYl18jZGMt+eJjFTCV+30l1pU5x8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3802.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 19 Nov
 2021 15:07:12 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%5]) with mapi id 15.20.4713.020; Fri, 19 Nov 2021
 15:07:12 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v3 2/2] ssh signing: make sign/amend test more resilient
Date:   Fri, 19 Nov 2021 16:07:07 +0100
Message-Id: <20211119150707.3924636-3-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211119150707.3924636-1-fs@gigacodes.de>
References: <20211117162727.650857-1-fs@gigacodes.de>
 <20211119150707.3924636-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR1001CA0064.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:15::41) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM5PR1001CA0064.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:15::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Fri, 19 Nov 2021 15:07:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40b18a97-3904-4b1e-ddbe-08d9ab6e43ee
X-MS-TrafficTypeDiagnostic: PR3PR10MB3802:
X-Microsoft-Antispam-PRVS: <PR3PR10MB38028405AE00A36593E953B6B69C9@PR3PR10MB3802.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:17;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wisJyaugnUPrEGMdDQQl+cqAdwlZRViHT0Be2CScBl+hyQXvFxl/O6+PW382?=
 =?us-ascii?Q?PjfThINbZfRo1DewLLRF9ToXo1CRaN3U1F+K+pBYb4MbDQq9U2ccVlEUxg6A?=
 =?us-ascii?Q?2zeb8cvvThzlFW7qNoU7cMDwdFMxKySiqWoMEMv76ucj5WFNq3E+d0yAReGv?=
 =?us-ascii?Q?IiKQvwFgxAD7bJmDz66Yn+2R/CMY3OObpmhnjzsjxsnZGSAXqpM1gtS/rqDK?=
 =?us-ascii?Q?XVvYlLfviCoqTzZPEmIfLujz6x+tTVHqBFhg7TjeYYuleGMFGVZZ9aC6tDOR?=
 =?us-ascii?Q?khaJ7KuLlh7BvV+chCg6olhdsgeMAfoKM61U6FJD1qqLJuTuKq6etJhA5P9O?=
 =?us-ascii?Q?pKe84WaK4NKa9u6s6Bb7Xq62tpvX9GfcH238BIjGseGYqiQAaOgybSGXOtlJ?=
 =?us-ascii?Q?/1ce6jkPyzOfsh6w5K1w4dzpeQui/pg2Jtglu46JDkrvQSW7pyGeaty/w1QJ?=
 =?us-ascii?Q?FprEOQrFPDD7r1w/O3jAcr//paoniSuXy33rDc0A18s3rEyRIWfAsy4n6ZrM?=
 =?us-ascii?Q?ApYB3GF0+ZpLnW+kAIND7UPnkR80LF/AYzgEHYYdoWbaYUKLxpVlVE8+8CUs?=
 =?us-ascii?Q?/BU07K5BIk6ruINN8YQLOr+KpWGSqiQajduoLbQYbDz4P9Dxl3uiaNf2+uh/?=
 =?us-ascii?Q?ySmPNqc5SPxxXAfb/28bqBu/IXmMbuyOWTSwZDyk+j4cnvHfrz2OZggjowuj?=
 =?us-ascii?Q?xSonUON/fFKVfTJrWN9JnEe8WZM3wjcD0a9bhBxmBZ07GCZBTDhkvbo8+Tpf?=
 =?us-ascii?Q?EnsdEhVPknFQZ95s6Nukw2efr3/zx5/kDLx3KLUUzlYgn47enLJaWDTEavtN?=
 =?us-ascii?Q?KZF6l0q1+r/J17A3WGrjpN/fvb89zVEBlq4mcBrQQLPn4f6lgoR3s1gMxpdH?=
 =?us-ascii?Q?+sY1cllm6OPyQzdKhnNhHRM3v4UjD/1zmqd+CjNUGporISgQHaWF5GA3QynE?=
 =?us-ascii?Q?E7ZptX5SrNgfJuECVc+8ruqh9gSB5y+VxczTZZEH0z35SBIY0n+8yF2Q6s0S?=
 =?us-ascii?Q?d+lboKLm/LfOuQrFbVl7mGb0Jg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(136003)(346002)(376002)(366004)(396003)(39840400004)(66476007)(66556008)(186003)(6916009)(36756003)(2616005)(38100700002)(8676002)(6486002)(83380400001)(316002)(8936002)(66946007)(54906003)(6496006)(508600001)(2906002)(52116002)(86362001)(5660300002)(107886003)(6666004)(4326008)(1076003)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hR0df1W6+2iBAbVzDzpfq6uirUVRmGTfvvSghX7fdZGOxOHLPimVkR+T2cyL?=
 =?us-ascii?Q?hFFEqhxe1aXVuKrADLUjUQL+A7rv5oUEvemzmTuNixz4ZwNrWGLavH7bhzhM?=
 =?us-ascii?Q?1LSm5wBTgSzIA3Ni/9KuRJqIMCLca3owMWkwxCo204VRqi7gQE+9xcUhwpJH?=
 =?us-ascii?Q?qkw+YBaHPNAPsmd8QZxl5ZmN4orV13Z3rUC5eTPnxUHOY0mm/58CI9YySJGd?=
 =?us-ascii?Q?7CTKmTp9QF9HYzj4z5N4/cX6tgBCCWJVch52xMjLJOYiEo6eCDDXERH8CLgF?=
 =?us-ascii?Q?BqGOeL/WIHrXhLbo5TyM1qPdif6MxrXFPh+3Ij6Zp8vYhd8bb2YRl+wMvUmi?=
 =?us-ascii?Q?V8OP3Mfd/kl5jLydP2iuJzosktKiUwbcMQwjntOaQ+eBAq//R9ZnwGoypYAF?=
 =?us-ascii?Q?9j4SVK6QQF7NKjZ3iTkN7mh8KnCVmaamc24WzjQ4PUza3aQzxYL5MLZiqygF?=
 =?us-ascii?Q?0kdYX02SCEcNmFlRs3Fr06EJc49gCQN5heqLr4Bh8qQwosKUsYbC8PtHyNaB?=
 =?us-ascii?Q?CmVxbz2Ty2PObHxKtqIheGNKl77r9un7fGTKootWOFAPl4jaxcn0fdZgk+ML?=
 =?us-ascii?Q?UhjwlUSFgT6Gx8nyoZBYtTcWazcTgY55rUFAMwwmapmIjC/IDH5Yaj9CPPyG?=
 =?us-ascii?Q?9aYCdar26xvyo9HTNk2cFvPJ2gqvlITvv9IspCKs3GODXBb5hKDVgS7Sprvw?=
 =?us-ascii?Q?xyFxHn4w2Td8sV/0IB80x1/pydsPv0waKHh9RnGkE1zFxhMIaer34paKd+ed?=
 =?us-ascii?Q?tR7Qd1UFC4MZeRl60vftBUpoXkMFwrhJLnSJlV11AX2PgJdzXj93SihqUK0k?=
 =?us-ascii?Q?hxVozb6j++fSFlvtjfIthEYuiiSmXfuXQZMMfJtE5pVPN5uPinzFPLoQfNfo?=
 =?us-ascii?Q?zzko2KTgu7CfTO6vSYFLIYKxEcy6euYjg5mevhSrYg/v3Iz+wiH/VyLnVpk7?=
 =?us-ascii?Q?5pZAN9+PSk4ISBhUSfEoMT0VzpQEUffrUXUhyxSAnZdWyGdH6TR9qNIloPo4?=
 =?us-ascii?Q?KzrwELy1nHIMTm75MO0kabKxqrhcJnuStEq0gAwnG61P7v51NWgw0ABi3ojI?=
 =?us-ascii?Q?CNYvTjdvw26unNP2xUTx6yRnwKXel4ThGxvDlTkkuyHy3Ugzp6tgoAomoNEj?=
 =?us-ascii?Q?eGzpBaSrfvuRI6xI5J8TCPrzAV6KvZ2TwR7OtHJlE31EJVZt/O/wMqOn3jhx?=
 =?us-ascii?Q?IDfExI5SS5AgSS2KIOppK5KIeFAAgqbUW/oJ76KOueAnRRZMgvZ/xagPkLQC?=
 =?us-ascii?Q?9cJWSe7j0lXJl4gFyZ951qnoDWTXChYQliBjCoRJk6Df8YFzRT4unxYs6ELQ?=
 =?us-ascii?Q?b+Frnu97JOYshYpSC4SGrtlQF2ecmIgfyJjVUAFcxK8mqxaQqIlApynJpjQU?=
 =?us-ascii?Q?s1X1XeAOiIrD3zGZhNTncgW6gGhe6TbtsV/vfSfISgTcupVkR9RuJ8oJ0ONk?=
 =?us-ascii?Q?FaosVJ35DjcMe91IXPLjil74PTzbK+rHlC9Q4Ng7KXdRrJHaNZdiJW8yv0+i?=
 =?us-ascii?Q?r1H+borCMFJ7PJvRTSw3Xa4+ym3IV/SEsDDS7DCt9hNMlb8VO0QztkBZcskf?=
 =?us-ascii?Q?JiHJ3PuHw/xCeJQTcVCc1LL7K6Pc5Ohz3cVFVW1o1eTwNs6+HvDJmcq0+hcK?=
 =?us-ascii?Q?nREEyuP4MCx+DnWHOxkUHA2nR3wFy17x1fo5oYeTATDPfzsezcz/viC/K0MR?=
 =?us-ascii?Q?epf7RbSZMlBShSRWpIgTgthpSv87r9dyK1TKpYneBJpMHOgJTyAPAeM3fvbN?=
 =?us-ascii?Q?/tecKneMUQ=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b18a97-3904-4b1e-ddbe-08d9ab6e43ee
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 15:07:12.6077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: atBkO4w8YO6M0OkEuvnrCEKRN0svdMPr3sFzGVExN7pjuawcebNE0vXjNjO/cHI2gpCmUkr7slk8ILJRUGpn2D+fYxybtb7b5wANITldRNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3802
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

