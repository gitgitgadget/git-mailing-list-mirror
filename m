Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B46FC004D4
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 01:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjATB0f (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 20:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjATB00 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 20:26:26 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0ADA295A
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 17:26:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xwa10I1X8GWSw7PDx4S6eDGxmsbzvUuwvrZvCFbtnYn/XqVuc9JKK4WY6/ofgpMia8fQDaqIInXD5YNhSFMEm+FXYlmKJIb2/qWSdwYP+qhd40+9ddsCE1RMn9bI5cnYJrDf6h9LVfArddXF3V9+lR5iJGpjBTBqc6PKdvGbi5/+OlwAhswQIYwpjjN7SaX05wjllwtyFmSByBWbAQs4e3u5Z/ftxhJcsyxlHke3X7ttwcBg+BdS3ADDRpw5Qp8L75szvf8NkEgqc/8E1qBAhMIY7cttO3ZOFigX8teqmLXu+liLFv1J1vCDBOF/aS53SXsBTivaM/N79SRAmQFyzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMKGbhZqfoAnNrcSRk3Zl/OJtWgVZeCBbwvGYZiox+A=;
 b=lRRfKiw1Gn71iF4uzy28Z7O/wfyH2k2jC7kKjfalQSl1FqUg4YS00hnuAfR4Vcs0lkeNtJmfAD+su47OruKwEJLK91F4CKmDG4qrmKiYHsVAWJahjeJ9SfgU/7xn3WUvEzAI/sU/goWX2180iaMyy7s6WvRhDU/EuXhBRhmMgOy7tbR7XVMbRHlJLRM61reP0HrYkpKQjpZjbaejuUwQBr7CAEBO1QGgnC6/ErDN1cic76dGn9NM/AB5jIClk5GKYh1blo7ePTpNl4MqOYzMpbGOcDR+ILs1fWVDy1QtAV89pGjkkERvRel1hociyrlVv24wrgKcT24bidd5MBY89g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMKGbhZqfoAnNrcSRk3Zl/OJtWgVZeCBbwvGYZiox+A=;
 b=G7Yl3ZWu7SUw4lSovoG8Ul9Pf4M5xrbQX1fRmXkcrRXymZ0gbSCKKpyJRMfBbDXIrNup9wRKn6wB6JIu/Wwd0tdgn9ZWm3S+yRvYUVVyWKFosCsl7ioRLZrNkrmVCXEhs7YHVg50M2Z8gMWyoyCpk0k8CSofBxrXvmaSFvUU0KQ=
Received: from DM6PR06CA0017.namprd06.prod.outlook.com (2603:10b6:5:120::30)
 by SN7PR12MB7909.namprd12.prod.outlook.com (2603:10b6:806:340::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 20 Jan
 2023 01:25:17 +0000
Received: from DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::f0) by DM6PR06CA0017.outlook.office365.com
 (2603:10b6:5:120::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25 via Frontend
 Transport; Fri, 20 Jan 2023 01:25:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT093.mail.protection.outlook.com (10.13.172.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Fri, 20 Jan 2023 01:25:16 +0000
Received: from mstrawbr-Standard-PC-Q35-ICH9-2009.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 19 Jan 2023 19:25:15 -0600
From:   Michael Strawbridge <michael.strawbridge@amd.com>
To:     <git@vger.kernel.org>
CC:     <michael.strawbridge@amd.com>
Subject: [PATCH v9 0/2] send-email: expose header information to git-send-email's sendemail-validate hook
Date:   Thu, 19 Jan 2023 20:24:57 -0500
Message-ID: <20230120012459.920932-1-michael.strawbridge@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT093:EE_|SN7PR12MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 27010d1d-f38a-4435-0982-08dafa852fd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ilq9stSczQ7NOzWUL8ZMfPRSYxFhHqcG+I4mixaKKLDV+6uaOIh9QPEcelEYb2l4Evxijyy/YYi7F0DdPXHJiUXHiT9i3JBe8JreMms2h/AyPwWrzcAd5h/GcgUY4eHFDzgwOpza8eMYie/M2vypPzI3hIfK7RnWt7TSd6vvfBhxvDKtjgu7dVfS6QSEpjJmz3NGpTaAGxZ46vh1iNMq4rrE0U/cyGpFxZZPXmq8HpsjcgnMQ9RF9UPEQ0WUl7aS1+P+Cp4pQxven2TxrpHAybU6sF0HUDaIJ5P4gLj17xOkGFwB9/XxhZM6XwEZO/G+pB8Cq3lP/SeLIr4R+o7/8mj3aKLoi5yV5ObqB+Sxx6vE+xFEfEkfWNTHSlTos1KtUlyoC4K+euMKoBiar7dB03gZLn6u/n++hndgOtykWpKrPgTiTC+aOw4TDVEP/921qomCobaTvliUhf+CfslukSTnfrOnuodSo33yFU285615qIgXii+kEyV/hiAm9E/gDN3UGzK6hcY1a6Muwd/Mtc3gRN69m0jYqh1S2VlQHPCcOCzs4S16+s71CAvuJ/34ck9MUTee9j4u1FpijOPHjI1jOBcF0aHV61KSehtiZXvnFzaBMv4G1rVW0qduDb3zrAe0M5IwPedlQIE/K4Gohp4hKJ/famEy3A/1DEMxVTY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(451199015)(36840700001)(46966006)(83380400001)(36860700001)(86362001)(8676002)(66574015)(6916009)(4326008)(70586007)(82310400005)(15650500001)(5660300002)(4744005)(2906002)(47076005)(426003)(26005)(8936002)(498600001)(1076003)(16526019)(2616005)(336012)(6666004)(81166007)(7696005)(356005)(44832011)(70206006)(186003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 01:25:16.4516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27010d1d-f38a-4435-0982-08dafa852fd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7909
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks to Ævar for an idea to simplify these patches further.

Michael Strawbridge (2):
  send-email: refactor header generation functions
  send-email: expose header information to git-send-email's
    sendemail-validate hook

 Documentation/githooks.txt | 27 +++++++++--
 git-send-email.perl        | 95 +++++++++++++++++++++++---------------
 t/t9001-send-email.sh      | 27 ++++++++++-
 3 files changed, 106 insertions(+), 43 deletions(-)

-- 
2.34.1

