Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB466C433FE
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B56A619E5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbhKQJiz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 04:38:55 -0500
Received: from mail-db5eur01hn2234.outbound.protection.outlook.com ([52.100.6.234]:20915
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231797AbhKQJiw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 04:38:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+Esp851Yajcf7sN1+4wrOxRKoMcfmGiXZBu2NZ++WDE3IOoKF+eXKzqAKE7mWj6xtIo60D0YpeHoWhYtzlLwv/M6gOs91Um2eE8iMY9P7050dhxR/I+7NBKuhedaOHUgfqe0GwAiQgRXn7BQ8oOvz6f0ZNipx8SGLGHV3HTseBxOu5ZMPI6GR5FcKzWsOVhjmHmf2nUX/FNWS3Uryn+QvGALrF8eYMcIglq2IvdEiDoKQA6oONLIUwwNzDxrNwuV9OXMAaPNgfEjg8IXEKDJHFuKRISlu9SXme2ASuIAYQRjZhRscu00zV3S+7fthEzHv9U06W51aGRVpfdD1wU0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRZHm4oyw3rcqEpk5Et3zIGO7W3mYBS0JOU6Fk/tIkE=;
 b=hPY3WXxYq93dQGjEVu0BfY9l+EEUzy6/4drApDOttG5tI6v1k3SXAHh6hfs0GjM+NQC5UG0y8zoBiY87LD2hlju7HL5pTYCPCoYlR18CQKi9X8VHhQIaMAcLdLHne9Ia1kAbrH4UFPW025MVJ9yrJ8ONoabdScWsMQQC/iFiKMBXskxWGfvL81r4ehkpfaqi/K7YW6UnJFu6HezooyKQC7lmuzuVfrnkgHvrxnAISAeK7GVaGYNaFE/motgAC5CN3hQ7h3hn/DOadteHTU/5pGpNyW/eEeNIiRLGwS8pO2q0ip9DwQR4hr6Y14JkDRn2glepQcxgh28sHKgbwPo4Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRZHm4oyw3rcqEpk5Et3zIGO7W3mYBS0JOU6Fk/tIkE=;
 b=FVe4yZmYGMgSFuZTHfhYGDVt7Du0JTh2hm4V78iQpvxBkje/xxIUtGoKyZ2xpviX/fY1KargK1Ow7i5wzuAcWVyrl8cbKDYkyabhW3Zxbxwaatj6Jxm82h2ezgPIlkzCBo3b1dU4gLQjCLn+ng29GrxZQe3PZ9Q6LBOmnULzcb0=
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
 09:35:47 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v3 3/7] ssh signing: make verify-commit consider key lifetime
