Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02D8C433FE
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 08:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbhLII4q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 03:56:46 -0500
Received: from mail-am6eur05on2061.outbound.protection.outlook.com ([40.107.22.61]:64384
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235293AbhLII4k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 03:56:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Og1oaoG1ODImbAcivW0/Uiji9hmZbpsdaX3SfisDfgKSq9sYVPD+taKN7SH2zEGYKdzvlHTGDAqcH9YtQ38v1knyssxnC6GG2JMraQGO/r5MiT24ne7sO+nCokxV1Uws6pvs2XbmqzxLHRjzWjiIvbSSfDu4rUriTzFH9rruRlWKl8n53KG4ti3LYHdT6p+AHlCLmPhFouYcbIaqNyZD2fO6rU1GF4TaMws5ave+tOCl/NFwEOGcUGz2BWjNVj46K3m39ACcm/l7xX7lSpZMpueI7H+ZaypfF662EvRZr0SBdSXMbOb3zjN1YCYuRKnUx24ZWgjqhwhlcFLljDOrJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYPX/41RHSRer8SjutnJT+YSrKXkTUZjhFw9YjE/748=;
 b=LU0ATvHt5p9ZolDYmWnb6jwcu2bUbGUDMGf1Loe877kutDfJtsMwpnjcTxHweLzwEOqplQ0Jkoy/ykYmBR5//KBIbzJw8AM0M3ww6tDQ6WgtdYdQjy7gpvbxA6lffek9wHq6EGZ1f0FAWyZ/i7p425lRLl238lI4DeMdPiNKiCKVbOnH3d2FBdxsdE/c+D2frJCvuKETrnPltmDC2Abv8I8A0B3nvDJkh51EXk0GJd2ixv8WwKf1odNauoVjb0mK9E7WoBJ8joF9Jpqb6/1XnEwdD5I1lSL8rJC7sMlxROpHVoFHqlolcy01vtT5E+iAja3pOIDG2lJuk2nZc/KNJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYPX/41RHSRer8SjutnJT+YSrKXkTUZjhFw9YjE/748=;
 b=XXsO0YipnujfD8huFNw47lcpBqyVd2p4jS9V1Ef1UBGtUjRbzEIyv0BL3jtL2RNDTUIWXwxwlssDwwJh16tDYxhLxT4X2Y9L4c9jXaCJgCHCN0UmMB+qB8UDY87jwCTmXGwwTemTy204l6L/2NArkEK8MriuoIbF2C5x3n2mUnA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3851.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22; Thu, 9 Dec
 2021 08:53:00 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Thu, 9 Dec 2021
 08:53:00 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v6 8/9] ssh signing: make fmt-merge-msg consider key lifetime
