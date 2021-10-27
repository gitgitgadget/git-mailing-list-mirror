Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEC8C433FE
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55014610E5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239220AbhJ0IIr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 04:08:47 -0400
Received: from mail-ve1eur01hn2244.outbound.protection.outlook.com ([52.100.7.244]:31484
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232225AbhJ0IIq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 04:08:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4jJPTOBpJjMyS1n+wm37NGSRdx4HkBAtNHhtHzCyELIFwA+bXfAvWJJ/+5rLbDjdHjSh9ctgY2pZ+i3hTdbY5YUNmtcYTf6deMcf1id1UBaQV0XD8xwmUM/WFS0FbUGfxswW7vgNmI0J8iwk7oWELZKkqctG/y6uLUhmW79h4VZUHyHsywi3RfvtEYL66rIcltjQbBmP6jEfWGgqDclFOP25zRfvtsjaefbaG0h2AnVLrV3SwQYh7ZLyixXkW1lxMhmP+9nH1RqzC56SSKNr4IyweJ6OXkSm0b6WALWa3Ky1QF5xepSXcO2dFnOMnZY3qXSvb2/rjKfYhUZcGpUgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Qm4geONT56ItaAjtobDvDG9rBIaMJ7N3v4UGam4gxg=;
 b=H5zQyXk05s683m7K+18f6vLrJWhw3jYmfwI0U8As7MY6TQKRdwe+kKVaXF/CaE7MUvenbxJsWPv5jPYnF2kQ94hJUbdvuW079mW2OkParDklsDjy2K/K9B1NkIX+Gg1OtnEhqAXuse/rwrnPU1RstGlcpw0KiVyDPTNV5iojcUtVhiZZ75hEu0NMlP5PFO9Iw4Pm5LBXMMYaC78w/og0VRZW8wzNRWrS0Y8V/ovq6YbCI2WUmM31KbY8FvZXS/38bLBuXHZDyNbRzfcvDez9CgVasZAIN4j/Lv/YdW9dHD9IY+/cnxCUhNRC63oLbGVsoduHADzdCSs7vDMX6lMRdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Qm4geONT56ItaAjtobDvDG9rBIaMJ7N3v4UGam4gxg=;
 b=BXjx3UP9bns3CWmIsyveEDrunolSJvq/cZyblsuJj4cx+82ZLQlTvelYTSGDz4hg00ey01eGltE4j7Z9dT8M1+J8u1CKHIAw0AcoOlQ53eYc16kUVmPCO8we6hxO0kvLmFu+UE2PPyc4x9Pu/Se+4EvJ4zRkr9CmXNum6rr3CqU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4158.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 08:06:19 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 08:06:19 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/6] ssh signing: use sigc struct to pass payload
