Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE25CC433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 16:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244781AbiBJQs1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:48:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244842AbiBJQsG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 11:48:06 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6929F9F
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:47:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2323cEmAAYeUKNYg3s8PxseAr1CoZdGCDul2MnNUxu6hpeJ8VFZKwt2aEIjfGHHdhYAXBkrYiXNEd5X/BawSFeLETC6wrkE+RytT1HBy2+i7DIDg36Nj2WzbsRg+TFa9svhW8LdNn4vH5K2t6Qf/BM6yRoLlfdhTovROTLoAuz2z2GX0/9ook+RWDkFc9xaAmwbZkpUsEYKbE/rDP9S/VZQRUaDPzCPF4bRwc+eHZphsPd8e+b6h1PFBRk8pd8h1tBUJ26vhZK5+WHVjK05+BDmosyS9R6/5Y7vmZcAmCIw1MrJ7aRefNYDMoEtTxBQJbzHOpH3K/sS/0hyDfOl/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L89DHETEHa56fZqTNaJVqXgv3Uvx/r5UUOjO+6ZFg6E=;
 b=lJWQXa6yp8vDHu+g9VxL19oNv+BJOatId6eX8EbQ82dmMTVwyXkzPYLFcGadtg2mae17H1LwZpSdZFQTRo7yBaGQIJqs/JZ3FUNW8X6lx4JAHH+TpDeAjyWylUvarBMQH2MicruYDYhkFoPJP0gPCR3lW6u0MxtJ6TeX1JLEBMFUV0qwLpU/xO+6QfKVzgOso21XQNlTJjgs4/Y2RhsJ7PU0MavEaTB4tEl93D8Z8DPWOI6ronzl+gIqADC7VdxjaOyfVvCJ2qtLR9GL7oDhXRw79avmwFMfqcUKDbD6aE8B6xNi/Fprs6YR01p2QI+QcBYgk6jNH4hbtH4Pms5D5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L89DHETEHa56fZqTNaJVqXgv3Uvx/r5UUOjO+6ZFg6E=;
 b=MuWRi1pD1y9GAwD6k7TgT9LHnCVskPPCLUC5BKh5tSpeec7UVQ+IzVuVL5yQ0bRz0ewm5O2X7lOnRKc8XwcmQXtAApwgBG5hBmnvXGUojZhk2qe5mHpylfJcNIFzqsKa/ZeZlnPbpD6JRoGVu+K2kAwZV1q2bBZQzuv6Xq84GbZfHPvzZsaz51DH+380IRYaPYnXDWSZlC2/DG3TSDhBkyLZdS6jBHzqKvUpzwzaDvpLGwAjncEm7vPbHOFf2DmzLP1nDJoYzjMkZ/2/CmuZ5QRT0VECO1llIzUUi28u1HiNLwWv2ATPNU0Zp7zmc23WNl5e7za9l+nktM1ZdonY2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by DM5PR12MB2421.namprd12.prod.outlook.com (2603:10b6:4:b4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 16:47:37 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10%2]) with mapi id 15.20.4951.021; Thu, 10 Feb 2022
 16:47:37 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH v4 22/22] git-p4: sort imports
Date:   Thu, 10 Feb 2022 16:46:27 +0000
Message-Id: <20220210164627.279520-23-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.35.GIT
In-Reply-To: <20220210164627.279520-1-jholdsworth@nvidia.com>
References: <20220210164627.279520-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0069.eurprd04.prod.outlook.com
 (2603:10a6:208:1::46) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17e6b23f-847d-4834-d1fe-08d9ecb50b4f
