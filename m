Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A17C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 17:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B5C261B5E
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 17:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbhKRRRX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 12:17:23 -0500
Received: from mail-am5eur03hn2214.outbound.protection.outlook.com ([52.100.11.214]:57077
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233966AbhKRRRV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 12:17:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgTiDXeVfVGVDs8flThnv9Xv53EPNblcSxOlTciu526KEhHUhGG1IrN0KhDCKqOQenEpKI/A3LKG60c9C1GGH9IOYGf670xFpIUWCZRuSGa4JwE8ikDyyLzQmfihlUkZBQZz2iHoW4FbBfj34ijs7XTuFT0YtgPpsO9f0lpD6/kyy0KWYUGd1lJB4lmq22v4SWB5W8+p/Ta+3U8UxrFXPqHIyqr/0+5xsK7J9StUp8jmRB0q3DSagqQnH6KDeosaQy+eMOaxNOLxMyKvW2wrOkROUH4h7BU20Bs+a9GTBFKcBXpDKXoxr8yjwR2g9I4ywuMq9jYDpH5wpIe5KX7xsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2GNIfL9a+Lty6oD/BpdCmd8+r+osZ/B4PgpgXMb44M=;
 b=aHQU6X86tUMpG8Lzolz56jvFe5wmWDW2gZts3JmSSPquBSN0Tv2QZ8kpyy2PwQVLXeOs76iWkfXJXe+2oGgfi5cSHRzoz79jqrpaWuyuoxOD/DkiVgyuUgjFLnIsskfUW4BdbHmO5MLCBEtIR0C59z5UA7YMaYtnPWZtn1PvTmTL89BcZmgFjWQoEgQWNFNy/D6VD3SL9XOmOeqzF+SweK5o4vgHYPnT5f/Sk2Pc5hACfpVBx0ixw3VWJUbucZM6FgUAeuFhhpDxJKpZkdOOV3yzKmqqYxFZ/+46HrIZD7ZME0LQKPSKS0BLmopNdpzzoYIxNlMCSVn0e8e1IpzFjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2GNIfL9a+Lty6oD/BpdCmd8+r+osZ/B4PgpgXMb44M=;
 b=oDCFhGEdCitdlxCjBO0WAKqWguPhLaU7YELpFhjeMs0m+M4LP0ROnbVPdpOTUz2s/PvJoOy7zrTgqM5axPXg6jtR9GYa0hiFjSIi08McW9w6oLcslUXk4TI5eIAVAZ5ydKao3vPQGy7NSZ/ET609Za471EZKRWV7JH98sTwLIk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:157::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 18 Nov
 2021 17:14:19 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%5]) with mapi id 15.20.4713.020; Thu, 18 Nov 2021
 17:14:19 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v2 1/2] ssh signing: support non ssh-* keytypes
