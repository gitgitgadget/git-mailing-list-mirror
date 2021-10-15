Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8BAC433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 13:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A12DC6115C
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 13:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239255AbhJONRV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 09:17:21 -0400
Received: from mail-cy1gcc01bn2023.outbound.protection.outlook.com ([52.100.19.23]:25729
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236117AbhJONRS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 09:17:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLJ3m8X14j5bWFIUlnoXAfhKjQShJ/J5QyFg6oQJ3DG4YCdYb5WlxxFyAGMgxQTQHn9yeFhW43Jy4wMm+GbCsAXuxjHNNIS8g6pYZAWxjfQuAZ8qNy9S76K0eTFxdDLJTcYhYtyBX2i4+McH5bpmBVhd2tl5Uc35UPZGzzRpbjshPebpvpPKC/cpOIv13rJfffIfwIWJUAQHZwCaLNB8ngkKs6IBVA9pac1ZGoikhD8v5Nhhfj1Bj/6itTzKVOitMkbG9xIdAn9nxbJ46CMYVt2pykAvWn29Gm8Fz42+Q0egAo+YHqBh46IGnqMv+elf/22AVI8K2/72uatLj5IiCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Usar81s4MkJF/zvIiD1Ed+YR6PLVTxs1yOZwVNriQAY=;
 b=lkDAX8bxZv7A7i4dp8vutGMbOLd9Nq0PgCe+WmAAReyF8+JMKt6rKIO6HUqGrDY2vt/nEal1xEZFz4/zWPzTM9wUOs+W9vZEWbsmvz7VJkNowmk1AKV0ssxSelXwZuJlxMxC9MEJCmCgV/eIjLfhsx8bUMtltYxlVAxB07VTovRqMSxfHsKrsP4dphIZfcMgwGlLCQd+zNBSqCyX2ylgT7IHTFPE3nUD87CfL5mXbXFztjtGjcF6xuVKGuXmz7I3nSImU3eUKa35lVSgddDhZRjajZ5AQ0EFT5usWjGOQ7T8ekdx5uXomCjf3KuyX6lOuuBrYTCZOSWjb1oW0aBwWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Usar81s4MkJF/zvIiD1Ed+YR6PLVTxs1yOZwVNriQAY=;
 b=tcShTAjSeEfEKpogBfrRzHDpQUPG0AQfZZ6ALai3X7i70cZFUiFXV7Gla69YHK2xhqpXKstHUtrVd7Huto7rhZPXnOhRCD8GXXtsRBaWIHH12RXmyu7iS0S4NDVAU749sPqAMWq1V9kjg41KZvr/fRC3mWtCdu5w7hI14tNoIVg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4046.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 13:15:09 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4587.026; Fri, 15 Oct 2021
 13:15:10 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>
Subject: [RFC PATCH 1/6] ssh signing: extend check_signature to accept payload metadata
Date:   Fri, 15 Oct 2021 15:15:02 +0200
Message-Id: <20211015131507.1773153-2-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211015131507.1773153-1-fs@gigacodes.de>
References: <20211015131507.1773153-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5P194CA0009.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::19) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM5P194CA0009.EURP194.PROD.OUTLOOK.COM (2603:10a6:203:8f::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Fri, 15 Oct 2021 13:15:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e72cf6c5-6949-4630-6ffa-08d98fddd083
X-MS-TrafficTypeDiagnostic: PR3PR10MB4046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PR3PR10MB40465F608EC5D03125BC06A6B6B99@PR3PR10MB4046.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3yYXgsEOdJAqXJem9zL4dF8g3mQDioJiuqoIr9M4h24KeSMPlhlctfsHKVld?=
 =?us-ascii?Q?Yitedkdn4Hu5X+nJN4fn0dSmzCgTXAgkdTCDXlroPEcVx74smU2Og8YB4dF6?=
 =?us-ascii?Q?Fm/VFXMScWF2jHvVN+83OjQpZqgji4IBAskrvctWgBY977M0zztRfUdsHcZB?=
 =?us-ascii?Q?YHqdVtMsxO4JGTTCY6us/6SbPPJWUk0KRcT+prh8ZvzffXSFrHTKDdneCL22?=
 =?us-ascii?Q?YIOL1JGMFK3McTQZRbmeMHGzKa9Jb2eLCLqeGqR8FEU091+u8iWImnp3o+bS?=
 =?us-ascii?Q?lBAVnHAgbgVmMLZ3+EPMGPJTT/Wl632Ip810+M5wyIWyUJsXchfJFNt6qcD1?=
 =?us-ascii?Q?tnVmfvhq4gbGilxaKz651NIKHT6yy+CHfr6Ux7kokyDHuKsg2Y2TTUsHB5WX?=
 =?us-ascii?Q?9vDQHBrrG6diHNxJ9fj7cvFnBHhWmpJhGinGBA7KG/Gb8jCgZmKY5629vFKs?=
 =?us-ascii?Q?7d34F6FBY2Q0uNy1FH/OzIlQg6K7rBa3tG03l6MYWZn+vVn+VMjNQJoCLJn0?=
 =?us-ascii?Q?fabT9EbXhjKhjEIt+0fs/lhvjROLC2mYavsFVjwI/NVi0vN16r1n8sJPBJQl?=
 =?us-ascii?Q?8/AM/Ymu0qiYCEO0zinkTU8ba9LfrJqI3IVw3alNP4C4Y66MREqIZbpNhQcf?=
 =?us-ascii?Q?7oxDcbHe3i1u3FNL0rXPnrkebeZGfjgidaX79F87efqn6NIWtp/RLPE7pTn3?=
 =?us-ascii?Q?K+q8++kUoDFUFi/h9LbZQWw+qxQV6FODNEa1c+3VU9ZSKDGjrtGjV0w1caLJ?=
 =?us-ascii?Q?DIVpPdir3nOsxMsME1A2MH29Ch5AqVZ2vFrmQApxLKtkBnRvwOR4AHYzmsL+?=
 =?us-ascii?Q?pAG/UtGgZPelFREYVm71SU69YV9eVKIdsUA/YwDm2UT55dLO2U3Xlo3e202b?=
 =?us-ascii?Q?3K71mSJKhxRJIL9G/p4UnvzCwICrInsSu8Zykok/H/ViDcG99UJJ5AScLiN/?=
 =?us-ascii?Q?aaSjnJfgUz+F+j3h24SBvfh42m6ZoLOhF3DLXKYFLZRhPnEjgPuU2APnX//X?=
 =?us-ascii?Q?GDd96w9oUabwFt/ZYq9LIYH2lA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(366004)(136003)(376002)(39840400004)(396003)(346002)(107886003)(36756003)(2906002)(1076003)(83380400001)(6916009)(316002)(4326008)(38100700002)(6496006)(8676002)(2616005)(5660300002)(66556008)(66476007)(66946007)(86362001)(8936002)(186003)(52116002)(6666004)(508600001)(6486002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gpv5iWGU1QnbOyOO9FrDYovHpu+2RfCdx+2O3J3MMXeL1Nge6qIox+tksNxm?=
 =?us-ascii?Q?zEqCAGkMW0Rzl71apOrUi4NUFsJk38JM5B345C8cxySscOGs+FdHIM6pu18e?=
 =?us-ascii?Q?T2ILZMLsYbPO1CirmuhlI10dj8U+7g9ASTWkvhQYawEQ5xyB5890+KgeaMM/?=
 =?us-ascii?Q?Kp6G5uD+KuzRKem54a4Iz9fS6QnBzNrPwRCgWYEa2aWtX1dE0MwvX9kIp5J9?=
 =?us-ascii?Q?FGf3+zv2QA71Ht4UZz5wM+GXZ2dYxVKDanseujhOIJPHzPDzDMGcyLkN84d+?=
 =?us-ascii?Q?PNJ/FRV118h/xNrqUmPk2pj/I+kIqHd9Gq8fPJTAEMVK/HVnruhVuzvkpPet?=
 =?us-ascii?Q?TRBdxNNvKNyLFil1tpSALlXLKssJPgHVbxYuDEacZHcP+U2c+T5qmgTDRSOz?=
 =?us-ascii?Q?hwMZqcOuAaZ296PbUj8e1k34C1ucSL5cUL7bRPnktn8phX/eDHFPzztzpyTf?=
 =?us-ascii?Q?4miaf7Uqy6jSEms1gkxCl93CpxGDO/c6+UPq1RrvLPvYTiy0ONva9KiHCNRE?=
 =?us-ascii?Q?cHmCbxY7AkvdyltiHD8QvM7Cvs5KpUhBqYWwIS32kHjTPRfvy10tppcvQW2u?=
 =?us-ascii?Q?1F8VtuSK2sGgG6CCnp2UomupbjHbWJ9vBQhvGrcQQ5y+o5Bmnk+B/IF0AAht?=
 =?us-ascii?Q?/UWEntVC4kr3sQhbbXOuFAawkDpcnjvibK+WU8au/ZxmiYD0JUN6QwXOQZGZ?=
 =?us-ascii?Q?qniBz4RhavxLE3k1Kp6TtSSp+U5KfRB8d/TvSaaNPP7aXl8vW648H1tNeyog?=
 =?us-ascii?Q?Vx3LlU6dPhENRyTfBNaQWV4Z6qfk0gMfjicIDsA5aopAF6jV4+iW7SHm1sOq?=
 =?us-ascii?Q?WQuSfLRxyXfQY4v/1XKdkgPwPohCFt/C9+L0vAGmhiRkylGXmBpgdoeUJSi2?=
 =?us-ascii?Q?eRReujiHAn0b99Z+OH1ihLy4zPrr/wiaEdHnPXCOMr3MgIcvDAYkvSdBI/5b?=
 =?us-ascii?Q?2WXnIlnQbxd6BQkQxyD5j6nVL646JfZqMD0zuC/7tx4FjWuISZj0VhLPmDyh?=
 =?us-ascii?Q?yLPFXelg9OOZN9GvOfayw7gIjplvruhUKaFV90sWUH3a076PtiMAVItZTnm5?=
 =?us-ascii?Q?pfcMywwWZgM2WO8L8BHXWs651+J2ABCqukKQ9mHSaT1vcco862sAi6Ph9RSO?=
 =?us-ascii?Q?ZjdgLqPA9MIOm740sR7CdEYgOx3pV3L4wNGakXcnLESaMaKrr6ywnteI6Gbn?=
 =?us-ascii?Q?62wNRv5e35gbG9KOyVq3vO76kPThqlh2l4oJMuaifRtXs05S66TG4X6MqhGG?=
 =?us-ascii?Q?9VBb5cdHfmYG6xMLWBmLEZynZQ6cFiMADfm/yfsAC2fzVeCcO7Bv0i99mEXu?=
 =?us-ascii?Q?xftULBn4IjVP4Lpps3q80JwAePfKHcXpTlfiH+J87+sc8DbgxrEyJOxqAlei?=
 =?us-ascii?Q?ueMQCNj2B1J+EcvCFiVnL1WiSsNF?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e72cf6c5-6949-4630-6ffa-08d98fddd083
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 13:15:09.9410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0u/eDG1j39Xnbne0fMOZaOO/jha4AAczs3kIEESuQb0R1tyUEuv1D21gkA5ab4mDvrMRcRjXAL6VtyyF+X318neB0lifqy2ZskM+D9kAa0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4046
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adds two new parameters to the check_signature api and passes them to the
internal verification ssh/gpg methods.
A payload timestamp that will be used to verify signatures at the time of their
objects creation if the signing method supports it (only ssh for now).
And a signer strbuf containing ident information about the signer that
we will need for implementing "Trust on first use" in a future patch
series.

Adding the ident info right now instead of a later patch series makes
certain choices in this patch series clearer. Only passing the timestamp
could be done a bit simpler on some call sites but i am certain that we
will need the ident info for "Trust on first use" no matter how exactly
it will be implemented later.

To start with we pass 0, NULL on all invocations to keep the current behaviour
as is.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 builtin/receive-pack.c |  5 +++--
 commit.c               |  2 +-
 fmt-merge-msg.c        |  4 ++--
 gpg-interface.c        | 35 +++++++++++++++++++++--------------
 gpg-interface.h        |  1 +
 log-tree.c             |  4 ++--
 tag.c                  |  2 +-
 7 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 49b846d960..761c70642b 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -769,8 +769,9 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 		memset(&sigcheck, '\0', sizeof(sigcheck));
 
 		bogs = parse_signed_buffer(push_cert.buf, push_cert.len);
-		check_signature(push_cert.buf, bogs, push_cert.buf + bogs,
-				push_cert.len - bogs, &sigcheck);
+		check_signature(push_cert.buf, bogs, 0, NULL,
+				push_cert.buf + bogs, push_cert.len - bogs,
+				&sigcheck);
 
 		nonce_status = check_nonce(push_cert.buf, bogs);
 	}
diff --git a/commit.c b/commit.c
index 551de4903c..1704d9df0a 100644
--- a/commit.c
+++ b/commit.c
@@ -1212,7 +1212,7 @@ int check_commit_signature(const struct commit *commit, struct signature_check *
 
 	if (parse_signed_commit(commit, &payload, &signature, the_hash_algo) <= 0)
 		goto out;
-	ret = check_signature(payload.buf, payload.len, signature.buf,
+	ret = check_signature(payload.buf, payload.len, 0, NULL, signature.buf,
 		signature.len, sigc);
 
  out:
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 5216191488..d2cedad6b7 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -533,8 +533,8 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 		else {
 			buf = payload.buf;
 			len = payload.len;
-			if (check_signature(payload.buf, payload.len, sig.buf,
-					    sig.len, &sigc) &&
+			if (check_signature(payload.buf, payload.len, 0, NULL,
+					    sig.buf, sig.len, &sigc) &&
 			    !sigc.output)
 				strbuf_addstr(&sig, "gpg verification failed.\n");
 			else
diff --git a/gpg-interface.c b/gpg-interface.c
index 433482307c..5960202615 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -20,8 +20,9 @@ struct gpg_format {
 	const char **sigs;
 	int (*verify_signed_buffer)(struct signature_check *sigc,
 				    struct gpg_format *fmt, const char *payload,
-				    size_t payload_size, const char *signature,
-				    size_t signature_size);
+				    size_t payload_size, timestamp_t payload_timestamp,
+				    struct strbuf *payload_signer,
+				    const char *signature, size_t signature_size);
 	int (*sign_buffer)(struct strbuf *buffer, struct strbuf *signature,
 			   const char *signing_key);
 	const char *(*get_default_key)(void);
@@ -54,12 +55,14 @@ static const char *ssh_sigs[] = {
 
 static int verify_gpg_signed_buffer(struct signature_check *sigc,
 				    struct gpg_format *fmt, const char *payload,
-				    size_t payload_size, const char *signature,
-				    size_t signature_size);
+				    size_t payload_size, timestamp_t payload_timestamp,
+				    struct strbuf *payload_signer,
+				    const char *signature, size_t signature_size);
 static int verify_ssh_signed_buffer(struct signature_check *sigc,
 				    struct gpg_format *fmt, const char *payload,
-				    size_t payload_size, const char *signature,
-				    size_t signature_size);
+				    size_t payload_size, timestamp_t payload_timestamp,
+				    struct strbuf *payload_signer,
+				    const char *signature, size_t signature_size);
 static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
 			   const char *signing_key);
 static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
@@ -315,8 +318,9 @@ static void parse_gpg_output(struct signature_check *sigc)
 
 static int verify_gpg_signed_buffer(struct signature_check *sigc,
 				    struct gpg_format *fmt, const char *payload,
-				    size_t payload_size, const char *signature,
-				    size_t signature_size)
+				    size_t payload_size, timestamp_t payload_timestamp,
+				    struct strbuf *payload_signer,
+				    const char *signature, size_t signature_size)
 {
 	struct child_process gpg = CHILD_PROCESS_INIT;
 	struct tempfile *temp;
@@ -421,8 +425,9 @@ static void parse_ssh_output(struct signature_check *sigc)
 
 static int verify_ssh_signed_buffer(struct signature_check *sigc,
 				    struct gpg_format *fmt, const char *payload,
-				    size_t payload_size, const char *signature,
-				    size_t signature_size)
+				    size_t payload_size, timestamp_t payload_timestamp,
+				    struct strbuf *payload_signer,
+				    const char *signature, size_t signature_size)
 {
 	struct child_process ssh_keygen = CHILD_PROCESS_INIT;
 	struct tempfile *buffer_file;
@@ -556,8 +561,9 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 	return ret;
 }
 
-int check_signature(const char *payload, size_t plen, const char *signature,
-	size_t slen, struct signature_check *sigc)
+int check_signature(const char *payload, size_t plen, timestamp_t payload_timestamp,
+		    struct strbuf *payload_signer, const char *signature,
+		    size_t slen, struct signature_check *sigc)
 {
 	struct gpg_format *fmt;
 	int status;
@@ -569,8 +575,9 @@ int check_signature(const char *payload, size_t plen, const char *signature,
 	if (!fmt)
 		die(_("bad/incompatible signature '%s'"), signature);
 
-	status = fmt->verify_signed_buffer(sigc, fmt, payload, plen, signature,
-					   slen);
+	status = fmt->verify_signed_buffer(sigc, fmt, payload, plen,
+					   payload_timestamp, payload_signer,
+					   signature, slen);
 
 	if (status && !sigc->output)
 		return !!status;
diff --git a/gpg-interface.h b/gpg-interface.h
index beefacbb1e..a326845be8 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -71,6 +71,7 @@ const char *get_signing_key(void);
  */
 const char *get_signing_key_id(void);
 int check_signature(const char *payload, size_t plen,
+		    timestamp_t payload_timestamp, struct strbuf *payload_signer,
 		    const char *signature, size_t slen,
 		    struct signature_check *sigc);
 void print_signature_buffer(const struct signature_check *sigc,
diff --git a/log-tree.c b/log-tree.c
index 644893fd8c..3c3aec5c40 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -513,7 +513,7 @@ static void show_signature(struct rev_info *opt, struct commit *commit)
 	if (parse_signed_commit(commit, &payload, &signature, the_hash_algo) <= 0)
 		goto out;
 
-	status = check_signature(payload.buf, payload.len, signature.buf,
+	status = check_signature(payload.buf, payload.len, 0, NULL, signature.buf,
 				 signature.len, &sigc);
 	if (status && !sigc.output)
 		show_sig_lines(opt, status, "No signature\n");
@@ -583,7 +583,7 @@ static int show_one_mergetag(struct commit *commit,
 	status = -1;
 	if (parse_signature(extra->value, extra->len, &payload, &signature)) {
 		/* could have a good signature */
-		status = check_signature(payload.buf, payload.len,
+		status = check_signature(payload.buf, payload.len, 0, NULL,
 					 signature.buf, signature.len, &sigc);
 		if (sigc.output)
 			strbuf_addstr(&verify_message, sigc.output);
diff --git a/tag.c b/tag.c
index 3e18a41841..3459a0867c 100644
--- a/tag.c
+++ b/tag.c
@@ -25,7 +25,7 @@ static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 		return error("no signature found");
 	}
 
-	ret = check_signature(payload.buf, payload.len, signature.buf,
+	ret = check_signature(payload.buf, payload.len, 0, NULL, signature.buf,
 				signature.len, &sigc);
 
 	if (!(flags & GPG_VERIFY_OMIT_STATUS))
-- 
2.31.1