Date:   Wed, 27 Oct 2021 10:06:11 +0200
Message-Id: <20211027080616.619956-2-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027080616.619956-1-fs@gigacodes.de>
References: <20211027080616.619956-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0601CA0069.eurprd06.prod.outlook.com
 (2603:10a6:206::34) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM5PR0601CA0069.eurprd06.prod.outlook.com (2603:10a6:206::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Wed, 27 Oct 2021 08:06:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07d08313-e7d2-4eb7-863b-08d99920a854
X-MS-TrafficTypeDiagnostic: PR3PR10MB4158:
X-Microsoft-Antispam-PRVS: <PR3PR10MB4158B6BA2C7CA25666D50C3CB6859@PR3PR10MB4158.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:103;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TumfGPuFloK1ZB8uumsXJ6pJNelaLeHsYEvSGKDongSM5B/ljzOQwKaV+9Zo?=
 =?us-ascii?Q?DhE2xEeGDlTc9zdAX7lwrBe/y2c5Gnutqr4T6hsMGueCf9ZsG01k3ZsK8SGF?=
 =?us-ascii?Q?MgNbRbcY0pYVTHCUdwohx6hrNCKj5zA2r+DUSMpHb3Ds0T2xk9EgjiQ9A8DM?=
 =?us-ascii?Q?4WKcyw1zJIl7gijeTgS5fWI1s9HMNynSwNnOvjq7cubNKC+ZKfh0Zm4VUGEI?=
 =?us-ascii?Q?O25iSWjQru4Ek9jgp8s70n03588OokOAlK7BdSRilQS5hjZAtYFclRu4tAK4?=
 =?us-ascii?Q?CO4AwYDcuZQEqNzOTfIaHwHu4IM7AWU4CFF3W+/7/7SLsj8x1gcIqSu5DDfK?=
 =?us-ascii?Q?ir39tI12T2w888Od+bUGfaztCVKkssRicrrsHsQqNveV2BQgWtIx2xhlMPoT?=
 =?us-ascii?Q?9OEMI8vaCEimyXte2zkgiwT1+wqhmKDozYcuiX6zy95rHpIsBVa8qijH1hiW?=
 =?us-ascii?Q?ukvrltqj7YGGvaUTwbSBW8YC3uBbwyzLTu0AgzGfk1DAY3q62YrJ3Woo3x8d?=
 =?us-ascii?Q?1/qDesh08yzNylh+JQ+aTGPKMZInWK0HIGLHMUQswLsCml8QTI/t4WOm972n?=
 =?us-ascii?Q?FSwuJ/wlant+sg7cFCdXUwyxa/F0gsSkBvcdRvP7cauau9mceUaZB1HANQxL?=
 =?us-ascii?Q?7uT0uTgKyb4yGsnRHHlRM2z1aH4bVYcA4TsZ9BmPJg5w9rR1AdxRb55vToK0?=
 =?us-ascii?Q?w9Fu+MslBSDuFcmrHHpbxTpM2xb5HylpAs7Um7xJeu0wIB40M51iQLghsDd5?=
 =?us-ascii?Q?FCY5RwMGdw+1sDFn/BThBM4FEH0IPTh7OYy/MudMpeU4wshSkbWUb/57WPaC?=
 =?us-ascii?Q?ve84Z6ffmJv9wdJRe559+iATf6ftxm2piFCY31xmUrXI6wdgyJ0fxiZ1Q159?=
 =?us-ascii?Q?x9RV935RlQeYpsa3WqQagHyJHUedeFKUY+ugdaakC7Vxj8no71+t7JSf8Q1R?=
 =?us-ascii?Q?jLfZMncHcy5Vs3HuJza6wh7K3CTxmpAzlGyrnYU9hl1Yo0I1E1SZWxki73Dw?=
 =?us-ascii?Q?TZzs+hDnRtlcbRs7CKvEE0y9AQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(366004)(396003)(39840400004)(376002)(136003)(346002)(66476007)(66946007)(2616005)(52116002)(6496006)(66556008)(186003)(8676002)(8936002)(316002)(6486002)(4326008)(38100700002)(1076003)(54906003)(6916009)(36756003)(508600001)(2906002)(83380400001)(6666004)(5660300002)(86362001)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OiFLiQD7nlpSLYGK6IiUgVns776ja0HUfSzmQxoVu5mVkKwS+sMUReZGxjzE?=
 =?us-ascii?Q?MbFqYmbNnVLKcZR/7XoRP8W48u+Ba4A53SNI/4Fcu/GF2k7vewNy4X5o4US0?=
 =?us-ascii?Q?B7K5JILtNkDIO5RUyJ0AkLkQg8fJQbEEj6bTDvyhyNC1UByGc+ghoWTl8gwd?=
 =?us-ascii?Q?GnRTMnT1lJvboPGEryX4Zt8ZMvxd6FqaBV2CF5BqNBSNG2hyr1xAYmBdMjzj?=
 =?us-ascii?Q?Bcmjzt8XKaO4Q5gDkfKt188E+iU4k6GxJX4dIMz616xz1JaG8Q+A1+2C0oIc?=
 =?us-ascii?Q?Hs/fe5BfR1CNQdzcVmOKqXOZnyrMqQAlaYM4uLMZu4Wtx24TuZcVw8vtRDyL?=
 =?us-ascii?Q?J60E1OzU+xUKEhndiKTeIkT9DKIXZua42EMIjBlYoh4JZBxj85jzwTA/b0tK?=
 =?us-ascii?Q?MlM4mjwLzh1NYE2GxQUHsgAE2W86gFKrJcd4eb5d6EPU+0Nwppo46NsIiuKm?=
 =?us-ascii?Q?z+4MX5yIqQzHfsY+cCXdrSazT7cirRgtxovGBur65hjvs4qd3jHLeKNrRBCd?=
 =?us-ascii?Q?R2RHtgzOP0y7v9/kUG9+8dsvHPzyKTbJw4d4eo2QihPJCHsVHFXV6qh97x4b?=
 =?us-ascii?Q?dhhO3Qj1RQ+qJzpePrQcNC8Jtk6EWi9Nohal3a3nx7FBcvy3KtZi6o0ikRDl?=
 =?us-ascii?Q?kQ+ow8OQldjdmoiFwebqkQ20lTplFsORuGMFYgj3E+Pkn1D8hOwqcMChgiLX?=
 =?us-ascii?Q?p9eP0Q5qiLUbnvGnwMQCkNo1iv5mPpysVjFaxY8ADDFcKtLDvTYXg74mOFk0?=
 =?us-ascii?Q?MsnVw7KRY8wb+p0phqMGD7Wnhc4+W7VUTXbv5PtvkjKPcTmQucFHLXtUdxK1?=
 =?us-ascii?Q?a5lQ306zMvSrbKxAq0oiN1nZOq6bXV7mH5tQ6x1TFv1J/1poEv+NY28LJjUP?=
 =?us-ascii?Q?rFY9+5sZ+6Be9bmxoIL7X3dWx9RFGv+HF/3cUcy8lYkHOzWBTVGMkEsbddw4?=
 =?us-ascii?Q?bDKqzGHqdPB4MtqjqEPJQd/RlgTycXSH9+bl7tdc+ERRjqyyGM3Gleqew8l5?=
 =?us-ascii?Q?7ElyxYRohA9+ZXaT4W9JC+PI8XcykFy/NQjLGwSELqfTB6lbh5RgFsnkzUg8?=
 =?us-ascii?Q?PA5+e/dQeuwz6U9E0Gi/tM7GBbEchu0EMG5Gq+W5tKC7J/R5lVNjJorD9ENA?=
 =?us-ascii?Q?skhjrCnmR/skxoDf7WhBOIRQL6c5UAjoVl89v2qFRe6gMe7YPJYsR6WjiiSm?=
 =?us-ascii?Q?aQYqnMyPr9WUTRi8knOr3mc4fWU8EkxHAc8YblMWcuFOQU8kMVCk5DYrutxy?=
 =?us-ascii?Q?URfphNpmOLcQdTrdJ+vP0UE8pfRRvdtmySls5mrLpON5gI7mNa2oxgUUYRUV?=
 =?us-ascii?Q?kXRJa2JhRhTnBp3Pq4yH2j3yfYftGdHw5LjDDZwyKI2TEP8XNbyQUhO+3tes?=
 =?us-ascii?Q?ie/7D0ChaPiwS+xAvZV+L5wjJLmwJlSVU+n5I3BDTDzwpIk5YLDQLHmNU4YC?=
 =?us-ascii?Q?0S/qGRKQwUoTJExp1NBx+gqonPsCX60REsHStdaQrxTIgQdO7DIVeI2BXeii?=
 =?us-ascii?Q?uODNOhcL5fwCU9fcY7O/Wssr9GZsh4ow+ZOl526Ej7AxsJR0HNvWDk0qQgZc?=
 =?us-ascii?Q?DdhTU5lKhM8Jze1oa6aLeM4X1y7yixrLaocq9PlW90ffGgxi0BXNAu3NRxL+?=
 =?us-ascii?Q?Dz3b5yh4Ij/lU3w+TqYqDA6NpIMkpNGrYnXVWGQn7GKErhZXHRC9BmUgmMRf?=
 =?us-ascii?Q?mGtHIX8TcVHekxcjar8JXv4lVRgaNWEA6CqfEHjOa4jgxIEDYRNhyuxfd1o6?=
 =?us-ascii?Q?5rvK8BGNgw=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d08313-e7d2-4eb7-863b-08d99920a854
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 08:06:19.3562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cz7NTvQ8t2Ac8eEfjCOhd9WDbLuH1bS5nBqyLNdJHf1fyP1HbD8CRFhkCOLyhhNYWDxqoZtXNQAOjCZY0sH1QjCYwpuq0kgBFvxS3uBYWxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4158
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
index 800d8caa67..760cf136db 100644
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
 
@@ -424,8 +423,8 @@ static void parse_ssh_output(struct signature_check *sigc)
 }
 
 static int verify_ssh_signed_buffer(struct signature_check *sigc,
-				    struct gpg_format *fmt, const char *payload,
-				    size_t payload_size, const char *signature,
+				    struct gpg_format *fmt,
+				    const char *signature,
 				    size_t signature_size)
 {
 	struct child_process ssh_keygen = CHILD_PROCESS_INIT;
@@ -478,7 +477,7 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 			     "-n", "git",
 			     "-s", buffer_file->filename.buf,
 			     NULL);
