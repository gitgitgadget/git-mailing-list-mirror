Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036B0C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 08:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbhLII4n (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 03:56:43 -0500
Received: from mail-am6eur05on2089.outbound.protection.outlook.com ([40.107.22.89]:26977
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235315AbhLII4c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 03:56:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n27+PWUCmlA+A8q2noJLgvsKii9nOtLH+lV2v9FKcI601wGT7ZRwXkC1gMIuS7/S0mkBIzNQFHRznmVYB8zeStEwpxXuhYLf4SAY3wCRiSyyxF/VMi0vp1ZJLiKO4J43gKEbeDGRgsthhbG22MfwqwErS1qDG2kTUn6KWyCXt3ef8h1yaRxyaUoIQzc9qWjMn+N2ZMHYtZ6AgJCYBv5h3oz+iOtBfsMSyx2mQtyBhBYVlS1EtvFDeFZ3ygTgkecDmrwJ5RGVawDH5GIgN7Wnj6Gc9Uq/Vt8NtQLyy/kbzNhicVun4HdhHwuiz6o/pTw9ghXCYP/f95G1iPPsJAEPgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1l9qmJoDiqvIXf+fkiDiFP54F8XDYP7oD2aRaUktoYs=;
 b=C8FG4ZNFz0QMwHfX0FvH4/HkVr+c4zQEmye/ybymeIJ3bOBkZRQFJC9sSIdpb5UO0+2Y/dwFPUcZCmTX163wQBBh4hMKyYwa/coc/bHQD38Hs+dvrxE/GlJBeB6gzJ7e9XZqrhF1ikIe3S16/KEL31rzqoklHWc2ykxGJhT5JT+aYsRtcAvEanCGRNqlLiI0ahFqywW7wwtf8k5evOBPFCR5HZqO11tm5MZOU8hEzzOhmJar79hFGwD+IoOWoXNWEpfLEMn5guaRInVK1evsJ0y4jXtuw4Maiodug47X5Y/8DtDPZQ4fAtNygJbK/AXUg61D28itbdOvC2h1s/5OlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1l9qmJoDiqvIXf+fkiDiFP54F8XDYP7oD2aRaUktoYs=;
 b=SsQlx8LjC0J+H85sV2/nJgCI3qLT3OMyY4wki3DaUWNRsyUmlNaN5uMeYfO8uVJ8V8v7W6wEZgteOR2agpuaFcnt8K8DDXRoGGi0cKYCM5doT8fxb3nudlpT/GtZnGoWySXCfCHl7rTL2X0a2+HG1abhkhdidrH8+o6sI0VsCAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4110.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 08:52:58 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Thu, 9 Dec 2021
 08:52:58 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v6 6/9] ssh signing: make git log verify key lifetime
Date:   Thu,  9 Dec 2021 09:52:46 +0100
Message-Id: <20211209085249.13587-7-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211209085249.13587-1-fs@gigacodes.de>
References: <20211208163335.1231795-1-fs@gigacodes.de>
 <20211209085249.13587-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR05CA0046.eurprd05.prod.outlook.com
 (2603:10a6:20b:489::29) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:3e55:2984:f78e:8b18) by AS9PR05CA0046.eurprd05.prod.outlook.com (2603:10a6:20b:489::29) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Thu, 9 Dec 2021 08:52:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c7b4934-5c2d-456c-c434-08d9baf14c2a
