Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D29FC433FE
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 16:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbhLHQhf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:37:35 -0500
Received: from mail-eopbgr10084.outbound.protection.outlook.com ([40.107.1.84]:45379
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237077AbhLHQhc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 11:37:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WS5KjYvfApeQPWpZjjU64NA9VKpv1YGufVY76hkg2nLc8bebRII1NmHy9w5e4E7+Fj3hQjphislhUujbG3zVImokJJvhnztRUpKdJRJMKyFAWz1Aihy1FTc3GVFZWmhjdGCu6vNcO94EGM1H0s+K2EGwD9As6l17sqEJzvO+TlJ0vnRJq/KdqIigPMIms3vl69AwUbzSLVs2s46O9dJfd1gvhZ66WVbfxTtkwhTf87L/nxsw0LrN5vwwcpcIZMuAsoWOw36KVOspv1KU6FiDcLM5T/jW85Fj9aW51FoS3RTfXCgJXAw79eoF1gWlmm2tuq7a1lmrhW6Xbv+RZ906+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqXAXvJxFfijWtIfXPjhBQEVCtCFbsViLD+T2fFn5LQ=;
 b=Bm4CsCf2aPwtQyqrBGRLQmMs1y7IbYQDFTtGF6oZW/BnaK6sqQiXYuc/rQ3tYkDbgjX6Khqw728/yN42Xjx9xXegDnSXNd8/Vh6DD4oxtfwOjQjKtHMOcsFkdUDQD9BSXF1AO72l5aNUqnD+m7iFxxrcbTUW3JwVhxKJ3hYtN1qKIGQfZao80gFf8wc2Pr09aGQvZVHQig5EmZTp22VyfzE+cmBIsANSr1lGcXepE+ox6QtKEdBdY6/ZGbru/i3XJAGAMldgvid54HjgJEH4XBgCR0PQjIBPLUcsGRNyF8fUBxGcklDfiyF9JbacAIo6bAzyPFuUx2VGI5oMge6Oog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqXAXvJxFfijWtIfXPjhBQEVCtCFbsViLD+T2fFn5LQ=;
 b=knBX6AOpI3b9U2R9wh9Jr2IAsBGDKpXbezhs2RNJHIiMk1pKJ2dlnG3ultjqM6ESVH9uAtJmy65MSMmJKz/Sy6PXzHedgJqqs2A/G3E0jaLZNerSzE4tCEn+6BZwRqGc+R6yunqNm0aasdghIa/g0WHMhBWNKJioQsY8K1KQq8U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3914.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:43::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 16:33:54 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Wed, 8 Dec 2021
 16:33:54 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v5 6/8] ssh signing: make fmt-merge-msg consider key lifetime
Date:   Wed,  8 Dec 2021 17:33:33 +0100
Message-Id: <20211208163335.1231795-7-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208163335.1231795-1-fs@gigacodes.de>
References: <20211130141112.78193-1-fs@gigacodes.de>
 <20211208163335.1231795-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR05CA0060.eurprd05.prod.outlook.com
 (2603:10a6:20b:489::31) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:3e55:2984:f78e:8b18) by AS9PR05CA0060.eurprd05.prod.outlook.com (2603:10a6:20b:489::31) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 8 Dec 2021 16:33:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0caf52d1-8d1a-4a39-b23e-08d9ba688667
