Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBB8C433F5
	for <git@archiver.kernel.org>; Sun, 16 Jan 2022 16:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiAPQIB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jan 2022 11:08:01 -0500
Received: from mail-mw2nam12on2064.outbound.protection.outlook.com ([40.107.244.64]:61889
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235576AbiAPQHt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jan 2022 11:07:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+FEUMBGxeMAivYZaSsjfd3qaqEvqNrzfpXH2Bb/y7BSBtiBTQcnaKD5EeV1ydTqPH9DMA3SWFEqo+UTf7sALq9Uxg/MD//j17kvwnrKSaiWocfYMv4cxT450hEdA/uBVM1q/G0kKFJfj3kuVMf6eh7ijN6BLHaVDav7oeO1QePCJIfM82qhkZSi8DHB0YT7ZtA1uc/Td8NynHqEVmfn/9f9JJftVJKAbuKRzXGryro+yL6IqPM3sOV9Rj9OHeoqRa/LNAJykCc/buSBOG+U4ON02a7D8Rv56lJDJEYt5dnPByZ3F/kifknescH/LtseVrq2NSyuVJpunZSgZQit9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkqiTFUT/KqolQTTlDf9t2oyeHl3TsjjjIfiMkdRWqY=;
 b=ixjzNnqzdrukLXue4+M0QIAwYYtRiNN+rT9x9V6HCq6dsCU+n4ycroXCk0X1ojGXCj42ZM8mjiEPnbpEErx6nTiIPc6o4cHGbtZrVVNf0GlbzG+/UhjHvGMCgALTdEhqCvt5u01Of+soLFGpeWo3wl2n+aNOMpHdL3+95VCunmxu4LbUJUWAwVdHnC82chObML/Ge+wBO69NPf7FOvhr4T/SBJFGT+t8EZo28cOaiYsmGVP2GqnEaqrK042S32xdf/j+G/YigG6cx9ODBBEAEpsJcmOpjYL7ub9VHyTdypD89ir+p4WXsxnPN2MieLpxovmDd0EGCJKi6UrQE0UgiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkqiTFUT/KqolQTTlDf9t2oyeHl3TsjjjIfiMkdRWqY=;
 b=GoQThtnE+YO+cX2mDwcHKXh4hPcWPRc43AVaWxmyglbkcJQlanthAZL0oF9h1P2+knPMJMwDBFf/sKzq75fQXTAJmrtxTO6S8pl0yGg+mDe8x3nD0u9zigX0QLgGo6jDawfxpvpV6s9VW+8NdDhk+8mSUv4g1aEo2O0sFJl8sGYgQ53v+ESS+MqxY0fJNSKFxT859n2l4+DVunBTccQPsgTVS7ffJeKgiQVxUYf2GpdoNhUV8OxA8sVpyEXPy8zrrJ+ubrZ+7m7b3FM0075OK8qozZ43RbJ/4JmF9Balc1VvsfXYcrvjG630hWnEAsQzqdXFwxYuyYMGKbAal4hveA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BYAPR12MB2597.namprd12.prod.outlook.com (2603:10b6:a03:6e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Sun, 16 Jan
 2022 16:07:37 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 16:07:36 +0000
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
Subject: [PATCH v3 12/21] git-p4: remove extraneous spaces before function arguments
Date:   Sun, 16 Jan 2022 16:05:41 +0000
Message-Id: <20220116160550.514637-13-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220116160550.514637-1-jholdsworth@nvidia.com>
References: <20220116160550.514637-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR08CA0019.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::31) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43f8b80b-066c-43ac-dd17-08d9d90a5029
X-MS-TrafficTypeDiagnostic: BYAPR12MB2597:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB25976609B2FCBD7CBABB0D57C8569@BYAPR12MB2597.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7zkWI7gqmQe5Zomtv6z9+0mAn9wpige4EUy7HeuDa7+2DeW+9dOwwtdSWH8UBc6UixvVmngLk0AQJhJQhFD9T3VJw+IWtIGAnXI86Y9i+omoysp2Sqd81HnXYqsHzOP/T14IqAuvrz2JecArr0YFPzPbtiZ43SzBs3vQeZ2wr+Z7033viAkYwrXuIbNbjmyMfSvhnxyn1UqVx5MV4t/dSmZZkxanHpKKFsWKMl2E0hCNOApUE+UZBGvDQJnN8J6XIUVu3fPPqaOVJCX+agnyaLFPJXmaj11aDw+i151VeQPXknGGTA2h6zkbt1pWWFXXMUiS/W2PXDPY0Qji5h2Ylt2l7X0ywZS86xwNxY2PCRmMAjrdVEQNZEd02M+Owa9dVV1cctkA3aQXZmWBW5U1eAhEec+EZ0wcjiW/WFynSy13uJezsoxAwoQz/zj6GMq+20ORQwKYfyUFNU19wcUdQRlMH9Y3HbtEYFhyIaf8YxBPBQYEs41JQH7/RLgOTexrqcyMgsFv4y96BRdtCplfbI+7CcSJSfTKwvr7xU7Cz6k/3AVydvTTCKCvMhqDJnKV9donsoPw/r89jR8985PXYj7W2QkkU/XYhdbzAROVxE1B+iE0fkJQUXXFQ+n0ZC0SjSRhvGstPXwoQISot5RLE3fN+8JgmmfaTTAtFwBD8oWOUIPEjVd/1GHp4/YidQjcy+4U3B4asJlCGZjWzK9GweNlRZGK+vkQ4FVCSTMK6GzBgpI25Cbdj15CuMQjNvqbIBvUS1SI8cx8oBkLYl0M67inoPFKPGHvR8ACdwgyNfs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(966005)(38350700002)(38100700002)(8936002)(4326008)(83380400001)(186003)(1076003)(6512007)(110136005)(54906003)(107886003)(8676002)(5660300002)(316002)(66556008)(66476007)(55236004)(6506007)(52116002)(86362001)(36756003)(508600001)(66946007)(2906002)(26005)(7416002)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vK9KqzQHpQU6vrOB52sTTz+baOuUyILaW3t50W4jvRvstPZpCLSVpcwHb5X1?=
 =?us-ascii?Q?WkI/3DfdZ0rFkSHyxaBbXJjP6yOgi9cQ+GfgQKvJNy+mnbXEYG2RWTCk4sli?=
 =?us-ascii?Q?SbidjKEaid0Z7KOALMc9ShdqiSVnqeI85MJOKjQQPLLC203/qxHe7vQV02Dg?=
 =?us-ascii?Q?rUNbsgmqv6sofN1zDGaOiw3ZWr5/jmKDlAIa2wN4rKm45Up2SI6W9BRR+SuR?=
 =?us-ascii?Q?YuRBlIEf/IAAXNaQMEJiuzOXH3v9b5mEg0LP8vDMiiQD2VYwNnqdTUWcSmgg?=
 =?us-ascii?Q?Yzi+TYzHZEUvD3NZiJUuD/IQ1dXZ171Cu2TLAZjTFXrif/oDaH8JBcWaZPNN?=
 =?us-ascii?Q?v94aY5vUGfpI2hfpoxSRFc2Vt5yQuzCqkmJnVwyf5GbsZ18OIzVrz10vu8kf?=
 =?us-ascii?Q?O/YTy2sSVfm7tLogbpe8j/S+Mo0xrl/wupcEQTO11M5CsSJzzLMQzrRFbAO2?=
 =?us-ascii?Q?1Kx2ny/N83Psee0w/ohcJr3F9vxafxsdO5npqD9ibDnS0L53tE0ocVM51nGN?=
 =?us-ascii?Q?8YDb1PwIKP1wq0OtnlObpz1hIjMRAWFX3B6E0q3Tz9mV1qjdkJ4MeRXhblk+?=
 =?us-ascii?Q?p52H+q0UvugAvlhUlSlBYUW+g8sKcU5E2BE36UiW9PvsTB8FJ86TrqGN83Vl?=
 =?us-ascii?Q?vUAE5EPPDhquTG02s559vkhU00r3hNbpgrFDaSQKjHPWk1Z9IdqORmg75pKu?=
 =?us-ascii?Q?buGzkOmvuNdLLetFqC/Q6UP6wDOe3UPD/mOSds4NnGp/zBRdBDPNXJ3UoVU6?=
 =?us-ascii?Q?QpDFMJazmSrH0L9spnWNaR5doyTBb6SETAQD5dLREYfIABhBLU7mrGpqjhLe?=
 =?us-ascii?Q?p8jrb4PQpy+T8qJV79WOzBZxzpbiqazWdshdCITFMTUiBVKf8slLwB3nIgBE?=
 =?us-ascii?Q?/3tV5l3kVkzhyqlaPpqt2j2wkRrSWDj4y4BSk6SwKLdJeJm4VTWVJzKdxHJo?=
 =?us-ascii?Q?Wfx7UeE0BDjDlt5aM+Nt+18sGOZvEdGjo0bbXOA0gPZ/d1Nl/Uo/FzaZ45or?=
 =?us-ascii?Q?zh+Z3UX8GKSm2X5BNtt/6f2qdqtQOyZchwEvVkcjaePNa3zvWPT/OkGaf1qg?=
 =?us-ascii?Q?CTev2jg9JiVYf2SV2v5UHd4/9mWswvz9suDIlN+ed8KgveBNt/lw72GMzCav?=
 =?us-ascii?Q?W4Y8iMh8okvinlzTWWhi7aHQoBQ9WTspJBmoWtZftGvaftt28nzz3uh7ipkl?=
 =?us-ascii?Q?MfCjpP4ZlRQfirMOrNFh7sZnXSw0rm04fqvZZnqRwNlJXuEbjt3AaJ5JLq93?=
 =?us-ascii?Q?zcOFIx90zsc991SohElbdZS38WTaIAPEr/FkSfAKSivLlXZjY3QiyAvEVyXS?=
 =?us-ascii?Q?2qnmYP8tGlqJhHUZfM6ln71nSrqwECx0t6zD5kna3HtSWfM26GcBNGAhP5/A?=
 =?us-ascii?Q?k1WOfsVV02qkqlX3XzY+txJqJD7asPxiqyiCx9zeg/1nd7rf0xWMceq6uwlj?=
 =?us-ascii?Q?wOP4U3f/OJUCIbUw++HiR7O7anpe3DvUDt/nAiPONQ7U76bB5zsLg6qUy4we?=
 =?us-ascii?Q?vegmaj+UgIDai68BkGqyYu5WmhkV2SR8TItJDytJ0oKiGaZMTBrTN5RpVQqp?=
 =?us-ascii?Q?KCH0kaiZ8iyGInDjkeN9NOFejUcVMwMHqN2u1ayWMTNmGTDNUXqUfalZ7lsj?=
 =?us-ascii?Q?IijABwHJdD93r039kWjQMcQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f8b80b-066c-43ac-dd17-08d9d90a5029
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 16:07:36.9331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L1vNqZp9zQUOh5v0O92ijZVnOr7/GV3k04mpeIPU+Ub+CPMz0E9M3TQnfgwhJ1K4ecFYDvcEiAL8/gZNs0Fdvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2597
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 recommends that there should be no spaces before function arguments
in the in the "Pet Peeves" section:

https://www.python.org/dev/peps/pep-0008/#pet-peeves

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 6a676cb415..c28edd9e85 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -969,16 +969,16 @@ def extractSettingsGitLog(log):
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
@@ -2333,9 +2333,9 @@ def applyCommit(self, id):
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
@@ -4006,7 +4006,7 @@ def run(self, args):
                                     i = i - 1
                                     break
 
-                            paths.append ("/".join(cur_list[:i + 1]))
+                            paths.append("/".join(cur_list[:i + 1]))
 
                         self.previousDepotPaths = paths
 
@@ -4035,8 +4035,8 @@ def run(self, args):
         else:
             if self.depotPaths and self.depotPaths != args:
                 print("previous import used depot path %s and now %s was specified. "
-                       "This doesn't work!" % (' '.join (self.depotPaths),
-                                               ' '.join (args)))
+                       "This doesn't work!" % (' '.join(self.depotPaths),
+                                               ' '.join(args)))
                 sys.exit(1)
 
             self.depotPaths = sorted(args)
@@ -4076,7 +4076,7 @@ def run(self, args):
                 if len(self.changesFile) == 0:
                     revision = "#head"
 
-            p = re.sub ("\.\.\.$", "", p)
+            p = re.sub("\.\.\.$", "", p)
             if not p.endswith("/"):
                 p += "/"
 
-- 
2.34.1

