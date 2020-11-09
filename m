Return-Path: <SRS0=J6fK=EP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81700C2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 08:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CBC6206ED
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 08:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="OtGy4dSi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgKIIeF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 03:34:05 -0500
Received: from mail-vi1eur05on2129.outbound.protection.outlook.com ([40.107.21.129]:38002
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726176AbgKIIeE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 03:34:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGDleNv1pnH6nvb3o3CAdqDF3w2YTh3heVXJ5midu4Ch+txJGx1sI8Ejw0G6fbW0rlKFHJxjUU5O+MjmWzv2tUgRuq/HkKNP3CPxK/5vG0Aif/WBwI9RiF58ALSK/xVlrMIg5gttL86EQkG9DbDgEiIRRQZQm9094MX5977aTQty2m4ll2w7UpJpl1voBhOC0v5sbRF536y+g8nVuwWL2lJvUptceTDiGiAcYBVI3G0Cl7afKRy2vDknnNZBPKLZASo7yq+B52ke2pG9jR1Bsf9AYc9J8lASbkHOyde8xM2dgPYwOqBuDhoDLJ5DD7qhVuoS22q3BqJdshyfGxTcJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NbaT09Y0GoufF70Jt3eGKox8qFsOQpAW+dCpx2oqzA=;
 b=OpZI0jGdtgmqVaMxXAMXErFFbaQAe6OEnFRbQPB87K7mUXMqPld/WyL3fTo8HaI+MMk4cTduRwvCKD/m4OLHIwzOsFV8GvPr4f0vPkIbZ00gdq2HKtq5AEdw4l7uY7dGadP8n+pzTAX5c4zfc0/MUTRXg04GEQF3zq8SQakMR23e7B9cNSNio2vO2542MVbsLBteNVlpbhqPhTJemYT/oIrOhaSEPykbppC93O9306UUxy+DVstY9LEtgv7cRK31Vgs0zHxxvw3hKMXH1a8BAN+MwQ6mICOwVnHXIN7CLf13bSwrqBDV2NhrgTDI6odgTPZVEd37oydRFkqr9VPpRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 131.228.6.101) smtp.rcpttodomain=google.com smtp.mailfrom=nokia.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NbaT09Y0GoufF70Jt3eGKox8qFsOQpAW+dCpx2oqzA=;
 b=OtGy4dSins8e0EN+bB5CLilVaepB0BxMVepjp3Epo3LiJRCkv+2vso0Lo88ev1mPkG6ZstvFkrpQd9hQhZi1wDdTHlSfSpeAn4JY9gX6dJRA4N87hd5tZuXVWiITgq1l/fNqxcbgytKe5MZmJTvluGUVN6jvj9/GdXI9EQai36Y=
Received: from AM5PR04CA0028.eurprd04.prod.outlook.com (2603:10a6:206:1::41)
 by VI1PR07MB6317.eurprd07.prod.outlook.com (2603:10a6:800:13f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.13; Mon, 9 Nov
 2020 08:34:01 +0000
Received: from AM5EUR03FT029.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:206:1:cafe::56) by AM5PR04CA0028.outlook.office365.com
 (2603:10a6:206:1::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Mon, 9 Nov 2020 08:34:01 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 131.228.6.101) smtp.mailfrom=nokia.com; google.com; dkim=none (message not
 signed) header.d=none;google.com; dmarc=fail action=none
 header.from=nokia.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 nokia.com discourages use of 131.228.6.101 as permitted sender)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM5EUR03FT029.mail.protection.outlook.com (10.152.16.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.17 via Frontend Transport; Mon, 9 Nov 2020 08:34:01 +0000
Received: from ulegcpbofur.emea.nsn-net.net (ulegcpbofur.emea.nsn-net.net [10.151.74.147])
        by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 0A98XxLl030528;
        Mon, 9 Nov 2020 08:34:00 GMT
From:   Peter Kaestle <peter.kaestle@nokia.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Cc:     peter.kaestle@nokia.com
Subject: [RFC 0/2] Handling regression introduced by a62387b
Date:   Mon,  9 Nov 2020 09:33:47 +0100
Message-Id: <1604910829-49109-1-git-send-email-peter.kaestle@nokia.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1604413399-63090-1-git-send-email-peter.kaestle@nokia.com>
References: <1604413399-63090-1-git-send-email-peter.kaestle@nokia.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f98bf04d-6179-409c-c5b7-08d8848a35c1
X-MS-TrafficTypeDiagnostic: VI1PR07MB6317:
X-Microsoft-Antispam-PRVS: <VI1PR07MB6317C723EE387B437C33D32DEEEA0@VI1PR07MB6317.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FcX2owfpWR1R20EpcxcUaGdXHnIa/6N01qTPm7Rqx1sAdiCYotyZn7U5cKN1tuD1ckr0kocZ2zsjwLJz+mKocO8ZnzZJBk4S47HvlzIDnlHlpTX+XxG77l11WAt+BLojPUKsj32JN4VWBPY3L5HC6EGlQGmp7YIVrdgo/Q1a5cDVkFzmxC3uSH94OGQn29H0fv7HSq7Yy3JS2NZiZ+P0Vp/Q0AzhM1SuaJhi/docjoZxlND9Kw2pLFVWgA2q9fKz4FYnZnUL3iCJcQauIcYg4cfk4G/O2YxL27JKGY/I4cLFng4iGErYE/G2cAAlFYZZe/zXQtPbbMa9Ys5JnZXAc1/dpwUEPA2Pd/s6l8Fj9XNFW2oopNeM9+VyDRD5fR40xtyvKKnw62xkwxU6OUnMEg==
X-Forefront-Antispam-Report: CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(46966005)(478600001)(2906002)(36906005)(6666004)(70586007)(70206006)(5660300002)(2616005)(316002)(82740400003)(110136005)(186003)(107886003)(36756003)(4326008)(83380400001)(81166007)(82310400003)(86362001)(26005)(336012)(44832011)(356005)(47076004)(8676002)(8936002);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 08:34:01.4540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f98bf04d-6179-409c-c5b7-08d8848a35c1
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT029.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6317
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two patches introduce a test case which triggers a regression
introduced by a62387b3fc9f5aeeb04a2db278121d33a9caafa7 and a revert of
the commit introducing the issue.


The test case reproduces following scenario:

Repository setup:
superproject/middle_repo/inner_repo

Person A and B have both a clone of it, while Person B is not working
with the inner_repo and thus does not have it initialized in his working
copy.

Now person A does a change to the inner_repo and propagates it through
the middle_repo and the superproject.
Once person A pushed the changes, a "git fetch" on superproject level of
person B will return with error saying:

Could not access submodule 'inner_repo'
Errors during submodule fetch:
        middle_repo


The revert was my quick approach to fix it.  However as I'm not fully
aware of what the idea was behind handling the submodules inside
.git/modules instead of the worktree, I don't know whether this is the
best solution.  Maybe rethinking the whole get_next_submodule()
algorithm or simply fixing the is_empty_dir() to use the worktree path
will be a better solution.

best regards,
--peter;

Peter Kaestle (2):
  submodules: test for fetch of non-init subsub-repo
  Revert "submodule.c: fetch in submodules git directory instead of in
    worktree"

 submodule.c                 | 14 ++++----------
 t/t5526-fetch-submodules.sh | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 10 deletions(-)

-- 
2.6.2