-		pipe_command(&ssh_keygen, payload, payload_size,
+		pipe_command(&ssh_keygen, sigc->payload, sigc->payload_len,
 				   &ssh_keygen_out, 0, &ssh_keygen_err, 0);
 
 		/*
@@ -524,7 +523,7 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 			}
 
 			sigchain_push(SIGPIPE, SIG_IGN);
-			ret = pipe_command(&ssh_keygen, payload, payload_size,
+			ret = pipe_command(&ssh_keygen, sigc->payload, sigc->payload_len,
 					   &ssh_keygen_out, 0, &ssh_keygen_err, 0);
 			sigchain_pop(SIGPIPE);
 
@@ -538,7 +537,6 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 		}
 	}
 
-	sigc->payload = xmemdupz(payload, payload_size);
 	strbuf_stripspace(&ssh_keygen_out, 0);
 	strbuf_stripspace(&ssh_keygen_err, 0);
 	/* Add stderr outputs to show the user actual ssh-keygen errors */
@@ -560,8 +558,8 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 	return ret;
 }
 
-int check_signature(const char *payload, size_t plen, const char *signature,
-	size_t slen, struct signature_check *sigc)
+int check_signature(struct signature_check *sigc,
+		    const char *signature, size_t slen)
 {
 	struct gpg_format *fmt;
 	int status;
@@ -573,8 +571,7 @@ int check_signature(const char *payload, size_t plen, const char *signature,
 	if (!fmt)
 		die(_("bad/incompatible signature '%s'"), signature);
 
-	status = fmt->verify_signed_buffer(sigc, fmt, payload, plen, signature,
-					   slen);
+	status = fmt->verify_signed_buffer(sigc, fmt, signature, slen);
 
 	if (status && !sigc->output)
 		return !!status;
@@ -591,7 +588,7 @@ void print_signature_buffer(const struct signature_check *sigc, unsigned flags)
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