Date:   Thu, 18 Nov 2021 18:14:10 +0100
Message-Id: <20211118171411.147568-1-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211117162727.650857-1-fs@gigacodes.de>
References: <20211117162727.650857-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::14) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2a02:908:178:20a0:d22:c58d:d0a4:a83a) by FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.9 via Frontend Transport; Thu, 18 Nov 2021 17:14:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f3eb706-facd-47c2-2af2-08d9aab6db5e
X-MS-TrafficTypeDiagnostic: PAXPR10MB4687:
X-Microsoft-Antispam-PRVS: <PAXPR10MB4687557F152E5DC50B7C6DB9B69B9@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:393;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gVJDJ2oxDZvCeft3Jtr/eD3N/ZkNVHXmpIJJ5Z4hhcf/Ax1rS5ThY2AFm34C?=
 =?us-ascii?Q?EswA4vSvRO5H62svOk9Pakwt5Avx6GoY8Ggjs6IvHKcEdwQ7buhNGWBe9FcQ?=
 =?us-ascii?Q?Y98q4ZGlXsw1hR9BYAsxxign5HMGdjWTk0KL9uTwAdpffqR9qQADw3y2M9qJ?=
 =?us-ascii?Q?LcSojK/tFsZZLRGnudY5IgIwVTb4WFEH5GPncE1Pjt11SoGim3yD9FtCvkco?=
 =?us-ascii?Q?ooP1GLldIFrvbhyj3ZFliTarUJ4cBPCrJSsEwfZPnnTBFgCNtONpZ0UPVbXm?=
 =?us-ascii?Q?wiauehgk/nJMJlHdiFhH6htYVhWe1760m9YeaejR4rbGeqqOfP0uFAStiQFa?=
 =?us-ascii?Q?zVPvjv83il1y5H54FpO1NRjUUwzcJjGClpYvMOU2eA9Gx3V3dn5HyBN0fHwk?=
 =?us-ascii?Q?Usz39K4NqBy7w5vxxAHQoJDCbhq3lxkf9Yp0Mv/nq4j4mk6jvGlge3MiKgzm?=
 =?us-ascii?Q?Bh6vdOJ39jkS4pmTD7vmWubesrWk5d7dXfTH3q/jon1tcLhgZVjEuaES8eSW?=
 =?us-ascii?Q?SAlG2RpJXXrrZ+dycGfndKh2yPHtfxBkE4i9ZJ0E/0WHFuKgiGl2ghY8AMEf?=
 =?us-ascii?Q?CsVqBeDLftJqW5190igDOLoU5KdX4gRdYxF9PTVy3CePpjwha6nB0n1G3IGy?=
 =?us-ascii?Q?ZRDWVcsJ55RiPN2LybsHWQFdpQ5lI7iEffLTnT5f1bBkzQAa5aNJjrBGZHqu?=
 =?us-ascii?Q?hk9jBgPMSOYQbNdWhzkKfjC9ATNUg1uIhbcsCdbTUTOum8bEp8AA2sZby46I?=
 =?us-ascii?Q?wqmskRmH3JhZG5028PkM7GJ1gJvKLu1aaM9pz8/fTTGBqcW1aNBN3MuMTo6Q?=
 =?us-ascii?Q?0xeipmUfOwdXyrTyBS5JXv8RJpZp985ZeFdvzZO9Au2qkIdOyeQmv64GSERn?=
 =?us-ascii?Q?4BIitz5UFdDlBB9TVy/9zK6bAsFFrcOYHK1SyclN55N3QMNks60i268OoOF9?=
 =?us-ascii?Q?NyaVzifzQXx+JwWHNeBxqGKkBR8hHkik1TdYEZqZyqHb5+TBgc+ZyxIVGDWa?=
 =?us-ascii?Q?XfrqYeVcYl9IolFh2q3Myh+pZg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(39840400004)(346002)(376002)(396003)(136003)(366004)(52116002)(6496006)(508600001)(2906002)(1076003)(4326008)(5660300002)(6666004)(86362001)(107886003)(6916009)(8676002)(38100700002)(186003)(36756003)(66476007)(66556008)(8936002)(83380400001)(316002)(6486002)(66946007)(2616005)(54906003)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wfP1OM1fFy3FDvOdGGIKUjUJjiK+5fLYlC+maXQoFR9y0uUwAVly+34eHhWz?=
 =?us-ascii?Q?XiG44EXFpLMwJDuZVy7+RTZIXgyunT16b8ii1idPAT+A9u6iRJiLlHcfJ++B?=
 =?us-ascii?Q?4wuLHy+Pv7rEM0I7i4bgionXfoOtYBxp3XHsRSrshlLTM86V+1/E7lHqPGO9?=
 =?us-ascii?Q?/ow4Kdq3f/g4R3/RqlWffSRp+mIPPfwp+s02VO1DocZCvJxArE9HoyEt7caq?=
 =?us-ascii?Q?VEZNijdON0kpyCUTGerMyYCeqadseiLUr0IezNGDsHMGfjudlqmJJUNP6ljl?=
 =?us-ascii?Q?NEjWahH4vRP3fUeAs40q4tU7KsV1agQPc2+4cfvoa5iW/Dpx4gSwr+Pl3IsZ?=
 =?us-ascii?Q?xtLfvpN0fhJLq0KeMSNvvaSKQavzv4zbZzPyWkCnveTBXp8oBL1AcrDRIu60?=
 =?us-ascii?Q?ioxjJt0FNXwmq/nqqoFE/vNZ6QgxyaAeJ6SHQZ5HcAvp2b3fMZ82LQ/oxCpZ?=
 =?us-ascii?Q?09ChgKZpNQFlF+gnEUmF7nHNE9WdUXB4oH0eKyaxQYfUFtA/b0RByiHayeM1?=
 =?us-ascii?Q?QU/y5bTJt6kYETCe0tlJvriUQxrLxd5FKjhm0S5cJ4p2KPbLhSRWOyf05w6j?=
 =?us-ascii?Q?Md16Qk+jQai/u7wacu9LCB+iJnQaZt22U9kZoXuq1VO3zSXPyaDa2XK5fMMx?=
 =?us-ascii?Q?xFx/l1P5/Hz4p1hDtkuvMyVhKjcc7JEyzLy7zxzG9Zkc19KPXXWsyscSuIar?=
 =?us-ascii?Q?igimXmsUczsfFg7U39Bijfcd0h4A+Z2mo8lt1bHHy46iwAeTKsjrl+QueCDl?=
 =?us-ascii?Q?E/b398zvQDwCHy0lk8BMHSgF1+UaBJ9cn1AEhsEWsdkIO1C4TAWFhK6appwP?=
 =?us-ascii?Q?2xfcFnpkdf8KUrupPoNriBJxD0ymKan3gqR/fHkiy4tSx4RFHACDnaS0Pu+5?=
 =?us-ascii?Q?g7ZpJ1pb0l1u/5Ddwh0uhpvloS4AIeKiDh2a3T2MjhqNGEAbqPeIPhGnjAAH?=
 =?us-ascii?Q?ubQfaz64YU1Or+iwZV20Plmj3oWJTvuXWF3hXDQ1+zhbGuNpg9AIB3m0WtHz?=
 =?us-ascii?Q?k3aLVHhfOzZVEG2kMP6BNx6pAKXCUyadJyZfZZWdPDv+lOf9AHNOYo3Y62zG?=
 =?us-ascii?Q?fL8ioiwSgD4ezf2sMNqfXF1CFcGL3OykPb5s5S2+afBsIlARXpvNJmtj6CEy?=
 =?us-ascii?Q?+HMbQ2TAxWWOAZU2OgHXtNWOwjquJr5JDNdYbZiCpNJwioQjBhp+iXwm7IRH?=
 =?us-ascii?Q?Cqdr+VPDRwmoKSfOQfo2+dlqlJjN0IMp7KbRmCpCXXfdOOeramHteB7Qf3qS?=
 =?us-ascii?Q?nk7Cu64IOEYtVBaLDYiCXiyW0KEs4D+wV4J3cZ4h+Hifvf7fl6LE3NZTrn7I?=
 =?us-ascii?Q?cHbikPJsxgIrNRMe/CSM0VnfFO8CTBK1rk25gaPot8M8UfwN4+9xKhfM3DdZ?=
 =?us-ascii?Q?mLwypfeowgUwmpKylGGM83FCuTyItn9lUU/98bJKBNEBez+hWDyUpVCu7M2f?=
 =?us-ascii?Q?8iOCDOjdM6+lAz1v3t0L6wDCEUXBAOI2XVJjQQWu0pbaWSGd+u9J8AboDIGg?=
 =?us-ascii?Q?LePOmuXbumbUTMVbQeAFySDJpemvmyPHmDFk9Hm5gKiIVKk7VvuJEfwsk9R3?=
 =?us-ascii?Q?I/DtBnJS9J0jT37LZN01bm7BesO+zWG/yfvgmVN14sqDE+SLeWDPKHDa6Fve?=
 =?us-ascii?Q?1eMRTOH1imfuW8zfHeecstdOF6RAhTOyiy+ZFIyti1w31soDhWQ8dP5x6uo6?=
 =?us-ascii?Q?w/uVTCva9daRY6CkmrE6TCO5Urhe3RAYhEC77k3lpAMOodVwXk/3/1RIqjn5?=
 =?us-ascii?Q?1lKPlGzeZA=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3eb706-facd-47c2-2af2-08d9aab6db5e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 17:14:19.2101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7k3CSzQOlIrdcCkR60+tMbron82WHcKKLq6mGqD/Vz8YsV4AYDQ9u3T5la0Vrf6Of8Q56OazWFSoTt8GZMe55mpJxUYzVK9QzLvPYUx/9Fk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4687
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The user.signingKey config for ssh signing supports either a path to a
file containing the key or for the sake of convenience a literal string
with the ssh public key. To differentiate between those two cases we
check if the first few characters contain "ssh-" which is unlikely to be
the start of a path. ssh supports other key types which are not prefixed
with "ssh-" and will currently be treated as a file path and therefore
fail to load. To remedy this we move the prefix check into its own
function and introduce the prefix `key::` for literal ssh keys. This way
we don't need to add new key types when they become available. The
existing `ssh-` prefix is retained for compatibility with current user
configs but removed from the official documentation to discourage its
use.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
When writing the tests for this i remembered why we had none for literal
keys. Those need a running ssh-agent with the private key present.
Please let me know if the tests provide a safer way to start the
additional agent and make sure it gets cleaned up correctly. I tried
grepping for spawn,kill and similar things but did not find much else.

 Documentation/config/user.txt | 14 +++++++-------
 gpg-interface.c               | 36 ++++++++++++++++++++++++++++-------
 t/lib-gpg.sh                  |  3 +++
 t/t7528-signed-commit-ssh.sh  | 24 ++++++++++++++++++++++-
 4 files changed, 62 insertions(+), 15 deletions(-)

diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
index ad78dce9ec..4de700f651 100644
--- a/Documentation/config/user.txt
+++ b/Documentation/config/user.txt
@@ -36,10 +36,10 @@ user.signingKey::
 	commit, you can override the default selection with this variable.
 	This option is passed unchanged to gpg's --local-user parameter,
 	so you may specify a key using any method that gpg supports.
-	If gpg.format is set to "ssh" this can contain the literal ssh public
-	key (e.g.: "ssh-rsa XXXXXX identifier") or a file which contains it and
-	corresponds to the private key used for signing. The private key
-	needs to be available via ssh-agent. Alternatively it can be set to
-	a file containing a private key directly. If not set git will call
-	gpg.ssh.defaultKeyCommand (e.g.: "ssh-add -L") and try to use the first
-	key available.
+	If gpg.format is set to `ssh` this can contain the path to either
+	your private ssh key or the public key when ssh-agent is used.
+	Alternatively it can contain a public key prefixed with `key::`
+	directly (e.g.: "key::ssh-rsa XXXXXX identifier"). The private key
+	needs to be available via ssh-agent. If not set git will call
+	gpg.ssh.defaultKeyCommand (e.g.: "ssh-add -L") and try to use the
+	first key available.
diff --git a/gpg-interface.c b/gpg-interface.c
index 3e7255a2a9..73554ea998 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -707,6 +707,21 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
+/*
+ * Returns 1 if `string` contains a literal ssh key, 0 otherwise
+ * `key` will be set to the start of the actual key if a prefix is present.
+ */
+static int is_literal_ssh_key(const char *string, const char **key)
+{
+	if (skip_prefix(string, "key::", key))
+		return 1;
+	if (starts_with(string, "ssh-")) {
+		*key = string;
+		return 1;
+	}
+	return 0;
+}
+
 static char *get_ssh_key_fingerprint(const char *signing_key)
 {
 	struct child_process ssh_keygen = CHILD_PROCESS_INIT;
@@ -714,15 +729,16 @@ static char *get_ssh_key_fingerprint(const char *signing_key)
 	struct strbuf fingerprint_stdout = STRBUF_INIT;
 	struct strbuf **fingerprint;
 	char *fingerprint_ret;
+	const char *literal_key = NULL;
 
 	/*
 	 * With SSH Signing this can contain a filename or a public key
 	 * For textual representation we usually want a fingerprint
 	 */
-	if (starts_with(signing_key, "ssh-")) {
+	if (is_literal_ssh_key(signing_key, &literal_key)) {
 		strvec_pushl(&ssh_keygen.args, "ssh-keygen", "-lf", "-", NULL);
-		ret = pipe_command(&ssh_keygen, signing_key,
-				   strlen(signing_key), &fingerprint_stdout, 0,
+		ret = pipe_command(&ssh_keygen, literal_key,
+				   strlen(literal_key), &fingerprint_stdout, 0,
 				   NULL, 0);
 	} else {
 		strvec_pushl(&ssh_keygen.args, "ssh-keygen", "-lf",
@@ -757,6 +773,7 @@ static const char *get_default_ssh_signing_key(void)
 	const char **argv;
 	int n;
 	char *default_key = NULL;
+	const char *literal_key = NULL;
 
 	if (!ssh_default_key_command)
 		die(_("either user.signingkey or gpg.ssh.defaultKeyCommand needs to be configured"));
@@ -774,7 +791,11 @@ static const char *get_default_ssh_signing_key(void)
 
 	if (!ret) {
 		keys = strbuf_split_max(&key_stdout, '\n', 2);
-		if (keys[0] && starts_with(keys[0]->buf, "ssh-")) {
+		if (keys[0] && is_literal_ssh_key(keys[0]->buf, &literal_key)) {
+			/*
+			 * We only use `is_literal_ssh_key` here to check validity
+			 * The prefix will be stripped when the key is used.
+			 */
 			default_key = strbuf_detach(keys[0], NULL);
 		} else {
 			warning(_("gpg.ssh.defaultKeyCommand succeeded but returned no keys: %s %s"),
@@ -889,19 +910,20 @@ static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
 	struct tempfile *key_file = NULL, *buffer_file = NULL;
 	char *ssh_signing_key_file = NULL;
 	struct strbuf ssh_signature_filename = STRBUF_INIT;
+	const char *literal_key = NULL;
 
 	if (!signing_key || signing_key[0] == '\0')
 		return error(
 			_("user.signingkey needs to be set for ssh signing"));
 
-	if (starts_with(signing_key, "ssh-")) {
+	if (is_literal_ssh_key(signing_key, &literal_key)) {
 		/* A literal ssh key */
 		key_file = mks_tempfile_t(".git_signing_key_tmpXXXXXX");
 		if (!key_file)
 			return error_errno(
 				_("could not create temporary file"));
-		keylen = strlen(signing_key);
-		if (write_in_full(key_file->fd, signing_key, keylen) < 0 ||
+		keylen = strlen(literal_key);
+		if (write_in_full(key_file->fd, literal_key, keylen) < 0 ||
 		    close_tempfile_gently(key_file) < 0) {
 			error_errno(_("failed writing ssh signing key to '%s'"),
 				    key_file->filename.buf);
diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index a3f285f515..6434feb6c1 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -91,6 +91,7 @@ GPGSSH_KEY_PRIMARY="${GNUPGHOME}/ed25519_ssh_signing_key"
 GPGSSH_KEY_SECONDARY="${GNUPGHOME}/rsa_2048_ssh_signing_key"
 GPGSSH_KEY_UNTRUSTED="${GNUPGHOME}/untrusted_ssh_signing_key"
 GPGSSH_KEY_WITH_PASSPHRASE="${GNUPGHOME}/protected_ssh_signing_key"
+GPGSSH_KEY_ECDSA="${GNUPGHOME}/ecdsa_ssh_signing_key"
 GPGSSH_KEY_PASSPHRASE="super_secret"
 GPGSSH_ALLOWED_SIGNERS="${GNUPGHOME}/ssh.all_valid.allowedSignersFile"
 
@@ -119,6 +120,8 @@ test_lazy_prereq GPGSSH '
 	echo "\"principal with number 2\" $(cat "${GPGSSH_KEY_SECONDARY}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
 	ssh-keygen -t ed25519 -N "${GPGSSH_KEY_PASSPHRASE}" -C "git ed25519 encrypted key" -f "${GPGSSH_KEY_WITH_PASSPHRASE}" >/dev/null &&
 	echo "\"principal with number 3\" $(cat "${GPGSSH_KEY_WITH_PASSPHRASE}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
+	ssh-keygen -t ecdsa -N "" -f "${GPGSSH_KEY_ECDSA}" >/dev/null
+	echo "\"principal with number 4\" $(cat "${GPGSSH_KEY_ECDSA}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
 	ssh-keygen -t ed25519 -N "" -f "${GPGSSH_KEY_UNTRUSTED}" >/dev/null
 '
 
diff --git a/t/t7528-signed-commit-ssh.sh b/t/t7528-signed-commit-ssh.sh
index badf3ed320..455eafa15c 100755
--- a/t/t7528-signed-commit-ssh.sh
+++ b/t/t7528-signed-commit-ssh.sh
@@ -73,7 +73,29 @@ test_expect_success GPGSSH 'create signed commits' '
 	git tag eleventh-signed $(cat oid) &&
 	echo 12 | git commit-tree --gpg-sign="${GPGSSH_KEY_UNTRUSTED}" HEAD^{tree} >oid &&
 	test_line_count = 1 oid &&
-	git tag twelfth-signed-alt $(cat oid)
+	git tag twelfth-signed-alt $(cat oid) &&
+
+	echo 13>file && test_tick && git commit -a -m thirteenth -S"${GPGSSH_KEY_ECDSA}" &&
+	git tag thirteenth-signed-ecdsa
+'
+
+test_expect_success GPGSSH 'sign commits using literal public keys with ssh-agent' '
+	test_when_finished "test_unconfig commit.gpgsign" &&
+	test_config gpg.format ssh &&
+	eval $(ssh-agent) &&
+	test_when_finished "kill ${SSH_AGENT_PID}" &&
+	ssh-add "${GPGSSH_KEY_PRIMARY}" &&
+	echo 1 >file && git add file &&
+	git commit -a -m rsa-inline -S"$(cat "${GPGSSH_KEY_PRIMARY}.pub")" &&
+	echo 2 >file &&
+	test_config user.signingkey "$(cat "${GPGSSH_KEY_PRIMARY}.pub")" &&
+	git commit -a -m rsa-config -S &&
+	ssh-add "${GPGSSH_KEY_ECDSA}" &&
+	echo 3 >file &&
+	git commit -a -m ecdsa-inline -S"key::$(cat "${GPGSSH_KEY_ECDSA}.pub")" &&
+	echo 4 >file &&
+	test_config user.signingkey "key::$(cat "${GPGSSH_KEY_ECDSA}.pub")" &&
+	git commit -a -m ecdsa-config -S
 '
 
 test_expect_success GPGSSH 'verify and show signatures' '

base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
-- 
2.31.1

