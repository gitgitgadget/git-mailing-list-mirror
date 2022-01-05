Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F46C433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 14:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbiAEOHN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 09:07:13 -0500
Received: from mail-mw2nam10on2048.outbound.protection.outlook.com ([40.107.94.48]:32334
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240559AbiAEOHM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 09:07:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRuuvguBRBFT0UTR+S7r+kjx3p3fTe4lsim7IyiM+jj6VtM/xFhHvvDaTMoJyjrHb9PCq5EUvdxKvAFKssiHR0j+fwabIXclBOHM+b/6AWmN8y1ELNSY0rYKjnlF9SXydCvi5ywwDipi82jlFY4ijQTzeT5kwE110Xe0hfjkST8DB1wvcql7L4lbcTp/dZKf7c9cKYrk/s1VfkP7aVNOfN+JDsHZUfdjif7RSDEfnbvBstungIoSo8b3dsIQP6EStdJ4daw24+oIF9e3NfrvJyKySAryIL1tQ1osFXzAvQv0GiLtp6FC7IWzdYvI3ar8AZPjDNFxsZays86lgQ+8ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhecZS6BqdvARjH263NeHK6T8pYZx4HycV10soS8Mn0=;
 b=KvcCIMWBXrGe5p6R0NPPRXit0dkK+eJCJNy8zlslYKbORr4G/QieZxClyexOVhzXTxhHFUiuAUECPwaqH9N8xYZ3zTUdEQoTQd8+BVR5Am0F+TwD/7vttVAVzQfW2ZTnQRkH3Oj9/SAHz1fpTuLTE3NkTRq8Z5L21P6UhS9hXWcfnoxVCdVDqaMoHH6djn7BYP1ORYH6T4VAW0TK4v3y0uXi15B9o9XWi2PyeOJnI5ESws+mnM3VkvUDAZ2+nfy4qRfYGs1Ir/7vHpac+u8y/sAxZjZGoKZg75uV9N1nQcv38QBYi+/5/JS6dtPP9fZNcRbxN2sNOnG/4jxuEHCrig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhecZS6BqdvARjH263NeHK6T8pYZx4HycV10soS8Mn0=;
 b=DadUhqY6njcuhOJXilTBaDLF0vYhyIYomywGl9xEuZ3JMOBlIIW21WHkr/I/ynIZldZr1rmopl45tgW8iWcANCZ86PQWP1Z/4fTuZeOnzKkwtqf5o+gYPLOJksBsPowwe7MdSus7Op2hih4p/Xba8T/5bfgxANM26bG3tSaDUX01OCmEfY4HhXyW9ZYmG5jQNIRcAPYoyPWs9a7FPU0gRStwDOaqwZdZvtQNHBolY8tsLcneNlYIP1hAjRakxDR4R/IE5nS2VhDrvBbVc1bJhhLoDscJh7DeXUbyIflTepDxcAsi58E2OVEoZzW6dl+C3FX12P/2CSHXpZDUd5Ge+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by MN2PR12MB4424.namprd12.prod.outlook.com (2603:10b6:208:26a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 14:07:10 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6%5]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 14:07:10 +0000
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
Subject: [PATCH] git-p4: don't allow cloning into non-empty directories
Date:   Wed,  5 Jan 2022 14:06:31 +0000
Message-Id: <20220105140631.48252-1-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR0P264CA0264.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::36)
 To BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc80fbfb-5ed6-4062-f5fc-08d9d054aa66
