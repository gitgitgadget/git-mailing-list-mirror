Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD976C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 15:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C47496108D
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 15:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbhJVPMY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 11:12:24 -0400
Received: from mail-ve1eur02hn2210.outbound.protection.outlook.com ([52.100.10.210]:57385
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233086AbhJVPMX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 11:12:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPTXXO36YzlYaVaRaxmggVTXfV+hwzDFaThRmULkTtDwsdt0iCtfl5qgDUCdamNblsIRRPQcGQ1QP04QKFOsw5r/tV/DdHcrYAxdE7WAcQZu5MhMe7UGyRIkcniykV0+tAx6CP+ofPzSbCgD/GbkKWPx4bSccciTUbKXAxqgfQsHUE75n0UBqTiP6xdQvFSpAIwM/Jde2a16Xmhi0MwH+BJP+iuD7T05oeUb4Pv9RxYGteKo87HNKQU/UQmOkX2F63IRs6JOrqae5Js5htw0tkisw1h0xEEFXnG8Pls33GFT8JL3agIlEQhag3+lvopSoDv/P16V16Hn7wW7xiCE2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usNSOsJK5NSYauxvl/8Eiwl6Amq7n/WAgDVmTOxjZHk=;
 b=Yb87t3UBk7Gz2Pf2QvoqZDlyK1OcLLgPXPyncHBTtsB9e+Zmy/AaE9Ggh972qDv9RqxjjACPTB4xr7Ppynip8pyfBcSxhNbZX9cpmiv9Is5yj3k8ZjXbgkWxlp7IcdI3lUKogA4Myegg56W9Mkz67IrHMWP/q4fnAiecM6h9m3kzvUhYW8yFcdC+xvvY9ai2OXapmmHNZQdfbmCUrSyh4jhr4FM4XMctZyHOvWop9Kbc+Zsn57HyzrRh7BfFf4iU1VaHmxBAqbUB/TB5LOlePnhpz4fmNh4EGLzY8glOyHfWBfWGWoUMxFahvm0z35RcPJZiJB5AgdO767m0kLL6nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usNSOsJK5NSYauxvl/8Eiwl6Amq7n/WAgDVmTOxjZHk=;
 b=v4RH/eFl1Sf0hIjhvsyxSoLRzTAhIC6fOWP/vKYhlsyatdYluAv6g3Ay2R3YM6M6bDQ1PZPhOoVRudRNcG/5jcucPTO/1J4TfQGA3jNOxmWxcK0RSZveTa28gVb840251eqTdmU2dn0YokGjxWY5VjC7hraseSWFBPwnv8PSmwQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4637.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:15b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 15:10:03 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 15:10:03 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>,
        "Han-Wen Nienhuys" <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Hans Jerry Illikainen" <hji@dyntopia.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        "Felipe Contreras" <felipe.contreras@gmail.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Gwyneth Morgan" <gwymor@tilde.club>,
        "Jonathan Tan" <jonathantanmy@google.com>,
        "Josh Steadmon" <steadmon@google.com>
Subject: [PATCH 1/6] ssh signing: extend check_signature to accept payload metadata
Date:   Fri, 22 Oct 2021 17:09:44 +0200
Message-Id: <20211022150949.1754477-2-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211022150949.1754477-1-fs@gigacodes.de>
References: <20211022150949.1754477-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0601CA0045.eurprd06.prod.outlook.com
 (2603:10a6:203:68::31) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM5PR0601CA0045.eurprd06.prod.outlook.com (2603:10a6:203:68::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Fri, 22 Oct 2021 15:10:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 571b050c-7772-4633-f2df-08d9956e066c
X-MS-TrafficTypeDiagnostic: PAXPR10MB4637:
X-Microsoft-Antispam-PRVS: <PAXPR10MB4637729AAC98B928DDDE408AB6809@PAXPR10MB4637.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BDmTp2E9JfEnR2ZTPUsrQsuRljvi+JHE6RpGVjXIWYDreOaeyCIagyQUeoZf?=
 =?us-ascii?Q?aTEQA+S6DHgwZuBnsIBoFWLyd8uhDbIDQUwrTgbr9fb4CKLh4mvWf6EWDXG0?=
 =?us-ascii?Q?EUrSqqRPQooMFtMLa44fLBCpHytV0ZeDWLCwVfwbFvbUHwxK4D5fA8cQhsvp?=
 =?us-ascii?Q?US/qs5XKeYzPw2Gl0pM3XKQTiJp2rqPD/LxBztTAW0zaXUvWBpwF4dGIF4bM?=
 =?us-ascii?Q?Eh3G5tdo1pEzhcvdH9Tc8fRaHVb5REmQBdRxRflSlQg7tRnPkF+a+03KT0cL?=
 =?us-ascii?Q?2tfoBy34RDPFc9gtNqVbpZrP+NazZnGPUbRIgUDG5zARjziIz0/rOjVXq/9J?=
 =?us-ascii?Q?TP4LpmytVyaxMkDvCQ81Alpy5yu6a187A2/GDfGeGW9TGVt/7dNhPGZ3x1FT?=
 =?us-ascii?Q?fIpqFCzYph2lR7FYFI1ogLv8u5oGSNnkmMYns+u2GJeaCra33VobtPp9jSi9?=
 =?us-ascii?Q?ofkGh/qCgeXdgKcaV+oy9uwEJ1rwhbSafLODTcP0Usd5NvJwcxydUuWDTsC8?=
 =?us-ascii?Q?ucPG7r9r8dmEDfwUWPi+2w1qiq3UolPCGhjkFy4bQbBBaWPwAxkZNJkAfBYv?=
 =?us-ascii?Q?mDu3lADE9pfCwCJuh/UKzavk5H+PEYxMThUgEoc7+qN9jXw7wR9D8EXUFTv8?=
 =?us-ascii?Q?C3CNnfdtwf0jI5gP0vRvAJ8zr1U9RWNs0gm+7yvRrdYQJhrKtCZq4ElvcQvQ?=
 =?us-ascii?Q?FWKk6cBwyAer0s5CCORF1jwB+aB5xxcANDzpvd2ctGOBDxZKBqgBe21OOObA?=
 =?us-ascii?Q?jBdSrGvnzwnRdIfh3HGDxM7jIwLsgaP5fjUtg/2L3NV6y1c4Uwn6sYVW1iKw?=
 =?us-ascii?Q?lqqibueEPt5Cz1/J+qInPna+2cnxkmJc7oz6EcL0PgYAuFsH8t8ycm/JhlTU?=
 =?us-ascii?Q?EHl79yzenIVL0V79XVQ4M4GoW57IVsDWLV6Ro8OzCZTTrObmKLfle2hl+mrt?=
 =?us-ascii?Q?/SDSdccb8tQ1t7wjj98mt0FpWAsGSrVeL19tpWOhbP3a9l7hYXragsaUCTjf?=
 =?us-ascii?Q?n6vKj1DkxIflRoJwkTdBGfTr4Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(376002)(396003)(346002)(366004)(136003)(39840400004)(4326008)(7416002)(186003)(6486002)(2616005)(316002)(66476007)(66946007)(5660300002)(8936002)(8676002)(508600001)(83380400001)(38100700002)(66556008)(2906002)(6666004)(54906003)(6496006)(36756003)(86362001)(6916009)(1076003)(52116002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0RsPwhP1VydQHTuVzWTSJ6F87J+TsciYEsSGpzs7vtdXyZpm0jRnkTAmQ42Y?=
 =?us-ascii?Q?eGY26CNu7LKNd/X9iuJM7te+oHM60vZfSZp6TtRDLxiOvU6uWkcvi37Kclzi?=
 =?us-ascii?Q?+qKZCIrjeuB79hQ5Ybx6JjazdXELqCVotP4znl41GjjwmUS3M8UhWV0QpLOR?=
 =?us-ascii?Q?DXXRyZbsEX5XjBE2LN2ojS/b8Rh2DlW18CoRFo7E7ogmP11MNL+xj8qMTmn4?=
 =?us-ascii?Q?3RaTnTr0g+WTCDlptoRDYtNkisGu0IU3cBBcTZVHPXx0YCIDeHKAGxBlKwp+?=
 =?us-ascii?Q?+BKral4zIdkNZagDoZ7+3KaJGs+uMf/B3BgT5mlQEch1RvlBu1bgEl2CBjif?=
 =?us-ascii?Q?Y670FA5fTGqYTf5Mj419DthKO/nPZxjYMcepql6c+9K4Yra8h/xDyF+sWHwZ?=
 =?us-ascii?Q?9XvK2eGoZ5eGYaoqoJYo05s+0IYrrHtosMR9A8RNX+H+cmDYXu/7u5grGybD?=
 =?us-ascii?Q?ghWsN0Pg/zwUnffhkESnUIGDZTjBcr8bpSKE9K8rSvYE+b2HcUSe7gb1bbyh?=
 =?us-ascii?Q?rF2UXttzGnWYnNHgDomIsgEqW9CUYSepN+C0LdPLoQfokkRLqbxDl8ETSHTs?=
 =?us-ascii?Q?HFmAv5ZfqNPKLHazCiQI8wNC3HzXaERADLXGcuYH/2bOz1pV6FZucJv/1Qw2?=
 =?us-ascii?Q?IMRtoJJUi1NstngyoI17lfoPqu07cLIKajMGkCfAuz67BDuVeEXIiloy9cZs?=
 =?us-ascii?Q?UUlckWCF3inTLjBTXCYe3N0awTNwepKHQK3vGPw0KJKRMhbaq39YdxgotPT3?=
 =?us-ascii?Q?u5kgb+NuYDzYcxI+htrFGqgQLBZSik6b+m48o2fBKfx68d1d3iPBy/o+WWdo?=
 =?us-ascii?Q?FuxmaJqEdEy82tgiUMHYq1jzEqqWFKpLO/z5iWH6kjPpahx+tvPX327crHzI?=
 =?us-ascii?Q?G7gz+lFMpjUHnsD2CqC7R5CPe9W5AGRbtW0VZJ5DeiAWqJfxeu09oLnMsMz7?=
 =?us-ascii?Q?kAtNDgJ5x7n7UFmWa8ZvpM+quD7MukIPSUL4dqYdvvzOb+CvrrKvKxCSkwcA?=
 =?us-ascii?Q?9MQYPfIe0MqYUireX7PRCi4cGcqVPZp7tjfEoxafnAtK+RZPjenTtQ9/lHlp?=
 =?us-ascii?Q?DwsNL/U2rH592WqC96QldepDuLxLiOPSEjYyvkINaFtie7qrvKcJW3NdIFox?=
 =?us-ascii?Q?g5fCUfV3JEXUX/DJBQohr2kWxlJnAeFcYLDuuloB9ANHSO//ymaSkrABtAji?=
 =?us-ascii?Q?AQvHC846TzIaGX0eqFC/69Wh2lNr2fWu2gtKxfCrrmrEemhGGPHRpjSofMWM?=
 =?us-ascii?Q?ImM8CvTWZl1A73IRghXbLJgjIiyN/m9R6m4YnIonaXVp7NZsJp445KeC3wIZ?=
 =?us-ascii?Q?2ZI1Sp/YZ4fTTaQUJNHYsmUSJDh3GL2vA0mxtIowFag1ejGyY3gmTtO9fffX?=
 =?us-ascii?Q?VBt8z6vjjl+JoYcSVrWmNdGmsPnxA7F12iYQHaZLxqDDThUSFC1llXVvJnW/?=
 =?us-ascii?Q?Z4vypTkFZgRASr6+GPkpW9c5P6OjqcNXRVoCuPpf5jd/2n4ansSKFS44X0zW?=
 =?us-ascii?Q?yhLQYwFTYfyJIVSEHy5OAV+lkHkrIvBUoPQz?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 571b050c-7772-4633-f2df-08d9956e066c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 15:10:03.7336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fabian.stelzer@campoint.net
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4637
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
 gpg-interface.c        | 36 +++++++++++++++++++++++++++---------
 gpg-interface.h        |  5 +++--
 log-tree.c             |  4 ++--
 tag.c                  |  2 +-
 7 files changed, 39 insertions(+), 19 deletions(-)

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
index 800d8caa67..6049f7cbf7 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -20,7 +20,10 @@ struct gpg_format {
 	const char **sigs;
 	int (*verify_signed_buffer)(struct signature_check *sigc,
 				    struct gpg_format *fmt, const char *payload,
-				    size_t payload_size, const char *signature,
+				    size_t payload_size,
+				    timestamp_t payload_timestamp,
+				    struct strbuf *payload_signer,
+				    const char *signature,
 				    size_t signature_size);
 	int (*sign_buffer)(struct strbuf *buffer, struct strbuf *signature,
 			   const char *signing_key);
@@ -54,11 +57,17 @@ static const char *ssh_sigs[] = {
 
 static int verify_gpg_signed_buffer(struct signature_check *sigc,
 				    struct gpg_format *fmt, const char *payload,
-				    size_t payload_size, const char *signature,
+				    size_t payload_size,
+				    timestamp_t payload_timestamp,
+				    struct strbuf *payload_signer,
+				    const char *signature,
 				    size_t signature_size);
 static int verify_ssh_signed_buffer(struct signature_check *sigc,
 				    struct gpg_format *fmt, const char *payload,
-				    size_t payload_size, const char *signature,
+				    size_t payload_size,
+				    timestamp_t payload_timestamp,
+				    struct strbuf *payload_signer,
+				    const char *signature,
 				    size_t signature_size);
 static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
 			   const char *signing_key);
@@ -315,7 +324,10 @@ static void parse_gpg_output(struct signature_check *sigc)
 
 static int verify_gpg_signed_buffer(struct signature_check *sigc,
 				    struct gpg_format *fmt, const char *payload,
-				    size_t payload_size, const char *signature,
+				    size_t payload_size,
+				    timestamp_t payload_timestamp,
+				    struct strbuf *payload_signer,
+				    const char *signature,
 				    size_t signature_size)
 {
 	struct child_process gpg = CHILD_PROCESS_INIT;
@@ -425,7 +437,10 @@ static void parse_ssh_output(struct signature_check *sigc)
 
 static int verify_ssh_signed_buffer(struct signature_check *sigc,
 				    struct gpg_format *fmt, const char *payload,
-				    size_t payload_size, const char *signature,
+				    size_t payload_size,
+				    timestamp_t payload_timestamp,
+				    struct strbuf *payload_signer,
+				    const char *signature,
 				    size_t signature_size)
 {
 	struct child_process ssh_keygen = CHILD_PROCESS_INIT;
@@ -560,8 +575,10 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 	return ret;
 }
 
-int check_signature(const char *payload, size_t plen, const char *signature,
-	size_t slen, struct signature_check *sigc)
+int check_signature(const char *payload, size_t plen,
+		    timestamp_t payload_timestamp,
+		    struct strbuf *payload_signer, const char *signature,
+		    size_t slen, struct signature_check *sigc)
 {
 	struct gpg_format *fmt;
 	int status;
@@ -573,8 +590,9 @@ int check_signature(const char *payload, size_t plen, const char *signature,
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
index beefacbb1e..f7c5389c90 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -71,8 +71,9 @@ const char *get_signing_key(void);
  */
 const char *get_signing_key_id(void);
 int check_signature(const char *payload, size_t plen,
-		    const char *signature, size_t slen,
-		    struct signature_check *sigc);
+		    timestamp_t payload_timestamp,
+		    struct strbuf *payload_signer, const char *signature,
+		    size_t slen, struct signature_check *sigc);
 void print_signature_buffer(const struct signature_check *sigc,
 			    unsigned flags);
 
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

