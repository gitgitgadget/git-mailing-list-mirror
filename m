Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E670EC433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 12:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbiADMtj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 07:49:39 -0500
Received: from mail-bn8nam12on2066.outbound.protection.outlook.com ([40.107.237.66]:29665
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233148AbiADMti (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 07:49:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVrHljUhIxk88WUg7cqMyKGUQ0tzOWow5jjn1nSqxInvOXavBojFhCLha4wVyfBDqP3n+XeAmW72dGvaQZQReLQgQDiNcTi3cX/C/jsJMs3I2rE7BalvuxU2TLC+/AqMcHDNQCtMH8+yhI/vbMEPWuLLR4/gqlmp4XhuL+Eyqc2Q/8jXWzTNGPx1RS6ybvA+gYYpMVjC5GInAbrdoqaSbHnXnpP+tJFuRzSDrIHNp52dYykspudUTnYex+WLoUaV2GF9uHSdxpscKDemaFZxeRyZlEwbN9WGwOUQqV+59dOwcHn/Eif9bRJSqVYAWKmQnTVxfEOG0yvGjFUWJonRCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCu4H2g+2K0GGL5jT7uNdLR9FAT3fkq0Mid1ja+lPBc=;
 b=TRQulZVci6RomaqawwQXR0hOyP5xKAe/VoO7SBtkqzneURFujDnjGY106SbFYDasG2CYdKiXuCmTR01wbIemMuxer6mFxqpvIxZ7bxpGJrJwKguedncXu/J6CBxpLm8EE53E/tQvnIJZsUHzfNvUyKQtb/U162B3EUrY2G/49+XDTSEtpICCjmS8NL2BN4kCsAyEeMvRZkVg5v7eR85/eLsTlGS5a/IeS0aiRWtVZKBl6CkxJWxWGE3TfmITy1awRbmvZjxIfXl1ww9adb2/dFf6SeCydYkCc+EAhuHTcvFBLaUG6phUQdWvjTZtrlbFYnA5WX7wYv3WJeua3anObw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCu4H2g+2K0GGL5jT7uNdLR9FAT3fkq0Mid1ja+lPBc=;
 b=hFsGHIbovZQo3/oypMtnDNYgFjx/lo/5RpQsbnxtsWxF8P97KUc8DPG/dKFFHOvmcjbd2cVYs4oyEUp+0rLdbfXAfugLkwe3jb/wSTHqhEz2Z9oi5YNkAclq6kWTDw8d2CL4JYEuPgd62D0m86paNlXtTkzpfdpp7xGn6X4aAZ6FQRtXsu+flH2zmNacf50u3JXLGHLeXowVpZ1UY9ntkulLvLboc2QtRaWxiBdN4YxaAJVI5cg1Ic6lF5kgmLSKq74NWUnvUt8VbMgtMWr0iCL1CqgoPBxmRPxt/uikIJFuF2MkgXPNn744r/HVUtXw0tkOcozZygNCupi5npbFWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BL0PR12MB2500.namprd12.prod.outlook.com (2603:10b6:207:4e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 12:49:36 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6%5]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 12:49:36 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH v2 RESEND 3/5] git-p4: add raw option to read_pipelines
Date:   Tue,  4 Jan 2022 12:49:11 +0000
Message-Id: <20220104124913.2894-4-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220104124913.2894-1-jholdsworth@nvidia.com>
References: <20220104124913.2894-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0014.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::19) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4322c7b6-2214-4c0b-e3b2-08d9cf80a9f2
X-MS-TrafficTypeDiagnostic: BL0PR12MB2500:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB250010BF53CB1DA0F433D771C84A9@BL0PR12MB2500.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JWcP5qQcp+SZVaw/J/eBs4qSw5bvh5WeSjIYkos1+mUrrgcALqjZuYje4q0VUgeVdo06UUBa8YZxCkX849GjgVc8rBTX/7PG7O0LqS1CkkyC1tDEpfHaZxzjj3WnkaH/MNQdp7YFDOcq9Vwqg7XY34NGWtyewOyFKpNhoI5pnDjQmIzoOjWsZoz7tz9mdbpZ8k2r1MXGUi7+OERf0XyTFoNOROmKlkNnp7A3bMdp8bhA/xteKdWbGDxLJYE1bTJdKKv+RoVwnhO+IqWrqZJ6QSQI4mlP7NYHp906IZuPoYskdP1R8alRvU9RQk8vDXCo/KT7fIeF7hCSY1DFTKW/jIwH4FDsh9go5W38z6hNWdQ4ISbZA8FqTariAqFeLXeDHrIZaVarQEM9nvK1h57YNalBjLnY4UbS5RJBPYhTLgfG5g9Lb5teljZBpbETsE8XISB70BFARjH3lCz/lsaQqWxNVtdYnmK2ScDrYEQ0dW1ebStxtIFUInW5bVhM2AEHP72ReaAKCjwwcBFNxBfvfmOS5ITfAElnAf85BMQFTXkfDu9DMYfQYZ9d1WeL3dBsrcoAm/Qj7F4qnIBNdObq9T3qVV9Q7SNZLtjScpc+RaUSqusoczZMQ0Na4q9W81q3JmHl9K26eD7WYuSYVK3jcRJPBLxy1RDac3JKXPlHMBmds92twFpiPkRk3v2JoHiDzijZdHyL8Vs6FlfpT+pZ8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(6506007)(6666004)(508600001)(55236004)(7416002)(316002)(107886003)(52116002)(38350700002)(26005)(66556008)(2906002)(83380400001)(4326008)(54906003)(66476007)(2616005)(66946007)(38100700002)(6486002)(110136005)(36756003)(186003)(5660300002)(8676002)(6512007)(86362001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5m+maPkz6mfeKlANrPPvFUmeLT2Y/RRs4c+f4gazzmKaHmFIhgi6h83oPEht?=
 =?us-ascii?Q?cB4NXi11JcC2kG6lmyqB+UkQnUNelc0TceVKuUtkemCE/9q03bmmwc2RqwEZ?=
 =?us-ascii?Q?H1wsOJh7imTaAMmJXToC7+HNHpVq6UBzQfzWsu4U1y7OOzxyWtCJTGG10lja?=
 =?us-ascii?Q?Z4V+eaO7wSaFqKwwFD9APLueUddXBRXE4oR72qJJji7WHwRVAFzdXO8bVlCg?=
 =?us-ascii?Q?VKRkBMdQSNbQzG+jKxwfedXixhXqhD0uPYh4jYg6i5prMR/dlCXykT4XM6WE?=
 =?us-ascii?Q?vNzuXBQftiDQoIPcA29rn0srivE13xjCWFp4oycsxM0+LqW4nO4xPJ1KXits?=
 =?us-ascii?Q?J+bRXBBL2cCv/YTzbibn5hN83lsfSwQSkqpF7nNxCyCBL4N06oBn3z5sofrE?=
 =?us-ascii?Q?ro1GwF2LKDLvHEpdBifUQ6j4/nqux/fhzR23LvhWamLUtBKYvg4xwVKDF8VH?=
 =?us-ascii?Q?GJe3TqcrI952P2C3hwJTxsbBIaAo5LCWKA7ZvUf2kgQTWge8ZdRYuCayEEAX?=
 =?us-ascii?Q?VXZ1PxyUN3M5f3AajgBAcDTNPA5JVerSZFMKyryoAekqH/wPoDWPFmACKdB/?=
 =?us-ascii?Q?Z5F0asmaAFizjS96rTogAJ53u6CfRrGcm1UvFUv3aSqbLh0DSXEIJmWoE3zk?=
 =?us-ascii?Q?vSwXWCo7Y6n9vrye6k42jmT+K1vjEBjbY5rk/cUxjYCqKMAIPxdmxaDYqIEz?=
 =?us-ascii?Q?+LeYwFxdMTzW0qV5rS1gw3xoYa8v6E/4TtMhq/Xn2B+uWoGGs++ooFvr/Dzt?=
 =?us-ascii?Q?DLyuig49zPgXSt1vk1d/4YQeLRcgk4gycxZZ3PsRS+6J5JI/P+s+lNKt1yg1?=
 =?us-ascii?Q?8w4SWE97RDWdjhMTvO7bxb9vdY8pqNmHse9ZC+2FhRoa10E+zsjCAC+R9R9k?=
 =?us-ascii?Q?kcD0T3sXOjc+vY4puOuA3E1ZhV1TdcoKg2HmQXZMnpaBoRLgihZTydIVurOR?=
 =?us-ascii?Q?lFNECuDDJckSu8SPic8liNBdvrYb8U2c9XNZNPBY/vr60No4nFnCF1Wj7co/?=
 =?us-ascii?Q?2xckGDq5BP9rikqxopgXOLKt+JJPOTxz7aNG06MSItsgHCkWcxmobUdwJpaL?=
 =?us-ascii?Q?0oMPqAivoMEzHzESwFyANX/2cecKbWPX5hi3DsLrWz4So9wJcGGDIiMb2+o6?=
 =?us-ascii?Q?BQRphkIf/ffZLXUnU22S5JjoiWkXeUQbpIUYoms74NVtk2LgwuzYI9hholC1?=
 =?us-ascii?Q?6RWOoVkYNHD3pV1msEsXmZu4BQPwkHj5Daq0CVxlR2axSFrfQXQpDiuLXRjC?=
 =?us-ascii?Q?QQKxj8rXW8kRTsRpZJSTl2AVVWQmOPwdYP1ygTXBjfIrK0VS1LZQLeX/rU1C?=
 =?us-ascii?Q?WBKsaHQBjVLSdl4yPzZaAW8xCuqoBkNm3UPhIk3ABDD2N27r6PGRqFJE/h18?=
 =?us-ascii?Q?uzOWUJgG8LQXCd32Ehy/xCQFxwiZPYW8BKZrvYrcQN4boIONK9OhD2sQwzQT?=
 =?us-ascii?Q?yvgDoI8+o5ynbUtqDAR/PcVGz/m3p5CuCPEcAV2DWBYT1Z7b2mgP5UV+u9yR?=
 =?us-ascii?Q?zwx/Oy3izhAXsMAYMGKu7XOepnAWMjPN97iQpefyU5nTWOKXJjQ5ZAP4CeFx?=
 =?us-ascii?Q?rcIRuUcK+zUQ401+3cSOXtFjxAoVYOFT19lyWtNITBzIxDT4qOpervxZHb73?=
 =?us-ascii?Q?oy5Olq5zOMZ6oiMTj/qnJME=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4322c7b6-2214-4c0b-e3b2-08d9cf80a9f2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 12:49:36.6492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACcAjEEewnmVzeZi3cL1D+X5m2dWjoSuRrLPXzXa5rJijTU/LjfapIIeLmJY60Ik3EAAcZcqNX1Zm+ISd3YzPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2500
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously the read_lines function always decoded the result lines. In
order to improve support for non-decoded binary processing of data in
git-p4.py, this patch adds a raw option to the function that allows
decoding to be disabled.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 0af83b9c72..509feac2d8 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -340,17 +340,19 @@ def p4_read_pipe(c, ignore_error=False, raw=False):
     real_cmd = p4_build_cmd(c)
     return read_pipe(real_cmd, ignore_error, raw=raw)
 
-def read_pipe_lines(c):
+def read_pipe_lines(c, raw=False):
     if verbose:
         sys.stderr.write('Reading pipe: %s\n' % str(c))
 
     expand = not isinstance(c, list)
     p = subprocess.Popen(c, stdout=subprocess.PIPE, shell=expand)
     pipe = p.stdout
-    val = [decode_text_stream(line) for line in pipe.readlines()]
+    lines = pipe.readlines()
+    if not raw:
+        lines = [decode_text_stream(line) for line in lines]
     if pipe.close() or p.wait():
         die('Command failed: %s' % str(c))
-    return val
+    return lines
 
 def p4_read_pipe_lines(c):
     """Specifically invoke p4 on the command supplied. """
-- 
2.34.1

