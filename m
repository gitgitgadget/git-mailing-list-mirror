Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DB8C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 16:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43E97613AC
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 16:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238512AbhKQQae (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 11:30:34 -0500
Received: from mail-ve1eur03hn2241.outbound.protection.outlook.com ([52.100.16.241]:52612
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230016AbhKQQaa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 11:30:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1alJWyedPlMzTPMaNR+l4aE6c0DKBV1jvRNHeSS3nGcLlansggjwQ1+R74+RBUdNCjOALOMpxwaOGWCvDjxh4n9njd2sDe9s2DcxhT8V/MP/jbJTr2epRuLEGXlUICOvj29dH0wH86AttzE+s78TFClGVQ5eXhPjbN9rLoIbyHmF7L4CwgvGWfjM8hTdQCJ0oUx1aCAbHCwQl5DUFTfProYGq7v1bAF2IVPakuBF3ON/d5j3Ly4SY1EYmUGXanNxbG/L1RuowN1Qzbbyq2w536iYlynuXf5lKiIKwKme6NdNMo5UZCitkoCTtEzZ2ogbhLuRereIgso9ZLakDb72w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1NVmD6z7ZQ52LoeBVsMgAspzV5gokLw/h+JL97gd2U=;
 b=GBhQby9IdB2If1+AvOXJChD9jgdrdXRN2V0pvjLANYJP6YtCB7EJmcPKy6+VTFEkFUXRH2Q+ZgVdkrFyoR1HX741/Kvz3DbnXOW4RISrVQgshxMEmrsKuaGM/8RuVS6sJW+17yAOICaO1yEpRhKGH5tZsUQ+h36T5D5kaz4YgDTdBFtsKAl42KGzsXXhCDi7bJ9I+yIzXoJdv+8iWQ+deOt8vJjomsRxstyCthkgXVLXGIuWetMpcOKOfUR29Kq0/iZIY3/7f/t124SvX4pwcurFGADgt02RsCys7Cy1Xp0cYNwfqJ81wTy4sjy+PTLs58ON+kjIq5edrmVx/1cHew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1NVmD6z7ZQ52LoeBVsMgAspzV5gokLw/h+JL97gd2U=;
 b=GzJUxGkfpIY0QsGv0zHXbgbHa+v2AU5qhAVFtOhykHDkYKvnkCxn1SQfTisGFw2YxK4YUgxigXsz9Mm+d8axwNhDbLB75JRFXdwXSAXQP+FAG/DeiKxpde9fieu/fGM7GV3+tb+36KJEh+ly6ACBnSIVA/sM8WNRxpaWN9yiyIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:42::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Wed, 17 Nov
 2021 16:27:30 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%5]) with mapi id 15.20.4713.020; Wed, 17 Nov 2021
 16:27:30 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH] ssh signing: support non ssh-* keytypes
