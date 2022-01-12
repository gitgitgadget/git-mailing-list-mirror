Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A2DC433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 13:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353819AbiALNtf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 08:49:35 -0500
Received: from mail-dm6nam12on2043.outbound.protection.outlook.com ([40.107.243.43]:52832
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353702AbiALNtY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 08:49:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKPjpQepNrL88U/Ch2NF0/KENPEkT+Ob7rEQfbF2qMHzteeB0cLAnxd4IUo1maNAUr6Ot/0lHOpmg6zYC8yGs6BpM1XGhZtXhaXC08bHia+LuJ2H9MftDDMuQmTIWgShHFogGI/hLvo8ohZNcSCYEZqh9yEB5bRH15kEzaEuaJfSAtvdNJ1GObIqUBacB/HB6i5AoRHz5+XlAeKZq3YzrbWWrN3SFbBml+fKoWTQGEOHL0FW3K9QyUfi0ev1K4qr5tTVeRmhLtgpaFNkwrOL9dhzZJ37o78gK8C+iknf8f2H1FusP/wAA+so8R6m28v/eh2nXRyzDz+VXHBmH7JNpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnNTDoN4xzaqDr0abdNUHPVXha0GMNPM+9R55PFa0EU=;
 b=f6sRJIXHrbnH3DDJxO7aTOg+e85IdTMefC/AbvTCGChMDjF+vR6NeOdlWC1RqUyWLwmfKvTOw5oAWLJDgq/giXFW/uqP6QppXUDAXH/1AyjKk3dfDZm6nPPDX3HpIy10xkOnS8MyjNxpaAcHFO6vi9RnNxWTnh9yznmuo2mLJ2L67bcqfdNvhoCnM9q1/FFPD3qmHODHZaq50HtWj5287MiDxZk2gDknziboftxu3+cNz0X4rZZI88RS7jWDsRwIb8twmTxEck8FM7DVQlysnTouwtdiuAWjRjJmsR1RypWdc6NT4F9dDUc/f3vzllsFboSyETMlKQVAFtxxmdZhEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnNTDoN4xzaqDr0abdNUHPVXha0GMNPM+9R55PFa0EU=;
 b=IKnvDzSqZ8favkhtY0TGGMIOcJskz1fk3d1n0JBGQcH/auOgVVaDdSt7Z2s/f9ewI70qV8JwbNEj4CliwX5JwCv18NwM8L8bxEuTypfzOq3XjMl4WSpHE/FttfOwN1ryD+vBIPk0qYP/mi0gVF4Xut/4GjyNoHQJOS9Rz4d3ouo51QtedLrcNjUeTCM42j51vyVEZBKlyFrFpGhGNuGtIwD2KfLEQP0Z8oMp1W2qAEXysfUbBgXLCA3fVp0nJtys6AFCE8vDLm7hYZF+bI7Z1nvsGDepKtn05xhzMduQzkKNeaoyNmx2TCsUPmL8pmUUrMzWW9AQYU+5Pf6hKzBKog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by DM5PR12MB1594.namprd12.prod.outlook.com (2603:10b6:4:e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Wed, 12 Jan 2022 13:47:43 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 13:47:43 +0000
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
Subject: [PATCH 17/20] git-p4: compare to singletons with "is" and "is not"
Date:   Wed, 12 Jan 2022 13:46:32 +0000
Message-Id: <20220112134635.177877-18-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112134635.177877-1-jholdsworth@nvidia.com>
References: <20220112134635.177877-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR04CA0137.eurprd04.prod.outlook.com (2603:10a6:207::21)
 To BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d784eb4c-2ae6-4c28-7b08-08d9d5d21b1b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1594:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB15940B8171E9881C9D185BCBC8529@DM5PR12MB1594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j6LjO7ii9HafjeqOtQWm4W96ASmmNo5sK5ZT3/kM82Er1JZ5roe5om2zdXcoX93QWkfkr6LI+F5BtkoZS61b3jzeiDA5xCby/TrGJL9G6Cd31u7GGbj2fd0meG9bVXxWtnX0oo7q6U/qr9JoYOiqHGTAU+x5H3NBG3F/2NiYmjuJUO+Qg6ZTSPeGqXbGiZxcR+2/gksgjx0sBN1di/5jv5q8cLIKQDG5Ao9k2LTxkl+/kr8WElD+WYC3oaBt7SaIVyPyYwiaPT2pA/minB/Lbk+yiedjxxYfNuRCxr9vCtAud87wynFFpkQAIrQjIjlN9u0LRCEk3vxpiJ6FyvnmgBV4ASWbSEE+79K6nA7Eu/F5HJGc0lrm+hmeZUkvf7q90W1fGb8FNy6wTbgcbPrbSyuaL0E0QIlv/yqtG9auEusev1ipHlVSPnwzFYMoLAeS++qm7ny3ESKVqfh5i4VEsVABZ28NW3NUZ4Z5o/syW3v4VLs/DecXcBXprYlJ4pA9rFktl704kdiK/Q1MejLk5S+R+zodlnVXNAEFTReWrgfnkryYtnb8uGmVmhCgg1NNiWG/tIJy9R8DhQN2j5jCcAH7E423yOIIvAjomQGruSmhePsuIrmnz4FHbHz30lgpanqwp/29M/91F/kJnUqrbvawsDt2git5yi99AeNbrpj9PnDssDsSkAJ5ZADaHA887gmFjN8RBh2VrHHwNd9BI3JWgai6mYtAkjSpfLgCka2YK4rbFG2RVJVvykQ8vEymPUDvGctnyxv3bWNSk+UPhOWi5Rih78/BPwUy6gv1uI4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(5660300002)(1076003)(26005)(38350700002)(2616005)(55236004)(186003)(54906003)(66946007)(52116002)(38100700002)(6666004)(8936002)(7416002)(83380400001)(8676002)(107886003)(66476007)(6512007)(508600001)(36756003)(316002)(86362001)(6506007)(2906002)(4326008)(110136005)(66556008)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Xk/AZk5BS1irkuOmMQLXvlSat/qaeHVMm8hkQeWhH/NR4keFhClLy154z9e?=
 =?us-ascii?Q?/Ji6JRtn3ed42tSDDUsABbDrmU2qhHEmeTCsSkdwJOoGDED1UHUBlqdDcPLS?=
 =?us-ascii?Q?MCFbdRhipffT4nnC95r24ppUaAtiP0HE8lLUl4E0ZtJs7Eqd7VqEHJSYqnOx?=
 =?us-ascii?Q?Bt6SfdnirQfyepuIeOsOmecLpx80o8yIn0o6DtldMWV357ha5vlYZqvjt6sT?=
 =?us-ascii?Q?8ZO19FrS0EkEDWrSKQt6PQhpxc0Uf8PiQkVTwxUWmArRiHwZVX80eYDb+Snq?=
 =?us-ascii?Q?bkYcIhkAXyZKX7lFrEVEjE03K9m4WG+mF+deVfbAWV/jPSbdM20NfcKh9YF3?=
 =?us-ascii?Q?6CxLFl4TWneIRdnldOJeGmfz87tMxTMt7CF0MeKoM1dQMbkceTDOqoGezGca?=
 =?us-ascii?Q?7ovq/fGp0u6+b6zHcLLpikcMQSUDFhs40c9K0OEW53aMwTX43kJOUfhO47fk?=
 =?us-ascii?Q?NOZTZIWTnzi9ve/u3dQdijH6HHXkG0rZvY9dXwMY5F66VqU9y+DML5ZJ2slD?=
 =?us-ascii?Q?BhwSx7NlYQZCYxOuPTaPmie8UvKftiONDrZDcU74vMJkpzhNX1gSi2jNQC8w?=
 =?us-ascii?Q?W9UIThwMqEgHNRRRK6Tdq452dC551M8bezfJq4skvEjLjvv809Ho/u7P5UmG?=
 =?us-ascii?Q?FzUUKXqWydddqtDUjhvOH/pMSi+9i3kgH9pPSqXHMD/PtBacsPWRV1hWc1F8?=
 =?us-ascii?Q?U1MesiXfYmNiUtXOyz5sOKI176wvwyfliNZGBGAPW8xCVhep9kh4w3hmHxmN?=
 =?us-ascii?Q?yPPPDIh0AdFgS3UMjp6RJMkRDzptupKwUwQxlEi0Dtz+ikmDfGSVIJZoy1SA?=
 =?us-ascii?Q?agYkbSNHTxbacwb8cq+lSV5xXJlMPetPY5lEtIFUPoCV1GeSy9W8vLiOf8Lr?=
 =?us-ascii?Q?yyEt8vLuVRmsZ0RKwG83Teff3j4cKbt3gtKRRh4apBSwZY3cmQMHoXV9S7rI?=
 =?us-ascii?Q?hLft2rAHoRBZC2x99124Lvk1bL12w+l35KemZ4A/m7SoFIj/LSLkYXiz4QxN?=
 =?us-ascii?Q?CtGXItmyfXWkzL2Uqq/HSV/rp3raaobJFItloiX/rY/6lXSBHg4pu+bf1MuW?=
 =?us-ascii?Q?R0t/ljR7iSDmM4wNWRxqG1f2cwBNAt2AfV9D+SUS7PUMSa/w4AanK9JKz4ot?=
 =?us-ascii?Q?RUzPTmYxGsgR7xfTp2cXdIdDwf2ySPGYX/5EXgk30DtuEgrak5YEk5eAwVxq?=
 =?us-ascii?Q?Mwkw9ErI1g8cMC3MNBI1nh2e8BLoPPGlp8IQo/+zfCgt7oUhFfCYotFAMaq1?=
 =?us-ascii?Q?tK03OHlJUTHnGyF6V9zj9zf6QcHg1uL3GVZCEuiDtwQUwk67Cj7MIppcqYYK?=
 =?us-ascii?Q?Sf+g10mY36LKIcq++qdWH0WKmF2GqfsXKHARvGzBZb1g4LAWCn4HYsqteeyu?=
 =?us-ascii?Q?qTfnkB4CJeVWNojlNl+FYKJghtw8tuOuDZlXAhmKzzjJHuECGl9Y+PqH7f4W?=
 =?us-ascii?Q?qosex0twMPYGqtLxrRQRDGBtZRkBatas2qK5jM5sdJNKN7XXaVv0wXp16UnX?=
 =?us-ascii?Q?ldxvr4e0uN5AOXmDvpf6SoQFuXh0kiVby+WIC7w3BCgqvsvuJoOKDVN6v1sa?=
 =?us-ascii?Q?Li45YqfMmDQE8B0lsqCvjT+1LbuJFs7Nk4inPD2FSBQM6/exGNEMZHfnbSPm?=
 =?us-ascii?Q?aQWIylD96mwjfxFTFS6X8/U=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d784eb4c-2ae6-4c28-7b08-08d9d5d21b1b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 13:47:43.0518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HhJ8YFI4qkGDDC2hrLj2xWdbNYBL2mx84uwFEf7SdIXsj7HNcX9f1et/OFOgYVVkitaVN4oaGL/qg+hAm776ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1594
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 recommends that comparisons with singletons such as None should be
done with "is" and "is not", and never equality operators.

This guideline is described here:
https://www.python.org/dev/peps/pep-0008/#programming-recommendations

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 0159e35adc..2a3409ebd2 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -930,7 +930,7 @@ def p4Where(depotPath):
             if data[:space] == depotPath:
                 output = entry
                 break
-    if output == None:
+    if not output:
         return ""
     if output["code"] == "error":
         return ""
@@ -952,7 +952,7 @@ def currentGitBranch():
 
 
 def isValidGitDir(path):
-    return git_dir(path) != None
+    return git_dir(path) is not None
 
 
 def parseRevision(ref):
@@ -4497,7 +4497,7 @@ def main():
     global verbose
     verbose = cmd.verbose
     if cmd.needsGit:
-        if cmd.gitdir == None:
+        if not cmd.gitdir:
             cmd.gitdir = os.path.abspath(".git")
             if not isValidGitDir(cmd.gitdir):
                 # "rev-parse --git-dir" without arguments will try $PWD/.git
-- 
2.34.1

