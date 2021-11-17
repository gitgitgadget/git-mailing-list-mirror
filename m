Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FDBC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 262B2619E5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbhKQJiu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 04:38:50 -0500
Received: from mail-db5eur01hn2234.outbound.protection.outlook.com ([52.100.6.234]:20915
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231797AbhKQJir (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 04:38:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSLxbAynILUUqoiK9q4l4/WuCB6XfkA4mDdn1WB5o/ykLtSlWl7APm1XMCVad9AGwN9V0KEpTnV3+9RZdbIC2fCcdsBsPUl/ybfI4tOwC+Wdri2WpQNqnCbp+XW0Jlhzx3Cbq4A9U4NNgP/Ey+SCLBg2U7ekBxlmcqWJwxJ01Q7prWY6pe9AtGHzuvgJTMZBvp/wZQkvsstI396ui7UOChXtnXxGpAfnzMNXRyCKcthxivGaTMdFsPV6kqO/TcsRLClj/a2mkfXbl9+qOSXJxqxBPTsnjjxLmQfwoJzmySBL0csOgsph/6qVP0QoqsygPIxTwtnPBD3Nr5V9s7xsqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFWk7mStrYAR15pRt33iPZVLIawsSF5hY44xdMc4tQM=;
 b=Fv+VCmfZ2+CSkORGCa/Vf4gu1X8c9219nYfKneqXRmMkFEWTvQ2ecrMKBh/nNiTEtY0rqPP1apPLMe29bq+Z6W8nJCpMwLnDCcorxX+Hf/xLq01VEgkeCNMcIoPgTMD5c7dNf9rMYzqZMlV8UV17DZTzyGB13o7QvckjjIyyZurwwgXxz6nR8dBbjbWmYRzM+LkwVpd/nsIkA1AZaRbIiPNVIC4gcjHlRN1CJdSr0fGB7AR/R4TqLaBmR0aDTusfCCSzwg3Kkz/EQ1NFI+Fej8I+3lWhcffiQxaZlguU2RJY2KqUlbi3wILNVK0aeWUZWVc+YMBeeqT8LnYBlQ7HWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFWk7mStrYAR15pRt33iPZVLIawsSF5hY44xdMc4tQM=;
 b=ZQMFCJHtEt+yUAhFxqkDpFhj3K8XDWdNIOQzT3nm7KfKogsCie+/6R1EDK9JZL20KxF0Is4+yqBIStmUADK1Zmwt7xlsGZqRzVjgmIVLTGm+vx+OT1XuCSr2tf1Qu3w9iH3ArKnSGruH9vdbyo9aWbJxYMFspx/WV4PqD2pxr2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3820.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:49::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Wed, 17 Nov
 2021 09:35:46 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%5]) with mapi id 15.20.4713.020; Wed, 17 Nov 2021
 09:35:46 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v3 1/7] ssh signing: use sigc struct to pass payload
