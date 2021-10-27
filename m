Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C779BC433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B00A2610EA
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239245AbhJ0IJM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 04:09:12 -0400
Received: from mail-vi1eur05hn2227.outbound.protection.outlook.com ([52.100.175.227]:54730
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240769AbhJ0IJE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 04:09:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2wV+gsLIkINt5fNrDi8o0aux5cuG18dJa3yy577zX1llQ72kiQnumH5sFwQrqIfaa7qAITTsVgx2JWsOze7qbXgj9O6saNtbPkdKcZGsMUznn3al0jTUgRjws1g6x5cVx29J01SRIe4mFb3ckEasoUqnEXXdJab9J8cNsfReW8FXFin1xPBDkLMitemTucD0OJwkV1jSqsp9uHQA6nwPW+Oz+h1S+hnMx3F+8PhLXLmv+MVUcKMZv4vYaMyadExvfHp60YW6/mI2CW6Y+KwYihAGn/s00LXMhiMvxK32k8wCgXL2lARyn/DS6QXpJlodq7ZUF0tTeihixvDNyT9Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IW3HmvIC+coz5Fp1EH38QJ0Hs52tSu4XrwUA3cBq5Tc=;
 b=WXq85LxNmt264Jxshps9qFPur8ysM+vHG7Zojejj6b+xRkb2/sBnmYN1Orn5NVToYskUyCR+/Bc84+O1cxFDufsru5QIaaUVplGAxvGMQ3VYIsaoISFCaOaBqENNsD3ptWTGdAwehIfsIcjUFufxUfVnvfst4lGK1DAiXyYwifYQD3bHTnF6RaVJxmHxnOSqemTW3GFvsPwuS8SlI5JslycLwTGxKA/3kaqJ+ji5TFYvU6pHarR9pmL4yUe/QqlNWTN6CFk79kRM4S5grVEG7kfbThMwpYV10pWJYI30CSN10KEmuHbUnBRSvebXMUCzXpRhL9g5XCMAtsipuxraqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IW3HmvIC+coz5Fp1EH38QJ0Hs52tSu4XrwUA3cBq5Tc=;
 b=ckCNmD/OXGJWUQR5hTaJ36A+aAq50knn7UDLUycGKigPZL4cby6dUgKw1prLt/q/WAaL/w1YOm3ddaR7DpjlZPehRXcSJgvmbaCaxV8Kyv8h1phJw9gpTc6OqEnxdY5lEdEF/iaeZv2czLOnxyvhm/ZdK3y44bIBR7MxgR3BvLs=
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
 08:06:24 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/6] ssh signing: make verify-tag consider key lifetime