X-MS-TrafficTypeDiagnostic: MN2PR12MB4424:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB44240EA18D34D60F499368FBC84B9@MN2PR12MB4424.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ALg6eG95WXZMpYyLJ+xzZ7nf+RA1+AxZQpXs98UjfUEKa0e2W6sk28Cnq5Lu89Ues+cZVxVZncWZLbTOFX2UhLrJYp14l90DtChhNzkFvhU2wZnOdc26HXicHywpBhbhv8ZGzM5dZojgq/u4CFzEX5papncrQtRw1oGY+aYCtT+sQkwoyHjiTHAHc47nNKXcASqTIMfxbJfrQRjK+wkIP0k4OkYEtfy1X91i+cjSgDPhn8me+0AzImZD5qvMCj4Ir5WXKaPRFp3OHlI/kS1FiN4r/EUC0F/FsoDjuVw8fOJA4q0KHay8zUn5gh5bhfboSjYvJp3PHQuLYAPa84LW8EeS15Boi4EQaWaKVqlOxzwfoXY+x/w3/WVNrA3YtKcj18lfFVQ7uhPV7kQk585yiPGCb/4AB99l2xRlYWrxq3HOSZG7GU873IzVcqtQ1kielThWkEnRg6r9qIEVwyF9LVx8zD4XeW6YSF/KSsAxSqlmCGM5HE7wVN8tgdXN7ugkWE412tqOIEbxJxLlvC0Kso5u2LwBp0dOyMfEq9o6rFwKAyhJeMZtci1P17DBKjZnTgwMgkrhuCaH8OASYeZK/Ap2yft6acVYaunvAJ81K8lubv9rMsh2jab+RYxqh4A+YvaAEMi5YFh19TdsQBv2S1eZ7wAteNIP18Ux2nm3xc7IuxjdWmHX7ANNl4mfMiC09dXwNxz6rYO86ykY5+oKHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(8676002)(6512007)(4326008)(55236004)(186003)(6506007)(86362001)(83380400001)(7416002)(36756003)(38350700002)(1076003)(66476007)(26005)(5660300002)(107886003)(6486002)(52116002)(66946007)(316002)(54906003)(38100700002)(2616005)(110136005)(6666004)(66556008)(8936002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qnsDWX1HXU+cLd/25XgYvikC9kW2OMMuEpQuSgAHzTRVuKYOvF7KDfSAYW3j?=
 =?us-ascii?Q?vhsL7S/M8ublWRVKtd7V+3ZrayUKHwCFf4M1MqzZssyjpVWK3Lev58NDNJrf?=
 =?us-ascii?Q?6dlmshbwTMme6GL9hbN6Lf0kKUjFEDFw4dSV5P057eXTnwbx+VzIckHlyLGh?=
 =?us-ascii?Q?BJn82jLM0gGCuIqmRq9OSC1+Tw/d4Ne9MZ/z6qgKYnlstQIIgdcgeTbWz4+7?=
 =?us-ascii?Q?msE1+X/n2nhO9i+UVXP5658CG01CVLrBHuW79FV+pbC/IYMf7ZAYtcvCOlzE?=
 =?us-ascii?Q?uEMODZAr1V3/7HJpji8VoM8v+iH9hY7QoLyKgCg0trbzpX+xjmKZfobN/fcR?=
 =?us-ascii?Q?/UuZ76m0CHseRhTP/K1r6RynfUXEFnF0zkgfh1oAf4DclJyXLPIhPJbX+9Aq?=
 =?us-ascii?Q?s2CDjXCjLMKiROk8mhqZiIbvRHGxjV3n3VTuyPOUj1isoF820cvfDBOw9Wq9?=
 =?us-ascii?Q?0b9R5MLqI8kkXJ87yFIvrnK6yAp8iY5IC5PevEy7iGPIhnRsTb6p2NdShlQp?=
 =?us-ascii?Q?Ol3WqWIOURrihC8IxGt6l6xWycTx8O0zZQEwyk3JxzlUwrr5vhK94/OwJNEs?=
 =?us-ascii?Q?stqLNs8uJy8IeKPUJIw4ozWDuo7KU2mFokhL4IJRj6jiYiHlxar1jwijXKDJ?=
 =?us-ascii?Q?kQP8HXHmQlkcBnQJLHSrCii0pjZhsnuD/ebBWkshORkstdOcTVksISVSyYFD?=
 =?us-ascii?Q?IXUfzR9zizJoSga8nrTbY2CJvBOI38GpnGYa5rNSdhl2R/10nFHgNH3o/TmX?=
 =?us-ascii?Q?5BMRsEbVOX0THHwGXYDQHzVybapw1hrKpjJw6AjGzgFbl9u6FBgv8ZEDVd5n?=
 =?us-ascii?Q?NWJfTzP7daZvcOmn+GX9sZsW1gm370VLSxq4lDtYiXgeUSj/9ezBdQP/dTEp?=
 =?us-ascii?Q?3GGgXFZvCfDhdbFqOTqxL+SnZ5EFKYkA/D2Mz3kN55kZLSFzx8iuC4HAazOE?=
 =?us-ascii?Q?W27iP2hCCJEwF9AW1otM2W+JJ/gA2dOeMwHP0jwBWredE7O5XXMQB8obRS19?=
 =?us-ascii?Q?A3dxaxv99WrNNJpFJzEZ+LQGBuQQrJkYdGfmFIjctxs1nibqtzGGriuFqse+?=
 =?us-ascii?Q?C9ixRyNFQrnXAbe8Pw0BmuG8mQeP5a/bqIHyf4wT24PHhB+dMxiv5MupXSVg?=
 =?us-ascii?Q?7YhS6HWsHBnz1EWxrtyGltp7eOcBI8K1MvQtJPHhF0Bn338bZmlPYcT0/s5z?=
 =?us-ascii?Q?NGgMOuyZeYXwUsxNY096KZn+6gIEfsVpIvKYQYfGQZ0CGaDBYu7a8N/1yCw9?=
 =?us-ascii?Q?s5HPnAncYMuXSFKyVVG1xtxnVGNUbAOdmNc799IzhzS47fDPqYmVxgL+mXO5?=
 =?us-ascii?Q?aCBLfaffaiRWOmpTpjtXKvGCQtfalXRvZonfZ1stY7722FIMFEd92zMbLoj/?=
 =?us-ascii?Q?T2qFR+HCfQlQ8d8h074G1zXS5Cts+rBZ126yB4gKfb0OsBXERIwuG3/OSEJe?=
 =?us-ascii?Q?iThyjuZHCRSSx9zMOCVAKusFgVIWUJDoRsoYpkyW0Lu2yzis++K/1GXKDwI8?=
 =?us-ascii?Q?l2RUUARXGx7VUpiTYfYYx+adk8arEKkjfmxKqi1ecJs+jVkgL5SdvMqpCU0w?=
 =?us-ascii?Q?de7I6yfaC5DTg9qedK/X5P8r7CLK1jbjU+wT5qfQPw83vCL+slunQ07w+mKo?=
 =?us-ascii?Q?GIB2P5C++iPt3+aElGLaFLM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc80fbfb-5ed6-4062-f5fc-08d9d054aa66
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 14:07:10.6058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/ijCIRGS/xrMszegfE9K9XJ7y7Gze1XqnxBdq+TrfCgoqbwx4tpZlKvRHGN7wv828cuURMn+a+1soK6XjVUnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4424
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, git-p4 would allow users to clone a Perforce repository into
a pre-existing git repository. When attempting this, git-p4 would
download the Perforce commits (a time consuming process), and would fail
at the end during the final git fast-import with a cryptic error
message.

This was easy to do inadvertently when running the same git-p4 clone
command more than once.

This patch changes the behaviour of git-p4.py so that it matches that
of git itself: disallowing all clones into non-empty directories.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index cb37545455..e15fbe1486 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -4099,12 +4099,19 @@ def run(self, args):
         if not self.cloneDestination:
             self.cloneDestination = self.defaultDestination(args)
 
-        print("Importing from %s into %s" % (', '.join(depotPaths), self.cloneDestination))
-
-        if not os.path.exists(self.cloneDestination):
+        if os.path.exists(self.cloneDestination):
+            if (not os.path.isdir(self.cloneDestination) or
+                os.listdir(self.cloneDestination)):
+                die(
+                    "fatal: destination path '{}' already exists and is not "
+                    "an empty directory.".format(self.cloneDestination))
+        else:
             os.makedirs(self.cloneDestination)
         chdir(self.cloneDestination)
 
+        print("Importing from {} into {}".format(
+            ', '.join(depotPaths), self.cloneDestination))
+
         init_cmd = [ "git", "init" ]
         if self.cloneBare:
             init_cmd.append("--bare")
-- 
2.34.1

