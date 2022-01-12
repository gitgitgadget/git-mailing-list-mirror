Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D004EC4332F
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 13:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353729AbiALNtu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 08:49:50 -0500
Received: from mail-dm6nam12on2073.outbound.protection.outlook.com ([40.107.243.73]:36313
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353750AbiALNt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 08:49:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AU9C4sEFIeHjVE9s34T8tGvz9ddV3Ri5PpM3lQBYvajz8iWXqcT3lRUDJVZW/XbSURlcvCMWsdytXswd+dj6YHdCEabQWu5bTpBQM0NUBd8hMgm41QHjwF2UWxhk48NcwtKpgqZXj0xXOrubUvOpvrvsm0kkdqZa7JogIoK1sW6Oxprj8U/tP7K2AfGr+HguAbWNva5YhYxBNl8OhLuv28tttdldM6Cbx+qJm8gwOLf6o5VMVMO2Ge8DENM2JovGy0F/J9VOEzX3DOESnQ4DWqRkm+AvegOh90niPg/Bp2s63hVJPaqnlgTNElEvt3GeEEVm+tk21AH8v/2eR7ritA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guICCNkFX+arutrgwnNHO1HhiNMo4pA0QwG4Ge82WQ8=;
 b=UoYii3izMQA7EMNgqXYX8iDJ5yaqTGocYD7nGjJq/72CzUSt1h4DpOSzP9qzaJ5cMXRSw4cl2VJoxYAjVdYbWXgvqIIGSeh/gVSfYEFkWHL8cxjZZB5uAVVeZFb0nj6qEBEhTdSL5Haoi8GJ94QCQsI4V0eQPedN0ycFS8V1H5u/Ht1UKt8Oi6XPjAL2VKjE37D3YGzf+sx2F1d6JeWg8fX9ctrNwcFRzsvZ68NCs9z9ZuvWyRc5uJDpkC+xvATyfXd3srbIWusF61EPJ8CtyfKrNtL5cx8Zut35BA2qmEura0lRwSW24HSYrwtYmV10+BakUE4zd+680h1G7BOkOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guICCNkFX+arutrgwnNHO1HhiNMo4pA0QwG4Ge82WQ8=;
 b=V0ZHVqdfkDbmChlUcyC9gghd4gAVAx/9+EsKBD+8zqnvTnPzvYFlicSRr+OqqTb+d9gFmtB+JdiUnM/XkZHYdUZnE9PqIunDwEjwq78Bd+EGteNrcLGeMd7PUipQZulweO1vlZNl7/z9DKmEDvD0Nq8bqa98BTs2DVGkuT07H8QMXpmTtkBbmVQxmISnW7FEdNWJhdo6iH3h9/0fns+R8HdyAV+mxirufB49iY5rpNSLfjNpAlfj21lMKsrpNv+pYptFPJyZL2F0jjE8LuLOoTHPMPIp1t1u660ak45onHZRCOKhdW5Ih9eJ4fQIxQEidiExOPP7vDThe51OKuDSyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by DM5PR12MB1594.namprd12.prod.outlook.com (2603:10b6:4:e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Wed, 12 Jan 2022 13:47:49 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 13:47:49 +0000
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
Subject: [PATCH 20/20] git-p4: seperate multiple statements onto seperate lines
Date:   Wed, 12 Jan 2022 13:46:35 +0000
Message-Id: <20220112134635.177877-21-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112134635.177877-1-jholdsworth@nvidia.com>
References: <20220112134635.177877-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR04CA0137.eurprd04.prod.outlook.com (2603:10a6:207::21)
 To BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec453e51-b06e-4311-f6af-08d9d5d21ef6
X-MS-TrafficTypeDiagnostic: DM5PR12MB1594:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB15948E54E05669EC89C280ECC8529@DM5PR12MB1594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Ih6UZYUTZkN07V3ND/wUeC1O1IqC8vkpkmdv+RZl0LWpPKJMpoEqE/5F1fCTvql8WN3iKLLScDFeBadvfMvJ1rcfMwmAhvuAVhJlGkr40Ff5XcGc4W4olrSdAqmGxPnvxCTg3jQVK6Y98K4touVksNgdp47qWmxGgOCvnYL9Lg2PhbN30oDefz3ZAqBWoECdNqUpdw9UtpuN3w4yej/rNvnXAuDG3giXVESyyS225fNtlqfuPQmoM3Q/SwJbfFTmxs1GgLKQSkXd9tQuNn+6BHbaiTmtyMdRKKJBH2E1f0LNrQe6ixF3dAlM3UrvGEvX3EYwM0hQglSKVI0+gAc5OwBgFcWmeI+VpSbIPLiFK4bJhjEPeCqySve5I4dUSDK/oBy1yn3gQAVuqBFOt8pZQKMfw8lJVOV7QD3lwiClneg0/b0+chYWoTuMoaHNstIksMtQM2s6apZTXePpeyPH95gV5HTDy5euQn3ndFzLtmFmebe2DUZgkKQ95FNuCNheRibhiq7+wyVR2MU3gpLsnz3tptbh6nk27qSevpScJrN0pYcwdsXLDPQ8KfneBYiK7oqbAltxR1vZWCBNeeaIRYImpNkUB02wggNY8YBCkMIdcGPLMNSbiTEYWoHc/xUKZ3UIyTFbuma/3VZKFsjA4hOMFSNQm8JgtwUDsvagtGalnDKdDT6fg0XITnX7AN2lIKl4fRmq2P9x9z0X5d/2jsVOD53me+oKU8c26Lwt+4eyuSy+nCNbjktI3TQB9iVDggBX05iSC7Fy5bPWQoUDh61o0D4aPj/MbaPuVexhEA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(5660300002)(1076003)(26005)(38350700002)(2616005)(55236004)(186003)(54906003)(66946007)(52116002)(38100700002)(6666004)(8936002)(7416002)(83380400001)(8676002)(107886003)(66476007)(6512007)(508600001)(36756003)(316002)(86362001)(6506007)(2906002)(4326008)(110136005)(66556008)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IrtX1VAzOYjOn80lCLevczj0P3GMfn6DdXl0XWKb+vnE6P6X673WYOTJIDob?=
 =?us-ascii?Q?yAxVSNim5KnfIkKn6ryXDVrEFIcpV76ek20goRqzduIs93tIV5OrGzwgh2PC?=
 =?us-ascii?Q?y6Yx7n0RzDPx1crU1KbXv95DGFhY3kTHjkgfb/3y+hfvWHHOdI8mkNk8VmuR?=
 =?us-ascii?Q?3yfMDAUBNlk/jUXsHMcBwYNs77MmccpmsYJbEwrg4FU5OnIFmgSYdyNBVgAv?=
 =?us-ascii?Q?3vKAJuT2i8VDZR4Oc80ostI7gZZdFSZ12G0pqtA6Spor7+iGKl9kTMoTV7xA?=
 =?us-ascii?Q?fdMmcP3cOBulLUbjNPjl2Ob1Npeivh1Y+B5WuzzjsVsQzvumHe1H9Jt6/Lsn?=
 =?us-ascii?Q?GIpQqu0t40PMwAS86KXOQfMq9CcGcxT360dzlvC66vg4thCrQXNppJxoO9hj?=
 =?us-ascii?Q?Q2Pe6nehrDlmefrWSOLIxb/KSscCwYucCgo3Dr2iWn4LycGGxZDAzV2Y9Y97?=
 =?us-ascii?Q?ZlWkKJQYnkYqG9ykCHto1kbta+N/E+aSAwNxHDezQh0Vwqx0QPytTjlsZP5t?=
 =?us-ascii?Q?HESLajKdLb5Tar6UfydzQP9pbK0Z29XKkHVmjRLg2qFcKQXB2OKzw0sCV5aW?=
 =?us-ascii?Q?DqyopMpXNGDr9mXRJD9yUBSiKPcfscBh8opVnnIygzg0ejCLPH+vp7V7qguP?=
 =?us-ascii?Q?G3jyC1ezq62DtVySPepAEZB0i9VOejyxHquMAik2/MOmlzNpLekFXrdfdEJC?=
 =?us-ascii?Q?aFGfiFgco67jRlVH6ag2JLolExGxSBvtrz17m1/8RdtIUfbpJQviR6F/xf7B?=
 =?us-ascii?Q?E+U/FbPIx+BNx0QkM4v/e3uihBm5+tXUyGxAn2YBmm45AI22zwmelfyvKrkU?=
 =?us-ascii?Q?jOAjlxir/jDcHbt0hEtXNEbYMxKbioKuab5ScLTyI1k40oVvI38jkzx29P/M?=
 =?us-ascii?Q?g/qBmXKhVJBdy2ma2aEb3BWWdu/WobLd0ITTlmsd8VhGBWQE+PJtju0vLy2e?=
 =?us-ascii?Q?pK7UZI9wR8zY+EzQfpYt7ucZmxyaOZHguncTUOw9vVc1yZGxMCTUFQ1Bpu2u?=
 =?us-ascii?Q?4SRky/xxi4K45Yb65ajWpflluU1qRkbowimj4xQQAjTtsBMuNyHPIVlpveN2?=
 =?us-ascii?Q?tGdjEeBafOw3gNeFIfto9DKhPvxd1EhGqjjOsm6YwMx3FsvJVzEa1YwaS59V?=
 =?us-ascii?Q?1QfTkkAU1klaB+QKSs4C+i9hvp/ru4TcXeHIvwORJUAhX0YM2S+VSGUrQ/r+?=
 =?us-ascii?Q?02fqgfoO+uNYEP00QwSuPv3KTBUBfOqMhrIaMZB/U8WiHZNZwBEgA1udepoa?=
 =?us-ascii?Q?V5DVBUERqxVdPq8EljRsiCwWfeYnVZcOQ8YO53zRXQn2ePVfe54PZopmdppd?=
 =?us-ascii?Q?NDMokxO1YTD0+LYoq4UGlYVeX2FMzaC2+Eaxtz9AD6okRsjWvEv+Z/QVV/UH?=
 =?us-ascii?Q?fZ08UpvXs0yvX6dPPMwgpIt6BvZ83wtg66WIAR2U82jI2SEiOqMvcAgxy8Dc?=
 =?us-ascii?Q?1F33TQQBLIwof5o+9x8/KaywnkzfJRAhNcWh3AUYoOcPDTqitrAV41PKAG6Y?=
 =?us-ascii?Q?fjHMyePV79tn/rH3ahXN8RaM/LfSS2MMtdYQELVMh9XUtJ9+ygdHdEHNlAOE?=
 =?us-ascii?Q?2M/pABqcL3O7PFcO5tVSWS+oCZdhtVlMmiSRd0jDiku10ReoLt8PFJn+3oPk?=
 =?us-ascii?Q?1nP03cgk2rC2k7wkKnflnLs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec453e51-b06e-4311-f6af-08d9d5d21ef6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 13:47:48.9766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZfD7vUa+rOmD5SlxcFtuN5tg5kbVuGaRmdcl/HKiZsB1v2gwDpA+QtGtoMi2dRfWZLOE9qp2y9EG7f1RTntSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1594
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 discourages the use of compound statements where there are multiple
statements on a single line in the "Other Recommendations" section:

https://www.python.org/dev/peps/pep-0008/#other-recommendations

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 679667611c..cd7ecb7aeb 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1264,7 +1264,8 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
             else:
                 block_size = max(2, block_size // 2)
 
-            if verbose: print("block size error, retrying with block size {0}".format(block_size))
+            if verbose:
+                print("block size error, retrying with block size {0}".format(block_size))
             continue
         except P4Exception as e:
             die('Error retrieving changes description ({0})'.format(e.p4ExitCode))
@@ -1891,7 +1892,9 @@ def modifyChangelistUser(self, changelist, newUser):
                 (changelist, newUser))
 
         c = changes[0]
-        if c['User'] == newUser: return   # nothing to do
+        if c['User'] == newUser:
+            # Nothing to do
+            return
         c['User'] = newUser
         # p4 does not understand format version 3 and above
         input = marshal.dumps(c, 2)
-- 
2.34.1

