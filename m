Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C977CC433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbhLHQh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:37:29 -0500
Received: from mail-eopbgr10084.outbound.protection.outlook.com ([40.107.1.84]:45379
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232823AbhLHQh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 11:37:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOYkMSXEubu1IzBlTsSF5F38XC0xc90nE44tRkbD7DLplrI7Xq8FNMN9DRXSDe+hnMENZxi2Hlxlhq8h1uFj70lKjBE8yY+Cvk/qT1spZc0H4g3Z9h5Ey+44udVwnq4d+r8OwvRUiGmYoKrSYSOQKgVbB1yEHGX34Iad9Cx+5USwUnEKgk35HaqgoJyeBRZbJs7SlyNIQiy5ixiHopn1ZhPrgP0Ua1J0Wtm5fc0qAK5+mPl/X6dZLB0yZvr2shNhChQbynQFkFMC+kcfmmGH2Q2GYumE5i9aCXKMSYxWuk9VIoAHJGLYhjZHKm0khrB2AgtCExtCNGZ2Rv+Z1GYtRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRZHm4oyw3rcqEpk5Et3zIGO7W3mYBS0JOU6Fk/tIkE=;
 b=M9hy5xQ4rpfJEjB9ihruVgrYmss/nywFEJyQhrjs7OcvXS5gKbQDEH9AuwjyQCkxgLUlAoOMPWe8A1QOZlaJNzTqxkUp60XlJPimNMbQgpsuBq5UudD6l+q10cXf7Luriby2qPYLJLG2Jf+eRaxgFkY6k+rU/+hjnJsmo8W4dqgSwILMifOh/c5/as0EVtQaXTuAli6aPukdPjSX6sYPOpSz7nBw3UORy6MQrMzfUHwkN45KIj2ql2Igvw+yxbm5G1BEG7Ca0z6htUmTZ6INRmL3cIW1+9Q5knbNw6DJSp+BIecrDFlWgJhite/oh/5atcJSyTj52+bIEVNqxuM6eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRZHm4oyw3rcqEpk5Et3zIGO7W3mYBS0JOU6Fk/tIkE=;
 b=WXfyIlOStyjb7gMFJhwTXs3qCvEGLGF/ARJdgNxNlhuij//JkxfvLZ1Et1uh0MZbdwL0oNVqzXeEau5X3pIQoQM8FxnRyRXDVfJwgwq/Sj9nf6k4A3+pF0FYK79mpZq4MUVjzJgPj8HDMvJi16rInJei0Y/8SEb1yPOooDPpJF8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3914.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:43::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 16:33:51 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Wed, 8 Dec 2021
 16:33:51 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v5 3/8] ssh signing: make verify-commit consider key lifetime
Date:   Wed,  8 Dec 2021 17:33:30 +0100
Message-Id: <20211208163335.1231795-4-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208163335.1231795-1-fs@gigacodes.de>
References: <20211130141112.78193-1-fs@gigacodes.de>
 <20211208163335.1231795-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9P194CA0006.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:20b:46d::6) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:3e55:2984:f78e:8b18) by AS9P194CA0006.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:46d::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Wed, 8 Dec 2021 16:33:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1dc4466-d5e2-40c3-f3c6-08d9ba68842a
