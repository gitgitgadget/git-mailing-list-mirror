Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A82C433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 15:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E18796112D
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 15:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbhJVPM1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 11:12:27 -0400
Received: from mail-ve1eur02hn2210.outbound.protection.outlook.com ([52.100.10.210]:57385
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233183AbhJVPMY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 11:12:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9B2eI4i2a0fsAUj0J2GSIZL+gBEIknvANYAEB/6tDmgsfK7o29lJJqFu714Qdk3Vfn+MAE1ZPmQkQ6pOoBTBrDws07vK6zl75sFfuw2kf8MlCd++U2Xl0XgsRqdQbYotZUiaeZIHYWQvI7EQ0UNR6wf7+5dNp9RaSa/QwBW/6XAZ4NcaMch6p9tGm44YLSNruuG/nEvTUH/Mqd9S8IIcQo2vRSNOnq/8ljKKNzLA/6SyPP4AhXHIf0t+SGLx8P3Qu0c9XAjibyZRax/9CnRkhgKd4zkqtu/aTijQZv0blhUKGxoJ4PYcVo8A6TMTMKIsTHfIjn5xuc9NmKF0oMllg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpvDbtu705R8sR6gd0MQX18IXhfr83HgtkIIjkZIaQM=;
 b=oZ9XTQOyPWT/PIChFEBYdCddym84Eib58XB2p40GChJxQySvB/WZixS2fh+fntpBKGa1rhS+oXXhN5u+eSzySeDSjU0s8lD8nPppdMTIiznqDhoMqWJRrm3L+Lh1u44OqIA2C1Ece1r3adC3uVf7TIzhieQo+dawpTDbBXODTAhUVSGEB0spIDD+pGWhumM5LYyTCZ4wJ0hoM/j3FfKsNH0oAacWpMPedYGiaAQ/DJymR56QrSJBVgMaidDUWldXBMNXWdabjcfIgDT1zGf2vwGVhllIp7n+rRXak8bXUR6Gnkhz4qtMEOYjfvBdRfd7bRA2hSo59GbkIkAzxnE4qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpvDbtu705R8sR6gd0MQX18IXhfr83HgtkIIjkZIaQM=;
 b=onWUReJhgRYhs8FxI3Rnqm+IAngrOr3qOFZ/JIbZ8BqFhTG8KzP05fP2BaPUWCqB0HNsvt9rc3W2bEik2vcWJGPOgMFh7yH/ck1PKfvBGbEpOIsg9eVXr/UfqIYKFm2JzqygLfj2CRYHQlOMfQgRLhGZHkM0yhBUurnws6wxk3M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4637.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:15b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 15:10:05 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 15:10:05 +0000
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
Subject: [PATCH 3/6] ssh signing: verify-commit/check_signature with commit date
Date:   Fri, 22 Oct 2021 17:09:46 +0200
Message-Id: <20211022150949.1754477-4-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211022150949.1754477-1-fs@gigacodes.de>
References: <20211022150949.1754477-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P193CA0102.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::43) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM6P193CA0102.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Fri, 22 Oct 2021 15:10:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b334b1a-1efc-41af-7b7b-08d9956e076c
X-MS-TrafficTypeDiagnostic: PAXPR10MB4637:
X-Microsoft-Antispam-PRVS: <PAXPR10MB4637EDDAB5AE5961DCBD2AB0B6809@PAXPR10MB4637.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FN2naMGBpi6yFMzo2C/PhjerbfiZRQNgRUFYSOOV3ZegH9GmIVMMJ+ubcCae?=
 =?us-ascii?Q?4hs89r4bXpqBnMRJHfMbM0zgza7DctuAyuWmH0fIYwzeuTU+/PV8oJAMVu+p?=
 =?us-ascii?Q?b+Aj1JaWHPAOpu+ulo1X8byyOuBeMSHuSr0KenbFB586ZJwEiYVuiLsGvw2u?=
 =?us-ascii?Q?uUrwdQiI7RiriKRFBzmzI1R9CO8Yq53rfDz5VK//6+0n9VTiIMJPLIsr2mK2?=
 =?us-ascii?Q?RlSTTyXFyNYl9lzTDwBgy4TReYyDfP1VYMHNAQcQJ2MXECsi01xUVzFU8QLo?=
 =?us-ascii?Q?/PAURZXzcgodUoAGMsC+wX40SkEXMf8eOIpokwuSmzOnGzFZg99J7u3FpEhw?=
 =?us-ascii?Q?GySGZ0USB1H1d3mljDE/FO8fi+dycQZ1bx+1NYHCT1JAhvpeNsQtInfc/yEB?=
 =?us-ascii?Q?Vjpf1M5GE85M4QihEYoK7RlqCowfxjKPsxBHM8efOaMbSnfteX3l1gMDi9C4?=
 =?us-ascii?Q?KAf9ThMCsfR0IP5ZFTsZKcd3dP7igbkREBBtSZ6kAu2iLY/PvzrbAcEnDXQR?=
 =?us-ascii?Q?gpEam7Vm9SIqxuaFU2AAmsru0osOm/4lh5D7yQRPt5a4pgWx7rYxNpnhskkE?=
 =?us-ascii?Q?qTNrAayD6StST1PbbkvdrFcjAX2KoKJyNNQtNlTuTjV0wSDrxywEh/lVKSDJ?=
 =?us-ascii?Q?rLr2lsv8vtZr9aiG5DEoF4zQ8ROvlvx15RRrkr79yh7X4JVLlsUPm7cHfLLN?=
 =?us-ascii?Q?3GKVOhuqe7mg/KEimb5sr8wbsFrBYfAtv8cFjDxKbCybFm9zSqZy2L/HGIAo?=
 =?us-ascii?Q?oorfMTMJWneL5hxpswSEoGwM2pEAdq89EE4NNkc34OMpCnxeYIyWLpmXyiN9?=
 =?us-ascii?Q?cz5lWwNxIidHYl0tDtAFkyTqBlky8moaeV42kUWqhCJbsX000wiMK9xqP/gL?=
 =?us-ascii?Q?G5bDvXAyJ03BMQBYxojRA1QLywAqe8UxR0QJr+QkaxmRcWIoWg6OlM7mNxIg?=
 =?us-ascii?Q?3lCLztftEFcNi5WWZQVKjFvHez1Q/UXTz5YKDk+/ibv4r2dkKWiKprQ79eAF?=
 =?us-ascii?Q?msiLVp6huhySeBLZpsYeQXm5Nw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(376002)(396003)(346002)(366004)(136003)(39840400004)(4326008)(7416002)(186003)(6486002)(2616005)(316002)(66476007)(66946007)(5660300002)(8936002)(8676002)(508600001)(83380400001)(38100700002)(15650500001)(66556008)(2906002)(6666004)(54906003)(6496006)(36756003)(86362001)(6916009)(1076003)(52116002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7U2szoQVzPo5vK2wvB3Tnzsw44qBYju6hXq43v4iYDLAaefpR46IHM7iFcOP?=
 =?us-ascii?Q?vgJGuvaSxGN8v+WGWFbr1zdMUP3Ex1EDeLI5mVbkL0UUa/Ovs9lM7YQYR8cb?=
 =?us-ascii?Q?n0YetQu3gDLC4PSrKtUlIy1COoGJ57++d6gOLUocXNG+ggFEa4NldrcV60Xm?=
 =?us-ascii?Q?R+mqEBgSZpGacMUoJTpJkE4XKnmxku8IX+RUSYsrQVTt/Bf8UJ/ObS/nIo8o?=
 =?us-ascii?Q?Q0H1laBOSxmgLg0Zb5mPo0XF5y4wKH5ouuV4fiReG8BKDJmT7tVkUUYJE5oW?=
 =?us-ascii?Q?c9ShM/pThiDkrZCVDWL7Ktmc0hnKu1mJRB9+2XooDr2KwWtRNUvmZNQRZvuH?=
 =?us-ascii?Q?LKwZcyguqhYfrE5zmz305Tr2/BxcMstIkxxH4mD+yu3KuXjfIVsDgDd9rUSf?=
 =?us-ascii?Q?Vd/FFzSSqz7JtmyydcXgG+lQOhnIagE4irvuLgl5yFGbU9qkixg2JZ7JsHH8?=
 =?us-ascii?Q?bNT/AC8I20t4iK6jgEm3QDd+uOtWkVjWsi2afX0wln9c4Lq3Ymiy8Muu6Cs2?=
 =?us-ascii?Q?AyRctfOXxlpUKjhUsBREbdkDm+RscD1c+2FfxQa/YzwSH1Ls7tnFo1ogYCDY?=
 =?us-ascii?Q?I3oVGPfxF/MjvjpGNPp6aDFkk5G+AazjnQuu7If5znu5HJwlQ4R7IFjgqjZo?=
 =?us-ascii?Q?kHYsDK2LwRqOtZ3Me946c6ENGPAvV5W2HgYtD0aYfWnBnb2+0loD23IEbhjf?=
 =?us-ascii?Q?qlS2DnX/IEQbPGcW81AczDDhsOP0C3PE5SdwCGpx/bo5M5rVIcmLuNflEDZP?=
 =?us-ascii?Q?1z9Rnyf59eF6nFDzZgCTzcqUKktW9Nvp610tn6kopCIw+3VN0NPAhuDzT3up?=
 =?us-ascii?Q?UuyUpcL/sdik3juUS8oH7nN4St+JLiplKzYGT5KPH8T+BtjCAMkv1r5FHGuC?=
 =?us-ascii?Q?3H/695B+2wDfMtsrr5npt6DZP+pF4IbSqOfmcuojPvfCm62N3dKMSQVL/9d/?=
 =?us-ascii?Q?T3x1WCxwaAjv5efm8GKnI+sS97O1fRbdhg0Id0/PAooeX4OZwVTMN4gvndyR?=
 =?us-ascii?Q?gcnEDK6FrqPDu4vs2969jUw787D12uIMJLUbQadRKniAyPk8sBZmxZj1mvta?=
 =?us-ascii?Q?X8abUN7gZba8qeB14NHgViUU3AbxbhV7lXUZn+XRcCZ4YKI4HDjFPJdyGTk4?=
 =?us-ascii?Q?AEQXXQWrawbDYsNyk/nPviYOJzHCs3hLWUBTZovUTmMOx5EopAmB30Hdgi6T?=
 =?us-ascii?Q?7DLKFp9/hQsJox6rnpXCnKzqeLS/KyQtBlS+w7PkiSRoHV91TigJLeHMUYNE?=
 =?us-ascii?Q?/LIb87zxw2c/cQdqE486aJbZYe+T+wPfdvNhcOV8HXUS/obTBy74OA6nsP08?=
 =?us-ascii?Q?6VuDoHb1koQeNvF4y7eTZhrKJKRNFXEGXfSbMBPpegpFookRlfqTOeHrhLsw?=
 =?us-ascii?Q?VtPumdxGxOBTbDb9ZtY5lVf5s2AGLWcgl8Dr5r6f5TLpJN66GopTzMikzffj?=
 =?us-ascii?Q?PrGYN6JkRlQHQBo3dSVURycB6AsAl2UVTwGtgCI2OyGNjxGE+niqCQ6vCtjG?=
 =?us-ascii?Q?K0YJJIchZvqN68wWTdt+NpzekvbvLBjtw3h4?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b334b1a-1efc-41af-7b7b-08d9956e076c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 15:10:05.4202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fabian.stelzer@campoint.net
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4637
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If valid-before/after dates are configured for this signatures key in the
allowedSigners file then the verification will check if the key was valid at
the time the commit was made. This allows for graceful key rollover and
revoking keys without invalidating all previous commits.
This feature needs openssh > 8.8. Older ssh-keygen versions will simply
ignore this flag and use the current time.
Strictly speaking this feature is available in 8.7, but since 8.7 has a
bug that makes it unusable in another needed call we require 8.8.

Timestamp information is present on most invocations of check_signature.
However signer ident is not. We will need the signer email / name to be able
to implement "Trust on first use" functionality.
Therefore we provide parse_signed_buffer_metadata() for parsing both from
the payload buffer.

Passes commit date for verify-commit on to check_signature.
Adds test for keys being expired, not yet valid, having a commit date outside
of key validity and within.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 Documentation/config/gpg.txt |  5 +++++
 commit.c                     | 12 ++++++++--
 gpg-interface.c              | 43 ++++++++++++++++++++++++++++++++++++
 gpg-interface.h              |  8 +++++++
 t/t7528-signed-commit-ssh.sh | 42 +++++++++++++++++++++++++++++++++++
 5 files changed, 108 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
index 4f30c7dbdd..c9be554c73 100644
--- a/Documentation/config/gpg.txt
+++ b/Documentation/config/gpg.txt
@@ -64,6 +64,11 @@ A repository that only allows signed commits can store the file
 in the repository itself using a path relative to the top-level of the working tree.
 This way only committers with an already valid key can add or change keys in the keyring.
 +
+Since OpensSSH 8.8 this file allows specifying a key lifetime using valid-after &
+valid-before options. Git will mark signatures as valid if the signing key was
+valid at the time of the signatures creation. This allows users to change a
+signing key without invalidating all previously made signatures.
++
 Using a SSH CA key with the cert-authority option
 (see ssh-keygen(1) "CERTIFICATES") is also valid.
 
diff --git a/commit.c b/commit.c
index 1704d9df0a..e5dfbfcf8e 100644
--- a/commit.c
+++ b/commit.c
@@ -1207,17 +1207,25 @@ int check_commit_signature(const struct commit *commit, struct signature_check *
 	struct strbuf payload = STRBUF_INIT;
 	struct strbuf signature = STRBUF_INIT;
 	int ret = 1;
+	struct strbuf payload_signer = STRBUF_INIT;
+	timestamp_t payload_timestamp = 0;
 
 	sigc->result = 'N';
 
 	if (parse_signed_commit(commit, &payload, &signature, the_hash_algo) <= 0)
 		goto out;
-	ret = check_signature(payload.buf, payload.len, 0, NULL, signature.buf,
-		signature.len, sigc);
+	if (parse_signed_buffer_metadata(payload.buf, "committer",
+					 &payload_timestamp, &payload_signer))
+		goto out;
+
+	ret = check_signature(payload.buf, payload.len, payload_timestamp,
+			      &payload_signer, signature.buf, signature.len,
+			      sigc);
 
  out:
 	strbuf_release(&payload);
 	strbuf_release(&signature);
+	strbuf_release(&payload_signer);
 
 	return ret;
 }
diff --git a/gpg-interface.c b/gpg-interface.c
index 6049f7cbf7..fed5113297 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -453,6 +453,13 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 	struct strbuf ssh_principals_err = STRBUF_INIT;
 	struct strbuf ssh_keygen_out = STRBUF_INIT;
 	struct strbuf ssh_keygen_err = STRBUF_INIT;
+	struct strbuf verify_time = STRBUF_INIT;
+	const struct date_mode verify_date_mode = {
+		.type = DATE_STRFTIME,
+		.strftime_fmt = "%Y%m%d%H%M%S",
+		/* SSH signing key validity has no timezone information - Use the local timezone */
+		.local = 1,
+	};
 
 	if (!ssh_allowed_signers) {
 		error(_("gpg.ssh.allowedSignersFile needs to be configured and exist for ssh signature verification"));
@@ -470,11 +477,17 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 		return -1;
 	}
 
+	if (payload_timestamp) {
+		strbuf_addf(&verify_time, "-Overify-time=%s",
+			    show_date(payload_timestamp, 0, &verify_date_mode));
+	}
+
 	/* Find the principal from the signers */
 	strvec_pushl(&ssh_keygen.args, fmt->program,
 		     "-Y", "find-principals",
 		     "-f", ssh_allowed_signers,
 		     "-s", buffer_file->filename.buf,
+		     verify_time.buf,
 		     NULL);
 	ret = pipe_command(&ssh_keygen, NULL, 0, &ssh_principals_out, 0,
 			   &ssh_principals_err, 0);
@@ -482,6 +495,7 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 		error(_("ssh-keygen -Y find-principals/verify is needed for ssh signature verification (available in openssh version 8.2p1+)"));
 		goto out;
 	}
