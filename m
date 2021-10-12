Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BC7C433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 09:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DB9160F21
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 09:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbhJLJY6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 05:24:58 -0400
Received: from mail-vi1eur05hn2238.outbound.protection.outlook.com ([52.100.175.238]:6624
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235386AbhJLJYy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 05:24:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eia/tuGY4RLSxMVGdi3lqvwfnuJ3VxgTNPK6bfO/sH7E9yXopX3QkAzHJArGdBpWPoS6Mb6qgHRuc0e9g+WUA0RnWtY2ZkYV8r7HNWgna1SaNHcEY9BO7wEd9tF+QqgK0fyectLlPIGUjlUcZ17qcagY86Y6Yw3SuCwPeUPEek74JS3+KWY0M8NEJyz9WUmDFGl9Vce4LfgBqWbEoOgumU3OoNbZ/GnsG+UF2yV8l47oT6HoOtpOuQeJvOKQYJi64wPWg6j6ftmnSOUeEX+e+auRy/TgDAHeC+fLY79uWyVpnlqwZPJl4k69SyWeUOFCUjgZWOoG+UAfjr1l7ByH8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oysvxlBDo2mu6vbN4a9MJ61DB9whvWIo+oa8yYqrBjE=;
 b=kgnrUDG46K/QSG1GVPx1obPI4TXumk5MIirMVsRi4AtBQBWj7bvKSQ2lgDlRIxxHtw64U0fsqvPD6jJkzjp1bZzdCK/7MTBNXoN2J7ZS2fWSWLJXnF6QrY/B09lNCtAflGSXsSJvFNnzHL4EdPK5Hj+OS1zH//RlDFM0mrPVN2bHmBjX7TNtAwQ2ArLWKRdE8QcLQFePbbXz31svsUtIMxtryBJp8hgX5KZwWTa0DR8btS0C0OwRj1tAC08Jda37tdlipXUdUt+g2iLp+DhFcoGDgxMLhtKFpej+3tQMF+BM7OgSpeNnDdS0OM0aBor9spSfE3oAu4BFhbdkAovLPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oysvxlBDo2mu6vbN4a9MJ61DB9whvWIo+oa8yYqrBjE=;
 b=jfHOCidU+Bw5dUw7Gu6aEM98bMyc0ykfnD+vW6q9JOfKOsJQmPzyq0cBetbYPxL85rLwvs4jPZQKr6We+B/vuq7+zpbSwJygO4iwFObZaVr/czK2x5eIvxY+tO4iM4naOPox5grP5d7FUYzHwBB4EDM/JJHyGOo7xFq7z9ZwPZc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4495.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:102::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Tue, 12 Oct
 2021 09:22:52 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 09:22:52 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH 1/2] ssh signing: fmt-merge-msg tests & config parse
