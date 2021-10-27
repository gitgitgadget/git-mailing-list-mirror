Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C5DC433FE
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB6C9610E5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240696AbhJ0II4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 04:08:56 -0400
Received: from mail-he1eur04hn0205.outbound.protection.outlook.com ([52.100.18.205]:33925
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239150AbhJ0IIx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 04:08:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hj62oz0S7hmYLEH/QIIyR8ulRadWbuBM0s7YB+HN/nvn/UXPIWtQmPzVbC98tLj4218xE6EF9FXxeaM2wdr4VYwET7TT+sGz06JKbbq8ofzdcq/esKPHIOHK1977pFcopc5GWSfocty9AVsCRN5JY0xqKVyFIkfpbOYaidFoZy5rN+110uS5PPZCXCD61EB1OfQ+8Rm+27YFzzs/QJ13GXuMGtXm94rUzXyoxcnphB7o0LeCdW4e24d0y3UDtG4aetNurTqeGVjxpkuXlMcJPZsiB1GpKBu8CVPj+2oqls8vy3lGHA7fTy7AAwvvOxUmQJZ/0pbMUYf37aNnP2Oy5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqXAXvJxFfijWtIfXPjhBQEVCtCFbsViLD+T2fFn5LQ=;
 b=eWeFug5FIrgH3xNZCAasK/XHNHWlvkx8uScjk7ntURuy3/bD/31grvpEJTN2Htao252t+ygFdLsfJAC0YAZ9YToblUY04WK/JnpdAboz+HyP4WodInRiN1/Qod8wvkciee+d5aID7lvBYkLav0Rqw9GiFxyCgRlOmgrM22qVcsrl7RWDnpxNELeLbFNM002VKuge9MzGWBP9ewIaCI/RShqlff2g8d6JTmbT3cU4mUNjglIkgylmZt5l1wPwgJGExkuTTOTis+EiFVU3NXciXbE2StgaJF/kFEYDKb07VcZi22FxwPX+V79w65bpTvk4aH9XgoaxKum8n5JiqLsV6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqXAXvJxFfijWtIfXPjhBQEVCtCFbsViLD+T2fFn5LQ=;
 b=lGHYAa6XRvL8hzkfSXHJt7zgX+9dAMvEZtfEAA7DEKetN6qvZSBZOa3fkU4++nEciUxsKLYDezV/xjSir9BkLRPY6raqdo8CTigEsJUEPW4RiM9xQ00tex/MjQj3T4PzOd0OFi2NS4sNuwgSZDpYzuEBZ1Ci02wprwVXhe6B77A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3786.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 08:06:25 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 08:06:25 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/6] ssh signing: make fmt-merge-msg consider key lifetime
