Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BBEC433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 13:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11CFD611C8
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 13:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239296AbhJONRX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 09:17:23 -0400
Received: from mail-db8eur05hn2207.outbound.protection.outlook.com ([52.100.20.207]:24545
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232670AbhJONRU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 09:17:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWq8S7zRwC0seWnfIWUCdzaXzNFbcPl70GAbqfYQyqks9kanQ9f1QqX7JNgMBrGQP5yfyWr+O7AQMGBTIRJV2WYfpiw/Sy4hmC/aM7fWCkldbKafr9Zp9GtNrM7ZWsn2hKkBpm47NYdH1FooLWa7LkxDN9BTcqZQ+shkD8JNY5W8KtvSqlaVNUbwSkS4SDQYolwi0zsjrO0dMuk6xXh8aljh4k5L7rUCZhT98HyOwz+LkHNye5L9LuDmi7FQCiPGtCOjmKbvh8epq+vWhqqL7Tzxd19iE2NLwUjl3apa9LnEsW31KpOE0zSPbHasY89qvrLg6x8gqykF2WL5vztOhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnayFmIShJtLCMxXXvxj9ZOJc0Se+6o2nCWFyRk3Ak4=;
 b=K9FXpzlW7AqM9pErMSPsXipNdePjcbQgWpg9Lx/ukA+Wte4rD07JpItFmNWCsPHhag0o1MAl7fMf6ekHwdxBgbZan1PEcg+Uespas+B1uokZ617bBrC0iQGcn30V+YZgRXxNX0koZjUE0ijZ2H4Rb1BevMqZIAy9HjoMKS6jl4bO37b/X34f2M3cszvt1nb+YHnLCXeHWDp15buHu+dbeFC1cMVqQxy/LkN0JYCf4/ateYj+JplEGHddDK7iIwn1UwbsF+32tqUgYVKgLoUFjxfyf19mv9rs598a/G//FNBSvW4gr9JGKqrSv/ybMhVpEjebvHJ0PzpqxQbqCmomng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnayFmIShJtLCMxXXvxj9ZOJc0Se+6o2nCWFyRk3Ak4=;
 b=desPH96+7UNniCQUxOxJJvYPPSUKl3C86JpONdYKvXpxfrqXa9CihHK+jHbaqgfwn9stFQFGWi6KPuGvwgLoPWxBaBCJDWnLqYEqOwmVHaMqelueAShSv4/DfNXgQk+K70nDUGjDxbF1/oz/uHQ3b5y2Fv6XCl/cSvAV4naZzD8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4192.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 13:15:12 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4587.026; Fri, 15 Oct 2021
 13:15:12 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>
Subject: [RFC PATCH 4/6] ssh signing: git log/check_signature with commit date
Date:   Fri, 15 Oct 2021 15:15:05 +0200
Message-Id: <20211015131507.1773153-5-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211015131507.1773153-1-fs@gigacodes.de>
References: <20211015131507.1773153-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P193CA0068.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:8e::45) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM6P193CA0068.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:8e::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 13:15:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b81fc08-af3c-48ba-13d5-08d98fddd206
X-MS-TrafficTypeDiagnostic: PR3PR10MB4192:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PR3PR10MB4192AC6167FC376A3405760FB6B99@PR3PR10MB4192.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UmOB9eNEFG7xg0GGM7wLZHYVz2+g0t478qOotcZFHiGq4oF9KsAO676+8GYa?=
 =?us-ascii?Q?xkvDxeLLgBngNz7C52sj+UIpBnxpVHJFNeChoKorxdWQxHgD5yNcsTjydrcr?=
 =?us-ascii?Q?rd/e+ca1RPHcNNrFe5gQwX7ZDGVVYaxw88JSiFovnVSDln2G02+wA1qC+PDV?=
 =?us-ascii?Q?BeOCMA6203GJ1V85KJS7vvTDxbF8eyX6H0UEIvKWUC9UGTUE4IfnkAMwe7oa?=
 =?us-ascii?Q?vQaX0zcVI0DBDMDpJYfTB88J82/SqHJAgs2o+SPMNiC8I26OEMLrsJErCJDt?=
 =?us-ascii?Q?3O24j8aoqN4BBn6JwuWt1zVw1DassQcP7CcFQRb32tON6YtCNJ9q/U8hpdkE?=
 =?us-ascii?Q?EL+/HP0BsJSZ2Pd+phn7ONE0h93malOSdEEoD5x3HVWbuJCyxVNhyndE7vbz?=
 =?us-ascii?Q?i/ydNGhy5U1f2qnqPbbbvLxUKtjY9nRMBgVtDA/gfdvK9V5GDTrhMFfHMUjT?=
 =?us-ascii?Q?Cde9dtwVpJjGrzaLNWoOa820NtOJhQU9JhdB80UGuR/vudyviOoQ/tesQV4T?=
 =?us-ascii?Q?R/zRL/lsusjNigoCt1qkNcxDbWPKWDKmBVVKyQ6SFGJThjct/RWtldPB+MBp?=
 =?us-ascii?Q?dzHB20aLlXvh7gzIm2yJj4ygdsgpGwtczRbzO46bZInpQfurt+PcD+NNSehs?=
 =?us-ascii?Q?rpL/pU+WgohQlrFilTvKYu/8ywRIlo+EIsEb3wp138+wNLKz2odLjiJLK+gN?=
 =?us-ascii?Q?kRxVddYlfRiWHS3j8c/Vl9HEWVnqlBPZXCK/ewCJLLlyhbfHq3AgCn7xDxra?=
 =?us-ascii?Q?QhHy1fIZlMAsjWWqMEfPjdyx7ggxP0S3aMpI8uoeL+sJgP8mXFn2LHhGOdZb?=
 =?us-ascii?Q?238/59GIsBsbvfqLo8o8ORO+Z6dp+KSaDAALVSa4MWgBZEXJ1bYAwCoUWZek?=
 =?us-ascii?Q?RszYz0Bd9XSpltEbmiMu0MVldbPVeAJz2NQvFerGz0ILsXhws1etwbFtanKu?=
 =?us-ascii?Q?b2eNYHUr7TYfFswLoH9czS30/hk5u0Cx319W0gxTwX3syoBiVLj08swvMJ2M?=
 =?us-ascii?Q?5mknR18fdQh1WxBdLRIkp336aQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(39830400003)(366004)(396003)(136003)(346002)(376002)(66476007)(66556008)(186003)(66946007)(2616005)(38100700002)(6916009)(6486002)(36756003)(2906002)(4326008)(107886003)(6666004)(508600001)(52116002)(86362001)(8936002)(316002)(8676002)(5660300002)(6496006)(83380400001)(1076003)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WJQZnBmhT270vmWfa3ASMbY0SJVpAfz2vJbsLL1WjlgjS9pjc76C6wey1wlX?=
 =?us-ascii?Q?zYG69gPcRridyXgrzw0qvD6huvH2xPC1Re3WK91gVEwZrBvKI3m1yOgpKjoU?=
 =?us-ascii?Q?jHtQUPr3QSJu0HvPEjC1IONJimPTHu/C+AopsIMN7BcUH6d5Kgc9bEi8l4+S?=
 =?us-ascii?Q?p/BLt87ckuE0v5GeqVj7b+MAUhNDxrpy4ZlGFVTu8+n5a2ux+vr1phHT4Lj2?=
 =?us-ascii?Q?KWRmEVW20k4M+pkEtwk+Uc7b49Vdj2Ml+/yC2DY8ELGBhwKEji3MW/Gu+UdZ?=
 =?us-ascii?Q?EFTXCYBSRqK4JDEeZD2E3p5gOA8J1MBxQjsMXYtX8qqGJpMsd/LNJJzqayUW?=
 =?us-ascii?Q?075ax2AdPphaS6Hf90LTVwN/cgBRcWinD0VEjMm8EV+9vmqWzSF8EPx2bZax?=
 =?us-ascii?Q?4EVzilLV6D/lBU1RcpIe1L4up/ennseoRemSxAoNROjQkB64gYvYhJflotFW?=
 =?us-ascii?Q?P1YUuZZ4TEHMGG4wPWOUQ6WP0yH5liCCHj9rRLx074caBj2kOJyjmkJNCqrp?=
 =?us-ascii?Q?nX/QmVqNmsKc66UfYGJ3sW9H3wI6Em8SfmVkYQgvjPouQ7vrjk0eUCQsOPBO?=
 =?us-ascii?Q?v3ZcTc5jS7sWac9sJyA4GwPL0zTcM/mxkblq3LUY9+Fnp4bWIlbCqhzr1PHG?=
 =?us-ascii?Q?iZ1GiYXdXagnl6YqajpxkEd4zhQHigrKUtK6n0bdrO+1N6kjVuDHaajAyCd4?=
 =?us-ascii?Q?0dyIBLSGWf5tei+ae/wv5LFkj6eIqTDS5+zyDRJ2DkJpL0jZeq1ON3/YNtdF?=
 =?us-ascii?Q?5ubg1Z2joq3rLLguB8bwQ92DeZIgQNT4AmPBCMgZysiu38CY+N7NsmVtvGqm?=
 =?us-ascii?Q?0EJmJwHoVP+edGYpznfHU01NHmzZZrr5PxkFdp8znLFNVpp/rf3muL5y2V+Q?=
 =?us-ascii?Q?4B/fDBneJq8vSAiZgMsyVEMgsrlpYze6yJk8oquJWSc1YtBQo/KKWgCygKHr?=
 =?us-ascii?Q?gTmISOU5QbUpWTZyMyGmHi/dlemwNVsY3xAbEO3Brn2K77y+d2ow4DcSfS0Q?=
 =?us-ascii?Q?df/4vh6cr8XMIURgFOULUwHL7iUJJATf4dwPehjSsRyZgew+Az9yVQsccgxe?=
 =?us-ascii?Q?jERaOxMQDYDwg1PWw6nnXLQsyMjS/uUx43FboZzA7epqpXx3Bv6cgD6oDEf6?=
 =?us-ascii?Q?iADIOmPDGy3vRQBGqL/nWt65azz2O/R9UKPvABgiCb/tvgkdjaKlUNEqMe5H?=
 =?us-ascii?Q?7ymyAQkQjciBaX3MO6iuEvJneGYMv2dXOgiJKlc8m9st4WEmi14X6nVJcE+l?=
 =?us-ascii?Q?8iENVLblDNra7WkkQ4jJY6HJz2xNB3kFdLAlH1Oa+eJi/4IAOFEYY+67Po0U?=
 =?us-ascii?Q?jDwihhOTfgGQMAywBv8ecxszhKbGC3iqG7NjvaYJ3xC5WyUlUTSLmXG1iR5V?=
 =?us-ascii?Q?UrJhxyx/hM2do9fmUiYPzAzeEYPk?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b81fc08-af3c-48ba-13d5-08d98fddd206
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 13:15:12.4809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PpY95Z1eOnkFoEEt92/iLAa3q8FZp7dxIGMg2G1kp66OC4Qr60iKJEruQdT1ws/SeByH1LreZuC8fkLat4MG8xXsLZ2o+T4DUeEhM0ZFSlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4192
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pass the commit date and ident to check_signature when calling git log.
Implements the same tests as for verify-commit.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 log-tree.c     | 23 +++++++++++++++++++----
 t/t4202-log.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 3c3aec5c40..2fd7f0c398 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -509,12 +509,18 @@ static void show_signature(struct rev_info *opt, struct commit *commit)
 	struct strbuf signature = STRBUF_INIT;
 	struct signature_check sigc = { 0 };
 	int status;
