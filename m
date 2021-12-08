Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CC2C4332F
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbhLHQhY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:37:24 -0500
Received: from mail-eopbgr60041.outbound.protection.outlook.com ([40.107.6.41]:23374
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237044AbhLHQhX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 11:37:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJRXWkY5n1027kKpGjJnhsO0hFLvKAKAjTvMegQIWV0eiBQPek2kXKrd+8zq4gnYPQBLBTtQfMVwFe4mvePWU8vdBuWzpcAaWQpE+3Pef+ySfHLyJLzIm7h6WEgsBqOrNBvdcPf4l2LfOdnHvGn6HZA05mE/js4A/cddPj9uKSqKo0i8d6vNi+NFxRfZMJjtE8rBk97e/9tucKIus4ljDRLTfWaA3p49O9z4M5hWZ+ux3bwFjbJQDkx5OZbj1fzg5GhOfsnGzj0LJ4iN8pF4ktP/cqW3yZKBOabuVWOFpp//4e4S5gTlsxf0Y3zp2VRNlnkjV7Z715hKkVScOC8jsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFWk7mStrYAR15pRt33iPZVLIawsSF5hY44xdMc4tQM=;
 b=DrZbS9S9+dOxUbKO1xCkMkvejGZm2eEHwQwkFmhAfQpjSKNUxT2SDQmnCfYA+xQ0KwITWEBTg8rR7PZv3kXsfoRqlb+wv7WVE/8hvZVi0MQxPBJR6IBi4Yxs0IVjgSia7+CkKG93p7YGclwWI58AyDLsyHpdTKnxzZ/WIoE8xV2HL+JZkUyUIVIMdcMzKU02mOgPYusQVU6HFNx9jynwBm3WQsc6zmHgsY1zyy/kHPmBjzqRGI3hOsFXbc6IzdD0kFclF8DgdZGPSc7ONr2d8CzzQsCYNHI/I4+nMYxUIbT2oH62Zq4DgYdpxm7HZLC4NCESZ1d27KGxSLbQTvGcCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFWk7mStrYAR15pRt33iPZVLIawsSF5hY44xdMc4tQM=;
 b=BWu08A7rv+eSBhgF8u7jZYKgLdY1D06CBQWEYYJep+VoLFiV+SyqDiKvjv7RKEJUvM6nsJMu4hK9xxavALpTDZavaVMPqjojE6uN/h4NnEN+pfR+AHlNnmPRFCwmLfYLQTjkAJoj7w9kPsSBXn1Y53ga2rt6pnmyzJxUY7r42XE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4128.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:ae::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Wed, 8 Dec
 2021 16:33:47 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Wed, 8 Dec 2021
 16:33:47 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v5 1/8] ssh signing: use sigc struct to pass payload
Date:   Wed,  8 Dec 2021 17:33:28 +0100
Message-Id: <20211208163335.1231795-2-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208163335.1231795-1-fs@gigacodes.de>
References: <20211130141112.78193-1-fs@gigacodes.de>
 <20211208163335.1231795-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8P250CA0023.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:330::28) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:3e55:2984:f78e:8b18) by AS8P250CA0023.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:330::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Wed, 8 Dec 2021 16:33:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4345ae01-4602-4707-2214-08d9ba6881f4
