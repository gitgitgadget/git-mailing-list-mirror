Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7235C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 14:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbhLTOJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 09:09:44 -0500
Received: from mail-eopbgr60040.outbound.protection.outlook.com ([40.107.6.40]:26598
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233287AbhLTOJn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 09:09:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yx6wLKW5R7eCFcZ6iddBrjsQfE16k34J5GceIeIEowq6ejJLkPQL7ffXwKS0lXgKHg3ECQxNNIJTXT45P/xRP9V/4wZU1K7yba0KvQvRczZg/MvysmqnYdrshNKQDfs6bwKlv2dI8QcDjRhHAQeIo78EK9JWOeQ1btmKaPfdYNZj/9fKnDkenUPvbnhjny2AkHwW0iVkCf8i49gY/W5lLOek8Nz/I0RvC3rnmsePFBymX3CwMqMMtu9W1AH5AgvgwwEEeAIRKrtTMNcfSdEed+qfqj0CMEBE0XQ9ZlTFF6A5l7mKVMZSmaLKbNry/IrCq6q0wCE/QX618kObNDYSrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUOD98w0C+Ou65p+c+H0wWGCLh2G8LoFn5VR3JRS0bE=;
 b=RDChFFkyvdYEH3HUxhpMVZiiVzVdApOCo0Ng75LdyzYup6JiXrklgKNAaKe0RfONz2Rrq68lcFZsp5p9UWDRCRq5rpM07hF1X02nCo5VpI9V/naaFiJb5eC4Ki1txBm9O2ztKOYRbmScRfPZCZ/j3GL6aBJH5m7YvLD/FswS6v6+ruhsYMocuMFGQXtsEttOQDDuSa2vUOr4z7ZfNq3Xjv0637oZ6wP7Yz7ty17Ehgwh/uG2yP3InvBgfT0FmBol962Vg9KxrreKucv0lDdoPNQVo7EiTkBn9URgTAzLv+VqmAJgLsCP6MG8JLBBIEqOj4Jtgn+7AS+RoLIhdsczuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUOD98w0C+Ou65p+c+H0wWGCLh2G8LoFn5VR3JRS0bE=;
 b=Ba5UR9GcHK8/HOFsRnJqn1opslnxmSih2CRYDth2D6VztHizr3ICO9Sg99HVNfgk7Oi6wPxIwpP90/OZZNfBVM3nAgVX8nvcEdXaONVACt57nn+v8H1QZ1qcVi5LSM562+K/1/kdRIfK5zg1wS9Xf1ahUi+L3xBo1pgzwgOHHfA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4238.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Mon, 20 Dec
 2021 14:09:41 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%4]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 14:09:41 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [RFC PATCH 1/2] crypto sign: add crypto-sign alias flag
Date:   Mon, 20 Dec 2021 15:09:27 +0100
Message-Id: <20211220140928.1205586-2-fs@gigacodes.de>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211220140928.1205586-1-fs@gigacodes.de>
References: <20211220140928.1205586-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0601CA0041.eurprd06.prod.outlook.com
 (2603:10a6:203:68::27) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2e69c99-0b97-45fb-c357-08d9c3c25db2
