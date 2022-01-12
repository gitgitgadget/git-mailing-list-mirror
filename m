Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47826C433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 13:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353832AbiALNtg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 08:49:36 -0500
Received: from mail-dm6nam12on2052.outbound.protection.outlook.com ([40.107.243.52]:20961
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353694AbiALNtT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 08:49:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwSVFG7niT3uQ6lcgz/kFAciilNOAg5Iv/jk8hq/589nDOp9qmifXY/Vy1ooUzdxcwbTjRDuJSp7+2x+797xEXJHb5be4EM5HjyxgbinG5YrSziv/HEDji8l5/5Fv0GhGyrQEPjBVyCr0Kt29mRfDXLXaut7pV4cY8DYlCcI/W0s/sdQpSbfEcnAXBxbta8/Qlc93QjBqsc92Z5ndeNvbgdmd8bR4JmYGSyRm1F/puhYa8i4+h8Fq52iA7fl2o8APHpCyXlYRUuP5kOiMFw2ua/+pASw9lktZHFDInm1swW2vpn+oth3qTSJFytF676iOnj3fVANLqOvBtnI2bBXug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTlPX4X0q8rjV5UmpT06da0Qb0u4BAhc1Ywi0fvBGDU=;
 b=Yg0YQ53f5eRWkW7SXR0fsk0C975uBafB7HkOp/1O60lZj5oVftE84VEeIwdK4CY/HhF31gwVuMpB8FmKGQ4gsgI3pZ30M97WavO9LhsF64UEvCMivGQD9Oc/UbSuSjgy7IxOdJkQ8KBeUT0KwWQg82nk14xOfU9kEnGDbhSNFG5iw0iOCMsieRfMM2q8qfFkv5g1jRo3aWCBW75Jshy9cby+KGNC2DrfRqikNSbQmvArPbQ26C/vWsYB3ZnFxQfE0+xb3zHIxyu7jjgIgH1cBgdeFw0YlYuIKg9rifpT1SATV8FS+17fBUndgYlrpf3VIaI8CmaVDZsK2SESW5pGEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTlPX4X0q8rjV5UmpT06da0Qb0u4BAhc1Ywi0fvBGDU=;
 b=F8GDJIQ3weq0bn0fm/wOuymPk7v5Zbo99mIH0LOc5MgC5nSfQjGidqItIuh2q9h9wKjZdw9GMtnZCiU0ZrANSRaC/w6QXQxGjj6vQvUTNCLuIdcDwx9cegU3RLEcWZDxCIrPiZniWTaXod+c47UQDT5+ya+MAxDinYlqsRxBTMMhB4oeSAaFHkZ4UP4T/E9kpAkncSv1bgi78M84HJ/j1DfSyDEUT6fTcIZLYlJy9RqsHQEzsw8Qdsp3uJ5s2C+wDyElhUh2jOn8b3riR4+YcNdOeNy7Y668+6rKzc96nwaqKYKp5CKsOgOxDeF/5PKsa34qUoiDgI3efkBVmXx08A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by DM5PR12MB1594.namprd12.prod.outlook.com (2603:10b6:4:e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Wed, 12 Jan 2022 13:47:38 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 13:47:38 +0000
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
Subject: [PATCH 15/20] git-p4: ensure there is a single space around all operators
Date:   Wed, 12 Jan 2022 13:46:30 +0000
Message-Id: <20220112134635.177877-16-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112134635.177877-1-jholdsworth@nvidia.com>
References: <20220112134635.177877-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR04CA0137.eurprd04.prod.outlook.com (2603:10a6:207::21)
 To BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 955a58dc-6768-402a-4895-08d9d5d218a1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1594:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1594B8EC8ABC1E00FECDF290C8529@DM5PR12MB1594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:159;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HgqZ4ZdPqZ7qkTvCp1DkVJdxoRu9286FANIagcUsLmvsm7jmyNxiBks94GzJsOmBv+DAoIIaoN+zNV9b4Le1eAvbxTYOg5EH6utC94OtYZYhhMTbwKspGmWlYysw6al6vHh4hK7RdMpC0k8nNESBcJmAdTKo5XKqa/Mun9s/11mIxiOU+IJQVrU/Jlgy3hz1mHrTOV++RPy7Q0vQyth/D47ZSmOavKjz+kj7aLUoYGY73v7y+GKwoaBNQ2m20vWLIGaR9C8iacbFqMJAJi3h5niudDl8alk2E27jp5RjDAo/OEHbsbERFiTp0t6I/pvdb+8ETSIxZFVm4TfQEJCj1msGB4jXUETKh4G2I26sJyHXxuV4nJSxl+I2lb0S3dIazHbDh7XaYtoA/vXsY3+mk1r+wxSqCMqvZGbVi1gUSJbWU8qbwKgGMyePilSqkjIpjivhwXZ1S7Zh5+CAawRZHoFnvUSVIBmMaSbuGqI8wnDdy3mx2GmKgJzJ70UEDcIH2vMVrVWK/qNuOdq+6Z8M23fPJ/lVXYaLZrNnPvRNR+f9x2mJTJW2pL/vkgmmcVumYS1UEa0gCRc6b+a6JNzS19BtiDNnnixx0Y+6HV+YTplZosoLLAQ62ucRZOVEP+erdhkkKqX9ITz8hUlR5I9F59T8P6oxjRCqqvGk0Y8n92qL+UXEYU1owH7OmZhKhsLbCp7awdfqKIKCzMeKBTvM5oBOFipiq9mPR7xVLxvUJoWejzmy+PF7V9AwL5bHveX+VSu7ZTgcnXsPIiuBRLdq5ZxykUvUhxIW3mh+u8QcFW0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(5660300002)(1076003)(26005)(38350700002)(2616005)(55236004)(186003)(54906003)(66946007)(52116002)(38100700002)(6666004)(8936002)(7416002)(83380400001)(8676002)(107886003)(66476007)(6512007)(508600001)(36756003)(316002)(86362001)(6506007)(2906002)(4326008)(110136005)(66556008)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rvu2H7C6eQY3Ht06YN3caOxs3lBFRgrrjr6VHhjJe3d+8gb5ARUL5IBt6nbo?=
 =?us-ascii?Q?++Ud06Y3OR00EjHXGTlM0otmdX8vxlrI5/B19Ft/GgSQo9oRBMl70M1V7Heh?=
 =?us-ascii?Q?BUsXtMCZOklHPpIUGLos4qHG22e4exOt/V+g2i/QvCUpqzLSWe0KA14kk8m5?=
 =?us-ascii?Q?G+FH4Zkac/9I8Mapl9kNDt3r2apkMUlx7O1ojd0cYhpPkLXgB5Ajtms4hZpf?=
 =?us-ascii?Q?KyX1bHzkyrwnAglraEASIFDTNqOSkWcz8I0uX/ZwQ8EHxsg9+eDr3ZjXp7AZ?=
 =?us-ascii?Q?UPM7o/rvD7wzILg/tMM1T4FZYzUr+rA5a2N7gK0ghMNYacPdA1274h79vv5/?=
 =?us-ascii?Q?ad76AGcOAsGsxfxeZadka8NU5Mr2gp9a5BP4cALKnGffYwAHChmNMCHoHd8Z?=
 =?us-ascii?Q?E3oHigoEuP/ko49nG0qOq3BtJCGw2orOwLy10jOMHnVkOUfvSakE37V0+B9c?=
 =?us-ascii?Q?B5EIil6j/Ic/T9zegtba0u3ZJnvKCsVmuJJqazpo4O2Bv2VIJTjPtHzxE/W0?=
 =?us-ascii?Q?J0My7oTWad+vGnA3VBvPQne3EmL1rFXOwxFoqPwkPQ+AY2LRElnB80Kp1lZd?=
 =?us-ascii?Q?AhxPCzPUm8Ox31/fO9lA01uSzzkLrLdpb2Q/tRKgjK/ojfZe3LyvkFPBbllZ?=
 =?us-ascii?Q?2FabRGxalzpF7Ozc8Kenp9n6Ae4blmgrsHimOhZqci2ZVLlRCZ5M5AuSw8E8?=
 =?us-ascii?Q?TbvOt16ckSutxBTViw8jVhoDtnq/sYCQJ6lRgmNLmhZrhl81nRhUloSlOI4l?=
 =?us-ascii?Q?dgCPxzF7kwrjQAXyIucOqz+rjRzbwOsGc7/beAeRBG1FB40FxBDIRyIZtRcY?=
 =?us-ascii?Q?sOjmSTpwEhypo3v2/JglT3YkOL/5PdLb8TRWNP80m7YHBMAJYp/M7azKC8Ea?=
 =?us-ascii?Q?fAwJ9Uc6UymS/8MAMlvzhRZh8GJmnMWdKJHCVwdsEI9oOM6FQldEAGzHhGr2?=
 =?us-ascii?Q?I9i+grYgXQOHFSNCZvY9/yPc+1hqZCC+8mg0XC3Vp1G24hMmy8+ybJ4rA2Oi?=
 =?us-ascii?Q?YRtYHagHE8HMrWqPsz7IfwnxrLX7LF3t/0xDw57X8O/4hVH3LODdLrFuuztD?=
 =?us-ascii?Q?tIHvPD8Ie5e4LMEIslNxDDVLSnDmLsMmBUs/V6/CQeqJVtU61KvJ3Jn4SMU6?=
 =?us-ascii?Q?zS7oe5HsoRRyKtv078rGdGAiPCl86/eDB5KM+v4cqbKvPS9px+MRcYiJSpwv?=
 =?us-ascii?Q?hhKzK0phSFrT39usfwYhzJrftQCYsXR5O0JSSdiLEbWPpZsq8eAR88jqdLn2?=
 =?us-ascii?Q?AesqjY6vhIDdAaUhU5jfxHFf2PGrmWcNSo4pY6GU3I+8O++bdrYdhlSg8o3p?=
 =?us-ascii?Q?IsUfQTS1awpANFDH0yd3HIWedg6WIVu5pcjFZwrb+KYN+rDEEMQOOBY9A9+p?=
 =?us-ascii?Q?YIiaFi8rQRzgPv8YZwrIZVSFXRj7yf34LBb7jcv91HncK3F6/Jn9J56mKAMQ?=
 =?us-ascii?Q?9ihjWlOY8czuI+KcMT6ERKvDp1L/u9mIRRbHIvSygzPM+PhFofqnUk4aO+s/?=
 =?us-ascii?Q?UU4OY/JfZpDS9v/P3NrdR4n73RdlSp+ltmbwvLATshR/eLC5SnkQgtTHAWfY?=
 =?us-ascii?Q?hwUTaNvf8HjDVcNUhhvT2sblOI1pdVkIQXTwB2Sp7SDSXY/1ZqL7fD625mG5?=
 =?us-ascii?Q?uXfRYjfsnVBWJQWdWgf5R94=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 955a58dc-6768-402a-4895-08d9d5d218a1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 13:47:38.4269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NBpX+N89hEIBm+sO6EbcyXDjMP7B39/As/Rb31TcpuckEjAHZM18T8La3ATpevgYt+ZR1WHEkFyii/e/o1H78w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1594
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 requires that binary operators such as assignment and comparison
operators should always be surrounded by a pair of single spaces, and
recommends that all other binary operators should typically be surround
by single spaces.

The recommendation is given here in the "Other Recommendations"
section

https://www.python.org/dev/peps/pep-0008/#other-recommendations

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 404de3e86d..90e7922ebd 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -67,7 +67,7 @@
 defaultLabelRegexp = r'[a-zA-Z0-9_\-.]+$'
 
 # The block size is reduced automatically if required
-defaultBlockSize = 1<<20
+defaultBlockSize = 1 << 20
 
 p4_access_checked = False
 
@@ -204,7 +204,7 @@ def prompt(prompt_text):
         sys.stderr.flush()
         sys.stdout.write(prompt_text)
         sys.stdout.flush()
-        response=sys.stdin.readline().strip().lower()
+        response = sys.stdin.readline().strip().lower()
         if not response:
             continue
         response = response[0]
@@ -259,7 +259,7 @@ def run_git_hook(cmd, param=[]):
         hooks_path = os.path.join(os.environ["GIT_DIR"], "hooks")
 
     if not isinstance(param, list):
-        param=[param]
+        param = [param]
 
     # resolve hook file name, OS depdenent
     hook_file = os.path.join(hooks_path, cmd)
@@ -2411,7 +2411,7 @@ def exportGitTags(self, gitTags):
             # Create the label - use the same view as the client spec we are using
             clientSpec = getClientSpec()
 
-            labelTemplate  = "Label: %s\n" % name
+            labelTemplate = "Label: %s\n" % name
             labelTemplate += "Description:\n"
             for b in body:
                 labelTemplate += "\t" + b + "\n"
@@ -2914,7 +2914,7 @@ def extractFilesFromCommit(self, commit, shelved=False, shelved_cl=0):
         files = []
         fnum = 0
         while "depotFile%s" % fnum in commit:
-            path =  commit["depotFile%s" % fnum]
+            path = commit["depotFile%s" % fnum]
             found = self.isPathWanted(decode_path(path))
             if not found:
                 fnum = fnum + 1
@@ -3995,7 +3995,7 @@ def run(self, args):
 
             p4Change = 0
             for branch in self.p4BranchesInGit:
-                logMsg =  extractLogMessageFromGitCommit(self.refPrefix + branch)
+                logMsg = extractLogMessageFromGitCommit(self.refPrefix + branch)
 
                 settings = extractSettingsGitLog(logMsg)
 
-- 
2.34.1

