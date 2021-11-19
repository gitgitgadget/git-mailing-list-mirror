Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFE6C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 15:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24F52611CC
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 15:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbhKSPKS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 10:10:18 -0500
Received: from mail-cy1gcc01bn2015.outbound.protection.outlook.com ([52.100.19.15]:48455
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233837AbhKSPKP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 10:10:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzQQR5fNxOhBH+swrCfifQxVq0GcBQsdebnlbKD3DODPGU0992ff3RlGxLcv3upfaj9yVqObYtCh2edc7OC6XqxDfCUrIroudSMQ8k//1Keo59gIOnLwJXkDuTd8kX05K7MIF1iGWfYc3d3u+X78pbxdueidzYD0zgjqcmI5I7ivnibjFDl/02HsT6Fnd7Bs/DWtKaHu4kxnCTRvDZ5deiYQwlkm+g1Dv7AiJLbkEn0bfhO22bIbtGqaDo/Hpmuk1PlrRxeKgulRWlMoyxEqkzKNgKCk99Wp5fdS3HTTwSF3L0jhd8wL2nndJCaA2VKyj2nLwPUV40qtfVH9z2ADBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOgr6lHIaAGCeiEdUTSoWAMuMyI09RQYOLAj43nDVZQ=;
 b=ods5gei0fVhuCElWsxuIoV4xjQjggDZeObwBchR5nGbjtB5+xQIfd7rhaNfQ4aXI98HTanO5+o8HBxat1KYHxNIIHla0byk04E+hZdKJ3AZUepE4Wvh0Zwsgb4hfO4X2XK2rVdNM6VIX0MbAuE6NOrBsM42Dqcqp1YPBzIl54jRD6tngvrU4CZqgNvc1X5uLwSs+rk7b90BSLPx6d1hPkb1bcAZqMp5wuQPJIiw2Q8/gdwPLFATCn3/gHpv8v5tr4JDvOTRRkS6fy2GkSUL23iKBCJtpP2zP0uF1B/0oV9v+IJHwobRRA+koIjvdz2eXrNCL0NquEh6VL5rFzyAyew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOgr6lHIaAGCeiEdUTSoWAMuMyI09RQYOLAj43nDVZQ=;
 b=YVTxRsLzBwRZI0AplKh8Cr/7wt+xwTYGjAAwS+zrPPG2sad5+J7XsHs43DAPn+cNZGo/7rm1yWyglt4bln1QRDAb5iWTZU402DtFQ3nxM1DI+NACRliuWUIItQE9n9ZZQyIdNKoiXEu8HL0F+P2C1jfgwvE77mtx4yFrYSBom7s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4207.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:94::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20; Fri, 19 Nov
 2021 15:07:11 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%5]) with mapi id 15.20.4713.020; Fri, 19 Nov 2021
 15:07:11 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v3 1/2] ssh signing: support non ssh-* keytypes
Date:   Fri, 19 Nov 2021 16:07:06 +0100
Message-Id: <20211119150707.3924636-2-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211119150707.3924636-1-fs@gigacodes.de>
References: <20211117162727.650857-1-fs@gigacodes.de>
 <20211119150707.3924636-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P194CA0102.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:8f::43) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM6P194CA0102.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:8f::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Fri, 19 Nov 2021 15:07:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2ae60d1-c5cb-4c77-9236-08d9ab6e4380
