Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EAFC433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 08:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbhLII4a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 03:56:30 -0500
Received: from mail-am6eur05on2067.outbound.protection.outlook.com ([40.107.22.67]:2017
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235264AbhLII42 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 03:56:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSe9ElfdUMVT+DXUHf9Q5F7JUCvDvo7dBVYsPMRZHlNWZiD4sAHYcZbd6SwZ2Sy5MOOa2gZlayqhWTxZhydPZnpEJRjpDXV38kgLYQtx0pcr3hseI5docm+PIaDmN2wQKH1/HGA/9FT/fPhA2YGTgBTCjsf8zNpi2Rn5a54+a9mY2UFyTSW94xU76EGLC8ujS6RtgIZcfo2ieiF+g6f5kIpqIpU4D/+fypoEyiQ8lggPluRkh3PxGaDvhQF71Wl9ZmxGw9PAiQakOFGzu+PuL/33hsbMwPkcyxIAPAnpyZZKTZT1rBDzK0kyc2z2HHg66RR1GNCMwWjvzLruv+ReQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48OAVczOPeEXT4UjekR2QYNoE/zGnjRZkD7iPTlopcA=;
 b=O1iyO8fwIwb1FtxvHzhInExynJg4etWCepqpU51skN/1n0k4CmIdzRJ64wUQWQTsPmBOkgrwRsBdk1jxf2J5h3NpQqGiDxs7yaOuiPluS7tH21IcaG8WYWGDSPz2eHtfM3ZLeuETvT/5R5X6HVa4NS0or0hbiC0vUHvHkp5+yhzyEXTCYN9lJZzJRMA+ukjEbVL6PEiYPVC93wcGNiyEfO2KwXJg5dFacDklMQS0ELeNRXKSUazS2OloBRIHRovUsq6X/HXqUaMUp6afAkB1epuXpiDaMSUjBeGPR4oWOFXGwdD3CDt1Zad6VMR+Z4NNprgLWsPLq3qrOoLOSDjhKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48OAVczOPeEXT4UjekR2QYNoE/zGnjRZkD7iPTlopcA=;
 b=QYLNPmKimMHhxW5LV516Ra3kmL8VB1eUruU2A+H0gkjsIbHOeTVjOw9serRYr/fBFr3E6cSrqTmravJKQsCRuHM3dW7GyqvhmFG4wEstJtPPGJNkCwRd8vR6AUw0dSRbyVsisDMcArph2b7TILeltClbCi8ha7elKy8OgMf6xNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4110.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 08:52:52 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Thu, 9 Dec 2021
 08:52:52 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v6 1/9] t/fmt-merge-msg: do not redirect stderr
