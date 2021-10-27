Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3E4C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E662E610E5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240739AbhJ0IIy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 04:08:54 -0400
Received: from mail-vi1eur05hn2227.outbound.protection.outlook.com ([52.100.175.227]:54730
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239264AbhJ0IIu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 04:08:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDdSt7c3IkWixfQdr8iaueZ8RFo8UxCqsgnrcpxlPEnycisW+N6UsvM9SifOVpGk88KP2ntVTBB3d+23CYTe1QnA9VqJ0ZSe+qmoBDAZH2tYm7xbItayXYVM/V0aQwOtLyzKBJor3v+DVeCPjZZEtUMQMgp9tJuH3lYzrAqk4k/bdjnZN4CA6VZRHNb1aMXxeMjaX6N8gkJ+klXGQc1vy2kOg1534tEibbJpqV24D0n6Vye8q6PFWhtn9DYx/HShDThYPQ6Le/XbZrCwFMxmWga7M/CJjTYnznvmAzUvBanl6yMVwEYbISlKc/L402YEjaEGlV2COI5eOWNqo5CRGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76KUjybAScNXzhqqXR1V6ioi4Ig+IMpZPYIh6R0YgUs=;
 b=RajIvhqpQDzoGM1zdZIfa4Gdm8Vyz0Uz9JfXCoQAll8cxhkrP5Tr+njenbt1uewQugygZplW3Pc0tSiGXxhqiswAwg5NnV5FlgcV3rba1ffXgOnnDc09H+juRj7Rov2R0ipy4ZhTluqDGO0lpF+1+sHLt8lfW6mxwkorT6eZXyxJOHxuZM2dAcNGy1KxzlzyoMtVFwymqaeB8wL/lqmmjB5lzHcMdVrr6G0Lz92r1HO280RSKMY5+cUKglgdJ6J8DR+0lJkxqDxAbpdmn/nmemE69sfrOAdzOYQQoLdaZnASg01nuFMpz8tpJfGXZhavE9nfSDJO/f5+4PrAwAdMhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76KUjybAScNXzhqqXR1V6ioi4Ig+IMpZPYIh6R0YgUs=;
 b=F+3HQmkAOTBevM+IExDt8H/bS1ezGXKEvLHORQnae9fGB4Le4ZsDRTs+i/9B3Cjx0kyuLY8l9EFEYareovbs4zUW+8vkBL016aCPfoY2848ZMFxi7R7+a084kZh8mEHWF2LsixDp6H8O5HdPqwxlk5sBvZZoVSr7cTVqUkNqNi4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4270.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Wed, 27 Oct
 2021 08:06:22 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 08:06:22 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/6] ssh signing: make verify-commit consider key lifetime
