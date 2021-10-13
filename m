Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A21C433FE
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 07:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E175C6103C
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 07:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238693AbhJMHxT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 03:53:19 -0400
Received: from mail-am5eur03hn2215.outbound.protection.outlook.com ([52.100.11.215]:61924
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238680AbhJMHxP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 03:53:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWaGbiwzlPw+gfzG+wHiFRocL57zwumh8Puo8oa2xUH9gO/7p3eMA5BYxYMqpaaMFDuM3ADl5JkIk4uykU3y5HoZzi8OK8cnEUDbYomCXH/2hB4/hHlbrl//tky2nJBD2w06qKbM91t3eM2uUP/F+Bw0OeK0Qr/n+2an8E8XAhaivm2NbxUXiogmYHWS0FESxFOE82vtVaKfrk5cLjbn5zp2Qe5yURZosgSWdweiTpUChbxknI+TVYQiqnTwqXvBWNOcOb/fguSNh+OcPzS7dhNBtmjIbo0CD3D6v1HMcNQr7V1dX36wApY1HFySfQsfe3kzrt93TZrTretsteK3ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oysvxlBDo2mu6vbN4a9MJ61DB9whvWIo+oa8yYqrBjE=;
 b=iMEFBbM3At03MpnhwsLBoJAFRr/4oC8maf688ETPJCz9T2tiwOy4HJMkzFdFl0oF2v2NirJrjZF+IsPXQ77FRYVBJMzortSGSj+8lKb6NoiQ5/ph3+Ypu/kmRS0zR02CxVL6iFaF651QYEahPH54WBILslMbnohRk932DEiGeSoo82xfyWpeDBqiPODbvevCoysF78ocS/4gpNBiBDRL3rNs8/rAJMPxK2tx9Us6DHcQxfBk5uRsDMkZXhPHPdjq22X4ge4MZsYq9OGYhtWzux4qVLim6HqyOaySaXPiZrTsvH2qEvRHJVsmaF2n6MBLVYFGAlLke2tWFMHLCs7Crw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oysvxlBDo2mu6vbN4a9MJ61DB9whvWIo+oa8yYqrBjE=;
 b=CURURafwuiB034xQxRBA5vaEhBgPloAX7XPBVMwXysZSOhfHtEY7iSuLr1B5u8nEJlTZLA3liRhNw/zHdAhnrq7g/qpDc8HumtiTM2Wughg+fC+PR73iJLE9zTUzyBDsBuBo7Mm19HuPulCbbrznXjtXEW8Q/701/G1XspsHomQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4813.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:152::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 13 Oct
 2021 07:51:11 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 07:51:11 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v2 1/2] ssh signing: fmt-merge-msg tests & config parse
