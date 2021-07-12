Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498E8C07E9C
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 22:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BFFF6120A
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 22:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhGLWex (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 18:34:53 -0400
Received: from mail-co1nam11on2102.outbound.protection.outlook.com ([40.107.220.102]:11552
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230456AbhGLWev (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 18:34:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQBWcf/lAtbnkXCuqCnX9YNj/qgeA5YW5MoepPLqyT0kibsDJpaMynQ/aFFTyHepKm2z7cU4YZQpyf3AwCIxDZ5XOaSQ91JwbiaX3pyXys6s6UoYsRsRteWzPfFUYZ6ajQPIcK5TemhAMLXJ2VnW76Z4D5CmigrQOD3wtTxDq8VbIBqtZlGD2N4HuZQJCBsnGKbnAOWHbV5kwEoiUsKGrofJVpvnupOQOmNkuGhCVN8D9XoP7jGAnQD7UrHz5Ki5AydvjSwbKzi7w1XzQUlgikQ21tAZC1ZTLtUriPiuEAQkrmkj8+3FV1SJ3tnhQ8rqCWy0wXEGk8i90OzkfeSQgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXiyiHjSSsTvSzs3EhlH5+qL3UID/RMbMThW0BmePPE=;
 b=jfqFfAc9giOYiCP9avEZ31ILA0NBE/EWviskO7ChmWgK6wQn6CiQTl4ix8U4kvXL17dmY0mMd44bALLNmrxfNIuem39zlvRvO0fM5UubK7zrZrUrxpW53VcEBzRN/H7BnCNCnn12Q207RatYanj9/y4d7FFsBt+dBssEo6g2qRgQmd/lqpU/akCP91Pg5X7FrbmtYopjUxmgK4TF89+yDWKF6ULcd1t3PeEIBZx64lsNuVX6+kZ0eI9iUBciyRYtJ+RcGWv4JA4l4PUSdVvE7gUfZZVJ7gwWrI4XCtQ877zcF2zLCRQLPLpYvtz+OuwkWdb21et+pvXKuZdXVFYIIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nexbridge.ca; dmarc=pass action=none header.from=nexbridge.ca;
 dkim=pass header.d=nexbridge.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nexbridge.onmicrosoft.com; s=selector2-nexbridge-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXiyiHjSSsTvSzs3EhlH5+qL3UID/RMbMThW0BmePPE=;
 b=r2u28HlDJ8MLYk+Fbt9LvgMkLpCADjkdt7Ok67vdWqSRZAYOf/K+euW+FNsbhZUZfZlb8eBJ7zNg87qldM8qx+EhWlBlck+URDIEBWyr/0tbybQ82L5frBMyZLDACfjc6jb1wBbUH/xkdHXH0O1ZiOu+0QmUCFN4BhdVAC0tcTg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=nexbridge.ca;
Received: from DM8PR17MB4934.namprd17.prod.outlook.com (2603:10b6:8:3b::24) by
 DM8PR17MB4936.namprd17.prod.outlook.com (2603:10b6:8:37::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.27; Mon, 12 Jul 2021 22:32:00 +0000
Received: from DM8PR17MB4934.namprd17.prod.outlook.com
 ([fe80::7c5c:6e02:71c6:915b]) by DM8PR17MB4934.namprd17.prod.outlook.com
 ([fe80::7c5c:6e02:71c6:915b%7]) with mapi id 15.20.4287.033; Mon, 12 Jul 2021
 22:32:00 +0000
From:   randall.becker@nexbridge.ca
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [Patch 2/3] Documentation/config.txt: add worktree includeIf conditionals.
Date:   Mon, 12 Jul 2021 18:31:38 -0400
Message-Id: <20210712223139.24409-3-randall.becker@nexbridge.ca>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210712223139.24409-1-randall.becker@nexbridge.ca>
References: <20210712223139.24409-1-randall.becker@nexbridge.ca>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:930:8::38) To DM8PR17MB4934.namprd17.prod.outlook.com
 (2603:10b6:8:3b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (173.33.197.34) by CY5PR03CA0023.namprd03.prod.outlook.com (2603:10b6:930:8::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Mon, 12 Jul 2021 22:32:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc2824e2-be31-4ab7-f34d-08d94584dd78
X-MS-TrafficTypeDiagnostic: DM8PR17MB4936:
X-Microsoft-Antispam-PRVS: <DM8PR17MB4936E5EEABC9FF60892883EDF4159@DM8PR17MB4936.namprd17.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hRFSCkWlTKrcTVD2qaFqZT8ke5ZLOO/rjy7yvvcktic5+pbxPhB6ZgPWAdRjcwOfV3q0RPWYLJJ6EOHislXGrd3I2IufQBKnFtNP8BTh8ayqAq3CVXCQo9HITNk/5qm38QtEBQN1UTIKcBApoNIKcFWmZ/Z6pityftKObUM7IQSJJnrf+thHBxJOXMFTAY30dLN3ijR+mxXJnJSZNC+aP+DN8xFVYugXpY0xtUp/U9VBE9J/K0ZVmtCY9+QiJj5/VdnIcwnuqoNS5BUKJZG1hQy/1SBoJm/ZvRnLxwc/6SuSzKx9jLcvRnMcGo73N2XtO10SuTzX5AtEEWteEDP1jCo9VjyElmNOutz/M7EZbF+i17Z0Ps3v6rm5AdhGhdqvoMtKyDm/+SlhFTlzvy9A/kBhEp1uLDz5kBIxBnYawFSTy+Zd6gJ45FX0jCKMKIUopDBEjCpwhw8jFV+79Pzz+s//+kDMknzGmZTkV6OBnlae7HaQFkVt+sWzEQ1JUxHpwFI9dakiBZb2Z8zWngzkWhn8iSgK/Coz9wBOtVe0zj7SjdrgKRdMy77eePsZQ90WOI+u7BRVPrXmnwEwYXf6Er9znNKee47i1IYIP0oT5dQA/W7e1IEnGIHLVNyMZzJgMt2dLjCEsywGqTmWchBR/45mJi1Sz0ZHCOHbQ5WzQMZNhlCzFtGMKhVQfRMs6bbh2296rE0vhf8ntyQ9N9ssOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR17MB4934.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(396003)(366004)(39830400003)(9686003)(66946007)(2906002)(83380400001)(2616005)(86362001)(36756003)(186003)(5660300002)(52116002)(316002)(956004)(8676002)(38100700002)(6512007)(38350700002)(8936002)(6506007)(66556008)(6916009)(1076003)(4326008)(478600001)(26005)(6666004)(66476007)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XdRvc5cifywG+v55Oj37sDmhgOQOlbrEqRHo5lsqzf6/O7VRN6IJNA+pDh+p?=
 =?us-ascii?Q?X4H8S1lcd2W/AP5msKTiDPKvz2HHXilg1wtyXyrFPNawl9RJhvzFUBmUGkue?=
 =?us-ascii?Q?j0vfOHYKaywn7xc0/QPpERopRcNdLQhB5kKBkitvDrQbT1eDjJlAveQyZsLj?=
 =?us-ascii?Q?Q+hAzSvyp0rVX1RWCoS2Yx2DpH2tl87v9/NprqBezD78LZFgaHR8pZj5B40E?=
 =?us-ascii?Q?5Zx0kkqIhCipmWlOBT2XKVmSWMXHI9Z7caP9QjTeYPFamvyTlCOk5UhOhM3C?=
 =?us-ascii?Q?j2OngyOwMzvOC3jcMGW+8U4/zxVUGdDA+heZU0i7ap+NKTr6BPRsHtNes1Us?=
 =?us-ascii?Q?Drr5RkpnWn1pAe9JIQXy/cyqx7CSlJMUyju//dh5j6DkZv0rEINlMfUKafOV?=
 =?us-ascii?Q?4F83dpMCej0nInu648VbgmCwPszkNgmrNEm/nW2p/mwGoBZGft/mIUFa5gGc?=
 =?us-ascii?Q?J+LmtqyFROnvsKgfwsKe69zBbmxhGbgWR8MJafrdbpvJJghH6xTxDBEZ7LZ6?=
 =?us-ascii?Q?98LOAb/IjpgUpV9pJvde8vEPePgtYdE/Xjue6f/G4ijZqTU5vkuSAoyoVYzW?=
 =?us-ascii?Q?d9yHIvNAVuCT0zG+2lZSuIvDNgqE6EekOuIBm+Xs+xMBCbuko+8UxWaUFdim?=
 =?us-ascii?Q?gmQT2f9b9+ToHYATWBk0bx69Vw0/vdf6+rIel/o9ox3BehgkaP7Q0a4h2ZOU?=
 =?us-ascii?Q?Y9smVhqWQfX2ArWARm5DSyo3IPAE8HaAD2EAGez34CDYaPwzIFmVpwQtpvEw?=
 =?us-ascii?Q?NSS5tVkx1VojCrvERYh0oVAYU8qqrW9TPqrU6twLdIbL9h4QkyuyTPmqbFPf?=
 =?us-ascii?Q?lmG/IrCuGQ0xh0hLGY09EpFMADmSVfwjnS0Szy7d+KpUDK8qKF53bQfbnPXy?=
 =?us-ascii?Q?8l/NV9cUIldQjT+eKN1ySEbTzpwcfJFMaQl6pXeG/zrkCgKQ4NQTrXDWqzW1?=
 =?us-ascii?Q?S7dVaxjw/lnsYVFE2uLfn718DMwkJrQMfNPn9RT4PLHlVcAXHM4649mGx0au?=
 =?us-ascii?Q?6N9Q0i/hsis9sELghh8C/gfKCsqbsWQI0JooUuA/uK9F65f9+UR1KsNZgqNq?=
 =?us-ascii?Q?+EMSE1xNBugkLUvUXhmP2ekYNdWQfsANs+LepbLjrW5JRN4p6sJ84cuNWsbh?=
 =?us-ascii?Q?c6s43TjYRKyapcCFNWvduAvVpWUIXa+N052uj7Xp3+54M69d+kHskSTRqqhP?=
 =?us-ascii?Q?oipJ9Yz3zUNeJoAuzo1xh7RAZpz/zk54mE87mYUelkp8iGxRlKJ1TdKkRf1s?=
 =?us-ascii?Q?6zJ72Z/OzjrNR+DnPdKfmndGfH/WelYp5xVOieeJAIal1p/uRcUHOTa+T3Q1?=
 =?us-ascii?Q?Vpsb6wdxOjZ2CgPj2E/Z7cCC?=
X-OriginatorOrg: nexbridge.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2824e2-be31-4ab7-f34d-08d94584dd78
X-MS-Exchange-CrossTenant-AuthSource: DM8PR17MB4934.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 22:32:00.5467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d6eda728-7424-4770-8f6a-462632ca4c1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QSutTgztDo5dwF1drYOYau9s/yKMNTl1Zf67ZKVDUNVNu0tPlQy0mxJqybaxbrKY2Nsax/Xp3vflbSSBgvO//CwIgnHt4xGRKB1iGJeXbjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR17MB4936
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

Documentation of the worktree and worktree/i conditionals is add based on
gitdir rules except that the trailing / form of the path is not supported.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 Documentation/config.txt | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bf82766a6a..7e951937ae 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -143,7 +143,16 @@ refer to linkgit:gitignore[5] for details. For convenience:
 
 `gitdir/i`::
 	This is the same as `gitdir` except that matching is done
-	case-insensitively (e.g. on case-insensitive file systems)
+	case-insensitively (e.g. on case-insensitive file systems).
+
+`worktree`::
+	This is similar to `gitdir` except that matching is done with
+	the path of a worktree instead of the main repository. Unlike
+	`gitdir`, the trailing / form of the worktree path is not supported.
+
+`worktree/i`::
+	This is the same as `worktree` except that matching is done
+	case-insensitively (e.g. on case-insensitive file systems).
 
 `onbranch`::
 	The data that follows the keyword `onbranch:` is taken to be a
-- 
2.32.0