+	struct strbuf payload_signer = STRBUF_INIT;
+	timestamp_t payload_timestamp = 0;
 
 	if (parse_signed_commit(commit, &payload, &signature, the_hash_algo) <= 0)
 		goto out;
 
-	status = check_signature(payload.buf, payload.len, 0, NULL, signature.buf,
-				 signature.len, &sigc);
+	if (parse_signed_buffer_metadata(payload.buf, "committer", &payload_timestamp, &payload_signer))
+		goto out;
+
+	status = check_signature(payload.buf, payload.len, payload_timestamp,
+				 &payload_signer, signature.buf, signature.len,
+				 &sigc);
 	if (status && !sigc.output)
 		show_sig_lines(opt, status, "No signature\n");
 	else
@@ -524,6 +530,7 @@ static void show_signature(struct rev_info *opt, struct commit *commit)
  out:
 	strbuf_release(&payload);
 	strbuf_release(&signature);
+	strbuf_release(&payload_signer);
 }
 
 static int which_parent(const struct object_id *oid, const struct commit *commit)
@@ -558,6 +565,8 @@ static int show_one_mergetag(struct commit *commit,
 	int status, nth;
 	struct strbuf payload = STRBUF_INIT;
 	struct strbuf signature = STRBUF_INIT;
+	struct strbuf payload_signer = STRBUF_INIT;
+	timestamp_t payload_timestamp = 0;
 
 	hash_object_file(the_hash_algo, extra->value, extra->len,
 			 type_name(OBJ_TAG), &oid);
@@ -582,9 +591,14 @@ static int show_one_mergetag(struct commit *commit,
 
 	status = -1;
 	if (parse_signature(extra->value, extra->len, &payload, &signature)) {
+
+		if (parse_signed_buffer_metadata(payload.buf, "tagger", &payload_timestamp, &payload_signer))
+			strbuf_addstr(&verify_message, _("failed to parse timestamp and signer info from payload"));
+
 		/* could have a good signature */
-		status = check_signature(payload.buf, payload.len, 0, NULL,
-					 signature.buf, signature.len, &sigc);
+		status = check_signature(payload.buf, payload.len, payload_timestamp,
+					 &payload_signer, signature.buf,
+					 signature.len, &sigc);
 		if (sigc.output)
 			strbuf_addstr(&verify_message, sigc.output);
 		else
@@ -597,6 +611,7 @@ static int show_one_mergetag(struct commit *commit,
 	strbuf_release(&verify_message);
 	strbuf_release(&payload);
 	strbuf_release(&signature);
+	strbuf_release(&payload_signer);
 	return 0;
 }
 
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 6a650dacd6..2b12baab77 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1626,6 +1626,24 @@ test_expect_success GPGSSH 'setup sshkey signed branch' '
 	git commit -S -m signed_commit
 '
 
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'create signed commits with keys having defined lifetimes' '
+	test_config gpg.format ssh &&
+	touch file &&
+	git add file &&
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
 test_expect_success GPGSM 'log x509 fingerprint' '
 	echo "F8BF62E0693D0694816377099909C779FA23FD65 | " >expect &&
 	git log -n1 --format="%GF | %GP" signed-x509 >actual &&
@@ -1663,6 +1681,31 @@ test_expect_success GPGSSH 'log --graph --show-signature ssh' '
 	grep "${GOOD_SIGNATURE_TRUSTED}" actual
 '
 
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'log shows failure on expired signature key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git log --graph --show-signature -n1 expired-signed >actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'log shows failure on not yet valid signature key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git log --graph --show-signature -n1 notyetvalid-signed >actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'log show success with commit date and key validity matching' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git log --graph --show-signature -n1 timeboxedvalid-signed >actual &&
+	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+	! grep "${GPGSSH_BAD_SIGNATURE}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'log shows failure with commit date outside of key validity' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git log --graph --show-signature -n1 timeboxedinvalid-signed >actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
 test_expect_success GPG 'log --graph --show-signature for merged tag' '
 	test_when_finished "git reset --hard && git checkout main" &&
 	git checkout -b plain main &&
-- 
2.31.1

