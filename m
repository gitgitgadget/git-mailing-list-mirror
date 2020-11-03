Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D1BC388F7
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 14:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3869022280
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 14:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="Rp6Fs0Xn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbgKCOYM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 09:24:12 -0500
Received: from mail-eopbgr130090.outbound.protection.outlook.com ([40.107.13.90]:50820
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729599AbgKCOXq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 09:23:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AF6Qu/Qz3oEbKKY3OXNPgFst5nFxkwxoWVjDQdwi3wQJvR0vn92NMiXw588SWJRC995XTZbPruBN2Hd5WL7vER193b+h8FPiSDElNa9vZLyv4KaQzqqoV6OdVzfQpw6Gz+Ughwv0KbaUB2oydtaN0vBdFgNRM0gUTziszlZsdSbnzkA1kq1zGXu72XNuNTYppwR5tlV4464cTWOsVzG/R7nHaTzbr+7577kDn/pn456OXQ9ZfbwGUsvM/85kicAXH3HPWa29qcTolxTRI8OyHu6ZADKrOn/UnRhI7D+D1pZIvatN+CPkWu5XLTnUJB+I5IIF8AA7SXu9XKwIIKi3Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NbaT09Y0GoufF70Jt3eGKox8qFsOQpAW+dCpx2oqzA=;
 b=CwtV2LOjw8kjiMktoop9YYWL419bRx/i1Tef99C/ibkBx8ODYyOqxs2pjqA2kyunEDLFg3Sf+1y/X8YbpWXrMOEJy5xi8f5H79ztYFrBsu29GpdYxeLIj60ektzuIk3NDoTYSsxJr+PyBzacWbnFWEhzGpPjL6G+Q4Pvkppcrfwofwms9OCdn1wXsMqgRzZt3Fvi/PdHg+wlfuL3R/QYZkZoiZjKF+PWBm3MlfUSeYdZzvrhGHqqWGZMOqT2u/agcPI3569SOx+W3zfQYffBjbgthtXSG7gm4+1YwNVFI9XuOd0nK5uQLepE6BUuZxeNqhV1oBQfkZ+nm6jGc3gF9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 131.228.6.101) smtp.rcpttodomain=google.com smtp.mailfrom=nokia.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NbaT09Y0GoufF70Jt3eGKox8qFsOQpAW+dCpx2oqzA=;
 b=Rp6Fs0Xnrusax0QBK3u+dpPHOpnUY46WG6KsYebtN+VSQ8B0OYdW6agk0GUPDHupy1HiU7N72B8IVOAkWS+ePgwxZLaM+ITgaWdxTpWOYiYPhv0JPBBlOtfgMp6U4FuA8s1oKMZpuHBnvAJInLd+5miFvBbe+YteTJrTo6Pxa0Y=
Received: from AM5PR0101CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:206:16::33) by HE1PR0701MB2827.eurprd07.prod.outlook.com
 (2603:10a6:3:49::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10; Tue, 3 Nov
 2020 14:23:41 +0000
Received: from VE1EUR03FT038.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:206:16:cafe::f8) by AM5PR0101CA0020.outlook.office365.com
 (2603:10a6:206:16::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend
 Transport; Tue, 3 Nov 2020 14:23:41 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 131.228.6.101) smtp.mailfrom=nokia.com; google.com; dkim=none (message not
 signed) header.d=none;google.com; dmarc=fail action=none
 header.from=nokia.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 nokia.com discourages use of 131.228.6.101 as permitted sender)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 VE1EUR03FT038.mail.protection.outlook.com (10.152.19.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3520.15 via Frontend Transport; Tue, 3 Nov 2020 14:23:41 +0000
Received: from ulegcpbofur.emea.nsn-net.net (ulegcpbofur.emea.nsn-net.net [10.151.74.147])
        by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 0A3ENbo6005363;
        Tue, 3 Nov 2020 14:23:37 GMT
From:   Peter Kaestle <peter.kaestle@nokia.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Cc:     peter.kaestle@nokia.com
Subject: [REGRESSION FIX 0/2] Handling regression introduced by a62387b
Date:   Tue,  3 Nov 2020 15:23:17 +0100
Message-Id: <1604413399-63090-1-git-send-email-peter.kaestle@nokia.com>
X-Mailer: git-send-email 2.6.2
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: aee9259c-c7b1-4c13-d590-08d880041023
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2827:
X-Microsoft-Antispam-PRVS: <HE1PR0701MB28273709B4FDC8ABBE97EECCEE110@HE1PR0701MB2827.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ul/fINtCflTAqpxs0DOxD623BEUgUy7kxHoY8SEQAXkVGFbQuO2jMMKrHeC4naG2did1Fr+8NXirldkrgUPd9rSboJjS0Mx1nYaQD1sl2lm7xIR5kELvo/xE/vfp1/MS/vt57cX0mJSYrsHp8/aEYalzsbPNwGhwAXJAXTvR0f3GjKA27wUY4Ww0UrQXtvNxauhNDOKTPs7v19pA1gMzdRLqtrD0MgVHjaxiiSWnHBL1Q9zGPXECn9NS9eaObTtxXo2o1Suv9GHbz21MOH2/0vJJs5hcRj/PrKTKoEeNKTBYOzoKywbY3hEJBZZYTWi6E13Qw0Hp9xmwsoeJqDOvmeZoQ+UVV4gGrRe7YDpuffFpDFyHBmDmVytB9d8DCopykztsECxpHxaleLeTIw/52w==
X-Forefront-Antispam-Report: CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(46966005)(316002)(36906005)(82740400003)(44832011)(4326008)(47076004)(107886003)(81166007)(2906002)(110136005)(86362001)(6666004)(478600001)(356005)(5660300002)(82310400003)(2616005)(83380400001)(36756003)(8936002)(336012)(8676002)(26005)(186003)(70586007)(70206006);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 14:23:41.0984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aee9259c-c7b1-4c13-d590-08d880041023
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT038.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2827
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

