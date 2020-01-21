Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E6AC2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 10:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068C920882
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 10:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="ob4hZmTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgAUKNG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:13:06 -0500
Received: from mail-eopbgr70098.outbound.protection.outlook.com ([40.107.7.98]:21870
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727220AbgAUKNF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 05:13:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLFYhhkRGuMjJXa1SeC+XwtoioX+PlBwLGC3ClIn9Ct1wLMryiHhA4Ft6JTUuIoK35bLtKD64uUePqtzTfO34h9zVxIqg7mGpOOLBvqDHMtGV2vwq/9Wjwd5cjLtCGD5RBkjfUjohl25Kf3UOpBiT4HLybtzoFPkbEvf/8B09rVB9i/UL8MLGVwRU4Tn89gtNISw9PpD8jCT7S8Ki4mZaVsMKSxyWkyuf458KV33prZFTF54CYeyy1ivlzBOOTAexCZKfZL3CJU9LXtlZ/npbbr2zqVCZ1bWbdWtF9WWQahtBdNn4LNqmGi/lFz4lj4fi+F5AjIuS2p30YRfAzU7Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh391SXeTDq004abKoVAAxNK2nhmMCo6qynVdZmLvMU=;
 b=gYntGtTIFjVNdnq98vIULHX4SDuS7hxLj3R/Swzba9e6xtFcvkzieYhrlAqlfPsxnfq5EezdpUOU7AO3sJt+Fo8e1lJ/M46/FiSNPRuW/gDHjkoP4VKTzgJ9pNjXYZkMzEfPKyMw+eJDH9TdzAtpn2U4RQwdbX1zRNRw4XppzmsDQ0/jo8DDwoehR9vj6PoMhhG/uPPLx8KgQ2DdF0J5mLhycxy8apHDwevVy+VXrO0/mLd7+2XilU5WZ1iBIu+yPmKapO3CApqRyQVbCmzPKgVdv2Adcx8zJMrAlOQJgLMMv+tBBRxfdk5gOhEmGqPEJjVxI/7/SBYePT18biUo0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.8) smtp.rcpttodomain=pobox.com smtp.mailfrom=nokia.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=nokia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh391SXeTDq004abKoVAAxNK2nhmMCo6qynVdZmLvMU=;
 b=ob4hZmTO41UEZ2Tw7JSxgYmoa3TWcOrHSN+EhcqxDlOUYB/vc08XbCy6FmCbCiufbNg3d5lpB6HAlrh8ka16iELIxA/3HysifHBNjjyVIPYBWYBoQAlBjMU/GN2cZsoiqPSUDx3goIRLHZ2MIh6Q8sNCM5gakg80JX/AmZubfks=