+
 	if (ret || !ssh_principals_out.len) {
 		/*
 		 * We did not find a matching principal in the allowedSigners
@@ -492,6 +506,7 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 			     "-Y", "check-novalidate",
 			     "-n", "git",
 			     "-s", buffer_file->filename.buf,
+			     verify_time.buf,
 			     NULL);
 		pipe_command(&ssh_keygen, payload, payload_size,
 				   &ssh_keygen_out, 0, &ssh_keygen_err, 0);
@@ -526,6 +541,7 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 				     "-f", ssh_allowed_signers,
 				     "-I", principal,
 				     "-s", buffer_file->filename.buf,
+				     verify_time.buf,
 				     NULL);
 
 			if (ssh_revocation_file) {
@@ -571,10 +587,37 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 	strbuf_release(&ssh_principals_err);
 	strbuf_release(&ssh_keygen_out);
 	strbuf_release(&ssh_keygen_err);
+	strbuf_release(&verify_time);
 
 	return ret;
 }
 
+int parse_signed_buffer_metadata(const char *payload, const char *signer_header,
+				 timestamp_t *payload_timestamp,
+				 struct strbuf *payload_signer)
+{
+	const char *ident_line = NULL;
+	size_t ident_len;
+	struct ident_split ident;
+
+	ident_line = find_commit_header(payload, signer_header, &ident_len);
+	if (ident_line && ident_len) {
+		if (!split_ident_line(&ident, ident_line, ident_len)) {
+			if (payload_timestamp && ident.date_begin &&
+			    ident.date_end)
+				*payload_timestamp = parse_timestamp(
+					ident.date_begin, NULL, 10);
+			if (payload_signer)
+				strbuf_add(payload_signer, ident.mail_begin,
+					(ident.mail_end - ident.mail_begin));
+
+			return 0;
+		}
+	}
+
+	return 1;
+}
+
 int check_signature(const char *payload, size_t plen,
 		    timestamp_t payload_timestamp,
 		    struct strbuf *payload_signer, const char *signature,
diff --git a/gpg-interface.h b/gpg-interface.h
index f7c5389c90..1cbecbf4c1 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -65,6 +65,14 @@ int git_gpg_config(const char *, const char *, void *);
 void set_signing_key(const char *);
 const char *get_signing_key(void);
 
+/*
+ * Tries to find "signer_header" (usually committer or tagger) in the payload,
+ * and sets the corresponding timestamp and signer parameters if found.
+ */
+int parse_signed_buffer_metadata(const char *payload, const char *signer_header,
+				 timestamp_t *payload_timestamp,
+				 struct strbuf *payload_signer);
+
 /*
  * Returns a textual unique representation of the signing key in use
  * Either a GPG KeyID or a SSH Key Fingerprint
diff --git a/t/t7528-signed-commit-ssh.sh b/t/t7528-signed-commit-ssh.sh
index badf3ed320..dae76ded0c 100755
--- a/t/t7528-signed-commit-ssh.sh
+++ b/t/t7528-signed-commit-ssh.sh
@@ -76,6 +76,23 @@ test_expect_success GPGSSH 'create signed commits' '
 	git tag twelfth-signed-alt $(cat oid)
 '
 
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'create signed commits with keys having defined lifetimes' '
+	test_when_finished "test_unconfig commit.gpgsign" &&
+	test_config gpg.format ssh &&
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
 test_expect_success GPGSSH 'verify and show signatures' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	test_config gpg.mintrustlevel UNDEFINED &&
@@ -122,6 +139,31 @@ test_expect_success GPGSSH 'verify-commit exits failure on untrusted signature'
 	grep "${GPGSSH_KEY_NOT_TRUSTED}" actual
 '
 
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-commit exits failure on expired signature key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	test_must_fail git verify-commit expired-signed 2>actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-commit exits failure on not yet valid signature key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	test_must_fail git verify-commit notyetvalid-signed 2>actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-commit succeeds with commit date and key validity matching' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git verify-commit timeboxedvalid-signed 2>actual &&
+	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+	! grep "${GPGSSH_BAD_SIGNATURE}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-commit exits failure with commit date outside of key validity' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	test_must_fail git verify-commit timeboxedinvalid-signed 2>actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
 test_expect_success GPGSSH 'verify-commit exits success with matching minTrustLevel' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	test_config gpg.minTrustLevel fully &&
-- 
2.31.1