Date:   Wed, 17 Nov 2021 10:35:23 +0100
Message-Id: <20211117093529.13953-2-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211117093529.13953-1-fs@gigacodes.de>
References: <xmqqsfwmus5g.fsf@gitster.g>
 <20211117093529.13953-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR0301CA0051.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::28) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS9PR0301CA0051.eurprd03.prod.outlook.com (2603:10a6:20b:469::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Wed, 17 Nov 2021 09:35:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9baf33ba-ddd0-4bf0-c4b8-08d9a9ada1f4
X-MS-TrafficTypeDiagnostic: PR3PR10MB3820:
X-Microsoft-Antispam-PRVS: <PR3PR10MB38202B9F814E933D3D887E75B69A9@PR3PR10MB3820.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:103;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hcw4pUA4brOhG7txCXGnNkfkQZ7GhDT4AABEZbs90rTwOuniw+Z5smGEFBg2?=
 =?us-ascii?Q?CVrxz5GwFMbeODSHfW5xoTuq6tMnAp1InAwse9TFsP5SiODZ1o0WNkqRzVz/?=
 =?us-ascii?Q?EPGOtnh2zzz4dzHvRt+bxPWvI5AWNUAZR6qFJSKFZ4dTi2mdBI7SKKJAb0dU?=
 =?us-ascii?Q?jcEkj8l9KLS53aVk4J2rNTUL5IpgYpBjAz71BOR7cdbrwqxYNwfopWR1UN1f?=
 =?us-ascii?Q?y4aF81GDJiF1fdGyIu8EL0kG4A5lPiwy2eq2y5IDN4S8l/UB97FbBR1b8tq4?=
 =?us-ascii?Q?Lk8SEwW+NB2n0mP1bFYZzm2UThDi947P6ltQ0Ybmt1xu6ABCxX7lorTTlCxC?=
 =?us-ascii?Q?kJWe1oiMqhZhRdpBx7054XvZw+kqoOcz36lC3ZsjGT7ctBUMbUxNyfqKjhq4?=
 =?us-ascii?Q?6wJaUmxpcQ9kBaL76pPxiMt3rYp9Z2GQ4UXoBrXJ8p7t+Hp5ZsjPFc0fk4pE?=
 =?us-ascii?Q?Iu3ELck6Z/UPgIJS/os1PM0WeM8f5tb3NDo/2UGcm5ceBkX0YcBivrkAPj0O?=
 =?us-ascii?Q?TZHKrpZ52p47rVBhDmLiVALwrJP8oXutKCywolZdevQHrFRpNBXwfNA+YKTv?=
 =?us-ascii?Q?vafwMBRWXritDjjNMsAshAXIB9AnIYPmQE4HK8f6VHCTorJBaW0W+rgW3/xT?=
 =?us-ascii?Q?uN3d+n8egMoUrwsdGGKsEm5BQdHIjje58ILFIKOZIbuZxboHHs7Bju2bYOlc?=
 =?us-ascii?Q?SmlSC6J/t1kN65+Qj4JGDvtYKJKUsI1er+GLu+Q2CkcOyfNsnlztdf6MLd0H?=
 =?us-ascii?Q?asWZ8a6MsSpbMgsYfqWVftYeQlRrcw56UBGmdrbj/faDyzdrS8+3kGqv68Fp?=
 =?us-ascii?Q?B9DS91iFDXLWEV9YYIdmLw0JWLDzYo6yoSh+cbmBaXYzwQvOQxpHwFT0xAlo?=
 =?us-ascii?Q?rFL0kCsOAHBzK5excDls7GIFDbIUnp8QxeXhfwGNW5VLX+xVmaNOiZBKWVOo?=
 =?us-ascii?Q?ejKrw9yGcUTNk2rvHEXZURkzNmOAf/1EbSVL6+8xTx3fjYt3tt4tVaWMX6SV?=
 =?us-ascii?Q?XqWkbVez1Wa2XStrPuuO/6zCl+51juTKr8jgNTraPuCdKDRaeMJUdLxTcuI6?=
 =?us-ascii?Q?vKC2vykE03/crRVN+rZhuJpBNBkl9lOg/rVOx07nnYEAXlYAEww=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(136003)(376002)(346002)(39840400004)(396003)(366004)(66556008)(316002)(8676002)(1076003)(66476007)(66946007)(38100700002)(8936002)(83380400001)(86362001)(5660300002)(36756003)(54906003)(186003)(2906002)(6486002)(2616005)(6666004)(107886003)(6496006)(6916009)(52116002)(4326008)(508600001)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XNDNigwFOC/MPvww8XKK43tE2zDluolrALednP79imdBsuwUCHFw4nY8MfnG?=
 =?us-ascii?Q?AAZbxPCOzeymOZZVtAwso6ZzJjwj7w/28gxcyHojjc8xTTppXAfT/EiM+KaS?=
 =?us-ascii?Q?87EiOXAUktyD3zetaa5OTE+uGQJGy9c95HJUPpZEdYS3mTq1UoDBuLet7mgo?=
 =?us-ascii?Q?LofR7VStGL/cFycVtvzqPWm4qHmThN2rILI8GOJOljcKartffdBu9vzXFJYM?=
 =?us-ascii?Q?vyS2DBSZMU50k2DKxBn/lUQOnmeN91yruP4hoFYGhe0rVwzpk3n1w+0fK/Rr?=
 =?us-ascii?Q?4Zd6aL2rdCiFp/EVf2BrvhqUAKuuRyvGGYtCTI2h9qeNKHItyu58Gvk3pm5h?=
 =?us-ascii?Q?DxySHTi5g8Je0bSKqkWdp/rRj3je1ckpIoE/XaA6qFmjQun6rMA8sLfDuasA?=
 =?us-ascii?Q?SiUuAFWfiE5mb5vu6DKegx1sMutNHvGedTfzqHs0Tz4+nm2n6E9zMoJxGOfO?=
 =?us-ascii?Q?ffPKsjiQXSi7OBwf9jskUZ4Tc3rM3gFpvveL8HikhQ5ebP1s/HDmSqO/8dea?=
 =?us-ascii?Q?bx5VO85OJx6jG6O8XWDuE5wJjkuYYizNC9mUGA2rlGGwT42yz6jaQR8AwbMV?=
 =?us-ascii?Q?JxF9LYkbVc7dlYvFMWLMpTNj759MuV9gEc7XEBMWcL/XVldBLLKIqscbEbsB?=
 =?us-ascii?Q?ZqSmMAZHaWrmVj3e1Kp829Xuokh6GxyNn2J2B7g/ULG5uLX8wwCXbbq/5zlt?=
 =?us-ascii?Q?ei6YYQIvYDgka1V4FHoYUz1o6BvlQ96WLFSUg04MEWuD70AEyzv89nU2Fz8y?=
 =?us-ascii?Q?s33oIsUU4rpTej26Ln55RxWVMcRzUEbdMeJM7g5VN5qBuBj35X+IpwQKuxy5?=
 =?us-ascii?Q?SZVd56KgYwZlzJjQnqKZFRWghWAnLmm3iICq+ociK+VwljuhMApC/tJErMdg?=
 =?us-ascii?Q?3AuJSR4r76ErdY1I8Su5Bj2tDeaUesjpBxkHC5QmhU8Z9OtgqUe1fORk+DlI?=
 =?us-ascii?Q?25cTqdXy5e5ku/hqOqAPezW+kQcps+xjtra7mXqmyHm5CzVTacZLYLDFG0hS?=
 =?us-ascii?Q?b0m+dTtD5ShhseuVDD1poOAWWlh5OGRTELdWq95FkgE8ruiVFZFLnM3bMhMZ?=
 =?us-ascii?Q?1GVx4L5PGjuUm9s/b30KSrlahLZ3g9u6gzSpnQ54w+HvOyxvdwGUJQsogjs7?=
 =?us-ascii?Q?So1x13xq1WcJYvcX2/W5BXpGVvC9ZFWb6ieNfcqKncp28Wv3uWFCXfgYCimo?=
 =?us-ascii?Q?v9gfF63WRmNFGybtjfBU721cFdAvciwNoumUNHqWP8Q6TSk2M2dp4KLoCisG?=
 =?us-ascii?Q?IxoLulwrscsf97JmtxKkXHlnGD7wAWXkfVMQwcKgvHDXmeBX4fhHRxr0YphT?=
 =?us-ascii?Q?I/os3Fll2E6rbLoGGhBeVRelFSCoa04BlvjwyTCooNHTNBk7dxALAXkryFjh?=
 =?us-ascii?Q?JCiPEjm0CKB65P2Bg7ZcGZ1zcnt3dlclYyMTGq+T1dJJX4ZmWcdmRq1ED7uV?=
 =?us-ascii?Q?XrMXaoybRnEMuiK5wcN52vtNu/FFmibqBZ/R3AEuak+AmSi0nQ8sT5w52bUr?=
 =?us-ascii?Q?DALyFTXQy3t82ywg6oyCXgE4VqL2FLZ6vCUEAQOfSGaias8mxbjHIAKKqOGF?=
 =?us-ascii?Q?ASCGiSksiANb8yT7A+SOBy+VEDZsntaGbPqs5bhw5q4DeoMKIkUAa0Edsk7T?=
 =?us-ascii?Q?b9JWT4YA15Ltqvcgo2SBQ2emJvsG1wEjwW4RJ2jDq9TE5ORA6G+DFUnTpH75?=
 =?us-ascii?Q?lmvxUyXYxb57UuRYXmakCVl3CgTE+g28V2PjrI19Un/m5JAhLp7N160RuyoU?=
 =?us-ascii?Q?9tmeOp9O11yR9/tLS+X+bJ/QzeWJZrk=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9baf33ba-ddd0-4bf0-c4b8-08d9a9ada1f4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 09:35:46.2330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +OAbHIAXtkCtv1dOukkmMY7rFXpHS+9msx6HFDPnyozp0QtjkStj3ud14HcJj3IK6H0u1jM+8ATjafLF1c+E4IXU0bxwXy918YQjlc7TV/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3820
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To be able to extend the payload metadata with things like its creation
timestamp or the creators ident we remove the payload parameters to
check_signature() and use the already existing sigc->payload field
instead, only adding the length field to the struct. This also allows
us to get rid of the xmemdupz() calls in the verify functions. Since
sigc is now used to input data as well as output the result move it to
the front of the function list.

 - Add payload_length to struct signature_check
 - Populate sigc.payload/payload_len on all call sites
 - Remove payload parameters to check_signature()
 - Remove payload parameters to internal verify_* functions and use sigc
   instead
 - Remove xmemdupz() used for verbose output since payload is now already
   populated.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 builtin/receive-pack.c |  6 ++++--
 commit.c               |  5 +++--
 fmt-merge-msg.c        |  4 ++--
 gpg-interface.c        | 37 +++++++++++++++++--------------------
 gpg-interface.h        |  6 +++---
 log-tree.c             |  8 ++++----
 tag.c                  |  4 ++--
 7 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 49b846d960..61ab63c2ea 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -769,8 +769,10 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 		memset(&sigcheck, '\0', sizeof(sigcheck));
 
 		bogs = parse_signed_buffer(push_cert.buf, push_cert.len);
-		check_signature(push_cert.buf, bogs, push_cert.buf + bogs,
-				push_cert.len - bogs, &sigcheck);
+		sigcheck.payload = xmemdupz(push_cert.buf, bogs);
+		sigcheck.payload_len = bogs;
+		check_signature(&sigcheck, push_cert.buf + bogs,
+				push_cert.len - bogs);
 
 		nonce_status = check_nonce(push_cert.buf, bogs);
 	}
