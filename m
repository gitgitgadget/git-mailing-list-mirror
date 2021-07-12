Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC5DC07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 22:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23D1F60240
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 22:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhGLWev (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 18:34:51 -0400
Received: from mail-co1nam11on2102.outbound.protection.outlook.com ([40.107.220.102]:11552
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230456AbhGLWeu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 18:34:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFFdFEohIcLHKBnMm/dnrwAbDoIq29pHqerrhj7NtnZe53tkCFubWI5eQft2bjYM0QCaQnCqI4Hzs4HFGnLg1lKbyfmolKpwDdT4J+00Jqv8TQXLPnAmGhJxKvFdYUg0kNTzxmgSECKzAkaoIV5Rd2KuhphVgkX6xk7h7fn2RvXSjRA/YSbHdrZOlBDz19B//0qTYoPzwyKRS4h/VlyaKjT8qLjVHc9OxrA2zO1+d0vxZSpE/a5qSe6hn4FIh4IOFRbRAJT8zeoW8QXh6O/cRgHnGikOfYMNtKsM0IjNBSmFf3aLFxw5dNjacVfxJmr7+D4tcPcWllOTVD3mAGZZxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ygszGIX50somC0tXx4SN7W1uQ3VUv1gfQHqncqdusw=;
 b=ic1P1gH+GE5HA7+nvczZdIGplZmD8G3fp0Rnl8P8CNIB2bwki4wYajJayJETTTS3zSNpjIahjvS8EhqcJDKz2lrWkaqowvwyljYpluOn1RLLHernP/fdllrZzt4ZPAPLDWnG/EBTnYAF2iWD+W7Tpc4gGRpJ+ROQ2dCls5PSnvbCSrAvLQAEID5UWcyupLdMCUXWYO6hjnnS5FLQuwlf3w1XKWsDmXB2XS+v+qzsc7MmvJX2wQIPBWdemK+DCeRodsqrRn8E1HvI+qR12Xb8iJgRqVq5yeMA4VlzTfbzZeDmO9YNtunBIfzalfmnD/6EtLshwyrzx52hkoLQHeldDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nexbridge.ca; dmarc=pass action=none header.from=nexbridge.ca;
 dkim=pass header.d=nexbridge.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nexbridge.onmicrosoft.com; s=selector2-nexbridge-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ygszGIX50somC0tXx4SN7W1uQ3VUv1gfQHqncqdusw=;
 b=vHbso923+DjkqfmUT9C0rFTnA52RaZCCfFdlAR4c5Aqf14Cqy9W7zwRZ/GLxhZwgj1uPody43T+isaqGDU700gE6yJAOAHK4OEbY1YujpBSx0rEXJwBfwJj3e8sVCpRNFEhEY+Vy8C1iL7AVvsRLaQUqjSon8VjTMc/j0qw8zvU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=nexbridge.ca;
Received: from DM8PR17MB4934.namprd17.prod.outlook.com (2603:10b6:8:3b::24) by
 DM8PR17MB4936.namprd17.prod.outlook.com (2603:10b6:8:37::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.27; Mon, 12 Jul 2021 22:31:59 +0000
Received: from DM8PR17MB4934.namprd17.prod.outlook.com
 ([fe80::7c5c:6e02:71c6:915b]) by DM8PR17MB4934.namprd17.prod.outlook.com
 ([fe80::7c5c:6e02:71c6:915b%7]) with mapi id 15.20.4287.033; Mon, 12 Jul 2021
 22:31:59 +0000
From:   randall.becker@nexbridge.ca
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [Patch 0/3] includeIf series for worktrees
Date:   Mon, 12 Jul 2021 18:31:36 -0400
Message-Id: <20210712223139.24409-1-randall.becker@nexbridge.ca>
X-Mailer: git-send-email 2.32.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:930:8::38) To DM8PR17MB4934.namprd17.prod.outlook.com
 (2603:10b6:8:3b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (173.33.197.34) by CY5PR03CA0023.namprd03.prod.outlook.com (2603:10b6:930:8::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Mon, 12 Jul 2021 22:31:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a58accb-6bca-451b-1d1a-08d94584dcbc
X-MS-TrafficTypeDiagnostic: DM8PR17MB4936:
X-Microsoft-Antispam-PRVS: <DM8PR17MB493697E48FB5BC1B8B4B7676F4159@DM8PR17MB4936.namprd17.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: erxJGM+Kzd7HLXXQuRQa0Uq6Q3a4akbYm74gaY6rB+vUM4ROLN4xXPHgGhDI3R48yk9ZT4su8k1fRhXjYTzmIv0mPVUQ1c3Mf1Lt3eXdbCkwbi78mIAGoIRVAwgebNCw483a4IM1uuLu8YkCsINrMOkohds9PgSC9Fm0Kh7pHxTv4AH6T/VMN6WLy8Jw4rCJu9dxXTslu/qG86EPRDCGAVQu1xwUkHh+K/y9tKzpR9VMh639B7xy0MZjW0bg8AtoE4aG8oC6+ZK36ZQ8gooFXBi3KvL8XzV/dFEF4fRFXZqpp+skGM08TckCSNPEilimUT6gUW9bdpHzAYzsz+NIBtkmbbV0t5zXfLnmCoeBB6CKsAnSHumrzXllCNXgDS3rzifB56fwG90Nn6HMkptrbP5EvklWUhtahSwgu6CX/vKgykyQyLS7b2mSZnj7EsOsLLFlMyowlq2AXouIgvE0ZclZoQ70E9Ul9v/BAMe5v3PXm19vce1trt3WAlPrggN0Gzqo/07so2vuyOVyA6ON57vMZ6k2DSgmLUOV3qdiGMxOYIArvxjMkib5UeC+IQz7/Vvl/Vh4BRdUfAFeZOWUOIQ7sjaRihdCpQDkQkA/ZNYu8CCSj7KE2e7lyk6arfFzySii1uslP74bvwpAKQb8RIintRJG5Rq1iFbudE5Qzgp6H4XIvXHSF6xTVERXnR3m4P3Kcjm4W8Dl8mdYxyXvlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR17MB4934.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(396003)(366004)(39830400003)(9686003)(66946007)(2906002)(83380400001)(2616005)(86362001)(36756003)(186003)(5660300002)(52116002)(316002)(4744005)(956004)(8676002)(38100700002)(6512007)(38350700002)(8936002)(6506007)(66556008)(6916009)(1076003)(4326008)(478600001)(26005)(6666004)(66476007)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EJrO7nO1ywWraUTe+RpbG01nKdopFrik66tKtNlLTvAfHnvfg6KnH4qiAzq8?=
 =?us-ascii?Q?msCuVNOYqLPmyK0/L4fqkX9UUvpr0fXdOTRX0NdAg5UIEhR/ToJupd5igv4V?=
 =?us-ascii?Q?au3gCF6Je3mV7txCIzq4qUw4X8RMcTNbbdjw3sgWYRFOQ7NT7FN1OV9J5Ulh?=
 =?us-ascii?Q?DLBuj+CFjYduU8gGv99ZuSiWXEeW1OVvuy+e6xdBTfYCXb0f3H6mgB+i6Q/l?=
 =?us-ascii?Q?Po3oxE3B2z7K45Ty1rBPndPJ1/AUeEi8aEBHOUi2/WqxN4xDAViCU/h5b93q?=
 =?us-ascii?Q?p1sHEofEtDJWhW5RSCRNNiHdPj/QM+wGWIj+8qVGlCEe+gxuhHjX+PMepE+/?=
 =?us-ascii?Q?Bv6WLAllcBp/g8tn15h9XCwc+7w85znN0jnLtCRwEovGY6sMcRj5EoLBVuqd?=
 =?us-ascii?Q?LaGQmWjSpjpDfJbCvItbjk7p3Bx0wpekhuxBPkHBXN40VYLIvv9yV4OtTnKm?=
 =?us-ascii?Q?3VEj0dGAbC7v2llA2xHt6zbr/q9G7ceWJAcl20PyziVqZuBNGWCX3nyo9QqQ?=
 =?us-ascii?Q?eCD7WYGKz/W6DMH60zmR2/PrGZTADXJbxwqt0pfXu9nGITxA2SJV+z7z85gQ?=
 =?us-ascii?Q?DOwVNPFyx7IcXffcE4c+MzHkm2roo0GOc1XYcs5f+NQXbCGJ2HOg/81EN95d?=
 =?us-ascii?Q?PHy5XIsrXv49Cj8LVRSmYMDm2SV9om9z9Yb8X4fmGHb0UgGWYgYapZ8T3taR?=
 =?us-ascii?Q?BDAQZ4wLniYMceofWtr95Qo2AuHEMaHNEk2/EVXOrDjPNpky4+N6bpDs+y2c?=
 =?us-ascii?Q?HB9ni5iks7/FPQnFnUHC27BsvIWEb5CJ1Tpye1jezSvFi3L6TX9e77Ip9cxU?=
 =?us-ascii?Q?ws6H9VzqEiKOenJjpisokpj+ITX6/b2qYVvHLek71cuW9bHdtRAaWHojeqqu?=
 =?us-ascii?Q?I+bCeuwM7Ke4o9QS7AAdaRodUPNFuiDmNZOewyKAKLxEadusBGx97wJUaDIF?=
 =?us-ascii?Q?BsGhMvIRdVDWipLw2v6qGJNoV+NFCTRbvSbVsui8aTGmH2YMVL9I1KhyK3eR?=
 =?us-ascii?Q?rUl0SXazuu0kV5y/JUSBGhQQyCXtkXVFXTAhAWiAnDLwfQabjnDEtKrDMsKZ?=
 =?us-ascii?Q?E3OHXTLhKPt2PCeg/mop31AhhDgWuqJoUYukvWu2OsW9Fn/aTq5TTYaEClpA?=
 =?us-ascii?Q?NL/MqpcvbPeyHmeKtG7cH2IPJNVxCtYFSqHlwt+C2QUxfrBsJJNNXtlBYGLf?=
 =?us-ascii?Q?Jh6lx2RRXNY26+I+Z1EYNYjbExJZ7DtUYS6lRCI38y6KOIDV91JGf0Ek9Eh9?=
 =?us-ascii?Q?PuOCZDGsy8/GTl9oZkgi9Jvi8bHNzpdrcmf/TXszOrPyCO9QbH3m8Au/tNdH?=
 =?us-ascii?Q?ePT1UfTxwLKPnzErfOA2wvGP?=
X-OriginatorOrg: nexbridge.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a58accb-6bca-451b-1d1a-08d94584dcbc
X-MS-Exchange-CrossTenant-AuthSource: DM8PR17MB4934.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 22:31:59.2474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d6eda728-7424-4770-8f6a-462632ca4c1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXIW8TNie3WiR5V/cAbFaYSdqdyJOiI7GcIjYuyK+8NJ4aHhGDq4nxe58KUaq4767fO274eGCI0XPF4owWBYzXzXEOWqQzOsFUb65x8zNaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR17MB4936
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

Add support for includeIf with a worktree: prefix. This permits
conditional includes that are specific to individual worktrees.
The set of patches differ slightly from gitdir: as worktrees to not
have .git/ directories, so matching repo/ is somewhat problematic -
suggestings on dealing with that case are more than welcome.

Also added worktree test condition to verify that onbranch: works
in a worktree scenario as different from the main repository.

Randall S. Becker (3):
  config.c: add conditional include based on worktree.
  Documentation/config.txt: add worktree includeIf conditionals.
  t1305: add tests for includeIf:worktree.

 Documentation/config.txt  | 11 +++++-
 config.c                  | 63 ++++++++++++++++++++++++++++++
 t/t1305-config-include.sh | 81 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 154 insertions(+), 1 deletion(-)

-- 
2.32.0