Date:   Wed, 27 Oct 2021 10:06:16 +0200
Message-Id: <20211027080616.619956-7-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027080616.619956-1-fs@gigacodes.de>
References: <20211027080616.619956-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR1001CA0012.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:2::25) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM5PR1001CA0012.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:2::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Wed, 27 Oct 2021 08:06:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c63eec0-86c6-41ca-3536-08d99920ac0f
X-MS-TrafficTypeDiagnostic: PR3PR10MB3786:
X-Microsoft-Antispam-PRVS: <PR3PR10MB3786C106D91D339D68E5D705B6859@PR3PR10MB3786.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:67;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X3E3GMgoQlBq7oETH1QOiCSVYC2E59b1C3w3OQv4LRngavxhwRq/5T7GBqWL?=
 =?us-ascii?Q?K0RUJfPohO/3Zl5f29IB3kvRYlZneYIn4TQ7k7jTRvugn+yhjrPqKbYqN+sH?=
 =?us-ascii?Q?N/XCB3QUhF1+Q+419ErXf4MjL4fIKLlC5AZR9hNWX10Ybrmxauj82+t6eyby?=
 =?us-ascii?Q?d8uC1rUbf0RQAfx7jkkv5Ra87z6A7doCtd1aSSDffuRjOg7a236kv0ZWC3Jy?=
 =?us-ascii?Q?R6iy9KJdGilczwmmATaGx3feriIKsTKLVy9US7m7laFgOiDwyhZFwlya6Tmr?=
 =?us-ascii?Q?tWoKVb22Jl0UKGDg+3SVxUNv5KmeY6KzwN5mYoP56jH3nBwTQX8JBgcZyNea?=
 =?us-ascii?Q?kDvRoKBYWY39jUqv1UhYV+Rh20kc5kW5r/FCf19Q50uURZ/GLgV5O6KTwDtW?=
 =?us-ascii?Q?Xv8Q5Vor38Ejo5xqBSBIp7ISlOqSMR98Wvagr4M08TPH+sfvvUkSTsVQo/IT?=
 =?us-ascii?Q?m0Sn4G+gGA2nzVrPIpOa89sxquenrpfOp8lY6TQT99phw4ezcpLuTsyEbchK?=
 =?us-ascii?Q?PnAFeh2glf3aEcK7U1vmRZcNo94TP+wQJvbqA2poqJ0LYyvYopxPXQipFirF?=
 =?us-ascii?Q?CnHfsi4SVXgW30RjzdkWR2xvXBotJCnn+Ef1zCz1TECgG2lep7cLHfVt2uWE?=
 =?us-ascii?Q?vc71pcH3di6/b3yzGwM7oIkQOcuwDqleK//WBwsQHIA/D1hZfatciG6ZcmOx?=
 =?us-ascii?Q?L1NAkKYyOUQHMPxu1XXy9UvGXetFDZxEU/aNOvyJ21ZEXeZqPMyQcdN41EFN?=
 =?us-ascii?Q?sD4t8MvrFRfMqh3pHMNCQSS49rG68w8kLxWCKF2e1oqFgeDmu7i+5VX0b/iq?=
 =?us-ascii?Q?bmS7XUQgolA0UGeF1LFSBRPqv6XoHBKXMvhqtCv5RVRC9eFjlw0f6r61vbRC?=
 =?us-ascii?Q?SxkjmyjPu4rN73GQFQadFop2jlegC56EW7W0KG6wPYJAGVDzROLw4EztmvN2?=
 =?us-ascii?Q?s13J8B9wknI+LCqtkvrJ/+xjCVQvWJg3A6svBoBopQEsM3Ev21V/hLBDJthj?=
 =?us-ascii?Q?wSFYNtX1FxGCptDCdqW96P+koA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(396003)(376002)(346002)(39840400004)(366004)(136003)(1076003)(6486002)(316002)(83380400001)(52116002)(54906003)(5660300002)(86362001)(6496006)(6916009)(36756003)(8936002)(38100700002)(66946007)(508600001)(2906002)(66476007)(186003)(2616005)(66556008)(4326008)(6666004)(8676002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wki2LWVCC3d/TTlcH4FQCo5NU8MmE5tugQB8iG2+0Ay2hrwDuWJ3Vt1axRyN?=
 =?us-ascii?Q?ETJNk6GijJg6dO8ViSTsIingFmOTFRgIwnodJ/1NNnRz8mwIK/ZLfLtLPoCC?=
 =?us-ascii?Q?N4YnSZuUfmc4SxMiVncI1xS2TWwCwiIvqhngt3WyQkYxVDjEIUiPU1afq1qy?=
 =?us-ascii?Q?R6a4udAFnNjVqJ5CUjS8ZXD3ScQHiZ8S174joX8rcWlP82WW0l7YgYNfgYN4?=
 =?us-ascii?Q?k3NLEfHXTzqBBuSbBInaJjf4pm7JHTo6iLVFQ6CoYw2FKnBQ2B6Ytn2svxJx?=
 =?us-ascii?Q?hSKrUrhTCYxCN3OJT+opeSGx8wVJWzEnNYkPe2dpEekp10XMCWlvC9NOThVw?=
 =?us-ascii?Q?zeTLQ0V4dH516OUZ68yJMf96g83CFdKl38k1fxekqxqTt36eSJ1S6tewVFKS?=
 =?us-ascii?Q?vgcJDMU1chIS3mEglK9mgxekA9VX3K0SHFBxsLh3gy0H/OAkTfojvL4PPgLa?=
 =?us-ascii?Q?GRE+RsJKoUeAIe2WDz/7vEVpRLQhekziWdz5J1SxLmofAy1SQA1PMw3bDa6Y?=
 =?us-ascii?Q?te4BQwbfVvy3j27PjcSt+StGN4Gir/6xGOd6x2MhlT6uIXBTIxfE5jmLbJ/z?=
 =?us-ascii?Q?hufpu1+x/t3rx2M4lSBii2hVxtiny8wCwUHAKhHuHrpQZ1MEl9SJlkWZgVS4?=
 =?us-ascii?Q?2dFqjG2NSc/ltFNqOgT8Ie6LZ5j1vea5Lp5ERWUVNrytfl8E142oGibHdEQM?=
 =?us-ascii?Q?HsgcxrL5OAiO1MAJGS6H7lIF2o0PNABjcWsY0ZYLj/8Qn/q5QMb1KAfWPPAE?=
 =?us-ascii?Q?rsV1nS5OVOK2rOkP0I7bWAr4Ivh6k41SPa0iiIjL/noTZLRx+XGIB4sX1kuK?=
 =?us-ascii?Q?/Ce09sk9pbxTBa+E70/B7sNY1D4VTj9fjFcDRxju4mnEMcFDQmV9oYSjAYZ+?=
 =?us-ascii?Q?hSY4VaoJKPTPi+gGJnXN7yaNN5wIz0Ylp1qaBhAC6Gmu8Odrwa7hQuVoHGKX?=
 =?us-ascii?Q?fV5L7ZgtR1vElMzB9LtM8+10vMZDXQLRDt4O+KWAtmSZ0tpuqXqQ0EeSUhuX?=
 =?us-ascii?Q?XV63hqBvQiotPdBL6DFjQu+PGULhM4SOYTqooZEOiYTkVYXj6nzXLgi4bdb4?=
 =?us-ascii?Q?RQBzV9JgpkI/NKRW67TFB7pE1PeZ1Tww/cFGl7yyZ/AB2c9pSB+ocdjQv+B2?=
 =?us-ascii?Q?JTyJJgMJQS1hmlsp55Osx7Vpss7hY0t+achwoTPag5maGi7AW0/KjKy1hQiH?=
 =?us-ascii?Q?EJfFvjmX6lgUeSZYmkHd6D1KF7774zeUhmDqwOWkXh5DGYzM7CpOPz0WsCZj?=
 =?us-ascii?Q?jzhWiQZU9Rr3e0BPSCwjCl7ttvOWf2mdp6PqrsLSS7VRTcB2XAD7wNpYVYtQ?=
 =?us-ascii?Q?yWRoumkz6BFxq35FA3gQ7UNuNoMkvQP+2W0PIDk3NhJfLkNbMSw5hTuw1/yD?=
 =?us-ascii?Q?Y4gBLmZrkR8kRn2AgTGKgZAgeLV+UmDG1SeAGgDxDuNdob3WFkhbgkYacI4E?=
 =?us-ascii?Q?yRAbLbrViDQc+4Uu88Gufu+Vtyg+fuesakaYvn2zJRg2dRmKjLdh8PJTkX+t?=
 =?us-ascii?Q?7GUEzJtHUx+vYTC6thJlUSuClikX5KwkuruPAydKyTYzt9qwXxJ2DzTWnOx6?=
 =?us-ascii?Q?Tj17ubtF+tThaqAikArDJqXgWRLyyja9iN5+TpGfqbRkSIayl+vVl6YwT9JX?=
 =?us-ascii?Q?nicPQgouVU+ar18SgEh4GAikxtIEpJN2t4WwZAnfQfeXX1fe5UD6PDd8ZkzZ?=
 =?us-ascii?Q?1ajWTyMQjUSpoFq4ISoy8QOPRItF4sELukZQqxYQYMcwoRQ9aO25GG1aV3+h?=
 =?us-ascii?Q?hKEupeJOwg=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c63eec0-86c6-41ca-3536-08d99920ac0f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 08:06:25.6328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxAtYdzHs0wDIQ99LBExqzQMI+bnpctF8baJ88ycwIwSeNy1qETWDOEZBjqDuWknkfUhPShar2bSI8jIP2CVkhz6GccOf9hGeg7YAhUZfR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3786
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Set the payload_type for check_signature() when generating merge messages to
verify merged tags signatures key lifetimes.
Implements the same tests as for verify-commit.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 fmt-merge-msg.c          |  1 +
 t/t6200-fmt-merge-msg.sh | 54 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index deca1ea3a3..e4f7810be2 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -533,6 +533,7 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 		else {
 			buf = payload.buf;
 			len = payload.len;
+			sigc.payload_type = SIGNATURE_PAYLOAD_TAG;
 			sigc.payload = strbuf_detach(&payload, &sigc.payload_len);
 			if (check_signature(&sigc, sig.buf, sig.len) &&
 			    !sigc.output)
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 06c5fb5615..2dd2423643 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -91,6 +91,26 @@ test_expect_success GPGSSH 'created ssh signed commit and tag' '
 	git tag -s -u"${GPGSSH_KEY_UNTRUSTED}" -m signed-ssh-tag-msg-untrusted signed-untrusted-ssh-tag left
 '
 
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'create signed tags with keys having defined lifetimes' '
+	test_when_finished "test_unconfig commit.gpgsign" &&
+	test_config gpg.format ssh &&
+	git checkout -b signed-expiry-ssh &&
+	touch file &&
+	git add file &&
+
+	echo expired >file && test_tick && git commit -a -m expired -S"${GPGSSH_KEY_EXPIRED}" &&
+	git tag -s -u "${GPGSSH_KEY_EXPIRED}" -m expired-signed expired-signed &&
+
+	echo notyetvalid >file && test_tick && git commit -a -m notyetvalid -S"${GPGSSH_KEY_NOTYETVALID}" &&
+	git tag -s -u "${GPGSSH_KEY_NOTYETVALID}" -m notyetvalid-signed notyetvalid-signed &&
+
+	echo timeboxedvalid >file && test_tick && git commit -a -m timeboxedvalid -S"${GPGSSH_KEY_TIMEBOXEDVALID}" &&
+	git tag -s -u "${GPGSSH_KEY_TIMEBOXEDVALID}" -m timeboxedvalid-signed timeboxedvalid-signed &&
+
+	echo timeboxedinvalid >file && test_tick && git commit -a -m timeboxedinvalid -S"${GPGSSH_KEY_TIMEBOXEDINVALID}" &&
+	git tag -s -u "${GPGSSH_KEY_TIMEBOXEDINVALID}" -m timeboxedinvalid-signed timeboxedinvalid-signed
+'
+
 test_expect_success 'message for merging local branch' '
 	echo "Merge branch ${apos}left${apos}" >expected &&
 
@@ -137,6 +157,40 @@ test_expect_success GPGSSH 'message for merging local tag signed by unknown ssh
 	! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
 	grep "${GPGSSH_KEY_NOT_TRUSTED}" actual
 '
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag signed by expired ssh key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git checkout main &&
+	git fetch . expired-signed &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag signed by not yet valid ssh key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git checkout main &&
+	git fetch . notyetvalid-signed &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag signed by valid timeboxed ssh key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git checkout main &&
+	git fetch . timeboxedvalid-signed &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+	! grep "${GPGSSH_BAD_SIGNATURE}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag signed by invalid timeboxed ssh key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git checkout main &&
+	git fetch . timeboxedinvalid-signed &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
 test_expect_success 'message for merging external branch' '
 	echo "Merge branch ${apos}left${apos} of $(pwd)" >expected &&
 
-- 
2.31.1

