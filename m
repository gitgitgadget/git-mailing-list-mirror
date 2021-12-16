Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B904C433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 13:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbhLPNrV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 08:47:21 -0500
Received: from mail-bn7nam10on2054.outbound.protection.outlook.com ([40.107.92.54]:19168
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229840AbhLPNrV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 08:47:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWkukpsJeH+lNFVEm87nlzimAxxim7vCbh81SmJeHJPqlVKb48clU+5+dSsBVY98FkIdzEb/oeeHfObURLP9qDRtmS8lYBuIQGMiWKoMV3NotycvBgDhLsfHO9zDNEaLzqCaFvDuXshtL4uz0PYwHe1cqVDaPhpxeUD4MsmOgjTbirhjQxYsHFAa+wAXcUuPHD3F1ufz1gP4ewTKx7UnDzM3qu4V+cXbY8Rm2uHJuGnTEYq8VYThDrvSPzG3EreIH3BB+j1Y166SlqYnSpPvflJhY6le9dft9Nj1HKUmoPt4qdUTh4nBMnUeo7BEq2W/q11nZcUZWXIm1CspsqcjEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmIOtHum3LppQNCBgy67TkSFgKUpGFeTs5Nqy0AZYjg=;
 b=jvbHjHiOCppqyu+nadrUE6U8BXztuoqQAgPK3NesD1mEXGyaKbXo9qWEJbseeFyuhIsoVYq411keVReZIksKalWB2IL9wrn6x2DZqXvNYqi7idKQ4Nar+uBADkqytfEhDzvpyRdCD2cYqSa/blBV6Pm32aXC8YK28II1kq/VgNyrMaz012AHgy+NT6cgYPEREx5FjT15GIkuX1Qha3qlQi00lmALpKKxtZ9NH0slti6mDUkPE3VYckzqMgKdx829poganEeapaWcdwrOdZrna/nE+kvd+rX3vXlu0P5eGe4WdKIJXTQSrqrXBtz3sa5orAywosVYFKQCTAXClaU86w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmIOtHum3LppQNCBgy67TkSFgKUpGFeTs5Nqy0AZYjg=;
 b=dE+ssUFbUisvgBcG5zFpGQhFNAoWU+VlPHJleCxwNW6wAVRxz9xAd5CHoyeX0IpovOkBsrqTuSjo3XhbYQYDfxppdCHMaAYsfrHeZd76hfOJwtjOgw12VWmm9KRoh725FQHm2DwNAuOYXU2SgYRYFsPdd5WT8Mnvi7fzMtUo7Nn+Sbvv7sFa6M4o1RnRL3GCB6GA93vhWOOAPBsXMAmRx7Rr6uuOWPYzvZSExhdx6HjXDX4aP4tThXkp0nWtUwMQpxPkHPfYjXxINhLQuzraikYazk2ggUuE2fGfDMqrg1LlgPKS47ODjs7qu+p5tHQfUBd2fngMx+U+njmiyJroBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN8PR12MB3443.namprd12.prod.outlook.com (2603:10b6:408:63::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Thu, 16 Dec
 2021 13:47:18 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 13:47:18 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH v2 0/5] git-p4: fix RCS keyword processing encoding errors
Date:   Thu, 16 Dec 2021 13:46:14 +0000
Message-Id: <20211216134619.2048348-1-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0028.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::33) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77fb99da-75b3-48f1-191b-08d9c09a9350
X-MS-TrafficTypeDiagnostic: BN8PR12MB3443:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB34435B1D922F0FE6B2E33668C8779@BN8PR12MB3443.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qVY1Tyu93lkkxc8VppDn/6w7MNq53jS72yawp+Co/uyNxBvS21/yafqd+1RHsH1VrsCU55IzteeestS6q340eY4TZMp9vKW4yccDczHY5urBA7ZtttoNcvdU2A4s1PCLp0SmicVcMG0Rsj8NJrFuNisxeeKiWlx5Pruu1dvyvw0I+feVD7Mu4MLEjQKmJfGbudFv8e03P2bq4xm6UKsfW2oHxx9uj0ohuZaG46YD0wBjMWzOEQa52iRui5OPSM830tAwUtWFUXkhYku9Ow0BWwSmhFLe/GAMv0/HjUB6Trbt8i8lIcqgz0q6x4hH400v6WzrVYQDqS5AR3IjpcXgDNF0Fw2/d7gcGLYuDPJYVmmOhs1XC2ykvhx1lVvRVyTgzovWJUls0L7VYgObkwwk2kK9wFP45VEeK/OeLDBj9TNwvqcBgBlWPhjZ9Bb1icp4kkMmznUZ3k0RvPj1xIFEqVFdYB8J+Sbea5pHVyHP1rNxMxB1QlmYHJ7MYT0wgQ7c1bXcsBm9XXs1ktHx4JSpqx2LiE3zwyaFnaelzvMZ5smWU56l1e059tkOY1Mx0rb97eMUXGmbjvPwfbi498F9Y77N9T+HPgSf7uxjFUvy1praDIlbLBRAxXoqigDrXjZidt51EUEAf1Hq/xfBtUA8lldfKFiTsKjxu7IWJ2OLebZcuNmfTu1HNk6z2G3VOw7m3wvQPRPqJHuHSYI9ZUT2nA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(66476007)(66556008)(8936002)(6512007)(66946007)(36756003)(508600001)(38350700002)(26005)(1076003)(86362001)(6916009)(4326008)(55236004)(6666004)(4744005)(83380400001)(316002)(107886003)(52116002)(8676002)(186003)(5660300002)(54906003)(6486002)(2906002)(2616005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D7e69d/ZLWWDrqxscKShagXfuQQfrVbxYdlFxC0DED9eKiapqMruC9z2sJzg?=
 =?us-ascii?Q?yjj+ORkRKeu4rJNW0LUJj16oT/0d3rFjLRrUKvqt+EhKWcjuioKKpevagoQl?=
 =?us-ascii?Q?7POQfZx18UHm9SXBHfJLWGwfk8qd1EvKzFXn0ZgM+Ou1bfV62qcQ9mWa3RSQ?=
 =?us-ascii?Q?LYV45QjSPBzvF6/V6ymRaTb8PrL5rPaWTnkoYjFZ77PGULdl50REHQW7F2fr?=
 =?us-ascii?Q?cx2CTrvFALQjLiYLdAIKoNxcc0ZqEoosKI+Zw37i2vjZR66SOWo/CnydbCFX?=
 =?us-ascii?Q?PskvP7V6jk22yGNSuHDU0lg6srAFWEURVAJ1zXJgABbR55zhR4o6LFOUVTzi?=
 =?us-ascii?Q?cIEe9rKST+EADNbwiUoegJmuo3aGLqW6kO6ApKPwXtq1BF17ZLMJOnrTMkML?=
 =?us-ascii?Q?l5Igc9gLMgwZKRmFS4nEP3lJhzoBo7z39dmUNXMuj/df9Hg61KPo3w9BurcB?=
 =?us-ascii?Q?vbChD5/gAjlR/EBaJ7gvLV1pTJe43uviwgIb31LjbiSAnEd9SvSRZ4sHN0mJ?=
 =?us-ascii?Q?8ateY01bx0RhvWaO6opdd98MO0MtP9dSsGJdkCOoRbFyH5GoM5PAqPLhIcTU?=
 =?us-ascii?Q?+hJZJxi954//6ZRWME92nhyRrJt6G3+/rRfvKwduCHdwf9JJGKvK/wobYT9r?=
 =?us-ascii?Q?Y4dDI0AJKhr1joKVWdmgpjlkQ4TqyF9PtYqpvoyGkQstr8MX+eIc2lCR/nnV?=
 =?us-ascii?Q?bD3XSf+dSHT8V/2KiKdkplu8d/SC2ZCyb+gwtYgDgZaK7KgoYaHDGPMWhAfi?=
 =?us-ascii?Q?zaxD7EBHIkh3j1nIWUuGNcZmvJ1OjLibXthJRDQ7ceXsXhDiVdUhdqp3cXRH?=
 =?us-ascii?Q?qI/zJBr37RFDBrlpswsV5C4k9nCOsSxD0qEmhFXS4Ik1iuLIOq0b4sIHAA4m?=
 =?us-ascii?Q?HoG/Sh1bLc7ruaiLVim9YH/eV8mzWGAE5Y/6wbBWJik3Bv6B9RI9pssfybi9?=
 =?us-ascii?Q?6aWyKRIoTc9KeoFD4f5xFTq6OTXI2gQSYkpXEYpaSaBI/NFU8DomyInKEi03?=
 =?us-ascii?Q?CPoOYqLVpAGjhTLihVO9S1GVCOESKaFLGx2OVX8Gmg+pLETGZDy75PwiK7lt?=
 =?us-ascii?Q?G8zyBUpoReO2EL0ip+ZdD06HQsOmvVt4JsXxCLZ+ldQEdDcuIHX63+fGWPHa?=
 =?us-ascii?Q?yeNWjMH5MBpmkqt7gBo/D+GVv+gSJwyBjjWXcg/FVrxqys08xT4gDZEffuks?=
 =?us-ascii?Q?MYT3Cu9V1UVKHX0CS2zDvFX58+VpqCCoTP6Pim9OSp85GWRIHkGEABsdu6gX?=
 =?us-ascii?Q?N2JrtuXlhVayOgR7ufR1mKhmvwFh5hbmw0f+3M7Tr6UGcOZ8XHZpMJy8xGtw?=
 =?us-ascii?Q?g8xjLEmQwuaSQ6IuojUGe43QhWVSJIV5VKEVSdcIWFqcg55XO0Bk4zDprgF4?=
 =?us-ascii?Q?WcFQKJsZ5NCioZk90rEPTYv/2cRie4dzX8Qq+p5emZ26lYPZXxlG5qIqJTIQ?=
 =?us-ascii?Q?CLTXWCp/lf9vLQKFfFOMAVwbxx2u1JP6Tul34/kPyloNoMrAYQ3b4bc9fR95?=
 =?us-ascii?Q?9urAQ900r2w/F/ML8ogd7GIXVbdIcpY9UYYgCku6Wrllce4QgQLJ9jyqXWJ8?=
 =?us-ascii?Q?hMQlPt/AsjfP/ym7jqd/7o9RP5JSb7qcj6Q+21wPQcOgAIwCWUtmOedqi+5y?=
 =?us-ascii?Q?CAkcYBCFOfKaOXoen1/E3Lw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77fb99da-75b3-48f1-191b-08d9c09a9350
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 13:47:18.1690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dz17rxL26tBZyZVe3/ZUVX8+hr1T1R3dBtZTW04sg5Jr3P5bAqDHDZHLPS5JIRCE2Sf8ZeTVfqZwL0tUL5rgUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3443
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch-set fixes a family of issues with git-p4's handling of
incoming text data that contains RCS keywords, when those files contain
bytes which are invalid UTF-8 codes.

Among the patches is a fix for the issue, as well as some peripheral
tidy-ups and improvements to the existing code.

This patch-set is compatible and has been tested with both Python 2 and
3, and includes a test.

This v2 version of the patch-set seperates the read/write mode fix (4/5)
out from the RCS byte processing patch (5/5)

Joel Holdsworth (5):
  git-p4: use with statements to close files after use in
    patchRCSKeywords
  git-p4: pre-compile RCS keyword regexes
  git-p4: add raw option to read_pipelines
  git-p4: open temporary patch file for write only
  git-p4: resolve RCS keywords in bytes not utf-8

 git-p4.py             | 66 ++++++++++++++++++-------------------------
 t/t9810-git-p4-rcs.sh | 15 ++++++++++
 2 files changed, 42 insertions(+), 39 deletions(-)

-- 
2.34.1

