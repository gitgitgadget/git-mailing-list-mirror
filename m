Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7943C433FE
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 13:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 853CB6115C
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 13:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239309AbhJONRY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 09:17:24 -0400
Received: from mail-cy1gcc01bn2023.outbound.protection.outlook.com ([52.100.19.23]:25729
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232649AbhJONRV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 09:17:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeZ7GAgOtUrvMitJSmpzk5afbKrL9/5egdAn72OU92/tnJxWfcis3g7RVCsPiSgV+wbUEaoQkcDhbdaqa6DtcVr2N6mZZFwqv6GphnyP7rAeX7/bDJcaRA03xfqi9+DFl8JBgMdTBPVcLrCJhk5iMeWCTlUNDVeLtFx5mhIiE3Du00Ef4BPuM+v9kw9Szu1pZFeZ1UOzBff7cZL5wQU9tVTCBywlGfxxhM3AXQlszij6NIO6rFFsfhOIS5Zkx3AlQuFyItufd/+mlxgatt2jbMUrFoA6XsavvwzOukzcK9PWv2GG5VHF6fRYM5INGedKpX9OBqFZk7PEPHBmwNAYfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssXhVRcpSKPj5TR+8o5qUGuLApMyE9s3EV5qN/GnlNU=;
 b=n1lr4XzmpztDqmnYNdzqn5xkq2GKRJfSsdNQVpjC7wsb4qxQPjYWQaqqQVPDEU8dGkFzwO5BzlncfY4NWk8tQNlW565QzijW3C4KCJEXCtV1tp69E2yaBRO4pvUPWPQcxoCqih8Zr2MRFXAqXVVjnGvaUkLGAJoqqLerRUBhRLWmCeq5vr0LQ7zlonFCy6y//2RO5ACpxnTV08OkML+Uh3VsPsvXY+/XiryJ5p34SaYv/TL8gefCzc4CvrsOme3VoT3f4YoLad+dna5QAC1KGTn/ZmcM5i3UPin8lCRKV4c1DhyEXOFJQPTvL82evlWGycuIhWQvD0qIePJXLdb8rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssXhVRcpSKPj5TR+8o5qUGuLApMyE9s3EV5qN/GnlNU=;
 b=EF/2Sxn2iuaCgDgDQ9iCxeJLPdlwZHUH3DqGrLlJN5jJXRu8QLvt6BFIPeGNQzN88k35AbscXY+6N1EIRIXWGOyq+VO6Kj7H/fjQXTp73Rn62349XnKPL3IEnGA3nfhDUkL9y13Lw8eea/rOSHq3qYskSQUusVmozHE8Mkkl3AA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4046.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 13:15:11 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4587.026; Fri, 15 Oct 2021
 13:15:11 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>
Subject: [RFC PATCH 3/6] ssh signing: verify-commit/check_signature with commit date
Date:   Fri, 15 Oct 2021 15:15:04 +0200
Message-Id: <20211015131507.1773153-4-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211015131507.1773153-1-fs@gigacodes.de>
References: <20211015131507.1773153-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0170.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::25) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS8PR04CA0170.eurprd04.prod.outlook.com (2603:10a6:20b:331::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 13:15:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2346f4c8-120c-43a2-cec3-08d98fddd195
X-MS-TrafficTypeDiagnostic: PR3PR10MB4046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PR3PR10MB404632D4B53CB14BD2D9DEF8B6B99@PR3PR10MB4046.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cn88iUEPut/aFu7miZeBE2h1GYuh8L+MGdAZRbjYbyms/gkHcm6pSSDxXxjy?=
 =?us-ascii?Q?hUXx8zRNhWpyPU0QLdRcPVHFNdxT8VO61ighlfhAmXeTyEDXJUYXwBWJlnP1?=
 =?us-ascii?Q?auLFnn8t6p4XBgOueNA3BiLOUXuXIH9sXrXXP8QZh/TjDmYxZSnFFIhuwhQP?=
 =?us-ascii?Q?VzDIgwdoHRZgwBFPHhHlIzAT/jnC1czizKqyoMzjBI+9q1lEJ6Yh9LqSgFJ0?=
 =?us-ascii?Q?vDkcxPvj3+K6t7WPOyHp3Weu6njzN+sQ22lElD1ByYOGtFOJNvcnjSqPjyRE?=
 =?us-ascii?Q?KhhWsNa82OT+yP/aw1qSVBhMr8w1M5f8/Aoy0ZdGxHOVUhWqekFvrehGT1NB?=
 =?us-ascii?Q?66OSOpOjQkKXimV3ws0ulTeL5EKWG7tZ++nRQX+pXSGUDjaPF9MFmiTiPpQ9?=
 =?us-ascii?Q?xcgw788dWPW6MXEO7N3ZELfELzfWNqlfDPGYfAr2cf2X/im6cimdWQYo4ERT?=
 =?us-ascii?Q?V7K8Ih/dPupI5ts9KeVMRgntmjadwXWWx2pLrdD2w4U8kaUdkiLbXAuLEyHm?=
 =?us-ascii?Q?EOOWj/T3MK3MRjQKY3LZoTLEgZz7GcDwXu5gW0zLimABUmkX4bhxR4YKlpJy?=
 =?us-ascii?Q?0K2fIfDM7uqI2auFiQhz5JOXEUQyqXtsH4dJJHz9RzqtbUt3u8w+axssNua2?=
 =?us-ascii?Q?ELLkWr3j1CyI/TL+WgLhrnIY/s8nmuAzXGUQyNPM5MrR/ya6fD1EwpNZHRga?=
 =?us-ascii?Q?ShVF0LAPFbBvUfcBqn4i2VKTAKpL64HSZyH79/mxhEoKBedXhaqZGke7qSQs?=
 =?us-ascii?Q?hMvjxiDCxBoFeOpszqt9WeRMyOmJcDRfpZpgRp3qW0wad1cvgk7mOw3dM5ov?=
 =?us-ascii?Q?jLI+1HCWKkG4PNu+4082LoM0U/114SLfr264O9FlgI5TaCgiRfiYjMrnrjA8?=
 =?us-ascii?Q?o5MPdA6iC6C5hSE5zVJSXHzxkwt1qLIMsAmAbydN/Mha4MRByyLBTMp2n0UC?=
 =?us-ascii?Q?e+F2WTmZJrUHVPDa9qQlxRPZPaAl7PzJ1K750CJo61E8FyvXn56a7Ndxe3cB?=
 =?us-ascii?Q?o6YNtGHtYrAoKkcV4zEaVREFaw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(366004)(136003)(376002)(39840400004)(396003)(346002)(107886003)(36756003)(2906002)(1076003)(83380400001)(6916009)(316002)(4326008)(38100700002)(6496006)(8676002)(2616005)(5660300002)(66556008)(66476007)(66946007)(15650500001)(86362001)(8936002)(186003)(52116002)(6666004)(508600001)(6486002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zaPhdVwjoSZJPuhxaXbnRq6W1FGCiIAzYsx9qVRfezF+CNQcqfwLSfjUAifk?=
 =?us-ascii?Q?PBj86zW77GxAG9IA9slFwSJ+3bjYLbbQWIk12ih9VDl2SeLekWu14Yb4ZQir?=
 =?us-ascii?Q?cnhkGjr6mlLjwWhffj2z4BP2r+f8v8JKmWoGsdrxBSY0KwAlp0Av0zQ5X1Eo?=
 =?us-ascii?Q?nU6xDpK+n98lX7GuY7OEaKmX4dvx/uw3oHWSbanwBBHRlN5WxdN73SWEV3bs?=
 =?us-ascii?Q?Uh9Csao+XnFIOomaUKvkAgBtk4VF50mtyI1FxiQBhmjtoS7ZZJwPBzDKAghn?=
 =?us-ascii?Q?tW6gLNvVRwOFFnxz54Dz5yrc7+y2t+j9fqxkNz30m1dRq2UuMSuGzNw6LBnD?=
 =?us-ascii?Q?7EvSrwvZ5fwS8Xkpf1vOO3nOfqeBTNYoxV+6pS1p/sIV2eMWuPhVua5kZ6Kc?=
 =?us-ascii?Q?Ba4Uv7/+Wfp6VcjBRwJLKm24LF9WxzhP4KjLOXMM4dOhyk6Ln1iBHZGtD4/t?=
 =?us-ascii?Q?fRTSwB8jvYjzaNqnkrIk/UlF+f+tI2JR0aiDOHBNV7BIwWVWKg8exnjkYqvl?=
 =?us-ascii?Q?KwvDfDr8536kJ4V8auv5EjGm+Weah5SZtWKeFMdN6yah/dl3GEgXGgIzqGlb?=
 =?us-ascii?Q?0LmrB+/WJx58M5wEYZ+VkHrvC7C88/RC/2bL7z3FVqXLaWjz2gnPa0m7pWVp?=
 =?us-ascii?Q?2DrhMqmdwPmGDRWUg53PKo7rdEKjz/KYBlGuWjjpUzgDRo1v9Sf4sMW9ChmR?=
 =?us-ascii?Q?qTxVubseHuAGIYTZvJ5V7vHB92MRN1IFOvOuxmbvR45K2rMVqqG7ebYZ44Zt?=
 =?us-ascii?Q?TRbdq8h6aiuMDBe6cVVqrUmplhTBAum4QWr0bGRfSFIa+VTmGiVD6rw4+oYP?=
 =?us-ascii?Q?QlOWEjkWn2Bc11CC9nZa3dHD+4kgvKq3yvvhidAtu2pJZPuhSpfSjLsMWcJD?=
 =?us-ascii?Q?CfLOI6U6xxR7yEeZZ97B/+REyZXvcZ1b5y68sF0KrKxDJoZr43hzNukXe7D/?=
 =?us-ascii?Q?iOZ5PhMi807/HIav79Ij0Nmwtf80SmEq7Yj3fKcmWvyKZZ3NhBu1J/uiuNyw?=
 =?us-ascii?Q?Q84WNs6PeorVTXc00Ey46IT0GseGjGmdtmro0N1gGfvzzsPZvv3sTgP8cbHt?=
 =?us-ascii?Q?PCHJhRH3V+UmA9G9CGmUCOlUt6xrpwxZdHcOvzZ1NZszObYC07GI+H2CpQf3?=
 =?us-ascii?Q?3OsEp0q2ZAOUTjHUVU1DkRj+2bUxJ1ecNIFz+l/aVpZYoMOzg3/VpnRtZ1bN?=
 =?us-ascii?Q?5O+Yptps4hniB6KcJLJd5gMZIoD5QQEuaufecvUndYtNGe0WzaZlNxmgUQlI?=
 =?us-ascii?Q?N2snalrSVYqSPzzz6XSS9/ZjIcr/9VrSBCfkkWVih9FC+46+PCfp4foAUbmT?=
 =?us-ascii?Q?FQOWu20eGZTvm/pKwKoCZzsw6YuvSG9vcmRWiruknyPpbvW924HlFtC/Xz3W?=
 =?us-ascii?Q?1o21TGXA5ACYTahuz/VTcqsaWHoe?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2346f4c8-120c-43a2-cec3-08d98fddd195
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 13:15:11.7302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IShiBrL2Z8wN0H4Ztjcm/vTToaVri9Ial9JJtp0QC2wR/6i5kRqO3wlE4cIMWQxlQZXRIS+TpkoLkGmCq60EG1/bNDdZ8KqCx4i5tuohMKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4046
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
 Documentation/config/gpg.txt |  5 ++++
 commit.c                     | 12 ++++++++--
 gpg-interface.c              | 45 ++++++++++++++++++++++++++++++++++++
 gpg-interface.h              |  8 +++++++
 t/t7528-signed-commit-ssh.sh | 42 +++++++++++++++++++++++++++++++++
 5 files changed, 110 insertions(+), 2 deletions(-)

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
index 1704d9df0a..f70b233e00 100644
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
+			      &payload_signer, signature.buf,
+			      signature.len, sigc);
 
  out:
 	strbuf_release(&payload);
 	strbuf_release(&signature);
+	strbuf_release(&payload_signer);
 
 	return ret;
 }
