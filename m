Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4F6C433FE
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 13:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14E3B611C1
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 13:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239341AbhJONRa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 09:17:30 -0400
Received: from mail-ve1eur03hn2213.outbound.protection.outlook.com ([52.100.16.213]:36958
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239328AbhJONR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 09:17:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0I0xbaoMggzfFZN0lM0vS/FfiMNh/uUk0UlwQWi+X5/Qt9jUZVFh0yUOL2DmhP6fp9e2x+mBvnJwp2BVUrDb79kP2yhkPWTLRikN3E/B2uq4rDZR+IW4xt2cMcdjT/Y6QOf0ZqFxv9CJUrURJsBNpSDJFzlJ1VIpYuk8UpSzjr2y6gh+8Pf897snkWyBocCXfQCOX1epkYVAfTvHaxcI1Gmm/ZrKf8bNzcVnFmhhgPLvXkwulUcAA+VUgZ7l/rFHC0FJeHgu0v1vYpmuO1Ap9LMy2MU9aCSF7GnuM/Hjp8aSqHYGR3HyqC8Z3/ZbgdIOzW7IAi2zQM2GiWiXYGrWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yyyW8PwfYWCQQcJLU/aPOKbsYOMcmQywVzmyalJaSI=;
 b=VX78k7Y1rnHGFJ4MLS0J2CotndKuDUOvZv+qtxpxmVGunVNXpIiL48Idk3R1JWddO2ra6POCCy2GPbrxiDJOo6kiWbD1NSINdYfDJgCwR9h3sJNu9odyd87ePM8mm1Cau5vF4oa+QQvwuhyu2dOQ3trDH6gXBhxC0UMZnbiYlUR5CIlywbBQeQKER9Hp+DlGBIoL3/ODujc0iY8eqdRsc1ALRSp5Qm2Yy1JwYcNMPack1vdiwhSurTcp5HwawHEH9iLTtY3DKsPdcesuuVvwcPmQOyWGwIHq92U3xaSFbhW5MSDIwtb6mt1CEi1O9K3424B6YLiWSusWWWq54bkalQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yyyW8PwfYWCQQcJLU/aPOKbsYOMcmQywVzmyalJaSI=;
 b=XNPiAae3YVBhvCc5VoRS0T1XK5oDElW0dz/1FRTaFmxb5PxnViuiiXfBwF1SRnZ1eHUIirH31bIOJAr1LPu1Qkn0o/MZ/po7gZoJ6oPRB1Mrujx1F9Y05PuUU5qLpdeRxRnt01h3OXnWLccr8FvNPGhYPMlpWtEEEVvyMSkuuGs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4046.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 13:15:13 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4587.026; Fri, 15 Oct 2021
 13:15:13 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>
Subject: [RFC PATCH 5/6] ssh signing: verify-tag/check_signature with tag date
Date:   Fri, 15 Oct 2021 15:15:06 +0200
Message-Id: <20211015131507.1773153-6-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211015131507.1773153-1-fs@gigacodes.de>
References: <20211015131507.1773153-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0351.eurprd06.prod.outlook.com
 (2603:10a6:20b:466::17) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS9PR06CA0351.eurprd06.prod.outlook.com (2603:10a6:20b:466::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 13:15:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caa93a68-dca3-4235-a438-08d98fddd289
X-MS-TrafficTypeDiagnostic: PR3PR10MB4046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PR3PR10MB4046E210F0549C1831C0697DB6B99@PR3PR10MB4046.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:82;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AvOlfm6J3npPqZXnzABzwODC5yzp5An5jkIki7+AXbSgNjWKPdOdxaeklCow?=
 =?us-ascii?Q?OBTH6w9k44jfNpNi7jbJpIuZFyE9z4seyWwFRSBmqsFWgCALGMi6w5bNVkUX?=
 =?us-ascii?Q?piHNg0eclQcCVznXMkbe/xGS5DSinhrmRbffwOaBeOuxMXJ39MYTK/uQnfIE?=
 =?us-ascii?Q?ItUcZEiZJ4YE11aQi24y8Y+JSOyOeOTNQCdgnlo4L9NQeHuNaFCZtra4JwQu?=
 =?us-ascii?Q?zmEZ7As+bDtX/WWXIuYnckm/7uMLFg9XkUUHjWvbTyrmxELN1o58NtF8RjCA?=
 =?us-ascii?Q?nWqiLNyNc9j7nT1YGtAdansfLMlacP/SEywHTqgfcm15JwEsCKWywmeaGK0t?=
 =?us-ascii?Q?biK8n+eEyfl0XcKRPLn0bny/8r3MamCWT5+9vMhmZGIfdMW7CvNgPZgLx/dH?=
 =?us-ascii?Q?zpJb0KqnWMYBEfrwHHLqleISjKB1Z2vU/PlYTsiNOp4p3CaTCZDjmed4JRNf?=
 =?us-ascii?Q?g82cWvtitaUSgRPJW/naHZMAAzLE4QQQuK8pluntxlLHQBNcxpGMF2WeyRJi?=
 =?us-ascii?Q?AsdMwGdVskEaWg4z8GQjGYrHPcSpU54MPI1uKEcPFCPUW8FEg7rPXPTqGFkC?=
 =?us-ascii?Q?6icB4f2FPwCeQTQxUkl+cWKKe5+MgQ0j85yWPUv9EwM1rE6vTqmK0PGMSuty?=
 =?us-ascii?Q?CPf7GZ09dofo/S1tJfIZ8a3Z4vDyfogl6XWewqS8T3A/E0ZxXg/JNmRnXISb?=
 =?us-ascii?Q?jLUsL1hQOG4xxMvAAubpCrNysxxTKaucWULMfRSMZf2C0tD7BheZ0cVHCcCY?=
 =?us-ascii?Q?6UyE/7mbRwnBHGact1CPMkDO6kdUEiepwP3+O+GOLedywuiEcxaBIJLzJNVk?=
 =?us-ascii?Q?KefAOtLeIsmkMTFwqS68VZm7u45yP1HB59mL1FRCPsyyUxrnCob0h4etREbo?=
 =?us-ascii?Q?7bxi34ap0cLaVHGf+DnjerzY3SVndluwmuJPxl+1kA1m60S/lTscMF22b2L0?=
 =?us-ascii?Q?nvb3UolP9bWI6H8DRy3SWvCbe7r5NSrkydW9hCID1l9oZ2nrF+Lw2Qh6NbrQ?=
 =?us-ascii?Q?EVxdV+9zVgLUfJaemTqoLF6slA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(366004)(136003)(376002)(39840400004)(396003)(346002)(107886003)(36756003)(2906002)(1076003)(83380400001)(6916009)(316002)(4326008)(38100700002)(6496006)(8676002)(2616005)(5660300002)(66556008)(66476007)(66946007)(15650500001)(86362001)(8936002)(186003)(52116002)(6666004)(508600001)(6486002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2DKHSeedZYABVR1qSQJVKA0+2iz/R/GP88vAom+uCXqFIRwvLwhBKvCSXuPW?=
 =?us-ascii?Q?s2aqhMTSPB0tj6L+EFIC7cWwfKACEJjvyq3E+gHeRhq+xMDjA+ZwIFezLuZC?=
 =?us-ascii?Q?6x9uMzVy3Yj/+5k2AG4JR+n1RcfjHxiompKpIVaynKHNaD2vf/Zm6FApWTnz?=
 =?us-ascii?Q?W670JWfc3gY0lyDcdjUieZJlNvGkx+LWnM61DrUK0mqog7a2RTk7UBwudTOM?=
 =?us-ascii?Q?lBYmNJjZd5JmKqklJjH86mgXa5CRMWnLoN2gKHhCypACVQc7XLxI7PnQ4xTj?=
 =?us-ascii?Q?lIf+2dbYwCLpDP0J0niC1xJZlsqqSBX1W2Ts2GK5+gPuX/T/j86tl0e5572h?=
 =?us-ascii?Q?FkZGnoUDJ7NsjhmSQoenvxPwlH4pgbf7VTe9Ak44m/5JUwqlxhk/t8RL1Njm?=
 =?us-ascii?Q?E3LI5Yypwl3rRnpwkGlqyb3603WcxQFpOZ+skm/wAr0fS30ESQ+TcLQO7Xln?=
 =?us-ascii?Q?xYNXAz+5YMeGYB1Kf78+ZCUGor6/H4K7L8KyrddzN8OOGCaXHJwKisQuSjog?=
 =?us-ascii?Q?fh5Zt5Z5/8VRwd3UnyFuEFkJ+O13M54XwdfWk1BMGm3HOorThKlHO2m/eZW6?=
 =?us-ascii?Q?SrExpf/MVZm4ciOTExukzkLMmtoIcMCHfrOIYmgpEIfzR7bOQvHnLoRdo0cp?=
 =?us-ascii?Q?QWOFdOVc6m2z04ZUpx9CfnSUEzfTAIfCCW2Ek/NzWMBZAi3xxTyZsuh3B5LJ?=
 =?us-ascii?Q?H0nmWA7tA+6y9RjwuxG/QWbg62S8lns3jo+TJnkyHVn11ILvPNz7BTRcHsh8?=
 =?us-ascii?Q?PHe+XF7dEfZ4QfggfCIY9/mEaFJ1mDqjBuMm5wetT07wD5EbH8xCUaDN2Udt?=
 =?us-ascii?Q?hp2vv2SSh2GZ9X7QMHViqO1WcNoOCRhkwl8MdCbJNzBSoHu5jVc1o/X5vInL?=
 =?us-ascii?Q?GgVCaYZdGOVpBaEVpXPTGA2kLyP4ePFuHLfuAyzKFJJmRJ0LFvEdyomqFVEJ?=
 =?us-ascii?Q?AbSYr9NgMnqbqnvRBOr8L/duvFlTvKKyWi0rpFwrMZ/GBPRs6HJ9dVzISDeR?=
 =?us-ascii?Q?FbsFAZRJN+1+snQXR1mb2+XMqLnDyt/ufilsdzvhBX6ednVJbQ8sqE/y14fu?=
 =?us-ascii?Q?fYHCD2RB8dddQzWZtaF+4ZXyXOeaG+6D2TEJ4GLCJ+ukIHoOz+V5xv9BQG1P?=
 =?us-ascii?Q?oviTT+ehv0eYnBkOR7coF4/UnanqLjKnlZsd4N0DNAOrEEy+3kHdIHlWECN8?=
 =?us-ascii?Q?U54pOAxZy7IAcTBYVYRy8wNKBsn/CWFKpacaIkcc6DFzGzKbNnHif4bcExzB?=
 =?us-ascii?Q?0vuYe4Juo8Z9oQ35IYIawXSfw/ie7qbU+OcjvPhIVuEtvhQAmX8/OrkQB/dk?=
 =?us-ascii?Q?V7uihw7v0A9ZzitDE3/Dm3gAoKmaT5IwaftU1qLw8XjZLu3pi7BwWp425yNQ?=
 =?us-ascii?Q?fC2Jwp0KmGpcu4kqkEoUuiVjfCim?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: caa93a68-dca3-4235-a438-08d98fddd289
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 13:15:13.4019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ClCQyrzfCaLbUNjZXTOIiNmb3EBSXBx/9w863TJ1E7dVsUnRVKAUUtLOH1Kh8M4yqYeh7pI2hPkEfiF/G5Ttc50oza2xtTvjaIizWE+e2eI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4046
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Passes tag date and tagger ident to to check_signature.
Implements the same tests as for verify-commit.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 t/t7031-verify-tag-signed-ssh.sh | 42 ++++++++++++++++++++++++++++++++
 tag.c                            | 12 +++++++--
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/t/t7031-verify-tag-signed-ssh.sh b/t/t7031-verify-tag-signed-ssh.sh
index 06c9dd6c93..1cb36b9ab8 100755
--- a/t/t7031-verify-tag-signed-ssh.sh
+++ b/t/t7031-verify-tag-signed-ssh.sh
@@ -48,6 +48,23 @@ test_expect_success GPGSSH 'create signed tags ssh' '
 	git tag -u"${GPGSSH_KEY_UNTRUSTED}" -m eighth eighth-signed-alt
 '
 
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'create signed tags with keys having defined lifetimes' '
+	test_when_finished "test_unconfig commit.gpgsign" &&
+	test_config gpg.format ssh &&
+
+	echo expired >file && test_tick && git commit -a -m expired -S"${GPGSSH_KEY_EXPIRED}" &&
+	git tag -s -u "${GPGSSH_KEY_EXPIRED}" -m expired-signed expired-signed &&
+
+	echo notyetvalid >file && test_tick && git commit -a -m notyetvalid -S"${GPGSSH_KEY_NOTYETVALID}" &&
+	git tag -s -u "${GPGSSH_KEY_NOTYETVALID}" -m notyetvalid-signed notyetvalid-signed &&
+
+	echo timeboxedvalid >file && test_tick && git commit -a -m timeboxedvalid -S"${GPGSSH_KEY_TIMEBOXEDVALID}" &&
+	git tag -s -u "${GPGSSH_KEY_TIMEBOXEDVALID}" -m timeboxedvalid-signed timeboxedvalid-signed &&
+
+	echo timeboxedinvalid >file && test_tick && git commit -a -m timeboxedinvalid -S"${GPGSSH_KEY_TIMEBOXEDINVALID}" &&
+	git tag -s -u "${GPGSSH_KEY_TIMEBOXEDINVALID}" -m timeboxedinvalid-signed timeboxedinvalid-signed
+'
+
 test_expect_success GPGSSH 'verify and show ssh signatures' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	(
@@ -80,6 +97,31 @@ test_expect_success GPGSSH 'verify and show ssh signatures' '
 	)
 '
 
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-tag exits failure on expired signature key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	test_must_fail git verify-tag expired-signed 2>actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-tag exits failure on not yet valid signature key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	test_must_fail git verify-tag notyetvalid-signed 2>actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-tag succeeds with tag date and key validity matching' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git verify-tag timeboxedvalid-signed 2>actual &&
+	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+	! grep "${GPGSSH_BAD_SIGNATURE}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-tag failes with tag date outside of key validity' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	test_must_fail git verify-tag timeboxedinvalid-signed 2>actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
 test_expect_success GPGSSH 'detect fudged ssh signature' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	git cat-file tag seventh-signed >raw &&
diff --git a/tag.c b/tag.c
index 3459a0867c..1868e6b51d 100644
--- a/tag.c
+++ b/tag.c
@@ -16,6 +16,8 @@ static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 	struct strbuf payload = STRBUF_INIT;
 	struct strbuf signature = STRBUF_INIT;
 	int ret;
+	struct strbuf payload_signer = STRBUF_INIT;
+	timestamp_t payload_timestamp = 0;
 
 	memset(&sigc, 0, sizeof(sigc));
 
@@ -25,8 +27,13 @@ static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 		return error("no signature found");
 	}
 
-	ret = check_signature(payload.buf, payload.len, 0, NULL, signature.buf,
-				signature.len, &sigc);
+	if (parse_signed_buffer_metadata(payload.buf, "tagger", &payload_timestamp,
+					 &payload_signer))
+		return error(_("failed to parse timestamp and signer info from payload"));
+
+	ret = check_signature(payload.buf, payload.len, payload_timestamp,
+			      &payload_signer, signature.buf, signature.len,
+			      &sigc);
 
 	if (!(flags & GPG_VERIFY_OMIT_STATUS))
 		print_signature_buffer(&sigc, flags);
@@ -34,6 +41,7 @@ static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 	signature_check_clear(&sigc);
 	strbuf_release(&payload);
 	strbuf_release(&signature);
+	strbuf_release(&payload_signer);
 	return ret;
 }
 
-- 
2.31.1