Date:   Wed, 17 Nov 2021 10:35:25 +0100
Message-Id: <20211117093529.13953-4-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211117093529.13953-1-fs@gigacodes.de>
References: <xmqqsfwmus5g.fsf@gitster.g>
 <20211117093529.13953-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR0301CA0040.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::26) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS9PR0301CA0040.eurprd03.prod.outlook.com (2603:10a6:20b:469::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Wed, 17 Nov 2021 09:35:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32566ba6-076c-4ea6-d40d-08d9a9ada2ee
X-MS-TrafficTypeDiagnostic: PR3PR10MB3820:
X-Microsoft-Antispam-PRVS: <PR3PR10MB382058BD755C2E5B27F88F54B69A9@PR3PR10MB3820.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?azgZnyaFtzd6qT7u0nys9wCFMo1bOuBxeDq3CgdjyqF3DQhRDE/Yv7WTI3TQ?=
 =?us-ascii?Q?DNrxGLrJv0MOnnAVF8Mfe1POWkolT0MkGyslBkSITjndQLhd5g6gyJHZkVjp?=
 =?us-ascii?Q?CdAXXTnYAECG/r9lktjIUrVQMQH4F4TrDEMmb0q/LFGzyfOmvARnqVayyQRv?=
 =?us-ascii?Q?FfMuOMlo0eItTpE4jXRqYijkYN8ei0CNkFfQXaaQTTj2wMKf82G19xOqciCq?=
 =?us-ascii?Q?MMlZS4VnzkhjjajqMg7wMojSzcDZgAVJhvm0ET8+RjiQUX32tfb9LcoojptV?=
 =?us-ascii?Q?swM2OIiwG2awGtwAPpptHRZlZ3pFUC3ZcHKDbyNdEWvuQzYHGuCXs83kazSn?=
 =?us-ascii?Q?7RKdGVy6djkm9yf1XYpIveDwxUmTxDj0ak8ezJVdVTchMRs7x+6LkQ8ST2nI?=
 =?us-ascii?Q?mwjz6BofkDNPM+T0tgb7xhFDkuBl5fo6L9yTMFk8LAaYOZLHLmG72xLbt+Cb?=
 =?us-ascii?Q?w2QvvFF36QFxFia1mmJlK8xnle8I0mubN096+CVDPVogsrm/go8Y0Hx0S3tY?=
 =?us-ascii?Q?VJDH+peBTx9tYFUhRvMOf+5hi2By0qkg7Vg4yCNE/O1YnxZJ4fFMid1m5/im?=
 =?us-ascii?Q?PJag3xVfVb+rT3L6bF3yTuId2E0T3ud03hEBZxEnKIPcxgPfCmUtFL/ue9hk?=
 =?us-ascii?Q?nYK+1b/09CAkFaBZGa9N6v9oqtxDrS4ZB188ZnAtZ7+aMrErpL5d5B/jix3o?=
 =?us-ascii?Q?vNBVmWojt8cRR3x9fg9B5W8KPoONtm1h8kVX2zHObGXR1dinMAF40lVMpeDH?=
 =?us-ascii?Q?uMqhcOr9XzBvJHuDzmM9cwizTlXRAT9omcMZC+XpbJ+RwOsYacWDpjPLvae9?=
 =?us-ascii?Q?cOJYPKtRlJ8+VmSSXBAVc7ri3D+UsYLrhq4BSGr2Us8SxPZwDIDKzJMakrFM?=
 =?us-ascii?Q?pZrXWZD7ozte3dCrt3MfkB8sFFHtbE2mLQspOQ/xtXYQzz5oRluxXX6MDzl8?=
 =?us-ascii?Q?4NN7LqszJzAoT/AOlTRYikFqoyOb+aNHuSq4GqpVrLF2DD/ou96tFDaZKAjj?=
 =?us-ascii?Q?u6bxryho7cguLDYksr/dt2Rzcg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(136003)(376002)(346002)(39840400004)(396003)(366004)(66556008)(316002)(8676002)(1076003)(66476007)(66946007)(38100700002)(8936002)(83380400001)(86362001)(5660300002)(36756003)(54906003)(15650500001)(186003)(2906002)(6486002)(2616005)(6666004)(107886003)(6496006)(6916009)(52116002)(4326008)(508600001)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VSyfcOyQXSgJ6ErhlnyYiUYnzDsReEqJkSTdgz1osI49umXNOcCFyegYtkUF?=
 =?us-ascii?Q?22OB1XQ3HePDSRHmT+5xECvsoASYzx9jnnSOaQPhewqNj59JGOgYQj1QXmTz?=
 =?us-ascii?Q?WM2Qxr6Kg4BxdceEXZ+/MCutNsJnvQn8hoJoN18khBXSaijOGRIeiuo7ugYI?=
 =?us-ascii?Q?SznReDcMT8gikAqt40jenkeKH5njFoTecok5I8VUrbAbXJx0i8kiqNZdGPE9?=
 =?us-ascii?Q?lpOSRy37/FRR6nXDfzXmkSlvNi83yCoiaOD9CA1C4R4b0cFnEC1A5ivFJTD4?=
 =?us-ascii?Q?wmQ6JPfCsy+qOqFtTrOKyIaY0z9ajMEcBkRYXSDe/ECnmN0wiUPTrddmyoyf?=
 =?us-ascii?Q?js2EuiVAjn7ondE7Au3BkjIf8QKrIATD560Yb/6fu+VZbXsE1LOjbqmxWVPU?=
 =?us-ascii?Q?S5quZDYsE/0KxOc9IuWvx7eXXglqogs1rAGTQznX7NiO1bB/kwkI2U90EcNC?=
 =?us-ascii?Q?IHANyxKeq5K+JDtw0UVqfmw8VFVlVLJ9WgO7PHY/BjZyB5sEMfzHxLy4tL3s?=
 =?us-ascii?Q?dBfG7XUXvFNvASLNVJrsmDPfB6JZrUxn1120RRWAyp47sQnGi28Z7hQ3IEZf?=
 =?us-ascii?Q?78ozQi06yxHW/U7UfXCpwS9IM9kRPS0KH67Bdp1CZ+mnbJHhmzVtFc4AhjyQ?=
 =?us-ascii?Q?f4ZPEKyUum06rWf9KKoH0vfAYIbw9zqhQEbokEzn3XrKZsuHrjWQ9sgSgaDC?=
 =?us-ascii?Q?O7f/SWxSxAIfZoKLJHNiTSl/b7L1twYFT0RTbh0VonVGeMWPvEbKI4Pum1tb?=
 =?us-ascii?Q?XZp1kMenR/tsnTS2ZFkQ2ntRTRn54olhr1na1KAgcwRtwqG+uIc04ddGZwJV?=
 =?us-ascii?Q?8OBLLpBC8JxjyX1eTQd6U9YpBZC/s/e6RJzQQw95qIqGM6nYmnCijg1mI0fi?=
 =?us-ascii?Q?6G1D/mTA8cn5a+DnXtlY0+6mbOlO+c2t1BmupqXv5yUW2jeh4lbN0krkPmWE?=
 =?us-ascii?Q?yXnsmL92cTrtTT6xzGlwDtQOixB+QI5H2tG2pazIHLkPipVvqVDcDY1gYHVV?=
 =?us-ascii?Q?r+wM9EF0TFDV4KyqRC1FIdfBcJ2wUfO55oh1+eeqqrZZu+JVj00F7zO24vgS?=
 =?us-ascii?Q?wOsaqWE/lZJ6NI4bXUDfMTVrJ/q/fwgQx7/pUWi6G9i097vOvLRPKWY+qycv?=
 =?us-ascii?Q?ezaig9VVwU6HjMCsqZkLK+J8x0tucf6+OojrZXdCQ2gLlTiAPUaImsy/YY+i?=
 =?us-ascii?Q?PAHsuPK5uboIPis5jYIOHMAudUkFIpLaX3PtW/MfGUzu0gdz/yjLHqF7JZzL?=
 =?us-ascii?Q?z/3AqsMA0x6TYJ7+iy0T9e+9A+O0eL+MDvdF4Drhsw2qT/MoJ4F86eu3pLDU?=
 =?us-ascii?Q?yrxNQYFBt3pivXIdpOMkayctnMaoAMWxw6IEqu8yPdfJN1xIIey3THKP35Es?=
 =?us-ascii?Q?pKThqhDuMDid6SrMd5thZCwqUhepllRm5EpBjNk4MgIzm+wMHiPQoDIRBg7b?=
 =?us-ascii?Q?hT5TrYqUd2OZ/8JMwozV4h7eAepDQyuq0LIXVifWX+PbOJkPUzy+NSYTIRz7?=
 =?us-ascii?Q?eHvaIx2QLAiubyBqC96uVm3qCtwM4/OZuiNybeMJzGCv76+bwlHZWRQMpI2d?=
 =?us-ascii?Q?WFuybRRX5U6PWRHu8YTZspkN/btc50x9KFff2fDnqx1ZIUUneMH+9PnoKkRn?=
 =?us-ascii?Q?jZ+XS46crEP7WggHc3vZPaDq6U7wN0nABaRYdJUlqiK8Mt3cbbnpq9zcSFX9?=
 =?us-ascii?Q?IKtKUquBLGBunuHHJEpxYxXmS+VkG9ncnvyqX7xgAbHgzZWNMDwEDfMyn5UD?=
 =?us-ascii?Q?bn5+s25YTmYtBffi3l8WAqoGGYV7+i0=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 32566ba6-076c-4ea6-d40d-08d9a9ada2ee
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 09:35:47.8777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNJ7e9WMZiG7W2O5Stz7h6Jz9L0xmSxuipJO8rjteEcrotUNohEB7Q2y8a3YfcmOWidL2SJ8Gs48VbeZAqIXIN3e8c62rV1+G48SY+tNsGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3820
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If valid-before/after dates are configured for this signatures key in the
allowedSigners file then the verification should check if the key was valid at
the time the commit was made. This allows for graceful key rollover and
revoking keys without invalidating all previous commits.
This feature needs openssh > 8.8. Older ssh-keygen versions will simply
ignore this flag and use the current time.
Strictly speaking this feature is available in 8.7, but since 8.7 has a
bug that makes it unusable in another needed call we require 8.8.

Timestamp information is present on most invocations of check_signature.
However signer ident is not. We will need the signer email / name to be able
to implement "Trust on first use" functionality later.
Since the payload contains all necessary information we can parse it
from there. The caller only needs to provide us some info about the
payload by setting payload_type in the signature_check struct.

 - Add payload_type field & enum and payload_timestamp to struct
   signature_check
 - Populate the timestamp when not already set if we know about the
   payload type
 - Pass -Overify-time={payload_timestamp} in the users timezone to all
   ssh-keygen verification calls
 - Set the payload type when verifying commits
 - Add tests for expired, not yet valid and keys having a commit date
   outside of key validity as well as within

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 Documentation/config/gpg.txt |  5 ++++
 commit.c                     |  1 +
 gpg-interface.c              | 53 ++++++++++++++++++++++++++++++++++++
 gpg-interface.h              |  9 ++++++
 t/t7528-signed-commit-ssh.sh | 42 ++++++++++++++++++++++++++++
 5 files changed, 110 insertions(+)

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
index 64e040a99b..a348f085b2 100644
--- a/commit.c
+++ b/commit.c
@@ -1213,6 +1213,7 @@ int check_commit_signature(const struct commit *commit, struct signature_check *
 	if (parse_signed_commit(commit, &payload, &signature, the_hash_algo) <= 0)
 		goto out;
 
+	sigc->payload_type = SIGNATURE_PAYLOAD_COMMIT;
 	sigc->payload = strbuf_detach(&payload, &sigc->payload_len);
 	ret = check_signature(sigc, signature.buf, signature.len);
 
diff --git a/gpg-interface.c b/gpg-interface.c
index 75ab6faacb..330cfc5845 100644
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
@@ -456,11 +463,16 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 		return -1;
 	}
 
+	if (sigc->payload_timestamp)
+		strbuf_addf(&verify_time, "-Overify-time=%s",
+			show_date(sigc->payload_timestamp, 0, &verify_date_mode));
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
@@ -478,6 +490,7 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 			     "-Y", "check-novalidate",
 			     "-n", "git",
 			     "-s", buffer_file->filename.buf,
+			     verify_time.buf,
 			     NULL);
 		pipe_command(&ssh_keygen, sigc->payload, sigc->payload_len,
 				   &ssh_keygen_out, 0, &ssh_keygen_err, 0);
