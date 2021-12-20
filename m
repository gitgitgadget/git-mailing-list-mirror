Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9712AC433FE
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 14:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbhLTOJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 09:09:44 -0500
Received: from mail-eopbgr60040.outbound.protection.outlook.com ([40.107.6.40]:26598
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230116AbhLTOJo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 09:09:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntucrapXLjohq2lDYK1UKqi+UX3yYd4q8J0ktsUNtvjOrLLBj/f78dwK1X5EPPPTZbL+5oFtnBOgMgW/0akJJhbfz2M/fYzZwnd77o3J9pq3k/6NrUWTcVqSpnbm3YXuBQY8T1VoMiQB5e4jN4Hx8aPTh8twd7nP0nQDw64gikgmpjN8wp5WvGAb/PiBYkGsNMUvzMhSfEPp0sNLs3qaZzPf6sAuDf4D2jruXpMZAQRFU4SE1Z2yPRVkqOlmU9q7wQpMbQuvqCbV3k93AocrQwN6glJgmsJmjsIdawQVq8A4fu4+2JmZF9yFqPEDvyRECFqdhodfo9RX4ODJrHxGVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u71xQRKecETCSvBl9btZX4Of1KTbQEVabrOqshm11Hw=;
 b=ZgyrgYVxOlGtb9aL3YvciW0oQ2RF5SnIA4CybdXyIWyiiEjUU5DyTSgW51Yuo1yqebasc91bJxLAqB1noSBy0gdoRamQTBSSultQ6GgmjwbZsU8yk0Mw2jGw4Z/wNbc60ziMFPK35WgE4xVfP2fFLQfAwJj1yB/3ZvcTZzCU1kXHPOvx4v43rl5nsmFtZwdmnWfp6rPL9rlpjqyq3NqDurrhxaKE7AoKHwUSHJb6hRb9KpUJB6ro5cxGUGvehHKyi5qzmdUU7e+IGCedKcMqJr14+i/1D+ZwuYHxuPIXEdC6Mhwo89cLzKtsuQ8JjTiV/rz/Z8ERGMiEWtuvCkUGSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u71xQRKecETCSvBl9btZX4Of1KTbQEVabrOqshm11Hw=;
 b=ZFjLPWRrQbn5aUpzp/meMIDLVdm1lZKccysbr8ld7q6zAiWLLZkeA8BjunMIULwTizqJIw0IleZOvsY7gLX0Qm+aTejqAOEnucN9CUckK70qBfUqghFfzoqD0osI4nkg2JskJfSsx4IChck4MUk8G3QV8JJC2D9B9J8KNXxL6Ok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4238.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Mon, 20 Dec
 2021 14:09:42 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%4]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 14:09:42 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [RFC PATCH 2/2] crypto sign: add cryptoSign.* config
Date:   Mon, 20 Dec 2021 15:09:28 +0100
Message-Id: <20211220140928.1205586-3-fs@gigacodes.de>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211220140928.1205586-1-fs@gigacodes.de>
References: <20211220140928.1205586-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0334.eurprd06.prod.outlook.com
 (2603:10a6:20b:466::19) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff2d564c-c089-452d-99d0-08d9c3c25e76