Date:   Thu,  9 Dec 2021 09:52:48 +0100
Message-Id: <20211209085249.13587-9-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211209085249.13587-1-fs@gigacodes.de>
References: <20211208163335.1231795-1-fs@gigacodes.de>
 <20211209085249.13587-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR05CA0034.eurprd05.prod.outlook.com
 (2603:10a6:20b:489::7) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:3e55:2984:f78e:8b18) by AS9PR05CA0034.eurprd05.prod.outlook.com (2603:10a6:20b:489::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Thu, 9 Dec 2021 08:53:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13e0133e-cccb-4080-90fc-08d9baf14d8e
X-MS-TrafficTypeDiagnostic: PR3PR10MB3851:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB3851B01E25486FB335A62619B6709@PR3PR10MB3851.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:67;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QCto17OS2VVmJAxGcHdYSYVQx/LZkq+qv3goya8tsX/4HouAUPmkodyPrYVFXhFbnU2u57xNLTWjj3RNfVOaZm9yfa22ITuuqtGnCvY56KcSxPZKpaa55PIApPEN/145pVNUboDaVr3BpG8aP/7b8VCSGu12yGWGZlPWgk5I2qNL0dA3k55cizUYD0N9+6WluGZJnRUIR3aDoysza8nUBU1BD8X6rOnl1R+RLPMYqIpgKjWMtoN2Gu6UEzeytX++op7jM2LYjpTcTfiqAUVAW5KtuT6uh7wyrb1Ztk9S+uKY4nm/E7k1pautZ+YIsijrhq0ZPMx+Mvt+Ktcusq7AhyO55Pi+YsjXf80T+V5/H1Kc1G0yYG2RommPHtgHmXfpx6YcGBLGF/QNOxpWmwF0tmJOfgBsAVx35zv1o/JdifewpVdgHsB+rdQjRIGCLhto0xO14QdDAupGAgqg/cW7PexF04MPrkwVLxd6I9UM02U1Kdzt4/tJwPrSciV+rDuL7r6Uv/Q65t4UwEssV2ZIQIDVl6UR+MIIA9RLTD+rL9TTpQMInY/TBC8nl2kfHoODMUv7MwZpp3ZadI61bN9Tu7BB/jN+6IevAXLRspIG4iGSxUMbkDzffzCMlMNpEUGddp719Nt4u7pLNBKWzMIXig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(396003)(366004)(346002)(376002)(136003)(8676002)(4326008)(36756003)(186003)(316002)(6486002)(6916009)(2906002)(86362001)(1076003)(6666004)(2616005)(66946007)(6496006)(38100700002)(83380400001)(66556008)(8936002)(508600001)(107886003)(54906003)(5660300002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hfChPXvNu7c635jk7R0NNALEOId20t/S1cb+ZcIu9QzpFtCz9ZzLKkdu9TAZ?=
 =?us-ascii?Q?4x51qgxPB7k3say2w2zzHUUNkfO9ushZ8MBlKgemH6gFq7a/5S4bQicNdk9q?=
 =?us-ascii?Q?IG2u3hnsuwKD5r7g2vHljFgFXSN+MJqE84Y8SUzd1/vXMj3ma1MI4AC4AFi7?=
 =?us-ascii?Q?D2ZQy+a8f0z/mYxHdM23w0YEHqEUMK+JoXgIRex+IubHBtWZ/Dt7R5fo0qU6?=
 =?us-ascii?Q?h7dquGToE7wZLl4B+AtgURLe6qW5UjvFBjmQ0talcXDEsBj0nCM01qiZpxIv?=
 =?us-ascii?Q?v8BUUiy9PI0/85panrB4KgZEPfWyqb8BBHOTCEG6T0mV+3+pWJArAq1BZXKg?=
 =?us-ascii?Q?hafIAmu6iW1JV1EAkQ9dV/FNgUKr4ddG0Bvr9Y8f+h+esjBPii2zKM37qgrQ?=
 =?us-ascii?Q?J42zq8bSZGGWEGjOgu/jQ15S4FhUctkD1Jjo57wcoRi2gNz0YIpUTAR4ItHp?=
 =?us-ascii?Q?piM0DXB4vDNInxVY2HMX2toEaFLhhqKxPPay4WPRAHdkpWJJ6guyBkA4OZlD?=
 =?us-ascii?Q?89hLCNrAnNcWlL+Hqm8q2ekwt0CTxTU6T8j353O06m+hag2uw4oHfKIaZfuP?=
 =?us-ascii?Q?0pzOwNmjekEwrPdwPc9Ljhq/txfKjE/fP68gzho/16YbMycpVxzseT1U0PQv?=
 =?us-ascii?Q?VDyde7ZPRirS/uo5BM/XerSw2ApAv/Wcz+hl/w9W0ax6Xy1sOl+JSeYV44hQ?=
 =?us-ascii?Q?lndSBoe/0zD6CEMueFgaW+ZLe+559Xmynf5qpmC8OsuGIEyjsqPumH/5Wlkx?=
 =?us-ascii?Q?xN+7TZ5MldFKQeZbmeuzf1S3EFHir6LTRyehgRjuC1O2O5pkHGtNwtuseb4/?=
 =?us-ascii?Q?C/UPLJxbQ68wkJ//w9QkJgm1++e12zG55g7l1ssryAggKjLNFxyRWfb7HXhR?=
 =?us-ascii?Q?A/1e0uiH1jJbbivq0eW78tURtqmjcIcg3mudmvdWw9HRS49KW6dC5kqXiLXi?=
 =?us-ascii?Q?AJtC4fQ2xlVvyB+YDADCvPySvpaJzAAJFyW2ZtChFIgFG92Id2JZTnyikm0F?=
 =?us-ascii?Q?e9JKb8fGGZJI7pvqOkBAz7s8GQgQkh1HYZYVNspvxt/jwngHcdMOMDZu4uEy?=
 =?us-ascii?Q?xMPXzdbA19/buOUGji3MAiHdQ4jaeOXyunOhegib7d/MChWRqsQHLRPsk7hd?=
 =?us-ascii?Q?WnOeA+mwq6RfstHKP4kTdEPQAqgTBtx12SlLhhY3lismm02EjJXrec9BSFoi?=
 =?us-ascii?Q?gobSXC2SwxouldwSMr6Dxt+WIYuNkbiD2RreaNdcASkwn3Oc+/UygsXiVltt?=
 =?us-ascii?Q?e8byT9jQLm8YC05WXlpVZpWrp6DwkJxEcp/lPgm+jkW8XVQxgF9ptUePFre9?=
 =?us-ascii?Q?19VGquExe5wcjsEVr6LkzfXejoVc+a1Y4ozXtamWiBaSiVc8dUj9pYtwNxbh?=
 =?us-ascii?Q?q39b1mPxM+kPN3w19WSh0tcJNchjcapYkwzFIBhDCugADu8Faje9L0NGdyyn?=
 =?us-ascii?Q?LouhHYzLvMKN1q6MQ+UMPJ2oVXvsPJg5jEbT90/TYmgGuyx6W+2rcDkiXypI?=
 =?us-ascii?Q?5+Uf6rrGpGCpeWU/jP/z5kr6vUB9SyTI1/6lQhmE8OEMX6SNv6k6rMDHlzEN?=
 =?us-ascii?Q?aIabJ3ftd3rzTMVN/vReyTsHpItRuN1r1WMJN+t8yV90WvBTPZDFjvxctlDn?=
 =?us-ascii?Q?aDiF8fNgqnEMIos5C0kdgXMbE+qSEULMZaZ6TtG9+PB701p/UIm0NpPu4fEu?=
 =?us-ascii?Q?9odj7Y5SoT5KR0CBgxO9sWbe2RXXOrMtNYz9uU9vpHOJfjbFs95tilfAnfGu?=
 =?us-ascii?Q?XpSnWmyxu92WDfAVwY8PDhsyJE+5Uh4=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e0133e-cccb-4080-90fc-08d9baf14d8e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 08:53:00.1575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXsF9fvBpNz48Ayyh3K/k3EXkeWvR2LOLq5kynK+a9vuOejqLJWPc/7pSOwnutn8m6wgo+zs0CFEFUlpFW2Ba/UrmzndvO/N3Z1wu/QV7Co=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3851
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Set the payload_type for check_signature() when generating merge messages to
verify merged tags signatures key lifetimes.
Implements the same tests as for verify-commit.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 fmt-merge-msg.c          |  1 +
 t/t6200-fmt-merge-msg.sh | 58 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index deca1ea3a3..e4f7810be2 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -533,6 +533,7 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 		else {
 			buf = payload.buf;
 			len = payload.len;
+			sigc.payload_type = SIGNATURE_PAYLOAD_TAG;
 			sigc.payload = strbuf_detach(&payload, &sigc.payload_len);
 			if (check_signature(&sigc, sig.buf, sig.len) &&
 			    !sigc.output)
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index eb2a9a4a78..6e10a539ce 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -91,6 +91,26 @@ test_expect_success GPGSSH 'created ssh signed commit and tag' '
 	git tag -s -u"${GPGSSH_KEY_UNTRUSTED}" -m signed-ssh-tag-msg-untrusted signed-untrusted-ssh-tag left
 '
 
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'create signed tags with keys having defined lifetimes' '
+	test_when_finished "test_unconfig commit.gpgsign" &&
+	test_config gpg.format ssh &&
+	git checkout -b signed-expiry-ssh &&
+	touch file &&
+	git add file &&
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
 test_expect_success 'message for merging local branch' '
 	echo "Merge branch ${apos}left${apos}" >expected &&
 
@@ -139,6 +159,44 @@ test_expect_success GPGSSH 'message for merging local tag signed by unknown ssh
 	! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
 	grep "${GPGSSH_KEY_NOT_TRUSTED}" actual
 '
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag signed by expired ssh key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git checkout main &&
+	git fetch . expired-signed &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	grep "^Merge tag ${apos}expired-signed${apos}" actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag signed by not yet valid ssh key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git checkout main &&
+	git fetch . notyetvalid-signed &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	grep "^Merge tag ${apos}notyetvalid-signed${apos}" actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag signed by valid timeboxed ssh key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git checkout main &&
+	git fetch . timeboxedvalid-signed &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	grep "^Merge tag ${apos}timeboxedvalid-signed${apos}" actual &&
+	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+	! grep "${GPGSSH_BAD_SIGNATURE}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag signed by invalid timeboxed ssh key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git checkout main &&
+	git fetch . timeboxedinvalid-signed &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	grep "^Merge tag ${apos}timeboxedinvalid-signed${apos}" actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
 test_expect_success 'message for merging external branch' '
 	echo "Merge branch ${apos}left${apos} of $(pwd)" >expected &&
 
-- 
2.31.1

