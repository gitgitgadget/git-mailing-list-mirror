Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F11C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5CCD619E5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbhKQJjH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 04:39:07 -0500
Received: from mail-db5eur01hn2234.outbound.protection.outlook.com ([52.100.6.234]:20915
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231797AbhKQJi6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 04:38:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBCcPSGHMbh/SZjS/j9MMU2bNSV4spAYVKBQkbK1rJkcdFu01ehDZ55j64YVoQyAlIPmHL3v8dIpZRqu4k67JByneeRyZXUBw/ST+StSFr+SlZryNd03jr1IpUTttXXc9UV0QqPhI5h6pD2dbkUxlLeG0cxJZbZW4+K1y/JlGrOCUti/kTV7XggCGTfZ3lnAjSPoVvFAKy/SVj3rCQN+P1NgowI4iURcpL0VW7dMUXmfVI/n5b6ot3h/WLn/LLGZrEtAMPlPMYJ0H6WY2NHyuye+wC4B/rc8GIUWXRS4xxGJcUHASwN6OMmB0JN1xQBsm0NqQzJjQEyTc1nRDPJfmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IW3HmvIC+coz5Fp1EH38QJ0Hs52tSu4XrwUA3cBq5Tc=;
 b=MOWP4I7d5PHVGpfcEMzR1wVWBjQSD8N7MZzTT3VlhD1wAHvwZZjFoBeOihOZ67cRITirnUuqn7/x8uHtEqwkdKhzpFnJsPap/jaUOm3wI8joXqpNOzTMcgn+/rhJktASDOcnu97SRBIaEvoujdbVj00CWfM3XvwXmoA0cjcwRQzXbHupk72ZOfmJHzrj63mtPeLD47XGOyVzT/U6OFjQW7FF9pzn/EYoTfhlI8Ss09MphGwBRlFJVSAeMjNIDQeeWSQ31mcmzVjzG5/VXqBYFkbR9jLZx6NkQL5f0/82S4CnmjEx0kCTafCP5ytxsWj+lv9HMdzsgdcpz3CVx3/FVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IW3HmvIC+coz5Fp1EH38QJ0Hs52tSu4XrwUA3cBq5Tc=;
 b=AsWPfvMOY1G3A4/7WmfoYhXSvhCWwHeDHz9IpabX9+izaBRyQu+iE5fmsNEVVdf/3wcZtZXmu2RHagnHAFlUFTT4Vm0L4IHK4GYCCP4m8EEI53yqOUUzgjraY7gc1dG8YKFmN1odEjNsXx0/BsA3R6inl++KyPX1LHT+8RE4gqo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3820.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:49::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Wed, 17 Nov
 2021 09:35:51 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%5]) with mapi id 15.20.4713.020; Wed, 17 Nov 2021
 09:35:49 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v3 5/7] ssh signing: make verify-tag consider key lifetime