X-MS-TrafficTypeDiagnostic: PR3PR10MB4238:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB4238A027ABB6B4CE8F037412B67B9@PR3PR10MB4238.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1O2cN3v1GudoNuBYOaFTpTUQYudElCnUQneITjU+Q4f2m9WDgSWv7aSjIYp3g4t2G98z9XBpKXT2hZLj13mRAPjsUFr50rRWYNbw30ame/6USLU2+4je06jUgGcP+Mf+wkw8tjLfxnFeHmKuRjmhGCTezHlDTt/SumxuDt+AQwi1bM9z009wodhwiExeOf5qTVr2BQS3FO3QPvl3ycjlGELWJSVqKvEMcPLceZtsQz8d0XycKbUORyrpOSdkNxzfZ+C1EWXzahribv2fPZm1JWKal/cvQ1PD3qiva2m/3HPwcZzQASq7UuTzyHwkcGiNiD0qlo4qAdbhOEmHrVd1KvSf7EqQnaBd8n9oEWvohpJ8AXBTuckgHiFePr7HKguW7KL0hTDYVHxYbe23xO5SSk5yHuGU5pA61GI75AmwNsVt6Dm+8l+OIgDHXLc4ZeOX4yPIHXimbeMHuTwArZoV8McCiXaDu4cDkcARMjKYvqXR7D8C3n62NJzr6r/mgDsPe/e+6Ic/4/JcJg+20k0kxOYOKhfFSI5so9SepC/ziQxwFT+HqAze5n5WOL8GtmB5rAqvf0ZuDw//q724naaEek0kq8LKGpJWA/CObDWdh95VKwFHJ2Cp5AJMaUL8P9W+OmRV1RRJoTBdvpJ4motjRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(39840400004)(136003)(346002)(376002)(396003)(8936002)(508600001)(6666004)(83380400001)(107886003)(8676002)(2616005)(86362001)(316002)(1076003)(54906003)(186003)(6506007)(36756003)(6916009)(6512007)(38100700002)(5660300002)(66476007)(66556008)(6486002)(66946007)(2906002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IYe3ou6cU02UVzbqojXuF02PpqO3FPnkd0fxizkINX11QwUo7Y5pL6SgL4wj?=
 =?us-ascii?Q?ZQwEwng3PTBYhX1rBjdRXYT01p72oeM/Y+NGlIoLVyvQtdpUJYZC1MJ/pb4P?=
 =?us-ascii?Q?lVG6qfkjelvHUCMXHfB1HiSteZNcg126FIf0V3PAflf+3X7A+rJ7K+dNxp0L?=
 =?us-ascii?Q?d4tPyNjIAiqMbuzSd4uyxpL1CNNP9GL/JxOJAuVEG1aK1v88SnOpzUom/KNi?=
 =?us-ascii?Q?pG1SyEA4S5w+u6/IYEtt14qZpcqPwpITrvyx+/rz6SfjPw9ZCDejvGz6ygzM?=
 =?us-ascii?Q?1s/QbGonmIVVUrXHl0V75SYMTlP5jMWN0UPBPagKsd11FcmKzVwGSV9vJ4go?=
 =?us-ascii?Q?qg8yPVabrZEaQFvMqPjSPgJdyFaSGSkM6FrqbletpVm8o55u3kZ5PDQiaf4C?=
 =?us-ascii?Q?FEtYLrfcRHy/iRMR0vT6TgK9WDIkWz1D6/8eg+EExrdiIqYh0yomfXijP/7b?=
 =?us-ascii?Q?JrImP7n7o5VjlLASZ4uhziTmeMFu4TfNNuUTBoGHRXpWA3m9oOM25CGs0YNT?=
 =?us-ascii?Q?iFH9xoxTfW2/YS5ejW0IRPAxQDmSCe0sH+MwU+BHNesC4lyDvHsBopUofjdY?=
 =?us-ascii?Q?KmcomEC025l7hog/P7D805peQ4NgfM7KvZ5fsOQ/ToIl3KzaxEgvu1VDMAaQ?=
 =?us-ascii?Q?UnzSWQCH/7yikj/RoTlh42BXSaPWfVSI2wXSiVle21sFfHP3/TLPjyNFGCf5?=
 =?us-ascii?Q?f+wZVQHtcZcJmcOi0vdOyAw/fr/aoWRCl1Vx7mB+Vco4rfB62q5cRBUD+Tpm?=
 =?us-ascii?Q?oMaJnFbEK+xYQfGSxIb1I/HTqiKeAo1aK9E2r/mJhl8HbyTrBoruHMuAUDPU?=
 =?us-ascii?Q?WRK9Q9YiDxbFhJDas70yOSw2ybGtZwAvEJTuaeVmsGVSfNGZlOim2zuDh8gy?=
 =?us-ascii?Q?dimNM4u+OBpKAzwJFNF2vQkLQ1gtgXPJtKJcLKpLwrLU5V9PM44rEP9jO5ZC?=
 =?us-ascii?Q?CMB6HLk8AuIzHlCoJAOBzHVfAtJ3OHh/xknZFQ+q9GcxU0EIRK8e2DR1WGa4?=
 =?us-ascii?Q?vNyv8k3WOpDClHI8XgWI5TY5uv6mrrc9yYIh+fQmSaZ9orTtnvY0m0+XVLil?=
 =?us-ascii?Q?tJbGSi1gF+ABaUnl2ZbS+8u2UC8j+lmGQVZjvhi1HusxlW2BA/xr/Zp1sIKC?=
 =?us-ascii?Q?RAeFeJvz8LXxq36iipvXhinTRVCD4CFnhq5VzLofRwrWtcYGFkcgYCnaxGKT?=
 =?us-ascii?Q?VbQRxAL17p4vWnsXYG76Nm+zQSx1lwyctsWocv8xqBJrBa17DZGkHExCNSbk?=
 =?us-ascii?Q?h4giU4DFQvpcERJzUiEc0laQnptYmSbyF8FYji9DWG9hUHVAgWxUHPE8CPlD?=
 =?us-ascii?Q?VJOGlUFJ0Fb/PtmezPyqO1BUo0ZinO9pz9PveOXFrMVqtbK95D7ab++gM+vR?=
 =?us-ascii?Q?w4eHyQ9E5QRCFcF6j7YEcI4ryEfGfGPR1dmnVm7VGctICUKejSpWIZyrjIiO?=
 =?us-ascii?Q?Muytdx4MuNWED51kORoHgJ/ydl5M1ZHXAmiloEvAFPvt+gowBIp9uBXiUnN0?=
 =?us-ascii?Q?bLvo7R97My9JNdQmeKgHKfXtz12EASIYh3/2uyIWpiKDc0AscN0xOkARfcq+?=
 =?us-ascii?Q?acAT9n6SndwjTtcIIorHTOlKqYqTffIfL7L/CPGlABcDTYUhSRkWTtouEwET?=
 =?us-ascii?Q?aq7vamcAeWC9zr5Z9e7134Irv1rUXt+dgU5FvHNmk9gg/+iTTY0GS8/8EUzE?=
 =?us-ascii?Q?9QmMQiGEZp+XutW1iuTPVr+eTRjaDBfsvNdkQOKNi5WhBzaNufqaWgU5+srX?=
 =?us-ascii?Q?wPz4AbeGGg=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2d564c-c089-452d-99d0-08d9c3c25e76
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2021 14:09:42.6944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKGREegkpx4XJROQhQ8iv9RT3x0luqSGcSKohAPKOv+9IGqllK3SEiGrGeaymSwEPYR1yBfoABr4D6MZSenDej6QF7YhgcH/HZRe7OtEszw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4238
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since git now supports multiple cryptographic methods/formats to sign
objects, the `gpg.` configuration prefix is misleading.
Add `cryptoSign.`, but keep `gpg.` as a compatibility alias at least for
all existing options.
`gpg.mintrustlevel` is moved to `cryptosign.gpg.mintrustlevel` while
also still allowing the former.
---
 Documentation/config/gpg.txt | 31 ++++++++++++++++++++-----------
 gpg-interface.c              | 30 ++++++++++++++++++++++--------
 2 files changed, 42 insertions(+), 19 deletions(-)

diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
index 4f30c7dbdd..ef21eb8249 100644
--- a/Documentation/config/gpg.txt
+++ b/Documentation/config/gpg.txt
@@ -1,6 +1,17 @@
 gpg.program::
-	Use this custom program instead of "`gpg`" found on `$PATH` when
-	making or verifying a PGP signature. The program must support the
+	Deprecated alias for `cryptoSign.<format>.program`.
+
+cryptoSign.format::
+gpg.format::
+	Specifies which key format to use when signing with `--crypto-sign`.
+	Default is "openpgp". Other possible values are "x509", "ssh".
+
+cryptoSign.<format>.program::
+gpg.<format>.program::
+	Use this to customize the program used for the signing format you
+	chose (see `cryptoSign.format`). The default value for
+	`gpg.x509.program` is "gpgsm" and `gpg.ssh.program` is "ssh-keygen".
+	With the format set to "opengpg" or "x509" the program must support the
 	same command-line interface as GPG, namely, to verify a detached
 	signature, "`gpg --verify $signature - <$file`" is run, and the
 	program is expected to signal a good signature by exiting with
@@ -8,17 +19,12 @@ gpg.program::
 	standard input of "`gpg -bsau $key`" is fed with the contents to be
 	signed, and the program is expected to send the result to its
 	standard output.
+	If the format is "ssh", then the configured program must implement the
+	`ssh-keygen -Y find-principals|check-novalidate|verify|sign` commands
+	(see ssh-keygen(1) man page).
 
-gpg.format::
-	Specifies which key format to use when signing with `--gpg-sign`.
-	Default is "openpgp". Other possible values are "x509", "ssh".
-
-gpg.<format>.program::
-	Use this to customize the program used for the signing format you
-	chose. (see `gpg.program` and `gpg.format`) `gpg.program` can still
-	be used as a legacy synonym for `gpg.openpgp.program`. The default
-	value for `gpg.x509.program` is "gpgsm" and `gpg.ssh.program` is "ssh-keygen".
 
