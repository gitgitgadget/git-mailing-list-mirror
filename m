Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7DFC433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 16:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244732AbiBJQrZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:47:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244731AbiBJQrX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 11:47:23 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCD51BD
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:47:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bESzPIxXTd7BNch7T8gcbynM4QIwFye4Sdn/SeREdVW3ql1dGSgTdbtUf3Vjq1WQkXVdjUh6oH6Wv2p3F0yO/qS+o2qqrOV3KQiW5dxOAljooveTyXn1agyswKD9KUtX/OXK3lIEWlIL9rz3uZZhn+Uwwb1abCAMt5T402nnlxLNeJxBykVKwtdmejtqRqdBCUt8uW59wt63XLWUil/ptK6OH4VSRixlogJBuGOA0r15ittzVSoVXnOSX2Rvp7//84O0tDJNKQEadPJHH/lCyLBUr5wIXXFBSP4o+LS3Ao3PWuGvkfhc2Zw5+99QkU8rplgvMVTDMDgIhleSqjxfnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDBt6GyCVkiOpGI/dzR/2/s+eaY6rKqPAwhqk0TOjIU=;
 b=CzRyK97zXxt57z1HAHuMKdtAtBwL1dt+iPMqok0pNSMV4XZO8K2RDYoyVCzHCEOB2F4N6OVUnPTP7s8JUxMuB9cnqyhzkMGLXyJtLePfqyzUUI/TkO5KyUSrzQ8jla0PD8XRyfZZ0b77Ohf6Hn1qAKxyOQYYhSnUhluQrps2c5W6pnRvmnoTjuEd+xNs9wxWSNYXR4ESIJuu2ugqDwTGxYwu/y/XmnRGyGq1JbL8CPcJTiy0Xzy2CF7wB/Iik6ag36xqKk3xHnGZO7oAO6o1TCNvhRhqJtl7o5AZV0cMzB4EHd+lZyw7w3jEkKVzQHmSwFQ49GvDMpXvvpbEKcb4PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDBt6GyCVkiOpGI/dzR/2/s+eaY6rKqPAwhqk0TOjIU=;
 b=X849TCJU3bpjPDZMad4rbL/S0WzZI966dZRyoFQjBHyGK48olPhkoRkdbyHCBWobpk1zeQED8UO3Sy21qF5wRplBMhH2XUZBcOun4mGIVKMv+KFeFAqhU72vMkDawfEoxz2ckaulz7DpCulygmLtLFXnkpjV8565XQCsNrS6GkJpFfVuD6Cw7BUGwvFFN0uz0qqQxSUyCoY21Y+XLv6kHMVta7ZWxjki6HzSx5y1XpUFP1Gfxy7Dw2wDybNOM2jr8ROTDlTCdOvCCDmfd2gqyxM6PN/RB9bV3a1TBCgwTDy7qdZjQOtMKWlwxjTit8j4UCkDKudtyXCwS7ebkyX6iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by DM5PR12MB2421.namprd12.prod.outlook.com (2603:10b6:4:b4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 16:47:18 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10%2]) with mapi id 15.20.4951.021; Thu, 10 Feb 2022
 16:47:18 +0000
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
Subject: [PATCH v4 12/22] git-p4: remove extraneous spaces before function arguments
Date:   Thu, 10 Feb 2022 16:46:17 +0000
Message-Id: <20220210164627.279520-13-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: fdeba225-d550-482c-1522-08d9ecb4ffb2
X-MS-TrafficTypeDiagnostic: DM5PR12MB2421:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB242176FBEB72D36B95C534C0C82F9@DM5PR12MB2421.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wI5IzBUfVtJdXOk3eJrEm3r9ba5AFWfYTFiD0X/tGwvCrYAO0BMsJHjd1BGcQBYUnqCQyM0anU3eIJzI3yaFtzv8dky/W+GFv8ErRsd1ZKOpM7Es1OjMRltBL89rHUcjg/WAY8Q9UD/8cmF3M62ncWfHUA54CbnZzvaElybl5crKlSPvrYHuzKaTjftgBy4sGYHaLQCu1IErNicrIZlBtwvkiClzQsgxEGdnpCiLo7whwZTFDYb232KMYQ78iwbv84gVU9rzt4RB+tlcBkjl+ysdxZy7uY7GBciEoS6Mj4TPyrDEZ5ewcVtUhf/eJXgQ5Oj+MYPyro8O1xHk0CXu9anO0wBjequoKpgHb1vfqnpP+WkpXbS70FjQCsWBLBa2zCwee1YCjUNn4TK9BIwn2yYdD3s9iLYGseDEMCuVj5xhVHkFT8P3x495q/VpSsHCWSIu0dQ4zeB1MRIhw25sq8JUDTmGdoP+kv2EkCAAgfptU1vw5FP+Vnwi+e0WLO2+TAWYOEl6IcfGY0hCFbHz0wLAvTASXvOxaHoVW8A7Vn2MGqKx53YbknGSkmP/IG4VQPmaWDst2y8xkXCP4btSV3UN8Bc3gizI7HpTUeu7/XzUEXmkcHzhHdDQM50fwPa4AG6OnkQKWIFF7LDgzvd2+7LcGoBUh0A3ADMLnc3o838uwBFA3GS1ElYwJNLr+kfBC0HUbfEBF8NpovR5AsZAseraSUiLpwPT4auWnLAJtJw0erB6wGn7dJZo0MbdfdlilL2EeA6XfyDliICj1dGYGg3N/YqYKNwnVpGT6vw0ANk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38350700002)(2906002)(52116002)(86362001)(508600001)(6486002)(6512007)(55236004)(6506007)(186003)(8936002)(8676002)(66556008)(66946007)(7416002)(5660300002)(110136005)(1076003)(316002)(4326008)(36756003)(966005)(54906003)(83380400001)(66476007)(2616005)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QVYiavoS6Sau2TWWuFfVk+aD3VKGt9/FTNyWjsb7TxCWFz0+3FVrsYrRP6m4?=
 =?us-ascii?Q?we25g72vGjUjKdj17GGK5TH0YvhyskoAFxCLgf+35KWLq9xWLohQZuwV+FEE?=
 =?us-ascii?Q?s06EkXxMN0YGVBcyfLGgsAvKVNRuKcdEhU2a/27nDUpKEsaEVS/0Rif5UUA8?=
 =?us-ascii?Q?B/npsfE1JFJJ1MZTCw9V/D7IntY7WC838jKdEl1Eh9fBabObxEt68QQ39D55?=
 =?us-ascii?Q?eks6DdGiFiA+bh5EZppeN44b0Yz+p5FgL+v0JafmhkAdvcsHs/n8Y2FBblEu?=
 =?us-ascii?Q?OmQq0axr6BA0fFP44g8a6YrGgCotQ2F3x6V0ADGX9kQ0N441iqMBfOaOo/2T?=
 =?us-ascii?Q?K7Gpt9rSpt99E9PThiI5RtTlnEbYkFDAEKL4bw/EduORggrWWRzTw161F5+d?=
 =?us-ascii?Q?RzdM28YehceFJJCj2JqTZFpCL+OAOyF3K9QkdLPpKLo/B5t7vErJOn3VmvuJ?=
 =?us-ascii?Q?LHSrjtI+PWqDxFNXIq3UogO9BMwgFBIe/303Syl/FRM7ibkBQ91SRk2XiFYM?=
 =?us-ascii?Q?18EPpb/hRFjCbxMpccmFwQik0t7G005Dr++xdObLuGaAGFr1NNC/KLZu9DLt?=
 =?us-ascii?Q?DpTOVq12Ea/Z2qyEQxnJ8ia3fKnHQqim/SdNAoaFvi+F8a3gUUDxEj7ut57i?=
 =?us-ascii?Q?FTchUOinOg8D/1vWlfgHhww0vJbvA6l3C9alGkglUbLfJUxgCHUwNR4iB8AX?=
 =?us-ascii?Q?BfXgGL7xwJ0h0ZocTjmOJFFQXDRGCVBgVBT3DuCL157dB1naxEb0hJqXKVru?=
 =?us-ascii?Q?dlnWx61CYbwzj02iFR8gEvNVwV4tYVye01hajAYkJQ47tRh9rk75Kzp/NS/+?=
 =?us-ascii?Q?4rDOqMlaeGc5i5sF+MdZkhj3mmCQAK9PyJoMFqhHZHSVxuegiDSi7eOGsfbt?=
 =?us-ascii?Q?WSmEyWXFfpiaKe0GUo6fcHDrPkTReZo0nN+ujdS5iwhfk8Y5nyfys2YQCzVz?=
 =?us-ascii?Q?UWoYPVXSOZFo2RT8GMsKqEKBtBHxayGz/EliNVmdNzw7VYSKKF6xV4Wyfjqo?=
 =?us-ascii?Q?6qtWQf3AlYaWwyjD6a60b7BcEC1fyhA6z8AJ1y1TwEkR+Is+eDVQMLhmtstX?=
 =?us-ascii?Q?WfeztD03tLFF5P0FA0dZ4CeBKqQcwGxTSwgxFYSjSZs2MMDsC/LWq7a4F5Fb?=
 =?us-ascii?Q?Vd32CfWxcdxWg9RjeuVX1bSgQZfUWBqAQ70AgutNKxcnu7jp190hM26gqqi5?=
 =?us-ascii?Q?zaltfppXCa8XbaHYVqY9hz9BlqRWO9EFBkePgSuh4NSoeBxRC/4hYucZNAhE?=
 =?us-ascii?Q?dlaH0T15Jn8eSHJX/85fmPbccNNsfIiYRokBLK4/fNLIYIV19sxnfA2nwVl0?=
 =?us-ascii?Q?/CUoyCuW/MExM4xILUcN1CxyMAI4Np3bbD869jK+gWffrYdD6TChiLQJpOyv?=
 =?us-ascii?Q?vrO1G/O3TifVgIZWYIWO0Sr0KkRWfbl/DVf9wxY/j0jhIW32NhXALfukghwZ?=
 =?us-ascii?Q?ct9EECSC2r64+zT3agCEuOD9wweteajSdjUhek728qqLBcdt2Fv6RjLDHv68?=
 =?us-ascii?Q?kGYri4xaV/20KuptqTRiuR/LgXbGu+ombKVlG9q2vzd3FP/zZ2yLRQRROYah?=
 =?us-ascii?Q?qPNwX8m2Myo3FIn0+0EPnHQm1zxhE7+uHIgI4UuAmvpOyp6ucXrQ0x0KAfgP?=
 =?us-ascii?Q?LK1uui8apVpBJMdZkgR3n7U=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdeba225-d550-482c-1522-08d9ecb4ffb2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 16:47:17.9171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uH1n13mL8OKRUXCZhZv8b1K+JoCXChjA5mKYdmu+NPuuKdJMbjWhBG+57gIRoWlPRq63NeKrjaDdSKzY1RMATg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2421
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
index c9081d79ac..862dc4ca00 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -911,16 +911,16 @@ def extractSettingsGitLog(log):
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
@@ -2275,9 +2275,9 @@ def applyCommit(self, id):
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
@@ -3948,7 +3948,7 @@ def run(self, args):
                                     i = i - 1
                                     break
 
-                            paths.append ("/".join(cur_list[:i + 1]))
+                            paths.append("/".join(cur_list[:i + 1]))
 
                         self.previousDepotPaths = paths
 
@@ -3977,8 +3977,8 @@ def run(self, args):
         else:
             if self.depotPaths and self.depotPaths != args:
                 print("previous import used depot path %s and now %s was specified. "
-                       "This doesn't work!" % (' '.join (self.depotPaths),
-                                               ' '.join (args)))
+                       "This doesn't work!" % (' '.join(self.depotPaths),
+                                               ' '.join(args)))
                 sys.exit(1)
 
             self.depotPaths = sorted(args)
@@ -4018,7 +4018,7 @@ def run(self, args):
                 if len(self.changesFile) == 0:
                     revision = "#head"
 
-            p = re.sub ("\.\.\.$", "", p)
+            p = re.sub("\.\.\.$", "", p)
             if not p.endswith("/"):
                 p += "/"
 
-- 
2.35.GIT

