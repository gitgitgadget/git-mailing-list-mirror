Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836E9C433FE
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 13:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbiAMNsa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 08:48:30 -0500
Received: from mail-co1nam11on2064.outbound.protection.outlook.com ([40.107.220.64]:15584
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235470AbiAMNsX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 08:48:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7kEN9gkIEqDlhEyC/5hxNitkOuXlk+4VfK4tZ95tjtIYZWhIwrU1DjkD43rASGIZfrA/dHLwvYmeeWONVCeaPJ3C3/4tA86SqgGQDealP0xN4V4Ii0qj5Nn+7FlUmT0jW6BcIGtd881ddyEHrnCKiOCzF2ZBQttNtNoXhBD39Lw6QWHMKFe8ciFF77rEOVOOlRM51ZpJS2vLNfjgu+jnVD3SX1HW7p2ccucu4gCAokLEkk8WEFvhg9Z6Z08MxnpMdIS/IRqj9P+p6QqFSSsCmiN3W+nFLZgZkE0iNgcOURH49FJlAtQsVLc5nIDYI73lcrYlzApDjoq4Hb+yWlTtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/SJgoPITfv2nEPEbTfEcFhPlr9JRsnTHnOMjuR4pzU=;
 b=DNNO5aIA8/0B7L1COPXJBKPeyel5aMK2q5SGoP5Ou3i/MYQ3ZLRJotSDRzZ0tg+AxEUH37xN8dnm3OHwxUY5bu+a/vWikR+98cjB4bxYGQOvpJTcTE6Ws1ATXPzWYfeK70vw3Rf8IMtcjnmcEh1Kmt97MwsjNmq/o5aPEy+pZ8+Lwuxim7LjxcLUfgaeeC6AmRIpwRVdEU2DPsmsdxJcOsmTE5xmuFA9FHzFAntPFJ+GfmnjagYcypTd0Vk4WKTjxdVOuIESDemwKeTQpnaCSg9rLePwd7xTfWLXEAL5ahe9LHcVpFlIvrEMzYnDd0hi3ufNblFyHp5Ab/7jwjCOdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/SJgoPITfv2nEPEbTfEcFhPlr9JRsnTHnOMjuR4pzU=;
 b=PyqeE0Wd5zr9kukq+bI22zx7vXYVDdGzrhCV5F8GUgRP3qyDR1SMqTEmAQABPL+ICi+0bg21fl3UwEGQwn2BsUMnW+myCfsFfba/f14wD9aBE23LCL42b7oZ6xixhjYiOQD98DHI2wesEXC2s0qXm0RyMFnaX2/NORCAcdgNpKqPwQ1Eo2V091Ltg1cx9WO5PBuIwkAVqxFQvRw5R+/vXT2i0xmK/ajqkU2lfFbvbV5FwgQ7Kv6ObmSlVQ3O8WCQsJpPvCJ/1rqGWZn4JFDZmfvShm41+dbnJ2pVfOzTM7HoAZL59QAY5l5dfnONiuTWO/lTr8hARge/mUhGSOLj0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by CH2PR12MB3944.namprd12.prod.outlook.com (2603:10b6:610:21::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 13 Jan
 2022 13:48:22 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 13:48:21 +0000
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
Subject: [PATCH v2 12/21] git-p4: remove extraneous spaces before function arguments
Date:   Thu, 13 Jan 2022 13:47:19 +0000
Message-Id: <20220113134728.23192-13-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220113134728.23192-1-jholdsworth@nvidia.com>
References: <20220113134728.23192-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0101.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::42) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14267af7-82c5-4798-5be6-08d9d69b5cf3
X-MS-TrafficTypeDiagnostic: CH2PR12MB3944:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB39440008694ECCD63978A738C8539@CH2PR12MB3944.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r90m8j+9Zzv7woA2V9tgbM4jwJMNX7et/koFMIIJjJQO4QTfPb9FGflTc4GZ3v/LqNyVq3xrmMY6405UE10g5JmQpBUg9l7qpF+dS4os3ab9Zcv5AtJW5+AXdeoxmZzA4eX3412VaUewIAiwY5xKC1G6fk+iamj9T8q76sbO/nUuMwZYxIgcctNeolPRyLxU1/tt0zxK+KluebcuZI+S7SUKJ8t1FjAc4kAbsw/Tl2TmswSUt++GawBtT0S9ksHCHqYlO5BeEJ3/6Qohi06YGAn7zXdbqTb8tnqDl2xBv0kTfaq5dfcKNeJEAbP9lAKAJjTvC5hCjs77JHXd8743qzGMZKv+BuJpKOHAXTVg9HKTsfHpMZ1G8RWgb0ET8bdYMQkfzBb+aQhWCx4CPtJ9nTihC+fJ6cq2aLirIFRpIewiQSXAVYXrn+NKih5v5qY1RoPntiXnKKpCjnEaKFGcH8RSczQ+bEZYCajliEQL4y4WkIS+hh6z5Z158yybcWLci3vrQLWNxHMfgfw5F1cZvrAerlRnVmyoPar1wztnMZ5DyHin7woH/tcYwK1x8Jzi6e/zxiOx+VPAwFBWUJZf3wqQeDpgOSj7n+8sF5nPjaKqRltYdu0SM7Qrn2yIn/hBihmXjZU7dfmfIsuwQR0ODFC+zX1lU1VKUWHSecm0Dtbw+QwAyWYfHAeV98NHW1qNKLGBKBEj3rAWA3pWIjUgnm48efbnM3zage3j/eLbtayiClPrXLXwpq223Amshwbp8Z8ItPAf1OppUjR2fOysuy9ZC9A4exzAtiETChs3vzU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(66946007)(186003)(66476007)(55236004)(86362001)(316002)(6506007)(26005)(36756003)(7416002)(38350700002)(4326008)(6486002)(8676002)(2906002)(107886003)(8936002)(110136005)(508600001)(2616005)(66556008)(54906003)(38100700002)(1076003)(83380400001)(5660300002)(6512007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wxt4BWj0HAIzIZ/Uixz+ujLmYUmHEvO6UrDlmsmFqZhex0FweppZc9LEIDli?=
 =?us-ascii?Q?Oz5vd7U4cFLCxWjiKcpt8xz8ZFF7n13NntPxgzQjTse5lWK2JitagPVr/2W6?=
 =?us-ascii?Q?ey/T6Yf72I1w6+jIC32+rJFBgEs6OXmxCMch8VnN1/uNCRwNjTgYqaGIFNVZ?=
 =?us-ascii?Q?YVTFWHqmByjErU3Ozzz/T9vvCVoLibe22UuUpgbf7WZyibv0tsqkfqTojKrr?=
 =?us-ascii?Q?LVEX6B/Z3A4L87uCK51nWobFxaPR0ygKDUk1vL34Nij3Fe0jkNEtSU7K/usa?=
 =?us-ascii?Q?YsKzaJaNd1eN4RDFAXRBfBwkWM5VWnArDTBCt9wPCGxbomppP0ZbI9lZXslt?=
 =?us-ascii?Q?wXJ6HN9A9v6ZS7kHKA3GjtceaUQGDTr2yimmq37p8ZP7i/tGtx+rQChMLAVB?=
 =?us-ascii?Q?MzW0DTEJ12+fM8kF8mOxoFhF4IFcitn/uK3kLd2qvL7htNeGPCrFs5r/SCMd?=
 =?us-ascii?Q?ul3tHtMBAYLLoWV+z0g75miTFY1vDuB2DTJOX0uSlAO4czNTgcNDNTyMrjDg?=
 =?us-ascii?Q?mQOvxJMHziTgKy8omJ4qgHOy84nqnxKW5gVM/tDvlNB61/JqZDiGJSrbtqdh?=
 =?us-ascii?Q?48nei8nwN4e3NrV42f8CpR7xvEr/IZ2Hfi4feUWEFHnQf6xA1YaPcy+e9NKr?=
 =?us-ascii?Q?iV+VXsdJr8moQW3ycOP3YiegE8jyIzJWMaTh/D0bPWywYNPv0EUwsOa9WlLf?=
 =?us-ascii?Q?SXG/inhc2hTp8iagqHt4pYruFYaU+t++dOAuRowfNcGf8L1u+MNI5oDWoYG1?=
 =?us-ascii?Q?Qtwaquhpp5UiuNW39B3pAUgkwE0zvaKvGTfGkW75KziP1F6m4y2YO70c4B1V?=
 =?us-ascii?Q?U00ImPv1LilIe6kXALeX9BHEwBzIec9cN4sQbfneIkW2r8RirAFHoT+29FH6?=
 =?us-ascii?Q?sleo2z5GfufVd92eTpouS4Tug+dNnKUiADioR4A62gt4iNi0e2FPY0j3kQ1Q?=
 =?us-ascii?Q?ADJDW/WaL6ZRQEjBLhDfZI4crj4Try3r+Uf0zGE4nxo+7LYWAko5303cZQCS?=
 =?us-ascii?Q?yDwXfp1o6yqhlZrXf5v3As4zo/bAlsU/soAZ0OKSlbQtFDJWKfU6wfXw+Ne0?=
 =?us-ascii?Q?wqLqMpgYxVi263FHy52XFzKPcfNROI6ih+jMCKQGBh36QV2FAAdLhqf9oKhM?=
 =?us-ascii?Q?oT9tsnEva7aGX4avaoIV+9I71zjY2QDFkyNDkakB3BjuNVxcWZAA8NJBanb/?=
 =?us-ascii?Q?8Rum7ZNThCMaid9qx4TJ6OqUoWILSTNeIDcLF4jwwaglnRgRuyRIO2UFigof?=
 =?us-ascii?Q?mO5Db2JuqFUZzELOUcVHk2mg4608PTAPJ9eqoAyqy6EShYrmxEXP6SEtK6iU?=
 =?us-ascii?Q?i2RwWu7SDoLsbsCcrTQtJrlJU0iSVQIetJqrP9Y3EAcC6WrhO4vGhqXKs0xN?=
 =?us-ascii?Q?JuQZtaF6RqopZfGpUoNislPppKajuz6FvkMJucWJci0wnMA3uEMkktrDnS/9?=
 =?us-ascii?Q?+tizSL/IhyChxJX5dgpV63bhCvv2dajuDVxH51iCp0n/oasFHKFUYhIjK9EK?=
 =?us-ascii?Q?G7ThAINFAOxEr5IJcjfmmvgr4bysE/9JVO7fUdlFVkf2liq8sJtfwsqOsiPE?=
 =?us-ascii?Q?l3BXmbrWmMJfb15okmkPra8qnYEfPgfv+LcPM2DJsy0wsvQIcdMs+x/CYPFo?=
 =?us-ascii?Q?BaruSGEDasmYgNOmnQsa/cc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14267af7-82c5-4798-5be6-08d9d69b5cf3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 13:48:21.8456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJUsUVyGvKKezQ7iZXkbaRBs7l+/2C7PKamclcV3s6QvCnrpEDGhlvl5PmumoQsOoIK7UYWoNjD3zhf8QQcmog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3944
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 recommends that there should be no spaces before function arguments
in the in the "Pet Peeves" section:

https://www.python.org/dev/peps/pep-0008/#pet-peeves

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
The previous version of this patch removed brackets around the
assignment of multiple return values. In this patch set, this change has
been split out into a preceding patch, which brackets in all similar
cases throughout the script.

 git-p4.py | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 996f344dca..41735181ce 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -984,16 +984,16 @@ def extractSettingsGitLog(log):
     values = {}
     for line in log.split("\n"):
         line = line.strip()
-        m = re.search (r"^ *\[git-p4: (.*)\]$", line)
+        m = re.search(r"^ *\[git-p4: (.*)\]$", line)
         if not m:
             continue
 
-        assignments = m.group(1).split (':')
+        assignments = m.group(1).split(':')
         for a in assignments:
-            vals = a.split ('=')
+            vals = a.split('=')
             key = vals[0].strip()
-            val = ('='.join (vals[1:])).strip()
-            if val.endswith ('\"') and val.startswith('"'):
+            val = ('='.join(vals[1:])).strip()
+            if val.endswith('\"') and val.startswith('"'):
                 val = val[1:-1]
 
             values[key] = val
@@ -2347,9 +2347,9 @@ def applyCommit(self, id):
             # Revert changes if we skip this patch
             if not submitted or self.shelve:
                 if self.shelve:
-                    print ("Reverting shelved files.")
+                    print("Reverting shelved files.")
                 else:
-                    print ("Submission cancelled, undoing p4 changes.")
+                    print("Submission cancelled, undoing p4 changes.")
                 sys.stdout.flush()
                 for f in editedFiles | filesToDelete:
                     p4_revert(f)
@@ -4021,7 +4021,7 @@ def run(self, args):
                                     i = i - 1
                                     break
 
-                            paths.append ("/".join(cur_list[:i + 1]))
+                            paths.append("/".join(cur_list[:i + 1]))
 
                         self.previousDepotPaths = paths
 
@@ -4050,8 +4050,8 @@ def run(self, args):
         else:
             if self.depotPaths and self.depotPaths != args:
                 print("previous import used depot path %s and now %s was specified. "
-                       "This doesn't work!" % (' '.join (self.depotPaths),
-                                               ' '.join (args)))
+                       "This doesn't work!" % (' '.join(self.depotPaths),
+                                               ' '.join(args)))
                 sys.exit(1)
 
             self.depotPaths = sorted(args)
@@ -4091,7 +4091,7 @@ def run(self, args):
                 if len(self.changesFile) == 0:
                     revision = "#head"
 
-            p = re.sub ("\.\.\.$", "", p)
+            p = re.sub("\.\.\.$", "", p)
             if not p.endswith("/"):
                 p += "/"
 
-- 
2.34.1