X-MS-TrafficTypeDiagnostic: PR3PR10MB4238:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB423895C11C87D6C68916A086B67B9@PR3PR10MB4238.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bzg6LqPCTFlTkbCb9U9GD9WEWa/0WIa5ziobnyL1AOpUWNTxOQjV2jaAlxqaPkIw9A06QLiJ/QFWM7WnKnarlO/YUTgq67AlY3GgOFuJoXpmYtqo1pTwm595Q87/Yi92uRlNqTlDenwTaQrWJFo8g6iJnsYixPZknspBCXSOmBGzbHb+yJBISVcVDIhG6+lGDkdEAH0RloC46vcci1ANh4lU3/SvFSh+8tZz/Qx0SrpC7kIkixwGfIsHemyZgpLWMlpEJURoQDTqMBS2BGMuGy3zMDkhP0qJkOG78yaOu26+QHwoOv3c4/ce2gZ7jklZoiwp5gkj7CkuGgmg4FKTHGIDDQkGQCT/5t/c8EhVkqDQEW0JlTUyX50yY4HIEtNaaBWDx3/B/m2JjT7JuF+la5fQw14M4bOZGzLcm4AOhfBiKEc73IcNKVUbNd4RwD2gqnz2RP/3ttXUHPhKgCUZcd+zvzYtJEtQUUF240VJPldYtNINoITOr3QYm/mxJdTFBy3aJZSW5YWeQohZRJwBdONgUbcs7L/FLm0j73ECcaoGL794xU5nmDEAyzI19UbN+c3QJMwytkAxDiWl6x39meKp72ybMpxHat7t5wR/bsItyCrFHMyUqU1oUupl2OsYc+ZIf7uOijQ63o8XyZyIkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(39840400004)(136003)(346002)(376002)(396003)(8936002)(508600001)(6666004)(83380400001)(107886003)(8676002)(2616005)(86362001)(316002)(1076003)(54906003)(186003)(6506007)(36756003)(6916009)(6512007)(38100700002)(5660300002)(66476007)(66556008)(6486002)(66946007)(2906002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kdFM/b3UlXqqFwsEApOsalZrcme+Pvj7n87lXmEfMDyT10zAlxQ0guNLVimX?=
 =?us-ascii?Q?XiI5gv/cd6L6zMAYa6cyu9J6lxjU5sVqooSsGhNwQF6xsbp8OwmUB6e/XAnQ?=
 =?us-ascii?Q?454i17ewar2THa++mIThKjbEmhoO4irvYgZTHCjElYR446cFz6yforLvRihp?=
 =?us-ascii?Q?MhMtvp4Xv2QVK8wYnh/pyTE6wJG22n+44yvZuAdUgZMufDCUgzZk6Mgw37+q?=
 =?us-ascii?Q?Su0AEJlMd18KGo9YkIDIKwyDyqJismvSgo/j8Ph2aqo+pTD5R/iAIJdLXN8C?=
 =?us-ascii?Q?zGWizJOTvCYFfGoeQyjRRYakBtqETJRsXdhl4YL0r/qoxloyyPxnZpOFA4Wz?=
 =?us-ascii?Q?80r8jYj2luG0ZIO+G3UQQ16Fb3xDDaRPwLts0zCXGkuAaSz8X7eAJl1ksd1l?=
 =?us-ascii?Q?EeWKvjAjSzDl7MP6a/3TnyjtSO6ROwSixD5yGHNcentl+FQ2BUG5y7eaesxT?=
 =?us-ascii?Q?BRHYjBG3/hUFxMSegIYj2FB/dl+Xv2cj6ypk/Bbw+njO9vWujWmSa/c4I4u4?=
 =?us-ascii?Q?9Nxe4zIRUbFfalcAmKkgVSsbT8h4fISoJMuTBjsLlePQLjiRgsQT/0ipoeOu?=
 =?us-ascii?Q?fLmIohY4hRf7NlogwHHR/Xka7CI9cS7EY/se1ZOhE9IcubNc5mWovtwX6Rzh?=
 =?us-ascii?Q?Nv0enCnf4WE771rZn40xFGViLbgtnfoDLlRE2vtILQinyxXxdK2IktzbkRPg?=
 =?us-ascii?Q?5EgUVDJpA5dsU0JgtWTQiCxLENkNKv6mDvsRtrb1XGDEAbLwhdFwF0J0R2P1?=
 =?us-ascii?Q?k6eEZlqoME+sAX14/74VHfLbwkvdNCRZmdPMj/7u8N3/ga9kFktzi6+FEnYO?=
 =?us-ascii?Q?m8449GrZBWJtJGIPLMq6jXyBexbZahB59mBTwwwIcrvX1g3KVlQ2nPEfiW84?=
 =?us-ascii?Q?fJ8wLHMC9AtEkabanukfPsody+Ic0BLaUplTnXbKdZ6erJlPQ5+UrPjg9CBU?=
 =?us-ascii?Q?IiEQZ3/EU7P+FBaHQ9o2BoB32C60Xsho158cKS0XhF8Pb8bNYCZ2MspRCi/v?=
 =?us-ascii?Q?eDVsUAQSxeKx6JnrDN0T8SWZ5DbRGxiO7BX4AWT2hUAO8YVGBlrllWr4qTpy?=
 =?us-ascii?Q?8e+hDc9MtkFKhlW14Yj9ucZSXdRx67C/gBPq+D4udiuD9KBeCiBM6s4iz4fU?=
 =?us-ascii?Q?3g92GiiBl/Sqe9rVJ7DK8hj3eWqTpdKzmgKzTY+A95RD6lwyM73KahG/wQlu?=
 =?us-ascii?Q?DA+aI7bPv8BpJZe5SGhAH2WEkfXUFx8puW01DG74tXqNkiwQZAm3S1izEYHY?=
 =?us-ascii?Q?qWKCUi+KjlobuuyWftlBHwOv+mTPIxuEqZ3h80hCVZPv+DbCP1ms/6HcnT2+?=
 =?us-ascii?Q?IeU5W4VF5UR9vfZScSrO81jj54fNt+iQo7tjOTblbl0aCKCwP+FJjMZB1u1a?=
 =?us-ascii?Q?cR+3JnNs1UxeCnQy1fKoUyvgZdusBwD+rULV87jjH7V8A1CZsIMj2+CtNmXi?=
 =?us-ascii?Q?tZk21TJ9gcVCp7x/XAE7uPoONBP+t/n5qXopFGYxacTGDAEhGi5QPB7HE4uM?=
 =?us-ascii?Q?1Qb1TfOEQhWropoAwTqEbMqmuZRoT+WNv57A4Z3g/8Jae1eK+6+mimSiLqZI?=
 =?us-ascii?Q?BXeyfqtq+UVF8T37DUB7ecVJvWSFmvmIKuLGXbiT/YJNvBxHE4g3Gtcx9E7r?=
 =?us-ascii?Q?yyrvjl5Hxebw0cj2QWo+4TYspvo5fr4nl1RwXG+hSKu+8G+6auTRlb4CSfbe?=
 =?us-ascii?Q?CzZxHTv1WA4GnOlGhkqrRBd5hz+T4he93msoFzXxaS1QwUdLsAe99f2Xzzg1?=
 =?us-ascii?Q?Awg/C3pn2A=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e69c99-0b97-45fb-c357-08d9c3c25db2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2021 14:09:41.4422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: inQaee/uCuU1xG+1e7KOWds785vFdgBwef3eHvtTcXT+MNCOZUQaoZehIMNfj0Q0SBGzB0/BpR1ohgeyhTE3XAFhEDxNXxYzqYk0dO0gEPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4238
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Multiple commands allow passing `--gpg-sign` or `--no-gpg-sign` to
enable or disable object signing. Since git can now use other methods
for signing this flag could suggest that it selects `gpg` as the method
to use, which it does not.
Since just `--sign` would conflict with `--signoff` too easily we choose
`--crypto-sign` as a more general name.

Add the new flag to all affected commands as an alias to gpg-sign.
Move the `-S` shorthand to the new flag to indicate that this is the
recommended one to use.
Update the documentation to match.

This affects the commands: am, commit-tree, commit, merge, rebase and
revert.
---
 Documentation/git-commit.txt | 15 ++++++++++-----
 builtin/commit.c             |  5 ++++-
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 6c60bf98f9..b2c1d8bdb9 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -387,13 +387,18 @@ changes to tracked files.
 	default commit message.
 
 -S[<keyid>]::
+--crypto-sign[=<keyid>]::
+--no-crypto-sign::
 --gpg-sign[=<keyid>]::
 --no-gpg-sign::
-	GPG-sign commits. The `keyid` argument is optional and
-	defaults to the committer identity; if specified, it must be
-	stuck to the option without a space. `--no-gpg-sign` is useful to
-	countermand both `commit.gpgSign` configuration variable, and
-	earlier `--gpg-sign`.
+	Cryptographically sign commits. The `keyid` argument is optional and
+	its default depends on the configured `cryptoSign.format`; if specified,
+	it must be stuck to the option without a space. `--no-crypto-sign` is
+	useful to countermand both `commit.gpgSign` configuration variable, and
+	earlier `--crypto-sign`.
+	`--(no-)gpg-sign` is a compatibility alias and has no effect on which
+	cryptographic format will be used. This is determined by the
+	configuration variable cryptoSign.format (see linkgit:git-config[1]).
 
 \--::
 	Do not interpret any more arguments as options.
diff --git a/builtin/commit.c b/builtin/commit.c
index 883c16256c..2c789ff6f9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1639,8 +1639,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
 		OPT_CLEANUP(&cleanup_arg),
 		OPT_BOOL(0, "status", &include_status, N_("include status in commit message template")),
-		{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
+		{ OPTION_STRING, 'S', "crypto-sign", &sign_commit, N_("key-id"),
+		  N_("cryptographically sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+		{ OPTION_STRING, 0, "gpg-sign", &sign_commit, N_("key-id"),
 		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+
 		/* end commit message options */
 
 		OPT_GROUP(N_("Commit contents options")),
-- 
2.33.1

