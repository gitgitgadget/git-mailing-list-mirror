Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D14EC433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55075610E6
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240779AbhJ0IJE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 04:09:04 -0400
Received: from mail-vi1eur05hn2227.outbound.protection.outlook.com ([52.100.175.227]:54730
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240647AbhJ0IIy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 04:08:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWzf4A8Xxrq/W9YZQYC57mk6TrxnJdCC6luTA4rppRWE3r+EPu7BaF9VZdFYR3HM5bwOLBWA3506yuC5Hul5k54foEmx3+GFtqlr9eoRzVigvgj06/UOSoYbKTqKuf1YjJKsOS3+Ran5KdyKTfxCwulIqahtvp00YQJ80YYv2YwOXR+urRUDDE3lakV+/ODNKBjT7t59qiMU5ZbXb2zJxFQEDAJnU64gkRAelnZHvpGzV+5Dz3uFpL2nQdwX/6HMKJy1aGn1JddCJStNNonNz3SIDdnC5n8DPo8zk4oOIFqqfxI5fMUAPCu37uKV5sqTV3yDZ8heYqzbxHvvp/B2ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txvIFM1eqJaPx+wshcksEwq6K1aNewKMJzDDvW/lEoQ=;
 b=jWksJ/8mjJXCgHyyBIocZ69VOnVHOALVdWrGyL+uVeRm8LcWQWbPaiGHg2Rwb8WPV+cZcX66NgNt4za7UJc20Jd1nzdZ4sz5nrx2h5DXyb1jb/PMqQoysPUTryUYLMDjKFZb10D1RCNAI+9MsUhr999MN6LVwWX20BEqSt8xSiTGEn+/XtDdgFoLUfMONlnOavNXhs2lXlQdOMZsWVOrtNnjq0m2JmMXuK5otCQMzi5AIaXrivHqVcHiVYB2zUuNcszKyHK/0n02YYN4o+QEcmMJ/xnjw5bPYUVPN0+Yev/Y1dPLgZJctDMECsrA1VK51nzkWx04nVGh31kvxpWnaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txvIFM1eqJaPx+wshcksEwq6K1aNewKMJzDDvW/lEoQ=;
 b=dl6OaMoI84pPuI7kzrhffRRG5phS2rymeRbrNIPyI1rRRkt0IqYULtirhdpOPmxM7Ux8cElKeXwz44pfPd7HmwdOeid9t6UQjzAspKy0RH6x2TxFGjUqo6OzMykh7aQvpH1mS7VxVqAlF3v4d1gkp9fe/WW7pVOfV8m+qIROluQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4270.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Wed, 27 Oct
 2021 08:06:24 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 08:06:23 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/6] ssh signing: make git log verify key lifetime