Date:   Wed, 13 Oct 2021 09:51:06 +0200
Message-Id: <20211013075107.8584-2-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211013075107.8584-1-fs@gigacodes.de>
References: <20211013075107.8584-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0048.eurprd04.prod.outlook.com
 (2603:10a6:20b:312::23) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS8PR04CA0048.eurprd04.prod.outlook.com (2603:10a6:20b:312::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend Transport; Wed, 13 Oct 2021 07:51:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01d5ed7f-ddde-4689-ff3b-08d98e1e392b
X-MS-TrafficTypeDiagnostic: PAXPR10MB4813:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PAXPR10MB4813FE1EB000A2CECF8D1584B6B79@PAXPR10MB4813.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:63;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wm1VASPQo/R9UsAKXZ5dzJK8lXm+prp1KZwOpDeYvbGnmB42j3J1NC7+HL8h?=
 =?us-ascii?Q?09vTnLsisJGEBJznpZlhUBwJyyPoR8XP/dZZ2VkLusTsvrunlUYfDc/QvB87?=
 =?us-ascii?Q?BbGtQAhHeUZMfeHq7gVr7fsk7yebDjwUpa4n/0Z4sXE8WXzq7yXcGvAr/L94?=
 =?us-ascii?Q?pfuOb3WX5uYCUjxTuDUb/GWRgh7i1sSZnu8dH+aI5//s7gXJW9zNFcwdINNo?=
 =?us-ascii?Q?DynJMNFBSY0FzkiaUSz+5m3GHYshSOMgyTWn/10ifvYwQXsp5DzcFGoCs4tR?=
 =?us-ascii?Q?bX1QktF76XTdj6RNQ6diVHr8xA1OHomeQhQL5FEIcFS06IkGdePOxOWrmZSz?=
 =?us-ascii?Q?IPeJBk1Uchwu4o9+D+g8xN6R3yi23QUndTsGN+YTVtl4wT+NVsVQDN0EVc7x?=
 =?us-ascii?Q?m2bSSwh7yBIQltFZykBOT3rlNmN7RzDw7/C3Ak75Up2xcL+UZUkPRV5bOFAt?=
 =?us-ascii?Q?6yBgUKUUMv2MiilFcMkthEqLFL4WdDlSsS39NNJNLh5A78w9ghcH0hPjsydX?=
 =?us-ascii?Q?QwuXH2d1FRe2eqNK1XeB4oUXGo9SV+YcNp836aD/m/TGYyjIq9UOTJ6f6ehZ?=
 =?us-ascii?Q?1qKfo5UvMgM7SPFWojyqn76or8LpaKNxayw8e4RNCeZvDOiCXfHyOcyl6kop?=
 =?us-ascii?Q?36dytFHPvzhv2u0I8UtJ4REfPEQDjqIu/d17SPNvDWCLbS210+Qba7FNY0jo?=
 =?us-ascii?Q?geRt7UMk41yNmSsGTFQ7ASRfuW2hK1UxECV9Bgz/nZYqCCEuCj5OtTGLZ7nS?=
 =?us-ascii?Q?Tq/0b+d9PJmuD9rF0kt26emmXORBgGWfcsNqDZ8/S6QM/gpEINOtd/2ER14N?=
 =?us-ascii?Q?aQhkRRieFVFoixOC1/yTKCWkPizjx7e/B4dMsOlRyx70MabLH3OSf2uVyqsn?=
 =?us-ascii?Q?QeDpFGqFlVM+mOsgGPxlPcciNOjWoySXQZQppmzdv5l1obfhNVvwXNIPSfuK?=
 =?us-ascii?Q?HX5i6JJOxCDIWvr11sexno1Xr8M835UmF8MsiumXdMd41a5QtqM3s/OvQDRU?=
 =?us-ascii?Q?Km+XuqiN09k6Vbtm5MXT6g+N8Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(376002)(346002)(136003)(396003)(39840400004)(366004)(66556008)(5660300002)(66476007)(66946007)(8936002)(6486002)(8676002)(6666004)(316002)(508600001)(2906002)(6496006)(52116002)(1076003)(36756003)(107886003)(38100700002)(83380400001)(186003)(6916009)(4326008)(2616005)(86362001)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b8Ji4mEPc2eKHHICw4cG0dwOd/3u2UmKpaAyljq3bNGuapNmW0h9j2OHro0O?=
 =?us-ascii?Q?66yNv8Ng6Y8DRaMm41pdn2bMxn1+OxEipRhLr9Knpdgn+6eI7JO4dMmIzYzK?=
 =?us-ascii?Q?0hKahGT8DtImiujHax/68/3+8Ysf6OLegpuJJAKMMllGyIHPSIV4fnDOxqAl?=
 =?us-ascii?Q?lf6yI7NBFXkRcnI5A8PoI6X8BsMd+96gDXMN3FyWLTOcvD9p5aW1h8mJW4nq?=
 =?us-ascii?Q?EUrFyk4kSf4/C+mhOp/KpHqHrGEC70mGGrOXRf/uq26usLHL8DFYfZ4ZLcde?=
 =?us-ascii?Q?MXlT9FGAEPca0SnWS3YrZ1y1mjLTU3EEvbM8g2DP2LNVI9Se+IGfHp0NXT4P?=
 =?us-ascii?Q?HbALU0nYQbobGtftN8/JzMvkgKr6tY4Xqwxeqt+II/tcLMKwbI7C+bBrifwL?=
 =?us-ascii?Q?Z5Uth3K7l5W/EYhxYLM9gMjdagxzrDYg9NEk7sVTchQNtZRzxnCQd06tfeS+?=
 =?us-ascii?Q?15Pl0EtXnmk+LtYFRtPbOPfEFNCqZXkhEIwAn6edH1rEZnNEk9nVANh+PfCm?=
 =?us-ascii?Q?L2sJBF1NBil14Wcc/nl1btSGh8X2Gj2+TgQhvmA3G4Qh5FbhW7GzyZEIwh9K?=
 =?us-ascii?Q?WYl1uZOUCbxXc22BYys2m+3jV5gYsDseUFucgCLg8Q96NfPpPu184hq40377?=
 =?us-ascii?Q?QWXsmNKOh25kXpVeA7B5R/FjLEji70M2T24UOUktMy6sQnuMAGtpUpcuPTfM?=
 =?us-ascii?Q?2RuE54sZV31tmQl7uIv2uzplgxdM7V+uROZ31oirdN8ig18Qns92+c4RcHB8?=
 =?us-ascii?Q?KgbHAy+wI4ByioED2ELHXS6YMHIcLbYy3gKANgu/C+9m8kYVGNFI7+rIz+EJ?=
 =?us-ascii?Q?3eWjZXaj+vv3oKMtCIYP6CVJ74LmAP9K5Jjz7Rm6VzX3J/NTnQWHDdVCih/j?=
 =?us-ascii?Q?jZOXT/ixzCIZSXTgJii69UMrhxiwkSP7d+dfttyWyPamdSHmkUQI0HoruML3?=
 =?us-ascii?Q?ZvTRNpkhLS9sNhd2BqiQMkawDHoDNJ4zon2E0H4bFIt+R+a/uWgHKNXVUk+c?=
 =?us-ascii?Q?mWLcd3eoCvhEuwuyEQqwEDP3Y45ZIk5NC0JgH9HiTaeuMX0WrDwOTRejwF8n?=
 =?us-ascii?Q?3uVmAGS5nxN88c5LcAxo+BztFLMT4Hm11qedI52i6uDzCyK+wJktZL7tS9D4?=
 =?us-ascii?Q?blubpUxxmH4qxTZxhIML3IbUZMBlqIslGbcSMXcFS76vp4r4wcdGqCRrLC/q?=
 =?us-ascii?Q?h9qZewfZMZWEVWHRZsA57lwmt6HMOOE9uf9WNLIB2vfLlJtSUfuwGNq/HMm1?=
 =?us-ascii?Q?6hGGL9PvghiONDKocI866NefcLxwWPBjgHTksIR+HmcgFEsMRAbFfIql0E/p?=
 =?us-ascii?Q?Z3zHEorGDRc07zrOIRlrMjmkLOI0X3/l5H8d7S9cwBMa/C/HFIfAW4k3/ki8?=
 =?us-ascii?Q?TLlSIpFuUKQXBWyXMpC8SnC3Ybef?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d5ed7f-ddde-4689-ff3b-08d98e1e392b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 07:51:11.0775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlmBRiuK8TtHnc9bQsSSuZZgSoqa0bvP26/cGT7oaX3pJLuPCQhP1vP1KWflS/0GIqj1TD77mlBg3FwBnRF5nKp7RZG/13E/364U1Li4+1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4813
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When merging a signed tag fmt-merge-msg was unable to verify its
validity missing the necessary ssh allowedSignersFile config.

Adds gpg config parsing to fmt-merge-msg.
Adds tests for ssh signed tags to fmt-merge-msg tests.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 fmt-merge-msg.c          |  6 ++++++
 t/t6200-fmt-merge-msg.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index fb300bb4b6..2d49584bf5 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -9,6 +9,7 @@
 #include "branch.h"
 #include "fmt-merge-msg.h"
 #include "commit-reach.h"
+#include "gpg-interface.h"
 
 static int use_branch_desc;
 static int suppress_dest_pattern_seen;
@@ -16,6 +17,8 @@ static struct string_list suppress_dest_patterns = STRING_LIST_INIT_DUP;
 
 int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 {
+	int status = 0;
+
 	if (!strcmp(key, "merge.log") || !strcmp(key, "merge.summary")) {
 		int is_bool;
 		merge_log_config = git_config_bool_or_int(key, value, &is_bool);
@@ -34,6 +37,9 @@ int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 			string_list_append(&suppress_dest_patterns, value);
 		suppress_dest_pattern_seen = 1;
 	} else {
+		status = git_gpg_config(key, value, NULL);
+		if (status)
+			return status;
 		return git_default_config(key, value, cb);
 	}
 	return 0;
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 44f55d93fe..06c5fb5615 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -81,6 +81,16 @@ test_expect_success GPG 'set up a signed tag' '
 	git tag -s -m signed-tag-msg signed-good-tag left
 '
 
+test_expect_success GPGSSH 'created ssh signed commit and tag' '
+	test_config gpg.format ssh &&
+	git checkout -b signed-ssh &&
+	touch file &&
+	git add file &&
+	git commit -m "ssh signed" -S"${GPGSSH_KEY_PRIMARY}" &&
+	git tag -s -u"${GPGSSH_KEY_PRIMARY}" -m signed-ssh-tag-msg signed-good-ssh-tag left &&
+	git tag -s -u"${GPGSSH_KEY_UNTRUSTED}" -m signed-ssh-tag-msg-untrusted signed-untrusted-ssh-tag left
+'
+
 test_expect_success 'message for merging local branch' '
 	echo "Merge branch ${apos}left${apos}" >expected &&
 
@@ -109,6 +119,24 @@ test_expect_success GPG 'message for merging local tag signed by unknown key' '
 	grep -E "^# gpg: Can${apos}t check signature: (public key not found|No public key)" actual
 '
 
+test_expect_success GPGSSH 'message for merging local tag signed by good ssh key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git checkout main &&
+	git fetch . signed-good-ssh-tag &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+	! grep "${GPGSSH_BAD_SIGNATURE}" actual
+'
+
+test_expect_success GPGSSH 'message for merging local tag signed by unknown ssh key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git checkout main &&
+	git fetch . signed-untrusted-ssh-tag &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual &&
+	! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
+	grep "${GPGSSH_KEY_NOT_TRUSTED}" actual
+'
 test_expect_success 'message for merging external branch' '
 	echo "Merge branch ${apos}left${apos} of $(pwd)" >expected &&
 
-- 
2.31.1

