Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCA7C11F66
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 22:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5720161245
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 22:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhGLWey (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 18:34:54 -0400
Received: from mail-co1nam11on2102.outbound.protection.outlook.com ([40.107.220.102]:11552
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231904AbhGLWew (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 18:34:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l66D+UHOdezxQkQ5QEQ593ZhvA9VPKuLMZi5t/z97c7A+CC7aRUmj/GaJau6f9/3wZQgJDKQnvQvtZLNr5zjWnC5x2GIFEp4ifCXzxp2iSA2IK+7ZulBrBg4SdQCPEKnfJmBpkslBUpzziqq44NlD9/iy46UFUlnqqwdyJEI4rOKMFeZ/QFNuw1bDBX1QDJhme0cKLVHUDGs4KjdbV1+e5fV/b8sIz16HC4YKoZTXbjFclGQVRJfpOg32FmhsOdCtRIna//SGs6wUNfjK+QHjh2q1UGUt0kuNh/Odjt6HeNzqEt8+IfPIKmGsSbzTCFs06MvfdhrAabYUrik6Njmcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8mVHlO5529JNiymc9Y8GaBnH4H7nAMjhf5qnxYcWyM=;
 b=cFcNupt9iJ6WbY+W62yMaIaOAdfmLbhdygL9s407KL6J52W9Nd4Fx7Z7aWIM0H3QU/PpS4m9XA+9IDNxxnxDHWR1GZrXTns233axQcc3vvYGvc+ushxovW2nCucSEsYhsJSDQ6oQ0mMVctyRQGg7IjZUPsLtfpCYENIVPt+8foOKtDIEkVpHJPSzyfqHS+H0Fy1ETAjl1XY+CAIE/wT7pq0inBDv0qPv5iVF7CZqTB+FVzBLeWMFeKu4eA2SyEFvXSiTnXr71sqvR7PxJoEcC07MErK88DUnMTQGT1ZHHnIrSUmbgr/qSqhZ/kZMENSnrtbZewXjpfInpveUq5hejg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nexbridge.ca; dmarc=pass action=none header.from=nexbridge.ca;
 dkim=pass header.d=nexbridge.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nexbridge.onmicrosoft.com; s=selector2-nexbridge-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8mVHlO5529JNiymc9Y8GaBnH4H7nAMjhf5qnxYcWyM=;
 b=SQvfeUnsuWL+1U02j8BRyt/R/XQROSfyWsVISvlZR/ttY0KzZH5M5XMMIf8NpFieoCziy7ATZVungarbw/KPAXqW/hxdfXzx6SxXCCPS8x6LfbOEW88W03R2JX1z5aSidOZmi2XQ279xtpOnHs2G7J2QjfyzPo0oqdkwVec9H6U=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=nexbridge.ca;
Received: from DM8PR17MB4934.namprd17.prod.outlook.com (2603:10b6:8:3b::24) by
 DM8PR17MB4936.namprd17.prod.outlook.com (2603:10b6:8:37::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.27; Mon, 12 Jul 2021 22:32:01 +0000
Received: from DM8PR17MB4934.namprd17.prod.outlook.com
 ([fe80::7c5c:6e02:71c6:915b]) by DM8PR17MB4934.namprd17.prod.outlook.com
 ([fe80::7c5c:6e02:71c6:915b%7]) with mapi id 15.20.4287.033; Mon, 12 Jul 2021
 22:32:01 +0000
From:   randall.becker@nexbridge.ca
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [Patch 3/3] t1305: add tests for includeIf:worktree.
Date:   Mon, 12 Jul 2021 18:31:39 -0400
Message-Id: <20210712223139.24409-4-randall.becker@nexbridge.ca>
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
X-MS-Office365-Filtering-Correlation-Id: 54722264-e7a6-4c29-fd9e-08d94584dde2
X-MS-TrafficTypeDiagnostic: DM8PR17MB4936:
X-Microsoft-Antispam-PRVS: <DM8PR17MB4936371166FE4FF74D763984F4159@DM8PR17MB4936.namprd17.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IRYyP8V2+W2j7NagjwDy0X8WkXvA3EpEBMn8mITsSa2J9/38pVacQDHIVFh5gJpxjCwVJvxyhm+coSG6Bim4oWVlk1qkfwaLnwqaCOcjimWSpFIem5W1kxp6vm/+eIW0QdN40HsBeYxXG70g0C/UQ8FyszaYMBZdwpecb5R5pD1x+W5OC/5Tal556VrnI9NdWUJTZ+WaFCDgcJkcSh1GhaUYC+NVxs8xYOeXQpWwIpoY/n3v8+3D76wokCtqcklQlwOFxWUs3JXlJgMA1BOTaTGFCAcJDLdgPB7v/V0fMRzvwyxe+TDXL3v4oeAo3Dq+FV7C7S8EXLdfGNFMl7Wih3zPAB3dKtGG7WYQHiLKQaOCVR88s3tahAZrT4oCQeelUWzbg4kAhteNW4C8335MThOO/j163gr7HogBEM3U5l/1Mu4FddvXaeVQy1gsWHjFLvsGLI6/mcgnlcpdXGdj6Px8B7A3iVve4gjvcfmTUIjMfBTOZEUQXC7DxrvvqUvbmYUkc5h9++PuqcsOxySVOBsCVftvRjncyEKezH0wwkyn2uhkPSydkP4gj3evQiKQNiLnno5na9i/CT8Dwy222myk7zdaY4bzJ2cC6GtM4y90GvqILZ8SLgPR+4XlkUj/N9wlMnhY8S5nmVFepdchsrqiosQd0dgLD8dhoTEN63wCDmCmKYw+3rFnCMfxST3+GhYSZ43ARqXs9IU/KtQDAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR17MB4934.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(396003)(366004)(39830400003)(9686003)(66946007)(2906002)(83380400001)(2616005)(86362001)(36756003)(186003)(5660300002)(52116002)(316002)(956004)(8676002)(38100700002)(6512007)(38350700002)(8936002)(6506007)(66556008)(6916009)(1076003)(4326008)(478600001)(26005)(6666004)(66476007)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EDn/OlN6WR4OM4WdSLRbQkb5RNTgNTjuTW2Z/3TBxl5j3DDa0bevDF00nIpn?=
 =?us-ascii?Q?wINbwZvy7YuBqSCfddjGlmMFOuoqkMQmsAxakMW2UtCuD8WrO+ofTzX1Zsaj?=
 =?us-ascii?Q?JMqjhhI/jfzh13NpEX5vhXdSnLqxpdiESeXe5zmlosxCmNKXfIt9M9rofc6R?=
 =?us-ascii?Q?U04fK+E7ffcseOq2be6tdO0fO0YQTGiCDManX8rmCRGp/b7b7G6cnd5s3V3R?=
 =?us-ascii?Q?vygcwlTU5i3DtIbbxcgeuPEvLVFz08PxvlVg2WX2OY9sYkPrlctN0EevDqW3?=
 =?us-ascii?Q?Tm39VR2xPK7bKlIAhvU+mKGInor6KApz4XFiyRqJcZCKx3lW+PCL49RgwT7N?=
 =?us-ascii?Q?tFzz3lXpi1wtWRaRfWKyn5+NF2Oc6tg6b296QGjww3yV+ufMzk/A9mFqBy3P?=
 =?us-ascii?Q?XTQwCjLoJ31j4tMFgH23pE7AthlqQ+++woRYK0jD7clN9G7tf1dDnzM1XM8l?=
 =?us-ascii?Q?/H7lyU/rtF3dMbnXVuRFLNhyU8g4zGesBlgtwGOcGq9njtAtUPtU41qPKlr8?=
 =?us-ascii?Q?/AbrWZNQ3rqNUs6XumtVT9cZ2bLFEsxEMna1nvHJpa+4dHr8FZzW9tV0SeKi?=
 =?us-ascii?Q?a/f+VW7yN52FN3Iba+RW23e9K3koWOoMgsX2AFfZStjgNNVUnx9noaOvUXCj?=
 =?us-ascii?Q?z3ZQ2I0OgolGA8EJXyDjC0i+w8Cxq0y/vyfHkhq/N2b5q1DLnUCHfVSpvmlw?=
 =?us-ascii?Q?QVDpNWcUcMhLtIaoRAXdit/rnWXruyWjYf5Woqlfad6r7E87kZSAyQ1rkldx?=
 =?us-ascii?Q?Z6N5ZHLVtZqvixPiR1/CsvHlO95OnTdHMH75IGacga8+tNdz6m1BCbvZtG8r?=
 =?us-ascii?Q?gdgRzEJQqTxwzMQgonALZEg2xLc8Tj0ayc3botXs3EUcG89utEZdpKVC4vKm?=
 =?us-ascii?Q?dGdTxmQo6pSnpphSLg9hNg02Pldj3TttaSmbngb2X9RS0PKC35Q6Kajx3ob7?=
 =?us-ascii?Q?JxeoWPqrWO8IGfayF8b9gENiBY9+pI/aVb308K6ByxIhEyQDA1JHaxrivklG?=
 =?us-ascii?Q?l2KTb9nbsCk2pyXwJJmSBxxkMBHumvT+hB6cEZdFGVvEIxf0vUxzHF8hGaWX?=
 =?us-ascii?Q?DktVOPBCPRf+vO74Ozm7Xt9rMaqWWyIfIVcfj7KbxOeu0wi6dAPdLB83yYA0?=
 =?us-ascii?Q?L+x3wXVKNvCL/wA8L7pMUJBwgGgrrZAHBLuGFHp9N1dh7N48DsGnL7YDbapu?=
 =?us-ascii?Q?w78oKIjQhxNGPtT/lYUIgMzsOj38+BNPkmGY5VIp0INBGhy2vvw0ztOFIv+w?=
 =?us-ascii?Q?iYluBFwjWkml94MXsG71sYBG/5dcoTc/FRf3iBNxsEta17t3qPlV9Ei5DHrp?=
 =?us-ascii?Q?CpCqAlwdhy/a7q7Rp3rqdCny?=
X-OriginatorOrg: nexbridge.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 54722264-e7a6-4c29-fd9e-08d94584dde2
X-MS-Exchange-CrossTenant-AuthSource: DM8PR17MB4934.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 22:32:01.2297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d6eda728-7424-4770-8f6a-462632ca4c1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZAfJCmXGz+l/NEZdgmSpu9QawmKRqvjOAQ3mxXGvHp+IuMdUNoe5wRTR6J6hzIN8We8i4Y76YkCpGToGxwVSMFzuWT/1xkhMX4AG6cFxS70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR17MB4936
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

The tests are a subset of those for gitdir:, taking into account that
the worktree: form does not support the trailing / at this time in
pattern matches. Some resets of the .git/config file are done to restrict
the set of includeIf paths being evaluated that conflict with prior
subtests.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 t/t1305-config-include.sh | 81 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index ccbb116c01..fe1ad106c3 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -309,6 +309,69 @@ test_expect_success SYMLINKS 'conditional include, gitdir matching symlink, icas
 	)
 '
 
+test_expect_success 'conditional worktree include, unanchored' '
+	(
+		cd foo &&
+		# Must add a commit for worktree add
+		git commit --allow-empty --allow-empty-message &&
+		sed -i "/includeIf/,\$d" .git/config &&
+		git worktree add ../foo.wt &&
+		echo "[includeIf \"worktree:foo.wt\"]path=bar" >>.git/config &&
+		echo "[test]one=1" >.git/bar &&
+		cd ../foo.wt &&
+		echo 1 >expect &&
+		git config test.one >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'conditional worktree include, $HOME expansion' '
+	(
+		cd foo &&
+		echo "[includeIf \"worktree:~/foo.wt\"]path=bar2" >>.git/config &&
+		echo "[test]two=2" >.git/bar2 &&
+		cd ../foo.wt &&
+		echo 2 >expect &&
+		git config test.two >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'conditional worktree include, full pattern' '
+	(
+		cd foo &&
+		echo "[includeIf \"worktree:**/foo.wt\"]path=bar3" >>.git/config &&
+		echo "[test]three=3" >.git/bar3 &&
+		cd ../foo.wt &&
+		echo 3 >expect &&
+		git config test.three >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'conditional worktree include, relative path' '
+	echo "[includeIf \"worktree:./foo.wt\"]path=bar4" >>.gitconfig &&
+	echo "[test]four=4" >bar4 &&
+	(
+		cd foo.wt &&
+		echo 4 >expect &&
+		git config test.four >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'conditional worktree include, both unanchored, icase' '
+	(
+		cd foo &&
+		echo "[includeIf \"worktree/i:FOO.WT\"]path=bar5" >>.git/config &&
+		echo "[test]five=5" >.git/bar5 &&
+		cd ../foo.wt &&
+		echo 5 >expect &&
+		git config test.five >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'conditional include, onbranch' '
 	echo "[includeIf \"onbranch:foo-branch\"]path=bar9" >>.git/config &&
 	echo "[test]nine=9" >.git/bar9 &&
@@ -348,6 +411,24 @@ test_expect_success 'conditional include, onbranch, implicit /** for /' '
 	test_cmp expect actual
 '
 
+test_expect_success 'conditional worktree include, onbranch' '
+	(
+		cd foo &&
+		sed -i "/includeIf/,\$d" .git/config &&
+		echo "[includeIf \"onbranch:foo.wt2\"]path=bar12" >>.git/config &&
+		echo "[test]twelve=12" >.git/bar12
+	) &&
+	(
+		cd foo.wt &&
+		git checkout -b main &&
+		test_must_fail git config test.twelve &&
+		git checkout -b foo.wt2 &&
+		echo 12 >expect &&
+		git config test.twelve >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'include cycles are detected' '
 	git init --bare cycle &&
 	git -C cycle config include.path cycle &&
-- 
2.32.0

