Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B443AC6FD18
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 20:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjDSU1g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 16:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjDSU1f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 16:27:35 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C65549DB
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 13:27:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZSxegPHfS33Gg1oe6RuVA4sCFYDJScoh5KkjchYa4XrbxsTxOYd/dSIlMaEeKAkuUqHzNGyTwLNzsOSOUD7BpZc4DwkoZjOGVPLlm21joZi2AnpP/wJsvx68qG1l8/PMkm7wuF2OW5RGn1j2170CV1d+NqjO6aPJsoWcoTW0jJ6OO2XaGffuYsub7AXSMT702zdquuWz8pJr78OZtbun1wn+y7HQ5X6fGA23qYS3EFNlcblkuulAtof6QUk+OY1Slh8fb43vcJiLXOqXX8u5vcr9X0gQQkfHMB2r8TkflQzxU8BzwJg7hDliln8ncZibg63o6swa0yN9+uRPRgVZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzbeljRFegkgbStn950McW1gHBN6jHRC1SBfy1PZ05E=;
 b=kjeChTKiUHA1kHNwjGNSjE6kCLOYGokpbHtWHdKklqZwxX2/Az9mXiGeBboobpPKXhfzphI7MLfcsrCfhuufstU3dhEiAeVonz9WXeUNPvH37pphPUHmPC6vl9xyBhdq3hqVuKwuVAANpQva/S9OcUqYdXzRXLr06d6+TR6nZqGk1w6jxW0oA1ShSM9o4Z5woyLZ+oOQplr7OARaJkblxauFX8JdFlf2NZ2FEkgzXY1dJopChT1FrvpW+xfnCm6eMwstFVEovrEqw1dibkRKAat0WRwLvw1mnUZZ7uldy3qnxM93D584VAtLHMdxtHlQtnjXZaZqkDq/FDvAav9BKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzbeljRFegkgbStn950McW1gHBN6jHRC1SBfy1PZ05E=;
 b=HSsc+TG0IcgUsNHu7wHjDIBWN7JLZ8SxHeOphw4GUlI1FJKDaZGQ0mXtBXGj37CFLS/ZGldMh8k6c+FkwAgTBZ08x7iNHmQFC2yLGMvHM/88Cht57YYLe2q/y+ohGi1ztdLxBIIn0dwNN8CSwYPNPoUZsBgwiP42TzbTqbEDp2g=
Received: from MW4PR03CA0116.namprd03.prod.outlook.com (2603:10b6:303:b7::31)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Wed, 19 Apr
 2023 20:27:30 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::85) by MW4PR03CA0116.outlook.office365.com
 (2603:10b6:303:b7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22 via Frontend
 Transport; Wed, 19 Apr 2023 20:27:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.23 via Frontend Transport; Wed, 19 Apr 2023 20:27:30 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 19 Apr
 2023 15:27:29 -0500
From:   Michael Strawbridge <michael.strawbridge@amd.com>
To:     <git@vger.kernel.org>
CC:     <michael.strawbridge@amd.com>
Subject: [PATCH v10 0/2] Expose header information to git-send-email's sendemail-validate hook
Date:   Wed, 19 Apr 2023 16:27:01 -0400
Message-ID: <20230419202703.2911836-1-michael.strawbridge@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT039:EE_|DM6PR12MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: bbb8b0ae-c1cc-4d06-8b83-08db4114802c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nk4a/N/2DXymrFXiO1Ylv2CFTaR86ZskA26cOOxgpGHr6vnFsahh1cn0sqOOuJvLeRrc/HHMsdqaSb3LpBFvctrJihcKTdPM5wfgj1pZxTyDScF9nECCAZkWRTa9U1PJI6Kjo+fZ942FVFoeQ0e1JF8KI5NIrLeT7bbnFrSmnJi+wOMY83VGwnGMXbZA9WjHi0+yrvVz6kmpZq49WQGReBgX4T3lE8Wauw6zIrsE2mCRGrXJeLXO2mBprDqZrzd6P/VpyMKvPfUTrdlzhvemik8IVL1qIul5H7xMzGecR3+npXDibh0Tei1bvNIcsjjQB1IoVjx27KprpBs2SX9lxyCjilRgTZ5KzKVZ1lS/DbfvkJe7eLVX0lEf0sBaadXOJwR1/tlvv8TzD6gT4Dl60l/HAe9C6zFHw3hcb05LTbbg+v98Z/2USXnu8I38xPtGBRPbI1uAnvQvIMEyowXE8Vn0AZUnt4B3F57YXeWPKCCwpWCbH631MN9OhrB4lIujhWDZz5ddEm1DiBRzzDdJU+SXxh8jJ9VKtTMkXZvzqQdDG6weCmYJuSr7ozsL58LLMF5wrLtMyaMbysYjZfjSwd1FuyD7sh0Hv2/vzVuh6qSvLFEVqBdTgHydyQR7z1SY6Z54l83kTX0dIgIsILyZGtdptVyXDs3yMYF1C2h1OlyPhMr/28Z9k01XuldJlKl++gxF1+6nETczojqN5PE6d5hDUe0Oqh7b3Z5s6U96zbQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199021)(46966006)(36840700001)(40470700004)(36756003)(186003)(70586007)(6916009)(4326008)(316002)(70206006)(478600001)(40480700001)(6666004)(82310400005)(8936002)(8676002)(5660300002)(41300700001)(15650500001)(4744005)(44832011)(82740400003)(2906002)(86362001)(356005)(81166007)(336012)(2616005)(426003)(1076003)(16526019)(26005)(40460700003)(36860700001)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 20:27:30.5799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb8b0ae-c1cc-4d06-8b83-08db4114802c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My appologies for taking a while to get back to this.  Here is a reroll
with the latest suggestions from Luben.

Michael Strawbridge (2):
  send-email: refactor header generation functions
  send-email: expose header information to git-send-email's
    sendemail-validate hook

 Documentation/githooks.txt | 27 +++++++++--
 git-send-email.perl        | 97 +++++++++++++++++++++++---------------
 t/t9001-send-email.sh      | 27 ++++++++++-
 3 files changed, 108 insertions(+), 43 deletions(-)

-- 
2.34.1

