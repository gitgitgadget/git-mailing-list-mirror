Return-Path: <SRS0=J6fK=EP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D10C55ABD
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 08:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85D0920702
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 08:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="Cj6OYEne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbgKIIeK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 03:34:10 -0500
Received: from mail-am6eur05on2132.outbound.protection.outlook.com ([40.107.22.132]:3937
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729267AbgKIIeK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 03:34:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9slI08lCX6sQ8x/D+rDJy0txCRi4ztcCZyz1BAmsPNOmQvMgSME5PeGU1gIN71qFvgn6xZGwcDtGVjoeU/r+CeHTSX7GyMnd8lpV2VYd1PQCmYnfiJ7bDZo9x9Guyy8vvYbVyeptXcTgFPP2Hnc6pUA6nII/4KBam19ZQA0f8mGE0SUczpsYk4odWYN3r95DzAaa3Eow4zO42Qvn0lxMq4MsFd3o65aqwwsx3a0JNQNLH7WnXYnwGBRuXr+0NgrJ1pOibMZAMeCkBXTQ2g7Bo/XhZg349KXRjmpt7WexX//cgv9KhnAfbnbQJjt+FyMF7OgG4gHszur2YM/DYkOVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuHOuAU9rIic9L7tfZiRJpgSbiVRXpIRWxFidY0iao0=;
 b=GZcFwbudz/FxDn503L2dxdeYYoElv0wgdQ79T7KhoyEA4TMXTYEOFSDXlc/nxc0PAJc+7MSealBmsxFRqTYEOj821BKq5ZmvT/EIJ1KDFadawOcwFzQv1xsIKOS+DGDp8+gtt649cviHGs92+BgSEA2g+z/WhqpwArWV4RwQ9NVVsL9XN5fqLEbg/Gj78F+SDDS8i2U+NMl9U9Aumzr+8Dr7YjQ6pt+ltJ2YeWP3Q/eZYpdbrl+XEtN4D10HsnZjPMfuH0s4DlCOeI7M5iMxr7WGgQBFP6py3R3UIeUUSUVVrGiXYOZ+FFaEYUvixXR4FHRHFN+l/3+/3Xtai0RwIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 131.228.6.101) smtp.rcpttodomain=google.com smtp.mailfrom=nokia.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuHOuAU9rIic9L7tfZiRJpgSbiVRXpIRWxFidY0iao0=;
 b=Cj6OYEnef6ZjD3YwOO9NRelAD0K+R9nfvocLzUWWUzbsHZMk5mymzhmq9XQ4Ftu4VIRhwNUJOOMtrmNeGB9GZGUiSdzf9IzMhRQeA7U0KTbei/w6J1+dF/XI3SgjEr9FKhLvStEfNLF9lX4HYFGQEmXRzeI5hwaWMgP3ak+gODo=
Received: from MR2P264CA0091.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:32::31)
 by DB6PR07MB4263.eurprd07.prod.outlook.com (2603:10a6:6:50::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10; Mon, 9 Nov
 2020 08:34:06 +0000
Received: from VE1EUR03FT003.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:500:32:cafe::e2) by MR2P264CA0091.outlook.office365.com
 (2603:10a6:500:32::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Mon, 9 Nov 2020 08:34:05 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 131.228.6.101) smtp.mailfrom=nokia.com; google.com; dkim=none (message not
 signed) header.d=none;google.com; dmarc=fail action=none
 header.from=nokia.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 nokia.com discourages use of 131.228.6.101 as permitted sender)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 VE1EUR03FT003.mail.protection.outlook.com (10.152.18.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.17 via Frontend Transport; Mon, 9 Nov 2020 08:34:04 +0000
Received: from ulegcpbofur.emea.nsn-net.net (ulegcpbofur.emea.nsn-net.net [10.151.74.147])
        by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 0A98XxLm030528;
        Mon, 9 Nov 2020 08:34:00 GMT
From:   Peter Kaestle <peter.kaestle@nokia.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Cc:     peter.kaestle@nokia.com
Subject: [RFC 1/2] submodules: test for fetch of non-init subsub-repo
Date:   Mon,  9 Nov 2020 09:33:48 +0100
Message-Id: <1604910829-49109-2-git-send-email-peter.kaestle@nokia.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1604910829-49109-1-git-send-email-peter.kaestle@nokia.com>
References: <1604413399-63090-1-git-send-email-peter.kaestle@nokia.com>
 <1604910829-49109-1-git-send-email-peter.kaestle@nokia.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 767fbe92-3f46-43a8-15a3-08d8848a37df
X-MS-TrafficTypeDiagnostic: DB6PR07MB4263:
X-Microsoft-Antispam-PRVS: <DB6PR07MB4263CBFB2EC0ABAAB15A4123EEEA0@DB6PR07MB4263.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u+bM/qh5qZsU44wHYSVy8b+wDv6MKqH7j8fBPmGvyvk9Lt7SaPCGwq06aGC8tKtjnEuM7RayUwthkRn2GAHQ2nOhdKC4+ctucCl4GTbvCIa452Cf3GrkB21XgpluXL+fcNdqnI13b6++7rka2Ls89oWgU8K6nZuTcWTJUYjKN1ID0nu+v3lbUBkja2cOQf0oEjpVnHR92ssOtaZx3tWLCWRaLzolDcoi1OEmpDARq7MivYG+Twvc/EvAB2vYcoFEisRONTkNUE1g78TucWbz5e8tr6N5ByX1u6Y1OyTRzXm37KfU+b2DJPVdvTdTbNDk73EVPvzlYtdRHeRqoUXavV54SrvzpQzV3HqZgQDbWuJnG0//Vr4IarBBtBWeQklYMfDIxNH13JHsajQMnVQqWg==
X-Forefront-Antispam-Report: CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(46966005)(26005)(44832011)(2616005)(107886003)(83380400001)(336012)(6666004)(36756003)(2906002)(70586007)(5660300002)(86362001)(36906005)(8936002)(8676002)(70206006)(186003)(81166007)(110136005)(356005)(316002)(82740400003)(478600001)(47076004)(4326008)(82310400003);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 08:34:04.9366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 767fbe92-3f46-43a8-15a3-08d8848a37df
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT003.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR07MB4263
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

