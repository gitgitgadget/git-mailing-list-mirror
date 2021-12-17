Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AD8C433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 20:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238857AbhLQUjV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 15:39:21 -0500
Received: from mail-bn7nam10on2087.outbound.protection.outlook.com ([40.107.92.87]:19150
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233009AbhLQUjU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 15:39:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4JDOJOJC/XXts/mGNih7E0kFqn6IdO7nTPVXIbl1KiOcmF3wFI8C/GuoNIV2klWEstUlkKMLFWX/zL8kJ9bAOh7NBykfUPiGKDBGS3ZaUXWSC989U7otZ/9UYgu8uvblQVhrLgdiD4Y+D2edB3kA5YEROkXV+LmGNzBrbasn3+RNa+US9p5/edgqXqRoTSY3pLqfa0D1afbLJZbvRzzJPqKevqT+GzgHy9KGQvRiCsNfGSx65A1kVhkDgOz38LR000O2F04jtEuEPn8epa+csWzuWlijdm2R+30ug2uL7e7zv5w0qkYDUN2lzI8yJNJ3MSQmzx3wkHAB94MLw1wcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrJRBhyr3smdQ9I7WtaaJ6SzW0ORhl3PnIJiGFxI9Gk=;
 b=AsQTilDOuL1ExAJYV3Jt6uYGrPaaDiGXaNpNtPyQkHr+uy1ITH6usabG8VkpTB+WsG47ezjVS3RPcjmfGNP/Gh/d+1q15k8Z8JxxSTt76m9PuHQMg43QwdxHT3YlIG+Gjyy4YJaT5MWalET3YuZ2X3HX6IF+WFTSZ45V7CqRGdsTjyNE9SIIm6IaUvfR5eXuZF6IsWY9roULi75pK/zJn8j8FYa0cB0C6QmMYJTNkbfxzkyZhu8DRf9UsnQB5iJn/Uc/iLNrZrrxw7uIPGavglBvSd0c7V6TodjtL91ZKtA38Mm4GRzW847dyvAb5QguhIb1/487cO5YQYRjR0yW3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrJRBhyr3smdQ9I7WtaaJ6SzW0ORhl3PnIJiGFxI9Gk=;
 b=H/VsNuCDJPS4Br3WnekX7f43LMhnH6oygeadbzRNZhP76Gwra+tocxXL/qwBKqDIIPep07x9DqG5vj8i/TcNrLO3spy1+LJ59v4o8xD8jS77mNqB4g39PCHCrelkCmROjSP6xikmfpoNlP4cCNrakq9XEmF8IRLmKJw4+HFdraCnGIUrhj+MfATX6XPddeK4kd36VsTj6JTTW0fyFmycuEviAWFg5xIaNQr3FPv1UjzkOWvpeZ7gPDS2NBGGaDwsuqDZ3jyn12TEoQ0rUF6w3+yjDKZ3IEwwU1ANH8xkFZ4HCjGVYbNsdjG71n5jmv5jKbSDfyzHm6sj9kDXlKYmog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN6PR12MB1652.namprd12.prod.outlook.com (2603:10b6:405:6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Fri, 17 Dec
 2021 20:39:14 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 20:39:14 +0000
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
Subject: [PATCH v2 0/2] git-p4: improve formatting of numeric values
Date:   Fri, 17 Dec 2021 20:38:54 +0000
Message-Id: <20211217203856.2339161-1-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR07CA0012.eurprd07.prod.outlook.com
 (2603:10a6:20b:46c::17) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac16527b-0cf6-49e8-ce2a-08d9c19d49cb
X-MS-TrafficTypeDiagnostic: BN6PR12MB1652:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1652D6B175E3745ED204996CC8789@BN6PR12MB1652.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jqwjEdmVkD4jbeUOQ1ACOJGN5BYL+wFmNvICHF3oNH+b/nwJJhvf5o4wKNSScKMrjHLKog1O5MBQsBIMD0IrGQSFNoWeC/jdw4gPXCFMNnTF+WdRuckcbKfEcdm9HX2QW0FtbIXk8kgnsaG/6vUg6JN0v8vU8h4etmEImLO+DfHIqr59YbbthXIWUhUYrVzInASSny7IgC98MVhLVt1mR50FkY+X6zjufz31mwsmLEd2n7NRJ/GhWhLQaWIEx8Vqpn6jXqwD8vxNU0vmLobA1+c/4oglDRbZcvgWu+9e1X0uHLNuAOdPnebdptAuKPh3KmLBdLpB1NogT6z5eF1IfvtMVoDkIK79RDt6l/nNQ+WQK9W4w+iKFTuohf718xHwsIG2lyzsvgkogl0n5fJJ9KgvdptYXpAe7NUl8i7xVexjZLF7dOq0Dt8R5kY6v4oxttqJMjS2HxT9pyR8fxZqj9R7G4sJavnzYW5Pnkq1jsDIcxIcEhpJQ52ZeHfzQ5aOxMjiquJmQPt5UmEgay5lrFWCxdslR0Q6TUU2Ycra+nG7B8NkEs1ZUevvy886/1zUO9Bae87N5DwzAv/AN07HWXB//QFjFZpvqr2UvtCxjeNIvO1J7ybRFrhcYNoZN+z0WNY4Ev2sN9IAIT1e+SXO8GEzstjgBugVW9Z72i9A+8u/YLwtJum/UaoOM5NyLiZP2wyGOX2yXRloz30vhgSkjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(8936002)(66946007)(8676002)(316002)(83380400001)(52116002)(1076003)(186003)(36756003)(54906003)(38350700002)(508600001)(5660300002)(26005)(38100700002)(4326008)(66476007)(2616005)(6916009)(86362001)(6512007)(6506007)(4744005)(6486002)(107886003)(55236004)(66556008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JzUK4HCsE6eHYWOp9vFOIDM+FuavKcjyqav1FrSmCXaRSN89hhA8J6DheFcJ?=
 =?us-ascii?Q?Pkq2PbmfVO1rAmbuAeS2EAXRzHezOwteInqKz6W/6MYJbrLU955ncDg2mdlk?=
 =?us-ascii?Q?JWtB1acqSDsEF6xqYYmaEiMhg3euwhQDrHf7LTW61XyU2gY0R5s/ygCfl3qg?=
 =?us-ascii?Q?TIXNwJuaiiZL3HCpmRg1iEUMH5Cg0q27Cq9s2bSNdlIssD6GOn9Xe7n4yU9u?=
 =?us-ascii?Q?wDDdHbnDscd0AhX0gIUW9oUoaL5TIHzduPyL8yKnIVcBAU9ybvoVsYLRHyPk?=
 =?us-ascii?Q?aYav/wmV8OcOjUOlnwCjuTbQqwNL4m3fxnoB0cOBmHF+7FQd7BjEd40LAoH/?=
 =?us-ascii?Q?BWTmj41dY073cbBOowibTahBC7ezw8oLX6UEiCwtDB3lgST1paoNy8+fjKuC?=
 =?us-ascii?Q?pS3fO3uTblXRVtFkv9YRJqpz7O+xoo2ZxxotGN36bIEjs/3UQipulF2X7vIr?=
 =?us-ascii?Q?zHKGhdf25eudQvZQ2rVDWLuZwZouevfMZ4OJFI1S/dKweB5qnjPGhCuh8bIT?=
 =?us-ascii?Q?mhbW+8fa5rRPWWwr77G8hx/ovTL0saj8iFh974zjFzFy8zejd3Mg6TSTuPPK?=
 =?us-ascii?Q?eSybcgl9t5giy9ScdKJGXXrH1YwUoziX4ABj55zrbTlajtmTF3FMH1GIIEm+?=
 =?us-ascii?Q?qJL6jOMdw8tgXC7ISR4aLXspEsZoKW1BXeCXczre/HrgkgznU2R0FE2WzRQF?=
 =?us-ascii?Q?kAiEAAgWnFXdNiQySsGueGgQ1IKUmGlC2GV2u3IlJiVu+c+k5YliPqBDU1if?=
 =?us-ascii?Q?S3yTHY0+EqaZ8Yt0q0mEWAscXJxg7JOgXaEkjy4rqJc1xOcTlnJ5+BFpfkkM?=
 =?us-ascii?Q?tWMvSuNU9rdJ8eB7z+Os4trt1aEakRNg056B70l6x2cGS/D0wMesjClC11R5?=
 =?us-ascii?Q?069PCpZ6g3jJLqdr/i4cHGKnxRKxRz1jw28xU6jzWW+V5TgmvqUV+wv90lGZ?=
 =?us-ascii?Q?xDHDNIXbo+tYpcDz7VF2h+QVpI3X40Yn1uwdtsc4oaKCjbaXoqgAEHnzxCeK?=
 =?us-ascii?Q?mX5UAnoLWQDoc2tvsRGC0k/H48OHtmDIrM1qA5Ll2XPOJyPk4yDS91jBdGGF?=
 =?us-ascii?Q?Y5ngb6zthKVNdMh/Ix+amAjYQc29Hi+O4jJSxNgROwGbm3HdYzg9pPGZG5Yz?=
 =?us-ascii?Q?rOkDtWfmkxfjj+/lTQi6vbeX2/iJ1mcLVCkhVjb5d9igb1AG1KkuQ02eOZVn?=
 =?us-ascii?Q?wfxJmQcKMxzV670mKajcdZ2IFv4RNycrP4QGLkQ4D2VgB/vQvgl8itAdZ7sa?=
 =?us-ascii?Q?C2ZcT75on07q+IsL9W13nrgoUi9a/2MJHfZuBlYsfDPMBJ1svmKXMDWNRJkN?=
 =?us-ascii?Q?GbmS5uIdZGTwxEAhGzUfTc/ARLX15tFs3MmxU1tE6GRXTYs/FPqDsdN44nJk?=
 =?us-ascii?Q?+OiXdJrWmwiZ6WY4kWfuMgon7OemafTfsABweNfTN2GYW85y3xHz1IpDyNWg?=
 =?us-ascii?Q?SyxjEaT/DAToRmaSbzDyUCXGx8c1DE67B2lSwnu8oXRESmBDcpXa3eHQYd6L?=
 =?us-ascii?Q?IcATSqtxE7CUhkqPJ1i1Sa2F1b6RaE8srgBLsuC0MUSyBCsk36vQ7fpCQWeM?=
 =?us-ascii?Q?jLAF1fxbPs3VrhyL7jX2BPYTkuAGWLCva0s4PBGZRG5Qsz8aXq4N/b/rhLNr?=
 =?us-ascii?Q?11TuVITOQAixkq1UwQ1R/Bs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac16527b-0cf6-49e8-ce2a-08d9c19d49cb
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 20:39:14.4304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNQLz54wQgX4M9heFhuQknFDCm83zYOrRmwJjC5WJ1AzHlx+KB1VPhfeitzbVuc6+t18yAD6duZ8ukRtEQJnzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1652
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch-set contains patches designed to improvement the way in which
the git-p4 script reports files sizes and percentage values in an effort
to improve the readability of the logged messages.

Joel Holdsworth (2):
  git-p4: print size values in appropriate units
  git-p4: show progress as an integer

 git-p4.py | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

-- 
2.34.1