X-MS-TrafficTypeDiagnostic: PR3PR10MB4128:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB4128576C33024FB9CE544ED4B66F9@PR3PR10MB4128.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:103;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AypuN/YCK2UG2NwlkYxvL1RIS5gXvKEj23dr6O1AJegRszVG0tLAgBM57hq7ccSjW8iSbqa3SzNClIeNRgKBn3yJ7rRwT8ZbTevQUrIVdFbS8HQH2VryBUKTY+RMaR5ubHA7f8LfgIywrpyhN5luEoSUqlzi2gm12BhQHSk/8ffkJDt5/jvDQCf6yLasA1y1cumynH210xazWTqh58hnHPSgEQE2xiY4fyjbEQRqds+29TjyPSZhVtHzjpUIpbH+TdsxxQdA7yU+qMCnyMISmWpErln1v3E/JtJA450yPEwBiD8BkrDFV+ejc9sGRzq1FnsTHTcclBlTFUp6FHcnISKwD64OE/p3vijWdNb7/Zub9I5jUYHN7+Iwfk2LPvGNiI5ZjM3S24FigBJtRb4KuDNLQgP1Q/8GpU4MvqUrz231YYFpd9tAihqsbvbJUiM6ykMmI0mnuFmgIroJ/3ZG3aImCzgrtiaiOCJXrgipAlKMDVSpH3Azt1ScDOzBB+Sh1md0rtNr7K11mJChZBVTOkwfh5gIjArhmh/Tas4N7IUhMk62Hsvbu/xdhljLnR5vb6ZwbegnzSAqt5C7UfkAkP74+XeRNG4gYh7PpMnmOQLal5pwYarPFZZYtW+OXo3wYMohnRPBsmmo8otawSytoNdOAUVfz9YETteTd+awvmcpJVhPua0kBDGQaob7j0mp+LP08IUnG1igHWvHmMclwoRfm4t4BJH3qg7UBVS8Tj6qQILaf+TTgVoEp9BCATO/3R5yjp/AHkrrvs4VQC7UH0Hv7nN6dob7th6zx6nIudY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39840400004)(6486002)(54906003)(84970400001)(8936002)(316002)(83380400001)(4326008)(6496006)(38100700002)(1076003)(6666004)(66556008)(66476007)(86362001)(2616005)(186003)(8676002)(6916009)(5660300002)(2906002)(36756003)(107886003)(508600001)(66946007)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EgJHunOs5StxnVYP0mdfT1W7pV7vr7uVREm6ZglVMXQOvs2dEzkdqR3EPEp4?=
 =?us-ascii?Q?I4huQDXiPUgxb/848O1RwjE49ZxBoEkG1cBM/u3vTSQYi3zN6j/1/hA/5ZRu?=
 =?us-ascii?Q?ZbjSUHIqNtc9ivIxdsZDDz8ZG4TdSL0zwzsdWi/1sriCagsLScQFwxTgvTDW?=
 =?us-ascii?Q?jUsRV+wUlANBCrRJRXLD21q+V/2mbdAxQmJ7SyS+lhKV3gum3dPjM7fkYv2e?=
 =?us-ascii?Q?QfMZCMIJlu710BWfBmmyUOxIbAgSh6D+OCgv5vxlvlHJoRdDIigAxrGU3kI4?=
 =?us-ascii?Q?Ey5Pm8aNEnM8qxSckJ0NJVMyVXx19PVRG0hOoPsdLevX2Rs4K3JEpdtL9I+S?=
 =?us-ascii?Q?3gq2O1Xf2sG8TacOIvbivng7pyfeSbCtkUccTxhn4d4CLjk3ex3hNEyQ45kL?=
 =?us-ascii?Q?SF1HEAKtSDGy3kooxLU/LVKJjTIBiZEp/E2KrVCUmxCQLOPtlaEO0deDPM6n?=
 =?us-ascii?Q?n+VKPYv1AFl4AwEHL4kboE+gi4zjTL3ns86Ngy1viC24k0JTHylMYsEMQSIv?=
 =?us-ascii?Q?TARwD0ppOHEGE7f6zIwglSgSoI9c0TCEkrLMDfnV3IKM2g1lErLv0KM1Lx9c?=
 =?us-ascii?Q?Hf1Q2XnVpejFbZyZclWzG4DmphgD2FPVJtvgHTufK3IGcB6ejo6y2ERRqPKe?=
 =?us-ascii?Q?Zshv9j5QT+OC0/Yalbs7PboRvwamAEjIMTJa/LBzsw+f39WdTYsn6gt9EAmd?=
 =?us-ascii?Q?PrR+jG7HBnsMJrR5ddsox1l5Lm9/6J5zmDo6G4NSCPX6gvqoDGWQkH5tu0ua?=
 =?us-ascii?Q?nN3mFnrnnquNn4YKgaAjoDowZCXk3WYnrGvyHymxKJYBg3df8faPGpxt3bl+?=
 =?us-ascii?Q?dg+M8OcCqgTt90KkrNOOsoS8qY/+uQnDjvLwaWUb9awroQ546I4bQ1jMv7pQ?=
 =?us-ascii?Q?bl3HjYm0OvTC9nl0bvwUza/G0hfEvx4cI7RQSKD6PZw283NIwOVboDG699ih?=
 =?us-ascii?Q?C/T49J4DDgTuEIWh9QPNahif1w+r6d4zSu/6TYolLQlV80dzln3Ilich69Ov?=
 =?us-ascii?Q?n7dpg+BGvzWWJlKm1nANnu+SNUFrLkG5QryW6RHM3PWS0XAIwJDyEUw82hWE?=
 =?us-ascii?Q?dnDepSLACQ3tsy456ADstHpkI1uDLc6zCle77+mrwzwfTz/Ba41FX+BNuUzb?=
 =?us-ascii?Q?Z4lB2fcQwB3TA3DQcJJQv7Utpp+P+OruogvVGiVtFr6IEYYUiQVuSjycIQhR?=
 =?us-ascii?Q?7LzBWlVEq+hWSeMlpSIK8OMQVXLA45mwYAjRFcjwvzLCaTVWWpM0x8S3QYga?=
 =?us-ascii?Q?BlP1Di13Y2vQl+p0KOYlgtAtwDJYKrZw+sM0HRGnZwDe1IkZyQaSwDF6aTIX?=
 =?us-ascii?Q?9tG6lAvHsPdN+EVMwI4vJ0Va80SUj47cOOzSl4lgK+DeYsc4NVOeYlWawAcx?=
 =?us-ascii?Q?AWDNOmlIuyGJYcaoqENMMoYR2b3yjM5xlSbRGcM0q5ni0zGizCzuFDXQrlIE?=
 =?us-ascii?Q?OI2TdXQ2suKPRw6T/XrmKJp8m4Cck30SmCOV4Fvs1VLpH6gYNSPD+b0g98cb?=
 =?us-ascii?Q?hIwAiSPHKj7iBXp6tQG6upVL75HcP8tB3oKBumTLAstWTANI7FbabI734Uiw?=
 =?us-ascii?Q?+fyeOqDl+03TfHxnpVKa5abm3FRu3UWuEmGGjfwJLN71OzsjLLi5IRcS4D03?=
 =?us-ascii?Q?n5kZy8tIGrnNmbpqVveDfZ4Kr2/BT0iPmfgT/xe49XaQCvlZtzFnBlegDH7h?=
 =?us-ascii?Q?PwQfOqeDlbpqx8Z8C85zpIOXuKbJSyN/9IEoqk/2+41/eQKUv8hd2GlJ6E/2?=
 =?us-ascii?Q?MKampP/5EQ=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4345ae01-4602-4707-2214-08d9ba6881f4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 16:33:47.0505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIZoGDqC2CiIi4dEIMFPmyGDHNSnJvyDAytbd9+p7/2FlJ2rsb89CZJgoVBX7kxKwZWIMRK9lzAFAVrHHMHlvSyuphENNA/hvU6xe5mhWVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4128
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