@@ -512,6 +525,7 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 				     "-f", ssh_allowed_signers,
 				     "-I", principal,
 				     "-s", buffer_file->filename.buf,
+				     verify_time.buf,
 				     NULL);
 
 			if (ssh_revocation_file) {
@@ -556,10 +570,46 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 	strbuf_release(&ssh_principals_err);
 	strbuf_release(&ssh_keygen_out);
 	strbuf_release(&ssh_keygen_err);
+	strbuf_release(&verify_time);
 
 	return ret;
 }
 
+static int parse_payload_metadata(struct signature_check *sigc)
+{
+	const char *ident_line = NULL;
+	size_t ident_len;
+	struct ident_split ident;
+	const char *signer_header;
+
+	switch (sigc->payload_type) {
+	case SIGNATURE_PAYLOAD_COMMIT:
+		signer_header = "committer";
+		break;
+	case SIGNATURE_PAYLOAD_TAG:
+		signer_header = "tagger";
+		break;
+	case SIGNATURE_PAYLOAD_UNDEFINED:
+	case SIGNATURE_PAYLOAD_PUSH_CERT:
+		/* Ignore payloads we don't want to parse */
+		return 0;
+	default:
+		BUG("invalid value for sigc->payload_type");
+	}
+
+	ident_line = find_commit_header(sigc->payload, signer_header, &ident_len);
+	if (!ident_line || !ident_len)
+		return 1;
+
+	if (split_ident_line(&ident, ident_line, ident_len))
+		return 1;
+
+	if (!sigc->payload_timestamp && ident.date_begin && ident.date_end)
+		sigc->payload_timestamp = parse_timestamp(ident.date_begin, NULL, 10);
+
+	return 0;
+}
+
 int check_signature(struct signature_check *sigc,
 		    const char *signature, size_t slen)
 {
@@ -573,6 +623,9 @@ int check_signature(struct signature_check *sigc,
 	if (!fmt)
 		die(_("bad/incompatible signature '%s'"), signature);
 
+	if (parse_payload_metadata(sigc))
+		return 1;
+
 	status = fmt->verify_signed_buffer(sigc, fmt, signature, slen);
 
 	if (status && !sigc->output)
diff --git a/gpg-interface.h b/gpg-interface.h
index 5ee7d8b6b9..b30cbdcd3d 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -15,9 +15,18 @@ enum signature_trust_level {
 	TRUST_ULTIMATE,
 };
 
+enum payload_type {
+	SIGNATURE_PAYLOAD_UNDEFINED,
+	SIGNATURE_PAYLOAD_COMMIT,
+	SIGNATURE_PAYLOAD_TAG,
+	SIGNATURE_PAYLOAD_PUSH_CERT,
+};
+
 struct signature_check {
 	char *payload;
 	size_t payload_len;
+	enum payload_type payload_type;
+	timestamp_t payload_timestamp;
 	char *output;
 	char *gpg_status;
 
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