Date:   Wed, 17 Nov 2021 17:27:27 +0100
Message-Id: <20211117162727.650857-1-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::20) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by FR3P281CA0034.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1c::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.15 via Frontend Transport; Wed, 17 Nov 2021 16:27:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 154d3634-c4f5-4084-e77a-08d9a9e72695
X-MS-TrafficTypeDiagnostic: PR3PR10MB3881:
X-Microsoft-Antispam-PRVS: <PR3PR10MB3881903B588A556E9027BD26B69A9@PR3PR10MB3881.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:164;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6K5d0ENk6Z0WLq1UbB09QSa9C8m9sNfqReRAEs8vVhC9W52EyuJpRUGGvkax?=
 =?us-ascii?Q?GVqqibHvOudZcCQzwHGmBj5z11a6dNq7R9+W6uRfw3iuS5Tp1Pvbn1yjlrvy?=
 =?us-ascii?Q?aK25aGmD1FC5MwCr6EwQd0RF/rSiC77t7PhIcC+TqRadlLc99YdeB4q+BaHC?=
 =?us-ascii?Q?oEe3kmr4HLs0v1xXQfZYgEenuGDVReOnvHY9saAmcBWE15pFL+JSoRIQ8vch?=
 =?us-ascii?Q?Nho9a69o1BDunsXG9RhDg6apnS+sMtZcJETXEldFEDGxFa24r2wGbQEyLc2O?=
 =?us-ascii?Q?1SHi/A8sEbqM0XnkqwRg6aXLptRZTmwaWkfKB4VC2/d040L8lr2VDbVwd5+S?=
 =?us-ascii?Q?L9uA55ceRXa9wcF3w4RsHd9zuKTNoGI7OeLt1p0IO/Xg8lTJcB9uw+JrTMGC?=
 =?us-ascii?Q?neLB/bjP0Fi6/Gush4TiJ+dBYtMRbhjnnHTHvL+1LLJdqFKZ2n0v0xNn70Or?=
 =?us-ascii?Q?QrsS8VqE24WpOIoWJAYfuytsJjCen9FlPJxEhXBccVRjlCefHjv+wjisx0WO?=
 =?us-ascii?Q?sgFK+gzhjJ6sepoljU3zepwGWriwqqydlMBLHBgGyai2gyyNRIe3FVrbJw0w?=
 =?us-ascii?Q?gL40//zoi1N0I9Aw8UXnmLBRVH187hkGhaJnZTIeKD8cs7krEc7Rck6TIBmh?=
 =?us-ascii?Q?3YgaOq5SXfn5VMMf05aqD0PMkuxCxMoz4rsll0q/EHpy+ceY/7mKvgtBk20y?=
 =?us-ascii?Q?Euc/KqSjP0/+Me0HTlDLOqf+ccTMuHzlC+UfvG9vQwH2l8pSoHyIq6wtTYpf?=
 =?us-ascii?Q?6yW/3atGeEQcV1uAsGGBTv6nhkzFUN2+gQHJb0wgGMwiGeAii4pFtyiY36Ul?=
 =?us-ascii?Q?6f+PQbESUAZGiEWiIm61lFLKmMeLJDyduHYpbFuTyQconoy8FvcC9kSCliMv?=
 =?us-ascii?Q?840nD/GI3VBPsT43j0H7OM2+oIBuSwt4bzPOyaBJSpbNNJ0Y/jv1b3eyR+pw?=
 =?us-ascii?Q?YVt7+fmGY7kl24t7PFtk+tY91vRsWTda3SsXlSh0HIqTJP4iikGOO7W9HQK2?=
 =?us-ascii?Q?zlseXAO1dg5KWmyNaqT8rTQt3A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(396003)(39840400004)(136003)(376002)(366004)(346002)(6916009)(8936002)(8676002)(4326008)(2906002)(186003)(5660300002)(316002)(1076003)(107886003)(36756003)(38100700002)(6486002)(2616005)(86362001)(6496006)(66556008)(66476007)(52116002)(66946007)(508600001)(83380400001)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dotpTjfCm3jBY3cD+UNkwo0vyXnZXzYglWXxWDGlB2KVksPXHG97S4S+aarp?=
 =?us-ascii?Q?DrvSL4Yye9jTvv+sMqDdAOk2vc3FZ8ftbDKB9FFF50uaavNilFKLRvJ3kL5F?=
 =?us-ascii?Q?TbuErLSoTwzprLbvn5tt6aNawLz8AW+UzYqy0IU50h8Cv+Aln3+m5uiJFGdk?=
 =?us-ascii?Q?A0FSRfusc62z0vE30e1ALSQ0n5KR34GU00iffTp4IRyoS/lsq5+LlN9yfUPg?=
 =?us-ascii?Q?K/KAPWZe3lHp1lyN0HadJs/0QR1dA5O4nf7a7/EI/ytkL89IvMcnKt7gPDUe?=
 =?us-ascii?Q?Maqdxql/nhKCMmIqZwEINf4YLJbSBnwM9cbZRXUtSVUXI6/taiqjmiPZgUXE?=
 =?us-ascii?Q?/vGLdi3aLAkHYNnib9oqHQv84F6WSZP5hAj9AMnMOHVuFNSTT1z99IIqKFF8?=
 =?us-ascii?Q?/uu/uHVYXo9W9oCKTslQ8lMrT9ooBv/oJMH7N0awaIDsTYPH9fMXticDrnYp?=
 =?us-ascii?Q?9wEBZi4u36Fq+6VV/v+Vcgo8Yx+oWPC13/4GR3zzAJScWyIbx1q9raAFyaE6?=
 =?us-ascii?Q?l4q1LIEWTr56h0v4/zK/mkEd0gajmvMQ2aAuvyEiyb/HTZp5wap2qZNm3mbz?=
 =?us-ascii?Q?s5Zpv8y4ettOFf0khGBJLiQjncH+tUPXpeWUBreuoJ0ahlf8UIUlelW+fNQV?=
 =?us-ascii?Q?MkzbnaUVVDOFMjMTztyy9UGE4OcQRAO5/4D/pfqaWSOWA/szHzy8Hfe1RhNg?=
 =?us-ascii?Q?KHzUgjDW6Y526WPPlPnqjj8KV2Qh5JBFXwixAsjHd2LvEvCMTuljGVhTfwJK?=
 =?us-ascii?Q?FF6lIqBLYrk7bQ4DUiAvhuavkrCuuUCw/K2Eoe0w3PTIW+II7pPlFpb9cWTw?=
 =?us-ascii?Q?3iDk3WEFnxetwYju+jE0UgFBneMWCrC7Mf/uJr9910ZKsL4FZAahDUU2PwK8?=
 =?us-ascii?Q?OSVBJuvaOwGky2+fOk/dSgQeA8lsfAkBbqzgxA8mZO9XYEArMjaPK6URNfQ7?=
 =?us-ascii?Q?YDBZpz/PFMgOJyfbYnSre2uru7ufG4SDtcUPW99POnwQh0BWlmaeNHjQPVFB?=
 =?us-ascii?Q?o5bzzS5yND7CljnDoY0r2BgyM67k2RYYkZc91X4Xs0+nRmyNcpgCZMEIOpXk?=
 =?us-ascii?Q?z5Fo+7GGkcuWbXO2ytbAv4ai8sabxMpv8gWwhhk+lUyQIkQxeSE8QwXL6mLx?=
 =?us-ascii?Q?hT1qgUtUO6WnDLHZYzYxulrJNxXlqaad95dAHN3Z3KEEZuyAGCmef27tZrTk?=
 =?us-ascii?Q?iP+Ne49bxDQI1LlpCj6USIJ5F9H2HdAxZskG2vzsKVFDIZrOSeACxv2M+mNX?=
 =?us-ascii?Q?2mNg7BO9dX5ydczqvak91UQmrQ4Dbxb7fGzOL+f3ncqwv8hVg9gZOs+oxpG+?=
 =?us-ascii?Q?3acZoo3qf2RfmB/KtZhFAh/s/stRqI3kyUlaz+nfuvCatSERjE9XCI5i39XL?=
 =?us-ascii?Q?Hh8j9EpYvRWP2SxTBmYJN2TSYnc5so9oN81XxvMNu6s5QFpstfsUF8ra/e9k?=
 =?us-ascii?Q?Duo49wsswrqW50hrHuHP7VEU/8mFlTp/k3XhUqpcQoJSaaBfBHn5AWRmWut0?=
 =?us-ascii?Q?VzYLsYMKMFjqBWcXWD5Z1qLNjNxti/3VpW/tFpCmfmzKdPn2ZEsV6npWQ44F?=
 =?us-ascii?Q?nMNXoCDlv+VQdCtxIuQEbdsS1EeRa8PZinUDopF/4Na8CIyMbFjbDmtSNjAW?=
 =?us-ascii?Q?IHhbmNmVJTR03dEqomOpm856ME5hc454vzT/u//Jy7xFYZY8+I7bFi3UoDwO?=
 =?us-ascii?Q?D3SZORbNBX4HbErdFM4PhvKwVvrj7/oL5eotGPBmG7SrpX5jV9KC5x6q7SlO?=
 =?us-ascii?Q?rvjDOZ9trQ=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 154d3634-c4f5-4084-e77a-08d9a9e72695
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 16:27:30.0270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2vf9SBU+dU0Kt1exOyP8Dau67XTlMiPjQ+Ir0P4I5zrdA4gEj4klL2XSXEjLRNR6eKq8RzH1miWB+Nx2Pln+K9zD5aYucO8hhfiTrhnveUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3881
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
function and add the other key types. "ssh -Q key" can be used to show a
list of all supported types.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 gpg-interface.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 3e7255a2a9..dd1df9f4ee 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -707,6 +707,16 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
+/* Determines wether key contains a literal ssh key or a path to a file */
+static int is_literal_ssh_key(const char *key) {
+	return (
+		starts_with(key, "ssh-") ||
+		starts_with(key, "ecdsa-") ||
+		starts_with(key, "sk-ssh-") ||
+		starts_with(key, "sk-ecdsa-")
+	);
+}
+
 static char *get_ssh_key_fingerprint(const char *signing_key)
 {
 	struct child_process ssh_keygen = CHILD_PROCESS_INIT;
@@ -719,7 +729,7 @@ static char *get_ssh_key_fingerprint(const char *signing_key)
 	 * With SSH Signing this can contain a filename or a public key
 	 * For textual representation we usually want a fingerprint
 	 */
-	if (starts_with(signing_key, "ssh-")) {
+	if (is_literal_ssh_key(signing_key)) {
 		strvec_pushl(&ssh_keygen.args, "ssh-keygen", "-lf", "-", NULL);
 		ret = pipe_command(&ssh_keygen, signing_key,
 				   strlen(signing_key), &fingerprint_stdout, 0,
@@ -774,7 +784,7 @@ static const char *get_default_ssh_signing_key(void)
 
 	if (!ret) {
 		keys = strbuf_split_max(&key_stdout, '\n', 2);
-		if (keys[0] && starts_with(keys[0]->buf, "ssh-")) {
+		if (keys[0] && is_literal_ssh_key(keys[0]->buf)) {
 			default_key = strbuf_detach(keys[0], NULL);
 		} else {
 			warning(_("gpg.ssh.defaultKeyCommand succeeded but returned no keys: %s %s"),
@@ -894,7 +904,7 @@ static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
 		return error(
 			_("user.signingkey needs to be set for ssh signing"));
 
-	if (starts_with(signing_key, "ssh-")) {
+	if (is_literal_ssh_key(signing_key)) {
 		/* A literal ssh key */
 		key_file = mks_tempfile_t(".git_signing_key_tmpXXXXXX");
 		if (!key_file)

base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
-- 
2.31.1