+crpytoSign.gpg.minTrustLevel::
 gpg.minTrustLevel::
 	Specifies a minimum trust level for signature verification.  If
 	this option is unset, then signature verification for merge
@@ -34,12 +40,14 @@ gpg.minTrustLevel::
 * `fully`
 * `ultimate`
 
+cryptoSign.ssh.defaultKeyCommand::
 gpg.ssh.defaultKeyCommand:
 	This command that will be run when user.signingkey is not set and a ssh
 	signature is requested. On successful exit a valid ssh public key is
 	expected in the	first line of its output. To automatically use the first
 	available key from your ssh-agent set this to "ssh-add -L".
 
+cryptoSign.ssh.allowedSignersFile::
 gpg.ssh.allowedSignersFile::
 	A file containing ssh public keys which you are willing to trust.
 	The file consists of one or more lines of principals followed by an ssh
@@ -67,6 +75,7 @@ This way only committers with an already valid key can add or change keys in the
 Using a SSH CA key with the cert-authority option
 (see ssh-keygen(1) "CERTIFICATES") is also valid.
 
+cryptoSign.ssh.revocationFile::
 gpg.ssh.revocationFile::
 	Either a SSH KRL or a list of revoked public keys (without the principal prefix).
 	See ssh-keygen(1) for details.
diff --git a/gpg-interface.c b/gpg-interface.c
index 3e7255a2a9..eacafcd56e 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -638,6 +638,7 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 	struct gpg_format *fmt = NULL;
 	char *fmtname = NULL;
 	char *trust;
+	const char *crypto_var = NULL;
 	int ret;
 
 	if (!strcmp(var, "user.signingkey")) {
@@ -647,7 +648,17 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	if (!strcmp(var, "gpg.format")) {
+	/*
+	 * `gpg.` is a backwards compatibility prefix alias for `cryptosign.`
+	 * All following vars expect a prefix so we can return early if
+	 * there is none
+	 */
+	if (!skip_prefix(var, "gpg.", &crypto_var) &&
+	    !skip_prefix(var, "cryptosign.", &crypto_var))
+		return 0;
+
+
+	if (!strcmp(crypto_var, "format")) {
 		if (!value)
 			return config_error_nonbool(var);
 		fmt = get_format_by_name(value);
@@ -658,7 +669,9 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	if (!strcmp(var, "gpg.mintrustlevel")) {
+	/* `gpg.mintrustlevel` moved to `cryptosign.gpg.mintrustlevel` */
+	if (!strcmp(crypto_var, "mintrustlevel") ||
+	    !strcmp(crypto_var, "gpg.mintrustlevel")) {
 		if (!value)
 			return config_error_nonbool(var);
 
@@ -672,31 +685,32 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	if (!strcmp(var, "gpg.ssh.defaultkeycommand")) {
+	if (!strcmp(crypto_var, "ssh.defaultkeycommand")) {
 		if (!value)
 			return config_error_nonbool(var);
 		return git_config_string(&ssh_default_key_command, var, value);
 	}
 
-	if (!strcmp(var, "gpg.ssh.allowedsignersfile")) {
+	if (!strcmp(crypto_var, "ssh.allowedsignersfile")) {
 		if (!value)
 			return config_error_nonbool(var);
 		return git_config_pathname(&ssh_allowed_signers, var, value);
 	}
 
-	if (!strcmp(var, "gpg.ssh.revocationfile")) {
+	if (!strcmp(crypto_var, "ssh.revocationfile")) {
 		if (!value)
 			return config_error_nonbool(var);
 		return git_config_pathname(&ssh_revocation_file, var, value);
 	}
 
-	if (!strcmp(var, "gpg.program") || !strcmp(var, "gpg.openpgp.program"))
+	if (!strcmp(crypto_var, "program") ||
+	    !strcmp(crypto_var, "openpgp.program"))
 		fmtname = "openpgp";
 
-	if (!strcmp(var, "gpg.x509.program"))
+	if (!strcmp(crypto_var, "x509.program"))
 		fmtname = "x509";
 
-	if (!strcmp(var, "gpg.ssh.program"))
+	if (!strcmp(crypto_var, "ssh.program"))
 		fmtname = "ssh";
 
 	if (fmtname) {
-- 
2.33.1