X-MS-TrafficTypeDiagnostic: PR3PR10MB4207:
X-Microsoft-Antispam-PRVS: <PR3PR10MB4207F2A51FFAE5E4579DCC28B69C9@PR3PR10MB4207.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/GOZixOBpv9tU7oSPjRyyew02p6CC+9NPjpZ7Tf3IrWvBwfxz/h8EYS5QC7f?=
 =?us-ascii?Q?TURHz9FgvbdiqeJ8xpZv3Tz3ry6AyQMo6Rp+MoJVoy4sneeXy1ayGL4bZKdJ?=
 =?us-ascii?Q?SydZ5mCdT3sWsujrjqlRvNKWcXD7XWnqtKHKEK3IW7jmDKuv8IioAqMf5mfW?=
 =?us-ascii?Q?oHCljHKCfO6demDjwfSRo1WXtUZJnxVX0gnCWMD+inAj3O5COqE7H1rMsZ3d?=
 =?us-ascii?Q?jsd+4qGwBGoHjsk8sKaQIFWXB/I8hrAom0AQVO1+Gcjer/G4ftJQfylKV1t+?=
 =?us-ascii?Q?kFIj/KIfxFVutAzzkMvRCTPz9DAX1wTsyn3N/Cq/caEhlG+50v0WXqdc4Vlj?=
 =?us-ascii?Q?d2QiM72sa1ItNyLVfyL7v6Th+MSq3VoBFkNpHJf9DQDZEkjeR+mWXRDQ534k?=
 =?us-ascii?Q?X4UqBTF/qatVesAA7UZSrNjQphW5uIg4c5qXd5C1/ni91kOHTIhDVKAKNYTQ?=
 =?us-ascii?Q?vlnxGsVY5U0L/h7sSDTn7kYyf6yGwRtOs90tZ0b2uuh7Hj7TCI+bNrrv+r22?=
 =?us-ascii?Q?uWuhvNQyDJMAabZTckFCSQ1SgM0BPVzzB/v1Qv4w3z79abL0vzpYb0/q0HGF?=
 =?us-ascii?Q?dIkzihdz10oLUz+4riGPoAu1C+xORVmvYrakeWZOLptNYzgMyYjzjOh/zfB1?=
 =?us-ascii?Q?ptF5ADy1llYkjSK4CwZAfcbxRxwnoyhPCRwp5WqYC2eQ9TGq+gW7IqI2K+OL?=
 =?us-ascii?Q?s/Qwy0S7Mge7Y7iW8XPvFRrMUW7Oxr8cs+hWSXAcNIm9GZosoEkTPUlS8BmO?=
 =?us-ascii?Q?xsJ2Qpdw5Xx5Nuu05d8JMtsdm4QDUcQbWfpiyWA9aSNlP9PfeJ/hl+Hlhfy9?=
 =?us-ascii?Q?9DsYIer4fyo3L8h6/9tLqIhWPWoouTaJUp+HndatnbqNLirM8t2db3ikmXsh?=
 =?us-ascii?Q?9OvSsd5M8Bu6t6U/3vka/WrIeV9hEIXV8hdpx3cfJ0bKtdj5siOeU1EEtTJq?=
 =?us-ascii?Q?HERihvY9dSYLUu/iBOiCHDXGu9/pypKMD+1m9sZgrCPVZ43Whfr30o2viAYe?=
 =?us-ascii?Q?+d4jv05iUmwr67UBU+4XHGSJJQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(39840400004)(376002)(396003)(366004)(136003)(346002)(1076003)(86362001)(186003)(316002)(54906003)(66556008)(66476007)(6666004)(6916009)(8676002)(66946007)(52116002)(36756003)(6496006)(83380400001)(2616005)(508600001)(6486002)(107886003)(4326008)(8936002)(38100700002)(2906002)(5660300002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2cYlkN0XfZZ1jnjSLL92n9P4kC9HdSuRgXlgHwek7tW7hGavoHzPzoGg2bIA?=
 =?us-ascii?Q?j/LPMqTM53l6UUvE6rfSbdAJJAdrlVhUYQGljqHktDXIJOFAouX7DhPX8ACJ?=
 =?us-ascii?Q?Dq+3lJRQRJ7fGdBo3JwK2358kMZvM10Nl/gO3CjaXmna9CSK5K9ZoSoP65Q9?=
 =?us-ascii?Q?SsqK9D/AghEktPqIBNWDmCKZ7BZWa/lUT7aJr71WmUH3sdvKa3BcaSWaL6UF?=
 =?us-ascii?Q?VnH6r+wH+sqRHCL+SZosmgGgowgHUehlxyYmtu9mc5HBkEwIw0oNoRZGCLXV?=
 =?us-ascii?Q?vuui/FCQJhyORGDSWrcnYJeno6t4q5IObinh9KMtoIr8EWAT9QJsQGpJM8/x?=
 =?us-ascii?Q?PTPTJcbBhurMJNS5tF+nwg2a7/m0/zRrZMYbzTSG0khyU7ckLtF7Hx+pSn63?=
 =?us-ascii?Q?+cTQtslkKM7VCXACEr9NvBRg/txq+O1wemwl3yCErhq/XsZhuUHOQZ04pNVQ?=
 =?us-ascii?Q?faSry0Qjl4OrNBMGij1bdt5myeh1Unq6vKI5S7KEFZkcn/xoCRynVxBDcgzF?=
 =?us-ascii?Q?Q4wjLIVlHG49noHk/ZN8XB1mMD22mwYtGaH1Pe3/Svp14XHHNViqyTJiC8Wf?=
 =?us-ascii?Q?/4G0VEUeFITF0JV7X6alZlraEEl07G1CO6NyYpjh7v69xD5SZfyPvSz+0Rx9?=
 =?us-ascii?Q?z8r8DVzCbvdxZglTfaP6xpIynlKX3UWGb2OOpXYf9RBbZHoOIcrhD1aqMhXT?=
 =?us-ascii?Q?5kjcsx9oTB+opwZfnUyAocYpCP+6Hv9xKFe6FOxnFfBxw1n19PHHT6qsWjfJ?=
 =?us-ascii?Q?3X+w3tjBdn1/Mq0DatI+4+UcgasWgNnn2uWuITyGj65H4XumZh7WKi8LJfxi?=
 =?us-ascii?Q?V7llFZZpHuxNrqTW/WbJOm043MKbZr6KsyU+XtnwGnJ9lsCHcpkm5umgpWwF?=
 =?us-ascii?Q?7FuVSPyYWWJ1vR2cTgt/43VXVr2Nxcen5CFwLbSAbPjrNb8enXnAcvNnDLdP?=
 =?us-ascii?Q?YUm1DGjEZnLU0UDmJleGdbnCjRS4NpX26ocyCUb1qEQb5nCIfWq+EHWcqtYF?=
 =?us-ascii?Q?23d3O3QNUNFYXF1K+drtZosPNDTzX2Tklyz0QlhmOmzTD/A8iT1+8f8ArKu4?=
 =?us-ascii?Q?VlUuhyMWA/argmv6DcM7ibqr/LNYCS4sdc9+o2dNflQeeK8+GbQrruxfPwRz?=
 =?us-ascii?Q?aV+t/ZeFGee2lQjzafeC1Cx+ZRp4p1PYoBJZ82SPUlyFiPnWqw4lpfpwZSX9?=
 =?us-ascii?Q?PamAYW599dL45DZ9pekbQ6DmbnrMfIzfwrA0WwmUIRXWIHOoJcP9W8zKi9oF?=
 =?us-ascii?Q?bzbt1uPlIOGyDKPNn25Zch0ZRhOYlNn5yVNTkOP88lbCstwrVn2ljbcBEe/e?=
 =?us-ascii?Q?1F44RGJcyIE4t5ucEhRbZ4zptPpFf9MuFAdE80dI1Y+9ULArGm2Xa65zo9m+?=
 =?us-ascii?Q?UnBs52Ojv6r0P3TE3K0PvsJ3Bsj94N63hncBPORsIQ+XzLCoe1XA+EUITHR/?=
 =?us-ascii?Q?NX4J2ylI01mEsGsE0A04docSL9RpjmfxJwRtaJATJaACD1ZBCP+alGpBbLMc?=
 =?us-ascii?Q?RzRFn0GiqcyZXXKI8V5ziSMCI8lwNqmFGrpgvL462HInSCZ/q0UKD6aOqNVQ?=
 =?us-ascii?Q?AT0nEVE7WelfGomWTvmk9goxcIOEIbTX1SJouClXVE1rC29Qp1peFA9qChlm?=
 =?us-ascii?Q?3765ZYm4Nz44uRGODMPCQUYaKpjU0ANS0TzFUJckyIJzDnXKgTL+/F0CIevt?=
 =?us-ascii?Q?VSgSVMqL3QX33efSKTUULqOd1HS0j5XzCTy9q6Bg65fTiNXreE1PJaogys7O?=
 =?us-ascii?Q?xL5rX4P2qQ=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ae60d1-c5cb-4c77-9236-08d9ab6e4380
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 15:07:11.7773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: myK4bz7iQJM6+nicbcsNg2zQHeAozawuo85W3nMtf+1R/F8axm0sKGaP+sCsJVCLvmilWwHu2m0LgxsSOdLTKJalhSEPfixfdoymavpimLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4207
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
 Documentation/config/user.txt | 17 ++++++++++-------
 gpg-interface.c               | 36 ++++++++++++++++++++++++++++-------
 t/lib-gpg.sh                  |  3 +++
 t/t7528-signed-commit-ssh.sh  | 24 ++++++++++++++++++++++-
 4 files changed, 65 insertions(+), 15 deletions(-)

diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
index ad78dce9ec..ec9233b060 100644
--- a/Documentation/config/user.txt
+++ b/Documentation/config/user.txt
@@ -36,10 +36,13 @@ user.signingKey::
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
+	first key available. For backward compatibility, a raw key which
+	begins with "ssh-", such as "ssh-rsa XXXXXX identifier", is treated
+	as "key::ssh-rsa XXXXXX identifier", but this form is deprecated;
+	use the `key::` form instead.
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
-- 
2.31.1

