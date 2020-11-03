Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324B6C388F7
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 14:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF4AF22280
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 14:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="JV/6+5GE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbgKCOYL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 09:24:11 -0500
Received: from mail-eopbgr00109.outbound.protection.outlook.com ([40.107.0.109]:35173
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729585AbgKCOXr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 09:23:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joLMa08m8P0edL8X0yi0/aNvTnKop6gpJ1gvr/AM7CcVH3w7EbbTA/kat6KpJ/2xGZKNQI1jpw/nfOkmManWIX/cj3fTM27PtRI5F4fWd6P8slXJuWtxbb+W41U9b8NjcprdJERZhmACv4iDJPf9sznlcTlCtR4BqU1WhVQsGNxl/iHhhwJiWiMtBWxB4OPdqZFc6U67iomD4i33UdET6pGwCLeU6K/XgvXCt4dmgQvKGuIplNjkHoZIONERIG7vCMmuUgCKHUzNo6GX4GRh4yhPz0KSsZuYPlsuSIkFgecQfA9hFACSDVGhes9Pm2Ajv9EDTboGAlFLDvL06OEV3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuHOuAU9rIic9L7tfZiRJpgSbiVRXpIRWxFidY0iao0=;
 b=POrnBqf1EJY3V3pLaifBBwqtclYh2RMDL0i1I6G+JobgDZ7piKyQV6IuB1z1uOtt4yxsJQjPOzBhf9ZtEqGAH4esqvEutQ9l2TBs2dk/hL1uvFVBMj8J4RO/gTXrLfr6e6LsIFlxH8FFGdKVwIjfK0QlUeOgUQJVMvdOptWHfT+qTFUa8j0jY5NsJXt9+f40NvyGR50zi4NB2eZjKe5KJeBsumo3aWEKMq0UxM8cIHO20wo1cS2zzpf89f1K/yP+H4eucks5cPNeIWhKW7lVSEQ6YM90Z1E/RsoWuEh67fOBcsdJC79RKXDP/D3C8b9Z3slB4X1TM7dgCNSl+Y8sfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 131.228.6.101) smtp.rcpttodomain=google.com smtp.mailfrom=nokia.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuHOuAU9rIic9L7tfZiRJpgSbiVRXpIRWxFidY0iao0=;
 b=JV/6+5GEeWutMKqEUaIIkmggDJTKrGmU/rrIEmQvUslMBnVqMrWP/PPpV9+wpTy7luy1k3FClvRXqbl4PMzfGu/erJyQP8biTph1txbgREqsxiCS5Ugj+7nSIZaOL8LbM8tmZu9Vqg4Fn8Zmy8vyuVFYSAlNfAvnrFBCFs7KFyQ=
