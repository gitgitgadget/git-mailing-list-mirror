Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AB1C433FE
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 16:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244757AbiBJQs2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:48:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244767AbiBJQry (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 11:47:54 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2073.outbound.protection.outlook.com [40.107.96.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9187B1BA
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:47:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNuuHx6Ufa92FQxNYhwDo4v26mrQJsKOT2NBQfTXR7F3ZRd0ojenc+JqzN0rC/nGJFIHqV1WZFi+FdjFkaT1g4XAEFJ31iKVRWhwmGwMHTUdb+hzuAXz1KQ2PbE+HFurH+9hw9oaW9InkawYhSFBVS71q7sAyxwxZ1+a65R0dykPtUHbX0yiHDhFbe4kWlM8RDlO+B+DcZFNqQ9sNdFfhTiAH2ta/HpaGvYVfxSeka70pqWWAmgrsW5wdlnGoLJmnxBHsZ0w8NrclfYajvxINb4p34dyLSAk49UhLQL6PWcn0SRFNkcILNUsg0/llVmCNCewhK/GtmEFwQnt0F7q5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VulX7N5EUIsHl83/dgACB2S0sanWGbfzugzkQbV3IoA=;
 b=j/VZm5MQ61ubvUOTjzJgrMr8RSt42fITldWP9vagKUrsIIYTYMGm7fRBgHu+fCDESBCHA2Pge19kcawhQCYce1opKBOoubS3+xIcbqs+SyxFl/q7gTWxKeNeEf+lOrZRCeTUfkCo5knTB1NprU1JRiG90arBhLroDAAQj9xVER0DrCzm6EdTFV4o9VVFIu8eh1QTqwC5usbG71cb8QNF04nKm9RGZkty+0SlMHh/SQVC33EGb47hrmmeyGxI/3kNu12xYvJG237VYnCbd4xvynDQumAWUIQUweWuM01xFm9A+r/k8Ioe/l30acFmHJEMnUg0C96UtB9oEAU6pLZHlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VulX7N5EUIsHl83/dgACB2S0sanWGbfzugzkQbV3IoA=;
 b=pZDVV1v57dHrX6JE2Sti1RZ0ix98ZwREsPcULldXl8R1zzp6cN1qi84WGMZKfS1UY3nKdTkJ9JMnoeJ8ATK+so3MCUIVQxraVdCIG19vh0TiwttLTcNRNa0WRpEkg4FxCnY310C1mFqAsjbFbxPVN15GGP/AR8wW2u8VqAgVZFBA6sVmIhiIeY4IrjpLJTLrleuPtMykN+U0uiMW9PBzoJJB7licL9oyqHt+5/h5d+NE+YU+IFN1R7nBYXJmodlPsdWXaNsvgSJDoUKORIJ/YKMv1WHOIOPxweu6PiiQIHRma53t+UEzUEvHO5C12O28gnm4YgD05VW+/dXIb4hUyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BN6PR12MB1362.namprd12.prod.outlook.com (2603:10b6:404:1a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 16:47:30 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10%2]) with mapi id 15.20.4951.021; Thu, 10 Feb 2022
 16:47:30 +0000
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
Subject: [PATCH v4 18/22] git-p4: compare to singletons with "is" and "is not"
Date:   Thu, 10 Feb 2022 16:46:23 +0000
Message-Id: <20220210164627.279520-19-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: c3380726-7b71-4e1a-408c-08d9ecb5069b
X-MS-TrafficTypeDiagnostic: BN6PR12MB1362:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB13629993F7EAF82CBEEF4055C82F9@BN6PR12MB1362.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p2W+8jLa7yY3p7LTWDoARNECdve9xM2/p1bP/1A7ejv2fXYf+fiZfTgo8sARLQ4Viw1tAvTp8ONdNMA5+dXswEbz9mjClvOk1oUJG+BIa1706CuBycEUEiI973CstAJPXCtHP1yW/2ipxs2ZziyVh3f5Zy3cCrOyfMYno9zrC3IfhmVR0zMC3TtoTu4FEUKI6+fVtUcBc3j6id7NiMRqtiLj7+zO6hXJiVY7VaWFBGuI/8lwpJ/8hS2f9ub602Hu//tXP+AjafgXmyJq/VqYtWZF5U4K/8hhL+sd56ohPKm6v0JIkC4ffdB8qto8e499mcpIGnh7AKZVOzec7Jo4SMT61ku9/wsYETnk/GZkmaCJrQYo0l++8o/MYdm2bX1s/243AFqV8CX+7xK8M1Ki6MiRigtilkMnwZq0935ElX6X4O8PHsxtv7eFB1mDParoeX4cH3Ozo/MiRXaE51NwoBQU1uiAwnuSBt4EUbGFuO/P4xWLYHx96sVEjvBOvcB+3p3hF9QscFF6uyLFHgtTDTNNo089EMVhi7L5oWHwPMdRzaMeMzPn9+3x00bWvsKKvy5escY4pKwTlrXawqgADzi0Z1f+yqZmTceHvs73Yd9uuPBswdbijGA8sc3vhV7OfSH1srgsvwUFT25lor1zvqCDMkB1zn2cOp54JAEb3SW1IdnFk/Q199ieSBM06nxAuTapzp/7xKkH/3odlmX4D1sT8mviHvSyvAVdtwViGohnKfArq9ZRFQY84RGdUohfOgqq14uxA5p8+bKuI6B/KvU1fQbnCEWtcH65aBmimYg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(6486002)(966005)(7416002)(2906002)(8676002)(66946007)(52116002)(6506007)(8936002)(83380400001)(2616005)(38100700002)(38350700002)(4326008)(1076003)(107886003)(508600001)(66556008)(66476007)(5660300002)(6512007)(36756003)(55236004)(6666004)(316002)(110136005)(54906003)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N3a2pKtWtNoDtm+CjfYBhEAI7LxWKq4GX8ySuMSF/c8r2zrqjIU/P4gqb9E6?=
 =?us-ascii?Q?RCdZRdJYhaJ3/wKyw4iGbEOrARHY+YF8F89dfyvweH25MOGtUTboizQgvOTk?=
 =?us-ascii?Q?pu3jByNOLb0gaFopTSZ3LjO/cvI3d0oBzO94t2t4fBn5/W4NNpzi+cHoevzz?=
 =?us-ascii?Q?9JDOZ1/bRKEPJUL+jlqNwAX5yS3u8IEqaeGVFiK2mswc1NGAMAr69rfyXn38?=
 =?us-ascii?Q?kp+weQX+qfelL5w0C2e3At1zjEaf+EqdfBGcMzcGtBSWMKT4h0KDlBw+IirV?=
 =?us-ascii?Q?8BUjG/6hbEO4FHui2mmB1sPJDgYhts1M4Zbj1beLFjg4T2vBvorlhk4qJsnC?=
 =?us-ascii?Q?c5ZKrqMZrXxggIVTEUorSXTb5Aizu3ioooJJoCcdtjk0GD+r/l1/Y5YoNhow?=
 =?us-ascii?Q?joxu6aftnaDQZ13I4KM1vSaI2F2oAt+WnJX1TdXBbcqoQtOY84J7LS4QvMM3?=
 =?us-ascii?Q?wpcGA7eIqDYbQVGC4iwVtSqrhMnjedirhuEAJtdCr18ZAsfFGqg/6KCK2SxB?=
 =?us-ascii?Q?2ZB6g0yEahIPcrEGsROlOACMOAMNlHlnV0Gnm22SS18dVeGMm/wG0m54hw2E?=
 =?us-ascii?Q?AOi/UuddIBUTArRzkXHsjnqlzhYxMGFoJiElXkex2ypZxRlIj/++VEg+13Cp?=
 =?us-ascii?Q?u4UBzZ+LnMENcUBh61m9xxYurTiLd5uXJoWo7eKZsC38aZUKLhBYDkFkZpw9?=
 =?us-ascii?Q?h6v5QTTjgWGq1sSoorsSkt/XhtQf/d3j7s53lx/PAK0mmIJRHVaXV4k3VskP?=
 =?us-ascii?Q?eXYHXTRWHa9jmDWv7SceGWC+G7RC+UBD2038wEX40BBMW3SEjy4zrezPFM1p?=
 =?us-ascii?Q?pxAHW2s3t5O+5SXZ7MXb5qRnkDtFiColHPE6y4wMAu2+zQaTtv4VM+IAO4un?=
 =?us-ascii?Q?hxlyW+mNBfA8h4E3ChgDh7QlzpMU9ZEVcW/UUUf3W5RMthZUiX+Z0kUHwrOw?=
 =?us-ascii?Q?+grwz4eP4nh/e+huOm+Qs++S2kUZCnxyqvGidHjKOcvD7/g7jIgELY8gPeUx?=
 =?us-ascii?Q?11eU1X9mMA1rmNWyTWHk5XhgQHl15Xapdmr7pcnKBVXbsdA3UXWiN4uk8VL2?=
 =?us-ascii?Q?ZFVqGXgnWnZwF46VOtZ7V01an6s7fwgChstvasYoym7OC8Gs/JT4sZMiITyJ?=
 =?us-ascii?Q?Ibu1OBh0eqlLm3I4r0Iyz3cdTuwhiVOXjcDBY70byaea7YIrk57L7sF+AFvv?=
 =?us-ascii?Q?JnaJWUuBZ+U2sRW94su0XxY5HqpDh+vrxjj2ok1wLL78l9nEreMew14CMkzq?=
 =?us-ascii?Q?QB3jy9YrbpbSt/yXagqmWZtv8AFzLQH6IbUswV5XYqn02x9mQmEQVKh2eXxW?=
 =?us-ascii?Q?hzTLbEk9lUbi2Tv4a1APjWnvETCIPF6oVBDyERVT3cioVtIMasOxxRg1y/nN?=
 =?us-ascii?Q?R8rnqmgYRXFJZXni/lQbNJRJj3FL5Vrh3+zGFzwkateoSyQ/isrSf7UMkCdc?=
 =?us-ascii?Q?BPuC/d8WjMybgQJu+xZxFjvgYCF7zhWbV2n7/mx4Ctw0Qg8GiE697BdFY7pm?=
 =?us-ascii?Q?pAmyz/tsuZD8lB1Kfj9AAk+/5J7UGnLDKkett16bwsiINQKMPgx/EDjshoLo?=
 =?us-ascii?Q?F4MDdXDWgkD2kF6SJGcK9oHA0i1lqBJkDFL/vJGGe0nkdXblYUjXLK+yZCVx?=
 =?us-ascii?Q?FCmgEY/B8b9VnX207yUsuRE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3380726-7b71-4e1a-408c-08d9ecb5069b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 16:47:29.6052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Hn+Ks3w8EoP9rZL0LZhtjXIYab3Ct26inAIVsM8JVeePtP+0s3EGDsbUxK2MyVc3xrrySO0/VQtsKYeiCaikA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1362
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
index a25adc8bae..2f2450f7d9 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -857,7 +857,7 @@ def p4Where(depotPath):
             if data[:space] == depotPath:
                 output = entry
                 break
-    if output == None:
+    if output is None:
         return ""
     if output["code"] == "error":
         return ""
@@ -879,7 +879,7 @@ def currentGitBranch():
 
 
 def isValidGitDir(path):
-    return git_dir(path) != None
+    return git_dir(path) is not None
 
 
 def parseRevision(ref):
@@ -4425,7 +4425,7 @@ def main():
     global verbose
     verbose = cmd.verbose
     if cmd.needsGit:
-        if cmd.gitdir == None:
+        if cmd.gitdir is None:
             cmd.gitdir = os.path.abspath(".git")
             if not isValidGitDir(cmd.gitdir):
                 # "rev-parse --git-dir" without arguments will try $PWD/.git
-- 
2.35.GIT