X-MS-TrafficTypeDiagnostic: DM5PR12MB2421:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2421CABFC31080BB98955777C82F9@DM5PR12MB2421.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OuloFAm0MYG3WbrKmKiDTer6p4rDhe4LyOs3XoliWZiyAy+MbulvsRKvhW67DvLTSQSaK7qtSjmLcvqHz3NZIq7qUJRpr6xilEZEYyJbtay6Ve3F3GpK/TMOQWI+itN2STxSH9uXrQFnA7sOGHoG9Sl4EGA4QrnE8cxCMBWF/iBfNGR+Zs1NpKrmNfHYSsH5TkrR9Mqgn8mRZ2EaqR07Cusb5+MOsNlrl94NiVP2Xu6cfr6fyPx3ujUZfT/dg6HZyI3qd84+EwBV+sx6UNAvi8TEykuJyzWwNf971dV+OKyMQQOnF7lUIWSVM/aOQz8mVLlKR0a5Xg3mdw/ZNZlU6lNfyj9tgpz90JV+1jLZcaEBIHAxdAB3AgfUJFAf37wVOaLRY3LOS8CtIQUcIgCIJGtvKlkkv+z+1JdrefNljVZUphemZh4ei2Mgh89rQxUmFu3XWGECF5tI/nMXFvnTXL+ywgQ/etWl/Z2vsT1Ev0Wdo49UzDNT7xkHWt73eu3hXov6PCvF/0tt9nP3Tb1hG2rbPot0wbjvzwV0nrTTU4KzObiteckQ9z1Ri6T16pJ8wxWmCK5jFKthQLKxdwUHCgEnmeWq19l+KeVgNGwBy7vKmXkfoNpFSpwCkfDcllEV+0jbwjhjgW2WfuJUQhfpIpn2lvinkN4ZB5z6zt5eARNAqCVeul8zKXiigLT0MqMnp0sOEMHs4xT/TTtoYu8SkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38350700002)(2906002)(52116002)(86362001)(6666004)(508600001)(6486002)(6512007)(55236004)(6506007)(4744005)(186003)(8936002)(8676002)(66556008)(66946007)(7416002)(5660300002)(110136005)(1076003)(316002)(4326008)(36756003)(54906003)(83380400001)(66476007)(2616005)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9ilGKSxAF7VLjhM3uI17Xg7AvM/OfLg3EEBqkSYIaNibhwATMV6iQtS41VFc?=
 =?us-ascii?Q?/TNRf9J41y0rqPNUuizZ7rwQ/AuVLEUj5R7i8OEzGtBatwKGh+J8itozZRKW?=
 =?us-ascii?Q?Noasb4xqGsR+RHoYJJ6HDb2FvkeV7Qio13XNcuTNV1MQWPIbtJ+JNF/FZ/Ro?=
 =?us-ascii?Q?JgQL/gu8IuJAODIs8aJicNk2Z9koCzGvEMtWwNsEWXX/z4FsRfBbH20KGu5t?=
 =?us-ascii?Q?rYELh4AEOINKA75/jzZP+6ihi2ncxTIywqNuj7BXsp6UyUjivmyIdL26h6DK?=
 =?us-ascii?Q?SIfqbh/Yn4hcgf/sqmqhi4lQaCEtZiHn8uaCsl8hIvqIBq+OTofnlpZ5GWgk?=
 =?us-ascii?Q?Jpcum4THQ24Tzn5OsL8LzKyeSA7nsKnT4TBGFpeT9vtP7Nd0BHn/q1yz38v8?=
 =?us-ascii?Q?F7rsboqA7vQG7YBTgXxM285gtXwq2T8BBAgXhV193xG4bLUATJuev15+MXw5?=
 =?us-ascii?Q?SBDbSma83DtNme31JFM5L+CTomcOWKOkItcD1QBEGCmf0TsOgXNlL/l39e39?=
 =?us-ascii?Q?TdzwYr7zkou/AuVJbew90CpO0wKMD1MA4vPEgboEJNYDF2FCfbI9w9TUvSzD?=
 =?us-ascii?Q?shKAFFYBH0FHT3bv7KJRYARzHrXlP8CFpkx3u2U90ERBy81mY899OrYH0sZa?=
 =?us-ascii?Q?JbwEATiu3uKid87v31qtoDVACJO5QbVPDvXMCOm/CO0fHRdKKzl1sPpyUIVy?=
 =?us-ascii?Q?8aYfkFXjsC3tN6zRJyxk8qTCYOtj277FxKfAD3sJHerFG6a7zqUIZOyv34SN?=
 =?us-ascii?Q?R0rBCcFDhLySBRN03FUkAwvK0v7JaPK4dDhNOVHdioxtnsrcA6Ez6n0w7dPm?=
 =?us-ascii?Q?2uqtTwHUNLXpML/lc9uAvU5JMT/x2qv4VvkF4Jfehp8OapAwzYpciUjOWosd?=
 =?us-ascii?Q?ElcIHQh9+U0la/9dX9dAhCzGOmsSm4pDDSxd0tRNDySs7yEjeNuuXnVLLN9m?=
 =?us-ascii?Q?qNpxG0SV8dejDKJO0uXmwfAgEkRIlhkdbxci7Qwo3wsVSFZhH/mpWv4dGewg?=
 =?us-ascii?Q?ouVBTBzmESZGJgxmffIFJFIpEJH+sqjAxP8I13LPwK6hA0RAFoAU5A2GLdWb?=
 =?us-ascii?Q?0KXJbd12Gb1Hd5Awq7H9fm+YSSoH/B48nMjFFYviJmWrK7lUaOy0uGR3KnMM?=
 =?us-ascii?Q?95KA/aWuGnDLPpbTz5aBdqi8pcwggYqzRu9s6+D2z1EVWhIIutYwzLONMrXF?=
 =?us-ascii?Q?1jwji0A5BAeHRjS4+KsG8dD2bSQnCzdYr6hCADD/lPd6UtJoiB3rULPRKuyV?=
 =?us-ascii?Q?gQbwjEN1ltOTHSuVU2WoQevTeuKms+sSGqYC7Kx4Tc3twV/CYuRf9rWmSE+8?=
 =?us-ascii?Q?PzhzGiPgwxKMQJ7NmKUXiQu425d86RbbYscaW/1OOQi4NbW6X7oORAsD2dek?=
 =?us-ascii?Q?hS5Szfk/SyIDZMPMbFBwWyeDgYZITo1V5lAHGhzz//3xuLY8wTdXvHkfYYg/?=
 =?us-ascii?Q?HXO4lmbeFNy8KKtZyEA5O3XB2pP6TqOmXi5oizxkLAMlbey7KcgWXmpyrgMC?=
 =?us-ascii?Q?suLnfIjBsk9HiqBow5JfUNCQyWjvy3GNulMdE9il0hkc7TC9/yF4TIh8HFOU?=
 =?us-ascii?Q?ZXhnpMExzpZdkEMNUKPjbjk88Zsn56vOg02HQwhf1GYh/qhHaChZWrtERPrq?=
 =?us-ascii?Q?Vr3JXfw8yX/8q6jP9cTRvxY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e6b23f-847d-4834-d1fe-08d9ecb50b4f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 16:47:37.5620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xA01ggCxA0LjgaPLacY+oiUeRkNk13rJLgM/+b8bCfELOUNfQ4LVkVXBlv5LE8Omhc9bSHMvFx6MsztK4/r74w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2421
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 git-p4.py | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index c3239cdabc..ea1d09f69f 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -30,26 +30,28 @@
 # pylint: disable=wrong-import-order
 # pylint: disable=wrong-import-position
 #
+
 import sys
 if sys.version_info.major < 3 and sys.version_info.minor < 7:
     sys.stderr.write("git-p4: requires Python 2.7 or later.\n")
     sys.exit(1)
-import os
-import optparse
+
+import ctypes
+import errno
 import functools
+import glob
 import marshal
-import subprocess
-import tempfile
-import time
+import optparse
+import os
 import platform
 import re
 import shutil
 import stat
+import subprocess
+import tempfile
+import time
 import zipfile
 import zlib
-import ctypes
-import errno
-import glob
 
 # On python2.7 where raw_input() and input() are both availble,
 # we want raw_input's semantics, but aliased to input for python3
-- 
2.35.GIT