Received: from MR2P264CA0127.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:30::19)
 by DB7PR07MB6025.eurprd07.prod.outlook.com (2603:10a6:10:85::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10; Tue, 3 Nov
 2020 14:23:41 +0000
Received: from VE1EUR03FT046.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:500:30:cafe::90) by MR2P264CA0127.outlook.office365.com
 (2603:10a6:500:30::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Tue, 3 Nov 2020 14:23:41 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 131.228.6.101) smtp.mailfrom=nokia.com; google.com; dkim=none (message not
 signed) header.d=none;google.com; dmarc=fail action=none
 header.from=nokia.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 nokia.com discourages use of 131.228.6.101 as permitted sender)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 VE1EUR03FT046.mail.protection.outlook.com (10.152.19.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3520.15 via Frontend Transport; Tue, 3 Nov 2020 14:23:40 +0000
Received: from ulegcpbofur.emea.nsn-net.net (ulegcpbofur.emea.nsn-net.net [10.151.74.147])
        by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 0A3ENbo7005363;
        Tue, 3 Nov 2020 14:23:37 GMT
From:   Peter Kaestle <peter.kaestle@nokia.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Cc:     peter.kaestle@nokia.com
Subject: [REGRESSION FIX 1/2] submodules: test for fetch of non-init subsub-repo
Date:   Tue,  3 Nov 2020 15:23:18 +0100
Message-Id: <1604413399-63090-2-git-send-email-peter.kaestle@nokia.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1604413399-63090-1-git-send-email-peter.kaestle@nokia.com>
References: <1604413399-63090-1-git-send-email-peter.kaestle@nokia.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 037a6252-417f-4ae6-69a8-08d880041010
X-MS-TrafficTypeDiagnostic: DB7PR07MB6025:
X-Microsoft-Antispam-PRVS: <DB7PR07MB6025388774FBB23901003E67EE110@DB7PR07MB6025.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vmp0vsc5/QSlNXhgcfZz+Lh0Aa/BQ/MATPUjTeR6UbBuplm9bsPZZ4sZy+1hzQQYnKrAlOY/2WG86QS7Di0jVz4PGD8owF8DrULiI/Q6P+7ea3wXfnJ1WPJ7ZDrPWKeF/blyBW8OTARrkdMMu1bY9KR8zKKyyqj1F4hEleOk6slItrtK9tdzBONPzk+k1ywyorh2W6g5xHDbUPi8UulrIMPrsXfNrq/ih6KCD726vA0eLaxGXgFIO37WWofr4fgXTPHK4mFngzFFUguKPlzxoLelbGPFjGZGnx8tY+sVyIuUE3LhuXjxI0k5uS0u6ET4goNRDnU1HD5QnDjP5pAe/rvuCJTSAw8RhHKBdQwMF9JefIWjWvoOGJzu2wjdsmTFn3YBUvK2Q1Ok0mxc3AE6Qg==
X-Forefront-Antispam-Report: CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(46966005)(36756003)(44832011)(5660300002)(336012)(6666004)(82310400003)(26005)(2616005)(110136005)(186003)(86362001)(4326008)(107886003)(356005)(81166007)(70586007)(82740400003)(70206006)(36906005)(8676002)(2906002)(478600001)(47076004)(8936002)(316002)(83380400001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 14:23:40.9741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 037a6252-417f-4ae6-69a8-08d880041010
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT046.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR07MB6025
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test case triggers a regression, which was introduced by
a62387b3fc9f5aeeb04a2db278121d33a9caafa7 in following setup:
outer_repo/middle_repo/inner_repo and a change in the remote of
inner_repo happens.  Then it's being fetched by a second clone of the
outer repo, in which the middle is initialized, but the inner is not.

This causes is_empty_dir() in submodule.c:get_next_submodule() to
check for a directory only existing in the actual worktree, while the
is_empty_dir() being called from .git/modules.

Signed-off-by: Peter Kaestle <peter.kaestle@nokia.com>
---
 t/t5526-fetch-submodules.sh | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index dd8e423..9fbd481 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -719,4 +719,42 @@ test_expect_success 'fetch new submodule commit intermittently referenced by sup
 	)
 '
 
+add_commit_push()
+{
+	dir="$1"
+	msg="$2"
+	shift 2
+	git -C "$dir" add "$@" &&
+	git -C "$dir" commit -a -m "$msg" &&
+	git -C "$dir" push
+}
+
+test_expect_failure 'fetching a superproject containing an uninitialized sub/sub project' '
+	# does not depend on any previous test setups
+
+	for repo in outer middle inner
+	do
+		git init --bare $repo &&
+		git clone $repo ${repo}_content &&
+		echo $repo > ${repo}_content/file &&
+		add_commit_push ${repo}_content "initial" file
+	done &&
+
+	git clone outer A &&
+	git -C A submodule add "$pwd/middle" &&
+	git -C A/middle/ submodule add "$pwd/inner" &&
+	add_commit_push A/middle/ "adding inner sub" .gitmodules inner &&
+	add_commit_push A/ "adding middle sub" .gitmodules middle &&
+
+	git clone outer B &&
+	git -C B/ submodule update --init middle &&
+
+	echo "change on inner repo of A" > A/middle/inner/file &&
+	add_commit_push A/middle/inner "change on inner" file &&
+	add_commit_push A/middle "change on inner" inner &&
+	add_commit_push A "change on inner" middle &&
+
+	git -C B/ fetch
+'
+
 test_done
-- 
2.6.2

