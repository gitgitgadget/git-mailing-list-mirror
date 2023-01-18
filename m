Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E45C38147
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 16:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjARQfS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 11:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjARQeb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 11:34:31 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6B759B48
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:32:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHRgcyER0CgY5yXn1mwxSE4SB9VXFCb/58GEwuDSL+V37mPV1b5+IR0z8/535KEi+jd2DbDM9W35vUhZ6tEnlbQes532QjrVfWj0B5+nhNsXvgJc7FDQqHbqS1uaUzdn4Z51PXJ2rLvr/HQ1FhKGaBPc5xqK5u/JFbwHGUSP2dJXQBjLfvl0xN/JuMWo04P9kw7r2od/AQQAkccitdkXp1P1fxPR3Z1B22egNGcv3NM24F2nirvtUds+K0GYtbVjTv7tg5uwhbg0e9tDfH9BMRiC3LuFTib7IoRYIFlkknM/nGJOn/O5TmmQ8FKCpJmp8tayXUHw7XjwHv6tA1HIdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkRylwzEySmqSj4MLT7bXaLJu1ruejy8N7rGUYccdeM=;
 b=NmHzR218Wcg0mJlKYTupYqnNaYLGw93es7mybOSF84DlAHuupfgUEp8VLISQ+uTySpLyqklj/KYNMFITG9Rrl1RtmDpCMT+6oZ3G2LhuSfT5flT8xFxQumPYvSrrxkZ58VSU/CMaJlMqXmrEHt5mskrYYyUM2Fz/2VwFjEv3HvSK2xf/IJ/M5wrl5lyRhCaoT2LfT/DMhzvo7dWJUvg4dGqwUShpzHb0LX8ulbJibnE7qgOA/T5wZh1PjrOTaCY9p7wmxGaYFCQ+opRruQ7AO58Nu5i7PgPrW53RrniEst2vGpY7YbdarOx3Zt1xiZuNIDOTm/paDuxMf9tRJgE2ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkRylwzEySmqSj4MLT7bXaLJu1ruejy8N7rGUYccdeM=;
 b=ej4rzhjIO4eL0n+RsCtzKVJ+PmIJawg3srlWmrQfdnImCBv8EAh/tLwG84KXt1xSy4r8XvHwNM0a3KBzh1ojWWwkL1mHi90K1JDmLL/F09RBbBDOUoVtyc60xctraW7WcavZXbLzLypcsyiJFZGBkWPuG/a75kWcIBPavjZxwlQ=
Received: from BN0PR04CA0098.namprd04.prod.outlook.com (2603:10b6:408:ec::13)
 by MW4PR12MB6779.namprd12.prod.outlook.com (2603:10b6:303:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 16:32:40 +0000
Received: from BL02EPF00010206.namprd05.prod.outlook.com
 (2603:10b6:408:ec:cafe::25) by BN0PR04CA0098.outlook.office365.com
 (2603:10b6:408:ec::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Wed, 18 Jan 2023 16:32:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010206.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Wed, 18 Jan 2023 16:32:40 +0000
Received: from mstrawbr-Standard-PC-Q35-ICH9-2009.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 18 Jan 2023 10:32:40 -0600
From:   Michael Strawbridge <michael.strawbridge@amd.com>
To:     <git@vger.kernel.org>
CC:     <michael.strawbridge@amd.com>
Subject: [PATCH v8 0/2] send-email: expose header information to git-send-email's sendemail-validate hook
Date:   Wed, 18 Jan 2023 11:32:01 -0500
Message-ID: <20230118163203.488652-1-michael.strawbridge@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010206:EE_|MW4PR12MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 2138b05a-71ba-4204-f92c-08daf9719e22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BEGlwq5mBEnMYZb7kUjaCHlwKpTkjvS1jy/Oq3GdQrVFomnve1gk9qdBfM4YlhBV/wWeammYGoMfQhyFmYBeJobi1JgEBpGHn2iPZM2Gj3FLQXhg0Aeg/gY/OcahJwYf605H6m2GZ0WlrOyRsNYc5MMdo0ggnFQJ8N/N2cpafkgQsSlYzjDaxVt6oWOIlsx19/9tqVeaVqlrY+gzh4P9h5lUhLrRn1Dx/AIaFrYpFD4nRlGcG+WlTUoNLagsnhVe4znOMiS1GFNEkBepu4b5aW1VV7ILknq28DJJ1ACivCwdK7Qy5DXnphJZ/+rr9r216tbYYjuONKY1s4XUNc5Gy7hmUVve7Foyu6UvktLGOh82CwgERFtwgcS4cZmrMhN5OMPzsKBrB/iigLimhNaPUW7Jw536RWmXXn7NVuEHGbrfzTDpRjj1TjDQXfuCOw0MUXWQacbhwYgsk3TkoUjcIO8p0NII8Qr1QjOGDKh9muEyexasP2AfvNvyUK5ZUmhp63zXFV+ovybTCj5UyhQq7BkRfnctETXlaMkCNxEUG57I3mQI1+5Fe6jj/lQbrrAXP7LDfkOf5qvQpnkubNcIrRPBwP++9H5SaeElC68iUlTZXhoQ9D7ibpY/xKChPVdsY6vuYg7OxoNbntE7xTvsK07LFojObmixjwVy34unVbuckTFNcCc0KsvehUPBRsN/ic47+CbQEET7spMcWit4cO5LBNu0GKbkjUasX1T4zrg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199015)(40470700004)(46966006)(36840700001)(2906002)(26005)(4326008)(40460700003)(70206006)(8676002)(70586007)(41300700001)(36756003)(82310400005)(36860700001)(6666004)(1076003)(16526019)(186003)(83380400001)(2616005)(426003)(336012)(86362001)(316002)(40480700001)(47076005)(81166007)(7696005)(356005)(4744005)(8936002)(6916009)(478600001)(82740400003)(5660300002)(44832011)(15650500001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 16:32:40.5590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2138b05a-71ba-4204-f92c-08daf9719e22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6779
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch version addresses:
- extra test for number of arguments in the header t9001 test
- removed use of envelope in the documentation
- re-arranged the validation loop and surrounding code to be closer to
  the other code not in functions
- made a note in the commit message that the moving of validation later
  can have some difference in stdout compared to before but actual email
functionality should be ok

Hopefully this looks better.

Michael Strawbridge (2):
  send-email: refactor header generation functions
  send-email: expose header information to git-send-email's
    sendemail-validate hook

 Documentation/githooks.txt |  27 +++++++--
 git-send-email.perl        | 109 ++++++++++++++++++++++---------------
 t/t9001-send-email.sh      |  27 ++++++++-
 3 files changed, 114 insertions(+), 49 deletions(-)

-- 
2.34.1