X-MS-TrafficTypeDiagnostic: PR3PR10MB4110:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB4110E2937B464C5F8592E15CB6709@PR3PR10MB4110.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZSJZSB87hzCI4oGb/ZUC8ixsRUNQKvbH5xPs16CKY1NVpT3DU4rvF0+VMvZ7h/AMT/em3YGGjtF1Cpq1ZU5Az6OIm8DRh0THnuNtRC66CILD9F8h/hG3X1+90deC8UPNYYggGG+kVAvIqgd/S9LlmhPdIzJC9HgVyQmvKOywGNPcrU9i/4G5WHyFWBC8vTEt/Ce3eTFQLWfQJow0DWQKeYOcwbECJQV5GZQ3zjffIXmqaD6O9wZDb2wkLpzRzD2Kag7GtUon/AewbGetbREB1tPcQ++FqScTTYtmr+rJQpnlBBWQV3dO/8CjEl/6OuW6BTAnxpb3iTfgllEF4FoSjZW+OhjRQ9nmRsNqfVYQTEkolI9WkXqWL+dfkb/Y3cIBIYnjdOYsIKCtn2CVXTvE5/Jdj/YRBPSy077wwfOrN/Ow9V2/XAOdqQAzDVK0ZtKWO3d9dH1Mbgp9+vSU88LeALFVi+OdAxccWFb4u2MY/1bDAUfv5V0HWgy9Mb7fYIppD62HHSnPdGg2BNGn2nYUqYeqItepFUpczp1kUZ2foMF7L+h/199Kzk4VmRY4Xq0iB/HoIy71Q1JyYKy7Tm0U3bY4ST4zVBx/S72iiQLRb8dfKTbnXC/GtDyIY0t6h/nYugHiXuTTo/OCsB90S4ANjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(39840400004)(366004)(86362001)(15650500001)(36756003)(8676002)(54906003)(8936002)(316002)(6916009)(6496006)(6486002)(508600001)(66946007)(66556008)(66476007)(186003)(4326008)(2616005)(107886003)(2906002)(1076003)(6666004)(83380400001)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+MD2L+JMpnPL9Sm/jmYvJeUIu/vP06zeI38xy0md/+Cad2lCU/ccS2p+wiND?=
 =?us-ascii?Q?KZOR9Uwmb41fgVET1Yv6phh6eZ9Ov+XJYgs0uTIPHogSNTjMVMZzGP/PA6+/?=
 =?us-ascii?Q?RDqZVeIz/gLN8QhmRcsKxUevMPAafsguKMXdakl2J5+gPyHp0BAVz+dr7/su?=
 =?us-ascii?Q?Etm0Mc+mMa8GvFjJFXc8moHu1GgD5CNErWXuerG4gI4oCf8ANQuEM7l4l0ID?=
 =?us-ascii?Q?BZ69FWv95XIFvaEOCdclqggqVAbOrBaSjbDG+Ly7Fjv7Plx4HzCXkM9RUj99?=
 =?us-ascii?Q?+TAORgzLjZLb5kbKH9mwm13slr5zgP49sJHmWlo2GG1OTfRT92ObjbM9ufOi?=
 =?us-ascii?Q?/U7t+EfcC12tCSHETbk4jtSGxTa7/lLpY9XfFm3IU1kaWCR4eAK4Z/7IC2yb?=
 =?us-ascii?Q?YxYazmrpmq64JGOhql9gRZYR3EYEzRfc8XJEsI2k5D1UzLeThTzNI0sP8aQs?=
 =?us-ascii?Q?EuVuvRRs1Yo202T8Kt71pWBbgHpIpe3MqGkq/pDbuTTRCYMnxMmNeemJqiuG?=
 =?us-ascii?Q?VWje82Tm18I8Z67Mldn9jGfHmQzZ6XTi/XrRGr7zsWmmuy5se9PUbKVAW9vn?=
 =?us-ascii?Q?FRCx2kEqdVQc0UBhp/r6mnNpcOOpUkACqvG8WTX0lUhTnnBaHXDDIZbrVav8?=
 =?us-ascii?Q?ZssrZ7BP6zUoYu42u1k3JitWOGLDI0367akIVKb2cOIXilWoGYLh8A8Qo/ff?=
 =?us-ascii?Q?KOOyzYzUyGwQGkMpGC6GGhlvj8+8HbOX87yERkZIjFE5Ks8+OcJybMIVDgq4?=
 =?us-ascii?Q?pvWLhT7MDZ1iUcKgoFD/O9fBeguvHbKxwQoTUJZ7c3WRqxAWky5V3YT2tPbr?=
 =?us-ascii?Q?G3suTAgO9x/jI3g+V8KMv8qcdYarUxp9dO3a9B/7u5EGU1YZ5pod5yW0hSDB?=
 =?us-ascii?Q?SrBbBOI5DYrjH9xs0oyNiispRciDVlCMI4amA4BqHXHrzc/alCTOsCc+yAP+?=
 =?us-ascii?Q?i31QDD4offaU1d6vyfBEqN3FRjc8pm6vb/H/YdVz28zHtpE7JBkR0l1uJDq/?=
 =?us-ascii?Q?N4xP4JtG73wlsJC76tIjiLNbr3ijFstYOvP0fyx2xlueSky70QMzkZNkZefa?=
 =?us-ascii?Q?AagCkDCMVkEjbzTymqtl863hD/lyk5BAdo/nSfrucuoZrDUnUOiFKNFz736f?=
 =?us-ascii?Q?PUVJ0OmUhnzA6FPMbFGIQuYe2MvYbmf+YXxgHosLjyOfTu97HcbjVieXF89Q?=
 =?us-ascii?Q?TOsOc9B7HITjBB1y5p/r2V9jO8AaOqRqRk3O85AKR1y6cg94uPL3kivR7Q14?=
 =?us-ascii?Q?BhPr5l7TIDtUIQAp8hFAmiXFtW4v/2jra0Q6G2D/2bQX0rwsJQmSpHQjAeFJ?=
 =?us-ascii?Q?qzj69GvVV9Qt5sIbQUNKeZqbyiUKPO0kwib+x+9OwcdZj57XMxIHS+GpD/AB?=
 =?us-ascii?Q?HeWbKsM294GR7reGYteDgoVkVqeFBC2ExScKF0QPRUEZhbgynT0W8Ooq9CGa?=
 =?us-ascii?Q?A8SddYM/3w+86Ygqoopst9/xlBJ8F+NpRvIulPUCLiBZ0x5Am8XrCHT2HHmM?=
 =?us-ascii?Q?wOdPfgQXBk3GTc67mJsW4QOnq6f67lLqjGhSDKXjV8Yr1Ex3JVjL5YT1dA76?=
 =?us-ascii?Q?hxJ/QUiVbKyk6uxCFDN39zSK2YLD5d4wntDNJQvYgoKsc3ocGBbceySQOpep?=
 =?us-ascii?Q?z7E645/q0Lh+BBznXQjus49uKZ01c4+fsKk1Wll/dGIvCAy2ShYGn20oGAuS?=
 =?us-ascii?Q?SKpph1oD+bIaCMKK+p9Nm/Lr0pUBvNN5KbpwF1p8vMd97yHr1N4jPmzCEyG2?=
 =?us-ascii?Q?0pgdHt24rMSBwMqs/d8VRfs6ZpbIWVo=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7b4934-5c2d-456c-c434-08d9baf14c2a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 08:52:57.8994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nB9wIB8MHGF9n71VWifvff6CkTR04mBRj+8UWixsKwHC6N4b0rq4xcRld2OcgPdgBZKk9JcWg9nv0I4BogWoDsnrE/Vwne+BwV6l4zw39Rk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4110
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
index 7884e3d46b..ba855ec893 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1677,6 +1677,24 @@ test_expect_success GPGSSH 'setup sshkey signed branch' '
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
@@ -1714,6 +1732,31 @@ test_expect_success GPGSSH 'log --graph --show-signature ssh' '
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