Date:   Thu,  9 Dec 2021 09:52:41 +0100
Message-Id: <20211209085249.13587-2-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211209085249.13587-1-fs@gigacodes.de>
References: <20211208163335.1231795-1-fs@gigacodes.de>
 <20211209085249.13587-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0012.eurprd06.prod.outlook.com
 (2603:10a6:20b:462::34) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:3e55:2984:f78e:8b18) by AS9PR06CA0012.eurprd06.prod.outlook.com (2603:10a6:20b:462::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Thu, 9 Dec 2021 08:52:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fc0af76-42ff-47c1-5ee2-08d9baf1491c
X-MS-TrafficTypeDiagnostic: PR3PR10MB4110:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB41101E1C3505F37E3E2CDA84B6709@PR3PR10MB4110.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HQghRJTqNZoIw/f0tqEdKJhloKyLZn9zmuG078nJaWgEdbZdPEX2xnyb4WlgXU0awciFIwmWgD4J7Jw49UCl7I2m9MtmH+bGd+tbhOxr91FwbXGjQsEbPzJKvlxWAZf6Tigga4jkQNS81tDslOSrUgBZMkUHkVDYe9Uc/HDyEQZDw1Xq+M4QO2vSdLLkAUA/oAl+xhgGO4KkQoarpbWo+TuVKAz5zNS4KcF5ZxFACLORAq9B4rVpWg/zZ4+qnl0SD2eBfYEXDyOLEZrEounPTkp5Zz9DXGuBzaU3OOpr/q1F9yNWhc3e7q8JBSHwNE3Loa90OlT/c0oizEnmjKU+7rXgDxU0mQmz3TgT1SWSVPhK803Fiouw7yNj9HJMNpTBIXFlzikMLKx2V4iGFuiEVv7zOU3hi6/gqCKwuNYIdj3924cCzAqiwC1uKHN8z6L4c1At8bYo6i4kGnO6A09Nb841oG8Y0B4vcSiw4sPtNmUm4CqxyYWL3W2uThoIoM6jMUGJKeli0MqHJnLjyR8X8rME3L7zKLDfNfYpqb6Cvv69ZkFa36hS4zOmJBRPuPgDS/8nCOg1jo3ttkUo6HFdrvh1ZRHR5WMfNbQ/m6UmqGl8IPbY8F2uqYIsxZRfpc44cCWBHVB59jgkoue4dz3hhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(39840400004)(366004)(86362001)(36756003)(8676002)(54906003)(8936002)(316002)(6916009)(6496006)(6486002)(508600001)(66946007)(66556008)(66476007)(186003)(4326008)(2616005)(107886003)(2906002)(1076003)(6666004)(83380400001)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FkScndpX2oDu/QvkkFu62JMu5kVjfLufKjR1/2qbcPW5ZyCq0RDmwz1gCXfG?=
 =?us-ascii?Q?G16R6CQiTQGue+yeGgWmpekee4N2IAAkj2ZqlGig+76hxUvj0QROzHldHTMU?=
 =?us-ascii?Q?YybUA/wYbrtnWMZraMeX4JvmaN1v4tMv8qi9Y3VgEpbCWMILxwuB+wGq5bSE?=
 =?us-ascii?Q?f4VYwD3+NK7DNLxIozs1bPyAc5UoHsL2dy8rk2nDS7Ll8dTQnwLYffZmM/3U?=
 =?us-ascii?Q?5HgSbr5nh2knZ2h+y2yMshQD1P2faIQcO1C+3+bpnnY1Kl1V0r0a4to7cHaW?=
 =?us-ascii?Q?5p/0Rt3DQ/z276uhhXt1JkS6yjicIAWTB2c1qMprut3vR6nAnhWEClq6D8B2?=
 =?us-ascii?Q?aizukU1cl+v+bm5ZW0CgT8/Lqx8EWGTkcS+IkxgXOL4KhTsxh9Ny0ApDzKRa?=
 =?us-ascii?Q?RXyqskFv92oOwTBDKIGLatO6N699fJheN6WZz03W1ApwmhBZz6+IcuhW54GK?=
 =?us-ascii?Q?nWYwpbn5jjYZP1TBh4ErG8zsZNGTRu7SzenZeztANsD8Oug4o0KPzkZK29oC?=
 =?us-ascii?Q?4Y2rxy1aZ9/KZlBNGyCeuGgYLc1bOuG0zwBbW6Yvx/2ezW9m7VD2Czx6u+XJ?=
 =?us-ascii?Q?rjtK/A1MG0xEYau1bw0qc1gypLofy1wwnItsXvhaqaFL+K1H/nbl7IRN5EuW?=
 =?us-ascii?Q?u9lfEayCaVW+cTIIIUNQItH4lYMBoME6apNiBUStJVAYk9sYbWlDf3iYm0dA?=
 =?us-ascii?Q?GMYla2Y7nNv2pzi2lD31FB0n+Uy7ITl8mTIECDqirPXgmzsgKg31VzPgz9v9?=
 =?us-ascii?Q?B+ystawBm9Oux8bV2mezd+T4yu5lwyoCElXW3u++tkL9uJKjIBJmzDhf5uAG?=
 =?us-ascii?Q?a97ILxTdPYaFcs+Ly0IvECSlrmfJ+Pcb+vDV4/LN/N50FJSBBISfz5NYtgrn?=
 =?us-ascii?Q?lLY7981x61OFbtDA/D80AO9OuO9H3ADFm4iKgzt/ER1z0Nka9BmGXxEnXa7A?=
 =?us-ascii?Q?rIB6y74xVz3m6S81oetqvullnnLCcP6YQzLAj2n6HmCeCHOCfMa9Gfp1fpyA?=
 =?us-ascii?Q?w1RLnJVhsF4K7O+w2IOOAT/yX8WryLMFLQ6sBoovI8ZYH6Qpqga66NgoxLET?=
 =?us-ascii?Q?sNhgAbooxGQ/GkROOVqoA40rbXn0RlUn11hEStaKOR7YAhZmXJMTKWA4RNFi?=
 =?us-ascii?Q?AIk2T6xRU7fxrsWghXuSdJPbz1ChH6dSAXD980rG1ELTVzum/0W6nfYmLfo6?=
 =?us-ascii?Q?u9uSzQxAPia+7JHf1VPGPZXj+FykcJrqiwjA+eh/mIIVfaaUAecFG2QPUGdF?=
 =?us-ascii?Q?iTSAQ1jqPtASZp2sh6PT3d5cTORZNZdVAucqWH2VXp0Mf7lOXmGqPVJhOo0R?=
 =?us-ascii?Q?1PveYtY9ddPDhNFFOolD31PvlkkOXlIQj0kAViLlTuir50FaVQTaV+NRBE5D?=
 =?us-ascii?Q?ur1DyVSNSEC9YbSexbu7rZExe+jIHUQHn013N4ECasVxov9dRLtbAqPLeMql?=
 =?us-ascii?Q?iBptfzpGwZLcZ7IwoxzY8iPGvIaUFC7RkOTMwI5+5suuo956/A21/eHgSVx+?=
 =?us-ascii?Q?xqqil1XSk9r6bPJONiNweFbRvh/YpngNauQUXNQjg7D+v6/nJpUn805es+et?=
 =?us-ascii?Q?T77v5xvbeAvPqkvNzt3UD8qE78VkBOqkJVMjcsoa7C2WjLpLFiHJAjFNnYs7?=
 =?us-ascii?Q?rFXZfzhCxpPQt2OeNNjuhHmavshAtovkG85otmPL39Re5DI0RLCrav/rYzw5?=
 =?us-ascii?Q?w4GlNrNH8jpayLsQyrTDHoR2JxYuWm5RX4ARhq+IGC5nBRKtitxew9XGYUH1?=
 =?us-ascii?Q?aH8obcj6MA=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc0af76-42ff-47c1-5ee2-08d9baf1491c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 08:52:52.7082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSABN8qrryQ4fgt8zW/H/mXeiFdEnvoJDhu9xkVnJN+rQhdKa2OL9QVwdQUJrAFIj2VNQezEOA/F1NxgKLtDzGhAMJJytygK2k5i63Gxwv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4110
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All the GPG and GPGSSH tests are redirecing stdout as well as stderr
to `actual` and grep for success/failure over the resulting file.
However, no output is printed on stderr and we do not need to
include it in the grep.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 t/t6200-fmt-merge-msg.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 06c5fb5615..cc68bba064 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -104,7 +104,7 @@ test_expect_success 'message for merging local branch' '
 test_expect_success GPG 'message for merging local tag signed by good key' '
 	git checkout main &&
 	git fetch . signed-good-tag &&
-	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
 	grep "^Merge tag ${apos}signed-good-tag${apos}" actual &&
 	grep "^# gpg: Signature made" actual &&
 	grep "^# gpg: Good signature from" actual
@@ -113,7 +113,7 @@ test_expect_success GPG 'message for merging local tag signed by good key' '
 test_expect_success GPG 'message for merging local tag signed by unknown key' '
 	git checkout main &&
 	git fetch . signed-good-tag &&
-	GNUPGHOME=. git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	GNUPGHOME=. git fmt-merge-msg <.git/FETCH_HEAD >actual &&
 	grep "^Merge tag ${apos}signed-good-tag${apos}" actual &&
 	grep "^# gpg: Signature made" actual &&
 	grep -E "^# gpg: Can${apos}t check signature: (public key not found|No public key)" actual
@@ -123,7 +123,7 @@ test_expect_success GPGSSH 'message for merging local tag signed by good ssh key
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	git checkout main &&
 	git fetch . signed-good-ssh-tag &&
-	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
 	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
 	! grep "${GPGSSH_BAD_SIGNATURE}" actual
 '
@@ -132,7 +132,7 @@ test_expect_success GPGSSH 'message for merging local tag signed by unknown ssh
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	git checkout main &&
 	git fetch . signed-untrusted-ssh-tag &&
-	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
 	grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual &&
 	! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
 	grep "${GPGSSH_KEY_NOT_TRUSTED}" actual
-- 
2.31.1