Date:   Wed, 27 Oct 2021 10:06:15 +0200
Message-Id: <20211027080616.619956-6-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027080616.619956-1-fs@gigacodes.de>
References: <20211027080616.619956-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM7PR02CA0018.eurprd02.prod.outlook.com
 (2603:10a6:20b:100::28) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM7PR02CA0018.eurprd02.prod.outlook.com (2603:10a6:20b:100::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Wed, 27 Oct 2021 08:06:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c777d0f-ffdc-4a0e-401e-08d99920ab8c
X-MS-TrafficTypeDiagnostic: PR3PR10MB4270:
X-Microsoft-Antispam-PRVS: <PR3PR10MB4270560AEBAE114468BEE35AB6859@PR3PR10MB4270.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:54;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nm0ppgQmEDyaOFGBMHCn1ST/3ORZCsI+kxfB39wV+DVAlmoBwj3OkagWlsEw?=
 =?us-ascii?Q?b776MkeFSD9lxpitV3dvbpS28ZrepgO7M4l+qp7Bgx+D10LOYX7YxVtCA3cm?=
 =?us-ascii?Q?LY4s62u2pABn7IEIqonthh01pxuNgp8YQgXBQc4zlU7dPx7JeZGYEYprtYJE?=
 =?us-ascii?Q?DRACQK12ehBiIXp7TvnrFzRNZmVVbol/an6KeEgazpGymIG9DTEqz4s/wcEz?=
 =?us-ascii?Q?m9PiREY4e1sGlRFqMeLPYg8E9wFi0btakgFlzytM6AFx3txdgUCCc4Swiz7N?=
 =?us-ascii?Q?sebNkI4xxCkGGdEwWmz4iu6UgXfzXJSNAG+B9H3QmCAk5DDrsMP+ZlczOC1i?=
 =?us-ascii?Q?sNWndDH0v786D1O3PppQTL7WNhngW0CuUiZs8b4a6ZL4uZpBWHCHfepEDtfQ?=
 =?us-ascii?Q?NIdKMJL1yUjp0upRTDXwbv9YvkofSQN95RF/Y/r23k77bgYOKjkjt3WasusY?=
 =?us-ascii?Q?lZ9gVSyocU1orJvszGf35vd1WTOlH6UpSd6F2TYWvjZFeaeo9sGazYqCwh3P?=
 =?us-ascii?Q?U0vMu8UKWE+YhAB7UoD396uXwkosESIct34U3U1YOQGbyoTpT0VJ4NA01Xly?=
 =?us-ascii?Q?Zxppi6YTHVHhZKJzzeNoKY2bgOAoYcgQSnwnVvop0ctgfsfGF+PeOyc/xmC6?=
 =?us-ascii?Q?zgkRAEzNjtifGreRojXz3HDwX96VFkhhSlv1isdqjDuGGD3hEVpMJL70iRGD?=
 =?us-ascii?Q?l1U/YKSfU4lOif6CN1NRLPzur2cBv8XE/Nmiyay0+Y0HfiSxIVYAfXIcex1O?=
 =?us-ascii?Q?Sqr/uQ8UEYyjSruxlQXqvA2Ja8eN0HA/bqed/bwBWzlw8nEqgRRo8jwBqakr?=
 =?us-ascii?Q?Jx8PZW62l6v4f1gVNy2vO0TDhpClVo/OukTTKDDCxrFMEEspj3eyg/lKdJid?=
 =?us-ascii?Q?vx1SGuvlnzCmKoU8lqPKvDpOY4GH9EoLWAPHfJxsCGADEV7UZclysG5maOOI?=
 =?us-ascii?Q?9cyWzeOfuq7lnb8wvDUtX+tS4g2hQGsxrdj85RujUEn33YkyjjMU3h/iMV8N?=
 =?us-ascii?Q?tAagBvDK68DA2uybzxeria3U9w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(376002)(346002)(136003)(366004)(39840400004)(396003)(4326008)(52116002)(8676002)(1076003)(508600001)(8936002)(6496006)(54906003)(6486002)(316002)(6916009)(36756003)(66556008)(86362001)(2906002)(2616005)(5660300002)(66476007)(83380400001)(66946007)(6666004)(186003)(15650500001)(38100700002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QtZMaz0BGfDr7wSpi5/zNiRxaXtB1M9ZyDbYTSxx7Bl6wTGWCA/fFeVftJJm?=
 =?us-ascii?Q?L8JlRS0uwL4RfC4ufLmnt9ebg2HmdaFKY18cuyZZefiNEGYaEAHUUQpDbIVC?=
 =?us-ascii?Q?3sCx72C7KS1pDVEhiLSr4BGoFzy58hZpcSHwKmv+ZP5U+qZ2LZ1lQg7kKYTE?=
 =?us-ascii?Q?Ck+llwlWa77tu92RAcsJphq1x/z8LDki4sW7ab2rIryUae87AfXnLY9ePdav?=
 =?us-ascii?Q?bpyEmvzgsIS1IjVGDn2yNW/PM/LEgV3Pnllu4V4LeNDj1i6e0+87ro+bWGJU?=
 =?us-ascii?Q?Lte3r4q5ptTWfM7X8TWwzboGHFnTMUCKvP9/qIpIeHTbeMwq0RMjB65EXitc?=
 =?us-ascii?Q?kai0LP786reY4CmJUmiDWXQRTFxDHXz22AbiIHc9oNCo+LPnmWT/Qto/lu+e?=
 =?us-ascii?Q?++rcNXgF+twDH9gu31AZ6+C8GeXYDxqKrDGcIHCe53xlbpzoFKAC+uo38V+9?=
 =?us-ascii?Q?EXHm+Zlv+uFFZxdhJxS0lLfvE94XLK8cstBoexriLbQ1vLX2j9x3R/b3Xjsx?=
 =?us-ascii?Q?OjUeAORXPovkaK6GQJvj3z57DGg6D/FTFsATlBnacq3M4N6dDcQTR2hCABIR?=
 =?us-ascii?Q?MnRPsaSa6PYPxD00m7PoqNjQSSPr+Qt8KRswa+4AeP4Nfp8iwRCBrmTIs4Lr?=
 =?us-ascii?Q?UARk7geeY3b5edwhcszJpKF/+WAdI9J4T4RlWWtopOQkIj2dnJZW7wV9JpEZ?=
 =?us-ascii?Q?HaWuAiDAToX51MONSY21CrCdu8AgQKRlwsyuNZu+unizSgYHkUZ+GA6WoAX4?=
 =?us-ascii?Q?HZhk1GdSyi7OwwHrE4wYXPTGwnKi7qMIwzIahS6rz71Vlmu47qdRtpNUl0Si?=
 =?us-ascii?Q?MyCA8RGvs3aYu0yHx4kh/ptLwsqxmvx/48xXgLudxQTqj/ng/2JG1ggVt4ok?=
 =?us-ascii?Q?Cr7DuBW3JoMz2vmTeDiciFYydlVvd6L4ni0Nh8TH9sWMDmDGHUAimz1bG8YO?=
 =?us-ascii?Q?RPgDirIqebxImuezycb2jbQ2xMdM5nuElGhjFO+4vZeOGL1bd5LhmkTmxMOB?=
 =?us-ascii?Q?TiAlwl7HFq4iNfU90bSz6MiFFoQtL5OfdZdm63Wb5BPZf+4MonsqnciXq9Z9?=
 =?us-ascii?Q?Iw7vX9xVszYzHSglhezFRSnpAQREAJyWs0UXmaDJUSnQs7nMUB66nBVJb3BB?=
 =?us-ascii?Q?R5h/Yje7quj0tszAs3Rfdxafp0DdJfnX+k/sT/+gLspkV7/an9pCUon2oT2w?=
 =?us-ascii?Q?GJieIHtWB0I21YydB/Stvei4JQXqQnKj2ezEUO9AlV1ckrzMx20CzqehrkrU?=
 =?us-ascii?Q?pJhGeeXUHuAv6UzItEB4JabLa19/H2GuDxj/FSk1GWpWpXKToNSbrQLZgitQ?=
 =?us-ascii?Q?VxdKxDaCvEyv1/6PhBRy4YNpRyzZRodTJoF5FE5TIax56o/5zZRGym9USKy1?=
 =?us-ascii?Q?fVquEOwhtqfnDecWO9BtrSXow/SJwqMpJhF1TL9apQI5MRLetxnuBXxOeVtP?=
 =?us-ascii?Q?HtFuN2457seQoXl4jXEdhWfvRuMAyNtDf2qKfOlAKNLWsZ6fE6L78RLv5TGs?=
 =?us-ascii?Q?zIug8owz20U5IeDz5RkqvRh8qbPOgV7EE3P/VWLkaMBbN8YfdnubX9Nm8rWr?=
 =?us-ascii?Q?0kZbWffwPLibKDAc7vIgTZhVVLt7T8/s8DFWmLnpchp1fkoHx1jHcV5NodFC?=
 =?us-ascii?Q?eegRO01aRmiTRRrv4D79Z+uXR1D1Tlxwl/43V7yRMVQEChzN8oIHfMd8aTBg?=
 =?us-ascii?Q?Fwa/8QiTX0ptyXiZySR0sAATnWMiPwGhvXwksWwt8GGszC7jZDkwmmdp54JK?=
 =?us-ascii?Q?m5JEqB7tXQ=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c777d0f-ffdc-4a0e-401e-08d99920ab8c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 08:06:24.6660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qPiBxYGHBv7UF774PjZXiHyPpLG9ABKQJF4uTAEWH8bhJjNu4CtqJIijqrxaZ5v/1qMwaLAVd/UQ6pC+i6JEf6ps9rDQTBlVCSgyIbxWc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4270
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Set the payload_type for check_signature() when calling verify-tag.
Implements the same tests as for verify-commit.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 t/t7031-verify-tag-signed-ssh.sh | 42 ++++++++++++++++++++++++++++++++
 tag.c                            |  1 +
 2 files changed, 43 insertions(+)

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
index 62fb09f5a5..dfbcd7fcc2 100644
--- a/tag.c
+++ b/tag.c
@@ -25,6 +25,7 @@ static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 		return error("no signature found");
 	}
 
+	sigc.payload_type = SIGNATURE_PAYLOAD_TAG;
 	sigc.payload = strbuf_detach(&payload, &sigc.payload_len);
 	ret = check_signature(&sigc, signature.buf, signature.len);
 
-- 
2.31.1