X-MS-TrafficTypeDiagnostic: PR3PR10MB3914:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB39145B4F7420C5CF7649F9BEB66F9@PR3PR10MB3914.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KzPY67SsDXS8twf0f9vMGdnaMG28TWarT0Vt+/FjckAdLipthbAJWMVIjsbkBzUKQsdC8ZZelQ1GdfAgrT0bY21H56VJilsA9hKrICaLg+9rK6OGZLVb370rUmlkDfnS2WSpKaC9ONvGthz1JjmQ9sSmQgxS98fNDcS89W/li9FeJV0WmTnOkus+ImiFysKgkOWpQ7+C+NHyWo0GeAHLausmMQQ4V+ckk75D7+3tipoRyrcqpN7ylCF1+Vn3GbzM62yXd181Em8eU/Fz9cTnxE7r9Ho4kYk/+WZZNUwz9F4i1oOUGnhHHdT6zkBNrxOyFlRz4hwTOUpYWN6mWY2Tw3kE4r4njJeQMyHyfDJZXx9qo1wr++0H+5xi0hd6C9SdCXUzygm6TwEjO/w9ZZ9wV/5hDcG4YVmnI8zYsu63c4IoQ5HLPog7vC7RpdkKe8i2DL9TU9IiIPbEEr1rW/j6F/JoEPcxBhg8/T9Ki7BjIW/SFMrjNGdYBTWiOzp2vnwPfDKfXQ/ODHFogTEr1pE3wz0cck0oTHeenveR7fVlwKB+QjPS+18WJmezwnTMOb9Q02MmCJ90J3bUrqVVb3OaqwJIqWHoKqp0rILFKPZS+TS3DqoRor8qE9aaKamokDC6SBK57mRVk5uKhAtI7Akt+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39840400004)(508600001)(2906002)(6916009)(15650500001)(2616005)(186003)(6496006)(36756003)(38100700002)(83380400001)(66946007)(8676002)(66476007)(8936002)(6666004)(1076003)(86362001)(66556008)(5660300002)(107886003)(54906003)(4326008)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b20e8NryLcVUAK3shNm4uY147yLrggsd8jAs8cLua/HRtivBhGtO66BW22bO?=
 =?us-ascii?Q?4eWT2ud+3AGwwY6mhDBFWKvRbKkKU52lHEKAZbtrgZHeHDasnD5LFZc3iUG+?=
 =?us-ascii?Q?ELwpyK4YjNwkVuY4cNntyJMeECN7OIQlL9GgmKiQGWKNnN4LJ9iNQFErKagL?=
 =?us-ascii?Q?9BqwzuShafdvbwS43Cbzl+LXVgMQtNQOvfTBUR9ZER3CnhFlaHsLCcClEJSF?=
 =?us-ascii?Q?d7RmtJMOEUjgucW9o/9tOlszAa9cgyfIdAHMfYIL9AgH3/ut+jZ7g6oLp82J?=
 =?us-ascii?Q?UkYU7u8B/hukA7SWl0C/CX235TaJKVPzdUG7Mf8XZZ3USgYJxkP1fFh6Gkw/?=
 =?us-ascii?Q?mKp2D1xM7GJ0fLtmuR/TeAFsyNxqqYb8Y4m9Qf/t1ZiTJvifSYkEXdbWmFgW?=
 =?us-ascii?Q?no+F25a4lcMe/I/0f1qDI3vtyga2OZJS4RMPfArr5adeIEgFKzO4p1edOTBJ?=
 =?us-ascii?Q?iRXFGw7Re2W5VhPhS5KBwM92k1c9Zq1yMGLE6PKQD655Wy8GGaIxYjFBhlX1?=
 =?us-ascii?Q?iN9j2IgmP5a87qdxxNxT4OgkQuNksey2aMOryqA2qxgCcBl78EVGTBtMgxL9?=
 =?us-ascii?Q?elyHt9La0LWwb0EfUV/QH69fGkeAfWzDdP3zWNu0NHlX8STEnvqjFRoSDfvz?=
 =?us-ascii?Q?gS/MHYAdL1eOmriLs9NHj5dVpyBhFPVQHDNggBp1MTtB4R2sjQuY+76DS30t?=
 =?us-ascii?Q?4vuRvBdV10iPpTB7nixMrPzkcU+U8MQpvIad4cTL2zlaEWmk8LvKelrXs7lb?=
 =?us-ascii?Q?w3pX7cuPaOdvn+Zde4Z1l/AlCEQIOVyr1i/kiloTrOH3usr1ElTddXZK6pC3?=
 =?us-ascii?Q?1/zA1p1ewIX9x9KKdJvfymw7I0clGSQoO8JancOpH8BNqMKGx1yGJn1gXhiV?=
 =?us-ascii?Q?uW+GCrkLUz3H2ljwX1Skl+bAj7Mx/66p313ul0kEYzB39opVfXL3cRaPFxjp?=
 =?us-ascii?Q?3Uq3I80jAuOBbPMM/js2zUkzBMzKPGK9Qy4nu6rjfcRGob9ucEaLX8DcZ8ft?=
 =?us-ascii?Q?hiBpJz/DWrIBHijmNVWGX7cV8b7CuX5iKYg8MIIPa/FkxD7KyKl/dp2utNET?=
 =?us-ascii?Q?X257YFCYN1/TNfdoJHYMjkbNT6eO2tG9oCd3CjBSr7+R54EigneWP+xlidCM?=
 =?us-ascii?Q?Eyu0pLH24/aKkpGzF+cMtDrN6wKT6EN95VZrAD6AvqSvWy8yuaF/U3XybHZ1?=
 =?us-ascii?Q?FBHy0kTa0m+iJSku3qoji3fnNfIdoZZ+67oueu3T4G9FxzpMCS92wjgjYmzk?=
 =?us-ascii?Q?SM2WQG19zkBWB+4gjyt07YXASFhp2dIUGi8KJYaYRlROgZRQoV/YRzHZjCRJ?=
 =?us-ascii?Q?jvmUst06j/7faWekAyPpkgfjAhmz0I5YzT4nZArR+agHpXo8FzlfXIOKQvKf?=
 =?us-ascii?Q?Hc2K14EljDc1ZUxYE67XMOZJx/Ek7rxmTXS5xfQ3f7gRgEq1ZXcm+5DBNUuX?=
 =?us-ascii?Q?4ro05ZQ37AK9FCD8p1Q2MMZ7/vSZxB5WyjxVzQzLl3UK3ZPRA1GCIInlOp8l?=
 =?us-ascii?Q?oKS0NCdVGpUGV2aXIMpdvLVLu+Qwxn1y4QJLDwxvTMf6xrQdjnG0OWkeOvDC?=
 =?us-ascii?Q?xm71kxDTX6AlpoUVPRjlBeQUHx4nxSYOYPJab/ZWy5cl/z0Kur5WA0efXOJN?=
 =?us-ascii?Q?kDh4ybB5+GHVEGlX5g7G4MW34oy4qtwvasVUUk/yJM9Yz6lvAHcRrKxFLr9A?=
 =?us-ascii?Q?L+UVII960sv13Ja+Hk+P9Jzg9PmRQwd/gd5GcBkQPHos6jWmSdI7OlpwXl0j?=
 =?us-ascii?Q?T35PR9/jRg=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f1dc4466-d5e2-40c3-f3c6-08d9ba68842a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 16:33:50.9893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xBrpcH8dF6ytScwlPC3cu/WaQMF7I61hSYXUJaixvne4IOQktyZswSr2pETJyzA7sr702VgBcCGE/zlrLmeaGCz4L3BQJFOqLlp60jw4ScQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3914
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