diff --git a/gpg-interface.c b/gpg-interface.c
index 5960202615..a51d8e361c 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -439,6 +439,13 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
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
@@ -456,18 +463,27 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 		return -1;
 	}
 
+	if (payload_timestamp != 0) {
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
+
 	ret = pipe_command(&ssh_keygen, NULL, 0, &ssh_principals_out, 0,
 			   &ssh_principals_err, 0);
+
 	if (ret && strstr(ssh_principals_err.buf, "usage:")) {
 		error(_("ssh-keygen -Y find-principals/verify is needed for ssh signature verification (available in openssh version 8.2p1+)"));
 		goto out;
 	}
+
 	if (ret || !ssh_principals_out.len) {
 		/*
 		 * We did not find a matching principal in the allowedSigners
@@ -478,7 +494,9 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 			     "-Y", "check-novalidate",
 			     "-n", "git",
 			     "-s", buffer_file->filename.buf,
+			     verify_time.buf,
 			     NULL);
+
 		pipe_command(&ssh_keygen, payload, payload_size,
 				   &ssh_keygen_out, 0, &ssh_keygen_err, 0);
 
@@ -512,6 +530,7 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 				     "-f", ssh_allowed_signers,
 				     "-I", principal,
 				     "-s", buffer_file->filename.buf,
+				     verify_time.buf,
 				     NULL);
 
 			if (ssh_revocation_file) {
@@ -557,10 +576,36 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
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
+			if (payload_timestamp && ident.date_begin && ident.date_end)
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
 int check_signature(const char *payload, size_t plen, timestamp_t payload_timestamp,
 		    struct strbuf *payload_signer, const char *signature,
 		    size_t slen, struct signature_check *sigc)
diff --git a/gpg-interface.h b/gpg-interface.h
index a326845be8..27a34d06e8 100644
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