Date:   Wed, 17 Nov 2021 10:35:27 +0100
Message-Id: <20211117093529.13953-6-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211117093529.13953-1-fs@gigacodes.de>
References: <xmqqsfwmus5g.fsf@gitster.g>
 <20211117093529.13953-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR0301CA0055.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::25) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS9PR0301CA0055.eurprd03.prod.outlook.com (2603:10a6:20b:469::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Wed, 17 Nov 2021 09:35:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb26ceeb-8061-435d-70b9-08d9a9ada3c9
X-MS-TrafficTypeDiagnostic: PR3PR10MB3820:
X-Microsoft-Antispam-PRVS: <PR3PR10MB38209255A8673C1A8AC51D4BB69A9@PR3PR10MB3820.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:54;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KpDBG8aFNSO5bg40r52PqBR5y0JYCgIA2ggVhMhn9zeg2nBtbEIVfJu4SmbY?=
 =?us-ascii?Q?HbqV+TPJABXx6jdonL0hjcPrGP1Hl1YkhD1Kwu2N3T3fyCHZDO4NDJQC7g9J?=
 =?us-ascii?Q?nDnrlyFglTijVGNi+VGXy1umjfIQ72/UfBxebssGuCGuOsw8EU8FfECxA7zz?=
 =?us-ascii?Q?e8SV/+hNGQAHw/WVr9XTg9/7gt8z+dqtGCWndl/+AK8+fsCqAvXBcOTyuoBW?=
 =?us-ascii?Q?a5JdMwMYIBGmk/B5xdq5udolJtJ4XAP/4nvgci8u8POALlmzmi83rNSExtj3?=
 =?us-ascii?Q?3RE3TOAfxjyTOS/uKGIt1TeIsjaEOpqtte2IQdDagzK7wazkdYyhJRP72BZn?=
 =?us-ascii?Q?rsGTW6K9BdcVKHth4SDsHYHV6EqqGxhGsSfRPumoS6aRmRiLTEyWn5KKAX8A?=
 =?us-ascii?Q?sf+5G8VgVchOC2b92LrSe7CXsqSvn9wJF0cFsaNZMCBqjEAjqM+Ii6CYUtjP?=
 =?us-ascii?Q?g1gKxS+2+9NO8xRP7eQAEN7IZqPFB9QiLCd2XSs6WCiTgZoKp3LfwA3jY1gB?=
 =?us-ascii?Q?NdvOZhZiCMgvoxcOipsnziktNBDYUoZkptQKah74ILObJxzlF0efI0zEy46D?=
 =?us-ascii?Q?0ANXl3QOWVDOOjZh1ecRAbd6zGNBbqHBNxK293Qh0y2KjPVlxz6FRjq3SQnj?=
 =?us-ascii?Q?WU8CMHsSIT8HCvG8QOcMhtc83HO5ngJTn3wTmWuCLloMY59DqU0UTaIr6aUL?=
 =?us-ascii?Q?yu7UX0zdvzNkGGGgY/UT3H3SNBsQavw8ikfzRfJFj4mxN0Z+HQV+eu4sTNTk?=
 =?us-ascii?Q?8ej6bkWhFvOGSaZcmhOWewymJz9K2r+2zOdvPvxwqEkcJHl9HBSkD70tNqUd?=
 =?us-ascii?Q?opJhn6nNcQQwpNFbsOwdMzfvnFjFwbojPJDt0TDlZNJATLr9JUt99zUc6IMb?=
 =?us-ascii?Q?DodZ/01VIB5tsF53cXLpLyyJvDkZBz+iZ15DvyK3zLyIwp/jAhh+hXNrWBUU?=
 =?us-ascii?Q?UjitvGPD199AH5yHPfyNmBMOEJYnMSzz3HlTEzPYMHuw1yFSwnbPAMAhz8eU?=
 =?us-ascii?Q?DXppNK0sVkKlPKEYMIA6U/GnoQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(136003)(376002)(346002)(39840400004)(396003)(366004)(66556008)(316002)(8676002)(1076003)(66476007)(66946007)(38100700002)(8936002)(83380400001)(86362001)(5660300002)(36756003)(54906003)(15650500001)(186003)(2906002)(6486002)(2616005)(6666004)(107886003)(6496006)(6916009)(52116002)(4326008)(508600001)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?joEloojX2WkYxVdZ7cCQf6yr7GPw+k9khR41ctlrwDfxZNWvalr5Ldy2Mb+K?=
 =?us-ascii?Q?FwrdqAORQbRCHqbLISEoUqbUJgYgOuebgSrt528pGxtHHVI574dS+KYzLVdQ?=
 =?us-ascii?Q?AEyUNSk3NSm4fdRdJGcPlwaAj77T23mIAfxPbb+sv9aILctNiec0eQl4JCW4?=
 =?us-ascii?Q?/ce88I1G68d7XHdT4OpqLRmcwMksCNJANhWhmT9rOt5k/taitZNegQ4/SvrO?=
 =?us-ascii?Q?uHEZuedy+44+3UlkujUV001AljuDcTMfkl0+fphBhwzbt9d8nJCKRVKfq55+?=
 =?us-ascii?Q?zqXD0TzpC7r1MDofC356e3o8rRBLD94w/578tzW6JqwQfiDiuTp1YXDjuaTc?=
 =?us-ascii?Q?VEKv6g5cpsdqskUcs+VKREbYO8mYW2rv2r2M9v8bmqFe4NZ2wkYpqh2tFgog?=
 =?us-ascii?Q?4L+ZXmiDiEvSLecyz8ezuQIi4MFKeW2AAOkYBIlz0UtmNURMwJsYBFwnwXGm?=
 =?us-ascii?Q?Mzmyb1jBs2lauRGC4dm0X0Fh2IDJ8LIHtrEhb6Qw+IFUqddT1F9ue9sYEgTE?=
 =?us-ascii?Q?1cG46xgrerFrT9cp/GWZzdz5buJeuh5fMlGAT5AxncdTyYQlns2UtdaSX5gh?=
 =?us-ascii?Q?xSmSl/XXS1ovXSDXwT1BAEX04gCJgFoKXhnXXqokFIEKDSdS2Sh/3U4dswat?=
 =?us-ascii?Q?+W1Enhbf5NrXd9PlpIKXnuIJvYUaGFgmvLIk4kE5bDk3sByP691P2EEc/h7k?=
 =?us-ascii?Q?ij3QdQVgyOP/iCEk2W1oTNJXM4IVux4QETkaO5cAfCNJ+fYCg6SEL2FU5WPF?=
 =?us-ascii?Q?9cwp9PBCT6yCyTN4z85YLo8OFGS6nvckuLa6HoNuWahzELKaAljNgsXK0SOa?=
 =?us-ascii?Q?2ja5pcu8SYq6i8ETT5PEDGBOdAJaSrmndArfu7gfMbD47qMgVqQqqOJz84Ep?=
 =?us-ascii?Q?JkoeLQa5YIEn2CN42b3VyzgNEpfwokLrEQap4Kt9EfIhz4PI80DWn6B+lN1u?=
 =?us-ascii?Q?x79AePzqOn90wD4wuSEhE8lFej39M3UO152espnF6croHmLnfR+6Jtl1YYsO?=
 =?us-ascii?Q?V0aRdt72Lv+wi/xgUeCSR2Qc57HenZ8TP2qcYiubJTwebWk3nNBSYJyU/RKg?=
 =?us-ascii?Q?rcl1siHQUyUXC6/We3jyp8IwBGwl7vqtalV28T2F0dR58z78tXnNs0lPgKhI?=
 =?us-ascii?Q?5Wi12cxUK5O7HNhpGms7uVcK9E21Tqy0bgX7Rl5KsB1zqm1vguOFr3Wd9FU8?=
 =?us-ascii?Q?XZWzmpWhG/54ufj0U0qZnxof0dMrfHzhFMiM1IoVDY4k08+f99cBTwPDxqHq?=
 =?us-ascii?Q?eW8LlAruKL62/BBHiq1N+33ymerJHrbHL+AY1zRS/ItsSa4bNFg6b/lputf1?=
 =?us-ascii?Q?ieOIulVDF8WZ5kqp/ZHF2s+4a+iAc2MiDohDTnG4HNcTVgk+uGhMvKUp3AVk?=
 =?us-ascii?Q?tQnTQdU+5Qw80wl1gSW9ZsWEm/HPO3D7hnIwPCjtNcqpqjG/dD3xjdci1Zc4?=
 =?us-ascii?Q?xm21ifCqctcSlwcmmRInTRr6R9+WjThHwpbk5onTYW2WqD2APzkNOZq/GxDH?=
 =?us-ascii?Q?KuyV4MQ+Yz8pFtc43pEnsxNuZIBv0IeTPam5BT4dilO1MuPzMiSvQChVLCCn?=
 =?us-ascii?Q?qViV2tjkqUTB9UdM+N/COywbxRGXDPitefK6JCUrBBk6gR6ecCrcAFggHRjf?=
 =?us-ascii?Q?XnoW3oUpmYQ3No0n2wPlimA8yPqDEZ5kSilAs9Weadfxx13wfWojYGDW07UI?=
 =?us-ascii?Q?C2xj21liahV1D7gFLt5AYkryPyPUchU7OQ7V23I5Z/R2v+OqNM0JzbZ6yzTL?=
 =?us-ascii?Q?1BGYRQ6PBOn7XbcIKGADepSxHrh02yk=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: eb26ceeb-8061-435d-70b9-08d9a9ada3c9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 09:35:49.3941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5FEGsvzDOTkLW/Vu/Yqq2mdnzaW9naoeieY0mvH9uAdg5tELUEzVtqBn4cbejW8ax6lRnUhgyCgL6XC0PLaWx1/xEYZvtQ6QOljVhPayiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3820
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

