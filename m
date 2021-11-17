Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72495C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 558D861A52
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbhKQJi4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 04:38:56 -0500
Received: from mail-db5eur01hn2234.outbound.protection.outlook.com ([52.100.6.234]:20915
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235132AbhKQJiz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 04:38:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuDLFC9vc+7md/v+Xk3GPDFSIyzKdJrY1U8l2W19MlIhieAKHvdKx8ql0NSp81brfBG0xBOMchYeJdxK7tPDBpmUWsn9jJR4G81jLzdsRtcYv2ynwsbqgZCCtqK9kWMtksRjVp1Mdhny9jF8w4M0sL5Popog0RRPeMwQBxmGBYyeWiTOM1BsuSXQZ7R6/b0C4TsdWwOWiK697aYbBikFbkbuzYc8NpR7qhuNEgUKnVpV5F+LvrblODQ+2tTfWkA1X1Rtki1nF/X1fX2H0g9ZpJLqgfHX73zMlN3iBkFfFTC3XJCRZZ4P37KWdx++uTicuHEN3NDndtRMDK6J7/l5Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1l9qmJoDiqvIXf+fkiDiFP54F8XDYP7oD2aRaUktoYs=;
 b=Oo9PVE7mvdBGQNUi7GXLl6PgIxIajtV0kXSac7CMz46oFs9mR0evO0nQ9ogaBzJBUTOjNJJs/cYEa8lXlcKEznB69rGD3IpnwFzRmfq7CpVefCjCyr2SRHXdpeVrfID75OSjTY2Z67ZFHBqwWCKDBoevd54Ba5fBKfAKtk34dgq13Au6/0wSWVb2OtEbbIIzfzaruNyzSOTmgzmULPxrYquGuDOvZJp8hMA/eswvS1M3m2CXJt112Sj8YjHi01TpVSBvN/OZp1/STATo/lDqItGjeKjqCtEj1kwwjJtY0s1t1jlRBFOb3qlXOnPIucTWW6w89d4blhRA6Us3pR+uZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1l9qmJoDiqvIXf+fkiDiFP54F8XDYP7oD2aRaUktoYs=;
 b=fhqMjZ7OOTc0+zHy++5NXFb6sgV0clVJelu5BQ11Wxd8Fi83K0ha81W0faEh9daBba75kSbuevPvboVjl34Me+HgbHNdVPRZTPgc114ke+8J/mlv9osP6WXST8Aqjeo6VkMtQAUgzTsu5J8kHabVzu74mxiBAi++KMXV+7gS/dA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3820.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:49::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Wed, 17 Nov
 2021 09:35:48 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%5]) with mapi id 15.20.4713.020; Wed, 17 Nov 2021
 09:35:48 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v3 4/7] ssh signing: make git log verify key lifetime