X-MS-TrafficTypeDiagnostic: PR3PR10MB3914:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB391473E81BE5D609E66E393FB66F9@PR3PR10MB3914.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:67;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 22Epqgufp4zpS0zjUCwwErtjSnP+2fsAUAKmsg5ObK+AumNAc1ix7WEgI6yQaQ5KqmwVoHP0xXNgcKE77WWhOz8GKEJSrL15x2uEIOOhz2iBF2mBI5dKVsYyERzQQgiMpWeodwHOluMl4k7gzrT4Fv8hC1N6HY5vG5PgHqesaI9Ccbo6nIAGZqU4Bin/QY2NtoWGYTmbcH57XHAHu3RUMymDqCeh6bXjq0UWOGHQRIcRCKIjKO7qx6RNUHrr7PZrE54EXycgoI9+tuSwlgZ9apgU0177QaT2JqfyGNsF8u+F3YhDiguQ0ALnpAkVBsXHbPTGPIO3Dkcg0Ro2+kYAKNhv/KViTjolBmuGUsZhBY7a9ke+hR9v9Q5uW0EJrQAdLFtZ2pbPwjOM7VpxzKlQ54vBN1IKA/r+sEhBJb8LLikb+tXHvjwGJrADlCwuWpD6VLM2XSCMvhU3+I7jucxrxBcBVswBsSykV1qlsqc+aMtbk/RRWsry5m0d39MWBivx0fdiK9TJ79C/0xGfdMNJ9UXU/3gHg3wZHkc4OkBFsYfhoKFnz61d3xmJoOk27isJJofTimoiraivZjBN2W2GDcsbqmVuXZlPCxNm9AptKYlM+nmnY9gLqX9MMBqpTMhbmBS2Duj8zsZ5xMTktDHe0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39840400004)(508600001)(2906002)(6916009)(2616005)(186003)(6496006)(36756003)(38100700002)(83380400001)(66946007)(8676002)(66476007)(8936002)(6666004)(1076003)(86362001)(66556008)(5660300002)(107886003)(54906003)(4326008)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RX66LfoRR+V40M7a0PqO79bv3nbVADDcZRUiz2smTVTY6p5cTljCNQ3GzJ5y?=
 =?us-ascii?Q?qu/GrgkW9VLqXlEchGA81MnkeiJh3Z5uZnu7Rkmft8YImkviCcaKd3sjmDYj?=
 =?us-ascii?Q?hBAwP6f10Z3Cq+u4iPHVUlZarlIQCFEXBs0fm9JtkBlH5p6CiFMHCqHYAFvY?=
 =?us-ascii?Q?AN5KFHztDuDlcaEnXB9bWcSpPvzHX0kJL6KQf9RXP17bsv2i0Yc/ubSvFKib?=
 =?us-ascii?Q?jPRlQnuaFbdS1+g1b8JmlVUiB1RA+sHTlG5lfHch9xT/b0R9C0xx/XgIYGqb?=
 =?us-ascii?Q?BUWzL4R9Ap+DwLAbNlsKZjjQJ5q3H1Xq6XGmau9q8ED4vK+5jijYSmlKDw5+?=
 =?us-ascii?Q?ZEHSiTsBSZBZXwThRLXIiubN4SxhaE1j3YKCivLwJllALOXwov4pCuZN6U6n?=
 =?us-ascii?Q?ybLNRcFKVabI5GU87nkcR8ZrPToft5tbWFcACYQhqzkidf7AcaT5WuMoXtgV?=
 =?us-ascii?Q?CwsISoi3L3YSqePu2u4+0/TKbmorGJ6l7XauoUf3OeZsgseMbVbMJEMykt35?=
 =?us-ascii?Q?3k1dUOIg6eTOSEVxQMmljeNV9UQnHvamrOOiQrr5ljEznBjgbU0zLAleD9j+?=
 =?us-ascii?Q?S/eZjA7XJS8gP9tlqn1XvbB9Mk9+Mrblhk5FxKbXcn6k7qXUjWDvc7dyxDvr?=
 =?us-ascii?Q?ytRzyoW9wfyr0RfZbmPPVWcXq++sXHJdeJIgDWL4QUyZyUzcJ1cilT2KHAh1?=
 =?us-ascii?Q?9sMBD8lbzUavZoL66xNs6WqfWDVgx640jNZlGvewp2sfeZ77nVmJXwIUKI3a?=
 =?us-ascii?Q?oJ9OKFZsdJZcj/OOdZN+KJ7+fxnPC509L98YPV/RyTU/9odOgErY887kp7Aw?=
 =?us-ascii?Q?TkyTRJ1luVp1NnGA4/7XrnbWQczhwziJNESpG+mQ04XSNIKPEy4UaT5RFk/T?=
 =?us-ascii?Q?A5D31WU7VJyTy4vepgmbjjOwk+BhNxlQo3sxi/H76R6Nl9lJANHRdBqPZVLG?=
 =?us-ascii?Q?MosyNdCtvA4sz3zwL6pTwPGRinHduGlAoAIoJWlgof58rNY7j9wLIQWiiDLU?=
 =?us-ascii?Q?bZRNqf3tjd4AAoMlN0Kvp7aeHxDu3yz0voohA3/dd7pZVlQOpka87s5k+xEL?=
 =?us-ascii?Q?LQ5+pnSFQ5UMuvOzpbaaCgy+vZ34Gx6RXDsQoWm7Zjlu9xup22xaro/UfiTg?=
 =?us-ascii?Q?k89mYdelJNzYVl/LanJA7v6HG8/2Zlj7VJu9Gx8Z401yyy6LN3PEgGPTQl6W?=
 =?us-ascii?Q?dZ277BHtcF7JCUa/4SoNtrQd/gr5u90zLoPhNbb16wZd9BBA8/OEhroHcnYT?=
 =?us-ascii?Q?IsiaIbSdwiulW+lxJ9WfTbaw9jtHgajICYefd4o/L3JWGKajVeE6O4HwlfwA?=
 =?us-ascii?Q?LJrxJ6XRf04hkRmm6aInFAtcKcD/fPKx4nD/Oce5zE2KHstOGoEaQSmKIFuw?=
 =?us-ascii?Q?2SK/yNZVpjJuBdi1/8n5gbUot1xrIDfL3IcWWluy4p/swW1iOTtpI9lUvWUa?=
 =?us-ascii?Q?VfcOthI5SZGWUuVP4PsykYIrIDiHgVirUmnBbQDtJv+CaZ6plT9y0smsPcCS?=
 =?us-ascii?Q?R9cqEj5gPt+ksyNvmg/EC3a34a0D/ADQGpyuaQ9hqJqbkEiifMFQR3kV427J?=
 =?us-ascii?Q?Fzk3OI02UDNfeQw9YGMm9wlGHJaazl34FK4hBV+4oQZeT2agZg4NBQd8xTvj?=
 =?us-ascii?Q?aQcfjRNBqf06Msz9o/5NIkQVJ3bOmZ2mraNabSy4+/p4yVfR8UX6rkkwITlB?=
 =?us-ascii?Q?Wbiv2A+3Aatg2P7PbMdJIuCI/yWaEWVQtdFID9hxTkiw9hsBS1ARah5eJ1iU?=
 =?us-ascii?Q?XNh0L695zg=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0caf52d1-8d1a-4a39-b23e-08d9ba688667
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 16:33:54.5457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5GhIlvqInGL8Muez7v63n7v/gyTdTDIqK17VU/KVYBdBs6xu0X5ukbSeP2XkUBEtpLjvBV3bJSby9y6KcRqIn/HhyYJG33vNUIyfrpfPlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3914
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Set the payload_type for check_signature() when generating merge messages to
verify merged tags signatures key lifetimes.
Implements the same tests as for verify-commit.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 fmt-merge-msg.c          |  1 +
 t/t6200-fmt-merge-msg.sh | 54 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

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