Date:   Wed, 27 Oct 2021 10:06:13 +0200
Message-Id: <20211027080616.619956-4-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027080616.619956-1-fs@gigacodes.de>
References: <20211027080616.619956-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR1001CA0013.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:2::26) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM5PR1001CA0013.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:2::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.22 via Frontend Transport; Wed, 27 Oct 2021 08:06:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7e56dad-9451-4467-8598-08d99920aa71
X-MS-TrafficTypeDiagnostic: PR3PR10MB4270:
X-Microsoft-Antispam-PRVS: <PR3PR10MB42704C31403A67B2861F5429B6859@PR3PR10MB4270.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IR1qxYYbcaZQtTqxsH8yCv9sduyvfx27AK9cZxeB2DqveR9+ij3A+BBTdkzL?=
 =?us-ascii?Q?g3Ge8/45qCv4cpu6z0rzNLO+7ffCFUnkU2z38MIxgwL861bumLMRqLRWrX6Z?=
 =?us-ascii?Q?p5TyfaIbF0JUCmLP/W3IiRIm4yxu+seobkIK+oGawAxCP+2lJgTMXnmGdYBa?=
 =?us-ascii?Q?cDd5qSDbhMxga3iKWMAD9iyytLByCFYxEvx8+QLTJCgIKYywUb1AR+nDBCVd?=
 =?us-ascii?Q?UdJu9n1wsFhQ1tpA4XvfCho2Ie8hNEu8FRbhqXlCAsKoqdOK8P4GRmH5repC?=
 =?us-ascii?Q?PhmjpInB456qxbQyndSGXHPxpBc7dasRdkIZ+MGSmggtghHg+WkE9hVXYu8P?=
 =?us-ascii?Q?xrsxDDie7Nq1dRuGBc1JIEAXl98+uOYI7+vIa80QVakRVBzR69uJSZPAeysB?=
 =?us-ascii?Q?1KLrz1NAjH4OFzsSBT4+QTSKbFjVmMeUieHZ/Nx/3Ens2t9UAa7hGPcBXthy?=
 =?us-ascii?Q?qgFUQHnU3l0uTNQKTaW7+z7YC7O60dkit7e0bWaNquWmiUY9QCF3Vfn3ZWh8?=
 =?us-ascii?Q?Pf9vqQvsY8G2XrNEHbCMN7HClp0tJj7J4gXvMuA+nzcGiBf+TxHdkjX6k+SH?=
 =?us-ascii?Q?W2YHZXdgquzJ1F+TQtR1GRpaRuqPOt3vZnFs+y5IidlsWjPqvRgAR94vVyp7?=
 =?us-ascii?Q?pVw2BW7vRCiPo4XH2Ru4HRfDs54j6RObsEAICb1MryX5LkDwcM7ohvYpfrpn?=
 =?us-ascii?Q?FhVavZ1PpQ7sjKMu91+wc/J7BIRQqgz6pbaSI9cUHIEC2FyIgzKxS5mpxX5R?=
 =?us-ascii?Q?ez26P2rpWY20FSmffmo2/Lt+eDkR9uuBfd/CpIEd9fXeTnTEPf0gvg+UuHkA?=
 =?us-ascii?Q?EdGzz8tFr9RoD8MDySzUAJsKcK46w9v6IY0B/AM/MKBZ6NlNaDPV2AeQwdT8?=
 =?us-ascii?Q?QYD5UDoaUGec6Rl/tgZzFSJXyW1B3zcMJh33ZdjsOKtOVYMiwINTTFC5e0BL?=
 =?us-ascii?Q?P4LupfvlQvV65Xk7/NRMwxrHok5eqQ0RJx0bpO5txrR/Szwsztw3Sabt8weD?=
 =?us-ascii?Q?YG/wDLDVJNicNDDPEc9CVEH+fQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(376002)(346002)(136003)(366004)(39840400004)(396003)(4326008)(52116002)(8676002)(1076003)(508600001)(8936002)(6496006)(54906003)(6486002)(316002)(6916009)(36756003)(66556008)(86362001)(2906002)(2616005)(5660300002)(66476007)(83380400001)(66946007)(6666004)(186003)(15650500001)(38100700002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6PlPtsXthqLfL8cE67ctX2td/70jG57lmdlSykENunSEaaOaONG1xgclRDgq?=
 =?us-ascii?Q?/alAsmftvucj9ItEI+/mtEBiLLJyFz0zLxO+qWN+wFA5Vum1NcK51V3NS4SO?=
 =?us-ascii?Q?qLZ3wGNJuUsVH75Rp3d0WnbjdWElFpXH0LPXArzbXgNF0qt+BX75+nbWOPMP?=
 =?us-ascii?Q?YTE7NdqXLC+xG+LemV5NNMHcIeDTW0VwttNRKO8B3kbcMbpYayqUSoSiiobG?=
 =?us-ascii?Q?+EzrSXiztWtDOohKXQ5ZHJoFW9592nj4ALbSAH3GDgL25EgZMNARb6bAfCpl?=
 =?us-ascii?Q?spjEzA3+0M0XTi6jBCdZ/E6Y7LUjHQ1fbQCmQZEWMmTvgsWSk02zVP4yNP4u?=
 =?us-ascii?Q?kk71UZa9VACJp3H7qwreK9LveZF6EM2vpekBbwwe4Nc4UmY/7uXfp0oCJZKX?=
 =?us-ascii?Q?acdsZn/yoSBG9evOLA6zpmeqO5l/6l1N9IBDREi/quiTr7DmWq/YaP9yjJno?=
 =?us-ascii?Q?DYgiubfIF7tHFAOwb87lqQx5bwsInmHBx14lNu+SFrPLl4x52sG0zM/sONVS?=
 =?us-ascii?Q?pw6LoCj3Vo/4prVOXYAW8s9/swdx5BBtvdXpHKQoh6Cu8ixUIPfHxrVXm94P?=
 =?us-ascii?Q?UXSQwcUfm8LRi8eqrL9AOY/CBqKeR9mmO0lRSOSuj8Z+awc0utB3wcl15jPv?=
 =?us-ascii?Q?KdvOiM0d3yf/8aUJtB+jXg1TnscVkXZ5Vz47Js4wjlq/Y8Lm6Hhjo8Gq00ov?=
 =?us-ascii?Q?lBHBiyHKKvV86gtYuLvlkNF2FSN6bzL+WbmKcGIxP/KTJd3XrVZfcLi+r9wx?=
 =?us-ascii?Q?/2/vvDBWE8EJVguNt8LrDIml7NgFEraGL78wK3i2ULWZoC7fxofSoiz2nKIC?=
 =?us-ascii?Q?jtYj0Ja9bp6/udmiBXV9IGA2L90V4N0IPNQqH1z4RthxSvejjOElZiJ4gbzr?=
 =?us-ascii?Q?MkHfIyfoTuycos5jbhnFCKDhyv2Q248S2wkuJELXGQlawzwX9Ua/Y39Mutcy?=
 =?us-ascii?Q?1tDlK0zMyK8Xf9RLpHY4++MAs2gxuUJCuREJhaIQub3CNuD+UQ6FOxfcsEQQ?=
 =?us-ascii?Q?rul0lZxG0JPpHOWx9HoDCxAeAOk5dWb+MwJLAwFvQHPD/sQvZ49hhfF4aCl4?=
 =?us-ascii?Q?hQBUnBaafQtxQ/Ue9C1yT4B/dsP4b68nkp1UsaFLkBsyk45E8hLR0FiF8WV8?=
 =?us-ascii?Q?RjnwkHeu98I8DFqWJwqWWXRMh5HO1HrzyVcJafJJUKDSz/1T5J3GUnoV7cKx?=
 =?us-ascii?Q?nC4iSkGafb7FzQT0qC82D3GxAE/jy3RrY8dcfkbEFwQENSLiOtEFAD16Zz3q?=
 =?us-ascii?Q?yr9O4B1dSPszvWoO48x9HbaxuDrFIdKpSWRvoWKN5to+yRWB5l/1GKHiJV8n?=
 =?us-ascii?Q?VpVUGXxRfVoxxvKdOpCb8v1vt4jidmmy2JrwziQJ5PSD2trfXitlXqXLq7Bm?=
 =?us-ascii?Q?uWs3rN8X6HEg0MQFPZ8qsPzVU+D95sG4xlLSSB2lLJnlnchrxa4D03dczS7O?=
 =?us-ascii?Q?r1IDMDBfjUr8HmwYRfUe9RCEJyJYgnJwrnXugBYAilKU99XmpC9Yfj7Op9BD?=
 =?us-ascii?Q?5jNIgSpchUXLCyoZWBkCOTB4/sySONSANPsCzLutYT1PvUBfp5riVH89O+os?=
 =?us-ascii?Q?G5mftk+vLDLGSxKX3gG31pZ8UaMROkmUE5DOJIBBzsyq810duuh8EfWmpxHG?=
 =?us-ascii?Q?aYrUNeE5hQHc2BcxeMiiBju0jONZwsfVH4p5PjJR36YIvrYngN/8ZhwA3NfO?=
 =?us-ascii?Q?+4tBBIAGVYTlPIJTIN2vA7MwBeaKod/jMKt4h7pIQJvSRCGSscnVBsOPOYDI?=
 =?us-ascii?Q?cYjlPzVW0ojNaAUzKIMWSqqNbmlkqIw=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e56dad-9451-4467-8598-08d99920aa71
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 08:06:22.8838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZRjR/FMWE9pglN90+yY3J9Uekd24kKwNiaqBnsEMYS1fuOvU4Vkv36/+OaWwGENfgicRWa+uKg040F290N48HA3wuilmPTEsLr5R55IKyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4270
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
 gpg-interface.c              | 50 ++++++++++++++++++++++++++++++++++++
 gpg-interface.h              |  9 +++++++
 t/t7528-signed-commit-ssh.sh | 42 ++++++++++++++++++++++++++++++
 5 files changed, 107 insertions(+)

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
index 760cf136db..bb2d5b2c67 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -437,6 +437,13 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
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
@@ -454,11 +461,16 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
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
@@ -476,6 +488,7 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 			     "-Y", "check-novalidate",
 			     "-n", "git",
 			     "-s", buffer_file->filename.buf,
+			     verify_time.buf,
 			     NULL);
 		pipe_command(&ssh_keygen, sigc->payload, sigc->payload_len,
 				   &ssh_keygen_out, 0, &ssh_keygen_err, 0);
@@ -510,6 +523,7 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 				     "-f", ssh_allowed_signers,
 				     "-I", principal,
 				     "-s", buffer_file->filename.buf,
+				     verify_time.buf,
 				     NULL);
 
 			if (ssh_revocation_file) {
@@ -554,10 +568,43 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
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
+	switch(sigc->payload_type) {
+		case SIGNATURE_PAYLOAD_COMMIT:
+			signer_header = "committer";
+			break;
+		case SIGNATURE_PAYLOAD_TAG:
+			signer_header = "tagger";
+			break;
+		default:
+			/* Ignore unknown payload types */
+			return 0;
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
@@ -571,6 +618,9 @@ int check_signature(struct signature_check *sigc,
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