Date:   Wed, 17 Nov 2021 10:35:26 +0100
Message-Id: <20211117093529.13953-5-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211117093529.13953-1-fs@gigacodes.de>
References: <xmqqsfwmus5g.fsf@gitster.g>
 <20211117093529.13953-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR0301CA0057.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::11) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS9PR0301CA0057.eurprd03.prod.outlook.com (2603:10a6:20b:469::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Wed, 17 Nov 2021 09:35:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e460e053-4f6b-4f4d-e19d-08d9a9ada35d
X-MS-TrafficTypeDiagnostic: PR3PR10MB3820:
X-Microsoft-Antispam-PRVS: <PR3PR10MB382034CA5FFF3F8F2D2E9305B69A9@PR3PR10MB3820.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uUG6sotvFeh1+kYGS3zCQ+PaXECutNOFv15UIPZx9JZCD8n1GGQz97CVEStb?=
 =?us-ascii?Q?fV4wHpnBtZArtdjtfVzHGIKvD0YUQXhudFqFY1CGRXtUaRljTR8B8cu70kRi?=
 =?us-ascii?Q?ifnx9m64OB8ZxqinsQQpZSlMNuqkHSbuQ4XU8QfZy47ETdFpJMJn7mfX1RyX?=
 =?us-ascii?Q?GfEKNZMCkTzAr9dBqSA1SaSR6i9ObtMDCvmgRIqMALJPZBfe58pslfIwKX5b?=
 =?us-ascii?Q?r/fg4k299Ilslzr6iEV523NgYsgtA9tL5F4BVQO0bq6xs6muQRXjbfMFYqaL?=
 =?us-ascii?Q?aW3KmbpXrLRBKalzZwfmEuD+MXLVTACHnjYQmvEFzE4SOauLYQSiAj1vzyEW?=
 =?us-ascii?Q?A8PcgZZj3lveSHT/ZuITJUbMWbsykD6bSFMoxlkyR3qKzTJnAE7ZnAZTfjf4?=
 =?us-ascii?Q?DHICe5f01pXv05l0makLA/SlXlxInJXur+aerhO4Kbdq9/uh1hsQkC9PaqDG?=
 =?us-ascii?Q?yGVsHXyB4jPthR4UWyvrms9TfzEW+ogI1V0X1LfeGk4PS33SkM3eCYBjO5Ls?=
 =?us-ascii?Q?cstwsLPTPN0/WwTwlRzpbqrWDBa0WdO8P/3mZ/GJJ2nxeT+4LyJq07JGA1Ev?=
 =?us-ascii?Q?qE3Jwo2Onqc4mJQOez6H7px6BQ/iM3zmC55hDWh2dPekOwfe5GGIttMcpFXY?=
 =?us-ascii?Q?cUmkrqAkAfn81k2zt3QqSe3KgiSEZ+RsPz1V60jJrZDD8l/Hl1gNUluZswj8?=
 =?us-ascii?Q?5LlafkQZoQ2QQImwTwIW89FJSx6+cNraKFX8VcUsD+OAkgafhN8ik1NteGGA?=
 =?us-ascii?Q?uQRJVXS+qipbnczIaz4lZAdn3WDoEa/HAkBtZ/zs1e6qaGVsEHHilvrm9JHC?=
 =?us-ascii?Q?Xe8mc0Ed5H25mAfgvjeAwrJy4zNejz+b5wgTnOXirkmVkInv7lHMGUmFZdjF?=
 =?us-ascii?Q?GjXobVNrj4d1Fz6OuVQ497WDxrqtLoWRkKgIxjnqs+JVDnB04F5hM38J9dmP?=
 =?us-ascii?Q?3mzBeUtFRjwFz+GTVkAONEBU+iNUlDY++u+NnOa2FqqADMDKnOQsZvqlVpfN?=
 =?us-ascii?Q?PvdTJ1tn1WWVUPcCszVdDz6aGw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(136003)(376002)(346002)(39840400004)(396003)(366004)(66556008)(316002)(8676002)(1076003)(66476007)(66946007)(38100700002)(8936002)(83380400001)(86362001)(5660300002)(36756003)(54906003)(15650500001)(186003)(2906002)(6486002)(2616005)(6666004)(107886003)(6496006)(6916009)(52116002)(4326008)(508600001)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VMEPZg2pZOL7k+3k3/D4Fbqm1qLU/PNGCmhpLJYEtJzghr5FTH1j7vvhi0Lq?=
 =?us-ascii?Q?KENW5WlJA40uo+9BADDErsgNnmedHKMvMjaxePBcCbChvTs4JW9FPdpd+WEm?=
 =?us-ascii?Q?nCaWBkf9okpABM3LhAiHRwcAqY4jRgQ3oEbLEIYYb9yM979LBe+I74AmLnUb?=
 =?us-ascii?Q?c7a1GUZq7Q+l992ZzJw26HFabW0Amh3MHk56pjxq9g9kscwhTSV1ZZD9+5kl?=
 =?us-ascii?Q?S7QpXbDCVvLyTh4OmSb0SA9Y9Ynxpu4hw8jUpsbmd4wtd0RdL2vzhXYpgSCD?=
 =?us-ascii?Q?zjJP8pTEGcLxrksl7C6fY7S4Ny0/75uVRCN80DmyrWfJUxnqGvSaoe52cIrf?=
 =?us-ascii?Q?1Ar8c5YvpBMQj/dY5SwNDIcMBGeprzRzHGZJPzrcmraKwcuvbshFrT8BgT7d?=
 =?us-ascii?Q?NyEsT0EDCWQxfP0t2CxPXqgmYKN7PTX8HZvfA3F73PFYqbOJBPqLwRGhGvzY?=
 =?us-ascii?Q?7RoPJhNB8on/RY/PT0DIExJWR3B34RxERQ/zMxx0xtqKuHltnPV8SjF4+h3z?=
 =?us-ascii?Q?jTH4KKRdvRoW1ZPVck9M6rwXCPZY/IlaNKuLkQgixfesCyaGn4qVNcg+Xwcd?=
 =?us-ascii?Q?P3kinPifrbWCJxC5PSewtVTd6L7bDTKToqON9iAkKeDpRuNMVpsDVLttonNN?=
 =?us-ascii?Q?0CMgCrtusST0MyR3ayAExYbjFZy6Jo93O3FgdQ4eHAX3IF4hzUQViOR5dvXz?=
 =?us-ascii?Q?zjOIwQTPhs9jI4erYmyiHDXsmwPCCZJ2j6ty1Ik054S8CGmLppLEV9WBL+iP?=
 =?us-ascii?Q?hmhk3PqZZLzkVL6n8Vo3B2px5UFotQ/RsUX1INGu8P35uHr+sd2b26sZCI+v?=
 =?us-ascii?Q?B6OKtYSxzqsqa3YX1V0pO1Sz5VebkVt4dRjvzwC6FBnNFPbrEvC6DSA82giI?=
 =?us-ascii?Q?LGVsNsaGR+pOVK1U6XrxRJo1ktbpfdrwDHSFqaQCeI5oSYUbMF4tKxGYXrrs?=
 =?us-ascii?Q?T4VaiOKKtwLutw0JeqOsr1AKcuKo1YXAvIlhRTxQheWhN0gGy/bDFnVPKpo4?=
 =?us-ascii?Q?aUd5ywIqVkfOkZVL7j0gKYM6vzNfJ3WXQjhsYo4xUl5jk/PujvyMkdUSVLv2?=
 =?us-ascii?Q?TSMH6GPyHmwSG+5jRgzAjKCo2xZiZe5wOd1e6ERXDq2izptT3C879NE74JRi?=
 =?us-ascii?Q?jnrbjEnoG9MHzQTGDbgWFOqZNQ40tIEy0sm+ZftViW4dWem44rYF/Dl3ndKe?=
 =?us-ascii?Q?5s5oF8wrQKfH1mp9IUb3pmvnK+PaexiIpexadAiRNShhw8zeCu3Nuf0ajDIh?=
 =?us-ascii?Q?TCB+mbzp8j+WmZNUReWdjEc9fsuAs3H2L+eohEvfFKNY0GcT8H6P8fTeaItN?=
 =?us-ascii?Q?fj3POYSLHsie8ssqLPNIQOvu4XxPSx1acbKO8PlLrfiSp2DUyR7Pv8rTTve/?=
 =?us-ascii?Q?IAsCfDWUlUyAJEtJVGDHYQT2YGPpq+b8X3oLIX7XQ5WkKOWNV3hNg/8gk1vA?=
 =?us-ascii?Q?v3GsBOFXUdet+07tIe/CiW3kYk0WzsJC+JpsimXQOdJvmlWZzhdwk0970vi2?=
 =?us-ascii?Q?nRmwYdmABQeoXaRx8QeDJN4Y5HsFdaKv8Lc78jBLxs234Pr3KIfcb+MeeyA5?=
 =?us-ascii?Q?WUU8q7wgiTraXGWxZdY87Qbs7m08H422N6YoWO9AKQ5c4bUqIYHCcPiXjRas?=
 =?us-ascii?Q?mtZRopDt4x2ZJKMpvho7BoWgSLA1zcHdZpeBZyQl0XjfpQDZo2nt79RR4kKg?=
 =?us-ascii?Q?yi4bhAdkh+RkapWvygZEBDSlBa76bd04ZsgVEQIxUNPphvN+aacR0J5UT3eD?=
 =?us-ascii?Q?NibZs6HzFtodkAQCLDaMcV2x1Xbzx2Q=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e460e053-4f6b-4f4d-e19d-08d9a9ada35d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 09:35:48.5717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wYMsMvq/wi3sozRkEcD7JOIYfkBlhIhgv/KFnvpzTW0hE2wqW+JZe8q1M0Yc9hALsWKjeF9f8C9EB3yYBF/XOYpU2V0UAL1T1ZNKgVQ/Xqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3820
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