Date:   Tue, 12 Oct 2021 11:22:35 +0200
Message-Id: <20211012092236.619822-2-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211012092236.619822-1-fs@gigacodes.de>
References: <20211012092236.619822-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR0301CA0027.eurprd03.prod.outlook.com
 (2603:10a6:20b:468::14) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS9PR0301CA0027.eurprd03.prod.outlook.com (2603:10a6:20b:468::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.21 via Frontend Transport; Tue, 12 Oct 2021 09:22:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0ee548c-fbdd-4a66-7b3d-08d98d61ddcc
X-MS-TrafficTypeDiagnostic: PA4PR10MB4495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PA4PR10MB4495BC6BEBCCAEE368DC1A0EB6B69@PA4PR10MB4495.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:63;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EPLkWVrLgdciRI76/z90QbgvZjD6eyBiZNsT2l185z9eCFCAlHCE8t5/dHQ0?=
 =?us-ascii?Q?TBsmrIjMbKCVey1jI4YtUkm2KaD7+k46T2UV+9aV7oGIYNSnjC0QktAPhGGO?=
 =?us-ascii?Q?FPHa8KVyHuMq+k6lxoSFT72RIfSA9x7bHqWZqOUjqpq1V55zVrTEbbYiW7z7?=
 =?us-ascii?Q?hY49xLn1DMBYibnihj39m2UKodBbxbry282tAh2BocposcNxIw43dlGdA9oq?=
 =?us-ascii?Q?KGDVc1C5l5bG47/91HjAAzxCQMZXn1EwnQD63kxDZ0QahI8kHmEbTPNR1n7H?=
 =?us-ascii?Q?Gq9t4lG25V32LXhE2dtRX0BTw02yLbDNeHbg5fW23CXNs72RyBenkv4QjxSO?=
 =?us-ascii?Q?x0Rt+IE34uaib4XaHOQouBdGf4s7XELxAiV1My72uZRqsflhgq3svsBo9Yg3?=
 =?us-ascii?Q?jQIuI/IZtFEH4xPjpTDt6riBfjQh7yT4fY/V0y4KpkShs4x8Q688PeAMP1sL?=
 =?us-ascii?Q?KKfA9wWM9IvqPNHExmQam9JJy/LX3KojhwAZIc4slM/CKwuEOM5+yPmzu2zJ?=
 =?us-ascii?Q?n3fp8Ap5SCQ4Psv5aYgSjfXYuz9ejiEn8kPwSxsfTSIigNsRIFCk/GAedz5+?=
 =?us-ascii?Q?ApaMk2uayenumIreIkUUvuFxbJ47Pb6iXlYnWhZtJfmvseAOF9FnPKgKJDNI?=
 =?us-ascii?Q?GYUDclnfzHKnWVn/CaFSb9Db9Q9xMu1Sr3TxkdKC4NeYedcIDmWz0LnHMQ1B?=
 =?us-ascii?Q?Zbs4bBcGrptEM2dCqcvtKiCvq+KW0vIJOICwhEFW2zrjZdErJCHAsJ819nXc?=
 =?us-ascii?Q?88qutJ0rkxY9+DD80dwdKYalrFslTaFoMz2TJ5rgMtJtmxoIdo7i4MrxivQx?=
 =?us-ascii?Q?UYjCbaJ/K4awYW/Xz7MW+I8QKZvC93zOWbGBNFijgC2jZ1irIouRYKebKO7L?=
 =?us-ascii?Q?uvl/l2mt7YRKddXgAesAxFEUylJRq0dZl7iJCIDn27pZUsVbG0cDSCPNeX71?=
 =?us-ascii?Q?Fy2eXbMfuzB6QcH4TKIsidTXgYmGkD5ppROGCwLnUCxbEEw8KgtN1igKlFV4?=
 =?us-ascii?Q?UCUEGPDmzlruqfTlw/fiC6WBuA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(346002)(376002)(396003)(366004)(39840400004)(136003)(38100700002)(66946007)(2616005)(316002)(66556008)(66476007)(6916009)(6666004)(2906002)(508600001)(52116002)(8936002)(107886003)(186003)(4326008)(1076003)(6496006)(6486002)(8676002)(86362001)(36756003)(5660300002)(83380400001)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vYf7ID0JNs+4nY/VCt2SL/0c4nKjzci0Z2/1T6TMIhSJgDkQMO4MaCd7ZBOZ?=
 =?us-ascii?Q?o5Cfll/bAgVI1fAY8Ww138qEu2waAn5dA3vboh+2h2CEO75G2uyyLR6Re23/?=
 =?us-ascii?Q?QIJ1tzsysZywRB/yatjx9nG6o6q+FWobd1tGuQpn0RfYBS4jvIREuFWLNXym?=
 =?us-ascii?Q?W8P+OzYDGmNQNGmgXEOF1jolKJM0l9v+awRLJy6JzEe2b02cveFX9TnpBIx2?=
 =?us-ascii?Q?WpAmZekENCgbzIhFuQNKErtcRG6fUCf0Eo4z6NvXr4i8q+PW5ALfy5yUSQsS?=
 =?us-ascii?Q?2Nm6c2zBfWZ+7HhOMfB8z5U7ZIedq6z2fwcSRSgRyHLA/4xGxSvs3me9/T3k?=
 =?us-ascii?Q?C6rZrDDbYMVjKofCy29lNO9yjUzzjZD9v07yVtutxeEXD4lXdO8xLk+gMN8S?=
 =?us-ascii?Q?ga6ucF/Neav6D78MQRzcjr5Gy7engZ8nYnU5EFebKolSf0VGYdjWHXHa0FaD?=
 =?us-ascii?Q?+u2LLGV9wjtqKsz12VYik5omYacTQhFWTRtEmFZ0dhDkYXaZMT2UBbnRUjXc?=
 =?us-ascii?Q?ywTaeJ2+b1gxBDIbFPRBOxmy0hbHduIBEqVwIj8GpxMz5u8gZHx0SrsJ45Of?=
 =?us-ascii?Q?5YvyaVB2XwUcwgGuWob0gV7wg8e/VyQC6fNiHgJce/KMsZ8MasZdciffMD1S?=
 =?us-ascii?Q?3lFaUVibWHqdDwYBUPuL02IhRqfgFwU9a+EjMopPp66LDHmZg5lO1PcLtBfD?=
 =?us-ascii?Q?W3jDpVhIItScsTEjC8o2/RVvbbN9YQeM1AmmT9MAVxP6nuY+FQZZ3AJBNkxD?=
 =?us-ascii?Q?PsNzGu/nIKTxI86QrZRuHXaNNAk8JMAkkxWdCRtCippardT2ssHbUglVVGPT?=
 =?us-ascii?Q?cxndX6m/NvBHpjIo1dGUzYMFXoVRnrD07veJavHCAG5ByPqrln8z0KKGktqj?=
 =?us-ascii?Q?fz1/0OPVwW18jEJA1cq2RfJ93Hvt+TW0xUbUtY8UV9YZlaMkRf7jPLPhgHlW?=
 =?us-ascii?Q?jB88Ogs1ExjY3+cgY+hquRaqWMUAFTc9RNTY70s4GwTvtRj/ZoE6jdx0X9Fk?=
 =?us-ascii?Q?tN5/ypHi3+yj833OuQht1LJOYuni+WUgF5ErN7ZxStLpmJNMVHsFYX+TFQCg?=
 =?us-ascii?Q?+EnV6WamE6CKQckh4yGYl9eybWtmzwlGn54iHBlYB2FYC4kKw9RbkZte8uV+?=
 =?us-ascii?Q?SRDCgOxjPWn9l3nMNlWuoDiN6K+LvhKsD2CI5FOD4exGRKAr2job4T7wCTdO?=
 =?us-ascii?Q?Ti2d/jMrw25aJdqR5+3V7XvyLBEu7jO/VQ4qVLS2YmQsYXR3y3V+LhHuZykd?=
 =?us-ascii?Q?zpW3K+98r1yxSDX5kM9gpOdujkVAu9cKSjvxOg2aDays63I2CS1mJ1CjZO1m?=
 =?us-ascii?Q?OEMrj/g4RGfX3tHwJeBCkQsJCJC0Z0jzV/zgW8ufZqV9aqZLm9/63DkI+rZC?=
 =?us-ascii?Q?zyYDFxd3ba1/b30ehEn98ymm2z2W?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ee548c-fbdd-4a66-7b3d-08d98d61ddcc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 09:22:52.2882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHqlBhc0KlbcUQlG81TktgT1Gfk3DWLbM05nYywVlZeW9U+nbBsWTdggZJ8VaiQ9su26FrG/rA8GUuEHFFLLkUaj3bAXtG5tE+8XzSR7JT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4495
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

