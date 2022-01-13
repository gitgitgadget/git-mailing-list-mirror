Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8496EC433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 13:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbiAMNss (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 08:48:48 -0500
Received: from mail-dm6nam10on2078.outbound.protection.outlook.com ([40.107.93.78]:10304
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235518AbiAMNsh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 08:48:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRfN4Iz8BcuIssHwcQ1+FwnPe0xZp6Jg6PzDoRPtRUQRYg5mZnsSakjuk03HyeDntmHICOhxauMORSxs5rZcNz0g58LTmtgymDlqXrhVM216t97pdiLxfw2gsauVIxQGvZIEPIDI7lC8w9J5khdTfPrh2iT1X/Z60BOiTQ5De6w542OhnPDeeUVm8mKYN/TVqCpkS0YamcOa8F8LUDCs1A/ubisbb37FPIgkUrxGLpF0KB7Zscgo9xmpFMBrHQ0L+ulITG+SJZl8lxnZF9KiH1KsH8y9SQj1w4V1exnn2CGn1xo0N49gEIeS4+HbLTU/A0vG+AljSsqR3f/e2FG2mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzPcH4KNyGRJM64bUc2MEVInf+N1iCp8sCsc9AhAmBA=;
 b=YmPzP1CunziYtBjI/0qgR7/6v1wOBgH+oG9m8kVyRtcafONpLNHiyLcghImzyw14S1irzm51QRBbvQArdPmBjbOnha0RWeYKm2VkdjQPZScLcgyNammuA/EuMW8G3Ei7xYZuLFfVNOiUeZ9XMGC0Fm0Fx0smEHZ96+WoLm4Gb4Jdn36yHf6zK/ufTAIvu0YWtnEdPZWh09Z3yx+yBPDYD4BjR9Nu6+T3ACaTLCwwsNedoUAJdtYVl+3nU1k181o19HHdr4v/slmN+Pcw4ep3tu5pFlQePidC4aBRESViLb4goqFr9D++kYmOliErUQT7BjoJXKzf29Vzf+3llmbAYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzPcH4KNyGRJM64bUc2MEVInf+N1iCp8sCsc9AhAmBA=;
 b=hUI4PWK8+94MdGlKbCmzxfEQPcBYTop1YB7HVdzBhLZJgXJWhVQN5CqNcLRKqVYc15WxneTHFyEuVw0TOYH5XhCtiwa6yYb0E/yaMgPECzCTFXyLzphaP0v3lgroav+Z4TmF2kTAdEdU9k3EutIyIEsat8KpnE/HJ6wzJ8+t7IIflUh4Y5/Zi14E2vbYNjMfEKAFG9sP/gwAqla4MAsy9LrMH0vlOfrL9pA1quUMKr5R1xG5nrFKfw8Pi4vWWrcd95feCzY6KyQV58p1eNie9WwInlRioCm3KTXc3RvMoE0Q6/LcyS4IGZEm7+4ipx+nqLznxlIV963xAlmicS+XFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by MN2PR12MB3791.namprd12.prod.outlook.com (2603:10b6:208:167::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 13 Jan
 2022 13:48:32 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 13:48:32 +0000
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
Subject: [PATCH v2 18/21] git-p4: compare to singletons with "is" and "is not"
Date:   Thu, 13 Jan 2022 13:47:25 +0000
Message-Id: <20220113134728.23192-19-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 975eab60-d54e-45b4-babd-08d9d69b636f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3791:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3791282FC76D800F6E50F0CEC8539@MN2PR12MB3791.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hzDCqoLAbO5yiteI8nvpgA+SmtnJ3UXKltZcvRSWRgUq9gD++kWvIlnkxh7c65OvRaHhOqHiTmHuzc9Hyp2TQfuJKTSeEszjuEKIXPu7unIEV5I72eRUmNjCgfG55bDY3VTveXgTS4n+Jv6ha7AMZQJ6Nom1R4R1RDtmBxDpTKx4rFAkmtDmv7bF3flesHtnzyLgQ3UxolKIsCkyzvFfmidNVv6Q7870r54KtVubNESQuVPp8ONGJ1lJECEA5hy4Pr6VTMDMQKT773y3egUWhCTiylmHWClWnXN020lHVoT4vePWaR00aeZL7w3BHQWnqE26ifoSPVhrJjb4p8ULMhw6i2CZKxEHBUkNFJDrifW0vrV0kAHsyXhPKoqh0Ew8P71urLdkY7j6npKlWdMFYJL/U0PkpOv4PO0v7eh0mkKoMAgsHXRRK13h/4WE1zIzpuK2M2ln1SwMM1dHK21ZMqQNUffTYutm2IYPF0U4P+qwJtLWUYealXsvi8I2Gi3uwXr+ypGNDqXr2fU3zLK4C2QBdskFmx4kObh/e27kfK6uB/fPWcWVboe72qdmQHu3f5rzBSVCUbg18vp5U4COE+8Fssh5kiEwu4p7NuGejPLateUkIai74HVfo37biBqf2LhnEPbBRGOmQmpnzr6UEETxyLe81DGuKXCntttkKVyYpYt+QrNSoR6RUOR47xG7yiAY0l1QYzUZwOIpcoz9PIj4GGeI4dL5eE65Uwuxc+lzzdz9RjDRrq1tZy36OWXbNYDgTwo87Y8DDyuu1AmemSHiSjEaTikVCYvTaCS7Zws=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(6666004)(5660300002)(2906002)(8676002)(186003)(66946007)(66476007)(6486002)(66556008)(7416002)(52116002)(38350700002)(110136005)(508600001)(36756003)(8936002)(83380400001)(1076003)(4326008)(86362001)(6512007)(966005)(2616005)(107886003)(6506007)(54906003)(38100700002)(55236004)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k+5fOZzUb/pc0AcT7lMq3soSRnqXF7X3MM0Sdpu8qBSinfPZAF5dawnJwdk/?=
 =?us-ascii?Q?0IFpmMj4ZCk4pzLuym4VVaUiiynY0XE4TeWCu+z0pud+wGUlYzJxLKudXtIQ?=
 =?us-ascii?Q?xIa+aQDfQphKPrA4/twUJ0Ek+VrzESvge+X/BUNkMbssW+GiP0zdQSqtKU27?=
 =?us-ascii?Q?qqccJlwaX/tIiukkUEloVixbHeHDbnqL9jCHV0iNDwdRrt0GJiZ7TbWHcz9n?=
 =?us-ascii?Q?iUf2ARUXAgJYElkPBdeDes0PoYfoozp9kJVWpOaNXC0EXCFZBOLz5Bhk5ixu?=
 =?us-ascii?Q?lWqELaIENDUzSoswv4JMLrotcCYxuoDUIRgG0dZbnvPkhE4i0VmHL8b3TzPG?=
 =?us-ascii?Q?ssmRoP0NxNHi1bnXsHa9rR/kJN9lsh5H8RN4Xel2kGn/QWmb8diyNvsRBZgx?=
 =?us-ascii?Q?3/oHIjTf5j+nMwX+/dhFnl4Dsg1oV38jkBx3YcPDXvBnzPKN3lsxJow5r7hF?=
 =?us-ascii?Q?sfkPwid+cfwSAEBt+zJ+ShqI0+WIjZyvy1jU3d92BXYrGPKRS/KmS0RQqKUo?=
 =?us-ascii?Q?WDP2L8PaxW8jCslhLU/vZyVh81azptu+IvD0iaY2SEaUXxg1kRGNAxxgqchd?=
 =?us-ascii?Q?MFWO0Xh7407cPaMl8LVUJOrnrYnwZYzBltHT5MSGEwAm5H7Wa428UVvLcKNG?=
 =?us-ascii?Q?8VlTmoaI2BkGJ++mru/285B3tKrH8ppdX7sEcEoGyJmmU9wWfH1MIevmtinR?=
 =?us-ascii?Q?UZJ1b8ARzdOyoB3zNc/xgPwnHOWiNaSnFRRkgM219mtuDqje8HHLLBk3WZTp?=
 =?us-ascii?Q?k6HIMkCmLxIZ+auPW3zeX2qvqMI/rNOTsVxlviHrgn5tR74lW87McPbv2LOJ?=
 =?us-ascii?Q?YQ0v67v1H8ikouV0SydkIfa+q67zbiJkhHbwNph4Ho6ht9CqLlY4viNK6lcO?=
 =?us-ascii?Q?3w7foKlHbtupMsICxJshnaWAZ6WfEAaG1lEx3+xEt0jNjOrFV/8zMy20spzK?=
 =?us-ascii?Q?rA+x9nq7KbP00S2vLZzd9kHNmFRjXD3nydTKWUoiJpv9wB+iM6Jd1pQmt+ZK?=
 =?us-ascii?Q?sLrked5E0D8PzCDCPCP1XvVM51B/9EbYZWcVFqJIoquVU+2eUndHHwJuuzpP?=
 =?us-ascii?Q?07CUYLG57tBui0x30Y826hpRABW0gT45Fhfq/9ZvO0F2sBtjgZ5afuzetQtK?=
 =?us-ascii?Q?2ZN5hxEeZ97KoVmXCmo01hsKApdTcRcBOP55cPnvViU4OUbYnHn4KBZpZ05U?=
 =?us-ascii?Q?DJZ4TlF3X4j9HhWAgnLtfNzaDuIcV1y0qDO09Z6bpEUw5dIThYQiUxvGXBLs?=
 =?us-ascii?Q?ZBTem8bjekzJ3BhQEoWxNGhIo4j36bsHcqKTHA6EZUrJ5C1ZJGVzvRjt/b7U?=
 =?us-ascii?Q?wiSBaR2XUAMCz55w9SZZkb4QLzsI2yoaY+xff89zmov1otKrDbHaC9H2rkg8?=
 =?us-ascii?Q?ghS18UL9T3B2yWr+MPujyv9Hwj9a9EHyYb/t3AVaY4YNu8/7lf6XOxLBNl1r?=
 =?us-ascii?Q?aXNcn/ImfDadnNehsx2dLFOalcAOwBMyG4KrERcymS/ysG0l0wqugegl0AEG?=
 =?us-ascii?Q?fTwqVW39Rvu/nXLyuDmH24eCcxh1+D5nB6hpK3hb2MsdsTA0ExS8mG1JAr3F?=
 =?us-ascii?Q?vJM1hI0iLIb2J193QV4F2eYP0lCm7RWcsPiFuKsHK0YBWsTXr2wXiuvUfieA?=
 =?us-ascii?Q?+bLUuZbdkBnkOR/+w8LnUj8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 975eab60-d54e-45b4-babd-08d9d69b636f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 13:48:32.7271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twDcHFv0ReTOWOhf6CGw5tAKc1mP9A2pgONOh0Eu//jOuoCgbr//XmBbMaTHbaF4z1R7Z0A8WRFlTkyAIRbcLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3791
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 recommends that comparisons with singletons such as None should be
done with "is" and "is not", and never equality operators.

This guideline is described here:
https://www.python.org/dev/peps/pep-0008/#programming-recommendations

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
The previous version of this patch replaced code of the form...

if foo == None:
    ...

...with code of the following form:

if not foo:
    ...

Eric Sunshine pointed out that the latter is not necessarily
functionally equivalent to the former in cases where foo is "", [],
False etc.

Therefore this version of the patch instead replaces the code with the
follow ing:

if foo is None:
    ...

 git-p4.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 1de5b1c49d..a42010fbdd 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -930,7 +930,7 @@ def p4Where(depotPath):
             if data[:space] == depotPath:
                 output = entry
                 break
-    if output == None:
+    if output is None:
         return ""
     if output["code"] == "error":
         return ""
@@ -952,7 +952,7 @@ def currentGitBranch():
 
 
 def isValidGitDir(path):
-    return git_dir(path) != None
+    return git_dir(path) is not None
 
 
 def parseRevision(ref):
@@ -4500,7 +4500,7 @@ def main():
     global verbose
     verbose = cmd.verbose
     if cmd.needsGit:
-        if cmd.gitdir == None:
+        if cmd.gitdir is None:
             cmd.gitdir = os.path.abspath(".git")
             if not isValidGitDir(cmd.gitdir):
                 # "rev-parse --git-dir" without arguments will try $PWD/.git
-- 
2.34.1