Received: from DB6PR07CA0119.eurprd07.prod.outlook.com (2603:10a6:6:2c::33) by
 VI1PR07MB5453.eurprd07.prod.outlook.com (2603:10a6:803:c2::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.12; Tue, 21 Jan 2020 10:13:02 +0000
Received: from VE1EUR03FT039.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::203) by DB6PR07CA0119.outlook.office365.com
 (2603:10a6:6:2c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.12 via Frontend
 Transport; Tue, 21 Jan 2020 10:13:02 +0000
Authentication-Results: spf=pass (sender IP is 131.228.2.8)
 smtp.mailfrom=nokia.com; pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.8 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.8; helo=fihe3nok0734.emea.nsn-net.net;
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.8) by
 VE1EUR03FT039.mail.protection.outlook.com (10.152.19.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23 via Frontend Transport; Tue, 21 Jan 2020 10:13:01 +0000
Received: from ulegcpork.emea.nsn-net.net (ulegcpork.emea.nsn-net.net [10.151.74.148])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id 00LACuY3028531;
        Tue, 21 Jan 2020 10:12:57 GMT
From:   Peter Kaestle <peter.kaestle@nokia.com>
To:     git@vger.kernel.org, christian.couder@gmail.com,
        sbeller@google.com, pc44800@gmail.com, gitster@pobox.com
Cc:     Peter Kaestle <peter.kaestle@nokia.com>
Subject: [PATCH v2] Fix status of initialized but not cloned submodules
Date:   Tue, 21 Jan 2020 11:12:12 +0100
Message-Id: <1579601532-10694-1-git-send-email-peter.kaestle@nokia.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <23e3d410-5271-a919-aa03-9e776cf72f7c@nokia.com>
References: <23e3d410-5271-a919-aa03-9e776cf72f7c@nokia.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.8;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(376002)(396003)(136003)(189003)(199004)(2616005)(6666004)(356004)(316002)(478600001)(81166006)(2906002)(70206006)(70586007)(8936002)(44832011)(86362001)(81156014)(26826003)(8676002)(4326008)(107886003)(186003)(36756003)(336012)(26005)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB5453;H:fihe3nok0734.emea.nsn-net.net;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f649db54-a029-4e01-d838-08d79e5a7f79
X-MS-TrafficTypeDiagnostic: VI1PR07MB5453:
X-Microsoft-Antispam-PRVS: <VI1PR07MB5453106E5364C06C623E35BCEE0D0@VI1PR07MB5453.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-Forefront-PRVS: 0289B6431E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nHyTyDtHV99hqTsUOXJJrJxkSABJfIUTQgaWkZn01POS4lrdPhe5i22yh49rr5ttsbNnYp9gT6pu6LaChIN8b1lW45tmLagXLi8QxGb23w4JKwLIl3pyRUgWt+ddOPPZ+hMrN3QO/eaca5+LMG4nVjFT347QeD0TX0TKohrrNr9MX4D7Hvn1ZRJf/uaPimfQv2ySCu1FYemgoJYJG03PQ0EwmwKfKV+eM8V83y4FOrrbeaJSV4/9yCN5m/U5cUcthD2jbanALghn23NkaJS+qZIqgvhH1P5hXMACMeoScl8wmhQ69/pqZnUs5BoucJFU4w7U1Sau2OHWURbNnNr/IWNs6m7rzi1pNxT2O7yl+wW60qLFvpSGPG0/E57m86LkVEQwkbC9oOF4uvq9PEnXGXSSQ2lTCZI9WubvZ3gZjpgtMW1/0b6np3phv0kPclkI
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 10:13:01.8290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f649db54-a029-4e01-d838-08d79e5a7f79
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.8];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB5453
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Original bash helper for "submodule status" was doing a check for
initialized but not cloned submodules and prefixed the status with
a minus sign in case no .git file or folder was found inside the
submodule directory.
This check was missed when the original port of the functionality
from bash to C was done.

Signed-off-by: Peter Kaestle <peter.kaestle@nokia.com>
---
 builtin/submodule--helper.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c72931e..c04241b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -782,6 +782,9 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 	struct argv_array diff_files_args = ARGV_ARRAY_INIT;
 	struct rev_info rev;
 	int diff_files_result;
+	struct strbuf buf = STRBUF_INIT;
+	const char *git_dir;
+
 
 	if (!submodule_from_path(the_repository, &null_oid, path))
 		die(_("no submodule mapping found in .gitmodules for path '%s'"),
@@ -794,10 +797,18 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 		goto cleanup;
 	}
 
-	if (!is_submodule_active(the_repository, path)) {
+	strbuf_addf(&buf, "%s/.git", path);
+	git_dir = read_gitfile(buf.buf);
+	if (!git_dir)
+		git_dir = buf.buf;
+
+	if (!is_submodule_active(the_repository, path) ||
+			!is_git_directory(git_dir)) {
 		print_status(flags, '-', path, ce_oid, displaypath);
+		strbuf_release(&buf);
 		goto cleanup;
 	}
+	strbuf_release(&buf);
 
 	argv_array_pushl(&diff_files_args, "diff-files",
 			 "--ignore-submodules=dirty", "--quiet", "--",
-- 
2.6.2

