Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AF2C433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 21:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244389AbiAFVm0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 16:42:26 -0500
Received: from mail-dm6nam12on2046.outbound.protection.outlook.com ([40.107.243.46]:15200
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244385AbiAFVmN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 16:42:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuAG+prTLH23JLHbY6xvzqsL/ynRAl3pI6KgMC5kr1G8LZHTfCY3DtzCOunMGISeJlE2e+YcJiinjyNp7sh7qamk6vSjdve6LT49+sXFZsnaYDpBjKJbVdgwiiCItVc/9pdVY1XNokWvlZ6dXgHwFLMS63Vw3oV5upUIEiuYlx523l5MQ0bLdlLzG2hSHgztni2lsWBo3P8CXvEWvTg+MjvVYoB0nbO6nLgCzmFTBS4mC+OGsD0TMiC5azB/MQ3CVTPWARVxHUnpESkr5QSejCIw3lWeC//QBEEBIWH6FDiCjp9gl4Il9PMyDScbxeyNQt2c6MoHRjUl3FjnhE/aww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PWXwmNLpWQrVPPq6hZVoXWTPhTKmKnX6c6UzDynPYE=;
 b=dZMR70V8vn15h5oQU+BlwbIM9jz6ntjcic1Sck0AuJp3GR96JGnEbhcpdLslNNnwL2jNKmkjmFa84WoNRU330mOhmRSx+SsvCgC4HdGY6jlm6PJMxLKJ3QFsvZ3Bt6A/rm7eP/mrt+1dWAon2X9S4J10a6MOgX6kQ9SY9iSVSc1qTI/5KGTXPZStb17bSj0qH2fJf/9+dwP86v1nX9eWhN7e8ncjKSwLFqn0duNpU/BR0TWHYMBnb/tjTr4VA0jFoAnM4YnwhIWy8H5kTLmzn90zPBv72azsUqoboIvZXKkf7u2vrjILSvpkKceCGlKh3drjxPx7npShDKTiC4uBwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PWXwmNLpWQrVPPq6hZVoXWTPhTKmKnX6c6UzDynPYE=;
 b=GTNlhR7B77oeljXzdbNgdS4opoPxU/MisA1hFIPJ7BYpkwfwMwgk/La1fX1jo9Nm2Aw+pxRnLp/AN6dwoO0rch4ETUSsVv2cQ996ylIA+Heg8eN2Gqrv68ggYDPNYrpMOYS2fqiJ83U7t8DczWs6d8si4a45kIyJ2hBfRtEpNsXzu2bydTq7hiwrqwpeJQfr2HZ3Aex4tqJn4Z6YZlEbXFtB4a2xpytwlKhpWHghLXBprhisN9C8QRFKatwfhkOiQNKSFJkwYUYNRSYgfOHlikKx0YJEANEKJkGEF4jZI2zx185KgssorxBkl4TFpt4iHhJxejdhW4SaWz3WIRV1EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by MN2PR12MB3854.namprd12.prod.outlook.com (2603:10b6:208:16a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Thu, 6 Jan
 2022 21:42:12 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 21:42:12 +0000
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
Subject: [PATCH v2] git-p4: fixed instantiation of CalledProcessError
Date:   Thu,  6 Jan 2022 21:41:56 +0000
Message-Id: <20220106214156.90967-1-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0027.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::32) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddb58d9a-73a3-4ffe-e96c-08d9d15d6578
X-MS-TrafficTypeDiagnostic: MN2PR12MB3854:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3854D269D265D24388144F2DC84C9@MN2PR12MB3854.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:213;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NsZiOPqwRsZC7gbVvc35YDsdPAOJCLWhvWtHiRsZ0FlzKcA4nHmAff38jinLVBlHmAqq4T5UXr/iyaT61HcNb54Z3/gXDNKyXQL9wlBH5T9sNFb5IICTewO7SWFkU5nyJkUjbJBddRp5RxdcrdpgOhHWB9pIcJR6Jq7b92GEAJzc19vPPKlQLfs68626iXm1ZuTWkdQsP1lztpoi9F9NaYkPOt1iG/HbMjf7AukDbytBDuBhjt9BLfShLM5Bx1QSyLKKL1rL4SWJbBNi3hEqtd6HOz1m3DONt1Ie6YdunYV/QxueY1Xg/RCtkEkkyk4jr3RStf/vtSDaXX4hkdHjwcVa9gRboyhP4Uu6uV5EhVMl3+XF+vhwQGdQNTTHQCm4dk+Wvp+vElFT9R/jm2wMKxa3laeyeNiOVSHIB8yGNhPBVmQzxsJYzd/IC1vb7O9bcAtM/IzMEYhN7d4PRD8WdYThWPBvQuVlZJgBSfsVukFl3NZSJ/ojj9ZU4EmMpTofHhQqSwW9aYzxdDZRYy/kJgaH7vBqOWg6rWEtZ5Y3d3cE+h+iLYSzJ9x2/45/RP9QM4i7vS/C36sMV2n0WvS6MQcpTE3p7bq0z6H/f1bXqjOx+WkUfw31vfbLF6SJHRZI4gEN7R0aPOIX1W6rSwIj7fdLxaIvmoi94pIUTPK6lDKZDUf8h8kZjLCQIoZpNtxRGZ2t7+lH4TPJQ+rIbglO8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(52116002)(6486002)(107886003)(7416002)(6512007)(6666004)(54906003)(1076003)(55236004)(86362001)(5660300002)(6506007)(316002)(110136005)(186003)(4326008)(38350700002)(83380400001)(38100700002)(508600001)(66556008)(66476007)(26005)(36756003)(2616005)(66946007)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qpKa/JsQX14jVikUQqL5Gq7j2n5y9kr4V23GUbEYLXe7G0PR1jbBA5lRNAB6?=
 =?us-ascii?Q?pPq4o83MaHLZi2bODq+4eNBAgB0+MA7feSDKvhI28hNEYK3rE4hMN5g1HPTv?=
 =?us-ascii?Q?etaZM8IKU4K8oMQc1M09OmHA/AotQHGrqMjW2qUFl42FY8zJe8ZNmyughQDm?=
 =?us-ascii?Q?H6qThSCKf3ioODn7qN/YFdCb28EKfJsuYi+OwF+O3Cyxh5D+VHRt5qL+gS3D?=
 =?us-ascii?Q?Nqxm3nXf4ZCd+mvHQdfiVTdc6Fddx9gQfZV9A3ryheCKrdVTx6fK5nF2LSQO?=
 =?us-ascii?Q?3+VF60u7tAVHz68obYe9HVh1d23Oajrri7CoBkIrRE6V7WS90hSZmYtPFQcM?=
 =?us-ascii?Q?fF/AZxmqcajZrol27ub5Ct3Xv40A1nIgNqVlmAEm4c3//wzDPpD83VvCiBj9?=
 =?us-ascii?Q?N4eobEdgSs9p5qsXeA9XsJEekEJMxnwW3mt5HFcarGfx7UzDGo/42mFw7IrC?=
 =?us-ascii?Q?c+MqaVBWQlGWi4llPi/5WWRjFZcTcWPi8vsCvgsFkdCxzXTfw1CtEQdr/yAL?=
 =?us-ascii?Q?YIeA+gFaMQJk7gmI3TUbHUjt8pmp6FSHio2FuqFtJP4+ct10n2opL9OSwVs5?=
 =?us-ascii?Q?hYRcxn3fy5MikuErdGOWigrJaSNt+FTsoSXEm9C0wCWlJVjGkTrvapZURsuF?=
 =?us-ascii?Q?zw1xkThUzs7aQ2dx8M0IMmYGOThStCYoCUAmZ2X9PHdlz+gCt7y80ZdgVSDX?=
 =?us-ascii?Q?SIxYb7LWb9YG7omm8+Z5w5B0GqzQTZ+4Ge+1kq4naDLDtL8Cpa3VukQbX+6S?=
 =?us-ascii?Q?cOLHw1pH+hwxWERRTpeoWiykGGIE80nMWiY0FF/YCO11hxV5qfxmo2uZyjch?=
 =?us-ascii?Q?7KeAN30dWyBieuMhl+hDnTScmUjMp8VkVN8v7Nw4TEp7XSbOIMWLWNKeBheB?=
 =?us-ascii?Q?qQSNaCv7HBF9mB0KSs1lGk4W0vxBRXWRIcKNS6d5vBnWdepZBEMufYMw3ZSo?=
 =?us-ascii?Q?rGhFmDigXciMDDtTejUjBPJQOi2WO8vbznT4jNTl//E+HZyLtw1uuduzMzlI?=
 =?us-ascii?Q?2vaKOl8AqoEv9YUI8AIr5SMzpCkD04byc3ntuAzBlxnP3Tncxz08ZmcbLd59?=
 =?us-ascii?Q?pLPi7h2x743pVXZ9LnxWhM6J/BRQyeQlOaBK9L/lqhBxSPClqO0xWVTNSeTl?=
 =?us-ascii?Q?OCoDPbheNBkKy4CvLTmEcUYRBH8huk+FfV14TB+ncFADoXUkbaYCv4MRgVz1?=
 =?us-ascii?Q?Rn41WziFwL2vYaoTk1fnVB4KxJ/Z/YEAP+tdwnSWIZ2b1ZohfLgDkXi0geQo?=
 =?us-ascii?Q?dBz+WQZMpeTWv6XoSc/+erlgymmfvVzFKaYYo4IcfeCQFVxFkDQp5Q0qRR2h?=
 =?us-ascii?Q?9+oyg2Sk2eyNrX9dz++3HwWL/9TaIHjBnYn8kpSNS4FOMpPOsqumEpZlpafi?=
 =?us-ascii?Q?5gUE+Xyj0LLlnoic/1W+ugCTorMOKRie5E3t8k6Uk1Iac/aoKzFwsw+CnNmE?=
 =?us-ascii?Q?MgDSne5bcIVEqizf7ScaPwKjXiqhzjUgpOPU+VAnDYecWoOj60gu2VN7pqGW?=
 =?us-ascii?Q?ohfwV83UcxL7bVY/lj0D4KoVuclNstyvPaBehXo7bVTSLxRSSoOU8hm+4//D?=
 =?us-ascii?Q?tIMqKUG/qPpZDFo54RQfabYObeloz3m7wnziiPmYk6K86YZ0HEoJKMMuyPL/?=
 =?us-ascii?Q?pzEUQFRNQ+7C4qT7OrF1qXM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb58d9a-73a3-4ffe-e96c-08d9d15d6578
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 21:42:12.0471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+1eKfJsnJkLnQxGPVCoKiSDo942X7Lra8oWqA7pJnZS21wNKPphMXlwyGlW2epVA3LwAAhsrkl9m+emNaP3Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3854
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

CalledProcessError is an exception class from the subprocess namespace.
When raising this exception, git-p4 would instantiate CalledProcessError
objects without properly referencing the subprocess namespace causing
the script to fail.

This patch resolves the issue by replacing CalledProcessError with
subprocess.CalledProcessError.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
This version adds a previously missing sign-off.

 git-p4.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 986595bef0..eefac27803 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -394,7 +394,7 @@ def system(cmd, ignore_error=False):
         sys.stderr.write("executing %s\n" % str(cmd))
     retcode = subprocess.call(cmd, shell=expand)
     if retcode and not ignore_error:
-        raise CalledProcessError(retcode, cmd)
+        raise subprocess.CalledProcessError(retcode, cmd)
 
     return retcode
 
@@ -404,7 +404,7 @@ def p4_system(cmd):
     expand = not isinstance(real_cmd, list)
     retcode = subprocess.call(real_cmd, shell=expand)
     if retcode:
-        raise CalledProcessError(retcode, real_cmd)
+        raise subprocess.CalledProcessError(retcode, real_cmd)
 
 def die_bad_access(s):
     die("failure accessing depot: {0}".format(s.rstrip()))
@@ -4169,7 +4169,7 @@ def run(self, args):
             init_cmd.append("--bare")
         retcode = subprocess.call(init_cmd)
         if retcode:
-            raise CalledProcessError(retcode, init_cmd)
+            raise subprocess.CalledProcessError(retcode, init_cmd)
 
         if not P4Sync.run(self, depotPaths):
             return False
-- 
2.34.1