Date:   Wed, 27 Oct 2021 10:06:14 +0200
Message-Id: <20211027080616.619956-5-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027080616.619956-1-fs@gigacodes.de>
References: <20211027080616.619956-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM7PR02CA0021.eurprd02.prod.outlook.com
 (2603:10a6:20b:100::31) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM7PR02CA0021.eurprd02.prod.outlook.com (2603:10a6:20b:100::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Wed, 27 Oct 2021 08:06:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85924203-8104-4466-f9b9-08d99920ab03
X-MS-TrafficTypeDiagnostic: PR3PR10MB4270:
X-Microsoft-Antispam-PRVS: <PR3PR10MB4270240B5D87928DF37EE849B6859@PR3PR10MB4270.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KsLQzlxqsQwRHt987pT6F+qe2nv/Igdw1ZDaIidbHAaDXSj2a9zQRd/GwAW3?=
 =?us-ascii?Q?oFCErdpyeD3IPhrN4vu5h3+OAoELE44teOd6m5mQpLwP497SGGS7z1zhQvHh?=
 =?us-ascii?Q?RzSPA3u5ON4wq2Z/indFibATFqSt0DFKoxpWu2l3ZbGtUjZSqE0+jPtvKogV?=
 =?us-ascii?Q?WXCckhWVlSonIptyNcTjtVBZfMI88z0RQwLlgP0+LUe2eWt+RomzmSIJNRtt?=
 =?us-ascii?Q?nURQYlPMkxjhnHN13VpNZb0iE4BUT28OZc75f5pwweZch96yNUjMifB2DznE?=
 =?us-ascii?Q?xT4jMqaZbYacDAf02F5Gqh8mz2V8cJEAysR0lgOBJQJ30jnAol0SPaOrcOPb?=
 =?us-ascii?Q?oRK0Tv60DENpmyMEHMlNmA/3dM5LRjqpW43qJ1l1vByIjfN7kmzZL9Yo7/ro?=
 =?us-ascii?Q?ZKRwKNPuI3awCZc87Up1nQQLoWh9sk64mJxnEd76AJ3zhAMbACaQERTWazLN?=
 =?us-ascii?Q?tSHOt+9cUCtWavKTs9eMH5HmOByvMy/cyD9Wb3tG2zcRbxZMD+ywDCw62gpj?=
 =?us-ascii?Q?epYvICZg4t2ceT++8o1IV6TE80NXJCBmKlo8c8sE1FnaV9biSTq47Oan0MH4?=
 =?us-ascii?Q?7Am/LRWcpEpnoExhAv5HHGrgcVRFgqMQ07Wbb5IX5W5Xb7AVc7fooC4nFQQT?=
 =?us-ascii?Q?AA3Uyn24NLjmyxER/Raa6byFnoldMO3ARwK9Vp+92PzsqrLR7G/GiSnZ5r2L?=
 =?us-ascii?Q?xTcqWEgZGEyxDHqY1aPAYL9w3JBySK/dz0tRmkt5sVJ40MkleeTtrgQpKspY?=
 =?us-ascii?Q?yfcOb8JmHZmseF5LzmyHXJv+a7MvT12LXxhnXkbcAkQtrt/ATIlgev80LewK?=
 =?us-ascii?Q?zGqbEBE9YTUcdxPADhq0VfD8FVOcQolC6VSIUVJTio+JTGQpjrVhEllmen0s?=
 =?us-ascii?Q?OfbC7pEuxCQ4VoW7+HzhTX2TB50bL1I4HsEz9OPu2BIcBlPX6WEs1YhVUtdh?=
 =?us-ascii?Q?VCMO3BottSTN5j/qHzujU4fenuAeXoKhCnMGvmzHOPb7pmn4mCs+hvrlvs6v?=
 =?us-ascii?Q?aZrxn3GE1buKgMlU0hh5nE6PeQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(376002)(346002)(136003)(366004)(39840400004)(396003)(4326008)(52116002)(8676002)(1076003)(508600001)(8936002)(6496006)(54906003)(6486002)(316002)(6916009)(36756003)(66556008)(86362001)(2906002)(2616005)(5660300002)(66476007)(83380400001)(66946007)(6666004)(186003)(15650500001)(38100700002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gIK/N/KQWdWjAyiLG377tHc8MKC5Q14IsAWptxnlWPxjWXYvGFv1JbVvDiVt?=
 =?us-ascii?Q?T5xAsPqDtofq1UJB0t5364swAOER3oaJZv6VlEm/LdLnfvUN3/2HW83tRfc7?=
 =?us-ascii?Q?8jCcSoqxVveC4wPdhoxuQbHJHm8kgRsfpik3I/HDt8yWsH2IgF8qnuNVXk2H?=
 =?us-ascii?Q?iTaOC1PpGA+iIMKhF96ljD8y/nexnCDLZnZKu908g1N4EvINP0AhxeBowqSh?=
 =?us-ascii?Q?JZK6FiXKNZ1mvyDkXnueLRqVaLScufyrVTdRCYl7Wriv/+i65K3m3Pmf6I9C?=
 =?us-ascii?Q?HoTQeeGvX+x9dF8FQe+o3xDki9LV3KGB+uYOHEt8CiZHWwL+O8m+933KnDhb?=
 =?us-ascii?Q?VbL++VxirRUQVmDzZPhv3Zb7nN78W1t6JRpR890yB2+k8Bt7nMmzOjDrL6sJ?=
 =?us-ascii?Q?Df3HBdgIF6tXbq0wFtzbaDWWM8bBBZ9W+DZlhYBJPdVkkUf0bbkFx6LITQtt?=
 =?us-ascii?Q?VIvxWNfOxi8w817lucUla5xs4RcTPyd1uHwTtsNdCOFPMnFvqFHUbx/lmtTZ?=
 =?us-ascii?Q?mucY5DmyRZT24FCJxW1rFtmMy7PqzHRdTdHwKjrDdIk3tXM7yIYtMJ1ECPM0?=
 =?us-ascii?Q?SZc4YF8abEcRGgqbM4G9EcswnFaDDUa0NOlp54MXB9bafd9YOQ1C4uCJ5FFf?=
 =?us-ascii?Q?d/c7IcEWaPYdQRx7nhntUU4Ub5lNB/AkbeDhW1qlFlm+rqjkNbSOWyzpgd1o?=
 =?us-ascii?Q?YDQEW5D+/l1ErD3qtQvyXR62srcYIfuK8uk7/koPJ83JHzyXf7eTJPLLcPfa?=
 =?us-ascii?Q?IQW9S5EtcK5dbhOqVKfbxL3phC9MVq9yfiLiw51wYkAmq0V5lCroWolv/G1d?=
 =?us-ascii?Q?GArfuyVpXdA8uw1XsfKeqUElalCRGcjTwnUw1zoFvpajrm5VMPopxrHzZjfr?=
 =?us-ascii?Q?TChCIR/F2DnuM/0S9sAw41glEYAFGyNm3YREr0KZEhgMFA6Z8uvN104dT3TO?=
 =?us-ascii?Q?ErKmKgKML6pUkFTfCT27PQVSZvjVTvi1+Fy/9sb3t1n51Y9rVddvFZCkO5+L?=
 =?us-ascii?Q?g7ZXPVuhTCKG+2R0aIfYNDcO5LFM3MVUm/Pp4i2Megk5j9s1UCLEua1jIjCo?=
 =?us-ascii?Q?4/GhLXWWu6KN+AIZgRRc+WTzoUCURVGuYl7xxzOcVoGuJilyHwWUX7K0ewFi?=
 =?us-ascii?Q?UHEw8SKNo/I/nYvXnI52HfE6jEe39xfv3FRrtJeL6FHaroK+jjLF09pLMJI3?=
 =?us-ascii?Q?oWFXfs/pdpFmcYnV7jerMJ4GzkVtfrttV4sLLmKD27YPsmiEmzjXqH/akIEx?=
 =?us-ascii?Q?RGWAfQgqrCraJEgolMky9fNQ8pfakk8NvWCoeOqdnt1IaJf/iAwr4w9bbE1P?=
 =?us-ascii?Q?Qd9PyuOoqRQx7n+oIxgGqrvyeKPE2rhIU5FDTMMJfmEsVt2bOkszpmJ6coXh?=
 =?us-ascii?Q?apHU5RYIpHLLW6sLYMQOpuVcK454H03TUg2FaNw1UPTlh/LC63/L8+r0cq52?=
 =?us-ascii?Q?OMjJKQcvfSYhak/e7QebIZvI07L7iiJHufFNNXwuyLw+p627H2KyJcD9q4zA?=
 =?us-ascii?Q?fV2qxpGlGCMVhHc6sVjaLMFT+Dx0k1iRx/8fQGkqIduKq7YUQaq+h4VPlmCb?=
 =?us-ascii?Q?fMIXtnBAnXRZV22mQ9ApRz1kJ2RwbUCEDDiPImoNmDxgiGgS+3XAnGN0izs9?=
 =?us-ascii?Q?BwYt6wuR0M1TAvjhsozxZ0nhzF4AMvv1TEh/tXIK9VZlNf8AULZbwUPM6ct7?=
 =?us-ascii?Q?+8HeGQPgG+gP15t6WD1eN8A3X3xMwdXCMyKxHKF1V+NRoUnyDic1eI28gNjP?=
 =?us-ascii?Q?V5fw5XUSJw=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 85924203-8104-4466-f9b9-08d99920ab03
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 08:06:23.8486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rScryoXuHU94353uUzmUDAri2tkT76FfQ0hTzjxzuvV0dNX3p76K8Yya89cMYN6sw7RHs23VDwJJhmoPRLgHCnOHF6dA/QdC/zvsBjLXOtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4270
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Set the payload_type for check_signature() when calling git log.
Implements the same tests as for verify-commit.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 log-tree.c     |  2 ++
 t/t4202-log.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/log-tree.c b/log-tree.c
index a46cf60e1e..d3e7a40b64 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -513,6 +513,7 @@ static void show_signature(struct rev_info *opt, struct commit *commit)
 	if (parse_signed_commit(commit, &payload, &signature, the_hash_algo) <= 0)
 		goto out;
 
+	sigc.payload_type = SIGNATURE_PAYLOAD_COMMIT;
 	sigc.payload = strbuf_detach(&payload, &sigc.payload_len);
 	status = check_signature(&sigc, signature.buf, signature.len);
 	if (status && !sigc.output)
@@ -583,6 +584,7 @@ static int show_one_mergetag(struct commit *commit,
 	status = -1;
 	if (parse_signature(extra->value, extra->len, &payload, &signature)) {
 		/* could have a good signature */
+		sigc.payload_type = SIGNATURE_PAYLOAD_TAG;
 		sigc.payload = strbuf_detach(&payload, &sigc.payload_len);
 		status = check_signature(&sigc, signature.buf, signature.len);
 		if (sigc.output)
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 6a650dacd6..2b12baab77 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1626,6 +1626,24 @@ test_expect_success GPGSSH 'setup sshkey signed branch' '
 	git commit -S -m signed_commit
 '
 
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'create signed commits with keys having defined lifetimes' '
+	test_config gpg.format ssh &&
+	touch file &&
+	git add file &&
+
+	echo expired >file && test_tick && git commit -a -m expired -S"${GPGSSH_KEY_EXPIRED}" &&
+	git tag expired-signed &&
+
+	echo notyetvalid >file && test_tick && git commit -a -m notyetvalid -S"${GPGSSH_KEY_NOTYETVALID}" &&
+	git tag notyetvalid-signed &&
+
+	echo timeboxedvalid >file && test_tick && git commit -a -m timeboxedvalid -S"${GPGSSH_KEY_TIMEBOXEDVALID}" &&
+	git tag timeboxedvalid-signed &&
+
+	echo timeboxedinvalid >file && test_tick && git commit -a -m timeboxedinvalid -S"${GPGSSH_KEY_TIMEBOXEDINVALID}" &&
+	git tag timeboxedinvalid-signed
+'
+
 test_expect_success GPGSM 'log x509 fingerprint' '
 	echo "F8BF62E0693D0694816377099909C779FA23FD65 | " >expect &&
 	git log -n1 --format="%GF | %GP" signed-x509 >actual &&
@@ -1663,6 +1681,31 @@ test_expect_success GPGSSH 'log --graph --show-signature ssh' '
 	grep "${GOOD_SIGNATURE_TRUSTED}" actual
 '
 
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'log shows failure on expired signature key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git log --graph --show-signature -n1 expired-signed >actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'log shows failure on not yet valid signature key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git log --graph --show-signature -n1 notyetvalid-signed >actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'log show success with commit date and key validity matching' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git log --graph --show-signature -n1 timeboxedvalid-signed >actual &&
+	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+	! grep "${GPGSSH_BAD_SIGNATURE}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'log shows failure with commit date outside of key validity' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git log --graph --show-signature -n1 timeboxedinvalid-signed >actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
 test_expect_success GPG 'log --graph --show-signature for merged tag' '
 	test_when_finished "git reset --hard && git checkout main" &&
 	git checkout -b plain main &&
-- 
2.31.1

