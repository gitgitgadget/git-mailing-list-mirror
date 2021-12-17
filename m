Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2A6C433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 13:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbhLQNsr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 08:48:47 -0500
Received: from mail-dm6nam08on2067.outbound.protection.outlook.com ([40.107.102.67]:16320
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231431AbhLQNsq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 08:48:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3kZ3pQP7KrTXoHNeWmq3VKIw7bac7vgyt1Cz9Xy/uN9Sqz79yU7bd6lvsBoUHXLUSG617gumF+kILIcd6IDhVn8njjCqvh317QcTI15TjXCv8d9Hn/EtqM6nLw2707MLHrKOKW4547HUgOqvRq6csiJ5fvY1bN+KhMPsbxs/tJHNwD4tIMy0EC6aE0JF0hSylvmi2KcH2IpZ19ezvQ+Dn8vuCyWcHJmgRAaEhKFn7CkvUfbvKQF7svKR50A8bdyC4UDbS2kmi8jDm0xdhrXB5oqyI79pVfxxlaxPjfuMZpX1ywdpfaMo5y0HQTxjLAtT2zlxWxMTFDdcciVdEbo9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2tDLoblOogcYEdwOAkg7VxZwIncAKfXbNa3Oex3wGU=;
 b=QauuSgxbZYT4ynbjLa72OgJSrhf3Ba4kRD/7WDPwLtTOi00VviUxy4KjZQU8lgGwW+cfC2yi618t6bJaX41E61doCNvw7ijaD0ovexWt3GZSjruzehQfhYwI5P56HY82vkAsR+/eOBwJw0SR8o4LImbYfg3gpyunlqC2TcQtiy5nY4xxRTg7ufXqy+QaxfrZmntLVTnC4mG5wROk71ON5I6pu7lfiyLIdGxDCFi6dVO335gyrq3kN07MZraADweEuOyKFmMEXIN6vMNHeF7zKpcldnSkLXeVAJ9G8uQF2qwcHu2wotPpashhaV2V2D0HtLk3ECvHvuFmjTK68ZNJ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2tDLoblOogcYEdwOAkg7VxZwIncAKfXbNa3Oex3wGU=;
 b=MnEepOS0E+yBwubHKUTBuUpE8nbu2rn9CNlhxm6cPxxVas8lHnuBpebLQdyV05M4oaZU0oj6VncFq/TLcptQ6CKTlZswTneYbkgIzSAcEY9B8N2QZKl2US4wfmfKvgBtw9D4PSnrNb8n+taDo6xm6oOgREwEy8yqaPKeMYQZarwDQg3WHaGKcx9cF0XWiZUSmZ9em31uGAG5+FrrOJbi8OHoBqJhPiAN2dvjRPGNiXmuz5PCts1i3XK43IYIxlEyNPhOgAD80G5gkIDoEWoetub5MLM8bEXGY2dHLpuNDwkOjtsrYgDcLi79XMJplJJSZERDxrTnIWLCLp4ZAXWJ+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN6PR12MB1651.namprd12.prod.outlook.com (2603:10b6:405:4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15; Fri, 17 Dec
 2021 13:48:44 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 13:48:44 +0000
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
Subject: [PATCH 0/2] git-p4: remove "debug" and "rollback" verbs
Date:   Fri, 17 Dec 2021 13:48:12 +0000
Message-Id: <20211217134814.2112631-1-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0113.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::10) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87452314-1f5b-4360-23ee-08d9c163f141
X-MS-TrafficTypeDiagnostic: BN6PR12MB1651:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB16511FFAAB55B4D308FD2526C8789@BN6PR12MB1651.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d31g17p1XAD8tCV9cWVoXNrJpFsoluCeQ1OxLy10l9KBQQFte1I0DjbfRuLjeljazm7Beo1fg8Oxiroi1TpCHQ2VDHjiimDvwWslJ6BZm7e0JbEuwQWl+PoJZmqrGKFsgXUiqqGhx/4sr9vBaQlzVNtypYtijZ/PSFIb0h8z2QUuhY21YXAGkk9V3s5Yy0L16IR86tu2BZqKjJlgelCiAcSPcH8NOImA2guMYQdkktacTvKmqP30hbAMjRXXrbBUWnO51VNI7+pjoPSIWID/rq+5g9ClOl1wADiTtQ8GYU1iBD+Xx0aW/3UTqjQvULsBLYDJI+ek7pBqzF4m8yaZcSu+ns/E/T26Tz5G455zd24H/vG7idsJC9SzzS0OnqrXNJpAT809yiNGBNUIPMYHRWk3DnkIuizqG+qcR/64Iglt5wPFk6tIqSWYwZDHvWTaR/6c9UoQIxkUoZpDrjVg2e+aoIwM6g0NkqRyrkBZ5fQfWdJ9sWnRZ9irC3/PTBBepHogb5U2gZBaDdmJnqLXI3XXPQLDNl7xH9gQTtbUg3lySA09RNWw7lGGm0ZAriB5eU2ZyvlhZptFHsGqvRx3I2roQhEAwQXIAV4tXSE41E11ZYSpOmbeCPQfbWyeS/H/v+GqYrP8Gd+UDTb4L7S+6RWRSzclYhqyV0+rpHbRhf8PNxkNlqIfOloPiVc+jkOe79J61S844KaYkG7RNSIdvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(4744005)(55236004)(83380400001)(186003)(6512007)(6486002)(1076003)(6506007)(26005)(52116002)(2906002)(5660300002)(508600001)(8676002)(8936002)(316002)(107886003)(38350700002)(86362001)(54906003)(36756003)(6666004)(38100700002)(66476007)(66556008)(2616005)(6916009)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3xDnQnF7oLciGtqRGIx/OEx88kFZ0xNH/mfGN44A2wEG/LQmcjjRg0c2PBYV?=
 =?us-ascii?Q?vMubTDsBwL8+QeRk06jWs+MWL+w0aeMdpaEl5OpuC4s+TUaQYEDf+5vjHYaJ?=
 =?us-ascii?Q?1JWPrV1IPQkoZHd8nPKpkMazvZ7869BYHoLKrrialgMFDEBlRDmqwVPfpOEI?=
 =?us-ascii?Q?gYXuVyQOrbwWaQdoL8yWiAvZIFD3IDygjaHzVgrETQKSyEoAm95i6SVM8CKz?=
 =?us-ascii?Q?/p2dGakKzQYyFlsxSPfTDB5tnMlNzyu25qMMFs+vAJ2HO/Gy9Kfu4CFGCyw+?=
 =?us-ascii?Q?j/A9XfxQ0TeuQSAiCDFAc7gKNZwzqpFa23RhaArsnCWHhwUJd68OQjPYwJTH?=
 =?us-ascii?Q?EVo5e3n8IpwV/PVP8DkHgF4Khn+GOu0jz9L3BRdwOpdpPw793L3VqK/MHUWY?=
 =?us-ascii?Q?xFbyaIOQI0nj9lCy8CyCFNLjN+GCBilnoWcksokhZBvmCZVdiIxZHHJNUduT?=
 =?us-ascii?Q?przf54ZIA4GJQlWuX4ITRji8fVWa+2Pq0+JJHW8t4vLxxaWL0GWcpaDRjLb0?=
 =?us-ascii?Q?HM7nVEt25K5/RSX0OjsR7xJdVU6JM6M6NgY5T/ksfjr6DxMsE1UGPZhGFEjw?=
 =?us-ascii?Q?32OQ6iBL7MnMJlEVvmSNH1wYL2/C6N48UB670458wsLEgSuKvg/kA+0R/ORJ?=
 =?us-ascii?Q?l6q1XdbFtROxuDVd5sjHDnKPNaJXiFRpQw5sONtGjYU5CNdPyAy2gF6H/G48?=
 =?us-ascii?Q?ie/mHhMQJRUEF79nceBY6pbE+chJ7r4yOWas6DMeermDtGdChLWKLrw/eUL5?=
 =?us-ascii?Q?9RMOvPq7qSfYl/wfY1+PqKTtv1o4SBBOsVEh2Y7WyMwD3+smd62OQIHf8a4y?=
 =?us-ascii?Q?3QfpdDTwlbVCDo887TZVRDN5vjrxR20L7/24CVnGtxxpiDTxXnyM+7yMIn9S?=
 =?us-ascii?Q?FUPKQfE3SSZo9Oyq4MFle0QplfTCz9bH4gcSqTU2AA4NpHdezj0uUWQ+HE98?=
 =?us-ascii?Q?cddbvsE3QzXIXiNg35Mv+qL/3Lj5tfU/GIPDAQOfi6ZR7gVMJyrZyqszwIPn?=
 =?us-ascii?Q?96lVgp/8H3X7FWrZFwdH+SbQOux/1qcktdY4MfcHxhYuXEpgFoMEqBd2INuj?=
 =?us-ascii?Q?KXMfJKU4DvXDr12qoiSsshhxLeqXnOywQR0tAN1Ug81KiTxNIFrxI6XeKXhe?=
 =?us-ascii?Q?KvC0hHrk3897Ex0LFqSX1U0TCx3tA5ZZ9PKkGVUW3wtJEtmYvb8afVzDuMsN?=
 =?us-ascii?Q?73GKBxawmEKGabk2aSlUsLMV8lSU0PtIsOS2vRfeWLFtlEjoCvNVF60uQ1c1?=
 =?us-ascii?Q?gcl4gRggMkBYhoYaAG5AI9KVR2vt82LJBqyc1SobJQq7N6Cf/yzJOKKNgk7k?=
 =?us-ascii?Q?3oOGHM15UvKJ62FnVK24JQWg8fSz9vCmUPIrg3ndgceBSL1KJFlhZJ5Ykilh?=
 =?us-ascii?Q?9jvPuaqw5eCp09vD9c2KPn7dcZcW5RnJ6sby0L8D55Nlc0OGshW9pbSUzZOm?=
 =?us-ascii?Q?0LnJMYgDPZGJh6UWZikjd/Y3O2asEM6xdt6sSOEMLCi2LKBo7PnifWsk7jUh?=
 =?us-ascii?Q?zeEAE7jkXudj+IK5A5R+TSJ6ZDOSlRga9P6l1GUfrlkAXzMjqrfV+Wg+m5T2?=
 =?us-ascii?Q?G7HWWOrTQAZMpKL7/wWXFGss6GJ9nJ0Q173DW73iSCtirODoi6NpRl8f/JBm?=
 =?us-ascii?Q?6oNTKMsCJICVMtFQLKS9kLg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87452314-1f5b-4360-23ee-08d9c163f141
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 13:48:44.6705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNMNaU65q8Wvy6S1trwlP30nWWagHRYVOCYXWE69NOymuk0X99NxtZNaBw8ve8WUIK0eMcwJBIoYaSEk3e+zeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1651
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-p4 contains a selection of verbs for various functions of the
script. The "debug" and "rollback" verbs appear to have been added early
in the development life of git-p4. They were once used as debugging
tools, but no longer serve any useful purpose either for developers or
users. Removing these verbs simplifies the script by removing dead code,
and increases usability by reducing complaexity.

Joel Holdsworth (2):
  git-p4: remove "delete" verb
  git-p4: remove "rollback" verb

 git-p4.py | 76 -------------------------------------------------------
 1 file changed, 76 deletions(-)

-- 
2.34.1

