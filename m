Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2A0C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 15:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D52B16112D
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 15:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbhJVPMh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 11:12:37 -0400
Received: from mail-ve1eur02hn2210.outbound.protection.outlook.com ([52.100.10.210]:57385
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233358AbhJVPMd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 11:12:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mzb/yYT1uGWUU6RO0RNpXUMhzSDYl0D4pcSlMuiiWwxnhlcZv1xDs+ES1TMrp5vqTcR1O7YsEpt41BrN5xi/qsuvA/qO3KjcbKODpj5tucJYypXkt8RkChJMYM9K/PQ3v11OLnc8xClGPZvBgO9w61IMcnKMHXQT+NtNxSE7UsquQXLWhv4VvtKWEWcfE4iTC1L39WlX4Xw6tEVBbAK/1aD9QcpgwGjjnvkjLJVjTVpcen08+XZlx6BP+SZMY/pZuBDWDZY7WkpYeKHX1JTC8CbwTh3A8Jf999PygZ9Neiv5f+oLnj34ahU5X4rPBw9PGK0n+Lmy7G8mynrirtcqhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQ0e9h3LrMkyP9+oFwdCHZ9zXefwAivf1KvEwQ265ao=;
 b=U/E+0d+Nm0QaWqFUMMJxVGbLQOGB0MPXWjWrJ5faa9ztVxuIx3bhTvh7c8UgLPKflM+/ohfrXA6qQfydMTgVBdBrY4+AOCOE5D5OwCC31+7BCTyJINbAqDVLqb6IfrCpheTXYXxnstBRQ5/Moj2B1t5cfmtbIs83k0ZtEABXQ77/dChEaYVBN4T9XfoGljahj+u5ERr70svkIlVj7rLJb4qrpN1pAm1x2lD+5bbhfuScjuYWk8HOOSn00FWFfjXzTh1wRpuOgD9SKmjfUJAsgNy+at4kFRY/dDTlvJJitbyP2DF4+ou0kkoOzogdz2e4e/+g/9wX1hJEt9AKr6K/lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQ0e9h3LrMkyP9+oFwdCHZ9zXefwAivf1KvEwQ265ao=;
 b=TYwtNh8qOWiu4CQAUIh+5IT/laAEstmjP7kQWWAXiZ5zOABjmUItZ346yP9o1hMU3/CpEVXv5tKaDKoDDCtUc0PvcfL/9taYXTGYaHZNHvCP4Ha9ad8TOJ4EsZd+eOusK0bTTbf4qG57F3U8IuKuJjNtFat3DzYSXltPuCeg3mQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4637.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:15b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 15:10:08 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 15:10:08 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>,
        "Han-Wen Nienhuys" <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Hans Jerry Illikainen" <hji@dyntopia.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        "Felipe Contreras" <felipe.contreras@gmail.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Gwyneth Morgan" <gwymor@tilde.club>,
        "Jonathan Tan" <jonathantanmy@google.com>,
        "Josh Steadmon" <steadmon@google.com>
Subject: [PATCH 6/6] ssh signing: fmt-merge-msg/check_signature with tag date
Date:   Fri, 22 Oct 2021 17:09:49 +0200
Message-Id: <20211022150949.1754477-7-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211022150949.1754477-1-fs@gigacodes.de>
References: <20211022150949.1754477-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P193CA0086.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::27) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM6P193CA0086.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Fri, 22 Oct 2021 15:10:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0130f13-31af-4d1f-6e3c-08d9956e08fb
X-MS-TrafficTypeDiagnostic: PAXPR10MB4637:
X-Microsoft-Antispam-PRVS: <PAXPR10MB4637F8B375A47D59EC8B2D68B6809@PAXPR10MB4637.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:91;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NcGHeCqlNbihmwZw+Rum4JgbSUqAJpZWaFIeOkD5ZKMD7eKtP79u33R6u+Tt?=
 =?us-ascii?Q?WJUYrdggBMBewHDm6g1tx6hadIGo/jeRdVFDvPg3Wx1juq5wiOuEFa7c5ZAW?=
 =?us-ascii?Q?lkUIQJsyZ2J16pbuqQGammH5eY4wAznlpiWheyhgkzjE3UQeYXGc1r1bsedf?=
 =?us-ascii?Q?27NR2xgcPFb3Bw91x1ZDX+jwGZzh+i+rHOk3VvQD/YiEfhXGEf6xoFkWklhV?=
 =?us-ascii?Q?qNSNT3SPbcUWdZznZjHmH73w1sPHuvPTsll00IXNsg4+HhulIfdX3uEKdBTo?=
 =?us-ascii?Q?VrEELHLZEWopKtrF7XfWIk9Oqnu+qRgSViqMVAgRUo0jnJFtt7dTeLf60x4q?=
 =?us-ascii?Q?MeJFARrYq82CY6ywMqmzzzg7WUS5dePbUTd5LTNGpe/imWnSuToM1q/+xoJ3?=
 =?us-ascii?Q?J952BytTCyOqsoTLp/kw3K1V/CQ6aqTHYJPwbiuaeJiUaawYbunYmCeK57JY?=
 =?us-ascii?Q?AakmxtO7PZcKttDoJOCDCKwjJ8vDOVvCL3zNV8XHTLulOGcQyTiodmTpQDMB?=
 =?us-ascii?Q?9HFuiudfgXFrDEcR3+sDdfxqrPnUioBdZPs+xz8D+jcVybHpdZP5LQKbicIi?=
 =?us-ascii?Q?a/F/av7iRnjlGjaHWVuLou+/k145lV+g0fMNDhXjAyBEZ+Z4gPLl3dsGC5u7?=
 =?us-ascii?Q?QKzoRatXFpIUQ7V6vfWs+m37cWf2qNc79JUqlhCsM0lW3TbQpbOwhbYeZt34?=
 =?us-ascii?Q?91Y1zxQ2V3j7F6oEY3mwP18/Z7Kgu5qyoZzQJRJLST648rSWjmyF7fYX+a34?=
 =?us-ascii?Q?W03irtTUN4QIgJuGGGvKuPKuD385spQQY1eq397bolQbaAItQY5ImEHfrVWH?=
 =?us-ascii?Q?6DkBv/jIGkhmGddc78XF4to0SPz5g9VqWyVHmsU/BPX3BklhrdYXxhESve6k?=
 =?us-ascii?Q?r+QnPI+kipJj+elzBlrJd9Nak1GRVUnsTON18AkP2SyP6AtRaIa8HPmo7Z+P?=
 =?us-ascii?Q?L8UMDPYWohRAluZazagH587nMnA5cnTh2SxQIJCCbTVhWLeMbxI/dYjLepj3?=
 =?us-ascii?Q?3fPYXNudYfrJXBl/+YRrorcpGg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(376002)(396003)(346002)(366004)(136003)(39840400004)(4326008)(7416002)(186003)(6486002)(2616005)(316002)(66476007)(66946007)(5660300002)(8936002)(8676002)(508600001)(83380400001)(38100700002)(66556008)(2906002)(6666004)(54906003)(6496006)(36756003)(86362001)(6916009)(1076003)(52116002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ug0asPPiNnEwaib+3bNv0NLdhxil/yVro9BYwGtopjCdmGc35M0DIV5UkISI?=
 =?us-ascii?Q?Qhnf8H144i2ub3b72IYognuQf0p44dQJjAxgmKos853SuD65hqQOkiJIRkVZ?=
 =?us-ascii?Q?k9FCkzmZ1/fs7FJlXu2eOQCkM+M61hipU3vHDqgp1eV/UJbP4WXURnFtuxeh?=
 =?us-ascii?Q?lAODgqm3UnbQIcVH0jT2P82/IIJd2nqkzfBlIXG75YEZXfYq+M4WidSo5spS?=
 =?us-ascii?Q?B+WmWXH+zzCHmntpPvR48EXmjr2PfM6VCqcZ5kkoVw4hPnT4skO872aIC8hT?=
 =?us-ascii?Q?br+RUqWtvIXkTcSl5CwdUVT+82z/zHIp8HvNKxgOqaoKZhBoT5mn0oSloiLx?=
 =?us-ascii?Q?icMvrHy0Qs/c33iZcwKBLV8z3BlJ5H+An8s/iNPo8os9jX6BTKsspvFAuT96?=
 =?us-ascii?Q?hso3WRPyy51RdWsTNSCq9ZDlv4zTNm8s+f3z4XAA/FrZFm4xMOzRMjetXBXG?=
 =?us-ascii?Q?CcEjp+KzuYQqOq3RLrIRe9xyp74Lj20jrdYEig5Qyb8I4XRuVtONHxu9wHFw?=
 =?us-ascii?Q?4mYk2dU5addVfLt2sIuCLBNNL372i1cNx6AjHAA7gn/MVDwjzU1S7Ufn0zz5?=
 =?us-ascii?Q?nl1gkFdqDxDe0cX6kuiQYzyodNOz1vRXxCeq48ptKK+E2cCJDVnYLMLK89Jh?=
 =?us-ascii?Q?zQ14mSPtLKxpCeIBJzXmE79zAVbyeR/SRJxnxD0rg3NKCgBzex1T2cqrEMpN?=
 =?us-ascii?Q?wk+5uh1uGLiuFiOcTOQPNu0ScMl8LRX4hLG61ITF+N6ELDxRcTUG34XTD9tl?=
 =?us-ascii?Q?gmSbiEm2Rgt8AlMfybiUPGaC6KOu0kJBHXBIGUyhP3lghLWkmkAIpt6nWtFn?=
 =?us-ascii?Q?5WBictkMM+Yhr7XvNEbldxq4O6QppfpLDfBx1j2OxSFTmmkpI3lCaEGF6bs+?=
 =?us-ascii?Q?cyEt7h/3fDu7AymGWbbFNefnzAWjdcJKu909LA2KX0fj9QUYdn8HxCe+ucYb?=
 =?us-ascii?Q?aZeRfFIoSBB+YgDFD4pf30GzC31m8HSiWIBjQniwa/ddUAlkWQ32nTDS1BRW?=
 =?us-ascii?Q?ttja/TLAXjyRpixxvrI78CW0Ysavlj81UeQNgJ84gbucoBWpVNOGPULURFzQ?=
 =?us-ascii?Q?AnS18xD1ZxxhRA/ig8tnNf1Nl12iQGmto0QXIohQvTvgBASJVN3A3dAGFoUp?=
 =?us-ascii?Q?o5oO5N3AU/NiBm+5ehYrp5bJ/j6ArIoAdSAdR4sVzUQ2VJ8AtWFsVr4jZx/d?=
 =?us-ascii?Q?5XpC+12O2IqnuDMudSkrjr0m2TbQLdPBVIO2K9ZFm3nd4F8lTNr2QQYn35LK?=
 =?us-ascii?Q?s0Ovu4eoBW+b8A20IEbkk4P3OpQHuahTYyoUZnDKe/QGaFQX9B0PDpYtMXko?=
 =?us-ascii?Q?LfQXGDr7ueXFeTE75IcLu+IwV+hB6kl1UGy8DfPicLyVWwb4wi/wCLJSeIsQ?=
 =?us-ascii?Q?WT7W0m1DKePGnwvf6E9dCSsr7LNeTJdjubNFbbwzm9wR5VjOp7fqds5n+I5m?=
 =?us-ascii?Q?0MYrr+hLcxVwXfNvoRKV2KLyVMg1oKPHuDIkfjJ5hK/uSLEowmFCpaR0Anci?=
 =?us-ascii?Q?ZYf+EOofh40RlRRWJkOricIUxhR4sB6Po4HO?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b0130f13-31af-4d1f-6e3c-08d9956e08fb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 15:10:08.1273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fabian.stelzer@campoint.net
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4637
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pass the tag date and tagger ident to check_signature when generating merge
messages to verify merged tags signatures.
Implements the same tests as for verify-commit.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 fmt-merge-msg.c          | 13 +++++++++-
 t/t6200-fmt-merge-msg.sh | 54 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index d2cedad6b7..4f49dd9341 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -524,6 +524,8 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 		unsigned long len = size;
 		struct signature_check sigc = { NULL };
 		struct strbuf payload = STRBUF_INIT, sig = STRBUF_INIT;
+		struct strbuf payload_signer = STRBUF_INIT;
+		timestamp_t payload_timestamp = 0;
 
 		if (!buf || type != OBJ_TAG)
 			goto next;
@@ -533,7 +535,15 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 		else {
 			buf = payload.buf;
 			len = payload.len;
-			if (check_signature(payload.buf, payload.len, 0, NULL,
+
+			if (parse_signed_buffer_metadata(payload.buf, "tagger",
+							 &payload_timestamp,
+							 &payload_signer))
+				strbuf_addstr(&sig,
+					_("failed to parse timestamp and signer info from payload"));
+
+			if (check_signature(payload.buf, payload.len,
+					    payload_timestamp, &payload_signer,
 					    sig.buf, sig.len, &sigc) &&
 			    !sigc.output)
 				strbuf_addstr(&sig, "gpg verification failed.\n");
@@ -564,6 +574,7 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 		}
 		strbuf_release(&payload);
 		strbuf_release(&sig);
+		strbuf_release(&payload_signer);
 	next:
 		free(origbuf);
 	}
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 06c5fb5615..2dd2423643 100755
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
 
@@ -137,6 +157,40 @@ test_expect_success GPGSSH 'message for merging local tag signed by unknown ssh
 	! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
 	grep "${GPGSSH_KEY_NOT_TRUSTED}" actual
 '
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag signed by expired ssh key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git checkout main &&
+	git fetch . expired-signed &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag signed by not yet valid ssh key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git checkout main &&
+	git fetch . notyetvalid-signed &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag signed by valid timeboxed ssh key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git checkout main &&
+	git fetch . timeboxedvalid-signed &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+	! grep "${GPGSSH_BAD_SIGNATURE}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag signed by invalid timeboxed ssh key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git checkout main &&
+	git fetch . timeboxedinvalid-signed &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
 test_expect_success 'message for merging external branch' '
 	echo "Merge branch ${apos}left${apos} of $(pwd)" >expected &&
 
-- 
2.31.1