diff --git a/commit.c b/commit.c
index 551de4903c..64e040a99b 100644
--- a/commit.c
+++ b/commit.c
@@ -1212,8 +1212,9 @@ int check_commit_signature(const struct commit *commit, struct signature_check *
 
 	if (parse_signed_commit(commit, &payload, &signature, the_hash_algo) <= 0)
 		goto out;
-	ret = check_signature(payload.buf, payload.len, signature.buf,
-		signature.len, sigc);
+
+	sigc->payload = strbuf_detach(&payload, &sigc->payload_len);
+	ret = check_signature(sigc, signature.buf, signature.len);
 
  out:
 	strbuf_release(&payload);
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 5216191488..deca1ea3a3 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -533,8 +533,8 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 		else {
 			buf = payload.buf;
 			len = payload.len;
-			if (check_signature(payload.buf, payload.len, sig.buf,
-					    sig.len, &sigc) &&
+			sigc.payload = strbuf_detach(&payload, &sigc.payload_len);
+			if (check_signature(&sigc, sig.buf, sig.len) &&
 			    !sigc.output)
 				strbuf_addstr(&sig, "gpg verification failed.\n");
 			else
diff --git a/gpg-interface.c b/gpg-interface.c
index 3e7255a2a9..75ab6faacb 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -19,8 +19,8 @@ struct gpg_format {
 	const char **verify_args;
 	const char **sigs;
 	int (*verify_signed_buffer)(struct signature_check *sigc,
-				    struct gpg_format *fmt, const char *payload,
-				    size_t payload_size, const char *signature,
+				    struct gpg_format *fmt,
+				    const char *signature,
 				    size_t signature_size);
 	int (*sign_buffer)(struct strbuf *buffer, struct strbuf *signature,
 			   const char *signing_key);
@@ -53,12 +53,12 @@ static const char *ssh_sigs[] = {
 };
 
 static int verify_gpg_signed_buffer(struct signature_check *sigc,
-				    struct gpg_format *fmt, const char *payload,
-				    size_t payload_size, const char *signature,
+				    struct gpg_format *fmt,
+				    const char *signature,
 				    size_t signature_size);
 static int verify_ssh_signed_buffer(struct signature_check *sigc,
-				    struct gpg_format *fmt, const char *payload,
-				    size_t payload_size, const char *signature,
+				    struct gpg_format *fmt,
+				    const char *signature,
 				    size_t signature_size);
 static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
 			   const char *signing_key);
@@ -314,8 +314,8 @@ static void parse_gpg_output(struct signature_check *sigc)
 }
 
 static int verify_gpg_signed_buffer(struct signature_check *sigc,
-				    struct gpg_format *fmt, const char *payload,
-				    size_t payload_size, const char *signature,
+				    struct gpg_format *fmt,
+				    const char *signature,
 				    size_t signature_size)
 {
 	struct child_process gpg = CHILD_PROCESS_INIT;
@@ -343,14 +343,13 @@ static int verify_gpg_signed_buffer(struct signature_check *sigc,
 		     NULL);
 
 	sigchain_push(SIGPIPE, SIG_IGN);
-	ret = pipe_command(&gpg, payload, payload_size, &gpg_stdout, 0,
+	ret = pipe_command(&gpg, sigc->payload, sigc->payload_len, &gpg_stdout, 0,
 			   &gpg_stderr, 0);
 	sigchain_pop(SIGPIPE);
 
 	delete_tempfile(&temp);
 
 	ret |= !strstr(gpg_stdout.buf, "\n[GNUPG:] GOODSIG ");
-	sigc->payload = xmemdupz(payload, payload_size);
 	sigc->output = strbuf_detach(&gpg_stderr, NULL);
 	sigc->gpg_status = strbuf_detach(&gpg_stdout, NULL);
 
@@ -426,8 +425,8 @@ static void parse_ssh_output(struct signature_check *sigc)
 }
 
 static int verify_ssh_signed_buffer(struct signature_check *sigc,
-				    struct gpg_format *fmt, const char *payload,
-				    size_t payload_size, const char *signature,
+				    struct gpg_format *fmt,
+				    const char *signature,
 				    size_t signature_size)
 {
 	struct child_process ssh_keygen = CHILD_PROCESS_INIT;
@@ -480,7 +479,7 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 			     "-n", "git",
 			     "-s", buffer_file->filename.buf,
 			     NULL);
-		pipe_command(&ssh_keygen, payload, payload_size,
+		pipe_command(&ssh_keygen, sigc->payload, sigc->payload_len,
 				   &ssh_keygen_out, 0, &ssh_keygen_err, 0);
 
 		/*
@@ -526,7 +525,7 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 			}
 
 			sigchain_push(SIGPIPE, SIG_IGN);
-			ret = pipe_command(&ssh_keygen, payload, payload_size,
+			ret = pipe_command(&ssh_keygen, sigc->payload, sigc->payload_len,
 					   &ssh_keygen_out, 0, &ssh_keygen_err, 0);
 			sigchain_pop(SIGPIPE);
 
@@ -540,7 +539,6 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 		}
 	}
 
-	sigc->payload = xmemdupz(payload, payload_size);
 	strbuf_stripspace(&ssh_keygen_out, 0);
 	strbuf_stripspace(&ssh_keygen_err, 0);
 	/* Add stderr outputs to show the user actual ssh-keygen errors */
@@ -562,8 +560,8 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 	return ret;
 }
 
-int check_signature(const char *payload, size_t plen, const char *signature,
-	size_t slen, struct signature_check *sigc)
+int check_signature(struct signature_check *sigc,
+		    const char *signature, size_t slen)
 {
 	struct gpg_format *fmt;
 	int status;
@@ -575,8 +573,7 @@ int check_signature(const char *payload, size_t plen, const char *signature,
 	if (!fmt)
 		die(_("bad/incompatible signature '%s'"), signature);
 
-	status = fmt->verify_signed_buffer(sigc, fmt, payload, plen, signature,
-					   slen);
+	status = fmt->verify_signed_buffer(sigc, fmt, signature, slen);
 
 	if (status && !sigc->output)
 		return !!status;
@@ -593,7 +590,7 @@ void print_signature_buffer(const struct signature_check *sigc, unsigned flags)
 							    sigc->output;
 
 	if (flags & GPG_VERIFY_VERBOSE && sigc->payload)
-		fputs(sigc->payload, stdout);
+		fwrite(sigc->payload, 1, sigc->payload_len, stdout);
 
 	if (output)
 		fputs(output, stderr);
diff --git a/gpg-interface.h b/gpg-interface.h
index beefacbb1e..5ee7d8b6b9 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -17,6 +17,7 @@ enum signature_trust_level {
 
 struct signature_check {
 	char *payload;
+	size_t payload_len;
 	char *output;
 	char *gpg_status;
 
@@ -70,9 +71,8 @@ const char *get_signing_key(void);
  * Either a GPG KeyID or a SSH Key Fingerprint
  */
 const char *get_signing_key_id(void);
-int check_signature(const char *payload, size_t plen,
-		    const char *signature, size_t slen,
-		    struct signature_check *sigc);
+int check_signature(struct signature_check *sigc,
+		    const char *signature, size_t slen);
 void print_signature_buffer(const struct signature_check *sigc,
 			    unsigned flags);
 
diff --git a/log-tree.c b/log-tree.c
index 644893fd8c..a46cf60e1e 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -513,8 +513,8 @@ static void show_signature(struct rev_info *opt, struct commit *commit)
 	if (parse_signed_commit(commit, &payload, &signature, the_hash_algo) <= 0)
 		goto out;
 
-	status = check_signature(payload.buf, payload.len, signature.buf,
-				 signature.len, &sigc);
+	sigc.payload = strbuf_detach(&payload, &sigc.payload_len);
+	status = check_signature(&sigc, signature.buf, signature.len);
 	if (status && !sigc.output)
 		show_sig_lines(opt, status, "No signature\n");
 	else
@@ -583,8 +583,8 @@ static int show_one_mergetag(struct commit *commit,
 	status = -1;
 	if (parse_signature(extra->value, extra->len, &payload, &signature)) {
 		/* could have a good signature */
-		status = check_signature(payload.buf, payload.len,
-					 signature.buf, signature.len, &sigc);
+		sigc.payload = strbuf_detach(&payload, &sigc.payload_len);
+		status = check_signature(&sigc, signature.buf, signature.len);
 		if (sigc.output)
 			strbuf_addstr(&verify_message, sigc.output);
 		else
diff --git a/tag.c b/tag.c
index 3e18a41841..62fb09f5a5 100644
--- a/tag.c
+++ b/tag.c
@@ -25,8 +25,8 @@ static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 		return error("no signature found");
 	}
 
-	ret = check_signature(payload.buf, payload.len, signature.buf,
-				signature.len, &sigc);
+	sigc.payload = strbuf_detach(&payload, &sigc.payload_len);
+	ret = check_signature(&sigc, signature.buf, signature.len);
 
 	if (!(flags & GPG_VERIFY_OMIT_STATUS))
 		print_signature_buffer(&sigc, flags);
-- 
2.31.1

